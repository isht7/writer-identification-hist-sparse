function strokes4 = Sstrokes(strokes,count)
%% 
strokes2 = cell(count,1);
        flag=400;
        index2=2;
        
        for k=1:count
            ax=strokes{k};
            str2(1,1)=ax(1,1);
            str2(1,2)=ax(1,2);
            str2(1,3)=ax(1,3);
            k1=1;
             while length(ax(:,1))>=2 && norm([ax(length(ax(:,1))-1,1)-ax(length(ax(:,1)),1),ax(length(ax(:,1))-1,2)-ax(length(ax(:,1)),2)],2)==0;
                    ax(length(ax(:,1)),:)=[];
                end
            while k1<=length(ax(:,1))-1
               
                if k1<=length(ax(:,1))-1
                    dist=norm([ax(k1,1)-ax(k1+1,1),ax(k1,2)-ax(k1+1,2)],2);
                else break
                end
                while dist == 0 && k1<=length(ax(:,1))-2
                    dist=norm([ax(k1,1)-ax(k1+1,1),ax(k1,2)-ax(k1+1,2)],2);
                if(dist==0)
                    ax(k1+1,:)=[];
                end
                end
                if(dist>flag)
                    ax(k1+1,:)=[];
                else
                    str2(index2,1)=ax(k1+1,1);
                    str2(index2,2)=ax(k1+1,2);
                    str2(index2,3)=ax(k1+1,3);
                    index2=index2+1;
                    k1=k1+1;
                end
            end
            clear k1;
            index2=2;
            strokes2{k} = str2;
            clear str2
        end
     
        
         clearvars -except strokes2 count i7 file_no folder x1 x a7 x2 counter ax
%% 

% Substrokes sementation based on window
        
%         N=30;
%         threshold1=10;
%         threshold2=30;
%         
%         count2=1;
%         for k=1: length(strokes2)
%             ax= strokes2{k};
%             if length(ax(:,1))<threshold1
%                 
%             elseif length(ax(:,1))<threshold2 && length(ax(:,1))>threshold1
%                 
%                 strokes3{count2}=ax;
%                 count2 = count2 + 1;
%             elseif(length(ax(:,1))>=threshold2)
%                 for i = 1: ceil(length(ax(:,1))/N)
%                     if i<  ceil(length(ax(:,1))/N)
%                         strokes3{count2}=ax(30*(i-1)+1:30*(i),:);
%                         count2=count2+1;
%                     elseif abs(30*(i-1)+1-length(ax(:,1)))>threshold1
%                         strokes3{count2}=ax(30*(i-1)+1:length(ax(:,1)),:);
%                         count2=count2+1;
%                     end
%                 end
%             end
%             
%         end
%%

% Segmenting the sub strokes by cutting at the minima
count2 = 1;        
for i = 1:length(strokes2)
   
str = strokes2{i};

if size(str,1)>=6
    
A = 0;

for j = 5:size(str,1)-5
    
    k = str(j-4:j+5,2);
    if str(j,2) == min(k) && (max(k) - str(j,2))>(max(str(:,2)) - min(str(:,2)))/6
    A = [A j];
    end
end

A = [A size(str,1)];

%sub_strokes = cell(length(A)-1,1);

if length(A)==2
    if length(str(:,1))>5
    strokes3{count2} = str(:,1:3); %time also
    count2 = count2+1;
    end
else    
    for j = 1:length(A)-1    
        k = str(A(j)+1:A(j+1),1:3);
        if length(k(:,1))>5
        strokes3{count2} = k;
        count2 = count2+1;
        end
    end
end

%else
%    sub_strokes = cell(1,1);
%    sub_strokes{count2} = str(:,1:2);
%   count2 = count2+1;
end
end
 %% Here we will do interpolation for all the substrokes to make them of uniform length       
        clear str2
        strokes4 = cell(length(strokes3),1);
        for i=1:length(strokes3)
            str2 = strokes3{i};
            str2 = str2(:,1:3);
%             if length(str2) < 32
                
%                 d = diff(str2,1);
%                 
%                 
%                 dist_from_vertex_to_vertex = hypot(d(:,1), d(:,2));
%                 
%                 cumulative_dist_along_path = [0;
%                     cumsum(dist_from_vertex_to_vertex,1)];
%                 
%                 
%                 num_points = 32;
%                 dist_steps = linspace(0, cumulative_dist_along_path(end), num_points);
%                 try
%                 points = interp1(cumulative_dist_along_path, str2, dist_steps);
%                 catch
%                     points = zeros(32,2);
%                     end
%                 strokes4{i} = points;
                
%             else
                 strokes4{i} = str2;
             
                
%             end
        end
       
        end