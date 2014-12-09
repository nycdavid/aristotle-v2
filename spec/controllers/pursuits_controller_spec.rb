require 'rails_helper'

describe PursuitsController, 'authentication' do
  let(:user) { FactoryGirl.create(:user) }
  let(:pursuit) { FactoryGirl.create :pursuit, { user_id: user.id } }

  context 'when User is signed in' do
    before :each do
      session[:user_id] = pursuit.user_id
    end

    describe '#index' do
      it 'should render index' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe '#new' do
      it 'should render new' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe '#create' do
      it 'should render create' do
        post :create, { pursuit: { name: 'Working out', user_id: user.id } }
        expect(response.status).to eq(302)
      end
    end

    describe '#show' do
      it 'should render show' do
        get :show, { id: pursuit.id }
        expect(response).to render_template :show
      end
    end

    describe '#edit' do
      it 'should render edit' do
        get :edit, { id: pursuit.id }
        expect(response).to render_template :edit
      end
    end

    describe '#update' do
      it 'should render update' do
        put :update, { id: pursuit.id, pursuit: { name: 'Working out', user_id: user.id } }
        expect(response.status).to eq(302)
      end
    end
  end

  context 'when User is not signed in' do
    describe '#index' do
      it 'should render 404' do
        get :index
        expect(response.status).to eq(404)
      end
    end

    describe '#new' do
      it 'should render 404' do
        get :new
        expect(response.status).to eq(404)
      end
    end

    describe '#create' do
      it 'should render create' do
        post :create, { pursuit: { name: 'Working out', user_id: user.id } }
        pending
        fail
      end
    end

    describe '#show' do
      it 'should render show' do
        get :show, { id: pursuit.id }
        expect(response.status).to eq(404)
      end
    end

    describe '#edit' do
      it 'should render edit' do
        get :edit, { id: pursuit.id }
        expect(response.status).to eq(404)
      end
    end

    describe '#update' do
      it 'should render update' do
        put :update, { id: pursuit.id, pursuit: { name: 'Working out', user_id: user.id } }
        pending
        fail
      end
    end
  end
end
