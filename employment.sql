CREATE Database employmentDB;
USE employmentDB;

CREATE TABLE `employer` (
  `id` int AUTO_INCREMENT PRIMARY KEY,
  `full_name` varchar(37) DEFAULT NULL,
  `company_name` varchar(40) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL UNIQUE KEY,
  `number` varchar(20) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL
);

INSERT INTO `employer` (`full_name`, `company_name`, `email`, `number`, `type`) VALUES
('Ivana Milevska', 'FINKI', 'ivanamilevska2@gmail.com', '070338505', 'programming');