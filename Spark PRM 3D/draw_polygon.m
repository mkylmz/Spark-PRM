function [] = draw_polygon(points,color)
figure(1);
hold on;
p1 = points(1,:);
p2 = points(2,:);
p3 = points(3,:);
p4 = points(4,:);
p5 = points(5,:);
p6 = points(6,:);
p7 = points(7,:);
p8 = points(8,:);

s1 = [p1;p2;p3;p4]';
s2 = [p5;p6;p7;p8]';
s3 = [p1;p2;p6;p5]';
s4 = [p2;p3;p7;p6]';
s5 = [p3;p4;p8;p7]';
s6 = [p4;p1;p5;p8]';

fill3(s1(1,:),s1(2,:),s1(3,:),color);
fill3(s2(1,:),s2(2,:),s2(3,:),color);
fill3(s3(1,:),s3(2,:),s3(3,:),color);
fill3(s4(1,:),s4(2,:),s4(3,:),color);
fill3(s5(1,:),s5(2,:),s5(3,:),color);
fill3(s6(1,:),s6(2,:),s6(3,:),color);

end