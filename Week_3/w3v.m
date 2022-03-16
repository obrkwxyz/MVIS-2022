%w3q.m: disp command 
close all, clear all
a=randi(10,1); %generate a random integer value between 1 to 10. 
if a<3,  disp('a is lower than 3.'), b=a*4;
else if a>=3 & a<6,  disp('a is higher than or equal to 3 and lower than 6.'), b=a^2;
    else  disp('a is higher than 6.'), b=10*a;
    end
end

fprintf('\n a is %i and b is %i\n', a,b);

