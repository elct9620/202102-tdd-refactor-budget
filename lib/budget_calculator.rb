# frozen_string_literal: true

require 'date'
require 'budget'
require 'budget_repo'

class BudgetCalculator
  def initialize(repo)
    @repo = repo
  end

  def query(start_at, end_at)
    return 0 if start_at > end_at

    budgets = @repo.get_all
    budget = budgets.find do |budget|
      budget.year_month == start_at.strftime('%Y%m') ||
        budget.year_month == end_at.strftime('%Y%m')
    end

    return 0 if budget.nil?

    budget_first_day = Date.parse("#{budget.year_month}01")
    budget_last_day = budget_first_day.next_month.prev_day
    days_in_month = budget_last_day.mjd - budget_first_day.mjd + 1
    days_in_query = end_at.mjd - start_at.mjd + 1
    daily_amount = budget.amount / days_in_month

    daily_amount * days_in_query
  end
end
