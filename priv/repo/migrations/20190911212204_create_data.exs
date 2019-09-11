defmodule Figgis.Repo.Migrations.CreateData do
  use Ecto.Migration

  def change do
    create table(:data, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")

      add :x_value, :string, null: false
      add :y_value, :string, null: false

      add :metric_id, references(:metrics, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:data, [:metric_id])
  end
end
