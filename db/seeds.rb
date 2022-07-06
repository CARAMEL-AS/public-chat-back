# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
bot = User.create(name: 'Public-Chat BOT', email: 'bot@public-chat.com', last_login: Time.now)
Group.create(admin_id: bot.id, group_name: 'Public Chat', group_code: 'PUBLIC')