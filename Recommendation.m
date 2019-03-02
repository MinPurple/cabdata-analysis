% ���⳵����M
% Routes���Ƽ�·��top N�����ź��򣺴�С����
% Capacity��ÿ���Ƽ��������
% PoCab:��ǰ���⳵��λ��
% Centriods���������ĵ�����
function [Recommendation_Distance,capacity,probability,optimal_Route] = Recommendation(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
N = size(Routes,1); % �Ƽ�·�������� 
L = size(Routes,2); % �Ƽ�·���ĳ���

Capacity_orig = Capacity; %�洢��ʼ������
Optimal_Route = Routes(1,:);
for i = 1:M %����ÿ����
    %���䵽��һ��·
    %Pro_NoPassenger = Probability(Routes(1,1));
    [~,OptDistance] = GetRoute_Distance(Centriods,Probability,DistanceOfclusters,L,PoCab,Optimal_Route);
    %num_decrease = 0; %�����ļ���
    num_decrease = [];
    sum_dec = 0;
    for j = 1:L % ����һ��·�ϵ�ÿһ���ؿ͵�               
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
    % top N �������� �õ�����·��
    Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L,PoCab,Routes);
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;
% disp('p');
% disp(probability);


%Weight_Routes = zero(10,1); % ÿ��·����Ȩ��
% Num_Car_Route = zero(10,1); % ÿ��·���Ϸ���ĳ��⳵������,����ȡ��
% Num_Car_Route = ceil(Weight_Routes.*M); 
% tmp = 0;
% for i=1:N-1
%    tmp = tmp + Num_Car_Route(i); 
% end
% Num_Car_Route(n) = M - tmp;
% for i = 1:N %����ÿһ��·
%     for l = 1:L
%         Capacity_Route(l) = Capacity(Routes(i,l)); % ����·�ϵĸ��ؿ͵������
%         Probability_Route(l) = Probability(Routes(i,l)); % ����·�ϵĸ��ؿ͵�ĸ���
%     end
%      
%     for j = 1:Num_Car_Route(i) % ����·�ϵ�ÿһ�����⳵
%         
%     end
% end


