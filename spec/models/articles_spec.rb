# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Article, type: :model do
  after(:all) do
    FactoryBot.rewind_sequences
  end

  context 'database' do
    describe 'columns' do
      it { should have_db_column(:title) }
      it { should have_db_column(:body) }
      it { should have_db_column(:status) }
      it { should have_db_column(:user_id) }
    end

    describe 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:comments) }
    end
  end

  context 'model' do
    subject { build(:article) }

    describe 'validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_least(10) }
      it { should validate_inclusion_of(:status).in_array(Article::VALID_STATUSES) }
    end
  end

  context 'crud' do
    subject { create(:article) }

    describe '#create' do
      subject { build(:article) }
      it { should be_valid }
      it 'is created' do
        expect(subject.save).to eq(true)
      end
      it 'is not created' do
        subject.title = nil
        expect(subject.save).not_to eq(true)
      end
    end

    describe '#read' do
      it 'is found' do
        expect(described_class.find(subject.id)).to eq(subject)
      end

      it 'is not found' do
        random_id = rand(1..100)
        expect { described_class.find(random_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe '#update' do
      let(:params_article) { {} }
      it 'is updated' do
        params_article['title'] = Faker::Lorem.sentence
        params_article['body'] = Faker::Lorem.paragraph
        expect(subject.update(params_article)).to eq(true)
      end

      it 'not updated' do
        params_article['title'] = nil
        params_article['body'] = nil
        expect(subject.update(params_article)).not_to eq(true)
      end
    end

    describe '#destroy' do
      it 'is deleted' do
        expect(subject.destroy).to eq(subject)
      end
    end
  end
end
