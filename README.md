# spark-cluster-services
# for Mac OS

- cassandra
- cassandra-2
- postgres
- zookeeper
- kafka
- spark-master
- spark-worker1
- spark-worker2
- spark-worker3



All sparks nodes share one path "/jar" on outside Docker it's in "/tmp/docker/spark-allnodes"   
Services save their state in /tmp/docker dir. Remove it if you want to clear all data.


0. Prepare (need sseudo real ip)
```

sudo ifconfig lo0 alias 10.0.0.1 up

```


1. # Examples # 

## Run full infrastructure ##

```

docker-compose -f https://raw.githubusercontent.com/a2mz/spark-cluster/master/cluster.yml up 

```

## Zookeeper with Kafka ##

```

docker-compose -f https://raw.githubusercontent.com/a2mz/spark-cluster/master/cluster.yml up zookeeper kafka

```


## Postgres with Cassandra one node ##

```

docker-compose -f https://raw.githubusercontent.com/a2mz/spark-cluster/master/cluster.yml up postgress cassandra

```


## Postgres with Cassandra two nodes ##

```

docker-compose -f https://raw.githubusercontent.com/a2mz/spark-cluster/master/cluster.yml up postgress cassandra cassandra-2

```


## Spark Cluster with 3 workers ##

```

docker-compose -f https://raw.githubusercontent.com/a2mz/spark-cluster/master/cluster.yml up spark-master spark-worker-1 spark-worker-2 spark-worker-3

```