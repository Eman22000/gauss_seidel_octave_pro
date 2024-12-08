function gauss_seidel_gui()
    % Create the GUI window
    fig = figure('Name', 'Gauss-Seidel Solver', 'Position', [300, 300, 500, 400]);

    % Label and input for the number of equations
    uicontrol('Style', 'text', 'Position', [20, 350, 150, 20], 'String', 'Number of equations (n):');
    n_input = uicontrol('Style', 'edit', 'Position', [200, 350, 250, 20], 'String', '');

    % Label and input for the coefficient matrix A
    uicontrol('Style', 'text', 'Position', [20, 310, 150, 20], 'String', 'Coefficient matrix A:');
    A_input = uicontrol('Style', 'edit', 'Position', [200, 270, 250, 50], 'String', '');

    % Label and input for the constant vector b
    uicontrol('Style', 'text', 'Position', [20, 230, 150, 20], 'String', 'Constant vector b:');
    b_input = uicontrol('Style', 'edit', 'Position', [200, 210, 250, 20], 'String', '');

    % Label and input for tolerance
    uicontrol('Style', 'text', 'Position', [20, 190, 150, 20], 'String', 'Tolerance:');
    tol_input = uicontrol('Style', 'edit', 'Position', [200, 170, 250, 20], 'String', '1e-6');

    % Label and input for max iterations
    uicontrol('Style', 'text', 'Position', [20, 150, 150, 20], 'String', 'Max Iterations:');
    max_iter_input = uicontrol('Style', 'edit', 'Position', [200, 130, 250, 20], 'String', '100');

    % Solve button
    uicontrol('Style', 'pushbutton', 'Position', [200, 90, 100, 30], 'String', 'Solve', ...
              'Callback', @(src, event) solve_gauss_seidel());

    % Area to display results
    result_label = uicontrol('Style', 'text', 'Position', [20, 20, 450, 60], ...
                             'String', 'Solution will appear here.', 'HorizontalAlignment', 'left');

    % Callback function for solving the system
    function solve_gauss_seidel()
        % Read input values
        n = str2num(get(n_input, 'String'));
        A = str2num(get(A_input, 'String'));
        b = str2num(get(b_input, 'String'));
        tolerance = str2num(get(tol_input, 'String'));
        max_iterations = str2num(get(max_iter_input, 'String'));

        % Validate inputs
        if isempty(A) || isempty(b) || isempty(n) || isempty(tolerance) || isempty(max_iterations)
            set(result_label, 'String', 'Error: Please enter valid inputs.');
            return;
        end

        % Initialize variables
        x = zeros(n, 1); % Initial guess (zero vector)
        iterations = 0;
        convergence = false;

        % Start Gauss-Seidel iterations
        while ~convergence && iterations < max_iterations
            iterations = iterations + 1;
            x_old = x; % Save old values

            for i = 1:n
                sum1 = A(i, 1:i-1) * x(1:i-1); % Sum of lower triangular part
                sum2 = A(i, i+1:n) * x_old(i+1:n); % Sum of upper triangular part
                x(i) = (b(i) - sum1 - sum2) / A(i, i);
            end

            % Check convergence
            if norm(x - x_old, Inf) < tolerance
                convergence = true;
            end
        end

        % Display results
        if convergence
            result = sprintf('Converged in %d iterations.\nSolution: %s', iterations, mat2str(x, 4));
            set(result_label, 'String', result);
        else
            set(result_label, 'String', 'Did not converge within the maximum number of iterations.');
        end
    end
end

