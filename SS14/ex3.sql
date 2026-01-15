use social_network;
alter table users
add column following_count int default 0,
add column followers_count int default 0;

-- tao bang followers
create table if not exists followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    constraint fk_followers_follower
        foreign key (follower_id) references users(user_id),
    constraint fk_followers_followed
        foreign key (followed_id) references users(user_id)
);
create table if not exists follow_log (
    log_id int auto_increment primary key,
    follower_id int,
    followed_id int,
    message varchar(255),
    created_at datetime default current_timestamp
);

-- xoa procedure neu da ton tai
drop procedure if exists sp_follow_user;

delimiter $$

create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int default 0;
    start transaction;
    -- kiem tra khong tu follow chinh minh
    if p_follower_id = p_followed_id then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'khong the tu follow chinh minh');
        rollback;
        leave proc_end;
    end if;

    -- kiem tra follower ton tai
    select count(*) into v_count
    from users
    where user_id = p_follower_id;

    if v_count = 0 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'follower khong ton tai');
        rollback;
        leave proc_end;
    end if;

    -- kiem tra followed ton tai
    select count(*) into v_count
    from users
    where user_id = p_followed_id;

    if v_count = 0 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'nguoi duoc follow khong ton tai');
        rollback;
        leave proc_end;
    end if;

    -- kiem tra da follow truoc do chua
    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'da follow truoc do');
        rollback;
        leave proc_end;
    end if;

    -- neu moi thu deu hop le
    insert into followers(follower_id, followed_id)
    values (p_follower_id, p_followed_id);

    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;

    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;

    commit;

    proc_end: end;

end$$

delimiter ;

-- truong hop thanh cong
call sp_follow_user(1, 2);

-- truong hop that bai: follow lai lan nua (rollback)
call sp_follow_user(1, 2);

-- truong hop that bai: tu follow chinh minh
call sp_follow_user(1, 1);

-- truong hop that bai: user khong ton tai
call sp_follow_user(1, 999);