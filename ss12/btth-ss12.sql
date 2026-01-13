DROP DATABASE IF EXISTS social_network;
CREATE DATABASE social_network;
USE social_network;

-- Bảng Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Posts
CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Bảng Comments
CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Bảng Friends
CREATE TABLE Friends (
    user_id INT,
    friend_id INT,
    status VARCHAR(20),
    CHECK (status IN ('pending','accepted')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (friend_id) REFERENCES Users(user_id)
);

-- Bảng Likes
CREATE TABLE Likes (
    user_id INT,
    post_id INT,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- BÀI 1: Thêm và hiển thị Users
INSERT INTO Users (username, password, email)
VALUES 
('an01','123','an@gmail.com'),
('binh02','123','binh@gmail.com'),
('chi03','123','chi@gmail.com');

SELECT * FROM Users;

-- BÀI 2: VIEW công khai
CREATE OR REPLACE VIEW vw_public_users AS
SELECT user_id, username, created_at
FROM Users;

SELECT * FROM vw_public_users;

-- BÀI 3: INDEX tìm kiếm user
CREATE INDEX idx_users_username ON Users(username);

SELECT * FROM Users WHERE username = 'an01';
-- BÀI 4: Procedure đăng bài
DELIMITER //
CREATE PROCEDURE sp_create_post(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE user_id = p_user_id) THEN
        INSERT INTO Posts(user_id, content)
        VALUES (p_user_id, p_content);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User không tồn tại';
    END IF;
END //
DELIMITER ;

CALL sp_create_post(1, 'Bài viết đầu tiên');
CALL sp_create_post(2, 'Học Database rất hay');

-- BÀI 5: VIEW News Feed
CREATE OR REPLACE VIEW vw_recent_posts AS
SELECT *
FROM Posts
WHERE created_at >= NOW() - INTERVAL 7 DAY;

SELECT * FROM vw_recent_posts;

-- BÀI 6: INDEX tối ưu bài viết
CREATE INDEX idx_posts_user ON Posts(user_id);
CREATE INDEX idx_posts_user_date ON Posts(user_id, created_at);

SELECT * FROM Posts
WHERE user_id = 1
ORDER BY created_at DESC;

-- BÀI 7: Thống kê số bài viết
DELIMITER //
CREATE PROCEDURE sp_count_posts(
    IN p_user_id INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
    FROM Posts
    WHERE user_id = p_user_id;
END //
DELIMITER ;

SET @total = 0;
CALL sp_count_posts(1, @total);
SELECT @total AS total_posts;

-- BÀI 8: VIEW WITH CHECK OPTION
CREATE OR REPLACE VIEW vw_active_users AS
SELECT user_id, username, email, created_at
FROM Users
WHERE created_at IS NOT NULL
WITH CHECK OPTION;

-- BÀI 9: Kết bạn
DELIMITER //
CREATE PROCEDURE sp_add_friend(
    IN p_user_id INT,
    IN p_friend_id INT
)
BEGIN
    IF p_user_id = p_friend_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể kết bạn với chính mình';
    ELSE
        INSERT INTO Friends(user_id, friend_id, status)
        VALUES (p_user_id, p_friend_id, 'pending');
    END IF;
END //
DELIMITER ;

CALL sp_add_friend(1,2);

-- BÀI 10: Gợi ý bạn bè
DELIMITER //
CREATE PROCEDURE sp_suggest_friends(
    IN p_user_id INT,
    INOUT p_limit INT
)
BEGIN
    DECLARE counter INT DEFAULT 0;

    WHILE counter < p_limit DO
        SELECT user_id, username
        FROM Users
        WHERE user_id != p_user_id
        LIMIT counter,1;
        SET counter = counter + 1;
    END WHILE;
END //
DELIMITER ;

SET @limit = 2;
CALL sp_suggest_friends(1, @limit);

-- BÀI 11: Top bài viết
CREATE INDEX idx_likes_post ON Likes(post_id);

CREATE OR REPLACE VIEW vw_top_posts AS
SELECT p.post_id, p.content, COUNT(l.post_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC
LIMIT 5;

SELECT * FROM vw_top_posts;

-- BÀI 12: Bình luận
DELIMITER //
CREATE PROCEDURE sp_add_comment(
    IN p_user_id INT,
    IN p_post_id INT,
    IN p_content TEXT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE user_id = p_user_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User không tồn tại';
    ELSEIF NOT EXISTS (SELECT 1 FROM Posts WHERE post_id = p_post_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Post không tồn tại';
    ELSE
        INSERT INTO Comments(user_id, post_id, content)
        VALUES (p_user_id, p_post_id, p_content);
    END IF;
END //
DELIMITER ;

CREATE OR REPLACE VIEW vw_post_comments AS
SELECT c.content, u.username, c.created_at
FROM Comments c
JOIN Users u ON c.user_id = u.user_id;

-- BÀI 13: Like bài viết
DELIMITER //
CREATE PROCEDURE sp_like_post(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM Likes
        WHERE user_id = p_user_id AND post_id = p_post_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Đã like rồi';
    ELSE
        INSERT INTO Likes(user_id, post_id)
        VALUES (p_user_id, p_post_id);
    END IF;
END //
DELIMITER ;

CREATE OR REPLACE VIEW vw_post_likes AS
SELECT post_id, COUNT(*) AS total_likes
FROM Likes
GROUP BY post_id;

-- BÀI 14: Tìm kiếm
DELIMITER //
CREATE PROCEDURE sp_search_social(
    IN p_option INT,
    IN p_keyword VARCHAR(100)
)
BEGIN
    IF p_option = 1 THEN
        SELECT * FROM Users
        WHERE username LIKE CONCAT('%', p_keyword, '%');
    ELSEIF p_option = 2 THEN
        SELECT * FROM Posts
        WHERE content LIKE CONCAT('%', p_keyword, '%');
    ELSE
        SELECT 'Giá trị option không hợp lệ' AS message;
    END IF;
END //
DELIMITER ;

CALL sp_search_social(1, 'an');
CALL sp_search_social(2, 'Database');
