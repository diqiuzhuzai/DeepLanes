 ## Verify CNN-based Lane Position Estimation
  - Building a DeepLanes network model
  - Collect and create diverse data sets
  - Training test using Caffe platform
### Experimental data: 
  - The label of the data is the distance from the bottom to lane.
  - The image size is 360*240 and the label is 0-316.
### Data Source:
  - Real vehicle recording and processing by cutting, plus manual screening and marking;
  - Obtained by data synthesis.
### Generate Data Tools: 
  - Matlab scripts, see the script attachment for details.
### Data Marking Tool:    
  - Open the image through matlab and manually judge the distance of the edge of the lane line from the nearest pixel edge of the image as a label;
  - In which the boundary of the lane line is obviously easy to batch processing, use the create_lable.m script to batch label, see the script attachment.
### Script directory:
		
	├──shell
	│ 	├── create_datalmdb.sh 		% Generate lmdb file
	│ 	├── make_mean.sh 		% Generate normalized binaryproto file
	│ 	├── train_deeplanes.sh		% Training mode running
	│	├── test_deeplanes.sh 		% Test mode running
	│ 	├── test.py 			% Test result analysis
	│ 	├── test_time.sh 		% Test model processing time
	│ 	├── classes.txt 		% Tag category
	│ 	├── create_lable.m 		% Data annotation script
	│ 	└── create_img.m 		% Composite image
### Data : 
  - Simple Generation；
  - Complex Generation；
  - Simple Generation And Manual Mark；
  - Complex Generation And Manual Mark；
### Data Directory Structure:
	├──Dataset
	│ 	├── data 		% Training, verification, test data and labels
	│ 	│ 	├── train
	│ 	│ 	├── val
	│ 	│ 	└── test
	│ 	├── prototxt 		% Network structure prototxt file and hyperparameter Sover file
	│ 	└──snapshot 		% Trained model
  - A total of 80000 samples, distributed according to 3:1:1
  - Because the dataset file is not uploaded yet, only the data file storage structure is displayed.
#### References :
  - A. Gurghian, T. Koduri, S. V. Bailur, K. J. Carey, and V. N. Murali. Deeplanes: End-to-end lane position estimation using deep neural networks.In IEEE Conference on Computer Vision and Pattern Recognition Workshops, 2016.
