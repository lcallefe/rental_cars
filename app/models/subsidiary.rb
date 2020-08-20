class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: true
    validates :name, :cnpj, uniqueness: true
    validates_uniqueness_of :name, :case_sensitive => false
    validates :name, length: { minimum: 4 }
    validates :address, length: { minimum: 10 }
    validates_format_of :name, :with => /\A[^\s]+[-a-zA-Z\s]+([-a-zA-Z]+)*\Z/, :message => "não é válido"
    validates_format_of :address, :with => /\A[^\s].+[^\s]\Z/, :message => "não é válido"
    validates_format_of :cnpj, :with => %r[\A\d{2}\.\d{3}.\d{3}/\d{4}-\d{2}\Z], :message => "não é válido"
    validate :cnpj_cant_be_zero, :cnpj_cant_be_one
 
  def cnpj_cant_be_zero
    if cnpj == '00.000.000/0000-00'
      errors.add(:cnpj, "não é válido")
    end
  end
 
  def cnpj_cant_be_one
    if cnpj == '11.111.111/1111-11'
      errors.add(:cnpj, "não é válido")
    end
  end
end
