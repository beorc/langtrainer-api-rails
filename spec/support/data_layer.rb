module DataLayer
  module ClassMethods
    def init_data_layer
      let(:user) { Factory.build(:user_stub) }
      let(:training) { Factory.build(:training_stub) }
      let(:unit) { training.unit }

      let(:steps) do
        [].tap do |s|
          3.times { |i| s << Factory.build(:step_stub, id: i) }
        end
      end

      before(:each) do
        steps.each do |step|
          allow(Step).to receive(:find).with(step.id).and_return(step)
        end

        allow(unit).to receive(:steps).and_return(steps)

        step_ids = steps.map(&:id)
        step_ids.each do |step_id|
          training.schedule[step_id] = { box: 0 }
        end
        training.current_step_id = step_ids.first
        allow(training).to receive(:current_step).and_return(steps.first)
      end
    end
  end
end

