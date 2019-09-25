require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com') }
    let(:task_a) { FactroyBot.create(:task, name: '最初のタスク', user: user_a) }
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', wtih: login_user.password
      click_button 'ログインする'
    end

    shared_example_for 'ユーザAが作成したタスクが表示される' do
      it { expect(page).to have_content '最初のタスク'}
    end

    describe '一覧表示機能' do
      context 'ユーザAがログインしているとき' do
        let(:login_user) { user_a }
        it_behaves_like 'ユーザAが作成タスクが表示される'
        end
      end

      context 'ユーザBがログインしているとき' do
        let(:login_user) { user_b }
        it 'ユーザAが作成したタスクが表示されない' do
          expect(page).to have_no_content '最初のタスク'
        end
      end
    end

    describe '詳細表示機能' do
      context 'ユーザAがログインしているとき' do
        let(:login_user) {user_a}

        before do
          visit task_path(task_a)
        end

        it_behaves_like 'ユーザAが作成したタスクが表示される'
        end
      end
    end
  end
end