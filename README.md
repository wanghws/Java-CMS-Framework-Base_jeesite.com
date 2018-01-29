# Java管理后台快速开发SSM框架_优化版-JDK1.8

## 框架简介

JeeSite是基于多个优秀的开源项目，高度整合封装而成的高效，高性能，强安全性的开源Java开发平台。

本人在开发中,使用了此项目,同时在开发过程中,对项目进行了部分优化修改,感谢原作者.

## 以下为修改部分

1.	表自增ID改为Long型,使用了[分布式唯一ID生成器Twitter 的 Snowflake idworker java版本]
2.	数据库连接改为[读写分离]
3.	项目第三方包引用全部改为Maven
4.	项目启动删除了Tomcat插件,改为自启动的Jetty插件
5.	Maven打包改为支持多profile方式,具体使用是请将src/resources/conf_development下的配置文件拷贝到conf_production和conf_test下并做对应配置
6.	引入了JRedis支持
7.	SpringMVC增加了Https支持,没有证书的环境设置init.properties中的http10=true,生成环境为false
8.	jquery-validation增加了部分验证规则
9.	其他代码结构,路径等基于个人喜好的修改

## 主要组件

1.	spring
2.	mybatis
3.  spring-mvc
4.  sitemesh
5.  ehcache
6.  jedis
7.  shiro
8.  jackson
9.  xstream
10. dozer
11. freemarker
12. zxing
13. httpclient


## 表单验证
1.	required: "必填信息",
2.	remote: "请修正该信息",
3.	email: "请输入正确格式的电子邮件",
4.	url: "请输入合法的网址",
5.	date: "请输入合法的日期",
6.	dateISO: "请输入合法的日期 (ISO).",
7.	number: "请输入合法的数字",
8.	digits: "只能输入整数",
9.	creditcard: "请输入合法的信用卡号",
10.	equalTo: "请再次输入相同的值",
11.	accept: "请输入拥有合法后缀名的字符串",
12.	maxlength:请输入一个长度最多是 {0} 的字符串
13.	minlength: 请输入一个长度最少是 {0} 的字符串
14.	rangelength: 请输入一个长度介于 {0} 和 {1} 之间的字符串
15.	range: 请输入一个介于 {0} 和 {1} 之间的值
16.	max: 请输入一个最大为 {0} 的值
17.	min: 请输入一个最小为 {0} 的值
18.	文本框验证：字段长度除以2 varchar(32)==16个字符
19.	数字类型字段验证：字段长度除以2 int(10)==5位整数
20.	金额字段验证：number(10,2) 表单验证 999999999.99
21.	备注/说明字段用textarea表单
22.	创建时间为框架自动生成，不允许手动设置
23.	ip：ip地址
24.	abc：字母或下划线
25.	username：3-20位字母或数字开头，字母或下划线
26.	realName：2-30个汉字
27.	mobile：11位手机号码
28.	simplePhone：固定电话
29.	zipCode：邮编
30.	qq：6~9位qq号码
31.	card：15~18位身份证
32.	money：99999999.99金额

* 有任何问题建议可以联系我 wanghws(AT)gmail(DOT)com
