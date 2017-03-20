%load data
load('AC50001_assignment2_data.mat');


% neural network classifier with one hidden layer to classify the
%dataset in a 5-fold cross validation setting.

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

all_data_label = a';



