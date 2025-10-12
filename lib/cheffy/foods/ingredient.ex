defmodule Cheffy.Foods.Ingredient do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "ingredients"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:name, :ingredient_category_id]
    end

    update :update do
      accept [:name, :ingredient_category_id]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      allow_nil? false
    end
  end

  relationships do
    belongs_to :category, Cheffy.Foods.IngredientCategory do
      source_attribute :ingredient_category_id
      allow_nil? false
      public? true
    end
  end

  calculations do
    calculate :edible_by_guest,
              :boolean,
              {Cheffy.Foods.Calculations.IngredientEdibleByGuest, []} do
      argument :guest_id, :uuid do
        allow_nil? false
      end
    end
  end
end
