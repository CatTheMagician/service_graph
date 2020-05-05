defmodule ServiceGraph.UseCases.RelationBulkUpdateTest do
  use ServiceGraph.DataCase

  alias ServiceGraph.UseCases.RelationBulkUpdate

  test "#сall - deletes old data and inserts new" do
    data = [
      "// SG_tag: uses Amazon::S3#store_document",
      "// SG_tag: uses Amazon::S3#read_document",
      "#  SG_tag: uses BarService#get_user_data",
      "#  SG_tag: implements get_user_profile"
    ]

    assert [
             %ServiceGraph.Consumes.Consume{
               service: _
             },
             %ServiceGraph.Consumes.Consume{
               service: _
             },
             %ServiceGraph.Consumes.Consume{
               service: _
             },
             %ServiceGraph.Implementations.Implementation{
               action_name: "get_user_profile",
               service: _
             }
           ] = RelationBulkUpdate.call("FooService", data)
  end
end
