# nginx [![Ansible Role](https://img.shields.io/ansible/role/d/34099.svg)](https://galaxy.ansible.com/cornfeedhobo/nginx)

Ansible role to install and manage nginx.

This role tries to avoid all opinionation, powered by
[`jtyr/ansible-config_encoder_filters`](https://github.com/jtyr/ansible-config_encoder_filters).

```bash
ansible-galaxy install cornfeedhobo.nginx
```

## Role Variables

|Name|Default Value|
|-|-|
| `nginx_install` | `false` |
| `nginx_package_state` | `"present"` |
| `nginx_packages` | `["nginx"]` |
| `nginx_service` | `false` |
| `nginx_service_name` | `"nginx"` |
| `nginx_service_state` | `"started"` |
| `nginx_service_enabled` | `true` |
| `nginx_configure` | `false` |
| `nginx_owner` | `"{{ __nginx_owner }}"` |
| `nginx_group` | `"{{ __nginx_group }}"` |
| `nginx_pidfile` | `"/run/nginx.pid"` |
| `nginx_log_dir` | `"/var/log/nginx"` |
| `nginx_error_log` | `"{{ nginx_log_dir }}/error.log"` |
| `nginx_access_log` | `"{{ nginx_log_dir }}/access.log"` |
| `nginx_worker_processes` | `"auto"` |
| `nginx_worker_connections` | `"1024"` |
| `nginx_worker_multi_accept` | `"off"` |
| `nginx_sendfile` | `"on"` |
| `nginx_tcp_nopush` | `"on"` |
| `nginx_tcp_nodelay` | `"on"` |
| `nginx_keepalive_timeout` | `"65"` |
| `nginx_keepalive_requests` | `"100"` |
| `nginx_types_hash_max_size` | `"2048"` |
| `nginx_log_format_main` | <pre>$remote_addr - $remote_user [$time_local] "$request"<br/>$status $body_bytes_sent "$http_referer"<br/>"$http_user_agent" "$http_x_forwarded_for"'</pre> |
| `nginx_config_dir` | `"/etc/nginx"` |
| `nginx_config_path` | `"{{ nginx_config_dir }}/nginx.conf"` |
| `nginx_mime_path` | `"{{ nginx_config_dir }}/mime.types"` |
| `nginx_mime_extra` | `[]` |
| `nginx_config` | <pre>- "user {{ nginx_owner }}"<br/>- "pid {{ nginx_pidfile }}"<br/>- "error_log {{ nginx_error_log }} warn"<br/>- "worker_processes {{ nginx_worker_processes }}"</pre> |
| `nginx_config_events` | <pre>- "worker_connections {{ nginx_worker_connections }}"<br/>- "multi_accept {{ nginx_worker_multi_accept }}"</pre> |
| `nginx_config_http` | <pre>- "log_format main {{ nginx_log_format_main }}"<br/>- "access_log  {{ nginx_access_log }} main"<br/>- "sendfile {{ nginx_sendfile }}"<br/>- "tcp_nopush {{ nginx_tcp_nopush }}"<br/>- "tcp_nodelay {{ nginx_tcp_nodelay }}"<br/>- "keepalive_timeout {{ nginx_keepalive_timeout }}"<br/>- "keepalive_requests {{ nginx_keepalive_requests }}"<br/>- "types_hash_max_size {{ nginx_types_hash_max_size }}"<br/>- "include {{ nginx_mime_path }}"<br/>- "default_type application/octet-stream"<br/>- "include {{ nginx_vhost_dir }}/*.conf"</pre> |
| `nginx_config_http_extra` | `[]` |
| `nginx_vhost_dir` | `"{{ nginx_config_dir }}/conf.d"` |
| `nginx_vhosts` | `{}` |
| `nginx_ssl` | `false` |
| `nginx_ssl_dir` | `"{{ nginx_config_dir }}/ssl"` |
| `nginx_ssl_dhparam` | `false` |
| `nginx_ssl_dhparam_size` | `"4096"` |
| `nginx_ssl_dhparam_path` | `"{{ nginx_ssl_dir }}/dhparam.pem"` |
| `nginx_ssl_pairs` | `[]` |

## Dependencies

- [jtyr.config_encoder_filters](https://github.com/jtyr/ansible-config_encoder_filters)

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
roles:

- role: "cornfeedhobo.nginx"
    nginx_install: true
    nginx_configure: true
    nginx_service: true

    nginx_ssl_pairs:
    - name: "example.org"
        key: "{{ lookup('file', 'example.org.key') }}"
        crt: "{{ lookup('file', 'example.org.crt') }}"
        ca: "{{ lookup('file', 'example.org.ca.crt') }}"

    nginx_vhost_default:

    # direct all clearnet traffic to ssl
    - server:
        - "listen {{ ansible_eth0.ipv4.address }}:80 default_server"
        - "server_name example.org *.example.org"
        - "return 301 https://$host$request_uri"

    # send requests for example.org to www.example.org
    - server:
        - "listen {{ ansible_eth0.ipv4.address }}:80"
        - "listen {{ ansible_eth0.ipv4.address }}:443 ssl http2"
        - "server_name example.org"
        - "ssl_prefer_server_ciphers on"
        - "ssl_session_cache shared:SSL:10m"
        - "ssl_ciphers EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH"
        - "ssl_protocols TLSv1.2 TLSv1.3"
        - "ssl_certificate {{ nginx_ssl_dir }}/example.org.crt"
        - "ssl_certificate_key {{ nginx_ssl_dir }}/example.org.key"
        - "return 301 $scheme://www.example.org$request_uri"
```

## Development

### pip

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pip uninstall -y selinux
```

### pipenv

```bash
pipenv sync
pipenv run pip uninstall -y selinux
```

## License

MIT
