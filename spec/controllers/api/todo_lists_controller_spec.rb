require 'rails_helper'

describe Api::TodoListsController do
  render_views

  describe 'POST create' do
    subject { post :create, params: params, format: :json }

    let(:params) { { name: Faker::Hobby.activity } }

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

    before do
      todo_list
      subject
    end

    context 'when format is HTML' do
      let(:format) { 'HTML' }

      it 'raises a routing error' do
        expect(response.parsed_body).to eq({ 'message' => I18n.t('errors.invalid_format') })
      end
    end

    context 'when format is JSON' do
      let(:format) { 'json' }

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
end
