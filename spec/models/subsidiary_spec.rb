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
      Subsidiary.create!(name: 'Brasilia', cnpj: '52.951.622/0001-07', address: 'Rua dos Bobos, 0')
      subsidiary = Subsidiary.new(name: 'Brasilia', cnpj: '52.951.622/0001-07')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('já está em uso')
      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'CNPJ must be valid' do
        cnpjs = [rand.to_s[2..15], '00.000.000/0000-00', '11.111.111/1111-11', '1234', CNPJ.generate(true)]
        @messages = []
        cnpjs.each do |cnpj|
          subsidiary = nil
          subsidiary = Subsidiary.create(name: 'Xpto', cnpj: cnpj, address: 'Rua dos Bobos, 0')
          
          CNPJ.valid?(subsidiary.cnpj)
          if !(subsidiary.errors[:cnpj].empty?)
            @messages << subsidiary.errors[:cnpj]
          end
        end   
        
        expect(@messages.count).to eq 4
        @messages.each do |message|
          expect(message).to include('não é válido')
        end
      end

      it 'must not contain whitespaces' do
        subsidiary = Subsidiary.create(name: '  ', cnpj: CNPJ.generate(true), address: '    ')
        expect(subsidiary.errors[:name]).to include('não é válido')
        expect(subsidiary.errors[:address]).to include('não é válido')
      end

      it 'uppercase and lowercase words are the same' do
        Subsidiary.create!(name: 'RoRAimA', cnpj: CNPJ.generate(true), address: 'Avenida Paulista')
        subsidiary = Subsidiary.new(name: 'roraima', cnpj: CNPJ.generate(true), address: 'Avenida Paulista')
  
        subsidiary.valid?
  
        expect(subsidiary.errors[:name]).to include('já está em uso') 
      end 

      it 'name field must not allow special characters' do
        subsidiary = Subsidiary.new(name: '@#$%^ola&', cnpj: CNPJ.generate(true), address: 'Rua Tutoia')

        subsidiary.valid?

        expect(subsidiary.errors[:name]).to include('não é válido')
      end 

      it 'name should be at least 4 characters long' do
        subsidiary = Subsidiary.new(name: 'Ola', cnpj: CNPJ.generate(true), address: 'Rua Caramuru, 86')

        subsidiary.valid?

        expect(subsidiary.errors[:name]).to include('é muito curto (mínimo: 4 caracteres)')
      end 

      it 'address should be at least 10 characters long' do
        subsidiary = Subsidiary.new(name: 'Filial2', cnpj: CNPJ.generate(true), address: 'Rua A')

        subsidiary.valid?

        expect(subsidiary.errors[:address]).to include('é muito curto (mínimo: 10 caracteres)')
      end 

      it 'first letter should be capitalized' do
        subsidiary = Subsidiary.new(name: 'capão redondo', cnpj: CNPJ.generate(true), address: 'rua brasil')

        subsidiary.valid?
  
        expect(subsidiary.name).to eq 'Capão Redondo'
        expect(subsidiary.address).to eq 'Rua Brasil'
      end   
  end
end
