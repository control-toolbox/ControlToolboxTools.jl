@callable struct MyStruct end
f(x) = 2*x
@test MyStruct(f)(2) == 4