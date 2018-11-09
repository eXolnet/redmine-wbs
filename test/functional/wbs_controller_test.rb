require File.expand_path('../../test_helper', __FILE__)

class WbsControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :enabled_modules,
           :enumerations,
           :repositories,
           :changesets,
           :changes

  def setup
    # Enable the REST API
    Setting.rest_api_enabled = 1

    # Configure the logged user
    @request.session[:user_id] = 1
    User.current.create_api_token

    # Enable the WBS module on one project
    @project1 = Project.find(1)
    EnabledModule.create(:project => @project1, :name => 'wbs')
  end

  def test_get_index_with_project
    get :index, :project_id => 'ecookbook'

    assert_response :success
  end
end
