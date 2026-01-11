-- Tạo chỉ mục phức hợp (Composite Index)
-- Tạo một truy vấn để tìm tất cả các bài viết (posts) trong năm 2026 của người dùng có user_id là 1. Trả về các cột post_id, content, và created_at.
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at >= '2026-01-01 00:00:00'
  AND created_at <  '2027-01-01 00:00:00';
-- Tạo chỉ mục phức hợp với tên idx_created_at_user_id trên bảng posts sử dụng các cột created_at và user_id.
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at >= '2026-01-01 00:00:00'
  AND created_at <  '2027-01-01 00:00:00';

CREATE INDEX idx_created_at_user_id
ON posts (created_at, user_id);
-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_created_at_user_id. So sánh kết quả thực thi giữa hai lần này.
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at >= '2026-01-01 00:00:00'
  AND created_at <  '2027-01-01 00:00:00';
-- Tạo chỉ mục duy nhất (Unique Index)
-- Tạo một truy vấn để tìm tất cả các người dùng (users) có email là 'an@gmail.com'. Trả về các cột user_id, username, và email.
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';
-- Tạo chỉ mục duy nhất với tên idx_email trên cột email trong bảng users.


