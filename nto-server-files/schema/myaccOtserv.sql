-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 27-Jun-2023 às 21:41
-- Versão do servidor: 5.7.41
-- versão do PHP: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `otserv`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `coins` int(12) NOT NULL DEFAULT '0',
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT '0',
  `vote` int(11) NOT NULL DEFAULT '0',
  `key` varchar(64) NOT NULL DEFAULT '',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `created` int(11) NOT NULL DEFAULT '0',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int(11) NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(3) NOT NULL DEFAULT '',
  `web_lastlogin` int(11) NOT NULL DEFAULT '0',
  `web_flags` int(11) NOT NULL DEFAULT '0',
  `email_hash` varchar(32) NOT NULL DEFAULT '',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `page_access` int(11) NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `email_next` int(11) NOT NULL DEFAULT '0',
  `premium_points` int(11) NOT NULL DEFAULT '0',
  `create_date` int(11) NOT NULL DEFAULT '0',
  `create_ip` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(80) NOT NULL DEFAULT '',
  `vip_time` int(11) NOT NULL DEFAULT '0',
  `guild_points` int(11) NOT NULL DEFAULT '0',
  `guild_points_stats` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `secret`, `type`, `premdays`, `coins`, `lastday`, `email`, `creation`, `vote`, `key`, `blocked`, `created`, `email_new`, `email_new_time`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_verified`, `page_access`, `email_code`, `email_next`, `premium_points`, `create_date`, `create_ip`, `last_post`, `flag`, `vip_time`, `guild_points`, `guild_points_stats`) VALUES
(8, 'god', '21298df8a3277357ee55b01df9530b535cf08ec1', NULL, 5, 0, 0, 0, 'patsadow2@gmail.com', 1465696163, 0, '', 0, 0, '', 0, '', '', '', 0, 0, '', 0, 9999, '', 0, 639, 0, 0, 1467772450, '', 0, 0, 0),
(9, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', NULL, 5, 0, 0, 0, 'admin@admin.com', 0, 0, '', 0, 1678041702, '', 0, '', '', 'us', 1687902050, 3, '', 0, 0, '', 0, 0, 0, 0, 0, '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` varchar(255) NOT NULL,
  `date` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `global_storage`
--

CREATE TABLE `global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `guild_logo` mediumblob,
  `create_ip` int(11) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `last_execute_points` int(11) NOT NULL DEFAULT '0',
  `logo_name` varchar(255) NOT NULL DEFAULT 'default.gif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Acionadores `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `started` bigint(15) NOT NULL DEFAULT '0',
  `ended` bigint(15) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `beds` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(2, 0, 0, 0, 'Market Street 4 (Shop)', 5105, 1, 0, 0, 0, 0, 182, 3),
