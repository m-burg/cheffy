defmodule Cheffy.Foods.Ingredient do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "ingredients"
    repo Cheffy.Repo
  end
end
