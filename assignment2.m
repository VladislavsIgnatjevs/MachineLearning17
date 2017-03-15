%load data
load('AC50001_assignment2_data.mat');

% To visualise one image , you can simply try:
%imshow(im,[]); 

%FIRST

% Use PCA to reduce the dimensions of each image descriptor to two (


% pca_didit_one = pca(digit_one);
% pca_digit_five = pca(digit_five);
% pca_digit_eight = pca(digit_eight);

[coeffFives,scoreFives] = pca(digit_five);
PcaFivesTwoDim = scoreFives(:,1:2);


[coeffOnes,scoreOnes] = pca(digit_one);
PcaOnesTwoDim = scoreOnes(:,1:2);

[coeffEights,scoreEights] = pca(digit_eight);
PcaEightsTwoDim = scoreEights(:,1:2);

[idx,C] = kmeans(PcaEightsTwoDim,3);

plot(PcaEightsTwoDim);



% 
% % use lda to do the same (q2)
% 
% figure;
% plot(pca_didit_one(:,1),pca_didit_one(:,2),'.');
% title 'Ones';
% 
% %k-means
% opts = statset('Display','final');
% [idx,C] = kmeans(pca_didit_one,3,'Distance','cityblock',...
%     'Replicates',5,'Options',opts);
% 
% 
% figure;
% plot(pca_didit_one(idx==1,1),pca_didit_one(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(pca_didit_one(idx==2,1),pca_didit_one(idx==2,2),'b.','MarkerSize',12)
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3)
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off


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

% 3) Now consider separating the images of digit �5� from the rest (the images of �1� and �8�).
% Note this is now a two-class classification problem. Use SVM with a RBF kernel, SVM
% with a linear kernel, and a neural network classifier with one hidden layer to classify the
% dataset in a 5-fold cross validation setting. Compare and discuss the results using the
% obtained validation accuracy. Create and plot the ROC curves of the results using the
% three different classifiers, and compare their performance using the area under the ROC
% curve (AUC). Pick one parameter (e.g., a penalty parameter, or a parameter from a
% kernel) from SVM, and show that how you can properly tune a parameter on this dataset. 