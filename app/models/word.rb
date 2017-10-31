class Word < ApplicationRecord

	has_many :relationships, dependent: :destroy
	has_many :users, through: :relationships

	before_save :downcase_word

	self.per_page = 20

	validates :word, presence: true, length: { maximum: 30 },
									 uniqueness: { case_sensitive: false }
	validates :sentence, presence: true, length: { maximum: 250 }
	validates :definition, presence: true, length: { maximum: 250 }


	private

  	# Converts word to all lower-case.
    def downcase_word
      word.downcase!
    end

end
