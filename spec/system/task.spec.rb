require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'task_title'
        fill_in 'Content', with: 'task_content'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '降順に表示される' do
        # ここに実装する
        Task.create(title: '1', content: 'context1')
        Task.create(title: '2', content: 'context2')
        Task.create(title: '3', content: 'context3')
        visit tasks_path
        expect(Task.order("created_at DESC").map(&:title)).to eq ["3", "2", "1"]
      end
    end
  end
  describe '詳細表示機能' do
   context '任意のタスク詳細画面に遷移した場合' do
     it '該当タスクの内容が表示される' do
       @task = FactoryBot.create(:task,title: 'task1',content: 'content1')
       visit task_path(@task)
       expect(page).to have_content 'task1'
       expect(page).to have_content 'content1'
     end
   end
end
end
