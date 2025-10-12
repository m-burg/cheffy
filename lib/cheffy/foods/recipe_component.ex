defmodule Cheffy.Foods.RecipeComponent do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "recipe_components"
    repo Cheffy.Repo
  end
end
