require 'rails_helper'

describe V1::TrainingsController do
  let(:user) { Factory.build(:user_stub) }
  let(:unit) { Factory.build(:unit_stub) }
  let(:training) { Factory.build(:training_stub) }
  let(:steps) { training.unit.steps }

  before(:each) do
    steps.each do |step|
      allow(Step).to receive(:find).with(step.id).and_return(step)
    end

    expect(User).to receive(:find_or_create_by).with({ token: user.token }).and_return(user)
    expect(Unit).to receive(:find).with(unit.id.to_s).and_return(unit)
    expect(Training).to receive(:find_by).with(
      user_id: user.id,
      unit_id: unit.id,
      language_id: Language.english.id,
      native_language_id: Language.russian.id
    ).and_return(training)
  end

  describe '#fetch_unit_advance' do
  end

  describe 'GET verify_answer' do
    it 'should return status success' do
      get(
        :verify_answer,
        token: user.token,
        unit: unit.id,
        language: Language.english.slug,
        native_language: Language.russian.slug,
        answer: 'first 0'
      )

      expect(response.status).to eq 200
    end
  end
end
