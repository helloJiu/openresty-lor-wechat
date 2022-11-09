# openresty_lor_wechat
使用openresty lor开发的微信回调事件项目

## 项目源码
https://github.com/helloJiu/openresty-lor-wechat

## lapis开发微信回调事件项目
https://github.com/helloJiu/openresty-wechat


## openresty源码安装(ubuntu为例)
```
apt install gcc libpcre3-dev libssl-dev perl make build-essential zlib1g-dev
wget https://openresty.org/download/openresty-1.19.9.1.tar.gz
tar -zxvf openresty-1.19.9.1.tar.gz
cd openresty-1.19.9.1/
./configure
make && make install
```


## 配置环境变量
```
vim /etc/profile
export PATH=$PATH:/usr/local/openresty/bin:/usr/local/openresty/luajit/bin
source /etc/profile

# 设置lua软链到luajit
ln -s  /usr/local/openresty/luajit/bin/luajit lua
mv lua /usr/bin/
```


## 安装redis依赖包和http-client依赖包以及其他依赖
```
opm install lua-resty-string
opm install openresty/lua-resty-redis
opm install ledgetech/lua-resty-http
```

## 微信公众平台准备
详情参见 https://github.com/helloJiu/openresty-wechat
包含签名验证等

## 准备工作
```
mkdir client_body_temp
mkdir fastcgi_temp
mkdir logs
mkdir proxy_temp
mkdir uwsgi_temp
```
## 启动项目

`/usr/local/openresty/bin/openresty -p `pwd` -c conf/nginx-dev.conf`


## 重新加载
`/usr/local/openresty/bin/openresty -s reload -p `pwd` -c conf/nginx-dev.conf`
- 浏览器访问 127.0.0.1:8123

## 压力测试

```
## autocannon压测命令需要使用npm安装
autocannon -c 100 -d 30 -p 2 -t 2 http://127.0.0.1:8123/wechat/accept

## 运行结果
Running 30s test @ http://10.254.39.195:8123/wechat/accept
100 connections with 2 pipelining factor


┌─────────┬───────┬────────┬────────┬────────┬───────────┬───────────┬─────────┐
│ Stat    │ 2.5%  │ 50%    │ 97.5%  │ 99%    │ Avg       │ Stdev     │ Max     │
├─────────┼───────┼────────┼────────┼────────┼───────────┼───────────┼─────────┤
│ Latency │ 12 ms │ 314 ms │ 652 ms │ 701 ms │ 316.26 ms │ 186.86 ms │ 3094 ms │
└─────────┴───────┴────────┴────────┴────────┴───────────┴───────────┴─────────┘
┌───────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┬─────────┐
│ Stat      │ 1%      │ 2.5%    │ 50%     │ 97.5%   │ Avg     │ Stdev   │ Min     │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
│ Req/Sec   │ 7259    │ 7259    │ 8807    │ 9207    │ 8714.94 │ 436.3   │ 7258    │
├───────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┼─────────┤
│ Bytes/Sec │ 1.58 MB │ 1.58 MB │ 1.92 MB │ 2.01 MB │ 1.9 MB  │ 95.1 kB │ 1.58 MB │
└───────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┴─────────┘

Req/Bytes counts sampled once per second.
# of samples: 30

267k requests in 30.03s, 57 MB read
55 errors (0 timeouts)

## QPS大概8700+
```


