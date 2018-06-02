
obs = [];
    
obs{1} =    [50.00  50.00 0.00;
             50.00  60.00 0.00;
             60.00  60.00 0.00;
             60.00  50.00 0.00;
             50.00  50.00 15.00;
             50.00  60.00 15.00;
             60.00  60.00 15.00;
             60.00  50.00 15.00;];
         
G = graph([],[]);

G = addnode(G,1);
G.Nodes.Q1 = 0;
G.Nodes.Q2 = 0;
G.Nodes.Q3 = 0;
G.Nodes.Q4 = 0;
G.Nodes.Q5 = 0;
G.Nodes.Q6 = 0;

[G,tot_samp] = spark_prm3d(obs,G,5,0,0);
clf;
for i = 1:5
   draw_robot( forwK( table2array(G.Nodes(i,:)) ) ); 
end
