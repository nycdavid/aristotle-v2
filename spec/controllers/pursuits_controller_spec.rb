require 'rails_helper'

describe PursuitsController do
  describe '#show' do
    let(:pursuit) { FactoryGirl.create :pursuit }

    it 'should be a success' do
      get :show, id: pursuit.id
      expect(response).to render_template :show
    end
  end
end
