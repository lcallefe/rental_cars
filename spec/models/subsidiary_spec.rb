require 'rails_helper'
require 'cpf_cnpj'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em '\
                                                      'branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'name and CNPJ must be both uniq' do
      Subsidiary.create!(name: 'Rio de Janeiro', cnpj: '52.951.622/0001-07', address: 'Rua dos Bobos, 0')
      subsidiary = Subsidiary.new(name: 'Rio de Janeiro', cnpj: '52.951.622/0001-07')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('já está em uso')
      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'CNPJ must be valid' do
        cnpjs = [rand.to_s[2..15], '00.000.000/0000-00', '11.111.111/1111-11', '1234']
        @message = []
        cnpjs.each do |cnpj|
          subsidiary = nil
          subsidiary = Subsidiary.new(name: 'Xpto', cnpj: cnpj, address: 'Rua dos Bobos, 0')
          subsidiary.save
          
          CNPJ.valid?(subsidiary.cnpj)
          @message << subsidiary.errors[:cnpj]
        end   
        
        expect(@message.count).to eq 4
        expect(@message.last).to include('não é válido')
    end
  end
end
