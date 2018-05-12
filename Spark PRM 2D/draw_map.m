function [] = draw_map(qstart,obs,G,nSamples)

figure(1);
clf;

nObs = length(obs);
for i = 1:nObs
   patch(obs{i}(:,1),obs{i}(:,2),'black')
end

hold on;

plot(qstart(1),qstart(2),'marker','*')
allNodes = table2array(G.Nodes);
for j = 2:nSamples
    plot(allNodes(j,1),allNodes(j,2),'marker','o','color','green')
end
allEdges = table2array(G.Edges);
nEdges = length(allEdges);
for k = 1:nEdges
    p1 = allNodes(allEdges(k,1),:);
    p2 = allNodes(allEdges(k,2),:);
    plot([p1(1) p2(1)],[p1(2) p2(2)],'color','red')
end

hold off;

axis tight;
axis equal;
axis([0 10 0 10]);

end

