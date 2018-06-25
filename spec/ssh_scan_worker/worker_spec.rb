require 'spec_helper'
require 'ssh_scan_worker/worker'

describe SSHScan::Worker do

  before :each do
    @opts = {
      "server" => "127.0.0.1",
      "scheme" => "http",
      "verify" => "false", # this is done for testing/development purposes, the expectation is that you will be setting this to true in a production setup
      "port" => 8000,
      "token" => "EXAMPLE_API_TOKEN",  # this is done for testing/development purposes, the expectation is that you will be setting this to a real API token in a production setup
      "poll_interval" => 10,
    }
  end

  it "should error if server is not specified" do
    @opts.delete("server")
    expect{SSHScan::Worker.new(@opts)}.to raise_error("API server not specified")
  end

  it "should error if scheme is not specified" do
    @opts.delete("scheme")
    expect{SSHScan::Worker.new(@opts)}.to raise_error("API scheme not specified")
  end

  it "should error if verify is not specified" do
    @opts.delete("verify")
    expect{SSHScan::Worker.new(@opts)}.to raise_error("API verify not specified")
  end

  it "should error if token is not specified" do
    @opts.delete("token")
    expect{SSHScan::Worker.new(@opts)}.to raise_error("API auth token not specified")
  end

  it "should have overridden poll poll_interval" do
    worker = SSHScan::Worker.new(@opts)
    expect(worker.instance_variable_get(:@poll_interval)).to be(@opts["poll_interval"])
  end

  it "should have defaults set for the non-essentials" do
    worker = SSHScan::Worker.new(@opts)
    expect(worker.instance_variable_get(:@logger)).to be_a(Logger)
    expect(worker.instance_variable_get(:@poll_restore_interval)).to be(5)
    expect(worker.instance_variable_get(:@worker_id)).to match(/[\w]{8}\-[\w]{4}\-[\w]{4}\-[\w]{4}\-[\w]{12}/)
  end
end