module ApplicationHelper
  def login_logout_path
    if current_user
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end

  def join_dashboard_path
    if current_user
      link_to "Logged in as #{current_user.name}", dashboard_path
    else
      link_to "Join", new_user_path
    end
  end

  def format_currency(price)
    number_to_currency(price, unit: "$")[0...-3]
  end

  def format_date(date)
    date.strftime("%B %d, %Y")
  end
end
