require 'rails_helper'

RSpec.describe Desk, type: :model do
  describe '画像投稿機能' do
    before do
      @desk = FactoryBot.build(:desk)
    end

    it 'title,imageが存在すれば登録できること' do
      expect(@desk).to be_valid
    end

    it '画像が含まれないと登録できないこと' do
      @desk.image = nil
      @desk.valid?
      expect(@desk.errors.full_messages).to include("Image can't be blank")
    end

    it 'titleが空だと登録できないこと' do
      @desk.title = nil
      @desk.valid?
      expect(@desk.errors.full_messages).to include("Title can't be blank")
    end

    it 'ユーザーが紐づいてないと登録できないこと' do
      @desk.user = nil
      @desk.valid?
      expect(@desk.errors.full_messages).to include('User must exist')
    end
  end
end
