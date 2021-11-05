DROP TABLE IF EXISTS ums.admin;
DROP TABLE IF EXISTS ums.role;
DROP TABLE IF EXISTS ums.admin_role_relation;

CREATE TABLE IF NOT EXISTS ums.admin
(
    id          BIGSERIAL                     NOT NULL,
    username    TEXT,
    password    TEXT,
    email       TEXT,
    icon        TEXT,
    nick_name   TEXT,
    note        TEXT,
    create_time TIMESTAMP WITHOUT TIME ZONE   NOT NULL,
    login_time  TIMESTAMP WITHOUT TIME ZONE   NOT NULL,
    status      INT CHECK ( status IN (1, 2)) NOT NULL,
    PRIMARY KEY (id)
);

COMMENT ON COLUMN ums.admin.id IS 'ID';
COMMENT ON COLUMN ums.admin.username IS 'Username to login';
COMMENT ON COLUMN ums.admin.password IS 'Password to login';
COMMENT ON COLUMN ums.admin.icon IS 'Front-end icon';
COMMENT ON COLUMN ums.admin.nick_name IS 'Admins nickname';
COMMENT ON COLUMN ums.admin.note IS 'Note about this account';
COMMENT ON COLUMN ums.admin.create_time IS 'Created time';
COMMENT ON COLUMN ums.admin.login_time IS 'Recently login time';

CREATE TABLE IF NOT EXISTS ums.admin_login_log
(
    id          BIGSERIAL NOT NULL,
    admin_id    BIGINT REFERENCES ums.admin (id),
    create_time TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
    ip          VARCHAR(64)                 DEFAULT NULL,
    address     VARCHAR(100)                DEFAULT NULL,
    user_agent  VARCHAR(100)                DEFAULT NULL
);

COMMENT ON TABLE ums.admin_login_log IS 'bảng lưu thông tin lịch sử đăng nhập';

INSERT INTO ums.admin
VALUES ('1', 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, 'Test account', NULL,
        '2018-09-29 13:55:30', '2018-09-29 13:55:39', '1');
INSERT INTO ums.admin
VALUES ('3', 'admin', '$2a$10$.E1FokumK5GIXWgKlg.Hc.i/0/2.qdAwYFL1zc5QHdyzpXOr38RZO',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/170157_yIl3_1767531.jpg', 'admin@163.com',
        'System administrator', 'System administrator', '2018-10-08 13:32:47', '2019-03-20 15:38:50', '1');


-- ALTER TABLE ums.admin
--     ALTER COLUMN status SET NOT NULL;
-- ALTER TABLE ums.admin
--     ADD COLUMN email TEXT NOT NULL;

/**
  ums.role
 */
CREATE TABLE IF NOT EXISTS ums.role
(
    id          BIGSERIAL                               NOT NULL,
    name        TEXT                                    NOT NULL,
    description TEXT,
    admin_count INT                                     NOT NULL,
    create_time TIMESTAMP WITHOUT TIME ZONE             NOT NULL,
    status      INT DEFAULT 1 CHECK ( status IN (0, 1)) NOT NULL,
    sort        INT DEFAULT 0,
    PRIMARY KEY (id)
);
COMMENT ON COLUMN ums.role.id IS 'ID';
COMMENT ON COLUMN ums.role.name IS 'tên role';
COMMENT ON COLUMN ums.role.description IS 'mô tả về role';
COMMENT ON COLUMN ums.role.admin_count IS 'số admin thuộc về role';
COMMENT ON COLUMN ums.role.create_time IS 'thời điểm tạo ra role';
COMMENT ON COLUMN ums.role.status IS 'trạng thái của role 1 -> kích hoạt, 0 -> vô hiệu hóa';
COMMENT ON COLUMN ums.role.sort IS 'thứ tự sắp xếp role';

