--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pms; Type: SCHEMA; Schema: -; Owner: truongtuan
--

CREATE SCHEMA pms;


ALTER SCHEMA pms OWNER TO truongtuan;

--
-- Name: SCHEMA pms; Type: COMMENT; Schema: -; Owner: truongtuan
--

COMMENT ON SCHEMA pms IS 'Products management system';


--
-- Name: ums; Type: SCHEMA; Schema: -; Owner: truongtuan
--

CREATE SCHEMA ums;


ALTER SCHEMA ums OWNER TO truongtuan;

--
-- Name: SCHEMA ums; Type: COMMENT; Schema: -; Owner: truongtuan
--

COMMENT ON SCHEMA ums IS 'User management system';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attribute; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.attribute (
    id bigint NOT NULL,
    attribute_category_id bigint,
    name character varying(64) NOT NULL,
    select_type integer,
    input_type integer,
    input_list text,
    sort integer,
    filter_type integer,
    search_type integer,
    related_status integer,
    hand_add_status integer,
    type integer,
    CONSTRAINT attribute_filter_type_check CHECK ((filter_type = ANY (ARRAY[0, 1]))),
    CONSTRAINT attribute_hand_add_status_check CHECK ((hand_add_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT attribute_input_type_check CHECK ((input_type = ANY (ARRAY[0, 1]))),
    CONSTRAINT attribute_related_status_check CHECK ((related_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT attribute_search_type_check CHECK ((search_type = ANY (ARRAY[0, 1, 2]))),
    CONSTRAINT attribute_select_type_check CHECK ((select_type = ANY (ARRAY[0, 1, 2]))),
    CONSTRAINT attribute_type_check CHECK ((type = ANY (ARRAY[0, 1])))
);


ALTER TABLE pms.attribute OWNER TO truongtuan;

--
-- Name: TABLE attribute; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.attribute IS 'bảng danh mục sản phẩm';


--
-- Name: attribute_category; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.attribute_category (
    id bigint NOT NULL,
    name text NOT NULL,
    attribute_count integer,
    param_count integer
);


ALTER TABLE pms.attribute_category OWNER TO truongtuan;

--
-- Name: TABLE attribute_category; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.attribute_category IS 'nhóm các attribute thành category (khác nhóm theo category sản phẩm)';


--
-- Name: attribute_category_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.attribute_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.attribute_category_id_seq OWNER TO truongtuan;

--
-- Name: attribute_category_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.attribute_category_id_seq OWNED BY pms.attribute_category.id;


--
-- Name: attribute_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.attribute_id_seq OWNER TO truongtuan;

--
-- Name: attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.attribute_id_seq OWNED BY pms.attribute.id;


--
-- Name: brand; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.brand (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    first_letter character varying(8) NOT NULL,
    sort integer NOT NULL,
    factory_status integer NOT NULL,
    show_status integer DEFAULT 1 NOT NULL,
    product_count integer DEFAULT 0 NOT NULL,
    product_comment_count integer DEFAULT 0 NOT NULL,
    logo text,
    big_pic text,
    brand_story text
);


ALTER TABLE pms.brand OWNER TO truongtuan;

--
-- Name: TABLE brand; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.brand IS 'bảng thương hiệu sản phẩm';


--
-- Name: brand_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.brand_id_seq OWNER TO truongtuan;

--
-- Name: brand_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.brand_id_seq OWNED BY pms.brand.id;


--
-- Name: category; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.category (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying(64) NOT NULL,
    level integer,
    product_count integer,
    product_unit integer,
    nav_status integer,
    show_status integer,
    sort integer,
    icon character varying(32),
    keywords text,
    description text,
    CONSTRAINT category_level_check CHECK ((level = ANY (ARRAY[0, 1]))),
    CONSTRAINT category_nav_status_check CHECK ((nav_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT category_show_status_check CHECK ((show_status = ANY (ARRAY[0, 1])))
);


ALTER TABLE pms.category OWNER TO truongtuan;

--
-- Name: TABLE category; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.category IS 'bảng danh mục sản phẩm';


--
-- Name: COLUMN category.parent_id; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.parent_id IS 'id của category mẹ, giá trị 0 là root_category';


--
-- Name: COLUMN category.name; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.name IS 'tên category';


--
-- Name: COLUMN category.level; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.level IS 'cấp bậc phân loại: 0->level1, 1->level2';


--
-- Name: COLUMN category.product_count; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.product_count IS 'số sản phẩm thuộc có';


--
-- Name: COLUMN category.product_unit; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.product_unit IS 'đơn vị một sản phẩm';


--
-- Name: COLUMN category.nav_status; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.nav_status IS 'trạng thái hiển thị trên navigation bar: 0->ẩn, 1->hiện';


--
-- Name: COLUMN category.show_status; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.category.show_status IS 'trạng thái hiển thị: 0->ẩn, 1->hiển thị';


--
-- Name: category_attribute_relation; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.category_attribute_relation (
    category_id bigint NOT NULL,
    attribute_id bigint NOT NULL
);


ALTER TABLE pms.category_attribute_relation OWNER TO truongtuan;

--
-- Name: TABLE category_attribute_relation; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.category_attribute_relation IS 'bảng liên kết giữa category và attribute, một category có các attribute đặc trưng';


--
-- Name: category_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.category_id_seq OWNER TO truongtuan;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.category_id_seq OWNED BY pms.category.id;


--
-- Name: member_price; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.member_price (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    member_level_id bigint NOT NULL,
    member_price numeric(10,2) NOT NULL,
    member_level_name text NOT NULL
);


ALTER TABLE pms.member_price OWNER TO truongtuan;

--
-- Name: TABLE member_price; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.member_price IS 'bảng  giá sản phẩm cho thành viên theo cấp độ';


--
-- Name: member_price_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.member_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.member_price_id_seq OWNER TO truongtuan;

--
-- Name: member_price_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.member_price_id_seq OWNED BY pms.member_price.id;


--
-- Name: product; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.product (
    id bigint NOT NULL,
    attribute_category_id bigint,
    category_id bigint,
    name text NOT NULL,
    product_sn character varying(50) NOT NULL,
    picture text,
    delete_status integer DEFAULT 0,
    publish_status integer DEFAULT 1,
    new_status integer DEFAULT 1,
    recommended_status integer,
    verify_status integer,
    sort integer,
    sale integer DEFAULT 0,
    price numeric(10,2),
    promotion_price numeric(10,2),
    gift_growth integer,
    gift_point integer,
    use_point_limit integer,
    subtitle text,
    description text,
    original_price numeric(10,2),
    stock integer,
    low_stock integer,
    unit character varying(16),
    weight numeric(5,2),
    preview_status integer DEFAULT 0,
    service_ids character varying(60),
    keywords character varying(255),
    note character varying(255),
    album_pics character varying(255),
    detail_title character varying(255),
    detail_desc text,
    detail_html text,
    detail_mobile_html text,
    promotion_start_time timestamp without time zone,
    promotion_end_time timestamp without time zone,
    promotion_per_limit integer,
    promotion_type integer,
    product_category_name character varying(255),
    brand_name character varying(255),
    brand_id bigint NOT NULL,
    weight_template_id bigint,
    CONSTRAINT product_delete_status_check CHECK ((delete_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT product_new_status_check CHECK ((new_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT product_preview_status_check CHECK ((preview_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT product_publish_status_check CHECK ((publish_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT product_recommended_status_check CHECK ((recommended_status = ANY (ARRAY[0, 1]))),
    CONSTRAINT product_verify_status_check CHECK ((verify_status = ANY (ARRAY[0, 1])))
);


ALTER TABLE pms.product OWNER TO truongtuan;

--
-- Name: TABLE product; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.product IS 'product table, thông tin sản phẩm';


--
-- Name: product_attribute_value; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.product_attribute_value (
    id bigint NOT NULL,
    product_id bigint,
    attribute_id bigint,
    value text
);


ALTER TABLE pms.product_attribute_value OWNER TO truongtuan;

--
-- Name: TABLE product_attribute_value; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.product_attribute_value IS 'bảng liên kết product-attribute đồng thời lưu giá trị attribute';


--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_attribute_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_attribute_value_id_seq OWNER TO truongtuan;

--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_attribute_value_id_seq OWNED BY pms.product_attribute_value.id;


--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_category_id_seq OWNER TO truongtuan;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_category_id_seq OWNED BY pms.product.category_id;


--
-- Name: product_full_reduction; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.product_full_reduction (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    full_price numeric(10,2) NOT NULL,
    reduce_price numeric(10,2) NOT NULL
);


ALTER TABLE pms.product_full_reduction OWNER TO truongtuan;

--
-- Name: TABLE product_full_reduction; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.product_full_reduction IS 'giảm giá toàn bộ sản phẩm (chỉ các sản phẩm cùng loại)';


--
-- Name: product_full_reduction_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_full_reduction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_full_reduction_id_seq OWNER TO truongtuan;

--
-- Name: product_full_reduction_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_full_reduction_id_seq OWNED BY pms.product_full_reduction.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_id_seq OWNER TO truongtuan;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_id_seq OWNED BY pms.product.id;


--
-- Name: product_ladder; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.product_ladder (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    count bigint DEFAULT 0 NOT NULL,
    discount numeric(10,2),
    price numeric(10,2)
);


ALTER TABLE pms.product_ladder OWNER TO truongtuan;

--
-- Name: TABLE product_ladder; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.product_ladder IS 'danh sách thang giá sản phẩm (sản phẩm cùng loại)';


--
-- Name: COLUMN product_ladder.count; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.product_ladder.count IS 'số sản phẩm';


--
-- Name: COLUMN product_ladder.discount; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.product_ladder.discount IS 'giảm giá';


--
-- Name: COLUMN product_ladder.price; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.product_ladder.price IS 'giá sau khi giảm';


--
-- Name: product_ladder_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_ladder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_ladder_id_seq OWNER TO truongtuan;

--
-- Name: product_ladder_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_ladder_id_seq OWNED BY pms.product_ladder.id;


--
-- Name: product_operate_log; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.product_operate_log (
    id bigint NOT NULL,
    product_id bigint,
    price_old numeric(10,2),
    price_new numeric(10,2),
    sale_price_old numeric(10,2),
    sale_price_new numeric(10,2),
    gift_point_old integer,
    gift_point_new integer,
    use_point_limit_old integer,
    use_point_limit_new integer,
    operate_man text,
    create_time timestamp without time zone
);


ALTER TABLE pms.product_operate_log OWNER TO truongtuan;

--
-- Name: TABLE product_operate_log; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.product_operate_log IS 'bảng lưu lịch sử thay đổi thông tin giá sản phẩm';


--
-- Name: COLUMN product_operate_log.operate_man; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.product_operate_log.operate_man IS 'người thực hiện thay đổi';


--
-- Name: product_operate_log_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.product_operate_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.product_operate_log_id_seq OWNER TO truongtuan;

--
-- Name: product_operate_log_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.product_operate_log_id_seq OWNED BY pms.product_operate_log.id;


--
-- Name: sku_stock; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.sku_stock (
    id bigint NOT NULL,
    product_id bigint,
    sku_code character varying(64) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0,
    low_stock integer,
    sp1 character varying(64) DEFAULT NULL::character varying,
    sp2 character varying(64) DEFAULT NULL::character varying,
    sp3 character varying(64) DEFAULT NULL::character varying,
    pic text,
    sale integer,
    promotion_price numeric(10,2),
    lock_stock integer DEFAULT 0
);


ALTER TABLE pms.sku_stock OWNER TO truongtuan;

--
-- Name: TABLE sku_stock; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.sku_stock IS 'sku - quản lý hàng tồn kho';


--
-- Name: COLUMN sku_stock.sku_code; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.sku_code IS 'mã sku';


--
-- Name: COLUMN sku_stock.stock; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.stock IS 'số lượng trong kho';


--
-- Name: COLUMN sku_stock.low_stock; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.low_stock IS 'cảnh báo số lượng hàng ở mức thấp';


--
-- Name: COLUMN sku_stock.sp1; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.sp1 IS 'thuộc tính thứ 1';


--
-- Name: COLUMN sku_stock.pic; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.pic IS 'ảnh hiện thị';


--
-- Name: COLUMN sku_stock.promotion_price; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.promotion_price IS 'giá khuyến mãi sản phẩm';


--
-- Name: COLUMN sku_stock.lock_stock; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.sku_stock.lock_stock IS 'khóa hàng tồn kho';


--
-- Name: sku_stock_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.sku_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.sku_stock_id_seq OWNER TO truongtuan;

--
-- Name: sku_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.sku_stock_id_seq OWNED BY pms.sku_stock.id;


--
-- Name: weight_template; Type: TABLE; Schema: pms; Owner: truongtuan
--

CREATE TABLE pms.weight_template (
    id bigint NOT NULL,
    name character varying(64) NOT NULL,
    charge_type integer NOT NULL,
    first_weight numeric(10,2),
    first_fee numeric(10,2),
    continue_weight numeric(10,2),
    continue_fee numeric(10,2),
    dest text,
    CONSTRAINT weight_template_charge_type_check CHECK ((charge_type = ANY (ARRAY[0, 1])))
);


ALTER TABLE pms.weight_template OWNER TO truongtuan;

--
-- Name: TABLE weight_template; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON TABLE pms.weight_template IS 'biểu mẫu vận chuyển hàng hóa';


--
-- Name: COLUMN weight_template.name; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.name IS 'tên template';


--
-- Name: COLUMN weight_template.charge_type; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.charge_type IS 'loại thanh toán: 0->theo trọng lượng, 1->theo số lượng';


--
-- Name: COLUMN weight_template.first_weight; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.first_weight IS 'trọng lượng đầu tiên kg';


--
-- Name: COLUMN weight_template.first_fee; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.first_fee IS 'tiền phí đầu tiên vnđ';


--
-- Name: COLUMN weight_template.continue_weight; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.continue_weight IS 'trọng lượng tiếp theo kg';


--
-- Name: COLUMN weight_template.continue_fee; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.continue_fee IS 'tiền phí tiếp theo vnđ';


--
-- Name: COLUMN weight_template.dest; Type: COMMENT; Schema: pms; Owner: truongtuan
--

COMMENT ON COLUMN pms.weight_template.dest IS 'điểm đến: tỉnh, thành phố';


--
-- Name: weight_template_id_seq; Type: SEQUENCE; Schema: pms; Owner: truongtuan
--

CREATE SEQUENCE pms.weight_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pms.weight_template_id_seq OWNER TO truongtuan;

--
-- Name: weight_template_id_seq; Type: SEQUENCE OWNED BY; Schema: pms; Owner: truongtuan
--

ALTER SEQUENCE pms.weight_template_id_seq OWNED BY pms.weight_template.id;


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: truongtuan
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO truongtuan;

--
-- Name: admin; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.admin (
    id bigint NOT NULL,
    username text,
    password text,
    icon text,
    email text,
    nick_name text,
    note text,
    create_time timestamp without time zone NOT NULL,
    login_time timestamp without time zone,
    status integer NOT NULL,
    CONSTRAINT admin_status_check CHECK ((status = ANY (ARRAY[0, 1])))
);


ALTER TABLE ums.admin OWNER TO truongtuan;

--
-- Name: COLUMN admin.id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.id IS 'ID';


--
-- Name: COLUMN admin.username; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.username IS 'Username to login';


--
-- Name: COLUMN admin.password; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.password IS 'Password to login';


--
-- Name: COLUMN admin.icon; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.icon IS 'Front-end icon';


--
-- Name: COLUMN admin.email; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.email IS 'Email';


--
-- Name: COLUMN admin.nick_name; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.nick_name IS 'Admins nickname';


--
-- Name: COLUMN admin.note; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.note IS 'Note about this account';


--
-- Name: COLUMN admin.create_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.create_time IS 'Created time';


--
-- Name: COLUMN admin.login_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.login_time IS 'Recently login time';


--
-- Name: COLUMN admin.status; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin.status IS 'Trạng thái tài khoản: 0->vô hiệu hóa, 1->kích hoạt';


--
-- Name: admin_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.admin_id_seq OWNER TO truongtuan;

--
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.admin_id_seq OWNED BY ums.admin.id;


--
-- Name: admin_login_log; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.admin_login_log (
    id bigint NOT NULL,
    admin_id bigint,
    create_time timestamp without time zone,
    ip character varying(64) DEFAULT NULL::character varying,
    address character varying(100) DEFAULT NULL::character varying,
    user_agent character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE ums.admin_login_log OWNER TO truongtuan;

--
-- Name: TABLE admin_login_log; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON TABLE ums.admin_login_log IS 'bảng lưu thông tin lịch sử đăng nhập';


--
-- Name: admin_login_log_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.admin_login_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.admin_login_log_id_seq OWNER TO truongtuan;

--
-- Name: admin_login_log_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.admin_login_log_id_seq OWNED BY ums.admin_login_log.id;


--
-- Name: admin_permission_relation; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.admin_permission_relation (
    admin_id bigint NOT NULL,
    permission_id bigint NOT NULL,
    type integer
);


ALTER TABLE ums.admin_permission_relation OWNER TO truongtuan;

--
-- Name: TABLE admin_permission_relation; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON TABLE ums.admin_permission_relation IS 'tùy chỉnh quyền admin riêng lẻ không thông qua bộ các permission nhóm bởi role';


--
-- Name: admin_role_relation; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.admin_role_relation (
    admin_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE ums.admin_role_relation OWNER TO truongtuan;

--
-- Name: COLUMN admin_role_relation.admin_id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin_role_relation.admin_id IS 'id của admin';


--
-- Name: COLUMN admin_role_relation.role_id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.admin_role_relation.role_id IS 'id của role';


--
-- Name: menu; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.menu (
    id bigint NOT NULL,
    parent_id bigint,
    create_time timestamp without time zone,
    title character varying(100),
    level integer,
    sort integer,
    name character varying(100),
    icon character varying(100),
    hidden integer DEFAULT 0
);


ALTER TABLE ums.menu OWNER TO truongtuan;

--
-- Name: TABLE menu; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON TABLE ums.menu IS 'bảng quản lý menu ở cạnh trái giao diện';


--
-- Name: COLUMN menu.id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.id IS 'ID';


--
-- Name: COLUMN menu.parent_id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.parent_id IS 'id menu mẹ, 0->root menu';


--
-- Name: COLUMN menu.create_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.create_time IS 'thời điểm tạo menu';


--
-- Name: COLUMN menu.title; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.title IS 'tiêu đề menu, hiển thị front-end';


--
-- Name: COLUMN menu.level; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.level IS 'cấp menu 0->root menu, 1->sub-menu';


--
-- Name: COLUMN menu.sort; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.sort IS 'thứ tự sắp xếp menu';


--
-- Name: COLUMN menu.name; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.name IS 'tên đường dẫn cho menu';


--
-- Name: COLUMN menu.icon; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.icon IS 'tên icon hiển thị';


--
-- Name: COLUMN menu.hidden; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.menu.hidden IS 'trạng thái ẩn, 0->hiển thị, 1->ẩn đi';


--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.menu_id_seq OWNER TO truongtuan;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.menu_id_seq OWNED BY ums.menu.id;


--
-- Name: permission; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.permission (
    id bigint NOT NULL,
    parent_id bigint,
    name text,
    value text,
    icon text,
    type integer,
    uri text,
    status integer DEFAULT 1 NOT NULL,
    create_time timestamp without time zone NOT NULL,
    sort integer,
    CONSTRAINT permission_status_check CHECK ((status = ANY (ARRAY[0, 1]))),
    CONSTRAINT permission_type_check CHECK ((type = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE ums.permission OWNER TO truongtuan;

--
-- Name: COLUMN permission.id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.id IS 'ID';


--
-- Name: COLUMN permission.parent_id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.parent_id IS 'id của permission mẹ, 0->root permission';


--
-- Name: COLUMN permission.name; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.name IS 'tên';


--
-- Name: COLUMN permission.value; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.value IS 'giá trị';


--
-- Name: COLUMN permission.icon; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.icon IS 'icon hiển thị';


--
-- Name: COLUMN permission.type; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.type IS 'kiểu, 0->directory, 1->menu, 2->button';


--
-- Name: COLUMN permission.uri; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.uri IS 'resource path';


--
-- Name: COLUMN permission.status; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.status IS 'trạng thái';


--
-- Name: COLUMN permission.create_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.create_time IS 'thời điểm được tạo';


--
-- Name: COLUMN permission.sort; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.permission.sort IS 'thứ tự sắp xếp';


--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.permission_id_seq OWNER TO truongtuan;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.permission_id_seq OWNED BY ums.permission.id;


--
-- Name: resource; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.resource (
    id bigint NOT NULL,
    create_time timestamp without time zone,
    name character varying(200),
    url character varying(200),
    description text,
    resource_category_id bigint
);


ALTER TABLE ums.resource OWNER TO truongtuan;

--
-- Name: TABLE resource; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON TABLE ums.resource IS 'bảng resource';


--
-- Name: COLUMN resource.id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.id IS 'ID';


--
-- Name: COLUMN resource.create_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.create_time IS 'thời điểm tạo';


--
-- Name: COLUMN resource.name; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.name IS 'tên resource';


--
-- Name: COLUMN resource.url; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.url IS 'url dẫn đến resource';


--
-- Name: COLUMN resource.description; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.description IS 'mô tả về resource';


--
-- Name: COLUMN resource.resource_category_id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.resource.resource_category_id IS 'danh mục resource';


--
-- Name: resource_category; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.resource_category (
    id bigint NOT NULL,
    create_time timestamp without time zone,
    name character varying(200) NOT NULL,
    sort integer
);


ALTER TABLE ums.resource_category OWNER TO truongtuan;

--
-- Name: resource_category_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.resource_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.resource_category_id_seq OWNER TO truongtuan;

--
-- Name: resource_category_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.resource_category_id_seq OWNED BY ums.resource_category.id;


--
-- Name: resource_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.resource_id_seq OWNER TO truongtuan;

--
-- Name: resource_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.resource_id_seq OWNED BY ums.resource.id;


--
-- Name: role; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.role (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    admin_count integer NOT NULL,
    create_time timestamp without time zone NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    sort integer DEFAULT 0,
    CONSTRAINT role_status_check CHECK ((status = ANY (ARRAY[0, 1])))
);


ALTER TABLE ums.role OWNER TO truongtuan;

--
-- Name: COLUMN role.id; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.id IS 'ID';


--
-- Name: COLUMN role.name; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.name IS 'tên role';


--
-- Name: COLUMN role.description; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.description IS 'mô tả về role';


--
-- Name: COLUMN role.admin_count; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.admin_count IS 'số admin thuộc về role';


--
-- Name: COLUMN role.create_time; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.create_time IS 'thời điểm tạo ra role';


--
-- Name: COLUMN role.status; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.status IS 'trạng thái của role 1 -> kích hoạt, 0 -> vô hiệu hóa';


--
-- Name: COLUMN role.sort; Type: COMMENT; Schema: ums; Owner: truongtuan
--

COMMENT ON COLUMN ums.role.sort IS 'thứ tự sắp xếp role';


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: ums; Owner: truongtuan
--

CREATE SEQUENCE ums.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ums.role_id_seq OWNER TO truongtuan;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: ums; Owner: truongtuan
--

ALTER SEQUENCE ums.role_id_seq OWNED BY ums.role.id;


--
-- Name: role_menu_relation; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.role_menu_relation (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL
);


ALTER TABLE ums.role_menu_relation OWNER TO truongtuan;

--
-- Name: role_permission_relation; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.role_permission_relation (
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE ums.role_permission_relation OWNER TO truongtuan;

--
-- Name: role_resource_relation; Type: TABLE; Schema: ums; Owner: truongtuan
--

CREATE TABLE ums.role_resource_relation (
    role_id bigint NOT NULL,
    resource_id bigint NOT NULL
);


ALTER TABLE ums.role_resource_relation OWNER TO truongtuan;

--
-- Name: attribute id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute ALTER COLUMN id SET DEFAULT nextval('pms.attribute_id_seq'::regclass);


--
-- Name: attribute_category id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute_category ALTER COLUMN id SET DEFAULT nextval('pms.attribute_category_id_seq'::regclass);


--
-- Name: brand id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.brand ALTER COLUMN id SET DEFAULT nextval('pms.brand_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category ALTER COLUMN id SET DEFAULT nextval('pms.category_id_seq'::regclass);


--
-- Name: member_price id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.member_price ALTER COLUMN id SET DEFAULT nextval('pms.member_price_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product ALTER COLUMN id SET DEFAULT nextval('pms.product_id_seq'::regclass);


--
-- Name: product category_id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product ALTER COLUMN category_id SET DEFAULT nextval('pms.product_category_id_seq'::regclass);


--
-- Name: product_attribute_value id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_attribute_value ALTER COLUMN id SET DEFAULT nextval('pms.product_attribute_value_id_seq'::regclass);


--
-- Name: product_full_reduction id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_full_reduction ALTER COLUMN id SET DEFAULT nextval('pms.product_full_reduction_id_seq'::regclass);


--
-- Name: product_ladder id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_ladder ALTER COLUMN id SET DEFAULT nextval('pms.product_ladder_id_seq'::regclass);


--
-- Name: product_operate_log id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_operate_log ALTER COLUMN id SET DEFAULT nextval('pms.product_operate_log_id_seq'::regclass);


--
-- Name: sku_stock id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.sku_stock ALTER COLUMN id SET DEFAULT nextval('pms.sku_stock_id_seq'::regclass);


--
-- Name: weight_template id; Type: DEFAULT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.weight_template ALTER COLUMN id SET DEFAULT nextval('pms.weight_template_id_seq'::regclass);


--
-- Name: admin id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin ALTER COLUMN id SET DEFAULT nextval('ums.admin_id_seq'::regclass);


--
-- Name: admin_login_log id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_login_log ALTER COLUMN id SET DEFAULT nextval('ums.admin_login_log_id_seq'::regclass);


--
-- Name: menu id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.menu ALTER COLUMN id SET DEFAULT nextval('ums.menu_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.permission ALTER COLUMN id SET DEFAULT nextval('ums.permission_id_seq'::regclass);


--
-- Name: resource id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.resource ALTER COLUMN id SET DEFAULT nextval('ums.resource_id_seq'::regclass);


--
-- Name: resource_category id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.resource_category ALTER COLUMN id SET DEFAULT nextval('ums.resource_category_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role ALTER COLUMN id SET DEFAULT nextval('ums.role_id_seq'::regclass);


--
-- Data for Name: attribute; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.attribute (id, attribute_category_id, name, select_type, input_type, input_list, sort, filter_type, search_type, related_status, hand_add_status, type) FROM stdin;
\.


--
-- Data for Name: attribute_category; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.attribute_category (id, name, attribute_count, param_count) FROM stdin;
\.


--
-- Data for Name: brand; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.brand (id, name, first_letter, sort, factory_status, show_status, product_count, product_comment_count, logo, big_pic, brand_story) FROM stdin;
51	Apple	A	200	1	1	55	200		\N	Apple's story
2	Samsung	S	100	1	1	100	100		\N	Samsung's story
1	Sony	S	0	1	1	100	100			The story of Sony
5	Honda	H	20	1	1	100	100		\N	The story of Honda
3	LG	L	100	1	1	100	100		\N	The story of LG
50	BMW	B	200	1	1	66	300			The story of BMW
4	Tesla	T	30	1	1	100	100		\N	The story of Tesla
58	Nike	N	0	1	1	33	100			NIKE's story
49	Canifa	C	200	1	1	77	400		\N	The story of Canifa
21	Vinfast	v	0	1	1	88	500			Vinfast Vietnam
6	Tiki	T	500	0	1	100	100			The story of Tiki
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.category (id, parent_id, name, level, product_count, product_unit, nav_status, show_status, sort, icon, keywords, description) FROM stdin;
\.


--
-- Data for Name: category_attribute_relation; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.category_attribute_relation (category_id, attribute_id) FROM stdin;
\.


--
-- Data for Name: member_price; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.member_price (id, product_id, member_level_id, member_price, member_level_name) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.product (id, attribute_category_id, category_id, name, product_sn, picture, delete_status, publish_status, new_status, recommended_status, verify_status, sort, sale, price, promotion_price, gift_growth, gift_point, use_point_limit, subtitle, description, original_price, stock, low_stock, unit, weight, preview_status, service_ids, keywords, note, album_pics, detail_title, detail_desc, detail_html, detail_mobile_html, promotion_start_time, promotion_end_time, promotion_per_limit, promotion_type, product_category_name, brand_name, brand_id, weight_template_id) FROM stdin;
\.


--
-- Data for Name: product_attribute_value; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.product_attribute_value (id, product_id, attribute_id, value) FROM stdin;
\.


--
-- Data for Name: product_full_reduction; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.product_full_reduction (id, product_id, full_price, reduce_price) FROM stdin;
\.


--
-- Data for Name: product_ladder; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.product_ladder (id, product_id, count, discount, price) FROM stdin;
\.


--
-- Data for Name: product_operate_log; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.product_operate_log (id, product_id, price_old, price_new, sale_price_old, sale_price_new, gift_point_old, gift_point_new, use_point_limit_old, use_point_limit_new, operate_man, create_time) FROM stdin;
\.


--
-- Data for Name: sku_stock; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.sku_stock (id, product_id, sku_code, price, stock, low_stock, sp1, sp2, sp3, pic, sale, promotion_price, lock_stock) FROM stdin;
\.


--
-- Data for Name: weight_template; Type: TABLE DATA; Schema: pms; Owner: truongtuan
--

COPY pms.weight_template (id, name, charge_type, first_weight, first_fee, continue_weight, continue_fee, dest) FROM stdin;
\.


--
-- Data for Name: admin; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.admin (id, username, password, icon, email, nick_name, note, create_time, login_time, status) FROM stdin;
87	thuylinh	$2a$10$XtIdaJ7k1cJ0apwzlgOqPeDrEWH1rgxJxtdu0CB6F0yp8Y4Aa82dG	\N	thuylingdy@mail.com	Product/Order manager	Quản lý sản phẩm	2021-11-18 08:12:48.848	2021-11-18 08:13:46.688	1
79	truongtuan	$2a$10$Q56HoueNAkMLUz4DhAaTTOFKkvE/UXBPKYMKwWvBruGnNmLZ3ff8G	\N	truongvantuan@outlook.com.vn	Java Developer	Super adminitrator	2021-11-17 17:02:04.08	2021-11-20 07:47:25.079	1
90	adminsystem	$2a$10$WO1A3p1nKW8XLViezhy2henHiQs5j8k.hL7MLRuKR0etpp5uKOlu6	\N	admin@gmail.com	admin system	admin system	2021-11-18 08:15:24.345	\N	1
3	admin	$2a$10$.E1FokumK5GIXWgKlg.Hc.i/0/2.qdAwYFL1zc5QHdyzpXOr38RZO	https://truongvantuan.github.io/authors/admin/avatar_hub0a1e9522a4d07747dfd7aa3fe185e02_516061_270x270_fill_lanczos_center_3.png	admin@email.com	System administrator	System administrator	2021-11-15 13:32:47	2021-11-20 08:40:39.807	1
7	orderAdmin	$2a$10$UqEhA9UZXjHHA3B.L9wNG.6aerrBjC6WHTtbv1FdvYPUI.7lkL6E.	\N	order@email.com	Order manager	Only order management authority	2021-11-15 16:15:50	2021-11-16 15:53:16.424	1
4	macro	$2a$10$Bx4jZPR7GhEpIQfefDQtVeS58GfT5n6mxs/b4nLLK65eMFa16topa	string	macro@email.com	macro	macro dedicated	2021-11-15 15:53:51	2021-11-14 20:00:35.638	1
6	productAdmin	$2a$10$6/.J.p.6Bhn7ic4GfoB5D.pGd7xSiD1a9M6ht6yO0fxzlKJPjRAGm	\N	product@email.com	Product manager	Only product permissions	2021-11-15 16:15:08	2021-11-16 15:57:08.202	1
1	test	$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG	https://truongvantuan.github.io/authors/admin/avatar_hub0a1e9522a4d07747dfd7aa3fe185e02_516061_270x270_fill_lanczos_center_3.png	test@email.com	Test account	test admin	2021-11-15 13:55:30	2021-11-16 15:52:13.53	1
\.


--
-- Data for Name: admin_login_log; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.admin_login_log (id, admin_id, create_time, ip, address, user_agent) FROM stdin;
16	3	2021-11-14 19:58:51.34	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
17	1	2021-11-14 20:00:29.395	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
18	4	2021-11-14 20:00:35.85	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
19	7	2021-11-14 20:00:42.724	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
20	1	2021-11-14 20:24:01.004	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
21	7	2021-11-14 20:29:33.602	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
22	3	2021-11-14 20:41:39.972	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
23	3	2021-11-15 10:28:36.276	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
24	3	2021-11-15 10:57:18.784	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
25	1	2021-11-15 11:56:54.234	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
26	1	2021-11-15 11:57:15.231	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
27	7	2021-11-15 11:57:49.58	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
28	3	2021-11-15 11:58:37.209	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	PostmanRuntime/7.28.4
29	3	2021-11-15 12:19:07.868	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
30	3	2021-11-15 12:20:49.645	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
31	3	2021-11-15 15:21:37.99	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
32	3	2021-11-15 15:21:49.862	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
33	3	2021-11-15 15:22:09.165	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
34	3	2021-11-15 15:26:25.167	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
35	3	2021-11-15 15:26:39.7	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
36	1	2021-11-15 15:27:13.61	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
37	3	2021-11-15 15:40:34.135	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
38	3	2021-11-15 15:48:14.277	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
39	3	2021-11-15 15:48:21.088	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
40	3	2021-11-15 15:48:24.103	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
41	3	2021-11-15 15:49:27.542	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
42	3	2021-11-15 15:51:41.203	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
43	3	2021-11-15 16:09:38.411	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
44	3	2021-11-15 16:12:26.58	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
45	3	2021-11-15 20:32:36.737	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
46	3	2021-11-15 20:33:35.881	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
47	3	2021-11-15 20:35:18.508	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
48	3	2021-11-15 20:36:48.61	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
49	1	2021-11-15 20:49:20.389	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
50	3	2021-11-15 20:54:13.06	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
51	3	2021-11-16 09:03:46.304	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
52	3	2021-11-16 10:11:28.603	0:0:0:0:0:0:0:1	0:0:0:0:0:0:0:1	insomnia/2021.6.0
53	3	2021-11-16 10:13:39.106	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
55	3	2021-11-16 15:24:39.18	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
57	3	2021-11-16 15:40:17.66	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
58	3	2021-11-16 15:49:03.897	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
59	3	2021-11-16 15:50:33.955	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
60	1	2021-11-16 15:52:13.576	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
61	7	2021-11-16 15:53:16.47	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
62	6	2021-11-16 15:57:08.211	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
63	3	2021-11-16 15:57:36.85	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
64	3	2021-11-16 16:10:50.103	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
67	3	2021-11-16 20:13:24.957	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
68	66	2021-11-16 20:42:11.019	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
69	3	2021-11-16 21:19:36.908	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
70	3	2021-11-17 07:48:49.997	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
71	3	2021-11-17 15:28:04.27	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
72	66	2021-11-17 15:43:16.918	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
73	66	2021-11-17 15:43:44.75	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
74	66	2021-11-17 15:44:41.487	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
75	66	2021-11-17 15:46:21.753	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
76	3	2021-11-17 15:46:30.869	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
77	66	2021-11-17 16:25:10.816	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
78	3	2021-11-17 17:00:44.304	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
80	79	2021-11-17 17:03:25.604	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
81	3	2021-11-17 17:03:57.065	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
82	3	2021-11-17 17:05:43.154	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
83	3	2021-11-17 19:00:13.901	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
84	3	2021-11-17 19:01:59.349	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
85	3	2021-11-17 19:09:30.171	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
86	3	2021-11-18 08:11:58.041	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
88	87	2021-11-18 08:13:46.694	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
89	3	2021-11-18 08:14:00.266	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
94	3	2021-11-18 09:49:48.251	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
95	3	2021-11-18 10:00:32.088	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
97	3	2021-11-18 10:05:06.169	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
100	3	2021-11-18 10:42:38.156	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
102	3	2021-11-18 15:01:39.019	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
104	3	2021-11-18 16:56:31.456	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
105	3	2021-11-18 21:04:09.697	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
106	3	2021-11-18 21:26:42.403	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
107	3	2021-11-18 21:30:34.928	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
108	3	2021-11-18 21:43:10.544	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
109	3	2021-11-19 08:02:34.988	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
110	3	2021-11-19 21:21:15.703	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
111	3	2021-11-19 21:23:00.489	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
112	3	2021-11-19 21:24:05.504	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
113	3	2021-11-20 07:45:47.995	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
114	79	2021-11-20 07:47:25.094	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
115	3	2021-11-20 07:52:23.503	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
116	3	2021-11-20 08:40:39.959	127.0.0.1	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0
\.


--
-- Data for Name: admin_permission_relation; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.admin_permission_relation (admin_id, permission_id, type) FROM stdin;
\.


--
-- Data for Name: admin_role_relation; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.admin_role_relation (admin_id, role_id) FROM stdin;
3	5
6	1
7	2
4	5
79	1
87	1
1	1
1	5
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.menu (id, parent_id, create_time, title, level, sort, name, icon, hidden) FROM stdin;
22	21	2021-11-16 16:29:51	Users	1	0	admin	ums-admin	0
17	12	2021-11-16 16:23:14	New arrivals	1	0	homeNew	sms-new	0
25	21	2021-11-16 16:31:13	Resources	1	0	resource	ums-resource	0
23	21	2021-11-16 16:30:13	Roles	1	0	role	ums-role	0
18	12	2021-11-16 16:26:38	Recommended	1	0	homeHot	sms-hot	0
16	12	2021-11-16 16:22:38	Popular brands	1	0	homeBrand	product-brand	0
4	1	2021-11-16 14:53:51	Categories	1	0	productCate	product-cate	0
1	0	2021-11-16 14:50:36	Catalog	0	0	pms	product	0
14	12	2021-11-16 16:20:16	Coupons	1	0	coupon	sms-coupon	0
9	7	2021-11-16 16:56:46	Order settings	1	0	orderSetting	order-setting	0
8	7	2021-11-16 16:55:18	Order list	1	0	order	product-list	0
3	1	2021-11-16 14:52:44	Add product	1	0	addProduct	product-add	0
13	12	2021-11-16 16:19:22	Planning list	1	0	flash	sms-flash	0
20	12	2021-11-16 16:28:42	Ads	1	0	homeAdvertise	sms-ad	0
11	7	2021-11-16 16:59:40	Return options	1	0	returnReason	order-return-reason	0
6	1	2021-11-16 14:56:29	Brand	1	0	brand	product-brand	0
10	7	2021-11-16 16:57:39	Returns	1	0	returnApply	order-return	0
12	0	2021-11-16 16:18:00	Marketing	0	0	sms	sms	0
7	0	2021-11-16 16:54:07	Order	0	0	oms	order	0
5	1	2021-11-16 14:54:51	Attributes	1	0	productAttr	product-attr	0
2	1	2021-11-16 14:51:50	Products	1	0	product	product-list	0
19	12	2021-11-16 16:28:16	Popular topics	1	0	homeSubject	sms-subject	0
21	0	2021-11-16 16:29:13	Authority	0	0	ums	ums	0
24	21	2021-11-16 16:30:53	Menus	1	0	menu	ums-menu	0
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.permission (id, parent_id, name, value, icon, type, uri, status, create_time, sort) FROM stdin;
2	1	Product list	pms:product:read	\N	1	/pms/product/index	1	2018-09-29 16:17:01	0
3	1	Adding product	pms:product:create	\N	1	/pms/product/add	1	2018-09-29 16:18:51	0
4	1	Categories	pms:productCategory:read	\N	1	/pms/productCate/index	1	2018-09-29 16:23:07	0
5	1	Product Types	pms:productAttribute:read	\N	1	/pms/productAttr/index	1	2018-09-29 16:24:43	0
6	1	Brand management	pms:brand:read	\N	1	/pms/brand/index	1	2018-09-29 16:25:45	0
7	2	Edit product	pms:product:update	\N	2	/pms/product/updateProduct	1	2018-09-29 16:34:23	0
8	2	Delete product	pms:product:delete	\N	2	/pms/product/delete	1	2018-09-29 16:38:33	0
9	4	Add product category	pms:productCategory:create	\N	2	/pms/productCate/create	1	2018-09-29 16:43:23	0
10	4	Modify product category	pms:productCategory:update	\N	2	/pms/productCate/update	1	2018-09-29 16:43:55	0
11	4	Delete product category	pms:productCategory:delete	\N	2	/pms/productAttr/delete	1	2018-09-29 16:44:38	0
12	5	Add product type	pms:productAttribute:create	\N	2	/pms/productAttr/create	1	2018-09-29 16:45:25	0
13	5	Modify product type	pms:productAttribute:update	\N	2	/pms/productAttr/update	1	2018-09-29 16:48:08	0
14	5	Delete product type	pms:productAttribute:delete	\N	2	/pms/productAttr/delete	1	2018-09-29 16:48:44	0
15	6	Add brand	pms:brand:create	\N	2	/pms/brand/add	1	2018-09-29 16:49:34	0
16	6	Modify brand	pms:brand:update	\N	2	/pms/brand/update	1	2018-09-29 16:50:55	0
17	6	Delete brand	pms:brand:delete	\N	2	/pms/brand/delete	1	2018-09-29 16:50:59	0
1	0	Product	\N	\N	0	\N	1	2018-09-29 16:15:14	0
18	0	Home page	\N	\N	0	\N	1	2018-09-29 16:51:57	0
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.resource (id, create_time, name, url, description, resource_category_id) FROM stdin;
3	2021-12-15 17:06:13	Product attribute management	/productAttribute/**	\N	1
5	2021-12-15 17:09:16	Product management	/product/**	\N	1
18	2021-12-15 16:40:07	Homepage carousel ad management	/home/advertise/**		3
20	2021-12-15 16:41:06	Home New Product Management	/home/newProduct/**		3
11	2021-12-15 14:45:43	Order setting management	/orderSetting/**		2
1	2021-12-15 17:04:55	Product brand management	/brand/**	\N	1
19	2021-12-15 16:40:34	Home Brand Management	/home/brand/**		3
6	2021-12-15 17:09:53	Product inventory management	/sku/**	\N	1
2	2021-12-15 17:05:35	Attribute type management	/productAttribute/**	\N	1
8	2021-12-15 14:43:37	Order management	/order/**		2
10	2021-12-15 14:45:08	Return reason management	/returnReason/**		2
4	2021-12-15 17:07:15	Product category management	/productCategory/**	\N	1
9	2021-12-15 14:44:22	Order return management	/returnApply/**		2
12	2021-12-15 14:46:23	Delivery address management	/companyAddress/**		2
24	2021-12-15 16:45:39	Product topic management	/subject/**		5
22	2021-12-15 16:42:48	Homepage Special Recommendation Management	/home/recommendSubject/**		3
13	2021-12-15 16:37:22	Coupon management	/coupon/**		3
27	2021-12-15 16:48:48	Menu management	/menu/**		4
26	2021-12-15 16:48:24	Role management	/role/**		4
29	2021-12-15 16:49:45	Resource management	/resource/**		4
28	2021-12-15 16:49:18	Resource group management	/resourceCategory/**		4
14	2021-12-15 16:37:59	Coupon history management	/couponHistory/**		3
17	2021-12-15 16:39:22	Limited time purchase management	/flashSession/**		3
23	2021-12-15 16:44:56	Product selection management	/prefrenceArea/**		5
16	2021-12-15 16:38:59	Limited-time purchase of goods relationship management	/flashProductRelation/**		3
15	2021-12-15 16:38:28	Limited time purchase activity management	/flash/**		3
25	2021-12-15 16:47:34	User management	/admin/**		4
21	2021-12-15 16:42:16	Home Popularity Recommendation Management	/home/recommendProduct/**		3
\.


--
-- Data for Name: resource_category; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.resource_category (id, create_time, name, sort) FROM stdin;
2	2020-02-05 10:22:34	Order module	0
3	2020-02-05 10:22:48	Marketing module	0
4	2020-02-05 10:23:04	Permission module	0
5	2020-02-07 16:34:27	Content module	0
6	2020-02-07 16:35:49	Other modules	0
1	2020-02-05 10:21:44	Product module	0
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.role (id, name, description, admin_count, create_time, status, sort) FROM stdin;
5	Super administrator	Có tất cả các quyền truy cập chức năng và tài nguyên	0	2021-11-16 15:11:05	1	0
1	Product manager	Có thể xem và thao tác với products	0	2021-11-16 16:50:37	1	0
91	System admin	Quản lý hệ thống	0	2021-11-18 08:44:20.789	1	\N
2	Order manager	Chỉ có thể xem và xử lý orders	0	2021-11-16 15:53:45	1	0
93	Role manager	Quản lý role	0	2021-11-18 09:04:37.954	1	0
103	DEV	developer	0	2021-11-18 15:14:36.775	1	0
\.


--
-- Data for Name: role_menu_relation; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.role_menu_relation (role_id, menu_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
2	7
2	8
2	9
2	10
2	11
5	1
5	2
5	3
5	4
5	5
5	6
5	7
5	8
5	9
5	10
5	11
5	12
5	13
5	14
5	16
5	17
5	18
5	19
5	20
5	21
5	22
5	23
5	24
5	25
\.


--
-- Data for Name: role_permission_relation; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.role_permission_relation (role_id, permission_id) FROM stdin;
1	1
1	2
1	3
1	7
1	8
2	4
2	9
2	10
2	11
5	5
5	12
5	13
5	14
5	6
5	15
5	16
5	17
\.


--
-- Data for Name: role_resource_relation; Type: TABLE DATA; Schema: ums; Owner: truongtuan
--

COPY ums.role_resource_relation (role_id, resource_id) FROM stdin;
2	8
2	9
2	10
2	11
2	12
5	1
5	2
5	3
5	4
5	5
5	6
5	8
5	9
5	10
5	11
5	12
5	13
5	14
5	15
5	16
5	17
5	18
5	19
5	20
5	21
5	22
5	23
5	24
5	25
5	26
5	27
5	28
5	29
1	1
1	2
1	3
1	4
1	5
1	6
1	23
1	24
\.


--
-- Name: attribute_category_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.attribute_category_id_seq', 1, false);


--
-- Name: attribute_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.attribute_id_seq', 1, false);


--
-- Name: brand_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.brand_id_seq', 1, false);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.category_id_seq', 1, false);


--
-- Name: member_price_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.member_price_id_seq', 1, false);


--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_attribute_value_id_seq', 1, false);


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_category_id_seq', 1, false);


--
-- Name: product_full_reduction_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_full_reduction_id_seq', 1, false);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_id_seq', 1, false);


--
-- Name: product_ladder_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_ladder_id_seq', 1, false);


--
-- Name: product_operate_log_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.product_operate_log_id_seq', 1, false);


--
-- Name: sku_stock_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.sku_stock_id_seq', 1, false);


--
-- Name: weight_template_id_seq; Type: SEQUENCE SET; Schema: pms; Owner: truongtuan
--

SELECT pg_catalog.setval('pms.weight_template_id_seq', 1, false);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: truongtuan
--

SELECT pg_catalog.setval('public.hibernate_sequence', 116, true);


--
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.admin_id_seq', 3, true);


--
-- Name: admin_login_log_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.admin_login_log_id_seq', 1, false);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.menu_id_seq', 1, false);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.permission_id_seq', 1, false);


--
-- Name: resource_category_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.resource_category_id_seq', 1, false);


--
-- Name: resource_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.resource_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: ums; Owner: truongtuan
--

SELECT pg_catalog.setval('ums.role_id_seq', 1, false);


--
-- Name: attribute_category attribute_category_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute_category
    ADD CONSTRAINT attribute_category_pkey PRIMARY KEY (id);


--
-- Name: attribute attribute_name_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute
    ADD CONSTRAINT attribute_name_key UNIQUE (name);


--
-- Name: attribute attribute_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute
    ADD CONSTRAINT attribute_pkey PRIMARY KEY (id);


--
-- Name: brand brand_name_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.brand
    ADD CONSTRAINT brand_name_key UNIQUE (name);


--
-- Name: brand brand_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);


--
-- Name: category_attribute_relation category_attribute_relation_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category_attribute_relation
    ADD CONSTRAINT category_attribute_relation_pkey PRIMARY KEY (category_id, attribute_id);


--
-- Name: category category_name_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: member_price member_price_member_level_id_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.member_price
    ADD CONSTRAINT member_price_member_level_id_key UNIQUE (member_level_id);


--
-- Name: member_price member_price_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.member_price
    ADD CONSTRAINT member_price_pkey PRIMARY KEY (id);


--
-- Name: product_attribute_value product_attribute_value_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_attribute_value
    ADD CONSTRAINT product_attribute_value_pkey PRIMARY KEY (id);


--
-- Name: product_full_reduction product_full_reduction_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_full_reduction
    ADD CONSTRAINT product_full_reduction_pkey PRIMARY KEY (id);


--
-- Name: product_ladder product_ladder_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_ladder
    ADD CONSTRAINT product_ladder_pkey PRIMARY KEY (id);


--
-- Name: product product_name_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_name_key UNIQUE (name);


--
-- Name: product_operate_log product_operate_log_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_operate_log
    ADD CONSTRAINT product_operate_log_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product product_product_sn_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_product_sn_key UNIQUE (product_sn);


--
-- Name: sku_stock sku_stock_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.sku_stock
    ADD CONSTRAINT sku_stock_pkey PRIMARY KEY (id);


--
-- Name: sku_stock sku_stock_sku_code_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.sku_stock
    ADD CONSTRAINT sku_stock_sku_code_key UNIQUE (sku_code);


--
-- Name: weight_template weight_template_name_key; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.weight_template
    ADD CONSTRAINT weight_template_name_key UNIQUE (name);


--
-- Name: weight_template weight_template_pkey; Type: CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.weight_template
    ADD CONSTRAINT weight_template_pkey PRIMARY KEY (id);


--
-- Name: admin_login_log admin_login_log_pk; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_login_log
    ADD CONSTRAINT admin_login_log_pk PRIMARY KEY (id);


--
-- Name: admin_permission_relation admin_permission_relation_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_permission_relation
    ADD CONSTRAINT admin_permission_relation_pkey PRIMARY KEY (admin_id, permission_id);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- Name: admin_role_relation admin_role_relation_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_role_relation
    ADD CONSTRAINT admin_role_relation_pkey PRIMARY KEY (admin_id, role_id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: role_permission_relation permission_role_relation_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_permission_relation
    ADD CONSTRAINT permission_role_relation_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: resource_category resource_category_name_key; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.resource_category
    ADD CONSTRAINT resource_category_name_key UNIQUE (name);


--
-- Name: resource_category resource_category_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.resource_category
    ADD CONSTRAINT resource_category_pkey PRIMARY KEY (id);


--
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- Name: role_menu_relation role_menu_relation_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_menu_relation
    ADD CONSTRAINT role_menu_relation_pkey PRIMARY KEY (role_id, menu_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_resource_relation role_resource_relation_pkey; Type: CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_resource_relation
    ADD CONSTRAINT role_resource_relation_pkey PRIMARY KEY (role_id, resource_id);


--
-- Name: attribute attribute_attribute_category_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.attribute
    ADD CONSTRAINT attribute_attribute_category_id_fkey FOREIGN KEY (attribute_category_id) REFERENCES pms.attribute_category(id);


--
-- Name: category_attribute_relation category_attribute_relation_attribute_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category_attribute_relation
    ADD CONSTRAINT category_attribute_relation_attribute_id_fkey FOREIGN KEY (attribute_id) REFERENCES pms.attribute(id);


--
-- Name: category_attribute_relation category_attribute_relation_category_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category_attribute_relation
    ADD CONSTRAINT category_attribute_relation_category_id_fkey FOREIGN KEY (category_id) REFERENCES pms.category(id);


--
-- Name: category category_pid_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.category
    ADD CONSTRAINT category_pid_fkey FOREIGN KEY (parent_id) REFERENCES pms.category(id);


--
-- Name: member_price member_price_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.member_price
    ADD CONSTRAINT member_price_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: product product_attribute_category_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_attribute_category_id_fkey FOREIGN KEY (attribute_category_id) REFERENCES pms.attribute_category(id);


--
-- Name: product_attribute_value product_attribute_value_attribute_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_attribute_value
    ADD CONSTRAINT product_attribute_value_attribute_id_fkey FOREIGN KEY (attribute_id) REFERENCES pms.attribute(id);


--
-- Name: product_attribute_value product_attribute_value_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_attribute_value
    ADD CONSTRAINT product_attribute_value_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: product product_brand_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES pms.brand(id);


--
-- Name: product product_category_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES pms.category(id);


--
-- Name: product_full_reduction product_full_reduction_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_full_reduction
    ADD CONSTRAINT product_full_reduction_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: product_ladder product_ladder_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_ladder
    ADD CONSTRAINT product_ladder_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: product_operate_log product_operate_log_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product_operate_log
    ADD CONSTRAINT product_operate_log_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: product product_weight_template_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.product
    ADD CONSTRAINT product_weight_template_fkey FOREIGN KEY (weight_template_id) REFERENCES pms.weight_template(id);


--
-- Name: sku_stock sku_stock_product_id_fkey; Type: FK CONSTRAINT; Schema: pms; Owner: truongtuan
--

ALTER TABLE ONLY pms.sku_stock
    ADD CONSTRAINT sku_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES pms.product(id);


--
-- Name: admin_permission_relation admin_permission_relation_admin_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_permission_relation
    ADD CONSTRAINT admin_permission_relation_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES ums.admin(id);


--
-- Name: admin_permission_relation admin_permission_relation_permission_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_permission_relation
    ADD CONSTRAINT admin_permission_relation_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES ums.permission(id);


--
-- Name: admin_role_relation admin_role_relation_admin_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_role_relation
    ADD CONSTRAINT admin_role_relation_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES ums.admin(id);


--
-- Name: admin_role_relation admin_role_relation_role_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.admin_role_relation
    ADD CONSTRAINT admin_role_relation_role_id_fkey FOREIGN KEY (role_id) REFERENCES ums.role(id);


--
-- Name: role_permission_relation permission_role_relation_permission_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_permission_relation
    ADD CONSTRAINT permission_role_relation_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES ums.permission(id);


--
-- Name: role_permission_relation permission_role_relation_role_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_permission_relation
    ADD CONSTRAINT permission_role_relation_role_id_fkey FOREIGN KEY (role_id) REFERENCES ums.role(id);


--
-- Name: role_menu_relation role_menu_relation_menu_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_menu_relation
    ADD CONSTRAINT role_menu_relation_menu_id_fkey FOREIGN KEY (menu_id) REFERENCES ums.menu(id);


--
-- Name: role_menu_relation role_menu_relation_role_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_menu_relation
    ADD CONSTRAINT role_menu_relation_role_id_fkey FOREIGN KEY (role_id) REFERENCES ums.role(id);


--
-- Name: role_resource_relation role_resource_relation_resource_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_resource_relation
    ADD CONSTRAINT role_resource_relation_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES ums.resource(id);


--
-- Name: role_resource_relation role_resource_relation_role_id_fkey; Type: FK CONSTRAINT; Schema: ums; Owner: truongtuan
--

ALTER TABLE ONLY ums.role_resource_relation
    ADD CONSTRAINT role_resource_relation_role_id_fkey FOREIGN KEY (role_id) REFERENCES ums.role(id);


--
-- PostgreSQL database dump complete
--

