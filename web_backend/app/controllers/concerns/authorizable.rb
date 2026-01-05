module Authorizable extend ActiveSupport::Concern
  class NotAuthorized < StandardError; end
  class FunctionAuthNotEnabled < StandardError; end
  class FunctionAuthHasNoRoles < StandardError; end

  included do
    before_action :authorize_user
  end

  private
  def authorize_user
    raise NotAuthorized unless $current_user

    acl = Acl.find_by!(controller: self.controller_name, action: self.action_name)
    raise FunctionAuthNotEnabled unless acl.enabled

    raise FunctionAuthHasNoRoles unless acl.role_ids

    raise NotAuthorized unless ($current_user.role_ids & acl.role_ids).any?
  end
end
