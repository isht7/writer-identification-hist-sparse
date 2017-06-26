function [writer_Nox] = findWriter(k,W5_8index)

tempx = 1;
for i = 1 : length(W5_8index)
tempx=tempx+W5_8index(i);
if tempx > k
   writer_Nox = i;
return 
end
end

end