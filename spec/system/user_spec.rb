require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザ新規登録' do
      it '自身の名が入ったページへアクセスできる' do
        visit new_user_path
        fill_in 'user_name', with: 'suzuki_test111'
        fill_in 'user_email', with: 'suzuki_test111@example.com'
        fill_in 'user_password', with: 'suzuki'
        fill_in 'user_password_confirmation', with: 'suzuki'
        click_on 'アカウントを登録する'
        expect(page).to have_content 'suzuki_test111のマイページ'
      end
    end

    context 'ログインなしでタスク一覧にアクセス' do
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能テスト' do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'suzuki_test01@example.com'
      fill_in 'session_password', with:'suzuki'
      click_on 'Log in'
    end

    context 'ログインした場合' do
      it '自分の詳細画面に飛べること' do
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'suzuki_test01のマイページ'
      end

      it "他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(@second_user.id)
        expect(page).to have_content "タスク一覧"
      end
    end

    context 'ログアウトした場合' do
      it "ログイン画面に戻る" do
        visit user_path(id: @user.id)
        click_link "ログアウト"
        expect(page).to have_content "ログイン"
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理ユーザ作成" do
      it "管理者は管理画面にアクセスできること" do
        visit new_session_path
        fill_in "session_email", with: "suzuki_test51@example.com​"
        fill_in "session_password", with: "suzuki"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "ユーザー一覧"
      end
    end

    context "一般ユーザーがログインしている場合" do
      it "一般ユーザーは管理画面にはアクセスできない" do
        visit new_session_path
        fill_in "session_email", with: "suzuki_test01@example.com​"
        fill_in "session_password", with: "suzuki"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外は"
      end
    end

    context "管理者でログインしている場合" do
      before do
        visit new_session_path
        fill_in "session_email", with: "suzuki_test51@example.com​"
        fill_in "session_password", with: "suzuki"
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザ新規登録ができる" do
        click_link "新規ユーザー作成"
        fill_in "user_name", with: "Saburou Suzuki"
        fill_in "user_email", with: "suzuki33@example.com"
        fill_in "user_password", with: "suzuki"
        fill_in "user_password_confirmation", with: "suzuki"
        click_on "登録する"
        expect(page).to have_content "Saburou Suzukiのマイページ"
      end

      it "管理者はユーザの詳細画面へ行ける" do
        visit admin_user_path(@user)
        expect(page).to have_content "suzuki_test01のマイページ"
      end

      it "管理者ユーザーの編集画面からユーザーの編集ができる" do
        visit edit_admin_user_path(@user)
        fill_in 'user_name', with: 'Saburou Suzuki43'
        fill_in 'user_email', with: 'suzuki43@example.com'
        check 'user_admin'
        fill_in 'user_password', with: 'suzuki'
        fill_in 'user_password_confirmation', with: 'suzuki'
        click_button '更新する'
        expect(page).to have_content "Saburou Suzuki43のマイページ"
      end

      it "管理者はユーザーを削除できる" do
        visit admin_users_path
        click_link "Delete", match: :first
      end
    end
  end
end
