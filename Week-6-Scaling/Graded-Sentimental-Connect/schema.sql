CREATE TABLE `Users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(32) NOT NULL UNIQUE,
    `password` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `Schools` (
    `id` VARCHAR(32) AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `type` ENUM('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'etc') NOT NULL,
    `location` VARCHAR(32),
    `founded` NUMERIC,
    PRIMARY KEY(`id`)
);

CREATE TABLE `Companies` (
    `id` INT AUTO_INCREMENT,
    `name` INT,
    `industry` INT,
    `location` INT,
    PRIMARY KEY(`id`)
);

CREATE TABLE `Connections_companies` (
    `id` INT AUTO_INCREMENT,
    `user` INT,
    `company` INT,
    `start_date` NUMERIC,
    `end_date` NUMERIC,
    `title` TEXT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`company`) REFERENCES `Companies`(`id`)
);

CREATE TABLE `Connections_schools` (
    `id` INT AUTO_INCREMENT,
    `user` INT,
    `school` INT,
    `start_date` NUMERIC,
    `end_date` NUMERIC,
    `degree` TEXT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`school`) REFERENCES `Schools`(`id`)
);

CREATE TABLE `Connections_users` (
    `id` INT AUTO_INCREMENT,
    `user_A` INT,
    `user_B` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_A`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`user_B`) REFERENCES `Users`(`id`)
);
