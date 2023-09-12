# nginx [![Ansible Role](https://img.shields.io/ansible/role/d/61778.svg)](https://galaxy.ansible.com/cornfeedhobo/nginx)

Install and configure nginx

## Table of content

- [Requirements](#requirements)
- [Default Variables](#default-variables)
  - [nginx_access_log](#nginx_access_log)
  - [nginx_config](#nginx_config)
  - [nginx_config_dir](#nginx_config_dir)
  - [nginx_config_events](#nginx_config_events)
  - [nginx_config_http](#nginx_config_http)
  - [nginx_config_http_extra](#nginx_config_http_extra)
  - [nginx_config_path](#nginx_config_path)
  - [nginx_configure](#nginx_configure)
  - [nginx_error_log](#nginx_error_log)
  - [nginx_group](#nginx_group)
  - [nginx_install](#nginx_install)
  - [nginx_keepalive_requests](#nginx_keepalive_requests)
  - [nginx_keepalive_timeout](#nginx_keepalive_timeout)
  - [nginx_log_dir](#nginx_log_dir)
  - [nginx_log_format_main](#nginx_log_format_main)
  - [nginx_mime_extra](#nginx_mime_extra)
  - [nginx_mime_path](#nginx_mime_path)
  - [nginx_owner](#nginx_owner)
  - [nginx_package_state](#nginx_package_state)
  - [nginx_packages](#nginx_packages)
  - [nginx_pidfile](#nginx_pidfile)
  - [nginx_sendfile](#nginx_sendfile)
  - [nginx_service](#nginx_service)
  - [nginx_service_enabled](#nginx_service_enabled)
  - [nginx_service_name](#nginx_service_name)
  - [nginx_service_state](#nginx_service_state)
  - [nginx_ssl](#nginx_ssl)
  - [nginx_ssl_dhparam](#nginx_ssl_dhparam)
  - [nginx_ssl_dhparam_path](#nginx_ssl_dhparam_path)
  - [nginx_ssl_dhparam_size](#nginx_ssl_dhparam_size)
  - [nginx_ssl_dir](#nginx_ssl_dir)
  - [nginx_ssl_pairs](#nginx_ssl_pairs)
  - [nginx_tcp_nodelay](#nginx_tcp_nodelay)
  - [nginx_tcp_nopush](#nginx_tcp_nopush)
  - [nginx_types_hash_max_size](#nginx_types_hash_max_size)
  - [nginx_vhost_dir](#nginx_vhost_dir)
  - [nginx_vhosts](#nginx_vhosts)
  - [nginx_worker_connections](#nginx_worker_connections)
  - [nginx_worker_multi_accept](#nginx_worker_multi_accept)
  - [nginx_worker_processes](#nginx_worker_processes)
- [Discovered Tags](#discovered-tags)
- [Dependencies](#dependencies)
- [License](#license)
- [Author](#author)

---

## Requirements

- Minimum Ansible version: `2.5`

## Default Variables

### nginx_access_log

#### Default value

```YAML
nginx_access_log: '{{ nginx_log_dir }}/access.log'
```

### nginx_config

#### Default value

```YAML
nginx_config:
  - user {{ nginx_owner }}
  - pid {{ nginx_pidfile }}
  - error_log {{ nginx_error_log }} warn
  - worker_processes {{ nginx_worker_processes }}
```

### nginx_config_dir

#### Default value

```YAML
nginx_config_dir: /etc/nginx
```

### nginx_config_events

#### Default value

```YAML
nginx_config_events:
  - worker_connections {{ nginx_worker_connections }}
  - multi_accept {{ nginx_worker_multi_accept }}
```

### nginx_config_http

#### Default value

```YAML
nginx_config_http:
  - log_format main {{ nginx_log_format_main }}
  - access_log  {{ nginx_access_log }} main
  - sendfile {{ nginx_sendfile }}
  - tcp_nopush {{ nginx_tcp_nopush }}
  - tcp_nodelay {{ nginx_tcp_nodelay }}
  - keepalive_timeout {{ nginx_keepalive_timeout }}
  - keepalive_requests {{ nginx_keepalive_requests }}
  - types_hash_max_size {{ nginx_types_hash_max_size }}
  - include {{ nginx_mime_path }}
  - default_type application/octet-stream
  - include {{ nginx_vhost_dir }}/*.conf
```

### nginx_config_http_extra

#### Default value

```YAML
nginx_config_http_extra: []
```

### nginx_config_path

#### Default value

```YAML
nginx_config_path: '{{ nginx_config_dir }}/nginx.conf'
```

### nginx_configure

#### Default value

```YAML
nginx_configure: false
```

### nginx_error_log

#### Default value

```YAML
nginx_error_log: '{{ nginx_log_dir }}/error.log'
```

### nginx_group

#### Default value

```YAML
nginx_group: '{{ __nginx_group }}'
```

### nginx_install

#### Default value

```YAML
nginx_install: false
```

### nginx_keepalive_requests

#### Default value

```YAML
nginx_keepalive_requests: '100'
```

### nginx_keepalive_timeout

#### Default value

```YAML
nginx_keepalive_timeout: '65'
```

### nginx_log_dir

#### Default value

```YAML
nginx_log_dir: /var/log/nginx
```

### nginx_log_format_main

#### Default value

```YAML
nginx_log_format_main: >-
  '$remote_addr - $remote_user [$time_local] "$request"
  $status $body_bytes_sent "$http_referer"
  "$http_user_agent" "$http_x_forwarded_for"'
```

### nginx_mime_extra

#### Default value

```YAML
nginx_mime_extra: []
```

### nginx_mime_path

#### Default value

```YAML
nginx_mime_path: '{{ nginx_config_dir }}/mime.types'
```

### nginx_owner

#### Default value

```YAML
nginx_owner: '{{ __nginx_owner }}'
```

### nginx_package_state

#### Default value

```YAML
nginx_package_state: present
```

### nginx_packages

#### Default value

```YAML
nginx_packages: [nginx]
```

### nginx_pidfile

#### Default value

```YAML
nginx_pidfile: /run/nginx.pid
```

### nginx_sendfile

#### Default value

```YAML
nginx_sendfile: on
```

### nginx_service

#### Default value

```YAML
nginx_service: false
```

### nginx_service_enabled

#### Default value

```YAML
nginx_service_enabled: true
```

### nginx_service_name

#### Default value

```YAML
nginx_service_name: nginx
```

### nginx_service_state

#### Default value

```YAML
nginx_service_state: started
```

### nginx_ssl

#### Default value

```YAML
nginx_ssl: false
```

### nginx_ssl_dhparam

#### Default value

```YAML
nginx_ssl_dhparam: false
```

### nginx_ssl_dhparam_path

#### Default value

```YAML
nginx_ssl_dhparam_path: '{{ nginx_ssl_dir }}/dhparam.pem'
```

### nginx_ssl_dhparam_size

#### Default value

```YAML
nginx_ssl_dhparam_size: '4096'
```

### nginx_ssl_dir

#### Default value

```YAML
nginx_ssl_dir: '{{ nginx_config_dir }}/ssl'
```

### nginx_ssl_pairs

#### Default value

```YAML
nginx_ssl_pairs: []
```

### nginx_tcp_nodelay

#### Default value

```YAML
nginx_tcp_nodelay: on
```

### nginx_tcp_nopush

#### Default value

```YAML
nginx_tcp_nopush: on
```

### nginx_types_hash_max_size

#### Default value

```YAML
nginx_types_hash_max_size: '2048'
```

### nginx_vhost_dir

#### Default value

```YAML
nginx_vhost_dir: '{{ nginx_config_dir }}/conf.d'
```

### nginx_vhosts

#### Default value

```YAML
nginx_vhosts: {}
```

### nginx_worker_connections

#### Default value

```YAML
nginx_worker_connections: '1024'
```

### nginx_worker_multi_accept

#### Default value

```YAML
nginx_worker_multi_accept: off
```

### nginx_worker_processes

#### Default value

```YAML
nginx_worker_processes: auto
```

## Discovered Tags

**_nginx_**

**_nginx-configure_**

**_nginx-install_**

**_nginx-service_**

**_nginx-ssl_**

**_skip_ansible_lint_**


## Dependencies

- jtyr.config_encoder_filters

## License

MIT

## Author

cornfeedhobo
