% w6p.m - Hole area/Equivalent Diameter
close all, clear all
f=imread('abcd.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('original Image'); 

[L,num]=bwlabel(fg);
%find the filled area, filled image, area and EquivDiameter
sB=regionprops(fg,'FilledImage','FilledArea','Area','EquivDiameter');

for k=1:num
 %find the orininal net area
 area_original(k)=sB(k).Area;
 %find the area with hole filles
 area_filled(k)=sB(k).FilledArea;
 %the whole area to hole area ratio 
 Ratio_Area_Hole(k)=area_original(k)/area_filled(k);
 Equi_Dia(k)=sB(k).EquivDiameter;
 figure(k+1),imshow(sB(k).FilledImage)
 title(['Area to hole are ratio: ' num2str(Ratio_Area_Hole(k)), ' Eqivalent Diameter: ', num2str(Equi_Dia(k))])
end
Ratio_Area_Hole
Equi_Dia