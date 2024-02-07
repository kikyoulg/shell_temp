-- CREATE DATABASE fedx;
-- create database IF NOT EXISTS test2;

CREATE TABLE IF NOT EXISTS default.fedx_system_log_src (
     `sessionId`    String     COMMENT 'message',
     `username`     String 	   comment '用户名',
     `ip`           String 	   COMMENT '用户IP',
     `level`        String 	   COMMENT '日志级别',
     `content`      String 	   COMMENT '备注操作行为',
     `consumTime`   String     COMMENT '消耗时间单位ms',
     `trace`        String 	   COMMENT '',
     `span`         String 	   COMMENT '',
     `parent`       String     COMMENT '',
     `exportable`   String     COMMENT '',
     `thread`       String 	   COMMENT '线程',
     `classname`    String 	   COMMENT '操作类',
     `message`      String     COMMENT 'message',
     `stacktrace`   String 	   COMMENT 'exception{10}',
     `exception`    String 	   COMMENT 'exception',
     `servletpath`  String     COMMENT 'servletpath',
     `method`       String     COMMENT '请求方式',
     `mark1`        String     COMMENT '备用字段1',
     `mark2`        String     COMMENT '备用字段2',
     `mark3`        String     COMMENT '备用字段3',
     `createtime` DateTime     COMMENT '创建时间'
) ENGINE = Kafka()
    SETTINGS
        kafka_broker_list = 'kafka:9092',
        kafka_topic_list = 'fedx_system_log',
        kafka_group_name = 'clickhouse',
        kafka_format = 'JSONEachRow';

CREATE TABLE IF NOT EXISTS default.fedx_system_log (
     `sessionId`    String     COMMENT 'message',
     `username`     String 	   comment '用户名',
     `ip`           String 	   COMMENT '用户IP',
     `level`        String 	   COMMENT '日志级别',
     `content`      String 	   COMMENT '备注操作行为',
     `consumTime`   String     COMMENT '消耗时间单位ms',
     `trace`        String 	   COMMENT '',
     `span`         String 	   COMMENT '',
     `parent`       String     COMMENT '',
     `exportable`   String     COMMENT '',
     `thread`       String 	   COMMENT '线程',
     `classname`    String 	   COMMENT '操作类',
     `message`      String     COMMENT 'message',
     `stacktrace`   String 	   COMMENT 'exception{10}',
     `exception`    String 	   COMMENT 'exception',
     `servletpath`  String     COMMENT 'servletpath',
     `method`       String     COMMENT '请求方式',
     `mark1`        String     COMMENT '备用字段1',
     `mark2`        String     COMMENT '备用字段2',
     `mark3`        String     COMMENT '备用字段3',
     `createtime` DateTime     COMMENT '创建时间'
) ENGINE = MergeTree()
    partition by toDate(createtime)
    ORDER BY createtime;

CREATE MATERIALIZED VIEW IF NOT EXISTS default.fedx_system_log_consumer TO fedx_system_log
AS SELECT * FROM fedx_system_log_src ;

-- 日志审计表
CREATE TABLE IF NOT EXISTS default.fedx_audit_log
(
    id           String comment 'id',
    user_id      String comment '用户id',
    project_name String comment '项目名称',
    project_id   String comment '项目id',
    common_id    String comment '通用id',
    type_name    String comment '类型名称',
    type_id      UInt8 comment '类型id',
    content      String comment '日志内容',
    create_date  DateTime comment '创建时间',
    user_name    String comment '用户名',
    log_key      String comment '关键字'
)
    engine = MergeTree ORDER BY id
        SETTINGS index_granularity = 8192;
