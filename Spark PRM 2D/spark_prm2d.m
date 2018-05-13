function [G,tot_samp] = spark_prm2d(obs,G,noOfPRMsamples,noOfRRTsamples,k_nstyle)

tot_samp = 1;

while (tot_samp < noOfPRMsamples)
    rand_samp = rand(1,2).*[10 10];
    if (isConfOK(rand_samp,obs))
       tot_samp = tot_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {rand_samp(1) rand_samp(2)};
       G = addAllEdges(G,tot_samp,obs,k_nstyle);
       if (tot_samp > 50)
          [G,tot_samp] = narrowPassageTest2d(G,tot_samp,obs,noOfRRTsamples,k_nstyle);
       end
    end
end

end

function result = addAllEdges(G,tot_samp,obs,k_nstyle)
allNodes = table2array(G.Nodes);
q = allNodes(tot_samp,:);
if (k_nstyle == 0) %my basic closest neighbor
    no = tot_samp-1;
    for i = 1:no
        if ( norm(q-allNodes(i,:)) < 2 && canConnect(q,allNodes(i,:),obs))
            G = addedge(G,tot_samp,i);
        end
    end
else
    if (k_nstyle == 1) %exhaustive 
        neighbors = knnsearch( allNodes(1:tot_samp-1,:),q,'K',3,'NSMethod','exhaustive' );
    elseif (k_nstyle == 2) %kdtree
        neighbors = knnsearch( allNodes(1:tot_samp-1,:),q,'K',3,'NSMethod','kdtree' );
    end
    for i = 1:length(neighbors)
        if ( norm(q-allNodes(neighbors(i),:)) < 2 && canConnect(q,allNodes(neighbors(i),:),obs))
            G = addedge(G,tot_samp,neighbors(i));
        end
    end
end
result = G;
end


