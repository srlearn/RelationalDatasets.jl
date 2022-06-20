# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

module TestConvert

using Test
using RelationalDatasets

@testset "Test converting propositional datasets" begin

    @test RelationalDatasets.from_vector(
        [0 1 1; 1 0 2; 2 2 0],
        [0, 0, 1],
    ) == (RelationalDatasets.RelationalDataset((
            pos=["v4(id3)."],
            neg=["v4(id1).", "v4(id2)."],
            facts=[
                "v1(id1,v1_0).",
                "v1(id2,v1_1).",
                "v1(id3,v1_2).",
                "v2(id1,v2_1).",
                "v2(id2,v2_0).",
                "v2(id3,v2_2).",
                "v3(id1,v3_1).",
                "v3(id2,v3_2).",
                "v3(id3,v3_0).",
            ])),
        [
            "v1(+id,#varv1).",
            "v2(+id,#varv2).",
            "v3(+id,#varv3).",
            "v4(+id).",
        ]
    )

    @test RelationalDatasets.from_vector(
        [0 1 1; 1 0 2; 2 2 0],
        [0.1, 0.2, 0.3],
    ) == (RelationalDatasets.RelationalDataset((
        pos=[
            "regressionExample(v4(id1),0.1).",
            "regressionExample(v4(id2),0.2).",
            "regressionExample(v4(id3),0.3).",
        ],
        neg=[],
        facts=[
            "v1(id1,v1_0).",
            "v1(id2,v1_1).",
            "v1(id3,v1_2).",
            "v2(id1,v2_1).",
            "v2(id2,v2_0).",
            "v2(id3,v2_2).",
            "v3(id1,v3_1).",
            "v3(id2,v3_2).",
            "v3(id3,v3_0).",
        ])),
        [
            "v1(+id,#varv1).",
            "v2(+id,#varv2).",
            "v3(+id,#varv3).",
            "v4(+id).",
        ]
    )

    @test RelationalDatasets.from_vector(
        [1 1; 0 1],
        [0, 1],
        ["a", "b", "c"],
    ) == (RelationalDatasets.RelationalDataset((
        pos=["c(id2)."],
        neg=["c(id1)."],
        facts=[
            "a(id1,a_1).",
            "a(id2,a_0).",
            "b(id1,b_1).",
            "b(id2,b_1).",
        ])),
        [
            "a(+id,#vara).",
            "b(+id,#varb).",
            "c(+id).",
        ]
    )

    @test RelationalDatasets.from_vector(
        [1 1; 0 1],
        [0.5, 1.0],
        ["a", "b", "c"],
    ) == (RelationalDatasets.RelationalDataset((
        pos=["regressionExample(c(id1),0.5).", "regressionExample(c(id2),1.0)."],
        neg=[],
        facts=[
            "a(id1,a_1).",
            "a(id2,a_0).",
            "b(id1,b_1).",
            "b(id2,b_1).",
        ])),
        [
            "a(+id,#vara).",
            "b(+id,#varb).",
            "c(+id).",
        ]
    )

    @test RelationalDatasets.from_vector(
        [0 1 1; 1 0 2; 2 2 0],
        [0, 1, 2],
    ) == (RelationalDatasets.RelationalDataset((
            pos=["v4(id1,v4_0).", "v4(id2,v4_1).", "v4(id3,v4_2)."],
            neg=[],
            facts=[
                "v1(id1,v1_0).",
                "v1(id2,v1_1).",
                "v1(id3,v1_2).",
                "v2(id1,v2_1).",
                "v2(id2,v2_0).",
                "v2(id3,v2_2).",
                "v3(id1,v3_1).",
                "v3(id2,v3_2).",
                "v3(id3,v3_0).",
            ])),
        [
            "v1(+id,#varv1).",
            "v2(+id,#varv2).",
            "v3(+id,#varv3).",
            "v4(+id,#classlabel).",
        ]
    )

end

@testset "Misaligned Classification and Regression" begin
    @test_throws AssertionError RelationalDatasets.from_vector([1 2], [1])
    @test_throws AssertionError RelationalDatasets.from_vector([1 2], [0.5])
end

@testset "Misaligned Custom Variable Names" begin
    @test_throws AssertionError RelationalDatasets.from_vector(
        [1 2],
        [1],
        ["a", "b", "c", "d"],
    )

    @test_throws AssertionError RelationalDatasets.from_vector(
        [1 2],
        [0.5],
        ["a", "b", "c", "d"]
    )
end

end # module
