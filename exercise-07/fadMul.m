function [F,J] = fadMul(c,x,y,xDer,yDer)
% Derivative of additional operation for FAD:
%                       d(c*x*y)/dt = c*(x*yDer+y*xDer)

F = c*x*y;
J = c*(x*yDer + y*xDer);
end
