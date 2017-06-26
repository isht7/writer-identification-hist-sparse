function [ AccuracyS,Accuracy3,Accuracy5,acc ] = svm4line(start_folder, end_folder,W1_4index,W5_8index,alpha_tr,alpha_te,ks,bc)
numWriters = end_folder-start_folder+1;
accuracy=0;
accuracy3=0;
accuracy5=0;
acc=zeros(20,1);
b=[];
% ks=1;
% bc=10;
no_Tr_lines = sum(W1_4index);
no_Te_lines = sum(W5_8index);
tempx = 1;
for i = 1 : numWriters
    Y = -ones(no_Tr_lines,1);
    Y(tempx : tempx + W1_4index(i)-1) = 1;
     model{i} = fitcsvm(alpha_tr',Y,'KernelScale',ks,'BoxConstraint',bc);
%        model{i} = fitcsvm(alpha_tr',Y,'KernelScale',ks,'BoxConstraint',bc,'KernelFunction','rbf');
      tempx = tempx + W1_4index(i);

end

for k = 1 : no_Te_lines
a=[];
for i = 1 : numWriters
 [~,score,~] = predict(model{i},alpha_te(:,k)'); 
  a = [a;score(2)];
end
[~, idx] = max(a);
a5 = -sortrows([-a,-(1:numWriters)'],1);
writer_Nox = findWriter(k,W5_8index);
  if idx == writer_Nox
      accuracy = accuracy + 1;
  end
  if length(find(a5(1:3,2) == findWriter(k,W5_8index)))>=1
      accuracy3 = accuracy3 + 1;
  end
  if length(find(a5(1:5,2) == findWriter(k,W5_8index)))>=1
      accuracy5 = accuracy5 + 1;
  end

  for rr=1:20
if length(find(a5(1:rr,2) == findWriter(k,W5_8index)))>=1
      acc(rr) = acc(rr) + 1;
end
end
  

end
disp('complete')
AccuracyS=accuracy*100/no_Te_lines
Accuracy3=accuracy3*100/no_Te_lines
Accuracy5=accuracy5*100/no_Te_lines
acc=acc*100/no_Te_lines;

clear model
end

