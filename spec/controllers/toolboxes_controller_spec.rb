require 'spec_helper'

describe ToolboxesController do
  describe "GET show" do
    it "assigns toolbox" do
      User.should_receive(:find_by_id).
        with("1").and_return(user = double)
      Toolbox.should_receive(:for).
        with(user).and_return(toolbox = double)

      get :show, id: 1

      expect(assigns(:toolbox)).to eq(toolbox)
    end

    it "renders HTML remplate" do
      get :show, id: 1
      expect(response).to render_template("show")
    end

    it "renders SH template" do
      get :show, id: 1, format: "sh"
      expect(response).to render_template("show")
    end

    it "renders VIM template" do
      get :show, id: 1, format: "vim"
      expect(response).to render_template("show")
    end
  end
end
