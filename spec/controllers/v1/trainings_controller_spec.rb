require 'rails_helper'

shared_examples 'a training' do
  it 'should return status 200' do
    expect(response).to have_http_status(:success)
  end

  it 'should assign @training' do
    expect(assigns(:training)).to eq(training)
  end
end

describe V1::TrainingsController do
  extend DataLayer::ClassMethods
  init_data_layer

  let(:shared_params) do
    {
      token: user.token,
      unit: unit.id,
      language: Language.english.slug,
      native_language: Language.russian.slug
    }
  end

  before(:each) do
    expect(User).to receive(:find_by).with({ token: user.token }).and_return(user)
    expect(Unit).to receive(:find).with(unit.id.to_s).and_return(unit)
    expect(Training).to receive(:find_or_create_by).with(
      user_id: user.id,
      unit_id: unit.id,
      language_id: Language.english.id,
      native_language_id: Language.russian.id
    ).and_return(training)
  end

  describe 'GET verify_answer' do
    let(:answer) { 'surely wrong answer' }

    before(:each) do
      get(:verify_answer, shared_params.merge(answer: answer))
    end

    it_behaves_like 'a training'

    context 'given right answer' do
      let(:answer) { steps.first.answers(:en).first }

      it 'should render next step' do
        verify(format: :json) { response.body }
      end
    end

    context 'given wrong answer' do
      it 'should render false' do
        expect(response.body).to eq 'false'
      end
    end
  end

  describe 'GET next_step' do
    before(:each) do
      get(:next_step, shared_params)
    end

    it_behaves_like 'a training'

    it 'should render next step' do
      verify(format: :json) { response.body }
    end
  end

  describe 'GET help_next_word' do
    before(:each) do
      get(:help_next_word, shared_params)
    end

    it_behaves_like 'a training'

    it 'should render nothing' do
      expect(response.body).to eq 'null'
    end
  end

  describe 'GET show_right_answer' do
    before(:each) do
      get(:show_right_answer, shared_params)
    end

    it_behaves_like 'a training'

    it 'should render nothing' do
      expect(response.body).to eq 'null'
    end
  end
end
