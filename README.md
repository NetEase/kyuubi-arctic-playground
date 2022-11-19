Playground
===

## For Users

### Setup

1. Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/);
2. Go to `docker/playground`, and use `docker compose up` to start compose services in the foreground, or use `docker compose up -d` to run compose services as daemon;

### Play
- Generate static data to MySQL
   ```
   docker exec -it mysql-datagen \
     java -jar lakehouse-benchmark.jar \
     -b tpcc,chbenchmark \
     -c config/mysql/sample_chbenchmark_config.xml \
     --create=true --load=true
   ```

- Start CDC service
  ```
  docker exec -it mysql-arctic-cdc \
    java -cp lakehouse-benchmark-ingestion-1.0-SNAPSHOT.jar \
    com.netease.arctic.benchmark.ingestion.MainRunner \
    -confDir /opt/lakehouse_benchmark_ingestion/conf \
    -sinkType arctic -sinkDatabase arctic_db
  ```

- Generate TPCC data to MySQL
  ```
  java -jar lakehouse-benchmark.jar \
    -b tpcc,chbenchmark -c config/mysql/sample_chbenchmark_config.xml \
    --execute=true -s 5
  ```

- Connect using `beeline`
  ```
  docker exec -it kyuubi /opt/kyuubi/bin/beeline -u 'jdbc:hive2://0.0.0.0:10009/'
  ```

- Connect using DBeaver
Add a Kyuubi datasource with
  - connection url `jdbc:hive2://0.0.0.0:10009/`
  - username: `anonymous`
  - password: `<empty>`

- Using built-in dataset

Kyuubi supply some built-in dataset, After the Kyuubi starts, you can run the following command to load the different datasets:

- For loading TPC-H tiny dataset to spark_catalog.tpch_tiny, run `docker exec -it kyuubi /opt/kyuubi/bin/beeline -u 'jdbc:hive2://0.0.0.0:10009/' -f /opt/load_data/load-dataset-tpch-tiny.sql`

### Access Service

- MinIO: http://localhost:9001 (minio/minio_minio)
- MySQL localhost:3306 (root/mysql)
- Arctic Meta Service (AMS) Dashboard: http://localhost:1630 (admin/admin)
- Spark UI: http://localhost:4040 (available after Spark application launching by Kyuubi, port may be 4041, 4042... if you launch more than one Spark applications)
- Flink UI: http://localhost:8081 (available after starting CDC service)

### Shutdown

1. Stop compose services by pressing `CTRL+C` if they are running on the foreground, or by `docker compose down` if they are running as daemon;
2. Remove the stopped containers `docker compose rm`;

## For Maintainers

### Build

1. Build images `docker/playground/build-image.sh`;
2. Optional to use `buildx` to build and publish cross-platform images `BUILDX=1 docker/playground/build-image.sh`;

## Federation query across data sources

```
select
    n_name,
    sum(l_extendedprice * (1 - l_discount)) as revenue
from
    tpch.tiny.customer,
    tpch.tiny.orders,
    tpch.tiny.lineitem,
    arctic.arctic_db.supplier,
    tpch.tiny.nation,
    tpch.tiny.region
where
    c_custkey = o_custkey
    and l_orderkey = o_orderkey
    and l_suppkey = su_suppkey
    and n_regionkey = r_regionkey
group by
    n_name
order by
    revenue desc
```
