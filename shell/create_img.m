clear,clc

path = 'E:\lane\GM_deeplane\data\creat_data\';	%Data synthesis material path
a = 1;        							%1 for daytime, 0 for night
if a == 1
    img_black = 'day\';        			%Background image
    labe_img = 'train_day\';   			%Generate image storage address
    labe_txt = 'train_day.txt';     	%Generated label document
    labe = 'day_';
else
    img_black = 'night';        		%Background image
    labe_img = 'train_night\';  		%Generate image storage address
    labe_txt = 'train_night.txt';     	%Generated label document
    labe = 'night_';
end
fid = fopen(strcat(path,labe_txt),'w');
no_lane = dir(strcat(path,img_black));

for r = (1:30000)   %The number of images generated
     b = randi([1 9]);
     if a == 1		%1 represents daylight data generation,0 night
         switch b	%Different lane lines are synthesized with the background image
             case 1
                 width = 38;
                 img_lane = 'day_0.jpg';   %Lane line image
             case 2
                 width = 74;
                 img_lane = 'day_1.jpg';   
             case 3
                 width = 22;          
                 img_lane = 'day_2.jpg';   
             case {4,5}
                 width = 50;
                 img_lane = 'day_3.jpg'; 
             case 6
                 width = 62;
                 img_lane = 'day_4.jpg'; 
             case 7
                 width = 30;
                 img_lane = 'day_5.jpg';
              case 8
                 width = 38;
                 img_lane = 'day_6.jpg';   
              case 9
                 width = 46;
                 img_lane = 'day_7.jpg'; 
         end 
     else
        switch b	%Different lane lines are synthesized with the background image
             case 1
                 width = 22;
                 img_lane = 'night_1.jpg';  
             case {2,3}
                 width = 34;
                 img_lane = 'night_0.jpg'; 
             case {4,5}
                 width = 39;
                 img_lane = 'night_1.jpg'; 
             case 6
                 width = 73;
                 img_lane = 'night_2.jpg';      
             case {7,8,9}
                 width = 54;
                 img_lane = 'night_3.jpg'; 
        end 
     end
    lane = imread(strcat(path,img_lane)); 
    lane = imresize(lane, [width+1 240]);
    min1 = width + 1;		%Lane line width
    max1 = 360 - width;		%Maximum mark value
    
    q = randi([3 length(no_lane)-1]);
    img_no = imread(fullfile(strcat(path,img_black), no_lane(q).name));
    img_no = imresize(img_no, [360 240]);
    %Take a range to ensure that the area is all lane lines
	
	%Control the ratio of single and double lines, non-zero for a single line
    if  randi([0,9])           
        i = randi([min1 max1]);
		%Assuming that j has half the probability equal to i, 
		%the ratio of horizontal lane lines in the control image is 50per
        if randi([0,2])         
			%According to the picture Lane Lane on the left random number i 
			%limit the range of the right random number j
            if i == max1         %In order to generate the label 338-j=0
                j = max1;        
            elseif i>=min1 && i<min1+30
                j = randi([min1, i + 30]);
            elseif i>=min1+30 && i< max1-70
                j = randi([i-30, i+30]);
            elseif i>=max1-70 && i<=max1
                j = randi([i - 30, max1]);
            end
        else
            j = i;
        end
        k = (j-i)/240;
		%Control lane line all visible, partially visible proportion of
		%non-zero when all visible
        if randi([0,9])             
            for m = (1:240)          %Three channels
                for l = (1:3)
                    n = round(i + m*k);
                   for p = (0:width-1)
						%The value of the lane line is assigned to that area of the background
                        if i<= max1
                            img_no(n - p,m,l) = lane(p+1,m,l);      
                        end                                    
                    end
                end
            end
        else
			%Control before and after the invisible part of the ratio, non-0 for the back is not visible
            if randi([0,1]) 
                star = 1;
                m_r = randi([80,240]);		%The rear part is not visible
            else
                m_r = 240;
                star = randi([1,180]);		%The front part is not visible
            end
            for m = (star:m_r)			
                for l = (1:3)				%Three channels
                    n = round(i + m*k);
                for p = (0:width-1)
						%The value of the lane line is assigned to that area of the background 
                        if i<= max1 
                            img_no(n - p,m,l) = lane(p+1,m,l);
                        end                          
                    end
                end
            end
        end
    else
        min2 = min1+width+20;
        i = randi([min2 max1]);        %To prevent the second line out of the border
        i_number2 = min1;     
        %Take parallel lane lines
        if randi([0,2])                           %Slash non-zero
            if i == max1         
                j = max1;        
            elseif i>=min2 && i<min2+30
                j = randi([min2, i + 30]);
            elseif i>=min2+30 && i< max1-70
                j = randi([i-30, i+30]);
            elseif i>=max1-70 && i<=max1
                j = randi([i - 10, max1]);
            end
        else
            j = i;
        end
        k = (j-i)/240;
        if randi([0,9])         %The value is non-zero when the entire line
            for m = (1:240)		
                for l = (1:3)
                    n = round(i + m*k);                 
                    n_number2 = n - width-20;
                    for p = (0:width-1)
                        if i<= max1 
                            img_no(n - p,m,l) = lane(p+1,m,l);
                            img_no(n_number2 - p,m,l) = lane(p+1,m,l);
                        end
                    end
                end
            end
        else
			%Value is not 0 when the rear portion of the lane line is not visible
            if randi([0,1])    
                star = 1;
                m_r = randi([80,220]);
            else
                m_r = 240;
                star = randi([20,180]);
            end
            for m = (star:m_r)
                for l = (1:3)
                    n = round(i + m*k);
                    n_number2 = n - width-20;
                   for p = (0:width-1)
                        if i<= max1 
                            img_no(n - p,m,l) = lane(p+1,m,l);
                            img_no(n_number2 - p,m,l) = lane(p+1,m,l);
                        end
                    end
                end
            end
        end
    end

    name = (['00000', int2str(r+10000)]);
    imgname = name(end-4:end);
    imwrite(img_no, [strcat(path,labe_img),strcat(labe,imgname),'.jpg'])
    %Save the picture to the specified path, the picture name is '00000X' format
    fprintf(fid,'%s',[strcat(labe,imgname),'.jpg']);
    fprintf(fid,'%s',' ');
	%Generate txt tag file
    if m == 240         %When the lane line is partially visible, the tag can not be selected in i, j only
        fprintf(fid,'%s\n',num2str(338 - max(i,j)));
    else
        fprintf(fid,'%s\n',num2str(338 - max(i,j)));
    end
   
end
 fclose('all');
