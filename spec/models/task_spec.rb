require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user, name: 'suzuki_test101', email: 'suzuki_test101@example.com', password: 'suzuki', password_confirmation: 'suzuki')
        task = Task.new(title: '成功テスト', content: '成功', deadline: '2020/12/11', status: '未着手', priority: '中' , user:user)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    user = FactoryBot.create(:user, name: 'suzuki_test102', email: 'suzuki_test102@example.com', password: 'suzuki', password_confirmation: 'suzuki')
    let!(:task) { FactoryBot.create(:task, title: 'task', status: '未着手', priority: '中', user:user ) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'test2', status: '着手中', priority: '中', user:user ) }
    let!(:third_task) { FactoryBot.create(:second_task, title: 'sample3', status: '完了', priority: '中', user:user ) }

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_by_task_title('task')).to include(task)
        expect(Task.search_by_task_title('task')).not_to include(second_task)
        expect(Task.search_by_task_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_by_status('未着手')).to include(task)
        expect(Task.search_by_status('未着手')).not_to include(second_task)
        expect(Task.search_by_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_by_task_title('task')).to include(task)
        expect(Task.search_by_status('未着手')).to include(task)
        expect(Task.search_by_task_title('task').count).to eq 1
        expect(Task.search_by_status('未着手').count).to eq 1
      end
    end
  end
end
