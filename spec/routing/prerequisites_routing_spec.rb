require "rails_helper"

RSpec.describe PrerequisitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/prerequisites").to route_to("prerequisites#index")
    end

    it "routes to #new" do
      expect(:get => "/prerequisites/new").to route_to("prerequisites#new")
    end

    it "routes to #show" do
      expect(:get => "/prerequisites/1").to route_to("prerequisites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/prerequisites/1/edit").to route_to("prerequisites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/prerequisites").to route_to("prerequisites#create")
    end

    it "routes to #update" do
      expect(:put => "/prerequisites/1").to route_to("prerequisites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/prerequisites/1").to route_to("prerequisites#destroy", :id => "1")
    end

  end
end
