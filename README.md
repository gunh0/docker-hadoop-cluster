# Hadoop for Efficient Data Processing

🐘 Dockerized Hadoop cluster for local development and testing with HDFS and YARN

<br/>

### Hadoop Docker (docker/)

> Code extracted from the last commit of the repository "https://github.com/big-data-europe/docker-hadoop" on Jun 29, 2020.

**Quick Start**

To deploy an example HDFS cluster, run:

```bash
make up
```

Run example wordcount job:

```bash
make wordcount
```

Stop the cluster:

```bash
make down
```

View logs:

```bash
make logs
```

Clean up everything (including volumes):

```bash
make clean
```

**Available Commands**

```bash
make up          # Start Hadoop cluster
make down        # Stop Hadoop cluster
make restart     # Restart all services
make logs        # View logs from all services
make wordcount   # Run example MapReduce job
make build       # Build custom Docker images
make clean       # Remove all containers and volumes
```

Or deploy in swarm:

```bash
docker stack deploy -c docker-compose-v3.yml hadoop
```

`docker-compose` creates a docker network that can be found by running `docker network list`, e.g. `dockerhadoop_default`.

Run `docker network inspect` on the network (e.g. `dockerhadoop_default`) to find the IP the hadoop interfaces are published on. Access these interfaces with the following URLs:

-   Namenode: http://localhost:9870/dfshealth.html#tab-overview
-   History server: http://localhost:8188/applicationhistory
-   Datanode: http://localhost:9864/
-   Nodemanager: http://localhost:8042/node
-   Resource manager: http://localhost:8088/

**Configuration**

- Hadoop settings: `docker/hadoop.env`
- Docker Compose: `docker/docker-compose.yml`
- Port mappings: Modify ports in `docker/docker-compose.yml` if needed

**Troubleshooting**

If you encounter port conflicts, you can modify the ports in `docker/docker-compose.yml`.

<br/>

**Configure Environment Variables**

The configuration parameters can be specified in the `docker/hadoop.env` file or as environmental variables for specific services (e.g. namenode, datanode etc.):

```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF corresponds to core-site.xml. fs_defaultFS=hdfs://namenode:8020 will be transformed into:

```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```

To define dash inside a configuration parameter, use triple underscore, such as YARN*CONF_yarn_log\*\*\_aggregation*\*\*enable=true (yarn-site.xml):

```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

The available configurations are:

-   /etc/hadoop/core-site.xml CORE_CONF
-   /etc/hadoop/hdfs-site.xml HDFS_CONF
-   /etc/hadoop/yarn-site.xml YARN_CONF
-   /etc/hadoop/httpfs-site.xml HTTPFS_CONF
-   /etc/hadoop/kms-site.xml KMS_CONF
-   /etc/hadoop/mapred-site.xml MAPRED_CONF

If you need to extend some other configuration file, refer to base/entrypoint.sh bash script.

<br/>

<br/>

### Reference

-   [Big Data Europe](https://www.big-data-europe.eu/) : Integrating Big Data, software & communicaties for addressing Europe's societal challenges
    -   GitHub : https://github.com/big-data-europe
    -   Docker Hub : https://hub.docker.com/u/bde2020