INSERT INTO ums.role
VALUES ('1', 'Product manager', 'Product manager', '0', '2018-09-30 15:46:11', '1', '0');
INSERT INTO ums.role
VALUES ('2', 'Product type manager', 'Product type manager', '0', '2018-09-30 15:53:45', '1', '0');
INSERT INTO ums.role
VALUES ('3', 'Categories manager', 'Categories manager', '0', '2018-09-30 15:53:56', '1', '0');
INSERT INTO ums.role
VALUES ('4', 'Brand manager', 'Brand manager', '0', '2018-09-30 15:54:12', '1', '0');

/**
  admin_role_relation
 */
CREATE TABLE IF NOT EXISTS ums.admin_role_relation
(
    admin_id BIGINT NOT NULL REFERENCES ums.admin (id),
    role_id  BIGINT NOT NULL REFERENCES ums.role (id),
    PRIMARY KEY (admin_id, role_id)
);
COMMENT ON COLUMN ums.admin_role_relation.role_id IS 'id của role';
COMMENT ON COLUMN ums.admin_role_relation.admin_id IS 'id của admin';
INSERT INTO ums.admin_role_relation
VALUES (3, 1);
INSERT INTO ums.admin_role_relation
VALUES (3, 2);
INSERT INTO ums.admin_role_relation
VALUES (3, 3);
INSERT INTO ums.admin_role_relation
VALUES (3, 4);
INSERT INTO ums.admin_role_relation
VALUES (1, 1);
INSERT INTO ums.admin_role_relation
VALUES (1, 2);



DROP TABLE IF EXISTS ums.permission;
CREATE TABLE IF NOT EXISTS ums.permission
(
    id          BIGSERIAL                                NOT NULL,
    pid         BIGINT REFERENCES ums.permission (id),
    name        TEXT                           DEFAULT NULL,
    value       TEXT                           DEFAULT NULL,
    icon        TEXT                           DEFAULT NULL,
    type        INT CHECK ( type IN (0, 1, 2)) DEFAULT NULL,
    uri         TEXT                           DEFAULT NULL,
    status      INT CHECK ( status IN (0, 1) ) DEFAULT 1 NOT NULL,
    create_time TIMESTAMP                                NOT NULL,
    sort        INT                            DEFAULT NULL,
    PRIMARY KEY (id)
);
COMMENT ON COLUMN ums.permission.id IS 'ID';
COMMENT ON COLUMN ums.permission.pid IS 'id của permission mẹ';
COMMENT ON COLUMN ums.permission.name IS 'tên';
COMMENT ON COLUMN ums.permission.value IS 'giá trị';
COMMENT ON COLUMN ums.permission.icon IS 'icon hiển thị';
COMMENT ON COLUMN ums.permission.type IS 'kiểu, 0->directory, 1->menu, 2->button';
COMMENT ON COLUMN ums.permission.uri IS 'resource path';
COMMENT ON COLUMN ums.permission.status IS 'trạng thái';
COMMENT ON COLUMN ums.permission.create_time IS 'thời điểm được tạo';
COMMENT ON COLUMN ums.permission.sort IS 'thứ tự sắp xếp';

INSERT INTO ums.permission
VALUES ('1', '1', 'Product', NULL, NULL, '0', NULL, '1', '2018-09-29 16:15:14', '0');
INSERT INTO ums.permission
VALUES ('2', '1', 'Product list', 'pms:product:read', NULL, '1', '/pms/product/index', '1', '2018-09-29 16:17:01', '0');
INSERT INTO ums.permission
VALUES ('3', '1', 'Adding product', 'pms:product:create', NULL, '1', '/pms/product/add', '1', '2018-09-29 16:18:51',
        '0');
INSERT INTO ums.permission
VALUES ('4', '1', 'Categories', 'pms:productCategory:read', NULL, '1', '/pms/productCate/index', '1',
        '2018-09-29 16:23:07', '0');
INSERT INTO ums.permission
VALUES ('5', '1', 'Product Types', 'pms:productAttribute:read', NULL, '1', '/pms/productAttr/index', '1',
        '2018-09-29 16:24:43', '0');
