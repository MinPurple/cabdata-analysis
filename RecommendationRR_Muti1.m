% ���⳵����M
% Routes���Ƽ�·��top N�����ź��򣺴�С����
% Capacity��ÿ���Ƽ��������
% PoCab:��ǰ���⳵��λ��
% Centriods���������ĵ�����
function [Recommendation_Distance,RouteList,capacity,probability,optimal_Route] = RecommendationRR_Muti1(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
num_position = size(PoCab,1); % ���⳵λ�õ�����
%N = size(Routes,1); % �Ƽ�·�������� 
%L = size(Routes,2); % �Ƽ�·���ĳ���
RouteList = cell(1,num_position); %��Ӧ���ص��·����ѡ��
for i = 1:num_position
    N(i) = size(Routes{1,i},1);% �Ƽ�·�������� 
end
for i = 1:num_position
    L(i) = size(Routes{1,i},2);% �Ƽ�·���ĳ���
end

Capacity_orig = Capacity; %�洢��ʼ������
routelist = []; % ÿ��λ�õĸ�����·���б�
%Optimal_Route = Routes(1,:);
for k= 1:num_position %����ÿ��λ��
    for i = 1:M(k) %����ÿ����
        %���䵽��һ��·
        index_Route = mod(i,N(k));
        if index_Route == 0
            index_Route = N(k);
        end
        Optimal_Route = Routes{1,k}(index_Route,:);
        routelist = [routelist;Optimal_Route];
        [OptRoute,OptDistance] = GetRoute_Distance(Centriods,Probability,DistanceOfclusters,L(k),PoCab(k,:),Optimal_Route);
        %num_decrease = 0; %�����ļ���
        num_decrease = [];
        sum_dec = 0;
        for j = 1:L(k) % ����һ��·�ϵ�ÿһ���ؿ͵�
            Pre_Capacity = Capacity(Optimal_Route(1,j)); % ��ǰ������
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
        % top N �������� �õ�����·��
        %Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L,PoCab,Routes);
    end
    RouteList{1,k} = routelist;
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;