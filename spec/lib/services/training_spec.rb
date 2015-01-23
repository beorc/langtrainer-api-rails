require 'rails_helper'

describe Services::Training do
  let(:controller) { double(:controller) }
  let(:training) { Factory.build(:training_stub) }
  let(:steps) { training.unit.steps }

  subject { Services::Training.new(controller, training) }

  before(:each) do
    [
      :render_step,
      :render_false,
      :render_nothing
    ].each do |method_name|
      allow(controller).to receive(method_name)
    end

    steps.each do |step|
      allow(Step).to receive(:find).with(step.id).and_return(step)
    end
  end

  describe '#next_step' do
    it 'should increment number of passed steps' do
      expect(training).to receive(:step_passed!)
      subject.next_step
    end

    context 'given the first step as current' do
      it 'should render the next step' do
        expect(controller).to receive(:render_step).with(steps.second)
        subject.next_step
      end
    end

    context 'given the last step as current' do
      before(:each) do
        training.current_step = steps.count - 1
      end

      it 'should render the first step' do
        expect(controller).to receive(:render_step).with(steps.first)
        subject.next_step
      end
    end
  end

  describe '#right_answer!' do
    it 'should move the current step to the next box' do
      expect(training).to receive(:push_current_step_to_next_box!)
      subject.right_answer!
    end

    it 'should increment the counter of revised steps' do
      expect(training).to receive(:step_revised!)
      subject.right_answer!
    end

    it 'should increment the counter of answered steps' do
      expect(training).to receive(:right_answer!)
      subject.right_answer!
    end

    it 'should render the next step' do
      expect(subject).to receive(:next_step)
      subject.right_answer!
    end
  end

  describe '#wrong_answer!' do
    it 'should move the current step to the first box' do
      expect(training).to receive(:push_current_step_to_first_box!)
      subject.wrong_answer!
    end

    it 'should increment the counter of wrong answered steps' do
      expect(training).to receive(:wrong_answer!)
      subject.wrong_answer!
    end

    it 'should render false' do
      expect(controller).to receive(:render_false)
      subject.wrong_answer!
    end
  end

  describe '#verify' do
    context 'given right answer' do
      it 'should call the Services::Training#right_answer!' do
        expect(subject).to receive(:right_answer!)
        subject.verify('first 0')
      end
    end

    context 'given wrong answer' do
      it 'should call the Services::Training#wrong_answer!' do
        expect(subject).to receive(:wrong_answer!)
        subject.verify('first 1')
      end
    end
  end

  describe '#help_next_word' do
    it 'should increment the number of helped words' do
      expect(training).to receive(:word_helped!)
      subject.help_next_word
    end

    it 'should render nothing' do
      expect(controller).to receive(:render_nothing)
      subject.help_next_word
    end
  end

  describe '#show_right_answer' do
    it 'should increment the number of helped steps' do
      expect(training).to receive(:step_helped!)
      subject.show_right_answer
    end

    it 'should increment the number of passed steps' do
      expect(training).to receive(:step_passed!)
      subject.show_right_answer
    end

    it 'should render nothing' do
      expect(controller).to receive(:render_nothing)
      subject.show_right_answer
    end
  end
end
