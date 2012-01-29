drop table if exists products;
create table products (
        id      int     not null auto_increment,
        name    varchar(100)    not null,
        descr   text    null,
        price   decimal(10,2)   not null,
        primary key (id)
);

drop table if exists products_tags;
create table products_tags (
        product_id      int     not null,
        tag_id          int     not null
);

drop table if exists tags;
create table tags (
        id      int     not null auto_increment,
        name    varchar(200)    not null,
        primary key (id)
);

drop table if exists events;
create table events (
        id      int     not null auto_increment,
        name    varchar(100)    not null,
        descr   text    not null,
        date    date    not null,
        primary key (id)
);

drop table if exists notes;
create table notes ( 
	id int not null auto_increment,
	name varchar(100) not null,
	descr text not null,
	primary key (id)
);

drop table if exists users;
create table users (
        id      int  not null auto_increment,
        name    varchar(100) not null,
        hashed_pwd    char(40) null,
        role varchar(100) null,
        primary key (id)
);
