function [realG,realTot_samp] = rrt2d(qstart,obs,realG,limit,realTot_samp)

G = graph([],[]);

G = addnode(G,1);
G.Nodes.x = qstart(1);
G.Nodes.y = qstart(2);
tot_samp = 1;
try_samp = 0;
firstCC = 0;
firstNode = 0;
firstNeighbor = 0;
secondCC = 0;
secondNode = 0;
secondNeighbor = 0;

conn = conncomp(realG);
[array,size] = processCC(conn,realTot_samp);

while (try_samp < limit && (~firstCC || ~secondCC))
    rand_samp = rand(1,2).*[10 10];
    index = closestNeighborBasic(G,tot_samp,rand_samp);
    neighbor = table2array(G.Nodes(index,:)); 
    vec = rand_samp-neighbor;
    new_samp = neighbor + vec./norm(vec)/2;
    if (isConfOK(new_samp,obs) && canConnect(neighbor,new_samp,obs))
       tot_samp = tot_samp + 1;
       try_samp = try_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {new_samp(1) new_samp(2)};
       G = addedge(G,tot_samp,index);
       
       i = closestNeighborBasic(realG,realTot_samp,new_samp);
       if ( canConnect(new_samp,table2array(realG.Nodes(i,:)),obs) )
            if (~firstCC && array(conn(i))> 3 )
                firstCC = conn(i);
                firstNode = tot_samp;
                firstNeighbor = i;
            elseif (~secondCC && array(conn(i))> 3 && conn(i)~=firstCC )
                secondCC = conn(i);
                secondNode = tot_samp;
                secondNeighbor = i;
            elseif (conn(i)==firstCC)
                G = rmedge(G,tot_samp,index);
                G = rmnode(G,tot_samp);
                tot_samp = tot_samp-1;
            end
       end
    end
end
old_tot_samp = realTot_samp;
[realG,realTot_samp] = connectTree(G,tot_samp,realG,realTot_samp);
if (firstCC)
    realG = addedge(realG,old_tot_samp+firstNode,firstNeighbor);
end
if (secondCC)
    realG = addedge(realG,old_tot_samp+secondNode,secondNeighbor);
end
end

function [realG,realTot_samp] = connectTree(G,tot_samp,realG,realTot_samp)
allNodes = table2array(G.Nodes);
allEdges = table2array(G.Edges);
for i = 1:tot_samp
    realG = addnode(realG,1);
    realG.Nodes(realTot_samp+i,:) = {allNodes(i,1) allNodes(i,2)};
end
len = tot_samp-1;
for i = 1:len
    a = allEdges(i,1);
    b = allEdges(i,2);
    realG = addedge(realG,a+realTot_samp,b+realTot_samp);
end
realTot_samp = realTot_samp + tot_samp;
end


%if (length(table2array(G.Edges))>2)
%    draw_map([1 5],obs,G,tot_samp);
%    pause(0.1);
%end