(4, 0, 0, 0, 'Market Street 3', 3475, 1, 0, 0, 0, 0, 145, 2),
(5, 0, 0, 0, 'Market Street 2', 4925, 1, 0, 0, 0, 0, 188, 3),
(6, 0, 0, 0, 'Market Street 1', 6680, 1, 0, 0, 0, 0, 234, 3),
(7, 0, 0, 0, 'Old Lighthouse', 3610, 1, 0, 0, 0, 0, 117, 2),
(8, 0, 0, 0, 'Seagull Walk 1', 5095, 1, 0, 0, 0, 0, 186, 2),
(9, 0, 0, 0, 'Seagull Walk 2', 2765, 1, 0, 0, 0, 0, 115, 3),
(10, 0, 0, 0, 'Dream Street 4', 3765, 1, 0, 0, 0, 0, 137, 4),
(11, 0, 0, 0, 'Elm Street 2', 2665, 1, 0, 0, 0, 0, 106, 2),
(12, 0, 0, 0, 'Elm Street 1', 2710, 1, 0, 0, 0, 0, 109, 2),
(13, 0, 0, 0, 'Elm Street 3', 2855, 1, 0, 0, 0, 0, 109, 3),
(14, 0, 0, 0, 'Elm Street 4', 3765, 1, 0, 0, 0, 0, 113, 2),
(15, 0, 0, 0, 'Dream Street 3', 2710, 1, 0, 0, 0, 0, 114, 2),
(16, 0, 0, 0, 'Dream Street 2', 3340, 1, 0, 0, 0, 0, 127, 2),
(18, 0, 0, 0, 'Paupers Palace, Flat 13', 450, 1, 0, 0, 0, 0, 16, 1),
(19, 0, 0, 0, 'Paupers Palace, Flat 12', 685, 1, 0, 0, 0, 0, 27, 2),
(23, 0, 0, 0, 'Paupers Palace, Flat 14', 585, 1, 0, 0, 0, 0, 23, 1),
(24, 0, 0, 0, 'Paupers Palace, Flat 15', 450, 1, 0, 0, 0, 0, 12, 1),
(25, 0, 0, 0, 'Paupers Palace, Flat 16', 585, 1, 0, 0, 0, 0, 19, 1),
(26, 0, 0, 0, 'Paupers Palace, Flat 17', 450, 1, 0, 0, 0, 0, 16, 1),
(27, 0, 0, 0, 'Paupers Palace, Flat 18', 315, 1, 0, 0, 0, 0, 16, 1),
(28, 0, 0, 0, 'Paupers Palace, Flat 01', 405, 1, 0, 0, 0, 0, 15, 1),
(29, 0, 0, 0, 'Paupers Palace, Flat 02', 450, 1, 0, 0, 0, 0, 19, 1),
(30, 0, 0, 0, 'Paupers Palace, Flat 03', 405, 1, 0, 0, 0, 0, 15, 1),
(31, 0, 0, 0, 'Paupers Palace, Flat 04', 450, 1, 0, 0, 0, 0, 16, 1),
(32, 0, 0, 0, 'Paupers Palace, Flat 05', 315, 1, 0, 0, 0, 0, 12, 1),
(33, 0, 0, 0, 'Paupers Palace, Flat 06', 450, 1, 0, 0, 0, 0, 16, 1),
(34, 0, 0, 0, 'Paupers Palace, Flat 07', 685, 1, 0, 0, 0, 0, 23, 2),
(35, 0, 0, 0, 'Paupers Palace, Flat 21', 315, 1, 0, 0, 0, 0, 12, 1),
(36, 0, 0, 0, 'Paupers Palace, Flat 22', 450, 1, 0, 0, 0, 0, 16, 1),
(37, 0, 0, 0, 'Paupers Palace, Flat 23', 585, 1, 0, 0, 0, 0, 23, 1),
(38, 0, 0, 0, 'Paupers Palace, Flat 24', 450, 1, 0, 0, 0, 0, 16, 1),
(39, 0, 0, 0, 'Paupers Palace, Flat 26', 450, 1, 0, 0, 0, 0, 16, 1),
(40, 0, 0, 0, 'Paupers Palace, Flat 28', 315, 1, 0, 0, 0, 0, 15, 1),
(41, 0, 0, 0, 'Paupers Palace, Flat 27', 685, 1, 0, 0, 0, 0, 24, 2),
(42, 0, 0, 0, 'Paupers Palace, Flat 25', 585, 1, 0, 0, 0, 0, 24, 1),
(43, 0, 0, 0, 'Paupers Palace, Flat 31', 855, 1, 0, 0, 0, 0, 28, 1),
(44, 0, 0, 0, 'Paupers Palace, Flat 32', 1135, 1, 0, 0, 0, 0, 32, 2),
(45, 0, 0, 0, 'Paupers Palace, Flat 33', 765, 1, 0, 0, 0, 0, 31, 1),
(46, 0, 0, 0, 'Paupers Palace, Flat 34', 1675, 1, 0, 0, 0, 0, 51, 2),
(47, 0, 0, 0, 'Salvation Street 1 (Shop)', 6240, 1, 0, 0, 0, 0, 200, 4),
(49, 0, 0, 0, 'Dream Street 1 (Shop)', 4330, 1, 0, 0, 0, 0, 147, 2),
(50, 0, 0, 0, 'Blessed Shield Guildhall', 8090, 1, 0, 0, 0, 0, 258, 9),
(51, 0, 0, 0, 'Dagger Alley 1', 2665, 1, 0, 0, 0, 0, 93, 2),
(52, 0, 0, 0, 'Steel Home', 13845, 1, 0, 0, 0, 0, 384, 13),
(53, 0, 0, 0, 'Iron Alley 1', 3450, 1, 0, 0, 0, 0, 111, 4),
(54, 0, 0, 0, 'Iron Alley 2', 3450, 1, 0, 0, 0, 0, 108, 4),
(55, 0, 0, 0, 'Swamp Watch', 11090, 1, 0, 0, 0, 0, 347, 12),
(57, 0, 0, 0, 'Salvation Street 2', 3790, 1, 0, 0, 0, 0, 123, 2),
(60, 0, 0, 0, 'Salvation Street 3', 3790, 1, 0, 0, 0, 0, 129, 2),
(61, 0, 0, 0, 'Silver Street 3', 1980, 1, 0, 0, 0, 0, 61, 1),
(62, 0, 0, 0, 'Golden Axe Guildhall', 10485, 1, 0, 0, 0, 0, 381, 10),
(63, 0, 0, 0, 'Silver Street 1', 2565, 1, 0, 0, 0, 0, 120, 1),
(64, 0, 0, 0, 'Silver Street 2', 1980, 1, 0, 0, 0, 0, 66, 1),
(66, 0, 0, 0, 'Silver Street 4', 3295, 1, 0, 0, 0, 0, 136, 2),
(67, 0, 0, 0, 'Mystic Lane 2', 2980, 1, 0, 0, 0, 0, 99, 2),
(69, 0, 0, 0, 'Mystic Lane 1', 2945, 1, 0, 0, 0, 0, 115, 3),
(70, 0, 0, 0, 'Loot Lane 1 (Shop)', 4565, 1, 0, 0, 0, 0, 194, 3),
(71, 0, 0, 0, 'Market Street 6', 5485, 1, 0, 0, 0, 0, 212, 5),
(72, 0, 0, 0, 'Market Street 7', 2305, 1, 0, 0, 0, 0, 110, 2),
(73, 0, 0, 0, 'Market Street 5 (Shop)', 6375, 1, 0, 0, 0, 0, 214, 4),
(194, 0, 0, 0, 'Lucky Lane 1 (Shop)', 6960, 1, 0, 0, 0, 0, 211, 4),
(208, 0, 0, 0, 'Underwood 1', 1495, 5, 0, 0, 0, 0, 41, 2),
(209, 0, 0, 0, 'Underwood 2', 1495, 5, 0, 0, 0, 0, 41, 2),
(210, 0, 0, 0, 'Underwood 5', 1370, 5, 0, 0, 0, 0, 35, 3),
(211, 0, 0, 0, 'Underwood 3', 1685, 5, 0, 0, 0, 0, 44, 3),
(212, 0, 0, 0, 'Underwood 4', 2235, 5, 0, 0, 0, 0, 56, 4),
(213, 0, 0, 0, 'Underwood 10', 585, 5, 0, 0, 0, 0, 20, 1),
(214, 0, 0, 0, 'Underwood 6', 1595, 5, 0, 0, 0, 0, 42, 3),
(215, 0, 0, 0, 'Great Willow 1a', 500, 5, 0, 0, 0, 0, 16, 1),
(216, 0, 0, 0, 'Great Willow 1b', 650, 5, 0, 0, 0, 0, 22, 1),
(217, 0, 0, 0, 'Great Willow 1c', 650, 5, 0, 0, 0, 0, 22, 1),
(218, 0, 0, 0, 'Great Willow 2d', 450, 5, 0, 0, 0, 0, 10, 1),
(219, 0, 0, 0, 'Great Willow 2c', 650, 5, 0, 0, 0, 0, 21, 1),
(220, 0, 0, 0, 'Great Willow 2b', 450, 5, 0, 0, 0, 0, 16, 1),
(221, 0, 0, 0, 'Great Willow 2a', 650, 5, 0, 0, 0, 0, 17, 1),
(222, 0, 0, 0, 'Great Willow 3d', 450, 5, 0, 0, 0, 0, 17, 1),
(223, 0, 0, 0, 'Great Willow 3c', 650, 5, 0, 0, 0, 0, 21, 1),
(224, 0, 0, 0, 'Great Willow 3b', 450, 5, 0, 0, 0, 0, 16, 1),
(225, 0, 0, 0, 'Great Willow 3a', 650, 5, 0, 0, 0, 0, 20, 1),
(226, 0, 0, 0, 'Great Willow 4b', 950, 5, 0, 0, 0, 0, 25, 2),
(227, 0, 0, 0, 'Great Willow 4c', 950, 5, 0, 0, 0, 0, 25, 2),
(228, 0, 0, 0, 'Great Willow 4d', 750, 5, 0, 0, 0, 0, 26, 1),
(229, 0, 0, 0, 'Great Willow 4a', 950, 5, 0, 0, 0, 0, 25, 2),
(230, 0, 0, 0, 'Underwood 7', 1460, 5, 0, 0, 0, 0, 39, 2),
(231, 0, 0, 0, 'Shadow Caves 3', 300, 5, 0, 0, 0, 0, 16, 1),
(232, 0, 0, 0, 'Shadow Caves 4', 300, 5, 0, 0, 0, 0, 18, 1),
(233, 0, 0, 0, 'Shadow Caves 2', 300, 5, 0, 0, 0, 0, 18, 1),
(234, 0, 0, 0, 'Shadow Caves 1', 300, 5, 0, 0, 0, 0, 16, 1),
(235, 0, 0, 0, 'Shadow Caves 17', 300, 5, 0, 0, 0, 0, 16, 1),
(236, 0, 0, 0, 'Shadow Caves 18', 300, 5, 0, 0, 0, 0, 17, 1),
(237, 0, 0, 0, 'Shadow Caves 15', 300, 5, 0, 0, 0, 0, 16, 1),
(238, 0, 0, 0, 'Shadow Caves 16', 300, 5, 0, 0, 0, 0, 17, 1),
(239, 0, 0, 0, 'Shadow Caves 13', 300, 5, 0, 0, 0, 0, 16, 1),
(240, 0, 0, 0, 'Shadow Caves 14', 300, 5, 0, 0, 0, 0, 19, 1),
(241, 0, 0, 0, 'Shadow Caves 11', 300, 5, 0, 0, 0, 0, 16, 1),
(242, 0, 0, 0, 'Shadow Caves 12', 300, 5, 0, 0, 0, 0, 18, 1),
(243, 0, 0, 0, 'Shadow Caves 27', 300, 5, 0, 0, 0, 0, 14, 1),
(244, 0, 0, 0, 'Shadow Caves 28', 300, 5, 0, 0, 0, 0, 17, 1),
(245, 0, 0, 0, 'Shadow Caves 25', 300, 5, 0, 0, 0, 0, 16, 1),
(246, 0, 0, 0, 'Shadow Caves 26', 300, 5, 0, 0, 0, 0, 17, 1),
(247, 0, 0, 0, 'Shadow Caves 23', 300, 5, 0, 0, 0, 0, 16, 1),
(248, 0, 0, 0, 'Shadow Caves 24', 300, 5, 0, 0, 0, 0, 19, 1),
(249, 0, 0, 0, 'Shadow Caves 21', 300, 5, 0, 0, 0, 0, 16, 1),
(250, 0, 0, 0, 'Shadow Caves 22', 300, 5, 0, 0, 0, 0, 17, 1),
(251, 0, 0, 0, 'Underwood 9', 585, 5, 0, 0, 0, 0, 17, 1),
(252, 0, 0, 0, 'Treetop 13', 1400, 5, 0, 0, 0, 0, 33, 2),
(254, 0, 0, 0, 'Underwood 8', 865, 5, 0, 0, 0, 0, 25, 2),
(255, 0, 0, 0, 'Mangrove 4', 950, 5, 0, 0, 0, 0, 25, 2),
(256, 0, 0, 0, 'Coastwood 10', 1630, 5, 0, 0, 0, 0, 36, 3),
(257, 0, 0, 0, 'Mangrove 1', 1750, 5, 0, 0, 0, 0, 42, 3),
(258, 0, 0, 0, 'Coastwood 1', 980, 5, 0, 0, 0, 0, 24, 2),
(259, 0, 0, 0, 'Coastwood 2', 980, 5, 0, 0, 0, 0, 24, 2),
(260, 0, 0, 0, 'Mangrove 2', 1350, 5, 0, 0, 0, 0, 33, 2),
(262, 0, 0, 0, 'Mangrove 3', 1150, 5, 0, 0, 0, 0, 29, 2),
(263, 0, 0, 0, 'Coastwood 9', 935, 5, 0, 0, 0, 0, 22, 1),
(264, 0, 0, 0, 'Coastwood 8', 1255, 5, 0, 0, 0, 0, 31, 2),
(265, 0, 0, 0, 'Coastwood 6 (Shop)', 1595, 5, 0, 0, 0, 0, 44, 1),
(266, 0, 0, 0, 'Coastwood 7', 660, 5, 0, 0, 0, 0, 19, 1),
(267, 0, 0, 0, 'Coastwood 5', 1530, 5, 0, 0, 0, 0, 35, 2),
(268, 0, 0, 0, 'Coastwood 4', 1145, 5, 0, 0, 0, 0, 30, 2),
(269, 0, 0, 0, 'Coastwood 3', 1310, 5, 0, 0, 0, 0, 34, 2),
(270, 0, 0, 0, 'Treetop 11', 900, 5, 0, 0, 0, 0, 26, 2),
(271, 0, 0, 0, 'Treetop 5 (Shop)', 1350, 5, 0, 0, 0, 0, 40, 1),
(272, 0, 0, 0, 'Treetop 7', 800, 5, 0, 0, 0, 0, 24, 1),
(273, 0, 0, 0, 'Treetop 6', 450, 5, 0, 0, 0, 0, 15, 1),
(274, 0, 0, 0, 'Treetop 8', 800, 5, 0, 0, 0, 0, 23, 1),
(275, 0, 0, 0, 'Treetop 9', 1150, 5, 0, 0, 0, 0, 30, 2),
(276, 0, 0, 0, 'Treetop 10', 1150, 5, 0, 0, 0, 0, 34, 2),
(277, 0, 0, 0, 'Treetop 4 (Shop)', 1250, 5, 0, 0, 0, 0, 40, 1),
(278, 0, 0, 0, 'Treetop 3 (Shop)', 1250, 5, 0, 0, 0, 0, 38, 1),
(279, 0, 0, 0, 'Treetop 2', 650, 5, 0, 0, 0, 0, 21, 1),
(280, 0, 0, 0, 'Treetop 1', 650, 5, 0, 0, 0, 0, 19, 1),
(281, 0, 0, 0, 'Treetop 12 (Shop)', 1350, 5, 0, 0, 0, 0, 40, 1),
(469, 0, 0, 0, 'Darashia 2, Flat 07', 1000, 10, 0, 0, 0, 0, 48, 1),
(470, 0, 0, 0, 'Darashia 2, Flat 01', 1000, 10, 0, 0, 0, 0, 48, 1),
(471, 0, 0, 0, 'Darashia 2, Flat 02', 1000, 10, 0, 0, 0, 0, 42, 1),
(472, 0, 0, 0, 'Darashia 2, Flat 06', 520, 10, 0, 0, 0, 0, 24, 1),
(473, 0, 0, 0, 'Darashia 2, Flat 05', 1260, 10, 0, 0, 0, 0, 48, 2),
(474, 0, 0, 0, 'Darashia 2, Flat 04', 520, 10, 0, 0, 0, 0, 24, 1),
(475, 0, 0, 0, 'Darashia 2, Flat 03', 1160, 10, 0, 0, 0, 0, 42, 1),
(476, 0, 0, 0, 'Darashia 2, Flat 13', 1160, 10, 0, 0, 0, 0, 42, 1),
(477, 0, 0, 0, 'Darashia 2, Flat 12', 520, 10, 0, 0, 0, 0, 24, 1),
(478, 0, 0, 0, 'Darashia 2, Flat 11', 1000, 10, 0, 0, 0, 0, 42, 1),
(479, 0, 0, 0, 'Darashia 2, Flat 14', 520, 10, 0, 0, 0, 0, 24, 1),
(480, 0, 0, 0, 'Darashia 2, Flat 15', 1260, 10, 0, 0, 0, 0, 47, 2),
(481, 0, 0, 0, 'Darashia 2, Flat 16', 680, 10, 0, 0, 0, 0, 30, 1),
(482, 0, 0, 0, 'Darashia 2, Flat 17', 1000, 10, 0, 0, 0, 0, 48, 1),
(483, 0, 0, 0, 'Darashia 2, Flat 18', 680, 10, 0, 0, 0, 0, 30, 1),
(484, 0, 0, 0, 'Darashia 1, Flat 05', 1100, 10, 0, 0, 0, 0, 48, 2),
(485, 0, 0, 0, 'Darashia 1, Flat 01', 1100, 10, 0, 0, 0, 0, 49, 2),
(486, 0, 0, 0, 'Darashia 1, Flat 04', 1000, 10, 0, 0, 0, 0, 42, 1),
(487, 0, 0, 0, 'Darashia 1, Flat 03', 2660, 10, 0, 0, 0, 0, 96, 4),
(488, 0, 0, 0, 'Darashia 1, Flat 02', 1000, 10, 0, 0, 0, 0, 41, 1),
(490, 0, 0, 0, 'Darashia 1, Flat 12', 1780, 10, 0, 0, 0, 0, 66, 2),
(491, 0, 0, 0, 'Darashia 1, Flat 11', 1100, 10, 0, 0, 0, 0, 41, 2),
(492, 0, 0, 0, 'Darashia 1, Flat 13', 1780, 10, 0, 0, 0, 0, 72, 2),
(493, 0, 0, 0, 'Darashia 1, Flat 14', 2760, 10, 0, 0, 0, 0, 108, 5),
(494, 0, 0, 0, 'Darashia 4, Flat 01', 1000, 10, 0, 0, 0, 0, 48, 1),
(495, 0, 0, 0, 'Darashia 4, Flat 05', 1100, 10, 0, 0, 0, 0, 48, 2),
(496, 0, 0, 0, 'Darashia 4, Flat 04', 1780, 10, 0, 0, 0, 0, 72, 2),
(497, 0, 0, 0, 'Darashia 4, Flat 03', 1000, 10, 0, 0, 0, 0, 42, 1),
(498, 0, 0, 0, 'Darashia 4, Flat 02', 1780, 10, 0, 0, 0, 0, 66, 2),
(499, 0, 0, 0, 'Darashia 4, Flat 13', 1780, 10, 0, 0, 0, 0, 78, 2),
(500, 0, 0, 0, 'Darashia 4, Flat 14', 1780, 10, 0, 0, 0, 0, 72, 2),
(501, 0, 0, 0, 'Darashia 4, Flat 11', 1000, 10, 0, 0, 0, 0, 41, 1),
(502, 0, 0, 0, 'Darashia 4, Flat 12', 2560, 10, 0, 0, 0, 0, 96, 3),
(503, 0, 0, 0, 'Darashia 7, Flat 05', 1225, 10, 0, 0, 0, 0, 40, 2),
(504, 0, 0, 0, 'Darashia 7, Flat 01', 1125, 10, 0, 0, 0, 0, 40, 1),
(505, 0, 0, 0, 'Darashia 7, Flat 02', 1125, 10, 0, 0, 0, 0, 41, 1),
(506, 0, 0, 0, 'Darashia 7, Flat 03', 2955, 10, 0, 0, 0, 0, 108, 4),
(507, 0, 0, 0, 'Darashia 7, Flat 04', 1125, 10, 0, 0, 0, 0, 42, 1),
(508, 0, 0, 0, 'Darashia 7, Flat 14', 2955, 10, 0, 0, 0, 0, 108, 4),
(509, 0, 0, 0, 'Darashia 7, Flat 13', 1125, 10, 0, 0, 0, 0, 42, 1),
(510, 0, 0, 0, 'Darashia 7, Flat 11', 1125, 10, 0, 0, 0, 0, 41, 1),
(511, 0, 0, 0, 'Darashia 7, Flat 12', 2955, 10, 0, 0, 0, 0, 95, 4),
(512, 0, 0, 0, 'Darashia 5, Flat 01', 1000, 10, 0, 0, 0, 0, 38, 1),
(513, 0, 0, 0, 'Darashia 5, Flat 05', 1000, 10, 0, 0, 0, 0, 48, 1),
(514, 0, 0, 0, 'Darashia 5, Flat 02', 1620, 10, 0, 0, 0, 0, 57, 2),
(515, 0, 0, 0, 'Darashia 5, Flat 03', 1000, 10, 0, 0, 0, 0, 41, 1),
(516, 0, 0, 0, 'Darashia 5, Flat 04', 1620, 10, 0, 0, 0, 0, 66, 2),
(517, 0, 0, 0, 'Darashia 5, Flat 11', 1780, 10, 0, 0, 0, 0, 66, 2),
(518, 0, 0, 0, 'Darashia 5, Flat 12', 1620, 10, 0, 0, 0, 0, 65, 2),
(519, 0, 0, 0, 'Darashia 5, Flat 13', 1780, 10, 0, 0, 0, 0, 78, 2),
(520, 0, 0, 0, 'Darashia 5, Flat 14', 1620, 10, 0, 0, 0, 0, 66, 2),
(521, 0, 0, 0, 'Darashia 6a', 3115, 10, 0, 0, 0, 0, 117, 2),
(522, 0, 0, 0, 'Darashia 6b', 3430, 10, 0, 0, 0, 0, 139, 2),
(523, 0, 0, 0, 'Darashia, Villa', 5385, 10, 0, 0, 0, 0, 233, 4),
(525, 0, 0, 0, 'Darashia, Western Guildhall', 10435, 10, 0, 0, 0, 0, 376, 14),
(526, 0, 0, 0, 'Darashia 3, Flat 01', 1100, 10, 0, 0, 0, 0, 40, 2),
(527, 0, 0, 0, 'Darashia 3, Flat 05', 1000, 10, 0, 0, 0, 0, 40, 1),
(529, 0, 0, 0, 'Darashia 3, Flat 02', 1620, 10, 0, 0, 0, 0, 65, 2),
(530, 0, 0, 0, 'Darashia 3, Flat 03', 1100, 10, 0, 0, 0, 0, 42, 2),
(531, 0, 0, 0, 'Darashia 3, Flat 04', 1620, 10, 0, 0, 0, 0, 72, 2),
(532, 0, 0, 0, 'Darashia 3, Flat 13', 1100, 10, 0, 0, 0, 0, 42, 2),
(533, 0, 0, 0, 'Darashia 3, Flat 14', 2400, 10, 0, 0, 0, 0, 102, 3),
(534, 0, 0, 0, 'Darashia 3, Flat 11', 1000, 10, 0, 0, 0, 0, 41, 1),
(535, 0, 0, 0, 'Darashia 3, Flat 12', 2600, 10, 0, 0, 0, 0, 90, 5),
(541, 0, 0, 0, 'Darashia 8, Flat 11', 1990, 10, 0, 0, 0, 0, 66, 2),
(542, 0, 0, 0, 'Darashia 8, Flat 12', 1810, 10, 0, 0, 0, 0, 65, 2),
(544, 0, 0, 0, 'Darashia 8, Flat 14', 1810, 10, 0, 0, 0, 0, 66, 2),
(545, 0, 0, 0, 'Darashia 8, Flat 13', 1990, 10, 0, 0, 0, 0, 78, 2),
(574, 0, 0, 0, 'Oskahl I j', 680, 9, 0, 0, 0, 0, 25, 1),
(575, 0, 0, 0, 'Oskahl I f', 840, 9, 0, 0, 0, 0, 34, 1),
(576, 0, 0, 0, 'Oskahl I i', 840, 9, 0, 0, 0, 0, 30, 1),
(577, 0, 0, 0, 'Oskahl I g', 1140, 9, 0, 0, 0, 0, 42, 2),
(578, 0, 0, 0, 'Oskahl I h', 1760, 9, 0, 0, 0, 0, 63, 3),
(579, 0, 0, 0, 'Oskahl I d', 1140, 9, 0, 0, 0, 0, 36, 2),
(580, 0, 0, 0, 'Oskahl I b', 840, 9, 0, 0, 0, 0, 30, 1),
(581, 0, 0, 0, 'Oskahl I c', 680, 9, 0, 0, 0, 0, 29, 1),
(582, 0, 0, 0, 'Oskahl I e', 840, 9, 0, 0, 0, 0, 33, 1),
(583, 0, 0, 0, 'Oskahl I a', 1580, 9, 0, 0, 0, 0, 52, 2),
(584, 0, 0, 0, 'Chameken I', 850, 9, 0, 0, 0, 0, 30, 1),
(585, 0, 0, 0, 'Charsirakh III', 680, 9, 0, 0, 0, 0, 30, 1),
(586, 0, 0, 0, 'Murkhol I d', 440, 9, 0, 0, 0, 0, 21, 1),
(587, 0, 0, 0, 'Murkhol I c', 440, 9, 0, 0, 0, 0, 18, 1),
(588, 0, 0, 0, 'Murkhol I b', 440, 9, 0, 0, 0, 0, 18, 1),
(589, 0, 0, 0, 'Murkhol I a', 440, 9, 0, 0, 0, 0, 20, 1),
(590, 0, 0, 0, 'Charsirakh II', 1140, 9, 0, 0, 0, 0, 39, 2),
(591, 0, 0, 0, 'Thanah II h', 1400, 9, 0, 0, 0, 0, 40, 2),
(592, 0, 0, 0, 'Thanah II g', 1650, 9, 0, 0, 0, 0, 45, 2),
(593, 0, 0, 0, 'Thanah II f', 2850, 9, 0, 0, 0, 0, 80, 3),
(594, 0, 0, 0, 'Thanah II b', 450, 9, 0, 0, 0, 0, 20, 1),
(595, 0, 0, 0, 'Thanah II c', 450, 9, 0, 0, 0, 0, 15, 1),
(596, 0, 0, 0, 'Thanah II d', 350, 9, 0, 0, 0, 0, 16, 1),
(597, 0, 0, 0, 'Thanah II e', 350, 9, 0, 0, 0, 0, 12, 1),
(599, 0, 0, 0, 'Thanah II a', 850, 9, 0, 0, 0, 0, 37, 1),
(600, 0, 0, 0, 'Thrarhor I c (Shop)', 1050, 9, 0, 0, 0, 0, 28, 1),
(601, 0, 0, 0, 'Thrarhor I d (Shop)', 1050, 9, 0, 0, 0, 0, 21, 1),
(602, 0, 0, 0, 'Thrarhor I a (Shop)', 1050, 9, 0, 0, 0, 0, 32, 1),
(603, 0, 0, 0, 'Thrarhor I b (Shop)', 1050, 9, 0, 0, 0, 0, 24, 1),
(604, 0, 0, 0, 'Thanah I c', 3250, 9, 0, 0, 0, 0, 91, 3),
(605, 0, 0, 0, 'Thanah I d', 2900, 9, 0, 0, 0, 0, 80, 4),
(606, 0, 0, 0, 'Thanah I b', 3000, 9, 0, 0, 0, 0, 84, 3),
(607, 0, 0, 0, 'Thanah I a', 850, 9, 0, 0, 0, 0, 27, 1),
(608, 0, 0, 0, 'Harrah I', 5740, 9, 0, 0, 0, 0, 190, 10),
(609, 0, 0, 0, 'Charsirakh I b', 1580, 9, 0, 0, 0, 0, 51, 2),
(610, 0, 0, 0, 'Charsirakh I a', 280, 9, 0, 0, 0, 0, 15, 1),
(611, 0, 0, 0, 'Othehothep I d', 2020, 9, 0, 0, 0, 0, 68, 4),
(612, 0, 0, 0, 'Othehothep I c', 1720, 9, 0, 0, 0, 0, 58, 3),
(613, 0, 0, 0, 'Othehothep I b', 1380, 9, 0, 0, 0, 0, 49, 2),
(614, 0, 0, 0, 'Othehothep I a', 280, 9, 0, 0, 0, 0, 14, 1),
(615, 0, 0, 0, 'Othehothep II e', 1340, 9, 0, 0, 0, 0, 44, 2),
(616, 0, 0, 0, 'Othehothep II f', 1340, 9, 0, 0, 0, 0, 44, 2),
(617, 0, 0, 0, 'Othehothep II d', 840, 9, 0, 0, 0, 0, 32, 1),
(618, 0, 0, 0, 'Othehothep II c', 840, 9, 0, 0, 0, 0, 30, 1),
(619, 0, 0, 0, 'Othehothep II b', 1920, 9, 0, 0, 0, 0, 67, 3),
(620, 0, 0, 0, 'Othehothep II a', 400, 9, 0, 0, 0, 0, 18, 1),
(621, 0, 0, 0, 'Mothrem I', 1140, 9, 0, 0, 0, 0, 38, 2),
(622, 0, 0, 0, 'Arakmehn I', 1320, 9, 0, 0, 0, 0, 41, 3),
(623, 0, 0, 0, 'Othehothep III d', 1040, 9, 0, 0, 0, 0, 36, 1),
(624, 0, 0, 0, 'Othehothep III c', 940, 9, 0, 0, 0, 0, 30, 2),
(625, 0, 0, 0, 'Othehothep III e', 840, 9, 0, 0, 0, 0, 32, 1),
(626, 0, 0, 0, 'Othehothep III f', 680, 9, 0, 0, 0, 0, 27, 1),
(627, 0, 0, 0, 'Othehothep III b', 1340, 9, 0, 0, 0, 0, 49, 2),
(628, 0, 0, 0, 'Othehothep III a', 280, 9, 0, 0, 0, 0, 14, 1),
(629, 0, 0, 0, 'Unklath I d', 1680, 9, 0, 0, 0, 0, 49, 3),
(630, 0, 0, 0, 'Unklath I e', 1580, 9, 0, 0, 0, 0, 51, 2),
(631, 0, 0, 0, 'Unklath I g', 1480, 9, 0, 0, 0, 0, 51, 1),
(632, 0, 0, 0, 'Unklath I f', 1580, 9, 0, 0, 0, 0, 51, 2),
(633, 0, 0, 0, 'Unklath I c', 1460, 9, 0, 0, 0, 0, 50, 2),
(634, 0, 0, 0, 'Unklath I b', 1460, 9, 0, 0, 0, 0, 50, 2),
(635, 0, 0, 0, 'Unklath I a', 1140, 9, 0, 0, 0, 0, 38, 2),
(636, 0, 0, 0, 'Arakmehn II', 1040, 9, 0, 0, 0, 0, 38, 1),
(637, 0, 0, 0, 'Arakmehn III', 1140, 9, 0, 0, 0, 0, 38, 2),
(638, 0, 0, 0, 'Unklath II b', 680, 9, 0, 0, 0, 0, 25, 1),
(639, 0, 0, 0, 'Unklath II c', 680, 9, 0, 0, 0, 0, 27, 1),
(640, 0, 0, 0, 'Unklath II d', 1580, 9, 0, 0, 0, 0, 52, 2),
(641, 0, 0, 0, 'Unklath II a', 1040, 9, 0, 0, 0, 0, 36, 1),
(642, 0, 0, 0, 'Arakmehn IV', 1220, 9, 0, 0, 0, 0, 41, 2),
(643, 0, 0, 0, 'Rathal I b', 680, 9, 0, 0, 0, 0, 25, 1),
(644, 0, 0, 0, 'Rathal I c', 680, 9, 0, 0, 0, 0, 27, 1),
(645, 0, 0, 0, 'Rathal I e', 780, 9, 0, 0, 0, 0, 27, 2),
(646, 0, 0, 0, 'Rathal I d', 780, 9, 0, 0, 0, 0, 27, 2),
(647, 0, 0, 0, 'Rathal I a', 1140, 9, 0, 0, 0, 0, 36, 2),
(648, 0, 0, 0, 'Rathal II b', 680, 9, 0, 0, 0, 0, 25, 1),
(649, 0, 0, 0, 'Rathal II c', 680, 9, 0, 0, 0, 0, 27, 1),
(650, 0, 0, 0, 'Rathal II d', 1460, 9, 0, 0, 0, 0, 52, 2),
(651, 0, 0, 0, 'Rathal II a', 1040, 9, 0, 0, 0, 0, 38, 1),
(653, 0, 0, 0, 'Esuph II a', 280, 9, 0, 0, 0, 0, 14, 1),
(654, 0, 0, 0, 'Uthemath II', 4460, 9, 0, 0, 0, 0, 138, 8),
(655, 0, 0, 0, 'Uthemath I e', 940, 9, 0, 0, 0, 0, 32, 2),
(656, 0, 0, 0, 'Uthemath I d', 840, 9, 0, 0, 0, 0, 30, 1),
(657, 0, 0, 0, 'Uthemath I f', 2440, 9, 0, 0, 0, 0, 86, 3),
(658, 0, 0, 0, 'Uthemath I b', 800, 9, 0, 0, 0, 0, 32, 1),
(659, 0, 0, 0, 'Uthemath I c', 900, 9, 0, 0, 0, 0, 34, 2),
(660, 0, 0, 0, 'Uthemath I a', 400, 9, 0, 0, 0, 0, 18, 1),
(661, 0, 0, 0, 'Botham I c', 1700, 9, 0, 0, 0, 0, 49, 2),
(662, 0, 0, 0, 'Botham I e', 1650, 9, 0, 0, 0, 0, 44, 2),
(663, 0, 0, 0, 'Botham I d', 3050, 9, 0, 0, 0, 0, 80, 3),
(664, 0, 0, 0, 'Botham I b', 3000, 9, 0, 0, 0, 0, 83, 3),
(666, 0, 0, 0, 'Horakhal', 9420, 9, 0, 0, 0, 0, 277, 14),
(667, 0, 0, 0, 'Esuph III b', 1340, 9, 0, 0, 0, 0, 49, 2),
(668, 0, 0, 0, 'Esuph III a', 280, 9, 0, 0, 0, 0, 14, 1),
(669, 0, 0, 0, 'Esuph IV b', 400, 9, 0, 0, 0, 0, 16, 1),
(670, 0, 0, 0, 'Esuph IV c', 400, 9, 0, 0, 0, 0, 18, 1),
(671, 0, 0, 0, 'Esuph IV d', 800, 9, 0, 0, 0, 0, 34, 1),
(672, 0, 0, 0, 'Esuph IV a', 400, 9, 0, 0, 0, 0, 16, 1),
(673, 0, 0, 0, 'Botham II e', 1650, 9, 0, 0, 0, 0, 42, 2),
(674, 0, 0, 0, 'Botham II g', 1400, 9, 0, 0, 0, 0, 38, 2),
(675, 0, 0, 0, 'Botham II f', 1650, 9, 0, 0, 0, 0, 44, 2),
(676, 0, 0, 0, 'Botham II d', 1950, 9, 0, 0, 0, 0, 49, 2),
(677, 0, 0, 0, 'Botham II c', 1250, 9, 0, 0, 0, 0, 38, 2),
(678, 0, 0, 0, 'Botham II b', 1600, 9, 0, 0, 0, 0, 47, 2),
(679, 0, 0, 0, 'Botham II a', 850, 9, 0, 0, 0, 0, 25, 1),
(680, 0, 0, 0, 'Botham III g', 1650, 9, 0, 0, 0, 0, 42, 2),
(681, 0, 0, 0, 'Botham III f', 2350, 9, 0, 0, 0, 0, 56, 3),
(682, 0, 0, 0, 'Botham III h', 3750, 9, 0, 0, 0, 0, 98, 3),
(683, 0, 0, 0, 'Botham III d', 850, 9, 0, 0, 0, 0, 27, 1),
(684, 0, 0, 0, 'Botham III e', 850, 9, 0, 0, 0, 0, 27, 1),
(685, 0, 0, 0, 'Botham III b', 950, 9, 0, 0, 0, 0, 25, 2),
(686, 0, 0, 0, 'Botham III c', 850, 9, 0, 0, 0, 0, 27, 1),
(687, 0, 0, 0, 'Botham III a', 1400, 9, 0, 0, 0, 0, 36, 2),
(688, 0, 0, 0, 'Botham IV i', 1800, 9, 0, 0, 0, 0, 51, 3),
(689, 0, 0, 0, 'Botham IV h', 1850, 9, 0, 0, 0, 0, 49, 1),
(690, 0, 0, 0, 'Botham IV f', 1700, 9, 0, 0, 0, 0, 49, 2),
(691, 0, 0, 0, 'Botham IV g', 1650, 9, 0, 0, 0, 0, 49, 2),
(692, 0, 0, 0, 'Botham IV c', 850, 9, 0, 0, 0, 0, 27, 1),
(693, 0, 0, 0, 'Botham IV e', 850, 9, 0, 0, 0, 0, 27, 1),
(694, 0, 0, 0, 'Botham IV d', 850, 9, 0, 0, 0, 0, 27, 1),
(695, 0, 0, 0, 'Botham IV b', 850, 9, 0, 0, 0, 0, 25, 1),
(696, 0, 0, 0, 'Botham IV a', 1400, 9, 0, 0, 0, 0, 36, 2),
(697, 0, 0, 0, 'Ramen Tah', 7650, 9, 0, 0, 0, 0, 184, 16),
(698, 0, 0, 0, 'Banana Bay 1', 450, 8, 0, 0, 0, 0, 25, 1),
(699, 0, 0, 0, 'Banana Bay 2', 765, 8, 0, 0, 0, 0, 36, 1),
(700, 0, 0, 0, 'Banana Bay 3', 450, 8, 0, 0, 0, 0, 25, 1),
(701, 0, 0, 0, 'Banana Bay 4', 450, 8, 0, 0, 0, 0, 25, 1),
(702, 0, 0, 0, 'Shark Manor', 8780, 8, 0, 0, 0, 0, 286, 15),
(703, 0, 0, 0, 'Coconut Quay 1', 1765, 8, 0, 0, 0, 0, 64, 2),
(704, 0, 0, 0, 'Coconut Quay 2', 1045, 8, 0, 0, 0, 0, 42, 2),
(705, 0, 0, 0, 'Coconut Quay 3', 2145, 8, 0, 0, 0, 0, 70, 4),
(706, 0, 0, 0, 'Coconut Quay 4', 2135, 8, 0, 0, 0, 0, 72, 3),
(707, 0, 0, 0, 'Crocodile Bridge 3', 1270, 8, 0, 0, 0, 0, 49, 2),
(708, 0, 0, 0, 'Crocodile Bridge 2', 865, 8, 0, 0, 0, 0, 36, 2),
(709, 0, 0, 0, 'Crocodile Bridge 1', 1045, 8, 0, 0, 0, 0, 42, 2),
(710, 0, 0, 0, 'Bamboo Garden 1', 1640, 8, 0, 0, 0, 0, 63, 3),
(711, 0, 0, 0, 'Crocodile Bridge 4', 4755, 8, 0, 0, 0, 0, 176, 4),
(712, 0, 0, 0, 'Crocodile Bridge 5', 3970, 8, 0, 0, 0, 0, 157, 2),
(713, 0, 0, 0, 'Woodway 1', 765, 8, 0, 0, 0, 0, 36, 1),
(714, 0, 0, 0, 'Woodway 2', 585, 8, 0, 0, 0, 0, 30, 1),
(715, 0, 0, 0, 'Woodway 3', 1540, 8, 0, 0, 0, 0, 65, 2),
(716, 0, 0, 0, 'Woodway 4', 405, 8, 0, 0, 0, 0, 24, 1),
(717, 0, 0, 0, 'Flamingo Flats 5', 1845, 8, 0, 0, 0, 0, 84, 1),
(718, 0, 0, 0, 'Bamboo Fortress', 21970, 8, 0, 0, 0, 0, 848, 20),
(719, 0, 0, 0, 'Bamboo Garden 3', 1540, 8, 0, 0, 0, 0, 63, 2),
(720, 0, 0, 0, 'Bamboo Garden 2', 1045, 8, 0, 0, 0, 0, 42, 2),
(721, 0, 0, 0, 'Flamingo Flats 4', 865, 8, 0, 0, 0, 0, 36, 2),
(722, 0, 0, 0, 'Flamingo Flats 2', 1045, 8, 0, 0, 0, 0, 42, 2),
(723, 0, 0, 0, 'Flamingo Flats 3', 685, 8, 0, 0, 0, 0, 30, 2),
(724, 0, 0, 0, 'Flamingo Flats 1', 685, 8, 0, 0, 0, 0, 30, 2),
(725, 0, 0, 0, 'Jungle Edge 4', 865, 8, 0, 0, 0, 0, 36, 2),
(726, 0, 0, 0, 'Jungle Edge 5', 865, 8, 0, 0, 0, 0, 36, 2),
(727, 0, 0, 0, 'Jungle Edge 6', 450, 8, 0, 0, 0, 0, 25, 1),
(728, 0, 0, 0, 'Jungle Edge 2', 3170, 8, 0, 0, 0, 0, 128, 3),
(729, 0, 0, 0, 'Jungle Edge 3', 865, 8, 0, 0, 0, 0, 36, 2),
(730, 0, 0, 0, 'Jungle Edge 1', 2495, 8, 0, 0, 0, 0, 98, 3),
(731, 0, 0, 0, 'Haggler\'s Hangout 6', 6450, 8, 0, 0, 0, 0, 208, 4),
(732, 0, 0, 0, 'Haggler\'s Hangout 5 (Shop)', 1550, 8, 0, 0, 0, 0, 56, 1),
(733, 0, 0, 0, 'Haggler\'s Hangout 4a (Shop)', 1850, 8, 0, 0, 0, 0, 56, 1),
(734, 0, 0, 0, 'Haggler\'s Hangout 4b (Shop)', 1550, 8, 0, 0, 0, 0, 56, 1),
(735, 0, 0, 0, 'Haggler\'s Hangout 3', 7550, 8, 0, 0, 0, 0, 256, 4),
(736, 0, 0, 0, 'Haggler\'s Hangout 2', 1300, 8, 0, 0, 0, 0, 49, 1),
(737, 0, 0, 0, 'Haggler\'s Hangout 1', 1400, 8, 0, 0, 0, 0, 49, 2),
(738, 0, 0, 0, 'River Homes 1', 3485, 8, 0, 0, 0, 0, 128, 3),
(739, 0, 0, 0, 'River Homes 2a', 1270, 8, 0, 0, 0, 0, 42, 2),
(740, 0, 0, 0, 'River Homes 2b', 1595, 8, 0, 0, 0, 0, 56, 3),
(741, 0, 0, 0, 'River Homes 3', 5055, 8, 0, 0, 0, 0, 176, 7),
(742, 0, 0, 0, 'The Treehouse', 24120, 8, 0, 0, 0, 0, 897, 23),
(743, 0, 0, 0, 'Corner Shop (Shop)', 2215, 12, 0, 0, 0, 0, 96, 2),
(744, 0, 0, 0, 'Tusk Flats 1', 765, 12, 0, 0, 0, 0, 40, 2),
(745, 0, 0, 0, 'Tusk Flats 2', 835, 12, 0, 0, 0, 0, 42, 2),
(746, 0, 0, 0, 'Tusk Flats 3', 660, 12, 0, 0, 0, 0, 34, 2),
(747, 0, 0, 0, 'Tusk Flats 4', 315, 12, 0, 0, 0, 0, 24, 1),
(748, 0, 0, 0, 'Tusk Flats 6', 660, 12, 0, 0, 0, 0, 35, 2),
(749, 0, 0, 0, 'Tusk Flats 5', 455, 12, 0, 0, 0, 0, 30, 1),
(750, 0, 0, 0, 'Shady Rocks 5', 2890, 12, 0, 0, 0, 0, 110, 2),
(751, 0, 0, 0, 'Shady Rocks 4 (Shop)', 2710, 12, 0, 0, 0, 0, 110, 2),
(752, 0, 0, 0, 'Shady Rocks 3', 4115, 12, 0, 0, 0, 0, 154, 3),
(753, 0, 0, 0, 'Shady Rocks 2', 2010, 12, 0, 0, 0, 0, 77, 4),
(754, 0, 0, 0, 'Shady Rocks 1', 3630, 12, 0, 0, 0, 0, 132, 4),
(755, 0, 0, 0, 'Crystal Glance', 19625, 12, 0, 0, 0, 0, 569, 24),
(756, 0, 0, 0, 'Arena Walk 3', 3550, 12, 0, 0, 0, 0, 126, 3),
(757, 0, 0, 0, 'Arena Walk 2', 1400, 12, 0, 0, 0, 0, 54, 2),
(758, 0, 0, 0, 'Arena Walk 1', 3250, 12, 0, 0, 0, 0, 128, 3),
(759, 0, 0, 0, 'Bears Paw 2', 2305, 12, 0, 0, 0, 0, 100, 2),
(760, 0, 0, 0, 'Bears Paw 1', 1810, 12, 0, 0, 0, 0, 72, 2),
(761, 0, 0, 0, 'Spirit Homes 5', 1450, 12, 0, 0, 0, 0, 56, 2),
(762, 0, 0, 0, 'Glacier Side 3', 1950, 12, 0, 0, 0, 0, 75, 2),
(763, 0, 0, 0, 'Glacier Side 2', 4750, 12, 0, 0, 0, 0, 154, 3),
(764, 0, 0, 0, 'Glacier Side 1', 1600, 12, 0, 0, 0, 0, 65, 2),
(765, 0, 0, 0, 'Spirit Homes 1', 1700, 12, 0, 0, 0, 0, 56, 2),
(766, 0, 0, 0, 'Spirit Homes 2', 1900, 12, 0, 0, 0, 0, 72, 2),
(767, 0, 0, 0, 'Spirit Homes 3', 4250, 12, 0, 0, 0, 0, 128, 3),
(768, 0, 0, 0, 'Spirit Homes 4', 1100, 12, 0, 0, 0, 0, 49, 1),
(770, 0, 0, 0, 'Glacier Side 4', 2050, 12, 0, 0, 0, 0, 75, 1),
(771, 0, 0, 0, 'Shelf Site', 4800, 12, 0, 0, 0, 0, 160, 3),
(772, 0, 0, 0, 'Raven Corner 1', 855, 12, 0, 0, 0, 0, 45, 1),
(773, 0, 0, 0, 'Raven Corner 2', 1685, 12, 0, 0, 0, 0, 60, 3),
(774, 0, 0, 0, 'Raven Corner 3', 855, 12, 0, 0, 0, 0, 45, 1),
(775, 0, 0, 0, 'Bears Paw 3', 2090, 12, 0, 0, 0, 0, 82, 3),
(776, 0, 0, 0, 'Bears Paw 4', 5205, 12, 0, 0, 0, 0, 189, 4),
(778, 0, 0, 0, 'Bears Paw 5', 2045, 12, 0, 0, 0, 0, 81, 3),
(779, 0, 0, 0, 'Trout Plaza 5 (Shop)', 3880, 12, 0, 0, 0, 0, 144, 2),
(780, 0, 0, 0, 'Pilchard Bin 1', 685, 12, 0, 0, 0, 0, 30, 2),
(781, 0, 0, 0, 'Pilchard Bin 2', 685, 12, 0, 0, 0, 0, 24, 2),
(782, 0, 0, 0, 'Pilchard Bin 3', 585, 12, 0, 0, 0, 0, 24, 1),
(783, 0, 0, 0, 'Pilchard Bin 4', 585, 12, 0, 0, 0, 0, 24, 1),
(784, 0, 0, 0, 'Pilchard Bin 5', 685, 12, 0, 0, 0, 0, 24, 2),
(785, 0, 0, 0, 'Pilchard Bin 10', 450, 12, 0, 0, 0, 0, 20, 1),
(786, 0, 0, 0, 'Pilchard Bin 9', 450, 12, 0, 0, 0, 0, 20, 1),
(787, 0, 0, 0, 'Pilchard Bin 8', 450, 12, 0, 0, 0, 0, 20, 2),
(789, 0, 0, 0, 'Pilchard Bin 7', 450, 12, 0, 0, 0, 0, 20, 1),
(790, 0, 0, 0, 'Pilchard Bin 6', 450, 12, 0, 0, 0, 0, 25, 1),
(791, 0, 0, 0, 'Trout Plaza 1', 2395, 12, 0, 0, 0, 0, 112, 2),
(792, 0, 0, 0, 'Trout Plaza 2', 1540, 12, 0, 0, 0, 0, 64, 2),
(793, 0, 0, 0, 'Trout Plaza 3', 900, 12, 0, 0, 0, 0, 36, 1),
(794, 0, 0, 0, 'Trout Plaza 4', 900, 12, 0, 0, 0, 0, 45, 1),
(795, 0, 0, 0, 'Skiffs End 1', 1540, 12, 0, 0, 0, 0, 70, 2),
(796, 0, 0, 0, 'Skiffs End 2', 910, 12, 0, 0, 0, 0, 42, 2),
(797, 0, 0, 0, 'Furrier Quarter 3', 1010, 12, 0, 0, 0, 0, 54, 2),
(798, 0, 0, 0, 'Mammoth Belly', 22810, 12, 0, 0, 0, 0, 634, 30),
(799, 0, 0, 0, 'Furrier Quarter 2', 1045, 12, 0, 0, 0, 0, 56, 2),
(800, 0, 0, 0, 'Furrier Quarter 1', 1635, 12, 0, 0, 0, 0, 84, 3),
(801, 0, 0, 0, 'Fimbul Shelf 3', 1255, 12, 0, 0, 0, 0, 66, 2),
(802, 0, 0, 0, 'Fimbul Shelf 4', 1045, 12, 0, 0, 0, 0, 56, 2),
(803, 0, 0, 0, 'Fimbul Shelf 2', 1045, 12, 0, 0, 0, 0, 56, 2),
(804, 0, 0, 0, 'Fimbul Shelf 1', 975, 12, 0, 0, 0, 0, 48, 2),
(805, 0, 0, 0, 'Frost Manor', 26370, 12, 0, 0, 0, 0, 806, 24),
(831, 0, 0, 0, 'Marble Guildhall', 16810, 3, 0, 0, 0, 0, 530, 17),
(832, 0, 0, 0, 'Iron Guildhall', 15560, 3, 0, 0, 0, 0, 464, 17),
(833, 0, 0, 0, 'The Market 1 (Shop)', 650, 3, 0, 0, 0, 0, 25, 1),
(834, 0, 0, 0, 'The Market 3 (Shop)', 1450, 3, 0, 0, 0, 0, 40, 1),
(835, 0, 0, 0, 'The Market 2 (Shop)', 1100, 3, 0, 0, 0, 0, 40, 1),
(836, 0, 0, 0, 'The Market 4 (Shop)', 1800, 3, 0, 0, 0, 0, 48, 1),
(837, 0, 0, 0, 'Granite Guildhall', 17845, 3, 0, 0, 0, 0, 530, 17),
(838, 0, 0, 0, 'Upper Barracks 1', 210, 3, 0, 0, 0, 0, 14, 1),
(850, 0, 0, 0, 'Upper Barracks 13', 580, 3, 0, 0, 0, 0, 24, 2),
(851, 0, 0, 0, 'Nobility Quarter 4', 765, 3, 0, 0, 0, 0, 25, 1),
(852, 0, 0, 0, 'Nobility Quarter 5', 765, 3, 0, 0, 0, 0, 25, 1),
(853, 0, 0, 0, 'Nobility Quarter 7', 765, 3, 0, 0, 0, 0, 25, 1),
(854, 0, 0, 0, 'Nobility Quarter 6', 765, 3, 0, 0, 0, 0, 26, 1),
(855, 0, 0, 0, 'Nobility Quarter 8', 765, 3, 0, 0, 0, 0, 26, 1),
(856, 0, 0, 0, 'Nobility Quarter 9', 765, 3, 0, 0, 0, 0, 26, 1),
(857, 0, 0, 0, 'Nobility Quarter 2', 1865, 3, 0, 0, 0, 0, 50, 3),
(858, 0, 0, 0, 'Nobility Quarter 3', 1865, 3, 0, 0, 0, 0, 50, 3),
(859, 0, 0, 0, 'Nobility Quarter 1', 1865, 3, 0, 0, 0, 0, 50, 3),
(863, 0, 0, 0, 'The Farms 6, Fishing Hut', 1255, 3, 0, 0, 0, 0, 32, 2),
(864, 0, 0, 0, 'The Farms 5', 1530, 3, 0, 0, 0, 0, 36, 2),
(866, 0, 0, 0, 'The Farms 3', 1530, 3, 0, 0, 0, 0, 36, 2),
(867, 0, 0, 0, 'The Farms 2', 1530, 3, 0, 0, 0, 0, 36, 2),
(868, 0, 0, 0, 'The Farms 1', 2510, 3, 0, 0, 0, 0, 60, 3),
(886, 0, 0, 0, 'Outlaw Castle', 8000, 3, 0, 0, 0, 0, 307, 9),
(889, 0, 0, 0, 'Tunnel Gardens 3', 2000, 3, 0, 0, 0, 0, 43, 3),
(890, 0, 0, 0, 'Tunnel Gardens 4', 2000, 3, 0, 0, 0, 0, 42, 3),
(892, 0, 0, 0, 'Tunnel Gardens 5', 1360, 3, 0, 0, 0, 0, 35, 2),
(893, 0, 0, 0, 'Tunnel Gardens 6', 1360, 3, 0, 0, 0, 0, 38, 2),
(894, 0, 0, 0, 'Tunnel Gardens 8', 1360, 3, 0, 0, 0, 0, 35, 2),
(895, 0, 0, 0, 'Tunnel Gardens 7', 1360, 3, 0, 0, 0, 0, 35, 2),
(900, 0, 0, 0, 'Wolftower', 21550, 3, 0, 0, 0, 0, 638, 23),
(901, 0, 0, 0, 'Paupers Palace, Flat 11', 315, 1, 0, 0, 0, 0, 12, 1),
(905, 0, 0, 0, 'Botham I a', 950, 9, 0, 0, 0, 0, 36, 1),
(906, 0, 0, 0, 'Esuph I', 680, 9, 0, 0, 0, 0, 39, 1),
(907, 0, 0, 0, 'Esuph II b', 1380, 9, 0, 0, 0, 0, 51, 2),
(1883, 0, 0, 0, 'Aureate Court 1', 5240, 13, 0, 0, 0, 0, 276, 3),
(1884, 0, 0, 0, 'Aureate Court 2', 4860, 13, 0, 0, 0, 0, 201, 2),
(1885, 0, 0, 0, 'Aureate Court 3', 4300, 13, 0, 0, 0, 0, 228, 2),
(1886, 0, 0, 0, 'Aureate Court 4', 3980, 13, 0, 0, 0, 0, 210, 4),
(1887, 0, 0, 0, 'Fortune Wing 1', 10180, 13, 0, 0, 0, 0, 422, 4),
(1888, 0, 0, 0, 'Fortune Wing 2', 5580, 13, 0, 0, 0, 0, 260, 2),
(1889, 0, 0, 0, 'Fortune Wing 3', 5740, 13, 0, 0, 0, 0, 258, 2),
(1890, 0, 0, 0, 'Fortune Wing 4', 5740, 13, 0, 0, 0, 0, 306, 4),
(1891, 0, 0, 0, 'Luminous Arc 1', 6460, 13, 0, 0, 0, 0, 344, 2),
(1892, 0, 0, 0, 'Luminous Arc 2', 6460, 13, 0, 0, 0, 0, 301, 4),
(1893, 0, 0, 0, 'Luminous Arc 3', 5400, 13, 0, 0, 0, 0, 249, 3),
(1894, 0, 0, 0, 'Luminous Arc 4', 8000, 13, 0, 0, 0, 0, 343, 5),
(1895, 0, 0, 0, 'Radiant Plaza 1', 5620, 13, 0, 0, 0, 0, 276, 4),
(1896, 0, 0, 0, 'Radiant Plaza 2', 3820, 13, 0, 0, 0, 0, 179, 2),
(1897, 0, 0, 0, 'Radiant Plaza 3', 4900, 13, 0, 0, 0, 0, 257, 2),
(1898, 0, 0, 0, 'Radiant Plaza 4', 7460, 13, 0, 0, 0, 0, 367, 3),
(1899, 0, 0, 0, 'Sun Palace', 23120, 13, 0, 0, 0, 0, 976, 27),
(1900, 0, 0, 0, 'Halls of Serenity', 23360, 13, 0, 0, 0, 0, 1093, 33),
(1901, 0, 0, 0, 'Cascade Towers', 19500, 13, 0, 0, 0, 0, 811, 33),
(1902, 0, 0, 0, 'Sorcerer\'s Avenue 5', 2695, 2, 0, 0, 0, 0, 96, 1),
(1903, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 1255, 2, 0, 0, 0, 0, 42, 2),
(1904, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 1035, 2, 0, 0, 0, 0, 36, 2),
(1905, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 1255, 2, 0, 0, 0, 0, 36, 2),
(1906, 0, 0, 0, 'Beach Home Apartments, Flat 06', 1145, 2, 0, 0, 0, 0, 40, 2),
(1907, 0, 0, 0, 'Beach Home Apartments, Flat 01', 715, 2, 0, 0, 0, 0, 30, 1),
(1908, 0, 0, 0, 'Beach Home Apartments, Flat 02', 715, 2, 0, 0, 0, 0, 25, 1),
(1909, 0, 0, 0, 'Beach Home Apartments, Flat 03', 715, 2, 0, 0, 0, 0, 30, 1),
(1910, 0, 0, 0, 'Beach Home Apartments, Flat 04', 715, 2, 0, 0, 0, 0, 24, 1),
(1911, 0, 0, 0, 'Beach Home Apartments, Flat 05', 715, 2, 0, 0, 0, 0, 24, 1),
(1912, 0, 0, 0, 'Beach Home Apartments, Flat 16', 1145, 2, 0, 0, 0, 0, 40, 2),
(1913, 0, 0, 0, 'Beach Home Apartments, Flat 11', 715, 2, 0, 0, 0, 0, 30, 1),
(1914, 0, 0, 0, 'Beach Home Apartments, Flat 12', 880, 2, 0, 0, 0, 0, 30, 1),
(1915, 0, 0, 0, 'Beach Home Apartments, Flat 13', 880, 2, 0, 0, 0, 0, 29, 1),
(1916, 0, 0, 0, 'Beach Home Apartments, Flat 14', 385, 2, 0, 0, 0, 0, 15, 1),
(1917, 0, 0, 0, 'Beach Home Apartments, Flat 15', 385, 2, 0, 0, 0, 0, 15, 1),
(1918, 0, 0, 0, 'Thais Clanhall', 8420, 2, 0, 0, 0, 0, 370, 10),
(1919, 0, 0, 0, 'Harbour Street 4', 935, 2, 0, 0, 0, 0, 30, 1),
(1920, 0, 0, 0, 'Thais Hostel', 6980, 2, 0, 0, 0, 0, 171, 24),
(1921, 0, 0, 0, 'Lower Swamp Lane 1', 4740, 2, 0, 0, 0, 0, 166, 4),
(1923, 0, 0, 0, 'Lower Swamp Lane 3', 4740, 2, 0, 0, 0, 0, 161, 4),
(1924, 0, 0, 0, 'Sunset Homes, Flat 01', 520, 2, 0, 0, 0, 0, 25, 1),
(1925, 0, 0, 0, 'Sunset Homes, Flat 02', 520, 2, 0, 0, 0, 0, 30, 1),
(1926, 0, 0, 0, 'Sunset Homes, Flat 03', 520, 2, 0, 0, 0, 0, 30, 1),
(1927, 0, 0, 0, 'Sunset Homes, Flat 14', 520, 2, 0, 0, 0, 0, 30, 1),
(1929, 0, 0, 0, 'Sunset Homes, Flat 13', 860, 2, 0, 0, 0, 0, 35, 2),
(1930, 0, 0, 0, 'Sunset Homes, Flat 12', 520, 2, 0, 0, 0, 0, 25, 1),
(1932, 0, 0, 0, 'Sunset Homes, Flat 11', 520, 2, 0, 0, 0, 0, 25, 1),
(1935, 0, 0, 0, 'Sunset Homes, Flat 24', 520, 2, 0, 0, 0, 0, 30, 1),
(1936, 0, 0, 0, 'Sunset Homes, Flat 23', 860, 2, 0, 0, 0, 0, 35, 2),
(1937, 0, 0, 0, 'Sunset Homes, Flat 22', 520, 2, 0, 0, 0, 0, 25, 1),
(1938, 0, 0, 0, 'Sunset Homes, Flat 21', 520, 2, 0, 0, 0, 0, 25, 1),
(1939, 0, 0, 0, 'Harbour Place 1 (Shop)', 1100, 2, 0, 0, 0, 0, 37, 1),
(1940, 0, 0, 0, 'Harbour Place 2 (Shop)', 1300, 2, 0, 0, 0, 0, 48, 1),
(1941, 0, 0, 0, 'Warriors Guildhall', 14725, 2, 0, 0, 0, 0, 522, 11),
(1942, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 945, 2, 0, 0, 0, 0, 42, 0),
(1943, 0, 0, 0, 'Farm Lane, Basement (Shop)', 945, 2, 0, 0, 0, 0, 36, 0),
(1944, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 1440, 2, 0, 0, 0, 0, 47, 0),
(1945, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 765, 2, 0, 0, 0, 0, 30, 0),
(1946, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 1260, 2, 0, 0, 0, 0, 48, 0),
(1947, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 945, 2, 0, 0, 0, 0, 42, 0),
(1948, 0, 0, 0, 'The City Wall 5a', 585, 2, 0, 0, 0, 0, 24, 1),
(1949, 0, 0, 0, 'The City Wall 5c', 585, 2, 0, 0, 0, 0, 24, 1),
(1950, 0, 0, 0, 'The City Wall 5e', 585, 2, 0, 0, 0, 0, 30, 1),
(1951, 0, 0, 0, 'The City Wall 5b', 585, 2, 0, 0, 0, 0, 24, 1),
(1952, 0, 0, 0, 'The City Wall 5d', 585, 2, 0, 0, 0, 0, 24, 1),
(1953, 0, 0, 0, 'The City Wall 5f', 585, 2, 0, 0, 0, 0, 30, 1),
(1954, 0, 0, 0, 'The City Wall 3a', 1045, 2, 0, 0, 0, 0, 42, 2),
(1955, 0, 0, 0, 'The City Wall 3b', 1045, 2, 0, 0, 0, 0, 35, 2),
(1956, 0, 0, 0, 'The City Wall 3c', 1045, 2, 0, 0, 0, 0, 35, 2),
(1957, 0, 0, 0, 'The City Wall 3d', 1045, 2, 0, 0, 0, 0, 41, 2),
(1958, 0, 0, 0, 'The City Wall 3e', 1045, 2, 0, 0, 0, 0, 30, 2),
(1959, 0, 0, 0, 'The City Wall 3f', 1045, 2, 0, 0, 0, 0, 31, 2),
(1960, 0, 0, 0, 'The City Wall 1a', 1270, 2, 0, 0, 0, 0, 49, 2),
(1961, 0, 0, 0, 'Mill Avenue 3', 1400, 2, 0, 0, 0, 0, 49, 2),
(1962, 0, 0, 0, 'The City Wall 1b', 1270, 2, 0, 0, 0, 0, 49, 2),
(1963, 0, 0, 0, 'Mill Avenue 4', 1400, 2, 0, 0, 0, 0, 49, 2),
(1964, 0, 0, 0, 'Mill Avenue 5', 3250, 2, 0, 0, 0, 0, 128, 4),
(1965, 0, 0, 0, 'Mill Avenue 1 (Shop)', 1300, 2, 0, 0, 0, 0, 54, 1),
(1966, 0, 0, 0, 'Mill Avenue 2 (Shop)', 2350, 2, 0, 0, 0, 0, 80, 2),
(1967, 0, 0, 0, 'The City Wall 7c', 865, 2, 0, 0, 0, 0, 36, 2),
(1968, 0, 0, 0, 'The City Wall 7a', 585, 2, 0, 0, 0, 0, 30, 1),
(1969, 0, 0, 0, 'The City Wall 7e', 865, 2, 0, 0, 0, 0, 36, 2),
(1970, 0, 0, 0, 'The City Wall 7g', 585, 2, 0, 0, 0, 0, 30, 1),
(1971, 0, 0, 0, 'The City Wall 7d', 865, 2, 0, 0, 0, 0, 36, 2),
(1972, 0, 0, 0, 'The City Wall 7b', 585, 2, 0, 0, 0, 0, 30, 1),
(1973, 0, 0, 0, 'The City Wall 7f', 865, 2, 0, 0, 0, 0, 35, 2),
(1974, 0, 0, 0, 'The City Wall 7h', 585, 2, 0, 0, 0, 0, 30, 1),
(1975, 0, 0, 0, 'The City Wall 9', 955, 2, 0, 0, 0, 0, 50, 2),
(1976, 0, 0, 0, 'Upper Swamp Lane 12', 3800, 2, 0, 0, 0, 0, 116, 3),
(1977, 0, 0, 0, 'Upper Swamp Lane 10', 2060, 2, 0, 0, 0, 0, 70, 3),
(1978, 0, 0, 0, 'Upper Swamp Lane 8', 8120, 2, 0, 0, 0, 0, 216, 3),
(1979, 0, 0, 0, 'Southern Thais Guildhall', 22440, 2, 0, 0, 0, 0, 596, 16),
(1980, 0, 0, 0, 'Alai Flats, Flat 04', 765, 2, 0, 0, 0, 0, 30, 1),
(1981, 0, 0, 0, 'Alai Flats, Flat 05', 1225, 2, 0, 0, 0, 0, 38, 2),
(1982, 0, 0, 0, 'Alai Flats, Flat 06', 1225, 2, 0, 0, 0, 0, 48, 2),
(1983, 0, 0, 0, 'Alai Flats, Flat 07', 765, 2, 0, 0, 0, 0, 30, 1),
(1984, 0, 0, 0, 'Alai Flats, Flat 08', 765, 2, 0, 0, 0, 0, 30, 1),
(1985, 0, 0, 0, 'Alai Flats, Flat 03', 765, 2, 0, 0, 0, 0, 36, 1),
(1986, 0, 0, 0, 'Alai Flats, Flat 01', 765, 2, 0, 0, 0, 0, 26, 1),
(1987, 0, 0, 0, 'Alai Flats, Flat 02', 765, 2, 0, 0, 0, 0, 34, 1),
(1988, 0, 0, 0, 'Alai Flats, Flat 14', 900, 2, 0, 0, 0, 0, 33, 1),
(1989, 0, 0, 0, 'Alai Flats, Flat 15', 1450, 2, 0, 0, 0, 0, 48, 2),
(1990, 0, 0, 0, 'Alai Flats, Flat 16', 1450, 2, 0, 0, 0, 0, 54, 2),
(1991, 0, 0, 0, 'Alai Flats, Flat 17', 900, 2, 0, 0, 0, 0, 38, 1),
(1992, 0, 0, 0, 'Alai Flats, Flat 18', 900, 2, 0, 0, 0, 0, 38, 1),
(1993, 0, 0, 0, 'Alai Flats, Flat 13', 765, 2, 0, 0, 0, 0, 36, 1),
(1994, 0, 0, 0, 'Alai Flats, Flat 12', 765, 2, 0, 0, 0, 0, 25, 1),
(1995, 0, 0, 0, 'Alai Flats, Flat 11', 765, 2, 0, 0, 0, 0, 35, 1),
(1996, 0, 0, 0, 'Alai Flats, Flat 24', 900, 2, 0, 0, 0, 0, 36, 1),
(1997, 0, 0, 0, 'Alai Flats, Flat 25', 1450, 2, 0, 0, 0, 0, 52, 2),
(1998, 0, 0, 0, 'Alai Flats, Flat 26', 1450, 2, 0, 0, 0, 0, 60, 2),
(1999, 0, 0, 0, 'Alai Flats, Flat 27', 900, 2, 0, 0, 0, 0, 38, 1),
(2000, 0, 0, 0, 'Alai Flats, Flat 28', 900, 2, 0, 0, 0, 0, 38, 1),
(2001, 0, 0, 0, 'Alai Flats, Flat 23', 765, 2, 0, 0, 0, 0, 35, 1),
(2002, 0, 0, 0, 'Alai Flats, Flat 22', 765, 2, 0, 0, 0, 0, 25, 1),
(2003, 0, 0, 0, 'Alai Flats, Flat 21', 765, 2, 0, 0, 0, 0, 36, 1),
(2004, 0, 0, 0, 'Upper Swamp Lane 4', 4740, 2, 0, 0, 0, 0, 165, 4),
(2005, 0, 0, 0, 'Upper Swamp Lane 2', 4740, 2, 0, 0, 0, 0, 159, 4),
(2006, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 715, 2, 0, 0, 0, 0, 20, 1),
(2007, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 715, 2, 0, 0, 0, 0, 20, 1),
(2008, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 715, 2, 0, 0, 0, 0, 20, 1),
(2009, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 715, 2, 0, 0, 0, 0, 20, 1),
(2010, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 715, 2, 0, 0, 0, 0, 24, 1),
(2011, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 715, 2, 0, 0, 0, 0, 24, 1),
(2012, 0, 0, 0, 'Ivory Circle 1', 4280, 7, 0, 0, 0, 0, 160, 2),
(2013, 0, 0, 0, 'Admiral\'s Avenue 3', 4115, 7, 0, 0, 0, 0, 142, 2),
(2014, 0, 0, 0, 'Admiral\'s Avenue 2', 5470, 7, 0, 0, 0, 0, 176, 4),
(2015, 0, 0, 0, 'Admiral\'s Avenue 1', 5105, 7, 0, 0, 0, 0, 168, 2),
(2016, 0, 0, 0, 'Sugar Street 5', 1350, 7, 0, 0, 0, 0, 48, 2),
(2017, 0, 0, 0, 'Freedom Street 1', 2450, 7, 0, 0, 0, 0, 84, 2),
(2018, 0, 0, 0, 'Freedom Street 2', 6050, 7, 0, 0, 0, 0, 208, 4),
(2019, 0, 0, 0, 'Trader\'s Point 2 (Shop)', 5350, 7, 0, 0, 0, 0, 198, 2),
(2020, 0, 0, 0, 'Trader\'s Point 3 (Shop)', 5950, 7, 0, 0, 0, 0, 195, 2),
(2021, 0, 0, 0, 'Ivory Circle 2', 7030, 7, 0, 0, 0, 0, 214, 2),
(2022, 0, 0, 0, 'The Tavern 1a', 2750, 7, 0, 0, 0, 0, 72, 4),
(2023, 0, 0, 0, 'The Tavern 1b', 1900, 7, 0, 0, 0, 0, 54, 2),
(2024, 0, 0, 0, 'The Tavern 1c', 4150, 7, 0, 0, 0, 0, 132, 3),
(2025, 0, 0, 0, 'The Tavern 1d', 1550, 7, 0, 0, 0, 0, 48, 2),
(2026, 0, 0, 0, 'The Tavern 2d', 1350, 7, 0, 0, 0, 0, 40, 2),
(2027, 0, 0, 0, 'The Tavern 2c', 950, 7, 0, 0, 0, 0, 32, 1),
(2028, 0, 0, 0, 'The Tavern 2b', 1700, 7, 0, 0, 0, 0, 62, 2),
(2029, 0, 0, 0, 'The Tavern 2a', 5550, 7, 0, 0, 0, 0, 163, 5),
(2030, 0, 0, 0, 'Straycat\'s Corner 4', 210, 7, 0, 0, 0, 0, 20, 1),
(2031, 0, 0, 0, 'Straycat\'s Corner 3', 210, 7, 0, 0, 0, 0, 20, 1),
(2032, 0, 0, 0, 'Straycat\'s Corner 2', 660, 7, 0, 0, 0, 0, 49, 1),
(2033, 0, 0, 0, 'Litter Promenade 5', 580, 7, 0, 0, 0, 0, 35, 2),
(2034, 0, 0, 0, 'Litter Promenade 4', 390, 7, 0, 0, 0, 0, 30, 1),
(2035, 0, 0, 0, 'Litter Promenade 3', 450, 7, 0, 0, 0, 0, 36, 1),
(2036, 0, 0, 0, 'Litter Promenade 2', 300, 7, 0, 0, 0, 0, 25, 1),
(2037, 0, 0, 0, 'Litter Promenade 1', 400, 7, 0, 0, 0, 0, 25, 2),
(2038, 0, 0, 0, 'The Shelter', 13590, 7, 0, 0, 0, 0, 560, 31),
(2039, 0, 0, 0, 'Straycat\'s Corner 6', 300, 7, 0, 0, 0, 0, 25, 1),
(2040, 0, 0, 0, 'Straycat\'s Corner 5', 760, 7, 0, 0, 0, 0, 48, 2),
(2042, 0, 0, 0, 'Rum Alley 3', 330, 7, 0, 0, 0, 0, 28, 1),
(2043, 0, 0, 0, 'Straycat\'s Corner 1', 300, 7, 0, 0, 0, 0, 25, 1),
(2044, 0, 0, 0, 'Rum Alley 2', 300, 7, 0, 0, 0, 0, 25, 1),
(2045, 0, 0, 0, 'Rum Alley 1', 510, 7, 0, 0, 0, 0, 36, 1),
(2046, 0, 0, 0, 'Smuggler Backyard 3', 700, 7, 0, 0, 0, 0, 40, 2),
(2048, 0, 0, 0, 'Shady Trail 3', 300, 7, 0, 0, 0, 0, 25, 1),
(2049, 0, 0, 0, 'Shady Trail 1', 1150, 7, 0, 0, 0, 0, 48, 5),
(2050, 0, 0, 0, 'Shady Trail 2', 490, 7, 0, 0, 0, 0, 30, 2),
(2051, 0, 0, 0, 'Smuggler Backyard 5', 610, 7, 0, 0, 0, 0, 35, 2),
(2052, 0, 0, 0, 'Smuggler Backyard 4', 390, 7, 0, 0, 0, 0, 30, 1),
(2053, 0, 0, 0, 'Smuggler Backyard 2', 670, 7, 0, 0, 0, 0, 40, 2),
(2054, 0, 0, 0, 'Smuggler Backyard 1', 670, 7, 0, 0, 0, 0, 40, 2),
(2055, 0, 0, 0, 'Sugar Street 2', 2550, 7, 0, 0, 0, 0, 84, 3),
(2056, 0, 0, 0, 'Sugar Street 1', 3000, 7, 0, 0, 0, 0, 84, 3),
(2057, 0, 0, 0, 'Sugar Street 3a', 1650, 7, 0, 0, 0, 0, 54, 3),
(2058, 0, 0, 0, 'Sugar Street 3b', 2050, 7, 0, 0, 0, 0, 60, 3),
(2059, 0, 0, 0, 'Harvester\'s Haven, Flat 01', 950, 7, 0, 0, 0, 0, 36, 2),
(2060, 0, 0, 0, 'Harvester\'s Haven, Flat 03', 950, 7, 0, 0, 0, 0, 30, 2),
(2061, 0, 0, 0, 'Harvester\'s Haven, Flat 05', 950, 7, 0, 0, 0, 0, 30, 2),
(2062, 0, 0, 0, 'Harvester\'s Haven, Flat 02', 950, 7, 0, 0, 0, 0, 36, 2),
(2063, 0, 0, 0, 'Harvester\'s Haven, Flat 04', 950, 7, 0, 0, 0, 0, 30, 2),
(2064, 0, 0, 0, 'Harvester\'s Haven, Flat 06', 950, 7, 0, 0, 0, 0, 30, 2),
(2065, 0, 0, 0, 'Harvester\'s Haven, Flat 07', 950, 7, 0, 0, 0, 0, 30, 2),
(2066, 0, 0, 0, 'Harvester\'s Haven, Flat 09', 950, 7, 0, 0, 0, 0, 30, 2),
(2067, 0, 0, 0, 'Harvester\'s Haven, Flat 11', 950, 7, 0, 0, 0, 0, 36, 2),
(2068, 0, 0, 0, 'Harvester\'s Haven, Flat 12', 950, 7, 0, 0, 0, 0, 36, 2),
(2069, 0, 0, 0, 'Harvester\'s Haven, Flat 10', 950, 7, 0, 0, 0, 0, 30, 2),
(2070, 0, 0, 0, 'Harvester\'s Haven, Flat 08', 950, 7, 0, 0, 0, 0, 30, 2),
(2071, 0, 0, 0, 'Marble Lane 4', 6350, 7, 0, 0, 0, 0, 192, 4),
(2072, 0, 0, 0, 'Marble Lane 2', 6415, 7, 0, 0, 0, 0, 200, 3),
(2073, 0, 0, 0, 'Marble Lane 3', 8055, 7, 0, 0, 0, 0, 240, 4),
(2074, 0, 0, 0, 'Marble Lane 1', 11060, 7, 0, 0, 0, 0, 320, 6),
(2075, 0, 0, 0, 'Ivy Cottage', 30650, 7, 0, 0, 0, 0, 858, 26),
(2076, 0, 0, 0, 'Sugar Street 4d', 750, 7, 0, 0, 0, 0, 24, 2),
(2077, 0, 0, 0, 'Sugar Street 4c', 650, 7, 0, 0, 0, 0, 24, 1),
(2078, 0, 0, 0, 'Sugar Street 4b', 950, 7, 0, 0, 0, 0, 36, 2),
(2079, 0, 0, 0, 'Sugar Street 4a', 950, 7, 0, 0, 0, 0, 30, 2),
(2080, 0, 0, 0, 'Trader\'s Point 1', 2200, 7, 0, 0, 0, 0, 77, 2),
(2081, 0, 0, 0, 'Mountain Hideout', 15550, 7, 0, 0, 0, 0, 486, 17),
(2082, 0, 0, 0, 'Dark Mansion', 17845, 2, 0, 0, 0, 0, 573, 17),
(2083, 0, 0, 0, 'Halls of the Adventurers', 15380, 2, 0, 0, 0, 0, 518, 18),
(2084, 0, 0, 0, 'Castle of Greenshore', 18860, 2, 0, 0, 0, 0, 600, 12),
(2085, 0, 0, 0, 'Greenshore Clanhall', 10800, 2, 0, 0, 0, 0, 312, 10),
(2086, 0, 0, 0, 'Greenshore Village 1', 2420, 2, 0, 0, 0, 0, 64, 3),
(2087, 0, 0, 0, 'Greenshore Village, Shop', 1800, 2, 0, 0, 0, 0, 56, 1),
(2088, 0, 0, 0, 'Greenshore Village, Villa', 8700, 2, 0, 0, 0, 0, 263, 4),
(2089, 0, 0, 0, 'Greenshore Village 2', 780, 2, 0, 0, 0, 0, 30, 1),
(2090, 0, 0, 0, 'Greenshore Village 3', 780, 2, 0, 0, 0, 0, 25, 1),
(2091, 0, 0, 0, 'Greenshore Village 5', 780, 2, 0, 0, 0, 0, 30, 1),
(2092, 0, 0, 0, 'Greenshore Village 4', 780, 2, 0, 0, 0, 0, 25, 1),
(2093, 0, 0, 0, 'Greenshore Village 6', 4360, 2, 0, 0, 0, 0, 118, 2),
(2094, 0, 0, 0, 'Greenshore Village 7', 1260, 2, 0, 0, 0, 0, 42, 1),
(2095, 0, 0, 0, 'The Tibianic', 34500, 2, 0, 0, 0, 0, 862, 22),
(2097, 0, 0, 0, 'Fibula Village 5', 1790, 2, 0, 0, 0, 0, 42, 2),
(2098, 0, 0, 0, 'Fibula Village 4', 1790, 2, 0, 0, 0, 0, 42, 2),
(2099, 0, 0, 0, 'Fibula Village, Tower Flat', 5105, 2, 0, 0, 0, 0, 161, 2),
(2100, 0, 0, 0, 'Fibula Village 1', 845, 2, 0, 0, 0, 0, 30, 1),
(2101, 0, 0, 0, 'Fibula Village 2', 845, 2, 0, 0, 0, 0, 30, 1),
(2102, 0, 0, 0, 'Fibula Village 3', 3810, 2, 0, 0, 0, 0, 110, 4),
(2103, 0, 0, 0, 'Mercenary Tower', 41955, 2, 0, 0, 0, 0, 996, 26),
(2104, 0, 0, 0, 'Guildhall of the Red Rose', 27725, 2, 0, 0, 0, 0, 571, 15),
(2105, 0, 0, 0, 'Fibula Village, Bar', 5235, 2, 0, 0, 0, 0, 122, 2),
(2106, 0, 0, 0, 'Fibula Village, Villa', 11490, 2, 0, 0, 0, 0, 402, 5),
(2107, 0, 0, 0, 'Fibula Clanhall', 11430, 2, 0, 0, 0, 0, 290, 10),
(2108, 0, 0, 0, 'Spiritkeep', 19210, 2, 0, 0, 0, 0, 783, 23),
(2109, 0, 0, 0, 'Snake Tower', 29720, 2, 0, 0, 0, 0, 1064, 21),
(2110, 0, 0, 0, 'Bloodhall', 15270, 2, 0, 0, 0, 0, 569, 15),
(2111, 0, 0, 0, 'Senja Clanhall', 10575, 4, 0, 0, 0, 0, 396, 9),
(2112, 0, 0, 0, 'Senja Village 2', 765, 4, 0, 0, 0, 0, 36, 1),
(2113, 0, 0, 0, 'Senja Village 1a', 765, 4, 0, 0, 0, 0, 36, 1),
(2114, 0, 0, 0, 'Senja Village 1b', 1630, 4, 0, 0, 0, 0, 66, 2),
(2115, 0, 0, 0, 'Senja Village 4', 765, 4, 0, 0, 0, 0, 30, 1),
(2116, 0, 0, 0, 'Senja Village 3', 1765, 4, 0, 0, 0, 0, 72, 2),
(2117, 0, 0, 0, 'Senja Village 6b', 765, 4, 0, 0, 0, 0, 30, 1),
(2118, 0, 0, 0, 'Senja Village 6a', 765, 4, 0, 0, 0, 0, 30, 1),
(2119, 0, 0, 0, 'Senja Village 5', 1225, 4, 0, 0, 0, 0, 48, 2),
(2120, 0, 0, 0, 'Senja Village 10', 1485, 4, 0, 0, 0, 0, 72, 1),
(2121, 0, 0, 0, 'Senja Village 11', 2620, 4, 0, 0, 0, 0, 96, 2),
(2122, 0, 0, 0, 'Senja Village 9', 2575, 4, 0, 0, 0, 0, 103, 2),
(2123, 0, 0, 0, 'Senja Village 8', 1675, 4, 0, 0, 0, 0, 57, 2),
(2124, 0, 0, 0, 'Senja Village 7', 865, 4, 0, 0, 0, 0, 37, 2),
(2125, 0, 0, 0, 'Rosebud C', 1340, 4, 0, 0, 0, 0, 70, 0),
(2127, 0, 0, 0, 'Rosebud A', 1000, 4, 0, 0, 0, 0, 60, 1),
(2128, 0, 0, 0, 'Rosebud B', 1000, 4, 0, 0, 0, 0, 60, 1),
(2129, 0, 0, 0, 'Nordic Stronghold', 18400, 4, 0, 0, 0, 0, 718, 21),
(2130, 0, 0, 0, 'Northport Village 2', 1475, 4, 0, 0, 0, 0, 40, 2),
(2131, 0, 0, 0, 'Northport Village 1', 1475, 4, 0, 0, 0, 0, 48, 2),
(2132, 0, 0, 0, 'Northport Village 3', 5435, 4, 0, 0, 0, 0, 178, 2),
(2133, 0, 0, 0, 'Northport Village 4', 2630, 4, 0, 0, 0, 0, 81, 2),
(2134, 0, 0, 0, 'Northport Village 5', 1805, 4, 0, 0, 0, 0, 56, 2),
(2135, 0, 0, 0, 'Northport Village 6', 2135, 4, 0, 0, 0, 0, 64, 2),
(2136, 0, 0, 0, 'Seawatch', 25010, 4, 0, 0, 0, 0, 749, 19),
(2137, 0, 0, 0, 'Northport Clanhall', 9810, 4, 0, 0, 0, 0, 292, 10),
(2138, 0, 0, 0, 'Druids Retreat D', 1180, 4, 0, 0, 0, 0, 54, 2),
(2139, 0, 0, 0, 'Druids Retreat A', 1340, 4, 0, 0, 0, 0, 60, 2),
(2140, 0, 0, 0, 'Druids Retreat C', 980, 4, 0, 0, 0, 0, 45, 2),
(2141, 0, 0, 0, 'Druids Retreat B', 980, 4, 0, 0, 0, 0, 55, 2),
(2142, 0, 0, 0, 'Theater Avenue 14 (Shop)', 2115, 4, 0, 0, 0, 0, 83, 1),
(2143, 0, 0, 0, 'Theater Avenue 12', 955, 4, 0, 0, 0, 0, 28, 2),
(2144, 0, 0, 0, 'Theater Avenue 10', 1090, 4, 0, 0, 0, 0, 45, 2),
(2145, 0, 0, 0, 'Theater Avenue 11c', 585, 4, 0, 0, 0, 0, 24, 1),
(2146, 0, 0, 0, 'Theater Avenue 11b', 585, 4, 0, 0, 0, 0, 24, 1),
(2147, 0, 0, 0, 'Theater Avenue 11a', 1405, 4, 0, 0, 0, 0, 54, 2),
(2148, 0, 0, 0, 'Magician\'s Alley 1', 1050, 4, 0, 0, 0, 0, 35, 2),
(2149, 0, 0, 0, 'Magician\'s Alley 1a', 700, 4, 0, 0, 0, 0, 29, 2),
(2150, 0, 0, 0, 'Magician\'s Alley 1d', 450, 4, 0, 0, 0, 0, 24, 1),
(2151, 0, 0, 0, 'Magician\'s Alley 1b', 750, 4, 0, 0, 0, 0, 24, 2),
(2152, 0, 0, 0, 'Magician\'s Alley 1c', 500, 4, 0, 0, 0, 0, 20, 1),
(2153, 0, 0, 0, 'Magician\'s Alley 5a', 350, 4, 0, 0, 0, 0, 14, 1),
(2154, 0, 0, 0, 'Magician\'s Alley 5b', 500, 4, 0, 0, 0, 0, 25, 1),
(2155, 0, 0, 0, 'Magician\'s Alley 5d', 500, 4, 0, 0, 0, 0, 20, 1),
(2156, 0, 0, 0, 'Magician\'s Alley 5e', 500, 4, 0, 0, 0, 0, 25, 1),
(2157, 0, 0, 0, 'Magician\'s Alley 5c', 1150, 4, 0, 0, 0, 0, 35, 2),
(2158, 0, 0, 0, 'Magician\'s Alley 5f', 1150, 4, 0, 0, 0, 0, 42, 2),
(2159, 0, 0, 0, 'Carlin Clanhall', 10750, 4, 0, 0, 0, 0, 364, 10),
(2160, 0, 0, 0, 'Magician\'s Alley 4', 2750, 4, 0, 0, 0, 0, 96, 4),
(2161, 0, 0, 0, 'Lonely Sea Side Hostel', 10540, 4, 0, 0, 0, 0, 454, 8),
(2162, 0, 0, 0, 'Suntower', 10080, 4, 0, 0, 0, 0, 450, 7),
(2163, 0, 0, 0, 'Harbour Lane 3', 3560, 4, 0, 0, 0, 0, 145, 3),
(2164, 0, 0, 0, 'Harbour Flats, Flat 11', 520, 4, 0, 0, 0, 0, 24, 1),
(2165, 0, 0, 0, 'Harbour Flats, Flat 13', 520, 4, 0, 0, 0, 0, 24, 1),
(2166, 0, 0, 0, 'Harbour Flats, Flat 15', 360, 4, 0, 0, 0, 0, 18, 1),
(2167, 0, 0, 0, 'Harbour Flats, Flat 17', 360, 4, 0, 0, 0, 0, 24, 1),
(2168, 0, 0, 0, 'Harbour Flats, Flat 12', 400, 4, 0, 0, 0, 0, 20, 1),
(2169, 0, 0, 0, 'Harbour Flats, Flat 14', 400, 4, 0, 0, 0, 0, 20, 1),
(2170, 0, 0, 0, 'Harbour Flats, Flat 16', 400, 4, 0, 0, 0, 0, 20, 1),
(2171, 0, 0, 0, 'Harbour Flats, Flat 18', 400, 4, 0, 0, 0, 0, 25, 1),
(2172, 0, 0, 0, 'Harbour Flats, Flat 21', 860, 4, 0, 0, 0, 0, 35, 2),
(2173, 0, 0, 0, 'Harbour Flats, Flat 22', 980, 4, 0, 0, 0, 0, 45, 2),
(2174, 0, 0, 0, 'Harbour Flats, Flat 23', 400, 4, 0, 0, 0, 0, 25, 1),
(2175, 0, 0, 0, 'Harbour Lane 2a (Shop)', 680, 4, 0, 0, 0, 0, 32, 0),
(2176, 0, 0, 0, 'Harbour Lane 2b (Shop)', 680, 4, 0, 0, 0, 0, 40, 0),
(2177, 0, 0, 0, 'Harbour Lane 1 (Shop)', 1040, 4, 0, 0, 0, 0, 54, 0),
(2178, 0, 0, 0, 'Theater Avenue 6e', 820, 4, 0, 0, 0, 0, 31, 2),
(2179, 0, 0, 0, 'Theater Avenue 6c', 225, 4, 0, 0, 0, 0, 12, 1),
(2180, 0, 0, 0, 'Theater Avenue 6a', 820, 4, 0, 0, 0, 0, 35, 2),
(2181, 0, 0, 0, 'Theater Avenue 6f', 820, 4, 0, 0, 0, 0, 31, 2),
(2182, 0, 0, 0, 'Theater Avenue 6d', 225, 4, 0, 0, 0, 0, 12, 1),
(2183, 0, 0, 0, 'Theater Avenue 6b', 820, 4, 0, 0, 0, 0, 35, 2),
(2184, 0, 0, 0, 'East Lane 1a', 2260, 4, 0, 0, 0, 0, 95, 2),
(2185, 0, 0, 0, 'East Lane 1b', 1700, 4, 0, 0, 0, 0, 83, 2),
(2186, 0, 0, 0, 'East Lane 2', 3900, 4, 0, 0, 0, 0, 172, 2),
(2191, 0, 0, 0, 'Northern Street 5', 1980, 4, 0, 0, 0, 0, 94, 2),
(2192, 0, 0, 0, 'Northern Street 7', 1700, 4, 0, 0, 0, 0, 83, 2),
(2193, 0, 0, 0, 'Northern Street 3a', 740, 4, 0, 0, 0, 0, 31, 2),
(2194, 0, 0, 0, 'Northern Street 3b', 780, 4, 0, 0, 0, 0, 36, 2),
(2195, 0, 0, 0, 'Northern Street 1c', 740, 4, 0, 0, 0, 0, 31, 2),
(2196, 0, 0, 0, 'Northern Street 1b', 740, 4, 0, 0, 0, 0, 37, 2),
(2197, 0, 0, 0, 'Northern Street 1a', 940, 4, 0, 0, 0, 0, 41, 2),
(2198, 0, 0, 0, 'Theater Avenue 7, Flat 06', 315, 4, 0, 0, 0, 0, 20, 1),
(2199, 0, 0, 0, 'Theater Avenue 7, Flat 01', 315, 4, 0, 0, 0, 0, 15, 1),
(2200, 0, 0, 0, 'Theater Avenue 7, Flat 05', 405, 4, 0, 0, 0, 0, 20, 1),
(2201, 0, 0, 0, 'Theater Avenue 7, Flat 02', 405, 4, 0, 0, 0, 0, 20, 1),
(2202, 0, 0, 0, 'Theater Avenue 7, Flat 04', 495, 4, 0, 0, 0, 0, 20, 1),
(2203, 0, 0, 0, 'Theater Avenue 7, Flat 03', 405, 4, 0, 0, 0, 0, 19, 1),
(2204, 0, 0, 0, 'Theater Avenue 7, Flat 14', 495, 4, 0, 0, 0, 0, 20, 1),
(2205, 0, 0, 0, 'Theater Avenue 7, Flat 13', 405, 4, 0, 0, 0, 0, 17, 1),
(2206, 0, 0, 0, 'Theater Avenue 7, Flat 15', 405, 4, 0, 0, 0, 0, 19, 1),
(2207, 0, 0, 0, 'Theater Avenue 7, Flat 16', 405, 4, 0, 0, 0, 0, 20, 1),
(2208, 0, 0, 0, 'Theater Avenue 7, Flat 11', 495, 4, 0, 0, 0, 0, 23, 1),
(2209, 0, 0, 0, 'Theater Avenue 7, Flat 12', 405, 4, 0, 0, 0, 0, 15, 1),
(2210, 0, 0, 0, 'Theater Avenue 8a', 1270, 4, 0, 0, 0, 0, 50, 2),
(2211, 0, 0, 0, 'Theater Avenue 8b', 1370, 4, 0, 0, 0, 0, 49, 3),
(2212, 0, 0, 0, 'Central Plaza 3', 600, 4, 0, 0, 0, 0, 20, 0),
(2213, 0, 0, 0, 'Central Plaza 2', 600, 4, 0, 0, 0, 0, 20, 0),
(2214, 0, 0, 0, 'Central Plaza 1', 600, 4, 0, 0, 0, 0, 20, 0),
(2215, 0, 0, 0, 'Park Lane 1a', 1220, 4, 0, 0, 0, 0, 53, 2),
(2216, 0, 0, 0, 'Park Lane 3a', 1220, 4, 0, 0, 0, 0, 48, 2),
(2217, 0, 0, 0, 'Park Lane 1b', 1380, 4, 0, 0, 0, 0, 64, 2),
(2218, 0, 0, 0, 'Park Lane 3b', 1100, 4, 0, 0, 0, 0, 48, 2),
(2219, 0, 0, 0, 'Park Lane 4', 980, 4, 0, 0, 0, 0, 42, 2),
(2220, 0, 0, 0, 'Park Lane 2', 980, 4, 0, 0, 0, 0, 42, 2),
(2221, 0, 0, 0, 'Magician\'s Alley 8', 1400, 4, 0, 0, 0, 0, 42, 2),
(2222, 0, 0, 0, 'Moonkeep', 13020, 4, 0, 0, 0, 0, 522, 16),
(2225, 0, 0, 0, 'Castle, Basement, Flat 01', 585, 11, 0, 0, 0, 0, 30, 1),
(2226, 0, 0, 0, 'Castle, Basement, Flat 02', 585, 11, 0, 0, 0, 0, 20, 1),
(2227, 0, 0, 0, 'Castle, Basement, Flat 03', 585, 11, 0, 0, 0, 0, 20, 1),
(2228, 0, 0, 0, 'Castle, Basement, Flat 04', 585, 11, 0, 0, 0, 0, 20, 1);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(2229, 0, 0, 0, 'Castle, Basement, Flat 07', 585, 11, 0, 0, 0, 0, 20, 1),
(2230, 0, 0, 0, 'Castle, Basement, Flat 08', 585, 11, 0, 0, 0, 0, 20, 1),
(2231, 0, 0, 0, 'Castle, Basement, Flat 09', 585, 11, 0, 0, 0, 0, 24, 1),
(2232, 0, 0, 0, 'Castle, Basement, Flat 06', 585, 11, 0, 0, 0, 0, 24, 1),
(2233, 0, 0, 0, 'Castle, Basement, Flat 05', 585, 11, 0, 0, 0, 0, 24, 1),
(2234, 0, 0, 0, 'Castle Shop 1', 1890, 11, 0, 0, 0, 0, 67, 1),
(2235, 0, 0, 0, 'Castle Shop 2', 1890, 11, 0, 0, 0, 0, 70, 1),
(2236, 0, 0, 0, 'Castle Shop 3', 1890, 11, 0, 0, 0, 0, 67, 1),
(2237, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 720, 11, 0, 0, 0, 0, 28, 1),
(2238, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 945, 11, 0, 0, 0, 0, 42, 1),
(2239, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 945, 11, 0, 0, 0, 0, 36, 1),
(2240, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 720, 11, 0, 0, 0, 0, 30, 1),
(2241, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 765, 11, 0, 0, 0, 0, 30, 1),
(2242, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 585, 11, 0, 0, 0, 0, 25, 1),
(2243, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 585, 11, 0, 0, 0, 0, 30, 1),
(2244, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 765, 11, 0, 0, 0, 0, 30, 1),
(2245, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 585, 11, 0, 0, 0, 0, 30, 1),
(2246, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 585, 11, 0, 0, 0, 0, 30, 1),
(2247, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 765, 11, 0, 0, 0, 0, 30, 1),
(2248, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 585, 11, 0, 0, 0, 0, 25, 1),
(2249, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 765, 11, 0, 0, 0, 0, 30, 1),
(2250, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 585, 11, 0, 0, 0, 0, 25, 1),
(2251, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 1045, 11, 0, 0, 0, 0, 36, 2),
(2252, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 720, 11, 0, 0, 0, 0, 30, 1),
(2253, 0, 0, 0, 'Castle Street 1', 2900, 11, 0, 0, 0, 0, 112, 3),
(2254, 0, 0, 0, 'Castle Street 2', 1495, 11, 0, 0, 0, 0, 56, 2),
(2255, 0, 0, 0, 'Castle Street 3', 1765, 11, 0, 0, 0, 0, 56, 2),
(2256, 0, 0, 0, 'Castle Street 4', 1765, 11, 0, 0, 0, 0, 64, 2),
(2257, 0, 0, 0, 'Castle Street 5', 1765, 11, 0, 0, 0, 0, 61, 2),
(2258, 0, 0, 0, 'Edron Flats, Basement Flat 2', 1540, 11, 0, 0, 0, 0, 48, 2),
(2259, 0, 0, 0, 'Edron Flats, Basement Flat 1', 1540, 11, 0, 0, 0, 0, 48, 2),
(2260, 0, 0, 0, 'Edron Flats, Flat 01', 400, 11, 0, 0, 0, 0, 20, 1),
(2261, 0, 0, 0, 'Edron Flats, Flat 02', 860, 11, 0, 0, 0, 0, 28, 2),
(2262, 0, 0, 0, 'Edron Flats, Flat 03', 400, 11, 0, 0, 0, 0, 20, 1),
(2263, 0, 0, 0, 'Edron Flats, Flat 04', 400, 11, 0, 0, 0, 0, 20, 1),
(2264, 0, 0, 0, 'Edron Flats, Flat 06', 400, 11, 0, 0, 0, 0, 20, 1),
(2265, 0, 0, 0, 'Edron Flats, Flat 05', 400, 11, 0, 0, 0, 0, 20, 1),
(2266, 0, 0, 0, 'Edron Flats, Flat 07', 400, 11, 0, 0, 0, 0, 20, 1),
(2267, 0, 0, 0, 'Edron Flats, Flat 08', 400, 11, 0, 0, 0, 0, 20, 1),
(2268, 0, 0, 0, 'Edron Flats, Flat 11', 400, 11, 0, 0, 0, 0, 25, 1),
(2269, 0, 0, 0, 'Edron Flats, Flat 12', 400, 11, 0, 0, 0, 0, 25, 1),
(2270, 0, 0, 0, 'Edron Flats, Flat 14', 400, 11, 0, 0, 0, 0, 25, 1),
(2271, 0, 0, 0, 'Edron Flats, Flat 13', 400, 11, 0, 0, 0, 0, 25, 1),
(2272, 0, 0, 0, 'Edron Flats, Flat 16', 400, 11, 0, 0, 0, 0, 20, 1),
(2273, 0, 0, 0, 'Edron Flats, Flat 15', 400, 11, 0, 0, 0, 0, 20, 1),
(2274, 0, 0, 0, 'Edron Flats, Flat 18', 400, 11, 0, 0, 0, 0, 20, 1),
(2275, 0, 0, 0, 'Edron Flats, Flat 17', 400, 11, 0, 0, 0, 0, 20, 1),
(2276, 0, 0, 0, 'Edron Flats, Flat 22', 400, 11, 0, 0, 0, 0, 25, 1),
(2277, 0, 0, 0, 'Edron Flats, Flat 21', 860, 11, 0, 0, 0, 0, 40, 2),
(2278, 0, 0, 0, 'Edron Flats, Flat 24', 400, 11, 0, 0, 0, 0, 20, 1),
(2279, 0, 0, 0, 'Edron Flats, Flat 23', 400, 11, 0, 0, 0, 0, 25, 1),
(2280, 0, 0, 0, 'Edron Flats, Flat 26', 400, 11, 0, 0, 0, 0, 20, 1),
(2281, 0, 0, 0, 'Edron Flats, Flat 27', 400, 11, 0, 0, 0, 0, 20, 1),
(2282, 0, 0, 0, 'Edron Flats, Flat 28', 400, 11, 0, 0, 0, 0, 20, 1),
(2283, 0, 0, 0, 'Edron Flats, Flat 25', 400, 11, 0, 0, 0, 0, 20, 1),
(2284, 0, 0, 0, 'Central Circle 1', 3020, 11, 0, 0, 0, 0, 119, 2),
(2285, 0, 0, 0, 'Central Circle 2', 3300, 11, 0, 0, 0, 0, 109, 2),
(2286, 0, 0, 0, 'Central Circle 3', 4160, 11, 0, 0, 0, 0, 147, 5),
(2287, 0, 0, 0, 'Central Circle 4', 4160, 11, 0, 0, 0, 0, 147, 5),
(2288, 0, 0, 0, 'Central Circle 5', 4160, 11, 0, 0, 0, 0, 161, 5),
(2289, 0, 0, 0, 'Central Circle 6 (Shop)', 3980, 11, 0, 0, 0, 0, 182, 2),
(2290, 0, 0, 0, 'Central Circle 7 (Shop)', 3980, 11, 0, 0, 0, 0, 161, 2),
(2291, 0, 0, 0, 'Central Circle 8 (Shop)', 3980, 11, 0, 0, 0, 0, 166, 2),
(2292, 0, 0, 0, 'Central Circle 9a', 940, 11, 0, 0, 0, 0, 42, 2),
(2293, 0, 0, 0, 'Central Circle 9b', 940, 11, 0, 0, 0, 0, 44, 2),
(2294, 0, 0, 0, 'Sky Lane, Guild 1', 21145, 11, 0, 0, 0, 0, 666, 23),
(2295, 0, 0, 0, 'Sky Lane, Guild 2', 19300, 11, 0, 0, 0, 0, 650, 14),
(2296, 0, 0, 0, 'Sky Lane, Guild 3', 17315, 11, 0, 0, 0, 0, 564, 18),
(2297, 0, 0, 0, 'Sky Lane, Sea Tower', 4775, 11, 0, 0, 0, 0, 196, 6),
(2298, 0, 0, 0, 'Wood Avenue 6a', 1450, 11, 0, 0, 0, 0, 56, 2),
(2299, 0, 0, 0, 'Wood Avenue 9a', 1540, 11, 0, 0, 0, 0, 56, 2),
(2300, 0, 0, 0, 'Wood Avenue 10a', 1540, 11, 0, 0, 0, 0, 64, 2),
(2301, 0, 0, 0, 'Wood Avenue 11', 7205, 11, 0, 0, 0, 0, 253, 6),
(2302, 0, 0, 0, 'Wood Avenue 8', 5960, 11, 0, 0, 0, 0, 198, 3),
(2303, 0, 0, 0, 'Wood Avenue 7', 5960, 11, 0, 0, 0, 0, 191, 3),
(2304, 0, 0, 0, 'Wood Avenue 6b', 1450, 11, 0, 0, 0, 0, 56, 2),
(2305, 0, 0, 0, 'Wood Avenue 9b', 1495, 11, 0, 0, 0, 0, 56, 2),
(2306, 0, 0, 0, 'Wood Avenue 10b', 1595, 11, 0, 0, 0, 0, 64, 3),
(2307, 0, 0, 0, 'Wood Avenue 5', 1765, 11, 0, 0, 0, 0, 64, 2),
(2308, 0, 0, 0, 'Wood Avenue 4a', 1495, 11, 0, 0, 0, 0, 56, 2),
(2309, 0, 0, 0, 'Wood Avenue 4b', 1495, 11, 0, 0, 0, 0, 56, 2),
(2310, 0, 0, 0, 'Wood Avenue 4c', 1765, 11, 0, 0, 0, 0, 56, 2),
(2311, 0, 0, 0, 'Wood Avenue 4', 1765, 11, 0, 0, 0, 0, 64, 2),
(2312, 0, 0, 0, 'Wood Avenue 3', 1765, 11, 0, 0, 0, 0, 56, 2),
(2313, 0, 0, 0, 'Wood Avenue 2', 1765, 11, 0, 0, 0, 0, 49, 2),
(2314, 0, 0, 0, 'Wood Avenue 1', 1765, 11, 0, 0, 0, 0, 64, 2),
(2315, 0, 0, 0, 'Magic Academy, Guild', 12025, 11, 0, 0, 0, 0, 414, 14),
(2316, 0, 0, 0, 'Magic Academy, Flat 1', 1465, 11, 0, 0, 0, 0, 57, 3),
(2317, 0, 0, 0, 'Magic Academy, Flat 2', 1530, 11, 0, 0, 0, 0, 55, 2),
(2318, 0, 0, 0, 'Magic Academy, Flat 3', 1430, 11, 0, 0, 0, 0, 55, 1),
(2319, 0, 0, 0, 'Magic Academy, Flat 4', 1530, 11, 0, 0, 0, 0, 55, 2),
(2320, 0, 0, 0, 'Magic Academy, Flat 5', 1430, 11, 0, 0, 0, 0, 55, 1),
(2321, 0, 0, 0, 'Magic Academy, Shop', 1595, 11, 0, 0, 0, 0, 48, 1),
(2322, 0, 0, 0, 'Stonehome Village 1', 1780, 11, 0, 0, 0, 0, 74, 2),
(2323, 0, 0, 0, 'Stonehome Flats, Flat 05', 400, 11, 0, 0, 0, 0, 20, 1),
(2324, 0, 0, 0, 'Stonehome Flats, Flat 04', 400, 11, 0, 0, 0, 0, 25, 1),
(2325, 0, 0, 0, 'Stonehome Flats, Flat 06', 400, 11, 0, 0, 0, 0, 20, 1),
(2326, 0, 0, 0, 'Stonehome Flats, Flat 03', 400, 11, 0, 0, 0, 0, 20, 1),
(2327, 0, 0, 0, 'Stonehome Flats, Flat 01', 400, 11, 0, 0, 0, 0, 20, 1),
(2328, 0, 0, 0, 'Stonehome Flats, Flat 02', 740, 11, 0, 0, 0, 0, 30, 2),
(2329, 0, 0, 0, 'Stonehome Flats, Flat 11', 740, 11, 0, 0, 0, 0, 35, 2),
(2330, 0, 0, 0, 'Stonehome Flats, Flat 12', 740, 11, 0, 0, 0, 0, 35, 2),
(2331, 0, 0, 0, 'Stonehome Flats, Flat 13', 400, 11, 0, 0, 0, 0, 20, 1),
(2332, 0, 0, 0, 'Stonehome Flats, Flat 14', 400, 11, 0, 0, 0, 0, 20, 1),
(2333, 0, 0, 0, 'Stonehome Flats, Flat 16', 400, 11, 0, 0, 0, 0, 20, 1),
(2334, 0, 0, 0, 'Stonehome Flats, Flat 15', 400, 11, 0, 0, 0, 0, 20, 1),
(2335, 0, 0, 0, 'Stonehome Village 2', 640, 11, 0, 0, 0, 0, 35, 1),
(2336, 0, 0, 0, 'Stonehome Village 3', 680, 11, 0, 0, 0, 0, 36, 1),
(2337, 0, 0, 0, 'Stonehome Village 4', 940, 11, 0, 0, 0, 0, 42, 2),
(2338, 0, 0, 0, 'Stonehome Village 6', 1300, 11, 0, 0, 0, 0, 55, 2),
(2339, 0, 0, 0, 'Stonehome Village 5', 1140, 11, 0, 0, 0, 0, 56, 2),
(2340, 0, 0, 0, 'Stonehome Village 7', 1140, 11, 0, 0, 0, 0, 49, 2),
(2341, 0, 0, 0, 'Stonehome Village 8', 680, 11, 0, 0, 0, 0, 36, 1),
(2342, 0, 0, 0, 'Stonehome Village 9', 680, 11, 0, 0, 0, 0, 36, 1),
(2343, 0, 0, 0, 'Stonehome Clanhall', 8580, 11, 0, 0, 0, 0, 345, 9),
(2344, 0, 0, 0, 'Cormaya 1', 1270, 11, 0, 0, 0, 0, 49, 2),
(2345, 0, 0, 0, 'Cormaya 2', 3710, 11, 0, 0, 0, 0, 145, 3),
(2346, 0, 0, 0, 'Cormaya Flats, Flat 01', 450, 11, 0, 0, 0, 0, 20, 1),
(2347, 0, 0, 0, 'Cormaya Flats, Flat 02', 450, 11, 0, 0, 0, 0, 20, 1),
(2348, 0, 0, 0, 'Cormaya Flats, Flat 03', 820, 11, 0, 0, 0, 0, 30, 2),
(2349, 0, 0, 0, 'Cormaya Flats, Flat 06', 450, 11, 0, 0, 0, 0, 20, 1),
(2350, 0, 0, 0, 'Cormaya Flats, Flat 05', 450, 11, 0, 0, 0, 0, 20, 1),
(2351, 0, 0, 0, 'Cormaya Flats, Flat 04', 820, 11, 0, 0, 0, 0, 30, 2),
(2352, 0, 0, 0, 'Cormaya Flats, Flat 13', 820, 11, 0, 0, 0, 0, 30, 2),
(2353, 0, 0, 0, 'Cormaya Flats, Flat 14', 820, 11, 0, 0, 0, 0, 35, 2),
(2354, 0, 0, 0, 'Cormaya Flats, Flat 15', 450, 11, 0, 0, 0, 0, 20, 1),
(2355, 0, 0, 0, 'Cormaya Flats, Flat 16', 450, 11, 0, 0, 0, 0, 20, 1),
(2356, 0, 0, 0, 'Cormaya Flats, Flat 11', 450, 11, 0, 0, 0, 0, 20, 1),
(2357, 0, 0, 0, 'Cormaya Flats, Flat 12', 450, 11, 0, 0, 0, 0, 20, 1),
(2358, 0, 0, 0, 'Cormaya 3', 2035, 11, 0, 0, 0, 0, 72, 2),
(2359, 0, 0, 0, 'Castle of the White Dragon', 25110, 11, 0, 0, 0, 0, 761, 19),
(2360, 0, 0, 0, 'Cormaya 4', 1720, 11, 0, 0, 0, 0, 63, 2),
(2361, 0, 0, 0, 'Cormaya 5', 4250, 11, 0, 0, 0, 0, 167, 3),
(2362, 0, 0, 0, 'Cormaya 6', 2395, 11, 0, 0, 0, 0, 84, 2),
(2363, 0, 0, 0, 'Cormaya 7', 2395, 11, 0, 0, 0, 0, 84, 2),
(2364, 0, 0, 0, 'Cormaya 8', 2710, 11, 0, 0, 0, 0, 113, 2),
(2365, 0, 0, 0, 'Cormaya 9b', 2620, 11, 0, 0, 0, 0, 88, 2),
(2366, 0, 0, 0, 'Cormaya 9a', 1225, 11, 0, 0, 0, 0, 48, 2),
(2367, 0, 0, 0, 'Cormaya 9c', 1225, 11, 0, 0, 0, 0, 48, 2),
(2368, 0, 0, 0, 'Cormaya 9d', 2620, 11, 0, 0, 0, 0, 88, 2),
(2369, 0, 0, 0, 'Cormaya 10', 3800, 11, 0, 0, 0, 0, 140, 3),
(2370, 0, 0, 0, 'Cormaya 11', 2035, 11, 0, 0, 0, 0, 72, 2),
(2371, 0, 0, 0, 'Demon Tower', 3340, 2, 0, 0, 0, 0, 127, 2),
(2372, 0, 0, 0, 'Nautic Observer', 6540, 4, 0, 0, 0, 0, 300, 4),
(2373, 0, 0, 0, 'Riverspring', 19450, 3, 0, 0, 0, 0, 588, 18),
(2374, 0, 0, 0, 'House of Recreation', 22540, 4, 0, 0, 0, 0, 702, 16),
(2375, 0, 0, 0, 'Valorous Venore', 14435, 1, 0, 0, 0, 0, 496, 9),
(2376, 0, 0, 0, 'Ab\'Dendriel Clanhall', 14850, 5, 0, 0, 0, 0, 405, 10),
(2377, 0, 0, 0, 'Castle of the Winds', 23885, 5, 0, 0, 0, 0, 842, 18),
(2378, 0, 0, 0, 'The Hideout', 20800, 5, 0, 0, 0, 0, 597, 20),
(2379, 0, 0, 0, 'Shadow Towers', 21800, 5, 0, 0, 0, 0, 750, 18),
(2380, 0, 0, 0, 'Hill Hideout', 13950, 3, 0, 0, 0, 0, 346, 15),
(2381, 0, 0, 0, 'Meriana Beach', 8230, 7, 0, 0, 0, 0, 184, 3),
(2382, 0, 0, 0, 'Darashia 8, Flat 01', 2485, 10, 0, 0, 0, 0, 80, 2),
(2383, 0, 0, 0, 'Darashia 8, Flat 02', 3385, 10, 0, 0, 0, 0, 114, 2),
(2384, 0, 0, 0, 'Darashia 8, Flat 03', 4700, 10, 0, 0, 0, 0, 171, 3),
(2385, 0, 0, 0, 'Darashia 8, Flat 04', 2845, 10, 0, 0, 0, 0, 90, 2),
(2386, 0, 0, 0, 'Darashia 8, Flat 05', 2665, 10, 0, 0, 0, 0, 85, 2),
(2387, 0, 0, 0, 'Darashia, Eastern Guildhall', 12660, 10, 0, 0, 0, 0, 444, 16),
(2388, 0, 0, 0, 'Theater Avenue 5a', 450, 4, 0, 0, 0, 0, 20, 1),
(2389, 0, 0, 0, 'Theater Avenue 5b', 450, 4, 0, 0, 0, 0, 19, 1),
(2390, 0, 0, 0, 'Theater Avenue 5c', 450, 4, 0, 0, 0, 0, 16, 1),
(2391, 0, 0, 0, 'Theater Avenue 5d', 450, 4, 0, 0, 0, 0, 16, 1),
(2392, 0, 0, 0, 'Outlaw Camp 1', 1660, 3, 0, 0, 0, 0, 52, 2),
(2393, 0, 0, 0, 'Outlaw Camp 2', 280, 3, 0, 0, 0, 0, 12, 1),
(2394, 0, 0, 0, 'Outlaw Camp 3', 740, 3, 0, 0, 0, 0, 27, 2),
(2395, 0, 0, 0, 'Outlaw Camp 4', 200, 3, 0, 0, 0, 0, 9, 1),
(2396, 0, 0, 0, 'Outlaw Camp 5', 200, 3, 0, 0, 0, 0, 9, 1),
(2397, 0, 0, 0, 'Outlaw Camp 6', 200, 3, 0, 0, 0, 0, 9, 1),
(2398, 0, 0, 0, 'Outlaw Camp 7', 780, 3, 0, 0, 0, 0, 27, 2),
(2399, 0, 0, 0, 'Outlaw Camp 8', 280, 3, 0, 0, 0, 0, 12, 1),
(2400, 0, 0, 0, 'Outlaw Camp 9', 200, 3, 0, 0, 0, 0, 9, 1),
(2401, 0, 0, 0, 'Outlaw Camp 10', 200, 3, 0, 0, 0, 0, 9, 1),
(2402, 0, 0, 0, 'Outlaw Camp 11', 200, 3, 0, 0, 0, 0, 9, 1),
(2404, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 280, 3, 0, 0, 0, 0, 7, 0),
(2405, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 280, 3, 0, 0, 0, 0, 7, 0),
(2406, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 640, 3, 0, 0, 0, 0, 16, 0),
(2407, 0, 0, 0, 'Open-Air Theatre', 2700, 2, 0, 0, 0, 0, 60, 1),
(2408, 0, 0, 0, 'The Lair', 7625, 1, 0, 0, 0, 0, 165, 3),
(2409, 0, 0, 0, 'Upper Barracks 2', 210, 3, 0, 0, 0, 0, 13, 1),
(2410, 0, 0, 0, 'Upper Barracks 3', 210, 3, 0, 0, 0, 0, 13, 1),
(2411, 0, 0, 0, 'Upper Barracks 4', 210, 3, 0, 0, 0, 0, 14, 1),
(2412, 0, 0, 0, 'Upper Barracks 5', 210, 3, 0, 0, 0, 0, 12, 1),
(2413, 0, 0, 0, 'Upper Barracks 6', 210, 3, 0, 0, 0, 0, 12, 1),
(2414, 0, 0, 0, 'Upper Barracks 7', 210, 3, 0, 0, 0, 0, 12, 1),
(2415, 0, 0, 0, 'Upper Barracks 8', 210, 3, 0, 0, 0, 0, 13, 1),
(2416, 0, 0, 0, 'Upper Barracks 9', 210, 3, 0, 0, 0, 0, 13, 1),
(2417, 0, 0, 0, 'Upper Barracks 10', 210, 3, 0, 0, 0, 0, 13, 1),
(2418, 0, 0, 0, 'Upper Barracks 11', 210, 3, 0, 0, 0, 0, 14, 1),
(2419, 0, 0, 0, 'Upper Barracks 12', 210, 3, 0, 0, 0, 0, 12, 1),
(2420, 0, 0, 0, 'Low Waters Observatory', 17165, 9, 0, 0, 0, 0, 760, 5),
(2421, 0, 0, 0, 'Eastern House of Tranquility', 11120, 14, 0, 0, 0, 0, 356, 5),
(2422, 0, 0, 0, 'Mammoth House', 9300, 12, 0, 0, 0, 0, 218, 6),
(2427, 0, 0, 0, 'Lower Barracks 1', 300, 3, 0, 0, 0, 0, 17, 1),
(2428, 0, 0, 0, 'Lower Barracks 2', 300, 3, 0, 0, 0, 0, 16, 1),
(2429, 0, 0, 0, 'Lower Barracks 3', 300, 3, 0, 0, 0, 0, 17, 1),
(2430, 0, 0, 0, 'Lower Barracks 4', 300, 3, 0, 0, 0, 0, 16, 1),
(2431, 0, 0, 0, 'Lower Barracks 5', 300, 3, 0, 0, 0, 0, 17, 1),
(2432, 0, 0, 0, 'Lower Barracks 6', 300, 3, 0, 0, 0, 0, 15, 1),
(2433, 0, 0, 0, 'Lower Barracks 7', 300, 3, 0, 0, 0, 0, 17, 1),
(2434, 0, 0, 0, 'Lower Barracks 8', 300, 3, 0, 0, 0, 0, 16, 1),
(2435, 0, 0, 0, 'Lower Barracks 9', 300, 3, 0, 0, 0, 0, 17, 1),
(2436, 0, 0, 0, 'Lower Barracks 10', 300, 3, 0, 0, 0, 0, 16, 1),
(2437, 0, 0, 0, 'Lower Barracks 11', 300, 3, 0, 0, 0, 0, 17, 1),
(2438, 0, 0, 0, 'Lower Barracks 12', 300, 3, 0, 0, 0, 0, 16, 1),
(2439, 0, 0, 0, 'Lower Barracks 13', 300, 3, 0, 0, 0, 0, 17, 1),
(2440, 0, 0, 0, 'Lower Barracks 14', 300, 3, 0, 0, 0, 0, 16, 1),
(2441, 0, 0, 0, 'Lower Barracks 15', 300, 3, 0, 0, 0, 0, 17, 1),
(2442, 0, 0, 0, 'Lower Barracks 16', 300, 3, 0, 0, 0, 0, 16, 1),
(2443, 0, 0, 0, 'Lower Barracks 17', 300, 3, 0, 0, 0, 0, 17, 1),
(2444, 0, 0, 0, 'Lower Barracks 18', 300, 3, 0, 0, 0, 0, 16, 1),
(2445, 0, 0, 0, 'Lower Barracks 19', 300, 3, 0, 0, 0, 0, 17, 1),
(2446, 0, 0, 0, 'Lower Barracks 20', 300, 3, 0, 0, 0, 0, 16, 1),
(2447, 0, 0, 0, 'Lower Barracks 21', 300, 3, 0, 0, 0, 0, 17, 1),
(2448, 0, 0, 0, 'Lower Barracks 22', 300, 3, 0, 0, 0, 0, 16, 1),
(2449, 0, 0, 0, 'Lower Barracks 23', 300, 3, 0, 0, 0, 0, 17, 1),
(2450, 0, 0, 0, 'Lower Barracks 24', 300, 3, 0, 0, 0, 0, 16, 1),
(2451, 0, 0, 0, 'The Farms 4', 1530, 3, 0, 0, 0, 0, 36, 2),
(2452, 0, 0, 0, 'Tunnel Gardens 1', 2000, 3, 0, 0, 0, 0, 40, 3),
(2455, 0, 0, 0, 'Tunnel Gardens 2', 2000, 3, 0, 0, 0, 0, 39, 3),
(2456, 0, 0, 0, 'The Yeah Beach Project', 6525, 7, 0, 0, 0, 0, 183, 3),
(2460, 0, 0, 0, 'Hare\'s Den', 7500, 3, 0, 0, 0, 0, 233, 4),
(2461, 0, 0, 0, 'Lost Cavern', 14730, 3, 0, 0, 0, 0, 621, 7),
(2462, 0, 0, 0, 'Caveman Shelter', 3780, 14, 0, 0, 0, 0, 92, 4),
(2463, 0, 0, 0, 'Old Sanctuary of God King Qjell', 21940, 28, 0, 0, 0, 0, 854, 6),
(2464, 0, 0, 0, 'Wallside Lane 1', 7590, 33, 0, 0, 0, 0, 246, 4),
(2465, 0, 0, 0, 'Wallside Residence', 6680, 33, 0, 0, 0, 0, 227, 4),
(2466, 0, 0, 0, 'Wallside Lane 2', 8445, 33, 0, 0, 0, 0, 244, 4),
(2467, 0, 0, 0, 'Antimony Lane 3', 3665, 33, 0, 0, 0, 0, 116, 3),
(2468, 0, 0, 0, 'Antimony Lane 2', 4745, 33, 0, 0, 0, 0, 148, 3),
(2469, 0, 0, 0, 'Vanward Flats B', 7410, 33, 0, 0, 0, 0, 229, 4),
(2470, 0, 0, 0, 'Vanward Flats A', 7410, 33, 0, 0, 0, 0, 238, 4),
(2471, 0, 0, 0, 'Bronze Brothers Bastion', 35205, 33, 0, 0, 0, 0, 1038, 14),
(2472, 0, 0, 0, 'Antimony Lane 1', 7105, 33, 0, 0, 0, 0, 216, 4),
(2473, 0, 0, 0, 'Rathleton Hills Estate', 20685, 33, 0, 0, 0, 0, 548, 13),
(2474, 0, 0, 0, 'Rathleton Hills Residence', 7085, 33, 0, 0, 0, 0, 251, 3),
(2475, 0, 0, 0, 'Rathleton Plaza 1', 2890, 33, 0, 0, 0, 0, 100, 2),
(2476, 0, 0, 0, 'Rathleton Plaza 2', 2620, 33, 0, 0, 0, 0, 94, 2),
(2478, 0, 0, 0, 'Antimony Lane 4', 5150, 33, 0, 0, 0, 0, 166, 3),
(2480, 0, 0, 0, 'Old Heritage Estate', 12075, 33, 0, 0, 0, 0, 344, 7),
(2481, 0, 0, 0, 'Cistern Ave', 3745, 33, 0, 0, 0, 0, 130, 2),
(2482, 0, 0, 0, 'Rathleton Plaza 4', 5005, 33, 0, 0, 0, 0, 154, 2),
(2483, 0, 0, 0, 'Rathleton Plaza 3', 5735, 33, 0, 0, 0, 0, 180, 3),
(2486, 0, 0, 0, 'Rook House #3', 500000, 6, 0, 0, 0, 0, 20, 0),
(2487, 0, 0, 0, 'Rook House #4', 500000, 6, 0, 0, 0, 0, 14, 0),
(2488, 0, 0, 0, 'Thrarhor V e (Shop)', 3000, 9, 0, 0, 0, 0, 36, 1),
(2489, 0, 0, 0, 'Rook House #2489', 500000, 6, 0, 0, 0, 0, 91, 3),
(2490, 0, 0, 0, 'Rook House #2490', 500000, 6, 0, 0, 0, 0, 42, 1),
(2491, 0, 0, 0, 'Rook House #2491', 500000, 6, 0, 0, 0, 0, 70, 2),
(2492, 0, 0, 0, 'Rook House #2492', 500000, 6, 0, 0, 0, 0, 82, 2),
(2493, 0, 0, 0, 'Rook House #2493', 1000000, 6, 0, 0, 0, 0, 271, 6),
(2494, 0, 0, 0, 'Rook House #2494', 500000, 6, 0, 0, 0, 0, 139, 1),
(2495, 0, 0, 0, 'Rook House #2495', 500000, 6, 0, 0, 0, 0, 136, 0),
(2496, 0, 0, 0, 'Rook House #2496', 500000, 6, 0, 0, 0, 0, 24, 0),
(2497, 0, 0, 0, 'Rook House #2497', 500000, 6, 0, 0, 0, 0, 30, 1),
(2498, 0, 0, 0, 'Rook House #2498', 500000, 6, 0, 0, 0, 0, 60, 1),
(2499, 0, 0, 0, 'Rook House #2499', 500000, 6, 0, 0, 0, 0, 98, 2),
(2500, 0, 0, 0, 'Rook House #2500', 500000, 6, 0, 0, 0, 0, 112, 2),
(2501, 0, 0, 0, 'Rook House #2501', 500000, 6, 0, 0, 0, 0, 112, 4),
(2502, 0, 0, 0, 'Rook House #2502', 500000, 6, 0, 0, 0, 0, 64, 2),
(2503, 0, 0, 0, 'Rook House #2503', 500000, 6, 0, 0, 0, 0, 70, 2),
(2504, 0, 0, 0, 'Rook House #2504', 500000, 6, 0, 0, 0, 0, 98, 1),
(2505, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 9, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `live_casts`
--

CREATE TABLE `live_casts` (
  `player_id` int(11) NOT NULL,
  `cast_name` varchar(255) NOT NULL,
  `password` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `spectators` smallint(5) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_history`
--

CREATE TABLE `market_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_account_actions`
--

CREATE TABLE `myaac_account_actions` (
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `date` int(11) NOT NULL DEFAULT '0',
  `action` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_account_actions`
--

INSERT INTO `myaac_account_actions` (`account_id`, `ip`, `ipv6`, `date`, `action`) VALUES
(9, 2886991873, 0x00000000000000000000000000000000, 1678041702, 'Account created.'),
(9, 2886860801, 0x00000000000000000000000000000000, 1687902065, 'Created character <b>Teste</b>.');

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_admin_menu`
--

CREATE TABLE `myaac_admin_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_bugtracker`
--

CREATE TABLE `myaac_bugtracker` (
  `account` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `id` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `reply` int(11) NOT NULL DEFAULT '0',
  `who` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  `tag` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_changelog`
--

CREATE TABLE `myaac_changelog` (
  `id` int(11) NOT NULL,
  `body` varchar(500) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',
  `where` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - server, 2 - site',
  `date` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_changelog`
--

INSERT INTO `myaac_changelog` (`id`, `body`, `type`, `where`, `date`, `player_id`, `hidden`) VALUES
(1, 'MyAAC installed. (:', 3, 2, 1678041648, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_config`
--

CREATE TABLE `myaac_config` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_config`
--

INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES
(1, 'database_version', '32'),
(2, 'status_online', ''),
(3, 'status_players', '0'),
(4, 'status_playersMax', '0'),
(5, 'status_lastCheck', '0'),
(6, 'status_uptime', '0h 0m'),
(7, 'status_monsters', '0'),
(8, 'last_usage_report', '1687733192'),
(9, 'views_counter', '20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_faq`
--

CREATE TABLE `myaac_faq` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(1020) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_forum`
--

CREATE TABLE `myaac_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `section` int(3) NOT NULL DEFAULT '0',
  `replies` int(20) NOT NULL DEFAULT '0',
  `views` int(20) NOT NULL DEFAULT '0',
  `author_aid` int(20) NOT NULL DEFAULT '0',
  `author_guid` int(20) NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL DEFAULT '',
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_html` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int(20) NOT NULL DEFAULT '0',
  `last_edit_aid` int(20) NOT NULL DEFAULT '0',
  `edit_date` int(20) NOT NULL DEFAULT '0',
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `sticked` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_forum_boards`
--

CREATE TABLE `myaac_forum_boards` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `guild` int(11) NOT NULL DEFAULT '0',
  `access` int(11) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_forum_boards`
--

INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hidden`) VALUES
(1, 'News', 'News commenting', 0, 0, 0, 1, 0),
(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),
(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),
(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),
(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_gallery`
--

CREATE TABLE `myaac_gallery` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_gallery`
--

INSERT INTO `myaac_gallery` (`id`, `comment`, `image`, `thumb`, `author`, `ordering`, `hidden`) VALUES
(1, 'Demon', 'images/gallery/demon.jpg', 'images/gallery/demon_thumb.gif', 'MyAAC', 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_menu`
--

CREATE TABLE `myaac_menu` (
  `id` int(11) NOT NULL,
  `template` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '',
  `category` int(11) NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_menu`
--

INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES
(1, 'kathrine', 'Latest News', 'news', 0, '', 1, 0, 1),
(2, 'kathrine', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(3, 'kathrine', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(4, 'kathrine', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(5, 'kathrine', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(6, 'kathrine', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(7, 'kathrine', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(8, 'kathrine', 'Downloads', 'downloads', 0, '', 5, 4, 1),
(9, 'kathrine', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(10, 'kathrine', 'Who is Online?', 'online', 0, '', 3, 0, 1),
(11, 'kathrine', 'Characters', 'characters', 0, '', 3, 1, 1),
(12, 'kathrine', 'Guilds', 'guilds', 0, '', 3, 2, 1),
(13, 'kathrine', 'Highscores', 'highscores', 0, '', 3, 3, 1),
(14, 'kathrine', 'Last Deaths', 'lastkills', 0, '', 3, 4, 1),
(15, 'kathrine', 'Houses', 'houses', 0, '', 3, 5, 1),
(16, 'kathrine', 'Bans', 'bans', 0, '', 3, 6, 1),
(17, 'kathrine', 'Forum', 'forum', 0, '', 3, 7, 1),
(18, 'kathrine', 'Team', 'team', 0, '', 3, 8, 1),
(19, 'kathrine', 'Monsters', 'creatures', 0, '', 5, 0, 1),
(20, 'kathrine', 'Spells', 'spells', 0, '', 5, 1, 1),
(21, 'kathrine', 'Server Info', 'serverInfo', 0, '', 5, 2, 1),
(22, 'kathrine', 'Commands', 'commands', 0, '', 5, 3, 1),
(23, 'kathrine', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(24, 'kathrine', 'Experience Table', 'experienceTable', 0, '', 5, 5, 1),
(25, 'kathrine', 'FAQ', 'faq', 0, '', 5, 6, 1),
(26, 'kathrine', 'Buy Points', 'points', 0, '', 6, 0, 1),
(27, 'kathrine', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(28, 'kathrine', 'Shop History', 'gifts/history', 0, '', 6, 2, 1),
(29, 'tibiacom', 'Latest News', 'news', 0, '', 1, 0, 1),
(30, 'tibiacom', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(31, 'tibiacom', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(32, 'tibiacom', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(33, 'tibiacom', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(34, 'tibiacom', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(35, 'tibiacom', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(36, 'tibiacom', 'Downloads', 'downloads', 0, '', 2, 4, 1),
(37, 'tibiacom', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(38, 'tibiacom', 'Characters', 'characters', 0, '', 3, 0, 1),
(39, 'tibiacom', 'Who Is Online?', 'online', 0, '', 3, 1, 1),
(40, 'tibiacom', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(41, 'tibiacom', 'Last Kills', 'lastkills', 0, '', 3, 3, 1),
(42, 'tibiacom', 'Houses', 'houses', 0, '', 3, 4, 1),
(43, 'tibiacom', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(44, 'tibiacom', 'Polls', 'polls', 0, '', 3, 6, 1),
(45, 'tibiacom', 'Bans', 'bans', 0, '', 3, 7, 1),
(46, 'tibiacom', 'Support List', 'team', 0, '', 3, 8, 1),
(47, 'tibiacom', 'Forum', 'forum', 0, '', 4, 0, 1),
(48, 'tibiacom', 'Creatures', 'creatures', 0, '', 5, 0, 1),
(49, 'tibiacom', 'Spells', 'spells', 0, '', 5, 1, 1),
(50, 'tibiacom', 'Commands', 'commands', 0, '', 5, 2, 1),
(51, 'tibiacom', 'Exp Stages', 'experienceStages', 0, '', 5, 3, 1),
(52, 'tibiacom', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(53, 'tibiacom', 'Server Info', 'serverInfo', 0, '', 5, 5, 1),
(54, 'tibiacom', 'Experience Table', 'experienceTable', 0, '', 5, 6, 1),
(55, 'tibiacom', 'Buy Points', 'points', 0, '', 6, 0, 1),
(56, 'tibiacom', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(57, 'tibiacom', 'Shop History', 'gifts/history', 0, '', 6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_monsters`
--

CREATE TABLE `myaac_monsters` (
  `id` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT '0',
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `speed_lvl` int(11) NOT NULL DEFAULT '1',
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `elements` text NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `pushable` tinyint(1) NOT NULL DEFAULT '0',
  `canpushitems` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonenergy` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonpoison` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonfire` tinyint(1) NOT NULL DEFAULT '0',
  `runonhealth` tinyint(1) NOT NULL DEFAULT '0',
  `hostile` tinyint(1) NOT NULL DEFAULT '0',
  `attackable` tinyint(1) NOT NULL DEFAULT '0',
  `rewardboss` tinyint(1) NOT NULL DEFAULT '0',
  `defense` int(11) NOT NULL DEFAULT '0',
  `armor` int(11) NOT NULL DEFAULT '0',
  `canpushcreatures` tinyint(1) NOT NULL DEFAULT '0',
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL,
  `summons` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_news`
--

CREATE TABLE `myaac_news` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - news, 2 - ticker, 3 - article',
  `date` int(11) NOT NULL DEFAULT '0',
  `category` tinyint(1) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `last_modified_by` int(11) NOT NULL DEFAULT '0',
  `last_modified_date` int(11) NOT NULL DEFAULT '0',
  `comments` varchar(50) NOT NULL DEFAULT '',
  `article_text` varchar(300) NOT NULL DEFAULT '',
  `article_image` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_news`
--

INSERT INTO `myaac_news` (`id`, `title`, `body`, `type`, `date`, `category`, `player_id`, `last_modified_by`, `last_modified_date`, `comments`, `article_text`, `article_image`, `hidden`) VALUES
(1, 'Hello!', 'MyAAC is just READY to use!', 1, 1678041702, 2, 14, 0, 0, 'https://my-aac.org', '', '', 0),
(2, 'Hello tickets!', 'https://my-aac.org', 2, 1678041702, 4, 14, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_news_categories`
--

CREATE TABLE `myaac_news_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `icon_id` int(2) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_news_categories`
--

INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hidden`) VALUES
(1, '', '', 0, 0),
(2, '', '', 1, 0),
(3, '', '', 2, 0),
(4, '', '', 3, 0),
(5, '', '', 4, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_notepad`
--

CREATE TABLE `myaac_notepad` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_pages`
--

CREATE TABLE `myaac_pages` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` text NOT NULL,
  `date` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `php` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - plain html, 1 - php',
  `enable_tinymce` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - enabled, 0 - disabled',
  `access` tinyint(2) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_pages`
--

INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hidden`) VALUES
(1, 'downloads', 'Downloads', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<div style=\"text-align: center;\">We\'re using official Tibia Client <strong>{{ config.client / 100 }}</strong><br />\n<p>Download Tibia Client <strong>{{ config.client / 100 }}</strong>&nbsp;for Windows <a href=\"https://drive.google.com/drive/folders/0B2-sMQkWYzhGSFhGVlY2WGk5czQ\" target=\"_blank\" rel=\"noopener\">HERE</a>.</p>\n<h2>IP Changer:</h2>\n<a href=\"https://static.otland.net/ipchanger.exe\" target=\"_blank\" rel=\"noopener\">HERE</a></div>', 0, 1, 0, 1, 1, 0),
(2, 'commands', 'Commands', '<table style=\"border-collapse: collapse; width: 87.8471%; height: 57px;\" border=\"1\">\n<tbody>\n<tr style=\"height: 18px;\">\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Description</strong></span></td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!example</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">This is just an example</td>\n</tr>\n<tr style=\"height: 18px; background-color: #d4c0a1;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!buyhouse</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy house you are looking at</td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!aol</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy AoL</td>\n</tr>\n</tbody>\n</table>', 0, 1, 0, 1, 1, 0),
(3, 'rules_on_the_page', 'Rules', '1. Names\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\n\n2. Cheating\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\nd) Manipulating the client program or using additional software to play the game.\ne) Trying to steal other players\' account data (\"hacking\").\nf) Playing on more than one account at the same time (\"multi-clienting\").\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\n\n3. Gamemasters\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\n\n4. Player Killing\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\n\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\n\nThese rules may be changed at any time. All changes will be announced on the official website.', 0, 1, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_spells`
--

CREATE TABLE `myaac_spells` (
  `id` int(11) NOT NULL,
  `spell` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `words` varchar(255) NOT NULL DEFAULT '',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - instant, 2 - conjure, 3 - rune',
  `level` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `soul` tinyint(3) NOT NULL DEFAULT '0',
  `conjure_id` int(11) NOT NULL DEFAULT '0',
  `conjure_count` tinyint(3) NOT NULL DEFAULT '0',
  `reagent` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_spells`
--

INSERT INTO `myaac_spells` (`id`, `spell`, `name`, `words`, `category`, `type`, `level`, `maglevel`, `mana`, `soul`, `conjure_id`, `conjure_count`, `reagent`, `item_id`, `premium`, `vocations`, `hidden`) VALUES
(1, '', 'Blank Rune', 'adori blank', 0, 2, 20, 0, 50, 1, 2260, 1, 0, 0, 0, '[2,6,3,7,1,5]', 0),
(2, '', 'Conjure Arrow', 'exevo con', 0, 2, 13, 0, 100, 1, 2544, 10, 0, 0, 0, '[3,7]', 0),
(3, '', 'Conjure Poisoned Arrow', 'exevo con pox', 0, 2, 16, 0, 130, 2, 2545, 7, 0, 0, 0, '[3,7]', 0),
(4, '', 'Conjure Bolt', 'exevo con mort', 0, 2, 17, 0, 140, 2, 2543, 5, 0, 0, 1, '[3,7]', 0),
(5, '', 'Conjure Sniper Arrow', 'exevo con hur', 0, 2, 24, 0, 160, 3, 7364, 5, 0, 0, 1, '[3,7]', 0),
(6, '', 'Conjure Explosive Arrow', 'exevo con flam', 0, 2, 25, 0, 290, 3, 2546, 8, 0, 0, 0, '[3,7]', 0),
(7, '', 'Conjure Piercing Bolt', 'exevo con grav', 0, 2, 33, 0, 180, 3, 7363, 5, 0, 0, 1, '[3,7]', 0),
(8, '', 'Enchant Staff', 'exeta vis', 0, 2, 41, 0, 80, 0, 2433, 0, 2401, 0, 1, '[5]', 0),
(9, '', 'Enchant Spear', 'exeta con', 0, 2, 45, 0, 350, 3, 7367, 0, 2389, 0, 1, '[3,7]', 0),
(10, '', 'Conjure Power Bolt', 'exevo con vis', 0, 2, 59, 0, 700, 4, 2547, 10, 0, 0, 1, '[7]', 0),
(11, '', 'Poison Field', 'adevo grav pox', 0, 2, 14, 0, 200, 1, 2285, 3, 2260, 0, 0, '[1,2,5,6]', 0),
(12, '', 'Light Magic Missile', 'adori min vis', 0, 2, 15, 0, 120, 1, 2287, 10, 2260, 0, 0, '[1,2,5,6]', 0),
(13, '', 'Fire Field', 'adevo grav flam', 0, 2, 15, 0, 240, 1, 2301, 3, 2260, 0, 0, '[1,2,5,6]', 0),
(14, '', 'Fireball', 'adori flam', 0, 2, 27, 0, 460, 3, 2302, 5, 2260, 0, 1, '[1,5]', 0),
(15, '', 'Energy Field', 'adevo grav vis', 0, 2, 18, 0, 320, 2, 2277, 3, 2260, 0, 0, '[1,2,5,6]', 0),
(16, '', 'Stalagmite', 'adori tera', 0, 2, 24, 0, 400, 2, 2292, 10, 2260, 0, 0, '[1,5,2,6]', 0),
(17, '', 'Great Fireball', 'adori mas flam', 0, 2, 30, 0, 530, 3, 2304, 4, 2260, 0, 0, '[1,5]', 0),
(18, '', 'Heavy Magic Missile', 'adori vis', 0, 2, 25, 0, 350, 2, 2311, 10, 2260, 0, 0, '[1,5,2,6]', 0),
(19, '', 'Poison Bomb', 'adevo mas pox', 0, 2, 25, 0, 520, 2, 2286, 2, 2260, 0, 1, '[2,6]', 0),
(20, '', 'Firebomb', 'adevo mas flam', 0, 2, 27, 0, 600, 4, 2305, 2, 2260, 0, 0, '[1,2,5,6]', 0),
(21, '', 'Soulfire', 'adevo res flam', 0, 2, 27, 0, 600, 3, 2308, 3, 2260, 0, 1, '[1,2,5,6]', 0),
(22, '', 'Poison Wall', 'adevo mas grav pox', 0, 2, 29, 0, 640, 3, 2289, 4, 2260, 0, 0, '[1,2,5,6]', 0),
(23, '', 'Explosion', 'adevo mas hur', 0, 2, 31, 0, 570, 4, 2313, 6, 2260, 0, 0, '[1,2,5,6]', 0),
(24, '', 'Fire Wall', 'adevo mas grav flam', 0, 2, 33, 0, 780, 4, 2303, 4, 2260, 0, 0, '[1,2,5,6]', 0),
(25, '', 'Energybomb', 'adevo mas vis', 0, 2, 37, 0, 880, 5, 2262, 2, 2260, 0, 1, '[1,5]', 0),
(26, '', 'Energy Wall', 'adevo mas grav vis', 0, 2, 41, 0, 1000, 5, 2279, 4, 2260, 0, 0, '[1,2,5,6]', 0),
(27, '', 'Sudden Death', 'adori gran mort', 0, 2, 45, 0, 985, 5, 2268, 3, 2260, 0, 0, '[1,5]', 0),
(28, '', 'Antidote Rune', 'adana pox', 0, 2, 15, 0, 200, 1, 2266, 1, 2260, 0, 0, '[2,6]', 0),
(29, '', 'Intense Healing Rune', 'adura gran', 0, 2, 15, 0, 240, 2, 2265, 1, 2260, 0, 0, '[2,6]', 0),
(30, '', 'Ultimate Healing Rune', 'adura vita', 0, 2, 24, 0, 400, 3, 2273, 1, 2260, 0, 0, '[2,6]', 0),
(31, '', 'Convince Creature', 'adeta sio', 0, 2, 16, 0, 200, 3, 2290, 1, 2260, 0, 0, '[2,6]', 0),
(32, '', 'Animate Dead', 'adana mort', 0, 2, 27, 0, 600, 5, 2316, 1, 2260, 0, 1, '[1,2,5,6]', 0),
(33, '', 'Chameleon', 'adevo ina', 0, 2, 27, 0, 600, 2, 2291, 1, 2260, 0, 0, '[2,6]', 0),
(34, '', 'Destroy Field', 'adito grav', 0, 2, 17, 0, 120, 2, 2261, 3, 2260, 0, 0, '[1,2,3,5,6,7]', 0),
(35, '', 'Desintegrate', 'adito tera', 0, 2, 21, 0, 200, 3, 2310, 3, 2260, 0, 1, '[1,2,3,5,6,7]', 0),
(36, '', 'Magic Wall', 'adevo grav tera', 0, 2, 32, 0, 750, 5, 2293, 3, 2260, 0, 1, '[1,5]', 0),
(37, '', 'Wild Growth', 'adevo grav vita', 0, 2, 27, 0, 600, 5, 2269, 2, 2260, 0, 1, '[2,6]', 0),
(38, '', 'Paralyze', 'adana ani', 0, 2, 54, 0, 1400, 3, 2278, 1, 2260, 0, 1, '[2,6]', 0),
(39, '', 'Icicle', 'adori frigo', 0, 2, 28, 0, 460, 3, 2271, 5, 2260, 0, 1, '[2,6]', 0),
(40, '', 'Avalanche', 'adori mas frigo', 0, 2, 30, 0, 530, 3, 2274, 4, 2260, 0, 0, '[2,6]', 0),
(41, '', 'Stone Shower', 'adori mas tera', 0, 2, 28, 0, 430, 3, 2288, 4, 2260, 0, 1, '[2,6]', 0),
(42, '', 'Thunderstorm', 'adori mas vis', 0, 2, 28, 0, 430, 3, 2315, 4, 2260, 0, 1, '[1,5]', 0),
(43, '', 'Holy Missile', 'adori san', 0, 2, 27, 0, 350, 3, 2295, 5, 2260, 0, 1, '[3,7]', 0),
(44, '', 'Annihilation', 'exori gran ico', 0, 1, 110, 0, 300, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(45, '', 'Apprentice\'s Strike', 'exori min flam', 0, 1, 8, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(46, '', 'Berserk', 'exori', 0, 1, 35, 0, 115, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(47, '', 'Blood Rage', 'utito tempo', 0, 1, 60, 0, 290, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(48, '', 'Brutal Strike', 'exori ico', 0, 1, 16, 0, 30, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(49, '', 'Cancel Invisibility', 'exana ina', 0, 1, 26, 0, 200, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(50, '', 'Challenge', 'exeta res', 0, 1, 20, 0, 30, 0, 0, 0, 0, 0, 1, '[8]', 0),
(51, '', 'Charge', 'utani tempo hur', 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(52, '', 'Creature Illusion', 'utevo res ina', 0, 1, 23, 0, 100, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(53, '', 'Cure Bleeding', 'exana kor', 0, 1, 45, 0, 30, 0, 0, 0, 0, 0, 0, '[2,4,6,8]', 0),
(54, '', 'Cure Burning', 'exana flam', 0, 1, 30, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(55, '', 'Cure Curse', 'exana mort', 0, 1, 80, 0, 40, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(56, '', 'Cure Electrification', 'exana vis', 0, 1, 22, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(57, '', 'Cure Poison', 'exana pox', 0, 1, 10, 0, 30, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(58, '', 'Curse', 'utori mort', 0, 1, 75, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(59, '', 'Death Strike', 'exori mort', 0, 1, 16, 0, 20, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(60, '', 'Divine Caldera', 'exevo mas san', 0, 1, 50, 0, 160, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(61, '', 'Divine Healing', 'exura san', 0, 1, 35, 0, 160, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(62, '', 'Divine Missile', 'exori san', 0, 1, 40, 0, 20, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(63, '', 'Electrify', 'utori vis', 0, 1, 34, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(64, '', 'Enchant Party', 'utori mas sio', 0, 1, 32, 0, 120, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(65, '', 'Energy Beam', 'exevo vis lux', 0, 1, 23, 0, 40, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(66, '', 'Energy Strike', 'exori vis', 0, 1, 12, 0, 20, 0, 0, 0, 0, 0, 1, '[1,2,5,6]', 0),
(67, '', 'Energy Wave', 'exevo vis hur', 0, 1, 38, 0, 170, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(68, '', 'Envenom', 'utori pox', 0, 1, 50, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(69, '', 'Eternal Winter', 'exevo gran mas frigo', 0, 1, 60, 0, 1050, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(70, '', 'Ethereal Spear', 'exori con', 0, 1, 23, 0, 25, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(71, '', 'Fierce Berserk', 'exori gran', 0, 1, 90, 0, 340, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(72, '', 'Find Person', 'exiva', 0, 1, 8, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(73, '', 'Fire Wave', 'exevo flam hur', 0, 1, 18, 0, 25, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(74, '', 'Flame Strike', 'exori flam', 0, 1, 14, 0, 20, 0, 0, 0, 0, 0, 1, '[1,2,5,6]', 0),
(75, '', 'Food', 'exevo pan', 0, 1, 14, 0, 120, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(76, '', 'Front Sweep', 'exori min', 0, 1, 70, 0, 200, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(77, '', 'Great Energy Beam', 'exevo gran vis lux', 0, 1, 29, 0, 110, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(78, '', 'Great Light', 'utevo gran lux', 0, 1, 13, 0, 60, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(79, '', 'Groundshaker', 'exori mas', 0, 1, 33, 0, 160, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(80, '', 'Haste', 'utani hur', 0, 1, 14, 0, 60, 0, 0, 0, 0, 0, 1, '[1,2,3,4,5,6,7,8]', 0),
(81, '', 'Heal Friend', 'exura sio', 0, 1, 18, 0, 140, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(82, '', 'Heal Party', 'utura mas sio', 0, 1, 32, 0, 120, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(83, '', 'Hell\'s Core', 'exevo gran mas flam', 0, 1, 60, 0, 1100, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(84, '', 'Holy Flash', 'utori san', 0, 1, 70, 0, 30, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(85, '', 'Ice Strike', 'exori frigo', 0, 1, 15, 0, 20, 0, 0, 0, 0, 0, 1, '[1,5,2,6]', 0),
(86, '', 'Ice Wave', 'exevo frigo hur', 0, 1, 18, 0, 25, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(87, '', 'Ignite', 'utori flam', 0, 1, 26, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(88, '', 'Inflict Wound', 'utori kor', 0, 1, 40, 0, 30, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(89, '', 'Intense Healing', 'exura gran', 0, 1, 20, 0, 70, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(90, '', 'Intense Recovery', 'utura gran', 0, 1, 100, 0, 165, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(91, '', 'Intense Wound Cleansing', 'exura gran ico', 0, 1, 80, 0, 200, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(92, '', 'Invisibility', 'utana vid', 0, 1, 35, 0, 440, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(93, '', 'Levitate', 'exani hur', 0, 1, 12, 0, 50, 0, 0, 0, 0, 0, 1, '[1,2,3,4,5,6,7,8]', 0),
(94, '', 'Light', 'utevo lux', 0, 1, 8, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(95, '', 'Light Healing', 'exura', 0, 1, 8, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(96, '', 'Lightning', 'exori amp vis', 0, 1, 55, 0, 60, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(97, '', 'Magic Rope', 'exani tera', 0, 1, 9, 0, 20, 0, 0, 0, 0, 0, 1, '[1,2,3,4,5,6,7,8]', 0),
(98, '', 'Magic Shield', 'utamo vita', 0, 1, 14, 0, 50, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(99, '', 'Mass Healing', 'exura gran mas res', 0, 1, 36, 0, 150, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(100, '', 'Physical Strike', 'exori moe ico', 0, 1, 16, 0, 20, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(101, '', 'Practise Fire Wave', 'exevo dis flam hur', 0, 1, 1, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(102, '', 'Practise Healing', 'exura dis', 0, 1, 1, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(103, '', 'Protect Party', 'utamo mas sio', 0, 1, 32, 0, 90, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(104, '', 'Protector', 'utamo tempo', 0, 1, 55, 0, 200, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(105, '', 'Rage of the Skies', 'exevo gran mas vis', 0, 1, 55, 0, 600, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(106, '', 'Recovery', 'utura', 0, 1, 50, 0, 75, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(107, '', 'Salvation', 'exura gran san', 0, 1, 60, 0, 210, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(108, '', 'Sharpshooter', 'utito tempo san', 0, 1, 60, 0, 450, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(109, '', 'Strong Energy Strike', 'exori gran vis', 0, 1, 80, 0, 60, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(110, '', 'Strong Ethereal Spear', 'exori gran con', 0, 1, 90, 0, 55, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(111, '', 'Strong Flame Strike', 'exori gran flam', 0, 1, 70, 0, 60, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(112, '', 'Strong Haste', 'utani gran hur', 0, 1, 20, 0, 100, 0, 0, 0, 0, 0, 1, '[1,2,5,6]', 0),
(113, '', 'Strong Ice Strike', 'exori gran frigo', 0, 1, 80, 0, 60, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(114, '', 'Strong Ice Wave', 'exevo gran frigo hur', 0, 1, 40, 0, 170, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(115, '', 'Strong Terra Strike', 'exori gran tera', 0, 1, 70, 0, 60, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(116, '', 'Summon Creature', 'utevo res', 0, 1, 25, 0, 0, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(117, '', 'Swift Foot', 'utamo tempo san', 0, 1, 55, 0, 400, 0, 0, 0, 0, 0, 1, '[3,7]', 0),
(118, '', 'Terra Strike', 'exori tera', 0, 1, 13, 0, 20, 0, 0, 0, 0, 0, 1, '[1,5,2,6]', 0),
(119, '', 'Terra Wave', 'exevo tera hur', 0, 1, 38, 0, 210, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(120, '', 'Train Party', 'utito mas sio', 0, 1, 32, 0, 60, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(121, '', 'Ultimate Energy Strike', 'exori max vis', 0, 1, 100, 0, 100, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(122, '', 'Ultimate Flame Strike', 'exori max flam', 0, 1, 90, 0, 100, 0, 0, 0, 0, 0, 1, '[1,5]', 0),
(123, '', 'Ultimate Healing', 'exura vita', 0, 1, 30, 0, 160, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(124, '', 'Ultimate Ice Strike', 'exori max frigo', 0, 1, 100, 0, 100, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(125, '', 'Ultimate Light', 'utevo vis lux', 0, 1, 26, 0, 140, 0, 0, 0, 0, 0, 1, '[1,2,5,6]', 0),
(126, '', 'Ultimate Terra Strike', 'exori max tera', 0, 1, 90, 0, 100, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(127, '', 'Wound Cleansing', 'exura ico', 0, 1, 10, 0, 40, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(128, '', 'Whirlwind Throw', 'exori hur', 0, 1, 28, 0, 40, 0, 0, 0, 0, 0, 1, '[4,8]', 0),
(129, '', 'Wrath of Nature', 'exevo gran mas tera', 0, 1, 55, 0, 700, 0, 0, 0, 0, 0, 1, '[2,6]', 0),
(130, '', 'House Guest List', 'aleta sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(131, '', 'House Subowner List', 'aleta som', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(132, '', 'House Door List', 'aleta grav', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(133, '', 'House Kick', 'alana sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(134, '', 'Poison Field Rune', '', 0, 3, 14, 0, 0, 0, 0, 0, 0, 2285, 0, '[]', 0),
(135, '', 'Poison Bomb Rune', '', 0, 3, 25, 4, 0, 0, 0, 0, 0, 2286, 0, '[]', 0),
(136, '', 'Poison Wall Rune', '', 0, 3, 29, 5, 0, 0, 0, 0, 0, 2289, 0, '[]', 0),
(137, '', 'Fire Field Rune', '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 2301, 0, '[]', 0),
(138, '', 'Firebomb Rune', '', 0, 3, 27, 5, 0, 0, 0, 0, 0, 2305, 0, '[]', 0),
(139, '', 'Fire Wall Rune', '', 0, 3, 33, 6, 0, 0, 0, 0, 0, 2303, 0, '[]', 0),
(140, '', 'Soulfire Rune', '', 0, 3, 27, 7, 0, 0, 0, 0, 0, 2308, 0, '[]', 0),
(141, '', 'Fireball Rune', '', 0, 3, 27, 4, 0, 0, 0, 0, 0, 2302, 0, '[]', 0),
(142, '', 'Great Fireball Rune', '', 0, 3, 30, 4, 0, 0, 0, 0, 0, 2304, 0, '[]', 0),
(143, '', 'Energy Field Rune', '', 0, 3, 18, 3, 0, 0, 0, 0, 0, 2277, 0, '[]', 0),
(144, '', 'Energybomb Rune', '', 0, 3, 37, 10, 0, 0, 0, 0, 0, 2262, 0, '[]', 0),
(145, '', 'Energy Wall Rune', '', 0, 3, 41, 9, 0, 0, 0, 0, 0, 2279, 0, '[]', 0),
(146, '', 'Light Magic Missile Rune', '', 0, 3, 15, 0, 0, 0, 0, 0, 0, 2287, 0, '[]', 0),
(147, '', 'Heavy Magic Missile Rune', '', 0, 3, 25, 3, 0, 0, 0, 0, 0, 2311, 0, '[]', 0),
(148, '', 'Explosion Rune', '', 0, 3, 31, 6, 0, 0, 0, 0, 0, 2313, 0, '[]', 0),
(149, '', 'Sudden Death Rune', '', 0, 3, 45, 15, 0, 0, 0, 0, 0, 2268, 0, '[]', 0),
(150, '', 'Icicle Rune', '', 0, 3, 28, 4, 0, 0, 0, 0, 0, 2271, 0, '[]', 0),
(151, '', 'Avalanche Rune', '', 0, 3, 30, 4, 0, 0, 0, 0, 0, 2274, 0, '[]', 0),
(152, '', 'Stone Shower Rune', '', 0, 3, 28, 4, 0, 0, 0, 0, 0, 2288, 0, '[]', 0),
(153, '', 'Thunderstorm Rune', '', 0, 3, 28, 4, 0, 0, 0, 0, 0, 2315, 0, '[]', 0),
(154, '', 'Stalagmite Rune', '', 0, 3, 24, 3, 0, 0, 0, 0, 0, 2292, 0, '[]', 0),
(155, '', 'Holy Missile Rune', '', 0, 3, 27, 4, 0, 0, 0, 0, 0, 2295, 0, '[3,7]', 0),
(156, '', 'Magic Wall Rune', '', 0, 3, 32, 9, 0, 0, 0, 0, 0, 2293, 0, '[]', 0),
(157, '', 'Antidote Rune Rune', '', 0, 3, 15, 0, 0, 0, 0, 0, 0, 2266, 0, '[]', 0),
(158, '', 'Intense Healing Rune Rune', '', 0, 3, 15, 1, 0, 0, 0, 0, 0, 2265, 0, '[]', 0),
(159, '', 'Ultimate Healing Rune Rune', '', 0, 3, 24, 4, 0, 0, 0, 0, 0, 2273, 0, '[]', 0),
(160, '', 'Convince Creature Rune', '', 0, 3, 16, 5, 0, 0, 0, 0, 0, 2290, 0, '[]', 0),
(161, '', 'Animate Dead Rune', '', 0, 3, 27, 4, 0, 0, 0, 0, 0, 2316, 0, '[]', 0),
(162, '', 'Desintegrate Rune', '', 0, 3, 21, 4, 0, 0, 0, 0, 0, 2310, 0, '[]', 0),
(163, '', 'Destroy Field Rune', '', 0, 3, 17, 3, 0, 0, 0, 0, 0, 2261, 0, '[]', 0),
(164, '', 'Chameleon Rune', '', 0, 3, 27, 4, 0, 0, 0, 0, 0, 2291, 0, '[]', 0),
(165, '', 'Wild Growth Rune', '', 0, 3, 27, 8, 0, 0, 0, 0, 0, 2269, 0, '[2,6]', 0),
(166, '', 'Paralyze Rune', '', 0, 3, 54, 18, 1400, 0, 0, 0, 0, 2278, 0, '[2,6]', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_videos`
--

CREATE TABLE `myaac_videos` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `youtube_id` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_visitors`
--

CREATE TABLE `myaac_visitors` (
  `ip` varchar(16) NOT NULL,
  `lastvisit` int(11) NOT NULL DEFAULT '0',
  `page` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_weapons`
--

CREATE TABLE `myaac_weapons` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_weapons`
--

INSERT INTO `myaac_weapons` (`id`, `level`, `maglevel`, `vocations`) VALUES
(2181, 26, 0, '{\"2\":true}'),
(2182, 7, 0, '{\"2\":true}'),
(2183, 33, 0, '{\"2\":true}'),
(2185, 19, 0, '{\"2\":true}'),
(2186, 13, 0, '{\"2\":true}'),
(2187, 33, 0, '{\"1\":true}'),
(2188, 19, 0, '{\"1\":true}'),
(2189, 26, 0, '{\"1\":true}'),
(2190, 7, 0, '{\"1\":true}'),
(2191, 13, 0, '{\"1\":true}'),
(2377, 20, 0, '{\"4\":true,\"8\":false}'),
(2378, 0, 0, '{\"4\":true,\"8\":false}'),
(2381, 25, 0, '[]'),
(2387, 25, 0, '{\"4\":true,\"8\":false}'),
(2390, 140, 0, '{\"4\":true,\"8\":false}'),
(2391, 50, 0, '{\"4\":true,\"8\":false}'),
(2392, 30, 0, '[]'),
(2393, 55, 0, '{\"4\":true,\"8\":false}'),
(2396, 0, 0, '[]'),
(2400, 80, 0, '[]'),
(2407, 30, 0, '[]'),
(2408, 120, 0, '{\"4\":true,\"8\":false}'),
(2413, 0, 0, '{\"4\":true,\"8\":false}'),
(2414, 60, 0, '[]'),
(2415, 95, 0, '{\"4\":true,\"8\":false}'),
(2421, 85, 0, '[]'),
(2423, 20, 0, '[]'),
(2424, 45, 0, '[]'),
(2425, 20, 0, '[]'),
(2426, 25, 0, '[]'),
(2427, 55, 0, '[]'),
(2429, 20, 0, '[]'),
(2430, 25, 0, '[]'),
(2431, 90, 0, '[]'),
(2432, 35, 0, '[]'),
(2434, 25, 0, '[]'),
(2435, 20, 0, '[]'),
(2436, 30, 0, '[]'),
(2438, 30, 0, '[]'),
(2440, 25, 0, '{\"4\":true,\"8\":false}'),
(2443, 70, 0, '{\"4\":true,\"8\":false}'),
(2444, 65, 0, '{\"4\":true,\"8\":false}'),
(2445, 35, 0, '[]'),
(2446, 45, 0, '[]'),
(2447, 50, 0, '{\"4\":true,\"8\":false}'),
(2451, 35, 0, '[]'),
(2452, 70, 0, '{\"4\":true,\"8\":false}'),
(2453, 75, 0, '[]'),
(2454, 65, 0, '{\"4\":true,\"8\":false}'),
(2545, 0, 0, '[]'),
(2546, 0, 0, '[]'),
(2547, 55, 0, '[]'),
(3961, 40, 0, '[]'),
(3962, 30, 0, '[]'),
(3965, 20, 0, '[]'),
(5803, 75, 0, '{\"3\":true,\"7\":false}'),
(6528, 75, 0, '{\"4\":true,\"8\":false}'),
(6529, 110, 0, '[]'),
(6553, 75, 0, '{\"4\":true,\"8\":false}'),
(7363, 30, 0, '[]'),
(7364, 20, 0, '[]'),
(7365, 40, 0, '[]'),
(7366, 0, 0, '[]'),
(7367, 42, 0, '[]'),
(7368, 80, 0, '[]'),
(7378, 25, 0, '[]'),
(7379, 25, 0, '[]'),
(7380, 35, 0, '{\"4\":true,\"8\":false}'),
(7381, 20, 0, '[]'),
(7382, 60, 0, '{\"4\":true,\"8\":false}'),
(7383, 50, 0, '[]'),
(7384, 60, 0, '[]'),
(7385, 20, 0, '[]'),
(7386, 40, 0, '{\"4\":true,\"8\":false}'),
(7387, 25, 0, '[]'),
(7388, 55, 0, '[]'),
(7389, 60, 0, '[]'),
(7390, 75, 0, '[]'),
(7391, 50, 0, '{\"4\":true,\"8\":false}'),
(7392, 35, 0, '[]'),
(7402, 45, 0, '{\"4\":true,\"8\":false}'),
(7403, 65, 0, '{\"4\":true,\"8\":false}'),
(7404, 40, 0, '[]'),
(7405, 70, 0, '{\"4\":true,\"8\":false}'),
(7406, 35, 0, '{\"4\":true,\"8\":false}'),
(7407, 30, 0, '{\"4\":true,\"8\":false}'),
(7408, 25, 0, '[]'),
(7409, 50, 0, '[]'),
(7410, 55, 0, '[]'),
(7411, 50, 0, '[]'),
(7412, 45, 0, '[]'),
(7413, 40, 0, '{\"4\":true,\"8\":false}'),
(7414, 60, 0, '{\"4\":true,\"8\":false}'),
(7415, 60, 0, '[]'),
(7416, 55, 0, '[]'),
(7417, 65, 0, '[]'),
(7418, 70, 0, '[]'),
(7419, 40, 0, '[]'),
(7420, 70, 0, '[]'),
(7421, 65, 0, '[]'),
(7422, 75, 0, '[]'),
(7423, 85, 0, '{\"4\":true,\"8\":false}'),
(7424, 30, 0, '[]'),
(7425, 20, 0, '[]'),
(7426, 40, 0, '[]'),
(7427, 45, 0, '[]'),
(7428, 55, 0, '{\"4\":true,\"8\":false}'),
(7429, 75, 0, '[]'),
(7430, 30, 0, '[]'),
(7431, 80, 0, '[]'),
(7432, 20, 0, '[]'),
(7433, 65, 0, '[]'),
(7434, 75, 0, '[]'),
(7435, 85, 0, '[]'),
(7436, 45, 0, '{\"4\":true,\"8\":false}'),
(7437, 30, 0, '[]'),
(7449, 25, 0, '{\"4\":true,\"8\":false}'),
(7450, 120, 0, '{\"4\":true,\"8\":false}'),
(7451, 35, 0, '[]'),
(7452, 30, 0, '{\"4\":true,\"8\":false}'),
(7453, 85, 0, '{\"4\":true,\"8\":false}'),
(7454, 30, 0, '{\"4\":true,\"8\":false}'),
(7455, 80, 0, '[]'),
(7456, 35, 0, '[]'),
(7744, 0, 0, '[]'),
(7745, 50, 0, '[]'),
(7746, 60, 0, '[]'),
(7747, 35, 0, '{\"4\":true,\"8\":false}'),
(7748, 45, 0, '{\"4\":true,\"8\":false}'),
(7749, 20, 0, '[]'),
(7750, 25, 0, '[]'),
(7751, 60, 0, '[]'),
(7752, 35, 0, '{\"4\":true,\"8\":false}'),
(7753, 65, 0, '{\"4\":true,\"8\":false}'),
(7754, 20, 0, '[]'),
(7755, 35, 0, '[]'),
(7756, 60, 0, '[]'),
(7757, 35, 0, '[]'),
(7758, 50, 0, '{\"4\":true,\"8\":false}'),
(7763, 0, 0, '[]'),
(7764, 50, 0, '[]'),
(7765, 60, 0, '[]'),
(7766, 35, 0, '{\"4\":true,\"8\":false}'),
(7767, 45, 0, '{\"4\":true,\"8\":false}'),
(7768, 20, 0, '[]'),
(7769, 25, 0, '[]'),
(7770, 60, 0, '[]'),
(7771, 35, 0, '{\"4\":true,\"8\":false}'),
(7772, 65, 0, '{\"4\":true,\"8\":false}'),
(7773, 20, 0, '[]'),
(7774, 35, 0, '[]'),
(7775, 60, 0, '[]'),
(7776, 35, 0, '[]'),
(7777, 50, 0, '{\"4\":true,\"8\":false}'),
(7838, 20, 0, '[]'),
(7839, 20, 0, '[]'),
(7840, 20, 0, '[]'),
(7850, 20, 0, '[]'),
(7854, 0, 0, '[]'),
(7855, 50, 0, '[]'),
(7856, 60, 0, '[]'),
(7857, 35, 0, '{\"4\":true,\"8\":false}'),
(7858, 45, 0, '{\"4\":true,\"8\":false}'),
(7859, 20, 0, '[]'),
(7860, 25, 0, '[]'),
(7861, 60, 0, '[]'),
(7862, 35, 0, '{\"4\":true,\"8\":false}'),
(7863, 65, 0, '{\"4\":true,\"8\":false}'),
(7864, 20, 0, '[]'),
(7865, 35, 0, '[]'),
(7866, 60, 0, '[]'),
(7867, 35, 0, '[]'),
(7868, 50, 0, '{\"4\":true,\"8\":false}'),
(7869, 0, 0, '[]'),
(7870, 50, 0, '[]'),
(7871, 60, 0, '[]'),
(7872, 35, 0, '{\"4\":true,\"8\":false}'),
(7873, 45, 0, '{\"4\":true,\"8\":false}'),
(7874, 20, 0, '[]'),
(7875, 25, 0, '[]'),
(7876, 60, 0, '[]'),
(7877, 35, 0, '{\"4\":true,\"8\":false}'),
(7878, 65, 0, '{\"4\":true,\"8\":false}'),
(7879, 20, 0, '[]'),
(7880, 35, 0, '[]'),
(7881, 60, 0, '[]'),
(7882, 35, 0, '[]'),
(7883, 50, 0, '{\"4\":true,\"8\":false}'),
(8849, 45, 0, '{\"3\":true,\"7\":false}'),
(8850, 60, 0, '{\"3\":true,\"7\":false}'),
(8851, 130, 0, '{\"3\":true,\"7\":false}'),
(8852, 100, 0, '{\"3\":true,\"7\":false}'),
(8853, 80, 0, '{\"3\":true,\"7\":false}'),
(8854, 80, 0, '{\"3\":true,\"7\":false}'),
(8855, 50, 0, '{\"3\":true,\"7\":false}'),
(8856, 60, 0, '{\"3\":true,\"7\":false}'),
(8857, 40, 0, '{\"3\":true,\"7\":false}'),
(8858, 70, 0, '{\"3\":true,\"7\":false}'),
(8910, 42, 0, '{\"2\":true}'),
(8911, 22, 0, '{\"2\":true}'),
(8912, 37, 0, '{\"2\":true}'),
(8920, 37, 0, '{\"1\":true}'),
(8921, 22, 0, '{\"1\":true}'),
(8922, 42, 0, '{\"1\":true}'),
(8924, 110, 0, '[]'),
(8925, 130, 0, '[]'),
(8926, 120, 0, '{\"4\":true,\"8\":false}'),
(8927, 120, 0, '[]'),
(8928, 100, 0, '[]'),
(8929, 100, 0, '{\"4\":true,\"8\":false}'),
(8930, 100, 0, '[]'),
(8931, 120, 0, '[]'),
(8932, 100, 0, '{\"4\":true,\"8\":false}'),
(11305, 60, 0, '[]'),
(11306, 50, 0, '{\"4\":true,\"8\":false}'),
(11307, 55, 0, '[]'),
(11308, 55, 0, '{\"4\":true,\"8\":false}'),
(11309, 20, 0, '{\"4\":true,\"8\":false}'),
(11323, 25, 0, '[]'),
(12613, 58, 0, '{\"4\":true,\"8\":false}'),
(12648, 82, 0, '[]'),
(12649, 82, 0, '[]'),
(13760, 37, 0, '{\"1\":true}'),
(13838, 25, 0, '[]'),
(13871, 40, 0, '{\"4\":true,\"8\":false}'),
(13872, 40, 0, '{\"2\":true}'),
(13873, 40, 0, '{\"3\":true,\"7\":false}'),
(13880, 40, 0, '{\"1\":true}'),
(15400, 38, 0, '[]'),
(15404, 80, 0, '[]'),
(15414, 90, 0, '[]'),
(15451, 40, 0, '[]'),
(15454, 50, 0, '[]'),
(15492, 70, 0, '[]'),
(15643, 85, 0, '{\"3\":true,\"7\":false}'),
(15644, 50, 0, '{\"3\":true,\"7\":false}'),
(15647, 48, 0, '[]'),
(15648, 30, 0, '[]'),
(15649, 40, 0, '[]'),
(16111, 150, 0, '{\"3\":true,\"7\":false}'),
(18304, 90, 0, '[]'),
(18390, 65, 0, '{\"1\":true}'),
(18409, 65, 0, '{\"1\":true}'),
(18411, 65, 0, '{\"2\":true}'),
(18412, 65, 0, '{\"2\":true}'),
(18435, 90, 0, '[]'),
(18436, 70, 0, '[]'),
(18437, 70, 0, '[]'),
(18450, 62, 0, '[]'),
(18453, 90, 0, '{\"3\":true,\"7\":false}'),
(18454, 105, 0, '{\"3\":true,\"7\":false}'),
(20092, 15, 0, '[]'),
(20093, 15, 0, '[]'),
(20108, 50, 0, '{\"4\":true,\"8\":false}'),
(20139, 20, 0, '[]'),
(21690, 70, 0, '{\"3\":true,\"7\":false}'),
(21696, 0, 0, '[]'),
(22398, 75, 0, '{\"4\":true,\"8\":false}'),
(22399, 120, 0, '{\"4\":true,\"8\":false}'),
(22400, 250, 0, '{\"4\":true,\"8\":false}'),
(22401, 75, 0, '{\"4\":true,\"8\":false}'),
(22402, 120, 0, '{\"4\":true,\"8\":false}'),
(22403, 250, 0, '{\"4\":true,\"8\":false}'),
(22404, 75, 0, '{\"4\":true,\"8\":false}'),
(22405, 120, 0, '{\"4\":true,\"8\":false}'),
(22406, 250, 0, '{\"4\":true,\"8\":false}'),
(22407, 75, 0, '{\"4\":true,\"8\":false}'),
(22408, 120, 0, '{\"4\":true,\"8\":false}'),
(22409, 250, 0, '{\"4\":true,\"8\":false}'),
(22410, 75, 0, '{\"4\":true,\"8\":false}'),
(22411, 120, 0, '{\"4\":true,\"8\":false}'),
(22412, 250, 0, '{\"4\":true,\"8\":false}'),
(22413, 75, 0, '{\"4\":true,\"8\":false}'),
(22414, 120, 0, '{\"4\":true,\"8\":false}'),
(22415, 250, 0, '{\"4\":true,\"8\":false}'),
(22416, 75, 0, '{\"3\":true,\"7\":false}'),
(22417, 150, 0, '{\"3\":true,\"7\":false}'),
(22418, 250, 0, '{\"3\":true,\"7\":false}'),
(22419, 75, 0, '{\"3\":true,\"7\":false}'),
(22420, 150, 0, '{\"3\":true,\"7\":false}'),
(22421, 250, 0, '{\"3\":true,\"7\":false}');

-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `soul` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `onlinetime` int(11) NOT NULL DEFAULT '0',
  `deletion` bigint(15) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT '2520',
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  `create_ip` int(11) NOT NULL DEFAULT '0',
  `create_date` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `cast` tinyint(1) NOT NULL DEFAULT '0',
  `skill_critical_hit_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_damage` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_critical_hit_damage_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_life_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_mana_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_damage` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_damage_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_criticalhit_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_lifeleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_manaleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_lifeleech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `skill_manaleech_amount` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `marriage_status` tinyint(11) NOT NULL DEFAULT '0',
  `skill_critical_hit_chance` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `deleted`, `description`, `comment`, `create_ip`, `create_date`, `hidden`, `cast`, `skill_critical_hit_chance_tries`, `skill_critical_hit_damage`, `skill_critical_hit_damage_tries`, `skill_life_leech_chance`, `skill_life_leech_chance_tries`, `skill_life_leech_amount`, `skill_life_leech_amount_tries`, `skill_mana_leech_chance`, `skill_mana_leech_chance_tries`, `skill_mana_leech_amount`, `skill_mana_leech_amount_tries`, `skill_criticalhit_chance_tries`, `skill_criticalhit_damage`, `skill_criticalhit_damage_tries`, `skill_criticalhit_chance`, `skill_lifeleech_chance`, `skill_manaleech_chance`, `skill_lifeleech_amount`, `skill_manaleech_amount`, `marriage_status`, `skill_critical_hit_chance`, `created`) VALUES
(13, 'God', 3, 8, 1, 0, 180, 180, 0, 124, 78, 0, 124, 746, 3, 50000, 35, 35, 0, 0, 1, 1010, 1000, 7, '', 10000, 1, 1678122953, 16781996, 1, 0, 0, 1678173845, 63, 126891, 0, 1005276, 43200, -1, 2520, 49, 0, 49, 0, 49, 0, 10, 0, 50, 0, 10, 0, 10, 0, 0, '', '', 0, 1465696208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 'Admin', 3, 9, 1, 0, 100, 100, 0, 10, 10, 10, 10, 136, 0, 0, 100, 100, 0, 0, 1, 1000, 1005, 7, '', 10000, 0, 1678041781, 16782508, 1, 0, 0, 1678041831, 0, 50, 0, 0, 43200, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041702),
(15, 'Rook Sample', 1, 9, 1, 0, 150, 150, 0, 118, 114, 38, 57, 130, 0, 0, 0, 0, 0, 100, 1, 1000, 1000, 7, '', 400, 1, 1678041704, 2130706433, 1, 0, 0, 1678041704, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041704),
(16, 'Sorcerer Sample', 1, 9, 8, 1, 185, 185, 4200, 118, 114, 38, 57, 130, 0, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1678041704, 2130706433, 1, 0, 0, 1678041704, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041704),
(17, 'Druid Sample', 1, 9, 8, 2, 185, 185, 4200, 118, 114, 38, 57, 130, 0, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1678041704, 2130706433, 1, 0, 0, 1678041704, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041704),
(18, 'Paladin Sample', 1, 9, 8, 3, 185, 185, 4200, 118, 114, 38, 57, 129, 0, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1678041704, 2130706433, 1, 0, 0, 1678041704, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041704),
(19, 'Knight Sample', 1, 9, 8, 4, 185, 185, 4200, 118, 114, 38, 57, 131, 0, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1678041704, 2130706433, 1, 0, 0, 1678041704, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1678041704),
(20, 'Teste', 1, 9, 8, 1, 185, 185, 4200, 118, 114, 38, 57, 130, 0, 0, 90, 90, 0, 100, 1, 0, 0, 0, '', 470, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1687902064);

-- --------------------------------------------------------

--
-- Estrutura da tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_inboxitems`
--

INSERT INTO `player_inboxitems` (`player_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES
(13, 101, 0, 12649, 1, ''),
(13, 102, 0, 22398, 1, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL DEFAULT '0',
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(14, 3, 101, 1987, 1, ''),
(14, 4, 102, 2651, 1, ''),
(14, 6, 103, 2382, 1, ''),
(14, 10, 104, 2050, 1, ''),
(14, 101, 105, 2674, 1, 0x0f01),
(13, 1, 101, 12645, 1, ''),
(13, 2, 102, 7890, 1, 0x160100),
(13, 3, 103, 1988, 1, ''),
(13, 7, 104, 9777, 1, ''),
(13, 10, 105, 6529, 1, 0x0f01),
(13, 103, 106, 2152, 2, 0x0f02),
(13, 103, 107, 2160, 56, 0x0f38),
(13, 103, 108, 5926, 1, ''),
(13, 103, 109, 2268, 3, 0x0f03),
(13, 108, 110, 2365, 1, ''),
(13, 108, 111, 2152, 45, 0x0f2d),
(13, 108, 112, 2273, 3, 0x0f03),
(13, 108, 113, 2268, 1, 0x0f01),
(13, 110, 114, 12559, 1, ''),
(13, 110, 115, 12565, 1, ''),
(13, 110, 116, 12563, 1, ''),
(13, 110, 117, 12561, 1, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_rewards`
--

CREATE TABLE `player_rewards` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(13, 0, 1473207922),
(13, 1, 1473345436),
(13, 900, 1),
(13, 954, 4),
(13, 960, 1),
(13, 2080, 1),
(13, 2081, 1),
(13, 2082, 1),
(13, 2083, 1),
(13, 2085, 1),
(13, 3250, 1),
(13, 8818, 1),
(13, 8819, 1),
(13, 10544, 1),
(13, 10545, 1),
(13, 10546, 1),
(13, 10547, 1),
(13, 10548, 1),
(13, 10549, 1),
(13, 12010, 1),
(13, 12055, 1),
(13, 20279, 2),
(13, 24828, 1),
(13, 25611, 1),
(13, 50135, 1),
(13, 50702, 2),
(13, 50712, 1),
(13, 50722, 0),
(13, 56221, 1),
(13, 64113, 1),
(13, 88419, 1),
(13, 99963, 1),
(13, 110002, 0),
(13, 110015, 0),
(13, 110019, 0),
(13, 10002011, 94);

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('motd_hash', ''),
('motd_num', '0'),
('players_record', '3');

-- --------------------------------------------------------

--
-- Estrutura da tabela `store_history`
--

CREATE TABLE `store_history` (
  `account_id` int(11) NOT NULL,
  `mode` smallint(2) NOT NULL DEFAULT '0',
  `description` varchar(3500) NOT NULL,
  `coin_amount` int(12) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` text NOT NULL,
  `categoria` int(11) NOT NULL,
  `link` varchar(11) NOT NULL,
  `ativo` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `videos_categorias`
--

CREATE TABLE `videos_categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `videos_comentarios`
--

CREATE TABLE `videos_comentarios` (
  `id` int(11) NOT NULL,
  `mensagem` text NOT NULL,
  `character` varchar(255) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `topico` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote`
--

CREATE TABLE `znote` (
  `id` int(10) NOT NULL,
  `version` varchar(30) NOT NULL COMMENT 'Znote AAC version',
  `installed` int(10) NOT NULL,
  `cached` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote`
--

INSERT INTO `znote` (`id`, `version`, `installed`, `cached`) VALUES
(1, '1.5_SVN', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_accounts`
--

CREATE TABLE `znote_accounts` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL,
  `created` int(10) NOT NULL,
  `points` int(10) DEFAULT '0',
  `cooldown` int(10) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `activekey` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(20) NOT NULL,
  `secret` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_accounts`
--

INSERT INTO `znote_accounts` (`id`, `account_id`, `ip`, `created`, `points`, `cooldown`, `active`, `activekey`, `flag`, `secret`) VALUES
(1, 1, 0, 1, 0, 0, 0, 0, '', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_changelog`
--

CREATE TABLE `znote_changelog` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_deleted_characters`
--

CREATE TABLE `znote_deleted_characters` (
  `id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum`
--

CREATE TABLE `znote_forum` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `access` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `guild_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_forum`
--

INSERT INTO `znote_forum` (`id`, `name`, `access`, `closed`, `hidden`, `guild_id`) VALUES
(1, 'Staff Board', 4, 0, 0, 0),
(2, 'Tutors Board', 2, 0, 0, 0),
(3, 'Discussion', 1, 0, 0, 0),
(4, 'Feedback', 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_posts`
--

CREATE TABLE `znote_forum_posts` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_threads`
--

CREATE TABLE `znote_forum_threads` (
  `id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `sticky` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_global_storage`
--

CREATE TABLE `znote_global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_guild_wars`
--

CREATE TABLE `znote_guild_wars` (
  `id` int(11) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_images`
--

CREATE TABLE `znote_images` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `desc` text NOT NULL,
  `date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` varchar(30) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_news`
--

CREATE TABLE `znote_news` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `date` int(11) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paygol`
--

CREATE TABLE `znote_paygol` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paypal`
--

CREATE TABLE `znote_paypal` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accid` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_paypal`
--

INSERT INTO `znote_paypal` (`id`, `txn_id`, `email`, `accid`, `price`, `points`) VALUES
(1, '1', 'patsadow2@gmail.com', 8, 10, 100);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_players`
--

CREATE TABLE `znote_players` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `hide_char` tinyint(4) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_players`
--

INSERT INTO `znote_players` (`id`, `player_id`, `created`, `hide_char`, `comment`) VALUES
(1, 1, 1, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_player_reports`
--

CREATE TABLE `znote_player_reports` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `posx` int(6) NOT NULL,
  `posy` int(6) NOT NULL,
  `posz` int(6) NOT NULL,
  `report_description` varchar(255) NOT NULL,
  `date` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop`
--

CREATE TABLE `znote_shop` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_logs`
--

CREATE TABLE `znote_shop_logs` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_orders`
--

CREATE TABLE `znote_shop_orders` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets`
--

CREATE TABLE `znote_tickets` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `ip` int(11) NOT NULL,
  `creation` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets_replies`
--

CREATE TABLE `znote_tickets_replies` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `message` text NOT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors`
--

CREATE TABLE `znote_visitors` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors_details`
--

CREATE TABLE `znote_visitors_details` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_forum`
--

CREATE TABLE `z_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `section` int(3) NOT NULL DEFAULT '0',
  `replies` int(20) NOT NULL DEFAULT '0',
  `views` int(20) NOT NULL DEFAULT '0',
  `author_aid` int(20) NOT NULL DEFAULT '0',
  `author_guid` int(20) NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL,
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_html` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int(20) NOT NULL DEFAULT '0',
  `last_edit_aid` int(20) NOT NULL DEFAULT '0',
  `edit_date` int(20) NOT NULL DEFAULT '0',
  `post_ip` varchar(15) NOT NULL DEFAULT '0.0.0.0',
  `icon_id` int(10) NOT NULL DEFAULT '0',
  `sticked` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_forum`
--

INSERT INTO `z_forum` (`id`, `first_post`, `last_post`, `section`, `replies`, `views`, `author_aid`, `author_guid`, `post_text`, `post_topic`, `post_smile`, `post_html`, `post_date`, `last_edit_aid`, `edit_date`, `post_ip`, `icon_id`, `sticked`, `closed`) VALUES
(1, 1, 1475006157, 1, 0, 0, 8, 13, 'testetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste\r\ntestetestetestetestetestetestetestetestetestetestetesteteste', 'TEste', 0, 0, 1475006157, 0, 0, '179.255.222.134', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_network_box`
--

CREATE TABLE `z_network_box` (
  `id` int(11) NOT NULL,
  `network_name` varchar(10) NOT NULL,
  `network_link` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_network_box`
--

INSERT INTO `z_network_box` (`id`, `network_name`, `network_link`) VALUES
(1, 'facebook', 'pages/Globalzhao/351502481668782'),
(2, 'twitter', 'tibia');

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_news_tickers`
--

CREATE TABLE `z_news_tickers` (
  `date` int(11) NOT NULL DEFAULT '1',
  `author` int(11) NOT NULL,
  `image_id` int(3) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `hide_ticker` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_news_tickers`
--

INSERT INTO `z_news_tickers` (`date`, `author`, `image_id`, `text`, `hide_ticker`) VALUES
(1475006357, 8, 0, 'teste', 1),
(1475006357, 8, 0, 'teste', 1),
(1475006564, 8, 0, 'teste', 1),
(1475006609, 8, 0, 'welcome', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_ots_comunication`
--

CREATE TABLE `z_ots_comunication` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_ots_guildcomunication`
--

CREATE TABLE `z_ots_guildcomunication` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `end` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `votes_all` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_item`
--

CREATE TABLE `z_shopguild_history_item` (
  `id` int(11) NOT NULL,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_history_pacc`
--

CREATE TABLE `z_shopguild_history_pacc` (
  `id` int(11) NOT NULL,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `pacc_days` int(11) NOT NULL DEFAULT '0',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shopguild_offer`
--

CREATE TABLE `z_shopguild_offer` (
  `id` int(11) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_shopguild_offer`
--

INSERT INTO `z_shopguild_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, `offer_type`, `offer_description`, `offer_name`, `pid`) VALUES
(1, 1, 2160, 10, 0, 0, 'item', '10 crystal coin para seu char.', 'Crystal Coin', 0),
(2, 10, 2640, 1, 0, 0, 'item', 'Soft Boots regenerate 10 health per 2 seconds and 15 mana per 2 seconds.', 'Pair of Soft Boots', 0),
(3, 2, 2195, 1, 0, 0, 'item', 'boots of haste (speed +20).', 'Boots of Haste', 0),
(4, 5, 18409, 1, 0, 0, 'item', 'Fire ataque max 85 e magic +1.', 'Wand of Everblazing', 0),
(5, 5, 18411, 1, 0, 0, 'item', 'Earth ataque max 85 e magic +1.', 'Muck Rod', 0),
(6, 5, 2400, 1, 0, 0, 'item', 'Atributos (Atk:48, Def:35 +3).', 'Magic Sword', 0),
(7, 7, 2431, 1, 0, 0, 'item', 'Atributos (Atk:50, Def:30 +3).', 'Stonecutter Axe', 0),
(8, 6, 8928, 1, 0, 0, 'item', 'Atributos (Atk:50, Def:30 +2).', 'Obsidian Truncheon', 0),
(9, 5, 18453, 1, 0, 0, 'item', 'Atributos (Range:6, Atk+4, Hit%+3).', 'Crystal Crossbow', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_history_item`
--

CREATE TABLE `z_shop_history_item` (
  `id` int(11) NOT NULL,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT '0',
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `offer_id` varchar(255) NOT NULL DEFAULT '',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT '0',
  `trans_real` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_shop_history_item`
--

INSERT INTO `z_shop_history_item` (`id`, `to_name`, `to_account`, `from_nick`, `from_account`, `price`, `offer_id`, `trans_state`, `trans_start`, `trans_real`) VALUES
(1, 'Mitsuig', 8, 'Anonymous', 8, 5, 'Crude Umbral Blade', 'realized', 1475012161, 1475061413),
(2, 'Mitsuig', 8, 'Anonymous', 8, 4, 'Blade of Corruption', 'realized', 1475012177, 1475061413),
(3, 'Testee', 129, 'Anonymous', 8, 40, 'Reed Lurker', 'realized', 1475012394, 1475012423),
(4, 'Testee', 129, 'Anonymous', 8, 30, 'Coralripper', 'realized', 1475012592, 1475012603),
(5, 'Testee', 129, 'Anonymous', 8, 7, 'Uniwheel', 'realized', 1475012780, 1475012784),
(6, 'Doom Loko', 133, 'Anonymous', 8, 40, 'Mould Shell', 'realized', 1475064399, 1475064413),
(7, 'Testee', 129, 'Anonymous', 8, 2, 'Outfit Mage', 'realized', 1475076865, 1475076983),
(8, 'Testee', 129, 'Anonymous', 8, 10, 'Yalahari Mask', 'realized', 1475080143, 1475080163),
(9, 'Testee', 129, 'Anonymous', 8, 20, 'Empiric Boots', 'realized', 1475088773, 1475088773),
(10, 'Testee', 129, 'Anonymous', 8, 8, 'Spellbook of Ancient Arcana', 'realized', 1475088795, 1475088803),
(11, 'Testee', 129, 'Anonymous', 8, 10, 'Dark Trinity Mace', 'realized', 1475088819, 1475088833),
(12, 'Testee', 129, 'Anonymous', 8, 15, 'Umbral Master Spellbook', 'realized', 1475088971, 1475088983),
(13, 'Testee', 129, 'Anonymous', 8, 30, 'Plumfish', 'realized', 1475089276, 1475089283),
(14, 'Testee', 129, 'Anonymous', 8, 75, 'Thornfire Wolf', 'realized', 1475089413, 1475089433),
(15, 'Testee', 129, 'Anonymous', 8, 40, 'Vortexion', 'realized', 1475089713, 1475089733),
(16, 'God', 8, 'Anonymous', 8, 4, 'War Bear', 'realized', 1475090388, 1475105813),
(17, 'Testee', 129, 'Anonymous', 8, 5, 'Widow Queen', 'realized', 1475090441, 1475090453),
(18, 'Testee', 129, 'Anonymous', 8, 4, 'War Bear', 'realized', 1475090543, 1475090543),
(19, 'Testee', 129, 'Anonymous', 8, 12, 'Blazebringer', 'realized', 1475090881, 1475090903);

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_shop_offer`
--

CREATE TABLE `z_shop_offer` (
  `id` int(11) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `itemid1` int(11) NOT NULL DEFAULT '0',
  `count1` int(11) NOT NULL DEFAULT '0',
  `itemid2` int(11) NOT NULL DEFAULT '0',
  `count2` int(11) NOT NULL DEFAULT '0',
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `offer_category` int(11) NOT NULL,
  `offer_new` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `z_shop_offer`
--

INSERT INTO `z_shop_offer` (`id`, `points`, `itemid1`, `count1`, `itemid2`, `count2`, `offer_type`, `offer_description`, `offer_name`, `offer_category`, `offer_new`, `pid`) VALUES
(1327, 4, 12649, 1, 0, 0, 'item', 'A decent sword-weapon. Attack: 48. Defense: 29 +2. Weight: 64 oz.', 'Blade of Corruption', 2, 0, 0),
(1328, 1, 2195, 1, 0, 0, 'item', '+20 speed', 'Boots of Haste', 2, 0, 0),
(1329, 10, 8927, 1, 0, 0, 'item', 'One of the best one handed club-weapon in the game. Attack: 51. Defense: 32 -1. Weight: 99 oz.', 'Dark Trinity Mace', 2, 0, 0),
(1330, 5, 2494, 1, 0, 0, 'item', 'Demon Armor provide 16 armor.', 'Demon Armor', 2, 0, 0),
(1331, 8, 2495, 1, 0, 0, 'item', 'Demon Legs provide 9 armor.', 'Demon Legs', 2, 0, 0),
(1332, 10, 15410, 1, 0, 0, 'item', 'Arguably the best boots in the game for a knight. Provides 3 armor and 5% protection against physical damage at the cost of -5 speed. It can only be wielded by knights of Level 150 or higher.', 'Depth Calcei', 2, 0, 0),
(1333, 8, 15408, 1, 0, 0, 'item', 'A replacement for helmet of the deep, provides much more armor and enables underwater exploration by protecting you 100% against drown damage. It can only be wielded by players of Level 150 or higher.', 'Depth Galea', 2, 0, 0),
(1334, 10, 15407, 1, 0, 0, 'item', 'One of the best offensive paladin armor in the game, it provides 16 armor, +3 distance fighting and 5% protection against death damage. It can only be wielded by paladins of Level 150 or higher.', 'Depth Lorica', 2, 0, 0),
(1335, 8, 15409, 1, 0, 0, 'item', 'Arm: 8, with 15% protection against mana drain. It can only be wielded by sorcerers and druids.', 'Depth Ocrea', 2, 0, 0),
(1336, 5, 12646, 1, 0, 0, 'item', 'Arm: 3, provides +15 speed. It can only be wielded by knights and paladins of Level 80 or higher.', 'Draken Boots', 2, 0, 0),
(1338, 10, 12645, 1, 0, 0, 'item', 'Arm: 9, provides +1 distance fighting and 3% protection against death damage. It can only be wielded by paladins of Level 100 or higher.', 'Elite Draken Helmet', 2, 0, 0),
(1339, 8, 8888, 1, 0, 0, 'item', 'Arm: 15, provides +3 distance fighting. It can only be wielded by paladins of Level 100 or higher.', 'Master Archer\'s Armor', 2, 0, 0),
(1340, 12, 15406, 1, 0, 0, 'item', 'Arm: 16, provides +3 shielding and 8% protection against physical damage. It can only be wielded by knights of Level 200 or higher.', 'Ornate Chestplate', 2, 0, 0),
(1341, 10, 15412, 1, 0, 0, 'item', 'Arm: 8, provides 5% protection against physical damage. It can only be wielded by knights of Level 185 or higher.', 'Ornate Legs', 2, 0, 0),
(1342, 8, 15413, 1, 0, 0, 'item', 'Arguably the best shield in the game. Def: 36, and provides 5% protection against physical damage. It can only be wielded by knights of Level 130 or higher.', 'Ornate Shield', 2, 0, 0),
(1343, 8, 12642, 1, 0, 0, 'item', 'Arguably the best shield in the game. Def: 36, and provides 5% protection against physical damage. It can only be wielded by knights of Level 130 or higher.', 'Royal Draken Mail', 2, 0, 0),
(1344, 10, 12643, 1, 0, 0, 'item', 'Arm: 12, provides +2 magic level and 5% protection against fire damage. It can only be wielded by sorcerers and druids of Level 100 or higher.', 'Royal Scale Robe', 2, 0, 0),
(1345, 8, 12644, 1, 0, 0, 'item', 'A decent choice for a sword-fighter because it gives +3 sword fighting. Defense: 36. Weight: 49 oz. It can only be wielded properly by knights of level 80 or higher.', 'Shield of Corruption', 2, 0, 0),
(1346, 10, 2640, 1, 0, 0, 'item', 'Soft Boots regenerate 15 health per 2 seconds and 10 mana per second.', 'Soft Boots', 2, 0, 0),
(1347, 10, 8925, 1, 0, 0, 'item', 'One of the best one handed axe-weapon in the game. Attack: 52. Defense: 29 +3. Weight: 110 oz. Level req: 130.', 'Solar Axe', 2, 0, 0),
(1348, 8, 16112, 1, 0, 0, 'item', 'The best spellbook. Defense: 19. Magic level: +4. protection death +5%. Weight: 25 oz. Level req: 150.', 'Spellbook of Ancient Arcana', 2, 0, 0),
(1349, 8, 16111, 1, 0, 0, 'item', 'One of the best crossbows. Attack: +9. Range: 6. Hit% +1. Weight: 126 oz. Level req: 150.', 'Thorn Spitter', 2, 0, 0),
(1350, 10, 9777, 1, 0, 0, 'item', 'Arm: 8, provides +2 distance fighting and 5% protection against death damage. It can only be wielded by paladins of Level 80 or higher.', 'Yalahari Leg Piece', 2, 0, 0),
(1351, 10, 9778, 1, 0, 0, 'item', 'Arm: 5, provides +2 magic level. It can only be wielded by sorcerers and druids of Level 80 or higher.', 'Yalahari Mask', 2, 0, 0),
(1352, 4, 11302, 1, 0, 0, 'item', 'Arm: 9, provides 5% protection against physical damage. It can only be wielded by knights and paladins.', 'Zaoan Helmet', 2, 0, 0),
(1353, 4, 18390, 1, 0, 0, 'item', 'Deals 70-100 energy damage. It can only be wielded properly by sorcerers of Level 65 or higher.', 'Wand of Defiance', 2, 0, 0),
(1354, 4, 18412, 1, 0, 0, 'item', 'Deals 70-100 ice damage. It can only be wielded properly by druids of Level 65 or higher.', 'Glacial Rod', 2, 0, 0),
(1355, 5, 22398, 1, 0, 0, 'item', 'You see a crude umbral blade (Atk:48, Def:26 +1).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Blade', 2, 0, 0),
(1356, 10, 22399, 1, 0, 0, 'item', 'You see a umbral blade (Atk:50, Def:29 +2).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Blade', 2, 0, 0),
(1357, 15, 22400, 1, 0, 0, 'item', 'You see a umbral masterblade (Atk:52, Def:31 +3, sword fighting +1).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Masterblade', 2, 0, 0),
(1358, 5, 22401, 1, 0, 0, 'item', 'You see a crude umbral slayer (Atk:51, Def:29).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Slayer', 2, 0, 0),
(1359, 10, 22402, 1, 0, 0, 'item', 'You see a umbral slayer (Atk:52, Def:31).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Slayer', 2, 0, 0),
(1360, 15, 22403, 1, 0, 0, 'item', 'You see a umbral master slayer (Atk:54, Def:35, sword fighting +3).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Master Slayer', 2, 0, 0),
(1361, 5, 22404, 1, 0, 0, 'item', 'You see a crude umbral axe (Atk:49, Def:24 +1).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Axe', 2, 0, 0),
(1362, 10, 22405, 1, 0, 0, 'item', 'You see a umbral axe (Atk:51, Def:27 +2).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Axe', 2, 0, 0),
(1363, 15, 22406, 1, 0, 0, 'item', 'You see a umbral master axe (Atk:53, Def:30 +3, axe fighting +1).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Master Axe', 2, 0, 0),
(1364, 5, 22407, 1, 0, 0, 'item', 'You see a crude umbral chopper (Atk:51, Def:27).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Chopper', 2, 0, 0),
(1365, 10, 22408, 1, 0, 0, 'item', 'You see a umbral chopper (Atk:52, Def:30).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Chopper', 2, 0, 0),
(1366, 15, 22409, 1, 0, 0, 'item', 'You see a umbral master chopper (Atk:54, Def:34, axe fighting +3).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Master Chopper', 2, 0, 0),
(1367, 5, 22410, 1, 0, 0, 'item', 'You see a crude umbral mace (Atk:48, Def:22 +1).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Mace', 2, 0, 0),
(1368, 10, 22411, 1, 0, 0, 'item', 'You see a umbral mace (Atk:50, Def:26 +2).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Mace', 2, 0, 0),
(1369, 15, 22412, 1, 0, 0, 'item', 'You see a umbral master mace (Atk:52, Def:30 +3, club fighting +1).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Master Mace', 2, 0, 0),
(1370, 5, 22413, 1, 0, 0, 'item', 'You see a crude umbral hammer (Atk:51, Def:27).\r\nIt can only be wielded properly by knights of level 75 or higher.', 'Crude Umbral Hammer', 2, 0, 0),
(1371, 10, 22414, 1, 0, 0, 'item', 'You see a umbral hammer (Atk:53, Def:30).\r\nIt can only be wielded properly by knights of level 120 or higher.', 'Umbral Hammer', 2, 0, 0),
(1372, 15, 22415, 1, 0, 0, 'item', 'You see a umbral master hammer (Atk:55, Def:34, club fighting +3).\r\nIt can only be wielded properly by knights of level 250 or higher.', 'Umbral Master Hammer', 2, 0, 0),
(1373, 5, 22419, 1, 0, 0, 'item', 'You see a crude umbral crossbow (Range:5, Atk+3, Hit%+1).\r\nIt can only be wielded properly by paladins of level 75 or higher.', 'Crude Umbral Crossbow', 2, 0, 0),
(1374, 10, 22420, 1, 0, 0, 'item', 'You see a umbral crossbow (Range:5, Atk+6, Hit%+2).\r\nIt can only be wielded properly by paladins of level 120 or higher.', 'Umbral Crossbow', 2, 0, 0),
(1375, 15, 22421, 1, 0, 0, 'item', 'You see a umbral master crossbow (Range:5, Atk+9, Hit%+4).\r\nIt can only be wielded properly by paladins of level 250 or higher.', 'Umbral Master Crossbow', 2, 0, 0),
(1376, 5, 22416, 1, 0, 0, 'item', 'You see a crude umbral bow (Range:7, Atk+2, Hit%+5).\r\nIt can only be wielded properly by paladins of level 75 or higher.', 'Crude Umbral Bow', 2, 0, 0),
(1377, 10, 22417, 1, 0, 0, 'item', 'You see a umbral bow (Range:7, Atk+4, Hit%+5).\r\nIt can only be wielded properly by paladins of level 120 or higher.', 'Umbral Bow', 2, 0, 0),
(1378, 15, 22418, 1, 0, 0, 'item', 'You see a umbral master bow (Range:7, Atk+6, Hit%+5).\r\nIt can only be wielded properly by paladins of level 250 or higher.', 'Umbral Master Bow', 2, 0, 0),
(1379, 5, 22422, 1, 0, 0, 'item', 'You see a crude umbral spellbook (Def:14, magic level +1, protection energy +2%, earth +2%, fire +2%, ice +2%).\r\nIt can only be wielded properly by sorcerers and druids of level 75 or higher.', 'Crude Umbral Spellbook', 2, 0, 0),
(1380, 10, 22423, 1, 0, 0, 'item', 'You see a umbral spellbook (Def:16, magic level +2, protection energy +3%, earth +3%, fire +3%, ice +3%).\r\nIt can only be wielded properly by sorcerers and druids of level 120 or higher.', 'Umbral Spellbook', 2, 0, 0),
(1381, 15, 22424, 1, 0, 0, 'item', 'You see a umbral master spellbook (Def:20, magic level +4, protection energy +5%, earth +5%, fire +5%, ice +5%).\r\nIt can only be wielded properly by sorcerers and druids of level 250 or higher.', 'Umbral Master Spellbook', 2, 0, 0),
(1385, 5, 2160, 100, 0, 0, 'item', 'Out of money? This will be a good start.', '100 crystal coins', 2, 0, 0),
(1386, 4, 12544, 1, 0, 0, 'item', 'Recover all your stamina. Only 1 charge to use.', 'Sweet Mangonaise Elixir', 2, 0, 0),
(1396, 35, 16101, 1, 0, 0, 'item', '30 shop coins will be added to your account when using a premium scroll.', 'Premium Scroll', 2, 0, 0),
(1415, 50, 2471, 1, 0, 0, 'item', 'You see a golden helmet (Arm:12). It weighs 32.00 oz. It is the famous Helmet of the Stars.', 'Golden Helmet', 2, 0, 0),
(1416, 7, 8882, 1, 0, 0, 'item', 'You see an earthborn titan armor (Arm:15, axe fighting +2, protection earth +5%, fire -5%). It can only be wielded properly by knights of level 100 or higher. It weighs 120.00 oz.', 'Earthborn titan armor', 2, 0, 0),
(1417, 7, 8883, 1, 0, 0, 'item', 'You see a windborn colossus armor (Arm:15, club fighting +2, protection energy +5%, earth -5%). It can only be wielded properly by knights of level 100 or higher. It weighs 120.00 oz.', 'Windborn colossus armor', 2, 0, 0),
(1418, 7, 8881, 1, 0, 0, 'item', 'You see a fireborn giant armor (Arm:15, sword fighting +2, protection fire +5%, ice -5%). It can only be wielded properly by knights of level 100 or higher. It weighs 120.00 oz.', 'Fireborn giant armor', 2, 0, 0),
(1419, 5, 18465, 1, 0, 0, 'item', 'You see a shiny blade (Atk:50, Def:35 +3, sword fighting +1). It can only be wielded properly by players of level 120 or higher. It weighs 45.00 oz.', 'Shiny Blade', 2, 0, 0),
(1420, 5, 18451, 1, 0, 0, 'item', 'You see a crystalline axe (Atk:51, Def:29 +3, axe fighting +1). It can only be wielded properly by players of level 120 or higher. It weighs 76.00 oz. Even in the light of day, the stars seem to reflect in each facet of this crystalline axe.', 'Crystalline axe', 2, 0, 0),
(1421, 5, 18452, 1, 0, 0, 'item', 'You see a mycological mace (Atk:50, Def:31 +3, club fighting +1). It can only be wielded properly by players of level 120 or higher. It weighs 59.00 oz.', 'Mycological Mace', 2, 0, 0),
(1422, 30, 2522, 1, 0, 0, 'item', '22:32 You see a great shield (Def:38).\r\nIt weighs 84.00 oz.\r\nThe shield is made of dragon scales.', 'Great shield', 2, 0, 0),
(1423, 50, 2523, 1, 0, 0, 'item', 'You see a blessed shield (Def:40).\r\nIt weighs 68.00 oz.\r\nThe shield grants divine protection.', 'Blessed Shield', 2, 0, 0),
(1424, 4, 15411, 1, 0, 0, 'item', 'You see a depth scutum (Def:25, magic level +2). It can only be wielded properly by sorcerers and druids of level 120 or higher. It weighs 30.00 oz.', 'Depth scutum', 2, 0, 0),
(1425, 5, 18398, 1, 0, 0, 'item', 'You see a gill gugel (Arm:5, magic level +2, protection earth +6%, fire -6%). It can only be wielded properly by sorcerers and druids of level 150 or higher. It weighs 9.00 oz.', 'Gill gugel', 2, 0, 0),
(1426, 7, 21725, 1, 0, 0, 'item', 'You see a furious frock (Arm:12, magic level +2, protection fire +5%). It can only be wielded properly by sorcerers and druids of level 130 or higher. It weighs 34.00 oz.', 'Furious frock', 2, 0, 0),
(1427, 5, 18399, 1, 0, 0, 'item', 'You see a gill coat (Arm:12, magic level +1, protection earth +10%, fire -10%). It can only be wielded properly by sorcerers and druids of level 150 or higher. It weighs 19.00 oz.', 'Gill coat', 2, 0, 0),
(1428, 6, 18400, 1, 0, 0, 'item', 'You see a gill legs (Arm:7, magic level +1, protection earth +8%, fire -8%). It can only be wielded properly by sorcerers and druids of level 150 or higher. It weighs 28.00 oz.', 'Gill legs', 2, 0, 0),
(1429, 7, 18401, 1, 0, 0, 'item', 'You see a spellbook of vigilance (Def:20, magic level +3, protection earth +3%, fire -3%). It can only be wielded properly by sorcerers and druids of level 130 or higher. It weighs 27.00 oz. It shows your spells and can also shield against attacks when worn.', 'Spellbook of vigilance', 2, 0, 0),
(1430, 6, 21700, 1, 0, 0, 'item', 'You see a icy culotte (Arm:8, protection ice +8%). It can only be wielded properly by sorcerers and druids. It weighs 15.00 oz.', 'Icy culotte', 2, 0, 0),
(1431, 10, 18423, 20, 0, 0, 'item', 'You see 20 major crystalline tokens.\r\nThey weigh 70.00 oz.', '20 Major Crystalline Tokens', 2, 0, 0),
(1433, 4, 2798, 10, 0, 0, 'item', 'You see 10 blood herbs.\r\nThey weigh 12.00 oz.', '10 Blood Herb', 2, 0, 0),
(1434, 2, 2151, 10, 0, 0, 'item', 'You see 10 talons.\r\nThey weigh 2.00 oz.\r\nThere are many rumours about these magic gems.', '10 Talons', 2, 0, 0),
(1435, 10, 2503, 1, 0, 0, 'item', 'You see a dwarven armor (Arm:10, protection physical +5%).\r\nIt weighs 130.00 oz.', 'Dwarven Armor', 2, 0, 0),
(1436, 10, 2504, 1, 0, 0, 'item', 'You see dwarven legs (Arm:7, protection physical +3%).\r\nIt weighs 49.00 oz.', 'Dwarven Legs', 2, 0, 0),
(1444, 20, 2358, 1, 0, 0, 'item', 'You see a Empiric Boots (speed +40). Regeneracao mana/hp: 50/s', 'Empiric Boots', 2, 0, 0),
(1446, 15, 8931, 1, 0, 0, 'item', 'You see the epiphany (Atk:50, Def:35 +3).\r\nIt can only be wielded properly by players of level 120 or higher.\r\nIt weighs 45.00 oz.', 'The Epiphany', 2, 0, 0),
(1448, 5, 20620, 1, 0, 0, 'item', 'You see a zaoan chess box (Vol:32).\r\nIt weighs 38.00 oz.\r\nThis chess box is made of jade and obsidian. It will hold a full set of 32 zaoan chess figures.', 'Zaoan chess box', 2, 0, 0),
(1449, 8, 13030, 1, 0, 0, 'item', 'Com este item vocÃª pode alterar seu Sexo.', 'ChangeSex Doll', 2, 0, 0),
(1450, 8, 11144, 1, 0, 0, 'item', 'Com este item vocÃª pode remover seu RedSkull ou seu BlackSkull. Para usar este item vocÃª deve estar em Protection Zone.', 'RemoveSkull Doll', 2, 0, 0),
(1451, 7, 8884, 1, 0, 0, 'item', 'Oceanborn Leviathan Armor (Arm:15, shielding +1, protection energy -5%, ice +5%). It can only be wielded properly by knights of level 100 or higher.', 'Oceanborn Leviathan Armor', 2, 0, 0),
(1452, 6, 6391, 1, 0, 0, 'item', 'Nightmare Shield (Def:37). It weighs 32.00 oz. It was crafted by the ancient order of the nightmare knights.', 'Nightmare shield', 2, 0, 0),
(1453, 7, 6433, 1, 0, 0, 'item', 'Necromancer Shield (Def:37). It weighs 32.00 oz. It is enchanted with unholy, necromantic powers.', 'Necromancer Shield', 2, 0, 0),
(100, 75, 100, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo +30 speed.', 'Thornfire Wolf', 4, 1, 0),
(99, 40, 99, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Reed Lurker', 4, 0, 0),
(98, 40, 98, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Mould Shell', 4, 0, 0),
(97, 40, 97, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Swamp Snapper', 4, 0, 0),
(96, 40, 96, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Vortexion', 4, 0, 0),
(95, 40, 95, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Neon Sparkid', 4, 0, 0),
(94, 40, 94, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Sparkion', 4, 0, 0),
(93, 40, 93, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Leafscutler', 4, 0, 0),
(92, 40, 92, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Bloodcurl', 4, 0, 0),
(91, 40, 91, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Mouldpincer', 4, 0, 0),
(90, 40, 90, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Cinderhoof', 4, 0, 0),
(89, 40, 89, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Frostflare', 4, 0, 0),
(88, 40, 88, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Nightdweller', 4, 0, 0),
(87, 35, 87, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Rift Runner', 4, 0, 0),
(86, 30, 86, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Razorcreep', 4, 0, 0),
(85, 30, 85, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Nightstinger', 4, 0, 0),
(84, 30, 84, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Slagsnare', 4, 0, 0),
(83, 34, 83, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Silverneck', 4, 0, 0),
(82, 34, 82, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Noctungra', 4, 0, 0),
(81, 34, 81, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Silverneck', 4, 0, 0),
(80, 30, 80, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Plumfish', 4, 0, 0),
(79, 30, 79, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Coralripper', 4, 0, 0),
(78, 30, 78, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Sea Devil', 4, 0, 0),
(77, 30, 77, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Batcat', 4, 0, 0),
(76, 30, 76, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Venompaw', 4, 0, 0),
(75, 30, 75, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Flitterkatzen', 4, 0, 0),
(74, 24, 74, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Glooth Glider', 4, 0, 0),
(73, 24, 73, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Shadow Hart', 4, 0, 0),
(72, 24, 72, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Black Stag', 4, 0, 0),
(71, 16, 71, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Emperor Deer', 4, 0, 0),
(70, 25, 70, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Emerald Waccoon', 4, 0, 0),
(69, 25, 69, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Night Waccoon', 4, 0, 0),
(68, 25, 68, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Ringtail Waccoon', 4, 0, 0),
(67, 40, 67, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Floating Kashmir', 4, 0, 0),
(66, 40, 66, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Magic Carpet', 4, 0, 0),
(65, 40, 65, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Flying Divan', 4, 0, 0),
(64, 26, 64, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Glacier Vagabond', 4, 0, 0),
(63, 26, 63, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Highland Yak', 4, 0, 0),
(62, 26, 62, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tundra Rambler', 4, 0, 0),
(61, 25, 61, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Copper Fly', 4, 0, 0),
(60, 25, 60, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Steel Bee', 4, 0, 0),
(59, 25, 59, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Golden Dragonfly', 4, 0, 0),
(58, 28, 58, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Blackpelt', 4, 0, 0),
(57, 28, 57, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Poisonbane', 4, 0, 0),
(56, 28, 56, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Siegebreaker', 4, 0, 0),
(55, 30, 55, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Hailtorm Fury', 4, 0, 0),
(54, 30, 54, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Woodland Prince', 4, 0, 0),
(53, 30, 53, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Doombringer', 4, 0, 0),
(52, 35, 52, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Winter King', 4, 0, 0),
(51, 35, 51, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tempest', 4, 0, 0),
(50, 35, 50, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Nethersteed', 4, 0, 0),
(49, 35, 49, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Jade Pincer', 4, 0, 0),
(48, 35, 48, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Jade Lion', 4, 0, 0),
(47, 35, 47, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Flamesteed', 4, 0, 0),
(46, 35, 46, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Death Crawler', 4, 0, 0),
(45, 16, 45, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Carpacosaurus', 4, 0, 0),
(44, 16, 44, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Azudocus', 4, 0, 0),
(43, 16, 43, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Walker', 4, 0, 0),
(42, 16, 42, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Shock Head', 4, 0, 0),
(41, 30, 41, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Desert King', 4, 0, 0),
(40, 14, 40, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Noble Lion', 4, 0, 0),
(39, 15, 39, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Hellgrip', 4, 0, 0),
(38, 15, 38, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Ursagrodon', 4, 0, 0),
(37, 14, 37, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Platesaurian', 4, 0, 0),
(36, 35, 36, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tombstinger', 4, 0, 0),
(35, 10, 35, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Water Buffalo', 4, 0, 0),
(34, 12, 34, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Steelbeak', 4, 0, 0),
(33, 18, 33, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Crimson Ray', 4, 0, 0),
(32, 13, 32, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Gnarlhound', 4, 0, 0),
(31, 25, 31, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Dragonling', 4, 0, 0),
(30, 13, 30, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Magma Crawler', 4, 0, 0),
(29, 25, 29, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Ironblight', 4, 0, 0),
(28, 9, 28, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Manta Ray', 4, 0, 0),
(27, 5, 27, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Lady Bug', 4, 0, 0),
(24, 17, 24, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Shadow Draptor', 4, 0, 0),
(23, 17, 23, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Armoured War Horse', 4, 0, 0),
(21, 15, 21, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Scorpion King', 4, 0, 0),
(20, 6, 20, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Dromedary', 4, 0, 0),
(19, 5, 19, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tamed Panda', 4, 0, 0),
(18, 8, 18, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Kingly Deer', 4, 0, 0),
(17, 8, 17, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'War Horse', 4, 0, 0),
(16, 6, 16, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Crystal Wolf', 4, 0, 0),
(15, 7, 15, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Uniwheel', 4, 0, 0),
(14, 6, 14, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tiger Slug', 4, 0, 0),
(13, 5, 13, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Donkey', 4, 0, 0),
(12, 9, 12, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Undead Cavebear', 4, 0, 0),
(11, 9, 11, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Stampor', 4, 0, 0),
(10, 8, 10, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Rapid Boar', 4, 0, 0),
(9, 12, 9, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Blazebringer', 4, 0, 0),
(8, 8, 8, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Tin Lizzard', 4, 0, 0),
(7, 6, 7, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Titanica', 4, 0, 0),
(6, 7, 6, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Draptor', 4, 0, 0),
(5, 7, 5, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Midnight Panther', 4, 0, 0),
(4, 4, 4, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Black Sheep', 4, 0, 0),
(3, 4, 3, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'War Bear', 4, 0, 0),
(2, 5, 2, 0, 0, 0, 'mount', 'Voce recebera a montaria no jogo.', 'Racing Bird', 4, 0, 0),
(1454, 2, 130, 138, 0, 0, 'addon', 'Voce recebera a montaria no jogo.', 'Outfit Mage', 5, 0, 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`),
  ADD UNIQUE KEY `name_3` (`name`);

--
-- Índices para tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices para tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`),
  ADD KEY `account_id_2` (`account_id`),
  ADD KEY `account_id_3` (`account_id`),
  ADD KEY `account_id_4` (`account_id`);

--
-- Índices para tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `global_storage`
--
ALTER TABLE `global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Índices para tabela `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Índices para tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Índices para tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices para tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Índices para tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices para tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Índices para tabela `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Índices para tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Índices para tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices para tabela `live_casts`
--
ALTER TABLE `live_casts`
  ADD UNIQUE KEY `player_id_2` (`player_id`);

--
-- Índices para tabela `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Índices para tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `myaac_account_actions`
--
ALTER TABLE `myaac_account_actions`
  ADD KEY `account_id` (`account_id`);

--
-- Índices para tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  ADD PRIMARY KEY (`uid`);

--
-- Índices para tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices para tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_visitors`
--
ALTER TABLE `myaac_visitors`
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Índices para tabela `myaac_weapons`
--
ALTER TABLE `myaac_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Índices para tabela `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices para tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Índices para tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Índices para tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Índices para tabela `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Índices para tabela `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Índices para tabela `store_history`
--
ALTER TABLE `store_history`
  ADD KEY `account_id` (`account_id`);

--
-- Índices para tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Índices para tabela `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `videos_categorias`
--
ALTER TABLE `videos_categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `videos_comentarios`
--
ALTER TABLE `videos_comentarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote`
--
ALTER TABLE `znote`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_accounts`
--
ALTER TABLE `znote_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_changelog`
--
ALTER TABLE `znote_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum`
--
ALTER TABLE `znote_forum`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_global_storage`
--
ALTER TABLE `znote_global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Índices para tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_images`
--
ALTER TABLE `znote_images`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_news`
--
ALTER TABLE `znote_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_paygol`
--
ALTER TABLE `znote_paygol`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_paypal`
--
ALTER TABLE `znote_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_players`
--
ALTER TABLE `znote_players`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop`
--
ALTER TABLE `znote_shop`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_tickets`
--
ALTER TABLE `znote_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_visitors`
--
ALTER TABLE `znote_visitors`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_forum`
--
ALTER TABLE `z_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices para tabela `z_network_box`
--
ALTER TABLE `z_network_box`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_ots_guildcomunication`
--
ALTER TABLE `z_ots_guildcomunication`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_polls`
--
ALTER TABLE `z_polls`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_shopguild_history_item`
--
ALTER TABLE `z_shopguild_history_item`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_shopguild_history_pacc`
--
ALTER TABLE `z_shopguild_history_pacc`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_shopguild_offer`
--
ALTER TABLE `z_shopguild_offer`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_shop_history_item`
--
ALTER TABLE `z_shop_history_item`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2506;

--
-- AUTO_INCREMENT de tabela `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT de tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `videos_categorias`
--
ALTER TABLE `videos_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `videos_comentarios`
--
ALTER TABLE `videos_comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote`
--
ALTER TABLE `znote`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `znote_accounts`
--
ALTER TABLE `znote_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `znote_changelog`
--
ALTER TABLE `znote_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_forum`
--
ALTER TABLE `znote_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_images`
--
ALTER TABLE `znote_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_news`
--
ALTER TABLE `znote_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_paygol`
--
ALTER TABLE `znote_paygol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_paypal`
--
ALTER TABLE `znote_paypal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `znote_players`
--
ALTER TABLE `znote_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop`
--
ALTER TABLE `znote_shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_tickets`
--
ALTER TABLE `znote_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_visitors`
--
ALTER TABLE `znote_visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_forum`
--
ALTER TABLE `z_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `z_network_box`
--
ALTER TABLE `z_network_box`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_ots_guildcomunication`
--
ALTER TABLE `z_ots_guildcomunication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13382;

--
-- AUTO_INCREMENT de tabela `z_polls`
--
ALTER TABLE `z_polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shopguild_history_item`
--
ALTER TABLE `z_shopguild_history_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shopguild_history_pacc`
--
ALTER TABLE `z_shopguild_history_pacc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shopguild_offer`
--
ALTER TABLE `z_shopguild_offer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `z_shop_history_item`
--
ALTER TABLE `z_shop_history_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1455;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_3` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_4` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_5` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `live_casts`
--
ALTER TABLE `live_casts`
  ADD CONSTRAINT `live_casts_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD CONSTRAINT `player_rewards_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `store_history`
--
ALTER TABLE `store_history`
  ADD CONSTRAINT `store_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD CONSTRAINT `znote_guild_wars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
