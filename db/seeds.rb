User.all.destroy_all
puts "🧹 cleaned successfully"
bot = User.create({
    email: 'bot@gmail.com',
    password_digest: '123IAMBOT',
})
puts "🤖 BOT initialized successfully"
Message.create({user_id: bot.id, message: 'Welcome to Invite Me!'})
Appwarning.create({user_id: bot.id})
#Group.create(user_id: bot.id, group_name: 'Public Chat', group_code: 'PUBLIC')
puts "🌱 seeding successfull"