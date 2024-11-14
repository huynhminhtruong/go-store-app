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

## Sử dụng các lệnh này sẽ giúp giải phóng dung lượng lưu trữ trên hệ thống Docker của bạn

  - Docker cung cấp lệnh `docker builder prune` để xóa các file và lớp build (build layers) không còn được sử dụng nhằm tiết kiệm dung lượng
  
  - Đây là các lệnh phổ biến để quản lý và xóa các file hoặc layer build không cần thiết:
  
  1. **Xóa các layer build không dùng:**
     ```bash
     docker builder prune
     ```
  
     - Lệnh này sẽ xóa các lớp build (cache layers) không còn được sử dụng bởi bất kỳ image nào. Bạn có thể thêm tùy chọn `-f` (force) để tránh yêu cầu xác nhận
  
  2. **Xóa image không còn sử dụng (dangling images):**
     ```bash
     docker image prune
     ```
  
     - Lệnh này sẽ xóa các image không có tag (dangling images) mà không liên kết với container nào
  
  3. **Xóa toàn bộ các image không dùng:**
     ```bash
     docker image prune -a
     ```
  
     - Tùy chọn `-a` sẽ xóa tất cả các image không được sử dụng bởi container nào, bao gồm cả các image có tag
  
  4. **Xóa tất cả các dữ liệu không sử dụng (volumes, images, containers, networks):**
     ```bash
     docker system prune
     ```
  
     - Lệnh này sẽ xóa tất cả các volumes, images, containers, và networks không được sử dụng. Bạn có thể thêm `-a` để xóa thêm cả các image chưa chạy
