# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    Annulus(center, radius)

An annulus with `center`, an `inner_radius` and an `outer_radius`.

See also [`Annulus`](@ref).
"""
struct Annulus{Dim,T} <: Primitive{Dim,T}
  center::Point{Dim,T}
  inner_radius::T
  outer_radius::T
#   function Annulus{Dim,T}(center, inner_radius, outer_radius)
#     if inner_radius ≥ outer_radius
#         throw(DomainError((inner_radius, outer_radius), "Inner radius must be less than outer radius"))
#     end
#     new{Dim,T}(center, inner_radius, outer_radius)
#   end
end

Annulus(center::Tuple, inner_radius, outer_radius) = Annulus(Point(center), inner_radius, outer_radius)

paramdim(::Type{<:Annulus{Dim}}) where {Dim} = Dim

isconvex(::Type{<:Annulus}) = false

center(b::Annulus) = b.center
radius(b::Annulus) = b.outer_radius
inner_radius(b::Annulus) = b.inner_radius
outer_radius(b::Annulus) = b.outer_radius

inner_ball(b::Annulus) = Ball(b.center, b.inner_radius)
outer_ball(b::Annulus) = Ball(b.center, b.outer_radius)

function measure(b::Annulus{Dim}) where {Dim}
  measure(outer_ball(b)) - measure(inner_ball(b))
end

function Base.in(p::Point, b::Annulus)
  Base.in(p,inner_ball(b)) && !Base.in(p,outer_ball(b))
end

# union of two spheres?
# boundary(b::Annulus) = Sphere(b.center, b.radius)

function Base.show(io::IO, b::Annulus{Dim,T}) where {Dim,T}
  c, i_r, o_r = b.center, b.inner_radius, b.outer_radius
  print(io, "Annulus{$Dim,$T}($c, $i_r, $o_r))")
end
