function [bins] = feat_HOGS_noSamx(strokes2,bins_no)
% bins_no = 20;
bins = zeros(bins_no*3,length(strokes2));
bin_size = 360/bins_no;

    for i = 1 : length(strokes2)
%% Position        
        str2 = strokes2{i};        
        xc = sum(str2(:,1))/length(str2(:,1));
        yc = sum(str2(:,2))/length(str2(:,1));
        
        for j = 1 : length(str2(:,1))
            x = str2(j,1); y = str2(j,2);
            theta = atand((y-yc)/(x-xc));            
            if (y==yc && x==xc) || isnan(theta)  
                theta = 0; 
            end            
            if x > xc && y< yc
                theta = 360 + theta;
            elseif x <= xc 
                theta = 180 + theta;               
            end            
            bx = floor(theta/bin_size) + 1;
            bins(bx,i) = bins(bx,i) + sqrt((y-yc)^2 + (x-xc)^2);                 
        end
%         bins(1:bins_no,i) = bins(1:bins_no,i)/max(bins(1:bins_no,i));
if norm(bins(1:bins_no,i),2)~=0
                 bins(1:bins_no,i) = bins(1:bins_no,i)/norm(bins(1:bins_no,i),2);
end
%% Velocity       
        str3 = zeros(length(str2(:,1))-4,2);
        for j = 3:length(str2(:,1))-2
             str3(j-2,:) = (([-2 -1 0 1 2])*(str2(j-2:j+2,1:2)))/4;
        end
        for j = 1 : length(str2(:,1))-4
            x = str3(j,1); y = str3(j,2);
            theta = atand(y/x);
            if x==0 && y==0 
                theta = 0; 
            end
            if x > 0 && y< 0
                theta = 360 + theta;
            elseif x <= 0 
                theta = 180 + theta;               
            end     
            bx = floor(theta/bin_size) + 1;
            bins(bx+bins_no,i) = bins(bx+bins_no,i) + sqrt(x^2 + y^2);
        end
%         bins(bins_no+1:2*bins_no,i) = bins(bins_no+1:2*bins_no,i)/max(bins(bins_no+1:2*bins_no,i));
               if norm(bins(bins_no+1:2*bins_no,i),2)~=0 
         bins(bins_no+1:2*bins_no,i) = bins(bins_no+1:2*bins_no,i)/norm(bins(bins_no+1:2*bins_no,i),2);
 end

%% Acceleration
        str4 = zeros(length(str2(:,1))-8,2);        
        for j = 3:length(str2(:,1))-6
            str4(j-2,:) = (([-2 -1 0 1 2])*(str3(j-2:j+2,:)))/4;
        end
        for j = 1 : length(str2(:,1))-8
            x = str4(j,1); y = str4(j,2);
            theta = atand(y/x);
            if x==0 && y==0 
                theta = 0; 
            end
            if x > 0 && y< 0
                theta = 360 + theta;
            elseif x <= 0 
                theta = 180 + theta;               
            end     
            bx = floor(theta/bin_size) + 1;
            bins(bx+2*bins_no,i) = bins(bx+2*bins_no,i) + sqrt(x^2 + y^2);
        end
%         bins(2*bins_no+1:3*bins_no,i) = bins(2*bins_no+1:3*bins_no,i)/max(bins(2*bins_no+1:3*bins_no,i));
if norm(bins(2*bins_no+1:3*bins_no,i),2)~=0
                  bins(2*bins_no+1:3*bins_no,i) = bins(2*bins_no+1:3*bins_no,i)/norm(bins(2*bins_no+1:3*bins_no,i),2);
end

    end        
end