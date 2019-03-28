# frozen_string_literal: true

module UsersHelper
  def create_user_button
    link_to '新增員工', new_users_admin_path, class: 'btn btn-secondary' if current_user.admin?
  end

  def manage_group_button
    link_to '管理群組', groups_path, class: 'btn btn-secondary' if current_user.admin?
  end
end
