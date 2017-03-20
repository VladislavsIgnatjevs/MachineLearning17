%load data
load('AC50001_assignment2_data.mat');

% using LDA to reduce the dimensions to 2 for each image descriptor
%combine all data
all_data = [digit_one digit_five digit_eight]' ;
all_data_label = [];

meanAll = mean(all_data);
all_data = all_data - repmat(meanAll, size(all_data,1),1);

%get labels
for k=1:size(all_data,1)
    if k<= 100
        all_data_label = [all_data_label;'1'];
    end
    if k >100 && k <= 200
        
        all_data_label = [all_data_label;'5'];
    end
    if k > 200
        all_data_label = [all_data_label;'8'];
    end
end



classOnes = all_data(all_data_label=='1',:);
classFives = all_data(all_data_label=='5',:);
classEights = all_data(all_data_label=='8',:);

%means
muOnes = mean(classOnes,1);
muFives = mean(classFives,1);
muEights = mean(classEights,1);

%class covariance matrices (from transposed class matrices)
covarOnes = cov(classOnes);
covarFives = cov(classFives);
covarEights = cov(classEights);

%within class scatter mask
sw = covarOnes + covarFives + covarEights;

%mean of the class means
meanClassMeans = (muOnes + muFives + muEights)./3;

%each of classes has 100 samples, no need to
%recalculate using size(class,2)

%between class scatter matrix
sbOnes = 100 .* (muOnes-meanClassMeans)'*(muOnes-meanClassMeans);
sbFives = 100 .* (muFives-meanClassMeans)'*(muFives-meanClassMeans);
sbEights = 100 .* (muEights-meanClassMeans)'*(muEights-meanClassMeans);

sb = sbOnes+ sbFives+sbEights;

%LDA projection vector

%addding small number to avoid inv on zero
dc=0.00001*eye(size(sw));

sw_new=sw+dc;

inverted_SW=inv(sw_new)*sb;
    
% computing the projection vectors:
[v1,d] = eig(inverted_SW);

score = (all_data*v1(:,1:2));

%Or the following code to plot data after LDA projection:
% the class ones:
figure


scatter(score(1:100,1), score(1:100,2), 'r', 'x'); %% look at only one direction will be fine
hold on;
scatter(score(101:200,1), score(101:200,2),'b', '*');
hold on;
scatter(score(201:300,1), score(201:300,2), 'g', 'o');
title 'LDA';
legend('Ones','Fives','Eights','Data','Location','NorthEast');  
hold off;







