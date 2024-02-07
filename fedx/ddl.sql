CREATE DATABASE IF NOT EXISTS fedx DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
use fedx;
SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`
(
    `id`          bigint NOT NULL COMMENT '项目ID',
    `name`        varchar(256) NULL DEFAULT NULL COMMENT '项目名',
    `type`        varchar(45) NULL COMMENT '项目类型',
    `description` varchar(256) NULL COMMENT '项目描述',
    `frame`       varchar(45) NULL DEFAULT NULL COMMENT '项目框架',
    `resourceCpu` varchar(256) NULL DEFAULT NULL COMMENT '项目cpu资源',
    `resourceMem` varchar(256) NULL DEFAULT NULL COMMENT '项目内存资源',
    `authority`   int NULL DEFAULT NULL COMMENT '1:我发起项目 2:我参与项目',
    `creator`     varchar(64) NULL DEFAULT NULL COMMENT '创建者',
    `updater`     varchar(64) NULL DEFAULT NULL COMMENT '修改者',
    `is_deleted`  tinyint(1) NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  COMMENT = '项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for project_type
-- ----------------------------
DROP TABLE IF EXISTS `project_type`;
CREATE TABLE `project_type`
(
    `id`   bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(128) NULL DEFAULT NULL COMMENT 'value项目名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '项目类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for multiple_party_biz_map
-- ----------------------------
DROP TABLE IF EXISTS `project_member`;
CREATE TABLE `project_member`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `project_id`  bigint not null DEFAULT 0 COMMENT '项目id',
    `user_id`     bigint not null DEFAULT 0 COMMENT '用户id',
    `role`        varchar(256) NULL COMMENT '角色：owner / guest',
    `create_date` datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='项目用户角色映射表' ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for multiple_party_biz_map
-- ----------------------------
DROP TABLE IF EXISTS `project_party_map`;
CREATE TABLE `project_party_map`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `project_id`  bigint not null DEFAULT 0 COMMENT '项目id',
    `party_id`    varchar(255) NULL DEFAULT '' COMMENT 'FATE的参与方标识id',
    `create_date` datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='项目映射表' ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for dataset
-- ----------------------------
DROP TABLE IF EXISTS `dataset`;
CREATE TABLE `dataset`
(
    `id`                  bigint      not null COMMENT '主键',
    `project_id`          bigint NULL COMMENT 'project_info.id 即 项目id',
    `datasource_id`       bigint NULL COMMENT 'datasource.id 即 数据源id，如果为空，则使用默认数据源',
    `scheduler_id`        bigint NULL COMMENT 'scheduler.id 即 scheduler.id',
    `party_id`            varchar(255) NULL DEFAULT '' COMMENT 'FATE的参与方标识id',
    `namespace`           varchar(255) NULL COMMENT '原生FATE中 命名空间名',
    `table_name`          varchar(12000) NULL COMMENT '原生FATE中 表名',
    `hdfs_dest_data_path` varchar(255) NULL COMMENT 'hdfs目标端数据路径，即pod内的路径',
    `hdfs_src_data_path`  varchar(255) NULL COMMENT 'hdfs源头端数据路径，即源端路径',
    `upload_type`         int NULL COMMENT '上传方式（0:hdfs,1:hive 2:mysql 3nfs）',
    `status`              int         not null default 0 COMMENT '状态（0待上传，1上传中，2上传完成 3待加载，4加载中，5加载完成）',
    `label_column`        varchar(255) not null default "" COMMENT '标签列名称',
    `summary_data`        text NULL COMMENT '数据集选择某几列后的列详情',
    `job_param`           text NULL COMMENT '列及类型',
    `encrypt_column`      text NULL COMMENT '加密列',
    `compute_column`      text NULL COMMENT '参与计算列',
    `is_use`              tinyint(1) NULL DEFAULT 0 COMMENT '数据集是否在使用(1:是,0:未使用)',
    `file_size`           varchar(1024) NULL DEFAULT '0 kb' COMMENT '文件大小',
    `file_rows`           bigint NULL DEFAULT 0 COMMENT '文件行数',
    `file_cols`           bigint NULL DEFAULT 0 COMMENT '文件列数',
    `remark`              varchar(1024) NULL COMMENT '备注',
    `is_deleted`          tinyint(1) not NULL DEFAULT 0 COMMENT '删除标:(0:否,1:是删除)',
    `create_user_id`      bigint NULL DEFAULT 0 COMMENT '创建人id',
    `create_user_name`    varchar(255) NULL COMMENT '创建人名称',
    `expire_time`         datetime NULL COMMENT '有效时间，默认14天',
    `threshold_times`     int         not null default 30 COMMENT '数据集限制使用的次数',
    `count`               int         not null default 0 COMMENT '数据集已经被使用次数',
    `expire_flag`         tinyint(4) not NULL DEFAULT -1 COMMENT '失效标识 -1:初始状态 0:未失效 1:已失效',
    `create_date`         datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`         datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `src_dataset_id` bigint DEFAULT NULL COMMENT '三期数据集id(三期数据集集成使用)',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '数据集' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for dataset_party_map
