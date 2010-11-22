class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    create_via_facebook_connect if @user.nil?
    if @user
      session[:user_id] = @user.id
    end
    if current_user
      redirect_to session[:return_to] || games_path
      session[:return_to]=nil
    else
      flash[:error] = "Unable to log you in"
      render :action=>"new"
    end
    if @user
      logger.error "[LOGIN] >>> #{@user.id}"
    end
    if current_facebook_user
      logger.error "[FB_LOGIN] >>> #{current_facebook_user.id}"
      find_friends
    end
  end
  
  def destroy
    session[:user_id]=nil
    redirect_to root_path
  end
  
  def create_via_facebook_connect
    if current_facebook_user
      #look for an existing user
      @user = User.find_by_facebook_id(current_facebook_user.id)
      if @user.nil?
        #if one isn't found, try to grab the email address and join to an existing account
        current_facebook_user.fetch
        unless current_facebook_user.email.blank?
          @user = User.find_by_email(current_facebook_user.email) 
          @user.update_attribute(:facebook_id,current_facebook_user.id) if @user
        end
      end
    end 
  end
  
  # finds Facebook friends
  def find_friends
    if current_facebook_user && @user
      client = current_facebook_client
      @friends = Mogli::User.find("#{current_facebook_user.id}/friends", client) unless (client.blank?)
      friend_ids = @friends.map &:id
      logger.error "[FRIENDS_PRE] >>> " + "#{friend_ids.join(", ")}"
      @new_friends = @user.add_new_fb_friends(@friends)
      new_friend_ids = @new_friends.map  &:id
      logger.error "[NEW_FRIENDS_WITH_APP] >>> " + "#{new_friend_ids.join(", ")}"
      return @new_friends.length
    end
  end
  
end
