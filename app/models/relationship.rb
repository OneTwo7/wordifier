class Relationship < ApplicationRecord

	belongs_to :user
	belongs_to :word

	before_create :add_study_at

	validates :points, 	 presence: true, inclusion: { in: 0..10 }

	#update relationship according to the button pressed by user
	def study (button="yeah")
		points = self.points
		intervals = []
    done = false
		if points < 4
			intervals = [2, 3]
		elsif points < 7
			intervals = [7, 11]
		elsif points < 9
			intervals = [28, 39]
		elsif points == 9
			done = true
		end
		button_to_columns = {
			"nope" => [0, Date.tomorrow],
			"yeah" => [points + 1, done ? nil : Date.current + intervals[0]],
			"easy" => [points + 1, done ? nil : Date.current + intervals[1]],
			"know" => [5, Date.current + 7]
		}
		unless done
			update_columns(
	      points:   	button_to_columns[button][0],
	      study_at: 	button_to_columns[button][1].to_datetime,
	      updated_at: Time.zone.now
	    )
		else
			user = self.user
			user.remove(self.word)
		end
	end

	private

		def add_study_at
			self.study_at = Date.current
		end

end
