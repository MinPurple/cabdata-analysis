% 验证计算时间
L = 4;
Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
cab_position = [37.7615,-122.3985;37.7825,-122.4215;37.7675,-122.4489;37.7965,-122.4155]; 
%cab_position = [37.7615,-122.3985;37.7825,-122.4215;37.7675,-122.4489]; 
%cab_position = [37.7825,-122.4215;37.7675,-122.4489]; 
%cab_position = [37.7825,-122.4215]; 
num_position = size(cab_position,1);
% our method 计算候选集合
tic;
RouteTopN_Muti = cell(1,num_position); %对应各地点的路径候选集
for i = 1:size(cab_position,1)
    [RouteTopN_Muti{1,i},~] = GetRouteTopN(Centriods1819,Probability,DistanceOfclusters,L,cab_position(i,:),Routes,45);
end
toc;
% baseline计算候选集合
tic;
%baseline
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
    for i = 1:100
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
    for i = 1:100
        [RealDistance_Base(i),m_capacity,m_probability,m_optimal_Route] = ...
            Recommendation_Simulate2(M,Probability,DistanceOfclusters,RouteList_Baseline,Capacity1819,cab_position,Centriods1819);
    end
    RealDistance_baseline = (sum(RealDistance_Base,2))/100;
    toc;
end

