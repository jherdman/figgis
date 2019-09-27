defmodule FiggisWeb.Api.DataControllerTest do
  use FiggisWeb.ConnCase

  alias Figgis.Factory

  setup do
    metric = Factory.insert(:metric)

    {:ok, metric: metric}
  end

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  @x_value "2019-05-16 10:30:30"
  @y_value "456"

  describe "create datum" do
    test "responds CREATED when successful", %{conn: conn, metric: metric} do
      params = %{
        "data" => %{
          "type" => "datum",
          "attributes" => %{
            "x_value" => @x_value,
            "y_value" => @y_value
          }
        }
      }

      conn = post(conn, Routes.api_data_path(conn, :create, metric), params)

      assert %{
               "data" => %{
                 "type" => "datum",
                 "attributes" => %{
                   "xValue" => @x_value,
                   "yValue" => @y_value
                 }
               }
             } = json_response(conn, :created)
    end

    test "responds with BAD REQUEST when missing a value", %{conn: conn, metric: metric} do
      params = %{
        "data" => %{
          "type" => "datum",
          "attributes" => %{}
        }
      }

      conn = post(conn, Routes.api_data_path(conn, :create, metric), params)

      assert %{
               "errors" => [
                 %{
                   "title" => "Invalid attribute",
                   "detail" => "can't be blank",
                   "source" => %{
                     "pointer" => "/data/attributes/xValue"
                   }
                 },
                 %{
                   "title" => "Invalid attribute",
                   "detail" => "can't be blank",
                   "source" => %{
                     "pointer" => "/data/attributes/yValue"
                   }
                 }
               ]
             } = json_response(conn, :bad_request)
    end
  end
end
