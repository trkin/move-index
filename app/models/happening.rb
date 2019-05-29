class Happening < ApplicationRecord
  extend Mobility
  translates :name

  FIELDS = %i[name start_date end_date website repeating].freeze

  attr_accessor :existing_or_new

  belongs_to :venue
  accepts_nested_attributes_for :venue
  belongs_to :club, optional: true

  has_many :discipline_happenings, dependent: :destroy

  enum repeating: %i[no_repeating daily_repeating weekly_repeating yearly_repeating]

  validates :name, :start_date, :end_date, presence: true
  validate :_end_date_greater_or_equal_start_date

  before_validation :_default_values_on_create, on: :create

  def _end_date_greater_or_equal_start_date
    return if end_date.blank? || start_date.blank?
    return if end_date >= start_date

    errors.add :end_date, t('can_not_be_greater_than_item_name', item_name: Happening.human_attribute_name(:start_date))
  end

  def multi_day?
    end_date != start_date
  end

  def _default_values_on_create
    self.end_date ||= start_date
  end
end
