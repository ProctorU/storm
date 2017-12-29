# TokensController
#
# The TokensController handles four RESTful actions.
#
#   - index
#   - new
#   - create
#   - destroy
#
# Built for simplicity. The token creator need only input a name.
class TokensController < ApplicationController
  def index
    @tokens = Token.recent.decorate
  end

  def new
    @token = Token.new
  end

  def create
    @token = Token.new(token_params.merge(create_params))

    if @token.save
      flash[:success] = t('.success', name: @token.name)
      redirect_to(tokens_path)
    else
      render(:new)
    end
  end

  def destroy
    @token = Token.find(params[:id])
    @token.destroy

    flash[:success] = t('.success', name: @token.name)
    redirect_to(tokens_path)
  end

  private

  def token_params
    params.require(:token).permit(:name)
  end

  def create_params
    {
      created_by: current_user
    }
  end
end
