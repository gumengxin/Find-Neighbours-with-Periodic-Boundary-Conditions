%Find8Neighbours: Find the nearest neighbours of a square 2D matrix element with
%PERIODIC BOUNDARY CONDITIONS 
% 
%
%Output parameters:
% neighbours: column vector with the indexes of the 8 neighbours
%
%
%Input parameters:
% deadR: row of the element whose neighbours will be discovered
% deadC: column of the element whose neighbours will be discovered
% n: dimensions of the square 2D matrix
%
%EXAMPLE:
% Neightbours of the element e = [2,2] of a 3x3 matrix:
%  1 1 1
%  1 e 1
%  1 1 1
% 
%  neighbours = Find8Neighbours(2,2,3)
% 
%  neighbours =
% 
%      1     2
%      3     2
%      2     1
%      2     3
%      1     3
%      1     1
%      3     3
%      3     1
% 
% Neightbours of the element e = [1,1] of a 4x4 matrix:
%  e 1 0 1
%  1 1 0 1
%  0 0 0 0
%  1 1 0 1
%
%  neighbours = Find8Neighbours(1,1,4)
% 
%  neighbours =
% 
%      4     1
%      2     1
%      1     4
%      1     2
%      4     2
%      4     4
%      2     2
%      2     4
%
%Version: 20180324
%Author: Violeta Calleja Solanas
%violeta.vics@gmail.comm
function neighbours = Find8Neighbours(deadR,deadC,n)

neighUp = [mod(deadR-2,n)+1, deadC];
neighDown = [mod(deadR,n)+1, deadC];
neighLeft = [deadR, mod(deadC - 2,n)+1];
neighRight = [deadR,  mod(deadC,n)+1];
neighUR = [mod(deadR-2,n)+1, mod(deadC,n)+1];
neighUL = [mod(deadR-2,n)+1, mod(deadC - 2,n)+1];
neighDR = [mod(deadR,n)+1,  mod(deadC,n)+1];
neighDL = [mod(deadR,n)+1,  mod(deadC - 2,n)+1];
neighbours = [neighUp; neighDown; ...
              neighLeft; neighRight; ...
              neighUR; neighUL; ...
              neighDR; neighDL];

end