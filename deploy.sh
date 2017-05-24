#!/bin/bash

#runnable class
CLASS=spark.Kafka2Cassandra
JARNAME=kafkaStreams-assembly-1.0
SOURCE=~/repository/kafkaStreams/target/scala-2.11/$JARNAME


# dir from cluster.yml do not change!
MAPPEDDIR=/tmp/docker/spark-allnodes

sbt clean reload assembly


RAND=`awk -v min=1 -v max=100000 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`


cp $SOURCE.* $MAPPEDDIR/$JARNAME-$RAND.jar
docker exec -it `docker ps | grep spark-master | awk '{print $1}'` /bin/bash bin/spark-submit \
--class $CLASS \
--master spark://spark-master:7077 \
--conf spark.cassandra.connection.host=cassandra \
--supervise \
--deploy-mode cluster \
--executor-memory 1G \
--total-executor-cores 2 \
  /jar/$JARNAME-$RAND.jar
