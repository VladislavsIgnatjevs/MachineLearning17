close all, clear all, clc, plt=0;

load('AC50001_assignment2_data.mat');


% neural network classifier with one hidden layer to classify the
%dataset in a 5-fold cross validation setting.

%combine all data
all_data = [digit_one digit_five digit_eight] ;
all_data_label = [];


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

tic
k = 5; % k-fold XVAL
x = all_data';
t = digit_five';
[ I N ] = size(x) %[ 1 94 ]
[O N ] = size(t) % [ 1 94 ]
MSE00 = mean(var(t',1)) % 8.34 Biased Reference
MSE00a = mean(var(t',0)) % 8.43 Unbiased Reference
whos

minmaxxt = minmax( [ x ; t ] )
% minmaxxt = 0 9.9763
% 0 10
plt = plt+1, figure(plt)
plot( x, t, 'LineWidth', 2 )
title('Numbers')

% THE SMOOTH PLOT WITH 4 LOCAL EXTREMA INDICATES
% 1. Outlier modification or removal is unnecessary
% 2. At least 4 hidden nodes are necessary

rng('default') % Or substitute your lucky number
ind0 = randperm(N);
% ind0 = 1:N; % For debugging
M = floor(N/k) % 9 length(valind & tstind)
Ntrn = N-2*M % 76 length(trnind)
Ntrneq = Ntrn*O % 76 No. of training equations
H = 4 % 4 No. of hidden nodes (default is 10)
Nw = (I+1)*H+(H+1)*O % 13 No. of unknown weights
Ndof = Ntrneq-Nw % 63 No. of estimation degrees of freedom
MSEgoal = 0.01*Ndof*MSE00a/Ntrneq % 0.069859
MinGrad = MSEgoal/100 % 0.00069859

net = fitnet(H);
net.trainParam.goal = MSEgoal;
net.trainParam.min_grad = MinGrad;
net.divideFcn = 'divideind';
% net.trainParam.max_fail = 1000; % For debugging

for i = 1:k
    rngstate(i) = rng;
    net = configure(net,x,t);
    net.trainParam.goal = MSEgoal;
    net.trainParam.min_grad = MinGrad;
    % net.trainParam.max_fail = 1000; % For debugging
    
    valind = 1 + M*(i-1) : M*i;
    if i==k
        tstind = 1:M;
        trnind = [ M+1:M*(k-1) , M*k+1:N ];
    else
        tstind = valind + M;
        trnind = [ 1:valind(1)-1 , tstind(end)+1:N ];
    end
    
    trnInd = ind0(trnind); % Note upper & lower case "i"
    valInd = ind0(valind);
    tstInd = ind0(tstind);
    net.divideParam.trainInd = trnInd;
    net.divideParam.valInd = valInd;
    net.divideParam.testInd = tstInd;
    
    [ net tr y e ] = train( net, x, t );
    
    stopcrit{i,1} = tr.stop;
    bestepoch(i,1) = tr.best_epoch;
    R2trn(i,1) = 1 - tr.best_perf/MSE00;
    R2trna(i,1) = 1 - (Ntrneq/Ndof)* tr.best_perf/MSE00a;
    R2val(i,1) = 1 - tr.best_vperf/MSE00;
    R2tst(i,1) = 1 - tr.best_tperf/MSE00;
end

stopcrit = stopcrit
result = [ bestepoch R2trn R2trna R2val R2tst]
minresult = min(result)
meanresult = mean(result)
medresult = median(result)
stdresult = std(result)
maxresult = max(result)
Elapsedtime = toc %3.87 sec