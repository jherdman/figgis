defmodule Figgis.Schema do
  @moduledoc """
  Defines a common shared Schema with all of our default options set. E.g.
  primary keys are UUIDs.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @primary_key {:id, :binary_id, autogenerate: false, read_after_writes: true}
      @foreign_key_type :binary_id
    end
  end
end
