# Main repository:

- go-store-app

# Sub-modules:

## 1. go-store-gateway

- GITHUB: https://github.com/huynhminhtruong/go-store-gateway.git

## 2. go-store-service

- GITHUB: https://github.com/huynhminhtruong/go-store-services.git

# Create sub-modules:

Để quản lý các repository `gateway service` và `book service` như submodule trong một repository chung, bạn có thể thực hiện theo các bước sau:

### Bước 1: Tạo Repository Chung

Tạo repository mới (ví dụ: `main-repo`) để chứa các submodule. Bạn có thể tạo trực tiếp trên GitHub, GitLab hoặc một nền tảng quản lý mã nguồn tương tự

### Bước 2: Thêm Các Repository Làm Submodule

Vào thư mục của repository `main-repo`, sau đó thêm các repository `gateway service` và `book service` làm submodule

```bash
# Điều hướng vào thư mục main-repo
cd main-repo

# Thêm repository `gateway service` làm submodule
git submodule add <url_git_gateway_service> gateway-service

# Thêm repository `book service` làm submodule
git submodule add <url_git_book_service> book-service
```

Lệnh `git submodule add` sẽ tạo một thư mục tương ứng cho mỗi submodule (`gateway-service` và `book-service`) trong `main-repo` và lưu URL của submodule trong file `.gitmodules`

### Bước 3: Cập nhật và Đồng bộ Submodule

Khi bạn clone hoặc cập nhật `main-repo`, bạn có thể tải và cập nhật các submodule như sau:

```bash
# Khi clone repository chung với các submodule
git clone --recurse-submodules <url_git_main_repo>

# Khi đã có `main-repo` và muốn cập nhật các submodule
git submodule update --init --recursive
```

### Bước 4: Quản lý Thay đổi trong Submodule

Mỗi khi thực hiện thay đổi trong một submodule, bạn cần vào thư mục submodule đó, commit và push bình thường. Sau đó, quay lại `main-repo`, commit lại phiên bản cập nhật của submodule:

```bash
# Vào submodule và thực hiện thay đổi
cd gateway-service
# <thực hiện các thay đổi>
git add .
git commit -m "Update gateway service"
git push

# Quay lại main-repo và commit submodule update
cd ..
git add gateway-service
git commit -m "Update submodule gateway-service to latest commit"
git push
```

### Bước 5: Xóa Submodule (nếu cần)

Để xóa một submodule, bạn có thể làm như sau:

```bash
# Xóa thư mục submodule và thông tin trong `.gitmodules`
git submodule deinit -f <submodule_path>
git rm -f <submodule_path>
rm -rf .git/modules/<submodule_path>
```

Với cách này, bạn có thể quản lý nhiều repository thành các submodule trong repository chung một cách dễ dàng

Nếu repository của bạn không có file `.gitmodules`, bạn vẫn có thể đổi tên submodule trực tiếp thông qua các lệnh Git. Dưới đây là cách làm:

1. **Đổi tên thư mục của submodule**:

   ```bash
   mv old_submodule_name new_submodule_name
   ```

2. **Cập nhật file cấu hình trong `.git/config`**:

   - Mở file `.git/config` trong repository chính.
   - Tìm dòng cấu hình liên quan đến submodule, ví dụ:
     ```plaintext
     [submodule "old_submodule_name"]
       url = <repository_url>
       path = old_submodule_name
     ```
   - Đổi `path` và tên submodule thành tên mới:
     ```plaintext
     [submodule "new_submodule_name"]
       url = <repository_url>
       path = new_submodule_name
     ```

3. **Kiểm tra và cập nhật submodule**:

   - Chạy lệnh sau để đảm bảo cấu hình submodule được cập nhật:
     ```bash
     git submodule sync
     git submodule update --init --recursive
     ```

4. **Commit thay đổi**:
   - Sau khi thay đổi, commit các cập nhật trong repository chính:
     ```bash
     git add .
     git commit -m "Rename submodule to new_submodule_name"
     ```

Nếu mọi thứ đúng, tên submodule mới sẽ được cập nhật mà không cần file `.gitmodules`.
