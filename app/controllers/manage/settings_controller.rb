class Manage::SettingsController < Manage::BaseController


  before_filter :get_details

  def show

  end

  def update
    Settings.host = params[:host]
    Settings.site_title = params[:site_title]
    Settings.site_description = params[:site_description]
    #Settings.site_theme = params[:site_theme]
    Settings.uses_books = !params[:uses_books].blank?
    Settings.uses_blog = !params[:uses_blog].blank?
    Settings.uses_facebook = !params[:uses_facebook].blank?
    Settings.uses_twitter = !params[:uses_twitter].blank?
    Settings.uses_ads = !params[:uses_ads].blank?
    Settings.uses_ga = !params[:uses_ga].blank?

    Settings.facebook_page = params[:facebook_page]
    Settings.facebook_app_id = params[:facebook_app_id]
    Settings.facebook_app_secret = params[:facebook_app_secret]
    Settings.facebook_page_id = params[:facebook_page_id]
    Settings.facebook_page_access_token = params[:facebook_page_access_token]
    Settings.facebook_access_token = params[:facebook_access_token]

    Settings.twitter_username = params[:twitter_username]
    Settings.twitter_password = params[:twitter_password]

    Settings.ads_code = params[:ads_code]
    Settings.ga_id = params[:ga_id]

    Settings.save!
    Settings.reload!

    redirect_to manage_settings_url
  end


  protected

  def get_details
    @themes = ['black','blue','red','yellow','green']
  end


end

