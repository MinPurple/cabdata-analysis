% 出租车数量M
% Routes：推荐路径top N（已排好序：从小到大）
% Capacity：每个推荐点的容量
% PoCab:当前出租车的位置
% Centriods：聚类中心点坐标
function [Recommendation_Distance,capacity,probability,optimal_Route] = Recommendation(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
N = size(Routes,1); % 推荐路径的数量 
L = size(Routes,2); % 推荐路径的长度

Capacity_orig = Capacity; %存储开始的容量
Optimal_Route = Routes(1,:);
for i = 1:M %对于每辆车
    %分配到第一条路
    %Pro_NoPassenger = Probability(Routes(1,1));
    [~,OptDistance] = GetRoute_Distance(Centriods,Probability,DistanceOfclusters,L,PoCab,Optimal_Route);
    %num_decrease = 0; %容量的减少
    num_decrease = [];
    sum_dec = 0;
    for j = 1:L % 对于一条路上的每一个载客点               
        num_decrease(j) = (1-sum_dec)*Probability(Optimal_Route(1,j));
        sum_dec = sum_dec + num_decrease(j);
%         if j ~= 1
%             num_decrease = num_decrease + Probability(Optimal_Route(1,j-1));
%         end       
        %Capacity(Optimal_Route(1,j)) = Capacity(Optimal_Route(1,j)) - (1-num_decrease)*Probability(Optimal_Route(1,j));
        Capacity(Optimal_Route(1,j)) = Capacity(Optimal_Route(1,j)) - num_decrease(j);
        if Capacity(Optimal_Route(1,j))<0
            Capacity(Optimal_Route(1,j)) = 0;
        end
        Probability(Optimal_Route(1,j)) = Probability(Optimal_Route(1,j)) * Capacity(Optimal_Route(1,j)) / Capacity_orig(Optimal_Route(1,j));
    end
    Recommendation_Distance = Recommendation_Distance + OptDistance;
    % top N 重新排序 得到最优路径
    Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L,PoCab,Routes);
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;
% disp('p');
% disp(probability);


%Weight_Routes = zero(10,1); % 每条路径的权重
% Num_Car_Route = zero(10,1); % 每条路径上分配的出租车的数量,向上取整
% Num_Car_Route = ceil(Weight_Routes.*M); 
% tmp = 0;
% for i=1:N-1
%    tmp = tmp + Num_Car_Route(i); 
% end
% Num_Car_Route(n) = M - tmp;
% for i = 1:N %对于每一条路
%     for l = 1:L
%         Capacity_Route(l) = Capacity(Routes(i,l)); % 该条路上的各载客点的容量
%         Probability_Route(l) = Probability(Routes(i,l)); % 该条路上的各载客点的概率
%     end
%      
%     for j = 1:Num_Car_Route(i) % 该条路上的每一辆出租车
%         
%     end
% end


