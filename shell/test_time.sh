TOOLS=/home/an/YANG/caffe/build/tools

$TOOLS/caffe time \
 -iterations=200 \
 -model=/home/an/An/Deeplane/lane_an/deeplanes2_jd.prototxt \
 -weights=/home/an/An/Deeplane/lane_an/data_yes_jd/snapshot2/_iter_300000.caffemodel \
 #-gpu=0 \
 #-iterations 10


#./build/tools/caffe time -model examples/mnist/lenet_train_test.prototxt -weights examples/mnist/lenet_iter_10000.caffemodel -gpu 0 -iterations 10
