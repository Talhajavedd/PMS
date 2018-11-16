class WelcomeController < ApplicationController
  def index
    @max_earning_projects = Project.left_outer_joins(:payments).group(:name).order("sum(payments.amount) DESC").first(5)
    @min_earning_projects = Project.left_outer_joins(:payments).group(:name).order("sum(payments.amount)").first(5)

    @payments = Project.joins(:payments).group(:name).where(payments: {created_at: Date.today.beginning_of_month..Date.today.end_of_month} ).sum(:amount)
    @time_logs = Project.joins(:time_logs).group(:name).where(time_logs: {created_at: Date.today.beginning_of_month..Date.today.end_of_month} ).sum(:hours)
  end
end
