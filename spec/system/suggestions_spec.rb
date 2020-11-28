require 'rails_helper'

RSpec.describe 'suggestions', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @suggestion = FactoryBot.build(:suggestion)
  end
  context '掃除箇所を新規登録できる。' do
    it 'ログインしたユーザーは新規投稿できる(提案はされない)' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_suggestion_path
      # フォームに情報を入力する
      fill_in 'place', with: @suggestion.place

      # 掃除頻度(period_cleaning)を2日とし、提案対象(掃除頻度<経過日数3日)とする
      fill_in 'period_cleaning', with: @suggestion.period_cleaning
      fill_in 'last_cleaned_date', with: @suggestion.last_cleaned_date

      # 送信するとsuggestionモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Suggestion.count }.by(1)

      # 登録一覧ページに遷移する
      visit suggestions_path

      # 投稿一覧ページに投稿内容(最後に掃除した日付)が表示される
      expect(page).to have_content((Date.today - 3).to_s)
    end

    it 'ログインしたユーザーは新規投稿できる(提案される)' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_suggestion_path
      # フォームに情報を入力する
      fill_in 'place', with: @suggestion.place

      # 掃除頻度(period_cleaning)を2日とし、提案対象(掃除頻度<経過日数3日)とする
      fill_in 'period_cleaning', with: 2
      fill_in 'last_cleaned_date', with: @suggestion.last_cleaned_date

      # 送信するとSuggestionモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Suggestion.count }.by(1)
      # 掃除提案ページに遷移する
      visit clean_suggestions_path

      # 掃除提案ページに掃除場所(デスク)が表示される
      expect(page).to have_content('デスク')

      # 「掃除完了」ボタンが押され、提案内容が非表示になる
      find('.suggestion-blue-btn').click
      expect(page).to have_no_content('デスク')

      # 登録一覧ページに遷移する
      visit suggestions_path

      # 投稿一覧ページの投稿内容(最後に掃除した日付)が更新(今日の日付)される
      expect(page).to have_content(Date.today.to_s)
    end
  end
end

RSpec.describe 'suggestions', type: :system do
  before do
    @user2 = FactoryBot.create(:user)
    @suggestion = FactoryBot.create(:suggestion)
  end
  context '投稿した掃除箇所の編集ができる' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # ログインする
      sign_in(@suggestion.user)

      # 登録一覧ページに遷移する
      visit suggestions_path

      # 「編集」ボタンが押される
      find('.suggestion-blue-btn').click

      # 編集ページに遷移することを確認する
      expect(current_path).to eq edit_suggestion_path(@suggestion.id)

      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#place').value
      ).to eq @suggestion.place

      expect(
        find('#period_cleaning').value
      ).to eq @suggestion.period_cleaning.to_s

      expect(
        find('#last_cleaned_date').value
      ).to eq @suggestion.last_cleaned_date.to_s

      # 投稿内容を編集する
      fill_in 'place', with: "#{@suggestion.place}+編集"
      fill_in 'period_cleaning', with: 4
      fill_in 'last_cleaned_date', with: Date.today

      # 編集してもSuggestionモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Suggestion.count }.by(0)

      # 登録一覧画面に遷移することを確認する
      expect(current_path).to eq suggestions_path

      # トップページには先ほど変更した内容が存在することを確認する
      expect(page).to have_content("#{@suggestion.place}+編集")
      expect(page).to have_content('4')
      expect(page).to have_content(Date.today)
    end
  end

  context '投稿した掃除箇所の削除ができる' do
    it 'ログインユーザーは自分の投稿内容を削除できる' do
      # ログインする
      sign_in(@suggestion.user)

      # 登録一覧ページに遷移する
      visit suggestions_path

      # 「編集」ボタンが押される
      find('.suggestion-red-btn').click

      # 投稿一覧ページに投稿内容(掃除場所名)が表示されない
      expect(page).to have_no_content(@suggestion.place)
    end
  end

  context '投稿した掃除箇所の編集ができない' do
    it 'ログインしたユーザーは他人の投稿を編集及び削除できない' do
      # ログインする
      sign_in(@user2)

      # 登録一覧ページに遷移する
      visit suggestions_path

      # 「編集」ボタンがない
      expect(page).to have_no_selector('.suggestion-blue-btn')

      # 「削除」ボタンがない
      expect(page).to have_no_selector('.suggestion-red-btn')

      # 編集ページに遷移できない
      visit edit_suggestion_path(@suggestion.id)
      expect(current_path).to eq suggestions_path
    end
  end
end
