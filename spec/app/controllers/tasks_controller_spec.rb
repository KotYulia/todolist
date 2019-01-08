require "rails_helper"

RSpec.describe TasksController, type: :controller do
  let(:task) {Task.create(name: "Test", complete: false)}
  let(:complete_task) {Task.create(name: "Test", complete: true)}
  let(:task_params) { task_params = { name: "Test", complete: true} }

  describe 'GET index' do
    before do
      task
      complete_task
      get :index
    end

    context 'should return all incomplete tasks when task is present' do
      it {expect(assigns(:incomplete_tasks)).to include(task)}
    end

    context 'when incomplete task is not present' do
      it {expect(assigns(:incomplete_tasks)).not_to include(nil)}
    end

    context 'should return all complete tasks when task is present' do
      it {expect(assigns(:complete_tasks)).to include(complete_task)}
    end

    context 'when complete task is not present' do
      it {expect(assigns(:complete_tasks)).not_to include(nil)}
    end
  end

  describe 'GET new' do
    before do
      get :new
    end

    context 'should assign the task' do
      it {expect(assigns(:task)).to be_a_new(Task)}
    end

    context 'should return http success' do
      it {expect(response).to have_http_status(:success)}
    end
  end

  describe 'GET edit' do
    before do
      task
      get :edit, params: { id: task.id }
    end

    context 'should assign a task' do
      it do
        expect(assigns(:task)).to eq(task)
      end
    end

    context 'should return http success' do
      it do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST create' do
    context 'should change a tasks counter' do
      it do
        expect{
          post :create, params: {task: task_params}
        }.to change(Task, :count).by(1)
      end
    end

    context 'should assign a newly created task' do
      before do
        post :create, params: { task: task_params }
      end

      it do
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
        expect(response).to redirect_to tasks_url
      end
    end
  end

  describe 'PUT update' do
    before do
      put :update, params: {id: task.id, task: task_params}
    end

    context 'should update the task' do
      it do
        task.reload

        expect(task.name).to  eq(task_params[:name])
        expect(response).to redirect_to tasks_url
      end
    end
  end

  describe 'DELETE destroy' do
    before {task}
    context 'should destroy the requested select_option' do
      it do
        expect{
          delete :destroy, params: {id: task.id}
        }.to change(Task, :count).by(-1)
      end
    end

    context 'should redirect to root_path and return successful notice' do
      before do
        delete :destroy, params: {id: task.id}
      end
      it do
        expect(response).to redirect_to tasks_url
      end
    end
  end

end