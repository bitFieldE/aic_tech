class MessagesChannel < ApplicationCable::Channel

  def subscribed
  #  stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  #  message = Message.create!(
  #    user_id: data['user_id'],
  #    chat_room_id: data['chat_room_id'],
  #    content: data['content']
  #  )
  #  template = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  #  ActionCable.server.broadcast 'messages_channel', template
  end

end
