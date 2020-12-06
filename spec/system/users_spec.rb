require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation

      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログイン後、ユーザー名とログアウトボタン表示されていないことを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ユーザー情報の編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ユーザー情報が編集できるとき' do
    it '正しい情報を入力すればユーザー情報が編集できてトップページに移動する' do
      # トップページに移動する
      visit root_path

      # ログインする
      sign_in(@user)
      # ユーザー情報編集ページに遷移する
      visit edit_user_path(@user.id)
      
      # ユーザー情報を編集する
      fill_in 'nickname', with: "#{@user.nickname}2"
      fill_in 'email', with: "2#{@user.email}"

      # サインアップボタンを押すとユーザーモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)

      # トップページへ遷移する
      expect(current_path).to eq root_path
      
      # ログイン後、ユーザー名が変わっていることを確認する
      expect(page).to have_content("#{@user.nickname}2")
    end
  end
  context 'ユーザー情報が編集できないとき' do
    it 'ログインしていなければ、ユーザー情報編集画面に遷移できない' do
      # トップページに移動する
      visit root_path

      # ユーザー情報編集ページに遷移を試みる
      visit edit_user_path(@user.id)
      
      # 自動的にトップページへ遷移する
      expect(current_path).to eq root_path
    end

    it 'ログインしているが、誤った情報では更新できない' do
      # ログインする
      sign_in(@user)
      # ユーザー情報編集ページに遷移する
      visit edit_user_path(@user.id)

      # ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
    end
  end
end
