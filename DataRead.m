
function [TStrokes,TStrokes_processed] = DataRead(start_folder,end_folder,start_document,end_document)

TStrokes = cell((end_folder - start_folder + 1),( end_document - start_document + 1 ));
TStrokes_processed = cell((end_folder - start_folder + 1),( end_document - start_document + 1 ));
ind = zeros((end_folder - start_folder + 1),( end_document - start_document + 1 ));
for i=start_folder : end_folder
    i
    x1=num2str(i);
    %folder=strcat(pwd,'\Data\',x1); %     #change#
    folder = strcat('/home/ravikiran/isht/original/',x1); % point to the folder "original" in the dataset here.
    %     #change#
    for j = start_document:end_document
        x2=num2str(j);
        file=fullfile(folder,strcat(x2,'.xml')); 
%% reading strokes from training data        
        [strokes,count] = DocRead(file);
        ind(i-start_folder + 1,j - start_document + 1) = count;
       TStrokes{i-start_folder + 1,j - start_document + 1} = strokes;
       strokes = strokesGen_Nosampling(strokes,count);
         TStrokes_processed{i-start_folder + 1,j - start_document + 1} = strokes;
         
        
%% finding substrokes and interpolating them to uniform lengths for training data         
        
    end
end

end

% 
