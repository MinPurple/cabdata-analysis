function [M_DriveTimeSet,M_OccRateSet,M_OccTimeSet] = cab_stat_set(cab_dataset,time_interval,occtime_interval,changetime_interval)
%————获得每辆车的总驾驶时间,存储矩阵M_DriveTimeSet————%
num_cab = size(cab_dataset,2);
DriveTimeSet = cell(1,num_cab); %定义一个1*num_cab的元胞数组,每个cell存储一辆车的驾驶时间信息
for i = 1:num_cab
    drive_time = 0;
    cab_data = flipud(cab_dataset{1,i}); %矩阵上下翻转,按时间增序
    m = size(cab_data,1);
    for j = 2:m 
        time_diff = cab_data(j,4) - cab_data(j-1,4);
        if (time_diff) < time_interval
            drive_time = drive_time + time_diff;
        elseif cab_data(j,3) == 1 && cab_data(j-1,3) == 1 && time_diff <= occtime_interval
            drive_time = drive_time + time_diff;
        elseif cab_data(j,3) == 0 && cab_data(j-1,3) == 1 && time_diff <= changetime_interval
            drive_time = drive_time + time_diff;
        end        
    end
    DriveTimeSet{1,i} = drive_time/3600;
end
M_DriveTimeSet = cell2mat(DriveTimeSet);

%——————-占有率&有客驾驶时间————————
OccRateSet = cell(1,num_cab); %定义一个1*num_cab的元胞数组,每个cell存储一个文件中的占有率信息
OccTimeSet = cell(1,num_cab); %定义一个1*num_cab的元胞数组,每个cell存储一个文件中的有客时间信息
for i = 1:num_cab
    occ_time = 0;
    cab_data = flipud(cab_dataset{1,i}); 
    m = size(cab_data,1);
    for j = 2:m 
        if cab_data(j,3) == 1
            if cab_data(j-1,3) == 1
                time_diff = cab_data(j,4) - cab_data(j-1,4);
                if (time_diff) <= occtime_interval
                    occ_time = occ_time + time_diff;                 
                end
            end     
        elseif cab_data(j,3) == 0         
            if cab_data(j-1,3) == 1 && (cab_data(j,4)- cab_data(j-1,4)) < changetime_interval
                occ_time = occ_time + (cab_data(j,4)-cab_data(j-1,4));
            end
        end
    end
    OccTimeSet{1,i} = occ_time/3600;
end

for i = 1:num_cab
    OccRateSet{1,i} = OccTimeSet{1,i}/DriveTimeSet{1,i};
end
M_OccTimeSet = cell2mat(OccTimeSet); 
M_OccRateSet = cell2mat(OccRateSet); 