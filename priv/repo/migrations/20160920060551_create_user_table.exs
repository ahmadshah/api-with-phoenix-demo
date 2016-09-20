defmodule ApiWithPhoenixDemo.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :first_name, :string
      add :last_name, :string
      timestamps
    end
    create unique_index(:users, [:email])

    create table(:user_tokens, primary_key: false) do
      add :jti, :string, primary_key: true
      add :typ, :string
      add :aud, :string
      add :iss, :string
      add :sub, :string
      add :exp, :bigint
      add :jwt, :text
      add :claims, :map
      timestamps
    end
    create unique_index(:user_tokens, [:jti, :aud])
  end

  def down do
    drop table(:users)
    drop table(:user_tokens)
  end
end
