TOOLS=/home/an/YANG/caffe/build/tools

$TOOLS/caffe test \
 -iterations=2000 \
 -model=/home/an/An/Deeplane/lane_an/deeplanes.prototxt \
 -weights=/home/an/An/Deeplane/lane_an/snapshot/_iter_300000.caffemodel \
 -gpu=0        
