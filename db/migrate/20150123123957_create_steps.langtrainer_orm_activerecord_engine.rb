# This migration comes from langtrainer_orm_activerecord_engine (originally 20150113201308)
class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.text :en_answers, null: false
      t.text :ru_answers, null: false

      t.string :ru_question
      t.string :ru_help

      t.string :en_question
      t.string :en_help
    end
  end
end
