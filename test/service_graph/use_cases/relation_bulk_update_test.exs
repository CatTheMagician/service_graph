defmodule ServiceGraph.UseCases.RelationBulkUpdateTest do
  use ServiceGraph.DataCase

  alias ServiceGraph.UseCases.RelationBulkUpdate

  test "#сall - deletes old data and inserts new" do
    data = [
      "uses Amazon::S3#store_document",
      "uses Amazon::S3#read_document",
      "uses BarService#get_user_data",
      "implements get_user_profile"
    ]

    assert [
             %ServiceGraph.Consumes.Consume{
               action_id: _,
               service_id: _
             },
             %ServiceGraph.Consumes.Consume{
               action_id: _,
               service_id: _
             },
             %ServiceGraph.Consumes.Consume{
               action_id: _,
               service_id: _
             },
             %ServiceGraph.Implementations.Implementation{
               action_name: "get_user_profile",
               service_id: _
             }
           ] = RelationBulkUpdate.call("FooService", data)
  end
end
