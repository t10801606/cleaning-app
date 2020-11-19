require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント投稿機能' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it 'textが存在すれば登録できること' do
      expect(@comment).to be_valid
    end

    it 'textが含まれないと登録できないこと' do
      @comment.text = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Text can't be blank")
    end

    it 'ユーザーが紐づいてないと登録できないこと' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('User must exist')
    end

    it '投稿したデスク情報が紐づいてないと登録できないこと' do
      @comment.desk = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('Desk must exist')
    end
  end
end
