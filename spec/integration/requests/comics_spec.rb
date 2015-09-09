require 'rails_helper'

RSpec.describe 'comics pages', type: :request do
  ActionView::CompiledTemplates::FACEBOOK_APP_ID = '123'
  ActionView::CompiledTemplates::GOOGLE_ANALYTICS_ACCOUNT = 'UA-123'

  it 'redirects to a safe page if the action is only for authenticated users' do
    get '/comics'
  end
end
