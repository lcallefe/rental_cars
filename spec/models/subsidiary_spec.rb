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
        cnpjs = [rand.to_s[2..15], '00.000.000/0000-00', '11.111.111/1111-11', CNPJ.generate(true)]
        @message = []
        cnpjs.each do |cnpj|
          subsidiary = nil
          subsidiary = Subsidiary.create(name: 'Xpto', cnpj: cnpj, address: 'Rua dos Bobos, 0')
          
          CNPJ.valid?(subsidiary.cnpj)
          if !(subsidiary.errors[:cnpj].empty?)
            @message << subsidiary.errors[:cnpj]
          end
        end   
        
        expect(@message.count).to eq 3
        expect(@message.first).to include('não é válido')
    end
  end
end
