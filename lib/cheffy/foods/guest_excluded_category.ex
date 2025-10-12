defmodule Cheffy.Foods.GuestExcludedCategory do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "guest_excluded_categories"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:guest_id, :ingredient_category_id]
    end
  end

  relationships do
    belongs_to :guest, Cheffy.Foods.Guest do
      public? true
      primary_key? true
      allow_nil? false
      source_attribute :guest_id
    end

    belongs_to :category, Cheffy.Foods.IngredientCategory do
      public? true
      primary_key? true
      allow_nil? false
      source_attribute :ingredient_category_id
    end
  end
end
