#!/bin/bash
set -euo pipefail
# Update values in GDAL_WMS configuration
envsubst < /app/wms_conf.xml > /tmp/wms_conf.xml
# Download using gdalwarp in mutlithreaded mode
gdalwarp -multi --config NUM_THREADS ALL_CPUS /tmp/wms_conf.xml "/output/$OUTPUT_FILE_NAME"
