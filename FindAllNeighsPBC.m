%FindAllNeighsPBC: Find all the neighbours of a square 2D matrix element with
%PERIODIC BOUNDARY CONDITIONS
%
%Output parameters:
% allNeighs: column vector with the indexes of all the neighbours upon a
%            certain radio
%
%Input parameters:
% deadR: row of the element whose neighbours will be discovered
% deadC: column of the element whose neighbours will be discovered
% n: dimensions of the square 2D matrix
% radio: maximun distance of neighbours to the element (e)
%
%Neighbours pf e = [4,4] in a 7x7 matrix with ratio = 3, 2 and 1:
%
% 3 3 3 3 3 3 3
% 3 2 2 2 2 2 3
% 3 2 1 1 1 2 3
% 3 2 1 e 1 2 3
% 3 2 1 1 1 2 3
% 3 2 2 2 2 2 3
% 3 3 3 3 3 3 3
% 
%Neigbours of e = [2,2] in a 5x5 matrix with radio = 1 and 2:
% 
% 1 1 1 2 2
% 1 e 1 2 2
% 1 1 1 2 2
% 2 2 2 2 2
% 2 2 2 2 2
% 
% EXAMPLE: Neigbours of e = [2,2] in a 5x5 matrix with radio = 1
%    allNeighs = FindAllNeighsPBC(2,2,5,1)
%   
%     allNeighs =
% 
%       1     1
%       1     2
%       1     3
%       2     1
%       2     2
%       2     3
%       3     1
%       3     2
%
%Version: 20180324
%Author: Violeta Calleja Solanas
%violeta.vics@gmail.comm
function allNeighs = FindAllNeighsPBC(deadR,deadC,n,radio)

if radio >= floor((n-1)/2)  % radio causes overlapping -> neighbours = all indixes minus [deadR,deadC] 
    all = repmat(1:n,1,2);
    C = nchoosek(all,2);
    allNeighs = unique(C,'rows');                                
    delete =  allNeighs(:,1) == deadR & allNeighs(:,2) == deadC; 
    allNeighs = allNeighs.*~sort(delete);                        
    allNeighs = allNeighs(1:end-1,:);
else
    %% Determinate neighbours' columns
    leftMost = mod(deadC - radio -1,n) +1;    % Column of the left-most neighbour
    columns = 1:n;                             % This vector will save all column indexes
    columns = circshift(columns,n+1-leftMost); % Taking account of periodic boundary conditions
    columns(2*radio + 2:end) = [];             % Save memory and delete superfluous indexes
    
    %% Determinate neighbours' rows
    top = mod(deadR-2,n) + 2 - radio;
    rows = 1:n;
    rows = circshift(rows,n+1-top);
    rows(2*radio + 2:end) = [];
    
    %% Pair of indixes
    aux = zeros(n);
    aux(rows,columns) = 1;
    aux(deadR,deadC) = 0;
    [y, x] = find(aux);
    allNeighs = [y x];
    

end