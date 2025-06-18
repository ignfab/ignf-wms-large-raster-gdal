# Download large images from IGNF WMS

When in need of downloading large images from [IGNF RASTER WMS](https://data.geopf.fr/wms-r?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities) (which is currently limited to 5010 x 5010 pixel images) two options are available:
* Download the images and merge them locally
* Let GDAL do all the work

For the sake of lazyness, this repo contains a simple example using the second option.

## Build

Get the repository locally

```bash 
git clone git@github.com:ignfab/ignf-wms-large-raster-gdal.git
```

Build the docker image

```bash
DOCKER_BUILDKIT=1 docker build . -t gdal_raster_dl
```

## Run

Let's extract a 10 000 x 10 000 pixels DTM extract from IGNF WMS. See the Dockerfile in this repo and [GDAL documentation](https://gdal.org/en/stable/drivers/raster/wms.html) for more information about the environment variables.

```bash
mkdir output # create output directory with current user
docker run --rm \
    -v "$(pwd)/output:/output" \
    -e XMIN=720000 \
    -e YMIN=6690000 \
    -e XMAX=730000 \
    -e YMAX=6700000 \
    -e CRS="EPSG:2154" \
    -e WIDTH=10000 \
    -e HEIGHT=10000 \
    -e LAYER="RGEALTI-MNT_PYR-ZIP_FXX_LAMB93_WMS" \
    -e FORMAT="image/geotiff" \
    -e OUTPUT_FILE_NAME="dtm.tif" \
    -e BLOCK_SIZE=2048 \
    -e MAX_CONN=8 \
    -e TIMEOUT=3600 \
    --user $(id -u):$(id -g) \
    gdal_raster_dl
```
