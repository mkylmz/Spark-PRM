function polygons = forwK(thetas)
config = [1 0 0;0 1 0;1 0 0;0 1 0;1 0 0;0 1 0];
polygons = zeros(8,3,2);
poly1 = [ 0,0,0; 5,0,0; 5,5,0; 0,5,0; 0,0,15; 5,0,15; 5,5,15; 0,5,15];
polygons(:,:,1) = mytf(poly1,config(1,:),thetas(1));
for i = 1:5
    center1 = (polygons(1,:,i)+polygons(2,:,i)+polygons(3,:,i)+polygons(4,:,i))/4;
    center2 = (polygons(5,:,i)+polygons(6,:,i)+polygons(7,:,i)+polygons(8,:,i))/4;
    polygons(:,:,i+1) = mytf(polygons(:,:,i)-center1,config(i+1,:),thetas(i+1))+center2;
end

end