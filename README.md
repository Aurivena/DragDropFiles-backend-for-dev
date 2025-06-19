### Запуск
```
make restart
```

### .env

```
MINIO_ROOT_USER=answer-minio-user
MINIO_ROOT_PASSWORD=answer-minio-password
MINIO_USE_SSL=false
MINIO_BUCKET_NAME=answer-minio-bucket

POSTGRES_USER=answer_postgres_user
POSTGRES_PASSWORD=answer_postgres_password
POSTGRES_DB=answer_postgres_database

VITE_API_URL=http://localhost:8080

REPO_URL_BACKEND=https://github.com/Aurivena/DragDropFile-API.git
REPO_URL_FRONT=https://github.com/Aurivena/f.git

API_CONFIG_FILE_PATH=./config.json
```
### config.json 
```
{
  "server": {
    "server_port": "8080",
    "server_mode": "development",
    "server_domain": "http://localhost"
  },
  "business-database": {
    "db_password":"answer_postgres_password",
    "db_host": "postgres",
    "db_port": "5432",
    "db_username":"answer_postgres_user",
    "db_name":"answer_postgres_database",
    "db_ssl_mode": "disable"
  },
  "minio": {
    "endpoint":"minio:9000",
    "minio_root_user":"answer-minio-user",
    "minio_root_password":"answer-minio-password",
    "minio_use_ssl": false,
    "minio_bucket_name":"answer-minio-bucket"
  }
}
```