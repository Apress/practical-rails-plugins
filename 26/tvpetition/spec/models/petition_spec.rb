require File.dirname(__FILE__) + '/../spec_helper'

module PetitionSpecHelper
  def valid_petition_attributes
    { :name => "Petition to Save TAYBC",
      :description => "Please don't cancel our favorite show!" }
  end
end

describe Petition do
  include PetitionSpecHelper

  before(:each) do
    @petition = Petition.new
  end

  it "should be valid" do
    @petition.attributes = valid_petition_attributes
    @petition.should be_valid
  end

  it "should require a name" do
    @petition.attributes = valid_petition_attributes.except(:name)
    @petition.should_not be_valid
    @petition.should have(1).error_on(:name)
    @petition.errors.on(:name).should == "can't be blank"
  end

  it "should require a description" do
    @petition.attributes = valid_petition_attributes.except(:description)
    @petition.should_not be_valid
    @petition.should have(1).error_on(:description)
    @petition.errors.on(:description).should == "can't be blank"
  end

  it "should require a unique name" do
    @petition.attributes = valid_petition_attributes
    @petition.save!

    @petition = Petition.new(valid_petition_attributes)
    @petition.should_not be_valid
    @petition.should have(1).error_on(:name)
    @petition.errors.on(:name).should == "has already been taken"
  end

  it "should have many signatures" do
    Petition.reflect_on_association(:signatures).should_not be_nil
  end
end

