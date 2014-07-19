class User < ActiveRecord::Base
	has_many :questions
	has_many :answers
	has_secure_password

	validates :username, presence: true, uniqueness: { case_sensitive: false },
						length: { in: 4..12},
						format: { with: /\A[a-z][a-z0-9]*\z/, message: 'can only contain lowercase letters and numbers.' }

	validate :password, length: { in: 4..8 }
	validate :password_confirmation, length: { in: 4..8 }

	def your_questions(params)
		questions.order('created_at DESC').paginate(page: params[:page], per_page: 3)
	end
end
