# This migration comes from langtrainer_orm_activerecord_engine (originally 20150215034128)
class RemoveBoxesFromTrainings < ActiveRecord::Migration
  def change
    5.times do |i|
      remove_column :trainings, "box_#{i}".to_sym
    end
  end
end
