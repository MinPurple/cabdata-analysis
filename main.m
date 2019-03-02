clear all;close all;
%————读取文件——————
% load cabsdataset.mat;
file_path = '/cabspottingdata/new*.txt';
cab_dataset = readFiles(file_path);

%————获取GPS点之间的时间间隔分布————%
[M_occtime_diffset, M_changetime_diffset, M_time_diffset] = distribution_time_interval(cab_dataset);

figure;[num,bin]=histc(M_occtime_diffset,6:1:60);
bar(6:1:60,num,'histc');

%————获得每辆车的总驾驶时间&占有率&有客驾驶时间————
%————一条完整的路径满足一定条件————————%
time_interval = 420;  % GPS两点之间时间差阈值
occtime_interval = 3600;  % 1-1两状态之间时间差阈值
changetime_interval = 900;  % 1-0两状态之间时间差阈值
[M_DriveTimeSet,M_OccRateSet,M_OccTimeSet] = cab_stat_set(cab_dataset,time_interval,occtime_interval,changetime_interval);
% 绘图
figure;
hist(M_OccRateSet,50)
[f,xcenter] = hist(M_OccRateSet,50);
plot(xcenter,f);

f = f/length(M_OccRateSet);
plot(xcenter,f);



%——————有经验司机：选出总驾驶时间>230小时，占有率>0.5的cab司机——————
DT_threshold = 230;
OR_threshold = 0.5;
SuccCabSet = [];
NonSuccCabSet = [];
for i = 1:size(cab_dataset,2)
    if M_DriveTimeSet(i) >= DT_threshold && M_OccRateSet(i) >= OR_threshold
        SuccCabSet = [SuccCabSet;i];    
    else
        NonSuccCabSet = [NonSuccCabSet;i];
    end
end

%————对每个文件进行操作，得到每辆车pick-up、drop-off等相关信息——————
[PickupSet,DropoffSet] = pickup_dropoffsets(cab_dataset,occtime_interval,changetime_interval);

%———有经验司机对应的pickup点信息——————
Succ_PickupSet = [];
for i = 1:size(SuccCabSet,1)
    index = SuccCabSet(i);
    succ_pickup = PickupSet{1,index};
    Succ_PickupSet = [Succ_PickupSet;succ_pickup];
end


%——————pick-up point for different time periods——————
Succ_PickupPointPeriod  = getPickupPointPeriod (Succ_PickupSet);
Succ_PickupPointPeriod_norep = cell(1,24); % 去掉每段时间内重复的上客点
for i = 1:size(Succ_PickupPointPeriod,2)
    Succ_PickupPointPeriod_norep{1,i} = Succ_PickupPointPeriod{1,i}(:,1:2);
    Succ_PickupPointPeriod_norep{1,i} = unique(Succ_PickupPointPeriod_norep{1,i},'rows');
end

%——————每辆车每段时间的数据——————
Period_cab_dataset = get_cabperiodDataset(cab_dataset);
%load Period_cab_dataset.mat;
%————获得 每段时间的驾驶时间 & 每段时间的占有率 & 每辆车每段时间的驾驶时间 & 每辆车每段时间的有客驾驶时间 & 每辆车每段时间的占有率————%
[Period_DriveTimeSet,Period_OccRateSet,Period_OccTimeSet,Period_Cab_DriveTimeSet,Period_Cab_OccTimeSet,Period_Cab_OccRateSet] = get_period_drivingtime_occrate(Period_cab_dataset,time_interval,occtime_interval,changetime_interval);
Period_OccRateSet';

%——————距离矩阵————
%————两个时间段的载客点距离矩阵
load DistMatrix_14_15.mat;
load DistMatrix_18_19.mat;

%——————6PM-7PM聚类各点（各类所有点）————
Cluster_Point = cell(1,10);
for i = 1:10
    n = num2str(i-1);
    temp = ['cluster',n,'.txt'];
    Cluster_Point{1,i} = load(temp);
