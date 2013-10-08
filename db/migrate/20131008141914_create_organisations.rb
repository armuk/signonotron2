class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.text :api_id
      t.text :web_url
      t.string :name
      t.string :organisation_type

      t.timestamps
    end

    create_table :organisations_users do |t|
      t.references :organisation
      t.references :user

      t.timestamps
    end
    add_index :organisations_users, :organisation_id
    add_index :organisations_users, :user_id
  end
end
