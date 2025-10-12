defmodule Cheffy.Foods.Recipe do
  use Ash.Resource, otp_app: :cheffy, domain: Cheffy.Foods, data_layer: AshPostgres.DataLayer

  postgres do
    table "recipes"
    repo Cheffy.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:name]
    end

    update :update do
      accept [:name]
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
    has_many :components, Cheffy.Foods.RecipeComponent do
      public? true
    end
  end
end
