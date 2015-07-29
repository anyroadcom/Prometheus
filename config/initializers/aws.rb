Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(ENV['PROMETHEUS_AKID'], ENV['PROMETHEUS_SECRET'])
})
