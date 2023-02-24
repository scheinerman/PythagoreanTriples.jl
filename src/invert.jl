export get_parameters

"""
    _is_perfect_square(n::Int)::Bool

Determine if the integer `n` is a perfect square. 
"""
function _is_perfect_square(n::Int)::Bool
    if n < 0
        return false 
    end
    s = isqrt(n)
    return n == s*s
end

"""
    get_parameters(P::PythagoreanTriple)
    get_parameters(a::Int, b::Int, c::Int)

Given a *primitive* Pythagorean triple `p`, find positive integers `u` and `v` such that 
`p == PythagoreanTriple(u,v)`.

In some cases this function will find parameters for non-primitive triples. 
"""
function get_parameters(P::PythagoreanTriple)::Tuple{Int,Int}
    a,b,c = abc = make_tuple(P)

    # if !is_primitive(P)
    #     error("$abc is not a primitive Pythagorean triple")
    # end

    if _is_perfect_square(a+c)
        a,b = b,a
    end


    if !_is_perfect_square(b+c)
        error("Unable to find parameters for $abc (non-primitive)")
    end

    # we know b+c is a perfect square so 
    # a = u^2-v^2
    # b = 2uv
    # c = u^2 + v^2
    # hence b+c = 2*u^2

    u = isqrt((a+c) ÷ 2)
    v = b ÷ (2u)

    if u > v
        u,v = v,u 
    end

    return u,v

end

get_parameters(a::Int, b::Int, c::Int) = get_parameters(PythagoreanTriple(a,b,c))
get_parameters(abc::NTuple{3,Int}) = get_parameters(abc...)