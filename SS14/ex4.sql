use ss14_bai1;

-- them cot comments_count vao bang posts neu chua co
alter table posts
add column comments_count int default 0;

-- tao bang comments
create table if not exists comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    constraint fk_comments_posts
        foreign key (post_id) references posts(post_id),
    constraint fk_comments_users
        foreign key (user_id) references users(user_id)
);

-- xoa procedure neu da ton tai
drop procedure if exists sp_post_comment;

delimiter $$

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    start transaction;

    -- buoc 1: them comment
    insert into comments(post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    -- tao savepoint sau khi insert thanh cong
    savepoint after_insert;

    -- buoc 2: cap nhat so luong comment
    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    -- neu update khong tac dong dong nao -> rollback partial
    if row_count() = 0 then
        rollback to after_insert;
        commit;
    else
        -- neu thanh cong toan bo
        commit;
    end if;

end$$

delimiter ;

-- truong hop thanh cong
call sp_post_comment(1, 1, 'day la binh luan hop le');

-- truong hop gay loi o buoc update (post_id khong ton tai)
call sp_post_comment(999, 1, 'binh luan nay se rollback partial');