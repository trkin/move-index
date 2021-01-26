class ApplicationController < ActionController::Base
  include LocaleConcern
  include Pundit
  protect_from_forgery

  # before_action :sleep_some_time

  def sleep_some_time
    sleep 2
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
  # To use, you need to initialize object and call with params and redirect path
  # redirect_path can be proc so it redirects to show page after create
  # Look for example admin/users_controller.rb
  #
  #  def new
  #    @subscriber = current_user.company.subscribers.new country: current_user.company.country
  #    render partial: 'form', layout: false
  #  end
  #  def create
  #    @subscriber = current_user.company.subscribers.new
  #    update_and_render_or_redirect_in_js @subscriber, _subscriber_params, ->(id) { subscriber_path(id) }
  #  end
  def update_and_render_or_redirect_in_js(item, item_params, redirect_path_or_proc, partial = 'form', notice = nil)
    notice ||= if item.new_record?
                 helpers.t_notice('successfully_created', item.class)
               else
                 helpers.t_notice('successfully_updated', item.class)
               end
    item.assign_attributes item_params
    # if you need some custom checks you can add errors before calling this proc
    if item.errors.blank? && item.save
      flash[:notice] = flash.now[:notice] = notice
      redirect_path = if redirect_path_or_proc.class == Proc
                        redirect_path_or_proc.call item.id
                      else
                        redirect_path_or_proc
                      end
      if redirect_path.present?
        render js: %(
          window.location.assign('#{redirect_path}');
        )
      else
        render js: %(
          window.location.reload();
        )
      end
    else
      flash.now[:alert] = item.errors.full_messages.to_sentence
      render js: %(
        var form = document.getElementById('remote-form');
        var parent = form.parentNode;
        var new_form = document.createElement('div');
        new_form.innerHTML = '#{helpers.j helpers.render(partial) + helpers.render('layouts/flash_notice_alert_jbox')}';
        parent.replaceChild(new_form, form);
      )
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
end
