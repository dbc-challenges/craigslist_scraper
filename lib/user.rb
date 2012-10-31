class User
	attr_reader :first_name, :last_name, :email, :account_creation_date

	def initialize(first_name, last_name, email, account_creation_date)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@account_creation_date = account_creation_date
	end

	def to_hash
		{"user_hash" => {"first_name" => self.first_name, "last_name" => self.last_name, "email" => self.email, "account_creation_date" => self.account_creation_date}}
	end
end