H(t, x, p) = t + x^2+p^2
F(t, x) = t + x^2

H1 = ControlFunction{:nonautonomous}(H)
H2 = ControlFunction((x, p) -> H(0.0, x, p))

F1 = ControlFunction{:nonautonomous}(F)
F2 = ControlFunction(x -> F(0.0, x))

t = 1
x = 2
p = 3

@test H1(t, x, p) == 14
@test H2(t, x, p) == 13
@test F1(t, x) == 5
@test F2(t, x) == 4

@test_throws ErrorException ControlFunction{:ttt}(H)