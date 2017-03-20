%load data
load('AC50001_assignment2_data.mat');

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


for i=1:max(size(all_data,2))
t = all_data(:,i);
t = (t-min(t(:)))./(max(t(:))-min(t(:)));
all_data(:,i) = t;
end