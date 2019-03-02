% 出租车数量M
% Capacity：每个推荐点的容量
% PoCab:出租车的位置
% Centriods：聚类中心点坐标
% RouteList: 路径列表
% 使用的模拟方法————用算法得到的路径作为参数
function [Recommendation_Distance,capacity,probability,optimal_Route] = Recommendation_Simulate2(M,Probability,DistanceOfclusters,RouteList,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
% N = size(Routes,1); % 推荐路径的数量
% L = size(Routes,2); % 推荐路径的长度
num_position = size(PoCab,1); % 出租车位置的数量
for i = 1:num_position
    L(i) = size(RouteList{1,i},2);% 推荐路径的长度
end
for k= 1:num_position %对于每个位置
    for i = 1:M(k) %对于每辆车
        Optimal_Route = RouteList{1,k}(i,:);
        index_pick = 0;
        for j = 1:L(k) % 对于一条路上的每一个载客点
            Pre_Capacity = Capacity(Optimal_Route(1,j)); % 当前的容量
            if Pre_Capacity == 0
                continue;
            end
            IsPick = round(rand(1)); %是否载到客
            if IsPick
                Capacity(Optimal_Route(1,j)) = Capacity(Optimal_Route(1,j)) - 1;
                if Capacity(Optimal_Route(1,j))<0
                    Capacity(Optimal_Route(1,j)) = 0;
                end
                Probability(Optimal_Route(1,j)) = Probability(Optimal_Route(1,j)) * Capacity(Optimal_Route(1,j)) / Pre_Capacity;
                index_pick = j;
                break;
            end
        end
        if index_pick == 0
            index_pick = L(k);
        end
        RealDistance = GetRoute_RealDistance(Centriods,DistanceOfclusters,PoCab(k,:),Optimal_Route,index_pick);
        Recommendation_Distance = Recommendation_Distance + RealDistance;
        % 之前算法得到的路径列表作为参数输入
    end
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;
% disp('p');
% disp(probability);