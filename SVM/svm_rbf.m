%load data
load('AC50001_assignment2_data.mat');

%combine all data
all_data = [digit_one digit_five digit_eight] ;
all_data_label = [];


%scale the data in each column of all data into the range of [0, 1]
for i=1:max(size(all_data,2))
    t = all_data(:,i);
    t = (t-min(t(:)))./(max(t(:))-min(t(:)));
    all_data(:,i) = t;
end

whos;

%get labels (digit one: 1-100, digit five 101-200, digit eight 201-300)
for k=1:size(all_data,2)
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

%fives against the rest
% preparing the vectors for 'fives' against the rest
a = zeros(size(all_data_label));
for i=1:max(size(a))
    a(i) = isequal(all_data_label(i),5);
    % in the vector a, 1 means 'fives'; and ‘0’ means rest
end


cvo = cvpartition(a,'k',2);
% get the index of training samples
trIdx = cvo.training(1); 

% get the index of the test samples
teIdx = cvo.test(1); 

% creating the training label ground truth
training_label_vector = a(trIdx); 

%creating the training data 
training_instance_matrix = all_data(trIdx,:); 

% creating the testing label ground truth
test_label_vector = a(teIdx); 

% creating the test data
test_instance_matrix = all_data(teIdx,:); 

%training SVM using a linear kernel
modelDef = svmtrain(training_label_vector, training_instance_matrix, '-t 1 -g 0.07');
modelSMallerG = svmtrain(training_label_vector, training_instance_matrix, '-t 1 -g 0.01');
modelHigherG = svmtrain(training_label_vector, training_instance_matrix, '-t 1 -g 0.20');
modelEvenHigherG = svmtrain(training_label_vector, training_instance_matrix, '-t 1 -g 0.50');
modelHighestG = svmtrain(training_label_vector, training_instance_matrix, '-t 1 -g 0.91');

%classification on the test data:
%[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, model);
%default g

defaultGclassifResults = []; %0.07
smallerGclassifResults = []; %0.01
higherGclassifResults = []; %0.20
evenHigherGclassifResults = []; %0.50
highestGclassifResults = []; %0.91

%default g
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, modelDef);

[X,Y] = perfcurve(test_label_vector,dec_values,1);
figure;
plot(X,Y);
hold on;
title('ROC RBF SVM (g=0.07)')
hold off;

%smaller g
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, modelSMallerG);

[X,Y] = perfcurve(test_label_vector,dec_values,1);
figure;
plot(X,Y);
hold on;
title('ROC RBF SVM (g=0.01)')
hold off;

%higher g
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, modelHigherG);

[X,Y] = perfcurve(test_label_vector,dec_values,1);
figure;
plot(X,Y);
hold on;
title('ROC RBF SVM (g=0.20)')
hold off;
%even more higher g
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, modelEvenHigherG);

[X,Y] = perfcurve(test_label_vector,dec_values,1);
figure;
plot(X,Y);
hold on;
title('ROC RBF SVM (g=0.50)')
hold off;

%highest g
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, modelHighestG);

[X,Y] = perfcurve(test_label_vector,dec_values,1);
figure;
plot(X,Y);
hold on;
title('ROC RBF SVM (g=0.91)')
hold off;
%default G - classification accuracy lowest but remains stable over different trainings
%hightest G - classsification accuracy highest, but accurracy is not stable
%(+-2-5% every time the training is performed 



