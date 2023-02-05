f(x) = 2x

# no fields
@callable struct MyStruct end
@test MyStruct{f}()(2) == 4
@test MyStruct(f)(2) == 4

# with other fields
@callable struct MyStructWithFields
    a::Real
    b
end
#
m = MyStructWithFields{f}(20, 30)
@test m(2) == 4
@test m.a == 20
@test m.b == 30
#
m = MyStructWithFields(f, 20, 30)
@test m(2) == 4
@test m.a == 20
@test m.b == 30
#
m = MyStructWithFields(20, 30, f=f)
@test m(2) == 4
@test m.a == 20
@test m.b == 30
