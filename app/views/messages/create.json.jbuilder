json.set! :id, @message.id
json.set! :sender_id, @message.user.id
json.set! :receiver_id, @message.receiver_id
json.set! :content, @message.content
json.set! :created_at, @message.created_at&.strftime("%H : %M")
