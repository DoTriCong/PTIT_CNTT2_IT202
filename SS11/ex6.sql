USE social_network_pro;
DELIMITER $$

CREATE PROCEDURE NotifyFriendsOnNewPost(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE new_post_id INT;
    DECLARE poster_name VARCHAR(255);

    -- Lấy tên người đăng
    SELECT full_name
    INTO poster_name
    FROM users
    WHERE user_id = p_user_id;

    -- Thêm bài viết mới
    INSERT INTO posts (user_id, content, created_at)
    VALUES (p_user_id, p_content, NOW());

    -- Lấy post_id vừa tạo
    SET new_post_id = LAST_INSERT_ID();

    -- Gửi thông báo cho bạn bè (2 chiều, đã accepted)
    INSERT INTO notifications (user_id, type, content, created_at)
    SELECT 
        CASE 
            WHEN f.user_id = p_user_id THEN f.friend_id
            ELSE f.user_id
        END AS notify_user_id,
        'new_post',
        CONCAT(poster_name, ' đã đăng một bài viết mới'),
        NOW()
    FROM friends f
    WHERE f.status = 'accepted'
      AND (f.user_id = p_user_id OR f.friend_id = p_user_id)
      AND (
            CASE 
                WHEN f.user_id = p_user_id THEN f.friend_id
                ELSE f.user_id
            END
          ) <> p_user_id;
END $$

DELIMITER ;
CALL NotifyFriendsOnNewPost(
    1,
    'Đây là bài viết mới được đăng từ stored procedure'
);
SELECT n.notification_id,
       u.full_name AS receiver_name,
       n.type,
       n.content,
       n.created_at
FROM notifications n
JOIN users u ON n.user_id = u.user_id
WHERE n.type = 'new_post'
ORDER BY n.notification_id DESC;
DROP PROCEDURE IF EXISTS NotifyFriendsOnNewPost;
DROP PROCEDURE IF EXISTS NotifyFriendsOnNewPost;