INSERT INTO ums.permission
VALUES ('6', '1', 'Brand management', 'pms:brand:read', NULL, '1', '/pms/brand/index', '1', '2018-09-29 16:25:45', '0');
INSERT INTO ums.permission
VALUES ('7', '2', 'Edit product', 'pms:product:update', NULL, '2', '/pms/product/updateProduct', '1',
        '2018-09-29 16:34:23', '0');
INSERT INTO ums.permission
VALUES ('8', '2', 'Delete product', 'pms:product:delete', NULL, '2', '/pms/product/delete', '1', '2018-09-29 16:38:33',
        '0');
INSERT INTO ums.permission
VALUES ('9', '4', 'Add product category', 'pms:productCategory:create', NULL, '2', '/pms/productCate/create', '1',
        '2018-09-29 16:43:23', '0');
INSERT INTO ums.permission
VALUES ('10', '4', 'Modify product category', 'pms:productCategory:update', NULL, '2', '/pms/productCate/update', '1',
        '2018-09-29 16:43:55', '0');
INSERT INTO ums.permission
VALUES ('11', '4', 'Delete product category', 'pms:productCategory:delete', NULL, '2', '/pms/productAttr/delete', '1',
        '2018-09-29 16:44:38', '0');
INSERT INTO ums.permission
VALUES ('12', '5', 'Add product type', 'pms:productAttribute:create', NULL, '2', '/pms/productAttr/create', '1',
        '2018-09-29 16:45:25', '0');
INSERT INTO ums.permission
VALUES ('13', '5', 'Modify product type', 'pms:productAttribute:update', NULL, '2', '/pms/productAttr/update', '1',
        '2018-09-29 16:48:08', '0');
INSERT INTO ums.permission
VALUES ('14', '5', 'Delete product type', 'pms:productAttribute:delete', NULL, '2', '/pms/productAttr/delete', '1',
        '2018-09-29 16:48:44', '0');
INSERT INTO ums.permission
VALUES ('15', '6', 'Add brand', 'pms:brand:create', NULL, '2', '/pms/brand/add', '1', '2018-09-29 16:49:34', '0');
INSERT INTO ums.permission
VALUES ('16', '6', 'Modify brand', 'pms:brand:update', NULL, '2', '/pms/brand/update', '1', '2018-09-29 16:50:55', '0');
INSERT INTO ums.permission
VALUES ('17', '6', 'Delete brand', 'pms:brand:delete', NULL, '2', '/pms/brand/delete', '1', '2018-09-29 16:50:59', '0');
INSERT INTO ums.permission
VALUES ('18', '1', 'Home page', NULL, NULL, '0', NULL, '1', '2018-09-29 16:51:57', '0');


DROP TABLE IF EXISTS ums.role_permission_relation;
CREATE TABLE IF NOT EXISTS ums.role_permission_relation
(
    role_id       BIGINT REFERENCES ums.role (id),
    permission_id BIGINT REFERENCES ums.permission (id),
    PRIMARY KEY (permission_id, role_id)
);
-- đổi tên table
ALTER TABLE ums.role_permission_relation
    RENAME TO role_permission_relation;

INSERT INTO ums.role_permission_relation
VALUES ('1', '2');
INSERT INTO ums.role_permission_relation
VALUES ('1', '7');
INSERT INTO ums.role_permission_relation
VALUES ('1', '8');
INSERT INTO ums.role_permission_relation
VALUES ('1', '1');
INSERT INTO ums.role_permission_relation
VALUES ('1', '3');
INSERT INTO ums.role_permission_relation
VALUES ('2', '4');
INSERT INTO ums.role_permission_relation
VALUES ('2', '9');
INSERT INTO ums.role_permission_relation
VALUES ('2', '10');
INSERT INTO ums.role_permission_relation
VALUES ('2', '11');
INSERT INTO ums.role_permission_relation
VALUES ('3', '5');
INSERT INTO ums.role_permission_relation
VALUES ('3', '12');
INSERT INTO ums.role_permission_relation
VALUES ('3', '13');
INSERT INTO ums.role_permission_relation
VALUES ('3', '14');
INSERT INTO ums.role_permission_relation
VALUES ('4', '6');
INSERT INTO ums.role_permission_relation
VALUES ('4', '15');
INSERT INTO ums.role_permission_relation
VALUES ('4', '16');
INSERT INTO ums.role_permission_relation
VALUES ('4', '17');

