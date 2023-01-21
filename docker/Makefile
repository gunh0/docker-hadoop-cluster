DOCKER_NETWORK = docker_default
ENV_FILE = hadoop.env
HADOOP_VERSION = 2.0.0-hadoop3.2.1-java8

build:
	docker build -t bde2020/hadoop-base:$(HADOOP_VERSION) ./base
	docker build -t bde2020/hadoop-namenode:$(HADOOP_VERSION) ./namenode
	docker build -t bde2020/hadoop-datanode:$(HADOOP_VERSION) ./datanode
	docker build -t bde2020/hadoop-resourcemanager:$(HADOOP_VERSION) ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:$(HADOOP_VERSION) ./nodemanager
	docker build -t bde2020/hadoop-historyserver:$(HADOOP_VERSION) ./historyserver
	docker build -t bde2020/hadoop-submit:$(HADOOP_VERSION) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(HADOOP_VERSION) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(HADOOP_VERSION) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(HADOOP_VERSION) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(HADOOP_VERSION) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(HADOOP_VERSION) hdfs dfs -rm -r /input
