require 'rails_helper'

describe V1::CoursesController do
  describe 'GET index' do
    let(:courses) do
      [].tap do |courses|
        3.times do |i|
          units = [].tap do |units|
            3.times { |j| units << Factory.build(:unit_stub, id: 3*i+j) }
          end

          c = Factory.build(:course_stub, id: i)
          allow(c).to receive(:units).and_return(units)
          courses << c
        end
      end
    end

    before(:each) do
      expect(Course).to receive(:published).and_return(courses)
    end

    it 'should render published courses' do
      get :index
      verify { response.body }
    end
  end
end
