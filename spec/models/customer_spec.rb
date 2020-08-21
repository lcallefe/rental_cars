require 'rails_helper'
require 'cpf_cnpj'

describe Customer, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:name]).to include('não pode ficar em branco')
      expect(customer.errors[:email]).to include('não pode ficar em '\
                                                      'branco')
      expect(customer.errors[:document]).to include('não pode ficar em branco')
    end

    it 'CPF must be unique' do
      cpf = CPF.generate(true)
      Customer.create!(name: 'Luciana', document: cpf, email: 'lucianacallefe@gmail.com')
      customer = Customer.new(name: 'Mariana', document: cpf, email: 'mariana@yahoo.com')

      customer.valid?

      expect(customer.errors[:document]).to include('já está em uso')
    end

    it 'CPF must be valid' do
        cpfs = [rand.to_s[2..13], '000.000.000-00', '111.111.111-11', '1234', CPF.generate(true)]
        @messages = []
        cpfs.each do |cpf|
          customer = nil
          customer = Customer.create(name: 'Xpto', document: cpf, email: 'customer_email@hotmail.com')
          
          CPF.valid?(customer.document)
          if !(customer.errors[:document].empty?)
            @messages << customer.errors[:document]
          end
        end   
        
        expect(@messages.count).to eq 4
        @messages.each do |message|
          expect(message).to include('não é válido')
        end
      end

      it 'must not contain whitespaces' do
        customer = Customer.create(name: '  ', document: CPF.generate(true), email: '   ')
        
        
        expect(customer.errors[:name]).to include('não é válido')
        expect(customer.errors[:email]).to include('não é válido')
      end

     
      it 'name must not allow special characters' do
        customer = Customer.new(name: '@#$%^ola&', document: CPF.generate(true), email: 'user@yahoo.com')

        customer.valid?

        expect(customer.errors[:name]).to include('não é válido')
      end 

      it 'name should be at least 2 characters long' do
        customer = Customer.new(name: 'A', document: CPF.generate(true), email: 'user@yahoo.com')

        customer.valid?

        expect(customer.errors[:name]).to include('é muito curto (mínimo: 2 caracteres)')
      end 

      it 'email must be valid' do
        customer = Customer.new(name: 'Fabio', document: CPF.generate(true), email: 'a')

        customer.valid?

        expect(customer.errors[:email]).to include('não é válido')
      end 

      it 'email must be unique' do
        Customer.create!(name: 'Fabio', document: CPF.generate(true), email: 'fabio@gmail.com')
        customer = Customer.new(name: 'Fabio', document: CPF.generate(true), email: 'fabio@gmail.com')

        customer.valid?

        expect(customer.errors[:email]).to include('já está em uso')
      end 

      it 'first letter should be capitalized' do
        customer = Customer.new(name: 'amanda', document: CPF.generate(true), email: 'abc_amanda@yahoo.com')

        customer.valid?
  
        expect(customer.name).to eq 'Amanda'
      end   
  end
end