-- ----------------------------
DROP TABLE IF EXISTS `dataset_party_map`;
CREATE TABLE `dataset_party_map`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `dataset_id`  bigint not null DEFAULT 0 COMMENT 'dataset.id',
    `party_id`    varchar(255) NULL DEFAULT '' COMMENT 'FATE的参与方标识id',
    `create_date` datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='数据集映射表' ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for dataset_audit
-- ----------------------------
DROP TABLE IF EXISTS `dataset_audit`;
CREATE TABLE `dataset_audit`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `dataset_id`  bigint not null DEFAULT 0 COMMENT 'meta_data.id',
    `approved`    int not null DEFAULT 0 COMMENT '审核是否通过 0:待提交审核 1：待审核 2：审核通过 3：审核不通过',
    `user_id`     bigint not null DEFAULT 0 COMMENT 'user.id',
    `create_date` datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='数据集审核表' ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for message 待确定 group_id
-- 旧版本
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `group_id`    bigint       not null DEFAULT 0 COMMENT 'group.id ',
    `party_id`    varchar(255) not null DEFAULT '' comment '消息发起端的party.id',
    `content`     varchar(255) not null DEFAULT '' comment '通知内容',
    `has_read`    tinyint(1) not null default 0 comment '已读',
    `create_date` datetime              DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime              DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='通知表' ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for new_message
