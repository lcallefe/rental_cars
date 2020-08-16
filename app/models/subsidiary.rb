class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: true
    validates :name, :cnpj, uniqueness: true
    validates_format_of :cnpj, :with => %r[\A\d{2}\.\d{3}.\d{3}/\d{4}-\d{2}\Z], :message => "não é válido"
end
