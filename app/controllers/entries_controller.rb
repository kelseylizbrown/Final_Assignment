class EntriesController < ApplicationController

  def new
    @current_user = User.find_by({ "id" => session["user_id"] })
    if @current_user == nil
      redirect_to "/login"
    end
  end

def create
  @current_user = User.find_by({ "id" => session["user_id"] })
  if @current_user != nil
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = @current_user["id"]
    @entry.save
    @entry.uploaded_image.attach(params["uploaded_image"])
    redirect_to "/places/#{@entry["place_id"]}"
  else
    redirect_to "/login"
  end
end

end
