User.all.destroy_all
Message.all.destroy_all
Appwarning.all.destroy_all
puts "🧹 cleaned successfully"
bot = User.create({
    email: 'bot@gmail.com',
    password_digest: '123IAMBOT',
})
puts "🤖 BOT initialized successfully"
Message.create({user_id: bot.id, message: 'Welcome to Invite Me!'})
#Group.create(user_id: bot.id, group_name: 'Public Chat', group_code: 'PUBLIC')
puts "🌱 seeding successfull"