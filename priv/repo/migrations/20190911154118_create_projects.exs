defmodule Figgis.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    execute(
      "CREATE EXTENSION IF NOT EXISTS pgcrypto",
      "DROP EXTENSION pgcrypto"
    )

    create table(:projects, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()")

      add :name, :string

      timestamps()
    end
  end
end
