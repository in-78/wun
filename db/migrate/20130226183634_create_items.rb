class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.date :date_due
      t.date :date_remind
      t.boolean :complete, null: false, default: false
      t.boolean :star, null: false, default: false
      t.references :list

      t.timestamps
    end
    add_index :items, :list_id
  end
end