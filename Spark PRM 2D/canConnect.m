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