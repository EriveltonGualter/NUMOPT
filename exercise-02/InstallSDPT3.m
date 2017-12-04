clc;
close all;
clear variables;

actualPath = pwd();
cd('/Applications/MATLAB_R2017b.app/sdpt3/');
Installmex(1);
% startup;
% sqlpdemo;
cd(actualPath);
