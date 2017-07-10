# frozen_string_literal: true

crumb :root do
  link 'Home', root_path
end

crumb :check_records do
  link 'Check Records', check_records_path
end

crumb :users do
  link 'Users', users_admin_index_path
end

crumb :machines do
  link 'Machines', machines_path
end

crumb :machine do |machine|
  link machine.name || 'New', machine
  parent :machines
end
