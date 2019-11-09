#!/bin/bash

source config.sh

CONTAINER_NAME = "spark-request-consumer"

docker pull metabrainz/listenbrainz-spark:latest

zip -r listenbrainz_spark.zip listenbrainz_spark/
docker run \
    -v `pwd`:/rec \
    --network spark-network \
    --name $CONTAINER_NAME \
    --packages org.apache.spark:spark-avro_2.11:2.4.1 \
    --master $SPARK_URI \
    --conf "spark.scheduler.listenerbus.eventqueue.capacity"=$LISTENERBUS_CAPACITY \
    --conf "spark.cores.max"=$MAX_CORES \
    --conf "spark.executor.cores"=$EXECUTOR_CORES \
    --conf "spark.executor.memory"=$EXECUTOR_MEMORY \
    --conf "spark.driver.memory"=$DRIVER_MEMORY \
    --py-files listenbrainz_spark.zip \
    metabrainz/listenbrainz-spark:latest \
    /usr/local/spark/bin/spark-submit listenbrainz_spark/request_consumer/main.py
