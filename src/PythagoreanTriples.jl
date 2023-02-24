module PythagoreanTriples

export PythagoreanTriple
export is_primitive, make_tuple, make_primitive

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

PythagoreanTriple(abc::NTuple{3,Int}) = PythagoreanTriple(abc...)
PythagoreanTriple(uv::NTuple{2,Int}) = PythagoreanTriple(uv...)

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
    return gcd(make_tuple(abc)...) == 1
end



"""
    make_primitive(t::PythagoreanTriple)::PythagoreanTriple

If `t` is the Pythagorean triple `(a,b,c)`. Return the Pythagorean triple
`(a/d, b/d, c/d)` where `d = gcd(a,b,c)`.
"""
function make_primitive(t::PythagoreanTriple)::PythagoreanTriple
    abc = make_tuple(t)
    d = gcd(abc...)
    xyz = abc .÷ d 
    return PythagoreanTriple(xyz...)
end


"""
    PT_check(a::Int, b::Int, c::Int)::Bool

Check that `a`, `b`, `c` form a valid Pythagorean triple. The three
integers should satisfy `0 < a < b < c` and `a^2+b^2 == c^2`.
"""
function PT_check(a::Int, b::Int, c::Int)::Bool
    return 0 < a < b < c && a * a + b * b == c * c
end


function Base.isless(t::PythagoreanTriple, s::PythagoreanTriple)::Bool
    abc = make_tuple(t)
    xyz = make_tuple(s)

    return isless(reverse(abc), reverse(xyz))
end

include("PT_gen.jl")
include("invert.jl")

end # module PythagoreanTriples
