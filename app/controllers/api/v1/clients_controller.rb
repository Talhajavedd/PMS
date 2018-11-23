class Api::V1::ClientsController < Api::APIController

  def index
    successful_response(Client.search_with(params))
  end
end
