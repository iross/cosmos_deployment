# Running
This is a simplified (but still a bit hacky) interface for running COSMOS that I whipped up. After updating `run.sh` to point at the directories you want to process, you can just run:

``` bash
./run.sh
```

from the command line. When invoked, it will look at the input directory, start up the COSMOS deployment, and then watch it until it notices that it's finished up (checking every ~5 minutes).

The key files are:

## .env
Defines what images to use and how many workers are registered in the dask cluster. I don't think you'll need to change anything here.

## run.sh
A shell script that drives the entire process. It has some fairly hard-coded paths at the moment, but the idea is that pdfs live in `/hdd/iaross/(some name)_pdfs`, and I want the output stored in `/hdd/iaross/(some name)_output`, with temporary (page-level PNG) files stored in `/hdd/iaross/tmp/(some name)`. 

### Needed changes
within `run.sh`, you'll need to change the `to_ingest`, and INPUT_DIR, OUTPUT_DIR, and TMP_DIR. You can always use CTRL-C to break out of a running instance if things seem stuck. You should also comment out the for loop that deletes the TMP_DIR images if you want/need to keep them around.




