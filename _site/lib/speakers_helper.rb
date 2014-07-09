# encoding: UTF-8
module SpeakersHelper

  def speakers

    @items.select { |item|
      item.identifier.split('/')[1] === 'speakers'
    }
  end

end

include SpeakersHelper