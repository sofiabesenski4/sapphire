require "./lib/router"
require "pry"
RSpec.describe Router do
  describe("#call") do
    let(:router) { described_class.new }
    let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/users/sofia/element/2"} }
    subject { router.call(env) }

    it "responds" do
      router.get("/users/:slug/element/:id") { |req| "Hello #{req.params[:slug]} at element #{req.params[:id]}" }
      expect(subject.content).to eq("Hello sofia at element 2")
      expect(subject.status).to eq(200)
    end

    context "when the route doesn't exist" do
      it "responds with a 404 fallback page when default not set" do
        expect(subject.content).to eq("Not found")
        expect(subject.status).to eq(404)
      end

      it "responds with a defined 404 fallback when specified" do
        router.not_found { |req| "Special fallback: not found #{req}" }
        expect(subject.content).to eq("Special fallback: not found /users/sofia/element/2")
        expect(subject.status).to eq(404)
      end
    end
  end
end
