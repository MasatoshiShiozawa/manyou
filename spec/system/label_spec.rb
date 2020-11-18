require 'rails_helper'
describe 'ラベル登録検証', type: :system do

  before do
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    @third_label = FactoryBot.create(:third_label)
    visit new_user_path
    fill_in 'user_name', with: 'suzuki_test121'
    fill_in 'user_email', with: 'suzuki_test121@example.com'
    fill_in 'user_password', with: 'suzuki'
    fill_in 'user_password_confirmation', with: 'suzuki'
    click_on 'アカウントを登録する'
    visit tasks_path
  end

  describe '新規作成機能' do
    context '複数のラベルを付けてタスクを新規作成した場合' do
      it '作成したタスクに選択したラベルが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'task_title'
        fill_in 'Content', with: 'task_content'
        fill_in 'Deadline', with: '2020/12/11'
        select '未着手', from: 'Status'
        check "task_label_ids_#{(@label.id)}"
        check "task_label_ids_#{(@second_label.id)}"
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content 'あ'
        expect(page).to have_content 'い'
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
     check "task_label_ids_#{(@label.id)}"
     check "task_label_ids_#{(@second_label.id)}"
     click_button '登録する'
     visit new_task_path
     fill_in 'Title', with: 'test2'
     fill_in 'Content', with: 'content2'
     fill_in 'Deadline', with: '2020/11/29'
     select '未着手', from: 'Status'
     check "task_label_ids_#{(@third_label.id)}"
     select '中', from: 'Priority'
     click_button '登録する'
   end

   context 'ラベル検索をした場合' do
     it "ラベルを含むタスクで絞り込まれる" do
       visit tasks_path
       select "あ", from: "task_label_id"
       click_on '検索'
       expect(page).to have_content 'あ'
     end
   end

   context 'タイトルであいまい検索＆ラベル検索をした場合' do
     it "検索キーワードとラベルを含むタスクで絞り込まれる" do
       visit tasks_path
       fill_in 'task_title', with: 'task'
       select "あ", from: "task_label_id"
       click_on '検索'
       expect(page).to have_content 'task'
       expect(page).to have_content 'あ'
     end
   end

   context 'ステータス検索＆ラベル検索をした場合' do
     it "ステータスに完全一致し、ラベルを含むタスクが絞り込まれる" do
       visit tasks_path
       select "未着手", from: "task_status"
       select "あ", from: "task_label_id"
       click_on '検索'
       expect(page).to have_content '未着手'
       expect(page).to have_content 'あ'
     end
   end

   context 'タイトルのあいまい検索＆ステータス検索＆ラベル検索をした場合' do
     it "検索キーワードをタイトルに含み、かつステータスに完全一致し、ラベルを含むタスク絞り込まれる" do
       visit tasks_path
       fill_in 'task_title', with: 'task'
       select "未着手", from: "task_status"
       select "あ", from: "task_label_id"
       click_on '検索'
       expect(page).to have_content 'task'
       expect(page).to have_content '未着手'
       expect(page).to have_content 'あ'
     end
   end
  end
end
