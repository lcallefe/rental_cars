class Subsidiary < ApplicationRecord
    validates_format_of :cnpj, with: /\A([0-9]{2,3}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}-[0-9]{2})*\z/, on: create
end
