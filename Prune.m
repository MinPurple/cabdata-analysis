function Routes_BNL = Prune(Probability,DistanceOfclusters,L,Routes,size_windows)
%clusters = [1,2,3,4,5,6,7,8,9,10];
%L = 3;
%Routes = get_permutation(clusters,L); %列举出所有长度为L的路径
Routes_BNL = [];
%size_windows = 10;
if L == 3
    while size(Routes,1) >= size_windows
        [m,n] = size(Routes);
        windows = Routes(1:size_windows,:);
        index_win = zeros(size_windows,1);
        for j = 1:size_windows
            index_win(j) = j;
        end
        delete = [];
        temp_file = [];
        temp_file_index = [];
        for i = (size_windows + 1):m
            %D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
            for j = 1:size(windows,1)
                %D1_hat_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(index_win(j),1),1),Centriods1819(Routes(index_win(j),1),2))*pi*6371000/180;
                if Probability(Routes(i,2)) <= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) <= Probability(Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))
                    %Routes(i,:) = []; % p被dominated，从Routes中删除
                    delete = [delete;i];
                    Routes(i,:) = [0,0,0];
                    %结束当前循环，将windows中的0清掉
                    zero_win = sum(windows,2); 
                    index = find(zero_win == 0);
                    windows(index,:) = [];
                    index_win(index,:) = [];
                    
                    break;
                elseif Probability(Routes(i,2)) >= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) >= Probability(Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))
                    %Routes(i,:) = []; % dominate windows中某些，被优于的从windows中删除，并将该路径插入到windows中
                    delete = [delete;index_win(j)];
                    Routes(index_win(j),:) = [0,0,0];
                    windows(j,:) = [0,0,0];
                    index_win(j) = 0;
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        windows = [windows;Routes(i,:)];
                        index_win = [index_win;i];
                    end
                else
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        if  size(windows,1) < size_windows
                            windows = [windows;Routes(i,:)];
                            index_win = [index_win;i];
                        else
                            temp_file = [temp_file;Routes(i,:)];
                            temp_file_index = [temp_file_index;i];
                        end
                    end
                end
            end
        end
        
        Routes_BNL = [Routes_BNL;windows];
        Routes = temp_file;
    end
    Routes_BNL = [Routes_BNL;temp_file];
end
if L == 4
    while size(Routes,1) >= size_windows
        [m,n] = size(Routes);
        windows = Routes(1:size_windows,:);
        index_win = zeros(size_windows,1);
        for j = 1:size_windows
            index_win(j) = j;
        end
        delete = [];
        temp_file = [];
        temp_file_index = [];
        for i = (size_windows + 1):m
            %D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
            for j = 1:size(windows,1)
                %D1_hat_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(index_win(j),1),1),Centriods1819(Routes(index_win(j),1),2))*pi*6371000/180;
                if Probability(Routes(i,2)) <= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) <= Probability(Routes(index_win(j),3)) && Probability(Routes(i,4)) <= Probability(Routes(index_win(j),4))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,3),Routes(i,4)) >= DistanceOfclusters(Routes(index_win(j),3),Routes(index_win(j),4))
                    %Routes(i,:) = []; % p被dominated，从Routes中删除
                    delete = [delete;i];
                    Routes(i,:) = [0,0,0,0];
                    
                    zero_win = sum(windows,2);
                    index = find(zero_win == 0);
                    windows(index,:) = [];
                    index_win(index,:) = [];
                    
                    break;
                elseif Probability(Routes(i,2)) >= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) >= Probability(Routes(index_win(j),3)) && Probability(Routes(i,4)) >= Probability(Routes(index_win(j),4))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,3),Routes(i,4)) <= DistanceOfclusters(Routes(index_win(j),3),Routes(index_win(j),4))
                    %Routes(i,:) = []; % dominate windows中某些，被优于的从windows中删除，并将该路径插入到windows中
                    delete = [delete;index_win(j)];
                    Routes(index_win(j),:) = [0,0,0,0];
                    windows(j,:) = [0,0,0,0];
                    index_win(j) = 0;
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        windows = [windows;Routes(i,:)];
                        index_win = [index_win;i];
                    end
                else
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        if  size(windows,1) < size_windows
                            windows = [windows;Routes(i,:)];
                            index_win = [index_win;i];
                        else
                            temp_file = [temp_file;Routes(i,:)];
                            temp_file_index = [temp_file_index;i];
                        end
                    end
                end
            end
        end
        
        Routes_BNL = [Routes_BNL;windows];
        Routes = temp_file;
    end
    Routes_BNL = [Routes_BNL;temp_file];
