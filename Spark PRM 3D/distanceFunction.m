function distance = distanceFunction(input,data)

config = [1 0 0;0 1 0;1 0 0;0 1 0;1 0 0;0 1 0];

size = length(data(:,1));

inputQuat = zeros(6,4);
for i = 1:6
    inputQuat(i,:) = angle2quat( config(i,1)*input(1,i), config(i,2)*input(1,i), config(i,3)*input(1,i) );
end

dataQuat = zeros(6,4,size);
for i = 1:size
    for j = 1:6
        dataQuat(j,:,i) = angle2quat( config(j,1)*data(i,j), config(j,2)*data(i,j), config(j,3)*data(i,j) );
    end
end

distance = zeros (size,1);
for i = 1:size
    distance(i) = 0;
    for j = 1:6
        distance(i) = distance(i) +  1-abs(sum(inputQuat(j,:).*dataQuat(j,:,i)));
    end
end

end