-- 新版本
-- ----------------------------
DROP TABLE IF EXISTS `new_message`;
CREATE TABLE `new_message`
(
    `id`          bigint AUTO_INCREMENT COMMENT '主键',
    `project_id`  bigint DEFAULT null COMMENT 'project_id',
    `project_name`varchar(255) not null DEFAULT '' comment 'project_name',
    `user_id`     bigint default null COMMENT 'user_id',
    `common_id`   varchar(255) default null COMMENT 'common_id: projectId / workflowId / modelId / taskId',
    `type`        varchar(255) not null DEFAULT '' comment '类型',
    `type_id`     varchar(255) not null DEFAULT '' comment '类型id (1：项目，2：数据集，3：工作流，4：模型)',
    `content`     varchar(255) not null DEFAULT '' comment '通知内容',
    `link_text`   varchar(255) not null DEFAULT '' comment '辅助前端 link_text',
    `remarks`     varchar(255) DEFAULT null comment '备注1',
    `has_read`    tinyint(1) default 0 comment '未读',
    `is_deleted`  tinyint(1) default 0 COMMENT '删除标志 0:否 1:是',
    `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='通知表' ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for workflow
-- ----------------------------
DROP TABLE IF EXISTS `workflow`;
CREATE TABLE `workflow`
(
    `id`                         bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `project_id`                 bigint          DEFAULT 0 COMMENT 'project.id',
    `name`                       varchar(255)    DEFAULT "" COMMENT '工作流名',
    `memo`                       varchar(255)    DEFAULT "" COMMENT '简介',
    `run_num`                    int             DEFAULT 0 COMMENT '运行次数',
    `job_json`                   longtext NULL COMMENT 'FATE工作流描述',
    `config_json`                longtext NULL COMMENT 'FATE工作流参数配置',
    `federal_ml_type`            int    NOT NULL DEFAULT 0 COMMENT '联邦学习模式，0：非联邦建模，1：纵向联邦学习，2：横向联邦学习，3：迁移联邦学习',
    `work_flow_template_id`      bigint NULL DEFAULT NULL COMMENT '模板id',
    `canvas_json`                longtext NULL COMMENT 'FATE工作流版本画布描述',
    `canvas_operator_param_json` longtext NULL COMMENT 'FATE工作流版本画布算子参数描述',
    `create_date`                datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`                datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 ROW_FORMAT=DYNAMIC COMMENT='工作流';

-- ----------------------------
-- Table structure for workflow_dataset_map
-- ----------------------------
DROP TABLE IF EXISTS `workflow_dataset_map`;
CREATE TABLE `workflow_dataset_map`
(
    `id`                bigint AUTO_INCREMENT COMMENT '主键',
    `workflow_id`       bigint not null DEFAULT 0 COMMENT 'workflow.id',
    `local_dataset_id`  bigint not null DEFAULT 0 COMMENT '自有数据集dataset.id',
    `remote_dataset_id` bigint not null DEFAULT 0 COMMENT '被授权的数据集dataset.id',
    `create_date`       datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`       datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='工作流-数据集映射表' ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for workflow_job
-- ----------------------------
DROP TABLE IF EXISTS `workflow_job`;
CREATE TABLE `workflow_job`
(
    `id`                         bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `workflow_id`                bigint not null DEFAULT 0 COMMENT 'workflow.id',
    `project_id`                 bigint not null DEFAULT 0 COMMENT 'project.id',
    `board_url`                  varchar(1024) NULL COMMENT 'FATE板上的地址',
    `dsl_path`                   varchar(255) NULL COMMENT '任务描述json文件地址',
    `job_id`                     varchar(74) NULL COMMENT '原生FATE里的job_id',
    `job_runtime_config_on_path` varchar(255) NULL COMMENT '任务在参与方角色的配置文件地址',
    `job_runtime_config_path`    varchar(255) NULL COMMENT '任务配置的文件地址',
    `logs_directory`             varchar(255) NULL COMMENT '日志目录',
    `fate_model_id`              varchar(255) NULL COMMENT '原生FATE里的模型id',
    `fate_model_version`         varchar(255) NULL COMMENT 'FATE模型版本，id,版本唯一确定一个模型',
    `pipeline_dsl_path`          varchar(255) NULL COMMENT '排排栏定义，管道定义文件地址',
    `train_runtime_config_path`  varchar(255) NULL COMMENT '训练配置定义文件地址',
    `return_code`                int UNSIGNED NULL COMMENT '返回代码',
    `return_message`             varchar(1024) NULL COMMENT '返回信息',
    `role`                       varchar(255) NULL COMMENT '角色',
    `create_date`                datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`                datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '训练job表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
     `id` bigint NOT NULL COMMENT '模型id',
     `workflow_job_id` varchar(255)  DEFAULT NULL COMMENT 'workflow_job.id,上传的模型workflow_job_id = 0',
     `workflow_id` bigint NOT NULL DEFAULT '0' COMMENT 'workflowId 工作流id',
     `project_id` bigint NOT NULL DEFAULT '0' COMMENT 'project.id，上传的模型要区分项目',
     `name` varchar(255)  DEFAULT NULL COMMENT '模型名，自动生成，模型组名+数字',
     `model_id` varchar(255)  DEFAULT NULL COMMENT '原生fate中 返回的model_id',
     `model_role` varchar(255)  DEFAULT NULL COMMENT '模型下载时，需要提供下载模型角色',
     `model_party` varchar(255)  DEFAULT NULL COMMENT '模型下载时，需要提供下载模型角色',
     `model_version_id` varchar(255)  DEFAULT NULL COMMENT '原生fate中 返回的 model_version_id',
     `predict_config` longtext  COMMENT '预测参数配置',
     `model_type` int DEFAULT NULL COMMENT '1:来源于训练 2:来源于上传',
     `status` int DEFAULT NULL COMMENT '模型状态， 1：模型未部署 2 模型已部署',
     `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:not delete 1:is delete',
     `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
     `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
     `intro` varchar(500)  DEFAULT NULL COMMENT '简介',
     `party_ids` varchar(255)  DEFAULT NULL COMMENT '合作方partyid集合',
     `origin_model_version_id` varchar(255)  DEFAULT NULL COMMENT '未部署前的模型版本id',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE KEY `uk_mid_mver` (`model_id`,`model_version_id`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC COMMENT='模型表';

-- ----------------------------
-- Table structure for workflow_dataset_map
-- ----------------------------
DROP TABLE IF EXISTS `model_dataset_map`;
CREATE TABLE `model_dataset_map`
(
    `id`                bigint AUTO_INCREMENT COMMENT '主键',
    `model_id`          bigint not null DEFAULT 0 COMMENT 'model.id',
    `local_dataset_id`  bigint not null DEFAULT 0 COMMENT '自有数据集,dataset.id',
    `remote_dataset_id` bigint not null DEFAULT 0 COMMENT '被授权的数据集,dataset.id',
    `create_date`       datetime        DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`       datetime        DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 COMMENT='模型预测时绑定的数据集' ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for model_job
-- ----------------------------
DROP TABLE IF EXISTS `model_job`;
CREATE TABLE `model_job`
(
    `id`                               bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `model_id`                         bigint not null DEFAULT 0 COMMENT 'model.id',
    `board_url`                        varchar(1024) NULL COMMENT 'FATE板上的地址',
    `dsl_path`                         varchar(255) NULL COMMENT '任务描述json文件地址',
    `job_id`                           varchar(74) NULL COMMENT '原生FATE里的job_id',
    `job_runtime_config_on_party_path` varchar(255) NULL COMMENT '任务在参与方角色的配置文件地址',
    `job_runtime_config_path`          varchar(255) NULL COMMENT '任务配置的文件地址',
    `logs_directory`                   varchar(255) NULL COMMENT '日志目录',
    `fate_model_id`                    varchar(255) NULL COMMENT '跑预测任务时，fate中返回的model_id',
    `fate_model_version`               varchar(255) NULL COMMENT '跑预测任务时，fate中返回的model_version_id',
    `pipeline_dsl_path`                varchar(255) NULL COMMENT '管道定义文件地址',
    `train_runtime_config_path`        varchar(255) NULL COMMENT '训练配置定义文件地址',
    `return_code`                      int UNSIGNED NULL COMMENT '返回代码',
    `return_message`                   varchar(1024) NULL COMMENT '返回信息',
    `role`                             varchar(255) NULL COMMENT '角色',
    `create_date`                      datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`                      datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `party_ids`                        varchar(255)  DEFAULT NULL COMMENT '合作方partyid集合',
    `project_id`                       bigint NOT NULL DEFAULT '0' COMMENT '项目id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '预测job表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for project_user_map
-- ----------------------------
DROP TABLE IF EXISTS `project_user_map`;
CREATE TABLE `project_user_map`
(
    `id`         bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `role_id`    varchar(128) NULL DEFAULT NULL COMMENT '角色id',
    `user_id`    varchar(128) NULL DEFAULT NULL COMMENT '用户ID',
    `project_id` bigint NULL DEFAULT NULL COMMENT '项目ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '项目角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for algorithm_unit
-- ----------------------------
DROP TABLE IF EXISTS `algorithm_unit`;
CREATE TABLE `algorithm_unit`
(
    `id`              bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `name`            varchar(255) COMMENT '英文名称',
    `name_cn`         varchar(255) COMMENT '中文名称',
    `federal_ml_type` int UNSIGNED DEFAULT 0 COMMENT '联邦学习模式，0：非联邦建模，1：纵向联邦学习，2：横向联邦学习，3：迁移联邦学习',
    `param_cn`        longtext COMMENT '参数json，中文的，用于显示',
    `param`           longtext COMMENT '参数json，英文的，用于传参，代码',
    `param_default`   longtext COMMENT '缺省值',
    `module_name`     varchar(255) COMMENT 'FATE的模块名',
    `create_date`     datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`     datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = 'fedx联邦学习平台算法单元，算子' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for hdfs_data
-- ----------------------------
DROP TABLE IF EXISTS `hdfs_data`;
CREATE TABLE `hdfs_data`
(
    `id`                 bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `binding_namespace`  varchar(255) NULL COMMENT '绑定命名空间名',
    `binding_table_name` varchar(255) NULL COMMENT '绑定表名',
    `hdfs_data_path`     varchar(255) NULL COMMENT 'hdfs数据路径',
    `upload_type`        tinyint(1) NULL COMMENT '上传方式（0:hdfs,1:csv）',
    `data_type`          tinyint(1) NULL DEFAULT 0 COMMENT '数据集类型(1:自有数据集,2:被授权数据集,3:自有psi数据集,4:被授权pis数据集)',
    `data_source`        varchar(10) NULL COMMENT '数据来源',
    `label_column`       varchar(10) not null default "" COMMENT '标签列名称',
    `file_size`          float(20, 2
) NULL DEFAULT 0.00 COMMENT '文件大小:单位是M',
    `file_rows`          bigint NULL DEFAULT 0 COMMENT '文件行数',
    `file_cols`          bigint NULL DEFAULT 0 COMMENT '文件列数',
    `create_user_id`     bigint NULL DEFAULT 0 COMMENT '创建人id',
    `create_user_name`   varchar(255)  NULL  COMMENT '创建人名称',
    `memo`               varchar(255)  NULL  COMMENT '备注',
    `project_id`             bigint NULL  COMMENT 'project_info.id 即 项目id',
    `create_date`        datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`        datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx hdfs元数据集' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for label
-- ----------------------------
DROP TABLE IF EXISTS `label`;
CREATE TABLE `label`
(
    `id`          bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `label`       varchar(255) NULL COMMENT '标签',
    `type`        int UNSIGNED DEFAULT 0 COMMENT '类型',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = 'fedx联邦学习平台标签' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`
(
    `id`          bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `sys_user_id` bigint UNSIGNED NULL COMMENT '系统用户id',
    `option`      varchar(255) NULL COMMENT '操作',
    `content`     varchar(4096) NULL COMMENT '内容',
    `username`    varchar(50) NULL,
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = 'fedx联邦学习平台审计日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`
(
    `id`          bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(255) NULL COMMENT '菜单名',
    `pid`         bigint NULL COMMENT '父菜单id',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx联邦学习平台菜单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for menu_new
-- ----------------------------
DROP TABLE IF EXISTS `menu_new`;
CREATE TABLE `menu_new`
(
    `id`                bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `name`              varchar(255) NULL COMMENT '菜单名',
    `type`              varchar(255) NULL COMMENT '菜单类型',
    `icon`              varchar(255) NULL COMMENT 'icon',
    `url`               varchar(255) NULL COMMENT 'url',
    `title`             varchar(255) NULL COMMENT 'title',
    `target`            varchar(255) NULL COMMENT 'target',
    `parent_menu_id`    bigint NULL COMMENT '父菜单id',
    `is_enabled`        tinyint(1) NULL DEFAULT 0 COMMENT 'is_enabled 0:否 1:是',
    `is_deleted`        tinyint(1) NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
    `create_date`       datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`       datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `seq`               bigint NULL COMMENT '排序id',
    `redirect`          varchar(255) NULL COMMENT '重定向地址',
    `method`            varchar(255) NULL COMMENT 'a链接打开方式：target / blank',
    `button_key`        int DEFAULT NULL COMMENT '  按钮key',
    `is_activate`       tinyint(1) DEFAULT '1' COMMENT ' 0 未启用 ，1 启用模块',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = 'fedx联邦学习平台新菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for menunew_role_map
-- ----------------------------
DROP TABLE IF EXISTS `menu_role_map`;
CREATE TABLE `menu_role_map`
(
    `id`          bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `menu_id`     bigint NULL COMMENT '菜单id',
    `role_code`   varchar(255)  NULL COMMENT '角色id',
    `is_deleted`  tinyint(1) NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx联邦学习平台菜单用户映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for menu_user_map
-- ----------------------------
DROP TABLE IF EXISTS `menu_user_map`;
CREATE TABLE `menu_user_map`
(
    `id`          bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `menu_id`     bigint NULL COMMENT '菜单id',
    `user_id`     bigint NULL COMMENT '用户id',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx联邦学习平台菜单用户映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator`
(
    `id`          bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(255) NOT NULL DEFAULT "" COMMENT '名称',
    `category_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '算子类别id',
    `input`       varchar(255) NULL DEFAULT NULL COMMENT '输入数据',
    `output`      varchar(255) NULL DEFAULT NULL COMMENT '输出数据',
    `param`       text NULL COMMENT '配置参数',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `alias`       varchar(255) NOT NULL DEFAULT '' COMMENT '前端别名',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `operator_operator_category`(`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = 'fedx算子' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for operator_category
-- ----------------------------
DROP TABLE IF EXISTS `operator_category`;
CREATE TABLE `operator_category`
(
    `id`          bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(255) NOT NULL COMMENT '名称',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx算子类别' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for party
-- ----------------------------
DROP TABLE IF EXISTS `party`;
CREATE TABLE `party`
(
    `id`              bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`            varchar(255) NOT NULL COMMENT '机构名字',
    `party_id`        varchar(255) NULL DEFAULT '' COMMENT 'FATE的参与方标识id',
    `contact`         varchar(255) NOT NULL COMMENT '联系人及方式',
    `is_self`         tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是本端机构 0：不是 1：是',

    `description`     varchar(500) NULL DEFAULT NULL COMMENT '备注',
    `encryption_type` varchar(255) NOT NULL DEFAULT '' COMMENT '加密方式',
    `encryption_key`  varchar(255) NOT NULL DEFAULT '' COMMENT '加密密钥',
    `create_date`     datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`     datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `health_check`    tinyint(1) NOT NULL DEFAULT 0 COMMENT '心跳状态 测试不通过为0 测试通过为1',
    `is_watermark`    int DEFAULT '0' COMMENT '水印  0：不需要水印 ,1：需要水印',
    `watermark_info`  varchar(50) DEFAULT NULL COMMENT '水印信息，1：机构名 ，2： 用户名 ， 3： 日期',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `party_id`(`party_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '机构表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for redis
-- ----------------------------
DROP TABLE IF EXISTS `redis`;
CREATE TABLE `redis`
(
    `id`          bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `authorization`         varchar(2000) NOT NULL COMMENT 'key',
    `value`       varchar(2000) NULL DEFAULT NULL COMMENT '值',
    `ttl`         bigint       NOT NULL DEFAULT 3600 COMMENT '过期时间：秒',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `key`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx   redis 用于存储登录用户信息' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for workflow_template
-- ----------------------------
DROP TABLE IF EXISTS `workflow_template`;
CREATE TABLE `workflow_template`
(
    `id`                         bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `federal_ml_type`            int UNSIGNED NOT NULL DEFAULT 0 COMMENT '联邦学习模式，0：非联邦建模，1：纵向联邦学习，2：横向联邦学习，3：迁移联邦学习',
    `model_name`                 varchar(255) NULL DEFAULT NULL COMMENT '模型名',
    `job_json`                   longtext NULL COMMENT 'FATE工作流描述',
    `config_json`                longtext NULL COMMENT 'FATE工作流参数配置',
    `canvas_json`                longtext NULL COMMENT 'FATE工作流版本模板画布描述',
    `canvas_operator_param_json` longtext NULL COMMENT 'FATE工作流版本模板画布算子参数描述',
    `status`                     tinyint(1) NULL DEFAULT 1 COMMENT '状态位(1存在，2已删除)',
    `create_date`                datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date`                datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    `remark`                     varchar(500)  DEFAULT NULL COMMENT '备注',
    `create_id`                  bigint DEFAULT '0' COMMENT '创建人id',
    `update_id`                  bigint DEFAULT '0' COMMENT '更新人id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx联邦学习平台工作流模板' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for encryption_type
-- ----------------------------
DROP TABLE IF EXISTS `encryption_type`;
CREATE TABLE `encryption_type`
(
    `id`          bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `code`        varchar(255) NOT NULL DEFAULT '' COMMENT '加密方式,SM2 SM3等',
    `name`        varchar(255) NOT NULL DEFAULT '' COMMENT '加密方式详细说明,SM2 SM3等',
    `encrypt_key` varchar(255) NOT NULL DEFAULT '' COMMENT '加密key',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '机构加密方式配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for scheduler
-- ----------------------------
DROP TABLE IF EXISTS `scheduler`;
CREATE TABLE `scheduler`
(
    `id`             bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`           varchar(128) NOT NULL DEFAULT '' COMMENT '作业名称',
    `project_id`     bigint       NOT NULL COMMENT 'project id',
    `user_id`        bigint       NOT NULL COMMENT 'creator id = user.id',
    `scheduler_type` int          NOT NULL COMMENT '作业类型:100->DataXETL作业;200->文件上传作业;300psi数据集上传',
    `job_status`     int          NOT NULL COMMENT '作业状态:0->待运行;10->运行中;20->运行失败;30->运行成功;',
    `job_param`      text NULL COMMENT '作业参数,json字符串形式',
    `created_at`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `author` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代表是谁创建标识',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '作业表' ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `scheduler_job`;
CREATE TABLE `scheduler_job`
(
    `id`           bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `scheduler_id` bigint   NOT NULL DEFAULT 0 COMMENT 'scheduler.id',
    `worker`       char(32) NOT NULL DEFAULT '' COMMENT '作业执行器,用于排它认领作业',
    `job_status`   int      NOT NULL COMMENT '作业状态:0->待运行;10->运行中;20->运行失败;30->运行成功;',
    `job_response` text NULL COMMENT '作业返回值,json字符串形式',
    `time_cost`    int      NOT NULL DEFAULT -1 COMMENT '作业耗时秒数,-1表示未完成',
    `created_at`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '作业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`
(
    `id`          bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name`        varchar(255) NULL DEFAULT NULL COMMENT '菜单名',
    `url`         varchar(255) NULL DEFAULT NULL COMMENT '链接',
    `parent_num`  varchar(255) NULL DEFAULT NULL COMMENT '上级菜单编码',
    `num`         int(0) NULL DEFAULT NULL COMMENT '本级菜单编码',
    `is_deleted`  tinyint(1) not NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT ' 创建日期 ',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '系统菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_meau_role_map
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_role_map`;
CREATE TABLE `sys_menu_role_map`
(
    `role_num` int(0) NULL DEFAULT NULL,
    `menu_num` int(0) NULL DEFAULT NULL
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for logo
-- ----------------------------
DROP TABLE IF EXISTS `logo`;
CREATE TABLE `logo`
(
    `id`                bigint UNSIGNED AUTO_INCREMENT COMMENT '主键',
    `name`              varchar(255) NULL COMMENT 'logo名称',
    `type`          	varchar(255) NULL COMMENT 'logo类型 1：登录页logo，2，导航logo',
	`value`             longtext NULL COMMENT 'logo图片base64',
    `is_deleted`        tinyint(1) NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
    `create_date`       datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`       datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = 'fedx联邦学习平台logo表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                         `name` varchar(255)  NULL DEFAULT NULL COMMENT '系统用户名字',
                         `username` varchar(255)  NULL DEFAULT NULL COMMENT '登录用户名',
                         `password` varchar(255)  NULL DEFAULT NULL COMMENT '密码，MD5',
                         `party_id` varchar(255)  NOT NULL DEFAULT '0' COMMENT '所属机构 party_id',
                         `contact_info` varchar(255)  NULL DEFAULT NULL COMMENT '联系方式',
                         `remarks` varchar(1024)  NULL DEFAULT NULL COMMENT '备注',
                         `is_fed_user_exist` int(0) NOT NULL DEFAULT 0 COMMENT '是否创建FedLearner用户，默认未创建：0未创建，1已创建',
                         `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
                         `create_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
                         `update_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新日期',
                         `effective_date` datetime(0) NULL DEFAULT NULL COMMENT '生效日期',
                         `expire_date` datetime(0) NULL DEFAULT NULL COMMENT '失效日期',
                         `org_id` bigint(0) NULL DEFAULT NULL COMMENT '组织ID',
                         `lock_status` int(0) NULL DEFAULT NULL,
                         `platform_type`  int null comment '用户平台类型，1:平台普通用户  2：第三方系统用户',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22  COMMENT = 'fedx联邦学习平台系统用户' ROW_FORMAT = Dynamic;





-- -
-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `project_user_role`;
CREATE TABLE `project_user_role`
(
    `id`         bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `role_name`  varchar(128) NULL DEFAULT NULL COMMENT '角色名',
    `is_deleted` tinyint(1) not null DEFAULT 0 COMMENT '是否删除 0:否 1:是',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '项目角色表' ROW_FORMAT = DYNAMIC;






-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `name` varchar(255)  NULL DEFAULT NULL COMMENT '角色名',
                             `num` varchar(255)  NULL DEFAULT NULL COMMENT '角色编码',
                             `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除标志 0:否 1:是',
                             `create_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
                             `update_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新日期',
                             `menu_text` text  NULL COMMENT '该角色拥有的按钮',
                             `remark` varchar(255)  DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3  COMMENT = '系统角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_map
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_map`;
CREATE TABLE `sys_role_map`  (
                                 `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
                                 `userid` bigint(0) NULL DEFAULT NULL COMMENT '用户编码',
                                 `roleid` bigint(0) NULL DEFAULT NULL COMMENT '角色变编码',
                                 `create_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
                                 `update_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新日期',
                                 `expire_date` datetime(0) NULL DEFAULT NULL COMMENT '失效日期',
                                 `effect_date` datetime(0) NULL DEFAULT NULL COMMENT '生效日期',
                                 PRIMARY KEY (`id`) USING BTREE,
                                 UNIQUE INDEX uk_uid (`userid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1  COMMENT = '系统角色表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
                            `name` varchar(255)  NULL DEFAULT NULL COMMENT '机构名',
                            `parent_org_id` bigint(0) NULL DEFAULT NULL COMMENT '父级机构ID',
                            `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '是否删除',
                            `id` bigint(0) NOT NULL AUTO_INCREMENT,
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  ROW_FORMAT = Dynamic;

SET
FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for datasource
-- ----------------------------
DROP TABLE IF EXISTS `datasource`;
CREATE TABLE `datasource`
(
    `id`                      BIGINT AUTO_INCREMENT COMMENT '主键',
    `datasource_name`          VARCHAR(255) NULL COMMENT '数据源名称',
    `datasource_type`         int NULL COMMENT '数据源类型（1:remote_hdfs,1:hive 2:mysql 3:local_hdfs）',
    `user_keytab`             VARCHAR(255) NULL COMMENT '用户指定keytabFilePath路径,例如：BQIAAAA4AAEACU1DSVBULkNPTQAIMTIwNTYyNTAAAAABYIDjxQEAFwAQW00sF093+/b2QintpXrETQAAAAEAAABIAAEACU1DSVBULkNPTQAIMTIwNTYyNTAAAAABYIDjxgEAEgAgyOYnSTMnqFGCUcupfgZ4Sl4efaVLPwSFDiA9oWGRxKgAAAAB',
    `user_hdfs_root`          VARCHAR(255) NULL COMMENT '用户限定的hdfs路径，例如：/user/12056250',
    `user_principal`          VARCHAR(255) NULL COMMENT '用户指定的principal，例如：12056250@MCIPT.COM',

    `remote_nameservices`     VARCHAR(255) NULL COMMENT '远端keytabFilePath路径 例如：172.20.8.154',
    `remote_namenode_address` VARCHAR(255) NULL COMMENT '远端namenode addresses 例如：172.20.8.154:8020,172.20.8.154:8020',
    `remote_namenodes`        VARCHAR(255) NULL COMMENT '远端namenodes 例如：namenode163,namenode252',
    `remote_principal`        VARCHAR(255) NULL COMMENT '远端principal 例如：hdfs/_HOST@MCIPT.COM',
    `remote_port`             VARCHAR(255) NULL COMMENT '远端cdh的8020端口 例如：8020',
    `remote_keytab_file_path` VARCHAR(255) NULL COMMENT '远端keytabFilePath路径,例如：/etc/keytab/user.keytab',

    `local_nameservices`      VARCHAR(255) NULL COMMENT '系统keytabFilePath路径 例如：fate-proxy-cluster-ip.fate-17x-1000',
    `local_port`              VARCHAR(255) NULL COMMENT 'cdh的8020端口 例如：9000',

    `hive_principal`          VARCHAR(255) NULL COMMENT '例如：;principal=hive/_HOST@MCIPT.COM',
    `hive_url`                VARCHAR(255) NULL COMMENT '例如：jdbc:hive2://172.20.8.154:10000/',
    `isLoginByKeytab`         TINYINT ( 1 ) not NULL DEFAULT 0 COMMENT '是否需要kerbos认证',

    `db_url`                  VARCHAR(2550) NULL COMMENT '数据库地址 ',
    `db_port`                 VARCHAR(2550) NULL COMMENT '端口',
    `db_username`             VARCHAR(2550) NULL COMMENT '用户名',
    `db_password`             VARCHAR(2550) NULL COMMENT '密码',

    `user_id`                 BIGINT not null default 9999 COMMENT '用户id',
    `is_deleted`              TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '删除标:(0:否,1:是删除)',
    `create_date`             datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`             datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = INNODB AUTO_INCREMENT = 1 COMMENT = '数据源' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dataset
-- ----------------------------
DROP TABLE IF EXISTS `dataset_clickhouse_map`;
CREATE TABLE `dataset_clickhouse_map`
(
    `id`              bigint AUTO_INCREMENT COMMENT '主键',
    `dataset_id`      bigint COMMENT '数据集id',
    `scheduler_id`      bigint COMMENT '调度id',
    `model_component_data_download_id`      bigint COMMENT '模型数据下载的存储表，一对多的即一个可能多个name,',
    `name`        VARCHAR(2550) NULL COMMENT '库名或表名',
    `type`   VARCHAR(2550) NULL COMMENT '库名：DB_NAME，数据集的表名 DATASET_TABLE_NAME，组件的表名 COMPONENT_NAME',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '数据集与模型存储于clickhouse内的库表映射关系' ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `dataset_scheduler_map`;
CREATE TABLE `dataset_scheduler_map`(
    `id`              bigint AUTO_INCREMENT COMMENT '主键',
    `dataset_id`      bigint COMMENT '数据集id,dataset.id',
    `scheduler_id` bigint COMMENT '调度id，scheduler.id',
    `scheduler_type`     int null COMMENT '调度类型',
    `create_date` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '数据集与调度的映射关系' ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `sys_user_appsecret`;
create table sys_user_appsecret
(
    id          int auto_increment comment 'ID'
        primary key,
    app_name    varchar(256)                       null comment '用户名应用名',
    app_secret  varchar(256)                       null comment '系统集成秘钥',
    create_time datetime default CURRENT_TIMESTAMP null,
    update_time datetime default CURRENT_TIMESTAMP null,
    constraint sys_user_appsecret_id_uindex
        unique (id)
)
    ENGINE = INNODB AUTO_INCREMENT = 1    comment '第三方系统集成用户表'  ROW_FORMAT = DYNAMIC;

/**
  模型组件下载表，
 */
DROP TABLE IF EXISTS `model_component_data_download`;
CREATE TABLE `model_component_data_download`
(
    `id`               bigint AUTO_INCREMENT COMMENT '主键',
    `model_job_id`     bigint COMMENT 'model_job.id',
    `model_version_id` VARCHAR(2550) NULL COMMENT 'model_job.model_name，原生fate的运行跑批预测的job_id',
    `path`             VARCHAR(2550) NULL COMMENT '持久化路径,完整/project/12312/model/22222',
    `component_name` varchar(255) not null COMMENT '例如:hertro_secure_boost_0',
    `status`           int NULL COMMENT '状态，0 待下载，1 下载中，2 下载完成 3 job运行失败',
    `create_date`      datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`      datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '模型组件数据导出表' ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `template_component_download_config`;
CREATE TABLE `template_component_download_config`
(
    `id`             bigint AUTO_INCREMENT COMMENT '主键',
    `template_id`    bigint       not null COMMENT 'workflow_template.id',
    `component_name` varchar(255) not null COMMENT '例如:hertro_secure_boost_0',
    `auto_download`  tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否需要自动下载该组件的数据',
    `is_deleted`     TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT ' 删除标:(0:否,1:是删除)',
    `create_date`    datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`    datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE

) ENGINE = InnoDB AUTO_INCREMENT = 1 COMMENT = '工作流模型和所需下载数据的组件 配置表' ROW_FORMAT = DYNAMIC;


DROP TABLE IF EXISTS `look_up`;
CREATE TABLE `look_up`
(
    `name` VARCHAR(255) NULL COMMENT 'key',
    `value` VARCHAR(255) NULL COMMENT 'value',
    `seq` int not null,
    `type` varchar(255)
) ENGINE = InnoDB COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `model_serving`;
CREATE TABLE `model_serving` (
     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 自增',
     `service_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '服务id',
     `service_name` varchar(32)  NOT NULL DEFAULT '' COMMENT '服务名称',
     `model_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '原生fate中 返回的model_id',
     `model_version_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '原生fate中 返回的 model_version_id',
     `service_type` int NOT NULL DEFAULT '0' COMMENT '模型类型  1:纵向SecureBoost 2:纵向SSHELR 3:纵向LR 4:横向SecureBoost 5:横向LR ',
     `serving_address` varchar(255)  NOT NULL DEFAULT '' COMMENT '服务地址',
     `project_id` bigint NOT NULL DEFAULT '0' COMMENT '项目id',
     `authority` int NOT NULL DEFAULT '0' COMMENT '1:我发起项目 2:我参与项目',
     `role_part_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '角色&part',
     `summary` varchar(64)  NOT NULL DEFAULT '' COMMENT '简介 guest端展示 host端不展示',
     `status` int NOT NULL DEFAULT '-1' COMMENT '状态（0未上线，1运行中，2已下线 3上线失败 4 删除）',
     `infer_count` int NOT NULL DEFAULT '0' COMMENT '调用次数',
     `creator` varchar(64)  NOT NULL DEFAULT '' COMMENT '创建者',
     `create_id` bigint DEFAULT '0' COMMENT '创建人id',
     `creator_party_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '创建者机构id',
     `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
     `deployer` varchar(64)  NOT NULL DEFAULT '' COMMENT '发布人',
     `deploy_party_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '部署者机构id',
     `deploy_date` datetime DEFAULT NULL COMMENT '发布日期',
     `offliner` varchar(64)  NOT NULL DEFAULT '' COMMENT '下线人 自造词汇',
     `offline_party_id` varchar(255)  NOT NULL DEFAULT '' COMMENT '下线机构id',
     `offline_date` datetime DEFAULT NULL COMMENT '下线日期',
     `updater` varchar(255)  NOT NULL DEFAULT '' COMMENT '更新人',
     `update_id` bigint DEFAULT '0' COMMENT '更新人id',
     `update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE KEY `uk_mid_mver` (`model_id`,`model_version_id`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC COMMENT='模型服务列表';

DROP TABLE IF EXISTS `realai_dataset_result`;
CREATE TABLE `realai_dataset_result`
(
    `id`           bigint       NOT NULL AUTO_INCREMENT COMMENT '主键 自增',
    `project_id`   varchar(255) NOT NULL COMMENT '项目id',
    `dataset_id`   varchar(255) NOT NULL COMMENT '数据集id',
    `scheduler_id` varchar(255) NOT NULL COMMENT '调度id',
    `psiPath`      varchar(255) NOT NULL DEFAULT '' COMMENT '文件存放的绝对路径',
    `psi_id`       varchar(255) NOT NULL DEFAULT '' COMMENT 'psi任务id',
    `mpcPath`      varchar(255) NOT NULL DEFAULT '' COMMENT '文件存放的绝对路径',
    `mpc_id`       varchar(255) NOT NULL DEFAULT '' COMMENT 'mpc任务id',

    `resultPath`   varchar(255) NOT NULL DEFAULT '' COMMENT '文件存放的绝对路径',
    `psi_key`      varchar(255) NOT NULL DEFAULT '' COMMENT 'psi的加密列',
    `create_date`  datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建日期',
    `update_date`  datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC COMMENT='瑞莱数据集处理结果信息';