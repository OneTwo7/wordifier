module ApplicationHelper

	def get_title(title="")
		base_title = "Wordifier"
		if title.blank?
			base_title
		else
			title + " | " + base_title
		end
	end

end
