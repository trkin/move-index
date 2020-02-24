class VenuesController < ApplicationController
  before_action :_set_venue, except: %i[index new create]

  def index
    @venues = Venue.all
  end

  def show; end

  def new
    run Venue::Operation::Create::Present
    render cell(Venue::Cell::New, @form), layout: false
    # @venue = Venue.new
    # render partial: 'form', layout: false
  end

  def edit
    render partial: 'form', layout: false
  end

  # JS
  def create
    run Venue::Operation::Create do |result|
      return redirect_to venue_path(result[:model])
    end
    render cell(Venue::Cell::New, @form), layout: false
    # @venue = Venue.new
    # update_and_render_or_redirect_in_js @venue, _venue_params, ->(id) { venue_path(id) }
  end

  # JS
  def update
    update_and_render_or_redirect_in_js @venue, _venue_params, venue_path(@venue)
  end

  def destroy
    @venue.destroy!
    redirect_to venues_path, notice: helpers.t_notice('successfully_deleted', Venue)
  end

  def _set_venue
    @venue = Venue.find params[:id]
  end

  def _venue_params
    params.require(:venue).permit(
      *Venue::FIELDS
    )
  end
end
