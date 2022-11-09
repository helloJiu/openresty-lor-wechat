return {
	app_debug = true,

	-- 静态模板配置，保持默认不修改即可
	view_config = {
		engine = "tmpl",
		ext = "html",
		views = "./app/views"
	},


	-- 分页时每页条数配置
	page_config = {
		index_topic_page_size = 10, -- 首页每页文章数
		topic_comment_page_size = 20, -- 文章详情页每页评论数
		notification_page_size = 10, -- 通知每页个数
	},

	-- mysql配置
	mysql = {
		timeout = 5000,
		connect_config = {
			host = "127.0.0.1",
	        port = 3306,
	        database = "openresty",
	        user = "hu",
	        password = "",
	        max_packet_size = 1024 * 1024
		},
		pool_config = {
			max_idle_timeout = 20000, -- 20s
        	pool_size = 50 -- connection pool size
		}
	},

	redis = {
		host = "127.0.0.1",
		port = 6379,
		password = "",
		db_index = 0,
		max_idle_time = 3000,
		keepalive = 60000,
		database = 0,
		pool_size = 100,
		timeout = 5000,
	},


	wechat = {
		appId = "",
		appSecret = ""
	},

}
