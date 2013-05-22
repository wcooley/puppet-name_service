#! /usr/bin/env ruby -S rspec

require 'spec_helper'
require 'pp'

describe Puppet::Type.type(:name_service).provider(:nsswitch) do

  it "should have a prefetch method" do
    Puppet::Type.type(:name_service).provider(:nsswitch).should respond_to(:prefetch)
  end

  it "should have an instances method" do
    Puppet::Type.type(:name_service).provider(:nsswitch).should respond_to(:instances)
  end

end
