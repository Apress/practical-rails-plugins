require File.dirname(__FILE__) + '/../spec_helper'

describe SignaturesController do
  describe "create with a valid signature" do
    before(:each) do
      Petition.stub!(:find).and_return(
        @petition = mock_model(Petition, :name => "name", 
          :description => "description", :signatures => []))
      @petition.signatures.stub!(:build).and_return(
        @signature = mock_model(Signature, :save => true))
    end

    def do_create
      post(:create, :petition_id => @petition.id)
    end

    it "should create a new signature" do
      @signature.should_receive(:save).and_return(true)
      do_create
    end

    it "should redirect after create" do
      do_create
      response.should be_redirect
      response.should redirect_to(petition_signatures_path(@petition.id))
    end

    it "should note success in the flash" do
      do_create
      flash[:notice].should_not be_empty
    end
  end

  describe "create with an invalid signature" do
    before(:each) do
      Petition.stub!(:find).and_return(
        @petition = mock_model(Petition, :name => "name",
          :description => "description", :signatures => []))
      @petition.signatures.stub!(:build).and_return(
        @signature = mock_model(Signature, :save => false))
    end

    def do_create
      post(:create, :petition_id => @petition.id)
    end

    it "should fail to create a new signature" do
      @signature.should_receive(:save).and_return(false)
      do_create
    end

    it "should redirect after create" do
      do_create
      response.should be_redirect
      response.should redirect_to(petition_signatures_path(@petition.id))
    end

    it "should not failure in the flash" do
      do_create
      flash[:error].should_not be_empty
    end
  end

  describe "index" do
    before(:each) do
      Petition.stub!(:find).and_return(
        @petition = mock_model(Petition, :name => "name",
          :description => "description", :signatures => []))
    end

    def do_index
      get(:index, :petition_id => @petition.id)
    end

    it "should assign signatures" do
      @petition.should_receive(:signatures).and_return([])
      do_index
      assigns[:signatures].should == []
    end

    it "should render the index template" do
      do_index
      response.should be_success
      response.should render_template('signatures/index')
    end
  end
end

