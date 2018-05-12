function result = stock_prm2d(obs,G,nSamples)

tot_samp = 1;

while (tot_samp < nSamples)
    rand_samp = rand(1,2).*[10 10];
    if (isConfOK(rand_samp,obs))
       tot_samp = tot_samp + 1;
       G = addnode(G,1);
       G.Nodes(tot_samp,:) = {rand_samp(1) rand_samp(2)};
       G = addAllEdges(G,tot_samp,obs);
    end
end

result=G;
end

function result = addAllEdges(G,tot_samp,obs)
allNodes = table2array(G.Nodes);
q = allNodes(tot_samp,:);
no = tot_samp-1;
for i = 1:no
    if ( sqrt( (q(1)-allNodes(i,1))^2+(q(2)-allNodes(i,2))^2 ) < 2 && canConnect(q,allNodes(i,:),obs))
        G = addedge(G,tot_samp,i);
    end
end
result = G;
end

function result = canConnect(q1,q2,obs)

result = 1;
start = q1;
vec = q2-q1;
trialNo = norm(vec)*10;
vec = vec./trialNo;
i=1;
while (i<trialNo)
    start = start + vec;
    if (~isConfOK(start,obs))
        result = 0;
    end
    i = i+1;
end

end


