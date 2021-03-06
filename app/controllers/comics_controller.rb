class ComicsController < ApplicationController

  before_filter :get_linked

  def index
    @comics = Comic.available.latest.limit(10)
    @comic = @comics.first

    respond_to do |format|
      format.html do
        get_calendar
      end
      format.rss  { render :layout => false }
      format.atom { render :layout => false }
    end
  end

  def archive
    @comics = Comic.group(&:"YEAR(publish_date)").available.group(&:"MONTH(publish_date)").order("publish_date desc")
  end

  def tagged
    @tag = Tag.find_by_name params[:tag]
    redirect_to root_url unless @tag
    @comics = @tag.comics.available.group(&:"YEAR(publish_date)").group(&:"MONTH(publish_date)").order("publish_date asc")
  end

  def show
    if params[:id]
      @comic = Comic.find(params[:id])
    else
      @comic = Comic.available.latest.first
    end
    get_calendar
  end

  def show_by_day
    @date = Date.parse "#{params[:day]}-#{params[:month]}-#{params[:year]}"
    @comic = Comic.available.where(:publish_date => @date).first || nil
    get_calendar
  end

  protected

  def get_linked
    @first  = Comic.oldest.available.first
    @latest = Comic.latest.available.first
  end

  def get_calendar
    today = Date.today
    unless @date
      if @comic
        @date = @comic.publish_date
      else
        @date = today
      end
      @date = today if @comic.publish_date > today
    end
    @comics_for_month = {}
    Comic.for_month(Date.new(@date.year, @date.month)).available.each do |c|
      @comics_for_month[c.publish_date.day] = c
    end
    @first_day = Date.new(@date.year, @date.month).wday - 1
    @num_days = Time.days_in_month(@date.month)
  end

end
