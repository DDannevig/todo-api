require 'rails_helper'

RSpec.describe CompleteAllItemsWorker, type: :job do
  subject { described_class.new }

  let(:execute_worker) { subject.perform(todo_list.id) }

  let(:todo_list) { FactoryBot.create(:todo_list) }
  let(:another_todo_list) { FactoryBot.create(:todo_list) }
  let(:first_todo_item) { FactoryBot.create(:todo_item, todo_list: todo_list, completed: false) }
  let(:second_todo_item) { FactoryBot.create(:todo_item, todo_list: todo_list, completed: false) }
  let(:third_todo_item) { FactoryBot.create(:todo_item, todo_list: todo_list, completed: false) }
  let(:another_list_item) { FactoryBot.create(:todo_item, todo_list: another_todo_list, completed: false) }

  it 'completes first pending task' do
    expect { execute_worker }.to change { first_todo_item.reload.completed }.from(false).to(true)
  end

  it 'completes second pending task' do
    expect { execute_worker }.to change { second_todo_item.reload.completed }.from(false).to(true)
  end

  it 'completes third pending task' do
    expect { execute_worker }.to change { third_todo_item.reload.completed }.from(false).to(true)
  end

  it 'does not update items from another lists' do
    expect { execute_worker }.not_to(change { another_list_item.reload.completed })
  end
end
