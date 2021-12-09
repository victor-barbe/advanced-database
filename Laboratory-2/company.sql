-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : mar. 19 oct. 2021 à 20:47
-- Version du serveur :  5.7.34
-- Version de PHP : 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `company.sql`
--

-- --------------------------------------------------------

--
-- Structure de la table `DEPT`
--

CREATE TABLE `DEPT` (
  `DID` int(11) NOT NULL,
  `DNAME` varchar(20) NOT NULL,
  `DLOC` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `DEPT`
--

INSERT INTO `DEPT` (`DID`, `DNAME`, `DLOC`) VALUES
(10, 'ACCOUNTING', 'NEW-YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'Paris'),
(50, 'MANAGMENT', 'LOS-ANGELES'),
(80, 'Relation', 'RIO');

-- --------------------------------------------------------

--
-- Structure de la table `EMP`
--

CREATE TABLE `EMP` (
  `EID` int(11) NOT NULL,
  `ENAME` varchar(20) NOT NULL,
  `JOB` varchar(20) NOT NULL,
  `MGR` int(11) DEFAULT NULL,
  `HIRED` date NOT NULL,
  `SAL` decimal(6,2) NOT NULL,
  `COMM` decimal(6,2) DEFAULT NULL,
  `DID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `EMP`
--

INSERT INTO `EMP` (`EID`, `ENAME`, `JOB`, `MGR`, `HIRED`, `SAL`, `COMM`, `DID`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', '-9200.00', NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', '-8400.00', '300.00', 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', '-8750.00', '500.00', 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', '8975.00', NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', '-8750.00', '1400.00', 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', '8850.00', NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', '8450.00', NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1981-11-09', '5000.00', NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', '-5000.00', NULL, NULL),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', '-8500.00', '0.00', 30),
(7876, 'ADAMS', 'CLERK', 7788, '1981-09-23', '-8900.00', NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', '-9050.00', NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', '5000.00', NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', '-8700.00', NULL, 10),
(8000, 'SMITH', 'MANAGER', 7839, '1980-12-17', '9000.00', NULL, 10);

-- --------------------------------------------------------

--
-- Structure de la table `MISSION`
--

CREATE TABLE `MISSION` (
  `MID` int(11) NOT NULL,
  `EID` int(11) NOT NULL,
  `CNAME` varchar(30) NOT NULL,
  `MLOC` varchar(30) NOT NULL,
  `ENDD` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `MISSION`
--

INSERT INTO `MISSION` (`MID`, `EID`, `CNAME`, `MLOC`, `ENDD`) VALUES
(209, 7654, 'BMW', 'BERLIN', '2011-02-09'),
(212, 7698, 'MacDo', 'CHICAGO', '2011-03-04'),
(213, 7902, 'Oracle', 'DALLAS', '2011-04-11'),
(214, 7900, 'Fidal', 'PARIS', '2011-06-07'),
(216, 7698, 'IBM', 'CHICAGO', '2011-02-09'),
(218, 7499, 'Decathlon', 'LYON', '2011-12-24'),
(219, 7782, 'BMW', 'CHICAGO', '2011-08-16'),
(220, 7369, 'IBM', 'LONDON', '2015-06-20'),
(300, 8000, 'ECE', 'PARIS', '2018-06-11');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `DEPT`
--
ALTER TABLE `DEPT`
  ADD PRIMARY KEY (`DID`);

--
-- Index pour la table `EMP`
--
ALTER TABLE `EMP`
  ADD PRIMARY KEY (`EID`),
  ADD KEY `EMP_FK_MNGR` (`MGR`),
  ADD KEY `EMP_FK_DID` (`DID`);

--
-- Index pour la table `MISSION`
--
ALTER TABLE `MISSION`
  ADD PRIMARY KEY (`MID`),
  ADD KEY `MISSION_FK_EID` (`EID`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `EMP`
--
ALTER TABLE `EMP`
  ADD CONSTRAINT `EMP_FK_DID` FOREIGN KEY (`DID`) REFERENCES `DEPT` (`DID`),
  ADD CONSTRAINT `EMP_FK_MNGR` FOREIGN KEY (`MGR`) REFERENCES `EMP` (`EID`);

--
-- Contraintes pour la table `MISSION`
--
ALTER TABLE `MISSION`
  ADD CONSTRAINT `MISSION_FK_EID` FOREIGN KEY (`EID`) REFERENCES `EMP` (`EID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
