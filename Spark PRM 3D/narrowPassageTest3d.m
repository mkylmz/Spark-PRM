function [G, tot_samp] = narrowPassageTest3d(G,tot_samp,obs,noOfRRTsamples,k_nstyle)
conn = conncomp(G);
[array,size] = processCC3d(conn,tot_samp);
index = 0;
for i = 1:size
    if ( array(i) <= 3 )
        for j = 1:tot_samp
           if (conn(j) == i)
              index = j;
              break;
           end
        end
        if (index)
            break;
        end
    end
end
if (index)
    qstart = table2array(G.Nodes(index,:));
    G = rmnode(G,index);
    tot_samp = tot_samp - 1;
    [G,tot_samp] = rrt3d(qstart,obs,G,noOfRRTsamples,tot_samp,k_nstyle);
end
end
