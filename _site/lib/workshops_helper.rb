# encoding: UTF-8
module WorkshopsHelper

  def workshops

    @items.select { |item|
      parts = item.identifier.split('/')
      parts[1] === 'workshops' && parts.count > 2
    }
  end

end

include WorkshopsHelper