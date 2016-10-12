# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_money(cents)
    sprintf("$%0.2f", cents.to_f / 100)
  end
end
