require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe "DB Table" do
  	it { is_expected.to have_db_column :id }
  	it { is_expected.to have_db_column :name }
  	it { is_expected.to have_db_column :grade }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :grade }
    it { is_expected.to validate_presence_of :user_ids }
    it { is_expected.to validate_presence_of :teacher_id }
  end

  describe "Relations" do
    it { is_expected.to belong_to :teacher }
    it { is_expected.to have_many :students }
    it { is_expected.to have_many :users }
  end
end
