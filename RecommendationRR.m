% ���⳵����M
% Routes���Ƽ�·��top N�����ź��򣺴�С����
% Capacity��ÿ���Ƽ��������
% PoCab:��ǰ���⳵��λ��
% Centriods���������ĵ�����
function [Recommendation_Distance,RouteList,capacity,probability,optimal_Route] = RecommendationRR(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
N = size(Routes,1); % �Ƽ�·�������� 
L = size(Routes,2); % �Ƽ�·���ĳ���
RouteList = cell(1,num_position); %��Ӧ���ص��·����ѡ��
Capacity_orig = Capacity; %�洢��ʼ������
%Optimal_Route = Routes(1,:);
for i = 1:M %����ÿ����
    %���䵽��һ��·
    %Pro_NoPassenger = Probability(Routes(1,1));
    index_Route = mod(i,N);
    if index_Route == 0
        index_Route = N;
    end
    Optimal_Route = Routes(index_Route,:);
    [OptRoute,OptDistance] = GetRoute_Distance(Centriods,Probability,DistanceOfclusters,L,PoCab,Optimal_Route);
    %num_decrease = 0; %�����ļ���
    num_decrease = [];
    sum_dec = 0;
    for j = 1:L % ����һ��·�ϵ�ÿһ���ؿ͵�               
        num_decrease(j) = (1-sum_dec)*Probability(Optimal_Route(1,j));
        sum_dec = sum_dec + num_decrease(j);
        Capacity(Optimal_Route(1,j)) = Capacity(Optimal_Route(1,j)) - num_decrease(j);
        if Capacity(Optimal_Route(1,j))<0
            Capacity(Optimal_Route(1,j)) = 0;
        end
        Probability(Optimal_Route(1,j)) = Probability(Optimal_Route(1,j)) * Capacity(Optimal_Route(1,j)) / Capacity_orig(Optimal_Route(1,j));
    end
    Recommendation_Distance = Recommendation_Distance + OptDistance;
    % top N �������� �õ�����·��
    %Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L,PoCab,Routes);
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;



