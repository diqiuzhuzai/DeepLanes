Experimental data: The label of the data is the distance from the bottom of the lane line to the bottom of the picture. The image size is 360*240 and the label is 0-316.
Data source: 1) Real vehicle recording and processing by cutting, plus manual screening and marking;
                  2) Obtained by data synthesis.
Generate data tools: matlab scripts, see the script attachment for details.
Data Marking Tool: Open the image through matlab and manually judge the distance of the edge of the lane line from the nearest pixel edge of the image as a label; in which the boundary of the lane line is obviously easy to batch processing, use the create_lable.m script to batch label, see the script attachment.
Script directory and description:
├──shell
│ ├── create_datalmdb.sh % generate lmdb file
│ ├── make_mean.sh %Generate normalized binaryproto file
│ ├── train_deeplanes.sh % training mode running
│ ├── test_deeplanes.sh % test mode running
│ ├── test.py % test result analysis
│ ├── test_time.sh % test model processing time
│ ├── classes.txt %tag category
│ ├── create_lable.m % data annotation script
│ └── create_img.m % composite image
Data set: simple generation, complex generation, simple generation + manual mark, complex generation + manual mark;
Data directory structure:
├──Dataset
│ ├── data % training, verification, test data and labels
│ │ ├── train
│ │ ├── val
│ │ └── test
│ ├── prototxt % network structure prototxt file and hyperparameter Sover file
│ └──Snapshot % trained model
