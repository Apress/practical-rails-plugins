require File.dirname(__FILE__) + '/../spec_helper'

module SignatureSpecHelper
  def valid_signature_attributes
    { :name => "Alan Washburne",
      :email => "alan@acceleratedrails.com",
      :petition_id => 1,
      :comment => "Best. Show. Ever." }
  end
end

describe Signature do
  include SignatureSpecHelper

  before(:each) do
    @signature = Signature.new
  end

  it "should be valid" do
    @signature.attributes = valid_signature_attributes
    @signature.should be_valid
  end

  it "should require a name" do
    @signature.attributes = valid_signature_attributes.except(:name)
    @signature.should_not be_valid
    @signature.should have(1).error_on(:name)
    @signature.errors.on(:name).should == "can't be blank"
  end

  it "should require an email" do
    @signature.attributes = valid_signature_attributes.except(:email)
    @signature.should_not be_valid
    @signature.should have(1).error_on(:email)
    @signature.errors.on(:email).should == "can't be blank"
  end

  it "should require a petition id" do
    @signature.attributes = valid_signature_attributes.except(:name)
    @signature.should_not be_valid
    @signature.should have(1).error_on(:name)
    @signature.errors.on(:name).should == "can't be blank"
  end

  it "should require a unique email to this petition" do
    @signature.attributes = valid_signature_attributes
    @signature.save
    @signature = Signature.new(valid_signature_attributes.merge(:petition_id => 2))
    @signature.should be_valid
    @signature.petition_id = 1
    @signature.should_not be_valid
    @signature.should have(1).error_on(:email)
    @signature.errors.on(:email).should == "has already been taken"
  end

  it "should belong to a petition" do
    Signature.reflect_on_association(:petition).should_not be_nil
  end
end
