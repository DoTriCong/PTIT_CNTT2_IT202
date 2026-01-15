create database ss14_bai2;
use ss14_bai2;
create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);
create table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);
create table likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    constraint fk_likes_posts
        foreign key (post_id) references posts(post_id),
    constraint fk_likes_users
        foreign key (user_id) references users(user_id),
    constraint unique_like unique (post_id, user_id)
);
start transaction;

insert into likes (post_id, user_id)
values (1, 2);

update posts
set likes_count = likes_count + 1
where post_id = 1;

commit;
start transaction;

insert into likes (post_id, user_id)
values (1, 2);

update posts
set likes_count = likes_count + 1
where post_id = 1;

rollback;