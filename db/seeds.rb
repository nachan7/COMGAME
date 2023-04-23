Admin.create!(
    email: 'admin@example.com',
    password: '2023comgame'
    )

categories = Category.create!(
    [
      {id: '1', name: 'PC'},
      {id: '2', name: 'Switch'},
      {id: '3', name: 'スマホ'},
      {id: '4', name: 'PS5'},
      {id: '5', name: 'PS4'},
      {id: '6', name: 'Xbox'},
      {id: '7', name: 'その他'}
    ]
    )

members = Member.create!(
    id: '1',
    email: 'test@example.com',
    name: 'テストユーザー',
    password: 'testuser'
    )

members = Member.create!(
    id: '2',
    email: 'customer@example.com',
    name: 'テスト会員',
    password: 'customer',
    gender: '非公開',
    introduction: 'テスト会員といいます。よろしくお願いします。',
    playstyle: 'エンジョイ',
    gamerank: 'なし',
    voicechat: 'なし',
    playtime: '基本的に夜'
    )



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
