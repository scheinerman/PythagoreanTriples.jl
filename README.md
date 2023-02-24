# `PythagoreanTriples`
 
A Pythagorean Triple is a list of three positive integers `(a,b,c)` 
with the property that `a^2 + b^2 == c^2`. That is, they are integers and the lengths
of the two legs and the hypotenuse of a right triangle.

In this module, a `PythagoreanTriple` is a container that holds three such integers
with the additional property that `a<b`. 

## Construction

### Three-parameter construction
A Pythagorean triple can be constructed simply by specifying the lengths of the legs
and hypotenuse of a right triangle

```
julia> using PythagoreanTriples

julia> T = PythagoreanTriple(4,3,5)
PythagoreanTriple(3, 4, 5)
```

If the three integers are not the side lengths of a right triangle, an error is thrown:
```
julia> T = PythagoreanTriple(4,5,6)
ERROR: (4, 5, 6) does not define a Pythagorean triple
```

In addition, the three side lengths can be given as a tuple:
```
julia> abc = (4,3,5)
(4, 3, 5)

julia> PythagoreanTriple(abc)
PythagoreanTriple(3, 4, 5)
```


### Two-parameter construction

Pythagorean triples can be created from a pair of integers `u,v` in which the 
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

Note: The function `is_primitive` is available to check if a Pythagorean triple
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

The function `make_primitive` takes a Pythagorean triple and returns a new
triple having divided the three numbers by their greatest common divisor.
```
julia> t = PythagoreanTriple(6,8,10)
PythagoreanTriple(6, 8, 10)

julia> make_primitive(t)
PythagoreanTriple(3, 4, 5)
```

### Scalar multiple

Pythagorean triples can be multiplied (on the left) by a positive integer.
For example:
```
julia> p = PythagoreanTriple(5,12)
PythagoreanTriple(119, 120, 169)

julia> 10p
PythagoreanTriple(1190, 1200, 1690)
```

### Finding parameters

All primitive Pythagorean triples (and some, but not all, non-primitive triples)
can be constructed using two parameters `p = PythagoreanTriple(u,v)`. 

Given such a triple, the function `get_parameters` will return a `u` and `v` that
creates that triple.
```
julia> p = PythagoreanTriple(5,12,13)
PythagoreanTriple(5, 12, 13)

julia> u,v = get_parameters(p)
(2, 3)

julia> PythagoreanTriple(u,v)
PythagoreanTriple(5, 12, 13)
```

While some non-primitive triples, such as `(6,8,10)`, can be created this way, others,
such as `(30,40,50)`, cannot:
```
julia> p = get_parameters(6,8,10)
(1, 3)

julia> get_parameters(30,40,50)
ERROR: Unable to find parameters for (30, 40, 50) (non-primitive)
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

