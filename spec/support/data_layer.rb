module DataLayer
  module ClassMethods
    def init_data_layer
      let(:user) { Factory.build(:user_stub) }
      let(:training) { Factory.build(:training_stub) }
      let(:unit) { training.unit }

      let(:steps) do
        [].tap do |s|
          3.times { s << Factory.build(:step_stub) }
        end
      end

      before(:each) do
        steps.each do |step|
          allow(Step).to receive(:find).with(step.id).and_return(step)
        end

        allow(unit).to receive(:steps).and_return(steps)

        step_ids = steps.map(&:id)
        allow(training).to receive(:step_ids).and_return(step_ids)
        training.box_0 = step_ids
      end
    end
  end
end

