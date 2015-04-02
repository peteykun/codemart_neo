redis = Redis.new
# Or whatever way you have your redis connection
$lock = RemoteLock.new(RemoteLock::Adapters::Redis.new(redis))