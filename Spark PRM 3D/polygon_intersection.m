function res = polygon_intersection(poly1,poly2)

S1.XData = poly1(:,1);
S1.YData = poly1(:,2);
S1.ZData = poly1(:,3);

S2.XData = poly2(:,1);
S2.YData = poly2(:,2);
S2.ZData = poly2(:,3);

res = GJK(S1,S2,6);
end

