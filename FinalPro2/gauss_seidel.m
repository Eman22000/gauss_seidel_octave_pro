function gauss_seidel()
    % Prompt user for input
    n = input('Enter the number of equations (n): ');
    A = input('Enter the coefficient matrix A (n x n): ');
    b = input('Enter the constant vector b (n x 1): ');
    tolerance = input('Enter the tolerance value: ');
    max_iterations = input('Enter the maximum number of iterations: ');

    % Initialize variables
    x = zeros(n, 1); % Initial guess (zero vector)
    iterations = 0;
    convergence = false;

    fprintf('\nIterating using Gauss-Seidel Method...\n');
    fprintf('Iteration\tSolution Vector\n');

    % Start iterations
    while ~convergence && iterations < max_iterations
        iterations = iterations + 1;
        x_old = x; % Save old values

        for i = 1:n
            % Calculate the new value for x(i)
            sum1 = A(i, 1:i-1) * x(1:i-1); % Sum of lower triangular part
            sum2 = A(i, i+1:n) * x_old(i+1:n); % Sum of upper triangular part
            x(i) = (b(i) - sum1 - sum2) / A(i, i);
        end

        % Print current solution
        fprintf('%d\t\t', iterations);
        fprintf('%.4f ', x);
        fprintf('\n');

        % Check convergence
        if norm(x - x_old, Inf) < tolerance
            convergence = true;
        end
    end

    % Display results
    if convergence
        fprintf('\nConverged to solution in %d iterations.\n', iterations);
        fprintf('Solution: \n');
        disp(x);
    else
        fprintf('\nDid not converge within the maximum number of iterations.\n');
    end
end

