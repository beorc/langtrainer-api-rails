# This migration comes from langtrainer_orm_activerecord_engine (originally 20150215031605)
class AddScheduleToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :schedule, :text
  end
end
