require 'rails_helper'

describe PomodoriController, 'authentication' do
  let(:user) { FactoryGirl.create :user }
  let(:pursuit) { FactoryGirl.create :pursuit }
  let(:pomodoro) { FactoryGirl.create(:pomodoro, { pursuit_id: pursuit.id }) }

  context 'when User is signed in' do
    before :each do
      session[:user_id] = user.id
    end

    describe '#new' do
      it 'should respond with 200' do
        get :new, { pursuit_id: pursuit.id }
        expect(response.status).to eq(200)
      end
    end

    describe '#create' do
      it 'should respond with 302' do
        post :create, { pursuit_id: pursuit.id, pomodoro: { elapsed_time: 10, pursuit_id: pursuit.id } }
        expect(response.status).to eq(200)
      end
    end

    describe '#show' do
      it 'should respond with 200' do
        get :show, { pursuit_id: pursuit.id, id: pomodoro.id }
        expect(response.status).to eq(200)
      end
    end

    describe '#edit' do
      it 'should respond with 200' do
        pending
        fail
      end
    end

    describe '#update' do
      it 'should respond with 200' do
        pending
        fail
      end
    end
  end

  context 'when User is not signed in' do
    describe '#new' do
      it 'should respond with 404' do
        get :new, { pursuit_id: pursuit.id }
        expect(response.status).to eq(404)
      end
    end

    describe '#create' do
      it 'should respond with 404' do
        post :create, { pursuit_id: pursuit.id, pomodoro: { elapsed_time: 10, pursuit_id: 5 } }
        expect(response.status).to eq(404)
      end
    end

    describe '#show' do
      it 'should respond with a 404' do
        pending
        fail
      end
    end

    describe '#edit' do
      it 'should respond with 404' do
        pending
        fail
      end
    end

    describe '#update' do
      it 'should respond with 404' do
        pending
        fail
      end
    end
  end
end
