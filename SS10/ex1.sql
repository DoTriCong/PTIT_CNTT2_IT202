-- Tạo một view có tên view_users_firstname để hiển thị danh sách các người dùng có họ “Nguyễn”. View này cần bao gồm các cột: user_id, username, full_name, email, created_at.
CREATE OR REPLACE VIEW view_users_firstname AS 
SELECT u.user_id, u.username, u.full_name, u.email, u.created_at
FROM users u
WHERE u.full_name LIKE 'Nguyễn%';

SELECT * FROM view_users_firstname;

INSERT INTO users(username, full_name, gender, email, password, birthdate, hometown) VALUES
('new_user', 'Nguyễn Van A', 'Nam', 'daiSV10@gmail.com', '123456', '2006-08-27', 'Hà Nội');


SELECT * FROM view_users_firstname;

DELETE FROM users
WHERE username = 'new_user';