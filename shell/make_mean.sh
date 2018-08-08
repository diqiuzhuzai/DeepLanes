#!/usr/bin/env sh
# Compute the mean image from the imagenet training lmdb
# N.B. this is available in data/ilsvrc12

EXAMPLE=/home/an/An/Deeplane/lane_an/data
DATA=/home/an/An/Deeplane/lane_an/data
TOOLS=/home/an/YANG/caffe/build/tools

$TOOLS/compute_image_mean $EXAMPLE/train_lmdb \
  $DATA/deeplanes_mean.binaryproto

echo "Done."
