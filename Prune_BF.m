%第一个点一样
function Routes_LCP = Prune_BF(Probability,DistanceOfclusters,L,Routes) 
Routes_LCP = [];
%size_windows = 10;
if L == 3
    m = size(Routes,1);
    for i = 1 : m
        for j = i+1 : m
            % p被dominated，从Routes中删除
            if Probability(Routes(i,2)) <= Probability(Routes(j,2)) && Probability(Routes(i,3)) <= Probability(Routes(j,3))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(j,2),Routes(j,3))
                %结束当前循环，p不从Routes中删除，最后再删除
                Routes(i,:) = [0,0,1];
                break;
            elseif Probability(Routes(i,2)) >= Probability(Routes(j,2)) && Probability(Routes(i,3)) >= Probability(Routes(j,3))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(j,2),Routes(j,3))
                % dominate Routes中某些，被优于的从Routes中删除
                Routes(j,:) = [0,0,0];
            end
        end 
        zero_route = sum(Routes,2);
        index = zero_route == 0;
        Routes(index,:) = [];
        m = size(Routes,1);
    end
    zero_route = sum(Routes,2);
    index = zero_route == 1;
    Routes(index,:) = [];
    Routes_LCP = Routes;
end
if L == 4
    m = size(Routes,1);
    for i = 1 : m
        for j = (i+1) : m
            if Probability(Routes(i,2)) <= Probability(Routes(j,2)) && Probability(Routes(i,3)) <= Probability(Routes(j,3)) && Probability(Routes(i,4)) <= Probability(Routes(j,4))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(j,2),Routes(j,3))...
                    && DistanceOfclusters(Routes(i,3),Routes(i,4)) >= DistanceOfclusters(Routes(j,3),Routes(j,4))
                %结束当前循环，p不从Routes中删除
                Routes(i,:) = [0,0,0,1];
                break;
            elseif Probability(Routes(i,2)) >= Probability(Routes(j,2)) && Probability(Routes(i,3)) >= Probability(Routes(j,3)) && Probability(Routes(i,4)) >= Probability(Routes(j,4))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(j,2),Routes(j,3))...
                    && DistanceOfclusters(Routes(i,3),Routes(i,4)) <= DistanceOfclusters(Routes(j,3),Routes(j,4))
                 % dominate Routes中某些，被优于的从Routes中删除
                 Routes(j,:) = [0,0,0,0];
            end
        end
        zero_route = sum(Routes,2);
        index = zero_route == 0;
        Routes(index,:) = [];
        m = size(Routes,1);
    end
    zero_route = sum(Routes,2);
    index = zero_route == 1;
    Routes(index,:) = [];
    Routes_LCP = Routes;           
end
if L == 5
    m = size(Routes,1);
    for i = 1 : m
        for j = i+1 : m
            if Probability(Routes(i,2)) <= Probability(Routes(j,2)) && Probability(Routes(i,3)) <= Probability(Routes(j,3)) && Probability(Routes(i,4)) <= Probability(Routes(j,4)) && Probability(Routes(i,5)) <= Probability(Routes(j,5))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(j,2),Routes(j,3))...
                    && DistanceOfclusters(Routes(i,3),Routes(i,4)) >= DistanceOfclusters(Routes(j,3),Routes(j,4)) && DistanceOfclusters(Routes(i,4),Routes(i,5)) >= DistanceOfclusters(Routes(j,4),Routes(j,5))
                Routes(i,:) = [0,0,0,0,1];     
                break;
            elseif Probability(Routes(i,2)) >= Probability(Routes(j,2)) && Probability(Routes(i,3)) >= Probability(Routes(j,3)) && Probability(Routes(i,4)) >= Probability(Routes(j,4)) && Probability(Routes(i,5)) >= Probability(Routes(j,5))...
                    && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(j,1),Routes(j,2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(j,2),Routes(j,3))...
                    && DistanceOfclusters(Routes(i,3),Routes(i,4)) <= DistanceOfclusters(Routes(j,3),Routes(j,4)) && DistanceOfclusters(Routes(i,4),Routes(i,5)) <= DistanceOfclusters(Routes(j,4),Routes(j,5))
                Routes(j,:) = [0,0,0,0,0];   
            end
        end
        zero_route = sum(Routes,2);
        index = zero_route == 0;
        Routes(index,:) = [];
        m = size(Routes,1);
    end
    zero_route = sum(Routes,2);
    index = zero_route == 1;
    Routes(index,:) = [];
    Routes_LCP = Routes; 
end


