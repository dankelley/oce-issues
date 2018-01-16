% rng default
% n = 0:319;
% x = cos(pi/4*n)+randn(size(n));
% sprintf('%.10f\n', x)

load("x1.dat")

[pxx1,w1] = pwelch(x1);

plot(w1/pi, 10*log10(pxx1))
xlabel('\omega / \pi')

% sprintf('%.10f\n', x1)
% sprintf('%.10f\n', pxx1)
% sprintf('%.10f\n', w1)
