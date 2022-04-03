%w5i.m (Edge Linking using McAndrew's custom m functions)
% You need edgelink.m, drawedgelist.m, cleanedgelist.m and 
% findendjunction.m files in the working folder
close all, clear all, clc
img = imread('machine.bmp'); figure(1),imshow(img), title('orignal image')
% find edges using Marr Hildreth detector
edgeim=edge(img,'log');
figure(2), imshow(edgeim); title('edge found by Marr Hildreth detector')

% Link edges with discarding broken lines with less than 20 pixels long.
[edgelist, labelededgeim] = edgelink(edgeim, 20);

%Draw the edges into figure 3 with colour [1 0 0]-Red. 
%Line width is "1" (this is a default value)
img_B=zeros(size(img)); 
figure(3), imshow(img_B), title('Linked edges')
% in the folllwing command, "1" represent the line width of the edges found
% (you can change it to "2" to see the difference). 
% [1 0 0] is the colour of edges found (red in this case)
% To change it to white, you can use [1 1 1]. 
% The last number "3" is the figure number to draw the edges. 
% In this case, we use figure 3
drawedgelist(edgelist, size(img), 1, [1 0 0], 3); axis off    

%you can find the number of edges identified using either size or length
%command - the number of edges (you can use either of the following two
%commands)
[exn, eyn]=size(edgelist)
edlen=length(edgelist)
%you can extract some of edges in the following way
%note that edgelist is a cell datatype. So you should use { } to
%extact an element in the cell
%To extarct edge line 1 to edge line20, we need to use for 
%k=1:20. For all edge lines to be displayed, use “for k=1:eyn”
for k=1:20
 c=edgelist{k}(:,1);
 r=edgelist{k}(:,2);
 cn=length(c);
 for i=1:cn
     img_B(c(i), r(i))=255;
 end
end
figure(4), imshow(img_B), 
title('number of edges are specified')