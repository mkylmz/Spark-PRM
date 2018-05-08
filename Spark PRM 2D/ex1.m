function [] = ex1()

    qstart = [1 5];
    
    obs = [];
    
    obs{1} =    [3 5;
                 5 7;
                 7 5;
                 5 3;];

    simulation2d(qstart,obs,100);

end

