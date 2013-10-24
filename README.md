# README

A simple chef recipe that I hacked together to setup ghost on a ubuntu 12.04

Steps:

1. Boostrap chef

` curl -L https://gist.github.com/rafaeljegundo/7068128/raw/edab0cb13ad230ed5c6c58f7ffe3ba95f89474a9/chef_solo_bootstrap.sh | bash`

2. Run chef on the server


3. If necessary, update nginx config

`vi /etc/nginx/nginx.conf`

set `server_names_hash_bucket_size: 32` to `64`

### TODO

* Refactor to use more recipes, less bash
* Import ghost from github
* Allow updates
* Setup backups



