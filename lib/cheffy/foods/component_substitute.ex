defmodule Cheffy.Foods.ComponentSubstitute do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "component_substitutes"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [:recipe_component_id, :ingredient_id]
    end
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

  calculations do
    calculate :edible_by_guest,
              :boolean,
              expr(ingredient.edible_by_guest(guest_id: ^arg(:guest_id))) do
      public? true

      argument :guest_id, :uuid do
        allow_nil? false
      end
    end
  end
end
