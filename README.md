# Main repository:

- go-store-app

# Sub-modules:

## 1. go-store-gateway

- GITHUB: https://github.com/huynhminhtruong/go-store-gateway.git

## 2. go-store-kong

- GITHUB: https://github.com/huynhminhtruong/go-store-kong.git

## 3. go-store-service

- GITHUB: https://github.com/huynhminhtruong/go-store-services.git

## 4. go-store-order

- GITHUB: https://github.com/huynhminhtruong/go-store-order.git

## 5. go-store-shipping

- GITHUB: https://github.com/huynhminhtruong/go-store-shipping.git

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

Nếu mọi thứ đúng, tên submodule mới sẽ được cập nhật mà không cần file `.gitmodules`

# Setup specific branch for submodule in main repo

Trong Git, lệnh `git submodule update --recursive --remote` sẽ cập nhật các submodule về commit đã được ghi nhận trong main repo. Nếu bạn đã chuyển sang một nhánh mới trong submodule nhưng vẫn muốn giữ nhánh đó khi cập nhật từ main repo, bạn cần chỉ định nhánh mặc định cho submodule trong main repository

Dưới đây là cách làm để submodule luôn sử dụng một nhánh cố định khi cập nhật:

### Bước 1: Cấu hình nhánh cho submodule trong main repo

1. Chuyển tới thư mục chính của main repo
2. Mở file `.gitmodules` để chỉ định nhánh mặc định cho submodule `book-service`

   ```ini
   [submodule "path/to/book-service"]
       path = path/to/book-service
       url = <submodule_repo_url>
       branch = <branch_name>
   ```

   Trong đó, `branch_name` là nhánh mà bạn muốn submodule `book-service` sẽ luôn sử dụng khi cập nhật

3. Sau đó, chạy các lệnh sau để cập nhật cấu hình:

   ```bash
   git add .gitmodules
   git commit -m "Set default branch for submodule book-service"
   ```

### Bước 2: Cập nhật submodule với nhánh chỉ định

Sau khi cấu hình nhánh trong `.gitmodules`, bạn có thể chạy lệnh sau để cập nhật submodule `book-service` theo nhánh đã đặt:

```bash
git submodule update --remote --recursive
```

### Kiểm tra Submodule

Submodule sẽ luôn cập nhật theo nhánh được chỉ định trong `.gitmodules`

# Connect Ubuntu Server To GitHub Via SSH-Key

Để kết nối từ Ubuntu tới GitHub thông qua SSH key thay vì username và password, bạn có thể thực hiện các bước sau:

### 1. Tạo SSH Key (Nếu Chưa Có)

1. Mở terminal và chạy lệnh dưới để tạo SSH key:

   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

   **Ghi chú:** Thay `your_email@example.com` bằng email bạn đã dùng đăng ký trên GitHub

2. Khi được hỏi về đường dẫn lưu key, bạn có thể nhấn `Enter` để lưu tại vị trí mặc định (`~/.ssh/id_ed25519`), hoặc chỉ định một vị trí khác

3. Nếu bạn muốn bảo mật hơn, nhập mật khẩu cho key; nếu không, chỉ cần nhấn `Enter` để bỏ qua

### 2. Thêm SSH Key Vào Agent

1. Kích hoạt SSH agent:

   ```bash
   eval "$(ssh-agent -s)"
   ```

2. Thêm SSH key vào agent:

   ```bash
   ssh-add ~/.ssh/id_ed25519
   ```

### 3. Thêm SSH Key Vào GitHub

1. Sao chép nội dung của SSH key vào clipboard:

   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

2. Truy cập [GitHub SSH keys settings](https://github.com/settings/keys), chọn **New SSH Key** và dán key bạn vừa sao chép vào

3. Đặt tên cho key này (ví dụ: "Ubuntu laptop") và nhấn **Add SSH Key**

### 4. Kiểm Tra Kết Nối SSH Với GitHub

Chạy lệnh dưới để kiểm tra kết nối:

```bash
ssh -T git@github.com
```

Nếu mọi thứ cài đặt đúng, bạn sẽ thấy thông báo như:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access
```

### 5. Đảm Bảo Sử Dụng SSH URL Khi Clone Repository

Khi clone repository, hãy dùng SSH URL thay vì HTTPS URL:

```bash
git clone git@github.com:username/repository.git
```

Với cách này, bạn có thể push và pull mà không cần nhập username và password

# Đổi URL của remote từ HTTPS sang SSH như sau

### 1. Kiểm Tra URL Hiện Tại của Remote

Chạy lệnh dưới đây để kiểm tra xem bạn đang dùng HTTPS hay SSH:

```bash
git remote -v
```

Nếu URL có dạng `https://github.com/username/repository.git`, thì Git sẽ yêu cầu username và password. Còn nếu URL có dạng `git@github.com:username/repository.git`, nghĩa là bạn đang dùng SSH.

### 2. Chuyển Đổi Từ HTTPS Sang SSH

Chạy lệnh sau để thay đổi URL từ HTTPS sang SSH:

```bash
git remote set-url origin git@github.com:username/repository.git
```

**Ghi chú:** Thay `username` và `repository` bằng tên người dùng và tên repository của bạn trên GitHub

### 3. Kiểm Tra Lại Remote và Push

Sau khi đổi URL, bạn có thể kiểm tra lại bằng cách:

```bash
git remote -v
```

Khi đã thấy URL có dạng SSH (`git@github.com:username/repository.git`), bạn có thể thử `git push` và lần này Git sẽ sử dụng SSH key để xác thực thay vì yêu cầu username và password
