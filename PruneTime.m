%---------剪枝效率——————%
%---将路径分为第一个点相同的几类，然后分别剪枝，后汇总
clusters = [1,2,3,4,5,6,7,8,9,10];
L = 3;
Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
temp_catg = Routes(:,1);
Routes_Catg = cell(1,10); %第一个点一样
for i = 1:10
    index = find(temp_catg ~= i);
    temp_Routes = Routes;
    temp_Routes(index,:) = [];
    Routes_Catg{i} = temp_Routes;
end
Routes_PST_Catg = cell(1,10); 
Routes_PST = []; %剪枝后的候选路径集


%———————分割线——18:00-19:00————PS-Tree 剪枝————

tic %剪枝时间
for i = 1:10
    Routes_PST_Catg{i} = Prune_BF(Probability,DistanceOfclusters,L,Routes_Catg{i});
end
for i = 1:10
    Routes_PST = [Routes_PST;Routes_PST_Catg{i}];
end
Route_5 = GetRoute(Centriods1819,Probability,DistanceOfclusters,L,PoCab,Routes_PST);
toc

%-----没剪枝所用时间————
tic
RouteWithoutPrun5 = GetRoute(Centriods1819,Probability,DistanceOfclusters,L,PoCab,Routes);
toc

%--------14:00-15:00--------------------%
tic %剪枝时间
for i = 1:10
    Routes_PST_Catg{i} = Prune_BF(Probability1415,DistanceOfclusters1415,L,Routes_Catg{i});
end
for i = 1:10
    Routes_PST = [Routes_PST;Routes_PST_Catg{i}];
end
Route_5 = GetRoute(Centriods1415,Probability1415,DistanceOfclusters1415,L,PoCab,Routes_PST);
toc

%-----没剪枝所用时间————
tic
RouteWithoutPrun5 = GetRoute(Centriods1415,Probability1415,DistanceOfclusters1415,L,PoCab,Routes);
toc



%——————剪枝Skyline————
tic
Routes_SR_3 = Online_Prune(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_PST,15);
Route_3 = GetRoute(Centriods1819,Probability,DistanceOfclusters,3,PoCab,Routes_SR_3);toc
tic




