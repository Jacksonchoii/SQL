/*    Practice06    */
--테이블 삭제 
drop table book;
drop table author;

--1.book 테이블
--(1-1)book 테이블 생성
create table book(
    book_id number(5), --이리저리 생각해보니 pk에 적합함. book테이블의 pk
    title varchar2(100) not null,
    pubs varchar2(50),
    pub_date date,
    author_id number(5),  -- foreign 키 author 테이블과 조인할 때 필요함
    primary key (book_id),-- 데이터의 유일성 보장
    constraint book_fk foreign key(author_id) --book_fk는 내가 지정한 이름, author_id는 fk로 쓸 컬럼명
    references author(author_id)
);

--(1-2)book 테이블 생성 확인
select  *
from book; --생성ok

--(1-3)book 시퀀스 생성
create sequence seq_book_id
increment by 1 -- 1씩 증가
start with 1; -- 1부터 시작

--(1-4)book 시퀀스 생성 확인(조회)
select * from user_sequences;
--현재 시퀀스 조회 (1-5) 첫 값 입력 후 확인해보기 => 1나옴 == 내가 원하던 값 맞음
select seq_book_id.currval
from dual;  

--(1-5)book 데이터 입력
insert into book
values (seq_book_id.nextval, 
        '우리들의 일그러진 영웅', 
        '다림', 
        '1998-02-22',
        1); -- book 테이블 전체조회 해본 뒤, 제대로 입력 되었으면 나머지 값 입력

insert into book
values (seq_book_id.nextval,
        '삼국지',
        '민음사',
        '2002-03-01',
        1);
        
insert into book
values (seq_book_id.nextval,
        '토지',
        '마로니에북스',
        '2012-08-15',
        2);
        
insert into book
values (seq_book_id.nextval,
        '유시민의 글쓰기 특강',
        '생각의길',
        '2015-04-01',
        3);
        
insert into book
values (seq_book_id.nextval,
        '패션왕',
        '중앙북스(books)',
        '2012-02-22',
        4);
        
insert into book
values (seq_book_id.nextval,
        '순정만화',
        '재미주의',
        '2011-08-03',
        5);
        
insert into book
values (seq_book_id.nextval,
        '오직두사람',
        '문학동네',
        '2017-05-04',
        6);
        
insert into book
values (seq_book_id.nextval,
        '26년',
        '재미주의',
        '2012-02-04',
        5);
        
--2.author 테이블 생성
create table author(
    author_id number(5), --author 테이블의 pk값
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key (author_id)
);


--(2-1)author 테이블 생성 확인
select *
from author;

--(2-2)author 테이블 시퀀스 생성
create sequence seq_author_id
increment by 1 --1씩증가
start with 1; --1부터 시작
--시퀀스 조회
select * from user_sequences;

--(2-3)author 데이터 insert
insert into author
values (seq_author_id.nextval,
        '김문열',
        '경북 영양');
        
insert into author
values (seq_author_id.nextval,
        '박경리',
        '경상남도 통영');
        
insert into author
values (seq_author_id.nextval,
        '유시민',
        '17대 국회의원');
        
insert into author
values (seq_author_id.nextval,
        '기안84',
        '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval,
        '강풀',
        '온라인 만화가 1세대');
        
insert into author
values (seq_author_id.nextval,
        '김영하',
        '알쓸신잡');

--??? book 테이블 foreign key 값 설정은 언제해야하는가?? 다시 공부하기

--select 문
select  b.book_id,
        b.title,
        b.pubs,
        to_char(b.pub_date, 'YYYY-MM-DD'),
        a.author_id,
        a.author_name,
        a.author_desc
from book b, author a
where b.author_id = a.author_id;

--[예제]강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요 
update author
set author_desc = '서울특별시'
where author_id = 5; -- fk가 5인 모든 값이 '서울특별시'로 변경됨

--[예제]author 테이블에서 기안84 데이터를 삭제해 보세요
--불가 author 테이블의 기안84는 4번의 pk값을 가지고 있는데 삭제하면
--book의 fk값이 4인 기안의 패션왕 값이 출력될 수 없음
-- 삭제하려면? --> book 테이블의 fk가 4인 값을 먼저 지우고 author 테이블의 pk가 4인 기안84의 데이터를 지우기

commit;