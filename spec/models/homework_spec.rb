RSpec.describe Homework, type: :model do
  describe 'DB Table' do
     it { is_expected.to have_db_column :id }
     it { is_expected.to have_db_column :title }
     it { is_expected.to have_db_column :link }
     it { is_expected.to have_db_column :due_date }
     it { is_expected.to have_db_column :category }
     it { is_expected.to have_db_column :status }
  end

  describe 'Validations' do
  	it { is_expected.to validate_presence_of :title }
  	it { is_expected.to validate_presence_of :link }
  	it { is_expected.to validate_presence_of :due_date }
  	it { is_expected.to validate_inclusion_of(Homework::VALID_STATUS).in? :status }
    it { is_expected.to validate_inclusion_of(Homework::VALID_CATEGORIES).in? :category }

  end

  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end
end
