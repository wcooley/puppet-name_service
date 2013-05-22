#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe Puppet::Type.type(:name_service) do
  it "should have a :name param" do
    Puppet::Type.type(:name_service).attrtype(:name).should == :param
  end

  [:ensure, :lookup, :target].each do |p|
    it "should have #{p} property" do
      Puppet::Type.type(:name_service).attrtype(p).should == :property
    end
  end

end
