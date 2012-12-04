CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJYKEV5FNXMU5MFAA',
      :aws_secret_access_key  => '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'
  }
  config.fog_directory = 'furnlab'
end