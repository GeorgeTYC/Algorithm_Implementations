function ans = dijkstra(adj, src, destination)
    %% 
    % adj   可达矩阵
    % src   源点
    % destination   目的节点

    % 尚未求出最短路径的节点集合
    U = 1:length(adj)   
    next = ones(length(adj),1) * - 1;
    U(U == src) = [];
    % 已求出最短路径的节点集合
    S = src;
    % 源节点到各个节点的距离
    distanceList = adj(src,:);

    lastnodes=ones(1,length(distanceList));
    lastnodes=lastnodes * src;

    while length(S) < length(adj)
        % 在未确定的节点集合中确定离源点最近的点
        [minDistance, indexTemp] = min(distanceList(U));
        if minDistance == inf
            disp('Not Completed');
            break;
        end
        % [~,index] = find(distanceList == minDistance, 1);
        index = U(indexTemp);
        % 将最短的点加入集合S当中，S最短路径已经寻得
        S = [S, index];
        U(U == index) = [];
        lastPath = lastnodes(index);
        next(index,1) = lastPath;

        % 如果加入的节点是目的节点则退出
        if index == destination
            break;
        end

        for k = 1:1:length(U)
            if(minDistance + adj(index,U(k)) < distanceList(U(k)))
                distanceList(U(k)) = minDistance + adj(index, U(k));
                lastnodes(U(k)) = index;
            end
        end
    end

    ans = 0;
    while destination ~= src
        if next(destination) < 0
            disp('No way');
            break;
        end
        ans = adj(next(destination), destination) + ans;
        destination = next(destination);
    end

end