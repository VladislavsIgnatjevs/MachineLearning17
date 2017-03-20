%clear workspace
clear all;

%load data
load('AC50001_assignment2_data.mat');

%for reuse
orig_digit_one = digit_one;
orig_digit_five = digit_five;
orig_digit_eight = digit_eight;



%combine all data
all_data = [digit_one digit_five digit_eight]';



[score] = calculatePCAforAll(all_data);

%cluster those data points in the 2-D space into 3 clusters using k-means
%idx - cluster indices
%c - centroids locations
%k-means(data, number_of_clusters) 
%prepare data for scatter plot

[idx,c,x1,x2,x_grid,idx_2_region] = PCAKmeansFiguresALL(score);







