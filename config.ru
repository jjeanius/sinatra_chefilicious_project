require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#console do
#  ActiveRecord::Base.connection
#end

use Rack::MethodOverride

run ApplicationController
use CustomersController
use MealkitsController
