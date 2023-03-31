docker tag uwcosmos/cosmos-base:v0.5.0 uwcosmos/cosmos-base:latest
docker tag uwcosmos/cosmos-ingestion:v0.5.0 uwcosmos/cosmos-ingestion:latest
docker tag uwcosmos/cosmos-retrieval:v0.5.0 uwcosmos/cosmos-retrieval:latest
docker tag uwcosmos/cosmos-api:v0.5.0 uwcosmos/cosmos-api:latest

docker push uwcosmos/cosmos-base:latest
docker push uwcosmos/cosmos-ingestion:latest
docker push uwcosmos/cosmos-retrieval:latest
docker push uwcosmos/cosmos-api:latest
