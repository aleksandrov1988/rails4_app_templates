module ErrorMessagesHelper
  def error_messages_for(object)
    render 'error_messages_for', object: object
  end

  def error_messages_for_attr(object, attr)
    render 'error_messages_for_attr', object: object, attr: attr
  end
end