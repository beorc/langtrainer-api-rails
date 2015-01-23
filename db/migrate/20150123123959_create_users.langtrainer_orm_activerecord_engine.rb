# This migration comes from langtrainer_orm_activerecord_engine (originally 20150113214352)
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token, null: false
      t.timestamps null: false

      t.index :token, unique: true
    end
  end
end
