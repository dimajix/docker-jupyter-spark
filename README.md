# Jupyter Spark Docker Container

This Docker image contains a Jupyter notebook with a PySpark kernel. Per default, the kernel runs in Spark 'local'
mode, which does not require any cluster. But the Docker image also supports setting up a Spark standalone cluster
which can be accessed from the Notebook.

The easiest way to run the Jupyter notebook is to run:

    docker run -p 8888:8888 dimajix/jupyter-spark
    
Then when the container is running, point your webbrowser to `http://localhost:8888`, where the Jupyter notebook 
server is running
    
You can also specify your AWS credentials for accessing data inside S3 via environment variables
    
    docker run \
        -p 8888:8888 \
        -e AWS_ACCESS_KEY_ID=your_aws_key \
        -e AWS_SECRET_ACCESS_KEY=your_aws_secret \
        dimajix/jupyter-spark
    

# Configuration

There are some configuration options which can be changed by setting environment variables for your Docker container.
Details to all the options are listed below.

## Jupyter Configuration

There are only two Jupyter specific configuration properties:

    JUPYTER_PORT=8888
    JUPYTER_DIR=/mnt/notebooks

## Spark Kernel Configuration

The Jupyter Notebook contains a special PySpark kernel, which also has some configuration options related to Spark
itself. Unfortunately you cannot change these settings on a per-notebook basis, but at least you can change these
settings per Docker container.

    SPARK_MASTER=local[*]
    SPARK_DRIVER_MEMORY=2G
    SPARK_EXECUTOR_MEMORY=4G
    SPARK_EXECUTOR_CORES=4
    SPARK_NUM_EXECUTORS=1


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


# Spark Cluster Configuration

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

## Running a Spark Standalone Cluster

The container already contains all components for running a Spark standalone cluster. This can be achieved by using the
two commands
* master
* slave

The docker-compose file contains an example of a complete Spark standalone cluster with a Jupyter Notebook as the
frontend.
