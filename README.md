# `PythagoreanTriples`
 
A Pythagorean Triple is a list of three positive integers `(a,b,c)` 
with the property that `a^2 + b^2 == c^2`. That is, they are integers and the lengths
of the two legs and the hypotenuse of a right triangle.

In this module, a `PythagoreanTriple` is a container that holds three such integers
with the additional property that `a<b`. 

## Construction

A Pythagorean triple can be constructed simply by specifying the lengths of the legs
and hypotenuse of a right triangle

```
julia> using PythagoreanTriples

julia> T = PythagoreanTriple(4,3,5)
PythagoreanTriple(3, 4, 5)
```

If the three arguments are invalid, an error is thrown:
```
julia> T = PythagoreanTriple(4,5,6)
ERROR: (4, 5, 6) does not define a Pythagorean triple
```



Every Pythagorean triple can be created from a pair of integers `u,v` in which the 
legs of the right triangle are `abs(u^2 - v^2)` and `abs(2*u*v)`, and the hypotenuse is
`u^2 + v^2`. 

A user can give the values `u` and `v` to create a Pythagorean triple:
```
julia> T = PythagoreanTriple(2,5)
PythagoreanTriple(20, 21, 29)
```

Note that the integers `u` and `v` must be distinct and nonzero:
```
julia> PythagoreanTriple(0,5)
ERROR: (0, 5) does not yield a PythagoreanTriple

julia> PythagoreanTriple(2,2)
ERROR: (2, 2) does not yield a PythagoreanTriple
```

## Generation

We call a Pythagorean triple `(a,b,c)` *primitive* provided `gcd(a,b) == 1`. 
Thus `(3,4,5)` is primitive but `(6,8,10)` is not. 

Use `TripleGenerator` to create an iterator for primitive Pythagorean triples. The
iterator `TripleGenerator(n)` will create `n` primitive triples:
```
julia> for t in TripleGenerator(5)
       println(t)
       end
PythagoreanTriple(3, 4, 5)
PythagoreanTriple(5, 12, 13)
PythagoreanTriple(8, 15, 17)
PythagoreanTriple(7, 24, 25)
PythagoreanTriple(20, 21, 29)
```

If `n` is omitted (or negative) the iterator will produce values endlessly.
For example:
```
julia> for t in TripleGenerator()
           a,b,c = make_tuple(t)
           if a > 1000
               println(t)
               break
           end
       end
PythagoreanTriple(1007, 1224, 1585)
```

Note: The function `is_primitive` is available to see if a Pythagorean triple
is primitive:
```
julia> t = PythagoreanTriple(3,4,5)
PythagoreanTriple(3, 4, 5)

julia> is_primitive(t)
true

julia> t = PythagoreanTriple(30,40,50)
PythagoreanTriple(30, 40, 50)

julia> is_primitive(t)
false
```


## Extracting values

The function `make_tuple` returns a 3-tuple containing the three values:
```
julia> t = PythagoreanTriple(5,11)
PythagoreanTriple(96, 110, 146)

julia> make_tuple(t)
(96, 110, 146)
```

## Sorting

Pythagorean triples can be compared using the usual `<`, `<=`, `>`, `>=` relations. 
Lists of triples can be sorted. They are sorted "reverse lexicographically". That is 
when we check if `(a,b,c)` is less than or equal to `(aa,bb,cc)` we first see if `c ≤ cc`.
If so, then if `b ≤ bb`. And if so, then if `a ≤ aa`. 

```
julia> list = [t for t in TripleGenerator(10)]
10-element Vector{PythagoreanTriple}:
 PythagoreanTriple(3, 4, 5)
 PythagoreanTriple(5, 12, 13)
 PythagoreanTriple(8, 15, 17)
 PythagoreanTriple(7, 24, 25)
 PythagoreanTriple(20, 21, 29)
 PythagoreanTriple(9, 40, 41)
 PythagoreanTriple(12, 35, 37)
 PythagoreanTriple(11, 60, 61)
 PythagoreanTriple(28, 45, 53)
 PythagoreanTriple(33, 56, 65)

julia> sort(list)
10-element Vector{PythagoreanTriple}:
 PythagoreanTriple(3, 4, 5)
 PythagoreanTriple(5, 12, 13)
 PythagoreanTriple(8, 15, 17)
 PythagoreanTriple(7, 24, 25)
 PythagoreanTriple(20, 21, 29)
 PythagoreanTriple(12, 35, 37)
 PythagoreanTriple(9, 40, 41)
 PythagoreanTriple(28, 45, 53)
 PythagoreanTriple(11, 60, 61)
 PythagoreanTriple(33, 56, 65)
 ```

Pythagorean triples can be compared
## To do

* It may be useful to create a function that takes a Pythagorean triple 
and returns  integers `u` and `v` that would generate it. 