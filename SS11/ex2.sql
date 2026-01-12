USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE CalculatePostLikes(
    IN p_post_id INT,
    OUT total_likes INT
)
BEGIN
    SELECT COUNT(*) 
    INTO total_likes
    FROM likes
    WHERE post_id = p_post_id;
END $$

DELIMITER ;

-- Khai báo biến nhận giá trị OUT
SET @total_likes = 0;

-- Gọi thủ tục
CALL CalculatePostLikes(1, @total_likes);

-- Xem kết quả
SELECT @total_likes AS total_likes;

DROP PROCEDURE IF EXISTS CalculatePostLikes;

SELECT post_id, content
FROM posts
WHERE post_id = 1;

SELECT * FROM likes;

SELECT COUNT(*) AS like_count
FROM likes
WHERE post_id = 1;
