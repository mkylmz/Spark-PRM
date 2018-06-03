function result = isConfOK_3D(thetas,obs)

result = 1;
joints = forwK(thetas);

for i = 2:6
   if ( min(joints(:,3,i)) < 0)
       result = 0;
       return
   end
end

for i = 3:6
   if (polygon_intersection(joints(:,:,1),joints(:,:,i)))
       result = 0;
       return
   end
end
for i = 1:length(obs)
   if (polygon_intersection(joints(:,:,1),obs{i}))
       result = 0;
       return
   end
end
 
for j = 2:4
    for i = j+2:6
       if (polygon_intersection(joints(:,:,j),joints(:,:,i)))
           result = 0;
           return
       end
    end
    for i = 1:length(obs)
       if (polygon_intersection(joints(:,:,j),obs{i}))
           result = 0;
           return
       end
    end
end

for i = 1:length(obs)
   if (polygon_intersection(joints(:,:,5),obs{i}))
       result = 0;
       return
   end
end


for i = 1:length(obs)
   if (polygon_intersection(joints(:,:,6),obs{i}))
       result = 0;
       return
   end
end


end

