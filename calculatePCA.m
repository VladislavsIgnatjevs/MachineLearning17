function [mean_desc,covar_desc,eigan_val_desc,eigan_vect_desc,score_desc] = calculatePCA(image_classifier)
    %initially we have 100 dimensions (100 samples)
%calculate mean of the data matrix
m = mean(image_classifier);
%substract the mean for individual dimenstions
image_classifier = image_classifier - repmat(m, size(image_classifier,1),1);
%lets calculate covariance matrix to see how much
%vary from the mean in respect to each other
covar = cov(image_classifier);
%now calculate the eigen values and vectors
[v,d] = eigs(covar);
%multiply our matrix by specific eigen vector's value
score = image_classifier*v(:,1:2);

mean_desc = m;
covar_desc = covar;
eigan_val_desc = v;
eigan_vect_desc = d;
score_desc = score;
end
