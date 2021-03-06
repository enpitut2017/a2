CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS', # IDCFでもAWSと記述
    path_style:            true,
    host:                  ENV['IDCF_HOST'],
    port:                  443,
    scheme:                'https',
    aws_access_key_id:     ENV['IDCF_ACCESS_KEY'], # アクセスキーを記述
    aws_secret_access_key: ENV['IDCF_SECRET_KEY'], # シークレットキー
    region:                ENV['IDCF_REGION'], # 東京
    aws_signature_version: 2
  }
  config.fog_directory = ENV['IDCF_BUCKET'] # バケット名を記述

  if Rails.env.production?
    config.asset_host = ENV['IDCF_ASSET'] # CDNを使用する場合
  else
    config.asset_host = "http://localhost:3000"
  end
end
