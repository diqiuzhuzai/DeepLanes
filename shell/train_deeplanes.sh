#!/usr/bin/env sh
set -e

/home/an/YANG/caffe/build/tools/caffe train \
	--solver=/home/an/An/Deeplane/lane_an/solver.prototxt \
        --gpu=1 2>&1 | tee train2.log
       # --snapshot=/home/an/An/Deeplane/lane_an/snapshot/_iter_150000.solverstate  \
        
