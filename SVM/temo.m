load fisheriris; %% and scale using the above scaling code 

for i=1:max(size(meas,2))
t = meas(:,i);
t = (t-min(t(:)))./(max(t(:))-min(t(:)));
meas(:,i) = t;
end 

whos;
% preparing the vectors for 'virginica' against the rest
a = zeros(size(species));
for i=1:max(size(a))
a(i) = isequal(species{i},'virginica');
%% in the vector a, 1 means 'virginica'; and ‘0’ means others
end
cvo = cvpartition(a,'k',2);
%% split the data into two fold. (one fold for training and the rest for
%testing
trIdx = cvo.training(1); %% get the index of training samples
teIdx = cvo.test(1); %% get the index of the test samples
training_label_vector = a(trIdx); %% creating the training label ground
%truth
training_instance_matrix = meas(trIdx,:); %% creating the training data
%matrix
test_label_vector = a(teIdx); %% creating the testing label ground
%truth
test_instance_matrix = meas(teIdx,:); %% creating the test data
%2. Now training SVM using a linear kernel
model = svmtrain(training_label_vector, training_instance_matrix);
%3. Now doing classification on the test data:
[predict_label, accuracy, dec_values] = svmpredict(test_label_vector,test_instance_matrix, model);

%You are getting there … , what is your classification accuracy? 