# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  context 'articles user not authenticated' do
    describe '#index' do
      subject { get articles_path }

      it { is_expected.to equal 200 }
      it { is_expected.to render_template 'index' }
    end

    describe '#show' do
      before { create :article }
      subject { get article_path id: Article.last.id }

      it { is_expected.to equal 200 }
      it { is_expected.to render_template 'show' }
      it 'is expected to not found' do
        random_id = rand(1..100)
        expect { get article_path id: random_id }.to raise_error ActionController::RoutingError
      end
    end

    describe '#new' do
      subject { get new_article_path }

      it { is_expected.to equal 302 }
      it { is_expected.to redirect_to signin_path }
    end

    describe '#create' do
      let(:article) { build :article }
      subject { post articles_path(article: article.instance_values) }

      it { is_expected.to equal 302 }
      it { is_expected.to redirect_to signin_path }
    end

    describe '#update' do
      let(:article) { create :article }
      let(:article_updated) { build :article }
      subject do
        put article_path(article),
            params: { article: article_updated.instance_values }
      end

      it { is_expected.to equal 302 }
      it { is_expected.to redirect_to signin_path }
    end

    describe '#destroy' do
      let(:article) { create :article }
      subject { delete article_path(article) }

      it { is_expected.to equal 302 }
      it { is_expected.to redirect_to signin_path }
    end
  end

  context 'articles user authenticated' do
    let(:user) { create :user }
    let(:article) { create :article, user: user }
    # subject {  }
    before(:example) do
      # Create Session
      post signin_path, params: {
        email: user.email,
        password: user.password,
        previous_url: root_path
      }
    end

    describe '#index' do
      subject { get articles_path }

      it { is_expected.to equal 200 }
      it { is_expected.to render_template 'index' }
    end

    describe '#show' do
      subject { get article_path id: article.id }

      it { is_expected.to equal 200 }
      it { is_expected.to render_template 'show' }
      it 'is expected to not found' do
        random_id = rand(1..100)
        expect { get article_path id: random_id }.to raise_error ActionController::RoutingError
      end
    end

    describe '#new' do
      subject { get new_article_path }

      it { is_expected.to equal 200 }
      it { is_expected.to render_template 'new' }
    end

    describe '#create' do
      let(:new_article) { build :article }
      subject { post articles_path(article: new_article.instance_values) }

      it { is_expected.to equal 200}
      it 'article not saved' do
        subject { post articles_path(article: { title: nil, body: nil }) }
        is_expected.to render_template 'new'
      end
    end

    describe '#update' do
      let(:article_updated) { build :article }
      subject do
        put article_path(article),
            params: { article: article_updated.instance_values }
      end

      it { is_expected.to equal 302 }
      it { is_expected.to redirect_to article_path(article) }
      it 'article not updated' do
        put article_path(article),
            params: { article: { title: nil, body: nil } }
        expect(response).to render_template 'edit'
      end
    end

    describe '#destroy' do
      subject { delete article_path(article) }

      it { is_expected.to eq 302 }
      it { is_expected.to redirect_to root_path }
    end
  end
end
