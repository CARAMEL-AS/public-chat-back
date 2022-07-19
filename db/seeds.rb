def genCode
    chars = '0123456789QWERTYUIOPASDFGHJKLZXCVBNM'
    code = ''
    6.times do |i| code += chars[rand(0...chars.length)] end
    code
end

firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
User.all.destroy_all
Message.all.destroy_all
Appwarning.all.destroy_all
firebase.update('', {
    'users' => '',
    'messages' => ''
})
puts "🧹 cleaned successfully"
bot = User.create({
    email: 'bot@chat-app.com',
    password_digest: '123IAMBOT',
    username: 'Chat App BOT'
})
Accverify.create({user_id: bot.id, code: genCode, verified: true})
Setting.create({user_id: bot.id})
puts "🤖 BOT initialized successfully"
botMessage = Message.create({user_id: bot.id, message: 'Welcome to Invite Me!'})
firebase.update('', {
    'users/default' => bot,
    'messages/default' => botMessage
})
puts "🌱 seeding successfull"