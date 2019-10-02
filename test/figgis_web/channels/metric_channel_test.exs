defmodule FiggisWeb.MetricChannelTest do
  use FiggisWeb.ChannelCase

  alias Figgis.Factory
  alias Figgis.Metrics.Metric

  describe "valid metric_id" do
    setup do
      metric = Factory.insert(:metric)

      data = Factory.insert_list(10, :datum, metric: metric)

      {:ok, metric: metric, data: data}
    end

    setup %{metric: %Metric{id: metric_id}} do
      {:ok, _, socket} =
        socket(FiggisWeb.UserSocket, "user_id", %{some: :assign})
        |> subscribe_and_join(FiggisWeb.MetricChannel, "metric:#{metric_id}")

      {:ok, socket: socket}
    end

    test "get_data replies with all known data", %{socket: socket, data: data} do
      ref = push socket, "get_data", %{}

      assert_reply ref, :ok, %{}

      assert_broadcast("data", payload)

      assert %{data: received_data} = payload

      assert Enum.count(received_data) == Enum.count(data)
    end
  end

  describe "invalid metric_id" do
    setup do
      {:ok, uuid: Ecto.UUID.generate()}
    end

    test "replies with an error", %{uuid: uuid} do
      {:error, %{reason: "unrecognized metric"}} =
        socket(FiggisWeb.UserSocket, "user_id", %{some: :assign})
        |> subscribe_and_join(FiggisWeb.MetricChannel, "metric:#{uuid}")
    end
  end
end
