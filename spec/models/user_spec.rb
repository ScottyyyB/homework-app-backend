require 'rails_helper'

RSpec.describe User, type: :model do
  describe "DB Table" do
  	it { is_expected.to have_db_column :id }
  	it { is_expected.to have_db_column :provider }
  	it { is_expected.to have_db_column :uid }
  	it { is_expected.to have_db_column :encrypted_password }
  	it { is_expected.to have_db_column :reset_password_token }
  	it { is_expected.to have_db_column :reset_password_sent_at }
  	it { is_expected.to have_db_column :sign_in_count }
  	it { is_expected.to have_db_column :current_sign_in_at }
  	it { is_expected.to have_db_column :last_sign_in_at }
  	it { is_expected.to have_db_column :current_sign_in_ip }
  	it { is_expected.to have_db_column :last_sign_in_ip }
  	it { is_expected.to have_db_column :confirmation_token }
  	it { is_expected.to have_db_column :confirmed_at }
  	it { is_expected.to have_db_column :confirmation_sent_at }
  	it { is_expected.to have_db_column :unconfirmed_email }
  	it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :name }
  	it { is_expected.to have_db_column :tokens }
  	it { is_expected.to have_db_column :created_at }
  	it { is_expected.to have_db_column :updated_at }
  	it { is_expected.to have_db_column :teacher }
    it { is_expected.to have_db_column :student }
  end

  describe "Validations" do
  	it { is_expected.to validate_presence_of :email }
  	it { is_expected.to validate_presence_of :password }
  	it { is_expected.to validate_presence_of :name }
  	it { is_expected.to validate_confirmation_of :password }
  	it { is_expected.to validate_inclusion_of(:teacher).in_array([true, false]) }
  	it { is_expected.to validate_inclusion_of(:student).in_array([true, false]) }
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