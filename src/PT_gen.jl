
export TripleGenerator

"""
    TripleGenerator
Create an iterator that produces primitive Pythagorean triples.
* `TripleGenerator(n)` will produce `n` triples.
* `TripleGenetor()` will produce an unending list of triples.
"""
struct TripleGenerator
    count::Int
    function TripleGenerator(amount::Int = -1)
        new(amount)
    end
end

# State is (u,v,n) with 0<u<v and n is the number of triple produced

function Base.iterate(TG::TripleGenerator)
    if TG.count == 0
        return nothing
    end
    return PythagoreanTriple(1, 2), (1, 2, 1)
end

function Base.iterate(TG::TripleGenerator, state::Tuple{Int,Int,Int})
    u, v, n = state

    if TG.count >= 0 && n >= TG.count
        return nothing
    end

    u += 1
    if u == v
        return Base.iterate(TG, (0, v + 1, n))
    end

    triple = PythagoreanTriple(u,v)
    
    if gcd(triple.a, triple.b) > 1 
        return Base.iterate(TG, (u, v, n))     
    end

    return triple, (u, v, n+1)

end

Base.length(TG::TripleGenerator) = TG.count