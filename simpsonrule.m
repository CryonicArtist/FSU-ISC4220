function I1 = simpsons(f, n, a, b)
    if mod(n, 2) ~= 0
        error('n has to be even')
    end
   
x = linspace(a, b, n+1);
h = (b - a)/n;
I1 = f(x(1)) + f(x(n+1))
I1 = I1 + 4 * sum(f(x(2:2:end))) + 2 * sum(f(x(3:2:end)));
I1 = I1 * (h / 3);
end

n = 2;

while n < 64

n = n * 2
simpsons(@(x) cos(x), n, 0, pi/2)

end