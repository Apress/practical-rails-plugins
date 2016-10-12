class SignaturesController < ApplicationController
  before_filter :find_petition

  def index
    @signatures = @petition.signatures
  end

  def create
    @signature = @petition.signatures.build(params[:signature])
    if @signature.save
      flash[:notice] = "Thank you for your support"
      redirect_to(:action => 'index')
    else
      flash[:error] = "Please check the form for errors"
      redirect_to(:action => 'index')
    end
  end

  protected

  def find_petition
    @petition = Petition.find(params[:petition_id])
  end
end

