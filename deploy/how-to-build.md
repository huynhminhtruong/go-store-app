# Cách tham chiếu environment variable vào docker-compose

- docker-compose --env-file .env.dev up -d

- docker-compose build [options] [SERVICE...]

  - options
    --no-cache: Bỏ qua cache khi build image
    --pull: Tải các base images mới nhất từ registry (nếu có) trước khi build
    --parallel: Build các dịch vụ song song để giảm thời gian chờ đợi

- Sau khi build xong, bạn có thể sử dụng docker-compose up để khởi động các container từ images đã build
- Nếu có thay đổi trong **Dockerfile** hoặc file cấu hình **docker-compose.yml**, bạn sẽ cần chạy lại **docker-compose build** để cập nhật các images

# Docker logs

- Get logs:
  docker logs <container_name_or_id>

- Real-time logs:
  docker logs -f <container_name_or_id>

- Get the latest logs:
  docker logs --tail <container_name_or_id>

- Kiểm tra nguyên nhân dừng của Container(nếu container không chạy):
  docker inspect <container_name_or_id> --format='{{.State.ExitCode}}'
