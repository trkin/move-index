class DisciplineHappening < ApplicationRecord
  extend Mobility
  translates :name, :description

  FIELDS = %i[name description gender distance_m elevation_m max_time_s age_min age_max price_without_discount_cents start_time].freeze

  attr_accessor :existing_or_new

  belongs_to :discipline
  accepts_nested_attributes_for :discipline
  belongs_to :happening

  has_many :discipline_happening_tags, dependent: :destroy

  enum gender: %i[any man women]

  def default_name
    return if discipline.blank?

    "#{discipline.name} #{age_min} #{age_max} #{distance_m} #{gender}"
  end

  def full_name
    if gender == 'any'
      "#{name} #{age_min} #{age_max}"
    else
      "#{name} #{age_min} #{age_max} #{distance_m} #{gender}"
    end
  end
end
