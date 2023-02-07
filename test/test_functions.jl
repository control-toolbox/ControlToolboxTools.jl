#
t = 1
x = 2
p = 3
u = 4

#
H(t, x, p) = t + x^2+p^2
@test_throws ErrorException Hamiltonian{:ttt}(H) # :autonomous or :nonautonomous

# HamiltonianVectorField: the name is not important since here we have Hamiltonians
H1 = HamiltonianVectorField{:nonautonomous}(H)
H2 = HamiltonianVectorField((x, p) -> H(0.0, x, p))
@test H1(t, x, p) == 14
@test H2(t, x, p) == 13

# Hamiltonian
H1 = Hamiltonian{:nonautonomous}(H)
H2 = Hamiltonian((x, p) -> H(0.0, x, p))
@test H1(t, x, p) == 14
@test H2(t, x, p) == 13

# VectorField
F(t, x) = t + x^2
F1 = VectorField{:nonautonomous}(F)
F2 = VectorField(x -> F(0.0, x))
@test F1(t, x) == 5
@test F2(t, x) == 4

#
whoami(h::Hamiltonian) = 1
whoami(v::VectorField) = 2

@test whoami(F1) == 2

# LagrangeControlFunction
L(t, x, u) = t+x+u
L1 = LagrangeControlFunction{:nonautonomous}(L)
L2 = LagrangeControlFunction((x, u) -> L(0.0, x, u))
@test L1(t, x, u) == 7
@test L2(t, x, u) == 6

# DynamicsControlFunction
f(t, x, u) = t+x+u
F1 = DynamicsControlFunction{:nonautonomous}(f)
F2 = DynamicsControlFunction((x, u) -> f(0.0, x, u))
@test F1(t, x, u) == 7
@test F2(t, x, u) == 6