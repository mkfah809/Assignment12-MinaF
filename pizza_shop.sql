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
-- ****************************************************************
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `order` (
  `order_id` int NOT NULL,
  `order_dt` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `pizza` (
  `pizza_id` int NOT NULL,
  `pizza_title` varchar(45) NOT NULL,
  `pizza_amount` decimal(6,2) NOT NULL,
  PRIMARY KEY (`pizza_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `order_has_pizzas` (
  `pizza_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  KEY `pizza_id_idx` (`pizza_id`),
  KEY `order_id_idx` (`order_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `pizza_id` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`pizza_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- ****************************************************************
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
insert into `order` values(1,'2014-09-09 10:47:00',1);
insert into `order` values(2,'2014-09-10 11:47:00',2);
insert into `order` values(3,'2014-09-09 4:50:00',1);
insert into `order` values(4,'2014-09-09 6:47:00',2);
insert into `order_has_pizzas` values (1,1);
insert into `order_has_pizzas` values (2,1);
insert into `order_has_pizzas` values (2,2);
insert into `order_has_pizzas` values (2,2);
insert into `order_has_pizzas` values (2,4);
insert into `order_has_pizzas` values (1,1);
insert into `order_has_pizzas` values (3,1);
insert into `order_has_pizzas` values (3,2);
insert into `order_has_pizzas` values (3,1);
-- ***************************************************************
-- Q4
SELECT 
    u.user_name, o.order_dt, SUM(p.pizza_amount) 'Total History'
FROM
    `user` u,
    `order` o,
    `order_has_pizzas` ohp,
    `pizza` p
WHERE
    u.user_id = o.user_id
        AND o.order_id = ohp.order_id
        AND p.pizza_id = ohp.pizza_id
GROUP BY u.user_name;
-- Q5
SELECT
    u.user_id,
    u.user_name,
    CAST(o.order_dt AS DATE) AS `order date`,
    SUM(pizza_amount) AS `daily total`
FROM
    `order` o,
    `user` u,
    `order_has_pizzas` ohp,
    `pizza` p
WHERE
    o.user_id = u.user_id
        AND ohp.order_id = o.order_id
        AND ohp.pizza_id = p.pizza_id
GROUP BY o.order_dt ;


