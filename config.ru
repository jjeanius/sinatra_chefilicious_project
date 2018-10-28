require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride  #  use middleware action for hidden field:  patch, put, delete action

run ApplicationController
use AuthenticateController
use CustomersController
use MealkitsController
use AuthenticateController
