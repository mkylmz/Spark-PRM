function [G,tot_samp] = spark_prm3d(obs,G,noOfPRMsamples,noOfRRTsamples,k_nstyle)

tot_samp = 1;

f = pi/9*4;
o = pi/3*2;

while (tot_samp < noOfPRMsamples)
    rand_samp = (rand(1,6)-0.5).*[f o o o o o];
    if (isConfOK_3D(rand_samp,obs))
       tot_samp = tot_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {rand_samp(1) rand_samp(2) rand_samp(3) rand_samp(4) rand_samp(5) rand_samp(6)};
       G = addAllEdges(G,tot_samp,obs,k_nstyle);
       if (tot_samp > 10)
          [G,tot_samp] = narrowPassageTest3d(G,tot_samp,obs,noOfRRTsamples,k_nstyle);
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
        if ( canConnect_3D(q,allNodes(i,:),obs))
            G = addedge(G,tot_samp,i);
        end
    end
else
    neighbors = knnsearch( allNodes(1:tot_samp-1,:),q,'K',3,'NSMethod','exhaustive','Distance',@distanceFunction );    
    for i = 1:length(neighbors)
        if ( canConnect_3D(q,allNodes(neighbors(i),:),obs))
            G = addedge(G,tot_samp,neighbors(i));
            break;
        end
    end
end
result = G;
end


