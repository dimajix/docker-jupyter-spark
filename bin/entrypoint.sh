#!/bin/bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/jupyter-init.sh


start_slave() {
   	$SPARK_HOME/sbin/start-slave.sh "spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}" --webui-port ${SPARK_WEBUI_PORT} "$@"
    check_java
}


start_master() {
    $SPARK_HOME/sbin/start-master.sh --webui-port ${SPARK_WEBUI_PORT} "$@"
    check_java
}


start_notebook() {
    mkdir -p ${JUPYTER_DIR}
    $ANACONDA_HOME/bin/jupyter notebook --ip 0.0.0.0 --port $JUPYTER_PORT --notebook-dir ${JUPYTER_DIR} --no-browser --allow-root
}


case "$1" in
    "master")
        start_master
        ;;
    "slave")
        start_slave
        ;;
    "notebook")
        start_notebook
        ;;
    *)
        exec $@
        ;;
esac
exit $?

