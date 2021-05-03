# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Article, type: :model do
  after(:all) do
    FactoryBot.rewind_sequences
  end

  context 'database' do
    describe 'columns' do
      it { is_expected.to have_db_column(:title) }
      it { is_expected.to have_db_column(:body) }
      it { is_expected.to have_db_column(:status) }
      it { is_expected.to have_db_column(:user_id) }
    end

    describe 'associations' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:comments) }
    end
  end

  context 'model' do
    subject { build(:article) }

    describe 'validations' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:body) }
      it { is_expected.to validate_length_of(:body).is_at_least(10) }
      it { is_expected.to validate_inclusion_of(:status).in_array(Article::VALID_STATUSES) }
    end
  end
end
