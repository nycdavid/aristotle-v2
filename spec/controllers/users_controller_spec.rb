require 'rails_helper'

describe UsersController, 'authentication' do
  let(:user) { FactoryGirl.create :user }

  context 'when User is signed in' do
    before :each do
      session[:user_id] = user.id
    end

    describe '#new' do
      it 'should respond with 200' do
        get :new
        expect(response.status).to eq(200)
      end
    end

    describe '#create' do
      it 'should respond with 302' do
        post :create, { user: { email: 'joe@person.com', password: 'strongpass', password_confirmation: 'strongpass' } }
        expect(response.status).to eq(302)
      end
    end

    describe '#show' do
      it 'should respond with 200' do
        get :show
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
      it 'should respond with 200' do
        get :new
        expect(response.status).to eq(200)
      end
    end

    describe '#create' do
      it 'should respond with 200' do
        post :create, { user: { email: 'joe@person.com', password: 'strongpass', password_confirmation: 'strongpass' } }
        expect(response.status).to eq(302)
      end
    end

    describe '#show' do
      it 'should respond with a 404' do
        get :show
        expect(response.status).to eq(404)
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
