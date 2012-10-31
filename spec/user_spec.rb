require '../lib/user'

describe User do
	let(:user){ User.new("Howard", "Snoot", "hsnoot@gmail.com", "2012-10-30 20:21:31 -0700") }

	context '#initialize' do
		it "has a first name" do
			user.first_name.should eq("Howard")
		end

		it "has last name" do
			user.last_name.should eq("Snoot")
		end

		it "has an email address" do
			user.email.should eq("hsnoot@gmail.com")
		end

		it "has an account creation date" do
			user.account_creation_date.should eq("2012-10-30 20:21:31 -0700")
		end
	end	
end