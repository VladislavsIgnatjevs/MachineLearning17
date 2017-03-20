%load data
load('AC50001_assignment2_data.mat');

% using LDA to reduce the dimensions to 2 for each image descriptor
%combine all data
all_data = [digit_one digit_five digit_eight]' ;
all_data_label = [];

meanAll = mean(all_data);

%get labels
for k=1:size(all_data,1)
    if k<= 100
        all_data_label = [all_data_label;1];
    end
    if k >100 && k <= 200
       
        all_data_label = [all_data_label;5];
    end
    if k > 200
        all_data_label = [all_data_label;8];
    end
end


classOnes = all_data(all_data_label==1,:);
classFives = all_data(all_data_label==5,:);
classEights = all_data(all_data_label==8,:);

%means
muOnes = mean(classOnes);
muFives = mean(classFives);
muEights = mean(classEights);

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
%center of all classes 
mu = [5;5];
%between class scatter matrix
sbOnes = 100 .* (muOnes-meanClassMeans)*(muOnes-meanClassMeans)';
sbFives = 100 .* (muFives-meanClassMeans)*(muFives-meanClassMeans)';
sbEights = 100 .* (muEights-meanClassMeans)*(muEights-meanClassMeans)';

sb = sbOnes+ sbFives+sbEights;

%LDA projection vector
inv_sw = inv(sw);
invSw_by_sb = inv_sw *sb;
% computing the projection vectors:
[v,d] = eig(invSW);

W1 = v(:,1);
W2 = v(:,2);

hfig = figure;
axes1 = axes('parent', hfig, 'FontWeight','bold','FontSize',12);
hold('all');

%labels
xlabel('X_1 - first feature', 'FontWeight', 'bold', 'FontSize', 12);
xlabel('Y_2 - second feature', 'FontWeight', 'bold', 'FontSize', 12);

%first class and mean
scatter(classOnes(1,:), classOnes(2,:),'r','LineWidth',2,'Parent',xaxes1);
hold on
plot(MuOnes_est(1),MuOnes_est(2),'co','MarkerSize',8,'MarkerEdgeColor','c',...
    'Color','c','LineWidth',2,'MarkerFaceColor','c','Parent',axes1);
hold on

%second class and mean
scatter(classFives(1,:), classFives(2,:),'r','LineWidth',2,'Parent',xaxes1);
hold on
plot(MuFives_est(1),MuFives_est(2),'co','MarkerSize',8,'MarkerEdgeColor','m',...
    'Color','m','LineWidth',2,'MarkerFaceColor','m','Parent',axes1);
hold on

%third class and mean
scatter(classEights(1,:), classEights(2,:),'r','LineWidth',2,'Parent',xaxes1);
hold on
plot(MuEights_est(1),MuEights_est(2),'co','MarkerSize',8,'MarkerEdgeColor','m',...
    'Color','m','LineWidth',2,'MarkerFaceColor','m','Parent',axes1);
hold on

%drawing projection vectors
%first
t = -10:25;
line_x1 = t .* W1(1);
line_y1 = t .* W1(1);
%second
t = -5:20;
line_x2 = t .* W2(1);
line_y2 = t .* W2(1);

plot(line_x1,line_y1,'k-','LineWidth',3);
grid on
plot(line_x2,line_y2,'k-','LineWidth',3);
grid on


% gscatter(score(:,1), score(:,1), all_data_label, 'rgb','os') %% look at only one direction will be fine.
% %Or the following code to plot data after LDA projection:
% % the class Ones:
% xOnes = score(all_data_label=='1');
% lmOnes = mean(xOnes);
% lstdOnes = std(xOnes);
% classOnes_pdf = mvnpdf(xOnes,lmOnes,lstdOnes);
% % the class Fives
% xFives = score(all_data_label=='5');
% lmFives = mean(xFives);
% lstdFives = std(xFives);
% classFives_pdf = mvnpdf(xFives, lmFives, lstdFives);
% % the class Eights
% xEights = score(all_data_label=='8');
% lmEights = mean(xEights);
% lstdEights = std(xEights);
% classEights_pdf = mvnpdf(xEights, lmEights, lstdEights);
% 
% 
% 
% figure(1); hold on; plot(xOnes, classOnes_pdf, 'r.'); plot(xFives,classFives_pdf,'g.'); plot(xEights,classEights_pdf,'b.');hold off
% 
% 
% %80% training data, 20% testing data
% testing_ind = [];
% for i = 1:length(all_data)
%     if rand>0.8
%         testing_ind = [testing_ind,i];
%     end
% end
% 
% training_ind = setxor(1:length(all_data), testing_ind);
% 
% %classify
% [ldaClass,err,P,logp,coeff] = classify(all_data(testing_ind,:),all_data(training_ind,:),all_data_label(training_ind,:),'linear');
% 
% %confusion_matrix
% [ldaResubCM,grpOrder] = confusionmat(char(all_data(testing_ind,:)),ldaClass);
% 
% K = coeff(1,2).const;
% L = coeff(1,2).linear;
% f = @(x,y) K + [x y]*L;
% 
% %testing
% 
% classOnes_testing = [];
% classFives_testing = [];
% classEights_testing = [];
% 
% for k=1:length(all_data)
%     if ~isempty(find(testing_ind==k))
%         if strcmp(all_data_label(k,:),'1') == 1
%             classOnes_testing = [classOnes_testing,k];
%         elseif strcmp(all_data_label(k,:),'5') == 1
%             classFives_testing = [classFives_testing,k];
%         elseif strcmp(all_data_label(k,:),'8') == 1
%             classEights_testing = [classEights_testing,k];
%         end
%     end
% end
% 
% figure
% plot (all_data(classOnes_testing));
% hold on
% plot (all_data(classFives_testing));
% hold on
% plot (all_data(classEights_testing));
% 
%             
% %overall mean
% figure
% plot(digit_one,'r.');hold on;
% plot(digit_five,'g.');hold on;
% plot(digit_eight,'b.');hold on;


