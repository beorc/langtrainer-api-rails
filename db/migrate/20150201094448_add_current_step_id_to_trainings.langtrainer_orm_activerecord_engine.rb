# This migration comes from langtrainer_orm_activerecord_engine (originally 20150201091512)
class AddCurrentStepIdToTrainings < ActiveRecord::Migration
  def change
    remove_column :trainings, :current_step
    add_column :trainings, :current_step_id, :integer
  end
end
