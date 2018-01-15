% rng default
% n = 0:319;
% x = cos(pi/4*n)+randn(size(n));
% sprintf('%.10f\n', x)

load("x1.dat")

[pxx,w] = pwelch(x1);

plot(w/pi, 10*log10(pxx))
xlabel('\omega / \pi')

% sprintf('%.10f\n', x)
% sprintf('%.10f\n', pxx)
% sprintf('%.10f\n', w)