end
%——————2PM-3PM聚类各点（各类所有点）————
Cluster_Point1415 = cell(1,10);
%————聚类中心矩阵————
Centriods1819 = load('centroid1819.txt');
Centriods1415 = load('centroid1415.txt');

for i = 1:10
    n = num2str(i-1);
    temp = ['clusterc',n,'.txt'];
    Cluster_Point1415{1,i} = load(temp);
end
%————得到出租车在6PM-7PM时间段的集合————
Period_cab_dataset1819 = cell(1,536);
for i = 1:536
    temp_cab = Period_cab_dataset{1,i};
    Period_cab_dataset1819{1,i} = flipud(temp_cab{1,19}); %矩阵上下翻转,按时间增序
end
%————得到出租车在2PM-3PM时间段的集合————
Period_cab_dataset1415 = cell(1,536);
for i = 1:536
    temp_cab = Period_cab_dataset{1,i};
    Period_cab_dataset1415{1,i} = flipud(temp_cab{1,15}); %矩阵上下翻转,按时间增序
end
%——————聚类中心之间的距离矩阵————
DistanceOfclusters = load('DistanceOfclusters.txt');
DistanceOfclusters1415 = load('DistanceOfclusters1415.txt');

%————半径——————
Radius = zeros(10,1); %集群中的点到聚类中心距离的均值为各聚类中心的半径（18-19）
for i = 1:10
    [m,n] = size(Cluster_Point{1,i});
    for row = 1:m
       temp = distance(Centriods1819(i,1),Centriods1819(i,2),Cluster_Point{1,i}(row,1),Cluster_Point{1,i}(row,2))*pi*6371000/180;
       Radius(i) = Radius(i) + temp;
    end
    Radius(i) = Radius(i)/m;
end
Radius1415 = zeros(10,1); %集群中的点到聚类中心距离的均值为各聚类中心的半径
for i = 1:10
    [m,n] = size(Cluster_Point1415{1,i});
    for row = 1:m
       temp = distance(Centriods1415(i,1),Centriods1415(i,2),Cluster_Point1415{1,i}(row,1),Cluster_Point1415{1,i}(row,2))*pi*6371000/180;
       Radius1415(i) = Radius1415(i) + temp;
    end
    Radius1415(i) = Radius1415(i)/m;
end
%——————计算概率（使用集群中的点到聚类中心距离的均值为各聚类中心的半径）——————
[T1,P1] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,0,10);
[T2,P2] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,10,20);
[T3,P3] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,20,30);
[T4,P4] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,30,40);
[T5,P5] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,40,50);
[T6,P6] = get_T_P(Period_cab_dataset1819,Centriods1819,Radius,50,60);
T1_count = sum(T1);P1_count = sum(P1);T2_count = sum(T2);P2_count = sum(P2);T3_count = sum(T3);P3_count = sum(P3);
T4_count = sum(T4);P4_count = sum(P4);T5_count = sum(T5);P5_count = sum(P5);T6_count = sum(T6);P6_count = sum(P6);
T = T1_count + T2_count + T3_count + T4_count + T5_count + T6_count;
P = P1_count + P2_count + P3_count + P4_count + P5_count + P6_count;
Probability = P./T;
Probability1415 = load('ca1.txt');

%——————目标函数——————
clusters = [1,2,3,4,5,6,7,8,9,10]; % 聚类簇数
L = 3; %路径长度
Routes_all = get_permutation(clusters,L); %列举出所有长度为L的路径

PoCab = [37.7825,-122.4215]; % 出租车位置
tic
Route_3 = getRoute(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_all);toc
[Route_3_test,Distance_test] = getRoute_Distance(Centriods1415,Probability1415,DistanceOfclusters1415,3,PoCab,Routes_all);
[Route_3_test1819,Distance_test1819] = getRoute_Distance(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_all);
tic
Route_4 = getRoute(Centriods1819,Probability,DistanceOfclusters,4,PoCab,Routes_all);toc
tic
Route_5 = getRoute(Centriods1819,Probability,DistanceOfclusters,5,PoCab,Routes_all);toc

