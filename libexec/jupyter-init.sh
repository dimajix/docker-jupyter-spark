#!/usr/bin/env bash
set -eo pipefail

# Setup environment
source /opt/docker/libexec/spark-init.sh
source /opt/docker/libexec/jupyter-vars.sh

render_templates /opt/docker/conf/jupyter-kernels $ANACONDA_HOME/share/jupyter/kernels
