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