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

  attributes do
    uuid_primary_key :id
  end

  relationships do
    belongs_to :recipe, Cheffy.Foods.Recipe do
      public? true
      allow_nil? false
    end

    belongs_to :ingredient, Cheffy.Foods.Ingredient do
      public? true
      allow_nil? false
    end

    has_many :substitutes, Cheffy.Foods.ComponentSubstitute do
    end
  end

  calculations do
    calculate :edible_by_guest,
              :boolean,
              {Cheffy.Foods.Calculations.ComponentEdibleByGuest, []} do
      public? true

      argument :guest_id, :uuid do
        allow_nil? false
      end
    end
  end

  identities do
    identity :unique_recipe_ingredient_combo, [:ingredient_id, :recipe_id],
      message: "ingredient has already been added to this recipe"
  end
end
