require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  describe '掃除箇所提案機能' do
    before do
      @suggestion = FactoryBot.build(:suggestion)
    end

    it 'place,status,period_cleaning,last_cleaned_dateが存在すれば登録できること' do
      expect(@suggestion).to be_valid
    end

    it 'statusがfalseでも登録できること' do
      @suggestion.status = false
      expect(@suggestion).to be_valid
    end

    it 'placeが含まれないと登録できないこと' do
      @suggestion.place = nil
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Place can't be blank")
    end

    it 'statusが空だと登録できないこと' do
      @suggestion.status = nil
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Status is not included in the list")
    end

    it 'period_cleaningが空だと登録できないこと' do
      @suggestion.period_cleaning = nil
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Period cleaning can't be blank", "Period cleaning is invalid")
    end

    it 'period_cleaningが数字以外だと登録できないこと' do
      @suggestion.period_cleaning = 'あああ'
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Period cleaning is not a number")
    end

    it 'period_cleaningが0だと登録できないこと' do
      @suggestion.period_cleaning = 0
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Period cleaning must be greater than or equal to 1")
    end

    it 'period_cleaningがマイナスの整数だと登録できないこと' do
      @suggestion.period_cleaning = -1
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Period cleaning must be greater than or equal to 1",
      "Period cleaning is invalid")
    end

    it 'period_cleaningが小数点を含むと登録できないこと' do
      @suggestion.period_cleaning = 1.5
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Period cleaning must be an integer")
    end

    it 'last_cleaned_dateが空だと登録できないこと' do
      @suggestion.last_cleaned_date = nil
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Last cleaned date can't be blank")
    end

    it 'last_cleaned_dateが明日以降だと登録できないこと' do
      @suggestion.last_cleaned_date = Date.today+1
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include("Last cleaned date は、今日を含む過去の日付を入力して下さい")
    end

    it 'ユーザーが紐づいてないと登録できないこと' do
      @suggestion.user = nil
      @suggestion.valid?
      expect(@suggestion.errors.full_messages).to include('User must exist')
    end
  end
end
