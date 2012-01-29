LOAD DATA LOCAL INFILE 'products'
INTO TABLE products
LINES TERMINATED BY '\n'
(id, name, descr, price);

LOAD DATA LOCAL INFILE 'tags'
INTO TABLE tags
LINES TERMINATED BY '\n'
(id, name);

LOAD DATA LOCAL INFILE 'products_tags'
INTO TABLE products_tags
LINES TERMINATED BY '\n'
(product_id, tag_id);

LOAD DATA LOCAL INFILE 'events'
INTO TABLE events
LINES TERMINATED BY '\n'
(id, name, descr, date);

LOAD DATA LOCAL INFILE 'users'
INTO TABLE users
LINES TERMINATED BY '\n'
(id, name, hashed_pwd, role);

LOAD DATA LOCAL INFILE 'notes'
INTO TABLE notes 
LINES TERMINATED BY '\n'
(id, name, descr);
