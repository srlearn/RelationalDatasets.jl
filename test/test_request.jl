# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

module TestRequest

using Test
using RelationalDatasets


function load_webkb()
    train, test = RelationalDatasets.load("webkb", "v0.0.4", fold=2)
    return length(train.facts), length(test.facts)
end


@testset "Test Loading webkb-v0.0.4-fold2" begin
    @test load_webkb() == (1344, 568)
end

end # module
