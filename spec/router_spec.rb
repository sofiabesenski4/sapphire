require "./lib/router"
require "pry"
RSpec.describe Router do
  describe("#call") do
    let(:router) { described_class.new }
    let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/big/long/path"} }
    subject { router.call(env) }

    it "responds" do
      router.get("/big/long/path") { "Hello World" }
      expect(subject.content).to eq("Hello World")
      expect(subject.status).to eq(200)
    end

    context "when the route doesn't exist" do
      it "responds with a 404 fallback page when default not set" do
        expect(subject.content).to eq("Not found")
        expect(subject.status).to eq(404)
      end

      it "responds with a defined 404 fallback when specified" do
        router.not_found { |req| "Special fallback: not found #{req}" }
        expect(subject.content).to eq("Special fallback: not found /big/long/path")
        expect(subject.status).to eq(404)
      end
    end
  end
end
