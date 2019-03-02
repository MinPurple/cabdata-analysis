% 出租车数量M
% Routes：推荐路径top N（已排好序：从小到大）
% Capacity：每个推荐点的容量
% PoCab:当前出租车的位置
% Centriods：聚类中心点坐标
function [Recommendation_Distance,RouteList,capacity,probability,optimal_Route] = RecommendationRR_Muti1(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
num_position = size(PoCab,1); % 出租车位置的数量
%N = size(Routes,1); % 推荐路径的数量 
%L = size(Routes,2); % 推荐路径的长度
RouteList = cell(1,num_position); %对应各地点的路径候选集
for i = 1:num_position
    N(i) = size(Routes{1,i},1);% 推荐路径的数量 
end
for i = 1:num_position
    L(i) = size(Routes{1,i},2);% 推荐路径的长度
end

Capacity_orig = Capacity; %存储开始的容量
routelist = []; % 每个位置的各车的路径列表
%Optimal_Route = Routes(1,:);
for k= 1:num_position %对于每个位置
    for i = 1:M(k) %对于每辆车
        %分配到第一条路
        index_Route = mod(i,N(k));
        if index_Route == 0
            index_Route = N(k);
        end
        Optimal_Route = Routes{1,k}(index_Route,:);
        routelist = [routelist;Optimal_Route];
        [OptRoute,OptDistance] = GetRoute_Distance(Centriods,Probability,DistanceOfclusters,L(k),PoCab(k,:),Optimal_Route);
        %num_decrease = 0; %容量的减少
        num_decrease = [];
        sum_dec = 0;
        for j = 1:L(k) % 对于一条路上的每一个载客点
            Pre_Capacity = Capacity(Optimal_Route(1,j)); % 当前的容量
            if Pre_Capacity == 0
                Capacity(Optimal_Route(1,j)) = 0;
                Probability(Optimal_Route(1,j)) = 0;
            else
                num_decrease(j) = (1-sum_dec)*Probability(Optimal_Route(1,j));
                sum_dec = sum_dec + num_decrease(j);
                Capacity(Optimal_Route(1,j)) = Capacity(Optimal_Route(1,j)) - num_decrease(j);
                if Capacity(Optimal_Route(1,j))<0
                    Capacity(Optimal_Route(1,j)) = 0;
                end
                Probability(Optimal_Route(1,j)) = Probability(Optimal_Route(1,j)) * Capacity(Optimal_Route(1,j)) / Pre_Capacity;
            end
        end
        Recommendation_Distance = Recommendation_Distance + OptDistance;
        % top N 重新排序 得到最优路径
        %Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L,PoCab,Routes);
    end
    RouteList{1,k} = routelist;
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;