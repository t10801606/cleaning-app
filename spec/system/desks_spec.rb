require 'rails_helper'

RSpec.describe "Desks", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @desk = FactoryBot.build(:desk)
  end
  context '画像投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
    
      sign_in(@user)
      # 投稿ページに移動する 
      visit new_desk_path
      # フォームに情報を入力する
      fill_in 'desk-title', with: @desk.title
      fill_in 'desk-concept', with: @desk.concept
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.jpg')
      
      # 画像選択フォームに画像を添付する
      attach_file('desk[image]', image_path, make_visible: true)

      # 送信するとDeskモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Desk.count }.by(1)
      # 画像一覧ページに遷移する
      visit desks_path
      # トップページには先ほど投稿した内容の画像が存在することを確認する（画像）
      expect(page).to have_selector("img")
      
      # トップページには先ほど投稿した内容の画像が存在することを確認する（テキスト）
      expect(page).to have_content(@desk.title)
    end
  end
end

RSpec.describe '画像の編集', type: :system do
  before do
    @user2 = FactoryBot.create(:user)
    @desk = FactoryBot.create(:desk)   
  end

  context '画像編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した画像の編集ができる' do
      # 画像を投稿したユーザーでログインする
      sign_in(@desk.user)

      # 詳細ページへ遷移する
      visit desk_path(@desk.id)

      # 「編集」と「削除」ボタンがある
      expect(page).to have_content('編集')
      expect(page).to have_content('削除')

      # 詳細ページへ遷移する    
      visit edit_desk_path(@desk.id)
      
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#desk_title').value
      ).to eq @desk.title

      expect(
        find('#desk_concept').value
      ).to eq @desk.concept
      
      # 投稿内容を編集する
      fill_in 'desk_title', with: "#{@desk.title}+編集したタイトル"
      image_path = Rails.root.join('public/images/test_image2.jpeg')
      attach_file('desk[image]', image_path, make_visible: true)

      # 編集してもDeskモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Desk.count }.by(0)
      
      # 編集完了画面に遷移することを確認する
      expect(current_path).to eq desks_path

      binding.pry
      # トップページには先ほど変更した内容が存在することを確認する（テキスト）
      expect(page).to have_content("#{@desk.title}+編集したタイトル")

      # トップページには先ほど変更した内容が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image2.jpeg']")
    end
  end

  context '画像編集ができないとき' do
    it '他ユーザーが投稿した画像を編集できない' do
      # 画像を投稿したユーザーとは別のユーザー(@user2)でログインする
      sign_in(@user2)

      # 詳細ページへ遷移する
      visit desk_path(@desk.id)

      # 詳細画面に「編集」と「削除」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
      expect(page).to have_no_content('削除')

      # 他ユーザーが投稿した画像の編集画面には遷移できない
      visit edit_desk_path(@desk.id)
      expect(current_path).to eq desks_path
    end
  end

  context '画像削除ができるとき' do
    it '画像を削除できる' do
      # 画像を投稿したユーザーでログインする
 
      sign_in(@desk.user)
      
      # 詳細ページへ遷移する
      visit desk_path(@desk.id)

      # 「削除」ボタンを押す
      find('.desk-destroy-btn').click

      # 削除後、画像一覧ページに遷移する
      expect(current_path).to eq desks_path

      # 画像一覧ページにから画像タイトルが削除されている
      expect(page).to have_no_content(@desk.title)

      # 画像一覧ページにから画像が削除されている
      expect(page).to have_no_selector(".desk-img")
    end
  end

end