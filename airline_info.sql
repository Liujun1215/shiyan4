/*
 Navicat Premium Data Transfer

 Source Server         : airline
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : airline_info

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 07/12/2019 19:19:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `user` varchar(16) NOT NULL COMMENT '管理员用户名',
  `pwd` varchar(32) NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员用户表';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES ('admin', '74D839D98630E280DF752E8939454A6B');
COMMIT;

-- ----------------------------
-- Table structure for common_user
-- ----------------------------
DROP TABLE IF EXISTS `common_user`;
CREATE TABLE `common_user` (
  `user_name` varchar(16) NOT NULL,
  `user_pwd` varchar(32) NOT NULL,
  `avatar_img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of common_user
-- ----------------------------
BEGIN;
INSERT INTO `common_user` VALUES ('admin', '9C70EA7F3264F3E7284853BE80DD3865', '9c77f9e7-6334-49df-a444-149e7bd49f81.png');
INSERT INTO `common_user` VALUES ('test', '3A251A4FB000208B8AE278822D2E2313', NULL);
INSERT INTO `common_user` VALUES ('test1', '3A251A4FB000208B8AE278822D2E2313', '3ca0bba1-1568-48cf-8ce4-c146c2da40c3.png');
INSERT INTO `common_user` VALUES ('test2', '26DD7D4D62829E56163688C40CEE376E', NULL);
INSERT INTO `common_user` VALUES ('lzl', '253D0BF20314FE3D53AF363D99C87BFC', NULL);
COMMIT;

-- ----------------------------
-- Table structure for flight
-- ----------------------------
DROP TABLE IF EXISTS `flight`;
CREATE TABLE `flight` (
  `number` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班号',
  `departure` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班起点',
  `destination` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班终点',
  `departure_airport` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班起飞机场',
  `dest_airport` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班到达机场',
  `departure_time` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '起飞(departure)时间',
  `arrival_time` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '到达时间',
  `first_class` int(11) NOT NULL COMMENT '头等舱价格First class price',
  `bussiness_class` int(11) NOT NULL COMMENT '商务舱价格',
  `economic_class` int(11) NOT NULL COMMENT '经济舱价格',
  `fir_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `dep_date` date NOT NULL,
  `col` int(11) DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `timeoflight` int(11) DEFAULT NULL,
  `airlinecompany` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`number`) USING BTREE,
  UNIQUE KEY `f_n` (`number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='航班信息';

-- ----------------------------
-- Records of flight
-- ----------------------------
BEGIN;
INSERT INTO `flight` VALUES ('3U3120', '北京', '郑州', '大兴机场', '新郑机场', '07:30', '12:00', 2100, 1500, 800, 18, 67, 30, '2019-12-15', 6, '000000100000000000000000001000100000000000000010001000000000000000000000000000000000000000000000000000000000000000000000', 330, '川航');
INSERT INTO `flight` VALUES ('CA3060', '北京', '上海', '首都机场', '虹桥机场', '08:30', '12:30', 2500, 1600, 1200, 18, 72, 30, '2019-12-24', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 240, '国航');
INSERT INTO `flight` VALUES ('ZH1280', '深圳', '上海', '深圳机场', '虹桥机场', '12:30', '04:30', 2000, 1000, 500, 18, 72, 30, '2019-12-24', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 240, '深圳航空');
INSERT INTO `flight` VALUES ('CA2333', '北京', '重庆', '首都机场', '重庆机场', '7:00', '12:00', 3000, 2000, 1000, 18, 72, 30, '2019-12-15', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 300, '国航');
INSERT INTO `flight` VALUES ('BK6280', '北京', '香港', '首都机场', '香港机场', '4:00', '16:00', 3500, 2000, 1000, 18, 72, 30, '2019-12-15', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 720, '奥凯航空');
INSERT INTO `flight` VALUES ('CZ7130', '北京', '武汉', '首都机场', '天河机场', '12:00', '5:00', 1000, 700, 500, 18, 72, 30, '2019-12-15', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 300, '南航');
INSERT INTO `flight` VALUES ('CZ7180', '北京', '武汉', '首都机场', '天河机场', '12:00', '3:00', 2000, 1000, 600, 18, 72, 30, '2019-12-15', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 180, '南航');
INSERT INTO `flight` VALUES ('FM2333', '北京', '武汉', '首都机场', '天河机场', '7:00', '12:30', 2500, 2200, 1000, 18, 72, 30, '2019-12-15', 6, '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000', 330, '成都航空');
COMMIT;

-- ----------------------------
-- Table structure for orderlist
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist` (
  `number` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `people_cnt` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `usrname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `orderid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`orderid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderlist
-- ----------------------------
BEGIN;
INSERT INTO `orderlist` VALUES ('3U3120', 3, '2019-12-07 16:17:46.000000', '000000100000000000000000001000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000', 'lzl', 'lzl20191207161746');
INSERT INTO `orderlist` VALUES ('3U3120', 2, '2019-12-07 16:18:29.000000', '000000000000000000000000000000100000000000000000001000000000000000000000000000000000000000000000000000000000000000000000', 'lzl', 'lzl20191207161829');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
