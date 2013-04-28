class ToolboxesController < ApplicationController
  def show
		@toolbox = toolbox
  end

	def current_user
		User.find_by_id(params[:id])
	end
end
