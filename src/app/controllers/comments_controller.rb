class CommentsController < ApplicationController
    def index
      @photo = Photo.find(params[:photo_id])
      @comments = @photo.comments.order(created_at: :desc).limit(3)

      respond_to do |format|
        format.js
      end
    end
  
    # Action to create a new comment for a photo
    def create
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        respond_to do |format|
          format.html { redirect_to user_path(@photo.user), notice: 'Comment added successfully!' }
          format.js   # Renders comments.js.erb
        end
      else
        respond_to do |format|
          format.html { redirect_to user_path(@photo.user), alert: 'Failed to add comment.' }
          format.js { render js: "alert('Failed to add comment.');" }
        end
      end
    end
  
    # Action to delete a comment
    def destroy
      @comment = Comment.find(params[:id])  # Find the comment by its ID
      @photo = @comment.photo               # Get the associated photo
  
      # Check if the current user is authorized to delete the comment (either the comment author or photo owner)
      if current_user == @comment.user || current_user == @photo.user
        # Delete the comment
        @comment.destroy 
        respond_to do |format|
          format.html do
            # Success message for HTML requests
            flash[:notice] = "Comment deleted successfully!"
            redirect_to user_path(@photo.user)
          end
          format.json do
            # Success response for JSON requests
            render json: { success: true }, status: :ok
          end
        end
      else
        respond_to do |format|
          format.html do
            # Error message for unauthorized HTML requests
            flash[:alert] = "You are not authorized to delete this comment."
            redirect_to user_path(@photo.user)
          end
          format.json do
            # Error response for unauthorized JSON requests
            render json: { success: false, error: "Unauthorized" }, status: :unauthorized
          end
        end
      end
    end
  
    # Action to fetch and return comments for a photo via JavaScript
    def comments
      @photo = Photo.find(params[:id])                     # Find the photo by its ID
      @comments = @photo.comments.order(created_at: :desc) # Fetch comments, ordered by creation date in descending order
  
      respond_to do |format|
        # Render the associated JavaScript view (comments.js.erb)
        format.js 
      end
    end
  
    private
  
    # Strong parameters to whitelist comment attributes
    def comment_params
      # Allow only the text attribute for comments
      params.require(:comment).permit(:text) 
    end
  end  