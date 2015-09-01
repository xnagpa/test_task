shared_examples_for 'New entity creator' do

  before do
    get :new
  end
  # question
  it 'assigns new variable to @#{entity.downcase} ' do
    expect(assigns(entity.to_sym)).to be_a_new(Object.const_get(entity.capitalize))
  end

  it 'renders new template' do
    expect(response).to render_template(:new)
  end
end
