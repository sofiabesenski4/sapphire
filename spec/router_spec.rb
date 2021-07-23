require "./lib/router"
require "pry"
RSpec.describe Router do
  describe("#call") do
    let(:router) { described_class.new }
    let(:env) { {"REQUEST_METHOD"=>"GET", "REQUEST_PATH"=>"/big/long/path"} }
    subject { router.call(env) }

    it "responds" do
      router.get('/big/long/path') { "Hello World" }
      expect(subject).to eq("Hello World")
    end


  end
end
