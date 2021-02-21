# frozen_string_literal: true

require 'budget_calculator'

RSpec.describe BudgetCalculator do
  let(:budgets) { [] }
  let(:repo) { instance_double(BudgetRepo, get_all: budgets) }
  subject(:calculator) { described_class.new(repo) }

  describe '#query' do
    let(:start_at) { Date.parse('2021/1/1') }
    let(:end_at) { Date.parse('2021/1/1') }
    subject(:query) { calculator.query(start_at, end_at) }

    it { is_expected.to eq(0) }

    context 'when end_at early then start_at' do
      let(:start_at) { Date.parse('2021/1/31') }
      let(:end_at) { Date.parse('2021/1/1') }
      let(:budgets) do
        [
          Budget.new('202101', 31)
        ]
      end

      it { is_expected.to eq(0) }
    end

    context 'when query whole month' do
      let(:start_at) { Date.parse('2021/1/1') }
      let(:end_at) { Date.parse('2021/1/31') }
      let(:budgets) do
        [
          Budget.new('202101', 31)
        ]
      end

      it { is_expected.to eq(31) }
    end

    context 'when query 5 days in Jan' do
      let(:start_at) { Date.parse('2021/1/6') }
      let(:end_at) { Date.parse('2021/1/10') }
      let(:budgets) do
        [
          Budget.new('202101', 31)
        ]
      end

      it { is_expected.to eq(5) }
    end

    context 'when query two months' do
      let(:start_at) { Date.parse('2021/1/1') }
      let(:end_at) { Date.parse('2021/2/28') }
      let(:budgets) do
        [
          Budget.new('202101', 62),
          Budget.new('202102', 28)
        ]
      end

      it { is_expected.to eq(90) }
    end
  end
end
