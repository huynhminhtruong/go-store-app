# 1. Docker-Compose

## Cách tham chiếu environment variable vào docker-compose

```bash
docker-compose --env-file .env.dev up -d
```

## Restart container

```bash
# service_name is defined in file docker-compose.yml
docker-compose restart <service_name>
```

## Build lại với code mới

```bash
docker-compose up --build
```

- Build lại các image từ Dockerfile hoặc docker-compose.yml với code mới
- Khởi động lại các container đang chạy bằng các image vừa build mà không cần xóa các image cũ

## Xóa các docker-container cũ và restart(không giữ lại bất kỳ dữ liệu nào từ container cũ)

```bash
docker-compose up --build --force-recreate
```

## Build lại image cho một service

```bash
docker-compose build <service_name>
```

## Build lại image và khởi động lại container

```bash
docker-compose up --build <service_name>
```

## Để build hoặc rebuild các images cho các services được chỉ định trong file docker-compose.yml mà không restart hoặc tạo lại các docker-container

```bash
docker-compose build [options] [SERVICE...]
```

- options
  --no-cache: Bỏ qua cache khi build image
  --pull: Tải các base images mới nhất từ registry (nếu có) trước khi build
  --parallel: Build các dịch vụ song song để giảm thời gian chờ đợi

- Sau khi build xong, bạn có thể sử dụng docker-compose up để khởi động các container từ images đã build
- Nếu có thay đổi trong **Dockerfile** hoặc file cấu hình **docker-compose.yml**, bạn sẽ cần chạy lại **docker-compose build** để cập nhật các images

## copy file từ host sang docker container

```bash
docker cp /path/to/your/protos/book.proto <container_id_or_name>:/protos/book.proto
docker cp proto/book.proto kong_container:/usr/local/kong/
```

# 2. Docker

## Access into docker container

```bash
# login with default user
docker exec -it <container_name_or_id> /bin/sh

# login with root user
docker exec -it -u root <container_name_or_id> /bin/sh

# change owner permission
chown user:group <file_or_dir>
chown -R user:group <file_or_dir>

# change modify permission
chmod 644 <file_or_dir>
```

## Logs

- Get logs:
  docker logs <container_name_or_id>

- Real-time logs:
  docker logs -f <container_name_or_id>

- Get the latest logs:
  docker logs --tail <container_name_or_id>

- Kiểm tra nguyên nhân dừng của Container(nếu container không chạy):
  docker inspect <container_name_or_id> --format='{{.State.ExitCode}}'
