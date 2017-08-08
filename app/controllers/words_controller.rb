class WordsController < ApplicationController

	before_action :find_word,      only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:new, :create]
	before_action :admin_user,     only: [:edit, :update, :destroy]

	def index
		@title = "All words"
		unless logged_in? and !params[:list].nil?
			@words = Word.paginate(page: params[:page])
		else
			@words = current_user.send(params[:list]).paginate(page: params[:page])
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
		respond_to do |format|
			format.html
			format.js
		end
	end

	def new
		@word = Word.new
	end

	def create
		@word = Word.new(word_params)
		if @word.save
			flash[:success] = "New word added"
			redirect_to words_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @word.update_attributes(word_params)
			flash[:success] = "Word updated"
			redirect_to @word
		else
			render 'edit'
		end
	end

	def destroy
		@word.destroy
		flash[:success] = "Word deleted"
		redirect_to words_path
	end

	def study
		if session[:words_ids].nil?
			ids = current_user.words_to_study.pluck(:id)
			unless ids.empty?
				to_study_ids = ids.shuffle[0...20]
				session[:words_ids] = to_study_ids
				@word = Word.find(to_study_ids.first)
			end
		else
			if params[:button].nil?
				@word = Word.find(session[:words_ids].first)
			else
				to_study_ids = session[:words_ids]
				rel = current_user.relationships.find_by(word_id: to_study_ids.first)
				rel.study(params[:button])
				unless to_study_ids.length == 1
					session[:words_ids] = to_study_ids[1..-1]
					@word = Word.find(session[:words_ids].first)
				else
					session.delete(:words_ids)
				end
			end
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	private

		def word_params
			params.require(:word).permit(:word, :sentence, :definition)
		end

		def find_word
			@word = Word.find(params[:id])
		end

end
