
# https://github.com/turbot/steampipe
docker run \
  -it \
  --rm \
  --name steampipe \
  --mount type=bind,source=$(pwd)/config,target=/home/steampipe/.steampipe/config  \
  --mount type=bind,source=$(pwd)/logs,target=/home/steampipe/.steampipe/logs   \
  --mount type=volume,source=steampipe_data,target=/home/steampipe/.steampipe/db/14.2.0/data \
  --mount type=volume,source=steampipe_internal,target=/home/steampipe/.steampipe/internal \
  --mount type=volume,source=steampipe_plugins,target=/home/steampipe/.steampipe/plugins   \
  --entrypoint /bin/bash \
  turbot/steampipe