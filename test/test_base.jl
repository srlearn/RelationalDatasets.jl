# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

module TestBase

using Test
using RelationalDatasets
import Base.Filesystem: expanduser, joinpath

@testset "Base Functions" begin
    @test RelationalDatasets.get_data_home() == expanduser(joinpath("~", "relational_datasets"))
end

end # module
