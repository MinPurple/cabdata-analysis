function [Period_DriveTimeSet,Period_OccRateSet,Period_OccTimeSet,Period_Cab_DriveTimeSet,Period_Cab_OccTimeSet,Period_Cab_OccRateSet] = get_period_drivingtime_occrate(Period_cab_dataset,time_interval,occtime_interval,changetime_interval)

num_cab = size(Period_cab_dataset,2);
Period_Cab_DriveTimeSet = cell(1,num_cab); %每辆车每段时间的驾驶时间
for i = 1:num_cab
    cab_period_data = Period_cab_dataset{1,i}; %1*24 cell
    cab_period_drivetimedata = cell(1,24); % 一辆车每段时间的驾驶时间
    for j = 1:24
        cab_data = flipud(cab_period_data{1,j});%时间增序
        m = size(cab_data,1);   
        drive_time = 0;
        for k = 2:m
            time_diff = cab_data(k,4) - cab_data(k-1,4);
            if (time_diff) < time_interval
                drive_time = drive_time + time_diff;
            elseif cab_data(k,3) == 1 && cab_data(k-1,3) == 1 && time_diff <= occtime_interval
                drive_time = drive_time + time_diff;
            elseif cab_data(k,3) == 0 && cab_data(k-1,3) == 1 && time_diff <= changetime_interval
                drive_time = drive_time + time_diff;
            end
        end
        cab_period_drivetimedata{1,j} = drive_time;
    end
    Period_Cab_DriveTimeSet{1,i} = cab_period_drivetimedata;
end

Period_Cab_OccTimeSet = cell(1,num_cab); %每辆车每段时间的有客驾驶时间
for i = 1:num_cab
    cab_period_data = Period_cab_dataset{1,i}; %1*24 cell
    cab_period_occtimedata = cell(1,24); %一辆车每段时间的有客驾驶时间
    for j = 1:24
        cab_data = flipud(cab_period_data{1,j});%时间增序
        m = size(cab_data,1);
        occ_time = 0;
        for k = 2:m
            if cab_data(k,3) == 1
                if cab_data(k-1,3) == 1
                    time_diff = cab_data(k,4) - cab_data(k-1,4);
                    if (time_diff) <= occtime_interval
                        occ_time = occ_time + time_diff;
                    end
                end
            elseif cab_data(k,3) == 0
                if cab_data(k-1,3) == 1 && (cab_data(k,4)- cab_data(k-1,4)) < changetime_interval
                    occ_time = occ_time + (cab_data(k,4)-cab_data(k-1,4));
                end
            end
        end
        cab_period_occtimedata{1,j} = occ_time;
    end
    Period_Cab_OccTimeSet{1,i} = cab_period_occtimedata;
end

Period_Cab_OccRateSet = cell(1,num_cab); %每辆车每段时间的占有率
for i = 1:num_cab
    cab_period_occratedata = cell(1,24); % 一辆车每段时间的占有率
    for j = 1:24
        cab_period_occratedata{1,j} = Period_Cab_OccTimeSet{1,i}{1,j}/Period_Cab_DriveTimeSet{1,i}{1,j};
    end
    Period_Cab_OccRateSet{1,i} = cab_period_occratedata;
end

Period_DriveTimeSet = []; %每段时间的驾驶时间（所有出租车）
for i = 1:24  
    drive_time = 0;   
    for j = 1:num_cab
        cab_period_data = Period_Cab_DriveTimeSet{1,j}; %1*24 cell
        drive_time = drive_time + cab_period_data{1,i}(1);
    end
    Period_DriveTimeSet(i) = drive_time/3600;
end

Period_OccTimeSet = []; %每段时间的有客驾驶时间（所有出租车）
for i = 1:24  
    drive_time = 0;
    for j = 1:num_cab
        cab_period_data = Period_Cab_OccTimeSet{1,j}; %1*24 cell
        %temp_time = cell2mat(cab_period_data{1,i});
        drive_time = drive_time + cab_period_data{1,i}(1);
    end
    Period_OccTimeSet(i) = drive_time/3600;
end

Period_OccRateSet = []; %每段时间的占有率（所有出租车）
for i = 1:24
    Period_OccRateSet(i) = Period_OccTimeSet(i)/Period_DriveTimeSet(i);
end