class PhotosController < ApplicationController

    # Action to delete a photo
    def destroy
      # Find the photo by ID, ensuring it belongs to the current user
      @photo = current_user.photos.find_by(id: params[:id]) 
  
      if @photo
        # Delete the photo if found
        @photo.destroy 
        respond_to do |format|
          # Respond with JSON or HTML depending on the request format
          format.json { render json: { success: true }, status: :ok }
          format.html { redirect_to user_path(current_user), notice: "Photo deleted successfully." }
        end
      else
        respond_to do |format|
          # Handle error if the photo is not found or unauthorized
          format.json { render json: { success: false, error: "Photo not found or unauthorized" }, status: :unprocessable_entity }
          format.html { redirect_to user_path(current_user), alert: "You are not authorized to delete this photo." }
        end
      end
    end
  
    # Action to fetch comments for a photo
    def comments
      # Find the photo by ID
      @photo = Photo.find(params[:id]) 

      # Load comments, including user info, ordered by creation date
      @comments = @photo.comments.includes(:user).order(created_at: :desc) 
  
      # Render the comments as JSON with associated user email included
      render json: @comments.as_json(include: { user: { only: :email } })
    end
  
    # Action to show details of a specific photo
    def show
      # Find the photo by ID
      @photo = Photo.find(params[:id]) 

      # Load photos of users followed by the current user
      @followed_users_photos = current_user.followed_users.includes(:photos).map do |user|
        {
          user: user,                                      # Include user details
          photos: user.photos.order(created_at: :desc)     # Include user's photos, ordered by creation date
        }
      end
    end
  
    # Action to upload a new photo
    def create
      if params[:photo].nil?
        # Handle case where no photo is uploaded
        flash[:alert] = "Please upload a photo"
        redirect_to :back
      else
        @photo = current_user.photos.new(photo_params)                    # Initialize a new photo belonging to the current user
        if @photo.save
          flash[:notice] = "Successfully uploaded a photo"                # Success message
        else
          flash[:alert] = "Failed to upload photo. Please try again."     # Error message
        end
        redirect_to user_path(current_user)                               # Redirect to the user's profile page
      end
    end
  
    # Action to render the photo upload form
    def new
      # Initialize a new photo object for the form
      @photo = Photo.new 
    end
  
    private
  
    # Strong parameters to whitelist attributes for photo creation
    def photo_params
      # Allow only the image and title attributes
      params.require(:photo).permit(:image, :title) 
    end
  end  