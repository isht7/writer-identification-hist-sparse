function [features] = feat2(strokes2)

        strokes3 = zeros(32,length(strokes2));
        strokes4 = zeros(32,length(strokes2));
        for i=1:length(strokes2)
            str2 = strokes2{i};

%             str3 = str2(1:size(str2,1)-1,1:2) - str2(2:size(str2,1),1:2);

            x = min(str2(:,1));
            y = min(str2(:,2));
            str4 = (str2(:,1)-x) + (str2(:,2) - y)*1i;
            
%%
            a = mean(str2(:,1));
            b = mean(str2(:,2));
            str5 = sqrt((str2(:,1)-a).^2 + (str2(:,2) - b).^2);
            [c,~] = wavedec(str5,5,'haar');
            c = abs(c);
            if c~=0
            c = c/max(c);
            end
%%            
%             str3 = str3(:,1) + str3(:,2)*1i;
            str4 = [str4];
            dct1 = fft(str4,32);
            dct1 = abs(dct1);
            if dct(1)~=0
            dct1 = dct1/dct1(1);
            end
            %dct1 = dct1(1:30,1);

%%          
            %strokes3(:,i) = c;
             
            strokes3(:,i) = [dct1];  
            strokes4(:,i) = c;
            if length(find(isnan(strokes3(:,i))))~=0
                strokes3(:,i)=zeros(32,1);
            end
             if length(find(isnan(strokes4(:,i))))~=0
                 strokes3(:,i)=zeros(32,1);
             end
        end
        
        features=[strokes3(2:32,:);strokes4];
end