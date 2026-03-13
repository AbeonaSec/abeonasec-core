#!/bin/bash

# entry.sh
# entrypoint script for morpheus container
# activates conda environment and waits for user command
# written by Aaron Krapes
# Mar 12, 2026

. /opt/conda/etc/profile.d/conda.sh
conda activate morpheus

SRC_FILE="/opt/docker/bin/entrypoint_source"
[ -f "${SRC_FILE}" ] && source "${SRC_FILE}"

THIRDPARTY_FILE="thirdparty/morpheus-container-thirdparty-oss.txt"
[ -f "${THIRDPARTY_FILE}" ] && cat "${THIRDPARTY_FILE}"

exec "$@"