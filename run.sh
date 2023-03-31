#!/bin/bash
#declare -a to_ingest=("xaa" "xab")

#declare -a to_ingest=("xac" "xae" "xag" "xai" "xak" "xam" "xao" "xaq" "xas" "xau" "xaw" "xay" "xaz")
#declare -a to_ingest=("xaa" "xab" "xac" "xad" "xae" "xaf" "xag" "xah" "xai"
# )
#declare -a to_ingest=("xaf" "xag")
declare -a to_ingest=("dtest")

for i in "${to_ingest[@]}"
do
    export INPUT_DIR=/hdd/iaross/$i\_pdfs
	export OUTPUT_DIR=/hdd/iaross/$i\_output/
    export TMP_DIR=/hdd/iaross/tmp/$i/
    mkdir -p $TMP_DIR/images
    mkdir -p $OUTPUT_DIR/images
	echo "$(date) - Starting $i ($(ls $INPUT_DIR/*.pdf | wc -l) documents found.)"
	time=0

	docker-compose -f deployment/docker-compose-ingest.yml -p cosmos down
	docker-compose -f deployment/docker-compose-ingest.yml -p cosmos up -d

	while :
	do
		check=$(docker ps | grep cosmos_runner_1)
		if [ -z "$check" ]; then
		  echo "$(date) : COSMOS runner not detected. Cleaning up and moving on."
		  for f in $(find $TMP_DIR/images/); do
			  rm -f $f
		  done
		  docker-compose -f deployment/docker-compose-ingest.yml -p cosmos down
          resize.py $OUTPUT_DIR/../
		  break
		else
		  echo "$(date) : COSMOS runner still running. Will check again in 5 minutes"
		fi
		let time=time+300
		if [ "$time" -ge "43200" ]; then # 12 hours. Is it enough? ¯\_(ツ)_/¯
			echo "$(date) : This has been running for too long. Skipping it and moving on."
			docker-compose -f deployment/docker-compose-ingest.yml -p cosmos down
			for f in $(find $TMP_DIR/images/); do
				rm -f $f
			done
			break
		else
			sleep 300
		fi
	done

done
