function PCAKmeansFiguresOnes(PCA_score)

[idx,c,x1,x2,x_grid,idx_2_region] = prepareDataForScatter3Clust(PCA_score);
    
figure;
gscatter(x_grid(:,1),x_grid(:,2),idx_2_region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(PCA_score(:,1),PCA_score(:,2),'k*','MarkerSize',5);
title 'MNISTs Vectorised digit Eight';
xlabel 'dim1';
ylabel 'dim2';
legend('Cluster 1','Cluster 2','Cluster 3','Data','Location','SouthEast');
hold off;    



opts = statset('Display','final');
[idx, c] = kmeans(PCA_score,3,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

%figure 2
figure;
plot(PCA_score(idx==1,1),PCA_score(idx==1,2),'r.','MarkerSize',12)
hold on
plot(PCA_score(idx==2,1),PCA_score(idx==2,2),'b.','MarkerSize',12)
hold on
plot(PCA_score(idx==3,1),PCA_score(idx==3,2),'g.','MarkerSize',12)

plot(c(:,1),c(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids in Eights'
hold off

end
