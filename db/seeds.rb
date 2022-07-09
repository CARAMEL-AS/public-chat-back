
User.all.destroy_all
puts "🧹 cleaned successfully"
bot = User.create({
    email: 'bot@gmail.com',
    password_digest: '123IAMBOT',
})
puts "🤖 BOT initialized successfully"
#Group.create(user_id: bot.id, group_name: 'Public Chat', group_code: 'PUBLIC')
puts "🌱 seeding successfull"