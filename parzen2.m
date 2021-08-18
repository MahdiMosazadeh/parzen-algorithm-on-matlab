clear;clc;
tic
a = [-7.266 -3.939 -2.73 -1.317 -2.059 -8.89 -3.578 -3.41 0.288];

load('brCan_data-1.mat');
brCan_data = brCan_data';       % Transport(change row and column)

brCan_data(1,:)=[];             % Delete first row becaus ID number is a cheap data

class(1,:) = brCan_data(10,:);  %cut class on brCan_data and Delete class row  
brCan_data(10,:)=[];

[class index]= sort(class);     % sort class and brCan_data
brCan_data=brCan_data(:,[index]);

clear index;

for j = 1:458                   % replace zero numbers ?? ???? average
    for i = 1:9
        if brCan_data(i,j)==0
            brCan_data(i,j)=mean(brCan_data(i,1:458));
        end
    end
end

for j = 459:699                   % replace zero numbers ?? ???? average
    for i = 1:9
        if brCan_data(i,j)==0
            brCan_data(i,j)=mean(brCan_data(i,459:699));
        end
    end
end

class(class==2)=1;              % reaplace 2 -> 1 && 4 ->4
class(class==4)=2;

for ii = 1:9
    brCan_data(ii,:) = brCan_data(ii,:) * a(ii);
end

Data(1,:) = class;             % Mix class and brCan_data in Data 
Data(2:10,:)= brCan_data;

dataTrain = Data(:,[1:120 459:578]);    % make test and train data in dataTrain and  dataTest
dataTest  = Data(:,[121:458 579:699]);

p = 0;
for i = 1:459
test = dataTest (2:10,i);        
for j = 1:240
    train = dataTrain(2:10,j);
    s=0;
        for k = 1:9
            s = s + ((test(k)-train(k))^2);
        end
    d(j) = sqrt(s);
    c(j) = dataTrain(1,j);
end

[d index] = sort(d);
c = c([index]);
c(14:end)=[];

n1 = numel(c(c==1));
n2 = numel(c(c==2));

if n1>n2
        yc = 1;
    else
        yc = 2;
end
if yc == dataTest(1,i)
    p = p+1;
end
end
toc
CCR = (p/459)*100
    