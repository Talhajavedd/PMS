class WelcomeController < ApplicationController
  def index
    @max_payment_projects = Project.includes(:client).max_five_projects
    @least_payment_projects = Project.includes(:client).min_five_projects

    @payments = Project.current_month_payments
    @time_logs = Project.current_month_time_logs
  end
end
