require File.dirname(__FILE__) + '/../../spec_helper'

describe "/signatures/index" do
  before(:each) do
    @signatures = []
    @petition = mock_model(Petition, :name => "name", 
      :description => "description", :signatures => @signatures)
    assigns[:petition] = @petition
  end

  it "should have a form for submitting a new signature" do
    render 'signatures/index'
    response.should have_tag('form[action=?]', petition_signatures_path(@petition))
  end

  it "should show the full list of all signatures" do
    @petition.should_receive(:signatures).at_least(1).times.and_return(@signatures)
    render 'signatures/index'
  end

  it "should show an error message if invalid data was submitted previously" do
    flash[:error] = "Please check the form for errors"
    render 'signatures/index'
    response.should have_tag('div#messages')
  end
end

