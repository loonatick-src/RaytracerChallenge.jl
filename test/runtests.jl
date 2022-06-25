using RaytracerChallenge
using Test
using LinearAlgebra: dot

@testset "RaytracerChallenge.jl" begin
    # Write your tests here.
    (x, y, z, w) = (4.3, -4.1, 3.1, 2.8)
    v = Vec3(x, y, z)
    p = Point(x, y, z)
    t = Vec4(x, y, z, w)

    @testset "Vec4 Basics" begin
        @test t[1] == x
        @test t[2] == y
        @test t[3] == z
        @test t[4] == w
        @test_throws BoundsError (t[5] == x)
    end

    @testset "Vec3 Basics" begin
        @test v[1] == x
        @test v[2] == y
        @test v[3] == z
        @test isVec(v)
    end

    @testset "Point basics" begin
        @test p[1] == x
        @test p[2] == y
        @test p[3] == z
        @test isPoint(p)
    end

    v₁ = Vec3(3, -2, 5)
    v₂ = Vec3(-2, 3, 1)
    p₁ = Point(-2, 3, 1)
    @testset "Vector arithmetic" begin
        @test v₁ + v₂ == Vec3(
                            v₁[1] + v₂[1],
                            v₁[2] + v₂[2],
                            v₁[3] + v₂[3])
        @test v₁ - v₂ == Vec3(
                            v₁[1] - v₂[1],
                            v₁[2] - v₂[2],
                            v₁[3] - v₂[3])
    end

    @testset "Vector-Point arithmetic" begin
        @test p₁ + v₁ == Point(
                            v₁[1] + p₁[1],
                            v₁[2] + p₁[2],
                            v₁[3] + p₁[3])
        
        @test p₁ - v₁ == Point(
                            p₁[1] - v₁[1],
                            p₁[2] - v₁[2],
                            p₁[3] - v₁[3])

        @test isPoint(p₁ - v₁)
        @test isPoint(p₁ + v₁)
    end

    @testset "Negation" begin
        @test 0.0 == -0.0
        @test -v == Vec3(-x, -y, -z)
        @test -v - Vec3(-x, -y, -z) == zero(v)
        @test zero(typeof(v)) - v == Vec3(-x, -y, -z)
    end

    approx_π = convert(Float64, π)
    @testset "scalar multiplication" begin
        @test 2v == Vec3(2x, 2y, 2z)
        @test v/2 == Vec3(x/2, y/2, z/2)
        @test v*2 == Vec3(2x, 2y, 2z)
        @test approx_π*v == Vec3(approx_π*x, approx_π*y, approx_π*z)
    end

    @testset "Vector magnitude" begin
        @test magnitude(v) == √(x*x + y*y + z*z)
        @test magnitude(Vec3(1.0,0.0,0.0)) == 1.0
        @test length_squared(v) == x*x + y*y + z*z
        @test length_squared(Vec3((1.0, 0.0, 0.0))) == 1.0
        @test magnitude(Vec3(1.0, 2.0, 3.0)) == √(14.0)
        @test magnitude(Vec3(-1.0, -2.0, -3.0)) == √(14.0)
    end

    @testset "Normalisation" begin
        v = Vec3(4.0, 0.0, 0.0)
        @test normalize(v) == Vec3(1.0, 0.0, 0.0)
        v = Vec3(1.0, 2.0, 3.0)
        l2norm = √(1.0^2 + 2.0^2 + 3.0^2)
        @test normalize(v) == Vec3(1/l2norm, 2/l2norm, 3/l2norm)
    end

    v₁ = Vec3(1, 2, 3)
    v₂ = Vec3(2, 3, 4)
    @testset "Dot product" begin
        @test dot(v₁, v₂) == 20
    end

    @testset "Cross Product" begin
        @test v₁ × v₂ == Vec3(-1, 2, -1)
        @test v₂ × v₁ == Vec3(1, -2, 1)
        @test v₁ × v₁ == Vec3(0, 0, 0)
    end

    m = Mat4(
        [
            1    2    3    4;
            5.5  6.5  7.5  8.5;
            9    10   11   12;
            13.5 14.5 15.5 16.5
        ]
    )
    @testset "Matrix basics" begin
        @test m[1,1] == 1
        
    end
end