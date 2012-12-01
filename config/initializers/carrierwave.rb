CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAJYKEV5FNXMU5MFAA',       # required
      :aws_secret_access_key  => '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',       # required
      #:region                 => 'us-standard'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'furnlab'                     # required
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end