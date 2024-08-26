# Extras for `PythagoreanTriples`

## Rational Pythagorean Triples

The `PythagoreanTriple` type only allows integer values. The file `rpt.jl` 
in the `extras` folder contains code to create an `RPT` type (which stands 
for *Rational Pythagorean Triple*). 

An `RPT` can be created as follows:
* If `p` is a `PythagoreanTriple` (or another `RPT`), then `RPT(p,factor=1)` creates a copy of `p`  in which the three values are scaled by `p`. This can also be accomplished  as `factor*p` if `p` is an `RPT`.
* Given three rational numbers (or integers), `RPT(x,y,z)` creates an `RPT`  with those three values. 

```
julia> include("extras/RPT.jl");

julia> p = PythagoreanTriple(3,4,5)
PythagoreanTriple(3, 4, 5)

julia> pp = RPT(p,1//2)
RPT(3//2, 2//1, 5//2)

julia> 10pp
RPT(15//1, 20//1, 25//1)

julia> make_tuple(pp)
(3//2, 2//1, 5//2)

julia> RPT(5//2, 6, 13//2)
RPT(5//2, 6//1, 13//2)

julia> RPT(6//1, 10//3, 12//5)
ERROR: (6//1, 10//3, 12//5) is not Pythagorean
```
