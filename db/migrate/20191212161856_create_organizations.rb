class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :phone_number
      t.text :logo
      t.timestamps
    end
  end
end