%——————论文中方法 PTD——————
tic
[RoutePTD_3,PTD3] = getRoute_PTD(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_all);toc
[RoutePTD_3_1415,PTD3_1415] = getRoute_PTD(Centriods1415,Probability1415,DistanceOfclusters1415,3,PoCab,Routes_all);
tic
[RoutePTD_4,PTD4] = getRoute_PTD(Centriods1819,Probability1415,DistanceOfclusters1415,4,PoCab);toc
tic
[RoutePTD_5,PTD5] = getRoute_PTD(Centriods1819,Probability1415,DistanceOfclusters1415,5,PoCab);toc

%——————剪枝LCP————
%---将路径分为第一个点相同的几类，然后分别剪枝，后汇总
clusters = [1,2,3,4,5,6,7,8,9,10];
L = 3;
Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
temp_catg = Routes(:,1);
Routes_Catg = cell(1,10); %第一个点一样
for i = 1:10
    index = find(temp_catg ~= i);
    temp_Routes = Routes;
    temp_Routes(index,:) = [];
    Routes_Catg{i} = temp_Routes;
end
%——————————————————分割线————————
%——--------------------------18:00-19:00————————
Routes_BNL_Catg = cell(1,10); 
tic %剪枝时间
for i = 1:10
    Routes_BNL_Catg{i} = Prune_BF(Probability,DistanceOfclusters,L,Routes_Catg{i});
end
toc
Routes_BNL_3 = []; %剪枝后的路径矩阵
for i = 1:10
    Routes_BNL_3 = [Routes_BNL_3;Routes_BNL_Catg{i}];
end
Routes_BNL_4 = []; %剪枝后的路径矩阵
for i = 1:10
    Routes_BNL_4 = [Routes_BNL_4;Routes_BNL_Catg{i}];
end
Routes_BNL_5 = []; %剪枝后的路径矩阵
for i = 1:10
    Routes_BNL_5 = [Routes_BNL_5;Routes_BNL_Catg{i}];
end
tic
Route_3 = getRoute(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_BNL_3);toc
tic
Route_4 = getRoute(Centriods1819,Probability,DistanceOfclusters,4,PoCab,Routes_BNL_4);toc
tic
Route_5 = getRoute(Centriods1819,Probability,DistanceOfclusters,5,PoCab,Routes_BNL_5);toc

[RouteTopN,Dis_RouteTopN] = GetRouteTopN(Centriods1819,Probability,DistanceOfclusters,4,PoCab,Routes,35);
%[RouteTopN,Dis_RouteTopN] = GetRouteTopN(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_BNL_3,35); % 使用剪枝后的路径

[Recommendation_Distance1819,Next_capacity,Next_probability,optimal_Route] = ...
Recommendation(30,Probability,DistanceOfclusters,RouteTopN,Capacity1819,PoCab,Centriods1819);

% 多地方的车，不同地点车分布
cab_position = load('cab_position.txt'); %各地点---两点
%cab_position = load('cab_position2.txt'); %各地点---两点反
cab_position = load('cab_position6.txt'); %各地点---三点
cab_position = load('cab_position3.txt'); %各地点---四点
cab_position = load('cab_position5.txt'); %各地点---五点
cab_position = load('cab_position4.txt'); %各地点---十点
%cab_position = load('cab_position7.txt'); %各地点---四点2

num_position = size(cab_position,1);
tic;
RouteTopN_Muti = cell(1,num_position); %对应各地点的路径候选集
for i = 1:size(cab_position,1)
    [RouteTopN_Muti{1,i},~] = GetRouteTopN(Centriods1819,Probability,DistanceOfclusters,L,cab_position(i,:),Routes,45);
