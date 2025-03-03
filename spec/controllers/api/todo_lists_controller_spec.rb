require 'rails_helper'

shared_examples 'bad request when format invalid' do
  let(:format) { 'HTML' }

  it 'raises a routing error' do
    expect(subject.parsed_body).to eq({ 'message' => I18n.t('errors.invalid_format') })
  end
end

describe Api::TodoListsController do
  render_views

  describe 'POST create' do
    subject { post :create, params: params, format: format }

    let(:params) { { name: Faker::Hobby.activity } }
    let(:format) { 'json' }

    it_behaves_like 'bad request when format invalid'

    context 'when name is blank' do
      let(:params) { { name: nil } }

      before { subject }

      it 'responds with param missing error' do
        message = 'param is missing or the value is empty: name'

        aggregate_failures 'responds with bad_request and message' do
          expect(response.status).to eq 400
          expect(response.parsed_body['message']).to eq(message)
        end
      end
    end

    context 'with required params' do
      it 'creates a todo_list' do
        expect { subject }.to change(TodoList, :count).by(1)
      end

      describe 'valid response' do
        before { subject }

        it 'responds with a 200' do
          expect(response.status).to eq 200
        end

        it 'responds with the correct todo_list' do
          aggregate_failures 'includes the id and name' do
            expect(response.parsed_body.keys).to match_array(%w[id name])
            expect(response.parsed_body['id']).to eq(TodoList.last.id)
            expect(response.parsed_body['name']).to eq(TodoList.last.name)
          end
        end
      end
    end
  end

  describe 'GET index' do
    subject { get :index, format: format }

    let(:todo_list) { TodoList.create(name: 'Setup RoR project') }

    before { todo_list }

    it_behaves_like 'bad request when format invalid'

    context 'when format is JSON' do
      let(:format) { 'json' }

      before { subject }

      it 'returns a success code' do
        expect(response.status).to eq(200)
      end

      it 'includes todo list records' do
        aggregate_failures 'includes the id and name' do
          expect(response.parsed_body.count).to eq(1)
          expect(response.parsed_body.first.keys).to match_array(%w[id name])
          expect(response.parsed_body.first['id']).to eq(todo_list.id)
          expect(response.parsed_body.first['name']).to eq(todo_list.name)
        end
      end
    end
  end

  describe 'PUT update' do
    subject { put :update, params: params, format: format }

    let(:todo_list) { TodoList.create(name: Faker::Hobby.activity) }
    let(:todo_list_id) { todo_list.id }
    let(:params) { { id: todo_list_id, name: updated_name } }
    let(:updated_name) { Faker::Hobby.activity }

    it_behaves_like 'bad request when format invalid'

    context 'with json format' do
      let(:format) { 'json' }

      context 'when the todo_list does not exist' do
        let(:todo_list_id) { TodoList.last.id + 1 }

        before do
          todo_list
          subject
        end

        it 'raises record not found error' do
          message = "Couldn't find TodoList with 'id'=#{todo_list_id}"

          aggregate_failures 'responds with not_found and message' do
            expect(response.status).to eq 404
            expect(response.parsed_body['message']).to eq(message)
          end
        end
      end

      context 'when name is blank' do
        let(:updated_name) { nil }

        before { subject }

        it 'responds with param missing error' do
          message = 'param is missing or the value is empty: name'

          aggregate_failures 'responds with bad_request and message' do
            expect(response.status).to eq 400
            expect(response.parsed_body['message']).to eq(message)
          end
        end
      end

      context 'when the todo_list exists' do
        before { subject }

        it 'updates todo_list' do
          expect(todo_list.reload.name).to eq(updated_name)
        end

        describe 'valid response' do
          it 'responds with a 200' do
            expect(response.status).to eq 200
          end

          it 'responds with the correct todo_list' do
            aggregate_failures 'includes the id and name' do
              expect(response.parsed_body.keys).to match_array(%w[id name])
              expect(response.parsed_body['id']).to eq(TodoList.last.id)
              expect(response.parsed_body['name']).to eq(TodoList.last.name)
            end
          end
        end
      end
    end
  end
end
