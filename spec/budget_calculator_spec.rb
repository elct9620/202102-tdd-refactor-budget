# frozen_string_literal: true

require 'budget_calculator'

RSpec.describe BudgetCalculator do
  let(:repo) { instance_double(BudgetRepo) }
  subject(:calculator) { described_class.new(repo) }

  describe '#query' do
    let(:start_at) { Date.parse('2021/1/1') }
    let(:end_at) { Date.parse('2021/1/1') }
    subject(:query) { calculator.query(start_at, end_at) }

    it { is_expected.to be(0) }
  end
end
