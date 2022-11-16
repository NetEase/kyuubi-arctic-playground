Playground
===

## For Users

### Setup

1. Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/);
2. Go to `docker/playground`, and use `docker compose up` to start compose services in the foreground, or use `docker compose up -d` to run compose services as daemon;

### Play
- Generate static data to mysql
   ```
   docker exec -it mysql-datagen \
     java -jar lakehouse-benchmark.jar \
     -b tpcc,chbenchmark \
     -c config/mysql/sample_chbenchmark_config.xml \
     --create=true --load=true
   ```

- Start cdc service
  ```
  docker exec -it mysql-arctic-cdc \
    java -cp lakehouse-benchmark-ingestion-1.0-SNAPSHOT.jar \
    com.netease.arctic.benchmark.ingestion.MainRunner \
    -confDir /opt/lakehouse_benchmark_ingestion/conf \
    -sinkType arctic -sinkDatabase arctic_db
  ```

- Generate tpcc data to mysql
  ```
  java -jar lakehouse-benchmark.jar \
    -b tpcc,chbenchmark -c config/mysql/sample_chbenchmark_config.xml \
    --execute=true -s 5
  ```

- Connect using `beeline`

    `docker exec -it kyuubi /opt/kyuubi/bin/beeline -u 'jdbc:hive2://0.0.0.0:10009/'`;

- Connect using DBeaver
Add a Kyuubi datasource with
  - connection url `jdbc:hive2://0.0.0.0:10009/`
  - username: `anonymous`
  - password: `<empty>`

- Using built-in dataset

Kyuubi supply some built-in dataset, After the Kyuubi starts, you can run the following command to load the different datasets:

- For loading TPC-DS tiny dataset to spark_catalog.tpcds_tiny, run `docker exec -it kyuubi /opt/kyuubi/bin/beeline -u 'jdbc:hive2://0.0.0.0:10009/' -f /opt/load_data/load-dataset-tpcds-tiny.sql`
- For loading TPC-H tiny dataset to spark_catalog.tpch_tiny, run `docker exec -it kyuubi /opt/kyuubi/bin/beeline -u 'jdbc:hive2://0.0.0.0:10009/' -f /opt/load_data/load-dataset-tpch-tiny.sql`

### Access Service

- MinIO: http://localhost:9001
- MySQL localhost:3306 (username: root, password: mysql)
- Spark UI: http://localhost:4040 (available after Spark application launching by Kyuubi, port may be 4041, 4042... if you launch more than one Spark applications)

### Shutdown

1. Stop compose services by pressing `CTRL+C` if they are running on the foreground, or by `docker compose down` if they are running as daemon;
2. Remove the stopped containers `docker compose rm`;

## For Maintainers

### Build

1. Build images `docker/playground/build-image.sh`;
2. Optional to use `buildx` to build and publish cross-platform images `BUILDX=1 docker/playground/build-image.sh`;
