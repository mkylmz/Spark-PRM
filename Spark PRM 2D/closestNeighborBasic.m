function index = closestNeighborBasic(G,tot_samp,x)
allNodes = table2array(G.Nodes);
index = 1;
min_dist = norm(allNodes(1,:)-x);
for i = 1:tot_samp
    dist = norm(allNodes(i,:)-x);
    if ( min_dist>dist )
        min_dist = dist;
        index = i;
    end 
end

end