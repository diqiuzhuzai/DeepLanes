image_dir = 'E:\lane\GM_deeplane\data\data_l\real data\night_l\';
fid_txt ='train.txt';
files = dir(strcat(image_dir,'*.jpg'));
for k = 1:length(files)
 %k=1;
 final_y = 360;
%Load picture
 image_name = files(k).name;
 RGB1 = imread(strcat(image_dir,image_name));
 image = imrotate(RGB1,180);
 %Set the abrupt value of RGB and record the minimum value as a label
   for i=1:240
       for j = 2:1:360  
           differ_r = image(j,i,1) - image(j-1,i,1);
           differ_g = image(j,i,2) - image(j-1,i,2);
           differ_b = image(j,i,3) - image(j-1,i,3);
          
           if differ_r >9 && differ_g > 7 && differ_b > 4% && image(j,i,2) > 80 %&&image(j,i,1) > 70 && image(j,i,1) > 50   
              break;  
           end
       end
        if j < final_y
            final_y = j;
        end   
   end 
   %Delete images that do not meet the requirements
   if final_y < 22 || (final_y > 338&&final_y < 360)
       imwrite(RGB1, ['E:\lane\GM_deeplane\data\data_l\real data\no\',image_name]);
       delete(strcat(image_dir,image_name));
       continue;
   end
   if final_y == 360
       final_y = 22;
   end
  fid = fopen(strcat(image_dir,fid_txt),'a');
  fprintf(fid,'%s %d\n',image_name,final_y - 22);
  fclose(fid);
 end    