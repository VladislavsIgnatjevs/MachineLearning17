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
[idx,c,x1,x2,x_grid,idx_2_region] = prepareDataForScatter3Clust(score_ones);
    
figure;
gscatter(x_grid(:,1),x_grid(:,2),idx_2_region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(score_ones(:,1),score_ones(:,2),'k*','MarkerSize',5);
title 'MNISTs Vectorised digit One';
xlabel 'dim1';
ylabel 'dim2';
legend('Cluster 1','Cluster 2','Cluster 3','Data','Location','SouthEast');
hold off;    

%--------centroids and clusters
opts = statset('Display','final');
[idx_ones, c_ones] = kmeans(score_ones,3,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

figure;
plot(score_ones(idx_ones==1,1),score_ones(idx_ones==1,2),'r.','MarkerSize',12)
hold on
plot(score_ones(idx_ones==2,1),score_ones(idx_ones==2,2),'b.','MarkerSize',12)
hold on
plot(score_ones(idx_ones==3,1),score_ones(idx_ones==3,2),'g.','MarkerSize',12)

plot(c_ones(:,1),c_ones(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids in Ones'
hold off


[idx_fives,c_fives] = kmeans(score_fives,3);
[idx_eights,c_eights] = kmeans(score_eights,3);







% mEights = mean(digit_eight);
% digit_eight = digit_eight - repmat(mEights, size(digit_eight,1),1);
% covarEights = cov(digit_eight);
% [vEights,dEights] = eigs(covarEights);
% scoreEights = digit_eight*vEights(:,1:2);
% 
% mFives = mean(digit_five);
% digit_five = digit_five - repmat(mFives, size(digit_five,1),1);
% covarFives = cov(digit_five);
% [vFives,dFives] = eigs(covarFives);
% 
% scoreFives = digit_five*vFives(:,1:2);
% 
% 
% 
% 
% 
% 
% % % use lda to do the same (q2)
% % preparing the vectors for 'virginica' against the rest, i.e., 'virginica' as class 1 % and others as class ‘0’
% lda_digit_one = orig_digit_one;
% lda_digit_five = orig_digit_five;
% lda_digit_eight = orig_digit_eight;
% 
% aOnes = zeros(size(lda_digit_one));
% aFives = zeros(size(lda_digit_five));
% aEights = zeros(size(lda_digit_eight));
% 
% for i=1:max(size(aOnes))
% aOnes(i) = isequal(species{i},'virginica');
% %% 1 means 'virginica'; and ‘0’ means others
% end
% 
% for i=1:max(size(aFives))
% aFives(i) = isequal(species{i},'virginica');
% %% 1 means 'virginica'; and ‘0’ means others
% end
% 
% for i=1:max(size(aEights))
% aEights(i) = isequal(species{i},'virginica');
% %% 1 means 'virginica'; and ‘0’ means others
% end
% 
% %label vectors
% label_vector_ones = aOnes;
% label_vector_fives = aFives;
% label_vector_eights = aEights;
% 
% %instance matrices
% instance_matrix = meas;
% 
% 
% class1 = meas(a==1,:)
% class0 = meas(a==0,:);
% % class means
% m1 = mean(class1);
% m0= mean(class0);
% % class covariance matrix
% s1 = cov(class1);
% s0 = cov(class0);
% % within class scatter matrix
% sw = s0 + s1;
% % computing the LDA projection vector
% v = inv(sw)*(m1-m0)’;
% 
% 
% 
% % computing the projection score:
% score = meas*v;
% gscatter(score(:,1), score(:,1), a, 'rg','os') %% look at only one direction will be fine.
% Or the following code to plot data after LDA projection:
% % the class 1:
% x1 = score(a==1);
% lm1 = mean(x1);
% lstd1 = std(x1);
% class1_pdf = mvnpdf(x1,lm1,lstd1);
% % the class 0
% x0 = score(a==0);
% lm0 = mean(x0);
% lstd0 = std(x0);
% class0_pdf = mvnpdf(x0, lm0, lstd0);
% figure(1); hold on; plot(x1, class1_pdf, ’r.’); plot(x0,class0_pdf,’g.’); hold off



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
