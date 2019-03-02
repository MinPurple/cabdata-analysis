% ���⳵����M
% Routes���Ƽ�·��top N�����ź��򣺴�С����
% Capacity��ÿ���Ƽ��������
% PoCab:��ǰ���⳵��λ��
% Centriods���������ĵ�����
% PoCab: ���⳵��λ��
% RouteList: ·���б�
% ������ʵķ�����һ����������
function [Recommendation_Distance,RouteList,capacity,probability,optimal_Route] = Recommendation_MutiPos1(M,Probability,DistanceOfclusters,Routes,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
%RouteList = [];
num_position = size(PoCab,1); % ���⳵λ�õ�����
%L = size(Routes{1,1},2); % �Ƽ�·���ĳ���
RouteList = cell(1,num_position); %��Ӧ���ص��·����ѡ��
for i = 1:num_position
    L(i) = size(Routes{1,i},2);% �Ƽ�·���ĳ���
end
%Capacity_orig = Capacity; %�洢��ʼ������
Optimal_Route = Routes{1,1}(1,:);
routelist = []; % ÿ��λ�õĸ�����·���б�
for k= 1:num_position %����ÿ��λ��
    for i = 1:M(k) %����ÿ����
        routelist = [routelist;Optimal_Route];
        %���䵽��һ��·
        %Pro_NoPassenger = Probability(Routes(1,1));
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
        Optimal_Route = GetRoute(Centriods,Probability,DistanceOfclusters,L(k),PoCab(k,:),Routes{1,k});
    end
    RouteList{1,k} = routelist;
    %     disp('λ��');
    %     disp(k);
end

capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;

