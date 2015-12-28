class PinsController < ApplicationController
	before_action :find_pin , only: [:show, :edit, :destroy, :update, :upvote, :downvote]
	before_action :authenticate_user!, except: [:show, :index]
	def index
		@pins = Pin.all.order("created_at DESC")
	end
	def new 
		@pin = current_user.pins.build
	end
	def create
		@pin = current_user.pins.build(pin_params)
		if @pin.save
			redirect_to @pin , notice: "Successfully created new pin"
		else 
			render 'new'
		end
	end
	def show
		@pin=find_pin
	end
	def edit

	end
	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end
	def downvote
		@pin.downvote_from current_user
		redirect_to :back
	end
	def update
		@pin = find_pin
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Pin updated Successfully"
		else
			render 'edit'
		end	
	end
	def destroy
		@pin = find_pin
		@pin.destroy
		redirect_to root_path
	end

	private
	def pin_params
		params.require(:pin).permit(:title,:description, :image)
	end
	def find_pin
		@pin = Pin.find(params[:id])
	end
end
