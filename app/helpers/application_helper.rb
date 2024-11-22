module ApplicationHelper
  def flash_class(key)
    case key
    when "notice"
      "bg-blue-100 text-blue-700" # Info messages
    when "alert", "error"
      "bg-red-100 text-red-700" # Error messages
    when "success"
      "bg-green-100 text-green-700" # Success messages
    end
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat_flash_message(message, msg_type)
    end

    if defined?(resource) && resource.errors.any?
      resource.errors.full_messages.each do |message|
        concat_flash_message(message, 'error')
      end
    end
    
    nil
  end
  
  def concat_flash_message(message, msg_type)
    concat(
      content_tag(:div, class: "fixed top-5 left-1/2 transform -translate-x-1/2 z-[60] max-w-sm w-full p-4 mb-4 rounded-lg shadow-lg #{flash_class(msg_type)} opacity-100", role: "alert", data: { controller: "flash" }) do
        concat(content_tag(:div, message, class: "text-medium font-medium text-center"))
      end
    )
  end

end
