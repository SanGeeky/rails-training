# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  context 'articles user not authenticated' do
    describe '#index' do
      before { get :index }

      it { should respond_with 200 }
      it { should render_template 'index' }
    end

    describe '#show' do
      subject { create :article }

      it 'article found' do
        get :show, params: { id: subject.id }
        expect(response.status).to eq(200)
      end

      it 'article not found' do
        random_id = rand(1..100)
        expect { get get :show, params: { id: random_id } }.to raise_error ActionController::RoutingError
      end
    end

    describe '#new' do
      before { get :new }

      it { should respond_with(:redirect) }
      it { should redirect_to signin_path }
    end

    describe '#create' do
      before { post :create }

      it { should respond_with(:redirect) }
      it { should redirect_to signin_path }
    end

    describe '#update' do
      let(:article) { create :article }

      before { get :create, params: { id: article.id } }
      it { should respond_with(:redirect) }
      it { should redirect_to signin_path }
    end

    describe '#destroy' do
      let(:article) { create :article }

      before { get :destroy, params: { id: article.id } }
      it { should respond_with(:redirect) }
      it { should redirect_to signin_path }
    end
  end
end

RSpec.describe ArticlesController, type: :request do
  context 'articles user authenticated' do
    let(:user) { create :user }
    subject { create :article, user: user }

    before(:example) do
      # Create Session
      post signin_path, params: {
        email: user.email,
        password: user.password,
        previous_url: root_path
      }
    end

    describe '#index' do
      before { get articles_path }

      it { expect(response.status).to eq 200 }
      it { should render_template 'index' }
    end

    describe '#show' do
      it 'article found' do
        get article_path id: subject.id
        expect(response.status).to eq(200)
      end

      it 'article not found' do
        random_id = rand(1..100)
        expect { get article_path id: random_id }.to raise_error ActionController::RoutingError
      end
    end

    describe '#new' do
      before { get new_article_path }

      it { expect(response.status).to eq 200 }
      it { should render_template 'new' }
    end

    describe '#create' do
      it 'saved' do
        post articles_path(article: subject.instance_values)
        expect(response.status).to eq 200
      end

      it 'not saved' do
        post articles_path(article: { title: nil, body: nil })
        expect(subject).to render_template 'new'
      end
    end

    describe '#update' do
      let(:article) { build :article }

      it 'updated' do
        put article_path(subject), params: { article: article.instance_values }
        expect(response.status).to eq 302
      end

      it 'not updated' do
        put article_path(subject), params: { article: { title: nil, body: nil } }
        expect(subject).to render_template 'edit'
      end
    end

    describe '#destroy' do
      before { delete article_path(subject) }

      it { expect(response.status).to eq 302 }
      it { should redirect_to root_path }
    end
  end
end
