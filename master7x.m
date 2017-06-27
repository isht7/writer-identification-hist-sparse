% clear all;
start_folder = 2;
end_folder = 217;
start_training_document = 1;
end_training_document = 4;
start_testing_document = 5;
end_testing_document = 8;
offset_val = start_folder - 1;


disp('Reading Documents')
  [~ , TStrokes_processed] = DataRead(start_folder,end_folder,1,8);   % do not change 1 and 8 even if you are modifying any of the above values.
%load('T_Strokes_1_216_swap.mat'); % the output of the above line can be saved to save computing time
train_writers = [1,2,3,4]; %datasample(1:8,4,'Replace',false); % for randomly picking up 4 writers.
test_writers = setdiff(1:8,train_writers);        
ind1 = zeros((end_folder-start_folder+1)*(end_training_document-start_training_document+1),1);
ind2 = zeros((end_folder-start_folder+1)*(end_testing_document-start_testing_document+1),1);
disp('Feature Extraction')
% ind1 contains the number of sub-strokes in consecutive paragraphs in the training set. Similarly, ind2 is for testing set. 
counter=1;
features1=[];
for i =start_folder-offset_val:end_folder-offset_val
    for j=1:4
    X=feat_HOGS_noSamx(TStrokes_processed{i,train_writers(j)},10);       %HOG,train
    features1 = [features1,X];
     ind1(counter,1) = size(TStrokes_processed{i,train_writers(j)},1);
     counter=counter+1;
    clear X;
    end
end

counter=1;
features11=[];
for i =start_folder-offset_val:end_folder-offset_val
    for j=1:4
    X=feat_HOGS_noSamx(TStrokes_processed{i,test_writers(j)},10);       %HOG,test
    features11 = [features11,X];
    ind2(counter,1) = size(TStrokes_processed{i,test_writers(j)},1);
     counter=counter+1;
    clear X;
    end
end

%% Dictionary Learning
K=200;   % size of dictionary 
lambda=0.2;
iter = 200;
modeParam = 0;
 mode=0; % this value is not used
L = 5;
[Dict1,alpha1,alpha2] = Dlearn_tf_idf(K,L,lambda,iter,mode,modeParam,features1(:,:),features11(:,:),ind1,ind2); 
alpha_tr=[alpha1]; alpha_te=[alpha2];
[AccuracyK, dist,results, results_f] = KNN(7,end_folder-start_folder+1,alpha_tr,alpha_te,end_training_document,start_training_document,end_testing_document,start_testing_document);
ks=10;
bc=1;

disp('SVM classification');
[AccuracyS,Accuracy_top3,Accuracy_top5] = svm4_top(end_folder-start_folder+1 ,end_training_document-start_training_document+1 ,end_testing_document-start_testing_document+1,abs(alpha_tr),abs(alpha_te),ks,bc);

