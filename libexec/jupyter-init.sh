#!/usr/bin/env bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/hadoop-init.sh
source /opt/docker/libexec/spark-vars.sh
source /opt/docker/libexec/jupyter-vars.sh

render_templates /opt/docker/conf/juypter-kernels $ANACONDA_HOME/share/jupyter/kernels
