require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "DB Table" do
    it { is_expected.to have_db_column :id }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :user_id }
  end

  describe "Relations" do
    it { is_expected.to belong_to :classroom }
 	it { is_expected.to belong_to :user }
  end
end
