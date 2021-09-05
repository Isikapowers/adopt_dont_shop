require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  describe "Approve Application" do
    it "has a button to approve" do
      visit "/admin/applications"

      expect(page).to have_button("Approve")
    end

    it "takes an admin bacl to admin_application and see no approve button" do
      visit "/admin/applications"

      expect(page).to_not have_button("Approve")
      expect(current_path).to eq("/admin/applications")
    end  
  end
end
