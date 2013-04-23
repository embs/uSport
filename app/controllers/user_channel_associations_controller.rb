class UserChannelAssociationsController < ApplicationController
  def destroy
    @uca = UserChannelAssociation.find(params[:id])
    authorize! :manage, @uca
    @uca.destroy

    respond_to do |format|
      format.js
    end
  end
end
