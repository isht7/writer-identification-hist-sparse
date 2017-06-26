function [accuracyS,Accuracy_top3,Accuracy_top5] = svm4_top(numWriters,numTrainingDocs,numTestingDocs,alpha_tr,alpha_te,ks,bc)
accuracy=0;
accuracy3=0;
accuracy5=0;
for i = 1 : numWriters
    Y = -ones(numTrainingDocs*numWriters,1);
    Y(1+numTrainingDocs*(i-1) : numTrainingDocs*i) = 1;
      model{i} = fitcsvm(alpha_tr',Y,'KernelScale',ks,'BoxConstraint',bc);
%        model{i} = fitcsvm(alpha_tr',Y,'KernelScale',ks,'KernelFunction','rbf','BoxConstraint',bc);

end


for k = 1 : numWriters*numTestingDocs
a=[];
for i = 1 : numWriters
 [~,score,~] = predict(model{i},alpha_te(:,k)'); 
  a = [a;score(2)];
end
[~, idx] = max(a); 
a5 = -sortrows([-a,-(1:numWriters)'],1);
  if idx == floor(k/numTestingDocs-1/numTestingDocs+1)
      accuracy = accuracy + 1;
  end
    if length(find(a5(1:3,2) == floor(k/numTestingDocs-1/numTestingDocs+1)))>=1
      accuracy3 = accuracy3 +  1;
    end
    if length(find(a5(1:5,2) == floor(k/numTestingDocs-1/numTestingDocs+1)))>=1
      accuracy5 = accuracy5 + 1;
    end

end
accuracyS = accuracy*100/numTestingDocs/numWriters;
Accuracy_top3 = accuracy3*100/numTestingDocs/numWriters;
Accuracy_top5 = accuracy5*100/numTestingDocs/numWriters;
end