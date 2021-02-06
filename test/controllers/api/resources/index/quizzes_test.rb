require_relative '../base_quizzes_test'

module ApiTests
  module ResourcesControllerTests
    module IndexTests
      class QuizzesTest < BaseQuizzesTest
        let(:params) do
          {}
        end

        let(:make_request) do
          get '/api/resources', params: params
        end

        describe 'Successful request' do
          let(:expected_json) do
            serialized_collection(
              quizzes.sort_by(&:published_at).reverse
            )
          end

          it 'responds with ok' do
            make_request
            assert_response :ok
          end

          it 'responds with proper json' do
            make_request
            assert_equal expected_json, json_response
          end

          describe 'sort date_asc param' do
            let(:expected_json) do
              serialized_collection(
                quizzes.sort_by(&:published_at)
              )
            end

            before do
              params.merge!(sort: 'date_asc')
            end

            it 'responds with proper json' do
              make_request
              assert_equal expected_json, json_response
            end
          end

          describe 'sort date_desc param' do
            before do
              params.merge!(sort: 'date_desc')
            end

            it 'responds with proper json' do
              make_request
              assert_equal expected_json, json_response
            end
          end
        end
      end
    end
  end
end
