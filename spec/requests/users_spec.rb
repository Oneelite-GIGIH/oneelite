require 'rails_helper'

RSpec.describe "Users", type: :request do
  context "User Controller" do
    describe "GET /new" do
      it "returns http success" do
        get "/users/new"
        expect(response).to have_http_status(:success)
      end
    end

    describe "Get /current/user" do
      it "[controller.user.2] it should get current user" do
        get "/current/user"
        expect(response).to have_http_status(:success)
      end
    end

  end
end
