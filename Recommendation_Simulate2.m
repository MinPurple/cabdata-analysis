% ���⳵����M
% Capacity��ÿ���Ƽ��������
% PoCab:���⳵��λ��
% Centriods���������ĵ�����
% RouteList: ·���б�
% ʹ�õ�ģ�ⷽ�������������㷨�õ���·����Ϊ����
function [Recommendation_Distance,capacity,probability,optimal_Route] = Recommendation_Simulate2(M,Probability,DistanceOfclusters,RouteList,Capacity,PoCab,Centriods)
Recommendation_Distance = 0;
% N = size(Routes,1); % �Ƽ�·��������
% L = size(Routes,2); % �Ƽ�·���ĳ���
num_position = size(PoCab,1); % ���⳵λ�õ�����
for i = 1:num_position
    L(i) = size(RouteList{1,i},2);% �Ƽ�·���ĳ���
end
for k= 1:num_position %����ÿ��λ��
    for i = 1:M(k) %����ÿ����
        Optimal_Route = RouteList{1,k}(i,:);
        index_pick = 0;
        for j = 1:L(k) % ����һ��·�ϵ�ÿһ���ؿ͵�
            Pre_Capacity = Capacity(Optimal_Route(1,j)); % ��ǰ������
            if Pre_Capacity == 0
                continue;
            end
            IsPick = round(rand(1)); %�Ƿ��ص���
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
        % ֮ǰ�㷨�õ���·���б���Ϊ��������
    end
end
capacity = Capacity;
probability = Probability;
optimal_Route = Optimal_Route;
% disp('p');
% disp(probability);