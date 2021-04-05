-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 05 avr. 2021 à 11:58
-- Version du serveur :  10.3.27-MariaDB
-- Version de PHP : 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `xasfvkeg_gestion`
--

-- --------------------------------------------------------

--
-- Structure de la table `aliments`
--

CREATE TABLE `aliments` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock_en_g` double NOT NULL,
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ateliers`
--

CREATE TABLE `ateliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bacs`
--

CREATE TABLE `bacs` (
  `id` int(10) UNSIGNED NOT NULL,
  `atelier` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_bac` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nbre` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `charges`
--

CREATE TABLE `charges` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cout` double NOT NULL,
  `type_charge` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `charges`
--

INSERT INTO `charges` (`id`, `code`, `name`, `cout`, `type_charge`, `description`) VALUES
(1, 'GVS-0', 'Frais divers', 0, 'FIXE', 'Taxi, charge spontanée, ...');

-- --------------------------------------------------------

--
-- Structure de la table `cms_apicustom`
--

CREATE TABLE `cms_apicustom` (
  `id` int(10) UNSIGNED NOT NULL,
  `permalink` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tabel` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aksi` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kolom` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orderby` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_query_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sql_where` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameter` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `method_type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `responses` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_apicustom`
--

INSERT INTO `cms_apicustom` (`id`, `permalink`, `tabel`, `aksi`, `kolom`, `orderby`, `sub_query_1`, `sql_where`, `nama`, `keterangan`, `parameter`, `created_at`, `updated_at`, `method_type`, `parameters`, `responses`) VALUES
(1, 'webhook', 'navigations', 'list', NULL, NULL, NULL, NULL, 'webhook', 'Reception des messages telegram', NULL, NULL, NULL, 'post', 'a:0:{}', 'a:0:{}');

-- --------------------------------------------------------

--
-- Structure de la table `cms_apikey`
--

CREATE TABLE `cms_apikey` (
  `id` int(10) UNSIGNED NOT NULL,
  `screetkey` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hit` int(11) DEFAULT NULL,
  `status` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cms_dashboard`
--

CREATE TABLE `cms_dashboard` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_cms_privileges` int(11) DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cms_email_queues`
--

CREATE TABLE `cms_email_queues` (
  `id` int(10) UNSIGNED NOT NULL,
  `send_at` datetime DEFAULT NULL,
  `email_recipient` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_from_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_cc_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_attachments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cms_email_templates`
--

CREATE TABLE `cms_email_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cc_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_email_templates`
--

INSERT INTO `cms_email_templates` (`id`, `name`, `slug`, `subject`, `content`, `description`, `from_name`, `from_email`, `cc_email`, `created_at`, `updated_at`) VALUES
(1, 'Email Template Forgot Password Backend', 'forgot_password_backend', NULL, '<p>Hi,</p><p>Someone requested forgot password, here is your new password : </p><p>[password]</p><p><br></p><p>--</p><p>Regards,</p><p>Admin</p>', '[password]', 'System', 'system@crudbooster.com', NULL, '2021-03-27 18:01:50', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_logs`
--

CREATE TABLE `cms_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `ipaddress` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `useragent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_cms_users` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_logs`
--

INSERT INTO `cms_logs` (`id`, `ipaddress`, `useragent`, `url`, `description`, `details`, `id_cms_users`, `created_at`, `updated_at`) VALUES
(1, '154.72.170.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', 'http://fish.soft.gvs-services.com/admin/login', 'fodoup@gmail.com login with IP Address 154.72.170.6', '', 1, '2021-04-05 13:54:42', NULL),
(2, '154.72.170.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36', 'http://fish.soft.gvs-services.com/admin/charges/add-save', 'Add New Data Frais divers at Charges', '', 1, '2021-04-05 13:58:00', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_menus`
--

CREATE TABLE `cms_menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'url',
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_dashboard` tinyint(1) NOT NULL DEFAULT 0,
  `id_cms_privileges` int(11) DEFAULT NULL,
  `sorting` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_menus`
--

INSERT INTO `cms_menus` (`id`, `name`, `type`, `path`, `color`, `icon`, `parent_id`, `is_active`, `is_dashboard`, `id_cms_privileges`, `sorting`, `created_at`, `updated_at`) VALUES
(2, 'Waves of Fish', 'Route', 'AdminVaguesControllerGetIndex', 'normal', 'fa fa-signal', 0, 1, 0, 1, 5, '2021-03-27 18:25:19', '2021-03-27 20:40:00'),
(3, 'Foods', 'Route', 'AdminAlimentsControllerGetIndex', 'normal', 'fa fa-shopping-bag', 0, 1, 0, 1, 6, '2021-03-27 19:19:53', '2021-03-27 20:40:16'),
(4, 'workshop', 'Route', 'AdminAteliersControllerGetIndex', 'normal', 'fa fa-bank', 0, 1, 0, 1, 3, '2021-03-27 19:25:46', '2021-03-27 20:40:36'),
(5, 'bins', 'Route', 'AdminBacsControllerGetIndex', 'normal', 'fa fa-bell', 0, 1, 0, 1, 4, '2021-03-27 19:29:32', '2021-03-27 20:40:51'),
(6, 'Charges', 'Route', 'AdminChargesControllerGetIndex', 'normal', 'fa fa-balance-scale', 0, 1, 0, 1, 7, '2021-03-27 19:48:05', '2021-03-27 20:41:02'),
(7, 'Flux', 'Route', 'AdminFluxMovementsControllerGetIndex', 'normal', 'fa fa-line-chart', 0, 1, 0, 1, 9, '2021-03-27 19:55:45', '2021-03-30 17:06:23'),
(8, 'Investments', 'Route', 'AdminInvestissementsControllerGetIndex', 'normal', 'fa fa-money', 0, 1, 0, 1, 8, '2021-03-27 20:04:43', '2021-03-27 20:41:33'),
(9, 'Navigations', 'Route', 'AdminNavigationsControllerGetIndex', NULL, 'fa fa-whatsapp', 0, 1, 0, 1, 10, '2021-03-27 20:13:50', NULL),
(10, 'proofs', 'Route', 'AdminPreuvesControllerGetIndex', 'normal', 'fa fa-picture-o', 14, 1, 0, 1, 8, '2021-03-27 20:17:34', '2021-03-27 20:41:59'),
(11, 'Template', 'Route', 'AdminTemplatesControllerGetIndex', NULL, 'fa fa-envelope', 0, 1, 0, 1, 11, '2021-03-27 20:20:44', NULL),
(12, 'LES VENTES', 'Statistic', 'statistic_builder/show/nbre-vente', 'green', 'fa fa-pie-chart', 0, 1, 1, 1, 1, '2021-03-27 20:59:18', '2021-03-27 21:44:28'),
(14, 'Report', 'URL', '#', 'normal', 'fa fa-table', 0, 1, 0, 1, 2, '2021-03-27 21:47:07', NULL),
(15, 'Ventes', 'Route', 'AdminFluxMovementsVenteControllerGetIndex', 'normal', 'fa fa-shopping-basket', 14, 1, 0, 1, 2, '2021-03-27 21:50:44', '2021-03-27 22:09:23'),
(16, 'Pertes', 'Route', 'AdminFluxMovementsPerteControllerGetIndex', 'normal', 'fa fa-trash', 14, 1, 0, 1, 3, '2021-03-27 22:19:31', '2021-03-27 22:22:51'),
(17, 'Achat', 'Route', 'AdminFluxMovementsAchatControllerGetIndex', 'normal', 'fa fa-truck', 14, 1, 0, 1, 1, '2021-03-27 22:26:50', '2021-03-27 22:31:07'),
(18, 'Changement Bac', 'Route', 'AdminFluxMovementsChangementControllerGetIndex', 'normal', 'fa fa-recycle', 14, 1, 0, 1, 5, '2021-03-27 22:32:47', '2021-03-27 22:35:29'),
(19, 'Nutrition', 'Route', 'AdminFluxMovementsNutritionControllerGetIndex', 'normal', 'fa fa-safari', 14, 1, 0, 1, 4, '2021-03-27 22:37:19', '2021-03-27 22:40:23'),
(20, 'Charge', 'Route', 'AdminFluxMovementsChargeControllerGetIndex', 'normal', 'fa fa-balance-scale', 14, 1, 0, 1, 6, '2021-03-27 22:42:13', '2021-03-27 22:44:27'),
(21, 'Investissement', 'Route', 'AdminFluxMovementsInvestissementControllerGetIndex', 'normal', 'fa fa-bank', 14, 1, 0, 1, 7, '2021-03-27 22:45:34', '2021-03-27 22:47:10'),
(23, 'Historique Caisse', 'Route', 'AdminFluxMovementsCaisseControllerGetIndex', 'normal', 'fa fa-archive', 14, 1, 0, 1, 9, '2021-03-30 19:23:26', '2021-03-30 19:26:57');

-- --------------------------------------------------------

--
-- Structure de la table `cms_menus_privileges`
--

CREATE TABLE `cms_menus_privileges` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_cms_menus` int(11) DEFAULT NULL,
  `id_cms_privileges` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_menus_privileges`
--

INSERT INTO `cms_menus_privileges` (`id`, `id_cms_menus`, `id_cms_privileges`) VALUES
(1, 1, 1),
(12, 2, 3),
(15, 3, 3),
(18, 4, 2),
(20, 5, 3),
(23, 6, 2),
(85, 23, 3),
(27, 8, 2),
(9, 9, 1),
(29, 10, 2),
(11, 11, 1),
(13, 2, 2),
(14, 2, 1),
(16, 3, 2),
(17, 3, 1),
(19, 4, 1),
(21, 5, 2),
(22, 5, 1),
(24, 6, 1),
(83, 7, 1),
(28, 8, 1),
(30, 10, 1),
(40, 12, 2),
(39, 12, 3),
(35, 13, 3),
(36, 13, 2),
(37, 13, 1),
(41, 12, 1),
(42, 14, 3),
(43, 14, 2),
(44, 14, 1),
(57, 15, 1),
(56, 15, 2),
(55, 15, 3),
(59, 16, 3),
(60, 16, 2),
(61, 16, 1),
(63, 17, 3),
(64, 17, 2),
(65, 17, 1),
(67, 18, 3),
(68, 18, 2),
(69, 18, 1),
(71, 19, 3),
(72, 19, 2),
(73, 19, 1),
(75, 20, 3),
(76, 20, 2),
(77, 20, 1),
(79, 21, 3),
(80, 21, 2),
(81, 21, 1),
(82, 22, 1),
(86, 23, 2),
(87, 23, 1);

-- --------------------------------------------------------

--
-- Structure de la table `cms_moduls`
--

CREATE TABLE `cms_moduls` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_protected` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_moduls`
--

INSERT INTO `cms_moduls` (`id`, `name`, `icon`, `path`, `table_name`, `controller`, `is_protected`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Notifications', 'fa fa-cog', 'notifications', 'cms_notifications', 'NotificationsController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(2, 'Privileges', 'fa fa-cog', 'privileges', 'cms_privileges', 'PrivilegesController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(3, 'Privileges Roles', 'fa fa-cog', 'privileges_roles', 'cms_privileges_roles', 'PrivilegesRolesController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(4, 'Users Management', 'fa fa-users', 'users', 'cms_users', 'AdminCmsUsersController', 0, 1, '2021-03-27 18:01:50', NULL, NULL),
(5, 'Settings', 'fa fa-cog', 'settings', 'cms_settings', 'SettingsController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(6, 'Module Generator', 'fa fa-database', 'module_generator', 'cms_moduls', 'ModulsController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(7, 'Menu Management', 'fa fa-bars', 'menu_management', 'cms_menus', 'MenusController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(8, 'Email Templates', 'fa fa-envelope-o', 'email_templates', 'cms_email_templates', 'EmailTemplatesController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(9, 'Statistic Builder', 'fa fa-dashboard', 'statistic_builder', 'cms_statistics', 'StatisticBuilderController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(10, 'API Generator', 'fa fa-cloud-download', 'api_generator', '', 'ApiCustomController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(11, 'Log User Access', 'fa fa-flag-o', 'logs', 'cms_logs', 'LogsController', 1, 1, '2021-03-27 18:01:50', NULL, NULL),
(12, 'Manage users', 'fa fa-glass', 'cms_users', 'cms_users', 'AdminCmsUsers1Controller', 0, 0, '2021-03-27 18:09:43', NULL, '2021-03-27 18:10:23'),
(13, 'Waves of Fish', 'fa fa-signal', 'vagues', 'vagues', 'AdminVaguesController', 0, 0, '2021-03-27 18:25:19', NULL, NULL),
(14, 'Foods', 'fa fa-shopping-bag', 'aliments', 'aliments', 'AdminAlimentsController', 0, 0, '2021-03-27 19:19:53', NULL, NULL),
(15, 'workshop', 'fa fa-bank', 'ateliers', 'ateliers', 'AdminAteliersController', 0, 0, '2021-03-27 19:25:46', NULL, NULL),
(16, 'bins', 'fa fa-bell', 'bacs', 'bacs', 'AdminBacsController', 0, 0, '2021-03-27 19:29:32', NULL, NULL),
(17, 'Charges', 'fa fa-balance-scale', 'charges', 'charges', 'AdminChargesController', 0, 0, '2021-03-27 19:48:05', NULL, NULL),
(18, 'Flux', 'fa fa-line-chart', 'flux_movements', 'flux_movements', 'AdminFluxMovementsController', 0, 0, '2021-03-27 19:55:45', NULL, NULL),
(19, 'Investments', 'fa fa-money', 'investissements', 'investissements', 'AdminInvestissementsController', 0, 0, '2021-03-27 20:04:43', NULL, NULL),
(20, 'Navigations', 'fa fa-whatsapp', 'navigations', 'navigations', 'AdminNavigationsController', 0, 0, '2021-03-27 20:13:50', NULL, NULL),
(21, 'proofs', 'fa fa-picture-o', 'preuves', 'preuves', 'AdminPreuvesController', 0, 0, '2021-03-27 20:17:34', NULL, NULL),
(22, 'Template', 'fa fa-envelope', 'templates', 'templates', 'AdminTemplatesController', 0, 0, '2021-03-27 20:20:44', NULL, NULL),
(23, 'Ventes', 'fa fa-shopping-basket', 'flux_movements_vente', 'flux_movements', 'AdminFluxMovementsVenteController', 0, 0, '2021-03-27 21:50:44', NULL, NULL),
(24, 'Pertes', 'fa fa-trash', 'flux_movements_perte', 'flux_movements', 'AdminFluxMovementsPerteController', 0, 0, '2021-03-27 22:19:31', NULL, NULL),
(25, 'Achat', 'fa fa-truck', 'flux_movements_achat', 'flux_movements', 'AdminFluxMovementsAchatController', 0, 0, '2021-03-27 22:26:50', NULL, NULL),
(26, 'Changement Bac', 'fa fa-recycle', 'flux_movements_changement', 'flux_movements', 'AdminFluxMovementsChangementController', 0, 0, '2021-03-27 22:32:47', NULL, NULL),
(27, 'Nutrition', 'fa fa-safari', 'flux_movements_nutrition', 'flux_movements', 'AdminFluxMovementsNutritionController', 0, 0, '2021-03-27 22:37:19', NULL, NULL),
(28, 'Charge', 'fa fa-balance-scale', 'flux_movements_charge', 'flux_movements', 'AdminFluxMovementsChargeController', 0, 0, '2021-03-27 22:42:13', NULL, NULL),
(29, 'Investissement', 'fa fa-bank', 'flux_movements_investissement', 'flux_movements', 'AdminFluxMovementsInvestissementController', 0, 0, '2021-03-27 22:45:34', NULL, NULL),
(30, 'User_Manage', 'fa fa-group', 'cms_users_custom', 'cms_users', 'AdminCmsUsersCustomController', 0, 0, '2021-03-28 20:07:19', NULL, NULL),
(31, 'Historique Caisse', 'fa fa-archive', 'flux_movements_caisse', 'flux_movements', 'AdminFluxMovementsCaisseController', 0, 0, '2021-03-30 19:23:25', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_notifications`
--

CREATE TABLE `cms_notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_cms_users` int(11) DEFAULT NULL,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cms_privileges`
--

CREATE TABLE `cms_privileges` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_superadmin` tinyint(1) DEFAULT NULL,
  `theme_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_privileges`
--

INSERT INTO `cms_privileges` (`id`, `name`, `is_superadmin`, `theme_color`, `created_at`, `updated_at`) VALUES
(1, 'Super Administrator', 1, 'skin-red', '2021-03-27 18:01:50', NULL),
(2, 'manager', 0, 'skin-purple', NULL, NULL),
(3, 'customer', 0, 'skin-blue', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_privileges_roles`
--

CREATE TABLE `cms_privileges_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `is_visible` tinyint(1) DEFAULT NULL,
  `is_create` tinyint(1) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `is_edit` tinyint(1) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT NULL,
  `id_cms_privileges` int(11) DEFAULT NULL,
  `id_cms_moduls` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_privileges_roles`
--

INSERT INTO `cms_privileges_roles` (`id`, `is_visible`, `is_create`, `is_read`, `is_edit`, `is_delete`, `id_cms_privileges`, `id_cms_moduls`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 0, 0, 0, 1, 1, '2021-03-27 18:01:50', NULL),
(2, 1, 1, 1, 1, 1, 1, 2, '2021-03-27 18:01:50', NULL),
(3, 0, 1, 1, 1, 1, 1, 3, '2021-03-27 18:01:50', NULL),
(4, 1, 1, 1, 1, 1, 1, 4, '2021-03-27 18:01:50', NULL),
(5, 1, 1, 1, 1, 1, 1, 5, '2021-03-27 18:01:50', NULL),
(6, 1, 1, 1, 1, 1, 1, 6, '2021-03-27 18:01:50', NULL),
(7, 1, 1, 1, 1, 1, 1, 7, '2021-03-27 18:01:50', NULL),
(8, 1, 1, 1, 1, 1, 1, 8, '2021-03-27 18:01:50', NULL),
(9, 1, 1, 1, 1, 1, 1, 9, '2021-03-27 18:01:50', NULL),
(10, 1, 1, 1, 1, 1, 1, 10, '2021-03-27 18:01:50', NULL),
(11, 1, 0, 1, 0, 1, 1, 11, '2021-03-27 18:01:50', NULL),
(12, 1, 1, 1, 1, 1, 1, 12, NULL, NULL),
(13, 1, 1, 1, 1, 1, 1, 13, NULL, NULL),
(14, 1, 1, 1, 1, 1, 1, 14, NULL, NULL),
(15, 1, 1, 1, 1, 1, 1, 15, NULL, NULL),
(16, 1, 1, 1, 1, 1, 1, 16, NULL, NULL),
(17, 1, 1, 1, 1, 1, 1, 17, NULL, NULL),
(18, 1, 1, 1, 1, 1, 1, 18, NULL, NULL),
(19, 1, 1, 1, 1, 1, 1, 19, NULL, NULL),
(20, 1, 1, 1, 1, 1, 1, 20, NULL, NULL),
(21, 1, 1, 1, 1, 1, 1, 21, NULL, NULL),
(22, 1, 1, 1, 1, 1, 1, 22, NULL, NULL),
(69, 1, 0, 1, 0, 0, 2, 24, NULL, NULL),
(68, 1, 0, 1, 0, 0, 2, 27, NULL, NULL),
(67, 1, 0, 1, 1, 1, 2, 20, NULL, NULL),
(66, 1, 1, 1, 1, 1, 2, 19, NULL, NULL),
(65, 1, 0, 1, 0, 0, 2, 29, NULL, NULL),
(64, 1, 1, 1, 1, 1, 2, 14, NULL, NULL),
(63, 1, 1, 1, 1, 1, 2, 18, NULL, NULL),
(62, 1, 1, 1, 1, 1, 2, 17, NULL, NULL),
(61, 1, 0, 1, 0, 0, 2, 28, NULL, NULL),
(60, 1, 0, 1, 0, 0, 2, 26, NULL, NULL),
(59, 1, 1, 1, 1, 1, 2, 16, NULL, NULL),
(80, 0, 0, 0, 1, 0, 3, 14, NULL, NULL),
(79, 0, 1, 1, 1, 0, 3, 17, NULL, NULL),
(78, 1, 0, 1, 0, 0, 3, 28, NULL, NULL),
(77, 1, 0, 1, 0, 0, 3, 26, NULL, NULL),
(76, 1, 0, 1, 0, 0, 3, 25, NULL, NULL),
(39, 1, 1, 1, 1, 1, 1, 23, NULL, NULL),
(58, 1, 0, 1, 0, 0, 2, 25, NULL, NULL),
(52, 1, 1, 1, 1, 1, 1, 24, NULL, NULL),
(53, 1, 1, 1, 1, 1, 1, 25, NULL, NULL),
(54, 1, 1, 1, 1, 1, 1, 26, NULL, NULL),
(55, 1, 1, 1, 1, 1, 1, 27, NULL, NULL),
(56, 1, 1, 1, 1, 1, 1, 28, NULL, NULL),
(57, 1, 1, 1, 1, 1, 1, 29, NULL, NULL),
(70, 1, 1, 1, 1, 0, 2, 21, NULL, NULL),
(71, 1, 1, 1, 1, 1, 2, 22, NULL, NULL),
(72, 1, 1, 1, 1, 0, 2, 4, NULL, NULL),
(73, 1, 0, 1, 0, 0, 2, 23, NULL, NULL),
(74, 1, 1, 1, 1, 1, 2, 13, NULL, NULL),
(75, 1, 1, 1, 1, 1, 2, 15, NULL, NULL),
(81, 1, 0, 1, 0, 0, 3, 29, NULL, NULL),
(82, 0, 0, 0, 1, 0, 3, 19, NULL, NULL),
(83, 1, 0, 1, 0, 0, 3, 27, NULL, NULL),
(84, 1, 0, 1, 0, 0, 3, 24, NULL, NULL),
(85, 0, 1, 0, 1, 0, 3, 21, NULL, NULL),
(86, 1, 0, 1, 0, 0, 3, 23, NULL, NULL),
(87, 0, 1, 0, 1, 0, 3, 13, NULL, NULL),
(88, 1, 1, 1, 1, 1, 1, 30, NULL, NULL),
(89, 1, 1, 1, 1, 1, 1, 31, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_settings`
--

CREATE TABLE `cms_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_input_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataenum` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `helper` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `group_setting` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_settings`
--

INSERT INTO `cms_settings` (`id`, `name`, `content`, `content_input_type`, `dataenum`, `helper`, `created_at`, `updated_at`, `group_setting`, `label`) VALUES
(1, 'login_background_color', NULL, 'text', NULL, 'Input hexacode', '2021-03-27 18:01:50', NULL, 'Login Register Style', 'Login Background Color'),
(2, 'login_font_color', NULL, 'text', NULL, 'Input hexacode', '2021-03-27 18:01:50', NULL, 'Login Register Style', 'Login Font Color'),
(3, 'login_background_image', NULL, 'upload_image', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Login Register Style', 'Login Background Image'),
(4, 'email_sender', 'info@gvs.com', 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Email Setting', 'Email Sender'),
(5, 'smtp_driver', 'smtp', 'select', 'smtp,mail,sendmail', NULL, '2021-03-27 18:01:50', NULL, 'Email Setting', 'Mail Driver'),
(6, 'smtp_host', 'mail.bjftconsulting.ca', 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Email Setting', 'SMTP Host'),
(7, 'smtp_port', '26', 'text', NULL, 'default 25', '2021-03-27 18:01:50', NULL, 'Email Setting', 'SMTP Port'),
(8, 'smtp_username', 'support@bjftconsulting.ca', 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Email Setting', 'SMTP Username'),
(9, 'smtp_password', 'BJFT2021**', 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Email Setting', 'SMTP Password'),
(10, 'appname', 'FISH-MANAGE', 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'Application Name'),
(11, 'default_paper_size', 'Legal', 'text', NULL, 'Paper size, ex : A4, Legal, etc', '2021-03-27 18:01:50', NULL, 'Application Setting', 'Default Paper Print Size'),
(12, 'logo', 'uploads/2021-03/66b263ee100ab31966059fc71063ae63.jpg', 'upload_image', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'Logo'),
(13, 'favicon', 'uploads/2021-03/290796ece2247c02acfdbc881c2cfa87.jpg', 'upload_image', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'Favicon'),
(14, 'api_debug_mode', 'true', 'select', 'true,false', NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'API Debug Mode'),
(15, 'google_api_key', NULL, 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'Google API Key'),
(16, 'google_fcm_key', NULL, 'text', NULL, NULL, '2021-03-27 18:01:50', NULL, 'Application Setting', 'Google FCM Key');

-- --------------------------------------------------------

--
-- Structure de la table `cms_statistics`
--

CREATE TABLE `cms_statistics` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_statistics`
--

INSERT INTO `cms_statistics` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'nbre-vente', '2021-03-27 20:46:02', '2021-03-28 03:51:02');

-- --------------------------------------------------------

--
-- Structure de la table `cms_statistic_components`
--

CREATE TABLE `cms_statistic_components` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_cms_statistics` int(11) DEFAULT NULL,
  `componentID` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `component_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area_name` varchar(55) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sorting` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_statistic_components`
--

INSERT INTO `cms_statistic_components` (`id`, `id_cms_statistics`, `componentID`, `component_name`, `area_name`, `sorting`, `name`, `config`, `created_at`, `updated_at`) VALUES
(1, 1, 'e653dcb6273ec4eaf091c9f49dd737ed', 'smallbox', 'area1', 0, NULL, '{\"name\":\"Cout total des ventes\",\"icon\":\"cash-outline\",\"color\":\"bg-green\",\"link\":\"#\",\"sql\":\"select concat(COALESCE(sum(cout_kg*qte_gramme\\/1000)+sum(cout_unite*nbre), 0),\\\" FCFA\\\") from flux_movements where statut = \'VENTE\'\"}', '2021-03-27 20:46:37', NULL),
(3, 1, '7a2151dcf285a073f714ae596d64cb6d', 'smallbox', 'area2', 0, NULL, '{\"name\":\"Nombre total des pertes\",\"icon\":\"cash-outline\",\"color\":\"bg-red\",\"link\":\"#\",\"sql\":\"select COALESCE(sum(nbre),0) from flux_movements where statut = \'PERTE\'\"}', '2021-03-27 21:02:52', NULL),
(4, 1, 'd836d737b22ce7038ec87edf7f6cdda3', 'smallbox', 'area4', 0, NULL, '{\"name\":\"Quantit\\u00e9 actuelle de poisson mature\",\"icon\":\"cash-outline\",\"color\":\"bg-aqua\",\"link\":\"#\",\"sql\":\"select COALESCE(sum(nbre), 0) from bacs where type_bac = \'MATURE\'\"}', '2021-03-27 21:05:15', NULL),
(2, 1, '69f5e6a991ba7d5c3221512ffd1cde70', 'smallbox', 'area3', 0, NULL, '{\"name\":\"Nombre total des poissons\",\"icon\":\"cash-outline\",\"color\":\"bg-yellow\",\"link\":\"#\",\"sql\":\"select COALESCE(sum(nbre), 0) from bacs\"}', '2021-03-27 21:05:18', NULL),
(5, 1, '3c0cbfa6110a1767e9485c5f2a7f730b', 'table', 'area5', 0, NULL, '{\"name\":\"Historique des pertes\",\"sql\":\"SELECT date_action as date,bacs.name as bac, flux_movements.nbre as nbre_perte, cms_users.name as agent\\r\\n FROM flux_movements JOIN cms_users on flux_movements.agent = cms_users.id\\r\\njoin bacs on flux_movements.bac_source = bacs.id\\r\\nWHERE flux_movements.statut = \'PERTE\'\"}', '2021-03-27 21:41:32', NULL),
(6, 1, 'f82ae96455161bbb17f36d6951505537', 'chartline', 'area5', 1, NULL, '{\"name\":\"Evolution des perte\",\"sql\":\"select WEEKOFYEAR(date_action) as label, sum(nbre) as value from flux_movements where statut = \'PERTE\' GROUP BY WEEKOFYEAR(date_action)\",\"area_name\":\"Journalier\",\"goals\":\"0\"}', '2021-03-27 21:42:22', NULL),
(7, 1, '8439c9c2a05f99c1ff709e5191896d59', 'smallbox', 'area1', 1, NULL, '{\"name\":\"Nombre investisseurs\",\"icon\":\"people-outline\",\"color\":\"bg-yellow\",\"link\":\"#\",\"sql\":\"select count(*) from investissements\"}', '2021-03-29 20:35:10', NULL),
(8, 1, 'a081712583951e0732b05f25d02e0231', 'smallbox', 'area2', 1, NULL, '{\"name\":\"Somme investissements\",\"icon\":\"people-outline\",\"color\":\"bg-green\",\"link\":\"#\",\"sql\":\"select concat(COALESCE(sum(balance), 0),\\\" FCFA\\\")  from investissements\"}', '2021-03-29 20:35:21', NULL),
(9, 1, '70e4f893ac66b4eed63d82cf9ca9b89c', 'smallbox', 'area3', 1, NULL, '{\"name\":\"Depenses \\/ charges\",\"icon\":\"people-outline\",\"color\":\"bg-red\",\"link\":\"#\",\"sql\":\"select concat(COALESCE(sum(cout_unite), 0),\\\" FCFA\\\") from flux_movements where type_flux = \'CHARGE\'\"}', '2021-03-29 20:35:30', NULL),
(10, 1, '9492f2bc09006afa6b78b9e739582e49', 'smallbox', 'area4', 1, NULL, '{\"name\":\"CAISSE ACTUELLE\",\"icon\":\"people-outline\",\"color\":\"bg-aqua\",\"link\":\"#\",\"sql\":\"select concat((h.invest + r.vente - s.charge - a.achat),\\\" FCFA\\\") as caisse  from\\r\\n(select COALESCE(sum(t.balance),0) as invest from investissements t) h,\\r\\n(select COALESCE(sum(p.cout_kg*qte_gramme\\/1000)+sum(p.cout_unite*nbre), 0) as vente from flux_movements p where p.statut in (\'VENTE\')) r,\\r\\n(select COALESCE(sum(z.cout_kg*qte_gramme\\/1000)+sum(z.cout_unite*nbre), 0) as achat from flux_movements z where z.statut in (\'ACHAT\')) a,\\r\\n(select COALESCE(sum(k.cout_unite), 0) as charge from flux_movements k where k.type_flux in (\'CHARGE\')) s;\"}', '2021-03-29 20:35:32', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cms_users`
--

CREATE TABLE `cms_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `telegram_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '12345',
  `secret` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '00001',
  `notifiable` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_cms_privileges` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cms_users`
--

INSERT INTO `cms_users` (`id`, `telegram_id`, `secret`, `notifiable`, `name`, `photo`, `email`, `password`, `id_cms_privileges`, `created_at`, `updated_at`, `status`) VALUES
(1, '831228193', '12345', 1, 'FK Christian', 'uploads/1/2021-03/config.jpg', 'fodoup@gmail.com', '$2y$10$Gg5uc2Lv.xqZcggGFjAiKemWh.o0bJ8hunL8B2xxfP8bYjSycxOBy', 1, '2021-03-27 18:01:50', '2021-03-28 21:16:55', 'Active'),
(2, '827558749', '12345', 1, 'SIME Vedrines', 'uploads/1/2021-03/telechargement_6.jpg', 'gassendi2002@yahoo.fr', '$2y$10$d.DZiY8gAJbAzz9ajSrn7OusrHbz0/LClDFioA/I8m1/8hPWfjrXm', 2, '2021-03-27 20:37:39', '2021-03-28 21:16:28', NULL),
(3, '1713261316', '00001', 0, 'Feungang Michel', 'uploads/1/2021-03/logo_1.png', 'feungang@test.test', '$2y$10$Bl8BNbZSi6jaMQ0oYmEbC.9hGb/gD5F/QXmbd1vI6PSrGJjyIkAgm', 3, '2021-03-30 19:12:37', NULL, NULL),
(4, '1796667479', '00001', 1, 'Kouam Stephane', 'uploads/1/2021-03/telechargement_6.jpg', 'stephanokouam@gmail.com', '$2y$10$72.yMIkdYtDLNI0X3g.ZleDUz8K6hKlXSXgclg3blt3wyTaliWnFy', 2, '2021-03-30 19:39:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `flux_movements`
--

CREATE TABLE `flux_movements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `charge` int(10) UNSIGNED DEFAULT NULL,
  `investissement` int(10) UNSIGNED DEFAULT NULL,
  `bac_source` int(10) UNSIGNED DEFAULT NULL,
  `bac_destination` int(10) UNSIGNED DEFAULT NULL,
  `vague` int(10) UNSIGNED DEFAULT NULL,
  `aliment` int(10) UNSIGNED DEFAULT NULL,
  `agent` int(10) UNSIGNED NOT NULL,
  `date_action` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `type_flux` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qte_gramme` double NOT NULL,
  `nbre` int(11) NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cout_unite` double NOT NULL,
  `cout_kg` double NOT NULL,
  `caisse_avant` double NOT NULL DEFAULT 0,
  `caisse_apres` double NOT NULL DEFAULT 0,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `investissements`
--

CREATE TABLE `investissements` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agent` int(10) UNSIGNED NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_modification` timestamp NOT NULL DEFAULT current_timestamp(),
  `balance` double NOT NULL,
  `max_to_give` double NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(40, '2021_03_27_191205_vague', 2),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_08_07_145904_add_table_cms_apicustom', 1),
(4, '2016_08_07_150834_add_table_cms_dashboard', 1),
(5, '2016_08_07_151210_add_table_cms_logs', 1),
(6, '2016_08_07_151211_add_details_cms_logs', 1),
(7, '2016_08_07_152014_add_table_cms_privileges', 1),
(8, '2016_08_07_152214_add_table_cms_privileges_roles', 1),
(9, '2016_08_07_152320_add_table_cms_settings', 1),
(10, '2016_08_07_152421_add_table_cms_users', 1),
(11, '2016_08_07_154624_add_table_cms_menus_privileges', 1),
(12, '2016_08_07_154624_add_table_cms_moduls', 1),
(13, '2016_08_17_225409_add_status_cms_users', 1),
(14, '2016_08_20_125418_add_table_cms_notifications', 1),
(15, '2016_09_04_033706_add_table_cms_email_queues', 1),
(16, '2016_09_16_035347_add_group_setting', 1),
(17, '2016_09_16_045425_add_label_setting', 1),
(18, '2016_09_17_104728_create_nullable_cms_apicustom', 1),
(19, '2016_10_01_141740_add_method_type_apicustom', 1),
(20, '2016_10_01_141846_add_parameters_apicustom', 1),
(21, '2016_10_01_141934_add_responses_apicustom', 1),
(22, '2016_10_01_144826_add_table_apikey', 1),
(23, '2016_11_14_141657_create_cms_menus', 1),
(24, '2016_11_15_132350_create_cms_email_templates', 1),
(25, '2016_11_15_190410_create_cms_statistics', 1),
(26, '2016_11_17_102740_create_cms_statistic_components', 1),
(27, '2017_06_06_164501_add_deleted_at_cms_moduls', 1),
(28, '2019_08_19_000000_create_failed_jobs_table', 1),
(48, '2021_03_27_200205_flux_movement', 2),
(47, '2021_03_27_195819_template', 2),
(46, '2021_03_27_195435_navigation', 2),
(45, '2021_03_27_195156_investissement', 2),
(44, '2021_03_27_194756_charge', 2),
(43, '2021_03_27_194117_bac', 2),
(42, '2021_03_27_193910_atelier', 2),
(41, '2021_03_27_193623_aliment', 2),
(49, '2021_03_27_200221_preuve', 2);

-- --------------------------------------------------------

--
-- Structure de la table `navigations`
--

CREATE TABLE `navigations` (
  `chat_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `step` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `data_collected` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `navigations`
--

INSERT INTO `navigations` (`chat_id`, `name`, `step`, `last_date`, `updated_at`, `created_at`, `data_collected`) VALUES
('831228193', 'Christian FK', 'NUTRITION-POISSON_QTE', '2021-04-04 16:27:20', '2021-04-04 12:27:20', '2021-03-28 16:32:43', '{\"home\":\"3\",\"bac_source\":\"1\",\"aliment\":\"1\"}'),
('827558749', ' Vedrines', 'PH0TO-PREUVE_RECAP', '2021-04-01 04:48:55', '2021-04-01 00:48:55', '2021-03-28 17:04:07', '{\"home\":\"7\",\"id\":\"27\",\"nbre_photo\":\"1\",\"photo_1\":\"Proof_827558749_20210401004841.jpg\",\"description\":\"transfert\"}'),
('1796667479', ' Stephane', 'NOUVELLE-VAGUE_PDU', '2021-04-03 19:12:34', '2021-04-03 15:12:34', '2021-03-30 15:35:02', '{\"home\":\"1\",\"bac_source\":\"1\"}'),
('1713261316', 'Michel Kevin Feungang Tchinche', 'HOME_HOME', '2021-03-30 19:54:55', '2021-03-30 15:54:55', '2021-03-30 15:21:01', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `preuves`
--

CREATE TABLE `preuves` (
  `id` int(10) UNSIGNED NOT NULL,
  `agent` int(10) UNSIGNED NOT NULL,
  `flux` bigint(20) UNSIGNED NOT NULL,
  `date_entree` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `templates`
--

CREATE TABLE `templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type_notif` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_notif` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vagues`
--

CREATE TABLE `vagues` (
  `id` int(10) UNSIGNED NOT NULL,
  `agent` int(10) UNSIGNED NOT NULL,
  `date_entree` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_sortie` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_prevu_sortie` timestamp NOT NULL DEFAULT current_timestamp(),
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `poids_unite` double NOT NULL,
  `prix_unite` double NOT NULL,
  `nbre_entree` int(11) NOT NULL,
  `nbre_sortie` int(11) NOT NULL,
  `nbre_perte` int(11) NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `aliments`
--
ALTER TABLE `aliments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `aliments_code_unique` (`code`);

--
-- Index pour la table `ateliers`
--
ALTER TABLE `ateliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ateliers_code_unique` (`code`);

--
-- Index pour la table `bacs`
--
ALTER TABLE `bacs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bacs_code_unique` (`code`),
  ADD KEY `bacs_atelier_foreign` (`atelier`);

--
-- Index pour la table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `charges_code_unique` (`code`);

--
-- Index pour la table `cms_apicustom`
--
ALTER TABLE `cms_apicustom`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_apikey`
--
ALTER TABLE `cms_apikey`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_dashboard`
--
ALTER TABLE `cms_dashboard`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_email_queues`
--
ALTER TABLE `cms_email_queues`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_email_templates`
--
ALTER TABLE `cms_email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_logs`
--
ALTER TABLE `cms_logs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_menus`
--
ALTER TABLE `cms_menus`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_menus_privileges`
--
ALTER TABLE `cms_menus_privileges`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_moduls`
--
ALTER TABLE `cms_moduls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_notifications`
--
ALTER TABLE `cms_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_privileges`
--
ALTER TABLE `cms_privileges`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_privileges_roles`
--
ALTER TABLE `cms_privileges_roles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_settings`
--
ALTER TABLE `cms_settings`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_statistics`
--
ALTER TABLE `cms_statistics`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_statistic_components`
--
ALTER TABLE `cms_statistic_components`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cms_users`
--
ALTER TABLE `cms_users`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `flux_movements`
--
ALTER TABLE `flux_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flux_movements_charge_foreign` (`charge`),
  ADD KEY `flux_movements_investissement_foreign` (`investissement`),
  ADD KEY `flux_movements_bac_source_foreign` (`bac_source`),
  ADD KEY `flux_movements_bac_destination_foreign` (`bac_destination`),
  ADD KEY `flux_movements_vague_foreign` (`vague`),
  ADD KEY `flux_movements_agent_foreign` (`agent`);

--
-- Index pour la table `investissements`
--
ALTER TABLE `investissements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `investissements_agent_foreign` (`agent`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `navigations`
--
ALTER TABLE `navigations`
  ADD PRIMARY KEY (`chat_id`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Index pour la table `preuves`
--
ALTER TABLE `preuves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preuves_agent_foreign` (`agent`),
  ADD KEY `preuves_flux_foreign` (`flux`);

--
-- Index pour la table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vagues`
--
ALTER TABLE `vagues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vagues_agent_foreign` (`agent`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `aliments`
--
ALTER TABLE `aliments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ateliers`
--
ALTER TABLE `ateliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bacs`
--
ALTER TABLE `bacs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cms_apicustom`
--
ALTER TABLE `cms_apicustom`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cms_apikey`
--
ALTER TABLE `cms_apikey`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cms_dashboard`
--
ALTER TABLE `cms_dashboard`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cms_email_queues`
--
ALTER TABLE `cms_email_queues`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cms_email_templates`
--
ALTER TABLE `cms_email_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cms_logs`
--
ALTER TABLE `cms_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cms_menus`
--
ALTER TABLE `cms_menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `cms_menus_privileges`
--
ALTER TABLE `cms_menus_privileges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT pour la table `cms_moduls`
--
ALTER TABLE `cms_moduls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `cms_notifications`
--
ALTER TABLE `cms_notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cms_privileges`
--
ALTER TABLE `cms_privileges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `cms_privileges_roles`
--
ALTER TABLE `cms_privileges_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT pour la table `cms_settings`
--
ALTER TABLE `cms_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `cms_statistics`
--
ALTER TABLE `cms_statistics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cms_statistic_components`
--
ALTER TABLE `cms_statistic_components`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `cms_users`
--
ALTER TABLE `cms_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `flux_movements`
--
ALTER TABLE `flux_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `investissements`
--
ALTER TABLE `investissements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT pour la table `preuves`
--
ALTER TABLE `preuves`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vagues`
--
ALTER TABLE `vagues`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
