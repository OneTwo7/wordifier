class RelationshipsController < ApplicationController

	before_action :logged_in_user

	def create
		@word = Word.find(params[:word_id])
		current_user.add(@word)
		respond_to do |format|
			format.html { redirect_to words_path }
			format.js
		end
	end

	def destroy
		@word = Relationship.find(params[:id]).word
		current_user.remove(@word)
		respond_to do |format|
			format.html { redirect_to words_path }
			format.js
		end
	end

end
