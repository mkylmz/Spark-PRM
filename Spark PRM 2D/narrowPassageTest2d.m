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
        rrt2d(table2array(G.Nodes(index,:)),obs,G,100);
        
    end
end

end

function [array, size] = processCC(conn,tot_samp)

    array = zeros(1);
    size = 1;
    for i = 1:tot_samp
        if ( conn(i) <= size)
           array(conn(i)) = array(conn(i)) + 1;
        else
           array = [array,0];
           size = size + 1;
           array(conn(i)) = array(conn(i)) + 1;
        end
    end
end