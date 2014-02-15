require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "pagination" do
  after(:all) { user.microposts.delete_all unless user.microposts.nil? }
  it "should paginate the feed" do
     40.times { FactoryGirl.create(:micropost, user: user) }
    end
  end

  describe "display single micropost" do
  	let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "foo")}
  	before { visit root_path }

    it { should have_content('1 micropost')}

    describe "display two microposts" do
	  	let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "foo")}
    	before { visit root_path}
	    it { should have_content('2 microposts')}
    end
  end

  describe "micropost destruction" do
  	before { FactoryGirl.create(:micropost, user: user)}

  	describe "as correct user" do
  		before { visit root_path }

  		it "should delete a micropost" do
  			expect { click_link "delete"}.to change(Micropost, :count).by(-1)
  		end
  	end
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
end