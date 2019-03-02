%——————每辆车每段时间的数据——————
function Period_cab_dataset = get_cabperiodDataset(cab_dataset)
num_cab = size(cab_dataset,2);
Period_cab_dataset = cell(1,num_cab); % 每辆车每段时间的记录

for i = 1:num_cab
    cab_period_data = cell(1,24); % 一辆车每段时间的记录
    cab_data = cab_dataset{1,i}; %时间降序
    m = size(cab_data,1);
    for j = 1:m
        timestamp = datevec(datestr((cab_data(j,4)-8*3600)/86400 + datenum(1970,1,1))); % 得到日期和时间向量
        hour_time = timestamp(4); %得到时间的小时部分
        if hour_time == 0
            cab_period_data{1,1} = [cab_period_data{1,1};cab_data(j,:)];
        elseif hour_time == 1
            cab_period_data{1,2} = [cab_period_data{1,2};cab_data(j,:)];
        elseif hour_time == 2
            cab_period_data{1,3} = [cab_period_data{1,3};cab_data(j,:)];
        elseif hour_time == 3
            cab_period_data{1,4} = [cab_period_data{1,4};cab_data(j,:)];
        elseif hour_time == 4
            cab_period_data{1,5} = [cab_period_data{1,5};cab_data(j,:)];
        elseif hour_time == 5
            cab_period_data{1,6} = [cab_period_data{1,6};cab_data(j,:)];
        elseif hour_time == 6
            cab_period_data{1,7} = [cab_period_data{1,7};cab_data(j,:)];
        elseif hour_time == 7
            cab_period_data{1,8} = [cab_period_data{1,8};cab_data(j,:)];
        elseif hour_time == 8
            cab_period_data{1,9} = [cab_period_data{1,9};cab_data(j,:)];
        elseif hour_time == 9
            cab_period_data{1,10} = [cab_period_data{1,10};cab_data(j,:)];
        elseif hour_time == 10
            cab_period_data{1,11} = [cab_period_data{1,11};cab_data(j,:)];
        elseif hour_time == 11
            cab_period_data{1,12} = [cab_period_data{1,12};cab_data(j,:)];
        elseif hour_time == 12
            cab_period_data{1,13} = [cab_period_data{1,13};cab_data(j,:)];
        elseif hour_time == 13
            cab_period_data{1,14} = [cab_period_data{1,14};cab_data(j,:)];
        elseif hour_time == 14
            cab_period_data{1,15} = [cab_period_data{1,15};cab_data(j,:)];
        elseif hour_time == 15
            cab_period_data{1,16} = [cab_period_data{1,16};cab_data(j,:)];
        elseif hour_time == 16
            cab_period_data{1,17} = [cab_period_data{1,17};cab_data(j,:)];
        elseif hour_time == 17
            cab_period_data{1,18} = [cab_period_data{1,18};cab_data(j,:)];
        elseif hour_time == 18
            cab_period_data{1,19} = [cab_period_data{1,19};cab_data(j,:)];
        elseif hour_time == 19
            cab_period_data{1,20} = [cab_period_data{1,20};cab_data(j,:)];
        elseif hour_time == 20
            cab_period_data{1,21} = [cab_period_data{1,21};cab_data(j,:)];
        elseif hour_time == 21
            cab_period_data{1,22} = [cab_period_data{1,22};cab_data(j,:)];
        elseif hour_time == 22
            cab_period_data{1,23} = [cab_period_data{1,23};cab_data(j,:)];
        elseif hour_time == 23
            cab_period_data{1,24} = [cab_period_data{1,24};cab_data(j,:)];
        end
    end
    Period_cab_dataset{1,i} = cab_period_data;
end