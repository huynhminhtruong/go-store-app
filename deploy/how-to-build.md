# Cách tham chiếu environment variable vào docker-compose

- docker-compose --env-file .env.dev up

# Docker logs

- Get logs:
  docker logs <container_name_or_id>

- Real-time logs:
  docker logs -f <container_name_or_id>

- Get the latest logs:
  docker logs --tail <container_name_or_id>

- Kiểm tra nguyên nhân dừng của Container(nếu container không chạy):
  docker inspect <container_name_or_id> --format='{{.State.ExitCode}}'
