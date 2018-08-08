import numpy as np
import caffe
import sys,os
import re,string

#Open the manual annotation file
rg_label=open('/home/an/An/Deeplane/lane_an/data_yes_fz/test/val.txt')	
source = rg_label.read()
rg_label.close()
#Initialize variables
V = 18000.0
E = [0] * 100
val = 0
MAE = 0.0
MAE2 = 0.0
fn = 0.0
fp1 = 0.0
t = 0.0
tp = 0.0

def get_imlist(path):  
    return [os.path.join(path,f) for f in os.listdir(path) if f.endswith('.jpg')]  
#Get a list of test pictures	
im_names = get_imlist('/home/an/An/Deeplane/lane_an/data_yes_fz/test/val/')
im_names.sort()

# Set caffe as the current working environment
caffe_root = '/home/an/YANG/caffe/' 
# Add caffe/python to the current environment 
sys.path.insert(0, caffe_root + 'python')
os.chdir(caffe_root)		#Change the working directory
# Set up the network structure
net_file='/home/an/An/Deeplane/lane_an/test/deploy.prototxt'
# Add training parameters
caffe_model='/home/an/An/Deeplane/lane_an/data_yes_fz/snapshot2/20171223/fz_iter_300000.caffemodel'

caffe.set_device(0)
caffe.set_mode_gpu()
#Save the tagged file
fp = open('/home/an/An/Deeplane/lane_an/data_yes_fz/test/test_hcfz_0111.txt', 'a')
#Tag category file
labels_filename='/home/an/An/Deeplane/lane_an/test/classes.txt'
labels = np.loadtxt(labels_filename, str, delimiter='\t')
#Constructs a Net processing picture
net = caffe.Net(net_file,caffe_model,caffe.TEST)
for im_name in im_names:
    # Get the shape of the data  
    transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
    transformer.set_transpose('data', (2,0,1))
    transformer.set_channel_swap('data', (2,1,0))
    im=caffe.io.load_image(im_name)
	# Use transformer.preprocess above to handle the image just loaded  
    net.blobs['data'].data[...] = transformer.preprocess('data',im)
	#The network began to spread forward 
    out = net.forward()
    prob = out['prob']
    path,file = os.path.split(im_name)
    ei = labels[prob.argmax()]
    fp.write(file + ' ' + ei + '\n')
	
	#Regular expression, by matching the label file to get the label and the operation
    r = re.compile(str(file)+r'\s\d+')
    ti =int(''.join(re.findall(r,source)).split()[1])
    ei = int(ei)
    k = abs(ei - ti)
    MAE += k;
    if(ti > 0 and ei > 0):
        t += 1
        MAE2 += abs(ei - ti)
    if(ti == 0 and ei == 0):
        tp += 1
    if(ei > 0 and ti== 0):
	fn += 1
    if(ei == 0 and ti> 0):
	fp1 += 1 
    if(k <= 9):
	E[k] +=  1
#Analyze the percentage of generated labels deviating from the pixel
for i in range(10):
	val += E[i]
	fp.write(str(i) + ' ' + str(("%.2f" %(100*val/V))) +'%' + '\n')

Pfn = ("%.2f" %(100*tp/(tp + fn)))
Pfp = ("%.2f" %(100*tp/(tp + fp1)))
fp.write('MAE' + ' ' + str(("%.3f" %(MAE/V))) + '\n')
fp.write('MAE2' + ' ' + str(("%.3f" %(MAE2/t))) + '\n')
fp.write('Precision' + ' ' + str(Pfp) +'%' + '\n')
fp.write('Recall' + ' ' + str(Pfn) +'%' + '\n')
#Print the result analysis details
# fp.write('MAE =' + ' ' + str(MAE) + '\n')
# fp.write('t =' + ' ' + str(t) + '\n')
# fp.write('MAE2 =' + ' ' + str(MAE2)  + '\n')
# fp.write('tp =' + ' ' + str(tp) + '\n')
# fp.write('fn =' + ' ' + str(fn) + '\n')
# fp.write('fp1 =' + ' ' + str(fp1) + '\n')	

fp.close()
