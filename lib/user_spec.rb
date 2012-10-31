require '../lib/user'

describe User do
	let(:user){ User.new }

	context '#initialize' do
		it "should be a first name" do
			user.first_name.should eq("Howard")
		end
	end	
end