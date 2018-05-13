function result = isConfOK(q,obs)
nObs = length(obs);
result = 1;
for i = 1:nObs
   %if (inpolygon(q(1),q(2),obs{i}(:,1),obs{i}(:,2))) //slower
   if (isInside(q,obs{i}))
      result = 0;
      break;
   end
end
end

function result = isLeft(P0,P1,P2)
    result = ( (P1(1) - P0(1)) * (P2(2) - P0(2)) - (P2(1) - P0(1)) * (P1(2) - P0(2)) );
end

function result = isInside(point, obstacle)

nPoints = length(obstacle)-1;
result = 1;

for i = 1:nPoints
    if ( isLeft(obstacle(i,:),obstacle(i+1,:),point) < 0)
       result = 0;
       break;
    end
end

if (result)
    if (isLeft(obstacle(nPoints+1,:),obstacle(1,:),point) < 0)
        result = 0;
    end
end

end