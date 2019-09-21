FactoryBot.define do
  factory :task do
    name{ 'テストを書く' }
    description { 'Rspec&Capybara&FacotryBotを準備する' }
    user #Use :user Factory name
  end
end