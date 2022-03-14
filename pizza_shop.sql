-- ***************************************************************
-- DROP/CREATE/USE DATABASE
use sys;
drop database if exists pizza_shop;
create database pizza_shop;
use pizza_shop;
-- ****************************************************************
-- DROP TABLES
drop table if exists `pizza_shop`.`user`;
drop table if exists `pizza_shop`.`pizza`;
drop table if exists `pizza_shop`.`order`;
drop table if exists `pizza_shop`.`order_has_pizzas`;
-- ***************************************************************
-- CREATE TABLES
CREATE TABLE `pizza_shop`.`pizza` (
  `pizza_id` INT NOT NULL,
  `pizza_title` VARCHAR(45) NOT NULL,
  `pizza_amount` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`pizza_id`));
CREATE TABLE `pizza_shop`.`user` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`));
CREATE TABLE `pizza_shop`.`order` (
  `order_id` INT NOT NULL,
  `order_dt` VARCHAR(45) NOT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `pizza_shop`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
CREATE TABLE `pizza_shop`.`order_has_pizzas` (
  `pizza_id` INT NULL,
  `order_id` INT NULL,
  INDEX `pizza_id_idx` (`pizza_id` ASC) VISIBLE,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `pizza_shop`.`pizza` (`pizza_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza_shop`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- *******************************************************************
-- INSERT STATEMENTS
insert into `pizza` values (1, "Pepperoni & cheese",7.99);
insert into `pizza` values (2, "Vegetarian",9.99);
insert into `pizza` values (3, "Meat Lovers",14.99);
insert into `pizza` values (4, "Hawaiian",12.99);
INSERT INTO `pizza` VALUES ('5', 'Bufflo', '14.99');
INSERT INTO `pizza` VALUES ('6', 'BBQ', '12.99');
INSERT INTO `pizza` VALUES ('7', 'Cheese Lovers', '14.99');
insert into `user` values(1,"Mina K Fahmy", "222-222-222");
insert into `user` values(2,"Lyly Rezq", "333-333-3333");
insert into `user` values(3,"Elon Musk", "777-777-7777");
insert into `user` values(4,"Jeff Bezoz", "999-999-9999");
insert into `user` values(5,"John William", "666-666-6666");
insert into `user` values(6,"Jane Doe", "555-555-5555");
insert into `user` values(7,"Johnny Depp", "888-888-8888");
insert into `order` values(1,"9/10/2014 9:47:00 PM",1);
insert into `order` values(2,"9/10/2014 10:47:00 PM",1);
insert into `order` values(3,"9/11/2014 9:50:00 PM",1);
insert into `order` values(4,"9/12/2014 3:47:00 PM",2);
insert into `order` values(5,"9/13/2014 9:47:00 PM",2);
insert into `order` values(7,"9/11/2015 9:47:00 PM",2);
insert into `order` values(8,"9/10/2014 10:47:00 PM",7);
insert into `order` values(9,"9/10/2014 10:47:00 PM",4);
insert into `order` values(10,"9/11/2014 10:50:00 PM",7);
insert into `order` values(11,"9/11/2014 10:47:00 PM",7);
insert into `order` values(12,"9/10/2014 10:47:00 PM",5);
insert into `order` values(13,"9/10/2014 10:47:00 PM",5);
insert into `order_has_pizzas`(order_id,pizza_id) values (1,1);
insert into `order_has_pizzas`(order_id,pizza_id) values (2,1);
insert into `order_has_pizzas`(order_id,pizza_id) values (2,2);
insert into `order_has_pizzas`(order_id,pizza_id) values (2,2);
insert into `order_has_pizzas`(order_id,pizza_id) values (2,4);
insert into `order_has_pizzas`(order_id,pizza_id) values (1,1);
insert into `order_has_pizzas`(order_id,pizza_id) values (3,1);
insert into `order_has_pizzas`(order_id,pizza_id) values (3,2);
insert into `order_has_pizzas`(order_id,pizza_id) values (3,1);
insert into `order_has_pizzas`(order_id,pizza_id) values (3,5);
insert into `order_has_pizzas`(order_id,pizza_id) values (3,6);
insert into `order_has_pizzas`(order_id,pizza_id) values (1,7);
UPDATE `pizza_shop`.`order` SET `user_id` = '2' WHERE (`order_id` = '2');


-- Q4
select u.user_name, o.order_dt, sum(p.pizza_amount) "Total History"
from `user` u, `order` o, `order_has_pizzas` ohp, `pizza` p 
where u.user_id = o.user_id
and o.order_id = ohp.order_id
and p.pizza_id = ohp.pizza_id
group by u.user_name;

-- Q5
select u.user_name, o.order_dt, sum(p.pizza_amount) "Total History"
from `user` u, `order` o, `order_has_pizzas` ohp, `pizza` p 
where u.user_id = o.user_id
and o.order_id = ohp.order_id
and p.pizza_id = ohp.pizza_id
group by u.user_name,o.order_dt;