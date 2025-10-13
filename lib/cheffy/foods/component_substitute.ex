defmodule Cheffy.Foods.ComponentSubstitute do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "component_substitutes"
    repo Cheffy.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    belongs_to :recipe_component, Cheffy.Foods.RecipeComponent do
      primary_key? true
      allow_nil? false
      public? true
    end

    belongs_to :ingredient, Cheffy.Foods.Ingredient do
      primary_key? true
      allow_nil? false
      public? true
    end
  end
end
