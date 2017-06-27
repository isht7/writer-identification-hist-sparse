function [AccuracyK, dist, results2,results_f] = KNN(K,numWriters,alpha1,alpha2,end_training_document,start_training_document,end_testing_document,start_testing_document)
%% Measuring distance between each test document with every training Document
dist = zeros(size(alpha1,2), size(alpha2,2));
for i = 1:size(alpha2,2)
    for j = 1:size(alpha1,2)
        dist(j,i) = norm(alpha2(:,i) - alpha1(:,j),2);
    end
end

%% Assigning class each training document based on K nearest neighbour
results2=zeros(K,size(alpha2,2));
results3=zeros(K,size(alpha2,2));
results_f=zeros(1,size(alpha2,2));
results=zeros(size(alpha1,2),size(alpha2,2));
for i = 1:size(alpha2,2)
[~,results(:,i)] = sort(dist(:,i));
end

 for k = 1:size(results2,2)
     results3(:,k)=results(1:K,k)-(end_training_document - start_training_document +1)*(k-1);
 end

     results2(:,:)=ceil(results(1:K,:)/(end_training_document - start_training_document +1));
for i = 1 : size(alpha2,2)
stats=tabulate(results2(:,i));
temp2=sortrows(stats,-2); 
% find the first element in results2(:,i) that has the frequency temp(1,2)
% frequency of jth element in results2(:,i) is stats(results2(j,i),2)
for j = 1:  size(results2(:,i),1)
if(stats(results2(j,i),2)==temp2(1,2))
    results_f(i)=results2(j,i);
    break;
end
end
%results_f(i)=temp2(1,1);
clear temp2;
end
countx=0;
for i = 1 : size(results_f,2)
%if results_f(i)==i
if results_f(i)== ceil(i/(end_testing_document - start_testing_document +1))
    countx = countx + 1;
end
end
AccuracyK = (countx*100)/(numWriters)/(end_testing_document-start_testing_document+1);
end