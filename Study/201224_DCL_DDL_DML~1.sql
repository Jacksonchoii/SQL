
--DDL 테이블 관리

--테이블 생성
create table book(
    book_id number(5),
    title varchar2(50),
    author varchar2(10), 
    pub_date date
);
    
--컬럼추가
alter table book add(pubs varchar2(50));

select *
from book;

--컬럼수정(내용제한수정)
alter table book modify(title varchar2(100));
--컬럼수정(컬럼명수정)
alter table book rename column title to subject;

--컬럼삭제
alter table book drop (author);

--테이블명 수정
rename book to article;

select *
from article;

--테이블 삭제
drop table article;



-- 제약조건 not null author 테이블 만들기
create table author(
    author_id number(10),
    author_name varchar2(100) not null, -- 무조건 있어야하는 값
    author_desc varchar2(500),
    primary key (author_id)
);

--DML 묵시적 방법
insert into author
values(1, '박경리', '토지 작가');

--null값이 안될 때의 예시
insert into author 
values(2, '이문열',''); --author_desc 값을 빈값으로 하고 싶지만 되지 않음

--명시적 방법
insert into author (author_id, author_name) --컬럼을 지정해주고
values (2, '이문열');                  --값을 입력하면 가능 author_desc는 null이 됨

--명시적 방법 오류상황
insert into author(author_id, author_desc)
values(3, '나혼자산다');


--수정
update author
set author_name = '기안84',
    author_desc = '나혼자산다 출연'
where author_id = 2;

update author
set author_name = '이문열'
where author_id = 1;

select *
from author;

--삭제
delete from author
where author_id = 1;


delete from author;

insert into author
values (seq_author_id.nextval, '이문열', '경북 영양');
       
insert into author
values (seq_author_id.nextval, '박경리', '경북 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

--번호표 기계로 추가
insert into author
values (seq_author_id.nextval, '기안84', '나혼자산다');


--번호표 기계 --> 시퀀스  --pk값이기 때문에 굳이 숫자 순서에 강박을 갖지 않아도 됨
--시퀀스 만들기
create sequence seq_author_id --이름만 설정 / 아직 실질적으로 테이블이랑 연관 없음
increment by 1 -- 몇 씩 올라가는지
start with 1; -- 시작번호

--시퀀스 전체 조회
select * from user_sequences;

--현재 시퀀스 조회 몇 번 실행했는지 체크 (조회만)
select seq_author_id.currval
from dual;

-- 다음 시퀀스 조회 실행 (무조건 실행 == 번호1 증가함)
select seq_author_id.nextval
from dual;

--시퀀스 삭제
drop sequence seq_author_id;



--테이블 생성 프라이머리키, foreign키 설정
select *
from author;

create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author (author_id) 
);

insert into book
values(1, '삼국지', '삼양출판사', '20-01-01', 6);

select *
from book;
