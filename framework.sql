-- MySQL dump 10.13  Distrib 5.7.18, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gen_scheme`
--

DROP TABLE IF EXISTS `gen_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_scheme` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成表编号',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='生成方案';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表外键',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_name` (`name`),
  KEY `gen_table_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `gen_template`
--

DROP TABLE IF EXISTS `gen_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_template` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件名',
  `content` text COLLATE utf8_bin COMMENT '内容',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_template_del_falg` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='代码模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_template`
--

LOCK TABLES `gen_template` WRITE;
/*!40000 ALTER TABLE `gen_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_area`
--

DROP TABLE IF EXISTS `sys_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_area` (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_area`
--

LOCK TABLES `sys_area` WRITE;
/*!40000 ALTER TABLE `sys_area` DISABLE KEYS */;
INSERT INTO `sys_area` VALUES (1,0,'0,','中国',10,'100000','1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(2,1,'0,1,','北京',20,'8888','2','1','2013-05-27 08:00:00','1','2017-08-08 19:20:33','','0'),(3,3,'0,1,2,3,3,','北京市',30,'100001','3','1','2013-05-27 08:00:00','1','2017-06-20 19:44:59','','0'),(4,3,'0,1,2,3,3,','朝阳区',40,'100002','4','1','2013-05-27 08:00:00','1','2017-06-01 19:21:53','','0'),(5,3,'0,1,2,3,3,','西城区',50,'100003','4','1','2013-05-27 08:00:00','1','2017-06-01 19:22:04','','0'),(6,3,'0,1,2,3,3,','东城区',60,'100003','4','1','2013-05-27 08:00:00','1','2017-06-01 19:22:11','','0'),(8,6,'0,1,2,3,4,6','密云县',70,'10000000',NULL,'1','2017-06-21 11:02:32','1','2017-06-21 11:02:42',NULL,'0'),(394703399045566464,2,'0,1,2,','海淀区',30,'','1','1','2017-06-20 19:45:18','1','2017-06-20 19:45:18','','0'),(394703495481004032,2,'0,1,2,','朝阳区',30,'1000000','1','1','2017-06-20 19:45:41','1','2017-06-20 19:45:41','','0'),(405436972463558656,1,'0,1,','上海',30,'10002','2','1','2017-07-20 10:36:42','1','2017-08-08 19:19:10','','0'),(405437141661782016,1,'0,1,','山东省',30,'10005','2','1','2017-07-20 10:37:22','1','2017-07-31 10:24:06','','1'),(406878910484058112,2,'0,1,2,','顺义',30,'101300','4','1','2017-07-24 10:06:26','1','2017-07-24 10:06:26','','0'),(406879382611693568,2,'0,1,2,','顺义区',30,'101300','4','1','2017-07-24 10:08:19','1','2017-07-24 10:08:19','','0'),(408326576413872128,1,'0,1,','山东',30,'','2','1','2017-07-28 09:58:57','1','2017-08-08 19:17:42','','0'),(408326667828727808,1,'0,1,','青岛',30,'','3','1','2017-07-28 09:59:19','1','2017-07-31 10:23:15','','0'),(408326750376824832,408326576413872128,'0,1,408326576413872128,','烟台',30,'','2','1','2017-07-28 09:59:38','1','2017-08-08 19:17:56','','0'),(412453566507126784,408326576413872128,'0,1,408326576413872128,','菏泽',30,'','2','1','2017-08-08 19:18:08','1','2017-08-08 19:18:08','','0'),(412453613428805632,412453566507126784,'0,1,408326576413872128,412453566507126784,','曹县',30,'','4','1','2017-08-08 19:18:19','1','2017-08-08 19:18:19','','0'),(412453712628289536,408326667828727808,'0,1,408326667828727808,','崂山区',30,'','3','1','2017-08-08 19:18:43','1','2017-08-08 19:18:43','','0'),(412453955499462656,405436972463558656,'0,1,405436972463558656,','浦东新区',30,'','3','1','2017-08-08 19:19:41','1','2017-08-08 19:19:41','','0');
/*!40000 ALTER TABLE `sys_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL,
  `value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` bigint(20) DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES (1,'0','正常','del_flag','删除标记',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(2,'1','删除','del_flag','删除标记',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(3,'0','隐藏','show_hide','显示/隐藏',10,0,'1','2013-05-27 08:00:00','1','2017-07-25 16:53:25','','0'),(4,'1','显示','show_hide','显示/隐藏',20,0,'1','2013-05-27 08:00:00','1','2017-07-25 16:53:30','','0'),(5,'1','是','yes_no','是/否',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(6,'0','否','yes_no','是/否',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(7,'red','红色','color','颜色值',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(8,'green','绿色','color','颜色值',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(9,'blue','蓝色','color','颜色值',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(10,'yellow','黄色','color','颜色值',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(11,'orange','橙色','color','颜色值',50,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(12,'default','默认主题','theme','主题方案',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(13,'cerulean','天蓝主题','theme','主题方案',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(14,'readable','橙色主题','theme','主题方案',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(15,'united','红色主题','theme','主题方案',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(16,'flat','Flat主题','theme','主题方案',60,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(17,'1','国家','sys_area_type','区域类型',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(18,'2','省份、直辖市','sys_area_type','区域类型',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(19,'3','地市','sys_area_type','区域类型',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(20,'4','区县','sys_area_type','区域类型',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(21,'1','公司','sys_office_type','机构类型',60,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(22,'2','部门','sys_office_type','机构类型',70,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(23,'3','小组','sys_office_type','机构类型',80,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(24,'4','其它','sys_office_type','机构类型',90,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(25,'1','综合部','sys_office_common','快捷通用部门',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(26,'2','开发部','sys_office_common','快捷通用部门',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(27,'3','人力部','sys_office_common','快捷通用部门',50,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(28,'1','一级','sys_office_grade','机构等级',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(29,'2','二级','sys_office_grade','机构等级',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(30,'3','三级','sys_office_grade','机构等级',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(31,'4','四级','sys_office_grade','机构等级',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(32,'1','所有数据','sys_data_scope','数据范围',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(33,'2','所在公司及以下数据','sys_data_scope','数据范围',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(34,'3','所在公司数据','sys_data_scope','数据范围',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(35,'4','所在部门及以下数据','sys_data_scope','数据范围',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(36,'5','所在部门数据','sys_data_scope','数据范围',50,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(37,'8','仅本人数据','sys_data_scope','数据范围',90,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(38,'9','按明细设置','sys_data_scope','数据范围',100,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(39,'1','系统管理','sys_user_type','用户类型',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(40,'2','部门经理','sys_user_type','用户类型',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(41,'3','普通用户','sys_user_type','用户类型',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(42,'basic','基础主题','cms_theme','站点主题',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(43,'blue','蓝色主题','cms_theme','站点主题',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),(44,'red','红色主题','cms_theme','站点主题',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),(45,'article','文章模型','cms_module','栏目模型',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(46,'picture','图片模型','cms_module','栏目模型',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),(47,'download','下载模型','cms_module','栏目模型',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),(48,'link','链接模型','cms_module','栏目模型',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(49,'special','专题模型','cms_module','栏目模型',50,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),(50,'0','默认展现方式','cms_show_modes','展现方式',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(51,'1','首栏目内容列表','cms_show_modes','展现方式',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(52,'2','栏目第一条内容','cms_show_modes','展现方式',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(53,'0','发布','cms_del_flag','内容状态',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(54,'1','删除','cms_del_flag','内容状态',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(55,'2','审核','cms_del_flag','内容状态',15,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(56,'1','首页焦点图','cms_posid','推荐位',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(57,'2','栏目页文章推荐','cms_posid','推荐位',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(58,'1','咨询','cms_guestbook','留言板分类',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(59,'2','建议','cms_guestbook','留言板分类',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(60,'3','投诉','cms_guestbook','留言板分类',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(61,'4','其它','cms_guestbook','留言板分类',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(62,'1','公休','oa_leave_type','请假类型',10,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(63,'2','病假','oa_leave_type','请假类型',20,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(64,'3','事假','oa_leave_type','请假类型',30,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(65,'4','调休','oa_leave_type','请假类型',40,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(66,'5','婚假','oa_leave_type','请假类型',60,0,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(67,'1','接入日志','sys_log_type','日志类型',30,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(68,'2','异常日志','sys_log_type','日志类型',40,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(69,'leave','请假流程','act_type','流程类型',10,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(70,'test_audit','审批测试流程','act_type','流程类型',20,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(71,'1','分类1','act_category','流程分类',10,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(72,'2','分类2','act_category','流程分类',20,0,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(73,'crud','增删改查','gen_category','代码生成分类',10,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(74,'crud_many','增删改查（包含从表）','gen_category','代码生成分类',20,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(75,'tree','树结构','gen_category','代码生成分类',30,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(76,'=','=','gen_query_type','查询方式',10,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(77,'!=','!=','gen_query_type','查询方式',20,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(78,'&gt;','&gt;','gen_query_type','查询方式',30,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(79,'&lt;','&lt;','gen_query_type','查询方式',40,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(80,'between','Between','gen_query_type','查询方式',50,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(81,'like','Like','gen_query_type','查询方式',60,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(82,'left_like','Left Like','gen_query_type','查询方式',70,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(83,'right_like','Right Like','gen_query_type','查询方式',80,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(84,'input','文本框','gen_show_type','字段生成方案',10,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(85,'textarea','文本域','gen_show_type','字段生成方案',20,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(86,'select','下拉框','gen_show_type','字段生成方案',30,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(87,'checkbox','复选框','gen_show_type','字段生成方案',40,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(88,'radiobox','单选框','gen_show_type','字段生成方案',50,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(89,'dateselect','日期选择','gen_show_type','字段生成方案',60,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(90,'userselect','人员选择\0','gen_show_type','字段生成方案',70,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(91,'officeselect','部门选择','gen_show_type','字段生成方案',80,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(92,'areaselect','区域选择','gen_show_type','字段生成方案',90,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(93,'String','String','gen_java_type','Java类型',10,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(94,'Long','Long','gen_java_type','Java类型',20,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(95,'dao','仅持久层','gen_category','代码生成分类\0\0\0\0\0\0',40,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(96,'1','男','sex','性别',10,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(97,'2','女','sex','性别',20,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(98,'Integer','Integer','gen_java_type','Java类型\0\0',30,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(99,'Double','Double','gen_java_type','Java类型\0\0',40,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(100,'java.util.Date','Date','gen_java_type','Java类型\0\0',50,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(101,'com.thinkgem.jeesite.modules.sys.entity.User','User','gen_java_type','Java类型\0\0',60,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(102,'com.thinkgem.jeesite.modules.sys.entity.Office','Office','gen_java_type','Java类型\0\0',70,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(103,'com.thinkgem.jeesite.modules.sys.entity.Area','Area','gen_java_type','Java类型\0\0',80,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(104,'Custom','Custom','gen_java_type','Java类型\0\0',90,0,'1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),(105,'1','会议通告\0\0\0\0','oa_notify_type','通知通告类型',10,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(106,'2','奖惩通告\0\0\0\0','oa_notify_type','通知通告类型',20,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(107,'3','活动通告\0\0\0\0','oa_notify_type','通知通告类型',30,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(108,'0','草稿','oa_notify_status','通知通告状态',10,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(109,'1','发布','oa_notify_status','通知通告状态',20,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(110,'0','未读','oa_notify_read','通知通告状态',10,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(111,'1','已读','oa_notify_read','通知通告状态',20,0,'1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(399734270882484224,'1','未跟进','follow_status','跟进状态',10,NULL,'1','2017-07-04 16:56:12','1','2017-07-04 16:56:12','','0'),(399734399081385984,'2','跟进中','follow_status','跟进状态',20,NULL,'1','2017-07-04 16:56:42','1','2017-07-04 16:56:42','','0'),(400045284677128192,'1','天','skill_unit','计价单位',10,NULL,'1','2017-07-05 13:32:03','1','2017-07-05 13:32:03','','0'),(400045436489961472,'2','次','skill_unit','计价单位',20,NULL,'1','2017-07-05 13:32:39','1','2017-07-05 13:32:39','','0'),(400046231675473920,'1','单项服务','skill_category','技能项类型',10,NULL,'1','2017-07-05 13:35:49','1','2017-07-17 15:01:48','','0'),(400046314521366528,'2','基础服务','skill_category','技能项类型',20,NULL,'1','2017-07-05 13:36:09','1','2017-07-17 15:01:56','','0'),(400061439315808256,'1','是','message_remind','短信提醒',10,NULL,'1','2017-07-05 14:36:15','1','2017-07-05 14:36:15','','0'),(400061523218665472,'2','否','message_remind','短信提醒',20,NULL,'1','2017-07-05 14:36:35','1','2017-07-05 14:36:35','','0'),(400482298627100672,'1','寄件','deposit_type','寄取类型',10,NULL,'1','2017-07-06 18:28:35','1','2017-07-06 18:28:35','','0'),(400482366541271040,'2','取件','deposit_type','寄取类型',20,NULL,'1','2017-07-06 18:28:52','1','2017-07-06 18:28:52','','0'),(400719930514739200,'2','按单价计价','way_measureWay','计量方式',10,NULL,'1','2017-07-07 10:12:51','1','2017-07-07 11:37:40','','0'),(400720121284268032,'1','按包价计价','way_measureWay','计量方式',10,NULL,'1','2017-07-07 10:13:37','1','2017-07-07 11:37:36','','0'),(402954116432662528,'1','员工','live_type','入住类型',10,NULL,'1','2017-07-13 14:10:43','1','2017-07-13 14:10:43','','0'),(402954208178868224,'2','学员','live_type','入住类型',20,NULL,'1','2017-07-13 14:11:05','1','2017-07-13 14:11:05','','0'),(404331342885556224,'0','启用','sys_finaceType_status','状态',10,NULL,'1','2017-07-17 09:23:19','1','2017-07-17 09:23:52','','0'),(404331461055877120,'1','停用','sys_finaceType_status','状态',10,NULL,'1','2017-07-17 09:23:47','1','2017-07-17 09:23:47','','0'),(404333651380146176,'1','收入','sys_finaceType_paymentType','收入类型',10,NULL,'1','2017-07-17 09:32:29','1','2017-07-17 09:32:29','','0'),(404333734486085632,'2','支出','sys_finaceType_paymentType','收入类型',10,NULL,'1','2017-07-17 09:32:49','1','2017-07-17 09:32:49','','0');
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `params` text COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text COLLATE utf8_bin COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_mdict`
--

DROP TABLE IF EXISTS `sys_mdict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_mdict` (
  `id` bigint(20) NOT NULL,
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多级字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_mdict`
--

LOCK TABLES `sys_mdict` WRITE;
/*!40000 ALTER TABLE `sys_mdict` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_mdict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL,
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `is_show` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'0','0,','功能菜单',0,NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(2,'1','0,1,','设置',12,'','','','1','','1','2013-05-27 08:00:00','1','2017-08-16 20:41:39','','0'),(3,'2','0,1,2,','权限管理',0,'','','','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:47:38','','0'),(4,'3','0,1,2,3,','菜单管理',1,'/sys/menu/',NULL,'list-alt','1','sys:menu:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(6,'4','0,1,2,3,4,','修改',40,NULL,NULL,NULL,'0','sys:menu:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(7,'3','0,1,2,3,','角色管理',2,'/sys/role/','','lock','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:37:22','','0'),(8,'7','0,1,2,3,7,','查看',30,NULL,NULL,NULL,'0','sys:role:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(9,'7','0,1,2,3,7,','修改',40,NULL,NULL,NULL,'0','sys:role:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(10,'399641207413673984','0,1,2,399641207413673984,','框架字典',3,'/sys/dict/','','th-list','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:46:58','','0'),(11,'10','0,1,2,399641207413673984,10,','查看',30,NULL,NULL,NULL,'0','sys:dict:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(12,'10','0,1,2,399641207413673984,10,','修改',40,NULL,NULL,NULL,'0','sys:dict:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(13,'2','0,1,2,','用户管理',0,'','','','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:48:08','','0'),(14,'399641207413673984','0,1,2,399641207413673984,','地址管理',1,'/sys/area/','','th','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:46:40','','0'),(15,'14','0,1,2,399641207413673984,14,','查看',30,NULL,NULL,NULL,'0','sys:area:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(16,'14','0,1,2,399641207413673984,14,','修改',40,NULL,NULL,NULL,'0','sys:area:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(17,'399640261942054912','0,1,2,399640261942054912,','部门设置',2,'/sys/office/','','th-large','1','','1','2013-05-27 08:00:00','1','2017-07-04 10:44:25','','0'),(18,'17','0,1,2,399640261942054912,17,','查看',30,NULL,NULL,NULL,'0','sys:office:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(19,'17','0,1,2,399640261942054912,17,','修改',40,NULL,NULL,NULL,'0','sys:office:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(20,'13','0,1,2,13,','用户管理',1,'/sys/user/index',NULL,'user','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(21,'20','0,1,2,13,20,','查看',30,NULL,NULL,NULL,'0','sys:user:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(22,'20','0,1,2,13,20,','修改',40,NULL,NULL,NULL,'0','sys:user:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(60,'31','0,1,31,','统计分析',600,NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(61,'60','0,1,31,60,','信息量统计',30,'/cms/stats/article',NULL,'tasks','1','cms:stats:article','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(67,'2','0,1,2,','日志查询',9,NULL,NULL,NULL,'1',NULL,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(68,'67','0,1,2,67,','日志查询',1,'/sys/log',NULL,'pencil','1','sys:log:view','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),(69,'62','0,1,62,','流程管理',300,NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(70,'69','0,1,62,69,','流程管理',50,'/act/process',NULL,'road','1','act:process:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(79,'1','0,1,','代码生成',12,'','','','0','','1','2013-10-16 08:00:00','1','2017-08-16 20:40:48','','0'),(80,'79','0,1,79,','代码生成',50,NULL,NULL,NULL,'1',NULL,'1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),(81,'80','0,1,79,80,','生成方案配置',30,'/gen/genScheme',NULL,NULL,'1','gen:genScheme:view,gen:genScheme:edit','1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),(82,'80','0,1,79,80,','业务表配置',20,'/gen/genTable',NULL,NULL,'1','gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit','1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),(85,'76','0,1,75,76,','行政区域',80,'/../static/map/map-city.html',NULL,NULL,'1',NULL,'1','2013-10-22 08:00:00','1','2013-10-22 08:00:00',NULL,'0'),(88,'387804229927964672','0,1,387804229927964672','通知通告',20,'','','','1','','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),(387807708012613632,'399641207413673984','0,1,2,399641207413673984,','基础类型',2,'/erp/commonsType/list','','book','1','erp:commonsType:list','1','2017-06-01 19:04:17','1','2017-07-25 16:50:42','','1'),(397821800639107072,'397821800639107072','0,1,397821800639107072,397821800639107072,','员工定级',5030,'','','','1','','1','2017-06-29 10:16:43','1','2017-06-29 10:18:01','','0'),(399640261942054912,'2','0,1,2,','人事设置',2,'','','','1','','1','2017-07-04 10:42:38','1','2017-07-04 10:42:38','','0'),(399641207413673984,'2','0,1,2,','基础设置',8,'','','','1','','1','2017-07-04 10:46:24','1','2017-07-04 10:46:24','','0'),(407264404367740928,'387807708012613632','0,1,2,399641207413673984,387807708012613632,','基础类型表单',30,'/erp/commonsType/form','','','0','erp:commonsType:form','1','2017-07-25 11:38:15','1','2017-07-25 15:45:37','','1'),(407264798468739072,'387807708012613632','0,1,2,399641207413673984,387807708012613632,','基础类型新增/修改',60,'/erp/commonsType/save','','','0','erp:commonsType:save','1','2017-07-25 11:39:49','1','2017-07-25 15:45:49','','1'),(407264926533423104,'387807708012613632','0,1,2,399641207413673984,387807708012613632,','基础类型删除',90,'/erp/commonsType/delete','','','0','erp:commonsType:delete','1','2017-07-25 11:40:20','1','2017-07-25 15:46:02','','1'),(407342930047537152,'387807708012613632','0,1,2,399641207413673984,387807708012613632,','基础类型-更新缓存',120,'/erp/commonsType/updateCache','','','0','erp:commonsType:updateCache','1','2017-07-25 16:50:17','1','2017-07-25 16:52:09','','1');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notify`
--

DROP TABLE IF EXISTS `sys_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notify` (
  `id` bigint(20) NOT NULL,
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `title` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `status` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notify`
--

LOCK TABLES `sys_notify` WRITE;
/*!40000 ALTER TABLE `sys_notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notify_record`
--

DROP TABLE IF EXISTS `sys_notify_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notify_record` (
  `id` bigint(20) NOT NULL,
  `oa_notify_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告发送记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notify_record`
--

LOCK TABLES `sys_notify_record` WRITE;
/*!40000 ALTER TABLE `sys_notify_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_notify_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_office`
--

DROP TABLE IF EXISTS `sys_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_office` (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属区域',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构类型',
  `grade` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构等级',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '传真',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='机构表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_office`
--

LOCK TABLES `sys_office` WRITE;
/*!40000 ALTER TABLE `sys_office` DISABLE KEYS */;
INSERT INTO `sys_office` VALUES (1,0,'0,','Demo Corp',10,'2','BN000','1','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),(447909202564747264,1,'0,1,','技术部',30,'4','BN000001','2','1','','','','','','','1',NULL,NULL,'1','2017-11-14 15:26:10','1','2017-11-14 15:26:10','','0');
/*!40000 ALTER TABLE `sys_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `enname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '数据范围',
  `is_sys` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `sys_role_enname` (`enname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,1,'系统管理员','admin','assignment','1','1','1','1','2013-05-27 08:00:00','1','2017-09-25 10:22:56','','0');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,1),(1,2),(1,3),(1,4),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,60),(1,61),(1,67),(1,68),(1,69),(1,70),(1,79),(1,80),(1,81),(1,82),(1,84),(1,85),(1,88),(1,387807708012613632),(1,397821800639107072),(1,399640261942054912),(1,399641207413673984),(1,407264404367740928),(1,407264798468739072),(1,407264926533423104),(1,407342930047537152),(405495138194821120,1),(405495138194821120,2),(405495138194821120,3),(405495138194821120,4),(405495138194821120,6),(405495138194821120,7),(405495138194821120,8),(405495138194821120,9),(405495138194821120,10),(405495138194821120,11),(405495138194821120,12),(405495138194821120,13),(405495138194821120,14),(405495138194821120,15),(405495138194821120,16),(405495138194821120,17),(405495138194821120,18),(405495138194821120,19),(405495138194821120,20),(405495138194821120,21),(405495138194821120,22),(405495138194821120,67),(405495138194821120,68),(405495138194821120,84),(405495138194821120,387807708012613632),(405495138194821120,399640261942054912),(405495138194821120,399641207413673984),(405497830556307456,1),(405497830556307456,2),(405497830556307456,3),(405497830556307456,4),(405497830556307456,6),(405497830556307456,7),(405497830556307456,8),(405497830556307456,9),(405497830556307456,10),(405497830556307456,11),(405497830556307456,12),(405497830556307456,13),(405497830556307456,14),(405497830556307456,15),(405497830556307456,16),(405497830556307456,17),(405497830556307456,18),(405497830556307456,19),(405497830556307456,20),(405497830556307456,21),(405497830556307456,22),(405497830556307456,67),(405497830556307456,68),(405497830556307456,84),(405497830556307456,387807708012613632),(405497830556307456,399640261942054912),(405497830556307456,399641207413673984),(406934327633383424,1),(406941545279787008,1),(406941545279787008,2),(406941545279787008,3),(406941545279787008,4),(406941545279787008,6),(406941545279787008,7),(406941545279787008,8),(406941545279787008,9),(406941545279787008,10),(406941545279787008,11),(406941545279787008,12),(406941545279787008,13),(406941545279787008,14),(406941545279787008,15),(406941545279787008,16),(406941545279787008,17),(406941545279787008,18),(406941545279787008,19),(406941545279787008,20),(406941545279787008,21),(406941545279787008,22),(406941545279787008,67),(406941545279787008,68),(406941545279787008,84),(406941545279787008,387807708012613632),(406941545279787008,399640261942054912),(406941545279787008,399641207413673984),(406960899782348800,1),(407301408203739136,1),(407301408203739136,2),(407302536446349312,1),(407302536446349312,2),(407305467119800320,1),(407305467119800320,2),(407305467119800320,399640261942054912),(407962352860794880,1),(407973434367152128,1),(409408910932316160,1),(409415929529634816,1),(411964138550464512,1),(413096841022803968,1),(413149979306102784,1),(415635100005306368,1),(415636143984349184,1),(415636988159332352,1),(415637625102143488,1),(415637994435776512,1),(415638838061305856,1),(424988005271343104,1),(425372987902922752,1),(425373543467847680,1),(425376113988997120,1),(425376861392998400,1),(425376861392998400,2),(425377980647215104,1),(425381458031415296,1),(425382103165702144,1),(425382103165702144,2),(425382622542172160,1),(425382998750269440,1),(425383568647131136,1),(425383568647131136,2),(425384150371930112,1),(425384150371930112,2),(425384682134179840,1),(425385088637734912,1),(425385438472048640,1),(425386354587734016,1),(425386550021328896,1),(425386735367622656,1),(436250798649774080,1),(436251669043351552,1),(436257581351047168,1),(436259474831839232,1),(436299773721448448,1),(436300184050208768,1),(436300564842680320,1);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_office`
--

DROP TABLE IF EXISTS `sys_role_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_office` (
  `role_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-机构';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_office`
--

LOCK TABLES `sys_role_office` WRITE;
/*!40000 ALTER TABLE `sys_role_office` DISABLE KEYS */;
INSERT INTO `sys_role_office` VALUES (1,1);
/*!40000 ALTER TABLE `sys_role_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `login_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `user_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,1,447909202564747264,'admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0001','系统管理员','dev@demo.com','13810959832','13810959832','',NULL,'127.0.0.1','2017-11-14 15:38:18','1','1','2013-05-27 08:00:00','1','2017-11-14 15:28:33','最高管理员','0');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户-角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,407962352860794880),(3,409415929529634816),(405455110076895232,406941545279787008),(405455110076895232,407973434367152128),(406934953285128192,406941545279787008),(406948871999066112,406934327633383424),(406961195652747264,406960899782348800),(407247543404072960,406960899782348800),(407302739907842048,407302536446349312),(407306346598240256,407305467119800320),(407956972747362304,1),(407962712736272384,407962352860794880),(409409193313832960,409408910932316160),(409416087566815232,409415929529634816),(409479079524306944,409408910932316160),(411964406608433152,411964138550464512),(413097019410747392,407973434367152128),(414566236081360896,409408910932316160),(414566236081360896,411964138550464512),(414574227132256256,406934327633383424),(414574227132256256,409415929529634816),(415639980807819264,425384682134179840),(415640452864151552,425384682134179840),(415641104294088704,425385088637734912),(415641346288652288,425385088637734912),(415641709666373632,425385088637734912),(415642030715179008,425385088637734912),(415642440091832320,425383568647131136),(415642667993534464,425384150371930112),(415642951163580416,425376113988997120),(415647326825091072,425381458031415296),(415647865352753152,425373543467847680),(415648217531682816,425372987902922752),(415648217531682816,436300564842680320),(415928512856199168,425381458031415296),(415928741949083648,425381458031415296),(415928989039726592,425381458031415296),(424988849257582592,424988005271343104),(424994523404308480,1),(424995833717460992,409415929529634816),(424996279739748352,409415929529634816),(425410571676946432,425386550021328896),(436252595279892480,436250798649774080),(436254393956831232,436251669043351552),(436255605473153024,436251669043351552),(436259790574850048,436257581351047168),(436260381074132992,436259474831839232),(436301683878793216,436299773721448448),(436302062884491264,436300184050208768),(438428020051546112,425382998750269440);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-14 15:40:48
