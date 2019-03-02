%——————某一条路径的实际驾驶距离——————%
%————Centriods1819：聚类中心点坐标————%
%————DistanceOfclusters：聚类中心点对驾驶距离————%
%————PoCab：空出租车当前位置————%
%————Routes：推荐路径————%
%————index_pick：上客的点——————%
function RealDistance = getRoute_RealDistance(Centriods1819,DistanceOfclusters,PoCab,Routes,index_pick)
D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(1,1),1),Centriods1819(Routes(1,1),2))*pi*6371000/180;
RealDistance = D1_PoCab;
if index_pick > 1 
    for j = 2:index_pick
        RealDistance = RealDistance + DistanceOfclusters(Routes(1,j-1),Routes(1,j));
    end
end
