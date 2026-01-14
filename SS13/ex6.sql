drop database if exists ex6_ss13;
create database ex6_ss13;
use ex6_ss13;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id)
        on delete cascade
);

create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending', 'accepted') default 'accepted',
    primary key (follower_id, followee_id),
    foreign key (follower_id) references users(user_id)
        on delete cascade,
    foreign key (followee_id) references users(user_id)
        on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

delimiter $$

create trigger trg_post_insert
after insert on posts
for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end $$

create trigger trg_post_delete
after delete on posts
for each row
begin
    update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end $$

delimiter ;

delimiter $$

create trigger trg_follow_insert
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end $$

create trigger trg_follow_delete
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end $$

delimiter ;

delimiter $$

create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending','accepted')
)
begin
    -- không cho tự follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'cannot follow yourself';
    end if;

    -- tránh follow trùng
    if exists (
        select 1 from friendships
        where follower_id = p_follower_id
          and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'already followed or pending';
    end if;

    -- thêm quan hệ follow
    insert into friendships (follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end $$

delimiter ;

create view user_profile as
select 
    u.user_id,
    u.username,
    u.follower_count,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes,
    group_concat(
        concat('[', p.created_at, '] ', p.content)
        order by p.created_at desc
        separator ' | '
    ) as recent_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.follower_count, u.post_count;

insert into posts (user_id, content, created_at, like_count) values
(1, 'alice first post', '2025-01-10 10:00:00', 5),
(1, 'alice second post', '2025-01-11 11:00:00', 3),
(2, 'bob post', '2025-01-12 09:00:00', 10),
(3, 'charlie post', '2025-01-13 15:00:00', 1);

call follow_user(2, 1, 'accepted');   
call follow_user(3, 1, 'accepted'); 
call follow_user(1, 2, 'pending');    

-- kiểm tra follower_count
select user_id, username, follower_count from users;

delete from friendships
where follower_id = 3 and followee_id = 1;

-- kiểm tra lại
select user_id, username, follower_count from users;

select * from user_profile;
