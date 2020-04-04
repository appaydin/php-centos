# PHP Centos Latest

PHP Version: 7.4 - appaydin/php-centos

PHP Version: 7.3 - appaydin/php-centos:php-73

The default directory /app is set to port 9000. You can check the installed plugins from the Dockerfile file. [Docker Config Loader](https://github.com/appaydin/docker-config-loader) was used for dynamic configuration.

### Example Application:
docker-compose:
```yaml
version: '3'

services:
    centosphp:
        image: appaydin/php-centos
        #ports:
        #    - 9000
        environment:
            # PHP Dynamic Configuration
            - PHP_1=output_buffering:4096
            - PHP_2=display_errors:Off
            - PHP_3=max_execution_time:60
            - PHP_4=max_input_time:60
            - PHP_5=memory_limit:512M
            - PHP_6=post_max_size:500M
            - PHP_7=upload_max_filesize:25M
            - PHP_8=max_file_uploads:50
            - PHP_9=log_errors:On
            # Use regex escape characters for special characters.
            - PHP_10=error_log:"\/logs\/php_error.log"
            - PHP_11=opcache.enable:1
            - PHP_12=opcache.max_accelerated_files:75000
            # PHP_13=php_config_name:value

            # PHP-FPM Dynamic Configuration
            - FPM_1=user:apache
            - FPM_2=group:apache
            - FPM_3=listen:127.0.0.1:9000
            - FPM_4=pm:dynamic
            - FPM_5=pm.max_children:15
            - FPM_6=pm.start_servers:6
            - FPM_7=pm.min_spare_servers:2
            - FPM_8=pm.max_spare_servers:10
            - FPM_9=php_admin_value\[error_log\]:"\/logs\/php-fpm-error.log"
            # FPM_10=phpfpm_config_name:value
        volumes:
            - ./:/app
```