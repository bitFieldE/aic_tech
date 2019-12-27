require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validation article(unit test)' do
    let(:valid_attributes) {
      {
        title: "TestTitle",
        body: "TestText",
        released_at: 8.days.ago.advance(days: 3),
        expired_at: 2.days.ago.advance(days: 3),
        user_list_only: 1
      }
    }

    let(:invalid_attributes) {
      {
        title: nil,
        body: nil,
        released_at: nil,
        expired_at: nil,
        user_list_only: nil
      }
    }

    describe 'article post' do
      before do
        @article = Article.new valid_attributes
      end

      it {
        expect(@article.valid?).to be_truthy
        expect { @article.save }.to change { Article.count }.by(1)
      }

      it 'blank of title' do
        @article.title = ""
        expect(@article).to be_invalid
      end

      it 'blank of body' do
        @article.body = ""
        expect(@article).to be_invalid
      end

      it 'blank of released_at' do
        @article.released_at = ""
        expect{@article.valid?}.to raise_error(ArgumentError)
      end

      it 'title within 40 characters' do
        @article.title = "#{"A" * 40}"
        expect(@article).to be_valid
      end

      it 'body over 2000 characters' do
        @article.body = "#{"A" * 2000}"
        expect(@article).to be_valid
      end

      it 'title over 40 characters' do
        @article.title = "#{"A" * 99}"
        expect(@article).to be_invalid
      end

      it 'body over 2000 characters' do
        @article.body = "#{"A" * 9999}"
        expect(@article).to be_invalid
      end
    end

    describe 'invalid article post' do
      before do
        @article = Article.new invalid_attributes
      end

      it {
        expect(@article.valid?).to be_falsey
      }
    end
  end

  #  before do
  #    @article = build(:article)
  #  end

  #  context 'User resistration which all columns are blank' do
  #      @article.title = ""
  #      @article.body = ""
  #      @article.expired_at = ""
  #      @article.released_at = ""
  #      @article.user_list_only = ""
  #      expect(@article).to be_invalid
  #    end

  #    it 'return false if title is blank' do
  #      @article.title = ""
  #      expect(@article).to be_invalid
  #    end

  #    it 'return true if title is blank or not' do
  #      @article.expired_at = ""
  #      expect(@article).to be_valid
  #    end


  #    it 'validate user_list_only is blank or not' do
  #      @article.user_list_only = ""
  #      expect(@article).to be_valid
  #    end
  #  end

  #  context 'User resistration which all columns are present' do
  #    it 'all columns are present' do
  #      expect(@article).to be_valid
  #    end

  #    it 'nullify expired_at preceeds released_at' do
  #      @article.expired_at = "#{8.days.ago.advance(days: 3)}"
  #      @article.released_at = "#{2.days.ago.advance(days: 3)}"
  #      expect(@article).to be_invalid
  #    end
  #  end
end
