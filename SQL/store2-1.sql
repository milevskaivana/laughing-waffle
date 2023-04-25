-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema store2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema store2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `store2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `store2` ;

-- -----------------------------------------------------
-- Table `store2`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`users` (
  `users_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`users_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`admins` (
  `admin_id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `users_id` (`users_id` ASC) VISIBLE,
  CONSTRAINT `admins_ibfk_1`
    FOREIGN KEY (`users_id`)
    REFERENCES `store2`.`users` (`users_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`products` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `manufacture_date` DATE NOT NULL,
  `shelf_life` INT(11) NOT NULL,
  `composition` TEXT NOT NULL,
  `storage_temperature` INT(11) NOT NULL,
  `place_of_origin` VARCHAR(55) NOT NULL,
  `manufacturer` VARCHAR(50) NOT NULL,
  `importer` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`orders` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `date_ordered` DATETIME NOT NULL,
  `date_approved` DATETIME NULL DEFAULT NULL,
  `approved_by` INT(11) NULL DEFAULT NULL,
  `date_delivered` DATETIME NULL DEFAULT NULL,
  `delivered_by` INT(11) NULL DEFAULT NULL,
  `supplier_id` INT(11) NULL DEFAULT NULL,
  `delivery_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `users_id` (`users_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`users_id`)
    REFERENCES `store2`.`users` (`users_id`),
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`reviews` (
  `review_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NOT NULL,
  `rating` INT(11) NOT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `reviews_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `store2`.`orders` (`order_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`buyer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`buyer` (
  `buyer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `buyer_confirmation_time` DATETIME NULL DEFAULT NULL,
  `users_id` INT(11) NULL DEFAULT NULL,
  `review_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`buyer_id`),
  INDEX `users_id` (`users_id` ASC) VISIBLE,
  INDEX `review_id` (`review_id` ASC) VISIBLE,
  CONSTRAINT `buyer_ibfk_1`
    FOREIGN KEY (`users_id`)
    REFERENCES `store2`.`users` (`users_id`),
  CONSTRAINT `buyer_ibfk_2`
    FOREIGN KEY (`review_id`)
    REFERENCES `store2`.`reviews` (`review_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`confectionery_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`confectionery_products` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `confectionery_products_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`cosmetics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`cosmetics` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `cosmetics_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`supplier` (
  `supplier_id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) NULL DEFAULT NULL,
  `review_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  INDEX `users_id` (`users_id` ASC) VISIBLE,
  INDEX `review_id` (`review_id` ASC) VISIBLE,
  CONSTRAINT `supplier_ibfk_1`
    FOREIGN KEY (`users_id`)
    REFERENCES `store2`.`users` (`users_id`),
  CONSTRAINT `supplier_ibfk_2`
    FOREIGN KEY (`review_id`)
    REFERENCES `store2`.`reviews` (`review_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`deliveries` (
  `delivery_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NOT NULL,
  `supplier_id` INT(11) NOT NULL,
  `delivery_time` DATETIME NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `supplier_id` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `deliveries_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `store2`.`orders` (`order_id`),
  CONSTRAINT `deliveries_ibfk_2`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `store2`.`supplier` (`supplier_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`drinks` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `type` ENUM('alcoholic', 'non-alcoholic', 'carbonated', 'non-carbonated') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `drinks_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`food_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`food_products` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `food_products_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`household_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`household_items` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `type` ENUM('cleaning agents', 'kitchen utensils') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `household_items_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`milk_and_dairy_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`milk_and_dairy_products` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `milk_and_dairy_products_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `store2`.`tobacco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `store2`.`tobacco` (
  `id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `type` ENUM('per piece', 'box', 'dry tobacco') NOT NULL,
  `nicotine` INT(11) NOT NULL,
  `tar` INT(11) NOT NULL,
  `carbon_monoxide` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `tobacco_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `store2`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
