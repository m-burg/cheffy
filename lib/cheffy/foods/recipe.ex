defmodule Cheffy.Foods.Recipe do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "recipes"
    repo Cheffy.Repo
  end
end
