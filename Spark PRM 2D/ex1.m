function [] = ex1()

    qstart = [1 5];
    
    obs = [];
    
    obs{1} =    [2.50 10.00;
                 2.50  5.50;
                 4.25  5.50;
                 4.25 10.00;];
             
    obs{2} =    [4.25 10.00;
                 4.25  6.50;
                 5.75  6.50;
                 5.75 10.00;];
             
    obs{3} =    [5.75 10.00;
                 5.75  5.50;
                 7.50  5.50;
                 7.50 10.00;];
             
    obs{4} =    [4.75  0.00;
                 4.75  5.00;
                 2.50  5.00;
                 2.50  0.00;];
             
    obs{5} =    [5.25  0.00;
                 5.25  6.00;
                 4.75  6.00;
                 4.75  0.00;];
             
    obs{6} =    [7.50  0.00;
                 7.50  5.00;
                 5.25  5.00;
                 5.25  0.00;];

    simulation2d(qstart,obs,100,40,1);

end

