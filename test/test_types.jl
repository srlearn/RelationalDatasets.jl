# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

module TestTypes

using RelationalDatasets
using Test

function test_initialize_relational_dataset()
    data = RelationalDatasets.RelationalDataset((
        ["cancer(alice)."],
        ["cancer(dan)."],
        ["friends(alice,bob)."]
    ))
    return data.pos[1], data.neg[1], data.facts[1]
end

@testset "RelationalDataset Type" begin
    @test test_initialize_relational_dataset() == (
        "cancer(alice).", "cancer(dan).", "friends(alice,bob)."
    )
end

end # module
