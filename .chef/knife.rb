# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "tubbo"
client_key               "#{current_dir}/tubbo.pem"
validation_client_name   "waxpoetic-validator"
validation_key           "#{current_dir}/waxpoetic-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/waxpoetic"
cookbook_path            ["#{current_dir}/../cookbooks"]
