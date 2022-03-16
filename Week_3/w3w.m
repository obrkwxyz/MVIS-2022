%w3s.m cell data type and fprintf
colours={'red', 'blue', 'green'};
red=[255,0,0];
green=[0,255,0];
blue=[0,0,255];
F=[red;green;blue]

for k=1:length(colours)
fprintf('%s colour: intensity of R is %d, intensity of G is %d and intensity of B is %d\n', ...
    colours{k}, F(k,1),F(k,2),F(k,3))
end