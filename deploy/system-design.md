**Kong Gateway** làm layer quản lý proxy và load balancing
**grpc-gateway** để xử lý việc ánh xạ HTTP sang gRPC

Mô hình này giúp giảm thiểu công việc phải xử lý trực tiếp từ `.proto` trong các dịch vụ gRPC
vì grpc-gateway sẽ đảm nhận nhiệm vụ chuyển đổi (transcoding) từ HTTP sang gRPC dựa trên các endpoint được định nghĩa trong file `.proto`

### Kiến trúc triển khai

```
[Client HTTP] --> [Kong Gateway] --> [grpc-gateway] --> [BookService (gRPC)]
```

### Lợi ích của mô hình này

1. **Quản lý lưu lượng và bảo mật qua Kong Gateway**:

   - Kong sẽ thực hiện các tác vụ quản lý lưu lượng (rate limiting), kiểm soát truy cập, xác thực, và load balancing
   - Điều này giúp bạn có thể bảo vệ hệ thống của mình trước các tấn công DDoS hoặc các yêu cầu từ nguồn không xác thực

2. **Giảm nhu cầu chuyển đổi (transcoding) trực tiếp trong Envoy hoặc dịch vụ gRPC**:

   - Nhờ sử dụng grpc-gateway, bạn sẽ không phải cấu hình các annotation phức tạp hoặc xây dựng các logic chuyển đổi JSON trực tiếp trong dịch vụ gRPC
   - grpc-gateway sẽ tự động chuyển đổi các yêu cầu HTTP thành gRPC dựa trên file `.proto`

3. **Tích hợp liền mạch giữa HTTP và gRPC**:

   - Các client HTTP có thể gửi các yêu cầu RESTful đến Kong Gateway như với các API thông thường, và Kong sẽ chuyển tiếp đến grpc-gateway mà không cần thay đổi nhiều trong cấu trúc mã gRPC
   - grpc-gateway sẽ xử lý việc ánh xạ các endpoint HTTP đến các phương thức gRPC, nhờ đó các yêu cầu sẽ được chuyển tiếp đến đúng phương thức trong `BookService`

4. **Khả năng mở rộng và quản lý tốt hơn**:
   - Mô hình này tách biệt rõ ràng giữa các lớp:
     - **Kong Gateway** xử lý các vấn đề về bảo mật, quản lý lưu lượng, cân bằng tải và proxy
     - **grpc-gateway** tập trung vào việc chuyển đổi từ HTTP sang gRPC mà không làm thay đổi cấu trúc nội bộ của gRPC service
   - Điều này giúp bạn dễ dàng mở rộng và bảo trì từng thành phần mà không ảnh hưởng đến toàn bộ hệ thống

### Cấu hình triển khai

1. **Định nghĩa các HTTP endpoint trong file `.proto`** cho grpc-gateway:

   - Sử dụng `google.api.http` để định nghĩa các endpoint HTTP tương ứng với các phương thức gRPC.
   - Ví dụ:
     ```proto
     service BookService {
         rpc Create(CreateBookRequest) returns (CreateBookResponse) {
             option (google.api.http) = { post: "/v1/books/create" };
         }
         rpc GetBook(GetBookRequest) returns (GetBookResponse) {
             option (google.api.http) = { get: "/v1/books/{book_id}" };
         }
         rpc ListBooks(ListBooksRequest) returns (ListBooksResponse) {
             option (google.api.http) = { get: "/v1/books" };
         }
     }
     ```
   - grpc-gateway sẽ tạo các HTTP handlers tương ứng với các endpoint trên, và ánh xạ chúng đến các phương thức gRPC

2. **Cấu hình Kong Gateway** để chuyển tiếp các yêu cầu HTTP đến grpc-gateway:

   - Trong Kong, bạn sẽ thiết lập một **Service** trỏ tới địa chỉ của grpc-gateway, ví dụ: `http://grpc-gateway:8080`
   - Tạo các **Routes** để định nghĩa các endpoint HTTP mà Kong sẽ chấp nhận từ client, ví dụ: `/v1/books`, `/v1/books/{book_id}`, `/v1/books/create`
   - Các Route sẽ chuyển tiếp đến grpc-gateway, sau đó grpc-gateway sẽ chuyển đổi các yêu cầu HTTP thành gRPC và gọi các phương thức tương ứng trong `BookService`

3. **Xử lý truy cập và bảo mật tại Kong**:
   - Thêm các **plugin** của Kong để xử lý bảo mật, xác thực, quản lý lưu lượng, logging, v.v. (ví dụ: `rate-limiting`, `key-auth`)
   - Điều này giúp bạn bảo vệ grpc-gateway và các gRPC services khỏi lưu lượng không mong muốn

### Tóm lại

Mô hình `[Kong Gateway] -> [grpc-gateway] -> [BookService (gRPC)]` mà bạn đề xuất là một thiết kế hiệu quả, tận dụng được lợi thế của cả Kong và grpc-gateway:

- Kong cung cấp tính năng proxy và load balancing mạnh mẽ, cộng với bảo mật
- grpc-gateway giảm tải việc phải tự chuyển đổi giữa HTTP và gRPC, tạo ra trải nghiệm RESTful API cho client mà không cần viết lại logic trong các dịch vụ gRPC

Cách triển khai này giúp hệ thống dễ dàng bảo trì và mở rộng khi có nhiều dịch vụ gRPC khác được thêm vào hệ thống trong tương lai
