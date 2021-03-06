describe CategoryForm do

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to ensure_length_of(:name).is_at_most(20) }
  it { is_expected.to validate_inclusion_of(:transaction_type).in_array(TransactionType.numbers) }

  it 'should ensure that name is unique for given TransactionType' do
    subject.entity_id = 3
    subject.name = 'Cate 1'
    subject.transaction_type = TransactionType[:income]
    expect(CategoryRepository).to(
        receive(:unique?).with(3, name: subject.name, transaction_type: subject.transaction_type).and_return(false))

    expect(subject.valid?).to be false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  it 'should ensure that no associated Transaction exists when transaction-type changes' do
    subject.entity_id = 3
    expect(TransactionRepository).to receive(:exists?).with(category_id: 3).and_return(true)
    expect(subject.valid?).to be false
    expect(subject.errors[:transaction_type]).not_to be_empty
  end


  describe '#transaction_type' do

    it 'should have default value' do
      expect(subject.transaction_type).to eq TransactionType[:expense]
    end
  end

  describe '#transaction_type=' do

    it 'should cast argument to number' do
      subject.transaction_type = 'incom'
      expect(subject.transaction_type).to eq TransactionType[:income]
    end
  end
end