end
if L == 5
    while size(Routes,1) >= size_windows
        [m,n] = size(Routes);
        windows = Routes(1:size_windows,:);
        index_win = zeros(size_windows,1);
        for j = 1:size_windows
            index_win(j) = j;
        end
        delete = [];
        temp_file = [];
        temp_file_index = [];
        for i = (size_windows + 1):m
            %D1_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(i,1),1),Centriods1819(Routes(i,1),2))*pi*6371000/180;
            for j = 1:size(windows,1)
                %D1_hat_PoCab = distance(PoCab(1),PoCab(2),Centriods1819(Routes(index_win(j),1),1),Centriods1819(Routes(index_win(j),1),2))*pi*6371000/180;
                if Probability(Routes(i,2)) <= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) <= Probability(Routes(index_win(j),3)) && Probability(Routes(i,4)) <= Probability(Routes(index_win(j),4)) && Probability(Routes(i,5)) <= Probability(Routes(index_win(j),5))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) >= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) >= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,3),Routes(i,4)) >= DistanceOfclusters(Routes(index_win(j),3),Routes(index_win(j),4)) && DistanceOfclusters(Routes(i,4),Routes(i,5)) >= DistanceOfclusters(Routes(index_win(j),4),Routes(index_win(j),5))
                    %Routes(i,:) = []; % p被dominated，从Routes中删除
                    delete = [delete;i];
                    Routes(i,:) = [0,0,0,0,0];
                    
                    zero_win = sum(windows,2);
                    index = find(zero_win == 0);
                    windows(index,:) = [];
                    index_win(index,:) = [];
                    
                    break;
                elseif Probability(Routes(i,2)) >= Probability(Routes(index_win(j),2)) && Probability(Routes(i,3)) >= Probability(Routes(index_win(j),3)) && Probability(Routes(i,4)) >= Probability(Routes(index_win(j),4)) && Probability(Routes(i,5)) >= Probability(Routes(index_win(j),5))...
                        && DistanceOfclusters(Routes(i,1),Routes(i,2)) <= DistanceOfclusters(Routes(index_win(j),1),Routes(index_win(j),2)) && DistanceOfclusters(Routes(i,2),Routes(i,3)) <= DistanceOfclusters(Routes(index_win(j),2),Routes(index_win(j),3))...
                        && DistanceOfclusters(Routes(i,3),Routes(i,4)) <= DistanceOfclusters(Routes(index_win(j),3),Routes(index_win(j),4)) && DistanceOfclusters(Routes(i,4),Routes(i,5)) <= DistanceOfclusters(Routes(index_win(j),4),Routes(index_win(j),5))
                    %Routes(i,:) = []; % dominate windows中某些，被优于的从windows中删除，并将该路径插入到windows中
                    delete = [delete;index_win(j)];
                    Routes(index_win(j),:) = [0,0,0,0,0];
                    windows(j,:) = [0,0,0,0,0];
                    index_win(j) = 0;
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        windows = [windows;Routes(i,:)];
                        index_win = [index_win;i];
                    end
                else
                    if j == size(windows,1)
                        zero_win = sum(windows,2);
                        index = find(zero_win == 0);
                        windows(index,:) = [];
                        index_win(index,:) = [];
                        if  size(windows,1) < size_windows
                            windows = [windows;Routes(i,:)];
                            index_win = [index_win;i];
                        else
                            temp_file = [temp_file;Routes(i,:)];
                            temp_file_index = [temp_file_index;i];
                        end
                    end
                end
            end
        end
        
        Routes_BNL = [Routes_BNL;windows];
        Routes = temp_file;
    end
    Routes_BNL = [Routes_BNL;temp_file];
end

