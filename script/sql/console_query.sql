-- product_full_reduction
DROP TABLE IF EXISTS pms_full_reduction;
CREATE TABLE pms_full_reduction
(
    id           BIGSERIAL                          NOT NULL,
    product_id   BIGINT REFERENCES pms.product (id) NOT NULL,
    full_price   NUMERIC(10, 2)                     NOT NULL,
    reduce_price NUMERIC(10, 2)                     NOT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE pms_full_reduction IS 'giảm giá toàn bộ sản phẩm (chỉ các sản phẩm cùng loại)';

-- product_ladder
DROP TABLE IF EXISTS pms_ladder;
CREATE TABLE pms_ladder
(
    id         BIGSERIAL                          NOT NULL,
    product_id BIGINT REFERENCES pms.product (id) NOT NULL,
    count      BIGINT DEFAULT 0                   NOT NULL,
    discount   NUMERIC(10, 2),
    price      NUMERIC(10, 2),
    PRIMARY KEY (id)
);

COMMENT ON TABLE pms_ladder IS 'danh sách thang giá sản phẩm (sản phẩm cùng loại)';
COMMENT ON COLUMN pms_ladder.count IS 'số sản phẩm';
COMMENT ON COLUMN pms_ladder.discount IS 'giảm giá';
COMMENT ON COLUMN pms_ladder.price IS 'giá sau khi giảm';

-- ----------------------------
-- Records of pms.brand      --
-------------------------------
INSERT INTO pms.brand
VALUES ('1', 'Wanhe', 'W', '0', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(5).jpg', '',
        'The story of Victoria''s Secret');
INSERT INTO pms.brand
VALUES ('2', 'Samsung', 'S', '100', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (1).jpg', NULL,
        'The story of Samsung');
INSERT INTO pms.brand
VALUES ('3', 'Huawei', 'H', '100', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/17f2dd9756d9d333bee8e60ce8c03e4c_222_222.jpg',
        NULL, 'The story of Victoria''s Secret');
INSERT INTO pms.brand
VALUES ('4', 'Gree', 'G', '30', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/dc794e7e74121272bbe3ce9bc41ec8c3_222_222.jpg',
        NULL, 'The story of Victoria''s Secret');
INSERT INTO pms.brand
VALUES ('5', 'Hota', 'F', '20', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg', NULL,
        'The story of Victoria''s Secret');
INSERT INTO pms.brand
VALUES ('6', 'Millet', 'M', '500', '1', '1', '100', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/1e34aef2a409119018a4c6258e39ecfb_222_222.png',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/5afd7778Nf7800b75.jpg',
        'The story of Xiaomi phones');
INSERT INTO pms.brand
VALUES ('21', 'OPPO', 'O', '0', '1', '1', '88', '500',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg', '', 'string');
INSERT INTO pms.brand
VALUES ('49', 'Seven Wolves', 'S', '200', '1', '1', '77', '400',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/18d8bc3eb13533fab466d702a0d3fd1f40345bcd.jpg',
        NULL, 'The story of BOOB');
INSERT INTO pms.brand
VALUES ('50', 'Umiyuki Family', 'H', '200', '1', '1', '66', '300',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/99d3279f1029d32b929343b09d3c72de_222_222.jpg',
        '', 'The story of Hailan House');
INSERT INTO pms.brand
VALUES ('51', 'Apple', 'A', '200', '1', '1', '55', '200',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, 'Apple''s story');
INSERT INTO pms.brand
VALUES ('58', 'NIKE', 'N', '0', '1', '1', '33', '100',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/timg (51).jpg', '', 'NIKE''s story');

-- product_operate_log
DROP TABLE IF EXISTS pms_operate_log;
CREATE TABLE pms_operate_log
(
    id                  BIGSERIAL NOT NULL,
    product_id          BIGINT REFERENCES pms.product (id),
    price_old           NUMERIC(10, 2),
    price_new           NUMERIC(10, 2),
    sale_price_old      NUMERIC(10, 2),
    sale_price_new      NUMERIC(10, 2),
    gift_point_old      INTEGER                     DEFAULT NULL,
    gift_point_new      INTEGER                     DEFAULT NULL,
    use_point_limit_old INTEGER                     DEFAULT NULL,
    use_point_limit_new INTEGER                     DEFAULT NULL,
    operate_man         TEXT                        DEFAULT NULL,
    create_time         TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE pms_operate_log IS 'bảng lưu lịch sử thay đổi thông tin giá sản phẩm';
COMMENT ON COLUMN pms_operate_log.operate_man IS 'người thực hiện thay đổi';

-- pms.sku_stock
DROP TABLE IF EXISTS pms.sku_stock;
CREATE TABLE pms.sku_stock
(
    id              BIGSERIAL          NOT NULL,
    product_id      BIGINT REFERENCES pms.product (id),
    sku_code        VARCHAR(64) UNIQUE NOT NULL,
    price           NUMERIC(10, 2)     NOT NULL,
    stock           INTEGER     DEFAULT 0,
    low_stock       INTEGER,
    sp1             VARCHAR(64) DEFAULT NULL,
    sp2             VARCHAR(64) DEFAULT NULL,
    sp3             VARCHAR(64) DEFAULT NULL,
    pic             TEXT        DEFAULT NULL,
    sale            INTEGER,
    promotion_price NUMERIC(10, 2),
    lock_stock      INTEGER     DEFAULT 0,
    PRIMARY KEY (id)
);
COMMENT ON TABLE pms.sku_stock IS 'sku - quản lý hàng tồn kho';
COMMENT ON COLUMN pms.sku_stock.sku_code IS 'mã sku';
COMMENT ON COLUMN pms.sku_stock.stock IS 'số lượng trong kho';
COMMENT ON COLUMN pms.sku_stock.low_stock IS 'cảnh báo số lượng hàng ở mức thấp';
COMMENT ON COLUMN pms.sku_stock.sp1 IS 'thuộc tính thứ 1';
COMMENT ON COLUMN pms.sku_stock.pic IS 'ảnh hiện thị';
COMMENT ON COLUMN pms.sku_stock.promotion_price IS 'giá khuyến mãi sản phẩm';
COMMENT ON COLUMN pms.sku_stock.lock_stock IS 'khóa hàng tồn kho';

-- pms.member_price
DROP TABLE IF EXISTS pms.member_price;
CREATE TABLE pms.member_price
(
    id                BIGSERIAL                          NOT NULL,
    product_id        BIGINT REFERENCES pms.product (id) NOT NULL,
    member_level_id   BIGINT UNIQUE                      NOT NULL,
    member_price      NUMERIC(10, 2)                     NOT NULL,
    member_level_name TEXT                               NOT NULL,
    PRIMARY KEY (id)
);
COMMENT ON TABLE pms.member_price IS 'bảng  giá sản phẩm cho thành viên theo cấp độ';

-- pms.weight_template
DROP TABLE IF EXISTS pms.weight_template;
CREATE TABLE pms.weight_template
(
    id              BIGSERIAL          NOT NULL,
    name            VARCHAR(64) UNIQUE NOT NULL,
    charge_type     INTEGER            NOT NULL CHECK ( charge_type IN (0, 1) ),
    first_weight    NUMERIC(10, 2),
    first_fee       NUMERIC(10, 2),
    continue_weight NUMERIC(10, 2),
    continue_fee    NUMERIC(10, 2),
    dest            TEXT,
    PRIMARY KEY (id)
);


-- ----------------------------
-- Records of pms    --
-- ----------------------------
INSERT INTO pms.product
VALUES ('1', '49', '7', '0', '0', 'Silver star embroidered mesh bottom pants 1',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '1', '1', '1',
        '1', '100', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL, NULL, NULL, '0',
        'Seven wolves', 'coat');
INSERT INTO pms.product
VALUES ('2', '49', '7', '0', '0', 'Silver star embroidered mesh bottom pants 2',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86578', '1', '1', '1', '1',
        '1', '1', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants2', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        '<p>Silver star embroidered mesh bottom pants</p>', '<p>Silver star embroidered mesh bottom pants</p>', NULL,
        NULL, NULL, '0', 'Seven wolves', 'coat');
INSERT INTO pms.product
VALUES ('3', '1', '7', '0', '0', 'Silver star embroidered mesh bottom pants 3',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86579', '1', '1', '1', '1',
        '1', '1', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants3', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL, NULL, NULL, '0',
        'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('4', '1', '7', '0', '0', 'Silver star embroidered mesh bottom pants 4',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86580', '1', '1', '1', '1',
        '1', '1', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants4', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL, NULL, NULL, '0',
        'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('5', '1', '7', '0', '0', 'Silver star embroidered mesh bottom pants 5',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86581', '1', '0', '1', '1',
        '1', '1', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants5', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL, NULL, NULL, '0',
        'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('6', '1', '7', '0', '0', 'Silver star embroidered mesh bottom pants 6',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86582', '1', '1', '1', '1',
        '1', '1', '0', '100.00', NULL, '0', '100', NULL, '111', '111', '120.00', '100', '20', 'item', '1000.00', '0',
        NULL, 'Silver star embroidered mesh bottom pants6', 'Silver star embroidered mesh bottom pants', NULL,
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants',
        'Silver star embroidered mesh bottom pants', 'Silver star embroidered mesh bottom pants', NULL, NULL, NULL, '0',
        'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('7', '1', '7', '0', '1', 'Women super soft brushed sports cardigan',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '0',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('8', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 1',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '0',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('9', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 1',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '0',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('10', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 1',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '0',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('11', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 1',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '1', '0', '1',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('12', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 2',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '1', '0', '1',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('13', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 3',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '1', '0', '1',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('14', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 3',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '1',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('18', '1', '7', '0', '1', 'Women super soft brushed sports cardigan 3',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180522/web.png', 'No86577', '1', '0', '0', '1',
        '0', '0', '0', '249.00', '0.00', '0', '100', '0', 'Ingenious tailoring, drape texture',
        'Ingenious tailoring, drape texture', '299.00', '100', '0', 'item', '0.00', '0', 'string',
        'Women super soft brushed sports cardigan ', 'string', 'string', 'string', 'string', 'string', 'string',
        '2018-04-26 10:41:03', '2018-04-26 10:41:03', '0', '0', 'Wanhe', 'coat');
INSERT INTO pms.product
VALUES ('22', '6', '7', '0', '1', 'test',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/1522738681.jpg', '', '1', '1', '0', '0',
        '0', '0', '0', '0.00', NULL, '0', '0', '0', 'test', '', '0.00', '100', '0', '', '0.00', '1', '1,2', '', '', '',
        '', '', '', '', NULL, NULL, '0', '0', 'Millet', 'coat');
INSERT INTO pms.product
VALUES ('23', '6', '19', '0', '1', 'Sweater test',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/1522738681.jpg', 'NO.1098', '1', '1', '1',
        '1', '0', '0', '0', '99.00', NULL, '99', '99', '1000', 'Sweater test11', 'xxx', '109.00', '100', '0', 'item',
        '1000.00', '1', '1,2,3', 'Sweater test', 'Sweater test',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/1522738681.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/1522738681.jpg',
        'Sweater test', 'Sweater test',
        '<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/155x54.bmp\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/APP登录bg1080.jpg\" width=\"500\" height=\"500\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180604/APP登录界面.jpg\" width=\"500\" height=\"500\" /></p>',
        '', NULL, NULL, '0', '2', 'Millet', 'Mobile Communications');
INSERT INTO pms.product
VALUES ('24', '6', '7', '0', NULL, 'xxx', '', '', '1', '0', '0', '0', '0', '0', '0', '0.00', NULL, '0', '0', '0', 'xxx',
        '', '0.00', '100', '0', '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', 'Millet',
        'coat');
INSERT INTO pms.product
VALUES ('26', '3', '19', '0', '3', 'HUAWEI P20 ',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '6946605', '0', '1',
        '1', '1', '0', '100', '0', '3788.00', NULL, '3788', '3788', '0',
        'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', '', '4288.00', '1000', '0', 'item', '0.00', '1', '2,3,1',
        '', '',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ab46a3cN616bdc41.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf5fN2522b9dc.jpg',
        '', '',
        '<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44f1cNf51f3bb0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa8Nfcf71c10.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa9N40e78ee0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f4N1c94bdda.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f5Nd30de41d.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5b10fb0eN0eb053fb.jpg\" /></p>',
        '', NULL, NULL, '0', '1', 'Huawei', 'Mobile Communications');
INSERT INTO pms.product
VALUES ('27', '6', '19', '0', '3',
        'Mi 8 Full Screen Gaming Smartphone 6GB 64GB Black Full Netcom 4G Dual SIM Dual Standby',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '7437788', '0', '1', '1', '1',
        '0', '0', '0', '2699.00', NULL, '2699', '2699', '0',
        'Snapdragon 845 processor, infrared face unlock, AI zoom dual camera, AI voice assistant Xiaomi 6X as low as 1299, click to buy',
        'Mi 8 Full Screen Gaming Smartphone 6GB 64GB Black Full Netcom 4G Dual SIM Dual Standby', '2699.00', '100', '0',
        '', '0.00', '0', '', '', '', '', '', '',
        '<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b2254e8N414e6d3a.jpg\" width=\"500\" /></p>',
        '', NULL, NULL, '0', '3', '小米', '手机通讯');
INSERT INTO pms.product
VALUES ('28', '6', '19', '0', '3',
        'Xiaomi Redmi 5A Full Netcom Edition 3GB 32GB Champagne Gold Mobile Unicom Telecom 4G Phone Dual SIM Dual Standby',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '7437789', '0', '1',
        '1', '1', '0', '0', '0', '649.00', NULL, '649', '649', '0', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '',
        '649.00', '100', '0', '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '4', '小米', '手机通讯');
INSERT INTO pms.product
VALUES ('29', '51', '19', '0', '3', 'Apple iPhone 8 Plus 64GB 红色特别版 移动联通电信4G手机',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', '7437799', '0', '1',
        '1', '0', '0', '0', '0', '5499.00', NULL, '5499', '5499', '0',
        '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', '', '5499.00', '100', '0',
        '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', '苹果', '手机通讯');
INSERT INTO pms.product
VALUES ('30', '50', '8', '0', '1', 'HLA海澜之家简约动物印花短袖T恤',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5ad83a4fN6ff67ecd.jpg!cc_350x449.jpg',
        'HNTBJ2E042A', '0', '1', '1', '1', '0', '0', '0', '98.00', NULL, '0', '0', '0',
        '2018夏季新品微弹舒适新款短T男生 6月6日-6月20日，满300减30，参与互动赢百元礼券，立即分享赢大奖', '', '98.00', '100', '0', '', '0.00', '0', '', '', '',
        '', '', '', '', '', NULL, NULL, '0', '0', '海澜之家', 'T恤');
INSERT INTO pms.product
VALUES ('31', '50', '8', '0', '1', 'HLA海澜之家蓝灰花纹圆领针织布短袖T恤',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5ac98b64N70acd82f.jpg!cc_350x449.jpg',
        'HNTBJ2E080A', '0', '1', '0', '0', '0', '0', '0', '98.00', NULL, '0', '0', '0',
        '2018夏季新品短袖T恤男HNTBJ2E080A 蓝灰花纹80 175/92A/L80A 蓝灰花纹80 175/92A/L', '', '98.00', '100', '0', '', '0.00', '0', '',
        '', '', '', '', '', '', '', NULL, NULL, '0', '0', '海澜之家', 'T恤');
INSERT INTO pms.product
VALUES ('32', '50', '8', '0', NULL, 'HLA海澜之家短袖T恤男基础款',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a51eb88Na4797877.jpg', 'HNTBJ2E153A', '0',
        '1', '0', '0', '0', '0', '0', '68.00', NULL, '0', '0', '0', 'HLA海澜之家短袖T恤男基础款简约圆领HNTBJ2E153A藏青(F3)175/92A(50)',
        '', '68.00', '100', '0', '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', '海澜之家', 'T恤');
INSERT INTO pms.product
VALUES ('33', '6', '35', '0', NULL, '小米（MI）小米电视4A ',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', '4609652', '0', '1',
        '0', '0', '0', '0', '0', '2499.00', NULL, '0', '0', '0',
        '小米（MI）小米电视4A 55英寸 L55M5-AZ/L55M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', '', '2499.00', '100', '0', '', '0.00',
        '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', '小米', '手机数码');
INSERT INTO pms.product
VALUES ('34', '6', '35', '0', NULL, '小米（MI）小米电视4A 65英寸',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b028530N51eee7d4.jpg', '4609660', '0', '1',
        '0', '0', '0', '0', '0', '3999.00', NULL, '0', '0', '0', ' L65M5-AZ/L65M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视',
        '', '3999.00', '100', '0', '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', '小米', '手机数码');
INSERT INTO pms.product
VALUES ('35', '58', '29', '0', NULL, '耐克NIKE 男子 休闲鞋 ROSHE RUN 运动鞋 511881-010黑色41码',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b235bb9Nf606460b.jpg', '6799342', '0', '1',
        '0', '0', '0', '0', '0', '369.00', NULL, '0', '0', '0', '耐克NIKE 男子 休闲鞋 ROSHE RUN 运动鞋 511881-010黑色41码', '',
        '369.00', '100', '0', '', '0.00', '0', '', '', '', '', '', '', '', '', NULL, NULL, '0', '0', 'NIKE', '男鞋');
INSERT INTO pms.product
VALUES ('36', '58', '29', '0', NULL, '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg', '6799345', '0', '1',
        '1', '1', '0', '0', '0', '499.00', NULL, '0', '0', '0',
        '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '', '499.00', '100', '0', '', '0.00', '0', '', '',
        '', '', '', '', '', '', NULL, NULL, '0', '0', 'NIKE', '男鞋');

DROP TABLE IF EXISTS ums.menu;
CREATE TABLE ums.menu
(
    id          BIGSERIAL NOT NULL,
    pid         BIGINT REFERENCES ums.menu (id),
    create_time TIMESTAMP WITHOUT TIME ZONE,
    title       VARCHAR(100),
    level       INTEGER,
    sort        INTEGER,
    name        VARCHAR(100),
    icon        VARCHAR(100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ums.role_menu_relation;
CREATE TABLE ums.role_menu_relation
(
    role_id BIGINT REFERENCES ums.role (id),
    menu_id BIGINT REFERENCES ums.menu (id),
    PRIMARY KEY (role_id, menu_id)
);


DROP TABLE IF EXISTS ums.resource_category;
CREATE TABLE ums.resource_category
(
    id          BIGSERIAL    NOT NULL,
    create_time TIMESTAMP WITHOUT TIME ZONE,
    name        VARCHAR(200) NOT NULL UNIQUE,
    sort        INTEGER,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ums.resource;
CREATE TABLE ums.resource
(
    id                   BIGSERIAL NOT NULL,
    create_time          TIMESTAMP WITHOUT TIME ZONE,
    name                 VARCHAR(200),
    url                  VARCHAR(200),
    description          TEXT,
    resource_category_id BIGINT REFERENCES ums.resource_category (id),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ums.role_resource_relation;
CREATE TABLE ums.role_resource_relation
(
    role_id     BIGINT REFERENCES ums.role (id),
    resource_id BIGINT REFERENCES ums.resource (id),
    PRIMARY KEY (role_id, resource_id)
);

-- ----------------------------
-- Records of ums.resource_category
-- ----------------------------
INSERT INTO ums.resource_category
VALUES ('1', '2020-02-05 10:21:44', 'Commodity module', '0');
INSERT INTO ums.resource_category
VALUES ('2', '2020-02-05 10:22:34', 'Order module', '0');
INSERT INTO ums.resource_category
VALUES ('3', '2020-02-05 10:22:48', 'Marketing module', '0');
INSERT INTO ums.resource_category
VALUES ('4', '2020-02-05 10:23:04', 'Permission module', '0');
INSERT INTO ums.resource_category
VALUES ('5', '2020-02-07 16:34:27', 'Content module', '0');
INSERT INTO ums.resource_category
VALUES ('6', '2020-02-07 16:35:49', 'Other modules', '0');

-- ----------------------------
-- Records of ums.resource
-- ----------------------------
INSERT INTO ums.resource
VALUES ('1', '2020-02-04 17:04:55', 'Product brand management', '/brand/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('2', '2020-02-04 17:05:35', 'Product attribute group management', '/productAttribute/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('3', '2020-02-04 17:06:13', 'Product attribute management', '/productAttribute/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('4', '2020-02-04 17:07:15', 'Product category management', '/productCategory/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('5', '2020-02-04 17:09:16', 'Product management', '/product/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('6', '2020-02-04 17:09:53', 'Product inventory management', '/sku/**', NULL, '1');
INSERT INTO ums.resource
VALUES ('8', '2020-02-05 14:43:37', 'Order management', '/order/**', '', '2');
INSERT INTO ums.resource
VALUES ('9', '2020-02-05 14:44:22', 'Order return application management', '/returnApply/**', '', '2');
INSERT INTO ums.resource
VALUES ('10', '2020-02-05 14:45:08', 'Return Reason Management', '/returnReason/**', '', '2');
INSERT INTO ums.resource
VALUES ('11', '2020-02-05 14:45:43', 'Order setting management', '/orderSetting/**', '', '2');
INSERT INTO ums.resource
VALUES ('12', '2020-02-05 14:46:23', 'Delivery address management', '/companyAddress/**', '', '2');
INSERT INTO ums.resource
VALUES ('13', '2020-02-07 16:37:22', 'Coupon management', '/coupon/**', '', '3');
INSERT INTO ums.resource
VALUES ('14', '2020-02-07 16:37:59', 'Coupon history record management', '/couponHistory/**', '', '3');
INSERT INTO ums.resource
VALUES ('15', '2020-02-07 16:38:28', 'Limited time purchase activity management', '/flash/**', '', '3');
INSERT INTO ums.resource
VALUES ('16', '2020-02-07 16:38:59', 'Limited-time purchase of goods relationship management',
        '/flashProductRelation/**', '', '3');
INSERT INTO ums.resource
VALUES ('17', '2020-02-07 16:39:22', 'Limited time purchase management', '/flashSession/**', '', '3');
INSERT INTO ums.resource
VALUES ('18', '2020-02-07 16:40:07', 'Homepage carousel ad management', '/home/advertise/**', '', '3');
INSERT INTO ums.resource
VALUES ('19', '2020-02-07 16:40:34', 'Home Brand Management', '/home/brand/**', '', '3');
INSERT INTO ums.resource
VALUES ('20', '2020-02-07 16:41:06', 'Home New Product Management', '/home/newProduct/**', '', '3');
INSERT INTO ums.resource
VALUES ('21', '2020-02-07 16:42:16', 'Home Popularity Recommendation Management', '/home/recommendProduct/**', '', '3');
INSERT INTO ums.resource
VALUES ('22', '2020-02-07 16:42:48', 'Homepage Special Recommendation Management', '/home/recommendSubject/**', '',
        '3');
INSERT INTO ums.resource
VALUES ('23', '2020-02-07 16:44:56', 'Product selection management', '/prefrenceArea/**', '', '5');
INSERT INTO ums.resource
VALUES ('24', '2020-02-07 16:45:39', 'Product topic management', '/subject/**', '', '5');
INSERT INTO ums.resource
VALUES ('25', '2020-02-07 16:47:34', 'User management', '/admin/**', '', '4');
INSERT INTO ums.resource
VALUES ('26', '2020-02-07 16:48:24', 'Role management', '/role/**', '', '4');
INSERT INTO ums.resource
VALUES ('27', '2020-02-07 16:48:48', 'Menu management', '/menu/**', '', '4');
INSERT INTO ums.resource
VALUES ('28', '2020-02-07 16:49:18', 'Resource group management', '/resourceCategory/**', '', '4');
INSERT INTO ums.resource
VALUES ('29', '2020-02-07 16:49:45', 'Resource management', '/resource/**', '', '4');

-- ----------------------------
-- Records of ums.role_resource_relation
-- ----------------------------
INSERT INTO ums.role_resource_relation
VALUES ('2', '8');
INSERT INTO ums.role_resource_relation
VALUES ('2', '9');
INSERT INTO ums.role_resource_relation
VALUES ('2', '10');
INSERT INTO ums.role_resource_relation
VALUES ('2', '11');
INSERT INTO ums.role_resource_relation
VALUES ('2', '12');
INSERT INTO ums.role_resource_relation
VALUES ('5', '1');
INSERT INTO ums.role_resource_relation
VALUES ('5', '2');
INSERT INTO ums.role_resource_relation
VALUES ('5', '3');
INSERT INTO ums.role_resource_relation
VALUES ('5', '4');
INSERT INTO ums.role_resource_relation
VALUES ('5', '5');
INSERT INTO ums.role_resource_relation
VALUES ('5', '6');
INSERT INTO ums.role_resource_relation
VALUES ('5', '8');
INSERT INTO ums.role_resource_relation
VALUES ('5', '9');
INSERT INTO ums.role_resource_relation
VALUES ('5', '10');
INSERT INTO ums.role_resource_relation
VALUES ('5', '11');
INSERT INTO ums.role_resource_relation
VALUES ('5', '12');
INSERT INTO ums.role_resource_relation
VALUES ('5', '13');
INSERT INTO ums.role_resource_relation
VALUES ('5', '14');
INSERT INTO ums.role_resource_relation
VALUES ('5', '15');
INSERT INTO ums.role_resource_relation
VALUES ('5', '16');
INSERT INTO ums.role_resource_relation
VALUES ('5', '17');
INSERT INTO ums.role_resource_relation
VALUES ('5', '18');
INSERT INTO ums.role_resource_relation
VALUES ('5', '19');
INSERT INTO ums.role_resource_relation
VALUES ('5', '20');
INSERT INTO ums.role_resource_relation
VALUES ('5', '21');
INSERT INTO ums.role_resource_relation
VALUES ('5', '22');
INSERT INTO ums.role_resource_relation
VALUES ('5', '23');
INSERT INTO ums.role_resource_relation
VALUES ('5', '24');
INSERT INTO ums.role_resource_relation
VALUES ('5', '25');
INSERT INTO ums.role_resource_relation
VALUES ('5', '26');
INSERT INTO ums.role_resource_relation
VALUES ('5', '27');
INSERT INTO ums.role_resource_relation
VALUES ('5', '28');
INSERT INTO ums.role_resource_relation
VALUES ('5', '29');
INSERT INTO ums.role_resource_relation
VALUES ('1', '1');
INSERT INTO ums.role_resource_relation
VALUES ('1', '2');
INSERT INTO ums.role_resource_relation
VALUES ('1', '3');
INSERT INTO ums.role_resource_relation
VALUES ('1', '4');
INSERT INTO ums.role_resource_relation
VALUES ('1', '5');
INSERT INTO ums.role_resource_relation
VALUES ('1', '6');
INSERT INTO ums.role_resource_relation
VALUES ('1', '23');
INSERT INTO ums.role_resource_relation
VALUES ('1', '24');


INSERT INTO ums.admin
VALUES ('1', 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', 'test@qq.com', 'Test account',
        NULL, '2018-09-29 13:55:30', '2018-09-29 13:55:39', '1');
INSERT INTO ums.admin
VALUES ('3', 'admin', '$2a$10$.E1FokumK5GIXWgKlg.Hc.i/0/2.qdAwYFL1zc5QHdyzpXOr38RZO',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', 'admin@163.com',
        'System administrator', 'System administrator', '2018-10-08 13:32:47', '2019-04-20 12:45:16', '1');
INSERT INTO ums.admin
VALUES ('4', 'macro', '$2a$10$Bx4jZPR7GhEpIQfefDQtVeS58GfT5n6mxs/b4nLLK65eMFa16topa', 'string', 'macro@qq.com', 'macro',
        'macro dedicated', '2019-10-06 15:53:51', '2020-02-03 14:55:55', '1');
INSERT INTO ums.admin
VALUES ('6', 'productAdmin', '$2a$10$6/.J.p.6Bhn7ic4GfoB5D.pGd7xSiD1a9M6ht6yO0fxzlKJPjRAGm', NULL, 'product@qq.com',
        'Product manager', 'Only product permissions', '2020-02-07 16:15:08', NULL, '1');
INSERT INTO ums.admin
VALUES ('7', 'orderAdmin', '$2a$10$UqEhA9UZXjHHA3B.L9wNG.6aerrBjC6WHTtbv1FdvYPUI.7lkL6E.', NULL, 'order@qq.com',
        'Order manager', 'Only order management authority', '2020-02-07 16:15:50', NULL, '1');

INSERT INTO ums.role
VALUES ('1', 'Commodity manager', 'Can only view and operate products', '0', '2020-02-03 16:50:37', '1', '0');
INSERT INTO ums.role
VALUES ('2', 'Order manager', 'Can only view and operate orders', '0', '2018-09-30 15:53:45', '1', '0');
INSERT INTO ums.role
VALUES ('5', 'Super administrator', 'Have all viewing and operating functions', '0', '2020-02-02 15:11:05', '1', '0');

INSERT INTO ums.admin_role_relation
VALUES ('3', '5');
INSERT INTO ums.admin_role_relation
VALUES ('6', '1');
INSERT INTO ums.admin_role_relation
VALUES ('7', '2');
INSERT INTO ums.admin_role_relation
VALUES ('1', '5');
INSERT INTO ums.admin_role_relation
VALUES ('4', '5');


INSERT INTO ums.menu
VALUES ('1', '0', '2020-02-02 14:50:36', 'Merchandise', '0', '0', 'pms', 'product', '0');
INSERT INTO ums.menu
VALUES ('2', '1', '2020-02-02 14:51:50', 'Product list', '1', '0', 'product', 'product-list', '0');
INSERT INTO ums.menu
VALUES ('3', '1', '2020-02-02 14:52:44', 'Adding product', '1', '0', 'addProduct', 'product-add', '0');
INSERT INTO ums.menu
VALUES ('4', '1', '2020-02-02 14:53:51', 'Categories', '1', '0', 'productCate', 'product-cate', '0');
INSERT INTO ums.menu
VALUES ('5', '1', '2020-02-02 14:54:51', 'Product Types', '1', '0', 'productAttr', 'product-attr', '0');
INSERT INTO ums.menu
VALUES ('6', '1', '2020-02-02 14:56:29', 'Brand', '1', '0', 'brand', 'product-brand', '0');
INSERT INTO ums.menu
VALUES ('7', '0', '2020-02-02 16:54:07', 'Order', '0', '0', 'oms', 'order', '0');
INSERT INTO ums.menu
VALUES ('8', '7', '2020-02-02 16:55:18', 'Order List', '1', '0', 'order', 'product-list', '0');
INSERT INTO ums.menu
VALUES ('9', '7', '2020-02-02 16:56:46', 'Order settings', '1', '0', 'orderSetting', 'order-setting', '0');
INSERT INTO ums.menu
VALUES ('10', '7', '2020-02-02 16:57:39', 'Return request processing', '1', '0', 'returnApply', 'order-return', '0');
INSERT INTO ums.menu
VALUES ('11', '7', '2020-02-02 16:59:40', 'Return reason setting', '1', '0', 'returnReason', 'order-return-reason',
        '0');
INSERT INTO ums.menu
VALUES ('12', '0', '2020-02-04 16:18:00', 'Marketing', '0', '0', 'sms', 'sms', '0');
INSERT INTO ums.menu
VALUES ('13', '12', '2020-02-04 16:19:22', 'Spike activity list', '1', '0', 'flash', 'sms-flash', '0');
INSERT INTO ums.menu
VALUES ('14', '12', '2020-02-04 16:20:16', 'Coupon list', '1', '0', 'coupon', 'sms-coupon', '0');
INSERT INTO ums.menu
VALUES ('16', '12', '2020-02-07 16:22:38', 'Brand recommendation', '1', '0', 'homeBrand', 'product-brand', '0');
INSERT INTO ums.menu
VALUES ('17', '12', '2020-02-07 16:23:14', 'New Product', '1', '0', 'homeNew', 'sms-new', '0');
INSERT INTO ums.menu
VALUES ('18', '12', '2020-02-07 16:26:38', 'Popular recommendation', '1', '0', 'homeHot', 'sms-hot', '0');
INSERT INTO ums.menu
VALUES ('19', '12', '2020-02-07 16:28:16', 'Recommended topics', '1', '0', 'homeSubject', 'sms-subject', '0');
INSERT INTO ums.menu
VALUES ('20', '12', '2020-02-07 16:28:42', 'Ad list', '1', '0', 'homeAdvertise', 'sms-ad', '0');
INSERT INTO ums.menu
VALUES ('21', '0', '2020-02-07 16:29:13', 'Authority', '0', '0', 'ums', 'ums', '0');
INSERT INTO ums.menu
VALUES ('22', '21', '2020-02-07 16:29:51', 'User list', '1', '0', 'admin', 'ums-admin', '0');
INSERT INTO ums.menu
VALUES ('23', '21', '2020-02-07 16:30:13', 'Role list', '1', '0', 'role', 'ums-role', '0');
INSERT INTO ums.menu
VALUES ('24', '21', '2020-02-07 16:30:53', 'Menu list', '1', '0', 'menu', 'ums-menu', '0');
INSERT INTO ums.menu
VALUES ('25', '21', '2020-02-07 16:31:13', 'Resource list', '1', '0', 'resource', 'ums-resource', '0');

INSERT INTO ums.role_menu_relation
VALUES ('1', '1');
INSERT INTO ums.role_menu_relation
VALUES ('1', '2');
INSERT INTO ums.role_menu_relation
VALUES ('1', '3');
INSERT INTO ums.role_menu_relation
VALUES ('1', '4');
INSERT INTO ums.role_menu_relation
VALUES ('1', '5');
INSERT INTO ums.role_menu_relation
VALUES ('1', '6');
INSERT INTO ums.role_menu_relation
VALUES ('2', '7');
INSERT INTO ums.role_menu_relation
VALUES ('2', '8');
INSERT INTO ums.role_menu_relation
VALUES ('2', '9');
INSERT INTO ums.role_menu_relation
VALUES ('2', '10');
INSERT INTO ums.role_menu_relation
VALUES ('2', '11');
INSERT INTO ums.role_menu_relation
VALUES ('5', '1');
INSERT INTO ums.role_menu_relation
VALUES ('5', '2');
INSERT INTO ums.role_menu_relation
VALUES ('5', '3');
INSERT INTO ums.role_menu_relation
VALUES ('5', '4');
INSERT INTO ums.role_menu_relation
VALUES ('5', '5');
INSERT INTO ums.role_menu_relation
VALUES ('5', '6');
INSERT INTO ums.role_menu_relation
VALUES ('5', '7');
INSERT INTO ums.role_menu_relation
VALUES ('5', '8');
INSERT INTO ums.role_menu_relation
VALUES ('5', '9');
INSERT INTO ums.role_menu_relation
VALUES ('5', '10');
INSERT INTO ums.role_menu_relation
VALUES ('5', '11');
INSERT INTO ums.role_menu_relation
VALUES ('5', '12');
INSERT INTO ums.role_menu_relation
VALUES ('5', '13');
INSERT INTO ums.role_menu_relation
VALUES ('5', '14');
INSERT INTO ums.role_menu_relation
VALUES ('5', '16');
INSERT INTO ums.role_menu_relation
VALUES ('5', '17');
INSERT INTO ums.role_menu_relation
VALUES ('5', '18');
INSERT INTO ums.role_menu_relation
VALUES ('5', '19');
INSERT INTO ums.role_menu_relation
VALUES ('5', '20');
INSERT INTO ums.role_menu_relation
VALUES ('5', '21');
INSERT INTO ums.role_menu_relation
VALUES ('5', '22');
INSERT INTO ums.role_menu_relation
VALUES ('5', '23');
INSERT INTO ums.role_menu_relation
VALUES ('5', '24');
INSERT INTO ums.role_menu_relation
VALUES ('5', '25');


INSERT INTO ums.role_permission_relation
VALUES ('1', '1');
INSERT INTO ums.role_permission_relation
VALUES ('1', '2');
INSERT INTO ums.role_permission_relation
VALUES ('1', '3');
INSERT INTO ums.role_permission_relation
VALUES ('1', '7');
INSERT INTO ums.role_permission_relation
VALUES ('1', '8');
INSERT INTO ums.role_permission_relation
VALUES ('2', '4');
INSERT INTO ums.role_permission_relation
VALUES ('2', '9');
INSERT INTO ums.role_permission_relation
VALUES ('2', '10');
INSERT INTO ums.role_permission_relation
VALUES ('2', '11');
INSERT INTO ums.role_permission_relation
VALUES ('5', '5');
INSERT INTO ums.role_permission_relation
VALUES ('5', '12');
INSERT INTO ums.role_permission_relation
VALUES ('5', '13');
INSERT INTO ums.role_permission_relation
VALUES ('5', '14');
INSERT INTO ums.role_permission_relation
VALUES ('5', '6');
INSERT INTO ums.role_permission_relation
VALUES ('5', '15');
INSERT INTO ums.role_permission_relation
VALUES ('5', '16');
INSERT INTO ums.role_permission_relation
VALUES ('5', '17');


SELECT *
FROM ums.admin
         LEFT JOIN ums.admin_role_relation ON admin.id = admin_role_relation.admin_id
         LEFT JOIN ums.role ON admin_role_relation.role_id = role.id
         LEFT JOIN ums.role_resource_relation ON role.id = role_resource_relation.role_id
         LEFT JOIN ums.resource ON role_resource_relation.resource_id = resource.id
WHERE admin.id = 3;

SELECT count(*)
FROM ums.role_resource_relation
WHERE role_id = 5;
