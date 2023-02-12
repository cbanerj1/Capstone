-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema little_lemon_st
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_st
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_st` DEFAULT CHARACTER SET utf8mb3 ;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon_st` ;

-- -----------------------------------------------------
-- Table `little_lemon_st`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`menuitems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `Type` VARCHAR(100) NOT NULL,
  `Price` INT NOT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `little_lemon_st`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `item_id_fk_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `item_id_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `little_lemon_st`.`menuitems` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `little_lemon_st`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`customers` (
  `CustomerID` INT NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `little_lemon_st`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE INDEX `OrderID_UNIQUE` (`OrderID` ASC) VISIBLE,
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `little_lemon_st`.`menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_st`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `little_lemon_st`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Contact_Number` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Annual_Salary` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `little_lemon_st`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `GuestFirstName` VARCHAR(100) NOT NULL,
  `GuestLastName` VARCHAR(100) NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `table_no_fk_idx` (`TableNo` ASC) VISIBLE,
  INDEX `employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `table_no_fk`
    FOREIGN KEY (`TableNo`)
    REFERENCES `little_lemon_st`.`orders` (`TableNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `little_lemon_st`.`employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;

USE `little_lemon_store` ;

-- -----------------------------------------------------
-- Table `little_lemon_store`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`menuitems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL DEFAULT NULL,
  `Type` VARCHAR(100) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`menus` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL DEFAULT NULL,
  `menuitems_ItemID` INT NOT NULL,
  PRIMARY KEY (`MenuID`, `ItemID`),
  INDEX `item_id_fk_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `item_id_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `little_lemon_store`.`menuitems` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`orders` (
  `OrderID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `MenuID` INT NULL DEFAULT NULL,
  `BookingID` INT NULL DEFAULT NULL,
  `BillAmount` INT NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`, `TableNo`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `little_lemon_store`.`menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL DEFAULT NULL,
  `Role` VARCHAR(100) NULL DEFAULT NULL,
  `Address` VARCHAR(100) NULL DEFAULT NULL,
  `Contact_Number` INT NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `Annual_Salary` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `GuestFirstName` VARCHAR(100) NOT NULL,
  `GuestLastName` VARCHAR(100) NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `table_no_fk_idx` (`TableNo` ASC) VISIBLE,
  INDEX `employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `table_no_fk`
    FOREIGN KEY (`TableNo`)
    REFERENCES `little_lemon_store`.`orders` (`TableNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `little_lemon_store`.`employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `little_lemon_st` ;

-- -----------------------------------------------------
-- Placeholder table for view `little_lemon_st`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_st`.`ordersview` (`OrderID` INT, `TableNo` INT, `MenuID` INT, `BookingID` INT, `BillAmount` INT, `Quantity` INT, `CustomerID` INT);

-- -----------------------------------------------------
-- View `little_lemon_st`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_st`.`ordersview`;
USE `little_lemon_st`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`Little_Lemon_user`@`%` SQL SECURITY DEFINER VIEW `little_lemon_st`.`ordersview` AS select `little_lemon_st`.`orders`.`OrderID` AS `OrderID`,`little_lemon_st`.`orders`.`TableNo` AS `TableNo`,`little_lemon_st`.`orders`.`MenuID` AS `MenuID`,`little_lemon_st`.`orders`.`BookingID` AS `BookingID`,`little_lemon_st`.`orders`.`BillAmount` AS `BillAmount`,`little_lemon_st`.`orders`.`Quantity` AS `Quantity`,`little_lemon_st`.`orders`.`CustomerID` AS `CustomerID` from `little_lemon_st`.`orders`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
