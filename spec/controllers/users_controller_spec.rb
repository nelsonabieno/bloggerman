require 'rails_helper'
let (:users)  { create(:user, 5) }

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns all the users" do
      get '/users'
      expect(response).to have_http_status(200)
    end
  end
end
