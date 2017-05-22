# Jupyter Spark Docker Container

# Configuration

There are some configuration options which can be changed by setting environment variables for your Docker container.
Details to all the options are listed below.

## Jupyter Configuration

There is only one configuration property, namely the port to listen on:

    JUPYTER_PORT=8888

## Spark Kernel Configuration

The Jupyter Notebook contains a special PySpark kernel, which also has some configuration options related to Spark
itself. Unfortunately you cannot change these settings on a per-notebook basis, but at least you can change these
settings per Docker container.

    SPARK_DRIVER_MEMORY=2G
    SPARK_EXECUTOR_MEMORY=4G
    SPARK_EXECUTOR_CORES=4
    SPARK_NUM_EXECUTORS=1

## Spark Cluster Configuration

Aside from the Jupyter kernel / driver side there are some more Spark related configuration properties, which are used
to setup and connect to the Spark cluster. Note that all worker nodes also require the same Python installation as on
the notebook server, so essentially the only deployment mode currently supported is Spark Standalone cluster using the
same Docker image for both the Spark master and all Spark worker nodes.

The following settings configure Spark master and all workers.

    SPARK_MASTER_HOST=spark-master
    SPARK_MASTER_PORT=7077

    SPARK_WEBUI_PORT=9090
    SPARK_WORKER_CORES=4
    SPARK_WORKER_MEMORY=8G
    SPARK_LOCAL_DIRS=/tmp/spark-local
    SPARK_WORKER_DIR=/tmp/spark-worker

## Hadoop Properties

It is possible to access Hadoop resources (in HDFS) from Spark. 

    HDFS_NAMENODE_HOSTNAME=hadoop-namenode
    HDFS_NAMENODE_PORT=8020
    HDFS_DEFAULT_FS=${HDFS_DEFAULT_FS=hdfs://$HDFS_NAMENODE_HOSTNAME:$HDFS_NAMENODE_PORT}
    HDFS_REPLICATION_FACTOR=2

## S3 properties

Since many users want to access data stored on AWS S3, it is also possible to specify AWS credentials and general
settings.

    S3_PROXY_HOST=
    S3_PROXY_PORT=
    S3_PROXY_USE_HTTPS=false
    S3_ENDPOINT=s3.amazonaws.com
    S3_ENDPOINT_HTTP_PORT=80
    S3_ENDPOINT_HTTPS_PORT=443

    AWS_ACCESS_KEY_ID=
    AWS_SECRET_ACCESS_KEY=
