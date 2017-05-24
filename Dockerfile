FROM ubuntu:14.04

RUN apt-get update && apt-get -y install curl

# JAVA
ENV JAVA_MAJOR_VERSION 8
ENV JAVA_UPDATE_VERSION 131
ENV JAVA_BUILD_NUMBER 11
ENV JAVA_HOME /usr/local/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
   | tar -xz -C /usr/local/ && ln -s $JAVA_HOME /usr/local/java && rm -rf $JAVA_HOME/man

# SPARK
ARG SPARK_ARCHIVE=http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
RUN curl -s $SPARK_ARCHIVE | tar -xz -C /usr/local/

ENV SPARK_HOME /usr/local/spark-2.1.0-bin-hadoop2.7
ENV PATH $PATH:$SPARK_HOME/bin

RUN   echo 'spark.deploy.recoveryMode=ZOOKEEPER' > ha.conf && \
      echo 'spark.deploy.zookeeper.url=zookeeper:2181' >> ha.conf && \
      echo 'spark.deploy.zookeeper.dir=/spark' >> ha.conf
      
COPY ha.conf $SPARK_HOME/conf

EXPOSE 4040 6066 7077 8080

WORKDIR $SPARK_HOME
