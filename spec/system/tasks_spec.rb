require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザAがログインしているとき' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', wtih: 'password'
        click_button 'ログインする'
      end

      it 'ユーザAが作成タスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザBがログインしているとき' do
      before do
        FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com')
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', wtih: 'password'
        click_button 'ログインする'
      end

      it 'ユーザAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
end