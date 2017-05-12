class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
        
        if @post.save
           flash[:success] = "Your post has been created!"
		   redirect_to posts_path
	    else 
	       flash.now[:alert] = "Your post has not been successfully created"
	       render :new
	    end
	end


	def show
		
	end

	def edit
		
	end

	def update
		
		if @post.update(post_params)
			flash[:success] = "Your Post has been updated!"
		    redirect_to posts_path
		else
			flash.now[:alert] = "Update failed!"
			render :edit
		end
	end

	def destroy
		
		if @post.destroy
			flash[:success] ="Your Post has been successfully terminated"
		    redirect_to posts_path
		else
			flash.now[:alert] = "Could not destroy that, sorry"
			render :edit
		end
	end


	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end
end
