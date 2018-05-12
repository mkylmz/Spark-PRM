function result = rrt2d(qstart,obs,realG,limit)

G = graph([],[]);

G = addnode(G,1);
G.Nodes.x = qstart(1);
G.Nodes.y = qstart(2);
tot_samp = 1;
firstReached = 0;
secondReached = 0;

while (tot_samp < limit || (firstReached && secondReached))
    rand_samp = rand(1,2).*[10 10];
    index = closestNeighborBasic(G,tot_samp,rand_samp);
    neighbor = table2array(G.Nodes(index,:)); 
    vec = rand_samp-neighbor;
    new_samp = neighbor + vec./norm(vec)/2;
    if (isConfOK(new_samp,obs) && canConnect(neighbor,new_samp,obs))
       tot_samp = tot_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {new_samp(1) new_samp(2)};
       G = addedge(G,tot_samp,index);
       i = closestNeighborBasic(realG,tot_samp,new_samp);
       if( canConnect(new_samp,table2array(realG.Nodes(i,:)),obs) )
        
       end
    end
end

result = G;
end


%if (length(table2array(G.Edges))>2)
%    draw_map([1 5],obs,G,tot_samp);
%    pause(0.1);
%end
