create database ss14_bai1;
use ss14_bai1;
create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);
create table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content varchar(100) not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);
insert into users (username) values('duc'),('anh'),('minh');

-- truong hop 1: giao dich thanh cong 
start transaction;

insert into posts (user_id, content) values (1, 'bai viet dau tien cua user 1');

update users set posts_count = posts_count + 1 where user_id = 1;

commit;

-- truong hop 2: giao dich that bai 
start transaction;

insert into posts (user_id, content) values (999, 'bai viet gay loi');

update users set posts_count = posts_count + 1 where user_id = 999;

rollback;