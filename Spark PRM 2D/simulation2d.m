function [] = simulation2d(qstart,obs,nSamples)

G = graph([],[]);

G = addnode(G,1);

G.Nodes.x = qstart(1);
G.Nodes.y = qstart(2);

[G,tot_samp] = spark_prm2d(obs,G,nSamples);

draw_map(qstart,obs,G,tot_samp);

end

