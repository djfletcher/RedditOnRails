class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.integer :moderator_id, null: false
      t.string :title, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
