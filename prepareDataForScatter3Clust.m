function [idx,c,x1,x2,x_grid,idx_2_region] = prepareDataForScatter3Clust(pca_score)

%do k-means for 3 clusters on data
[idx, c] = kmeans(pca_score,3);

%for cluster 1
x1 = min(pca_score(:,1)):0.01:max(pca_score(:,1));
%for cluster 2
x2 = min(pca_score(:,2)):0.01:max(pca_score(:,2));
%for cluster 3
%x3 = min(pca_score(:,3)):0.01:max(pca_score(:,3));

%calculate mesh grid
[x1G,x2G] = meshgrid(x1,x2);
x_grid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

% Assigns each node in the grid to the closest centroid
idx_2_region = kmeans(x_grid,3,'MaxIter',1,'Start',c);

end
