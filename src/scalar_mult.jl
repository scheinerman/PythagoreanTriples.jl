import Base.*

function (*)(n::Int, p::PythagoreanTriple)::PythagoreanTriple
    if n <= 0
        error("Scalar multiple of a Pythagorean triple must be positive")
    end

    a, b, c = make_tuple(p)

    return PythagoreanTriple(n * a, n * b, n * c)
end
