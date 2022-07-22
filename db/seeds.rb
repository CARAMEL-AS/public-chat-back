def genCode
    chars = '0123456789QWERTYUIOPASDFGHJKLZXCVBNM'
    code = ''
    6.times do |i| code += chars[rand(0...chars.length)] end
    code
end

def getAllIds(myId)
    ids = []
    User.all.length.times do |userIndex|
        if User.all[userIndex].id != myId
            ids.push(User.all[userIndex].id)
        end
    end
    ids
end

firebase = Firebase::Client.new('https://invite-me-9a07f-default-rtdb.firebaseio.com')
User.all.destroy_all
Group.all.destroy_all
Message.all.destroy_all
Appwarning.all.destroy_all
Accverify.all.destroy_all
Setting.all.destroy_all
firebase.delete('', {
    'users' => '',
    'chats' => '',
})
puts "🧹 cleaned successfully"

aftab = User.create({
    email: 'aftab@gmail.com',
    password_digest: '123ABC',
    username: 'Aftab Sidhu',
    image: 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/28.png'
})
Accverify.create({user_id: aftab.id, code: genCode, verified: true})
Setting.create({user_id: aftab.id})
puts "😊 admin initialized successfully"

bot = User.create({
    email: 'bot@chat-app.com',
    password_digest: '123IAMBOT',
    username: 'Chat App BOT',
    image: 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/29.png'
})
Accverify.create({user_id: bot.id, code: genCode, verified: true})
Setting.create({user_id: bot.id})
puts "🤖 BOT initialized successfully"

group = Group.create({admin: bot.id, member: aftab.id})
message = Message.create({user_id: bot.id, message: 'Welcome to Invite Me!', group_id: group.id})
message2 = Message.create({user_id: aftab.id, message: 'Thank You!', group_id: group.id})

firebase.update('', {
    "users/#{bot.id}" => bot,
    "users/#{aftab.id}" => aftab,
    "chats/#{group.id}/" => {
        id: group.id,
        admin: group.admin,
        members: group.member,
        messages: [message, message2]
    }
})
puts "🌱 seeding successfull"