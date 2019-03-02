function PickupPointPeriod = getPickupPointPeriod (PickupSet)
m = size(PickupSet,1);
PickupPointPeriod = cell(1,24);

for i = 1:m
    timestamp = datevec(datestr((PickupSet(i,4)-8*3600)/86400 + datenum(1970,1,1))); % 得到日期和时间向量
    hour_time = timestamp(4); %得到时间的小时部分
    if hour_time == 0
        PickupPointPeriod{1,1} = [PickupPointPeriod{1,1};PickupSet(i,:)];
    elseif hour_time == 1
        PickupPointPeriod{1,2} = [PickupPointPeriod{1,2};PickupSet(i,:)];
    elseif hour_time == 2
        PickupPointPeriod{1,3} = [PickupPointPeriod{1,3};PickupSet(i,:)];
    elseif hour_time == 3
        PickupPointPeriod{1,4} = [PickupPointPeriod{1,4};PickupSet(i,:)];
    elseif hour_time == 4
        PickupPointPeriod{1,5} = [PickupPointPeriod{1,5};PickupSet(i,:)];
    elseif hour_time == 5
        PickupPointPeriod{1,6} = [PickupPointPeriod{1,6};PickupSet(i,:)];
    elseif hour_time == 6
        PickupPointPeriod{1,7} = [PickupPointPeriod{1,7};PickupSet(i,:)];
    elseif hour_time == 7
        PickupPointPeriod{1,8} = [PickupPointPeriod{1,8};PickupSet(i,:)];
    elseif hour_time == 8
        PickupPointPeriod{1,9} = [PickupPointPeriod{1,9};PickupSet(i,:)];
    elseif hour_time == 9
        PickupPointPeriod{1,10} = [PickupPointPeriod{1,10};PickupSet(i,:)];
    elseif hour_time == 10
        PickupPointPeriod{1,11} = [PickupPointPeriod{1,11};PickupSet(i,:)];
    elseif hour_time == 11
        PickupPointPeriod{1,12} = [PickupPointPeriod{1,12};PickupSet(i,:)];
    elseif hour_time == 12
        PickupPointPeriod{1,13} = [PickupPointPeriod{1,13};PickupSet(i,:)];
    elseif hour_time == 13
        PickupPointPeriod{1,14} = [PickupPointPeriod{1,14};PickupSet(i,:)];
    elseif hour_time == 14
        PickupPointPeriod{1,15} = [PickupPointPeriod{1,15};PickupSet(i,:)];
    elseif hour_time == 15
        PickupPointPeriod{1,16} = [PickupPointPeriod{1,16};PickupSet(i,:)];
    elseif hour_time == 16
        PickupPointPeriod{1,17} = [PickupPointPeriod{1,17};PickupSet(i,:)];
    elseif hour_time == 17
        PickupPointPeriod{1,18} = [PickupPointPeriod{1,18};PickupSet(i,:)];
    elseif hour_time == 18
        PickupPointPeriod{1,19} = [PickupPointPeriod{1,19};PickupSet(i,:)];
    elseif hour_time == 19
        PickupPointPeriod{1,20} = [PickupPointPeriod{1,20};PickupSet(i,:)];
    elseif hour_time == 20
        PickupPointPeriod{1,21} = [PickupPointPeriod{1,21};PickupSet(i,:)];
    elseif hour_time == 21
        PickupPointPeriod{1,22} = [PickupPointPeriod{1,22};PickupSet(i,:)];
    elseif hour_time == 22
        PickupPointPeriod{1,23} = [PickupPointPeriod{1,23};PickupSet(i,:)];
    elseif hour_time == 23
        PickupPointPeriod{1,24} = [PickupPointPeriod{1,24};PickupSet(i,:)];
    end
end