function [] = simulation3d(qstart,obs,noOfPRMsamples,noOfRRTsamples,k_nstyle)

G = graph([],[]);

G = addnode(G,1);
G.Nodes.Q1 = qstart(1);
G.Nodes.Q2 = qstart(2);
G.Nodes.Q3 = qstart(3);
G.Nodes.Q4 = qstart(4);
G.Nodes.Q5 = qstart(5);
G.Nodes.Q6 = qstart(6);

[G,tot_samp] = spark_prm3d(obs,G,noOfPRMsamples,noOfRRTsamples,k_nstyle);
%G,tot_samp] = rrt3d(qstart,obs,noOfPRMsamples,k_nstyle);


clf;
allEdges = table2array(G.Edges);
allNodes = table2array(G.Nodes);
for i = 1:length(obs)
   draw_polygon(obs{i},'cyan'); 
end
for i = 1:length(allEdges)
    q1 = forwK( allNodes( allEdges(i,1),: )  );
    q2 = forwK( allNodes( allEdges(i,2),: )  );
    center1 = (q1(5,:,6)+q1(6,:,6)+q1(7,:,6)+q1(8,:,6))/4;
    center2 = (q2(5,:,6)+q2(6,:,6)+q2(7,:,6)+q2(8,:,6))/4;
    figure(1);
    hold on;
    plot3([center1(1) center2(1)],[center1(2) center2(2)],[center1(3) center2(3)]);
    axis equal;
end
for i = 1:tot_samp
   draw_robot( forwK( table2array(G.Nodes(i,:)) ) ); 
end



end

