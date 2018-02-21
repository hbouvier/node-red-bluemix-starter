

Assuming that your node-red container environment variables looks like this:
```bash
...
ITERM_PROFILE=Default
LC_CTYPE=en_CA.UTF-8
MQTT_HOST=mqtt.local
MQTT_USER=admin
MQTT_PASSWORD=secret
PATH=/bin
POSTGRESQL_HOST=postgresql.local
POSTGRESQL_USER=postgres
POSTGRESQL_PASSWORD=password
...
```

And you add the **NODE_RED_ENV_STARTSWITH** with **MQTT_,POSTGRESQL_**

```
NODE_RED_ENV_STARTSWITH="MQTT_,POSTGRESQL_"
```

in node-red you will have access to a javascript object `env` that will have a copy of all the environment variables starting with **MQTT_ ** AND **POSTGRESQL_**.

```bash
const env = global.get('env');
console.log(env);

    MQTT_HOST=mqtt.local
    MQTT_USER=admin
    MQTT_PASSWORD=secret
    POSTGRESQL_HOST=postgresql.local
    POSTGRESQL_USER=postgres
    POSTGRESQL_PASSWORD=password
```
