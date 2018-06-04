function [realG,realTot_samp] = rrt3d(qstart,obs,realG,limit,realTot_samp,k_nstyle)

G = graph([],[]);

G = addnode(G,1);
G.Nodes.Q1 = qstart(1);
G.Nodes.Q2 = qstart(2);
G.Nodes.Q3 = qstart(3);
G.Nodes.Q4 = qstart(4);
G.Nodes.Q5 = qstart(5);
G.Nodes.Q6 = qstart(6);
tot_samp = 1;
try_samp = 0;

f = pi/9*4;
o = pi/3*2;

firstCC = 0;
firstNode = 0;
firstNeighbor = 0;
secondCC = 0;
secondNode = 0;
secondNeighbor = 0;

conn = conncomp(realG);
[array,size] = processCC3d(conn,realTot_samp);

while (try_samp < limit && (~firstCC || ~secondCC))
    rand_samp = (rand(1,6)-0.5).*[f o o o o o];
    if (k_nstyle == 0)
        index = closestNeighborBasic(G,tot_samp,rand_samp);
    elseif (k_nstyle == 1)
        index = knnsearch(table2array(G.Nodes),rand_samp,'NSMethod','exhaustive' );
    end
    neighbor = table2array(G.Nodes(index,:)); 
    vec = rand_samp-neighbor;
    new_samp = neighbor + vec./(norm(vec)*5);
    if (isConfOK_3D(new_samp,obs) && canConnect_3D(neighbor,new_samp,obs))
       tot_samp = tot_samp + 1;
       try_samp = try_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {new_samp(1) new_samp(2) new_samp(3) new_samp(4) new_samp(5) new_samp(6)};
       G = addedge(G,tot_samp,index);
       
       if (k_nstyle == 0)
           i = closestNeighborBasic(realG,realTot_samp,new_samp);
       elseif (k_nstyle == 1)
           i = knnsearch(table2array(realG.Nodes),new_samp,'NSMethod','exhaustive' );
       else
           i = knnsearch(table2array(realG.Nodes),new_samp,'NSMethod','kdtree' );
       end
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
if (firstCC && secondCC)
    [P,d] = shortestpath(G,firstNode,secondNode);
    d = d+1;
    [realG,realTot_samp] = connectTree(G,P,d,realG,realTot_samp);
    realG = addedge(realG,old_tot_samp+1,firstNeighbor);
    realG = addedge(realG,old_tot_samp+d,secondNeighbor);
end

end

function [realG,realTot_samp] = connectTree(G,P,d,realG,realTot_samp)
allNodes = table2array(G.Nodes);

realG = addnode(realG,1);
realTot_samp = realTot_samp + 1;
realG.Nodes(realTot_samp,:) = {allNodes(P(1),1) allNodes(P(1),2) allNodes(P(1),3) allNodes(P(1),4) allNodes(P(1),5) allNodes(P(1),6)};
for i = 2:d
    realG = addnode(realG,1);
    realTot_samp = realTot_samp + 1;
    realG.Nodes(realTot_samp,:) = {allNodes(P(i),1) allNodes(P(i),2) allNodes(P(i),3) allNodes(P(i),4) allNodes(P(i),5) allNodes(P(i),6)};
    realG = addedge(realG,realTot_samp-1,realTot_samp);
end
end


%if (length(table2array(G.Edges))>2)
%    draw_map([1 5],obs,G,tot_samp);
%    pause(0.1);
%end
