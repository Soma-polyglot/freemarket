server "13.230.122.171", user: "ec2-user", roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"

# role-based syntax
# ==================
