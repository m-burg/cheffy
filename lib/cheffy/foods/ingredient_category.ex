defmodule Cheffy.Foods.IngredientCategory do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "ingredient_categories"
    repo Cheffy.Repo
  end
end
