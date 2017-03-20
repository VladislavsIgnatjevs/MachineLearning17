function [score] = calculatePCAforAll(all_data)

% classOnes = all_data(all_data_label=='1',:);
% classFives = all_data(all_data_label=='5',:);
% classEights = all_data(all_data_label=='8',:);

%means
% meanOnes = mean(classOnes);
% meanFives = mean(classFives);
% meanEights = mean(classEights);
meanAll = mean(all_data);

%all

%substract the mean for individual dimenstions
all_data = all_data - repmat(meanAll, size(all_data,1),1);
%lets calculate covariance matrix to see how much
%vary from the mean in respect to each other
covar = cov(all_data);
%now calculate the eigen values and vectors
[v,d] = eigs(covar);
%multiply our matrix by specific eigen vector's value
score = all_data*v(:,1:2);


end
