function [F,J] = fadAdd(c,x,y,xDer,yDer)
% Derivative of additional operation for FAD:
%                       d(c*(x+y))/dt = c*(xDer+yDer)

F = c*(x+y);
J = c*(xDer + yDer);
end
