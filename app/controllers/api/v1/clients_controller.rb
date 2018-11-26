class Api::V1::ClientsController < Api::APIController

  def index
    successful_response(ClientSerializer.new(Client.search_with(params)).serializable_hash)
  end
end
