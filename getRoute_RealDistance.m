%������������ĳһ��·����ʵ�ʼ�ʻ���롪����������%
%��������Centriods1819���������ĵ����ꡪ������%
%��������DistanceOfclusters���������ĵ�Լ�ʻ���롪������%
%��������PoCab���ճ��⳵��ǰλ�á�������%
%��������Routes���Ƽ�·����������%
%��������index_pick���Ͽ͵ĵ㡪����������%
function RealDistance = getRoute_RealDistance(Centriods1819,DistanceOfclusters,PoCab,Routes,index_pick)
D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(1,1),1),Centriods1819(Routes(1,1),2))*pi*6371000/180;
RealDistance = D1_PoCab;
if index_pick > 1 
    for j = 2:index_pick
        RealDistance = RealDistance + DistanceOfclusters(Routes(1,j-1),Routes(1,j));
    end
end
