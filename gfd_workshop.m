clear
%
% GFD Matlab workshop (date)
%{
Longer
description
on multible
lines
%}
%% Basics

a = 3;
b = 6;

c = 6\3;
%size(a)
%disp(a)
%% Other commands
A1 = [1, 4, 6, 7];
A2 = 1:6;
%Multiply el-by-el 
%A1.*A2 %will not work if A2 = 1:6, dimensions will not allign

%% For loop
%for  i = i1 : stride : i_end  %  initiate loop, and control
A = zeros(5,1);
for i = 1: 5
% operations with i
         i
A( i ) = i *0.1   
end              %end loop

%% python way
%x = 1:0.1:10
%for i = x;
%    i
%    y = i + 1
%end

%% 
% transpose example
%for i=imin:imax
%   for j=jmin:jmax
%for i=1:3
%   for j=1:3
%      A_trans( j, i ) = A( i, j )
%   end
%end

if  a == b  % logical operation
%do operation if logical true
    disp([ ' a equals b,  '  intstr(a)  '== ' intstr(b)  ])    
elseif  a == b  || a == c   % logical operation
else %do operations if logical false
end              %end if block

for k=1:2
    for i=10:-1:0; 
        disp(i)
        if  i == 5  ;   
            disp( 'exit loop '); 
            return;
        end
    end
end
 
for i=1:1:10; disp(i)
   pause( 1 )   % holds cycle for 1 second
end

