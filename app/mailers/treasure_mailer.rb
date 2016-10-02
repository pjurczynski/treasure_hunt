# frozen_string_literal: true
class TreasureMailer < ApplicationMailer
  def found(email, found_treasure_count)
    @found_treasure_count = found_treasure_count || 1
    mail(to: email, subject: 'Hey, you’ve found a treasure, congratulations!')
  end
end
