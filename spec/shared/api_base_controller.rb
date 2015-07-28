RSpec.shared_examples "api base controller" do
  describe 'GET #show' do
    subject { get :show, { id: id , format: :json}  }

    context 'with no record for provided id' do
      let(:id) { -1 }

      it 'responds with 404 NOT FOUND' do
        subject
        expect(response.status).to eq(404)
      end
    end
  end
end
