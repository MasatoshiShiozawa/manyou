require 'rails_helper'
describe 'タスク管理機能', type: :system do

  before do
    visit new_user_path
    fill_in 'user_name', with: 'suzuki_test02'
    fill_in 'user_email', with: 'suzuki_test02@example.com'
    fill_in 'user_password', with: 'suzuki'
    fill_in 'user_password_confirmation', with: 'suzuki'
    click_on 'アカウントを登録する'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'task_title'
        fill_in 'Content', with: 'task_content'
        fill_in 'Deadline', with: '2020/12/11'
        select '未着手', from: 'Status'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', deadline: '2020/12/11', status: '未着手', priority: '中' )
        visit tasks_path
        expect(page).to have_content '未着手'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '降順に表示される' do
        visit new_task_path
        fill_in 'Title', with: '1'
        fill_in 'Content', with: 'content1'
        fill_in 'Deadline', with: '2020/12/11'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit new_task_path
        fill_in 'Title', with: '2'
        fill_in 'Content', with: 'content2'
        fill_in 'Deadline', with: '2020/12/11'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit new_task_path
        fill_in 'Title', with: '3'
        fill_in 'Content', with: 'content3'
        fill_in 'Deadline', with: '2020/12/11'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit tasks_path
        expect(Task.order("created_at DESC").map(&:title)).to eq ["3", "2", "1"]
      end
    end

    context '終了期限でソートした場合' do
      it 'タスクが終了期限順に並んでいる' do
        visit new_task_path
        fill_in 'Title', with: '1'
        fill_in 'Content', with: 'content1'
        fill_in 'Deadline', with: '2020/11/30'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit new_task_path
        fill_in 'Title', with: '2'
        fill_in 'Content', with: 'content2'
        fill_in 'Deadline', with: '2020/11/29'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit new_task_path
        fill_in 'Title', with: '3'
        fill_in 'Content', with: 'content3'
        fill_in 'Deadline', with: '2020/11/28'
        select '未着手', from: 'Status'
        select '中', from: 'Priority'
        click_button '登録する'
        visit tasks_path
        click_on '終了期限でソートする'
        visit tasks_path(sort_expired: "true")
        visit tasks_path
        expect(Task.order("deadline DESC").map(&:title)).to eq ["1", "2", "3"]
      end
    end
  end

  describe '詳細表示機能' do
   context '任意のタスク詳細画面に遷移した場合' do
     it '該当タスクの内容が表示される' do
       @task = FactoryBot.create(:task,title: 'task1',content: 'content1', deadline: '2020/11/30', status: '未着手', priority: '中' )
       visit task_path(@task)
       expect(page).to have_content 'task1'
       expect(page).to have_content 'content1'
     end
   end
 end

  describe '検索機能' do
   before do
     visit new_task_path
     fill_in 'Title', with: 'task1'
     fill_in 'Content', with: 'content1'
     fill_in 'Deadline', with: '2020/11/30'
     select '未着手', from: 'Status'
     select '中', from: 'Priority'
     click_button '登録する'
     visit new_task_path
     fill_in 'Title', with: 'test2'
     fill_in 'Content', with: 'content2'
     fill_in 'Deadline', with: '2020/11/29'
     select '未着手', from: 'Status'
     select '中', from: 'Priority'
     click_button '登録する'
   end
   context 'タイトルであいまい検索をした場合' do
     it "検索キーワードを含むタスクで絞り込まれる" do
       visit tasks_path
       fill_in 'task_title', with: 'task'
       click_on '検索'
       expect(page).to have_content 'task'
     end
   end

   context 'ステータス検索をした場合' do
     it "ステータスに完全一致するタスクが絞り込まれる" do
       visit tasks_path
       select "未着手", from: "task_status"
       click_on '検索'
       expect(page).to have_content '未着手'
     end
   end

   context 'タイトルのあいまい検索とステータス検索をした場合' do
     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
       visit tasks_path
       fill_in 'task_title', with: 'task'
       select "未着手", from: "task_status"
       click_on '検索'
       expect(page).to have_content 'task'
       expect(page).to have_content '未着手'
     end
   end
  end
end
