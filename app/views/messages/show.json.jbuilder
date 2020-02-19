json.messages do

json.array!(@my_messages) do |message|
  json.id message.id
  json.my_receiver_id  message.receiver_id
  json.my_sender_id message.user.id
  json.my_content message.content
  json.created_at message.created_at
  json.t_created_at message.created_at&.strftime("%H : %M")
end

json.array!(@matched_user_messages) do |message|
  json.id message.id
  json.matched_receiver_id message.receiver_id
  json.matched_sender_id message.user.id
  json.matched_content message.content
  json.created_at message.created_at
  json.t_created_at message.created_at&.strftime("%H : %M")
end

end
