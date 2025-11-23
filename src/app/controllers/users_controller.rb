class UsersController < ApplicationController
    # Action to create a new user
    def create
      @user = User.new(user_params)    # Initialize a new user with parameters
      @user.valid?                     # Validate the user object without saving
  
      # Check if the provided email is properly formatted
      if !@user.is_email?
        flash[:alert] = "Input a properly formatted email."
        # Redirect to the previous page
        redirect_to :back 
      
      # Check for errors related to the email field
      elsif @user.errors.messages[:email] != nil
        flash[:notice] = "That email " + @user.errors.messages[:email].first
        # Redirect to the previous page
        redirect_to :back

      # Save the user if no errors exist and email is valid
      elsif @user.save
        flash[:notice] = "Signup successful. Welcome to the site!"
        # Log the user in by setting the session ID
        session[:user_id] = @user.id 
        # Redirect to the user's profile page
        redirect_to user_path(@user) 

      else
        # Handle any other errors during the save process
        flash[:alert] = "There was a problem creating your account. Please try again."
        # Redirect to the previous page
        redirect_to :back 
      end
    end
  
    # Action to render the signup form
    def new
    end
  
    # Action to show a user's profile
    def show
      @user = User.find(params[:id])   # Find the user by ID
      @all_users = User.all            # Fetch all users for display or other purposes
  
      # Fetch the user's photos, ordered by creation date in descending order
      @photos = @user.photos.order(created_at: :desc)
  
      # If the current user is viewing their own profile
      if current_user == @user
        # Fetch photos from followed users, ordered by creation date in descending order
        @followed_photos = current_user.followed_users.includes(:photos).flat_map(&:photos).sort_by(&:created_at).reverse
        # Initialize a new comment object for form use
        @comment = Comment.new
      else
        # If the user is viewing another user's profile, no followed photos are shown
        @followed_photos = []
        # Initialize a new comment object for form use
        @comment = Comment.new
      end
    end
  
    # Action to follow another user
    def follow
      # Find the user to follow by ID
      user_to_follow = User.find(params[:id]) 

      # Check if the user is already followed
      if current_user.followed_users.include?(user_to_follow)
        flash[:alert] = "You are already following this user."
      else
        # Add the user to the current user's followed list
        current_user.followed_users << user_to_follow
        flash[:notice] = "You are now following #{user_to_follow.email}!"
      end
      # Redirect to the current user's profile page
      redirect_to user_path(current_user) 
    end
  
    # Action to unfollow another user
    def unfollow
      # Find the user to unfollow by ID
      user_to_unfollow = User.find(params[:id])  

      # Check if the user is currently followed
      if current_user.followed_users.include?(user_to_unfollow)
        # Remove the user from the followed list
        current_user.followed_users.delete(user_to_unfollow)
        flash[:notice] = "You unfollowed #{user_to_unfollow.email}."
      else
        flash[:alert] = "You are not following this user."
      end
      # Redirect to the current user's profile page
      redirect_to user_path(current_user) 
    end
  
    private
  
    # Strong parameters to whitelist attributes for user creation or update
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
    end
  end  