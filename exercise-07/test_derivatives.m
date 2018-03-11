function [] = test_derivatives(N)
% Tests derivatives:
%   Inputs:
%       N - number of points

    param.N = N;          % number of discretization steps
    param.x0 = 0.6;       % init condition
    param.T  = 5;         % terminal time
    param.q  = 20;        % terminal weight
    h = param.T/param.N;  % interval length

    Utst = rand(param.N,1);  % random control trajectory

    % 1a) finite differences on nonlinear part 
    tic;
    [F1, J1] = finite_difference(@Phi, Utst, param);
    dt_FD = toc;

    % 1b) imaginary trick
    tic
    [F2, J2] = i_trick(@Phi, Utst, param);
    dt_IT = toc;

    % 1d) forward AD
    tic
    [F3, J3] = Phi_FAD(@Phi, Utst, param);
    dt_FAD = toc;

    % 1e) backward AD
    tic
    [F4, J4] = Phi_BAD(@Phi, Utst, param);
    dt_BAD = toc;

    % Check results
    disp('*** Cross Errors ***');
    disp(['Imaginary trick to FD:  ',...
          num2str(max(max(abs(J2-J1))))]);
    disp(['Imaginary trick to FAD: ',...
          num2str(max(max(abs(J2-J3))))]);
    disp(['Imaginary trick to BAD: ',...
          num2str(max(max(abs(J2-J4))))]);
    disp(' ');

    % Show timings:
    disp(['*** Runtime (N = ', num2str(param.N), ') ***']);
    disp(['Finite differences: ', num2str(dt_FD*1000) ,' ms']);
    disp(['Imaginary trick:    ', num2str(dt_IT*1000) ,' ms']);
    disp(['Forward AD:         ', num2str(dt_FAD*1000) ,' ms']);
    disp(['Backward AD:        ', num2str(dt_BAD*1000) ,' ms']);
    disp(' ');
end


