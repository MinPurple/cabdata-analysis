function [M_occtime_diffset, M_changetime_diffset, M_time_diffset] = distribution_time_interval(cab_dataset)
%———————占有状态（1-1)时间间隔差分布——————
M_occtime_diffset=[];
for i = 1:size(cab_dataset,2)
    cab_data = flipud(cab_dataset{1,i}); 
    [m,~] = size(cab_data);
    occtime_diff = [];  
    time_diff = 0;
    for j = 2:m
        if cab_data(j,3) == 1 && cab_data(j-1,3) == 1
            time_diff = (cab_data(j,4) - cab_data(j-1,4))/60; % 分钟
        end
        occtime_diff = [occtime_diff;time_diff];
    end
    [m1,~] = size(occtime_diff);
    for k = 1:m1
        if occtime_diff(k) > 60
            occtime_diff (k) = 60;
        %elseif temp_occtimediffset(j) < 60 && temp_occtimediffset(j) > 60
        end
    end 
    M_occtime_diffset = [M_occtime_diffset;occtime_diff];   
end

%———————1-0状态时间间隔差分布——————
M_changetime_diffset=[];
for i = 1:size(cab_dataset,2)
    cab_data = flipud(cab_dataset{1,i}); 
    [m,~] = size(cab_data);
    changetime_diff = [];
    time_diff = 0;
    for j = 2:m
        if cab_data(j,3) == 0 && cab_data(j-1,3) == 1
            time_diff = (cab_data(j,4) - cab_data(j-1,4))/60; % 分钟
        end
        changetime_diff = [changetime_diff;time_diff];
    end
    
    [m1,~] = size(changetime_diff);
    for k = 1:m1
        if changetime_diff(k) > 60
            changetime_diff(k) = 60;
        end
    end
    M_changetime_diffset = [M_changetime_diffset;changetime_diff];
end

%———————时间间隔差分布（所有状态）——————
M_time_diffset=[];
for i = 1:size(cab_dataset,2)
    cab_data = flipud(cab_dataset{1,i}); 
    [m,~] = size(cab_data);
    temp_timediff = [];   
    time_diff = 0;
    for j = 2:m
        time_diff = (cab_data(j,4) - cab_data(j-1,4))/60; % 分钟
        temp_timediff = [temp_timediff; time_diff];
    end
    [m1,~] = size(temp_timediff);
    for k = 1:m1
        if temp_timediff(k) > 60
            temp_timediff (k) = 60;
        %elseif temp_occtimediffset(j) < 60 && temp_occtimediffset(j) > 60
        end
    end 
    M_time_diffset = [M_time_diffset;temp_timediff];   
end