function out=normalize(c)
%
% NORMALIZE returns the vector which is the least integer of all cyclic
% shifts of V.
%
m=c;
lc=length(c);
for i=2:lc,m=[m;[m(i-1,lc),m(i-1,1:lc-1)]];end
ms=sortrows(m);
out=ms(1,:);
