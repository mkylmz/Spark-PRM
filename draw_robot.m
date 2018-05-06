function [] = draw_robot(polygons)
clf;
figure(1);
hold on;
draw_polygon(polygons(:,:,1),'yellow');
    for i = 2:5
        draw_polygon(polygons(:,:,i),'red');
    end
draw_polygon(polygons(:,:,6),'blue');
axis equal;
axis([-100 100 -100 100 0 100]);
view(3);
grid;
end