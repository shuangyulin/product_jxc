-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_productClass` (
  `productClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品类别id',
  `productClassName` varchar(40)  NOT NULL COMMENT '商品类别名称',
  PRIMARY KEY (`productClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_product` (
  `productNo` varchar(40)  NOT NULL COMMENT 'productNo',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(20)  NOT NULL COMMENT '商品名称',
  `productPhoto` varchar(60)  NOT NULL COMMENT '产品图片',
  `count` int(11) NOT NULL COMMENT '商品库存',
  `price` float NOT NULL COMMENT '市场价',
  `madeAddress` varchar(50)  NULL COMMENT '产地',
  `guige` varchar(50)  NULL COMMENT '规格',
  `madeDate` varchar(20)  NULL COMMENT '生产日期',
  `yxq` varchar(30)  NULL COMMENT '有效期',
  `beizhu` varchar(500)  NULL COMMENT '备注',
  PRIMARY KEY (`productNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_employee` (
  `employeeNo` varchar(40)  NOT NULL COMMENT 'employeeNo',
  `password` varchar(40)  NULL COMMENT '登录密码',
  `name` varchar(30)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `photo` varchar(60)  NOT NULL COMMENT '员工照片',
  `department` varchar(30)  NOT NULL COMMENT '所在部门',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '联系地址',
  PRIMARY KEY (`employeeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_attendance` (
  `attendanceId` int(11) NOT NULL AUTO_INCREMENT COMMENT '出勤id',
  `employeeObj` varchar(40)  NOT NULL COMMENT '员工',
  `year` varchar(20)  NOT NULL COMMENT '年份',
  `month` varchar(20)  NOT NULL COMMENT '月份',
  `shouldComeDays` float NOT NULL COMMENT '应到天数',
  `leaveDays` float NOT NULL COMMENT '请假天数',
  `absenceDays` float NOT NULL COMMENT '缺勤天数',
  PRIMARY KEY (`attendanceId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_salary` (
  `salaryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '工资id',
  `employeeObj` varchar(40)  NOT NULL COMMENT '员工',
  `year` varchar(20)  NOT NULL COMMENT '年份',
  `month` varchar(20)  NOT NULL COMMENT '月份',
  `attendanceMoney` float NOT NULL COMMENT '考勤扣除',
  `secureMoney` float NOT NULL COMMENT '保险扣除',
  `salaryMoney` float NOT NULL COMMENT '工资金额',
  PRIMARY KEY (`salaryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_purchase` (
  `purchaseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '进货id',
  `productObj` varchar(40)  NOT NULL COMMENT '进货商品',
  `supplierObj` int(11) NOT NULL COMMENT '供应商',
  `price` float NOT NULL COMMENT '进货单价',
  `count` int(11) NOT NULL COMMENT '进货数量',
  `purchaseDate` varchar(20)  NULL COMMENT '进货日期',
  `employeeObj` varchar(40)  NOT NULL COMMENT '进货员工',
  `memo` varchar(500)  NULL COMMENT '备注',
  PRIMARY KEY (`purchaseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_sale` (
  `saleId` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售id',
  `productObj` varchar(40)  NOT NULL COMMENT '销售商品',
  `userObj` varchar(50)  NOT NULL COMMENT '销售客户',
  `price` float NOT NULL COMMENT '销售单价',
  `count` int(11) NOT NULL COMMENT '销售数量',
  `saleDate` varchar(20)  NULL COMMENT '销售日期',
  `employeeObj` varchar(40)  NOT NULL COMMENT '销售员工',
  `memo` varchar(500)  NULL COMMENT '备注',
  PRIMARY KEY (`saleId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(50)  NOT NULL COMMENT 'user_name',
  `password` varchar(40)  NULL COMMENT '登录密码',
  `name` varchar(80)  NOT NULL COMMENT '会员全称',
  `legalMan` varchar(20)  NOT NULL COMMENT '联系人',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '地址',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_supplier` (
  `supplierId` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商id',
  `supplierName` varchar(60)  NOT NULL COMMENT '供应商名称',
  `personName` varchar(20)  NOT NULL COMMENT '联系人',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '地址',
  PRIMARY KEY (`supplierId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_product ADD CONSTRAINT FOREIGN KEY (productClassObj) REFERENCES t_productClass(productClassId);
ALTER TABLE t_attendance ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);
ALTER TABLE t_salary ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);
ALTER TABLE t_purchase ADD CONSTRAINT FOREIGN KEY (productObj) REFERENCES t_product(productNo);
ALTER TABLE t_purchase ADD CONSTRAINT FOREIGN KEY (supplierObj) REFERENCES t_supplier(supplierId);
ALTER TABLE t_purchase ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);
ALTER TABLE t_sale ADD CONSTRAINT FOREIGN KEY (productObj) REFERENCES t_product(productNo);
ALTER TABLE t_sale ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_sale ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);


