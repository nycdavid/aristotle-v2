require 'rails_helper'

describe PagesController do
  describe '#home' do
    it 'should respond with a 200' do
      get :home
      expect(response.status).to eq(200)
    end
  end
end
