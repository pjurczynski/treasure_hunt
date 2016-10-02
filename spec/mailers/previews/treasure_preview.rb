# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/treasure
class TreasurePreview < ActionMailer::Preview
  def found
    TreasureMailer.found('winner@example.com', 1)
  end
end
