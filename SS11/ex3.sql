USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE CalculateBonusPoints(
    IN p_user_id INT,
    INOUT p_bonus_points INT
)
BEGIN
    DECLARE post_count INT;

    -- Đếm số bài viết của user
    SELECT COUNT(*)
    INTO post_count
    FROM posts
    WHERE user_id = p_user_id;

    -- Cộng điểm thưởng
    IF post_count >= 20 THEN
        SET p_bonus_points = p_bonus_points + 100;
    ELSEIF post_count >= 10 THEN
        SET p_bonus_points = p_bonus_points + 50;
    ELSE
        SET p_bonus_points = p_bonus_points;
    END IF;
END $$

DELIMITER ;

SET @bonus = 100;

CALL CalculateBonusPoints(1, @bonus);

SELECT @bonus AS bonus_points;

DROP PROCEDURE IF EXISTS CalculateBonusPoints;