function [] = narrowPassageTest2d(G,tot_samp,obs)
conn = conncomp(G);
[array,size] = processCC(conn,tot_samp);
for i = 1:size
    if ( array(i) <= 3 )
        index = 1;
        for j = 1:tot_samp
           if (conn(j) == i)
              index = j;
              break;
           end
        end
        G = rrt2d(table2array(G.Nodes(index,:)),obs,G,100,tot_samp);
        conn = conncomp(G);
        [array,size] = processCC(conn,tot_samp);
    end
end

end
