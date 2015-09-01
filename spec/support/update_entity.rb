shared_examples_for 'Entity updater' do

  it 'assign @instance ' do
    do_update_request
    # patch :update, id: question_to_update, question: FactoryGirl.attributes_for(:question), format: :js
    expect(assigns(entity_to_update.class.to_s.downcase.to_sym)).to eq entity_to_update
  end

  it 'changes the original content off the entity' do
    do_change_content_request
    # patch :update, id: question_to_update, question: { title: 'crap', content: 'new crap' }, format: :js
    entity_to_update.reload
    expect(entity_to_update.name).to eq 'John' if entity_to_update.respond_to?(:title)
  end
  #

end
