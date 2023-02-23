using Test, PythagoreanTriples

@testset "Constructors" begin
T = PythagoreanTriple(4,3,5)
@test make_tuple(T) == (3,4,5)

T = PythagoreanTriple(2,5)
a,b,c = make_tuple(T)
@test a*a + b*b == c*c
end

@testset "Iteration" begin 
    nt = 5
    list = [t for t in TripleGenerator(nt)]
    @test length(list) == nt 
    for T in list 
        a,b,c = make_tuple(T)
        @test gcd(a,b) == 1
        @test a*a + b*b == c*c 
    end
end

@testset "Is primitive?" begin
    t = PythagoreanTriple(3,4,5)
    @test is_primitive(t)
    t = PythagoreanTriple(30,40,50)
    @test !is_primitive(t)
end