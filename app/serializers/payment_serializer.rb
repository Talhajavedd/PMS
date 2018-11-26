class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount
end
