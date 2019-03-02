%——————目标函数——————
%————Centriods：聚类中心点坐标————%
%————Probability：聚类中心点概率集————%
%————DistanceOfclusters：聚类中心点对驾驶距离————%
%————L：推荐驾驶路径长度————%
%————PoCab：空出租车当前位置————%
%————Routes：推荐路径————%
function Route = getRoute(Centriods1819,Probability,DistanceOfclusters,L,PoCab,Routes)
%L=3;
%clusters = [1,2,3,4,5,6,7,8,9,10];
%Routes = combntns(clusters,L);
if L == 3
    %Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
    m = size(Routes,1);
    PTD = +inf;
    index = 0;
    for i = 1:m
        D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
        temp_P = [Probability(Routes(i,1)),(1-Probability(Routes(i,1)))*Probability(Routes(i,2)),(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))];
        temp_D = [D1_PoCab;D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2));D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3))];
        temp_PDT = dot(temp_P,temp_D)/(Probability(Routes(i,1)) + (1-Probability(Routes(i,1)))*Probability(Routes(i,2)) + (1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*Probability(Routes(i,3)));
        if PTD > temp_PDT
            PTD = temp_PDT;
            index = i;
        end
    end
    Route = Routes(index,:);

end
if L == 4
    %Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
    m = size(Routes,1);
    PTD = +inf;
    index = 0;
    for i = 1:m
        D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
        temp_P = [Probability(Routes(i,1)),(1-Probability(Routes(i,1)))*Probability(Routes(i,2)),(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*Probability(Routes(i,3)),(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))];
        temp_D = [D1_PoCab;D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2));D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3));D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3))+DistanceOfclusters(Routes(i,3),Routes(i,4))];
        temp_PDT = dot(temp_P,temp_D)/(Probability(Routes(i,1)) + (1-Probability(Routes(i,1)))*Probability(Routes(i,2)) + (1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*Probability(Routes(i,3))+(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))*Probability(Routes(i,4)));
        if PTD > temp_PDT
            PTD = temp_PDT;
            index = i;
        end
    end
    Route = Routes(index,:);

end
if L == 5
    %Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
    m = size(Routes,1);
    PTD = +inf;
    index = 0;
    for i = 1:m
        D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
        temp_P = [Probability(Routes(i,1)),(1-Probability(Routes(i,1)))*Probability(Routes(i,2)),(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*Probability(Routes(i,3)),...
            (1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))*Probability(Routes(i,4)),(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))*(1-Probability(Routes(i,4)))];
        temp_D = [D1_PoCab;D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2));D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3));D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3))+DistanceOfclusters(Routes(i,3),Routes(i,4));...
            D1_PoCab+DistanceOfclusters(Routes(i,1),Routes(i,2))+DistanceOfclusters(Routes(i,2),Routes(i,3))+DistanceOfclusters(Routes(i,3),Routes(i,4))+DistanceOfclusters(Routes(i,4),Routes(i,5))];
        temp_PDT = dot(temp_P,temp_D)/(Probability(Routes(i,1)) + (1-Probability(Routes(i,1)))*Probability(Routes(i,2)) + (1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*Probability(Routes(i,3))+(1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))*Probability(Routes(i,4))+...
            (1-Probability(Routes(i,1)))*(1-Probability(Routes(i,2)))*(1-Probability(Routes(i,3)))*(1-Probability(Routes(i,4)))*Probability(Routes(i,5)));
        if PTD > temp_PDT
            PTD = temp_PDT;
            index = i;
        end
    end
    Route = Routes(index,:);

end


 