require 'spec_helper'

describe Searching::CustomerService do
  describe 'It search customers' do
    before :each do
      Setting.contact_creation_allowed = true
      sign_in_normal_user

      @customer_one = Customer.make(:name => 'Juan', :company => @logged_user.company)
      @customer_two = Customer.make(:name => 'Omar', :company => @logged_user.company)
    end

    it 'should search and return result' do
    end
  end
end
