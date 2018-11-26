class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :company
end
