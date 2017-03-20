%load data
load('AC50001_assignment2_data.mat');

%for reuse
orig_digit_one = digit_one;
orig_digit_five = digit_five;
orig_digit_eight = digit_eight;

% To visualise one image , you can simply try:
% im = reshape(digit_one(:,1), [ 28, 28]); % the first image of the digit ‘1’
%  imshow(im,[]); 


% using PCA to reduce the dimensions to 2 for each image descriptor

%for descriptor of digit one
[mean_ones,covar_ones,eig_val_ones,eig_vect_ones,score_ones] = calculatePCA(digit_one);
%for descriptor of digit five
[mean_fives,covar_fives,eig_val_fives,eig_vect_fives,score_fives] = calculatePCA(digit_five);
%for descriptor of digit eight
[mean_eights,covar_eights,eig_val_eights,eig_vect_eights,score_eights] = calculatePCA(digit_eight);

%cluster those data points in the 2-D space into 3 clusters using k-means
%idx - cluster indices
%c - centroids locations
%k-means(data, number_of_clusters) 
%prepare data for scatter plot

%digit one
PCAKmeansFiguresOnes(score_ones);
%digit five
PCAKmeansFiguresFives(score_fives);
%digit eight
PCAKmeansFiguresEights(score_eights);




% to two using the first two
% principal components, and cluster those data points in 
% the 2-D space into 3 clusters using
% one of the clustering methods that we have learned in 
% lectures (hierarchical clustering, kmeans,
% GMM etc), 



%and plot a scatter plot, that shows the cluster labels. 
% Discuss whether the resulting clusters match well the actual 
% ground truth partition of classes, i.e., are
% images from the same digit are clustered into one region?



%SECOND
% 2) Use LDA instead of PCA for dimensionality reduction and repeat Question 1. Plot the
% scatter plot after applying LDA. Compare the results from Question 1, and discuss.



%THIRD

% 3) Now consider separating the images of digit ‘5’ from the rest (the images of ‘1’ and ‘8’).
% Note this is now a two-class classification problem. Use SVM with a RBF kernel, SVM
% with a linear kernel, and a neural network classifier with one hidden layer to classify the
% dataset in a 5-fold cross validation setting. Compare and discuss the results using the
% obtained validation accuracy. Create and plot the ROC curves of the results using the
% three different classifiers, and compare their performance using the area under the ROC
% curve (AUC). Pick one parameter (e.g., a penalty parameter, or a parameter from a
% kernel) from SVM, and show that how you can properly tune a parameter on this dataset. 


%----------------------------
%test with real written numbers
