# docker-scassandra
Stubbed Apache Cassandra Docker Image

[![Docker Pulls](https://img.shields.io/docker/pulls/burakince/scassandra.svg)](https://hub.docker.com/r/burakince/scassandra/) [![Docker Automated build](https://img.shields.io/docker/automated/burakince/scassandra.svg)](https://hub.docker.com/r/burakince/scassandra/) [![Docker Build Status](https://img.shields.io/docker/build/burakince/scassandra.svg)](https://hub.docker.com/r/burakince/scassandra/)

Latest SCassandra: [![scassandra tag](https://img.shields.io/github/tag/scassandra/scassandra-server.svg)](https://github.com/scassandra/scassandra-server)

This project using [Stubbed Apache Cassandra Project](https://github.com/scassandra/scassandra-server/).

Documentation about scassandra project http://scassandra-docs.readthedocs.io/en/latest/standalone/overview/

# Usage

* Default Cassandra port: 8042
* Default Admin API port: 8043

```
docker run --rm -p 8042:8042 -p 8043:8043 burakince/scassandra
```

## Loading Data Example

```
curl -0 -v -X POST http://localhost:8043/prime-prepared-single \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d @- << EOF

{
  "when": {
    "query": "select * from people"
  },
  "then": {
    "variable_types": [
      "varchar"
    ],
    "rows": [
      {
        "name": "Chris"
      }
    ],
    "result": "success",
    "column_types": {
      "name": "varchar"
    }
  }
}
EOF
```

## Testing Loaded Data Example

```
curl -i \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -X GET http://localhost:8043/prime-prepared-single
```
