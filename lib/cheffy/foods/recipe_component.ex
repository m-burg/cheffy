defmodule Cheffy.Foods.RecipeComponent do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "recipe_components"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:recipe_id, :ingredient_id]
    end
  end

  relationships do
    belongs_to :recipe, Cheffy.Foods.Recipe do
      primary_key? true
      public? true
      allow_nil? false
    end

    belongs_to :ingredient, Cheffy.Foods.Ingredient do
      primary_key? true
      public? true
      allow_nil? false
    end
  end
end
