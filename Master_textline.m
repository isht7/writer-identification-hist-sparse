no_of_bins = 10;
start_folder = 2;  % do not change values, if this is changed, then many things below need to be changed.
end_folder = 217; 
start_training_document = 1;
end_training_document = 4;
start_testing_document = 5;
end_testing_document = 8;

disp('Reading Documents')
 [~ , TStrokes_processed] = DataRead(start_folder,end_folder,1,8);   % do not change 1 and 8
%load('T_Strokes_1_216_swap.mat'); % the output of the above line can be saved to save computing time
clear TStrokes;

train_writers = [1,2,3,4]; %datasample(1:8,4,'Replace',false); 
test_writers = setdiff(1:8,train_writers); 
%% line 16 to 82 is used to seperate lines in a paragraph and to count the number of sub-strokes in each line which is stored in LineInd1, LineInd2
LineData = cell(216,8);
for k = 1:216
    for k2 = 1:8
l=[];
y=[];
a=zeros(length(TStrokes_processed{k,k2}),1);
for i = 1 : length(TStrokes_processed{k,k2})
a(i) = TStrokes_processed{k,k2}{i,1}(1,1);
end
b = abs(diff(a,1));
% plot(b)
for i = 1 : length(b)
if b(i) > 2000
    l=[l;i];
end
end
for i = 1 : length(l)
    if i == 1 
y = [1,l(1)];
    else 
y = [y;l(i-1)+1,l(i)];        
    end
end
y = [y;l(i)+1,length(TStrokes_processed{k,k2})];
LineData{k,k2} = y;
    end
end


nox=0;
W5_8index = [];
for i = start_folder-1 : end_folder-1 
    nox=0;
    for j = 1 : 4 
   nox = length(LineData{i,test_writers(j)}) + nox;
    end
    W5_8index = [W5_8index ; nox];
end

nox=0;
W1_4index = [];
for i = start_folder-1 : end_folder-1 
    nox=0;
    for j = 1:4
   nox = length(LineData{i,train_writers(j)}) + nox;
    end
    W1_4index = [W1_4index ; nox];
end
%%
LineInd2=[];
for i = start_folder-1 : end_folder-1
    for j = 1:4
        for t = 1 : length(LineData{i,test_writers(j)})
LineInd2 = [LineInd2;LineData{i,test_writers(j)}(t,2)-LineData{i,test_writers(j)}(t,1)+1];
        end
    end
end

LineInd1=[];
for i = start_folder-1 : end_folder-1
    for j = 1:4
        for t = 1 : length(LineData{i,train_writers(j)})
LineInd1 = [LineInd1;LineData{i,train_writers(j)}(t,2)-LineData{i,train_writers(j)}(t,1)+1];
        end
    end
end
%%

features1=[];
for i =start_folder-1:end_folder-1
    for j=1:4
    X=feat_HOGS(TStrokes_processed{i,train_writers(j)},no_of_bins);       %HOG,train
    features1 = [features1,X];
    end
end


features11=[];
for i =start_folder-1:end_folder-1
    for j=1:4
    X=feat_HOGS(TStrokes_processed{i,test_writers(j)},no_of_bins);       %HOG,test
    features11 = [features11,X];
    end
end

K=400; % size of dictionary 

lambda=0.2;
iter = 250;
modeParam = 0;
 mode=0; % this value is not used
L = 5;
[~,alpha1,alpha2] = Dlearn_tf_idf(K,L,lambda,iter,mode,modeParam,features1(:,:),features11(:,:),LineInd1,LineInd2);

 alpha_tr=abs(alpha1); alpha_te=abs(alpha2);

 ks=1;
 bc=1;
disp('SVM');
[ AccuracyS,Accuracy3,Accuracy5,acc ] = svm4line(start_folder, end_folder,W1_4index,W5_8index,alpha_tr,alpha_te,ks,bc);


