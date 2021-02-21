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

    budget&.amount || 0
  end
end
