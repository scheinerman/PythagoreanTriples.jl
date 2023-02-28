using PythagoreanTriples
"""
    RPT

Rational Pythagorean Triple. Construction:
* `RPT(x,y,z)` where `x,y,z`` are rational numbers or integers
* `RPT(p, factor)` where p is a `PythagoreanTriple` or an `RPT` and `factor` is a rational number or an integer.
"""
struct RPT
    a::Rational{Int}
    b::Rational{Int}
    c::Rational{Int}
    function RPT(p::PythagoreanTriple, factor = 1)
        abc =  (factor//1) .* make_tuple(p)
        new(abc...)
    end

    function RPT(x,y,z)
        if x*x + y*y != z*z 
            error("$((x,y,z)) is not Pythagorean")
        end
        if x==0 || y==0
            error("Entries must be nonzero")
        end
        x = abs(x)
        y = abs(y)
        if x>y
            x,y = y,x
        end
        z = abs(z)
        new(x,y,z)
    end
end

PythagoreanTriples.make_tuple(p::RPT) = (p.a, p.b, p.c)

function RPT(p::RPT, factor = 1)::RPT 
    abc = make_tuple(p)
    RPT((abc .* (factor//1))...)
end


import Base: *
(*)(factor, p::RPT) = RPT(p,factor)
    

