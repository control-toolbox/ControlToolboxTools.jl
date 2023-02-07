#
t = 1
x = 2
p = 3

#
H(t, x, p) = t + x^2+p^2
@test_throws ErrorException ControlFunction{:ttt}(H)

H1 = ControlFunction{:nonautonomous}(H)
H2 = ControlFunction((x, p) -> H(0.0, x, p))
@test H1(t, x, p) == 14
@test H2(t, x, p) == 13

#
F(t, x) = t + x^2
F1 = ControlFunction{:nonautonomous}(F)
F2 = ControlFunction(x -> F(0.0, x))
@test F1(t, x) == 5
@test F2(t, x) == 4

# Hamiltonian
H1 = Hamiltonian{:nonautonomous}(H)
H2 = Hamiltonian((x, p) -> H(0.0, x, p))

@test H1(t, x, p) == 14
@test H2(t, x, p) == 13

whoami(h::Hamiltonian) = 1
whoami(v::VectorField) = 2

@test whoami(H1) == 1