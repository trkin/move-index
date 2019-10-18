class ClubsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[search]
  before_action :_set_club, except: %i[index search]

  def index
    @datatable = ClubsDatatable.new view_context
  end

  def search
    render json: ClubsDatatable.new(view_context)
  end

  def show
    view_context.params.merge! HappeningsForClubDatatable.param_set 'happenings.start_date', Time.zone.today..(Time.zone.today + 1.year)
    @datatable = HappeningsForClubDatatable.new view_context
  end

  def search_happenings
    render json: HappeningsForClubDatatable.new(view_context)
  end

  def _set_club
    @club = Club.find params[:id]
  end
end
