INSERT INTO ums.admin
VALUES ('1', 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, 'Test account', NULL,
        '2018-09-29 13:55:30', '2018-09-29 13:55:39', '1');
INSERT INTO ums.admin
VALUES ('3', 'admin', '$2a$10$.E1FokumK5GIXWgKlg.Hc.i/0/2.qdAwYFL1zc5QHdyzpXOr38RZO',
        'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/170157_yIl3_1767531.jpg', 'admin@163.com',
        'System administrator', 'System administrator', '2018-10-08 13:32:47', '2019-03-20 15:38:50', '1');

INSERT INTO ums.role
VALUES ('1', 'Product manager', 'Product manager', '0', '2018-09-30 15:46:11', '1', '0');
INSERT INTO ums.role
VALUES ('2', 'Product type manager', 'Product type manager', '0', '2018-09-30 15:53:45', '1', '0');
INSERT INTO ums.role
VALUES ('3', 'Categories manager', 'Categories manager', '0', '2018-09-30 15:53:56', '1', '0');
INSERT INTO ums.role
VALUES ('4', 'Brand manager', 'Brand manager', '0', '2018-09-30 15:54:12', '1', '0');


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
