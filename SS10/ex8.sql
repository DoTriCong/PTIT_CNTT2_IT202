USE social_network_pro;

CREATE INDEX idx_user_gender
ON users (gender);

CREATE OR REPLACE VIEW view_popular_posts AS
SELECT 
    p.post_id,
    u.username,
    p.content,
    COUNT(DISTINCT l.like_id)    AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
JOIN users u 
    ON u.user_id = p.user_id
LEFT JOIN likes l 
    ON l.post_id = p.post_id
LEFT JOIN comments c 
    ON c.post_id = p.post_id
GROUP BY 
    p.post_id,
    u.username,
    p.content;

SELECT *
FROM view_popular_posts;

SELECT *,
       (total_likes + total_comments) AS total_interactions
FROM view_popular_posts
WHERE (total_likes + total_comments) > 10
ORDER BY total_interactions DESC;