end
toc;
% baseline计算候选集合
tic;
RouteTopN_Baseline = cell(1,num_position); %对应各地点的路径候选集
for i = 1:size(cab_position,1)
    [RouteTopN_Baseline{1,i},~] = GetRouteTopN(Centriods1819,Probability,DistanceOfclusters,L,cab_position(i,:),Routes,5);
end
toc;

numLst = [10,20,30,40,50,60,70,80,90,100];
for tmpnum = 1:size(numLst,2)
    num_pos = numLst(tmpnum);    
    M = num_pos*ones(1,num_position);
    tic;
    % algorithm
    [Recommendation_Distance1819Muti,RouteList,~,~,~] =...
        Recommendation_MutiPos1(M,Probability,DistanceOfclusters,RouteTopN_Muti,Capacity1819,cab_position,Centriods1819);%改变概率更新方式
    toc;
end
for tmpnum = 1:size(numLst,2)
    num_pos = numLst(tmpnum);    
    M = num_pos*ones(1,num_position);
    tic;
    %baseline
    [Recommendation_Distance1819Base,RouteList_Baseline,~,~,~] = ...
        RecommendationRR_Muti1(M,Probability,DistanceOfclusters,RouteTopN_Baseline,Capacity1819,cab_position,Centriods1819);%改变概率更新方式
    toc;
end

for tmpnum = 1:size(numLst,2)
    num_pos = numLst(tmpnum);    
    M = num_pos*ones(1,num_position);
    %Simulation algorithm
    tic;
    RealDistance = [];
    for i = 1:1
        [RealDistance(i),m_capacity,m_probability,m_optimal_Route] = ...
            Recommendation_Simulate2(M,Probability,DistanceOfclusters,RouteList,Capacity1819,cab_position,Centriods1819); %改变概率更新方式
    end
    RealDistance_algorithm = (sum(RealDistance,2))/100;
    toc;
end

for tmpnum = 1:size(numLst,2)
    num_pos = numLst(tmpnum);    
    M = num_pos*ones(1,num_position);
    %Simulation baseline
    tic;
    RealDistance_Base = [];
    for i = 1:1
        [RealDistance_Base(i),m_capacity,m_probability,m_optimal_Route] = ...
            Recommendation_Simulate2(M,Probability,DistanceOfclusters,RouteList_Baseline,Capacity1819,cab_position,Centriods1819);
    end
    RealDistance_baseline = (sum(RealDistance_Base,2))/100;
    toc;
end



%——————剪枝Skyline————
tic
Routes_BNL_SR_3 = Online_Prune(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_BNL_3,15);
Route_3 = getRoute(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_BNL_SR_3);toc
tic
Routes_BNL_SR_4 = Online_Prune(Centriods1819,Probability,DistanceOfclusters,4,PoCab,Routes_BNL_4,15);
Route_4 = getRoute(Centriods1819,Probability,DistanceOfclusters,4,PoCab,Routes_BNL_SR_4);toc
tic
Routes_BNL_SR_5 = Online_Prune(Centriods1819,Probability,DistanceOfclusters,5,PoCab,Routes_BNL_5,10);
Route_5 = getRoute(Centriods1819,Probability,DistanceOfclusters,5,PoCab,Routes_BNL_SR_5);toc

figure;
x = 3:5;
y1 = [0.8,0.7958,0.8117];
y2 = [0.9653,0.9653,0.9658];
plot(x,y1,'s-',x,y2,'s-');

%——————————容量计算————————————————————————————————————————————————————
%————所有的pick-up上客点的信息 & 各个时段————%
M_PickupSet = [];
for i = 1:size(PickupSet,2)
    M_PickupSet = [M_PickupSet;PickupSet{1,i}];
end
PickupPointPeriod  = getPickupPointPeriod (M_PickupSet);
Capacity1415 = Get_Capacity(PickupPointPeriod{1,15},Centriods1415,Radius1415);
Capacity1819 = Get_Capacity(PickupPointPeriod{1,19},Centriods1819,Radius);




