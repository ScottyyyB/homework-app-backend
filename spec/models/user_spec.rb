require 'rails_helper'

RSpec.describe User, type: :model do
  describe "DB Table" do
  	it { is_expected.to have_db_column :id }
  	it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :auth_token }
  	it { is_expected.to have_db_column :password_digest }
    it { is_expected.to have_db_column :student }
    it { is_expected.to have_db_column :grade }
  end

  describe "Validations" do
  	it { is_expected.to validate_presence_of :password }
  	it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_uniqueness_of :username }
    it { is_expected.to validate_uniqueness_of :email }
  	it { is_expected.to validate_inclusion_of(:teacher).in_array([true, false]) }
  	it { is_expected.to validate_inclusion_of(:student).in_array([true, false]) }
    
    context "validate grade if student" do
      before { allow(subject).to receive(:student?).and_return(true) }
      it { is_expected.to validate_presence_of :grade }
    end

    context "not validate grade otherwise" do
      it { is_expected.not_to validate_presence_of :grade }
    end
  end

  describe 'Relations' do
    it { is_expected.to have_many :homework }
  end
  
  context "should be invalid" do
    emails = [ 'afg@afcom', '@example.com', 'something @ something. com']
    emails.each do |email|
  	 it { is_expected.not_to allow_value(email).for :email }
    end
  end

  context "should be valid" do
  	emails = ['something@something.com', 'random@random.com', 'user@example.se']
  	emails.each do |email|
  	  it { is_expected.to allow_value(email).for :email }
  	end
  end
end