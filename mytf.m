function res = mytf(points,axis,theta)
res = zeros(8,3);
R = axang2rotm([axis theta]);
center = (points(1,:) + points(2,:) + points(3,:) + points(4,:))/4;
for i = 1:8
    res(i,:) = (points(i,:)-center)*R + center;
end
end