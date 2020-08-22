class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: true
    validates :name, :cnpj, uniqueness: true
    validates_uniqueness_of :name, :case_sensitive => false
    validates :name, length: { minimum: 4 }
    validates :address, length: { minimum: 10 }
    validates_format_of :name, :with => /\A[^\s]+[-a-zA-Z\s]+([-a-zA-Z]+)*\Z/, :message => "não é válido"
    validates_format_of :address, :with => /\A[^\s].+[^\s]\Z/, :message => "não é válido"
    validate :cnpj_must_be_valid

  def name=(name)
    write_attribute(:name, name.to_s.titleize)
  end

  def address=(address)
    write_attribute(:address, address.to_s.titleize)
  end
 
  def cnpj_must_be_valid
    if !CNPJ.valid?(cnpj)
      errors.add(:cnpj, "não é válido")
    end
  end
end
