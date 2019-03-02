%---------��֦Ч�ʡ�����������%
%---��·����Ϊ��һ������ͬ�ļ��࣬Ȼ��ֱ��֦�������
clusters = [1,2,3,4,5,6,7,8,9,10];
L = 3;
Routes = get_permutation(clusters,L); %�оٳ����г���ΪL��·��
temp_catg = Routes(:,1);
Routes_Catg = cell(1,10); %��һ����һ��
for i = 1:10
    index = find(temp_catg ~= i);
    temp_Routes = Routes;
    temp_Routes(index,:) = [];
    Routes_Catg{i} = temp_Routes;
end
Routes_PST_Catg = cell(1,10); 
Routes_PST = []; %��֦��ĺ�ѡ·����


%���������������ָ��ߡ���18:00-19:00��������PS-Tree ��֦��������

tic %��֦ʱ��
for i = 1:10
    Routes_PST_Catg{i} = Prune_BF(Probability,DistanceOfclusters,L,Routes_Catg{i});
end
for i = 1:10
    Routes_PST = [Routes_PST;Routes_PST_Catg{i}];
end
Route_5 = GetRoute(Centriods1819,Probability,DistanceOfclusters,L,PoCab,Routes_PST);
toc

%-----û��֦����ʱ�䡪������
tic
RouteWithoutPrun5 = GetRoute(Centriods1819,Probability,DistanceOfclusters,L,PoCab,Routes);
toc

%--------14:00-15:00--------------------%
tic %��֦ʱ��
for i = 1:10
    Routes_PST_Catg{i} = Prune_BF(Probability1415,DistanceOfclusters1415,L,Routes_Catg{i});
end
for i = 1:10
    Routes_PST = [Routes_PST;Routes_PST_Catg{i}];
end
Route_5 = GetRoute(Centriods1415,Probability1415,DistanceOfclusters1415,L,PoCab,Routes_PST);
toc

%-----û��֦����ʱ�䡪������
tic
RouteWithoutPrun5 = GetRoute(Centriods1415,Probability1415,DistanceOfclusters1415,L,PoCab,Routes);
toc



%��������������֦Skyline��������
tic
Routes_SR_3 = Online_Prune(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_PST,15);
Route_3 = GetRoute(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_SR_3);toc
tic




