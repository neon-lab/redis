# Instillation
default[:redis][:redis_pkg_link]  = 'https://neon-dependencies.s3.amazonaws.com/redis-2.8.4.ubuntu.12.04_amd64.deb'
default[:redis][:version]         = '2.6.13'
default[:redis][:source_checksum] = '2ef8ea6a67465b6c5a5ea49241313d3dbc0de11b'
default[:redis][:install_dir]     = '/bin'
default[:redis][:conf_dir]        = '/etc/redis'
default[:redis][:db_dir]          = '/mnt/redis'

# Service user & group
default[:redis][:user]  = 'redis'
default[:redis][:group] = 'redis'

# Config
default[:redis][:daemonize]                   = 'no'
default[:redis][:pid_file]                    = '/var/run/redis_6379.pid'
default[:redis][:port]                        = 6379
default[:redis][:bind_address]                = '127.0.0.1'
default[:redis][:timeout]                     = 0
default[:redis][:keepalive]                   = 60
default[:redis][:log_level]                   = 'notice'
default[:redis][:log_file]                    = '/mnt/redis/redis.log'
default[:redis][:databases]                   = 16
default[:redis][:activerehashing]             = 'yes'
default[:redis][:stop_writes_on_bgsave_error] = 'yes'
default[:redis][:rdbcompression]              = 'yes'
default[:redis][:rdbchecksum]                 = 'yes'
default[:redis][:dbfilename]                  = 'dump.rdb'
default[:redis][:slave_serve_stale_data]      = 'yes'
default[:redis][:slave_read_only]             = 'yes'
default[:redis][:repl_disable_tcp_nodelay]    = 'no'
default[:redis][:slave_priority]              = 100
default[:redis][:appendonly]                  = 'yes'
default[:redis][:appendfsync]                 = 'everysec'
default[:redis][:no_appendfsync_on_rewrite]   = 'no'
default[:redis][:auto_aof_rewrite_percentage] = 100
default[:redis][:auto_aof_rewrite_min_size]   = '64mb'
default[:redis][:lua_time_limit]              = 5000
default[:redis][:slowlog_log_slower_than]     = 10000
default[:redis][:slowlog_max_len]             = 128
default[:redis][:snapshot_saves]              = [
  { 900 => 1 },
  { 300 => 10 },
  { 60 => 10000 }
]
default[:redis][:notify_keyspace_events]      = ''

# backup config
default[:redis][:backup_s3_bucket] = 'neon-db-backup'
default[:redis][:backup_log] = '/mnt/redis/backup.log'

# slave config
default[:redis][:video_db_layer] = 'redis'
default[:redis][:is_slave] = 'no'
