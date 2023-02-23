using Test, PythagoreanTriples

@testset "Constructors" begin
    T = PythagoreanTriple(4, 3, 5)
    @test make_tuple(T) == (3, 4, 5)
    S = PythagoreanTriple((3, 4, 5))
    @test S == T

    T = PythagoreanTriple(2, 5)
    a, b, c = make_tuple(T)
    @test a * a + b * b == c * c
    S = PythagoreanTriple((5, 2))
    @test T == S
end

@testset "Iteration" begin
    nt = 5
    list = [t for t in TripleGenerator(nt)]
    @test length(list) == nt
    for T in list
        a, b, c = make_tuple(T)
        @test gcd(a, b) == 1
        @test a * a + b * b == c * c
    end
end

@testset "Primitive" begin
    t = PythagoreanTriple(3, 4, 5)
    @test is_primitive(t)
    t = PythagoreanTriple(30, 40, 50)
    @test !is_primitive(t)
    t = make_primitive(t)
    @test is_primitive(t)
end

@testset "Sort" begin
    nt = 10
    list = [t for t in TripleGenerator(nt)]
    list = sort(list)
    front = list[1:nt-1]
    back = list[2:nt]
    checks = front .< back
    @test all(checks)

end