module PythagoreanTriples

export PythagoreanTriple, is_primitive, make_tuple

"""
    PythagoreanTriple

A Pythagorean triple, i.e., a list of three integers `(a,b,c)` 
with `0<a<b<c` and `a^2+b^2==c^2`.
"""
struct PythagoreanTriple
    a::Int
    b::Int
    c::Int
    function PythagoreanTriple(u::Int, v::Int)
        a = abs(u * u - v * v)
        b = abs(2 * u * v)
        c = abs(u * u + v * v)
        if a > b
            a, b = b, a
        end
        if !PT_check(a, b, c)
            error("$((u,v)) does not yield a PythagoreanTriple")
        end
        new(a, b, c)
    end

    function PythagoreanTriple(a::Int, b::Int, c::Int)
        aa = abs(a)
        bb = abs(b)
        cc = abs(c)
        if aa > bb
            aa, bb = bb, aa
        end
        if PT_check(aa, bb, cc)
            return new(aa, bb, cc)
        end
        error("$((a,b,c)) does not define a Pythagorean triple")
    end
end

"""
    make_tuple(abc::PythagoreanTriple)::NTuple{3,Int}

Return the three elements of a Pythgorean triple as a 3-tuple of integers.
"""
make_tuple(abc::PythagoreanTriple)::NTuple{3,Int} = (abc.a, abc.b, abc.c)

"""
    is_primitive(abc::PythagoreanTriple)::Bool

Check if the `PythagoreanTriple` is primitive, i.e. that `a`
and `b` are relatively prime
"""
function is_primitive(abc::PythagoreanTriple)::Bool
    return gcd(abc.a, abc.b) == 1
end



"""
    PT_check(a::Int, b::Int, c::Int)::Bool

Check that `a`, `b`, `c` form a valid Pythagorean triple. The three
integers should satisfy `0 < a < b < c` and `a^2+b^2 == c^2`.
"""
function PT_check(a::Int, b::Int, c::Int)::Bool
    return 0 < a < b < c && a * a + b * b == c * c
end


include("PT_gen.jl")

end # module PythagoreanTriples