CREATE TABLE IF NOT EXISTS ums.admin_permission_relation
(
    admin_id      BIGINT DEFAULT NULL REFERENCES ums.admin (id),
    permission_id BIGINT DEFAULT NULL REFERENCES ums.permission (id),
    type          INT    DEFAULT NULL,
    PRIMARY KEY (admin_id, permission_id)
);
COMMENT ON TABLE ums.admin_permission_relation IS 'tùy chỉnh quyền admin riêng lẻ không thông qua bộ các permission nhóm bởi role';

DROP TABLE IF EXISTS pms.brand;
CREATE TABLE IF NOT EXISTS pms.brand
(
    id                    BIGSERIAL           NOT NULL,
    name                  VARCHAR(150) UNIQUE NOT NULL,
    first_letter          VARCHAR(8)          NOT NULL,
    sort                  INT                 NOT NULL,
    factory_status        INT                 NOT NULL,
    show_status           INT DEFAULT 1       NOT NULL,
    product_count         INT DEFAULT 0       NOT NULL,
    product_comment_count INT DEFAULT 0       NOT NULL,
    logo                  TEXT,
    big_pic               TEXT,
    brand_story           TEXT,
    PRIMARY KEY (id)
);


-- ----------------------------
-- Records of pms.brand      --
-------------------------------
INSERT INTO pms.brand VALUES ('1', 'Wanhe', 'W', '0', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(5).jpg', '', 'The story of Victoria''s Secret');
INSERT INTO pms.brand VALUES ('2', 'Samsung', 'S', '100', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (1).jpg', null, 'Samsung''s story');
INSERT INTO pms.brand VALUES ('3', 'Huawei', 'H', '100', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/17f2dd9756d9d333bee8e60ce8c03e4c_222_222.jpg', null, 'The story of Victoria''s Secret');
INSERT INTO pms.brand VALUES ('4', 'Gree', 'G', '30', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/dc794e7e74121272bbe3ce9bc41ec8c3_222_222.jpg', null, 'The story of Victoria''s Secret');
INSERT INTO pms.brand VALUES ('5', 'Hota', 'F', '20', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg', null, 'The story of Victoria''s Secret');
INSERT INTO pms.brand VALUES ('6', 'Millet', 'M', '500', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/1e34aef2a409119018a4c6258e39ecfb_222_222.png', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/5afd7778Nf7800b75.jpg', 'The story of Xiaomi phones');
INSERT INTO pms.brand VALUES ('21', 'OPPO', 'O', '0', '1', '1', '88', '500', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg', '', 'string');
INSERT INTO pms.brand VALUES ('49', 'Seven Wolves', 'S', '200', '1', '1', '77', '400', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/18d8bc3eb13533fab466d702a0d3fd1f40345bcd.jpg', null, 'The story of BOOB');
INSERT INTO pms.brand VALUES ('50', 'Umiyuki Family', 'H', '200', '1', '1', '66', '300', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/99d3279f1029d32b929343b09d3c72de_222_222.jpg', '', 'The story of Hailan House');
INSERT INTO pms.brand VALUES ('51', 'Apple', 'A', '200', '1', '1', '55', '200', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', null, 'Apple''s story');
INSERT INTO pms.brand VALUES ('58', 'NIKE', 'N', '0', '1', '1', '33', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/timg (51).jpg', '', 'NIKE''s story');

-- pms.product
DROP TABLE IF EXISTS pms.product;
CREATE TABLE IF NOT EXISTS pms.product
(
    id                    BIGSERIAL          NOT NULL,
    name                  TEXT UNIQUE        NOT NULL,
    product_sn            VARCHAR(50) UNIQUE NOT NULL,
    picture               TEXT     DEFAULT NULL,
    delete_status         SMALLINT DEFAULT 0 CHECK ( delete_status IN (0, 1) ),
    publish_status        SMALLINT DEFAULT 1 CHECK ( publish_status IN (0, 1)),
    new_status            SMALLINT DEFAULT 1 CHECK ( new_status IN (0, 1)),
    recommended_status    SMALLINT CHECK ( recommended_status IN (0, 1) ),
    verify_status         SMALLINT CHECK ( verify_status IN (0, 1)),
    sort                  SMALLINT,
    sale                  SMALLINT DEFAULT 0,
    price                 NUMERIC(10, 2),
    promotion_price       NUMERIC(10, 2),
    gift_growth           SMALLINT,
    gift_point            SMALLINT,
    use_point_limit       SMALLINT,
    subtitle              TEXT,
    description           TEXT,
    original_price        NUMERIC(10, 2),
    stock                 SMALLINT,
    low_stock             SMALLINT,
    unit                  VARCHAR(16),
    weight                NUMERIC(5, 2),
    preview_status        SMALLINT DEFAULT 0 CHECK ( preview_status IN (0, 1)),
    service_ids           VARCHAR(60),
    keywords              VARCHAR(255),
    note                  VARCHAR(255),
    album_pics            VARCHAR(255),
    detail_title          VARCHAR(255),
    detail_desc           TEXT,
    detail_html           TEXT,
    detail_mobile_html    TEXT,
    promotion_start_time  TIMESTAMP WITHOUT TIME ZONE,
    promotion_end_time    TIMESTAMP WITHOUT TIME ZONE,
    promotion_per_limit   SMALLINT,
    promotion_type        SMALLINT,
    product_category_name VARCHAR(255),
    brand_name            VARCHAR(255),
    PRIMARY KEY (id)
);

COMMENT ON TABLE pms.product IS 'product table';

DROP TABLE IF EXISTS pms.category;
CREATE TABLE IF NOT EXISTS pms.category
(
    id            BIGSERIAL          NOT NULL,
    pid           BIGINT             NOT NULL DEFAULT NULL,
    name          VARCHAR(64) UNIQUE NOT NULL,
    level         SMALLINT                    DEFAULT NULL CHECK ( level IN (0, 1) ),
    product_count SMALLINT                    DEFAULT NULL,
    product_unit  SMALLINT                    DEFAULT NULL,
    nav_status    SMALLINT CHECK ( nav_status IN (0, 1) ),
    show_status   SMALLINT CHECK ( show_status IN (0, 1)),
    sort          SMALLINT,
    icon          VARCHAR(32),
    keywords      TEXT,
    description   TEXT,
    PRIMARY KEY (id)
);
COMMENT ON TABLE pms.category IS 'bảng danh mục sản phẩm';
COMMENT ON COLUMN pms.category.pid IS 'id của category mẹ, giá trị 0 là root_category';
COMMENT ON COLUMN pms.category.name IS 'tên category';
COMMENT ON COLUMN pms.category.level IS 'cấp bậc phân loại: 0->level1, 1->level2';
COMMENT ON COLUMN pms.category.product_count IS 'số sản phẩm thuộc có';
COMMENT ON COLUMN pms.category.product_unit IS 'đơn vị một sản phẩm';
COMMENT ON COLUMN pms.category.nav_status IS 'trạng thái hiển thị trên navigation bar: 0->ẩn, 1->hiện';
COMMENT ON COLUMN pms.category.show_status IS 'trạng thái hiển thị: 0->ẩn, 1->hiển thị';
