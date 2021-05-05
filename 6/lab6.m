close all; clear; clc;
N = 500;
a = 15; mu = 0; sigma = 0.4;
m = @(x) atan(a*x);

X = -2 + (2+2)*rand(N, 1);
Z = normrnd(mu, sigma, N, 1);
range = -2:0.01:2;
I = @(x)(x > -1) .* (x < 1);
% Boxcar, Gaussian, Epanechnikov Kernel
K = {
    @(x)(x > -0.5) .* (x < 0.5);
    @(x) exp(-x .* x / 2) / sqrt(2 * pi);
    @(x) 3/4 * (1 - x.^2) .* I(x);
};

switch 6
    case 1
        zad1(Z)
    case 2
        Y = zad2(X,Z,m);
        figure
        plot(X, Y, '.');
        hold on;
        plot(range, m(a .* range));
        legend('T_N', 'Rzeczywiste m(x)', 'Location', 'northwest');
        xlabel('x');
        ylabel('m(x)');
    case 3
        Y = zad2(X,Z,m);
        % Rozne h
        h = 0.1;
        [m_est, x] = zad3(X,Y,N,I,h);
        hold on;
        plot(x, m_est);
        plot(range, m(a .* range));
        legend('Estymator m_N(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        xlabel('x');
        ylabel('m(x)');
        title(sprintf('h = %g', h))
    case 4 
        % Rozne param a
        zad4(X, Z, m, I, N, range, a, 'Jadro I');
        zad4(X, Z, m, K{1}, N, range, a, 'Jadro Boxcar');
        zad4(X, Z, m, K{2}, N, range, a, 'Jadro Gaussian');
        zad4(X, Z, m, K{3}, N, range, a, 'Jadro Epanechnikov');
    case 5
        X = -2 + (2+2)*rand(201, 1);
        Z = normrnd(mu, sigma, 201, 1);
        Y = zad2(X,Z,m);
        [valid_h, h_N, errorH] = zad5(m, I, Y, X);
        disp(valid_h)
        plot(h_N, errorH);
        xlabel('h_N')
        ylabel('Error(h_N)')
    case 6
        Y = zad2(X,Z,m);
        % rozne K i roznego a
        zad6(m, K{3}, X, N, Y)
        hold on;
        plot(range, m(a.*range));
        legend('Estymator m(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        xlabel('x');
        ylabel('m(x)');
    case 7
        Z = zad7(0, 0.01, N);
        zad1(Z)
        Y = zad2(X,Z,m);
        figure
        plot(X, Y, '.');
        hold on;
        range = -2:0.01:2;
        plot(range, m(a .* range));
        legend('T_N', 'Rzeczywiste m(x)', 'Location', 'northwest');
        xlabel('x');
        ylabel('m(x)');
        
        % rozne h
        h = 0.5;
        [m_est, x] = zad3(X,Y,N,I,h);
        figure
        hold on;
        plot(range, m(a .* range));
        plot(x, m_est);
        legend('Estymator m(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        title('h=0.5');
        xlabel('x');
        ylabel('m(x)');
        
        h = 0.7;
        [m_est, x] = zad3(X,Y,N,I,h);
        figure
        hold on;
        plot(range, m(a .* range));
        plot(x, m_est);
        legend('Estymator m(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        title('h=0.7');
        xlabel('x');
        ylabel('m(x)');
        
        h = 1;
        [m_est, x] = zad3(X,Y,N,I,h);
        figure
        hold on;
        plot(range, m(a .* range));
        plot(x, m_est);
        legend('Estymator m(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        title('h=1');
        xlabel('x');
        ylabel('m(x)');
        
        figure
        [valid_h, h_N, errorH] = zad5(m, I, Y, X);
        plot(h_N, errorH);
        xlabel('h_N')
        ylabel('Error(h_N)')
        
        figure
        % rozne K i roznego a
        zad6(m, I, X, N, Y)
        hold on;
        range = -2:0.01:2;
        plot(range, m(a.*range));
        legend('Estymator m(x)', 'Rzeczywiste m(x)', 'Location', 'northwest');
        xlabel('x');
        ylabel('m(x)');
end
