function [Dict,alpha1,alpha2] = Dlearn(K,L,lambda,iter,mode,modeParam,features1,features2,ind1,ind2)
% function [Dict,alpha1,alpha2] = Dlearn(K,L,lambda,iter,mode,modeParam,features1,features2,ind1,ind2)


start_spams
param.K = K;
param.lambda = lambda;
param.iter = iter;
param.modeParam = modeParam;
param.L = L;
%param.mode=mode;

%% Dictionary Learning
Dict = mexTrainDL(features1,param);

%% Sparse representation of training Data
param.L = L;

% alpha = mexOMP(features1,Dict,param);
 alpha = mexLasso(features1,Dict,param);

S = alpha + 0;
dum = sum(S);  %or sum(S,1);
a = dum==0;
dum(a)=1;
norm = S./(dum'*ones(1,size(S,1)))';

idf = log((1 + size(features1,2))./(1 + sum(norm,2)));

j = 1;
tf1 = zeros(param.K,length(ind1));
alpha1 = zeros(param.K,length(ind1));
for i = 1:length(ind1)
    tf1(:,i) = sum(abs(S(:,j : j + ind1(i)-1)),2);
%         tf1(:,i) = tf1(:,i)/ind1(i);
    tf1(:,i) = tf1(:,i)/sum(tf1(:,i));
    alpha1(:,i) = tf1(:,i).*idf;
    j = j + ind1(i);
end

%% Sparse representation of testing data
% alpha = mexOMP(features2,Dict,param);
 alpha = mexLasso(features2,Dict,param);
S = alpha + 0;

j = 1;
tf2 = zeros(param.K,length(ind2));
alpha2 = zeros(param.K,length(ind2));
for i = 1:length(ind2)
    tf2(:,i) = sum(abs(S(:,j : j + ind2(i)-1)),2);
%     tf2(:,i) = tf2(:,i)/ind2(i);
tf2(:,i) = tf2(:,i)/sum(tf2(:,i));
    alpha2(:,i) = tf2(:,i).*idf;
    j = j + ind2(i);
end

end