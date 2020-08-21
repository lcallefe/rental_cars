class Customer < ApplicationRecord
  validates :name, :document, :email, presence: true
  validates :name, length: { minimum: 2 }
  validates :document, :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "não é válido"
  validates_format_of :name, :with => /\A[^\s]+[-a-zA-Z\s]+([-a-zA-Z]+)*\Z/, :message => "não é válido"
  validate :cpf_must_be_valid


  def name=(name)
    write_attribute(:name, name.to_s.titleize)
  end
  
  def cpf_must_be_valid
    if !CPF.valid?(document)
      errors.add(:document, "não é válido")
    end
  end

end
