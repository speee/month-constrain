require 'spec_helper'

class User < ActiveRecord::Base
  has_many :books
  acts_as_month_constrain :registration_month
end

class Book < ActiveRecord::Base
  belongs_to :user
  acts_as_month_constrain :registration_month
end

describe MonthConstrain do
  let(:column) { 'registration_month' }
  let(:base_date) { Date.parse('2016-01-01') }
  let(:delta) { 10 }
  before { User.destroy_all }
  subject { User.create(registration_month: base_date) }

  it 'has a version number' do
    expect(MonthConstrain::VERSION).not_to be nil
  end

  describe '.month_constrain' do
    [
      '2016-01',
      '2016-1',
      '2016-01-1',
      '2016-1-01',
      '2016-01-01',
      '2016-01-12',
      Time.zone.parse('2016-01-12'),
      Date.parse('2016-01-12'),
      Time.parse('2016-01-12'),
    ].each do |val|
      context "when specifies #{val} (#{val.class})" do
        before { subject.__send__("#{column}=", val) }
        it 'returns 1st' do
          expect(subject.__send__(column).day).to eq(1)
        end
      end
    end

    %w(
      aaaaaaaaaaaa
      222222222222
      2012-33-33
    ).each do |val|
      context "when specifies #{val}" do
        before { subject.__send__("#{column}=", val) }
        it 'returns nil' do
          expect(subject.__send__(column)).to eq(nil)
        end
      end
    end
  end

  describe 'scope' do
    it 'should return records [column]_in in the period', :aggregate_failures do
      [
        ['2016-01', nil, [subject]],
        ['2016-02', nil, []],
        ['2015-12', nil, [subject]],
        [nil, '2016-01', [subject]],
        [nil, '2016-02', [subject]],
        [nil, '2015-12', []],
        ['2016-01', '2016-01', [subject]],
        ['2015-12', '2016-02', [subject]],
        ['2016-02', '2015-12', []],
      ].each do |from, to, expected|
        result = User.__send__("#{column}_in", from, to)
        expect(result).to contain_exactly(*expected)
      end
    end

    it 'should return records [column]', :aggregate_failures do
      [
        ['2016-01', [subject]],
        ['2016-12', []],
        [nil, []],
      ].each do |target_date, expected|
        result = User.__send__(column.to_s, target_date)
        expect(result).to contain_exactly(*expected)
      end
    end

    context 'when duplicate column' do
      before { Book.create(registration_month: base_date, user: subject) }
      let(:users) { User.joins(:books).__send__("#{column}_in", base_date, base_date) }
      it 'returns user records' do
        expect(users).to be_present
      end
    end
  end
end
