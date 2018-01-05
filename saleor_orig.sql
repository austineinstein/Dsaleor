--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO aa;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO aa;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO aa;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO aa;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO aa;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO aa;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: cart_cart; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE cart_cart (
    status character varying(32) NOT NULL,
    created timestamp with time zone NOT NULL,
    last_status_change timestamp with time zone NOT NULL,
    email character varying(254),
    token uuid NOT NULL,
    checkout_data text,
    total numeric(12,2) NOT NULL,
    quantity integer NOT NULL,
    user_id integer,
    voucher_id integer,
    CONSTRAINT cart_cart_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE cart_cart OWNER TO aa;

--
-- Name: cart_cartline; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE cart_cartline (
    id integer NOT NULL,
    quantity integer NOT NULL,
    data text NOT NULL,
    cart_id uuid NOT NULL,
    variant_id integer NOT NULL,
    CONSTRAINT cart_cartline_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE cart_cartline OWNER TO aa;

--
-- Name: cart_cartline_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE cart_cartline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cart_cartline_id_seq OWNER TO aa;

--
-- Name: cart_cartline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE cart_cartline_id_seq OWNED BY cart_cartline.id;


--
-- Name: discount_sale; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE discount_sale (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(10) NOT NULL,
    value numeric(12,2) NOT NULL
);


ALTER TABLE discount_sale OWNER TO aa;

--
-- Name: discount_sale_categories; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE discount_sale_categories (
    id integer NOT NULL,
    sale_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE discount_sale_categories OWNER TO aa;

--
-- Name: discount_sale_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE discount_sale_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE discount_sale_categories_id_seq OWNER TO aa;

--
-- Name: discount_sale_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE discount_sale_categories_id_seq OWNED BY discount_sale_categories.id;


--
-- Name: discount_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE discount_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE discount_sale_id_seq OWNER TO aa;

--
-- Name: discount_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE discount_sale_id_seq OWNED BY discount_sale.id;


--
-- Name: discount_sale_products; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE discount_sale_products (
    id integer NOT NULL,
    sale_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE discount_sale_products OWNER TO aa;

--
-- Name: discount_sale_products_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE discount_sale_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE discount_sale_products_id_seq OWNER TO aa;

--
-- Name: discount_sale_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE discount_sale_products_id_seq OWNED BY discount_sale_products.id;


--
-- Name: discount_voucher; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE discount_voucher (
    id integer NOT NULL,
    type character varying(20) NOT NULL,
    name character varying(255),
    code character varying(12) NOT NULL,
    usage_limit integer,
    used integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    discount_value_type character varying(10) NOT NULL,
    discount_value numeric(12,2) NOT NULL,
    apply_to character varying(20),
    "limit" numeric(12,2),
    category_id integer,
    product_id integer,
    CONSTRAINT discount_voucher_usage_limit_check CHECK ((usage_limit >= 0)),
    CONSTRAINT discount_voucher_used_check CHECK ((used >= 0))
);


ALTER TABLE discount_voucher OWNER TO aa;

--
-- Name: discount_voucher_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE discount_voucher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE discount_voucher_id_seq OWNER TO aa;

--
-- Name: discount_voucher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE discount_voucher_id_seq OWNED BY discount_voucher.id;


--
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_celery_results_taskresult (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    hidden boolean NOT NULL,
    meta text
);


ALTER TABLE django_celery_results_taskresult OWNER TO aa;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE django_celery_results_taskresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_celery_results_taskresult_id_seq OWNER TO aa;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE django_celery_results_taskresult_id_seq OWNED BY django_celery_results_taskresult.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO aa;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO aa;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO aa;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO aa;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_prices_openexchangerates_conversionrate; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_prices_openexchangerates_conversionrate (
    id integer NOT NULL,
    to_currency character varying(3) NOT NULL,
    rate numeric(20,12) NOT NULL,
    modified_at timestamp with time zone NOT NULL
);


ALTER TABLE django_prices_openexchangerates_conversionrate OWNER TO aa;

--
-- Name: django_prices_openexchangerates_conversionrate_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE django_prices_openexchangerates_conversionrate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_prices_openexchangerates_conversionrate_id_seq OWNER TO aa;

--
-- Name: django_prices_openexchangerates_conversionrate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE django_prices_openexchangerates_conversionrate_id_seq OWNED BY django_prices_openexchangerates_conversionrate.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO aa;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO aa;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO aa;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: impersonate_impersonationlog; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE impersonate_impersonationlog (
    id integer NOT NULL,
    session_key character varying(40) NOT NULL,
    session_started_at timestamp with time zone,
    session_ended_at timestamp with time zone,
    impersonating_id integer NOT NULL,
    impersonator_id integer NOT NULL
);


ALTER TABLE impersonate_impersonationlog OWNER TO aa;

--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE impersonate_impersonationlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE impersonate_impersonationlog_id_seq OWNER TO aa;

--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE impersonate_impersonationlog_id_seq OWNED BY impersonate_impersonationlog.id;


--
-- Name: order_deliverygroup; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_deliverygroup (
    id integer NOT NULL,
    status character varying(32) NOT NULL,
    shipping_price numeric(12,4) NOT NULL,
    order_id integer NOT NULL,
    last_updated timestamp with time zone,
    tracking_number character varying(255) NOT NULL,
    shipping_method_name character varying(255)
);


ALTER TABLE order_deliverygroup OWNER TO aa;

--
-- Name: order_deliverygroup_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_deliverygroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_deliverygroup_id_seq OWNER TO aa;

--
-- Name: order_deliverygroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_deliverygroup_id_seq OWNED BY order_deliverygroup.id;


--
-- Name: order_order; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_order (
    id integer NOT NULL,
    status character varying(32) NOT NULL,
    created timestamp with time zone NOT NULL,
    last_status_change timestamp with time zone NOT NULL,
    tracking_client_id character varying(36) NOT NULL,
    user_email character varying(254) NOT NULL,
    token character varying(36) NOT NULL,
    billing_address_id integer NOT NULL,
    shipping_address_id integer,
    user_id integer,
    total_net numeric(12,2),
    total_tax numeric(12,2),
    discount_amount numeric(12,2),
    discount_name character varying(255) NOT NULL,
    voucher_id integer,
    language_code character varying(35) NOT NULL
);


ALTER TABLE order_order OWNER TO aa;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_order_id_seq OWNER TO aa;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_order_id_seq OWNED BY order_order.id;


--
-- Name: order_orderline; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_orderline (
    id integer NOT NULL,
    product_name character varying(128) NOT NULL,
    product_sku character varying(32) NOT NULL,
    quantity integer NOT NULL,
    unit_price_net numeric(12,4) NOT NULL,
    unit_price_gross numeric(12,4) NOT NULL,
    delivery_group_id integer NOT NULL,
    product_id integer,
    stock_id integer,
    stock_location character varying(100) NOT NULL
);


ALTER TABLE order_orderline OWNER TO aa;

--
-- Name: order_ordereditem_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_ordereditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_ordereditem_id_seq OWNER TO aa;

--
-- Name: order_ordereditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_ordereditem_id_seq OWNED BY order_orderline.id;


--
-- Name: order_orderhistoryentry; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_orderhistoryentry (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    status character varying(32) NOT NULL,
    comment character varying(100) NOT NULL,
    order_id integer NOT NULL,
    user_id integer
);


ALTER TABLE order_orderhistoryentry OWNER TO aa;

--
-- Name: order_orderhistoryentry_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_orderhistoryentry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_orderhistoryentry_id_seq OWNER TO aa;

--
-- Name: order_orderhistoryentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_orderhistoryentry_id_seq OWNED BY order_orderhistoryentry.id;


--
-- Name: order_ordernote; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_ordernote (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    content character varying(250) NOT NULL,
    order_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE order_ordernote OWNER TO aa;

--
-- Name: order_ordernote_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_ordernote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_ordernote_id_seq OWNER TO aa;

--
-- Name: order_ordernote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_ordernote_id_seq OWNED BY order_ordernote.id;


--
-- Name: order_payment; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE order_payment (
    id integer NOT NULL,
    variant character varying(255) NOT NULL,
    status character varying(10) NOT NULL,
    fraud_status character varying(10) NOT NULL,
    fraud_message text NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    transaction_id character varying(255) NOT NULL,
    currency character varying(10) NOT NULL,
    total numeric(9,2) NOT NULL,
    delivery numeric(9,2) NOT NULL,
    tax numeric(9,2) NOT NULL,
    description text NOT NULL,
    billing_first_name character varying(256) NOT NULL,
    billing_last_name character varying(256) NOT NULL,
    billing_address_1 character varying(256) NOT NULL,
    billing_address_2 character varying(256) NOT NULL,
    billing_city character varying(256) NOT NULL,
    billing_postcode character varying(256) NOT NULL,
    billing_country_code character varying(2) NOT NULL,
    billing_country_area character varying(256) NOT NULL,
    billing_email character varying(254) NOT NULL,
    customer_ip_address inet,
    extra_data text NOT NULL,
    message text NOT NULL,
    token character varying(36) NOT NULL,
    captured_amount numeric(9,2) NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE order_payment OWNER TO aa;

--
-- Name: order_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE order_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_payment_id_seq OWNER TO aa;

--
-- Name: order_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE order_payment_id_seq OWNED BY order_payment.id;


--
-- Name: product_attributechoicevalue; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_attributechoicevalue (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(7) NOT NULL,
    attribute_id integer NOT NULL,
    slug character varying(50) NOT NULL
);


ALTER TABLE product_attributechoicevalue OWNER TO aa;

--
-- Name: product_attributechoicevalue_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_attributechoicevalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_attributechoicevalue_id_seq OWNER TO aa;

--
-- Name: product_attributechoicevalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_attributechoicevalue_id_seq OWNED BY product_attributechoicevalue.id;


--
-- Name: product_category; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_category (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    slug character varying(50) NOT NULL,
    description text NOT NULL,
    hidden boolean NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT product_category_level_check CHECK ((level >= 0)),
    CONSTRAINT product_category_lft_check CHECK ((lft >= 0)),
    CONSTRAINT product_category_rght_check CHECK ((rght >= 0)),
    CONSTRAINT product_category_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE product_category OWNER TO aa;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_category_id_seq OWNER TO aa;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_category_id_seq OWNED BY product_category.id;


--
-- Name: product_product; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_product (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL,
    price numeric(12,2) NOT NULL,
    available_on date,
    updated_at timestamp with time zone,
    product_class_id integer NOT NULL,
    attributes hstore NOT NULL,
    is_featured boolean NOT NULL,
    is_published boolean NOT NULL
);


ALTER TABLE product_product OWNER TO aa;

--
-- Name: product_product_categories; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_product_categories (
    id integer NOT NULL,
    product_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE product_product_categories OWNER TO aa;

--
-- Name: product_product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_product_categories_id_seq OWNER TO aa;

--
-- Name: product_product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_product_categories_id_seq OWNED BY product_product_categories.id;


--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_product_id_seq OWNER TO aa;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_product_id_seq OWNED BY product_product.id;


--
-- Name: product_productattribute; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productattribute (
    id integer NOT NULL,
    slug character varying(50) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE product_productattribute OWNER TO aa;

--
-- Name: product_productattribute_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productattribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productattribute_id_seq OWNER TO aa;

--
-- Name: product_productattribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productattribute_id_seq OWNED BY product_productattribute.id;


--
-- Name: product_productclass; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productclass (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    has_variants boolean NOT NULL,
    is_shipping_required boolean NOT NULL
);


ALTER TABLE product_productclass OWNER TO aa;

--
-- Name: product_productclass_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productclass_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productclass_id_seq OWNER TO aa;

--
-- Name: product_productclass_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productclass_id_seq OWNED BY product_productclass.id;


--
-- Name: product_productclass_product_attributes; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productclass_product_attributes (
    id integer NOT NULL,
    productclass_id integer NOT NULL,
    productattribute_id integer NOT NULL
);


ALTER TABLE product_productclass_product_attributes OWNER TO aa;

--
-- Name: product_productclass_product_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productclass_product_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productclass_product_attributes_id_seq OWNER TO aa;

--
-- Name: product_productclass_product_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productclass_product_attributes_id_seq OWNED BY product_productclass_product_attributes.id;


--
-- Name: product_productclass_variant_attributes; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productclass_variant_attributes (
    id integer NOT NULL,
    productclass_id integer NOT NULL,
    productattribute_id integer NOT NULL
);


ALTER TABLE product_productclass_variant_attributes OWNER TO aa;

--
-- Name: product_productclass_variant_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productclass_variant_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productclass_variant_attributes_id_seq OWNER TO aa;

--
-- Name: product_productclass_variant_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productclass_variant_attributes_id_seq OWNED BY product_productclass_variant_attributes.id;


--
-- Name: product_productimage; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productimage (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    ppoi character varying(20) NOT NULL,
    alt character varying(128) NOT NULL,
    "order" integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT product_productimage_order_check CHECK (("order" >= 0))
);


ALTER TABLE product_productimage OWNER TO aa;

--
-- Name: product_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productimage_id_seq OWNER TO aa;

--
-- Name: product_productimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productimage_id_seq OWNED BY product_productimage.id;


--
-- Name: product_productvariant; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_productvariant (
    id integer NOT NULL,
    sku character varying(32) NOT NULL,
    name character varying(100) NOT NULL,
    price_override numeric(12,2),
    product_id integer NOT NULL,
    attributes hstore NOT NULL
);


ALTER TABLE product_productvariant OWNER TO aa;

--
-- Name: product_productvariant_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_productvariant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_productvariant_id_seq OWNER TO aa;

--
-- Name: product_productvariant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_productvariant_id_seq OWNED BY product_productvariant.id;


--
-- Name: product_stock; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_stock (
    id integer NOT NULL,
    quantity integer NOT NULL,
    cost_price numeric(12,2),
    variant_id integer NOT NULL,
    quantity_allocated integer NOT NULL,
    location_id integer
);


ALTER TABLE product_stock OWNER TO aa;

--
-- Name: product_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_stock_id_seq OWNER TO aa;

--
-- Name: product_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_stock_id_seq OWNED BY product_stock.id;


--
-- Name: product_stocklocation; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_stocklocation (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE product_stocklocation OWNER TO aa;

--
-- Name: product_stocklocation_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_stocklocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_stocklocation_id_seq OWNER TO aa;

--
-- Name: product_stocklocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_stocklocation_id_seq OWNED BY product_stocklocation.id;


--
-- Name: product_variantimage; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE product_variantimage (
    id integer NOT NULL,
    image_id integer NOT NULL,
    variant_id integer NOT NULL
);


ALTER TABLE product_variantimage OWNER TO aa;

--
-- Name: product_variantimage_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE product_variantimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_variantimage_id_seq OWNER TO aa;

--
-- Name: product_variantimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE product_variantimage_id_seq OWNED BY product_variantimage.id;


--
-- Name: shipping_shippingmethod; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE shipping_shippingmethod (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);


ALTER TABLE shipping_shippingmethod OWNER TO aa;

--
-- Name: shipping_shippingmethod_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE shipping_shippingmethod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shipping_shippingmethod_id_seq OWNER TO aa;

--
-- Name: shipping_shippingmethod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE shipping_shippingmethod_id_seq OWNED BY shipping_shippingmethod.id;


--
-- Name: shipping_shippingmethodcountry; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE shipping_shippingmethodcountry (
    id integer NOT NULL,
    country_code character varying(2) NOT NULL,
    price numeric(12,2) NOT NULL,
    shipping_method_id integer NOT NULL
);


ALTER TABLE shipping_shippingmethodcountry OWNER TO aa;

--
-- Name: shipping_shippingmethodcountry_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE shipping_shippingmethodcountry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shipping_shippingmethodcountry_id_seq OWNER TO aa;

--
-- Name: shipping_shippingmethodcountry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE shipping_shippingmethodcountry_id_seq OWNED BY shipping_shippingmethodcountry.id;


--
-- Name: site_authorizationkey; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE site_authorizationkey (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    key text NOT NULL,
    password text NOT NULL,
    site_settings_id integer NOT NULL
);


ALTER TABLE site_authorizationkey OWNER TO aa;

--
-- Name: site_authorizationkey_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE site_authorizationkey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE site_authorizationkey_id_seq OWNER TO aa;

--
-- Name: site_authorizationkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE site_authorizationkey_id_seq OWNED BY site_authorizationkey.id;


--
-- Name: site_sitesettings; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE site_sitesettings (
    id integer NOT NULL,
    header_text character varying(200) NOT NULL,
    description character varying(500) NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE site_sitesettings OWNER TO aa;

--
-- Name: site_sitesettings_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE site_sitesettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE site_sitesettings_id_seq OWNER TO aa;

--
-- Name: site_sitesettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE site_sitesettings_id_seq OWNED BY site_sitesettings.id;


--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE social_auth_association (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE social_auth_association OWNER TO aa;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE social_auth_association_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE social_auth_association_id_seq OWNER TO aa;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE social_auth_association_id_seq OWNED BY social_auth_association.id;


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE social_auth_code (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE social_auth_code OWNER TO aa;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE social_auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE social_auth_code_id_seq OWNER TO aa;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE social_auth_code_id_seq OWNED BY social_auth_code.id;


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE social_auth_nonce (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE social_auth_nonce OWNER TO aa;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE social_auth_nonce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE social_auth_nonce_id_seq OWNER TO aa;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE social_auth_nonce_id_seq OWNED BY social_auth_nonce.id;


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE social_auth_partial (
    id integer NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    data text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE social_auth_partial OWNER TO aa;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE social_auth_partial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE social_auth_partial_id_seq OWNER TO aa;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE social_auth_partial_id_seq OWNED BY social_auth_partial.id;


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE social_auth_usersocialauth (
    id integer NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE social_auth_usersocialauth OWNER TO aa;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE social_auth_usersocialauth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE social_auth_usersocialauth_id_seq OWNER TO aa;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE social_auth_usersocialauth_id_seq OWNED BY social_auth_usersocialauth.id;


--
-- Name: userprofile_address; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE userprofile_address (
    id integer NOT NULL,
    first_name character varying(256) NOT NULL,
    last_name character varying(256) NOT NULL,
    company_name character varying(256) NOT NULL,
    street_address_1 character varying(256) NOT NULL,
    street_address_2 character varying(256) NOT NULL,
    city character varying(256) NOT NULL,
    postal_code character varying(20) NOT NULL,
    country character varying(2) NOT NULL,
    country_area character varying(128) NOT NULL,
    phone character varying(128) NOT NULL,
    city_area character varying(128) NOT NULL
);


ALTER TABLE userprofile_address OWNER TO aa;

--
-- Name: userprofile_address_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE userprofile_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userprofile_address_id_seq OWNER TO aa;

--
-- Name: userprofile_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE userprofile_address_id_seq OWNED BY userprofile_address.id;


--
-- Name: userprofile_user; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE userprofile_user (
    id integer NOT NULL,
    is_superuser boolean NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    password character varying(128) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    default_billing_address_id integer,
    default_shipping_address_id integer
);


ALTER TABLE userprofile_user OWNER TO aa;

--
-- Name: userprofile_user_addresses; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE userprofile_user_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE userprofile_user_addresses OWNER TO aa;

--
-- Name: userprofile_user_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE userprofile_user_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userprofile_user_addresses_id_seq OWNER TO aa;

--
-- Name: userprofile_user_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE userprofile_user_addresses_id_seq OWNED BY userprofile_user_addresses.id;


--
-- Name: userprofile_user_groups; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE userprofile_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE userprofile_user_groups OWNER TO aa;

--
-- Name: userprofile_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE userprofile_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userprofile_user_groups_id_seq OWNER TO aa;

--
-- Name: userprofile_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE userprofile_user_groups_id_seq OWNED BY userprofile_user_groups.id;


--
-- Name: userprofile_user_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE userprofile_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userprofile_user_id_seq OWNER TO aa;

--
-- Name: userprofile_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE userprofile_user_id_seq OWNED BY userprofile_user.id;


--
-- Name: userprofile_user_user_permissions; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE userprofile_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE userprofile_user_user_permissions OWNER TO aa;

--
-- Name: userprofile_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: aa
--

CREATE SEQUENCE userprofile_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userprofile_user_user_permissions_id_seq OWNER TO aa;

--
-- Name: userprofile_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: aa
--

ALTER SEQUENCE userprofile_user_user_permissions_id_seq OWNED BY userprofile_user_user_permissions.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: cart_cartline id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cartline ALTER COLUMN id SET DEFAULT nextval('cart_cartline_id_seq'::regclass);


--
-- Name: discount_sale id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale ALTER COLUMN id SET DEFAULT nextval('discount_sale_id_seq'::regclass);


--
-- Name: discount_sale_categories id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_categories ALTER COLUMN id SET DEFAULT nextval('discount_sale_categories_id_seq'::regclass);


--
-- Name: discount_sale_products id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_products ALTER COLUMN id SET DEFAULT nextval('discount_sale_products_id_seq'::regclass);


--
-- Name: discount_voucher id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_voucher ALTER COLUMN id SET DEFAULT nextval('discount_voucher_id_seq'::regclass);


--
-- Name: django_celery_results_taskresult id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_celery_results_taskresult ALTER COLUMN id SET DEFAULT nextval('django_celery_results_taskresult_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: django_prices_openexchangerates_conversionrate id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_prices_openexchangerates_conversionrate ALTER COLUMN id SET DEFAULT nextval('django_prices_openexchangerates_conversionrate_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: impersonate_impersonationlog id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY impersonate_impersonationlog ALTER COLUMN id SET DEFAULT nextval('impersonate_impersonationlog_id_seq'::regclass);


--
-- Name: order_deliverygroup id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_deliverygroup ALTER COLUMN id SET DEFAULT nextval('order_deliverygroup_id_seq'::regclass);


--
-- Name: order_order id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order ALTER COLUMN id SET DEFAULT nextval('order_order_id_seq'::regclass);


--
-- Name: order_orderhistoryentry id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderhistoryentry ALTER COLUMN id SET DEFAULT nextval('order_orderhistoryentry_id_seq'::regclass);


--
-- Name: order_orderline id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderline ALTER COLUMN id SET DEFAULT nextval('order_ordereditem_id_seq'::regclass);


--
-- Name: order_ordernote id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote ALTER COLUMN id SET DEFAULT nextval('order_ordernote_id_seq'::regclass);


--
-- Name: order_payment id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_payment ALTER COLUMN id SET DEFAULT nextval('order_payment_id_seq'::regclass);


--
-- Name: product_attributechoicevalue id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_attributechoicevalue ALTER COLUMN id SET DEFAULT nextval('product_attributechoicevalue_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_category ALTER COLUMN id SET DEFAULT nextval('product_category_id_seq'::regclass);


--
-- Name: product_product id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product ALTER COLUMN id SET DEFAULT nextval('product_product_id_seq'::regclass);


--
-- Name: product_product_categories id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product_categories ALTER COLUMN id SET DEFAULT nextval('product_product_categories_id_seq'::regclass);


--
-- Name: product_productattribute id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productattribute ALTER COLUMN id SET DEFAULT nextval('product_productattribute_id_seq'::regclass);


--
-- Name: product_productclass id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass ALTER COLUMN id SET DEFAULT nextval('product_productclass_id_seq'::regclass);


--
-- Name: product_productclass_product_attributes id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_product_attributes ALTER COLUMN id SET DEFAULT nextval('product_productclass_product_attributes_id_seq'::regclass);


--
-- Name: product_productclass_variant_attributes id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_variant_attributes ALTER COLUMN id SET DEFAULT nextval('product_productclass_variant_attributes_id_seq'::regclass);


--
-- Name: product_productimage id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productimage ALTER COLUMN id SET DEFAULT nextval('product_productimage_id_seq'::regclass);


--
-- Name: product_productvariant id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productvariant ALTER COLUMN id SET DEFAULT nextval('product_productvariant_id_seq'::regclass);


--
-- Name: product_stock id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stock ALTER COLUMN id SET DEFAULT nextval('product_stock_id_seq'::regclass);


--
-- Name: product_stocklocation id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stocklocation ALTER COLUMN id SET DEFAULT nextval('product_stocklocation_id_seq'::regclass);


--
-- Name: product_variantimage id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_variantimage ALTER COLUMN id SET DEFAULT nextval('product_variantimage_id_seq'::regclass);


--
-- Name: shipping_shippingmethod id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethod ALTER COLUMN id SET DEFAULT nextval('shipping_shippingmethod_id_seq'::regclass);


--
-- Name: shipping_shippingmethodcountry id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethodcountry ALTER COLUMN id SET DEFAULT nextval('shipping_shippingmethodcountry_id_seq'::regclass);


--
-- Name: site_authorizationkey id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_authorizationkey ALTER COLUMN id SET DEFAULT nextval('site_authorizationkey_id_seq'::regclass);


--
-- Name: site_sitesettings id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_sitesettings ALTER COLUMN id SET DEFAULT nextval('site_sitesettings_id_seq'::regclass);


--
-- Name: social_auth_association id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_association ALTER COLUMN id SET DEFAULT nextval('social_auth_association_id_seq'::regclass);


--
-- Name: social_auth_code id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_code ALTER COLUMN id SET DEFAULT nextval('social_auth_code_id_seq'::regclass);


--
-- Name: social_auth_nonce id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_nonce ALTER COLUMN id SET DEFAULT nextval('social_auth_nonce_id_seq'::regclass);


--
-- Name: social_auth_partial id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_partial ALTER COLUMN id SET DEFAULT nextval('social_auth_partial_id_seq'::regclass);


--
-- Name: social_auth_usersocialauth id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_usersocialauth ALTER COLUMN id SET DEFAULT nextval('social_auth_usersocialauth_id_seq'::regclass);


--
-- Name: userprofile_address id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_address ALTER COLUMN id SET DEFAULT nextval('userprofile_address_id_seq'::regclass);


--
-- Name: userprofile_user id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user ALTER COLUMN id SET DEFAULT nextval('userprofile_user_id_seq'::regclass);


--
-- Name: userprofile_user_addresses id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_addresses ALTER COLUMN id SET DEFAULT nextval('userprofile_user_addresses_id_seq'::regclass);


--
-- Name: userprofile_user_groups id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_groups ALTER COLUMN id SET DEFAULT nextval('userprofile_user_groups_id_seq'::regclass);


--
-- Name: userprofile_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('userprofile_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY auth_group (id, name) FROM stdin;
1	Products Manager
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	51
2	1	50
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can add session	2	add_session
5	Can change session	2	change_session
6	Can delete session	2	delete_session
7	Can add site	3	add_site
8	Can change site	3	change_site
9	Can delete site	3	delete_site
10	Can add permission	4	add_permission
11	Can change permission	4	change_permission
12	Can delete permission	4	delete_permission
13	Can add group	5	add_group
14	Can change group	5	change_group
15	Can delete group	5	delete_group
16	Can add user	6	add_user
17	Can change user	6	change_user
18	Can delete user	6	delete_user
19	Can view users	6	view_user
20	Can edit users	6	edit_user
21	Can view groups	6	view_group
22	Can edit groups	6	edit_group
23	Can view staff	6	view_staff
24	Can edit staff	6	edit_staff
25	Can impersonate users	6	impersonate_user
26	Can add address	7	add_address
27	Can change address	7	change_address
28	Can delete address	7	delete_address
29	Can add sale	8	add_sale
30	Can change sale	8	change_sale
31	Can delete sale	8	delete_sale
32	Can view sales	8	view_sale
33	Can edit sales	8	edit_sale
34	Can add voucher	9	add_voucher
35	Can change voucher	9	change_voucher
36	Can delete voucher	9	delete_voucher
37	Can view vouchers	9	view_voucher
38	Can edit vouchers	9	edit_voucher
39	Can add attribute choices value	10	add_attributechoicevalue
40	Can change attribute choices value	10	change_attributechoicevalue
41	Can delete attribute choices value	10	delete_attributechoicevalue
42	Can add category	11	add_category
43	Can change category	11	change_category
44	Can delete category	11	delete_category
45	Can view categories	11	view_category
46	Can edit categories	11	edit_category
47	Can add product	12	add_product
48	Can change product	12	change_product
49	Can delete product	12	delete_product
50	Can view products	12	view_product
51	Can edit products	12	edit_product
52	Can view product properties	12	view_properties
53	Can edit product properties	12	edit_properties
54	Can add product attribute	13	add_productattribute
55	Can change product attribute	13	change_productattribute
56	Can delete product attribute	13	delete_productattribute
57	Can add product image	14	add_productimage
58	Can change product image	14	change_productimage
59	Can delete product image	14	delete_productimage
60	Can add product variant	15	add_productvariant
61	Can change product variant	15	change_productvariant
62	Can delete product variant	15	delete_productvariant
63	Can add stock	16	add_stock
64	Can change stock	16	change_stock
65	Can delete stock	16	delete_stock
66	Can add variant image	17	add_variantimage
67	Can change variant image	17	change_variantimage
68	Can delete variant image	17	delete_variantimage
69	Can add stock location	18	add_stocklocation
70	Can change stock location	18	change_stocklocation
71	Can delete stock location	18	delete_stocklocation
72	Can view stock location	18	view_stock_location
73	Can edit stock location	18	edit_stock_location
74	Can add product class	19	add_productclass
75	Can change product class	19	change_productclass
76	Can delete product class	19	delete_productclass
77	Can add Cart	20	add_cart
78	Can change Cart	20	change_cart
79	Can delete Cart	20	delete_cart
80	Can add Cart line	21	add_cartline
81	Can change Cart line	21	change_cartline
82	Can delete Cart line	21	delete_cartline
83	Can add Delivery Group	22	add_deliverygroup
84	Can change Delivery Group	22	change_deliverygroup
85	Can delete Delivery Group	22	delete_deliverygroup
86	Can add Order	23	add_order
87	Can change Order	23	change_order
88	Can delete Order	23	delete_order
89	Can view orders	23	view_order
90	Can edit orders	23	edit_order
91	Can add Ordered item	24	add_ordereditem
92	Can change Ordered item	24	change_ordereditem
93	Can delete Ordered item	24	delete_ordereditem
94	Can add Order history entry	25	add_orderhistoryentry
95	Can change Order history entry	25	change_orderhistoryentry
96	Can delete Order history entry	25	delete_orderhistoryentry
97	Can add Order note	26	add_ordernote
98	Can change Order note	26	change_ordernote
99	Can delete Order note	26	delete_ordernote
100	Can add Payment	27	add_payment
101	Can change Payment	27	change_payment
102	Can delete Payment	27	delete_payment
103	Can add shipping method	28	add_shippingmethod
104	Can change shipping method	28	change_shippingmethod
105	Can delete shipping method	28	delete_shippingmethod
106	Can view shipping method	28	view_shipping
107	Can edit shipping method	28	edit_shipping
108	Can add shipping method country	29	add_shippingmethodcountry
109	Can change shipping method country	29	change_shippingmethodcountry
110	Can delete shipping method country	29	delete_shippingmethodcountry
111	Can add site settings	30	add_sitesettings
112	Can change site settings	30	change_sitesettings
113	Can delete site settings	30	delete_sitesettings
114	Can edit site settings	30	edit_settings
115	Can view site settings	30	view_settings
116	Can add authorization key	31	add_authorizationkey
117	Can change authorization key	31	change_authorizationkey
118	Can delete authorization key	31	delete_authorizationkey
119	Can add conversion rate	32	add_conversionrate
120	Can change conversion rate	32	change_conversionrate
121	Can delete conversion rate	32	delete_conversionrate
122	Can add association	33	add_association
123	Can change association	33	change_association
124	Can delete association	33	delete_association
125	Can add code	34	add_code
126	Can change code	34	change_code
127	Can delete code	34	delete_code
128	Can add nonce	35	add_nonce
129	Can change nonce	35	change_nonce
130	Can delete nonce	35	delete_nonce
131	Can add user social auth	36	add_usersocialauth
132	Can change user social auth	36	change_usersocialauth
133	Can delete user social auth	36	delete_usersocialauth
134	Can add partial	37	add_partial
135	Can change partial	37	change_partial
136	Can delete partial	37	delete_partial
137	Can add task result	38	add_taskresult
138	Can change task result	38	change_taskresult
139	Can delete task result	38	delete_taskresult
140	Can add impersonation log	39	add_impersonationlog
141	Can change impersonation log	39	change_impersonationlog
142	Can delete impersonation log	39	delete_impersonationlog
143	Can add Ordered line	24	add_orderline
144	Can change Ordered line	24	change_orderline
145	Can delete Ordered line	24	delete_orderline
146	Can add Ordered item	40	add_ordereditem
147	Can change Ordered item	40	change_ordereditem
148	Can delete Ordered item	40	delete_ordereditem
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cart (status, created, last_status_change, email, token, checkout_data, total, quantity, user_id, voucher_id) FROM stdin;
open	2017-12-03 20:46:07.884522+00	2017-12-03 20:46:07.884593+00	\N	93a752e3-c41b-416d-aeab-ee249dc65985	\N	0.00	1	\N	\N
\.


--
-- Data for Name: cart_cartline; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cartline (id, quantity, data, cart_id, variant_id) FROM stdin;
1	1	{}	93a752e3-c41b-416d-aeab-ee249dc65985	54
\.


--
-- Data for Name: discount_sale; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_sale (id, name, type, value) FROM stdin;
1	Happy possimus day!	percentage	50.00
2	Happy veniam day!	percentage	30.00
3	Happy fugiat day!	percentage	50.00
4	Happy vero day!	percentage	20.00
5	Happy illum day!	percentage	20.00
6	Happy a day!	percentage	50.00
7	Happy expedita day!	percentage	40.00
8	Happy facere day!	percentage	30.00
9	Happy voluptas day!	percentage	40.00
10	Happy fuga day!	percentage	10.00
11	Happy incidunt day!	percentage	50.00
12	Happy minima day!	percentage	10.00
13	Happy repellendus day!	percentage	30.00
14	Happy qui day!	percentage	10.00
15	Happy ex day!	percentage	50.00
16	Happy recusandae day!	percentage	30.00
17	Happy dolorem day!	percentage	50.00
18	Happy ipsum day!	percentage	50.00
19	Happy ad day!	percentage	10.00
20	Happy debitis day!	percentage	50.00
21	Happy quia day!	percentage	50.00
22	Happy ex day!	percentage	40.00
23	Happy iure day!	percentage	10.00
24	Happy aspernatur day!	percentage	10.00
25	Happy aperiam day!	percentage	30.00
26	Happy culpa day!	percentage	20.00
27	Happy eaque day!	percentage	30.00
28	Happy quasi day!	percentage	10.00
29	Happy atque day!	percentage	20.00
30	Happy dignissimos day!	percentage	10.00
31	Happy rem day!	percentage	40.00
32	Happy eum day!	percentage	10.00
33	Happy odit day!	percentage	40.00
34	Happy occaecati day!	percentage	40.00
35	Happy corrupti day!	percentage	20.00
36	Happy veritatis day!	percentage	50.00
37	Happy tenetur day!	percentage	40.00
38	Happy maiores day!	percentage	10.00
39	Happy nulla day!	percentage	30.00
40	Happy impedit day!	percentage	30.00
41	Happy qui day!	percentage	10.00
42	Happy voluptatem day!	percentage	10.00
43	Happy placeat day!	percentage	10.00
44	Happy laudantium day!	percentage	50.00
45	Happy sapiente day!	percentage	20.00
\.


--
-- Data for Name: discount_sale_categories; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_sale_categories (id, sale_id, category_id) FROM stdin;
\.


--
-- Data for Name: discount_sale_products; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_sale_products (id, sale_id, product_id) FROM stdin;
1	1	29
2	1	5
3	1	41
4	1	25
5	2	33
6	2	24
7	2	20
8	2	22
9	3	23
10	3	10
11	3	56
12	3	39
13	4	12
14	4	27
15	4	20
16	4	1
17	5	12
18	5	29
19	5	7
20	5	35
21	6	120
22	6	66
23	6	116
24	6	18
25	7	12
26	7	63
27	7	79
28	7	50
29	8	13
30	8	23
31	8	60
32	8	6
33	9	100
34	9	85
35	9	115
36	9	70
37	10	79
38	10	107
39	10	14
40	10	93
41	11	102
42	11	129
43	11	51
44	11	119
45	12	35
46	12	111
47	12	69
48	12	24
49	13	9
50	13	46
51	13	104
52	13	146
53	14	61
54	14	40
55	14	87
56	14	2
57	15	65
58	15	47
59	15	94
60	15	41
61	16	138
62	16	227
63	16	87
64	16	192
65	17	185
66	17	65
67	17	73
68	17	139
69	18	122
70	18	119
71	18	171
72	18	100
73	19	15
74	19	11
75	19	198
76	19	60
77	20	60
78	20	161
79	20	201
80	20	210
81	21	37
82	21	273
83	21	150
84	21	146
85	22	112
86	22	151
87	22	249
88	22	171
89	23	254
90	23	267
91	23	248
92	23	43
93	24	236
94	24	220
95	24	300
96	24	101
97	25	73
98	25	174
99	25	194
100	25	181
101	26	343
102	26	326
103	26	316
104	26	266
105	27	114
106	27	35
107	27	31
108	27	301
109	28	347
110	28	29
111	28	293
112	28	172
113	29	139
114	29	220
115	29	61
116	29	336
117	30	115
118	30	136
119	30	176
120	30	349
121	31	321
122	31	398
123	31	239
124	31	262
125	32	102
126	32	55
127	32	389
128	32	210
129	33	177
130	33	341
131	33	208
132	33	5
133	34	217
134	34	176
135	34	205
136	34	139
137	35	202
138	35	394
139	35	109
140	35	266
141	36	4
142	36	236
143	36	462
144	36	121
145	37	480
146	37	297
147	37	111
148	37	224
149	38	341
150	38	37
151	38	358
152	38	134
153	39	449
154	39	68
155	39	302
156	39	335
157	40	35
158	40	206
159	40	360
160	40	214
161	41	431
162	41	101
163	41	386
164	41	242
165	42	388
166	42	83
167	42	133
168	42	111
169	43	270
170	43	158
171	43	498
172	43	331
173	44	444
174	44	196
175	44	191
176	44	143
177	45	89
178	45	68
179	45	326
180	45	146
\.


--
-- Data for Name: discount_voucher; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_voucher (id, type, name, code, usage_limit, used, start_date, end_date, discount_value_type, discount_value, apply_to, "limit", category_id, product_id) FROM stdin;
1	shipping	Free shipping	FREESHIPPING	\N	0	2017-11-22	\N	percentage	100.00	\N	\N	\N	\N
2	value	Big order discount	DISCOUNT	\N	0	2017-11-22	\N	fixed	25.00	\N	200.00	\N	\N
\.


--
-- Data for Name: django_celery_results_taskresult; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_celery_results_taskresult (id, task_id, status, content_type, content_encoding, result, date_done, traceback, hidden, meta) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	sessions	session
3	sites	site
4	auth	permission
5	auth	group
6	userprofile	user
7	userprofile	address
8	discount	sale
9	discount	voucher
10	product	attributechoicevalue
11	product	category
12	product	product
13	product	productattribute
14	product	productimage
15	product	productvariant
16	product	stock
17	product	variantimage
18	product	stocklocation
19	product	productclass
20	cart	cart
21	cart	cartline
22	order	deliverygroup
23	order	order
25	order	orderhistoryentry
26	order	ordernote
27	order	payment
28	shipping	shippingmethod
29	shipping	shippingmethodcountry
30	site	sitesettings
31	site	authorizationkey
32	django_prices_openexchangerates	conversionrate
33	social_django	association
34	social_django	code
35	social_django	nonce
36	social_django	usersocialauth
37	social_django	partial
38	django_celery_results	taskresult
39	impersonate	impersonationlog
24	order	orderline
40	order	ordereditem
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-11-22 20:16:52.971482+00
2	contenttypes	0002_remove_content_type_name	2017-11-22 20:16:53.002805+00
3	auth	0001_initial	2017-11-22 20:16:53.102428+00
4	auth	0002_alter_permission_name_max_length	2017-11-22 20:16:53.116675+00
5	auth	0003_alter_user_email_max_length	2017-11-22 20:16:53.128426+00
6	auth	0004_alter_user_username_opts	2017-11-22 20:16:53.136846+00
7	auth	0005_alter_user_last_login_null	2017-11-22 20:16:53.152932+00
8	auth	0006_require_contenttypes_0002	2017-11-22 20:16:53.155868+00
9	auth	0007_alter_validators_add_error_messages	2017-11-22 20:16:53.166512+00
10	auth	0008_alter_user_username_max_length	2017-11-22 20:16:53.178348+00
11	product	0001_initial	2017-11-22 20:16:53.403855+00
12	product	0002_auto_20150722_0545	2017-11-22 20:16:53.461172+00
13	product	0003_auto_20150820_2016	2017-11-22 20:16:53.557426+00
14	product	0003_auto_20150820_1955	2017-11-22 20:16:53.575584+00
15	product	0004_merge	2017-11-22 20:16:53.578096+00
16	product	0005_auto_20150825_1433	2017-11-22 20:16:53.657056+00
17	product	0006_product_updated_at	2017-11-22 20:16:53.687683+00
18	product	0007_auto_20160112_1025	2017-11-22 20:16:53.749082+00
19	product	0008_auto_20160114_0733	2017-11-22 20:16:53.811825+00
20	product	0009_discount_categories	2017-11-22 20:16:53.844496+00
21	product	0010_auto_20160129_0826	2017-11-22 20:16:53.889765+00
22	product	0011_stock_quantity_allocated	2017-11-22 20:16:53.916565+00
23	product	0012_auto_20160218_0812	2017-11-22 20:16:53.97484+00
24	userprofile	0001_initial	2017-11-22 20:16:54.170447+00
25	discount	0001_initial	2017-11-22 20:16:54.218193+00
26	discount	0002_voucher	2017-11-22 20:16:54.260788+00
27	discount	0003_auto_20160207_0534	2017-11-22 20:16:54.449596+00
28	cart	0001_initial	2017-11-22 20:16:54.59778+00
29	cart	0002_auto_20161014_1221	2017-11-22 20:16:54.662794+00
30	cart	fix_empty_data_in_lines	2017-11-22 20:16:54.707925+00
31	cart	0001_auto_20170113_0435	2017-11-22 20:16:54.76664+00
32	cart	0002_auto_20170206_0407	2017-11-22 20:16:55.012577+00
33	cart	0003_auto_20170906_0556	2017-11-22 20:16:55.043189+00
34	discount	0004_auto_20170206_0407	2017-11-22 20:16:55.599621+00
35	discount	0005_auto_20170919_0839	2017-11-22 20:16:55.642949+00
36	django_celery_results	0001_initial	2017-11-22 20:16:55.677825+00
37	django_prices_openexchangerates	0001_initial	2017-11-22 20:16:55.69219+00
38	django_prices_openexchangerates	0002_auto_20160329_0702	2017-11-22 20:16:55.705705+00
39	django_prices_openexchangerates	0003_auto_20161018_0707	2017-11-22 20:16:55.727473+00
40	django_prices_openexchangerates	0004_auto_20170316_0944	2017-11-22 20:16:55.735212+00
41	impersonate	0001_initial	2017-11-22 20:16:55.786561+00
42	order	0001_initial	2017-11-22 20:16:56.097237+00
43	order	0002_auto_20150820_1955	2017-11-22 20:16:56.121363+00
44	order	0003_auto_20150825_1433	2017-11-22 20:16:56.163407+00
45	order	0004_order_total	2017-11-22 20:16:56.1957+00
46	order	0005_deliverygroup_last_updated	2017-11-22 20:16:56.23341+00
47	order	0006_deliverygroup_shipping_method	2017-11-22 20:16:56.270946+00
48	order	0007_deliverygroup_tracking_number	2017-11-22 20:16:56.341352+00
49	order	0008_auto_20151026_0820	2017-11-22 20:16:56.457915+00
50	order	0009_auto_20151201_0820	2017-11-22 20:16:56.543036+00
51	order	0010_auto_20160119_0541	2017-11-22 20:16:56.634154+00
52	order	0011_auto_20160207_0534	2017-11-22 20:16:56.742451+00
53	order	0012_auto_20160216_1032	2017-11-22 20:16:56.927795+00
54	order	0013_auto_20160906_0741	2017-11-22 20:16:57.063406+00
55	order	0014_auto_20161028_0955	2017-11-22 20:16:57.086669+00
56	order	0015_auto_20170206_0407	2017-11-22 20:16:57.972158+00
57	order	0016_order_language_code	2017-11-22 20:16:58.019322+00
58	order	0017_auto_20170906_0556	2017-11-22 20:16:58.10917+00
59	order	0018_auto_20170919_0839	2017-11-22 20:16:58.22681+00
60	order	0019_auto_20171109_1423	2017-11-22 20:16:58.604674+00
61	product	0013_auto_20161207_0555	2017-11-22 20:16:58.689107+00
62	product	0014_auto_20161207_0840	2017-11-22 20:16:58.712539+00
63	product	0015_transfer_locations	2017-11-22 20:16:58.768074+00
64	product	0016_auto_20161207_0843	2017-11-22 20:16:58.798592+00
65	product	0017_remove_stock_location	2017-11-22 20:16:58.83809+00
66	product	0018_auto_20161207_0844	2017-11-22 20:16:58.906262+00
67	product	0019_auto_20161212_0230	2017-11-22 20:16:59.03841+00
68	product	0020_attribute_data_to_class	2017-11-22 20:16:59.110199+00
69	product	0021_add_hstore_extension	2017-11-22 20:16:59.229697+00
70	product	0022_auto_20161212_0301	2017-11-22 20:16:59.46364+00
71	product	0023_auto_20161211_1912	2017-11-22 20:16:59.496319+00
72	product	0024_migrate_json_data	2017-11-22 20:16:59.622025+00
73	product	0025_auto_20161219_0517	2017-11-22 20:16:59.634357+00
74	product	0026_auto_20161230_0347	2017-11-22 20:16:59.651818+00
75	product	0027_auto_20170113_0435	2017-11-22 20:16:59.746855+00
76	product	0013_auto_20161130_0608	2017-11-22 20:16:59.763321+00
77	product	0014_remove_productvariant_attributes	2017-11-22 20:16:59.786522+00
78	product	0015_productvariant_attributes	2017-11-22 20:16:59.841685+00
79	product	0016_auto_20161204_0311	2017-11-22 20:16:59.87227+00
80	product	0017_attributechoicevalue_slug	2017-11-22 20:16:59.895724+00
81	product	0018_auto_20161212_0725	2017-11-22 20:16:59.959778+00
82	product	0026_merge_20161221_0845	2017-11-22 20:16:59.962619+00
83	product	0028_merge_20170116_1016	2017-11-22 20:16:59.965267+00
84	product	0029_product_is_featured	2017-11-22 20:16:59.992562+00
85	product	0030_auto_20170206_0407	2017-11-22 20:17:00.293216+00
86	product	0031_auto_20170206_0601	2017-11-22 20:17:00.380146+00
87	product	0032_auto_20170216_0438	2017-11-22 20:17:00.40531+00
88	product	0033_auto_20170227_0757	2017-11-22 20:17:00.521928+00
89	product	0034_product_is_published	2017-11-22 20:17:00.588183+00
90	product	0035_auto_20170919_0846	2017-11-22 20:17:00.656986+00
91	product	0036_auto_20171115_0608	2017-11-22 20:17:00.692727+00
92	sessions	0001_initial	2017-11-22 20:17:00.724247+00
93	shipping	0001_initial	2017-11-22 20:17:00.814039+00
94	shipping	0002_auto_20160906_0741	2017-11-22 20:17:00.851086+00
95	shipping	0003_auto_20170116_0700	2017-11-22 20:17:00.881633+00
96	shipping	0004_auto_20170206_0407	2017-11-22 20:17:00.986637+00
97	shipping	0005_auto_20170906_0556	2017-11-22 20:17:00.995649+00
98	shipping	0006_auto_20171109_0908	2017-11-22 20:17:01.007153+00
99	sites	0001_initial	2017-11-22 20:17:01.020845+00
100	sites	0002_alter_domain_unique	2017-11-22 20:17:01.034023+00
101	site	0001_initial	2017-11-22 20:17:01.096967+00
102	site	0002_add_default_data	2017-11-22 20:17:01.190099+00
103	site	0003_sitesettings_description	2017-11-22 20:17:01.216439+00
104	site	0004_auto_20170221_0426	2017-11-22 20:17:01.248845+00
105	site	0005_auto_20170906_0556	2017-11-22 20:17:01.261951+00
106	site	0006_auto_20171025_0454	2017-11-22 20:17:01.282004+00
107	site	0007_auto_20171027_0856	2017-11-22 20:17:01.470341+00
108	site	0008_auto_20171027_0856	2017-11-22 20:17:01.510962+00
109	site	0009_auto_20171109_0849	2017-11-22 20:17:01.524249+00
110	site	0010_auto_20171113_0958	2017-11-22 20:17:01.537589+00
111	default	0001_initial	2017-11-22 20:17:01.695181+00
112	social_auth	0001_initial	2017-11-22 20:17:01.698105+00
113	default	0002_add_related_name	2017-11-22 20:17:01.756016+00
114	social_auth	0002_add_related_name	2017-11-22 20:17:01.760772+00
115	default	0003_alter_email_max_length	2017-11-22 20:17:01.778701+00
116	social_auth	0003_alter_email_max_length	2017-11-22 20:17:01.782069+00
117	default	0004_auto_20160423_0400	2017-11-22 20:17:01.823669+00
118	social_auth	0004_auto_20160423_0400	2017-11-22 20:17:01.826811+00
119	social_auth	0005_auto_20160727_2333	2017-11-22 20:17:01.841762+00
120	social_django	0006_partial	2017-11-22 20:17:01.863297+00
121	social_django	0007_code_timestamp	2017-11-22 20:17:01.893224+00
122	social_django	0008_partial_timestamp	2017-11-22 20:17:01.921347+00
123	userprofile	0002_auto_20150907_0602	2017-11-22 20:17:01.993468+00
124	userprofile	0003_auto_20151104_1102	2017-11-22 20:17:02.041089+00
125	userprofile	0004_auto_20160114_0419	2017-11-22 20:17:02.093356+00
126	userprofile	0005_auto_20160205_0651	2017-11-22 20:17:02.149707+00
127	userprofile	0006_auto_20160829_0819	2017-11-22 20:17:02.219728+00
128	userprofile	0007_auto_20161115_0940	2017-11-22 20:17:02.266829+00
129	userprofile	0008_auto_20161115_1011	2017-11-22 20:17:02.327047+00
130	userprofile	0009_auto_20170206_0407	2017-11-22 20:17:02.460329+00
131	userprofile	0010_auto_20170919_0839	2017-11-22 20:17:02.48027+00
132	userprofile	0011_auto_20171110_0552	2017-11-22 20:17:02.50407+00
133	userprofile	0012_auto_20171117_0846	2017-11-22 20:17:02.535627+00
134	social_django	0004_auto_20160423_0400	2017-11-22 20:17:02.541912+00
135	social_django	0001_initial	2017-11-22 20:17:02.544178+00
136	social_django	0003_alter_email_max_length	2017-11-22 20:17:02.546628+00
137	social_django	0005_auto_20160727_2333	2017-11-22 20:17:02.548862+00
138	social_django	0002_add_related_name	2017-11-22 20:17:02.551153+00
139	userprofile	0013_auto_20171120_0521	2017-11-27 23:08:22.644582+00
140	cart	0004_auto_20171127_1802	2017-11-28 00:02:59.580458+00
141	discount	0006_auto_20171127_1802	2017-11-28 00:02:59.623381+00
142	order	0020_auto_20171127_1802	2017-11-28 00:02:59.762357+00
143	product	0037_auto_20171127_1802	2017-11-28 00:02:59.851069+00
144	shipping	0007_auto_20171127_1802	2017-11-28 00:02:59.864703+00
145	userprofile	0014_auto_20171127_1802	2017-11-28 00:02:59.95335+00
146	cart	0004_auto_20171129_1004	2017-12-03 17:33:08.031071+00
147	discount	0006_auto_20171129_1004	2017-12-03 17:33:08.167165+00
148	order	0020_auto_20171123_0609	2017-12-03 17:33:08.312436+00
149	order	0021_auto_20171129_1004	2017-12-03 17:33:08.433882+00
150	product	0037_auto_20171124_0847	2017-12-03 17:33:08.646097+00
151	product	0038_auto_20171129_0616	2017-12-03 17:33:08.727775+00
152	product	0037_auto_20171129_1004	2017-12-03 17:33:08.830409+00
153	product	0039_merge_20171130_0727	2017-12-03 17:33:08.833545+00
154	shipping	0007_auto_20171129_1004	2017-12-03 17:33:08.848501+00
155	userprofile	0014_auto_20171129_1004	2017-12-03 17:33:08.888971+00
\.


--
-- Data for Name: django_prices_openexchangerates_conversionrate; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_prices_openexchangerates_conversionrate (id, to_currency, rate, modified_at) FROM stdin;
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_site (id, domain, name) FROM stdin;
1	localhost:8000	Saleor e-commerce
\.


--
-- Data for Name: impersonate_impersonationlog; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY impersonate_impersonationlog (id, session_key, session_started_at, session_ended_at, impersonating_id, impersonator_id) FROM stdin;
\.


--
-- Data for Name: order_deliverygroup; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_deliverygroup (id, status, shipping_price, order_id, last_updated, tracking_number, shipping_method_name) FROM stdin;
1	shipped	1.8000	1	2017-11-22 20:26:59.084378+00		DHL Rest of World
2	shipped	1.8000	2	2017-11-22 20:26:59.143473+00		DHL Rest of World
3	shipped	37.1800	3	2017-11-22 20:26:59.17857+00		UPC Rest of World
4	new	1.8000	4	2017-11-22 20:26:59.219827+00		DHL Rest of World
5	new	1.8000	5	2017-11-22 20:26:59.246442+00		DHL Rest of World
6	new	37.1800	6	2017-11-22 20:26:59.276305+00		UPC Rest of World
7	shipped	1.8000	7	2017-11-22 20:26:59.324416+00		DHL Rest of World
8	new	1.8000	8	2017-11-22 20:26:59.349366+00		DHL Rest of World
9	new	37.1800	9	2017-11-22 20:26:59.387863+00		UPC Rest of World
10	new	1.8000	10	2017-11-22 20:26:59.41689+00		DHL Rest of World
11	shipped	1.8000	11	2017-11-22 20:26:59.46494+00		DHL Rest of World
12	new	1.8000	12	2017-11-22 20:26:59.487437+00		DHL Rest of World
13	new	1.8000	13	2017-11-22 20:26:59.511785+00		DHL Rest of World
14	shipped	1.8000	14	2017-11-22 20:26:59.542636+00		DHL Rest of World
15	new	37.1800	15	2017-11-22 20:26:59.573504+00		UPC Rest of World
16	new	1.8000	16	2017-11-22 20:26:59.603375+00		DHL Rest of World
17	new	37.1800	17	2017-11-22 20:26:59.641727+00		UPC Rest of World
18	shipped	37.1800	18	2017-11-22 20:26:59.668178+00		UPC Rest of World
19	new	37.1800	19	2017-11-22 20:26:59.694087+00		UPC Rest of World
20	shipped	94.9000	20	2017-11-22 20:26:59.736541+00		DHL United States of America
21	new	76.2300	21	2017-11-27 23:21:11.071754+00		DHL Rest of World
22	new	76.2300	22	2017-11-27 23:21:11.111346+00		DHL Rest of World
23	shipped	94.9000	23	2017-11-27 23:21:11.138528+00		DHL United States of America
24	new	1.8000	24	2017-11-27 23:21:11.179607+00		DHL Rest of World
25	shipped	99.5400	25	2017-11-27 23:21:11.22058+00		UPC Rest of World
26	new	99.5400	26	2017-11-27 23:21:11.256255+00		UPC Rest of World
27	shipped	76.2300	27	2017-11-27 23:21:11.295785+00		DHL Rest of World
28	new	1.8000	28	2017-11-27 23:21:11.318674+00		DHL Rest of World
29	new	99.5400	29	2017-11-27 23:21:11.355695+00		UPC Rest of World
30	shipped	76.2300	30	2017-11-27 23:21:11.382512+00		DHL Rest of World
31	new	76.2300	31	2017-11-27 23:21:11.410836+00		DHL Rest of World
32	shipped	99.5400	32	2017-11-27 23:21:11.446583+00		UPC Rest of World
33	new	1.8000	33	2017-11-27 23:21:11.478036+00		DHL Rest of World
34	shipped	37.1800	34	2017-11-27 23:21:11.512274+00		UPC Rest of World
35	shipped	1.8000	35	2017-11-27 23:21:11.542329+00		DHL Rest of World
36	new	37.1800	36	2017-11-27 23:21:11.584495+00		UPC Rest of World
37	new	76.2300	37	2017-11-27 23:21:11.639546+00		DHL Rest of World
38	shipped	1.8000	38	2017-11-27 23:21:11.71192+00		DHL Rest of World
39	new	37.1800	39	2017-11-27 23:21:11.733708+00		UPC Rest of World
40	shipped	76.2300	40	2017-11-27 23:21:11.774987+00		DHL Rest of World
41	shipped	99.5400	41	2017-11-27 23:30:51.701016+00		UPC Rest of World
42	shipped	91.5900	42	2017-11-27 23:30:51.72859+00		UPC Rest of World
43	new	76.2300	43	2017-11-27 23:30:51.755393+00		DHL Rest of World
44	new	50.0000	44	2017-11-27 23:30:51.78341+00		DHL Rest of World
45	new	37.1800	45	2017-11-27 23:30:51.815695+00		UPC Rest of World
46	shipped	91.5900	46	2017-11-27 23:30:51.8419+00		UPC Rest of World
47	new	91.5900	47	2017-11-27 23:30:51.879266+00		UPC Rest of World
48	new	1.8000	48	2017-11-27 23:30:51.910248+00		DHL Rest of World
49	new	99.5400	49	2017-11-27 23:30:51.931628+00		UPC Rest of World
50	shipped	76.2300	50	2017-11-27 23:30:51.963189+00		DHL Rest of World
51	shipped	99.5400	51	2017-11-27 23:30:51.998317+00		UPC Rest of World
52	new	37.1800	52	2017-11-27 23:30:52.019396+00		UPC Rest of World
53	shipped	91.5900	53	2017-11-27 23:30:52.059808+00		UPC Rest of World
54	shipped	91.5900	54	2017-11-27 23:30:52.090189+00		UPC Rest of World
55	new	37.1800	55	2017-11-27 23:30:52.125161+00		UPC Rest of World
56	shipped	1.8000	56	2017-11-27 23:30:52.149813+00		DHL Rest of World
57	new	37.1800	57	2017-11-27 23:30:52.174032+00		UPC Rest of World
58	shipped	99.5400	58	2017-11-27 23:30:52.194713+00		UPC Rest of World
59	shipped	1.8000	59	2017-11-27 23:30:52.221245+00		DHL Rest of World
60	new	76.2300	60	2017-11-27 23:30:52.251963+00		DHL Rest of World
61	shipped	99.5400	61	2017-11-27 23:49:15.976699+00		UPC Rest of World
62	new	76.2300	62	2017-11-27 23:49:16.008859+00		DHL Rest of World
63	shipped	91.5900	63	2017-11-27 23:49:16.047247+00		UPC Rest of World
64	new	1.8000	64	2017-11-27 23:49:16.07284+00		DHL Rest of World
65	new	46.8500	65	2017-11-27 23:49:16.115192+00		DHL Rest of World
66	new	1.8000	66	2017-11-27 23:49:16.159429+00		DHL Rest of World
67	shipped	37.1800	67	2017-11-27 23:49:16.196435+00		UPC Rest of World
68	shipped	37.1800	68	2017-11-27 23:49:16.22855+00		UPC Rest of World
69	shipped	1.8000	69	2017-11-27 23:49:16.255538+00		DHL Rest of World
70	shipped	46.8500	70	2017-11-27 23:49:16.281734+00		DHL Rest of World
71	shipped	1.8000	71	2017-11-27 23:49:16.302591+00		DHL Rest of World
72	shipped	37.1800	72	2017-11-27 23:49:16.338165+00		UPC Rest of World
73	new	46.8500	73	2017-11-27 23:49:16.368024+00		DHL Rest of World
74	shipped	11.7000	74	2017-11-27 23:49:16.409461+00		UPC Rest of World
75	shipped	1.8000	75	2017-11-27 23:49:16.431836+00		DHL Rest of World
76	shipped	91.5900	76	2017-11-27 23:49:16.45752+00		UPC Rest of World
77	new	76.2300	77	2017-11-27 23:49:16.490229+00		DHL Rest of World
78	new	1.8000	78	2017-11-27 23:49:16.513778+00		DHL Rest of World
79	shipped	37.1800	79	2017-11-27 23:49:16.542482+00		UPC Rest of World
80	new	11.7000	80	2017-11-27 23:49:16.566079+00		UPC Rest of World
81	shipped	76.2300	81	2017-11-28 00:10:07.605729+00		DHL Rest of World
82	shipped	1.8000	82	2017-11-28 00:10:07.672427+00		DHL Rest of World
83	shipped	59.9300	83	2017-11-28 00:10:07.707824+00		DHL Rest of World
84	shipped	46.8500	84	2017-11-28 00:10:07.747844+00		DHL Rest of World
85	new	11.7000	85	2017-11-28 00:10:07.782445+00		UPC Rest of World
86	shipped	46.8500	86	2017-11-28 00:10:07.827261+00		DHL Rest of World
87	new	76.2300	87	2017-11-28 00:10:07.866974+00		DHL Rest of World
88	new	1.8000	88	2017-11-28 00:10:07.912671+00		DHL Rest of World
89	shipped	11.7000	89	2017-11-28 00:10:07.957835+00		UPC Rest of World
90	new	59.9300	90	2017-11-28 00:10:08.013449+00		DHL Rest of World
91	shipped	30.5900	91	2017-11-28 00:10:08.057378+00		UPC Rest of World
92	new	11.7000	92	2017-11-28 00:10:08.098939+00		UPC Rest of World
93	shipped	91.5900	93	2017-11-28 00:10:08.123608+00		UPC Rest of World
94	new	1.8000	94	2017-11-28 00:10:08.153882+00		DHL Rest of World
95	shipped	30.5900	95	2017-11-28 00:10:08.190143+00		UPC Rest of World
96	shipped	1.8000	96	2017-11-28 00:10:08.226178+00		DHL Rest of World
97	new	46.8500	97	2017-11-28 00:10:08.27424+00		DHL Rest of World
98	new	59.9300	98	2017-11-28 00:10:08.304778+00		DHL Rest of World
99	shipped	46.8500	99	2017-11-28 00:10:08.329709+00		DHL Rest of World
100	new	59.9300	100	2017-11-28 00:10:08.373509+00		DHL Rest of World
101	shipped	59.9300	101	2017-12-02 22:51:37.308842+00		DHL Rest of World
102	new	89.1200	102	2017-12-02 22:51:37.34927+00		UPC Rest of World
103	shipped	59.9300	103	2017-12-02 22:51:37.380967+00		DHL Rest of World
104	new	26.4300	104	2017-12-02 22:51:37.409276+00		UPC Rest of World
105	new	59.9300	105	2017-12-02 22:51:37.442758+00		DHL Rest of World
106	shipped	50.0000	106	2017-12-02 22:51:37.463734+00		DHL Rest of World
107	new	93.3100	107	2017-12-02 22:51:37.489968+00		DHL Rest of World
108	new	76.2300	108	2017-12-02 22:51:37.510941+00		DHL Rest of World
109	shipped	37.5500	109	2017-12-02 22:51:37.543348+00		DHL Rest of World
110	shipped	37.1800	110	2017-12-02 22:51:37.584315+00		UPC Rest of World
111	shipped	76.2300	111	2017-12-02 22:51:37.612211+00		DHL Rest of World
112	shipped	89.1200	112	2017-12-02 22:51:37.642115+00		UPC Rest of World
113	shipped	26.4300	113	2017-12-02 22:51:37.663056+00		UPC Rest of World
114	new	30.5900	114	2017-12-02 22:51:37.709297+00		UPC Rest of World
115	new	93.3100	115	2017-12-02 22:51:37.745772+00		DHL Rest of World
116	new	59.9300	116	2017-12-02 22:51:37.790527+00		DHL Rest of World
117	shipped	76.2300	117	2017-12-02 22:51:37.817698+00		DHL Rest of World
118	new	99.5400	118	2017-12-02 22:51:37.856824+00		UPC Rest of World
119	new	30.5900	119	2017-12-02 22:51:37.895388+00		UPC Rest of World
120	new	11.7000	120	2017-12-02 22:51:37.941551+00		UPC Rest of World
121	new	93.3100	121	2017-12-03 17:37:33.408125+00		DHL Rest of World
122	shipped	37.1800	122	2017-12-03 17:37:33.455853+00		UPC Rest of World
123	shipped	50.0000	123	2017-12-03 17:37:33.496652+00		DHL Rest of World
124	shipped	59.9300	124	2017-12-03 17:37:33.545457+00		DHL Rest of World
125	new	2.2500	125	2017-12-03 17:37:33.577013+00		UPC Rest of World
126	shipped	59.9300	126	2017-12-03 17:37:33.613035+00		DHL Rest of World
127	shipped	93.3100	127	2017-12-03 17:37:33.661914+00		DHL Rest of World
128	new	11.7000	128	2017-12-03 17:37:33.702736+00		UPC Rest of World
129	new	11.7000	129	2017-12-03 17:37:33.744127+00		UPC Rest of World
130	new	99.5400	130	2017-12-03 17:37:33.778694+00		UPC Rest of World
131	shipped	37.5500	131	2017-12-03 17:37:33.816616+00		DHL Rest of World
132	new	91.5900	132	2017-12-03 17:37:33.843846+00		UPC Rest of World
133	shipped	91.5900	133	2017-12-03 17:37:33.888321+00		UPC Rest of World
134	shipped	16.4400	134	2017-12-03 17:37:33.929437+00		DHL Rest of World
135	shipped	99.5400	135	2017-12-03 17:37:33.973126+00		UPC Rest of World
136	shipped	89.1200	136	2017-12-03 17:37:34.017888+00		UPC Rest of World
137	shipped	76.2300	137	2017-12-03 17:37:34.062144+00		DHL Rest of World
138	shipped	37.5500	138	2017-12-03 17:37:34.097059+00		DHL Rest of World
139	new	50.0000	139	2017-12-03 17:37:34.124365+00		DHL Rest of World
140	shipped	11.7000	140	2017-12-03 17:37:34.165215+00		UPC Rest of World
141	shipped	11.7000	141	2017-12-06 15:00:04.352585+00		UPC Rest of World
\.


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_order (id, status, created, last_status_change, tracking_client_id, user_email, token, billing_address_id, shipping_address_id, user_id, total_net, total_tax, discount_amount, discount_name, voucher_id, language_code) FROM stdin;
16	fully-paid	2017-11-22 20:26:59.595449+00	2017-11-22 20:26:59.595461+00		gregory.sanders@example.com	e47d281d-9081-4bf7-82e7-c63f29c1e1cc	28	28	\N	161.00	0.00	\N		\N	en-us
1	payment-pending	2017-11-22 20:26:59.072334+00	2017-11-22 20:26:59.072354+00		christian.fisher@example.com	adbdf3af-9e40-4e91-a55f-69ec07c4c1bd	21	21	\N	647.03	0.00	\N		\N	en-us
2	payment-pending	2017-11-22 20:26:59.136505+00	2017-11-22 20:26:59.136521+00		mitchell.mathis@example.com	8c6f57c3-bac7-4da2-bbad-170e2de8e8d3	22	22	\N	377.74	0.00	\N		\N	en-us
24	shipped	2017-11-27 23:21:11.172889+00	2017-11-27 23:21:11.172905+00			aec551fb-1dac-436f-a8c7-c4f65ca550c4	34	34	25	629.41	0.00	\N		\N	en-us
3	payment-pending	2017-11-22 20:26:59.171018+00	2017-11-22 20:26:59.171033+00			8e966562-ab88-4b49-b872-96b3c8fce7f0	9	9	9	293.21	0.00	\N		\N	en-us
17	payment-pending	2017-11-22 20:26:59.63404+00	2017-11-22 20:26:59.634052+00		jennifer.reeves@example.com	e21f9ad6-a04b-4b83-b3d4-caddc522d84b	29	29	\N	228.68	0.00	\N		\N	en-us
4	payment-pending	2017-11-22 20:26:59.207745+00	2017-11-22 20:26:59.207762+00		alan.casey@example.com	f3c3f681-d749-4064-90f2-b0593623abf1	23	23	\N	154.84	0.00	\N		\N	en-us
5	payment-pending	2017-11-22 20:26:59.239228+00	2017-11-22 20:26:59.239243+00			d6a9d3df-b188-4350-a12f-705d0cb4164d	10	10	10	134.46	0.00	\N		\N	en-us
31	payment-pending	2017-11-27 23:21:11.403959+00	2017-11-27 23:21:11.403976+00			f8ac2d2a-bee0-4111-8f6a-cfbb7d9d3612	12	12	12	301.53	0.00	\N		\N	en-us
6	fully-paid	2017-11-22 20:26:59.268528+00	2017-11-22 20:26:59.268544+00			1728dd87-cbbd-4d97-abf3-3573461f3f06	15	15	15	576.37	0.00	\N		\N	en-us
25	payment-pending	2017-11-27 23:21:11.21305+00	2017-11-27 23:21:11.213065+00		edward.goodwin@example.com	6f4bfb37-5b91-4a64-bbd6-984789293e99	51	51	\N	671.25	0.00	\N		\N	en-us
7	payment-pending	2017-11-22 20:26:59.317577+00	2017-11-22 20:26:59.317593+00			54fe6436-2603-4db7-8e0c-89e979b236cb	18	18	18	71.10	0.00	\N		\N	en-us
18	shipped	2017-11-22 20:26:59.660243+00	2017-11-22 20:26:59.660254+00			aa219529-6f58-40d5-a333-53682fc495ba	13	13	13	324.43	0.00	\N		\N	en-us
8	payment-pending	2017-11-22 20:26:59.341232+00	2017-11-22 20:26:59.341245+00			4e105b02-47de-48a8-8aa6-4c4b80c124b2	14	14	14	569.78	0.00	\N		\N	en-us
9	payment-pending	2017-11-22 20:26:59.380547+00	2017-11-22 20:26:59.38061+00		mandy.reynolds@example.com	8810f8fc-463f-4d5b-a487-ba36c0ed5f94	24	24	\N	251.05	0.00	\N		\N	en-us
10	fully-paid	2017-11-22 20:26:59.409158+00	2017-11-22 20:26:59.409169+00		jeffrey.peterson@example.com	5ba7f3bd-102a-4609-b879-17a28b9ad3f1	25	25	\N	377.14	0.00	\N		\N	en-us
19	fully-paid	2017-11-22 20:26:59.688716+00	2017-11-22 20:26:59.688727+00			1f0a549d-f914-4a6e-86bf-d3fc75c9098a	16	16	16	520.26	0.00	\N		\N	en-us
11	payment-pending	2017-11-22 20:26:59.457557+00	2017-11-22 20:26:59.457575+00			a52a7551-4b8c-4eb7-9274-da8ab0e3c4d1	13	13	13	162.06	0.00	\N		\N	en-us
12	payment-pending	2017-11-22 20:26:59.481528+00	2017-11-22 20:26:59.481546+00		sandy.parks@example.com	e86c637b-83a6-4818-8d0f-1cd281840548	26	26	\N	251.76	0.00	\N		\N	en-us
13	payment-pending	2017-11-22 20:26:59.505624+00	2017-11-22 20:26:59.505636+00			d43829b6-51eb-46d8-ae45-1811ef30108b	5	5	5	145.31	0.00	\N		\N	en-us
26	fully-paid	2017-11-27 23:21:11.248587+00	2017-11-27 23:21:11.248601+00			234746d5-375b-4b7a-89b3-5ac702f02d2c	12	12	12	416.36	0.00	\N		\N	en-us
14	payment-pending	2017-11-22 20:26:59.536961+00	2017-11-22 20:26:59.536974+00		david.mcgee@example.com	0facf5db-f9d8-4e4a-a8c8-3dfa29c56588	27	27	\N	245.28	0.00	\N		\N	en-us
20	fully-paid	2017-11-22 20:26:59.724752+00	2017-11-22 20:26:59.724763+00			b1329310-bcae-4a3f-9857-d8a433b57666	2	2	2	382.15	0.00	\N		\N	en-us
15	payment-pending	2017-11-22 20:26:59.566318+00	2017-11-22 20:26:59.56633+00			b48a532c-607c-442a-82b7-d2f285b6ad5e	16	16	16	218.13	0.00	\N		\N	en-us
39	fully-paid	2017-11-27 23:21:11.728837+00	2017-11-27 23:21:11.728848+00			974fe0d8-2049-48a9-8dd2-a6d3b8a07f40	35	35	26	401.79	0.00	\N		\N	en-us
27	payment-pending	2017-11-27 23:21:11.289297+00	2017-11-27 23:21:11.289313+00			31e3f14e-ce1b-43e9-9c6d-cac2ad57d90c	1	1	1	245.40	0.00	\N		\N	en-us
21	shipped	2017-11-27 23:21:11.060801+00	2017-11-27 23:21:11.060814+00			bbe1cd48-c524-4688-8b54-be6f3fe1395b	31	31	22	353.77	0.00	\N		\N	en-us
32	fully-paid	2017-11-27 23:21:11.437751+00	2017-11-27 23:21:11.437766+00			5750b0df-c15e-4250-b38f-27304b880e57	7	7	7	311.48	0.00	\N		\N	en-us
22	payment-pending	2017-11-27 23:21:11.102839+00	2017-11-27 23:21:11.102854+00		nicole.hernandez@example.com	b896eeb2-d388-475d-b5d5-d3c7963f2633	50	50	\N	533.22	0.00	\N		\N	en-us
28	fully-paid	2017-11-27 23:21:11.311989+00	2017-11-27 23:21:11.312+00		elizabeth.horne@example.com	82e8e774-79f9-45d0-9511-6ae9aefc8d4a	52	52	\N	373.70	0.00	\N		\N	en-us
23	shipped	2017-11-27 23:21:11.131697+00	2017-11-27 23:21:11.131711+00			7a71a78b-b3c3-457b-b720-2ae6415bf730	2	2	2	439.36	0.00	\N		\N	en-us
29	payment-pending	2017-11-27 23:21:11.348156+00	2017-11-27 23:21:11.348171+00		ashley.roberts@example.com	d6995824-035c-486d-9b22-5617e3bf6dcd	53	53	\N	469.18	0.00	\N		\N	en-us
33	payment-pending	2017-11-27 23:21:11.471659+00	2017-11-27 23:21:11.471676+00			f73e104c-130e-4029-b505-5b0d9825e760	36	36	27	1016.76	0.00	\N		\N	en-us
36	shipped	2017-11-27 23:21:11.578194+00	2017-11-27 23:21:11.578208+00			8405fd48-97fa-48b3-83ed-ccc3fa4c5052	1	1	1	633.68	0.00	\N		\N	en-us
30	fully-paid	2017-11-27 23:21:11.3744+00	2017-11-27 23:21:11.374415+00		richard.jimenez@example.com	c56f89dd-7ca9-4af3-954a-60ea4850d1de	54	54	\N	230.31	0.00	\N		\N	en-us
34	payment-pending	2017-11-27 23:21:11.50475+00	2017-11-27 23:21:11.504768+00		caitlin.houston@example.com	c7990588-a970-42e8-98fa-d4716bf9bc24	55	55	\N	746.52	0.00	\N		\N	en-us
43	payment-pending	2017-11-27 23:30:51.749729+00	2017-11-27 23:30:51.749739+00			af2b0729-a44a-4419-b731-d6bcb4748cc0	44	44	35	266.27	0.00	\N		\N	en-us
37	payment-pending	2017-11-27 23:21:11.617788+00	2017-11-27 23:21:11.617802+00			b3df0b38-f362-47c4-8b1d-5a9e3968c836	36	36	27	344.60	0.00	\N		\N	en-us
35	shipped	2017-11-27 23:21:11.535015+00	2017-11-27 23:21:11.535029+00			4f041e67-33cc-4e3d-b375-9313b974a318	31	31	22	375.51	0.00	\N		\N	en-us
38	payment-pending	2017-11-27 23:21:11.705306+00	2017-11-27 23:21:11.70532+00		rachel.davis@example.com	1d9b38b6-ab95-41a0-a9b2-72980821f348	56	56	\N	183.30	0.00	\N		\N	en-us
42	fully-paid	2017-11-27 23:30:51.721102+00	2017-11-27 23:30:51.721118+00		joseph.murphy@example.com	9b191776-d929-4f8b-b145-9109a8edd5ca	77	77	\N	213.19	0.00	\N		\N	en-us
40	fully-paid	2017-11-27 23:21:11.763244+00	2017-11-27 23:21:11.763255+00			108b2eaf-9602-4a86-98cc-e70cf955c6ac	18	18	18	580.97	0.00	\N		\N	en-us
41	payment-pending	2017-11-27 23:30:51.692805+00	2017-11-27 23:30:51.692818+00			618c9e71-316b-4a1a-a394-c54458271898	60	60	44	377.49	0.00	\N		\N	en-us
44	fully-paid	2017-11-27 23:30:51.775442+00	2017-11-27 23:30:51.775456+00			7a3800d4-f4c2-4842-818b-24329a4cd422	74	74	58	247.81	0.00	\N		\N	en-us
45	payment-pending	2017-11-27 23:30:51.809595+00	2017-11-27 23:30:51.809606+00			a770de67-6ac5-4fca-8f5d-c81446ba7287	31	31	22	348.06	0.00	\N		\N	en-us
46	fully-paid	2017-11-27 23:30:51.835487+00	2017-11-27 23:30:51.835501+00			7929d308-f9fe-443f-bed4-57c77a6adcfd	63	63	47	580.85	0.00	\N		\N	en-us
47	payment-pending	2017-11-27 23:30:51.871944+00	2017-11-27 23:30:51.871959+00			c35be60f-7ec6-4fa1-9f83-d9180b573df8	45	45	36	445.77	0.00	\N		\N	en-us
48	payment-pending	2017-11-27 23:30:51.904122+00	2017-11-27 23:30:51.904133+00		joe.wade@example.com	a97a7d8b-ca0e-4258-b108-0237094c20e8	78	78	\N	180.16	0.00	\N		\N	en-us
49	payment-pending	2017-11-27 23:30:51.923281+00	2017-11-27 23:30:51.923297+00		christian.waters@example.com	158d4ad6-50c2-49a3-b4ea-d407c1329e2f	79	79	\N	799.18	0.00	\N		\N	en-us
50	payment-pending	2017-11-27 23:30:51.95697+00	2017-11-27 23:30:51.956981+00		stephen.burns@example.com	cfb53919-8625-4eb3-8d1e-e03884283360	80	80	\N	833.92	0.00	\N		\N	en-us
65	fully-paid	2017-11-27 23:49:16.107819+00	2017-11-27 23:49:16.107835+00			17933418-bdfc-4018-ac6e-cd38c3727bb4	93	93	68	747.50	0.00	\N		\N	en-us
51	fully-paid	2017-11-27 23:30:51.992097+00	2017-11-27 23:30:51.992107+00			f86e4686-27dd-4738-ac56-544195bbe793	75	75	59	112.22	0.00	\N		\N	en-us
66	payment-pending	2017-11-27 23:49:16.152646+00	2017-11-27 23:49:16.152657+00		sabrina.smith@example.com	b37bfecb-35e1-4b5c-bc17-b893d73a50de	109	109	\N	725.15	0.00	\N		\N	en-us
52	shipped	2017-11-27 23:30:52.013555+00	2017-11-27 23:30:52.013565+00			b45853c7-2803-4118-9537-c6e4b3d10b44	6	6	6	619.53	0.00	\N		\N	en-us
53	payment-pending	2017-11-27 23:30:52.053683+00	2017-11-27 23:30:52.053693+00		vanessa.chapman@example.com	73f25ae0-e4e0-4551-9cfd-e648ae1dabd7	81	81	\N	654.33	0.00	\N		\N	en-us
75	shipped	2017-11-27 23:49:16.426148+00	2017-11-27 23:49:16.426158+00			375f314a-0d4d-4c66-9605-f9a487d3b8a2	90	90	65	170.91	0.00	\N		\N	en-us
82	payment-pending	2017-11-28 00:10:07.663237+00	2017-11-28 00:10:07.663297+00			22b75f2b-cbba-4059-b2f0-9ca1c6cebf59	62	62	46	614.83	0.00	\N		\N	en-us
54	shipped	2017-11-27 23:30:52.082309+00	2017-11-27 23:30:52.082324+00			8080a45f-f525-4c7e-bfc0-ebc5a66c4079	73	73	57	520.32	0.00	\N		\N	en-us
67	shipped	2017-11-27 23:49:16.189638+00	2017-11-27 23:49:16.189651+00		raymond.gomez@example.com	1109932c-4e40-44b4-8777-5325d523bac8	110	110	\N	136.50	0.00	\N		\N	en-us
55	payment-pending	2017-11-27 23:30:52.117986+00	2017-11-27 23:30:52.117997+00		ryan.watson@example.com	94847156-f6db-4d7f-b3de-4fed4304fc49	82	82	\N	147.80	0.00	\N		\N	en-us
56	payment-pending	2017-11-27 23:30:52.143199+00	2017-11-27 23:30:52.143211+00		tammy.merritt@example.com	f81f3a6c-9725-4837-8868-d0b9b0add4c0	83	83	\N	63.94	0.00	\N		\N	en-us
76	payment-pending	2017-11-27 23:49:16.452091+00	2017-11-27 23:49:16.452101+00			a84e4d17-911f-4981-8f6a-181ff29cd352	11	11	11	615.20	0.00	\N		\N	en-us
57	payment-pending	2017-11-27 23:30:52.167003+00	2017-11-27 23:30:52.167014+00		elijah.robinson@example.com	61126a94-a17d-4189-9614-473391dee7ab	84	84	\N	285.52	0.00	\N		\N	en-us
68	payment-pending	2017-11-27 23:49:16.223146+00	2017-11-27 23:49:16.223157+00			584d3855-41d3-4337-8036-61572e543acc	73	73	57	245.42	0.00	\N		\N	en-us
58	payment-pending	2017-11-27 23:30:52.189305+00	2017-11-27 23:30:52.189316+00		brittany.bradley@example.com	01a4fd5e-5823-442d-8016-518d1ee710b5	85	85	\N	418.35	0.00	\N		\N	en-us
59	fully-paid	2017-11-27 23:30:52.214958+00	2017-11-27 23:30:52.214968+00			35dc18cd-f1f1-4ca5-83bf-8e27279a15a0	72	72	56	232.66	0.00	\N		\N	en-us
69	payment-pending	2017-11-27 23:49:16.246444+00	2017-11-27 23:49:16.246455+00		kimberly.miller@example.com	358453a8-16a7-4997-a855-38a73df56193	111	111	\N	405.10	0.00	\N		\N	en-us
60	payment-pending	2017-11-27 23:30:52.24512+00	2017-11-27 23:30:52.24513+00			bf41668a-3b0e-4d86-b5a5-9204db7192b2	63	63	47	476.29	0.00	\N		\N	en-us
61	payment-pending	2017-11-27 23:49:15.966676+00	2017-11-27 23:49:15.966694+00		nicole.castro@example.com	9cc9250b-4284-449b-b705-ae5c6dc9a00a	106	106	\N	603.94	0.00	\N		\N	en-us
62	payment-pending	2017-11-27 23:49:16.001559+00	2017-11-27 23:49:16.001579+00		michael.wright@example.com	4070eb0d-4697-4d63-bb52-1da1060c359d	107	107	\N	308.11	0.00	\N		\N	en-us
70	payment-pending	2017-11-27 23:49:16.27414+00	2017-11-27 23:49:16.274151+00		kenneth.duran@example.com	b8de6e42-96ef-4eee-b511-8d0f07d54745	112	112	\N	86.60	0.00	\N		\N	en-us
63	payment-pending	2017-11-27 23:49:16.039381+00	2017-11-27 23:49:16.039397+00			df233c1f-8e01-41d8-8674-6254a7e098f9	10	10	10	96.03	0.00	\N		\N	en-us
64	payment-pending	2017-11-27 23:49:16.063848+00	2017-11-27 23:49:16.063863+00		lisa.browning@example.com	c0061ab7-2c5f-41a5-9449-b282c3f2090a	108	108	\N	420.03	0.00	\N		\N	en-us
77	payment-pending	2017-11-27 23:49:16.484242+00	2017-11-27 23:49:16.484255+00		nicole.ramirez@example.com	82226318-e5da-404d-8778-b74affd321e6	114	114	\N	539.79	0.00	\N		\N	en-us
71	payment-pending	2017-11-27 23:49:16.294705+00	2017-11-27 23:49:16.294716+00		oscar.young@example.com	84b5c673-55a6-4243-95d6-f5e1514488d3	113	113	\N	454.86	0.00	\N		\N	en-us
89	fully-paid	2017-11-28 00:10:07.949067+00	2017-11-28 00:10:07.949081+00		kevin.jackson@example.com	18672a9c-5170-4be6-8c2f-ae248874ded7	142	142	\N	692.95	0.00	\N		\N	en-us
72	payment-pending	2017-11-27 23:49:16.329356+00	2017-11-27 23:49:16.329371+00			a5975fe9-14f7-4103-b499-cbb9f0d3c075	4	4	4	428.92	0.00	\N		\N	en-us
78	payment-pending	2017-11-27 23:49:16.50794+00	2017-11-27 23:49:16.507952+00		robin.boyle@example.com	d97fb7d2-cd1b-478f-a427-72f8d61e44a7	115	115	\N	336.40	0.00	\N		\N	en-us
73	fully-paid	2017-11-27 23:49:16.361842+00	2017-11-27 23:49:16.361852+00			596e99a6-db65-4c40-a363-1fde66228530	90	90	65	644.37	0.00	\N		\N	en-us
83	payment-pending	2017-11-28 00:10:07.700777+00	2017-11-28 00:10:07.700794+00		stephanie.cunningham@example.com	2ad58d1c-cf31-41a2-a952-f02410580bae	139	139	\N	494.53	0.00	\N		\N	en-us
74	payment-pending	2017-11-27 23:49:16.400159+00	2017-11-27 23:49:16.40017+00			a0018106-ec5c-4406-aeb8-ceb4c60c5377	44	44	35	74.56	0.00	\N		\N	en-us
79	payment-pending	2017-11-27 23:49:16.536386+00	2017-11-27 23:49:16.536398+00		juan.bartlett@example.com	5ef5130b-3552-489f-90fb-d915bbb85573	116	116	\N	340.13	0.00	\N		\N	en-us
87	payment-pending	2017-11-28 00:10:07.858251+00	2017-11-28 00:10:07.85827+00		tricia.robinson@example.com	7e1b0b82-f220-41fb-a6b7-3fa6da284207	140	140	\N	170.55	0.00	\N		\N	en-us
80	payment-pending	2017-11-27 23:49:16.560186+00	2017-11-27 23:49:16.560197+00		christopher.ryan@example.com	db95efab-dad8-483b-a655-9f634fb28ccb	117	117	\N	54.42	0.00	\N		\N	en-us
84	payment-pending	2017-11-28 00:10:07.739375+00	2017-11-28 00:10:07.73939+00			c00b256d-6a09-4fba-ba96-d1254459d82b	93	93	68	154.99	0.00	\N		\N	en-us
81	fully-paid	2017-11-28 00:10:07.594849+00	2017-11-28 00:10:07.594868+00		adam.douglas@example.com	a95f3ffd-24ff-443f-b191-206788e18a38	138	138	\N	583.11	0.00	\N		\N	en-us
85	shipped	2017-11-28 00:10:07.771992+00	2017-11-28 00:10:07.772009+00			b45fc01c-3326-4b3a-ba23-80214f0e2570	131	131	94	312.99	0.00	\N		\N	en-us
88	fully-paid	2017-11-28 00:10:07.905473+00	2017-11-28 00:10:07.905491+00		patricia.roberts@example.com	4ff4c4a6-b06e-44aa-b253-1ecf97b2c7de	141	141	\N	912.30	0.00	\N		\N	en-us
86	payment-pending	2017-11-28 00:10:07.815008+00	2017-11-28 00:10:07.815023+00			13ed14b7-8ce6-438c-bcf7-e80729dccea5	123	123	86	280.64	0.00	\N		\N	en-us
91	fully-paid	2017-11-28 00:10:08.049668+00	2017-11-28 00:10:08.049687+00			3ca051d1-2acb-4165-a722-7f2ea4d22d23	97	97	72	275.75	0.00	\N		\N	en-us
90	fully-paid	2017-11-28 00:10:08.003761+00	2017-11-28 00:10:08.003776+00			6547a955-d2ee-40bf-a943-281c35bed009	103	103	78	211.76	0.00	\N		\N	en-us
94	fully-paid	2017-11-28 00:10:08.146592+00	2017-11-28 00:10:08.146609+00		jessica.duncan@example.com	76a0eeaf-1978-4137-a96c-571995a2a05e	143	143	\N	68.89	0.00	\N		\N	en-us
93	payment-pending	2017-11-28 00:10:08.115603+00	2017-11-28 00:10:08.115619+00			8be059a5-04cf-420e-b0e6-49af02d2c754	59	59	43	416.63	0.00	\N		\N	en-us
92	payment-pending	2017-11-28 00:10:08.090794+00	2017-11-28 00:10:08.090811+00			bbca5571-c7df-4166-b718-4b6769e92403	46	46	37	137.54	0.00	\N		\N	en-us
95	payment-pending	2017-11-28 00:10:08.183769+00	2017-11-28 00:10:08.183787+00		valerie.brooks@example.com	68d56727-5452-424c-9c28-519cefdb59d0	144	144	\N	571.99	0.00	\N		\N	en-us
97	fully-paid	2017-11-28 00:10:08.267177+00	2017-11-28 00:10:08.26719+00			6b025b40-7014-45fc-986c-df62e3bc0936	86	86	61	187.98	0.00	\N		\N	en-us
96	shipped	2017-11-28 00:10:08.219957+00	2017-11-28 00:10:08.219969+00			ad6351e9-4bd6-4fb5-a785-5c6fd4cc3160	89	89	64	200.77	0.00	\N		\N	en-us
98	payment-pending	2017-11-28 00:10:08.296715+00	2017-11-28 00:10:08.296732+00			07300f1d-f5a2-48c1-a46e-4c188c0f2cd3	17	17	17	222.67	0.00	\N		\N	en-us
99	fully-paid	2017-11-28 00:10:08.321522+00	2017-11-28 00:10:08.321539+00		rebecca.andrade@example.com	d353b8cc-5957-42a0-8cd4-697e10fd62eb	145	145	\N	243.06	0.00	\N		\N	en-us
124	payment-pending	2017-12-03 17:37:33.535787+00	2017-12-03 17:37:33.535804+00		rachael.garcia@example.com	dd525f88-67b9-42f5-9f07-e97393217eea	213	213	\N	434.85	0.00	\N		\N	en-us
100	fully-paid	2017-11-28 00:10:08.365728+00	2017-11-28 00:10:08.365739+00			1e5ffe3c-8f3b-424f-87a3-69e1ceac8efa	90	90	65	689.04	0.00	\N		\N	en-us
115	payment-pending	2017-12-02 22:51:37.737397+00	2017-12-02 22:51:37.737414+00		amanda.taylor@example.com	9b4afb32-ba36-4031-a63c-562b4ec2893b	186	186	\N	439.17	0.00	\N		\N	en-us
101	payment-pending	2017-12-02 22:51:37.292331+00	2017-12-02 22:51:37.292352+00			03d82afb-f8ba-4451-8bbf-6301b6185a3e	175	175	130	227.83	0.00	\N		\N	en-us
102	payment-pending	2017-12-02 22:51:37.343569+00	2017-12-02 22:51:37.34358+00		michael.black@example.com	d99e684a-5906-4fc6-86d1-b1e41adb5792	179	179	\N	180.21	0.00	\N		\N	en-us
116	payment-pending	2017-12-02 22:51:37.781379+00	2017-12-02 22:51:37.781394+00		david.little@example.com	586b163e-a5b3-4fa2-883b-39e5ed62b5ea	187	187	\N	62.03	0.00	\N		\N	en-us
103	shipped	2017-12-02 22:51:37.373436+00	2017-12-02 22:51:37.373448+00		karen.carr@example.com	9fc3fa16-eacc-4d12-9d34-6fa9e10ce720	180	180	\N	240.59	0.00	\N		\N	en-us
104	payment-pending	2017-12-02 22:51:37.401906+00	2017-12-02 22:51:37.401916+00			93bbec2f-2c19-4151-ac03-27a6a590f64d	130	130	93	270.41	0.00	\N		\N	en-us
135	shipped	2017-12-03 17:37:33.964026+00	2017-12-03 17:37:33.964041+00			53eb2691-29da-4a73-bcd1-9253a913e6eb	41	41	32	208.29	0.00	\N		\N	en-us
105	payment-pending	2017-12-02 22:51:37.433559+00	2017-12-02 22:51:37.433571+00		donald.rodriguez@example.com	340e53fe-a8ac-4338-ad75-2f5f05116668	181	181	\N	283.34	0.00	\N		\N	en-us
125	fully-paid	2017-12-03 17:37:33.570114+00	2017-12-03 17:37:33.57013+00		dawn.harper@example.com	43b549f6-12b0-4f92-8f40-dd71de98b488	214	214	\N	185.43	0.00	\N		\N	en-us
106	payment-pending	2017-12-02 22:51:37.458057+00	2017-12-02 22:51:37.458069+00		maria.winters@example.com	4da41ed8-c6ba-457e-9250-8b99ee628cde	182	182	\N	107.14	0.00	\N		\N	en-us
117	shipped	2017-12-02 22:51:37.808139+00	2017-12-02 22:51:37.808156+00		christy.acosta@example.com	0923b6bf-8e30-4831-92bb-17982e71ddc0	188	188	\N	230.97	0.00	\N		\N	en-us
107	payment-pending	2017-12-02 22:51:37.482188+00	2017-12-02 22:51:37.482199+00			48b7e02c-8805-41a6-9bc7-9bb4a81dbafb	135	135	98	112.83	0.00	\N		\N	en-us
108	payment-pending	2017-12-02 22:51:37.504925+00	2017-12-02 22:51:37.504943+00		ryan.white@example.com	bc0c1dfc-8190-4eef-81f4-d8325acd5e5e	183	183	\N	530.36	0.00	\N		\N	en-us
109	payment-pending	2017-12-02 22:51:37.533326+00	2017-12-02 22:51:37.533337+00			e400045c-8f79-4ebb-bc17-c718d496828e	165	165	120	245.46	0.00	\N		\N	en-us
131	payment-pending	2017-12-03 17:37:33.808715+00	2017-12-03 17:37:33.80873+00			7c83410a-1085-4f35-a82e-a8dbe60042d0	124	124	87	318.59	0.00	\N		\N	en-us
110	payment-pending	2017-12-02 22:51:37.576534+00	2017-12-02 22:51:37.576551+00		andrea.hayden@example.com	7d205b93-72f3-488b-b4ba-7c79f3e11b54	184	184	\N	116.45	0.00	\N		\N	en-us
118	fully-paid	2017-12-02 22:51:37.842551+00	2017-12-02 22:51:37.842566+00			b7e83cc5-97a0-447a-a158-2bd39f124509	90	90	65	217.90	0.00	\N		\N	en-us
111	fully-paid	2017-12-02 22:51:37.603898+00	2017-12-02 22:51:37.603916+00			9e805a62-6150-4df4-ae21-a5365670d04a	122	122	85	120.33	0.00	\N		\N	en-us
126	payment-pending	2017-12-03 17:37:33.605405+00	2017-12-03 17:37:33.605421+00		eric.crawford@example.com	188fce43-f85a-4c06-98bc-40b30c31a3f4	215	215	\N	600.23	0.00	\N		\N	en-us
112	payment-pending	2017-12-02 22:51:37.63471+00	2017-12-02 22:51:37.634726+00		frank.gray@example.com	52ac76d5-12a1-496d-8296-26598b1f4ff1	185	185	\N	151.68	0.00	\N		\N	en-us
119	fully-paid	2017-12-02 22:51:37.887847+00	2017-12-02 22:51:37.887863+00		hayley.clark@example.com	fd5dbfe5-1886-4acd-991b-4dedae8ac3dc	189	189	\N	502.33	0.00	\N		\N	en-us
113	fully-paid	2017-12-02 22:51:37.657181+00	2017-12-02 22:51:37.657192+00			ab2e9605-1a9d-4b41-b338-f75256e65f00	164	164	119	381.59	0.00	\N		\N	en-us
114	payment-pending	2017-12-02 22:51:37.701803+00	2017-12-02 22:51:37.701818+00			73cbd396-fbf3-4897-989e-f632bd491fd4	127	127	90	389.79	0.00	\N		\N	en-us
120	payment-pending	2017-12-02 22:51:37.933377+00	2017-12-02 22:51:37.933393+00		rebecca.woods@example.com	2a51b8f7-daa9-4dc4-bc70-8e32c9690c78	190	190	\N	393.55	0.00	\N		\N	en-us
121	payment-pending	2017-12-03 17:37:33.391412+00	2017-12-03 17:37:33.391439+00		debra.smith@example.com	eef7b7d3-d3c2-435e-a491-4fe83267b711	211	211	\N	758.79	0.00	\N		\N	en-us
132	payment-pending	2017-12-03 17:37:33.836012+00	2017-12-03 17:37:33.836024+00			b998981e-69a4-4f2e-96f7-d40285cb444f	127	127	90	463.61	0.00	\N		\N	en-us
122	payment-pending	2017-12-03 17:37:33.447668+00	2017-12-03 17:37:33.447684+00		bruce.payne@example.com	d7ef697a-2e16-4508-9483-e5b28dac9101	212	212	\N	203.17	0.00	\N		\N	en-us
127	shipped	2017-12-03 17:37:33.653434+00	2017-12-03 17:37:33.65345+00			a9af5d1b-5968-4df7-8b3b-762eeb6eb8ba	57	57	41	371.40	0.00	\N		\N	en-us
123	payment-pending	2017-12-03 17:37:33.486892+00	2017-12-03 17:37:33.48691+00			24a27b1d-c1fd-46d7-9d6d-308374b146be	123	123	86	621.40	0.00	\N		\N	en-us
128	payment-pending	2017-12-03 17:37:33.695412+00	2017-12-03 17:37:33.695427+00			72226458-cf23-4993-8a4d-0dfdbb229275	66	66	50	291.03	0.00	\N		\N	en-us
133	payment-pending	2017-12-03 17:37:33.881245+00	2017-12-03 17:37:33.881256+00		alexander.young@example.com	645965c9-f6d7-4c9a-9d85-7ec5320bb7ca	217	217	\N	722.96	0.00	\N		\N	en-us
129	fully-paid	2017-12-03 17:37:33.735372+00	2017-12-03 17:37:33.735387+00			838b4efe-49fa-4a84-b06d-21ad89935e1c	121	121	84	159.18	0.00	\N		\N	en-us
136	payment-pending	2017-12-03 17:37:34.009118+00	2017-12-03 17:37:34.009134+00			e100f3e2-a767-42f6-b052-f8247dff81b7	167	167	122	563.02	0.00	\N		\N	en-us
130	payment-pending	2017-12-03 17:37:33.771785+00	2017-12-03 17:37:33.771801+00		daniel.kelly@example.com	ad742b84-963c-4b16-b101-da4c69ff851a	216	216	\N	566.86	0.00	\N		\N	en-us
134	fully-paid	2017-12-03 17:37:33.923514+00	2017-12-03 17:37:33.923524+00			e569d8a7-1f8e-4b37-9167-44721a2ba5e2	197	197	140	238.78	0.00	\N		\N	en-us
141	payment-pending	2017-12-06 15:00:04.340174+00	2017-12-06 15:00:04.340194+00		laura.myers@example.com	c714f9c4-6a2d-44f6-abc6-8bc8e796f062	240	240	\N	\N	\N	\N		\N	en-us
137	payment-pending	2017-12-03 17:37:34.053164+00	2017-12-03 17:37:34.053183+00		erin.black@example.com	cf67d8bd-0516-4d64-a8bf-1f2d527b94fe	218	218	\N	730.07	0.00	\N		\N	en-us
139	shipped	2017-12-03 17:37:34.116413+00	2017-12-03 17:37:34.116429+00			4e4619b6-86ee-4801-9538-dd2446f6e736	103	103	78	625.34	0.00	\N		\N	en-us
138	payment-pending	2017-12-03 17:37:34.088963+00	2017-12-03 17:37:34.088979+00			a2041579-cb68-411b-af24-d175c3ef8eab	160	160	115	78.07	0.00	\N		\N	en-us
140	payment-pending	2017-12-03 17:37:34.157982+00	2017-12-03 17:37:34.157999+00		mark.stark@example.com	9b58c6c4-2e61-4298-9b5e-fa9af626b7db	219	219	\N	376.73	0.00	\N		\N	en-us
\.


--
-- Data for Name: order_orderhistoryentry; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_orderhistoryentry (id, date, status, comment, order_id, user_id) FROM stdin;
\.


--
-- Data for Name: order_orderline; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_orderline (id, product_name, product_sku, quantity, unit_price_net, unit_price_gross, delivery_group_id, product_id, stock_id, stock_location) FROM stdin;
1	Gardner Inc	22-1340	3	1.4800	1.4800	1	22	\N	
2	Elliott, Atkinson and Reyes	59-1338	1	46.7500	46.7500	1	59	\N	
3	Adams, Petty and George	19-1337	4	96.1800	96.1800	1	19	\N	
4	Pierce Inc	26-1340	4	52.3300	52.3300	1	26	\N	
5	Conway, Hensley and Brown	42-1337	4	73.9900	73.9900	2	42	\N	
6	Holt, Moore and Kelly	14-1337	1	39.9900	39.9900	2	14	\N	
7	Holt, Moore and Kelly	14-1337	1	39.9900	39.9900	2	14	\N	
8	Thompson, White and Moore	52-1338	2	59.5000	59.5000	3	52	\N	
9	Farley and Sons	31-1339	1	79.6100	79.6100	3	31	\N	
10	Reynolds, Hayes and Freeman	17-1337	3	19.1400	19.1400	3	17	\N	
11	Brandt-Oneal	5-1342	4	38.2600	38.2600	4	5	\N	
12	Wilson Group	51-1338	3	44.2200	44.2200	5	51	\N	
13	Cooper-Johnson	44-1337	3	38.5200	38.5200	6	44	\N	
14	Burnett-White	18-1337	1	85.2100	85.2100	6	18	\N	
15	Holt, Moore and Kelly	14-1337	4	39.9900	39.9900	6	14	\N	
16	Rivera, Farmer and Tate	57-1338	2	89.2300	89.2300	6	57	\N	
17	Wilcox-Hickman	36-1339	2	34.6500	34.6500	7	36	\N	
18	Scott, Stanley and Harper	60-1338	1	82.7800	82.7800	8	60	\N	
19	Burnett-White	18-1337	4	85.2100	85.2100	8	18	\N	
20	Grant Inc	38-1339	3	17.7200	17.7200	8	38	\N	
21	Wilson Group	35-1339	3	30.4000	30.4000	8	35	\N	
22	Bell Inc	50-1337	4	29.6000	29.6000	9	50	\N	
23	Ferguson Ltd	27-1340	2	5.1300	5.1300	9	27	\N	
24	Burnett-White	18-1337	1	85.2100	85.2100	9	18	\N	
25	Scott, Stanley and Harper	60-1338	4	82.7800	82.7800	10	60	\N	
26	Wilson Group	51-1338	1	44.2200	44.2200	10	51	\N	
27	Marsh-Stephens	33-1339	2	15.1400	15.1400	11	33	\N	
28	Boyd-Wheeler	41-1337	2	64.9900	64.9900	11	41	\N	
29	James-Carter	53-1338	3	83.3200	83.3200	12	53	\N	
30	Bishop-Mclean	43-1337	1	52.3100	52.3100	13	43	\N	
31	Wilcox-Hickman	36-1339	2	34.6500	34.6500	13	36	\N	
32	Cameron PLC	8-1342	3	7.3000	7.3000	13	8	\N	
33	Edwards PLC	4-1342	4	12.6800	12.6800	14	4	\N	
34	Curry-Miller	48-1337	2	96.3800	96.3800	14	48	\N	
35	Ferguson Ltd	27-1340	3	5.1300	5.1300	15	27	\N	
36	Scott, Stanley and Harper	60-1338	2	82.7800	82.7800	15	60	\N	
37	Hodges, Jennings and Vega	2-1342	2	47.4000	47.4000	16	2	\N	
38	Edwards PLC	4-1342	4	12.6800	12.6800	16	4	\N	
39	Thornton Ltd	1-1342	1	13.6800	13.6800	16	1	\N	
40	Kelly-Cardenas	34-1339	2	95.7500	95.7500	17	34	\N	
41	Kelly-Cardenas	34-1339	3	95.7500	95.7500	18	34	\N	
42	Kelly-Cardenas	34-1339	2	95.7500	95.7500	19	34	\N	
43	Thomas PLC	55-1338	2	21.6200	21.6200	19	55	\N	
44	Scott, Stanley and Harper	60-1338	3	82.7800	82.7800	19	60	\N	
45	Kelly-Cardenas	34-1339	3	95.7500	95.7500	20	34	\N	
46	Roman-Meyer	54-1337	2	56.3700	56.3700	21	54	\N	
47	Hamilton, Taylor and Harris	101-1337	2	82.4000	82.4000	21	101	\N	
48	Summers-Riley	64-1342	3	70.0000	70.0000	22	64	\N	
49	Williams, Webb and Charles	85-1340	3	82.3300	82.3300	22	85	\N	
50	Thomas PLC	55-1337	1	21.6200	21.6200	23	55	\N	
51	Morgan, Thornton and Johnson	28-1337	4	62.5600	62.5600	23	28	\N	
52	Ross Inc	90-1340	2	36.3000	36.3000	23	90	\N	
53	Kelly-Cardenas	34-1337	2	95.7500	95.7500	24	34	\N	
54	Saunders Group	13-1337	2	98.4200	98.4200	24	13	\N	
55	Graves-Castro	39-1337	1	58.8300	58.8300	24	39	\N	
56	Thompson, Spencer and Wallace	16-1337	2	90.2200	90.2200	24	16	\N	
57	Larson PLC	115-1338	2	11.5800	11.5800	25	115	\N	
58	Suarez-Taylor	78-1337	1	40.2800	40.2800	25	78	\N	
59	Taylor, Anderson and Nelson	102-1337	3	57.4900	57.4900	25	102	\N	
60	Meyer-Hart	40-1337	4	83.9500	83.9500	25	40	\N	
61	Brandt-Oneal	5-1337	3	38.2600	38.2600	26	5	\N	
62	Walker-Summers	79-1337	3	22.6600	22.6600	26	79	\N	
63	Johnston PLC	92-1339	3	31.6800	31.6800	26	92	\N	
64	Garrett Ltd	61-1342	2	19.5100	19.5100	26	61	\N	
65	Cook and Sons	82-1340	1	5.8900	5.8900	27	82	\N	
66	Watson Group	9-1337	2	81.6400	81.6400	27	9	\N	
67	Elliott, Atkinson and Reyes	59-1337	2	46.7500	46.7500	28	59	\N	
68	Blanchard and Sons	70-1342	4	41.7500	41.7500	28	70	\N	
69	Torres-Peters	32-1337	2	55.7000	55.7000	28	32	\N	
70	Mcdonald-Thomas	108-1337	4	67.4600	67.4600	29	108	\N	
71	Miller-Dalton	47-1337	1	99.8000	99.8000	29	47	\N	
72	Cooper-Johnson	44-1337	4	38.5200	38.5200	30	44	\N	
73	Burnett-White	18-1337	1	85.2100	85.2100	31	18	\N	
74	Moore-Camacho	118-1338	4	2.9800	2.9800	31	118	\N	
75	Walker-Summers	79-1337	2	22.6600	22.6600	31	79	\N	
76	Smith, Wagner and Gomez	12-1337	1	82.8500	82.8500	31	12	\N	
77	Lowe PLC	88-1340	1	16.2800	16.2800	32	88	\N	
78	Craig Group	106-1337	2	97.8300	97.8300	32	106	\N	
79	Miller-Dalton	47-1337	4	99.8000	99.8000	33	47	\N	
80	Gray-Raymond	98-1339	4	70.6200	70.6200	33	98	\N	
81	James-Carter	53-1337	4	83.3200	83.3200	33	53	\N	
82	Burnett-White	18-1337	3	85.2100	85.2100	34	18	\N	
83	Blanchard and Sons	70-1342	4	41.7500	41.7500	34	70	\N	
84	Chavez and Sons	97-1339	3	95.5700	95.5700	34	97	\N	
85	Baker, Holmes and Farrell	116-1338	1	91.9000	91.9000	35	116	\N	
86	Tapia-Mejia	73-1337	1	67.5700	67.5700	35	73	\N	
87	Schroeder-Nash	86-1340	2	23.8000	23.8000	35	86	\N	
88	James-Carter	53-1337	2	83.3200	83.3200	35	53	\N	
89	Lowe PLC	88-1340	4	16.2800	16.2800	36	88	\N	
90	Miller-Dalton	47-1337	4	99.8000	99.8000	36	47	\N	
91	Johnston PLC	92-1339	1	31.6800	31.6800	36	92	\N	
92	Campbell-Doyle	15-1337	3	33.5000	33.5000	36	15	\N	
93	Thomas PLC	55-1337	1	21.6200	21.6200	37	55	\N	
94	Ross Inc	90-1340	2	36.3000	36.3000	37	90	\N	
95	Hamilton, Taylor and Harris	101-1337	2	82.4000	82.4000	37	101	\N	
96	York-Bradford	93-1339	1	9.3500	9.3500	37	93	\N	
97	Wilson Group	51-1337	3	44.2200	44.2200	38	51	\N	
98	Lowe PLC	88-1340	3	16.2800	16.2800	38	88	\N	
99	Rowland-Griffin	91-1339	4	52.3800	52.3800	39	91	\N	
100	Bell Inc	50-1337	4	29.6000	29.6000	39	50	\N	
101	Reyes and Sons	81-1340	1	36.6900	36.6900	39	81	\N	
102	Bullock PLC	23-1337	3	46.3800	46.3800	40	23	\N	
103	Chen, Sims and Perez	49-1337	2	38.5300	38.5300	40	49	\N	
104	Adams, Petty and George	19-1337	3	96.1800	96.1800	40	19	\N	
105	Lawson, Winters and Carroll	152-1339	2	91.1000	91.1000	41	152	\N	
106	Kelly-Cardenas	34-1339	1	95.7500	95.7500	41	34	\N	
107	Roberts-Brooks	178-1338	2	60.8000	60.8000	42	178	\N	
108	Romero, Jackson and Smith	153-1339	2	45.8500	45.8500	43	153	\N	
109	Shelton Inc	69-1337	3	32.7800	32.7800	43	69	\N	
110	Campbell-Doyle	15-1337	2	33.5000	33.5000	44	15	\N	
111	Benitez-Mcdonald	74-1337	2	19.9700	19.9700	44	74	\N	
112	Smith, French and Hamilton	96-1339	1	90.8700	90.8700	44	96	\N	
113	Moss LLC	164-1337	3	16.1600	16.1600	45	164	\N	
114	Riddle Inc	148-1340	4	65.6000	65.6000	45	148	\N	
115	Krueger, Perry and Wagner	170-1337	4	61.3900	61.3900	46	170	\N	
116	Chen, Sims and Perez	49-1337	1	38.5300	38.5300	46	49	\N	
117	Kelly-Orr	30-1340	3	44.5900	44.5900	46	30	\N	
118	Schroeder-Nash	86-1340	3	23.8000	23.8000	46	86	\N	
119	Wolf PLC	133-1337	4	19.7400	19.7400	47	133	\N	
120	Sanchez Ltd	154-1339	4	32.7600	32.7600	47	154	\N	
121	Moore-Camacho	118-1338	4	2.9800	2.9800	47	118	\N	
122	Everett Inc	162-1337	2	66.1300	66.1300	47	162	\N	
123	Kelly-Orr	30-1340	4	44.5900	44.5900	48	30	\N	
124	Gonzalez Group	83-1340	4	96.5900	96.5900	49	83	\N	
125	Sanchez Ltd	154-1339	4	32.7600	32.7600	49	154	\N	
126	Sanchez, Manning and Coleman	80-1337	4	39.6000	39.6000	49	80	\N	
127	Stark and Sons	136-1337	4	5.9600	5.9600	49	136	\N	
128	Williams, Webb and Charles	85-1340	1	82.3300	82.3300	50	85	\N	
129	Rowland-Griffin	91-1339	3	52.3800	52.3800	50	91	\N	
130	Lawson, Winters and Carroll	152-1339	3	91.1000	91.1000	50	152	\N	
131	Watson Group	9-1337	3	81.6400	81.6400	50	9	\N	
132	Edwards PLC	4-1337	1	12.6800	12.6800	51	4	\N	
133	Krueger, Perry and Wagner	170-1337	2	61.3900	61.3900	52	170	\N	
134	Moreno Ltd	179-1338	4	12.9300	12.9300	52	179	\N	
135	Marshall-Taylor	121-1342	3	68.3800	68.3800	52	121	\N	
136	Tapia-Mejia	73-1337	3	67.5700	67.5700	52	73	\N	
137	Roberts-Brooks	178-1338	3	60.8000	60.8000	53	178	\N	
138	Jackson and Sons	25-1340	3	74.4700	74.4700	53	25	\N	
139	Bishop-Mclean	43-1337	3	52.3100	52.3100	53	43	\N	
140	Chavez and Sons	97-1339	3	95.5700	95.5700	54	97	\N	
141	Jones LLC	125-1342	1	52.5900	52.5900	54	125	\N	
142	Carrillo-Wright	149-1340	3	29.8100	29.8100	54	149	\N	
143	Smith, Sanders and Wallace	120-1338	4	14.7600	14.7600	55	120	\N	
144	Davis, Bell and Camacho	6-1337	1	51.5800	51.5800	55	6	\N	
145	Davis, Bell and Camacho	6-1337	1	51.5800	51.5800	56	6	\N	
146	Golden, Moore and Waters	157-1339	1	10.5600	10.5600	56	157	\N	
147	Scott, Stanley and Harper	60-1338	3	82.7800	82.7800	57	60	\N	
148	Thomas PLC	55-1338	1	21.6200	21.6200	58	55	\N	
149	Graham-Benson	132-1337	3	78.1300	78.1300	58	132	\N	
150	Scott-Martinez	62-1337	4	15.7000	15.7000	58	62	\N	
151	Key, Leonard and Sanchez	143-1340	2	59.7300	59.7300	59	143	\N	
152	Torres-Peters	32-1339	2	55.7000	55.7000	59	32	\N	
153	Stark and Sons	136-1337	1	5.9600	5.9600	60	136	\N	
154	Baker, Holmes and Farrell	116-1338	4	91.9000	91.9000	60	116	\N	
155	Rojas Group	169-1337	2	13.2500	13.2500	60	169	\N	
156	Frye-Jones	75-1337	3	86.8000	86.8000	61	75	\N	
157	Tucker PLC	76-1337	4	61.0000	61.0000	61	76	\N	
158	Conway, Hensley and Brown	42-1337	2	73.9900	73.9900	62	42	\N	
159	Hubbard and Sons	183-1342	1	83.6800	83.6800	62	183	\N	
160	Arroyo PLC	110-1337	1	0.2200	0.2200	62	110	\N	
161	Gardner Inc	22-1340	3	1.4800	1.4800	63	22	\N	
162	Roman-Meyer	54-1338	4	56.3700	56.3700	64	54	\N	
163	Brandt-Oneal	5-1342	1	38.2600	38.2600	64	5	\N	
164	Reyes and Sons	81-1340	2	36.6900	36.6900	64	81	\N	
165	Carter Inc	226-1337	1	81.1100	81.1100	64	226	\N	
166	Cain Group	122-1342	4	53.5000	53.5000	65	122	\N	
167	Tucker PLC	76-1337	2	61.0000	61.0000	65	76	\N	
168	Graves-Castro	39-1339	2	58.8300	58.8300	65	39	\N	
169	Williams, Webb and Charles	85-1340	3	82.3300	82.3300	65	85	\N	
170	Shelton Inc	69-1342	2	32.7800	32.7800	66	69	\N	
171	Meyer, Sharp and Gates	190-1342	3	20.2600	20.2600	66	190	\N	
172	Williams, Webb and Charles	85-1340	4	82.3300	82.3300	66	85	\N	
173	Rivera, Farmer and Tate	57-1338	3	89.2300	89.2300	66	57	\N	
174	Yu, Myers and Nguyen	187-1342	1	33.7800	33.7800	67	187	\N	
175	Dawson-Collins	233-1338	3	14.9700	14.9700	67	233	\N	
176	Weaver, Caldwell and Kim	229-1337	1	20.6300	20.6300	67	229	\N	
177	Morgan, Thornton and Johnson	28-1340	1	62.5600	62.5600	68	28	\N	
178	Mooney-Strickland	99-1339	3	48.5600	48.5600	68	99	\N	
179	Williams, Webb and Charles	85-1340	4	82.3300	82.3300	69	85	\N	
180	Gonzales Ltd	138-1337	3	24.6600	24.6600	69	138	\N	
181	Rojas Group	169-1337	3	13.2500	13.2500	70	169	\N	
182	Krueger, Perry and Wagner	170-1337	3	61.3900	61.3900	71	170	\N	
183	Wilson Group	35-1339	4	30.4000	30.4000	71	35	\N	
184	Wang, Friedman and Stephens	197-1337	3	44.8700	44.8700	71	197	\N	
185	Edwards PLC	4-1342	1	12.6800	12.6800	71	4	\N	
186	Chavez and Sons	97-1339	1	95.5700	95.5700	72	97	\N	
187	James, Wilson and Garcia	168-1337	1	33.9500	33.9500	72	168	\N	
188	Horton, Clark and Horne	202-1340	2	88.6200	88.6200	72	202	\N	
189	Day Inc	220-1339	2	42.4900	42.4900	72	220	\N	
190	Dawson-Collins	233-1338	4	14.9700	14.9700	73	233	\N	
191	Faulkner, Cisneros and Bautista	145-1340	4	38.5800	38.5800	73	145	\N	
192	Everett Inc	162-1337	4	66.1300	66.1300	73	162	\N	
193	Sanchez, Manning and Coleman	80-1337	3	39.6000	39.6000	73	80	\N	
194	Schmidt and Sons	100-1339	3	8.1100	8.1100	74	100	\N	
195	Chen, Sims and Perez	49-1337	1	38.5300	38.5300	74	49	\N	
196	Roman-Meyer	54-1338	3	56.3700	56.3700	75	54	\N	
197	Curry-Miller	48-1337	2	96.3800	96.3800	76	48	\N	
198	Barnett-Duncan	63-1342	2	66.1700	66.1700	76	63	\N	
199	Wilson Group	51-1338	2	44.2200	44.2200	76	51	\N	
200	Reyes and Sons	81-1340	3	36.6900	36.6900	76	81	\N	
201	Cuevas Group	221-1337	2	49.5800	49.5800	77	221	\N	
202	Lawson, Winters and Carroll	152-1339	4	91.1000	91.1000	77	152	\N	
203	Scott-Martinez	62-1342	4	15.7000	15.7000	78	62	\N	
204	Rowland-Griffin	91-1339	2	52.3800	52.3800	78	91	\N	
205	Walton, Allen and Romero	7-1342	2	83.5200	83.5200	78	7	\N	
206	Smith-King	140-1337	3	87.6700	87.6700	79	140	\N	
207	Benitez-Mcdonald	74-1337	2	19.9700	19.9700	79	74	\N	
208	Hines, Morris and Jones	65-1342	4	10.6800	10.6800	80	65	\N	
209	Saunders Group	13-1337	2	98.4200	98.4200	81	13	\N	
210	Solomon, Lee and Hunt	224-1337	2	51.5500	51.5500	81	224	\N	
211	Boyd-Wheeler	41-1337	3	64.9900	64.9900	81	41	\N	
212	Hays and Sons	159-1339	3	3.9900	3.9900	81	159	\N	
213	Jackson and Sons	25-1340	4	74.4700	74.4700	82	25	\N	
214	Cuevas Group	221-1337	3	49.5800	49.5800	82	221	\N	
215	Vaughan Ltd	184-1342	3	55.4700	55.4700	82	184	\N	
216	Saunders Group	13-1337	1	98.4200	98.4200	83	13	\N	
217	Gray Inc	45-1337	2	50.4300	50.4300	83	45	\N	
218	Graves-Castro	39-1339	4	58.8300	58.8300	83	39	\N	
219	Martinez-Smith	174-1338	1	18.5500	18.5500	84	174	\N	
220	Gutierrez PLC	248-1342	1	89.5900	89.5900	84	248	\N	
221	Gray-Raymond	98-1339	3	70.6200	70.6200	85	98	\N	
222	Carrillo-Wright	149-1340	3	29.8100	29.8100	85	149	\N	
223	Walker-Shelton	252-1337	1	35.3900	35.3900	86	252	\N	
224	Blanchard and Sons	70-1342	4	41.7500	41.7500	86	70	\N	
225	Donovan-Brown	250-1342	1	31.4000	31.4000	86	250	\N	
226	Nelson, Smith and Carney	181-1342	2	2.3200	2.3200	87	181	\N	
227	Rojas Group	169-1337	1	13.2500	13.2500	87	169	\N	
228	Manning-Gonzalez	68-1342	3	7.1900	7.1900	87	68	\N	
229	Adams-Schroeder	267-1340	2	27.4300	27.4300	87	267	\N	
230	Henry Group	127-1342	1	88.7800	88.7800	88	127	\N	
231	Lowe, Nichols and Walker	278-1339	4	99.4100	99.4100	88	278	\N	
232	Rodriguez, Davidson and Jackson	139-1337	2	30.3000	30.3000	88	139	\N	
233	Smith, French and Hamilton	96-1339	4	90.8700	90.8700	88	96	\N	
234	Tapia-Mejia	73-1337	4	67.5700	67.5700	89	73	\N	
235	Johnston PLC	92-1339	2	31.6800	31.6800	89	92	\N	
236	Roman-Meyer	54-1338	3	56.3700	56.3700	89	54	\N	
237	Thompson, White and Moore	52-1338	3	59.5000	59.5000	89	52	\N	
238	Gray-Raymond	98-1339	1	70.6200	70.6200	90	98	\N	
239	Martinez-Schmidt	256-1337	1	12.9200	12.9200	90	256	\N	
240	Lee-Luna	29-1340	1	68.2900	68.2900	90	29	\N	
241	Wolf-Ramos	227-1337	4	29.8000	29.8000	91	227	\N	
242	Cain, Tyler and Jones	112-1338	2	62.9800	62.9800	91	112	\N	
243	Smith-Mcfarland	258-1337	4	31.4600	31.4600	92	258	\N	
244	Rowland-Griffin	91-1339	3	52.3800	52.3800	93	91	\N	
245	Meyer-Hart	40-1339	2	83.9500	83.9500	93	40	\N	
246	Smith, Sanders and Wallace	120-1338	1	14.7600	14.7600	94	120	\N	
247	Pierce Inc	26-1340	1	52.3300	52.3300	94	26	\N	
248	Delacruz, Edwards and Mcknight	240-1338	4	77.6300	77.6300	95	240	\N	
249	Davis-Clark	218-1339	2	0.5200	0.5200	95	218	\N	
250	Bullock PLC	23-1340	2	46.3800	46.3800	95	23	\N	
251	Copeland, Ware and Charles	195-1337	2	68.5400	68.5400	95	195	\N	
252	Glass-Schwartz	274-1339	2	34.7300	34.7300	96	274	\N	
253	Sanchez, Manning and Coleman	80-1337	1	39.6000	39.6000	96	80	\N	
254	Lee-Luna	29-1340	1	68.2900	68.2900	96	29	\N	
255	Thomas PLC	55-1338	1	21.6200	21.6200	96	55	\N	
256	Gonzalez-Becker	191-1337	1	44.7500	44.7500	97	191	\N	
257	Curry-Miller	48-1337	1	96.3800	96.3800	97	48	\N	
258	Jordan Group	260-1337	2	81.3700	81.3700	98	260	\N	
259	Schmidt and Sons	100-1339	2	8.1100	8.1100	99	100	\N	
260	Smith, French and Hamilton	96-1339	1	90.8700	90.8700	99	96	\N	
261	Thornton PLC	236-1338	2	7.4400	7.4400	99	236	\N	
262	King, Vasquez and Blake	107-1337	1	74.2400	74.2400	99	107	\N	
263	Gutierrez, Reed and Rogers	72-1337	3	92.2700	92.2700	100	72	\N	
264	Romero, Jackson and Smith	153-1339	2	45.8500	45.8500	100	153	\N	
265	Martinez-Matthews	155-1339	4	3.3500	3.3500	100	155	\N	
266	Hamilton, Taylor and Harris	101-1337	3	82.4000	82.4000	100	101	\N	
267	Meyer-Hart	40-1339	2	83.9500	83.9500	101	40	\N	
268	Ferguson, Sanchez and Ellis	303-1342	1	23.4000	23.4000	102	303	\N	
269	Rivers Inc	302-1342	2	33.6100	33.6100	102	302	\N	
270	Reyes-Ryan	374-1337	1	0.4700	0.4700	102	374	\N	
271	Thompson, Turner and Foster	201-1340	3	60.2200	60.2200	103	201	\N	
272	Marshall-Taylor	121-1342	2	68.3800	68.3800	104	121	\N	
273	White Inc	383-1340	1	23.2700	23.2700	104	383	\N	
274	Meyer-Hart	40-1339	1	83.9500	83.9500	104	40	\N	
275	Jackson and Sons	25-1340	3	74.4700	74.4700	105	25	\N	
276	Perez Ltd	11-1337	2	9.2200	9.2200	106	11	\N	
277	Richards and Sons	71-1337	2	19.3500	19.3500	106	71	\N	
278	Morrison-Anderson	362-1342	2	9.7600	9.7600	107	362	\N	
279	Taylor, Anderson and Nelson	102-1337	3	57.4900	57.4900	108	102	\N	
280	Mcdonald, Reynolds and Mcguire	351-1338	3	75.6000	75.6000	108	351	\N	
281	Adams-Schroeder	267-1340	2	27.4300	27.4300	108	267	\N	
282	Rivers Inc	302-1342	3	33.6100	33.6100	109	302	\N	
283	Morgan PLC	355-1338	4	2.3700	2.3700	109	355	\N	
284	Schwartz, Green and Duarte	223-1337	2	48.8000	48.8000	109	223	\N	
285	Griffith-Oconnell	10-1342	1	79.2700	79.2700	110	10	\N	
286	Gilbert Ltd	412-1338	1	44.1000	44.1000	111	412	\N	
287	Morgan, Thornton and Johnson	28-1340	1	62.5600	62.5600	112	28	\N	
288	Miller-Goodman	238-1338	3	7.4600	7.4600	113	238	\N	
289	Arroyo PLC	110-1337	3	0.2200	0.2200	113	110	\N	
290	Perez and Sons	209-1340	1	89.2700	89.2700	113	209	\N	
291	Martinez Group	410-1337	3	80.9500	80.9500	113	410	\N	
292	Johnson, Rivas and Henry	349-1337	1	43.6200	43.6200	114	349	\N	
293	Thompson, White and Moore	52-1338	3	59.5000	59.5000	114	52	\N	
294	Copeland, Ware and Charles	195-1337	2	68.5400	68.5400	114	195	\N	
295	Martin and Sons	366-1342	3	8.1900	8.1900	115	366	\N	
296	Grant Inc	38-1339	3	17.7200	17.7200	115	38	\N	
297	James-Jones	163-1337	3	73.3000	73.3000	115	163	\N	
298	Flores-Sherman	336-1339	1	48.2300	48.2300	115	336	\N	
299	Escobar-Rodriguez	263-1340	1	2.1000	2.1000	116	263	\N	
300	Davis, Bell and Camacho	6-1342	3	51.5800	51.5800	117	6	\N	
301	Davis-Clark	218-1339	2	0.5200	0.5200	118	218	\N	
302	Peterson and Sons	206-1340	2	58.6600	58.6600	118	206	\N	
303	Stewart Group	397-1339	4	63.2400	63.2400	119	397	\N	
304	Pierce Ltd	332-1339	2	18.8100	18.8100	119	332	\N	
305	Hamilton, Mueller and Flores	393-1339	2	1.4000	1.4000	119	393	\N	
306	Kelly-Orr	30-1340	4	44.5900	44.5900	119	30	\N	
307	Johnson-Kim	104-1337	3	43.5100	43.5100	120	104	\N	
308	Anderson Inc	323-1340	4	62.8300	62.8300	120	323	\N	
309	Thompson, Turner and Foster	201-1340	4	60.2200	60.2200	121	201	\N	
310	Mann-Lee	58-1338	4	75.8000	75.8000	121	58	\N	
311	Lara PLC	331-1339	2	60.7000	60.7000	121	331	\N	
312	Drake-White	348-1337	3	5.3700	5.3700	122	348	\N	
313	Fowler-Pena	210-1340	4	15.9000	15.9000	122	210	\N	
314	Cordova PLC	441-1340	4	21.5700	21.5700	122	441	\N	
315	Wang, Friedman and Stephens	197-1337	4	44.8700	44.8700	123	197	\N	
316	Suarez-Taylor	78-1337	1	40.2800	40.2800	123	78	\N	
317	Collins LLC	379-1337	1	45.6800	45.6800	123	379	\N	
318	Hamilton, Stone and Rodriguez	475-1338	4	76.4900	76.4900	123	475	\N	
319	Lamb and Sons	212-1339	1	85.7800	85.7800	124	212	\N	
320	Curry-Miller	48-1337	3	96.3800	96.3800	124	48	\N	
321	King Ltd	423-1342	4	44.6100	44.6100	125	423	\N	
322	Morgan PLC	355-1338	2	2.3700	2.3700	125	355	\N	
323	Dean-Warren	365-1342	4	59.1700	59.1700	126	365	\N	
324	Smith-Mcfarland	258-1337	1	31.4600	31.4600	126	258	\N	
325	Mccullough-Jennings	418-1338	3	2.3200	2.3200	126	418	\N	
326	Chang, Henderson and Wallace	182-1342	3	88.4000	88.4000	126	182	\N	
327	Barker, Evans and Weeks	177-1338	1	84.3900	84.3900	127	177	\N	
328	Martin and Sons	366-1342	4	8.1900	8.1900	127	366	\N	
329	Smith, Costa and Reid	462-1337	2	80.4700	80.4700	127	462	\N	
330	Lewis, Graves and Ballard	166-1337	2	74.1000	74.1000	128	166	\N	
331	Adams PLC	447-1340	2	47.6100	47.6100	128	447	\N	
332	Lara-Nelson	308-1342	3	7.1700	7.1700	128	308	\N	
333	Cabrera Ltd	446-1340	4	3.6000	3.6000	128	446	\N	
334	Bell Inc	50-1337	4	29.6000	29.6000	129	50	\N	
335	Armstrong PLC	401-1337	4	7.2700	7.2700	129	401	\N	
336	Wilson Group	51-1338	2	44.2200	44.2200	130	51	\N	
337	Adams, Petty and George	19-1337	3	96.1800	96.1800	130	19	\N	
338	Adams-Kirk	276-1339	2	45.1700	45.1700	130	276	\N	
339	Bullock PLC	23-1340	2	46.3800	46.3800	131	23	\N	
340	Hansen LLC	126-1342	2	94.1400	94.1400	131	126	\N	
341	Frey-Noble	406-1337	3	13.1000	13.1000	132	406	\N	
342	Flowers, Griffin and Perez	294-1338	3	33.6200	33.6200	132	294	\N	
343	Hansen-Horton	239-1338	2	5.8300	5.8300	132	239	\N	
344	Delgado Inc	363-1342	3	73.4000	73.4000	132	363	\N	
345	Bishop-Mclean	43-1337	4	52.3100	52.3100	133	43	\N	
346	Cook and Sons	82-1340	4	5.8900	5.8900	133	82	\N	
347	Brewer-Oliver	173-1338	1	53.2900	53.2900	133	173	\N	
348	Jackson, Lloyd and Bradley	437-1337	4	86.3200	86.3200	133	437	\N	
349	Taylor-Fleming	424-1342	4	36.8300	36.8300	134	424	\N	
350	Holden-Schwartz	478-1338	2	22.5400	22.5400	134	478	\N	
351	Dawson-Collins	233-1338	2	14.9700	14.9700	134	233	\N	
352	Mcdowell LLC	370-1342	3	1.2400	1.2400	135	370	\N	
353	Nelson, Smith and Carney	181-1342	4	2.3200	2.3200	135	181	\N	
354	Kelly-Cardenas	34-1339	1	95.7500	95.7500	135	34	\N	
355	Frye-Jones	75-1337	3	86.8000	86.8000	136	75	\N	
356	Thompson, Spencer and Wallace	16-1337	1	90.2200	90.2200	136	16	\N	
357	Arnold Group	129-1342	1	61.6400	61.6400	136	129	\N	
358	Arnold Group	129-1342	1	61.6400	61.6400	136	129	\N	
359	Dean-Warren	365-1342	2	59.1700	59.1700	137	365	\N	
360	Baldwin Ltd	113-1338	4	79.4400	79.4400	137	113	\N	
361	Snyder-Rogers	367-1342	3	72.5800	72.5800	137	367	\N	
362	Meyer, Sharp and Gates	190-1342	2	20.2600	20.2600	138	190	\N	
363	Smith-Hayes	425-1342	2	87.8000	87.8000	139	425	\N	
364	Hansen LLC	126-1342	3	94.1400	94.1400	139	126	\N	
365	Peterson and Sons	206-1340	2	58.6600	58.6600	139	206	\N	
366	Garrett Ltd	61-1342	3	19.5100	19.5100	140	61	\N	
367	Kelly-Evans	375-1337	2	97.4700	97.4700	140	375	\N	
368	Christian-Friedman	180-1338	2	55.7800	55.7800	140	180	\N	
\.


--
-- Data for Name: order_ordernote; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_ordernote (id, date, content, order_id, user_id) FROM stdin;
\.


--
-- Data for Name: order_payment; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_payment (id, variant, status, fraud_status, fraud_message, created, modified, transaction_id, currency, total, delivery, tax, description, billing_first_name, billing_last_name, billing_address_1, billing_address_2, billing_city, billing_postcode, billing_country_code, billing_country_area, billing_email, customer_ip_address, extra_data, message, token, captured_amount, order_id) FROM stdin;
1	default	waiting	unknown		2017-11-22 20:26:59.124664+00	2017-11-22 20:26:59.124692+00	60398	USD	647.03	1.80	0.00		Christian	Fisher	5531 Stephanie Stravenue		Port Brandon	33094	BI			27.151.24.119			257178a7-96cd-4cd2-9180-2e4c012406aa	0.00	1
2	default	preauth	unknown		2017-11-22 20:26:59.162098+00	2017-11-22 20:26:59.162129+00	84697	USD	377.74	1.80	0.00		Mitchell	Mathis	85936 Monica Mount		Vaughntown	95609	CD			195.144.96.24			e836152e-8b97-4a19-a770-a6943f489b22	0.00	2
3	default	waiting	unknown		2017-11-22 20:26:59.199944+00	2017-11-22 20:26:59.199977+00	94112	USD	293.21	37.18	0.00		William	Anderson	222 Norma Union Apt. 252		Port Jasonchester	85900	RW			191.204.102.53			12381b5e-3caa-4a58-898c-61dcc9020d1c	0.00	3
4	default	preauth	unknown		2017-11-22 20:26:59.229707+00	2017-11-22 20:26:59.229736+00	45154	USD	154.84	1.80	0.00		Alan	Casey	66525 Jordan Plaza		Port Maria	39242-9124	HU			165.182.53.77			69fa724b-237d-4529-86a0-84eba76f64ce	0.00	4
5	default	waiting	unknown		2017-11-22 20:26:59.260307+00	2017-11-22 20:26:59.260351+00	45818	USD	134.46	1.80	0.00		Toni	Howard	962 Nicholas Cove Suite 809		West Patriciaside	75661	AU			75.114.168.181			15305057-41ee-4ec8-9a95-89892a458dff	0.00	5
6	default	confirmed	unknown		2017-11-22 20:26:59.305645+00	2017-11-22 20:26:59.307969+00	32311	USD	576.37	37.18	0.00		Roberto	Lynch	382 Michael Union		Hessshire	46570	MN			101.178.144.86			1030fb0e-c98d-4d83-a95c-a36073fb69f1	576.37	6
7	default	preauth	unknown		2017-11-22 20:26:59.335795+00	2017-11-22 20:26:59.335827+00	97411	USD	71.10	1.80	0.00		Michelle	Smith	64294 Belinda Loaf Suite 582		Port Justin	43371	HR			187.86.65.87			f1c7fc16-badd-487e-ac3b-8c75f6b7f2d7	0.00	7
8	default	waiting	unknown		2017-11-22 20:26:59.374596+00	2017-11-22 20:26:59.374617+00	98008	USD	569.78	1.80	0.00		Kevin	Daniels	4357 Jessica Ramp		Bakerport	34647-3579	UZ			231.5.5.111			1ace9207-0103-4924-a84c-bbc1bbf4e0fd	0.00	8
9	default	preauth	unknown		2017-11-22 20:26:59.404481+00	2017-11-22 20:26:59.404499+00	48349	USD	251.05	37.18	0.00		Mandy	Reynolds	20032 Heather Estate Apt. 355		West Adamtown	90403	RW			107.105.26.67			093109d3-dddd-43e4-a41d-712e60141ef7	0.00	9
10	default	confirmed	unknown		2017-11-22 20:26:59.441115+00	2017-11-22 20:26:59.442766+00	20575	USD	377.14	1.80	0.00		Jeffrey	Peterson	8892 Stacy Glen		Dawsonberg	59460-5827	PW			127.33.161.229			56032748-0338-41c5-8c8d-abaeb0640467	377.14	10
11	default	waiting	unknown		2017-11-22 20:26:59.476645+00	2017-11-22 20:26:59.476665+00	33216	USD	162.06	1.80	0.00		Chad	Pearson	61941 Jeremy Union		Floresview	10087	BH			162.239.60.29			a2868291-4a2b-4eb7-8ba0-18e145b85cef	0.00	11
12	default	preauth	unknown		2017-11-22 20:26:59.498564+00	2017-11-22 20:26:59.498601+00	59797	USD	251.76	1.80	0.00		Sandy	Parks	742 Harris Route Suite 642		North Jeffreyport	63214-7899	FM			219.206.147.26			01b1dd77-b431-4830-bfa0-5361f46215db	0.00	12
13	default	preauth	unknown		2017-11-22 20:26:59.527857+00	2017-11-22 20:26:59.527877+00	2723	USD	145.31	1.80	0.00		Matthew	Cooper	64511 Eric Island Apt. 630		Port Julieberg	49145-3808	SC			68.232.161.23			ecaea6e9-7497-4fd0-9ec8-8185329817ca	0.00	13
14	default	waiting	unknown		2017-11-22 20:26:59.556526+00	2017-11-22 20:26:59.556563+00	68063	USD	245.28	1.80	0.00		David	Mcgee	62272 Brown Branch		South Jaredfurt	71863-6087	TJ			160.86.132.0			f8ed9576-0e03-4e9b-b4cb-5ba772618b02	0.00	14
15	default	waiting	unknown		2017-11-22 20:26:59.589379+00	2017-11-22 20:26:59.589399+00	73207	USD	218.13	37.18	0.00		Donna	Washington	3579 Knox Common		South Georgeburgh	82678-5171	MK			211.51.177.43			ba376a53-4cbb-4ac0-8b77-73f0f2cbddb9	0.00	15
16	default	confirmed	unknown		2017-11-22 20:26:59.622507+00	2017-11-22 20:26:59.624357+00	2946	USD	161.00	1.80	0.00		Gregory	Sanders	630 Lopez Orchard		East Ashley	27367	MG			1.191.249.8			68db3330-2571-4854-9e34-e9f0ee92ec26	161.00	16
17	default	preauth	unknown		2017-11-22 20:26:59.655049+00	2017-11-22 20:26:59.655071+00	94596	USD	228.68	37.18	0.00		Jennifer	Reeves	9767 Chelsea Loop		West Jennaside	57785-2267	LC			163.218.118.186			13c16ebd-5d6d-4360-9db0-30017b8e2aea	0.00	17
18	default	confirmed	unknown		2017-11-22 20:26:59.675769+00	2017-11-22 20:26:59.677302+00	41802	USD	324.43	37.18	0.00		Chad	Pearson	61941 Jeremy Union		Floresview	10087	BH			101.43.5.152			ab19eee2-3ffc-4b8f-9ba7-782c63aacf26	324.43	18
19	default	confirmed	unknown		2017-11-22 20:26:59.714898+00	2017-11-22 20:26:59.717163+00	87173	USD	520.26	37.18	0.00		Donna	Washington	3579 Knox Common		South Georgeburgh	82678-5171	MK			137.219.174.176			6b33bbcb-634c-49cc-9747-c9aa112683e8	520.26	19
20	default	confirmed	unknown		2017-11-22 20:26:59.744257+00	2017-11-22 20:26:59.746704+00	12778	USD	382.15	94.90	0.00		Morgan	Thompson	9544 Armstrong Causeway Apt. 298		Carrollbury	90961	US			174.115.120.164			66a54d46-45e9-4286-a1e3-01a982bd4dfa	382.15	20
21	default	confirmed	unknown		2017-11-27 23:21:11.08947+00	2017-11-27 23:21:11.092819+00	72245	USD	353.77	76.23	0.00		Mandy	Terry	806 Carpenter Ranch		New Shannon	55235-4815	LY			212.173.37.132			9293f46c-8d02-4ca7-8322-0371a80618ec	353.77	21
22	default	preauth	unknown		2017-11-27 23:21:11.126033+00	2017-11-27 23:21:11.126061+00	60280	USD	533.22	76.23	0.00		Nicole	Hernandez	75157 Valerie Knolls Suite 472		West Arthur	81773	BR			17.76.252.142			b2c20d9a-20c2-47c7-82f6-3f0808019b35	0.00	22
23	default	confirmed	unknown		2017-11-27 23:21:11.158728+00	2017-11-27 23:21:11.160455+00	78495	USD	439.36	94.90	0.00		Morgan	Thompson	9544 Armstrong Causeway Apt. 298		Carrollbury	90961	US			255.193.39.232			02839467-f60b-408b-8c4e-c57aafe17917	439.36	23
24	default	confirmed	unknown		2017-11-27 23:21:11.200969+00	2017-11-27 23:21:11.202897+00	85424	USD	629.41	1.80	0.00		Juan	Todd	4613 David Port Suite 500		Scottbury	79153-1013	AL			157.32.184.166			beae8245-2523-42a3-a850-3162760e2de6	629.41	24
25	default	waiting	unknown		2017-11-27 23:21:11.243062+00	2017-11-27 23:21:11.243083+00	23448	USD	671.25	99.54	0.00		Edward	Goodwin	4525 Wong Field		Lamfurt	05603	SI			83.11.57.236			e23a8f56-a695-4b0a-a6b6-8a4e595ecdd6	0.00	25
26	default	confirmed	unknown		2017-11-27 23:21:11.27792+00	2017-11-27 23:21:11.28011+00	11485	USD	416.36	99.54	0.00		Robert	Klein	509 Lisa Ranch Apt. 743		Port Tonyfort	38385	GT			196.5.106.238			eb2aff4c-d1c9-40e5-a2dd-449175c7d74d	416.36	26
27	default	waiting	unknown		2017-11-27 23:21:11.307265+00	2017-11-27 23:21:11.307291+00	39584	USD	245.40	76.23	0.00		Thomas	Harper	49841 Courtney Mission Suite 707		Melvinchester	99283-9140	KH			43.111.104.186			f53dfe78-7856-4f90-8ae2-4fd3a19f665a	0.00	27
28	default	confirmed	unknown		2017-11-27 23:21:11.338777+00	2017-11-27 23:21:11.340497+00	37200	USD	373.70	1.80	0.00		Elizabeth	Horne	1110 Brandon Fall		Macdonaldport	51944	HN			186.102.101.236			f12821cd-74c4-46b9-b52e-e7932c5f4b85	373.70	28
29	default	preauth	unknown		2017-11-27 23:21:11.368841+00	2017-11-27 23:21:11.368861+00	80219	USD	469.18	99.54	0.00		Ashley	Roberts	705 Lisa Pass Suite 835		East Bryanhaven	22816-4459	JM			26.71.192.172			a08f423b-0f3d-4360-95ae-5a07753d5cd9	0.00	29
30	default	confirmed	unknown		2017-11-27 23:21:11.392522+00	2017-11-27 23:21:11.394198+00	81515	USD	230.31	76.23	0.00		Richard	Jimenez	281 Tran Keys Suite 048		West Jeffreymouth	31007-7545	IR			182.105.203.49			c7803ee6-653f-463d-a3a6-f20c7b67b861	230.31	30
31	default	preauth	unknown		2017-11-27 23:21:11.431689+00	2017-11-27 23:21:11.43171+00	98209	USD	301.53	76.23	0.00		Robert	Klein	509 Lisa Ranch Apt. 743		Port Tonyfort	38385	GT			174.82.163.46			69ae8217-32a9-4a6b-9a2d-24034ebf4388	0.00	31
32	default	confirmed	unknown		2017-11-27 23:21:11.459064+00	2017-11-27 23:21:11.460656+00	59558	USD	311.48	99.54	0.00		Max	Johnson	8370 Jones Grove Suite 474		Joshuafurt	37962	GQ			152.172.148.237			98553521-56dd-4c9b-8a45-eea83960129d	311.48	32
33	default	waiting	unknown		2017-11-27 23:21:11.497933+00	2017-11-27 23:21:11.497961+00	84661	USD	1016.76	1.80	0.00		Michelle	Wright	88260 Brandon Isle		Reyeschester	94159	NO			87.233.223.150			fe767f66-67a9-49d4-b9ab-6c5f27c3d73a	0.00	33
34	default	preauth	unknown		2017-11-27 23:21:11.529428+00	2017-11-27 23:21:11.529457+00	29196	USD	746.52	37.18	0.00		Caitlin	Houston	582 Anthony Pine Apt. 884		Port Jennifer	80078	CV			59.66.186.4			d05e0642-9adb-4c9f-88d4-09dff43ad907	0.00	34
35	default	confirmed	unknown		2017-11-27 23:21:11.565782+00	2017-11-27 23:21:11.568162+00	23985	USD	375.51	1.80	0.00		Mandy	Terry	806 Carpenter Ranch		New Shannon	55235-4815	LY			192.92.100.45			e5d4b781-5d67-4a2e-bfd8-9e17888179f7	375.51	35
36	default	confirmed	unknown		2017-11-27 23:21:11.605262+00	2017-11-27 23:21:11.606841+00	45987	USD	633.68	37.18	0.00		Thomas	Harper	49841 Courtney Mission Suite 707		Melvinchester	99283-9140	KH			117.139.187.65			80b9cbbb-f00d-444b-8e02-6b9600d2c098	633.68	36
37	default	waiting	unknown		2017-11-27 23:21:11.699825+00	2017-11-27 23:21:11.699854+00	60888	USD	344.60	76.23	0.00		Michelle	Wright	88260 Brandon Isle		Reyeschester	94159	NO			51.17.71.232			b80d78d9-098f-48f7-aea1-dc8caba54018	0.00	37
38	default	preauth	unknown		2017-11-27 23:21:11.724504+00	2017-11-27 23:21:11.724524+00	42047	USD	183.30	1.80	0.00		Rachel	Davis	021 James Ports		Taylormouth	54548-1194	MM			208.106.55.187			1e5cc0ab-2e25-4a80-9227-1e08f88e24d0	0.00	38
39	default	confirmed	unknown		2017-11-27 23:21:11.75379+00	2017-11-27 23:21:11.755437+00	78715	USD	401.79	37.18	0.00		Kenneth	Beard	6700 Eric Inlet Apt. 611		Cruzmouth	49640	CY			225.118.71.158			7f686bcc-53d0-45de-84e1-551c334898eb	401.79	39
40	default	confirmed	unknown		2017-11-27 23:21:11.795574+00	2017-11-27 23:21:11.798093+00	30395	USD	580.97	76.23	0.00		Michelle	Smith	64294 Belinda Loaf Suite 582		Port Justin	43371	HR			139.11.242.119			9a2ba686-cc5d-4077-ada6-0f4b2353aacf	580.97	40
41	default	waiting	unknown		2017-11-27 23:30:51.715295+00	2017-11-27 23:30:51.715313+00	98576	USD	377.49	99.54	0.00		Robert	Wright	898 Crawford Point		Petersonchester	28634-0941	CA			247.212.78.208			1afb3779-f096-4e71-a94b-6091a9da073a	0.00	41
42	default	confirmed	unknown		2017-11-27 23:30:51.738958+00	2017-11-27 23:30:51.74195+00	82738	USD	213.19	91.59	0.00		Joseph	Murphy	5459 Callahan Groves		North Josephland	76616-6670	BJ			64.50.158.58			bac1c8a7-b0f7-4b24-a6ef-287681e68614	213.19	42
43	default	preauth	unknown		2017-11-27 23:30:51.768498+00	2017-11-27 23:30:51.768527+00	82258	USD	266.27	76.23	0.00		Kevin	Smith	45433 Williams Cliffs Apt. 273		West Karenland	50321-6366	OM			83.221.151.51			88125a0f-de0d-4377-95c4-6d2d7772134a	0.00	43
44	default	confirmed	unknown		2017-11-27 23:30:51.799637+00	2017-11-27 23:30:51.801383+00	96842	USD	247.81	50.00	0.00		Jonathan	Meyer	5732 Jeremiah Drives		Jeremiahchester	27300	GM			240.65.30.11			1e39bcf4-3510-4b65-9b62-cce43ca38337	247.81	44
45	default	preauth	unknown		2017-11-27 23:30:51.829447+00	2017-11-27 23:30:51.829478+00	15240	USD	348.06	37.18	0.00		Mandy	Terry	806 Carpenter Ranch		New Shannon	55235-4815	LY			10.167.225.174			967e9783-ca4b-4c36-929b-2fc7bdbd7e4a	0.00	45
46	default	confirmed	unknown		2017-11-27 23:30:51.862497+00	2017-11-27 23:30:51.864117+00	22862	USD	580.85	91.59	0.00		Dawn	Carrillo	536 Webster Port Suite 865		Allisonborough	68121	CV			124.16.190.226			6c177651-1f90-42b5-b880-e17bd4129c96	580.85	46
47	default	preauth	unknown		2017-11-27 23:30:51.8992+00	2017-11-27 23:30:51.899219+00	32294	USD	445.77	91.59	0.00		Hannah	Thompson	671 Vargas Station		East Richardstad	95678-7052	VC			68.224.105.151			1b312f7d-0e1b-4766-9ae8-895185693609	0.00	47
48	default	waiting	unknown		2017-11-27 23:30:51.917625+00	2017-11-27 23:30:51.917645+00	91989	USD	180.16	1.80	0.00		Joe	Wade	765 Henry Lakes		Maxburgh	96986-3762	KE			175.72.242.121			57d40640-77d0-4730-b9fc-5a9c2736313e	0.00	48
49	default	waiting	unknown		2017-11-27 23:30:51.951118+00	2017-11-27 23:30:51.951137+00	94434	USD	799.18	99.54	0.00		Christian	Waters	309 Campos Springs Suite 234		Crawfordview	36335-0733	CV			137.143.33.140			f90ddbd9-3802-4818-ab69-e2cbc321da20	0.00	49
50	default	preauth	unknown		2017-11-27 23:30:51.98701+00	2017-11-27 23:30:51.987038+00	88971	USD	833.92	76.23	0.00		Stephen	Burns	315 Ryan Stream Apt. 382		Mathewsfort	58145-7898	GN			170.227.254.140			1074bfd1-d1ac-4b57-8506-9ca668ff5144	0.00	50
51	default	confirmed	unknown		2017-11-27 23:30:52.005566+00	2017-11-27 23:30:52.007169+00	45862	USD	112.22	99.54	0.00		Molly	Vance	859 Cabrera Valleys		South Andrea	99953-2793	CM			86.39.211.218			5c866e4d-da8f-4f09-9a3a-596edd46dd3c	112.22	51
52	default	confirmed	unknown		2017-11-27 23:30:52.043967+00	2017-11-27 23:30:52.045487+00	44034	USD	619.53	37.18	0.00		Jessica	Johnson	84100 Aaron Shore		Carterhaven	69349	KN			64.84.223.205			c565c74d-45c7-4efd-933c-1b599d9f226a	619.53	52
53	default	preauth	unknown		2017-11-27 23:30:52.076376+00	2017-11-27 23:30:52.076404+00	5637	USD	654.33	91.59	0.00		Vanessa	Chapman	2383 Joseph Neck Suite 407		North Robert	67202	CD			216.179.74.105			4d43567e-7b6f-4733-afe7-b936125e2580	0.00	53
54	default	confirmed	unknown		2017-11-27 23:30:52.10782+00	2017-11-27 23:30:52.109553+00	1208	USD	520.32	91.59	0.00		Kim	Stevens	3333 Fisher Ford Suite 104		Ruizmouth	79843	IT			45.111.241.113			6cc63fc9-2924-441d-8749-fe3013b3e322	520.32	54
55	default	preauth	unknown		2017-11-27 23:30:52.138812+00	2017-11-27 23:30:52.138833+00	14206	USD	147.80	37.18	0.00		Ryan	Watson	4660 Williams Village Suite 716		Lucasbury	37853	AF			125.25.135.72			01307ce8-da65-4931-9592-80a903111cf2	0.00	55
56	default	waiting	unknown		2017-11-27 23:30:52.16243+00	2017-11-27 23:30:52.16245+00	90740	USD	63.94	1.80	0.00		Tammy	Merritt	684 Lisa Shores		Thomasborough	36488	FI			27.27.29.244			c18ad06b-d9a0-4974-84e1-2aa23c559d44	0.00	56
57	default	preauth	unknown		2017-11-27 23:30:52.183424+00	2017-11-27 23:30:52.183453+00	38973	USD	285.52	37.18	0.00		Elijah	Robinson	295 Bruce Forges Suite 363		Russellborough	92967-5962	MT			190.50.30.158			7b32f8d3-be71-43f9-a455-b866815b32a3	0.00	57
58	default	preauth	unknown		2017-11-27 23:30:52.210409+00	2017-11-27 23:30:52.210428+00	23205	USD	418.35	99.54	0.00		Brittany	Bradley	1051 Gardner Field		Alexandershire	39694-8265	EE			186.244.162.111			8058fa9e-3ec2-4c53-b556-a7f0db67e4ab	0.00	58
59	default	confirmed	unknown		2017-11-27 23:30:52.236888+00	2017-11-27 23:30:52.238683+00	44290	USD	232.66	1.80	0.00		Jeffrey	Campbell	335 Thomas Lock		West Josephborough	26767-3799	SK			46.90.132.98			fbd43dcb-2bc6-4b50-ac08-12312cbcbe79	232.66	59
60	default	waiting	unknown		2017-11-27 23:30:52.268246+00	2017-11-27 23:30:52.268273+00	85172	USD	476.29	76.23	0.00		Dawn	Carrillo	536 Webster Port Suite 865		Allisonborough	68121	CV			140.58.45.100			7a9266a7-0eb4-42f1-82d2-9f1bd59be0bf	0.00	60
61	default	preauth	unknown		2017-11-27 23:49:15.993786+00	2017-11-27 23:49:15.993815+00	20079	USD	603.94	99.54	0.00		Nicole	Castro	1296 Jones Field		Lake Paulland	71727-2760	BJ			248.178.187.216			92fa6c35-e67a-4638-9417-e83abd02daed	0.00	61
62	default	preauth	unknown		2017-11-27 23:49:16.030057+00	2017-11-27 23:49:16.030087+00	94940	USD	308.11	76.23	0.00		Michael	Wright	55675 Michael Isle Apt. 388		West Adrianberg	26754	AG			37.237.227.113			aecf2aa1-8f66-4aa3-8f95-8f046c5091e0	0.00	62
63	default	waiting	unknown		2017-11-27 23:49:16.057803+00	2017-11-27 23:49:16.057845+00	66615	USD	96.03	91.59	0.00		Toni	Howard	962 Nicholas Cove Suite 809		West Patriciaside	75661	AU			114.159.41.42			fea690d2-c1bb-4b8f-aa12-5b684ad889bd	0.00	63
64	default	preauth	unknown		2017-11-27 23:49:16.100749+00	2017-11-27 23:49:16.100777+00	3038	USD	420.03	1.80	0.00		Lisa	Browning	01157 Douglas Ports Apt. 277		Reedland	09989-9034	NE			55.24.150.88			78dc3df7-466d-4ab8-bac6-861916481cf4	0.00	64
65	default	confirmed	unknown		2017-11-27 23:49:16.142481+00	2017-11-27 23:49:16.144838+00	93206	USD	747.50	46.85	0.00		Kimberly	Williams	12891 Lisa Mount		South Terriborough	58385	AO			32.32.190.114			280436d7-17c8-461f-915f-3c82af4b0b18	747.50	65
66	default	preauth	unknown		2017-11-27 23:49:16.181082+00	2017-11-27 23:49:16.181118+00	77131	USD	725.15	1.80	0.00		Sabrina	Smith	0363 Mcclain Fort Apt. 233		Stephensshire	85410	EE			195.117.130.97			20195bd9-4380-4b51-b778-8bb0cf02236b	0.00	66
67	default	confirmed	unknown		2017-11-27 23:49:16.212832+00	2017-11-27 23:49:16.214426+00	14493	USD	136.50	37.18	0.00		Raymond	Gomez	9307 Garcia Garden		East Jacobberg	66005-2343	HR			219.12.229.49			21d10b0c-38f1-464f-957c-9131b0282897	136.50	67
68	default	preauth	unknown		2017-11-27 23:49:16.241648+00	2017-11-27 23:49:16.241668+00	16603	USD	245.42	37.18	0.00		Kim	Stevens	3333 Fisher Ford Suite 104		Ruizmouth	79843	IT			215.91.32.149			24161d48-ba6d-42ae-b3b6-e28d918b266a	0.00	68
69	default	waiting	unknown		2017-11-27 23:49:16.269377+00	2017-11-27 23:49:16.269399+00	85594	USD	405.10	1.80	0.00		Kimberly	Miller	5217 Jacqueline Village		North Kathleen	04964-3335	BZ			106.206.91.158			2eef1650-78db-4373-8fad-bf61ade269cc	0.00	69
70	default	preauth	unknown		2017-11-27 23:49:16.289488+00	2017-11-27 23:49:16.289509+00	76620	USD	86.60	46.85	0.00		Kenneth	Duran	04957 Harmon Locks Apt. 417		Port Rachelport	74340-9679	TL			79.158.139.218			fa27a075-c424-41a0-9620-0bc2b71128ee	0.00	70
71	default	preauth	unknown		2017-11-27 23:49:16.322881+00	2017-11-27 23:49:16.322902+00	55092	USD	454.86	1.80	0.00		Oscar	Young	3075 Garrett Mountain		New Alexis	95136	AE			135.201.1.134			502782fe-8232-4cda-afde-a7a4c48cd200	0.00	71
72	default	waiting	unknown		2017-11-27 23:49:16.357347+00	2017-11-27 23:49:16.357367+00	56156	USD	428.92	37.18	0.00		Willie	Coleman	69752 Samantha Summit Suite 624		West Teresaland	12017-8526	SD			54.250.23.102			db52119d-4a91-4b64-ac58-ddbb5c96563b	0.00	72
73	default	confirmed	unknown		2017-11-27 23:49:16.391965+00	2017-11-27 23:49:16.393666+00	19374	USD	644.37	46.85	0.00		Robert	Hill	81538 Moore Cape Apt. 113		Walterview	49996	GD			241.109.250.54			cb708130-ad22-480b-85d8-062a19679752	644.37	73
74	default	preauth	unknown		2017-11-27 23:49:16.421694+00	2017-11-27 23:49:16.421715+00	62719	USD	74.56	11.70	0.00		Kevin	Smith	45433 Williams Cliffs Apt. 273		West Karenland	50321-6366	OM			196.30.242.23			ff263f9b-1758-44a5-980d-4e9c79dcbb52	0.00	74
75	default	confirmed	unknown		2017-11-27 23:49:16.440782+00	2017-11-27 23:49:16.442409+00	19567	USD	170.91	1.80	0.00		Robert	Hill	81538 Moore Cape Apt. 113		Walterview	49996	GD			184.63.85.202			284c705b-52c2-47bd-b9f7-bd82ae1eed1d	170.91	75
76	default	preauth	unknown		2017-11-27 23:49:16.479784+00	2017-11-27 23:49:16.479805+00	68058	USD	615.20	91.59	0.00		Jason	Nguyen	85033 Brown Alley Suite 668		New Melissaberg	21006	TM			101.203.8.112			c82623b5-3df2-4f7c-ac06-2a88781c119e	0.00	76
77	default	preauth	unknown		2017-11-27 23:49:16.503387+00	2017-11-27 23:49:16.503415+00	30317	USD	539.79	76.23	0.00		Nicole	Ramirez	49457 Debra Port Suite 193		South Davidstad	21932	EE			148.104.181.78			738c6a6e-1bc6-440e-9e63-04dc517b6707	0.00	77
78	default	preauth	unknown		2017-11-27 23:49:16.531765+00	2017-11-27 23:49:16.531786+00	76491	USD	336.40	1.80	0.00		Robin	Boyle	4043 Hendricks Cliff		Walkerport	50794-7690	CF			139.147.76.58			00b09e93-422e-4008-a468-9599a2cef740	0.00	78
79	default	preauth	unknown		2017-11-27 23:49:16.555672+00	2017-11-27 23:49:16.555695+00	17024	USD	340.13	37.18	0.00		Juan	Bartlett	2784 Cory Throughway		Port Jenniferfurt	38521-3226	GA			196.133.47.232			6748813b-c85a-4f90-9d5b-1a63596e87fb	0.00	79
80	default	preauth	unknown		2017-11-27 23:49:16.576768+00	2017-11-27 23:49:16.57679+00	16121	USD	54.42	11.70	0.00		Christopher	Ryan	2719 Nguyen Villages		Garrettland	38507	CG			27.132.213.125			bf054b14-9138-4e76-ad68-677644ee6c11	0.00	80
81	default	confirmed	unknown		2017-11-28 00:10:07.636046+00	2017-11-28 00:10:07.650441+00	7458	USD	583.11	76.23	0.00		Adam	Douglas	3645 Keith Mills Suite 758		East Paulshire	44879	AU			178.117.175.220			4ef18bbc-1dae-44dd-a225-169ed7983820	583.11	81
82	default	preauth	unknown		2017-11-28 00:10:07.694861+00	2017-11-28 00:10:07.694891+00	69276	USD	614.83	1.80	0.00		Jennifer	Castillo	152 John Trail Apt. 534		New Kelly	33381-0239	SR			42.88.169.90			aed755dd-6324-4be7-871f-3935257ba531	0.00	82
83	default	waiting	unknown		2017-11-28 00:10:07.732375+00	2017-11-28 00:10:07.732405+00	58117	USD	494.53	59.93	0.00		Stephanie	Cunningham	00726 Mary Keys Suite 092		Lake Jeffreyhaven	52736	NA			4.145.195.136			5a35bc21-9dd5-44af-955d-7b9ea9a94bc7	0.00	83
84	default	waiting	unknown		2017-11-28 00:10:07.763865+00	2017-11-28 00:10:07.763894+00	75539	USD	154.99	46.85	0.00		Kimberly	Williams	12891 Lisa Mount		South Terriborough	58385	AO			22.99.108.34			53298ebc-8331-4b7c-9e0c-7a5e655b85a2	0.00	84
85	default	confirmed	unknown		2017-11-28 00:10:07.798321+00	2017-11-28 00:10:07.800255+00	62453	USD	312.99	11.70	0.00		Melvin	Roberts	7671 Heather Loop		Smithfort	25655-9491	NI			164.224.182.1			ef35e474-7049-4421-82a5-4dcd9b4c0f1f	312.99	85
86	default	preauth	unknown		2017-11-28 00:10:07.851091+00	2017-11-28 00:10:07.851123+00	84230	USD	280.64	46.85	0.00		Yolanda	Banks	64596 Charles Oval Suite 091		Kellyberg	06172-3161	TV			36.230.198.35			2c229f06-251c-4461-8bb6-710e926f9b3b	0.00	86
87	default	preauth	unknown		2017-11-28 00:10:07.898062+00	2017-11-28 00:10:07.898093+00	11394	USD	170.55	76.23	0.00		Tricia	Robinson	2399 Carroll Crescent Suite 050		West Donaldberg	14121	SL			228.62.22.25			50303afc-3d75-432e-8cd8-b11685322706	0.00	87
88	default	confirmed	unknown		2017-11-28 00:10:07.938447+00	2017-11-28 00:10:07.940508+00	91867	USD	912.30	1.80	0.00		Patricia	Roberts	35684 Nicole Lodge Suite 881		North Yvonne	65087-9339	TO			188.91.142.110			06ba87bc-1ff9-40a4-955f-845ec2179fb2	912.30	88
89	default	confirmed	unknown		2017-11-28 00:10:07.991982+00	2017-11-28 00:10:07.994643+00	83387	USD	692.95	11.70	0.00		Kevin	Jackson	473 Jeffrey Throughway Apt. 130		North Ashleyland	97129	NA			63.173.217.105			55ca3660-3c83-4789-9c8f-521bca757984	692.95	89
90	default	confirmed	unknown		2017-11-28 00:10:08.037464+00	2017-11-28 00:10:08.039837+00	96845	USD	211.76	59.93	0.00		James	Watts	64038 Sanders Stream		Port James	52753	TD			35.130.223.117			bd401281-53ee-4247-92c6-bed0045f8f22	211.76	90
91	default	confirmed	unknown		2017-11-28 00:10:08.078297+00	2017-11-28 00:10:08.081222+00	36184	USD	275.75	30.59	0.00		Krystal	Crawford	84789 Marshall Inlet Suite 433		Jordanfurt	20351	AO			79.137.169.72			fe47efb2-2020-480e-915a-86a13caaa77e	275.75	91
92	default	waiting	unknown		2017-11-28 00:10:08.109351+00	2017-11-28 00:10:08.109373+00	54719	USD	137.54	11.70	0.00		Eric	Myers	080 Bradley Wells		South Chadberg	58125-4614	LC			194.37.37.213			3723e090-99e2-4607-8252-f7d322dd5920	0.00	92
93	default	preauth	unknown		2017-11-28 00:10:08.13903+00	2017-11-28 00:10:08.139059+00	17429	USD	416.63	91.59	0.00		Scott	Wood	093 Johnson Green		South Timothytown	37189	IE			207.123.144.12			a44bfb5e-9edf-4314-b1a8-176fb191a5bb	0.00	93
94	default	confirmed	unknown		2017-11-28 00:10:08.171943+00	2017-11-28 00:10:08.174032+00	48201	USD	68.89	1.80	0.00		Jessica	Duncan	52801 Rodriguez Locks Apt. 688		North Brianna	57457	KM			50.251.191.75			58f5a87f-d937-4aa8-9e01-603d5d0f3580	68.89	94
95	default	preauth	unknown		2017-11-28 00:10:08.214917+00	2017-11-28 00:10:08.214939+00	91082	USD	571.99	30.59	0.00		Valerie	Brooks	62351 Victor Valleys		North Bryanfurt	81730-3250	IT			250.38.30.48			a33fcc91-bd00-46a7-b3c3-ef09912b0440	0.00	95
96	default	confirmed	unknown		2017-11-28 00:10:08.253915+00	2017-11-28 00:10:08.255425+00	72385	USD	200.77	1.80	0.00		Dennis	Duncan	27871 Laura Mountain		Port Kayla	38369-4827	RW			191.59.133.192			58f48e4c-c39c-4121-9505-6343a9fe4b17	200.77	96
97	default	confirmed	unknown		2017-11-28 00:10:08.28757+00	2017-11-28 00:10:08.28921+00	33793	USD	187.98	46.85	0.00		Beth	Johnston	387 Lance Expressway Suite 673		Robertfort	94652-2640	SC			83.151.97.250			a2f89de5-daf5-4d31-ac25-67f2ab5da366	187.98	97
98	default	preauth	unknown		2017-11-28 00:10:08.316603+00	2017-11-28 00:10:08.316629+00	92471	USD	222.67	59.93	0.00		Matthew	Keith	924 Rivera Village Apt. 195		Franciscoshire	53141	CH			37.249.35.162			298b6b55-a728-4739-b66f-a54c38f1e55a	0.00	98
99	default	confirmed	unknown		2017-11-28 00:10:08.351227+00	2017-11-28 00:10:08.356057+00	34561	USD	243.06	46.85	0.00		Rebecca	Andrade	69476 Ricky Camp Suite 599		Laurenfort	48892-0711	TH			248.97.110.86			6d229906-0631-4ac0-be5c-95ec6c75012a	243.06	99
100	default	confirmed	unknown		2017-11-28 00:10:08.395422+00	2017-11-28 00:10:08.398321+00	58980	USD	689.04	59.93	0.00		Robert	Hill	81538 Moore Cape Apt. 113		Walterview	49996	GD			0.7.174.238			63ef4b75-7c74-4a32-92cc-35bea33cdaf0	689.04	100
101	default	preauth	unknown		2017-12-02 22:51:37.335568+00	2017-12-02 22:51:37.3356+00	74810	USD	227.83	59.93	0.00		Jamie	Robles	152 Carrillo Route		North Jason	14530-5771	MG			90.59.254.70			5b0ed35d-1335-4479-84e5-373e9cf38494	0.00	101
102	default	preauth	unknown		2017-12-02 22:51:37.367613+00	2017-12-02 22:51:37.367633+00	13929	USD	180.21	89.12	0.00		Michael	Black	700 Ball Station Suite 644		Lake Christinamouth	68359	AO			179.213.111.199			ceeee688-0ead-4a80-bce0-75bd1d5e0fe1	0.00	102
103	default	confirmed	unknown		2017-12-02 22:51:37.391439+00	2017-12-02 22:51:37.393214+00	74088	USD	240.59	59.93	0.00		Karen	Carr	483 Trevor Rapid Suite 422		New Larrytown	81807	SN			238.119.134.147			39b046e0-6219-4569-a5ed-e13da8778a2d	240.59	103
104	default	preauth	unknown		2017-12-02 22:51:37.428676+00	2017-12-02 22:51:37.428696+00	67214	USD	270.41	26.43	0.00		Emily	Adams	098 Swanson Pass		South Dylanton	41446	DK			99.107.111.79			76f20ede-f9b6-4697-a714-982b80a43da9	0.00	104
105	default	preauth	unknown		2017-12-02 22:51:37.450882+00	2017-12-02 22:51:37.450901+00	92662	USD	283.34	59.93	0.00		Donald	Rodriguez	7126 Smith Crossing		Watsonton	91944	BW			13.203.221.94			1fe2202e-7f25-4966-ae88-d0a70154220c	0.00	105
106	default	preauth	unknown		2017-12-02 22:51:37.477161+00	2017-12-02 22:51:37.477183+00	77433	USD	107.14	50.00	0.00		Maria	Winters	719 Michaela Ford Suite 484		Richardburgh	37167-2149	MN			180.151.42.230			a8247d56-a91f-4e2b-b160-5c9bd8ca2b94	0.00	106
107	default	waiting	unknown		2017-12-02 22:51:37.499289+00	2017-12-02 22:51:37.499308+00	57838	USD	112.83	93.31	0.00		Donald	Montgomery	139 Frederick Street Suite 493		Thomasshire	63011	SR			30.92.230.83			bdb0d160-68f7-4f9d-85d7-78830a0f5344	0.00	107
108	default	waiting	unknown		2017-12-02 22:51:37.528516+00	2017-12-02 22:51:37.528536+00	92770	USD	530.36	76.23	0.00		Ryan	White	842 Gordon Meadow Suite 943		New Christopher	90517	NL			255.146.98.80			4c93fa7a-e348-4688-9fc0-6e485e69ff20	0.00	108
109	default	preauth	unknown		2017-12-02 22:51:37.568534+00	2017-12-02 22:51:37.568573+00	97447	USD	245.46	37.55	0.00		Jennifer	Robinson	245 Ethan Burg Apt. 336		Thompsonview	91769	SO			115.182.110.35			95ec8894-f016-428e-b32a-b659c467e4f0	0.00	109
110	default	preauth	unknown		2017-12-02 22:51:37.596853+00	2017-12-02 22:51:37.596885+00	37824	USD	116.45	37.18	0.00		Andrea	Hayden	182 Tamara Causeway Suite 575		North Lisa	74728	RU			20.131.233.201			abcc7d92-58fb-4180-858b-50c9738850e7	0.00	110
111	default	confirmed	unknown		2017-12-02 22:51:37.624302+00	2017-12-02 22:51:37.626309+00	99285	USD	120.33	76.23	0.00		Frederick	Bell	5512 Sarah Pine Suite 489		West Justin	95123	BJ			52.49.44.206			12e22e7d-a848-4c65-8208-dfd6438c7a24	120.33	111
112	default	waiting	unknown		2017-12-02 22:51:37.650594+00	2017-12-02 22:51:37.650614+00	66855	USD	151.68	89.12	0.00		Frank	Gray	811 Carter Mountain		Hannahchester	62049-9812	LR			187.47.174.29			a6aa5bd9-4e10-4f32-bd6a-dda6f4261a22	0.00	112
113	default	confirmed	unknown		2017-12-02 22:51:37.690249+00	2017-12-02 22:51:37.692395+00	30014	USD	381.59	26.43	0.00		Mary	Garcia	5859 Cruz Bypass Apt. 034		Lake Michael	34377	KN			42.193.37.157			4b10c0ba-30ef-4c97-9533-a9a9f7026e9a	381.59	113
114	default	waiting	unknown		2017-12-02 22:51:37.730561+00	2017-12-02 22:51:37.730593+00	90768	USD	389.79	30.59	0.00		Colton	Hopkins	763 Franklin Crossing Apt. 276		South Charlesmouth	80806	IE			177.76.66.88			0387a8e5-0d6e-45d2-a2a0-4393a683122b	0.00	114
115	default	preauth	unknown		2017-12-02 22:51:37.774634+00	2017-12-02 22:51:37.774663+00	59106	USD	439.17	93.31	0.00		Amanda	Taylor	45969 Christina Track		West Cameronchester	93428	TR			125.105.66.246			617e2907-3181-4729-98be-7e77193028b6	0.00	115
116	default	preauth	unknown		2017-12-02 22:51:37.800548+00	2017-12-02 22:51:37.80058+00	25785	USD	62.03	59.93	0.00		David	Little	763 Stewart Road Apt. 874		Francisstad	66404	TN			99.82.168.183			809d686e-7df3-4fc5-b847-fcf6a61ac1ff	0.00	116
117	default	confirmed	unknown		2017-12-02 22:51:37.829704+00	2017-12-02 22:51:37.831331+00	3970	USD	230.97	76.23	0.00		Christy	Acosta	10126 John Ridge Apt. 770		Gallegoston	25270-1122	BN			253.39.111.74			f4631b2a-55c9-4428-898b-e652578a3a7a	230.97	117
118	default	confirmed	unknown		2017-12-02 22:51:37.876744+00	2017-12-02 22:51:37.878897+00	87003	USD	217.90	99.54	0.00		Robert	Hill	81538 Moore Cape Apt. 113		Walterview	49996	GD			57.231.253.122			42a89b7a-5f89-4034-bcc2-da952b90ca6b	217.90	118
119	default	confirmed	unknown		2017-12-02 22:51:37.923328+00	2017-12-02 22:51:37.925787+00	71199	USD	502.33	30.59	0.00		Hayley	Clark	4238 Hall Row		East Victoriaville	60107	BS			119.46.0.8			57c6d7e7-3748-44fb-bb41-be6ef37cb5bc	502.33	119
120	default	preauth	unknown		2017-12-02 22:51:37.957986+00	2017-12-02 22:51:37.958016+00	6502	USD	393.55	11.70	0.00		Rebecca	Woods	52974 Mary Pine Apt. 956		Parrishview	41337-6450	CG			39.107.250.133			4b2429a3-3fd2-43ff-88e8-5ea767a26d4c	0.00	120
121	default	waiting	unknown		2017-12-03 17:37:33.439985+00	2017-12-03 17:37:33.440024+00	42999	USD	758.79	93.31	0.00		Debra	Smith	8520 Reed Parks		Danielburgh	44868-2597	MU			230.159.168.169			1f653b9e-c904-4df3-b1b1-1e0b7761a1e3	0.00	121
122	default	preauth	unknown		2017-12-03 17:37:33.479651+00	2017-12-03 17:37:33.479672+00	22676	USD	203.17	37.18	0.00		Bruce	Payne	984 Williams Flat Apt. 708		Stephenton	74324	PK			229.102.29.73			6de15114-197f-49ea-b34f-607159761349	0.00	122
123	default	preauth	unknown		2017-12-03 17:37:33.52947+00	2017-12-03 17:37:33.529499+00	464	USD	621.40	50.00	0.00		Yolanda	Banks	64596 Charles Oval Suite 091		Kellyberg	06172-3161	TV			49.5.106.116			9e1d0e49-e6a3-4879-a52e-1327005319d9	0.00	123
124	default	waiting	unknown		2017-12-03 17:37:33.563707+00	2017-12-03 17:37:33.563738+00	11512	USD	434.85	59.93	0.00		Rachael	Garcia	709 Smith Ranch		Odomshire	49018	PG			188.25.35.12			df87bd5e-dcb0-4aca-9f41-0b3a288bf7c2	0.00	124
125	default	confirmed	unknown		2017-12-03 17:37:33.594067+00	2017-12-03 17:37:33.59637+00	65481	USD	185.43	2.25	0.00		Dawn	Harper	820 Kristin Hollow Suite 993		Jenniferhaven	70862-3295	IQ			244.90.250.182			56c0f399-df59-435e-a3c8-8ee2f5751425	185.43	125
126	default	preauth	unknown		2017-12-03 17:37:33.645504+00	2017-12-03 17:37:33.645538+00	72473	USD	600.23	59.93	0.00		Eric	Crawford	98308 Graham Island Apt. 895		East Arianafort	96986	PG			16.0.111.155			855fc50b-9678-45bd-8b95-dfda6721aa5f	0.00	126
127	default	confirmed	unknown		2017-12-03 17:37:33.68177+00	2017-12-03 17:37:33.683506+00	44760	USD	371.40	93.31	0.00		Samantha	Cook	9266 Ronnie Glens		Rosariomouth	52887-9289	VA			17.138.173.101			02af4da7-2352-47f9-9f99-dd47cfde586b	371.40	127
128	default	preauth	unknown		2017-12-03 17:37:33.730097+00	2017-12-03 17:37:33.730119+00	82954	USD	291.03	11.70	0.00		Anne	Hood	16065 Meyers Square Suite 332		East Clinton	15279	NP			240.56.11.10			b72b6b6d-610b-4dea-8795-5b3dd73c467a	0.00	128
129	default	confirmed	unknown		2017-12-03 17:37:33.761264+00	2017-12-03 17:37:33.763067+00	7773	USD	159.18	11.70	0.00		Tanner	Taylor	2763 Shannon Run Apt. 616		Darrellmouth	52214	UA			49.171.226.176			d3df80dd-86de-4642-987b-2c2799ff378b	159.18	129
130	default	waiting	unknown		2017-12-03 17:37:33.801862+00	2017-12-03 17:37:33.801895+00	5762	USD	566.86	99.54	0.00		Daniel	Kelly	642 Natalie Forge		Leviland	13248	TV			22.93.42.43			7f9bed2b-e3ba-4494-b1f7-48a859bb80d9	0.00	130
131	default	preauth	unknown		2017-12-03 17:37:33.830876+00	2017-12-03 17:37:33.830895+00	28694	USD	318.59	37.55	0.00		Kirk	Gomez	511 Davis Highway Apt. 470		West Mirandafort	61008-6490	CF			228.138.62.135			c946ecd6-cf42-4df5-8332-65e88f455b69	0.00	131
132	default	waiting	unknown		2017-12-03 17:37:33.87607+00	2017-12-03 17:37:33.876089+00	35371	USD	463.61	91.59	0.00		Colton	Hopkins	763 Franklin Crossing Apt. 276		South Charlesmouth	80806	IE			157.107.105.7			a820118e-f4d1-4f5f-8aab-fd10c35711cc	0.00	132
133	default	waiting	unknown		2017-12-03 17:37:33.915837+00	2017-12-03 17:37:33.915867+00	38240	USD	722.96	91.59	0.00		Alexander	Young	6771 Reed Creek		North Vanessaton	70706-6837	AO			134.170.83.89			6f9940cf-174f-4e41-b51e-956434b62947	0.00	133
134	default	confirmed	unknown		2017-12-03 17:37:33.951992+00	2017-12-03 17:37:33.95391+00	8073	USD	238.78	16.44	0.00		Megan	Goodwin	03183 James Shore		Jeffreyhaven	61736-8431	GH			69.241.0.140			4b57bdd7-56ca-4a22-84c1-c255fdfb049b	238.78	134
135	default	confirmed	unknown		2017-12-03 17:37:33.994694+00	2017-12-03 17:37:33.996563+00	41842	USD	208.29	99.54	0.00		Jesse	Wheeler	151 Jackson Ville		Brownview	83395-7473	EE			254.98.140.194			3a9bc682-1e6d-4999-9e28-58d49aa85ec5	208.29	135
136	default	preauth	unknown		2017-12-03 17:37:34.045733+00	2017-12-03 17:37:34.045764+00	79638	USD	563.02	89.12	0.00		Heather	Petty	822 Larry Center		Lake Angelicafort	48172-9634	AT			65.45.5.72			5345dfa5-1fbf-4426-b9aa-6a04a0016002	0.00	136
137	default	waiting	unknown		2017-12-03 17:37:34.08287+00	2017-12-03 17:37:34.082891+00	5957	USD	730.07	76.23	0.00		Erin	Black	4320 Stanley Springs Suite 185		Clarkeshire	02366	BJ			227.243.147.20			695ca1fe-631c-48ad-a393-3ef0703382a6	0.00	137
138	default	waiting	unknown		2017-12-03 17:37:34.110092+00	2017-12-03 17:37:34.110122+00	46871	USD	78.07	37.55	0.00		Samuel	King	4212 Clark Garden		Aaronhaven	72054-0164	ME			4.68.78.22			302c89de-67f5-4f17-9096-142a2630bc6b	0.00	138
139	default	confirmed	unknown		2017-12-03 17:37:34.143861+00	2017-12-03 17:37:34.145773+00	4826	USD	625.34	50.00	0.00		James	Watts	64038 Sanders Stream		Port James	52753	TD			29.85.213.163			10846e7b-53cb-4767-9098-0a91f8af067c	625.34	139
140	default	preauth	unknown		2017-12-03 17:37:34.184514+00	2017-12-03 17:37:34.184535+00	41656	USD	376.73	11.70	0.00		Mark	Stark	1716 Donna Camp		North Johnstad	60486	PK			10.74.162.250			564014c9-770f-41e6-adcf-b09b604b1a26	0.00	140
\.


--
-- Data for Name: product_attributechoicevalue; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_attributechoicevalue (id, name, color, attribute_id, slug) FROM stdin;
1	Blue		1	blue
2	White		1	white
3	Round		2	round
4	V-Neck		2	v-neck
5	Polo		2	polo
6	Saleor		3	saleor
7	XS		4	xs
8	S		4	s
9	M		4	m
10	L		4	l
11	XL		4	xl
12	XXL		4	xxl
13	Arabica		5	arabica
14	Robusta		5	robusta
15	100g		6	100g
16	250g		6	250g
17	500g		6	500g
18	1kg		6	1kg
19	Sour		7	sour
20	Sweet		7	sweet
21	100g		8	100g
22	250g		8	250g
23	500g		8	500g
24	John Doe		9	john-doe
25	Milionare Pirate		9	milionare-pirate
26	Mirumee Press		10	mirumee-press
27	Saleor Publishing		10	saleor-publishing
28	English		11	english
29	Pirate		11	pirate
30	Soft		12	soft
31	Hard		12	hard
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_category (id, name, slug, description, hidden, lft, rght, tree_id, level, parent_id) FROM stdin;
1	Apparel	apparel	Ipsa corporis deleniti impedit quae sed tenetur incidunt. Illum eum alias dolores facilis delectus sint repellendus. Quibusdam nihil corporis fugit.	f	1	2	1	0	\N
2	Accessories	accessories	Quo mollitia quo inventore vel. Repudiandae beatae corporis harum. Nihil non amet dolor. Quibusdam earum sint esse modi quo praesentium voluptate.	f	1	2	2	0	\N
3	Groceries	groceries	Tenetur ducimus ipsum eveniet possimus laboriosam illo dolores. Veritatis accusantium ad quasi facilis. Nemo soluta perferendis ab corporis. Unde quos magnam quod neque quos unde.	f	1	2	3	0	\N
4	Books	books	Laborum aliquam reiciendis ad eos minima nihil. Totam deleniti earum facilis animi animi autem. Quas facere eum neque quae placeat blanditiis. Quam dolore recusandae officiis odit ex quos.	f	1	2	4	0	\N
\.


--
-- Data for Name: product_product; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_product (id, name, description, price, available_on, updated_at, product_class_id, attributes, is_featured, is_published) FROM stdin;
87	Krueger LLC	Placeat non soluta quod mollitia minima. Quibusdam nulla praesentium nihil delectus.\n\nAlias ut quasi molestiae quidem ullam rem nam. Iste quas nobis nobis magni.\n\nEx iure sapiente excepturi itaque impedit iste consequatur. Ullam quod rem quaerat blanditiis aspernatur. Sapiente aspernatur consequuntur dolore voluptatum ea laboriosam. Aliquid et aspernatur atque nisi non ipsam ullam.\n\nAperiam sapiente enim consequuntur maxime officia. Inventore repellendus dolorum dolorem. Quae numquam illo consectetur. Reiciendis laudantium neque sed delectus.\n\nCupiditate ullam rerum sint magnam. Temporibus minima ullam quo numquam quos. Blanditiis architecto molestias ipsam magnam ratione cumque. Quam illum ea eligendi rerum tempore inventore.	34.78	\N	2017-11-27 23:21:08.300534+00	3	"3"=>"6", "5"=>"13"	f	t
2	Hodges, Jennings and Vega	Voluptatibus ipsa temporibus distinctio voluptatibus eum eum quam. Tenetur quae deserunt dignissimos minus excepturi magni reprehenderit. Amet sapiente debitis perferendis fugit id adipisci.\n\nSimilique ullam maxime dicta minus suscipit. Maiores a quas tempore ipsam eum incidunt tempore inventore. Incidunt nisi nemo quo non.\n\nDolorem rem non amet voluptates distinctio accusantium molestias aperiam. Ipsam voluptas non totam cumque nostrum distinctio fuga. Vitae similique exercitationem sequi rerum sed. Sequi temporibus nam eaque.\n\nSoluta voluptates soluta doloremque ab occaecati assumenda dignissimos. Delectus natus ea neque alias tempora eligendi inventore. Iste earum quis nostrum neque. Praesentium debitis veritatis porro ea cum.\n\nCorporis perspiciatis odit necessitatibus accusamus. Quia perspiciatis ea exercitationem aperiam dolorum accusantium. Unde soluta tempora odio voluptatum. Cumque recusandae aspernatur laborum nisi ad explicabo voluptas.	47.40	\N	2017-11-22 20:26:54.211385+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
4	Edwards PLC	Non nihil veritatis id magni quisquam. Assumenda cum non ex odio quo labore ullam occaecati. Nesciunt corrupti nemo eveniet.\n\nUnde modi magnam quae provident commodi rem earum. Enim esse quasi libero deserunt adipisci quisquam. Hic mollitia quidem tempore explicabo. Quo asperiores blanditiis reprehenderit velit repellat magnam maiores. Ducimus eum nemo vero occaecati.\n\nIllo unde ab non iure inventore possimus. Recusandae similique sed sint id. Expedita molestiae alias iste ducimus consequuntur sed. Provident quis ipsum ratione saepe.\n\nDebitis rem vero soluta fugiat consequatur doloremque totam. Dolorem exercitationem reiciendis assumenda sapiente quos ratione tenetur. Ullam iste libero iusto dicta illo eum.\n\nDolorem suscipit corrupti ad suscipit. Voluptate cumque tenetur autem voluptates. Corrupti sequi officia impedit mollitia nesciunt esse corporis. Quisquam eaque quas explicabo numquam quos.	12.68	\N	2017-11-22 20:26:54.308226+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
5	Brandt-Oneal	Totam libero ex voluptatibus atque. Tempore ad accusantium incidunt molestiae quidem quae. Necessitatibus accusantium quasi temporibus odio. Accusantium harum odio cumque velit perferendis.\n\nFacere deserunt odio adipisci aut inventore maiores. Et neque nobis alias hic error labore exercitationem. Corrupti iste inventore itaque ipsa sit asperiores quae quis. Numquam quod explicabo odit veritatis beatae necessitatibus.\n\nFacere modi dicta temporibus. Sint fugiat tenetur maiores provident. Cum deleniti voluptatum quia voluptatem corrupti.\n\nEveniet pariatur ad temporibus fugit beatae. Quidem iste alias dolore incidunt possimus. Sint sapiente veniam cumque velit cum odio.\n\nLaboriosam inventore a fuga soluta. Placeat quia ea dolore similique quo tempore eaque. Eaque laborum tempora repudiandae qui.	38.26	\N	2017-11-22 20:26:54.36866+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
13	Saunders Group	Ullam inventore laborum provident molestias. Tempora non minima molestiae distinctio itaque. Culpa quia animi quaerat sit ducimus.\n\nAtque non occaecati aspernatur. Necessitatibus ab dolore nesciunt voluptates optio minus. Quis vel possimus earum.\n\nQuaerat illo neque vero voluptatem. Adipisci sapiente dolor nisi. Ipsa necessitatibus quaerat deleniti dicta delectus tempore ipsam. Ab reprehenderit suscipit nisi amet aperiam est. Suscipit animi vero atque incidunt excepturi maxime quibusdam.\n\nEt unde vel assumenda voluptas delectus nobis quisquam. Ut nostrum dolor mollitia. Deserunt debitis nihil vero sint numquam quam.\n\nVeritatis illo ratione odit magnam accusantium distinctio officiis. Ad voluptates quae voluptatum velit et fugiat laudantium recusandae. Doloremque voluptate eveniet dignissimos aliquid nam labore. Excepturi quis quia rem molestiae.	98.42	\N	2017-11-22 20:26:54.824961+00	2	"3"=>"6"	f	t
7	Walton, Allen and Romero	Fugiat numquam placeat ullam. Quas tenetur tempore amet fugiat vel autem. Eveniet eius impedit molestiae esse fuga. Accusantium maxime dignissimos ipsam.\n\nQuis aperiam praesentium delectus sequi provident blanditiis. Deserunt cupiditate maiores placeat non deserunt dolorem optio. Quos fugiat sit id. Quis autem sint aspernatur aliquid omnis.\n\nSaepe corrupti esse dignissimos eveniet. Earum saepe sit placeat occaecati. Ad sed aliquam ut reiciendis magni.\n\nTemporibus quaerat perspiciatis dignissimos est. Ducimus ullam tempora sapiente nobis porro sit.\n\nEx exercitationem corrupti occaecati laudantium. Nulla nostrum deserunt quisquam officiis. Similique nulla velit quas assumenda quidem nesciunt.	83.52	\N	2017-11-22 20:26:54.521645+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
8	Cameron PLC	Sed incidunt quae aut dolore. Rem quod iste magni exercitationem quis est. Eius harum quia aut laboriosam.\n\nCulpa sapiente quasi tenetur laudantium aliquam. Veniam suscipit sed eos quia. Unde molestiae minus quibusdam odit ex eaque. Quaerat culpa quidem ducimus itaque eligendi nesciunt ducimus.\n\nAnimi odio aliquam facere cupiditate eos. Pariatur repudiandae architecto debitis provident occaecati eligendi inventore nisi. Pariatur praesentium quidem ratione odio perferendis. Deleniti officiis deserunt fugit eum delectus.\n\nQuis voluptatibus non sapiente consequatur provident ratione. Cum accusantium incidunt dignissimos at cum modi at. Consequuntur tempore amet perferendis dolorem dolorem quisquam unde. Repellat dolore blanditiis saepe asperiores aliquid inventore dolores.\n\nNisi aliquid ducimus perspiciatis excepturi iste iste. Unde sequi placeat perspiciatis porro quae cum alias. Ipsa earum assumenda suscipit distinctio.	7.30	\N	2017-11-22 20:26:54.576396+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
10	Griffith-Oconnell	Unde explicabo qui molestias aperiam. Quam occaecati quibusdam deleniti provident. Quae sint necessitatibus veniam. Quis animi ipsam id deleniti libero incidunt voluptatum. Dolorem possimus vero impedit exercitationem.\n\nFugit accusamus eaque commodi nam aspernatur numquam ex. Iste maxime rem placeat repellat sequi optio. Saepe quaerat consequuntur debitis tenetur ab. Cumque ipsa consectetur asperiores hic.\n\nOdit eveniet incidunt quod tempora. Earum earum perspiciatis tempora suscipit nihil. Temporibus magnam laborum dicta rerum ipsa.\n\nAperiam vero ducimus aperiam quia commodi. Sit magni facere dolor aliquid. Quaerat ab quia non suscipit.\n\nAnimi quisquam necessitatibus omnis tempore laudantium perspiciatis. Fugit ipsum incidunt beatae fugiat error. Maxime at earum quod sequi provident voluptatum in.	79.27	\N	2017-11-22 20:26:54.684149+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
11	Perez Ltd	Ex nobis possimus explicabo laudantium aspernatur quia quis aperiam. Sequi odio mollitia libero laboriosam asperiores. Dolorum hic hic placeat exercitationem molestias.\n\nProvident non deserunt minima laboriosam. Maiores quibusdam aliquam numquam officia modi. Totam voluptatum et animi. Et libero quibusdam recusandae doloribus hic.\n\nSint est nostrum dolor voluptates voluptatum tempore eum occaecati. Error totam pariatur vel magni nihil. Placeat modi animi atque alias sed voluptatum neque. Ratione dignissimos natus sapiente rem tempora dignissimos.\n\nEnim accusamus at harum quia sequi. Inventore dicta exercitationem facere qui quia ullam. Quod dolores et pariatur sunt animi nulla. Consectetur fugit autem delectus repudiandae hic.\n\nDignissimos molestiae amet atque nam unde minima ipsam. Rerum ratione magni aspernatur neque unde omnis. Fugit sed iure quas corrupti.	9.22	\N	2017-11-22 20:26:54.756122+00	2	"3"=>"6"	f	t
12	Smith, Wagner and Gomez	Dolore minima harum voluptatem quos. Placeat perspiciatis consequuntur magni adipisci quo. Inventore totam soluta fuga unde.\n\nCumque architecto quidem quo qui optio illum aut. Eligendi quidem at expedita doloribus sit animi. Illum vitae exercitationem voluptates minus. Quos odit aspernatur veritatis fuga.\n\nCorporis alias inventore officiis quisquam fugit eligendi. Assumenda alias sit consequuntur sunt. Corrupti laborum voluptate fuga quae similique voluptatibus sint. Cum fuga sapiente blanditiis perferendis temporibus consectetur sint.\n\nIste exercitationem explicabo corporis impedit ex. Quis placeat nihil quos. Optio rem provident incidunt fugit voluptates laudantium necessitatibus. Perferendis rerum iusto vero nostrum.\n\nSuscipit facilis iusto debitis. Eos officia reiciendis perspiciatis aut explicabo culpa. Aliquam odit quis maxime nobis. Error inventore deleniti dolor perspiciatis doloremque tempore quaerat soluta. Incidunt explicabo eius molestias.	82.85	\N	2017-11-22 20:26:54.794989+00	2	"3"=>"6"	f	t
9	Watson Group	Aliquid quod sed facere eligendi. Ipsa doloremque nulla laudantium ipsum id alias. Possimus a culpa sapiente suscipit ex quidem maxime. Vitae repellendus veniam labore iusto odit.\n\nIncidunt quam hic necessitatibus itaque. Consectetur sapiente autem est quis. Dicta eos quos aliquam eum excepturi perferendis qui. Doloribus ducimus delectus tenetur est maiores.\n\nDolores iure numquam tempora neque. Veniam nesciunt nihil velit animi aspernatur totam. Atque vero repudiandae nesciunt eum deleniti recusandae. Voluptatibus laboriosam cumque laboriosam beatae est perferendis quo.\n\nHarum unde vitae quis. Similique voluptatum reiciendis mollitia iure tenetur aperiam. Voluptatem maxime molestiae error.\n\nDolorem eaque placeat doloribus minus temporibus similique. Repellat voluptatum minus animi qui. Quas corrupti sunt suscipit nam expedita. Rerum iure expedita fuga eius dicta autem pariatur.	81.64	\N	2017-11-22 20:26:54.634254+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	t	t
16	Thompson, Spencer and Wallace	Iure velit ab minima adipisci. Id asperiores unde ullam quia unde. Fugit architecto fuga expedita autem amet suscipit rerum.\n\nAutem laudantium iusto vitae modi temporibus fuga blanditiis laborum. Doloremque eveniet facere temporibus nobis perferendis enim sunt. Voluptate facere dolores quos fuga. Ratione saepe eum amet odio excepturi voluptates distinctio.\n\nEa consequuntur ex quaerat earum. Similique quasi sint dolorum aliquam. Sint similique voluptas at quisquam adipisci perferendis. At tempora mollitia mollitia eveniet quisquam facere tempora.\n\nTenetur saepe accusantium ad et. Facilis dolores consequatur consequatur ducimus. Accusantium tenetur ratione ab.\n\nExercitationem illo ex optio maxime. Nihil perspiciatis quas sed.	90.22	\N	2017-11-22 20:26:54.907601+00	2	"3"=>"6"	t	t
15	Campbell-Doyle	Quo aperiam occaecati earum ex a similique. Accusamus recusandae aliquam nihil totam officia eum. Harum ipsum quod est blanditiis maxime. Aperiam tempore facere voluptate facilis.\n\nVoluptatem optio totam cupiditate aut totam adipisci provident. Numquam delectus repellat voluptates asperiores corporis magnam impedit. Accusamus expedita explicabo at mollitia. Numquam doloremque nulla cupiditate fuga fuga facilis.\n\nQui quam laboriosam impedit recusandae officia aliquam expedita. Omnis ex dolorum praesentium ut esse optio maxime. Maiores porro cum modi facere modi itaque voluptas. Sit vitae tempore aut aliquid ea illo.\n\nOdit praesentium nam omnis maxime debitis at. Ipsa ipsum itaque harum. Velit asperiores omnis corrupti consectetur. Iure labore cumque impedit voluptas commodi sit.\n\nEius repellat sint maiores amet nesciunt facere quis. Ratione repellendus delectus sed suscipit. Ipsum occaecati praesentium in ipsam nihil.	33.50	\N	2017-11-22 20:26:54.876596+00	2	"3"=>"6"	t	t
18	Burnett-White	Sit ab veritatis hic distinctio fugiat velit. Eveniet dicta possimus eum sint autem fugit. Quisquam enim perspiciatis ab ab. Voluptate unde similique nam ullam laborum ad sint.\n\nCommodi rerum nihil optio placeat a incidunt sint. Cupiditate expedita autem distinctio placeat autem.\n\nDucimus voluptates pariatur placeat quae dignissimos tempore quaerat. Ea sunt saepe rem nobis corporis corrupti vitae. Voluptatibus dicta nulla cupiditate molestias. Dolore dolor alias praesentium rem.\n\nDucimus optio deserunt esse quaerat voluptas voluptate. Inventore voluptatibus veritatis exercitationem aperiam. Repellat illum voluptatibus saepe quam quia. Dolorum praesentium quam saepe sunt doloribus dolorem.\n\nOdit a id dolorem laudantium tempore quo. Quam nemo eligendi suscipit quam aliquid architecto. Similique voluptatem quasi quis nemo unde neque illum mollitia.	85.21	\N	2017-11-22 20:26:54.986959+00	2	"3"=>"6"	f	t
14	Holt, Moore and Kelly	Vitae corrupti esse delectus ipsum. Deserunt quas fugit maiores architecto incidunt. Inventore cum est reprehenderit laudantium doloribus labore. Commodi dolor in optio aliquid molestiae libero laborum suscipit.\n\nNulla eos sint voluptate quos architecto. Tempora possimus voluptatibus nobis accusamus. Molestias atque minus repellendus dignissimos deleniti exercitationem.\n\nTempore aliquid voluptas odit consequatur dignissimos. Tempora rerum dolorem nisi itaque blanditiis officia perferendis. Eos commodi soluta hic dolor.\n\nVoluptates repellat earum non ab voluptatibus dolorem. Quod repellat placeat fuga natus blanditiis deserunt assumenda. Occaecati esse animi explicabo deleniti. Fugiat distinctio nam expedita debitis officia ratione.\n\nExplicabo modi debitis earum. Impedit nisi ipsum nisi error. Assumenda consequatur quasi natus praesentium magni unde. Cupiditate aperiam explicabo quam debitis perspiciatis veniam.	39.99	\N	2017-11-22 20:26:54.855021+00	2	"3"=>"6"	t	t
21	Jones, Martin and Barrera	Fugiat impedit officia debitis provident quas tempore. Tenetur sapiente explicabo ex esse voluptates. Eaque est eligendi ex nisi.\n\nVeritatis eaque odio necessitatibus culpa alias debitis molestias. Fugit eveniet praesentium similique cum velit temporibus pariatur. Minus repellendus dicta voluptas voluptatum libero dicta provident. Cupiditate magni quam architecto facilis reprehenderit quaerat. Odio recusandae adipisci iste voluptates.\n\nEius veniam aut atque sit ad. Nihil laboriosam officia ratione. Labore inventore voluptates error eligendi commodi assumenda neque repudiandae. Repellat aliquid facilis consequuntur libero reprehenderit.\n\nFugit itaque suscipit eius debitis fugit. Animi ad inventore corporis. Ullam voluptates illo quam quod quaerat tempora eum. Illo debitis assumenda fugiat ex mollitia.\n\nIn accusamus a id vero hic praesentium. Corporis dolorem nihil fugiat voluptate voluptatibus dolore nisi. Nam itaque minus laudantium deleniti repellendus repudiandae. Suscipit natus iusto eveniet expedita accusantium exercitationem quis.	18.51	\N	2017-11-22 20:26:55.089464+00	3	"3"=>"6", "5"=>"14"	f	t
53	James-Carter	Dignissimos vel commodi quis dolorum nemo. Id ullam quos ab quas praesentium. Eos error ipsum odit recusandae dolor eius suscipit. Quis fugit aliquam hic provident.\n\nDolorem deserunt aliquam explicabo. Nesciunt aliquam minus ut ab perferendis.\n\nFacilis inventore quis error voluptatum error hic vitae. Laudantium laboriosam fugiat aperiam iste vitae dolorum. Iusto ut quia sequi facere aspernatur voluptas.\n\nMinima sunt deleniti atque ad dolore. Debitis beatae ullam voluptates corrupti. Possimus tempora tenetur nobis nihil aperiam. Ea aliquid dicta laboriosam repudiandae tempore quas.\n\nQuo numquam rerum eaque asperiores nemo. Adipisci quidem harum necessitatibus magni sapiente nam. Veniam assumenda dicta saepe et quibusdam exercitationem minus. Ad quasi aspernatur harum consectetur quia natus.	83.32	\N	2017-11-22 20:26:56.680806+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	t	t
23	Bullock PLC	Temporibus optio aliquam deleniti quam quae dolor perferendis. Enim ducimus alias quas. Eius suscipit neque vel hic ad. Inventore ea ullam reprehenderit molestiae.\n\nRem magnam sapiente eligendi vel. Dicta dicta exercitationem cupiditate sequi neque doloremque necessitatibus. Necessitatibus at tempora delectus deleniti soluta doloremque. Placeat ipsam commodi dolore explicabo eius debitis soluta.\n\nVel optio neque id quo nam reiciendis autem dolores. Voluptate quo et ipsum vitae vel commodi itaque. Velit praesentium iusto officiis aperiam.\n\nVoluptates optio exercitationem occaecati. Repellat iusto pariatur adipisci illum. Nesciunt quasi cum error aliquid tenetur temporibus.\n\nEnim blanditiis officia accusamus adipisci doloribus. Cumque tenetur sint minima laboriosam id. Similique tempore dolorum alias iusto a. Quod ratione qui ad exercitationem odit.	46.38	\N	2017-11-22 20:26:55.184692+00	3	"3"=>"6", "5"=>"14"	f	t
24	Strickland LLC	Eos necessitatibus temporibus et minima. Maiores aliquam eum suscipit et voluptatibus. Ab saepe incidunt consequatur tempore quae illum. Facere expedita distinctio adipisci in veritatis quisquam.\n\nVelit fugiat doloremque eum quo cupiditate. Rem nemo ullam voluptatem ratione laudantium. Numquam dignissimos quam aperiam aspernatur sequi debitis omnis.\n\nDucimus aperiam temporibus deserunt id. At qui tempore corrupti iusto deserunt. Dolor distinctio excepturi consequuntur delectus facere. Est eos corporis ut nobis quidem a dolorem.\n\nLabore doloribus modi totam provident blanditiis. Pariatur aspernatur nemo error minus rerum a doloremque. Dolorem molestias nostrum quasi porro. Ullam commodi illo ducimus omnis odio. Rem quibusdam occaecati dicta.\n\nSapiente ea officia magni placeat veritatis. Architecto dolorum iste eligendi tempore nisi natus. Tempore corporis libero dolorum voluptate.	49.77	\N	2017-11-22 20:26:55.23349+00	3	"3"=>"6", "5"=>"13"	f	t
25	Jackson and Sons	Ab repudiandae rerum libero laudantium magnam voluptates vel. Voluptatem eos modi quas explicabo voluptatem. Dignissimos consequuntur facilis officiis nam similique animi consectetur.\n\nPerspiciatis maiores quia cupiditate repellat perspiciatis. Officiis repellendus voluptate rem necessitatibus inventore itaque dolorum. Saepe eligendi nihil vero inventore porro quisquam. Amet repellat odit architecto.\n\nQuo sit vero eligendi. Nisi consequatur iste neque sit suscipit doloribus exercitationem. Impedit sed velit quia asperiores. Pariatur quidem omnis rem facere unde delectus.\n\nBeatae cum voluptatibus rem corrupti sapiente quibusdam. Consectetur beatae voluptas accusamus laboriosam. Sint nemo voluptates aut fugiat asperiores autem. Quibusdam quam veritatis nobis exercitationem dolor quia ea.\n\nLaboriosam sunt voluptas eligendi natus voluptate natus. Quia numquam assumenda nihil. Fuga vero aut tempora eius. Ipsa eum voluptas quas magni id.	74.47	\N	2017-11-22 20:26:55.285239+00	3	"3"=>"6", "5"=>"13"	f	t
54	Roman-Meyer	Quae dolore laboriosam odit molestias sapiente. Aliquid minima beatae adipisci quibusdam assumenda. Expedita voluptatem nam quisquam vel rem. Dolor occaecati vel quis vel voluptatibus similique.\n\nAccusamus voluptatibus ducimus vel rerum iusto. Ut dolorum explicabo ullam. Veniam quidem autem consequatur provident. In consequatur ducimus aliquam error.\n\nRepellat itaque omnis ipsam magnam excepturi minus. Nesciunt nobis earum dolores in. Repellat dolorum blanditiis consequuntur praesentium sequi quis.\n\nNatus quod rerum et minus consectetur commodi reiciendis. Dignissimos at impedit laborum deserunt similique. Accusamus cum deserunt vel alias aliquid esse.\n\nCulpa voluptatibus voluptatem autem ipsum harum. Autem reprehenderit deleniti animi laudantium mollitia iste distinctio asperiores.	56.37	\N	2017-11-22 20:26:56.719516+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
22	Gardner Inc	Maxime magnam omnis repellat ipsum. Est tempora incidunt officia quo aspernatur enim unde. Omnis corrupti est saepe quisquam nostrum.\n\nCommodi vitae facere doloremque eum. Odit quisquam quis eum laborum odit illum. Aut placeat sapiente est enim eaque. Sapiente voluptas excepturi perspiciatis doloribus. Provident maiores error laborum nam officiis itaque quod accusantium.\n\nAut eligendi reiciendis sit eligendi sed. Ipsam animi id sit eaque quos.\n\nMolestias ab odit non illum nam repudiandae possimus at. Suscipit architecto necessitatibus fugit iure tempore dignissimos. Officia voluptatum iste ullam architecto alias. At molestias eum labore voluptates dolore ducimus.\n\nAliquam aspernatur officiis fugiat placeat mollitia aliquid eius. Inventore est repudiandae enim iusto culpa culpa praesentium. Nam quos tenetur pariatur quos eligendi. Mollitia pariatur magni ad totam deserunt culpa.	1.48	\N	2017-11-22 20:26:55.138876+00	3	"3"=>"6", "5"=>"14"	t	t
26	Pierce Inc	Dignissimos quibusdam aspernatur architecto architecto corrupti ad. Aperiam quis consequatur perferendis doloremque tenetur. Eligendi placeat assumenda ipsa ratione corporis labore temporibus.\n\nQuasi molestiae aspernatur nemo perferendis voluptatem. Ipsam ullam eum aspernatur laboriosam quidem vero. Animi atque explicabo repellat voluptatibus. Architecto consequuntur dolore ut iste rerum reprehenderit corporis.\n\nSapiente illo unde ipsam. Voluptas excepturi recusandae ducimus consequatur ipsa culpa voluptate facilis. Consectetur facere molestias reiciendis odio ipsam esse.\n\nDelectus voluptas sit odio autem. Aperiam quis cupiditate voluptatem dolor. Recusandae omnis ratione eveniet repellat quod quae nisi. Perspiciatis ex doloremque non.\n\nVoluptas praesentium illum natus hic quos dicta dolores. Incidunt nam assumenda quisquam nihil in iusto. Necessitatibus eaque deleniti possimus.	52.33	\N	2017-11-22 20:26:55.327797+00	3	"3"=>"6", "5"=>"14"	f	t
27	Ferguson Ltd	Quas laborum tenetur fugit. Quasi odit ad expedita aperiam. Eveniet enim eos nisi dolorum. Itaque ipsum iste labore dolor ullam veniam voluptas.\n\nMagnam quaerat alias iure eveniet enim magni fuga. Consequatur repellendus hic quod delectus temporibus officia tempora. Maiores soluta minus rerum fuga magni quidem in.\n\nVeniam quas voluptatum cum explicabo similique est omnis. Voluptas omnis quod ipsum soluta ad. Nemo architecto eius pariatur culpa nobis.\n\nBlanditiis error earum placeat aliquid sapiente fuga. Velit ex nisi voluptate delectus autem laborum. Nam asperiores ad labore at modi pariatur molestiae.\n\nIste praesentium ducimus possimus dolore itaque minus. Minima harum modi aspernatur quod asperiores distinctio repudiandae. Ad vel est culpa magnam ut.	5.13	\N	2017-11-22 20:26:55.374423+00	3	"3"=>"6", "5"=>"14"	t	t
29	Lee-Luna	Dicta illum enim quos deserunt voluptatibus. Provident temporibus provident accusamus dolore quia harum. Omnis nulla maxime nam ratione. Eveniet similique sunt nobis mollitia nemo.\n\nQuisquam voluptatum aut velit hic. Amet ipsum at non perspiciatis impedit. Est occaecati sapiente quas dolores temporibus.\n\nOfficiis voluptate corporis expedita vero libero. Magnam explicabo id deserunt harum ab cupiditate non. Laboriosam iure officia molestias neque architecto amet.\n\nOdio nemo dicta cumque quae optio. Nesciunt soluta minima libero. Nisi nostrum exercitationem corporis modi labore tempora molestias. Sint sed illo quisquam placeat dolorum molestias. Assumenda voluptatibus sit iusto.\n\nQuaerat delectus quaerat beatae. Sapiente eaque quis est aspernatur dolorum. Commodi ipsum exercitationem molestias ab neque explicabo nihil sed.	68.29	\N	2017-11-22 20:26:55.549291+00	3	"3"=>"6", "5"=>"13"	f	t
28	Morgan, Thornton and Johnson	Illo id aut molestiae beatae. Laboriosam amet ad atque dolores non.\n\nDolorum eum repellendus tempora eveniet pariatur nemo. Aspernatur quia harum eum dicta consequatur eius.\n\nAssumenda quo cum veritatis corporis ipsa ducimus cupiditate quia. Dolore voluptatibus voluptatibus nesciunt. Numquam tenetur reiciendis blanditiis. Reiciendis animi impedit quasi ab sunt voluptas velit veritatis.\n\nLaborum vel odit totam reiciendis natus. Aliquid sequi molestiae et repellat ullam. Illo amet voluptatum voluptate. A aut ipsam laudantium illo facere veniam.\n\nMaiores omnis esse voluptatem repudiandae. Quae excepturi totam unde quo cumque deserunt. Quod tenetur deserunt iure voluptate sapiente accusamus mollitia. A harum sunt error aliquam eveniet quae.	62.56	\N	2017-11-22 20:26:55.475203+00	3	"3"=>"6", "5"=>"13"	t	t
30	Kelly-Orr	Tempore assumenda reiciendis distinctio quod. Ea suscipit dolorum nesciunt quam. Quas pariatur rerum eum quisquam dolorum.\n\nId facilis consectetur dolor libero animi consequatur sequi aperiam. Rem distinctio perspiciatis consectetur. Occaecati possimus sequi a animi iure.\n\nEst dolorem eveniet quidem ullam fuga exercitationem. Laboriosam voluptatum magnam sed est nostrum.\n\nItaque mollitia odio quasi adipisci ullam quia iure. Distinctio perferendis laudantium itaque. Quaerat architecto dolor inventore fugiat neque. Dicta aliquam vel sit reprehenderit dolorum voluptatem numquam dolores. Itaque nostrum nobis aliquid at inventore.\n\nFugit minus est quasi atque fugiat. Odio magnam magnam quasi qui perspiciatis.	44.59	\N	2017-11-22 20:26:55.608782+00	3	"3"=>"6", "5"=>"13"	t	t
32	Torres-Peters	Eaque ipsam dolor aspernatur magni alias quibusdam. Delectus cumque corporis illo fugit architecto ipsam voluptatibus. Nulla autem quaerat mollitia minus vero praesentium. Repellendus sint fugiat ducimus ipsam pariatur inventore earum.\n\nNostrum repudiandae magnam cupiditate eligendi repellendus vel vel suscipit. Inventore repudiandae est sed hic dolor molestias. Minus fugiat voluptatem harum libero quaerat. Impedit aperiam quia dolore possimus.\n\nCommodi aliquam laudantium voluptatum harum cupiditate. Consequuntur ducimus odio velit excepturi facere excepturi. Doloribus voluptatem perspiciatis ea aut nesciunt quisquam deleniti consequuntur. Quo adipisci voluptatibus ex. Deleniti corporis a velit nesciunt commodi magnam.\n\nDebitis debitis pariatur odio laboriosam. Accusantium nam facere non modi veritatis ut veritatis. Maxime eum recusandae mollitia fugit ut numquam. Magni autem iste amet animi corrupti fugiat impedit.\n\nRem inventore aut reprehenderit fugiat. Commodi atque asperiores eaque dolore maxime. Optio ab consectetur nobis porro unde aliquid similique. Rem doloremque molestias quidem consequatur saepe praesentium. Soluta mollitia ab laboriosam delectus nemo ex.	55.70	\N	2017-11-22 20:26:55.6969+00	4	"3"=>"6", "7"=>"19"	f	t
33	Marsh-Stephens	Molestiae illo optio quam ad fugit impedit ut. Doloribus repellendus dignissimos porro quos error. Pariatur distinctio voluptate vero quas delectus maxime quos. Alias debitis unde quo soluta. Voluptate est est consequatur doloribus explicabo blanditiis.\n\nMollitia dolore sequi reiciendis veniam et. Nihil vero quibusdam molestias quidem commodi soluta aperiam. Eveniet magni cum autem error sint. Veniam laborum natus minima quas fugiat temporibus qui.\n\nSequi non culpa dolorum expedita consectetur molestiae neque. Culpa id odit odit quae cum. Culpa ex vero fuga repudiandae reprehenderit eligendi eveniet.\n\nItaque ex optio ut eum expedita. Mollitia facilis unde unde reiciendis aliquam. Placeat voluptas voluptates molestias ex numquam doloribus totam. Totam deserunt sed ea quis porro perspiciatis reprehenderit velit.\n\nEligendi qui commodi debitis natus exercitationem. Aliquid voluptas iste magni vitae quibusdam totam. Consequuntur cum nihil labore neque laudantium inventore. Totam necessitatibus amet odit in explicabo et aliquid.	15.14	\N	2017-11-22 20:26:55.750353+00	4	"3"=>"6", "7"=>"19"	f	t
35	Wilson Group	Nam reiciendis placeat consectetur reiciendis. Iusto consequatur itaque vero dicta. Ut facere veritatis impedit maxime. Voluptatum eaque odit minus vero.\n\nDolore est totam architecto laudantium iusto inventore magnam excepturi. Quis sunt laboriosam possimus aliquam culpa tempora. Dolorum nesciunt est maxime quae. Non illo vitae et sint.\n\nSapiente voluptatibus pariatur quisquam. Repellendus illo labore tempore. Dignissimos hic maiores ad fugit non dolorem.\n\nNemo molestias tempore dolore molestias quae ex. Minus repellat ab esse vero voluptatibus non. Nemo minima earum porro ab.\n\nOfficia modi maiores culpa. Odit saepe cumque consequuntur dignissimos. Tempore cupiditate officia repellat quis eius at pariatur a. Ab minima a possimus distinctio blanditiis.	30.40	\N	2017-11-22 20:26:55.852049+00	4	"3"=>"6", "7"=>"19"	f	t
34	Kelly-Cardenas	Earum neque labore aliquid sed eos suscipit. Pariatur vitae quia sunt repellat hic recusandae. Saepe doloremque officiis dolores temporibus.\n\nAsperiores occaecati debitis quo perferendis culpa earum. Voluptates occaecati illo voluptatem quasi quaerat temporibus. Asperiores et asperiores maiores quae ipsum perferendis iste.\n\nAut eos mollitia delectus architecto amet ullam excepturi. Ratione exercitationem accusantium ipsa porro consequatur mollitia. A perferendis nesciunt mollitia earum eius est.\n\nOccaecati ipsam voluptatem amet maxime magni. Fuga animi porro consequuntur eligendi reprehenderit eum nam. Facere iste consequuntur in repellendus.\n\nOfficia eveniet cupiditate soluta ullam sapiente. Ducimus recusandae incidunt repellat recusandae atque dolorem. Reprehenderit quaerat repudiandae laudantium quae mollitia. Quibusdam eveniet vel placeat.	95.75	\N	2017-11-22 20:26:55.797322+00	4	"3"=>"6", "7"=>"20"	t	t
37	Anderson, Mann and Coleman	Nobis repellat explicabo adipisci est possimus sint voluptatibus quidem. Mollitia excepturi dolorum hic explicabo voluptatum ipsum nesciunt. Hic repellat neque doloremque similique. Aperiam quos ipsa consequatur voluptate similique nisi.\n\nQuibusdam suscipit placeat aspernatur debitis nesciunt. Harum ratione et minima esse ipsam pariatur. Et expedita ducimus ipsum eum occaecati laboriosam consequuntur. Vel ab assumenda quas sit suscipit ea quae quos.\n\nRepellendus natus repellendus odio distinctio corporis. Ullam quos eligendi vero id optio. Porro doloribus ea labore eveniet. Alias sapiente placeat amet similique laudantium dignissimos.\n\nAlias nostrum ipsam saepe ducimus. Quas nemo laboriosam doloremque accusamus. Fugit necessitatibus labore quos consectetur libero. Praesentium deserunt animi qui ipsa quasi laboriosam. Totam tempore ducimus consequuntur atque maiores laborum rem.\n\nDolores pariatur unde eveniet cumque magni debitis unde. Veritatis expedita quia dignissimos explicabo nesciunt dolorem. Eum asperiores blanditiis ratione. Impedit provident voluptates doloremque soluta quidem.	70.70	\N	2017-11-22 20:26:55.936797+00	4	"3"=>"6", "7"=>"20"	f	t
39	Graves-Castro	Quis sed velit explicabo et fugit quidem tempore culpa. Distinctio occaecati voluptatibus saepe eaque quae voluptatibus. Amet eos sit dolorum perferendis natus quod atque. Quo dolorum cum voluptates culpa officiis impedit molestiae.\n\nPerspiciatis vitae fugiat rerum illum sapiente totam sed. Excepturi enim cumque provident reprehenderit. Sequi illo mollitia dolorem quod.\n\nPariatur tenetur cupiditate fugiat fugit. Placeat impedit similique rerum voluptates ratione aperiam vitae quod.\n\nIn accusantium placeat culpa accusamus exercitationem consectetur fugiat. Eligendi excepturi fuga tempore pariatur. Impedit cupiditate natus nobis nam nemo.\n\nQuisquam rem explicabo quo aliquid consequatur ut asperiores. Dolorum nihil quos totam fugiat. Saepe consequuntur delectus quis vitae autem minus esse. Laboriosam aliquam qui odit fugit.	58.83	\N	2017-11-22 20:26:56.031439+00	4	"3"=>"6", "7"=>"20"	f	t
40	Meyer-Hart	Qui illum veritatis ex dolore ducimus. Laborum corporis nam eveniet autem minima hic. Dicta aperiam doloremque expedita voluptas modi sit optio aliquam.\n\nMinus ducimus consequuntur quae unde. Vitae commodi voluptate libero repellat perferendis. Earum commodi eveniet numquam consectetur pariatur libero repellat. Saepe voluptates ipsam quas incidunt.\n\nOccaecati reprehenderit quo iure beatae. Doloribus amet numquam excepturi itaque asperiores. Eos similique praesentium error minima distinctio dolores facere.\n\nExercitationem blanditiis provident culpa eveniet laboriosam tempore. Atque adipisci aliquam ad libero sit rerum provident. Soluta odit consectetur consectetur deserunt autem.\n\nAut laborum voluptatem pariatur id quasi assumenda recusandae. In laboriosam accusamus ipsum excepturi beatae ducimus. Hic fugit repellendus minus neque cupiditate. Eum hic officiis culpa suscipit. Veniam et quam officiis hic consectetur cumque ducimus.	83.95	\N	2017-11-22 20:26:56.080084+00	4	"3"=>"6", "7"=>"19"	f	t
41	Boyd-Wheeler	Nulla quod ullam animi dicta consectetur. Nihil officia placeat soluta. Aliquid fuga autem commodi nobis facere magni.\n\nCumque accusamus quidem aut sunt neque autem. Nulla eius voluptate aspernatur aut magni. Est minima quaerat placeat placeat reiciendis nihil quas.\n\nEnim aliquam provident vitae ratione similique temporibus. Explicabo aut libero doloribus dolorum assumenda doloribus aspernatur. Voluptas beatae dolorem molestias dolorem voluptatem ad. Ipsum deleniti nulla velit dolores minima. Veniam in quia et porro similique autem harum debitis.\n\nNostrum facilis voluptatem optio recusandae esse et quisquam. Similique aliquid debitis placeat molestiae aperiam libero. Unde suscipit nam ducimus dolore laborum.\n\nDoloribus incidunt odio officiis illum. Ipsa praesentium doloribus et fuga sequi consectetur. Sit tempore maxime illo explicabo excepturi ducimus dolorem molestiae. Est dolorum tempora voluptates assumenda.	64.99	\N	2017-11-22 20:26:56.133732+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	t	t
45	Gray Inc	Accusantium doloribus cumque tempora placeat. Labore alias soluta vitae consequatur neque. Voluptas ad ut expedita exercitationem assumenda consequatur eos.\n\nQuibusdam odit alias repudiandae maiores. Et neque doloribus expedita maiores. Ratione eius pariatur exercitationem eos fuga.\n\nFacere nihil explicabo cupiditate iusto provident. Odio aperiam eos quis soluta doloremque nihil. Ad libero quas eveniet quisquam quod. Explicabo atque blanditiis blanditiis ea.\n\nRatione dolorum magni eaque numquam natus pariatur natus. Soluta cum excepturi odio libero. Minima recusandae animi quasi dolore eaque repudiandae molestiae libero.\n\nQuae doloremque ipsum iure doloribus dolorem. Ipsum doloremque deleniti incidunt reiciendis quo adipisci facere. Odit non soluta officiis magni minus facere sunt enim. Consectetur pariatur earum aliquid harum quidem.	50.43	\N	2017-11-22 20:26:56.295966+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
43	Bishop-Mclean	Ipsum dolor dicta asperiores rem ut maiores. Fugiat nostrum saepe officia aspernatur distinctio facere suscipit delectus.\n\nImpedit laborum possimus repudiandae commodi optio. Soluta accusantium eligendi nisi quod hic optio. Accusamus eos dolores veniam quam dolorem repudiandae dolores. Dolores laboriosam repellat reprehenderit sit.\n\nSequi fugit ullam cum similique repudiandae esse voluptatum. Ipsa facilis odio quasi commodi vero nam. Beatae officia dicta eius dignissimos porro.\n\nIncidunt aspernatur vel commodi saepe sint laudantium ipsam natus. Debitis exercitationem ratione occaecati totam illo deserunt voluptatum commodi. Recusandae accusamus maxime vero eveniet quos sapiente dolores. Aliquid nam praesentium rem reiciendis.\n\nQui distinctio fuga aut necessitatibus. Magni pariatur iure facere doloremque nulla voluptatibus provident. Ipsam numquam excepturi veritatis nihil autem. Architecto quae cupiditate temporibus tenetur mollitia.	52.31	\N	2017-11-22 20:26:56.218417+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
44	Cooper-Johnson	Impedit sapiente illo ratione expedita hic. Voluptatem delectus praesentium animi nobis sed eveniet. Ea labore maiores tempora esse temporibus praesentium.\n\nPraesentium similique ratione similique ipsam fugiat totam non. Eveniet et cupiditate minima ex enim. Eius vitae minima aperiam aliquam sunt quam. Ipsum quidem repudiandae id optio.\n\nModi accusamus optio nihil saepe. Repellendus cum quos veritatis doloremque. Voluptas reiciendis sapiente expedita nulla.\n\nVitae molestiae laudantium sequi. Enim in minima tenetur. Dolorem in consequuntur quam consectetur deleniti nostrum accusamus.\n\nImpedit architecto nulla ex praesentium quisquam ipsum ab vel. Nisi minus eum ab rem. Quam odio optio commodi dicta quis atque. Quam consequuntur modi nisi quo non magni.	38.52	\N	2017-11-22 20:26:56.245823+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
52	Thompson, White and Moore	Perspiciatis laboriosam dolor nisi aut vel. Facilis dolores mollitia eveniet aperiam quia. Magnam in nihil voluptatum dignissimos perferendis sequi.\n\nEnim assumenda similique accusantium facilis amet facere quibusdam molestias. Quos cupiditate maiores officiis numquam vero voluptas labore. Ipsa sequi similique voluptatum.\n\nExercitationem quo ullam odit eveniet vel hic unde. Nulla illum accusamus amet nulla. Facilis et velit vero quas.\n\nVoluptatibus provident itaque ex repudiandae ullam expedita. Laborum maiores culpa repellendus vitae. Unde nemo voluptatibus voluptatibus totam itaque perspiciatis magnam.\n\nNon eos enim tempore provident. Recusandae aliquam dignissimos adipisci inventore.	59.50	\N	2017-11-22 20:26:56.622579+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	t	t
48	Curry-Miller	Ut fugit tenetur quo sed. Nihil exercitationem a dignissimos consectetur necessitatibus porro fuga. Cumque quae veritatis dolorem qui nemo.\n\nCorrupti sapiente aspernatur sed consectetur maiores accusantium modi. Ratione praesentium vero natus ipsam tenetur explicabo tenetur. Delectus laborum cum earum exercitationem minus qui. Quia eligendi aperiam accusantium dolore magni repudiandae voluptate.\n\nReiciendis dolorum ipsam modi consequatur illum iste. Possimus quia cupiditate perspiciatis occaecati voluptatem ipsam dolore. Voluptas eos sint doloremque assumenda architecto hic. Iusto numquam suscipit eveniet eos nisi voluptas.\n\nDeleniti pariatur molestias error tempore nobis. Repudiandae officiis laborum magnam aut error quam molestiae. Excepturi provident distinctio ipsa possimus eveniet nam. Quaerat itaque occaecati sunt.\n\nCorrupti quod dicta sit qui asperiores maiores. Sequi quidem hic inventore deleniti ab. Fugit saepe minima corrupti deleniti dolore quibusdam. Vel corrupti optio id praesentium.	96.38	\N	2017-11-22 20:26:56.458725+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
46	Dickson, Thomas and Wilson	Saepe laborum libero sunt. Voluptas commodi eligendi nesciunt minima excepturi voluptas. Explicabo quod repudiandae voluptas voluptatum modi facilis. Quo sequi ipsum vel numquam.\n\nCorrupti debitis temporibus eos fugiat animi mollitia. Deleniti eveniet culpa perspiciatis eius nulla molestias omnis.\n\nNobis perspiciatis tempore blanditiis labore. Ducimus officiis quasi vitae voluptatem quia.\n\nRerum illum sit reprehenderit assumenda explicabo alias commodi. Voluptatem magni itaque impedit ut. Debitis deserunt iste eius tempore impedit expedita. Dignissimos aliquam vel voluptates molestiae. Quisquam laborum error sit expedita quibusdam illo ea.\n\nDelectus corporis voluptate perferendis cumque similique. Quaerat fugit pariatur quas eum perferendis perspiciatis. Qui atque nemo est libero cumque expedita. Officiis praesentium eum commodi dolores eum.	25.17	\N	2017-11-22 20:26:56.342158+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	t	t
50	Bell Inc	Adipisci quis perferendis reiciendis dignissimos repellat ratione accusantium. Magnam quo voluptas velit veniam sapiente. Eos animi tempora necessitatibus voluptas.\n\nPossimus labore doloremque similique. Voluptatum earum repudiandae cum saepe repellat eveniet dolor. Velit asperiores dolor quibusdam numquam fugiat. Debitis dolorum ut nihil cumque cum similique.\n\nEsse voluptatem possimus aspernatur eveniet. Sed ad voluptatibus eligendi hic nostrum vitae eos. Consequuntur tempore omnis velit repellat. Dolores quidem sit labore inventore culpa repellat occaecati.\n\nRepellat reprehenderit molestiae suscipit maxime vitae. Quo hic voluptates et corrupti laborum sint. Non cum modi facilis atque. Voluptatum blanditiis excepturi aliquid velit facere voluptate veniam.\n\nDeleniti laudantium soluta labore odit. Dicta inventore ipsum optio ratione. Ab perferendis sunt consequuntur cum error. Distinctio rerum ducimus sequi mollitia.	29.60	\N	2017-11-22 20:26:56.540651+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
51	Wilson Group	Officia dignissimos totam perferendis possimus ex blanditiis unde veniam. Dolores doloremque asperiores repellendus ipsum velit. Consequatur magnam architecto voluptates vero voluptate debitis.\n\nMinima nobis laudantium sequi corporis dolore praesentium illo. Nihil praesentium excepturi perferendis repellendus magni. Quis labore quo magni quaerat tenetur dolorum pariatur consequuntur.\n\nQuasi veniam modi labore quod minus nobis. Laudantium placeat facere error ipsum pariatur fugiat eaque. Molestiae eaque amet expedita vel unde. Voluptates aut illo earum cum.\n\nNeque excepturi vel debitis. Doloremque doloribus voluptatibus doloribus enim molestiae beatae placeat. Corporis amet minima blanditiis illo accusantium similique. Tempora commodi fuga eaque ipsam.\n\nSapiente quae minus ratione ratione odit. Iure distinctio occaecati quam beatae debitis. Quia distinctio voluptates magnam nemo animi.	44.22	\N	2017-11-22 20:26:56.586798+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
47	Miller-Dalton	Impedit adipisci in illo autem hic. Reiciendis nam laboriosam hic eveniet aperiam aspernatur fugiat quo.\n\nSaepe ex odit veritatis. Impedit mollitia ratione ipsa sed doloribus perferendis voluptate.\n\nMaiores fugit cum non numquam architecto voluptas. Cum iure illum iure atque illum. Quae praesentium ducimus cum nobis dolore iusto beatae.\n\nIllum explicabo nam nostrum enim earum facere voluptas corporis. Praesentium ut sed dolor beatae impedit quam modi. Quod alias consequatur voluptates totam. Soluta earum voluptas necessitatibus officia.\n\nMinima est incidunt neque voluptas ea. Iure quae dignissimos neque distinctio laboriosam repudiandae ex modi. Nostrum non quisquam voluptatibus quae doloremque molestias. Ab doloribus saepe eligendi ab neque quidem.	99.80	\N	2017-11-22 20:26:56.385404+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
141	Smith and Sons	Iste sint officia dolor maiores maxime. Eligendi saepe corrupti et modi voluptas voluptate ducimus at. Dolorem eos enim consequatur ex eum.\n\nReiciendis nemo corrupti modi voluptas sunt. Officiis harum facilis voluptatibus repellat natus culpa sed. Expedita exercitationem dolorem quae non similique ab beatae.\n\nDolorem alias cumque cupiditate iure quia. Rerum odit atque libero ex odio omnis occaecati. Velit harum vitae molestiae numquam nemo quod.\n\nConsequatur mollitia accusamus provident. Repellendus labore illo maxime dicta. Nostrum impedit amet dignissimos a similique laboriosam voluptatibus aliquam.\n\nCommodi aliquam repellendus nihil distinctio. Est sint soluta eum nisi facilis assumenda recusandae. Placeat corrupti laudantium sapiente voluptates nemo.	54.29	\N	2017-11-27 23:30:49.106281+00	3	"3"=>"6", "5"=>"14"	f	t
58	Mann-Lee	Sed nesciunt explicabo ipsum dolorem maiores necessitatibus. Asperiores nulla fugit error voluptate harum dignissimos. Vero minima nisi aliquam nemo necessitatibus nulla non.\n\nEt impedit totam dignissimos eum sint repellat voluptas voluptate. Dicta enim soluta recusandae tempore consequatur provident hic dignissimos. Molestias suscipit illum ut quo consequatur facilis reprehenderit. Corporis in neque inventore qui reprehenderit minima vitae reprehenderit. Eveniet dolorum asperiores ab aut.\n\nQuibusdam quia amet consequuntur officiis vero tempore. Maiores consectetur minima earum accusamus. Optio explicabo nobis libero facilis. Totam vitae voluptatum alias.\n\nVeritatis quia natus voluptate. Velit perferendis recusandae eius adipisci. Quia pariatur qui id doloremque provident voluptatibus officia.\n\nEos dignissimos laborum adipisci in corporis odit. Ut voluptatibus aliquid amet impedit minima. Enim repellendus ipsum cumque minima molestiae id soluta.	75.80	\N	2017-11-22 20:26:56.912173+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
55	Thomas PLC	Placeat ipsum quam iusto blanditiis totam. Ab eius explicabo sint non ipsum totam qui. Voluptatibus voluptates enim quibusdam nulla. Quisquam quas aliquid quia perferendis explicabo.\n\nRem mollitia neque labore unde libero quidem. Tenetur perspiciatis tempora eius veritatis. Iusto sunt deleniti non enim doloribus cumque.\n\nFacilis doloribus quo maxime ea velit quaerat. Assumenda tempore totam magni sapiente at ad. Hic suscipit voluptas amet.\n\nProvident facere distinctio placeat illo ullam. Culpa illum nostrum omnis libero odio ea. Quaerat perspiciatis nesciunt iusto accusantium. Aut repellendus accusamus numquam harum asperiores.\n\nVoluptatum reprehenderit enim eius. Dolorem animi placeat perferendis atque voluptates esse. Iure cupiditate excepturi ipsum perferendis molestiae at. Repellat tempore voluptatem voluptatum esse reprehenderit.	21.62	\N	2017-11-22 20:26:56.78632+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	t	t
56	Benjamin Group	In temporibus atque libero voluptatem recusandae laborum maxime quos. Nisi illum porro praesentium asperiores doloribus dolorum. Quo eligendi soluta beatae placeat.\n\nDoloribus esse blanditiis hic dolor repellat temporibus pariatur. Molestiae unde aspernatur quas totam. Quod at voluptas eos nam suscipit occaecati iusto. Eaque possimus repudiandae suscipit accusantium velit.\n\nQuod exercitationem maiores odit suscipit dolor. Aut quos nulla soluta reprehenderit eaque libero officiis. Deserunt inventore debitis aperiam facilis. Magni nemo hic eius sint voluptates eos dicta.\n\nAlias eveniet architecto voluptate voluptatum ratione voluptatum. Nemo aliquid molestiae quidem quisquam sunt architecto ducimus modi. Ex architecto aperiam voluptatem vitae magnam quibusdam. Consequuntur soluta quo quo magni corporis.\n\nIn iure beatae nobis ad quam impedit. Eos itaque est debitis mollitia. Voluptatibus iure deleniti minima accusamus. Odit dignissimos possimus saepe error repellendus officia.	21.40	\N	2017-11-22 20:26:56.820065+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	t	t
57	Rivera, Farmer and Tate	Ut labore id totam cupiditate explicabo praesentium. Dolore vitae quae pariatur harum laboriosam. Distinctio eligendi dignissimos enim quisquam modi facere nemo.\n\nAtque ea reiciendis at vel assumenda aperiam. Aspernatur fuga molestias eaque laboriosam asperiores minus ratione. Quae inventore alias quasi adipisci delectus velit maxime.\n\nInventore facilis sint praesentium explicabo dolorum repellendus voluptatibus. Tempore sed aut nihil. Eum maiores nisi earum qui rem nemo quas.\n\nConsequatur consectetur expedita cumque maxime odio. Rerum blanditiis odio a minima autem inventore error occaecati. Delectus odio voluptate illo placeat sint magni. Quo nam assumenda libero iure sapiente ducimus tempora. Quisquam neque nisi amet maiores excepturi sit.\n\nNumquam aliquam sed natus perspiciatis. Esse itaque officiis nemo nemo. Asperiores eaque corporis tempora assumenda ut similique. Ex voluptates dignissimos quia provident.	89.23	\N	2017-11-22 20:26:56.873828+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
152	Lawson, Winters and Carroll	Voluptates voluptates fugit aliquam sunt. Facilis sint quis inventore perferendis. Libero perferendis dolore corporis nisi at natus tempore nemo.\n\nEsse aliquid veniam sapiente perspiciatis excepturi. Accusantium omnis reprehenderit voluptate nemo quae quisquam rerum. Ad placeat suscipit sapiente consectetur tenetur eos.\n\nPorro blanditiis odio consectetur et cumque. Reprehenderit fuga odit aspernatur quasi. Id deserunt eius deserunt accusamus. Incidunt at velit ipsa.\n\nDolores illo odio aut nulla reprehenderit. Voluptatem harum dolores delectus dicta hic odit.\n\nFacilis delectus eos mollitia incidunt dolore. Sunt deleniti non cupiditate aliquid culpa. Laudantium eveniet ducimus eos voluptatibus.	91.10	\N	2017-11-27 23:30:49.53967+00	4	"3"=>"6", "7"=>"19"	f	t
142	Weber Group	Eius aliquam magnam quo impedit eaque ipsum beatae aut. Quae dolore libero eveniet blanditiis iusto. Officia aspernatur voluptatibus suscipit natus. Iusto harum reiciendis molestias nam deserunt dolores enim dolorem.\n\nDeleniti magnam fuga reprehenderit ex. Ratione minima fugiat dolore blanditiis. Numquam tempore facere molestiae nam ad.\n\nAsperiores saepe possimus ratione vero. Animi iure molestiae mollitia aliquam sapiente vero. Praesentium id dolores odio vero voluptate fugiat. Doloremque hic odio alias repudiandae aspernatur.\n\nNecessitatibus provident enim reprehenderit quis deserunt ducimus. Dolores voluptatum voluptas iusto esse est corrupti nisi cumque.\n\nAdipisci officia ex distinctio non tempora quisquam rerum. Totam debitis incidunt tempora at quo molestias. Tenetur aliquam non commodi quo maxime exercitationem. Officia quis iure consectetur totam dolore ut. Repudiandae ex accusamus dolores odit.	18.71	\N	2017-11-27 23:30:49.142343+00	3	"3"=>"6", "5"=>"13"	t	t
17	Reynolds, Hayes and Freeman	Molestias fuga fugit molestias itaque harum. Impedit velit sapiente voluptates impedit. Consequuntur libero nesciunt eum necessitatibus. Ipsa cum ducimus in molestias eaque repellat.\n\nMinus similique nobis vitae quam. Ad voluptates doloribus incidunt consequatur doloribus culpa. Natus architecto saepe temporibus tempora exercitationem cumque voluptatem animi. Ut quaerat exercitationem numquam.\n\nVoluptatum odio quaerat quis odit delectus delectus nobis quisquam. Atque magni numquam dolore sed rem. Magni quibusdam laudantium optio.\n\nHarum sapiente eveniet nam porro nostrum nobis. Dolores eius molestiae id laboriosam. Id quibusdam id deserunt aperiam quia itaque. Dolorem voluptatum suscipit ab explicabo exercitationem voluptatibus.\n\nMaxime laborum minima voluptates quaerat libero illum sit nesciunt. Perspiciatis quasi dicta magni cupiditate voluptatum fuga exercitationem ipsa.	19.14	\N	2017-11-22 20:26:54.952373+00	2	"3"=>"6"	t	t
31	Farley and Sons	Voluptates alias recusandae molestiae quaerat esse. Quod perspiciatis inventore ea voluptatibus. Illo quas vel necessitatibus harum qui. Corporis ducimus quidem hic accusamus recusandae nisi. Ea doloribus temporibus pariatur nam asperiores quas quo.\n\nOdit soluta optio deserunt veniam ab. Occaecati culpa amet omnis quia. Modi officiis dolores ullam adipisci qui mollitia vero. Quasi aliquam enim repellendus fuga reiciendis nulla molestias minima. Quas nesciunt blanditiis dolore error aperiam.\n\nVoluptatem nisi error nam nam officia aliquid placeat. Nostrum dolor atque eligendi pariatur dolor. Repellendus incidunt dicta ipsum sit placeat odio sed. Tempora ad debitis quos quos explicabo.\n\nNisi mollitia delectus consequuntur ea aliquid laboriosam dolor et. Ducimus consequuntur iusto atque voluptatum. Accusantium placeat ullam facere unde consectetur amet. Molestias libero veritatis incidunt et.\n\nExercitationem eligendi dignissimos vel numquam. Nesciunt unde aperiam cumque dolores mollitia unde. Itaque temporibus fuga inventore rerum nemo beatae perspiciatis. Odit minima iste suscipit vel. Eveniet tempore dolor ipsa ab.	79.61	\N	2017-11-22 20:26:55.654351+00	4	"3"=>"6", "7"=>"19"	t	t
42	Conway, Hensley and Brown	Reprehenderit amet quasi pariatur iste maiores animi. Magnam veritatis quod eveniet odio animi non dolores. Quasi deleniti laudantium unde atque deleniti. In ullam eaque tenetur facilis.\n\nAut dolor animi placeat facere aliquid error quia. Blanditiis nisi ducimus praesentium possimus velit. Magni harum cumque consectetur saepe delectus ratione.\n\nExplicabo qui quidem quo. Facere doloribus reprehenderit corporis quaerat. Fugiat eos consequatur praesentium unde.\n\nAt ex dolorum accusantium odio. Fugiat ipsam labore quis in nisi reprehenderit assumenda. Nobis voluptates laudantium voluptatum nihil facere enim.\n\nPorro rem esse excepturi culpa possimus explicabo commodi. Modi nulla tempore ipsam facere quam recusandae excepturi. Natus itaque assumenda ipsam. Reprehenderit officia ad assumenda molestiae natus aut.	73.99	\N	2017-11-22 20:26:56.172804+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
6	Davis, Bell and Camacho	Delectus repellat quia eaque. Ipsa placeat nihil sapiente perspiciatis cumque inventore aliquid. Omnis explicabo sapiente accusantium non deserunt. Labore praesentium molestias adipisci a.\n\nExplicabo distinctio vitae suscipit illo accusamus dignissimos ea laborum. Cupiditate dolorum expedita praesentium cumque perspiciatis quos. Distinctio reiciendis explicabo culpa dolore. Repellat eius ratione delectus rem atque. Est quae velit unde nostrum dolor autem.\n\nMolestias eos ea ducimus expedita blanditiis id magni eius. Eaque delectus deserunt et harum quos quia ipsam. Nobis ea adipisci fugit harum aliquid inventore voluptate. Magni adipisci quibusdam architecto nemo neque dicta quidem.\n\nAnimi eum adipisci iure doloribus alias. Velit explicabo similique explicabo sunt repellendus at provident. Molestias voluptas molestiae corrupti ea optio. Necessitatibus delectus dolorem minima repellendus.\n\nMaxime sunt reprehenderit magnam vero ex similique. Impedit voluptatibus ducimus occaecati nihil occaecati. Cupiditate atque error odit quod.	51.58	\N	2017-11-22 20:26:54.421977+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	t	t
150	Woods, Thomas and Johnson	Doloribus accusantium perferendis labore autem. Quis distinctio sit natus deserunt. Possimus consectetur occaecati itaque quisquam laudantium eligendi.\n\nQui dolorem incidunt laborum. Illo laborum totam qui excepturi praesentium optio quae. Iure eos iusto modi quibusdam aut cum rem.\n\nPariatur maxime accusamus molestias illum quas. Temporibus porro dolorem commodi tempora. Nisi deserunt minus ut atque sunt ad id. Sequi nesciunt quod repellat.\n\nVoluptate tempore nam ipsam totam quasi nam. Incidunt tenetur illo necessitatibus eius ex et. Doloribus nostrum quam placeat fuga. Fuga et sint ratione.\n\nAdipisci aut cum necessitatibus amet inventore dolorum. Iste reiciendis sapiente quae recusandae at illo quaerat. Adipisci pariatur laboriosam distinctio atque eligendi.	80.82	\N	2017-11-27 23:30:49.467878+00	3	"3"=>"6", "5"=>"14"	t	t
167	Avila-Garza	Dolorum maxime voluptatibus vero dolorum odit assumenda assumenda. Alias quos pariatur reprehenderit voluptatum ratione atque.\n\nEx quibusdam blanditiis cum minus aspernatur dolor reiciendis. Sint ullam sed quod aperiam reprehenderit. Illum dolorem commodi ex.\n\nIncidunt fuga similique cupiditate in vero optio. Tenetur sint at nam deserunt exercitationem quae eaque. Occaecati quas mollitia dicta a explicabo fugiat. Nemo blanditiis voluptas omnis.\n\nVoluptatibus officia nemo laborum pariatur. Asperiores debitis cum libero tenetur tempora enim aut.\n\nCommodi qui voluptatum minus necessitatibus quas suscipit accusantium. Eum ipsa cumque magnam voluptatem eligendi. Velit vitae labore fuga. Tempora reiciendis repellendus sunt dicta vero.	90.81	\N	2017-11-27 23:30:50.044546+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
49	Chen, Sims and Perez	Fugiat omnis nisi reiciendis nobis eaque. Voluptate provident labore quam illo beatae labore. Iure facilis nulla aliquam quaerat laudantium suscipit. Ad impedit aliquid libero sequi voluptatum dolorem praesentium.\n\nDoloribus sint non fuga occaecati magnam porro repellendus. Ullam iste accusamus laborum natus rem. Ipsa provident ullam nesciunt ipsum explicabo tenetur. Ex quod cupiditate eligendi quidem reprehenderit illum.\n\nEos vero quos ad iste. Laudantium consectetur dicta nobis nulla sed assumenda. Ea deleniti praesentium quidem hic ratione et harum.\n\nQuae illum distinctio distinctio incidunt hic odit. Molestias repellendus eos itaque earum laborum velit quis.\n\nIpsa eos incidunt earum ea. Minus alias maxime corporis tempora enim ut fugit voluptatem. Ratione ut sunt quidem itaque error. Repellat minus illum ad sed.	38.53	\N	2017-11-22 20:26:56.508609+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	t	t
60	Scott, Stanley and Harper	Sed aspernatur labore repellendus modi dignissimos neque animi. Molestiae excepturi officiis eos accusamus. Dolor est repellat neque cupiditate. Numquam aliquam nesciunt explicabo labore.\n\nNemo commodi amet fugit autem accusantium culpa. Nam ut delectus similique vitae. Fugit aliquam explicabo earum quaerat nulla alias.\n\nAssumenda harum esse ex delectus dolores quae. Temporibus minima labore blanditiis quasi.\n\nIpsa esse doloremque repellendus itaque totam facilis recusandae. Fugit enim quidem sit ipsa. Ex atque deserunt sequi eaque. Hic fuga inventore eaque expedita impedit temporibus.\n\nBeatae temporibus unde eligendi molestias adipisci autem earum. Laudantium asperiores voluptas corporis dolor placeat magnam non nostrum. At quidem quaerat incidunt aliquid et ipsam. Ratione fugit suscipit in.	82.78	\N	2017-11-22 20:26:57.011504+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	t	t
62	Scott-Martinez	Fugiat esse facere inventore consequuntur facere. Esse illo tenetur aut dolorum quo quo molestias amet. Sequi incidunt nisi doloribus accusamus adipisci deleniti accusamus nam. Culpa et dolore aliquid aut neque.\n\nUt eveniet quibusdam iusto ullam. Consectetur minus fugit totam odit. Modi ut fugit ipsam alias sint repellendus.\n\nLaborum et labore necessitatibus maiores animi error. Repudiandae laborum eum eveniet aut beatae ad in. Iste delectus eum sunt officia sed. Sed quis harum eveniet nam minima consequatur.\n\nSunt doloribus architecto odio odio eum ratione qui. Minus explicabo alias officia nesciunt nobis. Cum doloremque ipsum quasi eos neque nemo.\n\nQuod quos quasi doloribus sequi odit veniam quam nihil. Odio quibusdam commodi cumque cupiditate adipisci voluptatem itaque. Iure dolor nesciunt non doloremque quaerat nihil.	15.70	\N	2017-11-27 23:21:07.244299+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
63	Barnett-Duncan	Quaerat nam quae atque non eum quasi distinctio similique. Porro totam ipsa ipsam iure deserunt incidunt consequuntur. Totam quas accusantium culpa facere accusantium eveniet.\n\nVoluptas doloremque cum corporis saepe. Porro placeat enim necessitatibus totam consequuntur aliquid eius. Vel unde fuga accusamus qui fugiat.\n\nDebitis atque dignissimos esse aliquid consectetur quidem odit. Aliquam incidunt laudantium quaerat doloribus hic eligendi nam facere. Sunt voluptas labore illum laboriosam odio voluptas.\n\nEaque quae ipsum ea nemo rem doloremque unde. Neque pariatur et ducimus doloribus numquam.\n\nIpsum culpa est non omnis autem veniam dolor error. Quasi ex officia nihil. Animi distinctio explicabo temporibus laborum.	66.17	\N	2017-11-27 23:21:07.290722+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
64	Summers-Riley	Dolore nemo odit excepturi ipsa. Adipisci quidem unde error. Rerum repellendus laboriosam alias cumque. Porro placeat sequi nulla amet.\n\nBeatae dolorum dolores repellendus distinctio. Recusandae voluptatibus porro a facere. Adipisci porro aliquam dolorum ducimus pariatur. Magni repellendus impedit illo esse.\n\nCupiditate dolores dicta et non sit temporibus iusto voluptates. Blanditiis hic vel dolor alias tempore ipsa ullam. Soluta nulla debitis expedita velit dolorem expedita vero.\n\nExpedita nemo nobis iste nihil autem. Excepturi cumque culpa provident tempore esse magnam possimus. Eius quae tempore deserunt vero repudiandae laboriosam repellendus sapiente. Nisi assumenda quam quos dolores. Doloremque suscipit quae itaque libero asperiores.\n\nPorro magnam sunt molestias placeat quas. Laudantium perferendis alias eos laboriosam aut distinctio. Dolores eos reiciendis quibusdam aliquam quasi.	70.00	\N	2017-11-27 23:21:07.338739+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
61	Garrett Ltd	Hic consequuntur repellat incidunt atque qui quas necessitatibus. Ex quis aspernatur laboriosam ducimus hic ipsum blanditiis. Consequatur dolorum nostrum quam voluptates hic eum unde. Ut ratione maxime fugiat quisquam tempore dolorum.\n\nFacilis sit quibusdam exercitationem quisquam vitae ex. Animi laudantium expedita voluptatem assumenda facere id illum. Delectus numquam voluptates asperiores ipsa qui id. Adipisci animi esse deleniti veniam possimus quaerat incidunt hic.\n\nEst delectus ut fuga. Odit porro sunt magni earum harum corporis esse. Nihil culpa dolore nemo ipsa sapiente voluptate. Illum est aut modi atque.\n\nReprehenderit odit accusamus adipisci rerum exercitationem officiis. Enim quae nihil at vel. Omnis impedit numquam perferendis. Maiores perspiciatis necessitatibus a laudantium blanditiis voluptate.\n\nLaborum nemo laborum illo nisi ea ipsam expedita. Inventore animi eos repellat enim. Minus sapiente eos quod quasi. Laudantium ullam reprehenderit illum perferendis.	19.51	\N	2017-11-27 23:21:07.173004+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	t	t
65	Hines, Morris and Jones	Placeat numquam libero est accusamus occaecati neque. Dolorem ipsa quo assumenda iure. Id expedita fuga delectus. Tempore molestias ratione libero saepe aperiam consectetur.\n\nA molestias optio qui asperiores quo architecto cumque. Saepe numquam ex quibusdam ducimus corporis totam nemo. Molestias possimus error optio animi. Dignissimos sint et temporibus nulla autem voluptatem dicta odit.\n\nQuis pariatur delectus accusamus odit rerum eveniet illum odio. Architecto iure nostrum iure laborum repellat quibusdam. Cupiditate provident atque commodi neque ducimus dolorum. A laborum sunt ullam ex itaque suscipit.\n\nIusto ullam error dolores praesentium vel illum magnam. Eligendi sed dolores eum ab totam excepturi. Beatae adipisci asperiores error ut repudiandae iste.\n\nRem repellendus quos quaerat quasi harum omnis possimus. Error expedita optio corporis ipsa beatae.	10.68	\N	2017-11-27 23:21:07.396329+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
66	Harrison-Wilson	Maxime ad porro nisi quibusdam. Culpa eum ex veniam sequi commodi eos provident. Voluptatibus repellat est repudiandae. Sint occaecati itaque minima in vero.\n\nSapiente id ullam enim tenetur culpa natus suscipit. Repellendus modi optio similique dolores harum rerum perspiciatis. Vero sint error delectus.\n\nAliquid amet deserunt laborum incidunt quam. Nam temporibus fugit id recusandae temporibus rem quae. Placeat magnam quam unde labore sit vero ullam.\n\nQuasi veritatis pariatur explicabo. Aliquid dolores inventore soluta itaque. Eius cum impedit sunt consequatur.\n\nLaboriosam ipsa laborum dignissimos mollitia. Ipsum molestiae alias laboriosam quas fuga reprehenderit. Unde adipisci nesciunt beatae fugiat expedita. Excepturi nobis pariatur totam atque eius voluptates veritatis.	38.75	\N	2017-11-27 23:21:07.457181+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	t	t
68	Manning-Gonzalez	Dicta perspiciatis explicabo iure minus voluptate numquam. Amet ratione ipsa vero. Atque voluptas nobis natus neque nulla. Consequatur saepe distinctio odit inventore facilis.\n\nExcepturi voluptas quibusdam omnis accusamus necessitatibus vitae exercitationem. Quisquam quia dignissimos alias nostrum. Ab vitae magnam officiis excepturi cum quas vitae rem.\n\nAccusantium rerum quos odit illum. Saepe occaecati adipisci asperiores maiores repellendus ad. Natus debitis architecto eos neque hic optio sapiente. Deserunt quas deserunt molestias ipsa itaque. Asperiores distinctio quae maiores aperiam accusantium a.\n\nHarum voluptatum eligendi distinctio modi ratione. Beatae laboriosam cumque officia distinctio minus. Ducimus voluptatum exercitationem autem tempore illo maxime. Ipsum unde adipisci nam dolores exercitationem. Accusamus labore officiis corrupti a doloribus dolorem.\n\nFugit quam quo sed laborum repellendus. Sit error veniam magni optio. Ipsa incidunt doloremque recusandae nihil.	7.19	\N	2017-11-27 23:21:07.562635+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
67	Miller-Bennett	Mollitia fugiat tempora id voluptatum deserunt eos maiores commodi. Aliquam accusantium repudiandae tempore voluptates impedit cum. Vitae rem placeat omnis mollitia maxime praesentium.\n\nA ex non aliquam aperiam reiciendis culpa vero vitae. Necessitatibus itaque quasi tempore quia doloremque nam.\n\nAut numquam a atque ipsa doloremque odit. Quo rerum quia inventore eum. Expedita minus maxime placeat neque voluptatum laudantium laboriosam. Qui maxime beatae autem fugit sequi corrupti.\n\nSaepe saepe officiis expedita iure cum. Quasi doloremque omnis repellat quisquam.\n\nNecessitatibus adipisci autem magni consequuntur eaque. Corporis numquam voluptas sint nulla ipsum expedita velit excepturi. Nulla minima possimus dicta atque eveniet. Veritatis odio sint ducimus fugiat.	25.18	\N	2017-11-27 23:21:07.513122+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
71	Richards and Sons	Aliquid cumque cupiditate incidunt quod iusto est harum. Quos quisquam ullam expedita accusamus ut fugit blanditiis officiis. Quaerat quisquam ratione distinctio voluptates. Culpa vero rerum laudantium suscipit a.\n\nAssumenda tempore sed soluta. Quis nulla eius doloremque veniam doloribus amet illo. Inventore excepturi vitae repellendus aliquam tempora possimus accusamus dignissimos.\n\nQui dolorum tempora cum et nostrum. Ducimus ipsa ratione natus quia aliquam. Molestiae praesentium tempora amet veritatis dolorum et.\n\nNatus aperiam voluptatibus repellat maiores molestias totam cumque veritatis. Quo quos voluptates adipisci accusantium ratione soluta commodi recusandae. Nam deleniti odio cum sunt vel necessitatibus.\n\nAd quis autem est ad quae. Facere totam molestiae id quasi cumque. Atque ex voluptas tempora architecto corporis.	19.35	\N	2017-11-27 23:21:07.729245+00	2	"3"=>"6"	f	t
70	Blanchard and Sons	Quo nisi voluptatibus maxime eligendi. Debitis praesentium provident rem nemo minima odit. Sint dolorum praesentium veritatis aliquam. Dolor expedita tenetur quo nisi ea.\n\nEx earum delectus est ad et a voluptatem. Enim natus nulla quas nesciunt. Eius quisquam odit iste culpa.\n\nFugiat excepturi dolor repellat ea deleniti velit accusantium. Mollitia dolorem sed ullam sed dolor. Exercitationem quod quidem sequi.\n\nLabore tempore exercitationem quaerat ipsa quia deleniti rem quam. Ad eveniet impedit aperiam quos laboriosam. Natus natus quidem voluptatibus corporis. Aut repellendus dolor aliquid impedit quo dolor. Officia voluptates quaerat earum unde possimus fuga suscipit.\n\nDeserunt aliquam alias corrupti amet ea pariatur reprehenderit. Sint exercitationem quis veritatis. Soluta hic nihil commodi odio nisi modi autem voluptatem. Expedita numquam natus ex laboriosam.	41.75	\N	2017-11-27 23:21:07.677154+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
69	Shelton Inc	Fuga a blanditiis quia et deleniti harum modi. Hic at quas ea modi dolore unde sapiente sint. Reiciendis quia beatae consequuntur molestias. Fuga ea inventore aliquid molestiae occaecati. Distinctio modi pariatur veniam dolorum quae fugiat velit.\n\nNemo cumque molestiae sequi velit. Cumque incidunt soluta vero eius non. Debitis maiores sequi quidem laudantium ducimus.\n\nQuia eaque quaerat suscipit nihil qui praesentium. Recusandae aut vel facilis doloremque. Tempora modi possimus at eius quae facilis aut.\n\nMinus consequuntur est deleniti corrupti incidunt. Facilis a sed dolore voluptatum officia impedit. Pariatur cum at nam. Eligendi tempora nihil ratione a quam.\n\nNecessitatibus dignissimos temporibus exercitationem pariatur. Eius illo sunt cumque voluptatibus. Repellat tenetur cupiditate harum optio.	32.78	\N	2017-11-27 23:21:07.618798+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	t	t
73	Tapia-Mejia	Pariatur ut non atque soluta debitis recusandae. Tenetur at et enim repellendus cum velit. Alias minima nostrum cupiditate cumque vel quia accusantium impedit.\n\nVoluptas soluta ea dolor accusantium eos ex. Exercitationem vel tempora aspernatur in doloremque amet in. Ut unde cum illo possimus quisquam illum.\n\nAssumenda non laboriosam corrupti voluptatem. Voluptatibus totam debitis rerum optio commodi. Ipsam ipsum at provident ab voluptas aspernatur perferendis. Excepturi doloremque ex assumenda.\n\nConsequuntur neque aut voluptatibus adipisci reprehenderit. Ipsum ex rem quidem aut fuga sunt itaque. Inventore neque voluptate commodi fugit asperiores.\n\nIpsa cupiditate pariatur iste consequatur. Blanditiis dignissimos harum nobis quasi aperiam sequi sed quia. Nesciunt odio aspernatur consectetur ut eos velit dolor.	67.57	\N	2017-11-27 23:21:07.801808+00	2	"3"=>"6"	f	t
74	Benitez-Mcdonald	Odio alias itaque eveniet nisi. Ipsa voluptatem maxime neque. Sapiente odit vero explicabo distinctio autem.\n\nVoluptatibus dolorem accusantium officiis velit explicabo nesciunt ut. Consequatur molestiae debitis voluptatibus cupiditate. Quam unde ab laudantium minus dolore praesentium. Eligendi facere corporis neque neque laudantium beatae eius.\n\nNam veniam deserunt magni ratione quibusdam assumenda dolores. Quis molestiae deserunt eum. Odio quae fuga sunt quibusdam maxime ab.\n\nSequi provident minima illo veniam cupiditate ex. Voluptatibus consequuntur temporibus error nesciunt eum.\n\nDolorum recusandae sunt nam aliquam quas. Natus vel totam facere perferendis nihil illo. Fugit eum tempora maiores vero perspiciatis dignissimos.	19.97	\N	2017-11-27 23:21:07.836725+00	2	"3"=>"6"	f	t
75	Frye-Jones	Illo eaque expedita delectus est ab porro distinctio. Veritatis ullam corporis occaecati iusto accusantium. Magni ducimus consequuntur optio odio saepe vero dolor ducimus. Soluta sit repudiandae ratione eum reiciendis omnis aut. Possimus natus magnam repellat animi natus.\n\nQuo vitae cupiditate sapiente repudiandae necessitatibus mollitia ratione. Aliquam eius harum amet perferendis vel architecto modi. Maxime nostrum quos accusamus quidem.\n\nVero quam animi similique neque dolorem earum itaque. Explicabo in nihil quasi. Sequi enim in magnam ut. Consequatur nisi aliquid porro.\n\nNulla occaecati assumenda incidunt enim autem repudiandae. Nesciunt maxime facere expedita. Esse doloribus sunt delectus cum quidem vero. Cumque expedita aut eius aut.\n\nRatione placeat dolorem reiciendis voluptate voluptas officiis. Possimus accusamus porro fugit laudantium veniam vero totam. Ea totam sint quaerat numquam eligendi id. Iste assumenda natus iusto suscipit blanditiis.	86.80	\N	2017-11-27 23:21:07.866983+00	2	"3"=>"6"	t	t
77	Austin, Smith and Moore	Doloribus praesentium doloremque nihil non. Laudantium odit voluptate quo illum neque. Eaque sint omnis provident doloremque exercitationem alias eos praesentium. Magni quidem harum similique molestias tempora vel.\n\nAccusamus quisquam doloribus in totam. Occaecati dolor temporibus optio eius.\n\nExercitationem adipisci non dolorum mollitia nobis neque dicta. Veritatis libero molestias alias sit sapiente ratione voluptas laborum. Ad quis impedit quia eveniet reiciendis sunt dolorum iusto. Quisquam repudiandae minima doloremque soluta dolores quas praesentium.\n\nNisi quidem quo hic qui incidunt officiis voluptatem. Nostrum earum expedita nihil error alias voluptatibus. Cum numquam harum officia voluptate rerum omnis quidem commodi.\n\nQuos voluptate velit fugiat. Debitis incidunt iusto similique a voluptatibus. Inventore distinctio minima sed doloremque numquam.	37.57	\N	2017-11-27 23:21:07.910475+00	2	"3"=>"6"	f	t
86	Schroeder-Nash	Illo quos perferendis mollitia similique eos earum quaerat. Dicta fugit ipsa vitae doloribus totam. Quisquam necessitatibus debitis dolorum minus voluptatibus voluptatum. Aliquam architecto dignissimos porro iure.\n\nEum eligendi corporis odio. Dignissimos unde corrupti eum incidunt earum. Optio ab reiciendis est illum. Repellat harum minima repellendus neque provident voluptatum.\n\nSunt esse necessitatibus quis nesciunt exercitationem cumque ipsum. Culpa laudantium vel consequuntur doloremque adipisci labore. Ex doloremque veritatis eligendi omnis corporis non. Natus vero ea ad perspiciatis sit quod quis porro. Harum accusantium aliquam aperiam nihil repellendus.\n\nDoloribus distinctio repellat ut sequi. Unde dolore assumenda expedita incidunt esse. Quisquam eius eos quaerat at vel exercitationem. Iusto ipsum dolor earum velit ipsam hic in.\n\nQuos exercitationem facere natus non vero. Architecto in rerum ex voluptatem. Facilis ipsum illum mollitia nulla. Hic quasi repellendus id.	23.80	\N	2017-11-27 23:21:08.256153+00	3	"3"=>"6", "5"=>"13"	f	t
76	Tucker PLC	Sint consequatur sunt deserunt quisquam ipsa deserunt. Repellendus consectetur facere corporis saepe nobis quasi corrupti. Aperiam sit harum maxime commodi id. Esse molestiae pariatur iure facilis distinctio quas iste optio.\n\nFacilis sit a ipsa exercitationem voluptas porro. Deleniti magni culpa animi illo. Aliquid sunt ad ad excepturi sunt nulla sequi. Impedit tenetur quaerat eveniet pariatur sunt laudantium nostrum.\n\nSuscipit cupiditate ut dolores ullam. Laboriosam deserunt unde perferendis mollitia. Doloribus eius labore aspernatur perferendis adipisci.\n\nMinus laboriosam commodi doloribus fuga at tenetur. Debitis molestias molestias sint natus rerum expedita delectus. Perferendis explicabo expedita reiciendis voluptatem ad laborum aliquid dolores.\n\nVeritatis natus occaecati error tenetur officiis. A excepturi facere praesentium saepe sit tempore. Praesentium voluptatem perspiciatis cumque commodi quis reprehenderit.	61.00	\N	2017-11-27 23:21:07.889529+00	2	"3"=>"6"	t	t
79	Walker-Summers	Explicabo doloremque maxime earum assumenda ex. Cupiditate saepe corporis provident magnam itaque at. Repellat optio corporis exercitationem ratione voluptatum. Rerum nisi aliquid quasi cupiditate autem dolorum recusandae.\n\nRepellendus et expedita dolorum nihil consectetur praesentium praesentium. Qui laboriosam delectus possimus facilis. Consequatur iure minus nihil incidunt beatae reiciendis porro impedit.\n\nLibero natus est et. Sed omnis ex expedita ad esse culpa. Voluptate cum quia exercitationem dignissimos ipsam aspernatur ipsam.\n\nIn ab maiores quaerat commodi. Rem laudantium ullam voluptas voluptatibus. Omnis aliquid ex provident necessitatibus porro incidunt temporibus.\n\nAdipisci consequatur doloremque quis neque facere tempora. Quas nobis aut nobis fugit nostrum ea quidem. Quia debitis ratione excepturi quae laboriosam culpa nostrum. Eligendi nesciunt laboriosam vero pariatur mollitia maiores nostrum. Dignissimos exercitationem eveniet accusantium magni tempora.	22.66	\N	2017-11-27 23:21:07.964357+00	2	"3"=>"6"	f	t
80	Sanchez, Manning and Coleman	Atque vel quas facere laborum vel inventore aliquam. Sequi quae reprehenderit dolorem voluptas et. Pariatur quo deleniti praesentium sapiente dolor.\n\nNulla fugiat est quibusdam ullam impedit. Nostrum ipsa architecto voluptates repellat placeat. Quaerat voluptatibus autem illo omnis.\n\nRatione maiores tenetur temporibus itaque. Error debitis pariatur dolorum quam eos vero. At maiores ea ad maiores minus nobis.\n\nPerferendis tenetur amet odio natus saepe dolore molestias. Earum voluptate suscipit minus facilis soluta assumenda dolor fugit. Ad nobis est omnis totam rem quas eos.\n\nPorro ab laboriosam occaecati alias hic consectetur ut qui. Quae quidem earum a excepturi facere soluta natus. At voluptatum nesciunt perspiciatis saepe earum vel rem. Impedit rem iure excepturi non.	39.60	\N	2017-11-27 23:21:08.001937+00	2	"3"=>"6"	f	t
81	Reyes and Sons	Minima tempore incidunt voluptatibus aliquam perferendis soluta illo officia. Et quae id nesciunt quos vero soluta eaque. Quod exercitationem atque omnis saepe eius impedit.\n\nAnimi neque perspiciatis labore aut sunt. Distinctio error eligendi laborum rerum soluta. Tenetur praesentium nostrum quod consectetur itaque. Porro ullam eius excepturi quos molestias sapiente. Accusamus inventore maxime quisquam.\n\nLaudantium magnam facilis similique non praesentium hic. Neque saepe ratione ut deleniti nisi. A occaecati fuga itaque reprehenderit similique.\n\nQuae excepturi cum temporibus placeat delectus occaecati. Maxime architecto occaecati dolores accusantium. Quod soluta quam adipisci corrupti omnis nobis dolorem laboriosam.\n\nFuga cum placeat cupiditate optio pariatur libero. Odit molestias impedit dolores laudantium nemo sint at. Possimus nemo eius fuga voluptate unde doloribus.	36.69	\N	2017-11-27 23:21:08.025785+00	3	"3"=>"6", "5"=>"13"	f	t
83	Gonzalez Group	Nam quia nostrum voluptatibus corrupti laboriosam exercitationem sint. Facere ducimus facere similique. Qui ipsum hic neque incidunt.\n\nEst nihil delectus nemo commodi magni velit veritatis. Esse expedita eius dolorum quam vel eveniet. In ab repellendus necessitatibus iure asperiores quas ad.\n\nBlanditiis fugiat voluptatum fugit vel magnam reiciendis. Minus illum numquam excepturi pariatur.\n\nImpedit fuga aut accusamus voluptates ex minus quam excepturi. Aliquam placeat vitae facere asperiores harum. Facilis qui atque earum expedita itaque exercitationem quisquam.\n\nNemo in dolores modi. Perferendis placeat quod praesentium voluptates at eveniet. Facilis corrupti harum facilis aperiam. Alias quas corrupti molestias.	96.59	\N	2017-11-27 23:21:08.115712+00	3	"3"=>"6", "5"=>"13"	f	t
84	Glenn-Diaz	Tenetur maxime eum aut illo ducimus voluptas est. Earum laudantium eum error libero. Suscipit quidem esse modi dolorum. Eos sunt quod occaecati atque sint.\n\nReprehenderit cumque possimus tempora voluptatibus. Doloribus modi facere perferendis maiores saepe. Explicabo laudantium harum ratione doloribus asperiores numquam. Dignissimos incidunt facilis id consectetur.\n\nQuos delectus sed eius error libero. Recusandae laudantium illo dolores voluptate libero. Veritatis in officiis modi eos omnis. Incidunt unde minus commodi eligendi repudiandae.\n\nAlias cupiditate voluptatibus sint explicabo laborum nesciunt. Accusamus error sint nulla porro.\n\nProvident reprehenderit provident cum aperiam. Magnam repellendus sunt eius quod necessitatibus temporibus error. Aliquam in voluptates impedit cum odit itaque nemo.	88.60	\N	2017-11-27 23:21:08.157526+00	3	"3"=>"6", "5"=>"13"	f	t
82	Cook and Sons	Placeat eaque perferendis laborum velit animi. Officia tempora iusto nesciunt quae. Modi esse veniam ipsam ut velit. Omnis aspernatur quod doloremque veritatis voluptate placeat.\n\nEveniet sed quasi harum at. Optio repellendus quia doloribus delectus pariatur asperiores libero. Sapiente quos cupiditate reiciendis.\n\nAperiam repudiandae perspiciatis repellendus doloribus necessitatibus corporis voluptatem. Placeat distinctio magni alias omnis consequuntur. Assumenda dolorum eveniet distinctio et consectetur quia hic. Velit officiis porro fugiat nulla nostrum.\n\nAccusamus natus beatae laboriosam ullam cum. Recusandae nulla suscipit fugit hic culpa earum veniam aliquid. Reprehenderit assumenda minima totam corrupti. Libero vero rerum architecto harum.\n\nNisi iste tenetur sit nobis vel. Laboriosam recusandae optio quo nisi voluptate totam odit. Illum nihil quos laboriosam porro fugit et esse.	5.89	\N	2017-11-27 23:21:08.080898+00	3	"3"=>"6", "5"=>"14"	t	t
88	Lowe PLC	Nesciunt et perferendis cum ea consectetur. Debitis dolore praesentium quos debitis qui enim id laudantium.\n\nBeatae impedit molestias sequi quis. Accusantium sed quae dicta quasi in dolorum quidem. Laboriosam assumenda officia dolorem cumque consectetur. Beatae corporis nesciunt adipisci consequatur.\n\nModi hic dolore repellat. At autem itaque inventore corrupti rem vitae libero. Molestiae officia omnis consequatur ullam saepe esse laborum cupiditate. Necessitatibus quaerat deserunt pariatur at iusto asperiores explicabo voluptas.\n\nSuscipit vitae nostrum eius vero exercitationem similique ipsam. Inventore in maiores dicta voluptas in eligendi. Ipsum distinctio quas commodi perferendis similique inventore error.\n\nRem provident occaecati voluptates. Est adipisci itaque rerum debitis natus. Numquam similique natus facere ab quia odio ut.	16.28	\N	2017-11-27 23:21:08.349199+00	3	"3"=>"6", "5"=>"14"	f	t
89	Villa, Porter and Barker	Quos repellendus adipisci odit earum. Asperiores facilis error consequuntur quis. Ad minus velit tempore ipsa est.\n\nPlaceat omnis libero expedita ipsum magni quos tempore. Illum modi vero at quis doloremque exercitationem. Esse temporibus odit adipisci quidem. Fugit suscipit voluptate omnis architecto recusandae tempora.\n\nIure repellat fugit quaerat amet. Ipsum nobis cupiditate ad possimus occaecati eligendi. Velit vitae beatae aperiam fugiat similique. Adipisci maiores laudantium reiciendis laudantium ad quo.\n\nQuas fuga eveniet eos iste repellendus. Sapiente est nesciunt magnam exercitationem iure magnam temporibus. Aspernatur modi cum soluta voluptates voluptatum consequatur omnis exercitationem. Quidem ullam eum ullam nisi. Fugiat dolore ipsa magnam pariatur.\n\nVelit eum a rerum sequi esse earum. Aut id asperiores ullam magni. Autem tenetur eum harum in consectetur veritatis qui. Ipsa laborum quasi magni quam fuga consectetur pariatur.	72.76	\N	2017-11-27 23:21:08.391731+00	3	"3"=>"6", "5"=>"13"	f	t
90	Ross Inc	Aliquid mollitia exercitationem illo cum expedita necessitatibus quo. Asperiores libero porro totam qui occaecati. Earum numquam et illo sed numquam provident.\n\nExpedita repellendus cumque asperiores ipsam ratione animi. Eius doloremque porro modi deleniti in officiis.\n\nRepellat esse nisi voluptate provident praesentium culpa. Ipsam ut dignissimos eius quae occaecati nesciunt. Aliquid nisi omnis adipisci harum occaecati.\n\nUnde quidem illo saepe. Architecto eveniet consequuntur ab suscipit officiis voluptatem veritatis eveniet. Magni atque excepturi accusantium soluta architecto hic. Molestiae blanditiis ipsa atque commodi veniam.\n\nIusto incidunt quisquam ipsam id quo unde illum. Temporibus alias at aut quae voluptates. Provident praesentium tenetur aliquam sint modi perferendis. Ea ipsam aspernatur tempore dolorum iure possimus eos. Impedit id minima nobis occaecati distinctio aperiam eos.	36.30	\N	2017-11-27 23:21:08.428871+00	3	"3"=>"6", "5"=>"13"	f	t
92	Johnston PLC	Nemo in fugiat fuga. Enim incidunt dolorem dolores enim. Inventore maxime nemo itaque sed consequatur. Sit magnam consequatur ex sequi tempora. Pariatur eveniet sunt porro quis temporibus recusandae nobis.\n\nDignissimos in ut dolor excepturi possimus nemo. Labore enim esse minus. Nam atque consectetur qui repellendus error explicabo sapiente. Corrupti similique voluptatem illum.\n\nMollitia repudiandae soluta iste doloremque impedit dolorum architecto iusto. Maxime eos quaerat modi itaque repellendus. Aspernatur animi sequi debitis sint ratione.\n\nAut impedit aliquam dicta inventore quisquam tempora ducimus. Ipsum ut delectus accusantium quis consectetur reiciendis inventore. Soluta officiis adipisci distinctio laboriosam eligendi sed dignissimos.\n\nAt ab vitae quos voluptatem quaerat cum maxime odio. Maxime praesentium est molestias. Odio sequi ex occaecati rem recusandae iste voluptates.	31.68	\N	2017-11-27 23:21:08.516756+00	4	"3"=>"6", "7"=>"19"	f	t
93	York-Bradford	Sint eius autem assumenda asperiores laudantium soluta odio. Commodi quis consequuntur autem ipsam inventore. Fugiat eveniet molestiae blanditiis tempore at.\n\nMaxime adipisci quidem exercitationem perferendis nobis eos aut. Optio libero porro eligendi recusandae nemo. Perferendis alias laudantium beatae modi repudiandae ullam omnis facilis.\n\nVel iste cum voluptates minus facilis. Reiciendis sint quas impedit eligendi reprehenderit. Suscipit delectus delectus alias voluptatem. Facere voluptatem aspernatur tempora eum facilis illum.\n\nSequi quia sint quia temporibus nulla. Dicta consectetur architecto delectus ex ipsum molestiae. Quo aperiam sapiente quibusdam ipsam.\n\nVoluptas molestiae sunt doloribus. Tempore ut eveniet cum eligendi libero sint inventore ea. Illum quisquam expedita asperiores dolor rem mollitia delectus.	9.35	\N	2017-11-27 23:21:08.554442+00	4	"3"=>"6", "7"=>"19"	f	t
94	Nelson PLC	Quibusdam earum laborum tempora provident at eius ipsum dignissimos. Nulla nemo nemo aut voluptate ducimus assumenda expedita. Veniam soluta esse esse. Dolore blanditiis hic maxime neque.\n\nSed nisi enim nulla dignissimos. Optio aut fuga inventore.\n\nLaboriosam iure perferendis iure iure voluptatum assumenda ducimus. Ipsam praesentium deleniti culpa libero dolore. Voluptates odit veniam distinctio id.\n\nPlaceat blanditiis voluptate consectetur totam voluptatem incidunt quisquam nostrum. Quasi voluptate odit ipsam nisi unde. Et non rerum autem. Ducimus necessitatibus reprehenderit aut eligendi. Velit fuga minima nisi odit debitis harum blanditiis.\n\nProvident reiciendis voluptatibus excepturi vero sapiente. Quis consequatur esse illum dicta reiciendis repellendus commodi. Voluptatum quisquam adipisci nisi dolor.	22.20	\N	2017-11-27 23:21:08.596539+00	4	"3"=>"6", "7"=>"20"	f	t
91	Rowland-Griffin	Doloremque facilis laudantium rerum distinctio autem eaque. Facere dolore illo totam a possimus quaerat. Harum atque suscipit reiciendis consectetur. Itaque consectetur similique facere nostrum.\n\nVeniam incidunt rem alias deleniti quos provident praesentium. Explicabo quia doloribus optio perspiciatis aspernatur pariatur labore. Ratione numquam libero distinctio aliquam perspiciatis.\n\nOfficiis aliquam quaerat blanditiis consequatur. Aut illo blanditiis mollitia earum totam dicta. Repellendus sequi doloremque dolor soluta iure. Beatae laudantium mollitia cum sit illum ab repellendus cum.\n\nBeatae tempore soluta saepe eaque quod consequatur omnis. Facere ea aperiam quod modi nam libero repudiandae. Omnis accusamus explicabo amet quam.\n\nEum nemo soluta numquam numquam aliquam tenetur numquam. Libero a modi voluptatem tempora saepe incidunt. Ex eos mollitia labore molestiae.	52.38	\N	2017-11-27 23:21:08.4745+00	4	"3"=>"6", "7"=>"20"	t	t
95	Weber, Stewart and Moreno	Beatae repellendus inventore explicabo delectus placeat. Dolores numquam veritatis debitis nihil. Aliquid non temporibus velit exercitationem atque. Culpa quaerat assumenda perspiciatis delectus omnis consectetur debitis.\n\nCulpa tenetur amet sequi hic nobis. Harum iusto ex praesentium provident assumenda nam ipsa molestiae. Earum repellat velit vero ex sint veniam.\n\nBlanditiis culpa tenetur totam fugiat assumenda. Quas eos eos dolore harum. Est eos porro dicta beatae. Labore ex ratione blanditiis laudantium eum.\n\nVel nesciunt in eveniet cumque tempore sit. Dicta error possimus odit minus quaerat illum. Culpa architecto pariatur commodi reiciendis quis neque at saepe.\n\nConsequuntur eos at sit aspernatur reiciendis occaecati non. Cumque iste quos quam eius maiores odio quos. Iste soluta laudantium inventore aperiam.	61.47	\N	2017-11-27 23:21:08.633241+00	4	"3"=>"6", "7"=>"20"	f	t
96	Smith, French and Hamilton	Id molestiae molestias nulla distinctio voluptates. Aliquam beatae molestias quasi numquam aliquid quo maiores. Minima neque cum magnam. Expedita ipsum ullam doloribus excepturi dolore vitae.\n\nEarum voluptate ducimus reprehenderit quidem dolorem quas consequatur corporis. Eaque possimus a iste aperiam. Dolor ea suscipit occaecati quidem voluptates distinctio libero. Nihil repellendus facilis eaque nihil voluptatem perspiciatis quas.\n\nMinima dolorum vel nihil. Perferendis non nostrum perspiciatis hic dolorum ullam adipisci. Expedita nam fuga minus excepturi officiis corporis voluptatibus necessitatibus.\n\nExplicabo suscipit repellendus esse sunt quae. Sit repellat dolorem aliquam ratione accusantium mollitia sunt. Occaecati aut a ea ducimus.\n\nA ad magni enim exercitationem. Reprehenderit nam alias nisi voluptatem modi laudantium qui modi. Commodi omnis ea beatae quasi cum occaecati ullam.	90.87	\N	2017-11-27 23:21:08.686165+00	4	"3"=>"6", "7"=>"19"	t	t
98	Gray-Raymond	Provident deleniti totam recusandae maxime libero deleniti voluptatum. Nemo quas eius et explicabo. Ab dolore dolore reprehenderit non vero atque est. Veniam omnis voluptatibus optio architecto.\n\nOdio similique corporis nihil quos maxime. Eos voluptatem minima tenetur quia minima. Corrupti libero perferendis quia error error. Distinctio beatae quod repellendus dolore. Excepturi vero qui consequatur sint blanditiis.\n\nAut quod sapiente dignissimos minima quis. Dolorem facere consectetur assumenda omnis nesciunt velit. Reprehenderit commodi eligendi dolor asperiores. Quia doloribus molestiae ex quas. Nisi quis delectus qui similique.\n\nEst vel quam corrupti ducimus magnam velit reiciendis. Libero voluptatibus minus officiis omnis quaerat dolores quidem. Numquam enim repellendus deleniti hic quae adipisci dolores.\n\nNisi commodi quos debitis labore maxime sunt. Autem eligendi aliquid ullam itaque fugit rem. Facilis animi aut fugiat quos cumque.	70.62	\N	2017-11-27 23:21:08.763452+00	4	"3"=>"6", "7"=>"20"	f	t
99	Mooney-Strickland	Saepe minima repellat quidem dolorum. Eveniet ad labore quas earum asperiores iusto id sint. Sit ut voluptatem voluptate libero ratione placeat.\n\nDicta eius odit quisquam nemo voluptates eum tenetur. Veritatis accusamus at molestias asperiores blanditiis deleniti vitae. Accusantium velit labore error officiis sunt quis cumque.\n\nVeniam in similique eos eum qui itaque. Eligendi ratione tempore minima doloribus voluptates ratione iusto. Error sint consequuntur sint a cupiditate quis iusto. Ea aliquam illo temporibus nisi. Nesciunt aut molestiae ipsa.\n\nQuae fugit deleniti expedita debitis harum. Voluptatibus libero ipsam placeat iusto architecto molestias. Dicta ipsa accusantium perspiciatis nobis dolor molestiae delectus.\n\nAspernatur fugit perferendis nulla facilis est iure facilis. Dolore soluta nisi fuga eum. Quo odio nobis saepe illo eaque. Totam rerum neque soluta facere nobis.	48.56	\N	2017-11-27 23:21:08.788876+00	4	"3"=>"6", "7"=>"19"	f	t
100	Schmidt and Sons	Voluptas hic facere accusantium incidunt architecto. Perferendis maiores ipsam quo perferendis.\n\nUt est optio corrupti quo. Blanditiis ut nesciunt beatae molestias quidem. Recusandae suscipit autem odio perspiciatis magnam eos provident eius. Modi aspernatur consequuntur quia dicta eius.\n\nTotam dignissimos facere totam eveniet expedita ullam veniam porro. Quo ipsam necessitatibus magni veritatis odit iusto. Dolore dolor fuga reiciendis impedit nam sequi debitis mollitia.\n\nAliquam nobis officiis veritatis excepturi quo molestiae quae. Necessitatibus recusandae ex culpa est. Totam at doloremque ab distinctio. Animi laudantium possimus natus quis ea.\n\nAut reprehenderit aspernatur reprehenderit explicabo aperiam. Iure nobis molestias qui at. Tenetur omnis deleniti mollitia delectus.	8.11	\N	2017-11-27 23:21:08.831857+00	4	"3"=>"6", "7"=>"19"	f	t
101	Hamilton, Taylor and Harris	Numquam laborum asperiores in optio architecto aspernatur in. Voluptate doloribus harum aperiam dolorum corrupti. Expedita minima cumque doloribus labore fuga. Non nostrum error odio deserunt inventore.\n\nPlaceat reiciendis quaerat blanditiis voluptatibus ipsam voluptate. Suscipit nulla natus fuga odio soluta magni. Eveniet sunt dolores quos nulla ab totam eaque. Libero fugit repellat totam mollitia modi optio.\n\nSint impedit excepturi omnis beatae nostrum alias totam. Saepe nostrum voluptatibus quia tempore veniam beatae consectetur natus. Numquam ipsam voluptatem doloribus. Quis id accusamus nostrum voluptatum labore ullam necessitatibus.\n\nSed deleniti impedit assumenda labore nemo magni. Dolorem sint repellendus nisi qui. Saepe porro ipsum suscipit ipsum. Dignissimos molestias esse porro id consequatur itaque saepe.\n\nNumquam maxime dolore est soluta hic in vero. Et aperiam quam vero vitae dolorum. Iure maxime nobis illum pariatur veniam corrupti voluptas.	82.40	\N	2017-11-27 23:21:08.866303+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
97	Chavez and Sons	Qui vitae iusto aut dolorum assumenda magnam ipsum. Fugiat odio veritatis corrupti architecto. Cupiditate tempore repellat vero eos dolorum vero.\n\nModi fugiat accusamus veniam maxime ipsa corrupti dolorum. Molestias perspiciatis laboriosam nemo excepturi fugiat amet. Et iste doloremque laboriosam pariatur. Cum voluptatum hic suscipit facere.\n\nVoluptas rem occaecati necessitatibus maxime architecto. Sint perferendis blanditiis explicabo reiciendis. Natus voluptatem repudiandae adipisci iusto.\n\nEaque possimus atque aliquid perspiciatis laborum itaque veritatis. Ea eos doloremque fugiat aut quas. Expedita ut porro maiores deleniti error rerum quaerat.\n\nNihil a illo ea ipsam illum officiis tempore. Saepe enim unde harum ipsa. Tempore cumque exercitationem voluptatem tempore adipisci assumenda nihil. Inventore provident eaque debitis asperiores accusamus.	95.57	\N	2017-11-27 23:21:08.718455+00	4	"3"=>"6", "7"=>"20"	t	t
103	Thompson-Wood	Error consequuntur vero ad veritatis quod. Necessitatibus vero voluptate rem neque. Quidem quam enim itaque earum molestias est illum. Omnis optio sequi totam tenetur quisquam.\n\nSunt quas labore accusamus eaque sint. Nostrum facere similique perferendis necessitatibus autem vel beatae. Amet quas nam iste iusto. Minima maxime enim accusantium sit. Atque iste quis optio necessitatibus incidunt ut veritatis.\n\nSuscipit animi omnis dolorum voluptatem ipsum. Recusandae temporibus amet eum vitae. Esse reprehenderit aspernatur impedit vel recusandae.\n\nBlanditiis doloremque maxime consectetur. At dolores in nam ex quia. Tempore est consequuntur quo accusantium nesciunt esse possimus. Quisquam cupiditate facilis excepturi cumque animi. Animi sapiente in iste optio.\n\nAdipisci minus error perferendis eos voluptates. Nemo molestias quibusdam sequi doloremque. Vero cum beatae quia eum laboriosam earum. Quae dignissimos hic nemo dolore laudantium quo.	81.58	\N	2017-11-27 23:21:08.95039+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
105	Travis, Drake and Carter	Recusandae a totam rem quod facere maxime. Ex id omnis dolor nemo autem tenetur perferendis. Consequuntur fugit iure neque sit. Cumque corporis porro aperiam debitis alias.\n\nEveniet pariatur repellendus quo animi dolor. Ipsum laudantium vero dolore voluptatem in ratione molestiae. Voluptate laborum beatae doloribus necessitatibus. Eaque possimus beatae reprehenderit incidunt dignissimos maxime.\n\nIn culpa tempore est suscipit eius. Alias in cupiditate itaque aliquid non exercitationem fugit. Sit repellat optio ab officiis voluptas. A eum culpa labore earum numquam.\n\nMollitia doloremque illum voluptatibus error non repudiandae repellendus. Molestiae a voluptatum eius facilis iste. Aspernatur beatae quis praesentium dolorem ea natus. Alias voluptatem accusamus saepe sequi.\n\nHic accusantium quidem tempora odio mollitia dolorum. Illum tempora delectus doloremque quae voluptas officia delectus. Unde autem quis maxime corrupti iste vero autem.	89.44	\N	2017-11-27 23:21:09.013104+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
106	Craig Group	Possimus cupiditate mollitia laudantium voluptatum. Atque id dolorem saepe ipsum ipsa ipsum mollitia.\n\nImpedit eligendi eligendi itaque ducimus aspernatur iure. Veniam animi dolorum veritatis provident laborum. Voluptatem earum veritatis cupiditate esse. Ut quam itaque excepturi ad amet fugit nostrum. Praesentium veniam sapiente nostrum.\n\nAnimi velit iure totam esse tempore molestias dicta. Temporibus dolorem dolores enim. Dicta sed reiciendis consectetur eos nam vel. Dolor quae harum voluptatibus culpa.\n\nAd suscipit quisquam harum iste voluptatem. Autem quos quaerat corrupti explicabo dolorum sapiente. Explicabo qui illo incidunt enim.\n\nPlaceat deserunt labore alias ullam nisi voluptatum. Ducimus sed voluptatibus delectus ea aliquid reprehenderit. Enim voluptatibus corporis nulla rerum illum ut eligendi. Veniam nostrum rerum rem ab.	97.83	\N	2017-11-27 23:21:09.041821+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
108	Mcdonald-Thomas	Odit suscipit iusto officiis molestias repellat. Commodi repudiandae optio voluptatum eaque. Illum fugit vel delectus. Unde iste fugiat hic.\n\nDoloremque distinctio illo praesentium voluptas officiis sequi ducimus. Ut id quaerat reprehenderit officiis vitae fugit. Porro dolores autem reprehenderit laborum nisi libero. Ex unde suscipit officia minima.\n\nAd veritatis consequuntur voluptates. Voluptatum cupiditate repellendus labore quod ea unde. Nostrum aliquam nihil optio totam.\n\nTempora rerum nihil amet reprehenderit. Repellat cupiditate cum aliquam perspiciatis provident tempora porro a. Veniam laboriosam similique fuga magni molestiae ex.\n\nAccusantium illo error facilis nihil ullam quisquam accusamus. Alias ut ab soluta quod labore.	67.46	\N	2017-11-27 23:21:09.117498+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
107	King, Vasquez and Blake	Occaecati sint recusandae quod minima. Minus modi dolore cupiditate ducimus a. Suscipit placeat culpa earum sed harum voluptates.\n\nLaboriosam hic consequatur labore sint eius eaque deleniti. Magni consequuntur debitis accusantium accusantium debitis sunt ut officiis. Laborum at consectetur in laborum vitae. Assumenda pariatur sint velit adipisci architecto.\n\nAdipisci illum sint officiis blanditiis quam vitae amet. Expedita perspiciatis fugiat possimus officiis occaecati a alias iste. Sunt expedita voluptatibus corporis asperiores.\n\nEnim cumque consequuntur asperiores nostrum repellat ea. Mollitia dolorem dolore nobis illum id omnis sit. Eius facere consequatur fugit ratione est.\n\nAutem dolor earum error sequi ut. Dicta odit veniam doloribus porro quam. Corporis cupiditate non quam quo. Esse quidem beatae culpa repudiandae voluptates dolores animi labore.	74.24	\N	2017-11-27 23:21:09.077944+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
109	Wang LLC	Dolorum ullam omnis voluptatem. Aliquid ratione quaerat consequuntur qui eum facere et. Laborum in voluptatem asperiores accusantium quidem debitis.\n\nVoluptatem alias quaerat perferendis distinctio nostrum et at aspernatur. Ipsa distinctio aperiam delectus reiciendis esse quos. Ipsa ab amet ratione nostrum doloremque itaque. Corrupti nostrum incidunt quas tempora non quidem. Distinctio eos corrupti at rem ipsum cumque.\n\nError harum illo rem possimus exercitationem nesciunt dolorem eius. A in reiciendis sunt. Doloribus asperiores cum tempora vel libero facilis necessitatibus.\n\nOmnis repellat quia aspernatur. Veritatis eaque facere maxime dolorum ea. Placeat labore ullam provident quia sed optio. Molestias hic earum sapiente laboriosam.\n\nNeque quibusdam numquam assumenda sapiente aliquam. Labore aliquid numquam iusto facilis esse voluptatibus sint. Quasi ea quam accusantium aut repudiandae nihil. Molestias commodi alias deleniti inventore.	40.71	\N	2017-11-27 23:21:09.14754+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
110	Arroyo PLC	Ut commodi maxime dicta. Omnis perspiciatis at eaque minus optio. Excepturi nisi iusto temporibus ex deserunt aliquid placeat.\n\nModi iure sed perspiciatis soluta fugit similique officiis. Aliquid numquam alias odit. Perspiciatis aliquam autem quo nemo.\n\nItaque ipsam eos doloremque dolor distinctio dolorum deserunt. Alias tempore voluptate animi a. Eius voluptas laborum recusandae itaque nobis modi sapiente.\n\nOdit doloribus facilis cupiditate tenetur. Labore quod sunt commodi. Eum quas reiciendis id iure modi quae. Facere voluptate deserunt molestiae adipisci reprehenderit doloribus reprehenderit doloremque.\n\nAssumenda exercitationem voluptas laborum. Incidunt consequuntur repudiandae molestiae voluptate molestiae. Eveniet corrupti in earum ipsa ullam voluptatum.	0.22	\N	2017-11-27 23:21:09.194676+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
111	Carey-Andersen	Minima explicabo cupiditate ipsa quae quisquam occaecati. Voluptates debitis molestiae autem architecto iure.\n\nPariatur eius illo repudiandae expedita sed quasi placeat. Corporis quo vel atque similique. Voluptatibus odit architecto voluptatem sint eligendi. Delectus soluta illo nesciunt eos.\n\nDelectus ratione delectus odio nobis doloribus. Accusamus nihil libero voluptates laudantium repudiandae iste temporibus. Fugit enim voluptatum fugit dolor minus corrupti itaque. Adipisci a provident provident.\n\nIn quasi quasi iusto facilis odit perspiciatis impedit sint. Facere a nostrum laboriosam necessitatibus. Sequi quasi nesciunt nobis unde. A ipsa fugit sit consequatur officia quia. Recusandae ex veniam repellat rerum aut vel.\n\nEligendi sunt nihil vero beatae. Quia quis minima fugit animi non. Mollitia eligendi provident animi ducimus minima voluptatem cum. Nisi cum cum amet quae tempore unde facilis.	38.99	\N	2017-11-27 23:21:09.220667+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
112	Cain, Tyler and Jones	Deserunt voluptates iusto odio quod esse quam. Excepturi nobis laudantium omnis placeat perspiciatis similique odio quasi. Molestiae eum quae reiciendis optio ratione autem.\n\nQuis autem provident corrupti dolor voluptatibus at vero. Perspiciatis quam quaerat nesciunt ipsum harum animi. Adipisci dolore inventore rem magni distinctio cumque labore sit. Non totam possimus cum inventore.\n\nEx ad perferendis nemo non vitae. Vero rerum necessitatibus sit sint sit nobis. Cupiditate corrupti optio at nostrum non.\n\nQuibusdam voluptatum quam eum vero culpa inventore dolores laudantium. Ad sint doloremque eveniet odio voluptatum eos rerum. Officiis blanditiis dignissimos quis fugiat.\n\nMagnam magnam voluptatum perspiciatis totam asperiores inventore sint. Labore voluptates placeat similique ab. Quia assumenda aliquam doloremque sunt qui quos exercitationem temporibus. Sint inventore velit molestiae temporibus nam.	62.98	\N	2017-11-27 23:21:09.260624+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
113	Baldwin Ltd	Quo corporis nisi nulla reiciendis ratione recusandae at. Provident possimus facilis aspernatur dicta quam ad. Distinctio dicta aut debitis recusandae laudantium recusandae. Praesentium cumque illo dicta eligendi magni nostrum incidunt inventore. Adipisci laborum molestias sit quos.\n\nConsequuntur error porro sunt illum occaecati maxime ipsum. Numquam blanditiis ratione fuga quis quis incidunt sequi. Laboriosam molestiae pariatur non amet optio recusandae. At corporis vero nam nulla rerum error. Minus molestiae ipsum dolorum consequuntur tenetur itaque ea odit.\n\nUllam nemo similique molestias aspernatur odio. Cum optio nisi eveniet totam. Repellat accusamus alias voluptate reiciendis.\n\nDolor necessitatibus sint repellat. Magnam suscipit itaque exercitationem quaerat. Eaque porro deserunt neque doloremque. Consectetur tenetur accusamus qui quasi.\n\nVoluptas velit laudantium repellat animi. Iure dolores nihil maxime quisquam odit. Iusto enim eum earum rem quis distinctio temporibus.	79.44	\N	2017-11-27 23:21:09.288284+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
114	Williams, Marks and Hunt	Voluptas minus totam asperiores aperiam. Amet accusamus vel ipsum aliquam maiores et. Repudiandae voluptatem ducimus veniam perspiciatis doloremque deserunt voluptatibus. Alias animi velit nulla possimus quibusdam. Architecto similique labore illo eveniet sunt aut illum.\n\nEum voluptates velit recusandae quo a. Voluptatem recusandae autem porro enim modi sunt libero officiis. Ea expedita possimus voluptate iusto vel quas. Doloremque ut aliquam modi hic laudantium cum ea.\n\nQuae in nostrum quas nostrum laborum. Perspiciatis sunt est labore. Eius voluptatem maiores eos temporibus explicabo maxime ut. Quod nulla nihil fugiat totam impedit accusamus impedit id. Adipisci veniam culpa nisi ipsa error blanditiis maiores dignissimos.\n\nNumquam laboriosam quibusdam temporibus ab dolorum iure architecto. Nostrum necessitatibus ratione asperiores itaque doloribus. Consequatur pariatur facilis velit tenetur.\n\nQuis tempore harum itaque dignissimos qui voluptatem dignissimos unde. Eum blanditiis aliquam repudiandae doloribus rem. Dolorem id eaque unde tenetur. Odit veniam voluptate voluptatibus harum quisquam occaecati expedita.	65.46	\N	2017-11-27 23:21:09.327303+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
194	Hernandez Ltd	Fuga perferendis dolorum fugit ab ipsam quibusdam. Excepturi laborum itaque quidem dolores qui dicta. Vitae animi voluptate illo aut consequatur dicta. Illum quae repellendus dolores officia tempore aut.\n\nNam cumque culpa vitae debitis et excepturi necessitatibus. Facere nulla debitis recusandae autem placeat veritatis. Sit quod laborum vel aliquam.\n\nExcepturi veritatis laudantium vero sequi eligendi. Rerum accusantium ex itaque esse ratione. Animi inventore debitis natus eaque. Fugit consequatur natus maxime perferendis.\n\nRepudiandae fuga corporis magnam libero. Ut enim fugiat eius.\n\nDelectus voluptates illo atque minima totam. Ullam error in voluptatem odio. Asperiores dignissimos a eaque maiores itaque nesciunt aliquam.	24.15	\N	2017-11-27 23:49:12.174092+00	2	"3"=>"6"	f	t
116	Baker, Holmes and Farrell	Occaecati accusantium eum odio cum qui minima. Qui suscipit dolores eaque eius. Nostrum error nesciunt sint doloremque.\n\nNesciunt dolores incidunt aperiam illo repellendus incidunt. Maiores porro ipsa laborum facilis dignissimos laborum. Repudiandae repellendus doloremque nobis aliquam maiores. Facere cum repellat totam vero nemo.\n\nExercitationem aspernatur fuga repellendus molestias natus quae tempora voluptate. Excepturi placeat mollitia quibusdam blanditiis qui recusandae inventore. Sint accusamus ex unde harum sapiente earum.\n\nIpsa similique totam explicabo libero. Neque aspernatur ad inventore excepturi vel in. Sapiente et quam repellat soluta quod error. Distinctio repellendus veniam ad quam aliquam.\n\nRepellendus cum corrupti repudiandae qui nulla fuga. Maxime dolorem minus iste dolorem officia iure unde fugit. Corrupti excepturi nostrum at optio numquam.	91.90	\N	2017-11-27 23:21:09.399917+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
117	Johnson-Evans	Fuga iure ea nostrum ut labore cumque magni. Itaque harum doloribus possimus quasi illum iusto soluta minima. Animi perspiciatis a animi ab repellat dolorem.\n\nAmet harum ad culpa rerum. Maxime repudiandae vero soluta occaecati fugiat. Itaque nemo maxime deleniti porro soluta magnam maiores.\n\nQuis totam soluta officia aspernatur. Impedit quia consectetur alias saepe. Eos rem praesentium labore eligendi ducimus quos ratione. Cum aliquam non illum possimus.\n\nImpedit autem perferendis eaque impedit accusamus occaecati pariatur. Officia unde quidem neque nisi qui at laborum blanditiis.\n\nExpedita doloribus atque suscipit odit in maiores. Et corrupti alias quia soluta corporis laboriosam dolore. Maiores animi nam similique cumque a qui labore distinctio.	56.83	\N	2017-11-27 23:21:09.428262+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
266	Russell Ltd	Molestiae officia sapiente voluptate accusamus ratione. Cupiditate commodi dolor adipisci at provident quasi.\n\nMaiores saepe in ut illum saepe sapiente dicta. Quos vitae molestias amet neque corporis quis cupiditate. Incidunt veritatis totam odio animi magni reprehenderit. Earum animi iste distinctio alias asperiores vel id.\n\nTotam repellendus quia architecto itaque. Quo nemo quae error similique perspiciatis consequuntur sint. Quasi esse officiis numquam voluptas quaerat pariatur eum.\n\nNeque voluptate deleniti hic. Velit consequatur rem unde. Tempore iusto neque earum voluptatum.\n\nDistinctio quo deserunt accusamus reiciendis officia accusantium odit. Deleniti autem quidem ea distinctio quam. Optio temporibus minus animi omnis.	97.75	\N	2017-11-28 00:10:04.505644+00	3	"3"=>"6", "5"=>"14"	f	t
119	Ingram-Brooks	Aliquam ea blanditiis laboriosam possimus saepe. Sit molestiae quod atque amet pariatur. Atque quas nisi amet odio.\n\nUllam consequatur suscipit dicta saepe. Culpa magnam omnis quasi animi vitae quidem. Eveniet libero amet ut fugit ullam id dicta asperiores. Unde aut labore unde porro.\n\nCorrupti dolor dolores possimus eum sapiente error. Sapiente maiores voluptatem hic optio asperiores voluptatem sint. Non doloribus nesciunt ex quasi blanditiis corrupti. Voluptatibus iure sunt corporis alias exercitationem.\n\nIusto ea modi cum dignissimos. Quas praesentium ex vitae voluptas quas nemo.\n\nQui a impedit saepe perspiciatis voluptatum ducimus quae. Eligendi nobis dolores quis maiores deserunt totam. Praesentium optio nemo ipsa accusamus voluptatem repellendus. Ea dolores adipisci cum quo.	99.22	\N	2017-11-27 23:21:09.513931+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
267	Adams-Schroeder	Temporibus harum architecto ex neque necessitatibus ex. Doloremque quo explicabo quam repellat ipsum dolores error. Atque optio minus quas. Delectus quia magnam asperiores cupiditate minus.\n\nIllo exercitationem dolores tempore in qui repellendus. Quasi eos veritatis tempora molestiae. Amet voluptates laborum nesciunt ratione.\n\nAssumenda facere autem maiores adipisci ullam ipsam. Vero est id a. Maxime labore repellendus nesciunt nihil cumque ex iusto.\n\nSuscipit repellat ratione quibusdam accusamus. Nesciunt corrupti reiciendis in ut voluptas minima reiciendis. Qui illum animi eligendi non. Autem saepe harum dolores odit ut ab iure.\n\nOdit sunt molestiae necessitatibus provident. Assumenda odio voluptatum est possimus officia doloremque odio. Aliquam et quam deleniti molestiae nemo. Deserunt error eveniet minima deserunt.	27.43	\N	2017-11-28 00:10:04.565374+00	3	"3"=>"6", "5"=>"13"	f	t
268	Lawrence-Scott	Quisquam enim dolor dignissimos est rem expedita asperiores. Beatae numquam quisquam quis deserunt doloribus magni quibusdam. Delectus dignissimos quae pariatur doloremque ad qui vero beatae.\n\nAspernatur assumenda labore eveniet labore eaque corporis. Velit quaerat optio impedit veniam itaque. Dolore nostrum mollitia libero rem corrupti. Accusantium voluptatibus ullam assumenda sapiente.\n\nReiciendis sapiente odio consectetur corporis eligendi. Est aspernatur accusamus soluta.\n\nMinus cumque dicta eum voluptatibus cupiditate. Deserunt cumque error enim modi voluptates aliquid a. Saepe quis ipsa libero reprehenderit assumenda. Deleniti sapiente necessitatibus quaerat vel accusamus officiis. Ab suscipit facilis provident provident.\n\nOdio libero minima inventore nulla quis. Placeat ut nisi delectus reprehenderit saepe accusamus labore. Error repellat ab ducimus pariatur voluptates illo doloremque.	65.77	\N	2017-11-28 00:10:04.615884+00	3	"3"=>"6", "5"=>"14"	f	t
118	Moore-Camacho	Autem earum nihil saepe. Alias iste tenetur cumque earum nihil. Occaecati id similique sit tenetur.\n\nExcepturi eaque eius voluptatem eaque harum illo mollitia. Aut optio sapiente delectus distinctio accusantium harum. Quibusdam laborum distinctio ut enim. Tempore ipsa eum doloribus ullam.\n\nVoluptate nemo est assumenda blanditiis qui temporibus ipsum at. Quaerat sed placeat nobis odio ad vero quam quidem. Dicta quos perspiciatis suscipit.\n\nAt id est maiores repudiandae nihil. Ut praesentium dolor in quos error. Voluptatem laborum nobis inventore eveniet. Eum necessitatibus ratione alias voluptatum.\n\nTenetur minus distinctio necessitatibus dolorum. Temporibus nam facere esse eligendi. Ea voluptas maxime blanditiis ducimus voluptatibus dolorem nesciunt.	2.98	\N	2017-11-27 23:21:09.460757+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
120	Smith, Sanders and Wallace	Rem distinctio ratione nulla quam expedita libero eveniet excepturi. Quia recusandae animi dolores voluptatum est. Adipisci consectetur voluptatem quod nobis eligendi illo voluptatem a. Quam dolorum dignissimos explicabo molestias nemo impedit minima.\n\nConsectetur autem voluptatum consequatur aspernatur harum doloribus voluptatum. In eius aperiam autem nulla perferendis maxime consectetur. Minus dolorum deleniti veritatis facilis quisquam. Dolorem atque quisquam dolores autem accusamus. Maxime dolorem iste rerum corporis libero dolor.\n\nOmnis consequuntur quaerat tenetur rem. Doloribus facilis sequi placeat fugiat ratione. Iusto at voluptatem accusamus neque suscipit distinctio et adipisci. Porro ab vel illo consequuntur suscipit delectus. Iure distinctio quisquam ratione illum.\n\nDucimus consequuntur vitae vel labore enim repellat quia. Beatae distinctio aliquam vitae unde. Ab repudiandae iste vero accusantium.\n\nRerum nobis molestias cumque consectetur corporis libero labore. Laudantium quas perspiciatis doloremque. Repellat velit similique repudiandae officiis excepturi. Quibusdam laudantium neque tempore iste dolores iure.	14.76	\N	2017-11-27 23:21:09.537713+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
1	Thornton Ltd	Rem exercitationem harum deserunt. Molestias voluptatum suscipit repellendus iure. Quos eveniet magnam accusantium recusandae odit nobis. Quas enim veniam corporis illum distinctio.\n\nExercitationem laboriosam nemo recusandae doloremque odio mollitia asperiores. Suscipit mollitia nisi placeat. Voluptatem deleniti odit consectetur vel. Quas sint nobis optio ex libero facere quis.\n\nAliquid laborum provident explicabo reiciendis similique reprehenderit qui. Perferendis facere excepturi neque laborum in a necessitatibus dicta. Beatae nobis earum a soluta magnam accusantium voluptas.\n\nAliquam voluptate occaecati ratione quo vel. Voluptatum repellendus consequuntur commodi explicabo ea. Aspernatur qui animi cum et vitae. Corporis soluta commodi placeat non.\n\nRatione fuga quia ea corrupti odio nam blanditiis ex. Accusantium dolorum illo voluptates hic quod. Enim sint animi numquam dignissimos aspernatur. Placeat quis cum maiores eos.	13.68	\N	2017-11-22 20:26:54.154231+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	t	t
59	Elliott, Atkinson and Reyes	Dolorum dicta nesciunt ipsam. Adipisci distinctio maxime repellendus porro eius. Quae vero quos suscipit consequuntur perspiciatis quam sit.\n\nDolore culpa ratione voluptatum reiciendis odio eos. Doloribus incidunt libero minus aliquid. Reprehenderit magnam officiis dolor laborum blanditiis tenetur voluptatibus.\n\nDelectus recusandae inventore earum ullam. Delectus quo sapiente iusto cum. Quasi sed amet rem quasi reprehenderit provident rem. Explicabo sequi molestiae doloremque quaerat.\n\nOdio repellendus quas doloribus repellat. Accusamus ratione deserunt cupiditate quos. Ipsam animi optio laudantium quos hic optio accusamus. Recusandae laudantium mollitia sit.\n\nAnimi laudantium fuga quis quam molestiae aut ipsam. Accusamus repellendus amet expedita rerum odit veritatis saepe. Temporibus fuga consequatur incidunt odio repellendus eius facere. Tempore quod deleniti optio placeat cupiditate blanditiis accusamus.	46.75	\N	2017-11-22 20:26:56.959565+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
20	Smith-Webster	Quam dicta distinctio laborum. Quaerat dolorem officiis aut id. Facilis nisi soluta soluta vel corrupti.\n\nVeritatis aperiam voluptates deserunt eum soluta. Molestias repellat fugiat ratione omnis nostrum est. Earum facere ex eum aliquid rerum corrupti.\n\nVoluptates iure voluptatibus quos a. Aperiam aperiam quisquam debitis maxime. Nemo numquam rem soluta minima saepe dignissimos ipsam occaecati.\n\nAssumenda architecto quo similique eligendi necessitatibus odio. Nam asperiores consectetur corporis iusto enim. Ipsa doloribus perferendis maxime perspiciatis cupiditate ratione totam.\n\nPerspiciatis numquam nobis adipisci nihil repudiandae. Sequi optio quasi maiores voluptas quos. Amet explicabo nesciunt provident soluta doloremque explicabo saepe.	21.40	\N	2017-11-22 20:26:55.046983+00	2	"3"=>"6"	t	t
85	Williams, Webb and Charles	Quaerat hic minus possimus facilis reprehenderit culpa. Id recusandae tempora iste. Facere eum corporis doloremque aut laborum reprehenderit reiciendis modi.\n\nUnde incidunt voluptatibus consequatur ducimus eaque doloribus corrupti doloribus. Repudiandae consequatur blanditiis similique atque. Dolore corporis eveniet voluptatem sapiente eligendi aspernatur. Ducimus itaque maxime voluptas incidunt saepe ducimus. Quos deleniti molestiae dolores deleniti dicta.\n\nQuaerat suscipit ipsam molestiae sed. Nemo doloribus odit in odit dolor. Consequuntur veniam deleniti soluta accusantium repellendus. Molestiae accusamus dicta laudantium quia quas itaque.\n\nExcepturi natus inventore quasi distinctio distinctio ipsa iure. Necessitatibus laborum architecto inventore inventore.\n\nAmet labore provident fugiat fuga soluta modi. Totam facere aliquam aliquam itaque.	82.33	\N	2017-11-27 23:21:08.203988+00	3	"3"=>"6", "5"=>"14"	t	t
121	Marshall-Taylor	Labore repellat expedita temporibus pariatur consequatur. Perferendis laudantium asperiores et saepe ducimus aliquam exercitationem. Saepe voluptates ex ipsa dolor alias fugit.\n\nNumquam blanditiis molestias quidem possimus laboriosam aut animi rerum. Aliquid dicta sapiente quos corporis occaecati ipsa ab assumenda. Vel ea ad tenetur.\n\nDolorem eligendi similique autem ducimus voluptatem. Molestiae eveniet nisi a quis veniam vel maiores. Dolorem voluptates occaecati animi possimus autem dolorum saepe incidunt. Distinctio earum illum nesciunt repellat occaecati reprehenderit quos.\n\nConsequuntur repellendus sunt veritatis eius. Quo officiis repellat incidunt. Suscipit repellendus beatae provident provident nam facilis minima. Harum nulla tempora dignissimos illum exercitationem.\n\nNobis perferendis delectus ullam reiciendis deleniti. Iure pariatur sint exercitationem porro consectetur quae cupiditate harum. Inventore illum porro facilis.	68.38	\N	2017-11-27 23:30:48.354927+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
122	Cain Group	Accusamus ex numquam fuga dolore inventore vel. Nihil totam veniam saepe. Nihil soluta molestiae voluptas molestias.\n\nVoluptatibus iste voluptate perferendis nostrum animi delectus beatae corporis. Sed consequuntur minima recusandae ipsum iure doloribus ratione. Minus laudantium vel modi veritatis cumque laboriosam. Sequi cum esse maxime ipsum consequuntur eligendi alias.\n\nConsectetur quas rem mollitia odio molestias. Expedita sed eius blanditiis ratione ea sunt. Alias a molestias cumque neque laudantium in soluta. Voluptate ipsum distinctio impedit.\n\nOfficiis quisquam necessitatibus tempore ratione corrupti magnam ipsum. Asperiores cumque blanditiis debitis similique. Odio numquam tenetur dolorum impedit accusantium.\n\nItaque temporibus adipisci voluptate sequi. Ullam ab accusamus ullam eius quo praesentium. Totam sed explicabo ea nobis autem. Eius exercitationem fuga laborum ipsam velit.	53.50	\N	2017-11-27 23:30:48.406072+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
123	Miller Group	Cumque voluptatem voluptatem nisi dolorem cupiditate officia adipisci sunt. Esse eius dolore eos cupiditate provident odit. Aliquam corporis quam modi numquam. Eum aspernatur provident minima labore libero vitae.\n\nCum saepe culpa quam nam eligendi. Corrupti maxime blanditiis id minima. Exercitationem possimus debitis earum a sint. Dolorum saepe ratione commodi corporis adipisci ab ut rem.\n\nMaxime eos sequi eius in necessitatibus. Harum amet inventore voluptatum. Quasi occaecati quae fuga deserunt nisi optio qui. Fugit est architecto voluptatum quidem aliquid placeat molestiae.\n\nTotam ipsa quia impedit dolores odit eos adipisci consequatur. Occaecati quis optio perferendis itaque porro quisquam libero. Incidunt ipsa voluptatibus molestias. Quo voluptas iure quaerat.\n\nReiciendis illo eveniet culpa hic praesentium molestiae. Dolorum optio occaecati eaque. Iusto molestiae nulla labore nemo sunt sunt.	7.23	\N	2017-11-27 23:30:48.453247+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
125	Jones LLC	Magni sunt ipsum similique natus. Vitae a iste recusandae natus tenetur. Delectus ducimus quos culpa voluptates. Nesciunt aliquid amet dolorem illo.\n\nSapiente magnam rerum qui facilis doloremque non animi. Earum animi necessitatibus incidunt voluptatem atque laboriosam esse. Nesciunt similique quae eius dolore incidunt quae.\n\nCorrupti dolorem animi sapiente harum necessitatibus. Fugit architecto nisi totam sed. Culpa explicabo ducimus ea excepturi ut non iste blanditiis. Nemo officiis quibusdam nisi eligendi autem at.\n\nUt quas ipsum nulla vitae reiciendis doloremque illum. Consequatur rerum sint sunt nihil illum id impedit. Est quibusdam eos doloribus dignissimos dolorem.\n\nExercitationem ipsum laboriosam sed sed facere. Officia consequuntur reprehenderit alias est. Corrupti assumenda fugiat nam eos fugiat aperiam vero voluptatibus. Quisquam beatae earum ducimus amet suscipit.	52.59	\N	2017-11-27 23:30:48.534023+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
126	Hansen LLC	Alias eaque quo hic. Corrupti architecto ut doloribus dolorum. Neque rem dolores doloribus eos velit adipisci non quidem.\n\nNeque iste pariatur error eum veniam ex consectetur saepe. Sint praesentium quod ratione. Ex incidunt voluptates qui consequatur.\n\nEum culpa maiores vel repellat at perferendis sed. Officia expedita placeat fugiat nemo voluptates temporibus sunt. Aspernatur praesentium reprehenderit ut praesentium. Deleniti reprehenderit saepe minima quasi quaerat.\n\nA dolore distinctio recusandae expedita. Ipsa in minus ut temporibus. Dicta accusantium illum iste eius sit. Delectus assumenda fugiat voluptates doloribus.\n\nAdipisci nesciunt distinctio impedit necessitatibus. Recusandae delectus modi quae inventore iusto dignissimos cumque veniam. Nemo cum molestiae id corporis commodi. Minima hic amet voluptas iure enim eligendi sint.	94.14	\N	2017-11-27 23:30:48.584062+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
151	Gray-Newton	Tenetur ab repellendus amet vero tenetur sequi placeat omnis. Nulla ut sunt natus enim expedita. Beatae necessitatibus expedita cupiditate quae. Architecto nemo enim expedita aliquid maiores molestiae odit.\n\nConsectetur numquam a rerum quia iure placeat. Veritatis ad sed deleniti. Optio impedit aspernatur veritatis neque dolorem repellendus quo totam.\n\nNostrum inventore est placeat voluptatibus commodi. Doloremque veritatis quam mollitia rerum aliquid autem cupiditate dolores. Possimus ratione eaque in soluta. Officiis nam voluptatem fuga eligendi.\n\nQuia veniam vel rem delectus cupiditate minima repellendus quasi. Alias ullam molestiae ipsa veniam. Error omnis adipisci placeat eum.\n\nAnimi quis praesentium repellendus nobis voluptatem. Distinctio sapiente totam delectus natus nihil vitae voluptatum. Eius veniam earum sapiente sequi.	60.15	\N	2017-11-27 23:30:49.502979+00	4	"3"=>"6", "7"=>"19"	f	t
124	Christensen Inc	Officiis officiis aperiam veritatis quibusdam atque. Repellendus quos esse consequatur fugiat nam corrupti. A reprehenderit reprehenderit vel recusandae illo minima dignissimos. Molestias dignissimos quae esse totam mollitia recusandae a.\n\nMaxime non blanditiis voluptas illum ducimus possimus laborum. Id dignissimos amet dignissimos perferendis. Nisi officiis natus officia iste.\n\nHarum provident magni minima officia. Voluptates autem vel dicta deserunt. Nulla eos reiciendis veniam qui soluta harum alias. Ipsam expedita beatae doloremque cupiditate fugit.\n\nUt praesentium ad dolores vitae fugiat. Est iure adipisci nobis natus sunt quibusdam. Delectus consequatur dolor odit quas.\n\nAccusamus omnis eos reprehenderit ratione praesentium repellat. Id minima optio ipsa dolorum. Iusto neque ipsa fuga dicta sunt.	35.24	\N	2017-11-27 23:30:48.494573+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	t	t
127	Henry Group	Assumenda doloribus quidem cum provident aperiam labore accusantium. At ea hic delectus provident veritatis soluta mollitia. Iusto minus molestias delectus reiciendis. Inventore sequi dignissimos impedit unde.\n\nAccusantium alias neque nemo consequuntur consequuntur tempora quam perspiciatis. Dolor fugit nam mollitia esse aliquam. Nemo deleniti expedita animi ab delectus modi. Dolores corrupti voluptatibus distinctio laborum culpa sequi porro.\n\nVoluptatem mollitia pariatur rem. Fuga inventore tempore quia quia laboriosam odio tenetur. Voluptatum impedit incidunt fugiat at est inventore. Impedit nam maxime libero optio illum.\n\nOdio voluptate at exercitationem voluptate eos magni aliquam. Aspernatur tempore pariatur incidunt commodi architecto. Optio reprehenderit ad rem minima. Libero at minima sunt nulla debitis officia culpa voluptates.\n\nAliquid inventore nostrum sit occaecati explicabo. Accusantium facilis minima pariatur beatae quasi cumque sequi animi. Repellat aut dicta delectus corrupti ea facere.	88.78	\N	2017-11-27 23:30:48.642588+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
128	Daniels, Santos and Shannon	Quas ipsa soluta neque temporibus inventore aliquid ipsam. Temporibus nulla tenetur accusamus ut iure sapiente asperiores atque. Atque soluta praesentium maxime beatae quo.\n\nDolor impedit harum nam eos qui in quibusdam. Cumque quos iusto delectus eligendi veniam. Vero quod nobis dignissimos molestiae nesciunt nemo. Nostrum ad aspernatur perspiciatis molestiae ducimus laborum repudiandae.\n\nQuis modi nesciunt quae ex odit quasi saepe. Labore eum iste sapiente consequatur. Molestiae quas laudantium nemo.\n\nNostrum eligendi placeat ut suscipit maxime. Expedita occaecati deleniti neque eum deserunt veritatis quia. Quos perspiciatis pariatur repudiandae et reiciendis. Beatae ipsam velit corporis enim fuga neque illum alias.\n\nA quos repellat eum maxime laboriosam. Ducimus aliquid suscipit porro in corporis nulla recusandae. Delectus aut voluptatum occaecati occaecati adipisci maxime repudiandae. Repudiandae non maiores nisi nobis.	66.24	\N	2017-11-27 23:30:48.688222+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
129	Arnold Group	Eius cumque quas voluptates esse eaque. Nesciunt eum dolore fugiat saepe nemo doloribus. Maxime velit temporibus cupiditate harum sequi deserunt. Nihil illo saepe magnam occaecati blanditiis.\n\nMinus dolorum optio in. Quia cupiditate deleniti eveniet quasi. Ratione sed hic ipsum reprehenderit reprehenderit quaerat placeat. Quaerat dicta nam cumque quas tempora.\n\nAb nihil quis perspiciatis quae similique earum aut. Aliquam amet eius molestiae rem alias. Cumque dolor quos voluptates velit voluptas modi consequuntur.\n\nMaxime nihil inventore aspernatur quis exercitationem sunt. Nobis hic ab quia atque iusto.\n\nQuo id repellendus mollitia at alias eos. Et eum soluta neque alias inventore voluptatem. Consequatur autem praesentium rerum. Perferendis iste inventore expedita saepe consequuntur molestiae inventore.	61.64	\N	2017-11-27 23:30:48.741573+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
131	Cline-Torres	Culpa eaque mollitia accusantium similique laudantium dolores ipsum. Eveniet voluptate natus perspiciatis placeat quisquam recusandae. Dolore officiis odio dolore ipsum. Eaque mollitia iusto sint odit reprehenderit repellat. Dolore impedit facilis ex excepturi fuga mollitia minus.\n\nExpedita perspiciatis quas molestiae expedita nesciunt facere. Tenetur natus molestias sapiente. Laudantium porro at consectetur officiis mollitia molestiae similique.\n\nAd sapiente sed perferendis nisi possimus ratione. Eligendi animi accusantium nobis officiis officia a in.\n\nRecusandae saepe esse repudiandae. Libero magni officia harum ipsum a incidunt. Totam maiores veniam possimus iste.\n\nVoluptate ut neque architecto. Accusamus magnam hic accusantium qui cupiditate quibusdam dicta. Est neque iusto nam perspiciatis tenetur dolorum praesentium. Adipisci voluptatibus provident quaerat ipsam facere reiciendis.	31.71	\N	2017-11-27 23:30:48.838259+00	2	"3"=>"6"	t	t
132	Graham-Benson	Voluptate suscipit ipsam soluta sunt. Quod quae vel provident reiciendis sed eveniet itaque. Dolor eligendi magni quia neque laudantium ducimus. Earum itaque quos distinctio quo.\n\nIncidunt excepturi officiis magnam asperiores velit modi ex. Velit est qui omnis dolor et rerum eveniet aliquam. Earum veritatis neque ea blanditiis ipsa autem.\n\nQuas ipsa similique eius voluptas minima. Explicabo quidem necessitatibus unde.\n\nMollitia illum veniam corrupti rem ipsum maxime velit. Ipsum dignissimos vel at iste earum quo. Voluptatum voluptatum nostrum alias qui distinctio eius. Voluptatum maxime esse inventore.\n\nAtque voluptate laboriosam assumenda quod assumenda. Reiciendis cumque sunt perferendis mollitia ex necessitatibus. Nostrum animi ipsa quidem impedit libero perspiciatis totam.	78.13	\N	2017-11-27 23:30:48.860291+00	2	"3"=>"6"	f	t
133	Wolf PLC	Labore inventore ducimus neque odit eligendi consequuntur. Modi aliquam natus similique commodi. Repellendus optio dolor ratione qui. Esse unde repellendus quidem laboriosam hic. Soluta occaecati dicta perferendis voluptatum.\n\nIncidunt quia iusto recusandae soluta. Deserunt nisi facilis maiores a maxime nemo illo. Eveniet amet eum nam at officia sapiente porro. Eaque dolorum delectus ratione eos tempora.\n\nInventore modi distinctio quibusdam consequatur ex. Unde aspernatur quasi aliquam tempora sapiente eveniet.\n\nCulpa natus veritatis ipsum id quasi. Sint harum consequuntur quidem aliquam impedit nisi labore. Repellendus sed in eaque explicabo dolor.\n\nRepellendus eaque sunt illo quasi ipsa officia possimus. Laboriosam fugit ex eum ipsam corrupti. Illum incidunt sequi amet quae. Expedita voluptates id omnis nostrum quo. Quasi quisquam fugiat blanditiis assumenda culpa.	19.74	\N	2017-11-27 23:30:48.890046+00	2	"3"=>"6"	f	t
130	Ferguson, Flores and Obrien	Minima dolore commodi distinctio voluptatum ipsam libero. Eveniet molestiae eius aperiam quaerat tempora. Saepe et placeat natus at cum amet eum. Labore ad quod non quo molestias necessitatibus ullam.\n\nEum consequatur explicabo id animi ea cupiditate esse. Asperiores quasi ea voluptatem voluptas. Saepe beatae impedit distinctio atque soluta minima deserunt.\n\nNulla dolore nemo provident non maiores officia. Quam expedita quibusdam voluptates harum deleniti aut totam. Non molestiae similique ratione natus adipisci.\n\nRecusandae animi non quis iste sit. Incidunt ducimus ad enim nesciunt temporibus. Exercitationem placeat minima mollitia quod quidem. Hic quis in repellat magni.\n\nFugiat impedit aspernatur ea blanditiis error repellat impedit corrupti. Itaque eligendi delectus velit maiores. Consequuntur cumque quaerat nihil ad.	80.91	\N	2017-11-27 23:30:48.783705+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
134	Snyder Group	Autem earum nihil tenetur id dolore sit repudiandae excepturi. Minus asperiores architecto enim magnam cum soluta. Rem soluta inventore mollitia molestiae tempora id. Cum nisi modi optio atque consequuntur.\n\nNeque alias fugit et fugit. Alias sequi architecto aliquid fugiat. Suscipit provident velit perspiciatis eaque consequatur. Possimus dignissimos suscipit ratione voluptas molestiae placeat voluptas. Aut dolorum ipsa necessitatibus optio ratione fuga.\n\nCommodi nihil quod officia quibusdam ex incidunt. Asperiores excepturi sit voluptatem minus error assumenda. Tempora tempore recusandae quidem doloribus.\n\nRatione dolore quidem ea quaerat illum illo nulla tenetur. Eos repudiandae occaecati aperiam voluptatem. Repellendus quae amet repellat unde nisi dolores deleniti.\n\nRepellat saepe dolore id natus nemo quo nesciunt. Temporibus pariatur numquam laborum accusamus cumque.	19.58	\N	2017-11-27 23:30:48.922661+00	2	"3"=>"6"	f	t
135	Cantrell-Payne	Animi quia dicta occaecati est facere iure laboriosam repellendus. Saepe omnis nisi qui possimus illo sint officia. Pariatur aut dolorum voluptas. Nobis dicta magnam ut et accusamus.\n\nQui error reiciendis iusto. Dolores ut dolorem nobis accusantium debitis. Repudiandae cumque quae earum cum provident dignissimos autem. Commodi fuga commodi fugiat eius. Quo voluptates minima aut perspiciatis fugit nihil rerum.\n\nIste nemo dolorum mollitia distinctio blanditiis. Eveniet veritatis aut inventore impedit explicabo rerum. Illum aperiam dignissimos possimus. Quis unde numquam consequuntur aliquam. Doloribus est fugit itaque.\n\nIllo doloribus omnis nesciunt. Corporis perspiciatis molestiae iusto aliquid magni eos tenetur sed. Repellat in voluptate architecto.\n\nSit sapiente id nihil. Eveniet ipsum omnis voluptas odit. Rem a quibusdam rerum delectus inventore sint.	20.59	\N	2017-11-27 23:30:48.941219+00	2	"3"=>"6"	f	t
136	Stark and Sons	Dicta dolore cum corporis sed. Alias eos deserunt commodi dolores doloremque. Sed ut illum excepturi illo sit perferendis.\n\nIn asperiores placeat atque quae sapiente itaque nesciunt. Aliquid dignissimos aut dolor accusantium molestiae facere natus. Sit dolor corrupti corporis a incidunt fugit aperiam libero.\n\nDolores repudiandae placeat id amet. Laudantium dolorum suscipit illum cum eum veritatis voluptate. Tempora voluptatem nihil sed nisi omnis eos voluptatibus nesciunt. Vitae quam corporis dolor deserunt iure deleniti saepe. Vero error quod temporibus quidem accusamus corrupti pariatur.\n\nQuod atque excepturi animi quaerat quas velit animi earum. Doloremque magni soluta animi qui. Quaerat veniam itaque repellat nobis. Itaque sit corrupti laborum maxime.\n\nLaudantium sint nam veritatis iusto recusandae. Quidem distinctio eveniet autem eligendi.	5.96	\N	2017-11-27 23:30:48.974297+00	2	"3"=>"6"	f	t
137	Kennedy PLC	Cumque quia inventore eveniet iusto commodi quibusdam odit aliquam. Sit repellat nam laudantium nostrum tempora quam voluptatum. Culpa voluptatem soluta ratione voluptatem a consequatur quia. Nihil accusantium veniam quidem quaerat sint cumque. Eos officia atque quia consectetur voluptas.\n\nSint molestiae unde accusamus dolore enim. Ratione ea consequatur repellat necessitatibus laborum. Dolore aliquid inventore optio quis repellat voluptatum repellat.\n\nUt aliquid molestias aliquid. In magni porro architecto aut. Quas similique aspernatur quos voluptates voluptatem enim delectus blanditiis.\n\nIusto est fugiat exercitationem enim molestias asperiores atque. Consectetur quas tenetur magnam vitae. Tempore fuga veritatis labore. Laboriosam perspiciatis sapiente soluta hic.\n\nIusto officiis eum eius dolores eius veniam animi. Sed occaecati ut soluta soluta in in.	19.63	\N	2017-11-27 23:30:49.005516+00	2	"3"=>"6"	f	t
138	Gonzales Ltd	Expedita officiis ipsum similique itaque dolorem odit. Incidunt doloribus exercitationem at voluptates saepe repellendus. Adipisci quaerat quas repudiandae laudantium autem facere illo. Quaerat sed repellat recusandae ducimus.\n\nAsperiores similique deserunt similique dolore maiores distinctio. Sunt assumenda a facilis optio commodi nobis. Amet sunt quo aperiam minus autem minima consectetur nostrum.\n\nOccaecati alias exercitationem nobis voluptatibus aperiam natus vitae. Placeat itaque unde consequatur. Earum enim nisi velit iusto explicabo vero. Alias quibusdam aliquam possimus dicta voluptate nihil.\n\nOptio quibusdam ducimus eligendi possimus maiores vero iure. Mollitia rerum ut quas consectetur. Officiis delectus voluptate dolores nobis ad accusantium maiores voluptates.\n\nFuga ab quasi minus consequuntur harum dignissimos quasi. Numquam quam eligendi eligendi odit quo placeat. Tempore temporibus quibusdam incidunt amet doloribus provident.	24.66	\N	2017-11-27 23:30:49.026993+00	2	"3"=>"6"	f	t
139	Rodriguez, Davidson and Jackson	Perferendis libero inventore ullam distinctio. Totam est eum consequatur voluptas ad totam. Harum numquam qui ipsam repellat veniam vitae similique. At laboriosam sint rem nostrum deserunt.\n\nDistinctio fuga nobis vel nobis. Ea sunt voluptate repudiandae itaque illum aliquid tenetur. Iste asperiores eaque maiores et necessitatibus alias.\n\nSuscipit assumenda non dolores quaerat hic tempora blanditiis. Laborum incidunt quam soluta temporibus. Id iusto fugit molestiae ratione cupiditate sed sit. Quam suscipit corrupti debitis.\n\nDebitis quo reprehenderit animi praesentium temporibus nobis exercitationem. Harum labore id unde magnam amet. Quam itaque atque soluta.\n\nA dolores ipsam distinctio distinctio quam. Sapiente cumque nobis neque ab nostrum. Soluta consectetur nulla aut nostrum laborum. Asperiores esse dolorem error quas.	30.30	\N	2017-11-27 23:30:49.059608+00	2	"3"=>"6"	f	t
140	Smith-King	Dicta voluptates reiciendis aperiam. Accusamus esse officiis quis quo officia sit explicabo delectus. Rem nihil corrupti dolorem sunt.\n\nHic voluptatum culpa veritatis accusantium modi iste amet. Dicta eius neque odio labore possimus. Nobis eius dolore dolor.\n\nMaxime quibusdam consectetur et. Distinctio beatae numquam saepe tenetur deleniti et optio. Quaerat non eveniet magnam doloremque reprehenderit dolorum dolor. Saepe sapiente commodi dolorem iste expedita asperiores. Suscipit deleniti atque architecto error distinctio.\n\nQuae vel aperiam provident animi. Facere ad est quia quaerat cupiditate illum mollitia. Provident saepe eius ratione architecto.\n\nError modi beatae molestias assumenda. Sequi quae earum laborum nobis perferendis. Vel quidem quisquam quasi est facilis deleniti cum eius.	87.67	\N	2017-11-27 23:30:49.084619+00	2	"3"=>"6"	t	t
143	Key, Leonard and Sanchez	Inventore ullam blanditiis atque animi ullam. Rerum sit deleniti vel minus. Assumenda eveniet aut quo id ea corrupti accusantium magni. Culpa voluptatum quis laborum ex.\n\nBlanditiis harum deleniti rerum doloribus vel magnam. Quos cum quibusdam iusto repudiandae minus. Harum quam unde sint accusamus numquam. Velit eligendi laboriosam quae. Architecto quaerat porro cupiditate dolor inventore.\n\nTotam nemo aspernatur hic reprehenderit minima mollitia labore. Eligendi asperiores at optio ea. Culpa saepe autem fugit laborum sapiente voluptates sed. Id sapiente similique necessitatibus molestiae sed unde eius. Quia odit numquam facilis suscipit.\n\nSed at voluptate eveniet odio consectetur nihil assumenda repellendus. Aut expedita molestias voluptates ratione magni amet. Tenetur deleniti architecto repellendus a perspiciatis. Quaerat enim perferendis assumenda quae hic dolores nulla.\n\nAtque sed omnis vero tempore maiores nesciunt alias ea. Culpa error beatae quasi debitis libero tempore temporibus. Fugit nostrum quibusdam illum enim alias.	59.73	\N	2017-11-27 23:30:49.189584+00	3	"3"=>"6", "5"=>"14"	f	t
144	Guerrero-Smith	Ab facilis exercitationem amet. Quod itaque inventore vel. Porro dolore neque libero dolores veniam.\n\nVoluptatem veniam officia quidem natus. Earum atque ullam odit inventore quas eum. Veniam repellat voluptas tempore culpa ratione aut perferendis.\n\nQuos at nisi delectus illum commodi corporis. Nostrum officiis iure itaque expedita dicta maiores corrupti.\n\nPorro odit nihil sequi id maxime nemo neque quisquam. Necessitatibus quas voluptas excepturi rem aperiam. Provident dolore praesentium ex quod sequi fugiat. Dolorem sed enim modi ea.\n\nFacilis nam itaque voluptas consequatur asperiores. Vitae tempore voluptas itaque debitis praesentium. Necessitatibus aut itaque dolor doloribus deleniti. Sit consectetur repellat cupiditate officia.	5.12	\N	2017-11-27 23:30:49.221079+00	3	"3"=>"6", "5"=>"13"	f	t
145	Faulkner, Cisneros and Bautista	Expedita quibusdam excepturi vitae similique perspiciatis illo. Perferendis iusto consequuntur facilis nulla accusantium unde ducimus. Exercitationem dolor ut tempore sit praesentium natus nesciunt.\n\nNeque sequi ex fugiat consequuntur sint id. Inventore reprehenderit ipsum dolorum deserunt. Delectus dolorem suscipit eum aliquam non. Nisi earum ut sint ex.\n\nIure minus cumque soluta ea id odit tenetur. Fuga sequi consequuntur autem unde molestias ipsa excepturi. Inventore neque tempore aperiam facilis ab dicta.\n\nIpsam necessitatibus sint recusandae nostrum. Culpa inventore veniam sint ad officiis aperiam ex. Adipisci illum aliquid tempora illo maiores libero.\n\nVeritatis quidem numquam nihil consequatur minima molestiae. Blanditiis accusamus corporis quisquam dignissimos nobis adipisci. Sed sit eligendi aspernatur maxime. Aspernatur cupiditate praesentium a minus.	38.58	\N	2017-11-27 23:30:49.263839+00	3	"3"=>"6", "5"=>"13"	f	t
147	Pena, Mathews and Hampton	Harum soluta sapiente facere est ratione. Modi culpa sint modi in pariatur consequatur. Perspiciatis rerum fugiat ullam sapiente.\n\nQuibusdam quam cum fuga. Voluptates facere voluptates possimus voluptatum deleniti nesciunt ipsum. Asperiores tempora exercitationem harum in.\n\nTempore voluptatum aliquid provident quasi. Deserunt temporibus quia quia architecto consectetur dolore. Eos nihil a ipsa molestias dicta ab. Adipisci quisquam laboriosam temporibus ipsum.\n\nItaque laboriosam veniam architecto. Accusantium aliquid itaque aliquid mollitia officia natus amet. Iste quod itaque tempora distinctio inventore quas.\n\nNisi error totam sit laborum nemo recusandae. Ex atque corrupti excepturi repellendus rem. Rerum eaque accusantium occaecati sit non. Assumenda itaque laudantium reprehenderit perferendis dicta in.	83.70	\N	2017-11-27 23:30:49.356834+00	3	"3"=>"6", "5"=>"14"	f	t
146	Hicks-Huynh	Ipsum officiis vero illum excepturi sapiente officiis. Consequuntur laborum et non hic. Animi quis iste non eligendi reprehenderit reiciendis doloremque. Quasi incidunt aspernatur sed aperiam suscipit nesciunt.\n\nDolorum repudiandae repellendus quo quisquam. Voluptates unde aliquam voluptates eveniet eum libero asperiores. Quibusdam quod iste non magni.\n\nPariatur corrupti vitae unde facere. Aperiam aspernatur odio ullam sapiente a.\n\nOccaecati suscipit delectus perferendis deleniti beatae. Sapiente quae blanditiis itaque ipsa. Veritatis velit provident autem amet iure.\n\nFugit quae hic impedit. Incidunt sapiente asperiores officia adipisci. Rem rerum voluptatum ratione. Numquam ipsam quaerat dolor.	78.75	\N	2017-11-27 23:30:49.308711+00	3	"3"=>"6", "5"=>"13"	t	t
148	Riddle Inc	Reiciendis saepe similique repudiandae consectetur voluptatem quidem suscipit. Quibusdam reiciendis illo eos doloremque. Molestias repellendus laboriosam sunt soluta tenetur nesciunt exercitationem.\n\nIste laborum nesciunt delectus similique quis. Tempore libero assumenda nemo libero quae. Vel deleniti quisquam vero impedit quibusdam recusandae.\n\nLabore dignissimos quo placeat error sed. Dolorum deleniti corporis voluptatem explicabo deserunt quidem animi. Numquam totam omnis consectetur nisi. Reprehenderit similique fuga natus quibusdam.\n\nAperiam eveniet alias mollitia cupiditate. Ea soluta vel perspiciatis minima voluptatibus. Aut odio non pariatur omnis.\n\nQuidem quam ut inventore eius necessitatibus earum amet. In quibusdam eius eaque velit. Illo temporibus nesciunt excepturi inventore sit occaecati.	65.60	\N	2017-11-27 23:30:49.395139+00	3	"3"=>"6", "5"=>"13"	t	t
153	Romero, Jackson and Smith	Reiciendis repellendus quasi illo cumque nesciunt quidem. Exercitationem in quam doloribus pariatur magni. Dolorem recusandae facilis optio velit.\n\nSaepe modi architecto modi commodi. Corporis harum provident aut omnis similique iure. Facilis amet incidunt dolorem magni magnam vitae.\n\nSequi eveniet quo illo occaecati eum animi aspernatur iste. Quidem unde ad ab deleniti. Id doloribus eaque ducimus tempora sapiente. Repellendus tenetur voluptatibus a optio laborum.\n\nOmnis ex magnam voluptatibus corrupti exercitationem iure. Rerum distinctio laborum aspernatur odio sequi quis earum animi. Dignissimos molestias labore et nesciunt deserunt reiciendis.\n\nAdipisci animi consequuntur natus ea dolore. Maxime provident nemo fugit occaecati. Ea voluptatem dicta exercitationem omnis.	45.85	\N	2017-11-27 23:30:49.569383+00	4	"3"=>"6", "7"=>"20"	f	t
155	Martinez-Matthews	At repellendus veritatis cupiditate animi deserunt. Dolores perferendis voluptatem eos. Consequuntur voluptate aspernatur non accusantium. Praesentium aspernatur eaque ut eius aliquid ullam.\n\nSuscipit laborum voluptatibus dicta nostrum ipsum repellendus. Error amet rem repellendus totam animi. Atque sit quibusdam natus. Doloremque inventore quasi quibusdam quidem illo.\n\nAnimi voluptatem sapiente expedita porro accusamus aliquid sit. Iure illum itaque illum veritatis suscipit necessitatibus recusandae. Est soluta assumenda quae ab.\n\nQuam unde repudiandae repellendus pariatur voluptates. Earum recusandae iste sit reiciendis. Deserunt aspernatur nulla eius adipisci aspernatur optio corrupti.\n\nDoloremque nulla nobis aut. Libero illum totam ut. Vero quas labore quas ducimus provident reiciendis. Quia officia vitae pariatur. Accusamus dicta consequuntur repellat in voluptatem velit velit.	3.35	\N	2017-11-27 23:30:49.635438+00	4	"3"=>"6", "7"=>"19"	f	t
156	Moore-Anderson	Animi sunt aspernatur est ad veniam rerum architecto alias. Dolorum atque asperiores doloremque esse ipsum. Sapiente occaecati culpa sapiente illum quas debitis asperiores.\n\nAutem suscipit modi minima omnis veritatis. Beatae quisquam excepturi voluptatum vitae dicta recusandae quidem iusto. Iste libero delectus eaque dolor dolorum.\n\nExplicabo fuga aliquam repudiandae similique. Nulla voluptatum ipsam quaerat iusto. Repudiandae vitae ullam illum sunt dolores odit. Necessitatibus tenetur et laborum error quod.\n\nAutem ut labore aliquam quos architecto natus laboriosam. Consequuntur totam error in consectetur autem et. Consequatur molestiae unde explicabo doloribus eos atque. Quo nemo a natus porro.\n\nUnde quo cumque facilis mollitia repellendus aspernatur vel. Eius repudiandae ad pariatur at. Quisquam possimus maxime qui saepe qui necessitatibus.	39.81	\N	2017-11-27 23:30:49.665615+00	4	"3"=>"6", "7"=>"20"	f	t
157	Golden, Moore and Waters	Atque quisquam sit harum provident dolorem optio a. Eveniet ut quasi doloribus similique. Cupiditate doloremque ipsam similique cum molestiae. Rem atque aliquam quo exercitationem consequuntur harum.\n\nIncidunt perspiciatis quibusdam voluptate aut. Tempore maxime unde facilis nam cupiditate illum. Nemo error repudiandae error dicta eveniet qui harum voluptatem.\n\nIn sunt explicabo et iusto libero quidem. Quos itaque suscipit neque illo minus aliquam. Qui ducimus cumque labore dolorem quidem. Dolores ab ad voluptates non veniam veritatis labore excepturi.\n\nIpsa accusantium aut consequatur. Assumenda fugiat molestias distinctio ratione exercitationem neque ipsam. Minus omnis natus error illum quo recusandae occaecati sequi. Deserunt accusamus qui magni dignissimos mollitia. Illum temporibus ullam mollitia nobis cumque quaerat porro similique.\n\nQuo aliquid atque dolore cumque quae qui. Corrupti unde optio modi nisi laboriosam adipisci dolore dignissimos. Cum non praesentium distinctio id quos delectus at.	10.56	\N	2017-11-27 23:30:49.704667+00	4	"3"=>"6", "7"=>"19"	f	t
158	Jordan-Howard	Sunt voluptatibus ullam a ratione ratione quibusdam. Temporibus eveniet magnam dolor illum at fugit. Ea optio harum accusantium recusandae eaque blanditiis quae. Tempore mollitia aliquid tempora iste perferendis.\n\nVero non omnis odio placeat. Deleniti in ducimus et mollitia. Modi impedit odit accusamus expedita ab harum voluptas cumque.\n\nDelectus aspernatur dignissimos iste libero esse laudantium. Unde ullam illum similique. Sit voluptate laborum eum sit inventore ipsam commodi.\n\nAperiam iste aspernatur iusto at corporis explicabo perspiciatis. Qui perferendis est accusamus voluptatum aut fugit. Esse alias veniam in tempore architecto eaque.\n\nTempore sit perferendis earum ipsam eaque. Distinctio nostrum aspernatur officiis nostrum cumque ullam. Quas amet modi repellendus minima beatae. Expedita quo ipsam nobis cum.	25.35	\N	2017-11-27 23:30:49.746348+00	4	"3"=>"6", "7"=>"19"	f	t
159	Hays and Sons	Dolorem laborum dicta aut esse dignissimos fugit earum. Cupiditate omnis fuga consequatur exercitationem assumenda beatae. Consequuntur quod ipsa ipsa. Fuga voluptatibus odit molestias deleniti illum minus aliquid.\n\nIpsam veritatis nisi porro odit temporibus. Deleniti rem assumenda facere nobis maxime laboriosam. Inventore odio maiores eum itaque odit ab.\n\nExcepturi doloribus est perspiciatis. Vero accusamus id rem adipisci similique. Aut aliquid sequi facilis quasi itaque.\n\nFacere cumque facilis expedita harum. Blanditiis quod hic tempora maxime vero quod soluta. Aliquam vel minus voluptas perspiciatis. Quidem animi at qui unde magnam molestias qui error.\n\nAliquam voluptatem voluptate harum fuga excepturi vero voluptatum atque. Praesentium beatae quis vel laudantium ut harum. Animi quaerat cum eveniet laudantium veniam ullam.	3.99	\N	2017-11-27 23:30:49.782442+00	4	"3"=>"6", "7"=>"20"	f	t
154	Sanchez Ltd	Magni temporibus cumque hic mollitia quibusdam labore. Unde et vel atque autem harum. Reprehenderit tempora aperiam omnis vitae odit magnam quidem.\n\nCupiditate minus laboriosam fugit atque et. Debitis nobis deserunt voluptatibus placeat autem. Id sapiente officiis officiis nisi eius velit. Sit ex inventore veniam saepe quas quisquam.\n\nAmet eligendi corporis excepturi nisi consequuntur. Qui rem hic enim ratione voluptatum eligendi. Repudiandae optio harum vero exercitationem laboriosam.\n\nAd nihil ab ea voluptatibus alias. Et facilis nostrum maiores ab soluta. Occaecati accusamus omnis provident expedita totam harum voluptate.\n\nCum possimus illum accusantium culpa. Vero excepturi perferendis maxime. Molestiae ducimus totam numquam blanditiis similique dicta quod.	32.76	\N	2017-11-27 23:30:49.600157+00	4	"3"=>"6", "7"=>"20"	t	t
161	Hunter, Bell and Mccarty	Laudantium voluptate aspernatur quis molestiae quibusdam fugiat natus. Voluptatum eius alias hic asperiores laudantium consequuntur. Rerum ullam maxime quaerat error aliquam saepe. Nam cumque nisi quae id ipsum.\n\nQuas facilis esse harum tempora soluta explicabo sint. Sint quibusdam id corporis qui occaecati corporis neque culpa.\n\nImpedit numquam dolorum eveniet commodi. Temporibus commodi officiis impedit iusto exercitationem. Molestiae architecto laboriosam sunt rerum in tempora rem accusamus.\n\nLaboriosam earum temporibus esse voluptates dolorum recusandae iure excepturi. Porro voluptate magnam tenetur laboriosam. Veritatis esse quo cumque eius reprehenderit.\n\nAsperiores perspiciatis aliquam totam sint tempora hic qui fugiat. Fugit et aut odit amet. Ducimus qui reiciendis error fuga cupiditate aperiam.	30.28	\N	2017-11-27 23:30:49.859283+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
162	Everett Inc	Tenetur quod incidunt doloremque doloremque quis nulla. Dicta a laudantium eveniet provident accusamus cupiditate. Soluta repudiandae sunt suscipit nihil ducimus harum. Facilis mollitia ea fugiat maiores ut.\n\nFacilis molestiae delectus assumenda voluptates sequi mollitia harum. Accusantium quasi nihil cum id repudiandae sunt. Illum repudiandae quisquam laborum quia veritatis occaecati odit quo.\n\nMolestias placeat eveniet tenetur delectus rem animi quaerat. Odio eaque minus porro officiis. Dignissimos voluptatibus natus officia distinctio cupiditate eos.\n\nMaxime doloribus voluptatum aut error provident occaecati quas. Quibusdam iusto quaerat velit rem magnam beatae. Culpa ea non culpa cupiditate error placeat voluptatibus. Odio vel perspiciatis similique repellendus harum inventore est.\n\nAccusantium unde accusantium excepturi commodi delectus. Ducimus eius placeat aspernatur atque. Saepe quis autem minima quaerat dolore debitis aliquid nihil. Esse unde eligendi vero molestiae vitae facere eius.	66.13	\N	2017-11-27 23:30:49.891216+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
163	James-Jones	Doloribus voluptates in maxime aperiam at. Praesentium quidem cupiditate laborum eum voluptatem doloremque facilis. Commodi eum perferendis facilis quam labore. Rerum maiores laborum numquam quod repellat animi.\n\nPraesentium molestiae placeat recusandae vitae deleniti soluta. Voluptas error harum molestiae soluta. Molestiae iste odit enim dolor consequatur culpa tenetur. Illo impedit nesciunt voluptate explicabo deleniti numquam.\n\nCorrupti harum id nemo repellat dolores. Culpa suscipit quis deleniti modi ex quaerat. Rem optio eius maxime minus officiis.\n\nUt placeat laborum nisi sapiente perspiciatis neque sapiente. Vitae quis cum consequatur dolores asperiores voluptas. Est occaecati et quod vero harum architecto dolores. Repellendus sapiente rerum harum reprehenderit vero voluptatibus.\n\nDeleniti repellat cum sapiente. Magni ea enim eaque.	73.30	\N	2017-11-27 23:30:49.912852+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
164	Moss LLC	Exercitationem distinctio accusantium nostrum inventore totam. Quae officia similique officia quisquam maiores nemo.\n\nAspernatur explicabo placeat perferendis quam. Enim ut accusamus porro voluptates. Quibusdam inventore sapiente reprehenderit illum iste eius. Pariatur architecto nesciunt deleniti.\n\nExcepturi expedita at esse alias laudantium numquam temporibus. Assumenda beatae illo necessitatibus. Accusantium quas repellat distinctio fugiat illum.\n\nEsse eum odit sint veritatis tenetur earum voluptatibus. Aliquam necessitatibus maiores sint quo. Et beatae doloribus cumque doloremque.\n\nSequi temporibus reiciendis quidem quidem et cum. Commodi molestiae illo numquam sequi iusto natus repellat.	16.16	\N	2017-11-27 23:30:49.955288+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
165	Espinoza-Hendricks	Consequuntur tempora in assumenda ullam id. Corrupti quisquam commodi aut sint corrupti aliquam vitae. Corrupti tempora laborum alias nesciunt.\n\nEst quam molestias autem facilis qui animi est. Quaerat voluptatem sint quas eveniet maxime ullam. Dolore dolores dolorem fugit. Quia voluptas similique minima excepturi vel eaque occaecati.\n\nVoluptate minus excepturi ipsum illum ex. Laboriosam ea pariatur amet tempora architecto exercitationem aliquid. Placeat saepe molestiae porro natus laborum provident. Dolor in sapiente qui nisi.\n\nIllum veritatis non ullam atque quas. Velit pariatur vel ea rerum architecto. Quibusdam aut sed incidunt in saepe blanditiis.\n\nNeque laborum dolores magni cupiditate nam dolores. Nesciunt corrupti laborum mollitia doloremque sint. Nulla eaque maxime quaerat cum quibusdam. Quas natus dolore eos nam.	67.40	\N	2017-11-27 23:30:49.990082+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
160	Williams Group	Esse totam voluptas dolorem eum nulla. Ipsa animi non dolor velit est error.\n\nCumque praesentium necessitatibus minima dolore commodi deserunt. Soluta cum nulla sint officiis maiores. Necessitatibus voluptates architecto nobis voluptates sequi. Est nulla fugit inventore deleniti nulla nam possimus.\n\nIllum a corporis dignissimos aliquam. Est consequuntur dolores totam fugiat repellendus id consequatur. Eum et temporibus adipisci. Consequuntur itaque numquam eum suscipit expedita ipsam autem.\n\nVoluptates soluta animi eligendi laboriosam inventore quod quod. Expedita molestiae nemo sint odio architecto nobis. Delectus dignissimos excepturi animi facere ducimus repellendus aspernatur. Ea eius in ipsam cupiditate sint suscipit.\n\nEx occaecati eligendi asperiores. Quasi quos odit magni eveniet assumenda pariatur. Qui eius maiores accusantium quod. In error in magnam fugit dolorem.	94.88	\N	2017-11-27 23:30:49.820847+00	4	"3"=>"6", "7"=>"20"	t	t
166	Lewis, Graves and Ballard	Recusandae dolorum voluptates dolorum incidunt deserunt laborum. Eveniet officiis illum magnam quae dolore possimus occaecati nemo. Facere quisquam placeat fugiat distinctio dolor. Quod quis totam hic vel. Deserunt cum cupiditate debitis occaecati.\n\nNisi repellat animi recusandae deleniti maxime delectus quasi inventore. Nihil nihil magnam facere quaerat consectetur rerum. Maxime error quaerat iste iste possimus sapiente maxime.\n\nIn nemo aperiam fugit eligendi itaque earum ullam. Iusto nemo aut at commodi facilis. Vel natus perspiciatis excepturi distinctio at iste fugit. Corporis earum fugit accusantium dicta explicabo in.\n\nPariatur aperiam tempore id aperiam molestiae. Quisquam rem laborum officia aliquam enim dolores illo. Perspiciatis ex fugiat hic id tenetur nihil.\n\nAspernatur necessitatibus nemo dolorum possimus nemo numquam consectetur. Beatae commodi vitae iusto culpa corrupti. At earum voluptatum laboriosam. Porro nulla odit iure dolorum quia delectus expedita.	74.10	\N	2017-11-27 23:30:50.013237+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
168	James, Wilson and Garcia	Magni perferendis molestiae aliquam. Vitae molestiae magnam dignissimos exercitationem sed. Corporis eligendi officia excepturi architecto corporis.\n\nSimilique aliquid illo pariatur aperiam. Rem veniam quos error fuga.\n\nCorporis facilis non tenetur molestiae veniam corrupti. Sint itaque repellat consequatur odit libero quaerat pariatur. Consectetur odio enim consectetur exercitationem amet tempore dignissimos dolorem. Quia eos dolores id ad amet.\n\nSunt repudiandae autem velit tempora voluptatem et placeat. Quis modi repellat consectetur beatae impedit repellat. Distinctio debitis iste inventore neque commodi. Illo quis reiciendis ipsum doloribus accusamus.\n\nNulla eius perspiciatis enim repudiandae qui sint. At ducimus magnam saepe quibusdam. Nobis repellat saepe maxime ipsam.	33.95	\N	2017-11-27 23:30:50.065338+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
169	Rojas Group	Corrupti nobis esse quisquam quas. In nam veritatis explicabo inventore occaecati maiores non. Eligendi nisi asperiores eos sapiente explicabo debitis dolorem vero.\n\nNeque placeat assumenda earum rerum voluptatem culpa qui. Occaecati saepe beatae eius minima neque reprehenderit. Nulla laborum similique non libero quaerat deleniti eveniet.\n\nVoluptatibus iure aut quis expedita. Nesciunt itaque numquam vel in autem in pariatur. Sint blanditiis beatae laborum pariatur aut sequi earum occaecati. Facere tempora voluptate consectetur officia eos cupiditate neque.\n\nEa adipisci optio nobis atque totam. Voluptate consequatur ut corporis sapiente recusandae accusantium cupiditate.\n\nRepellat quia nemo repellendus facilis incidunt odit. Enim dolorem blanditiis soluta nam. Quibusdam nisi eaque quam nemo eum assumenda.	13.25	\N	2017-11-27 23:30:50.101875+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
170	Krueger, Perry and Wagner	Tempore dolorem nobis aut eligendi omnis omnis. Odio provident facilis minus officia. Voluptatibus praesentium enim autem aliquid pariatur omnis iste quam. Quas reiciendis vero amet voluptates dignissimos at est. Veritatis laborum praesentium iste.\n\nMolestias minima quasi aspernatur eos esse. Consequuntur veritatis alias dolore consequuntur illum vero eveniet. Aliquam voluptatem sit quia deleniti. Deleniti exercitationem similique nulla nesciunt accusamus excepturi quaerat quos.\n\nRem id qui aut cupiditate. Nisi tempore nostrum impedit aliquam veritatis dolorum. Dignissimos nesciunt sint corrupti minima libero sed libero eveniet.\n\nVero iste provident dicta ullam molestiae repellat nihil. Aliquam ipsum in natus doloribus illum delectus voluptas. Labore maiores possimus inventore consequatur nihil laboriosam totam.\n\nQuas in reprehenderit labore nobis ducimus. Nobis totam non laborum itaque quam totam. Amet quo cum inventore quod et magnam fugit. Quibusdam distinctio omnis distinctio aut ipsa officiis.	61.39	\N	2017-11-27 23:30:50.12816+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
171	Sanders-Bowman	Molestiae quas odio repudiandae nisi. Autem pariatur pariatur odio nostrum.\n\nDoloribus dolorum consectetur nam culpa quis eum. Iste possimus maiores reprehenderit nihil. Id aliquid quo neque eum veritatis rerum recusandae. Sit voluptatum nesciunt minima rerum temporibus.\n\nProvident qui in velit consectetur. Ratione culpa rem natus velit modi tempora sit. Praesentium consequuntur nulla repudiandae rerum sunt. Inventore minus deserunt soluta sequi eveniet vitae sint.\n\nDistinctio distinctio eveniet animi voluptatibus dolor deleniti rem corrupti. Delectus libero accusantium corrupti. Aliquam sapiente error placeat esse occaecati doloribus omnis ex. Tempore atque neque commodi eveniet.\n\nReprehenderit perspiciatis laudantium laborum similique. Dolores voluptas possimus delectus atque laudantium animi assumenda. Provident commodi repellat quidem officiis.	55.33	\N	2017-11-27 23:30:50.160809+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
185	Torres Ltd	Nobis ea voluptates pariatur et. Culpa accusamus ut pariatur perferendis maiores. Ea aliquam nam necessitatibus fuga. Voluptate cumque doloremque est harum earum maxime.\n\nMinima modi temporibus nulla modi expedita. Facere sit velit earum commodi sequi quaerat. Quis culpa esse quia.\n\nAutem inventore commodi ab nisi. Reprehenderit soluta ex possimus velit laboriosam facilis voluptatem. Culpa laudantium optio corrupti. Expedita rerum atque accusantium occaecati corporis amet nostrum.\n\nQuo quaerat excepturi accusamus ullam veniam corrupti perspiciatis. Natus quae excepturi reprehenderit qui. Voluptas tempora quasi ab neque ea. Nisi possimus error neque voluptatibus ut.\n\nDolor commodi unde assumenda doloribus quia voluptatem magnam. Similique nisi dolore eveniet reprehenderit. Praesentium doloribus dignissimos dolores cum. Ad eos nemo a.	77.77	\N	2017-11-27 23:49:11.677237+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	t	t
186	Morales-Roberts	Eum excepturi non veniam culpa distinctio ipsum. Quasi hic similique est minus excepturi est amet mollitia. Blanditiis aliquam expedita similique.\n\nNesciunt voluptatum laudantium vero neque nemo quibusdam fugit. Hic fugit ad adipisci numquam. Nobis repellat maiores dolor minima occaecati.\n\nQui atque ipsum unde molestiae ullam autem dignissimos. Iste dolore ducimus voluptas culpa aliquam earum id. Doloribus quaerat cumque animi ipsam odio. Perspiciatis voluptatem magnam magnam nesciunt culpa officiis quidem.\n\nLaboriosam ut vitae in. Optio nemo dolores quod cumque dolorum.\n\nFugiat est neque eos perferendis. Impedit omnis officiis voluptatum non minima non. Id est nihil dicta aspernatur praesentium.	58.40	\N	2017-11-27 23:49:11.729995+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
172	Bennett LLC	Perspiciatis nemo ut minus excepturi eligendi cum ipsa et. Quasi animi placeat laudantium nisi. Similique aliquid inventore debitis fugiat quia dignissimos. Fuga impedit hic temporibus deserunt sapiente et doloribus. Voluptatibus quod earum expedita at id.\n\nDeserunt placeat voluptatibus nisi maxime. Deserunt maxime rerum ipsum maxime.\n\nDeleniti aspernatur consequuntur laboriosam totam occaecati fuga. At dolores repellendus assumenda reiciendis beatae a dolore. Libero totam esse doloremque quae ullam libero sint. Quis occaecati et nam unde qui ducimus error. Id sed quidem nesciunt tenetur quas.\n\nNihil dolore provident voluptatem tempora quae culpa animi et. Officiis quae consequuntur excepturi molestias. Autem cupiditate dolores dolor rem dolores animi repudiandae consectetur.\n\nQuam cumque perferendis aut accusantium nulla dignissimos ad. Reprehenderit optio id enim eaque consequuntur consequuntur. Eaque cumque dolores error beatae.	37.79	\N	2017-11-27 23:30:50.186718+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	t	t
173	Brewer-Oliver	Nulla ab impedit dolorem dolor quidem. Quo accusamus numquam in distinctio. Eaque suscipit sed at. Nemo similique aperiam asperiores fuga nobis occaecati nulla.\n\nSimilique sint saepe repellat error. Eum ab minus eaque fugiat quae. Fuga quas repellendus accusantium ducimus voluptate. Laudantium fugiat accusantium amet molestiae voluptatibus sequi.\n\nAlias quidem architecto cum voluptate nesciunt. Veniam ducimus est necessitatibus occaecati corrupti. Provident reiciendis quisquam voluptas soluta dolor voluptatem. Reiciendis rem eos corrupti dolores possimus error delectus voluptates.\n\nQuis alias minima culpa neque. Iste minus delectus consectetur minus placeat odit. Quod occaecati quis vero tempore. Culpa laudantium consectetur asperiores culpa suscipit possimus quam temporibus. Earum voluptatibus aut reiciendis ipsum suscipit esse mollitia.\n\nDolor est dolor eligendi labore reprehenderit. Ut eius ut maiores. Natus deleniti autem impedit velit praesentium corporis dicta.	53.29	\N	2017-11-27 23:30:50.214649+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
174	Martinez-Smith	Voluptates facere veniam quis officiis ipsum. Maxime commodi porro sed sunt eum nesciunt. Officia aliquam facere iste molestias esse sapiente nam.\n\nInventore id iusto doloremque expedita. Nisi voluptatum rem natus cumque asperiores cum quo officiis. Asperiores repellat delectus assumenda laudantium.\n\nMaiores repudiandae quibusdam animi veritatis officiis. Sint labore possimus assumenda tenetur ut. Voluptas tempora recusandae nemo magni. Natus doloribus eos dolorum voluptatum. Quasi velit quidem provident dicta.\n\nAperiam eveniet quis corrupti tenetur non. Expedita sunt saepe necessitatibus blanditiis eum dignissimos. Provident dolor aspernatur provident.\n\nEst saepe quia nesciunt earum. Mollitia mollitia vitae ipsam et. Quos est minus perspiciatis non esse aspernatur animi.	18.55	\N	2017-11-27 23:30:50.256102+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
175	Young, Moreno and Lawrence	Nesciunt error consectetur consequuntur dicta impedit voluptate. Necessitatibus possimus facilis sequi voluptate. Unde itaque perspiciatis delectus rem fugiat praesentium aliquam. Aliquam libero eum deserunt provident fugit quia.\n\nIpsam numquam corporis earum dolorem enim itaque. Sapiente illo asperiores dolore ipsum inventore. Ex unde dolores itaque cumque.\n\nNecessitatibus itaque facilis corrupti quaerat rerum ullam nam atque. Rem rem nobis iste sequi ab voluptates necessitatibus. In vitae illum error nulla qui. Ipsa quisquam ipsa voluptate numquam quasi amet.\n\nQuo fugiat iusto mollitia facere esse minus doloribus voluptatem. Repellat amet beatae officia pariatur mollitia maxime. Ducimus iste alias sit aspernatur quis aspernatur unde pariatur. Vero occaecati animi alias dicta nam error.\n\nAut tempore consequatur voluptatibus. Quam commodi dolorem facilis non harum. Eaque vel voluptates ipsa reiciendis magni pariatur aliquid eligendi.	69.79	\N	2017-11-27 23:30:50.288186+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
176	Butler-Duncan	Sapiente quidem provident minus minima iste. Eligendi non saepe ratione voluptates. Quia non magnam vitae ipsum soluta autem repudiandae.\n\nFugiat ab in temporibus deserunt quisquam optio consectetur. Mollitia veniam aliquam perspiciatis blanditiis. Beatae quasi officiis accusantium suscipit iure.\n\nDeserunt nisi officiis odit. Ipsam voluptas explicabo quod neque hic quod. Corrupti excepturi voluptatum assumenda. Molestias quam velit amet nesciunt nulla autem.\n\nIn asperiores eaque vel quis culpa. Sint incidunt aliquid totam natus. Vero ducimus mollitia corrupti ea vero cumque corporis.\n\nIncidunt unde eos fugiat ut. Quod eaque id harum vero. Et aspernatur expedita dolorem quod eveniet. Mollitia tempore iste eius natus porro.	17.78	\N	2017-11-27 23:30:50.318205+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
177	Barker, Evans and Weeks	Sapiente nemo numquam maxime nemo reprehenderit corporis. Laboriosam fuga quis non dolorum magnam. Impedit ipsa beatae ipsa est aliquid. Velit quisquam sed dolor.\n\nSoluta expedita iure sit maiores tenetur rem. Placeat et exercitationem optio qui corporis explicabo officia. Doloribus consectetur consectetur maxime mollitia.\n\nBeatae veritatis eum maiores architecto. Fugit vero sint fugit veritatis. Nostrum odit corporis animi.\n\nQuas architecto magnam repellat a qui facere voluptatibus labore. Error quisquam maxime vitae inventore ducimus repudiandae. Laboriosam quaerat laborum placeat veniam tempora perferendis. Eos voluptates omnis ipsam mollitia aliquam eum maxime.\n\nDicta voluptates molestias dolore corporis incidunt iusto. Quasi sapiente quis vitae nulla enim. Corporis nisi numquam explicabo vitae. Assumenda accusantium occaecati hic nihil similique.	84.39	\N	2017-11-27 23:30:50.345144+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
178	Roberts-Brooks	Accusantium sit similique quos ex eum eaque. Autem temporibus magnam molestiae eos incidunt. Ad dolorem maiores pariatur facere distinctio aliquid soluta. Accusantium accusantium iure iusto esse animi.\n\nUnde modi perspiciatis perspiciatis facere ad. Quasi voluptatum ratione at eaque libero nemo doloribus. Porro suscipit dolorem temporibus ut eligendi illum cum.\n\nIpsam unde distinctio ex alias. Amet libero facere qui dolorem eaque nulla. Ex similique molestias quam quod similique recusandae.\n\nAliquam deleniti voluptatum facere consequatur dolor vel veritatis veritatis. Est labore ratione facere voluptatum pariatur soluta. Assumenda ad similique quas reiciendis ipsam expedita deserunt. Eum consectetur omnis dicta praesentium inventore officiis eveniet animi.\n\nVitae et nostrum quod error quod quae illum accusamus. Officiis beatae dignissimos deserunt eos labore facere neque.	60.80	\N	2017-11-27 23:30:50.385228+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
179	Moreno Ltd	Repellat incidunt deserunt autem architecto. Repellat aliquid officia voluptates quibusdam corporis. Laborum natus est maiores.\n\nNam ducimus esse ducimus laboriosam. Eius sit officia quod a tenetur praesentium voluptatem. Non mollitia iusto nesciunt accusamus totam ipsa. Recusandae commodi dolorum nostrum molestias.\n\nVoluptas iusto esse occaecati amet. Alias incidunt dolorem voluptates voluptatibus iusto aut natus. Doloremque accusantium animi ex officia non. Pariatur atque harum architecto id perspiciatis.\n\nNumquam quam vitae ratione ipsam tempore. Eveniet iusto alias quisquam aut alias officia quidem vel. Quas nihil doloremque repudiandae cupiditate.\n\nSuscipit reiciendis exercitationem modi nam occaecati delectus officia. Quos ea laborum doloribus necessitatibus rerum. Quos aspernatur eveniet atque adipisci debitis. Neque ducimus dicta hic qui quam sed perferendis ullam. Exercitationem labore tempora veniam dolores ea et.	12.93	\N	2017-11-27 23:30:50.420881+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
102	Taylor, Anderson and Nelson	Inventore deleniti ea et architecto neque quos. Laudantium exercitationem accusantium magni illum ipsum. Atque commodi quibusdam consectetur ad unde minima.\n\nAnimi nulla quidem impedit at iure. Dolores ratione quam harum atque perspiciatis quaerat aspernatur. Aliquam repellendus soluta consequuntur dignissimos.\n\nVel ducimus aut expedita officia explicabo deleniti quibusdam. Possimus perspiciatis minus quam minus amet ullam quia. Dolore iste voluptates sapiente. Cupiditate perferendis aperiam accusamus iure beatae.\n\nQuis vero quis possimus recusandae molestiae dolor doloremque. Ducimus consectetur maiores cum. Labore aliquid ratione delectus cupiditate non minus.\n\nAutem occaecati quos beatae porro fugiat perspiciatis tenetur. Explicabo voluptatem porro voluptatum hic debitis asperiores quasi. Asperiores odit blanditiis aperiam ipsam. Molestiae ipsam sit cumque temporibus ipsum sunt deleniti.	57.49	\N	2017-11-27 23:21:08.907987+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	t	t
149	Carrillo-Wright	Ab nisi totam nihil quam exercitationem totam magnam. Nesciunt assumenda natus quae distinctio. At corporis similique dicta delectus eligendi. Pariatur aliquid qui consequatur labore ipsum similique quo.\n\nMagnam praesentium reprehenderit quo facere. Provident asperiores tenetur consectetur commodi reiciendis ratione error. Ut repellendus ipsam culpa delectus.\n\nPraesentium debitis consectetur praesentium exercitationem tenetur. Aliquid error dolorum aut iure et. Praesentium laborum velit minima impedit inventore perspiciatis.\n\nNihil quibusdam deleniti saepe earum itaque ab. Nulla porro molestiae deleniti culpa quas dolores quasi suscipit. Quasi dolores consequuntur aperiam occaecati.\n\nIure voluptatem praesentium possimus praesentium. Maiores dicta beatae debitis aut enim dignissimos dolore natus. Exercitationem fugit non sequi maiores perferendis animi. Quod id repellendus necessitatibus.	29.81	\N	2017-11-27 23:30:49.429534+00	3	"3"=>"6", "5"=>"13"	t	t
181	Nelson, Smith and Carney	Eum eum quibusdam expedita aliquam debitis quae quia. Dolor repudiandae fugit culpa sapiente in.\n\nQuia possimus placeat adipisci. Corporis perferendis fuga iste sint tempore.\n\nEx harum assumenda sed voluptas debitis reiciendis. Deserunt reprehenderit eos nam mollitia. Doloribus asperiores incidunt sint facilis quam. Eius facere numquam corporis amet ab sit.\n\nUnde possimus eius recusandae temporibus nulla. Nisi quaerat impedit soluta eveniet. Consectetur hic voluptate commodi eos rerum repellendus.\n\nConsectetur culpa consectetur ut ad quod temporibus. Quidem numquam alias ullam aspernatur quibusdam accusamus commodi cupiditate. Dolorem officia consequatur delectus voluptatem.	2.32	\N	2017-11-27 23:49:11.473782+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
183	Hubbard and Sons	Ratione officia laudantium dolor doloremque atque. Totam alias laboriosam deleniti. Ratione vitae inventore labore ut fuga. Minus corrupti vero omnis est voluptas tempore pariatur.\n\nReprehenderit earum debitis modi accusamus. Aperiam eligendi quia optio doloribus. Sint dolor inventore nesciunt numquam. Vel nisi iste corporis assumenda porro iste. Eos nostrum soluta illum ut suscipit.\n\nDicta exercitationem earum laboriosam veniam voluptate. Nostrum aperiam reprehenderit quidem dolorem. Deleniti adipisci odio maxime numquam aut. Error odio perspiciatis doloribus molestiae quia iste quia.\n\nAt libero totam tempora rerum placeat. Accusantium incidunt consectetur veritatis et consequuntur odit aperiam nulla. Sequi eaque labore facere distinctio. Amet perferendis eius sequi mollitia repellat dignissimos libero.\n\nIn voluptatem ipsam quos vero. Quia consequuntur velit consequuntur et ipsum. Omnis vel porro ut laboriosam labore magni nobis. Cupiditate iste officiis ducimus exercitationem eveniet. Nesciunt nobis rerum blanditiis rerum facilis deleniti architecto voluptatum.	83.68	\N	2017-11-27 23:49:11.580032+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
184	Vaughan Ltd	Odit nobis dignissimos cumque quam at quod ducimus. Laboriosam asperiores veniam aliquid veniam.\n\nNumquam recusandae natus tempore repellendus deleniti animi tempore explicabo. Numquam non at unde molestias dolorum similique labore doloribus. Quisquam odit reiciendis rerum temporibus aliquam mollitia.\n\nNam possimus recusandae animi quaerat excepturi. Enim temporibus beatae consequatur eos ut quod dolores. Eos iste ea placeat architecto mollitia consectetur qui. Magnam provident mollitia aperiam.\n\nInventore cumque facilis veritatis. Veniam nulla excepturi est dolores est explicabo at. Ut distinctio culpa commodi magnam. Aspernatur quibusdam nostrum dicta numquam a nesciunt.\n\nAccusantium natus nostrum quod hic magni vel veritatis. Quaerat repudiandae deserunt sed commodi perspiciatis quia dolor. Odio cum voluptas ad pariatur quod deleniti quae.	55.47	\N	2017-11-27 23:49:11.623374+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
180	Christian-Friedman	Reprehenderit dignissimos distinctio quidem fuga quam. Earum cum eveniet numquam veniam non dolor. Corporis repellendus dolor repellat.\n\nFacilis a explicabo incidunt ea ea eveniet non. Sunt laborum necessitatibus reprehenderit sunt voluptatem ab sed. Eum voluptates voluptate deleniti vero est exercitationem. Inventore ab reprehenderit at sunt omnis magni hic. Eveniet laboriosam minus nisi.\n\nNemo culpa adipisci vero nihil molestiae sequi veritatis. Esse dolore ipsa harum aliquid molestiae. Nesciunt modi nobis ipsum velit.\n\nAmet quo sunt porro molestiae quasi. Ad adipisci incidunt optio aperiam porro debitis repellat. Totam illum accusantium illo amet eaque numquam. Odio eaque id dicta delectus.\n\nPraesentium ducimus tempora labore. Reprehenderit minus aut commodi id architecto impedit dicta. In minima placeat veritatis atque quisquam repudiandae inventore. Eveniet doloribus numquam eaque odit.	55.78	\N	2017-11-27 23:30:50.458284+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	t	t
188	Shields and Sons	Quia maiores adipisci dignissimos molestiae repellat. Sint necessitatibus beatae necessitatibus.\n\nPerferendis at vero odit. Odio eligendi explicabo quis molestias. Perspiciatis voluptatum cumque enim mollitia dolore ipsam alias.\n\nArchitecto perferendis delectus laboriosam. Odio ducimus numquam a vel. Officia quis similique eveniet natus. Adipisci culpa voluptate dolores vero. Nostrum amet nam quas fugiat voluptatem quos adipisci dolorum.\n\nA veniam vel ipsa blanditiis maxime possimus. Magnam aliquam voluptates nisi quasi in consequatur sed quos. Consequatur vero perferendis suscipit neque. Impedit sequi cupiditate ducimus hic.\n\nAdipisci odit saepe non error. Cumque dolores sunt tenetur labore tempora praesentium labore adipisci. Aliquid nobis in at aperiam amet in esse eum.	92.61	\N	2017-11-27 23:49:11.840655+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
189	Newton PLC	Earum repellat dolorem assumenda vitae id odio. Eos dicta aperiam vero. Sequi temporibus perferendis illo voluptates in illum neque impedit.\n\nProvident perferendis non aperiam iste quis. Veniam tempora temporibus inventore illo autem eaque. Tenetur amet sapiente deserunt.\n\nDoloremque minus aperiam nulla eveniet qui. Commodi consequatur occaecati omnis doloremque quidem blanditiis aperiam. Debitis cumque dolore doloribus consequuntur.\n\nNeque sapiente repellat tempora mollitia autem ducimus voluptates deleniti. Nam mollitia voluptate deleniti perspiciatis natus nam hic. Ut molestias dignissimos rem autem. Maiores error ad aspernatur perferendis quo.\n\nIncidunt inventore sit praesentium iste non. Enim quasi consequatur voluptatem accusamus nesciunt. Vel at rerum amet neque voluptatem earum eius neque.	3.61	\N	2017-11-27 23:49:11.894143+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
190	Meyer, Sharp and Gates	Maxime eveniet incidunt quisquam tempore. Provident ad nulla ipsum quis cumque. Itaque officia natus voluptatibus natus voluptatem reiciendis. Fuga cumque asperiores perspiciatis quos.\n\nMollitia deleniti sunt libero necessitatibus praesentium. Iste earum tempore ipsa est. Facere dolorem nesciunt facere facere.\n\nTotam dolore tenetur odio tempora itaque. Deserunt inventore odio ullam distinctio blanditiis. Perspiciatis cumque hic et rem. Nam et fugiat sequi.\n\nVoluptates aliquam consectetur corrupti quas. Nemo voluptatibus ab magnam deserunt deleniti aperiam. Dolore maxime illo quae possimus. Doloribus facere ipsum ducimus porro unde consequuntur cumque.\n\nA ipsa ea autem tenetur minima nostrum ab. Assumenda numquam nobis suscipit quibusdam. Voluptatem voluptatem cumque quia ipsam sequi delectus voluptate ducimus.	20.26	\N	2017-11-27 23:49:11.967572+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
191	Gonzalez-Becker	Repudiandae soluta voluptates porro eligendi. Atque sed possimus nobis totam animi eum doloribus. Alias rem maxime sed quidem itaque vel. Veritatis quisquam aliquam ut quibusdam iure.\n\nIllo quis possimus ut autem aliquid labore. Maxime fuga temporibus harum nisi qui quidem totam. Aut accusamus incidunt soluta incidunt aperiam iste cumque.\n\nVoluptatum alias eveniet nemo voluptate. Veritatis illum est inventore blanditiis rem repellendus. Unde quisquam natus aperiam recusandae. Quod eius quas numquam error recusandae.\n\nIusto impedit placeat rem fugiat. Consectetur nulla culpa sequi ratione est. Deleniti sequi corrupti temporibus tempora dolor occaecati.\n\nNemo praesentium voluptatum porro fugit iusto culpa. Occaecati repellat laboriosam repellendus tempora. Neque voluptas nam quae dignissimos. Aspernatur quam eligendi tempore corporis. Est aperiam odio necessitatibus sint cum suscipit.	44.75	\N	2017-11-27 23:49:12.047904+00	2	"3"=>"6"	f	t
192	Barnes Inc	Quasi explicabo distinctio aut adipisci. Non vitae iusto cum aliquid maxime. Reprehenderit ipsum ab nesciunt illo exercitationem. Debitis illum aspernatur sit quo.\n\nHic inventore velit esse molestias repellendus laudantium mollitia. Maiores nisi accusamus ab necessitatibus laudantium modi error sapiente. Assumenda aperiam ad autem culpa aperiam ratione rem. Sapiente voluptate nemo neque. Laborum ad accusamus quaerat impedit quo fuga dolores.\n\nDeleniti quasi magni necessitatibus officia. Veniam non nihil et quas vero sunt animi. Corrupti blanditiis necessitatibus quos eveniet.\n\nCulpa enim iusto consequuntur quos blanditiis. Nisi magni eligendi eum sunt nostrum. Quaerat quos aliquid nihil voluptatibus.\n\nAspernatur dolore occaecati quos beatae dolorum iste cumque. Doloribus similique optio tenetur ullam repellendus fuga. Iure officiis temporibus illum laudantium corporis enim. Sint aspernatur suscipit architecto.	36.66	\N	2017-11-27 23:49:12.101574+00	2	"3"=>"6"	f	t
193	Ferguson-Kirk	Reiciendis eos adipisci modi quam eligendi aperiam. Maiores suscipit alias illo asperiores porro ipsum. Inventore ea perspiciatis odit quae praesentium ea.\n\nConsectetur labore minus ducimus perspiciatis assumenda cum. Architecto ullam sed in. At rerum sint libero ab unde ut.\n\nMagnam eligendi corrupti non temporibus architecto. Consectetur suscipit reiciendis aliquam nisi facere. In accusamus alias hic nesciunt excepturi architecto consequuntur ad. Excepturi quas adipisci autem fugiat laborum repellendus sed.\n\nNulla cupiditate quod id hic explicabo nostrum. Sequi aspernatur rem qui iure velit maiores aliquid. Aspernatur impedit repellendus eos amet totam vel rem. Veniam provident tempore totam maiores aperiam consequuntur.\n\nNostrum voluptates illum corrupti nisi. Laboriosam totam atque sint soluta quisquam sit fuga. Voluptas expedita aliquid molestias expedita porro. Iusto molestiae pariatur officiis.	73.23	\N	2017-11-27 23:49:12.132133+00	2	"3"=>"6"	f	t
187	Yu, Myers and Nguyen	Officiis asperiores cumque tempora at ducimus fugit porro. Voluptas aliquid ea at voluptates. Eos minus voluptatum quibusdam commodi tempora ex cupiditate.\n\nConsequatur aliquid odit mollitia ratione voluptates iusto atque perspiciatis. Modi soluta dignissimos in. A libero cum quia provident earum doloribus. Soluta laborum similique totam facilis iusto ullam.\n\nCum repellat dolor voluptate perspiciatis. Nihil tenetur cumque hic magni quas quasi distinctio. Ipsam voluptates dolor numquam consequatur iure.\n\nVoluptate illum iste porro. Placeat ipsa autem impedit commodi earum ut. Saepe explicabo illum quia numquam. Repudiandae quisquam pariatur accusamus recusandae ea similique.\n\nSint voluptate a sapiente tempora exercitationem enim. Veniam possimus temporibus dolor officia. Quae optio debitis similique sint suscipit vitae porro.	33.78	\N	2017-11-27 23:49:11.774389+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
196	Hurley Group	Provident deserunt qui praesentium eaque asperiores ullam. Et sunt voluptate mollitia eum quibusdam voluptate odio quo. Quos repudiandae qui sunt animi nulla cum. Explicabo accusantium saepe et. Reprehenderit mollitia natus molestias expedita.\n\nPerspiciatis aliquid tempora at in explicabo impedit. Aperiam excepturi eligendi accusamus. Eum ut possimus fuga ipsa ipsum enim aspernatur sit. Consequatur ipsa officia voluptate odit earum.\n\nNihil similique deserunt facilis est debitis dolores quos sapiente. Recusandae aut laborum corrupti dignissimos culpa voluptatibus. Odit consectetur consequatur ducimus minima. Labore modi assumenda hic voluptatem aliquam.\n\nMinima voluptates eum reprehenderit adipisci laudantium. Veniam blanditiis voluptatum soluta sequi. Aperiam quaerat officia tenetur quisquam sunt alias tenetur.\n\nModi consequuntur libero dolor expedita molestias. Consectetur ratione deserunt eveniet quo recusandae. Porro officiis corporis delectus repellendus cumque sequi non. Consequatur repudiandae accusantium consequuntur vel sit maiores cupiditate.	57.26	\N	2017-11-27 23:49:12.304117+00	2	"3"=>"6"	f	t
197	Wang, Friedman and Stephens	Ut cum unde corrupti possimus ipsa vero. Officia nostrum nobis voluptatum debitis earum. Cupiditate neque molestiae accusantium delectus accusantium repellendus officia harum.\n\nAmet earum blanditiis dignissimos blanditiis ratione optio. Harum reiciendis aspernatur velit incidunt unde vitae.\n\nIllum consequatur dignissimos debitis. Incidunt quae facere doloremque deserunt aliquid expedita. Voluptas cumque optio voluptatem debitis doloribus.\n\nConsequatur maiores reiciendis cum asperiores iure aut. Officia exercitationem exercitationem cumque sapiente soluta explicabo. Architecto assumenda atque maxime voluptas veniam eaque. Similique atque aliquam accusantium vitae et neque.\n\nEaque voluptas laudantium iusto maiores itaque pariatur tempora quaerat. Veniam doloremque reiciendis reiciendis earum voluptatibus consequuntur. Repellat mollitia itaque voluptas rem dicta natus. Voluptatem quam dignissimos porro similique deleniti laboriosam deserunt.	44.87	\N	2017-11-27 23:49:12.367214+00	2	"3"=>"6"	f	t
198	Morales, Torres and Scott	Aperiam vitae assumenda repellat quasi repellat nihil. Dolores dolore quae dolorem eum. Vitae omnis magnam eum quas nesciunt ipsam numquam. Quaerat error excepturi modi eligendi repellat consequatur. Tenetur amet laborum id quae magnam.\n\nDoloremque nobis nulla vitae necessitatibus fugiat rem repudiandae. Assumenda minus minima dicta veritatis. Accusamus culpa sapiente esse quo minus unde dicta ut. Sapiente voluptatem at dolor quas accusantium occaecati omnis.\n\nNobis odio dolore ipsum nulla commodi possimus. Sequi sunt aliquam voluptatem optio aperiam. Pariatur consequatur maiores numquam quod eos beatae. Repellat a aperiam quisquam occaecati quasi quae.\n\nUllam sapiente odio facilis error. Sint facere itaque optio molestias unde ut perferendis.\n\nRepellendus alias veniam sunt. Laborum asperiores officiis sapiente. Iste dignissimos fuga ad architecto quaerat eveniet illum. Quod ratione mollitia maxime quas aspernatur tempora.	33.33	\N	2017-11-27 23:49:12.402256+00	2	"3"=>"6"	f	t
199	Moss, Long and Luna	Facere nesciunt ad nulla. Temporibus quod reiciendis sit porro eaque illum pariatur. Omnis dolores et quia corrupti accusamus doloremque. Quibusdam nisi aut nemo quod est. Laborum ipsa magnam facere rerum velit blanditiis.\n\nSapiente commodi beatae ratione molestiae. Inventore laborum nisi iusto aspernatur est ratione sapiente. Eum enim ratione deleniti.\n\nSit laborum officia quo officiis sit nisi. Iusto quibusdam omnis laborum mollitia ipsam ipsum unde sit. Occaecati soluta esse itaque nesciunt.\n\nEveniet in quaerat illo dolorem repudiandae magnam beatae explicabo. Velit minus reprehenderit eaque illum iusto consequatur expedita. Nulla aspernatur non impedit autem adipisci illo qui.\n\nFacere porro animi dolor beatae aut. Ex expedita quia reprehenderit impedit sed itaque. Placeat neque doloribus ipsum. Esse deleniti maxime repudiandae occaecati blanditiis.	41.70	\N	2017-11-27 23:49:12.438993+00	2	"3"=>"6"	f	t
104	Johnson-Kim	Fugiat voluptatibus doloremque eaque omnis. Earum eius quasi dignissimos. Cupiditate nulla ut explicabo placeat assumenda laudantium labore.\n\nVoluptatibus magni porro perferendis molestiae non maiores. Illo officiis quasi tempore voluptate cumque commodi et sapiente. Ratione et veritatis ut. Repellat quam voluptate corrupti quo facere perferendis.\n\nCulpa odit earum adipisci adipisci officia. Velit cupiditate cupiditate unde quod sequi. Qui est quibusdam amet labore cupiditate dicta asperiores incidunt.\n\nNobis nulla fuga porro repellat neque. Totam nesciunt aliquid nesciunt fugit non. Fugit sit sit sunt magnam aut odit.\n\nA debitis ab quos. Dolores architecto officiis quo ipsum ratione. Dolorem commodi cum incidunt commodi.	43.51	\N	2017-11-27 23:21:08.978827+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
195	Copeland, Ware and Charles	Ullam vitae quidem inventore quos. Et soluta ut atque facilis. Sint ad beatae perferendis vel quasi eaque. Pariatur fugit nesciunt suscipit. Totam est expedita vel quaerat deserunt nemo eligendi accusantium.\n\nTenetur cumque unde cumque minima natus. Delectus commodi reiciendis laboriosam delectus. Nesciunt error dolor adipisci at. Magnam nobis ut voluptatem.\n\nTempore culpa consectetur dolore harum assumenda nobis quod. Quam veniam perferendis rerum itaque dolores iste. Asperiores temporibus pariatur laudantium laborum ea.\n\nSoluta dolorem esse dolore hic occaecati facere adipisci. Dolorem dolorum aspernatur sapiente deserunt dolorum dolorem. Non molestias pariatur molestiae vero quidem ducimus. Illum eligendi rerum suscipit porro.\n\nNesciunt omnis nobis odio minus cupiditate quasi atque. Ducimus saepe officiis enim nulla aliquid quod. Facilis eligendi blanditiis laborum.	68.54	\N	2017-11-27 23:49:12.209208+00	2	"3"=>"6"	t	t
200	Campbell Ltd	Ut occaecati facere aliquam illo veritatis perferendis. Maxime rerum alias numquam dicta provident. Dolor maiores maiores voluptates laboriosam quis dolorum.\n\nAd omnis nam est quas. Dolores cumque pariatur molestias ipsum quo recusandae. Officia possimus laudantium vel voluptate dolore ipsam labore. Inventore molestias culpa quaerat beatae id consectetur impedit.\n\nAt dignissimos aspernatur repellat. Placeat facilis minima deserunt ex amet. Eveniet non quas laborum numquam maiores. Voluptate nobis amet sit perferendis rem dignissimos.\n\nDignissimos at minima aliquid assumenda maxime iure sunt. Consectetur ducimus voluptate voluptates labore excepturi fuga quae deleniti. Perspiciatis eaque nobis asperiores temporibus eveniet quae quod.\n\nMaiores explicabo nihil tenetur. Harum asperiores sunt enim nemo blanditiis repudiandae.	3.87	\N	2017-11-27 23:49:12.4847+00	2	"3"=>"6"	f	t
201	Thompson, Turner and Foster	Aperiam vel nulla ea et. Fuga quia facilis aspernatur vero aliquid quidem magni. Repellat praesentium repudiandae ipsa corrupti quis. Consectetur quod sit necessitatibus reiciendis. Eaque quae perspiciatis ab est nisi accusantium explicabo asperiores.\n\nIllum unde rerum eligendi eum debitis dolorum debitis. Doloribus praesentium iusto totam officiis voluptas similique. Accusamus accusamus distinctio commodi exercitationem temporibus delectus fugit.\n\nPorro dicta quod natus ipsum illum iste nulla. Error consequatur corporis consequatur maxime minus. Laborum dolorem magni atque sint error.\n\nAperiam vitae ab consequuntur reprehenderit repudiandae sunt. Animi laboriosam accusamus corrupti similique laborum. Ullam officia neque illum id magnam.\n\nNecessitatibus et ea et iure ipsam nihil. Iste id optio est possimus culpa adipisci dolorem quasi. Debitis dolor eum provident nihil nisi magnam reprehenderit.	60.22	\N	2017-11-27 23:49:12.528064+00	3	"3"=>"6", "5"=>"13"	f	t
202	Horton, Clark and Horne	Explicabo at eligendi ea architecto voluptatem modi quos. Molestiae libero iste eius aliquid quaerat. Sint reprehenderit ea dolor rem.\n\nOfficiis inventore hic consequatur et sit quo. Aperiam commodi cumque eum consequatur. Commodi voluptate debitis recusandae laborum ipsum hic. Rem adipisci tempora autem accusamus temporibus aperiam ipsum.\n\nDelectus explicabo facere maiores fugiat quae reprehenderit. Iure optio reiciendis dolorem quibusdam aliquam commodi.\n\nVel numquam nemo facere similique sed esse cupiditate. Voluptas dignissimos nostrum provident voluptates explicabo. Suscipit dolores quibusdam assumenda eligendi.\n\nAb minima minima ipsum maiores error blanditiis. Harum culpa velit ipsum sint dignissimos doloribus dicta. Fugiat illum eaque voluptatum architecto omnis.	88.62	\N	2017-11-27 23:49:12.588976+00	3	"3"=>"6", "5"=>"14"	f	t
203	Gill, Evans and Caldwell	Ipsa aliquid neque voluptate ut debitis modi magnam. Dolore magnam mollitia id alias sapiente. Dignissimos fuga eveniet numquam molestiae. Deserunt assumenda adipisci animi dolores vero dolore rem.\n\nHarum nihil nisi aliquam laborum quasi magnam. Deserunt eum placeat error in possimus beatae accusantium. Ab ducimus mollitia reprehenderit quae facere amet unde enim.\n\nMagnam animi dolor eaque doloribus similique error. Eligendi explicabo accusantium qui aliquam consectetur eum maiores. Facere sunt officiis dolorem quo explicabo id.\n\nDeleniti sint nemo totam commodi facere. Quo amet quod sed voluptatum fugit. Quas saepe ipsum ab temporibus voluptatum. Consequuntur deleniti sequi vitae corporis.\n\nQuasi voluptatibus delectus iusto modi. Deserunt similique illo dolor aperiam amet sit. Laborum consequatur rem culpa eos. Recusandae eaque libero facere quos.	37.79	\N	2017-11-27 23:49:12.646338+00	3	"3"=>"6", "5"=>"13"	f	t
204	Moreno Ltd	At nostrum aliquid ea totam consequatur voluptatem earum vitae. Inventore nihil esse a ea rem asperiores alias. Ex delectus sint fugiat corporis. Iste possimus repellat ad alias fugiat quam tempora.\n\nVeritatis quasi quos assumenda sequi vero. Repudiandae consectetur aliquid fugiat. Dolor magni eaque beatae iusto fuga molestiae.\n\nEligendi saepe in adipisci. Doloribus odit itaque nemo minima. Possimus debitis labore ex facere.\n\nDoloremque nesciunt ut ea minima est. Possimus sed reprehenderit occaecati aperiam cum. Placeat soluta similique unde magnam suscipit porro dolores.\n\nQuas dicta voluptates porro ipsum incidunt eum. Officiis praesentium eos excepturi iste veritatis.	39.60	\N	2017-11-27 23:49:12.699914+00	3	"3"=>"6", "5"=>"14"	f	t
205	Martin and Sons	Voluptatem unde quaerat ducimus eligendi. Hic possimus corporis cupiditate ratione. Excepturi consequuntur blanditiis porro repellendus saepe ducimus porro. Magni neque facere minus tempore inventore cupiditate inventore.\n\nPorro quaerat ea quaerat facilis culpa. Possimus temporibus voluptatem nisi eos. Expedita nam nobis at adipisci aliquid. Officiis ullam voluptatum voluptatum laborum quod.\n\nQuam occaecati maiores ex. Saepe delectus molestias tempora aspernatur. Eius amet excepturi nesciunt nisi quidem.\n\nAlias labore perspiciatis cumque aspernatur cum. Porro exercitationem earum commodi ipsam iusto. Blanditiis quas excepturi eius quis ut quidem incidunt. Labore ipsum labore accusantium a doloribus.\n\nPraesentium enim odit deserunt perferendis dolor animi quae animi. Sequi architecto commodi error voluptatum eligendi mollitia itaque iusto. Pariatur voluptatibus distinctio ut a culpa veritatis. Occaecati praesentium saepe vel repudiandae tenetur.	32.56	\N	2017-11-27 23:49:12.746848+00	3	"3"=>"6", "5"=>"13"	f	t
206	Peterson and Sons	Eum necessitatibus illo voluptas eius. Inventore expedita nihil dolore dolorum repellendus. Consequuntur aliquid delectus qui optio consequuntur aperiam. Necessitatibus molestias rerum voluptatum explicabo odio.\n\nAssumenda enim veniam in recusandae cupiditate. Soluta sint accusantium deleniti qui. Quidem repellendus quo quaerat blanditiis. Nulla quos perferendis totam quia eligendi rem deleniti.\n\nDelectus necessitatibus dolore tempora dolore quisquam tempore quis. Dolor vero laboriosam ipsum tenetur possimus id quod. Ut facilis unde quos. Ad nostrum aliquam tempore tenetur.\n\nAt sequi maiores quasi ipsa fugit a eligendi. At quidem cupiditate sit laborum quos fugiat doloremque. Laudantium ullam veritatis ex laborum debitis atque nobis.\n\nDucimus laboriosam quia quo quaerat molestiae. Necessitatibus vero alias quidem cumque ea dicta. Reiciendis numquam consectetur voluptatem nulla laborum.	58.66	\N	2017-11-27 23:49:12.798696+00	3	"3"=>"6", "5"=>"13"	f	t
208	Harris, Dixon and Moore	Aspernatur omnis magni officia id. Libero inventore vel magnam excepturi illo reprehenderit. Nihil architecto quasi mollitia nihil molestias laudantium. Sint repellat rem non hic impedit voluptate nulla. Delectus officia sint consequuntur reiciendis ipsa sunt.\n\nArchitecto in unde aliquid commodi. Dignissimos reiciendis corporis nam cum. Quasi iusto commodi rem iste quaerat quos occaecati. Dolores itaque corporis dolore repellendus debitis.\n\nRerum adipisci at explicabo expedita explicabo. Modi sapiente quia modi quaerat molestiae rerum facere. Vitae mollitia corporis sunt enim. Distinctio reiciendis praesentium nisi nisi.\n\nLaborum ut exercitationem ipsum tempore aliquam. Quod itaque ipsa enim inventore rerum nesciunt sunt.\n\nQuis corrupti veritatis sed nesciunt totam laboriosam. Necessitatibus voluptate aliquam aperiam aliquid. Libero repudiandae quam saepe nam atque impedit.	97.00	\N	2017-11-27 23:49:12.904247+00	3	"3"=>"6", "5"=>"14"	f	t
209	Perez and Sons	Sunt ducimus beatae ipsam exercitationem eveniet esse sunt inventore. Vitae maiores adipisci iste explicabo tempore. Voluptatem cupiditate harum impedit odit autem unde voluptate.\n\nRatione suscipit autem suscipit vero molestiae atque. Aspernatur numquam modi ut quam. Neque libero est consequuntur. Ex rem facilis illo ut animi possimus recusandae. Odit et ullam aliquid labore quibusdam aliquam.\n\nPerferendis sunt at dolor amet. Accusantium ad labore architecto saepe molestias ipsum.\n\nTemporibus nam eligendi non cumque porro. Aliquam ex eos officia. Rerum doloremque laborum voluptas vitae sit illo sed. Facere laudantium vitae molestiae tenetur sapiente nobis nulla ipsum. Excepturi nobis officiis inventore nobis voluptates nobis repudiandae.\n\nEa ipsum at earum ipsum. Quia a dolorum maxime suscipit recusandae quod rerum eveniet. Alias error impedit eligendi sit.	89.27	\N	2017-11-27 23:49:12.965393+00	3	"3"=>"6", "5"=>"14"	f	t
210	Fowler-Pena	Accusantium veritatis fuga perspiciatis voluptas perspiciatis nihil voluptates. Dolor possimus accusamus dignissimos fuga.\n\nIllo quo corporis nulla quia voluptatum tempore. Maiores labore at dicta quod. Similique corporis facilis officiis illo. Minus atque optio illum incidunt tenetur repellendus sequi consectetur. Cumque amet distinctio adipisci commodi.\n\nAccusamus pariatur fugit eligendi officiis ex architecto vitae. Minus laudantium soluta ullam quidem maiores quibusdam nisi. Corrupti quibusdam consequatur nobis asperiores temporibus mollitia maiores. Suscipit qui aut laborum quisquam necessitatibus.\n\nDebitis at eos molestias repudiandae harum consequatur. Exercitationem saepe aspernatur officia. Labore voluptatibus ut doloribus architecto magnam optio sit tempore.\n\nCorrupti a distinctio hic quia ab consequuntur. Esse odio rerum ex quos totam. Vero facere ipsa nemo velit facilis neque. Hic maiores in nisi illum nobis laboriosam.	15.90	\N	2017-11-27 23:49:13.012123+00	3	"3"=>"6", "5"=>"13"	f	t
211	Mcdonald Inc	Sit optio sunt quis vel vitae libero. Eos culpa tenetur aspernatur quis. Maxime magni quos laboriosam labore.\n\nEnim eveniet eveniet fugit doloremque. Porro aliquid quis repellat. Quod inventore asperiores iusto sequi fuga.\n\nQuasi molestiae aut at fugiat tempora molestias sit. Alias temporibus ipsa soluta. Earum aliquam provident a.\n\nTempora eaque natus dolores cupiditate quae veniam id. Pariatur asperiores reiciendis rem sequi modi animi.\n\nId voluptate cumque delectus nostrum dolor. Alias vel modi adipisci expedita alias eum unde repellat.	42.92	\N	2017-11-27 23:49:13.067397+00	4	"3"=>"6", "7"=>"19"	f	t
212	Lamb and Sons	Quis doloremque atque recusandae tenetur harum. Vel qui accusantium impedit placeat consequatur iusto distinctio. Enim iusto omnis assumenda reprehenderit. Doloremque quisquam dicta optio.\n\nEius dicta nobis dolore ad. Occaecati quam fuga minima sint deleniti ut mollitia eligendi. Quam nihil nisi occaecati reprehenderit aliquam unde.\n\nReiciendis reprehenderit quaerat quod. Libero suscipit nam magnam ex itaque quaerat. Odio consectetur consectetur incidunt consequatur. Sed nisi officia nulla quos vitae molestias.\n\nAtque nostrum perferendis iusto. A omnis harum ipsum excepturi sed. Accusantium in mollitia culpa magnam corporis asperiores neque. Dicta doloremque at impedit reiciendis veritatis tempora.\n\nRepudiandae repellat delectus beatae animi soluta repudiandae. Consequuntur maiores dolorem fuga incidunt quis. Doloremque repudiandae deleniti debitis pariatur ratione minus.	85.78	\N	2017-11-27 23:49:13.099054+00	4	"3"=>"6", "7"=>"19"	f	t
207	Brooks, Roberts and Roberts	Ipsam possimus ab voluptatibus consequatur. Eius rem facere blanditiis quidem ducimus nihil nulla. Aspernatur est doloremque maxime cupiditate deleniti. Cum necessitatibus nihil aspernatur qui fuga deleniti.\n\nReprehenderit voluptatem dolor sequi molestiae mollitia commodi. Reiciendis repellat a consectetur iure molestiae non fugit ipsam. Facere assumenda vel accusamus consequatur quas voluptas.\n\nVoluptates officia consectetur similique velit maxime nemo fugiat. Dolor molestiae veniam excepturi blanditiis dicta quas. Earum tempora sapiente tempore eaque facilis quaerat. Nam nam dolore et.\n\nExplicabo ex alias vel aliquid id non itaque. Nobis corporis aliquam aut architecto illum. Soluta ea impedit incidunt iure quae.\n\nProvident eaque asperiores laudantium eveniet. Quam similique expedita voluptatibus neque nemo illo possimus amet. Modi laudantium iusto nobis aperiam placeat iste vel harum. Fugiat aliquid tenetur repudiandae consequuntur minima. Odio aliquam tempore voluptatibus voluptas quaerat.	39.36	\N	2017-11-27 23:49:12.859067+00	3	"3"=>"6", "5"=>"14"	t	t
213	Santiago Ltd	Sed consequuntur exercitationem voluptatum fugiat voluptas repellat eum. Nisi sequi numquam at fuga. Sed suscipit dolor quaerat reprehenderit harum nostrum ratione molestiae. Quisquam debitis nesciunt exercitationem corrupti possimus quisquam.\n\nVeritatis tempore necessitatibus eaque maxime nostrum suscipit. Ab nostrum quas libero quis voluptates dolorem veniam provident.\n\nMinima perferendis voluptas veniam veniam nemo. Dolorem delectus culpa ex. Animi facere enim alias eius.\n\nDoloribus molestiae quo repudiandae. Neque repudiandae repudiandae labore unde iure molestias. Vitae qui beatae deleniti maiores eos expedita non. Excepturi eveniet quo dicta officiis nisi tenetur. Deserunt quae et facilis ipsa vero id.\n\nOfficia amet animi temporibus ipsum. Reiciendis odio saepe magnam dolorum aut. Laborum aut architecto laudantium ducimus enim totam consequatur.	36.91	\N	2017-11-27 23:49:13.144032+00	4	"3"=>"6", "7"=>"19"	t	t
215	Travis, Leblanc and Torres	Tempora aut non animi nemo laboriosam impedit sapiente officia. Sed sapiente eaque consequatur ipsum nesciunt deserunt.\n\nConsequatur unde eligendi provident odit voluptates aut tempore. Cum nemo officiis qui totam accusamus. Nulla nesciunt fugit aliquam numquam provident.\n\nAliquam adipisci aliquam voluptatem iure expedita incidunt. Occaecati natus quam soluta reprehenderit cumque placeat dolorem.\n\nFugiat aspernatur fugiat minus expedita. Nihil dicta ratione possimus magnam. Blanditiis reiciendis nostrum numquam distinctio provident corrupti omnis.\n\nPariatur dolorem in placeat quae expedita sunt assumenda. Maiores ab optio hic asperiores debitis. Natus error eius dicta sed quam dicta in fugit.	67.94	\N	2017-11-27 23:49:13.241917+00	4	"3"=>"6", "7"=>"19"	f	t
216	Green-Smith	Repellendus ex eligendi quo. Fugit asperiores illum debitis dolores. Laudantium id numquam debitis omnis temporibus natus dolorem. Architecto vel minus dolorum magni omnis nam.\n\nIllum molestias quisquam incidunt. Nulla totam voluptate quo autem doloremque expedita molestias porro. Optio hic praesentium nobis excepturi suscipit deleniti excepturi odit. Dolores commodi velit fugiat harum rem adipisci laudantium.\n\nAut sint libero rerum exercitationem ea officia itaque. Sapiente aliquid ab possimus quo consequatur autem. Id voluptatum ducimus quasi repudiandae esse impedit.\n\nDolor at iste beatae fugit. Exercitationem magni aliquid eveniet quibusdam laudantium optio. Quos odio facere voluptatibus temporibus totam.\n\nEa harum optio quas consequuntur. Fugit quia ut assumenda. Non dolor suscipit dolorem totam ab ducimus. Dolore quam aut voluptatibus repellat facere omnis odio.	23.52	\N	2017-11-27 23:49:13.290787+00	4	"3"=>"6", "7"=>"20"	f	t
218	Davis-Clark	Quis architecto itaque consectetur ipsa pariatur ad libero rem. Aliquam dolorem facere dolore laudantium commodi repudiandae. Odio distinctio necessitatibus quod fuga similique. Deleniti possimus repellendus explicabo nisi quibusdam ut iste.\n\nModi voluptates laboriosam culpa ad veniam ab quis. Magni fugiat perferendis exercitationem inventore. Illum consectetur eligendi omnis eaque nemo. Rem sequi voluptatibus quidem laudantium eligendi magnam. Iure cum fuga voluptate error recusandae tempora.\n\nEa perspiciatis numquam explicabo quibusdam corrupti. Assumenda rerum dolor sint perspiciatis. Pariatur porro aliquam ipsa.\n\nLaborum maiores distinctio magnam. Eum blanditiis pariatur fugiat vel eveniet. Blanditiis deserunt maiores atque cupiditate praesentium nisi laboriosam facilis.\n\nEst quam itaque quas totam voluptate. Accusantium maiores corrupti et molestiae. Eos voluptates magnam eaque officiis deleniti.	0.52	\N	2017-11-27 23:49:13.368999+00	4	"3"=>"6", "7"=>"19"	f	t
219	Perry, Adams and Hawkins	Error assumenda commodi perspiciatis enim beatae. Sint dolore accusantium alias saepe veritatis nemo. Sit laudantium tempora sapiente suscipit.\n\nAliquam pariatur dolore voluptate rem. Voluptate voluptate inventore consequatur commodi quaerat vel. Unde adipisci sequi veritatis omnis.\n\nNulla architecto fugit nemo eveniet assumenda magni vel. Molestiae fugiat saepe est eum. Sit ipsa iusto non eveniet perspiciatis eligendi. Saepe esse quaerat quod voluptas veritatis illo necessitatibus dignissimos.\n\nCupiditate repellendus asperiores iure et. Distinctio animi eaque culpa dignissimos error. Rerum nobis rerum cupiditate cupiditate impedit accusantium.\n\nSequi corporis ratione aliquam quas quia. Blanditiis reiciendis hic aliquam ex numquam. Minus veritatis inventore tempore aliquam id. Ex aliquam explicabo corporis reiciendis veritatis commodi alias.	82.50	\N	2017-11-27 23:49:13.410733+00	4	"3"=>"6", "7"=>"19"	f	t
220	Day Inc	Repudiandae sequi hic quasi modi. Ea ab iste harum eum.\n\nMaiores reprehenderit quis repellendus quasi cumque temporibus repudiandae. Rem delectus maiores ab eum. Voluptates non quis accusantium asperiores voluptatum soluta quaerat.\n\nLibero rem ipsum cumque. Asperiores asperiores neque consectetur harum id quidem harum.\n\nTempora eius voluptate excepturi molestias pariatur voluptates. Perspiciatis reprehenderit magnam possimus impedit deserunt totam dicta. Officiis sed voluptatibus quasi enim incidunt dignissimos reprehenderit.\n\nReiciendis aut quaerat modi cumque laudantium impedit eaque. Cum maiores eos amet ipsa inventore exercitationem. Consequatur nostrum dolorem aut optio recusandae cumque. Ratione tenetur ex magni quibusdam tenetur.	42.49	\N	2017-11-27 23:49:13.447404+00	4	"3"=>"6", "7"=>"20"	f	t
214	King and Sons	Placeat nostrum perferendis autem eius. Neque alias nobis totam iste hic. Quos nisi a aut.\n\nIpsa atque minus id magnam fugiat laborum nisi. Consequatur consequuntur ad cupiditate similique error aliquam reprehenderit consequatur. Atque consequuntur labore accusantium sunt.\n\nDeserunt sed tempore itaque porro. Aliquam minus eligendi impedit nihil quos ut. Repellat provident excepturi eos cumque voluptates ipsum quo. Quae inventore autem blanditiis.\n\nTempore quidem repudiandae unde maxime. Ea dolores at veniam debitis dolorem ipsa cupiditate. Ex minus odio ipsam eaque inventore optio. At deserunt sit quos corporis provident tempore ducimus. Impedit dolores perspiciatis consectetur eos doloremque eveniet.\n\nHic praesentium possimus quis ex sint quasi deleniti. Laborum deleniti asperiores consequatur debitis error. Quibusdam non consectetur labore eveniet nisi quas quia. Pariatur nostrum consequatur maiores illum cupiditate.	17.82	\N	2017-11-27 23:49:13.191477+00	4	"3"=>"6", "7"=>"19"	t	t
217	Mack, Moore and Reese	Laborum quibusdam facere quam. Earum aliquam nisi rem tenetur distinctio. Et architecto dicta voluptatum odio aliquid fugit aperiam. Cum dolores rem saepe recusandae modi.\n\nFugit consectetur quibusdam dolores. Et praesentium ut ut maiores. Cum culpa est laborum assumenda facilis nemo. Animi illum vitae expedita.\n\nPorro ex officiis repudiandae unde esse dolorum. Tempore officiis laboriosam consequatur nostrum. Animi recusandae quod temporibus vel eveniet.\n\nQuaerat itaque nulla ut dolorem dolorem assumenda. Ducimus pariatur maiores quam amet temporibus quo delectus. Exercitationem nam voluptate molestias modi animi error. Expedita nihil placeat beatae. Quaerat distinctio eligendi inventore iusto tempora.\n\nDoloremque fugiat perspiciatis blanditiis occaecati quam. Quia ipsam sint nemo autem enim. Iusto explicabo magni incidunt labore impedit amet voluptatum.	81.93	\N	2017-11-27 23:49:13.33223+00	4	"3"=>"6", "7"=>"19"	t	t
221	Cuevas Group	Iusto quos facilis est. Doloribus mollitia suscipit odit quo. Provident cum a mollitia tenetur aliquid sunt nostrum. Blanditiis mollitia aut earum optio numquam consectetur est quisquam.\n\nQuae a unde odio aut odio. Voluptatibus ipsam esse quia tempore temporibus animi. Sed esse placeat ratione ducimus deleniti. Cumque sequi minima expedita eius maxime. Libero quo ratione dolore a libero accusantium ad.\n\nNatus fugit fugit voluptatem repellendus minima. Excepturi perferendis exercitationem voluptate id aspernatur. Sapiente fuga quidem earum fugiat.\n\nQuis deleniti amet delectus. Eius cumque alias magnam maiores laboriosam. Maiores magnam deserunt ipsa sequi est error corporis. Provident aliquam quis necessitatibus nobis. Impedit ad totam voluptate iusto quaerat voluptatibus.\n\nVelit ullam doloremque odio distinctio vero velit voluptatem facere. Vel accusamus corporis voluptas ex officia. Rerum facere hic laborum nostrum tempore error exercitationem.	49.58	\N	2017-11-27 23:49:13.492294+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
222	Cisneros-Potter	Ex dolores inventore ratione quo tempore esse id. Officiis delectus aliquid quod cumque amet nisi vel. Fugit corrupti quos minus eum impedit dolorem. Deleniti blanditiis iure culpa sunt.\n\nEius distinctio ut nemo accusamus eaque deserunt hic. Eaque quis assumenda autem quas voluptatum.\n\nUllam pariatur unde quos soluta cum eaque. Tempore doloremque consequuntur autem recusandae. Facere animi doloribus perferendis deserunt voluptas nemo animi. Unde aliquid eligendi impedit id facilis necessitatibus.\n\nVero ducimus commodi id earum laborum. Reprehenderit dolore molestiae laudantium veniam quos ipsum maiores. Ad sequi dolore eos cupiditate. Veritatis velit incidunt sint porro repellendus animi.\n\nTempore voluptas iure rerum fugit at. Veniam atque quo incidunt. Blanditiis eligendi accusantium similique deserunt id illum adipisci. Vitae voluptas quisquam sequi.	83.31	\N	2017-11-27 23:49:13.546071+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
223	Schwartz, Green and Duarte	Totam modi molestiae dolorum impedit harum. Nam excepturi ut quidem incidunt. Modi eligendi delectus iure aliquam quos illum. Consectetur libero optio earum voluptas quasi repudiandae animi.\n\nOfficiis voluptatem natus alias sapiente. Odio amet aut rerum nulla ducimus quidem cumque blanditiis. Voluptatibus asperiores iure quos eveniet inventore ea perferendis.\n\nVoluptas porro facilis amet. Sit distinctio voluptates commodi ipsam aut dolorem iusto magni. Enim quibusdam perferendis deleniti non fugit deleniti. Sapiente ad eum nemo magnam expedita.\n\nVelit laborum eos in aspernatur atque. Sunt quae amet consequuntur quasi occaecati temporibus. Quis unde doloribus officia. Fuga optio consectetur accusantium sequi expedita enim.\n\nOmnis sunt repudiandae culpa quibusdam voluptas tempora eum. Repellendus unde facere eveniet quae. Vitae alias cum ad harum necessitatibus quis.	48.80	\N	2017-11-27 23:49:13.59332+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
224	Solomon, Lee and Hunt	Ab consequuntur aliquam dolore ipsa nesciunt. Iusto adipisci sunt quis harum dolore pariatur alias eos. Velit iste error quis culpa doloremque.\n\nPariatur beatae expedita ut. Esse repellendus unde repudiandae. Quo praesentium temporibus ipsum recusandae voluptates molestiae. Itaque nesciunt iste iusto.\n\nExpedita nisi maiores provident qui provident. Optio tenetur ut quaerat iusto numquam dignissimos sunt. Vero repellendus hic quisquam sit. Aliquam omnis magni distinctio amet quidem nisi quis architecto.\n\nIpsum occaecati eos placeat id. Accusantium perspiciatis eos minus expedita. Corrupti earum corporis dicta necessitatibus. Maiores rerum laudantium facilis dolorum voluptates aperiam assumenda. Porro magni error unde placeat eos tempora unde.\n\nEx cumque perspiciatis labore occaecati vel aperiam. Molestias sed inventore repudiandae eaque debitis. A necessitatibus occaecati laboriosam.	51.55	\N	2017-11-27 23:49:13.646192+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
225	Miller, Ross and Gibson	Ut voluptatibus excepturi voluptas similique incidunt. Veniam non reiciendis sit quod error in. Doloribus dolorem voluptatum at dolorum tempora suscipit. Omnis culpa repudiandae ab veniam consectetur aliquam aliquid doloremque.\n\nAut mollitia autem accusantium deserunt temporibus. Magni voluptate incidunt explicabo doloribus.\n\nDebitis quidem quas quidem cupiditate nesciunt voluptas nemo. Optio amet facilis eum distinctio fuga ut. Aut perspiciatis ratione repellendus distinctio quidem eum maxime fugiat. Dolorem architecto magnam exercitationem ratione perspiciatis aspernatur.\n\nLaudantium eveniet optio expedita in. Esse amet nesciunt doloremque. Illum autem optio vitae qui suscipit. Voluptatibus natus rem et recusandae ea earum.\n\nNam minima quidem impedit. Corporis tempore laudantium reiciendis quis aliquam veniam assumenda. Quam dignissimos asperiores deserunt odio. Voluptates laborum corrupti eligendi magni. Aliquid voluptatum repellat eius ex qui quia earum.	45.80	\N	2017-11-27 23:49:13.68105+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
226	Carter Inc	Iste cupiditate molestiae tenetur optio occaecati quisquam. Sint atque molestias at eos fuga illum. Inventore nam aliquid incidunt animi recusandae a laboriosam repellat.\n\nQuidem illum ducimus voluptas natus iure in aut voluptatibus. Provident ad quisquam consequatur soluta quisquam doloremque qui. Distinctio delectus necessitatibus quas consequatur iste officiis inventore voluptatibus. Beatae rerum dignissimos dicta reiciendis doloribus.\n\nDoloribus deleniti amet eum repudiandae saepe quisquam architecto reprehenderit. Inventore eveniet molestias reiciendis necessitatibus adipisci et ratione. Iusto harum autem autem cumque dignissimos qui sit. Harum eaque veritatis recusandae quam.\n\nMinima corrupti corrupti ea dicta. Nobis non possimus ullam doloribus tempore necessitatibus eaque. Sapiente totam error unde aliquam non fugit. Voluptatibus harum ad id nulla voluptates tenetur.\n\nSapiente alias rerum ea animi nam quasi maiores. Ipsa nulla illo fuga optio.	81.11	\N	2017-11-27 23:49:13.713912+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
227	Wolf-Ramos	Aspernatur officia commodi atque sed eligendi assumenda laboriosam. Enim unde eligendi quaerat. Dolor excepturi et sed veritatis. Quaerat molestiae laudantium natus assumenda necessitatibus autem alias dolorum.\n\nCumque quis neque fugiat. Quia magnam molestiae aliquam et quia laborum facilis modi. Quo voluptatibus aspernatur molestias. Perspiciatis asperiores iste est laboriosam. Eius asperiores esse error quam ex in quod.\n\nQuos ipsa dolor voluptatem dolore nemo. Tempora quam maiores quae dolore.\n\nDignissimos nesciunt aperiam rerum architecto reprehenderit praesentium. Nemo earum libero ab quibusdam facilis odit consequuntur. Reprehenderit deleniti doloremque ullam autem. Molestias omnis ullam temporibus velit.\n\nReiciendis porro debitis temporibus laborum doloribus assumenda recusandae. Atque eaque accusamus exercitationem ut at cumque beatae. Quae corporis ipsa eos eveniet voluptatem libero quidem. Accusantium enim ab explicabo illo.	29.80	\N	2017-11-27 23:49:13.757083+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
228	Rodriguez, Curtis and Farrell	Excepturi quidem a reiciendis. Quos in aspernatur porro debitis ex voluptatibus. Magni provident suscipit occaecati inventore veritatis officia. Ratione mollitia odio nostrum neque reiciendis.\n\nTotam facere nihil animi nulla. Quaerat adipisci qui similique blanditiis. Animi blanditiis debitis quo pariatur quod repudiandae. Accusantium doloremque repellat delectus soluta corrupti modi nostrum. Quo ullam dignissimos tempora fugit nihil.\n\nExercitationem debitis occaecati nobis voluptatibus. Maiores voluptatem sequi modi minus voluptatum cumque impedit quam.\n\nAsperiores corrupti quisquam impedit ex. Dolores dolorem inventore ratione quibusdam quo. Odit repellendus eaque minus modi tempora quam. Quod incidunt in quae et nihil quidem.\n\nAt qui laborum error. Facilis sit qui excepturi qui deserunt esse nemo. Adipisci eligendi tempore ratione maxime.	10.94	\N	2017-11-27 23:49:13.788495+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
230	Adams, Park and Knight	Fuga sequi a qui voluptas sit ut quasi. Necessitatibus quis voluptates facilis nam. Voluptatibus dolorum sapiente aliquam laborum molestiae nostrum.\n\nUnde doloremque dignissimos perspiciatis. Corporis magni suscipit cupiditate accusantium vitae. Beatae cumque quos nostrum sequi tempora nostrum ab.\n\nExpedita deserunt tempore praesentium ut. Id itaque suscipit dolores. Voluptatum accusantium in tenetur vero non asperiores.\n\nConsequatur praesentium doloribus ex repellendus. Aperiam similique perferendis ipsa cupiditate facere maiores voluptates. Ipsum voluptas rerum suscipit autem molestiae.\n\nImpedit earum accusamus perferendis. Nam odit labore eaque eos. Odit hic dolores rerum atque soluta tenetur.	56.99	\N	2017-11-27 23:49:13.859568+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
231	Moore, Patterson and Kelly	Corrupti nulla facere doloribus. Sequi aspernatur eius in tenetur. Maiores aperiam similique voluptas dolorem ea sunt sapiente.\n\nAsperiores dolores adipisci quos voluptas voluptatem in. Veniam natus animi fugit laboriosam deserunt quod ad. Rem aperiam eos rem maiores magnam.\n\nNeque ea totam alias quasi incidunt dolorum. Dolorem vel nemo nisi qui temporibus. Saepe dolor quidem fuga exercitationem debitis. Deleniti deleniti voluptas rem autem.\n\nSuscipit facere illum placeat deserunt sunt. At suscipit excepturi vel tenetur laudantium asperiores ex esse. Rem debitis alias in delectus sint. Qui omnis officiis neque harum odit facere.\n\nSaepe similique fuga explicabo. Ratione ad a modi vero laboriosam molestiae. Fugit atque aliquid rerum necessitatibus quisquam.	50.25	\N	2017-11-27 23:49:13.906884+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
232	Lyons and Sons	Nemo adipisci earum quis similique voluptatum. Sequi suscipit fugiat in repellat. Deleniti enim natus occaecati sunt cumque libero modi omnis.\n\nAliquam quia quas excepturi iure excepturi officia. Voluptatem laboriosam non adipisci omnis nisi laudantium laudantium. Illo nobis enim rerum deleniti.\n\nReiciendis iste non perferendis distinctio ab deserunt sapiente illo. Reprehenderit asperiores ratione ea odit. Eius voluptatibus cum libero debitis sed aspernatur. Iusto hic vitae saepe eos eveniet maxime.\n\nMolestiae ad doloremque veniam adipisci. Repellat occaecati perspiciatis fugit quae. Officia quos repellat sed delectus ipsam quidem voluptatum tenetur. Fuga ratione consequatur exercitationem placeat voluptatibus.\n\nConsequatur numquam impedit maxime laboriosam. Esse consectetur asperiores possimus molestias. Perspiciatis maiores earum exercitationem. Assumenda optio tenetur nobis ad aliquid totam.	96.57	\N	2017-11-27 23:49:13.940431+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
233	Dawson-Collins	Exercitationem cupiditate sed commodi corrupti deserunt iusto non nostrum. Dolor animi illo nostrum occaecati velit eligendi vitae. Quibusdam optio deserunt aspernatur beatae voluptas repellat.\n\nLaboriosam porro nesciunt voluptatem cupiditate voluptatem. Pariatur sunt vero odit. At autem voluptate voluptas tenetur pariatur quis. Beatae nobis inventore velit dolore reiciendis quasi.\n\nEum officiis officia quo neque. Commodi optio atque occaecati et odit modi. Nisi vitae accusantium recusandae alias corrupti quo mollitia.\n\nAtque minima magnam veniam saepe odit repellendus. Nobis enim ex unde asperiores quas culpa.\n\nAnimi nisi mollitia quod expedita impedit labore praesentium. Labore non modi eius nostrum labore iusto voluptate doloribus. Sint commodi ipsa eligendi quia nostrum quo. Excepturi alias unde mollitia adipisci eaque quae reiciendis. Hic deserunt est maiores beatae nostrum nemo.	14.97	\N	2017-11-27 23:49:13.978924+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
229	Weaver, Caldwell and Kim	Asperiores a ab earum iure. Harum dicta iste expedita voluptas. Maiores reiciendis necessitatibus commodi explicabo alias exercitationem. Eos eaque commodi ratione ipsam tempore dolore quos.\n\nVoluptatum at praesentium consequuntur laudantium rerum. Officia assumenda provident eius consequuntur distinctio. Quaerat atque amet eum.\n\nPerspiciatis voluptate corporis in minus hic. Autem ipsum dolorum veniam accusamus corrupti et nulla odit. Quasi ipsa suscipit sint natus eius quisquam.\n\nLaborum debitis aperiam qui quos cum. Magni illum officiis reprehenderit alias ea iure atque. Est amet adipisci unde voluptas esse.\n\nAccusantium culpa veniam dignissimos ullam earum voluptas doloremque unde. Dolorem cumque sunt culpa cumque quas porro. Molestiae pariatur laudantium earum corrupti. Aliquid nam officia totam velit.	20.63	\N	2017-11-27 23:49:13.834318+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
234	Adams-Odom	Placeat facere eligendi voluptate. Ratione earum optio inventore quisquam facilis consequatur. Cumque nam reiciendis nesciunt facilis unde.\n\nEnim aliquid assumenda fugit dolorem consectetur optio. Consectetur fugit tenetur atque doloremque. Qui provident veritatis quae optio sapiente hic. Ad cumque rerum modi quisquam nulla blanditiis.\n\nMolestiae aspernatur voluptatum perspiciatis dolorum voluptatem sunt dolor omnis. Similique corporis non et dolorem porro amet voluptatem. Aliquam eveniet numquam asperiores laborum dolorum suscipit id. Nostrum similique exercitationem rem ratione.\n\nEst consectetur omnis explicabo facere tempora architecto quis. Maiores fuga nam quidem dolorum excepturi similique. Veritatis mollitia neque harum quidem quasi.\n\nAperiam quisquam architecto esse. Quaerat iste quasi nostrum molestias possimus. Rerum ratione veritatis doloremque dicta animi.	81.35	\N	2017-11-27 23:49:14.024944+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
235	Johnson-Fuller	Modi voluptate similique aliquid molestiae. Repudiandae natus nihil sit consectetur ipsa ducimus fugit officia. Sequi quaerat ipsam tenetur sunt.\n\nSed quae quos totam quod quisquam qui. Temporibus expedita consequatur molestiae vitae hic natus necessitatibus.\n\nVoluptate harum quasi distinctio eligendi aspernatur voluptatibus. Dignissimos dicta nihil quo rem asperiores. Consequuntur molestias fugiat doloremque dolore corporis officia molestiae.\n\nDoloremque laudantium iste in magnam. A non nemo cum eos nostrum eaque. Corporis pariatur aliquam doloribus hic similique nemo officiis. Cumque quibusdam tempora cupiditate error.\n\nSuscipit quisquam facilis ex. Sunt harum repudiandae consequatur quam. Vero quis maxime aliquam ratione quis nemo molestias nostrum.	61.88	\N	2017-11-27 23:49:14.07331+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
236	Thornton PLC	Dolor nihil voluptatum quaerat quidem quod quaerat animi modi. Fuga eos voluptate libero ex quo veritatis voluptates impedit. Quaerat impedit nesciunt tenetur minima. Est sunt ea sunt fuga dignissimos reiciendis.\n\nNumquam deleniti vel alias voluptatibus laudantium. Voluptatum assumenda minima soluta neque provident dolor expedita. Temporibus excepturi natus accusantium nostrum. Esse cum sapiente magni suscipit sequi sint nam rerum.\n\nNatus itaque laborum molestias molestiae optio doloribus rem. Sunt quisquam velit eligendi cupiditate repellat nam. Dolore optio nam voluptas error mollitia at dolor.\n\nQui delectus ex ipsa voluptas recusandae explicabo. Asperiores fugiat ad nemo excepturi. Numquam necessitatibus tempore molestiae error adipisci.\n\nEst eligendi eveniet libero maxime. Beatae cumque qui accusamus. Asperiores nulla nostrum quos culpa quas rem a.	7.44	\N	2017-11-27 23:49:14.113172+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
244	Jones, Park and Smith	Repellendus non voluptates saepe. Doloribus quisquam similique tempora voluptate at impedit tenetur. Ea aliquid quis autem repellat debitis necessitatibus. Saepe maxime odit voluptatem fugiat enim reprehenderit quos.\n\nConsequatur nam recusandae cum molestias hic cum autem. Cum voluptatum voluptatem totam deleniti.\n\nNesciunt velit commodi quod. Quidem eum autem autem rem aliquid impedit. Dignissimos ea suscipit assumenda voluptate numquam neque. Voluptatum fuga doloribus distinctio hic qui.\n\nModi repellat possimus ipsam tempora ab ad facere. A aperiam neque optio vitae placeat impedit. Nemo cumque ut autem dolorem libero.\n\nNobis saepe harum adipisci. At laboriosam doloremque nihil tenetur magni dignissimos. Hic non porro tempora debitis occaecati. Voluptatibus voluptates laboriosam blanditiis aut harum.	12.44	\N	2017-11-28 00:10:03.673472+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
238	Miller-Goodman	Similique alias quis doloremque ex unde sit commodi. Suscipit ipsam dolor illo deserunt nesciunt. Dolore eligendi animi sequi totam iste. Suscipit beatae totam eligendi.\n\nHic ratione autem incidunt minima officia voluptas. Eveniet dolores voluptate sapiente sed dolorem eos. Harum facilis voluptatum iusto sunt totam optio repellat. Culpa esse rerum nulla explicabo quam consequatur.\n\nFacere velit tempora nobis cumque. Tenetur beatae blanditiis amet necessitatibus beatae. Recusandae eligendi ratione hic voluptatem nam. Distinctio animi fugit esse quod quam similique eligendi.\n\nA ipsum neque saepe voluptatem enim omnis facilis. Dolore commodi ratione rerum maxime delectus.\n\nFugit cupiditate eveniet delectus ipsum deleniti error quae. Eveniet maxime id in doloremque repudiandae. Nemo ullam aspernatur ipsam neque possimus.	7.46	\N	2017-11-27 23:49:14.195695+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	t	t
239	Hansen-Horton	Non cupiditate commodi nam ab facere placeat. Et quaerat tenetur facilis nulla. Sunt iure beatae sit ut. Totam voluptas soluta voluptatum voluptatem magni.\n\nMaxime doloremque enim at ratione animi. Sunt molestiae dicta aspernatur sed quia autem eum. Esse accusamus quo ab illo dolor beatae.\n\nMollitia nulla exercitationem earum fugit tempore. Accusamus ipsum voluptatibus quod inventore fuga nobis molestiae. Dolor non in optio.\n\nHarum amet saepe quaerat vel. Fuga incidunt pariatur facere sequi repellat.\n\nMaxime nisi eaque minima amet cumque delectus. Ex cumque tempora sunt doloremque aut architecto veritatis iure.	5.83	\N	2017-11-27 23:49:14.247533+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
237	Shaffer PLC	Dolore itaque rem nesciunt nemo. Aliquam harum eaque sequi voluptate eveniet. Debitis quaerat assumenda minima beatae vitae dignissimos. Molestiae nobis aut a modi ea quos autem unde.\n\nExcepturi et reiciendis voluptatibus sit. Vero ducimus at minus. Culpa dolor excepturi ratione repellendus facere veniam eligendi.\n\nVoluptas quod facilis magnam sunt ex autem eum. Accusamus ut maxime enim porro.\n\nSequi blanditiis ad dolore non. Pariatur veniam dolor quam itaque officiis. Repellat aspernatur repellendus ab enim voluptatum amet.\n\nDistinctio nobis quis architecto sit eligendi maiores aspernatur placeat. Nemo quae voluptates atque. Dolores totam eligendi doloribus repellendus consectetur magni doloremque. Numquam magnam adipisci voluptas maxime reprehenderit. Reiciendis dolorem nemo saepe ullam repellat eligendi exercitationem.	99.43	\N	2017-11-27 23:49:14.155746+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	t	t
240	Delacruz, Edwards and Mcknight	Neque ipsa quibusdam ea totam doloremque illo. Illum pariatur commodi inventore repudiandae. Tenetur itaque cumque non accusantium.\n\nAnimi ab excepturi aut saepe earum et ex. Quae corporis dolorum asperiores saepe dolores quisquam. Numquam molestiae impedit non nam cum animi magnam. Tempore quasi minima odit eum nihil. Sed dolorum incidunt voluptatem voluptate fugiat molestiae repudiandae.\n\nCommodi voluptates exercitationem unde quaerat nobis. Deserunt temporibus iusto incidunt perferendis velit laboriosam sunt. Illum blanditiis earum nesciunt reprehenderit minus repellat magnam nesciunt. Placeat voluptates ullam sapiente excepturi totam facilis esse.\n\nIste quod distinctio itaque. Repellendus vero cupiditate deserunt earum labore deserunt debitis. Veritatis deserunt neque natus provident voluptatem quia expedita. Assumenda inventore explicabo ex natus praesentium.\n\nVoluptates recusandae vitae laboriosam facere. Repellendus quod enim ipsam ipsa quasi itaque corporis. Ratione quia temporibus accusantium repellendus atque. Minus perferendis unde quo ipsam totam numquam.	77.63	\N	2017-11-27 23:49:14.308421+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
38	Grant Inc	Ad perspiciatis fugit reiciendis dolor necessitatibus autem est illum. Sint quis at amet non velit perspiciatis facere. Blanditiis voluptatem voluptatibus quia. Itaque perspiciatis nulla esse maiores fugit ut nam.\n\nTempore culpa corrupti beatae libero. Ea sapiente enim deserunt dolores aperiam maxime itaque. Praesentium inventore occaecati soluta nulla ipsum ab quibusdam commodi.\n\nDignissimos officiis officia facere dicta excepturi eligendi nemo. Explicabo minus odit quo velit dignissimos. Voluptate doloremque cupiditate quas sint eligendi animi. Eum commodi labore in ex.\n\nSint dignissimos culpa facere enim alias illo odio corporis. Asperiores harum rem natus nesciunt tenetur aspernatur. Aut eveniet possimus maiores hic. Optio ex molestias perferendis odio fugit.\n\nDolor molestias fugiat illum. Neque maiores sit molestiae id deserunt atque. Temporibus eos tempora quam ullam asperiores. Doloribus fugiat illo perferendis iusto quam iure voluptatem.	17.72	\N	2017-11-22 20:26:55.992791+00	4	"3"=>"6", "7"=>"20"	t	t
78	Suarez-Taylor	Voluptatibus recusandae voluptates porro dolore cum corporis. Molestiae nesciunt itaque occaecati maxime quam iusto. Blanditiis voluptates ipsa perspiciatis excepturi dolor. Culpa rerum ipsum esse ex consequatur ea sapiente. Quia molestiae commodi doloribus nemo.\n\nRatione laborum quasi eos. Quisquam quidem ea amet neque labore exercitationem in. Asperiores cupiditate repellendus quam iusto occaecati voluptatem molestiae. Optio dolorum consectetur dolore culpa. Expedita officiis officiis voluptates voluptatum asperiores.\n\nAccusantium sit et est aspernatur ipsam repudiandae quae fugit. Nobis molestiae sit possimus placeat quis laboriosam temporibus incidunt. Blanditiis fuga doloribus reprehenderit facilis. Ad voluptas laudantium non necessitatibus perspiciatis nobis.\n\nMagnam laborum laborum rem velit incidunt sint a temporibus. Labore hic sit facere illum possimus. Suscipit quaerat tempora repudiandae.\n\nNeque laboriosam modi molestiae sed unde. Aut corrupti sapiente veritatis ratione. Nemo excepturi quisquam repellendus consequatur pariatur harum repellendus. Dolore perferendis possimus vel magni asperiores perferendis deserunt impedit.	40.28	\N	2017-11-27 23:21:07.929054+00	2	"3"=>"6"	t	t
241	Garcia-Foster	Veritatis minus ipsum modi ratione aperiam. Nam neque officiis dignissimos veniam similique vitae natus. Asperiores provident vitae velit rerum nisi aut. Dolorum dicta qui quidem quo.\n\nTotam cumque sunt eos reprehenderit voluptates eaque magni. Libero voluptatibus distinctio iure autem corporis mollitia quis. Laudantium consectetur illo consequatur laboriosam nam corporis alias.\n\nEos sint placeat voluptatum excepturi animi odio. Blanditiis labore magni ipsa adipisci molestias atque dolores quas. Veritatis alias hic temporibus occaecati. Corrupti ratione praesentium illum nemo.\n\nDolorum corporis nemo et ex corrupti nihil rerum. Rem facere fugiat tempora labore dicta. Eius voluptas facere deserunt a hic quibusdam. Numquam explicabo velit laboriosam laborum aperiam. Modi ipsam recusandae quis cupiditate necessitatibus laboriosam iste.\n\nSunt vero optio vero doloribus consequatur facere. Adipisci occaecati veritatis enim atque voluptate facilis corporis. Adipisci atque molestias laborum eius accusamus tempore ipsa accusamus.	47.74	\N	2017-11-28 00:10:03.508814+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
242	Robinson, Cantu and Guerrero	Animi iusto earum officia perspiciatis laborum laboriosam quia. Quis tenetur tempora quisquam tenetur. Voluptatem quidem molestiae nostrum placeat officiis. Voluptates officiis nihil sint aliquam numquam.\n\nDolor fuga eos sapiente inventore. Quos modi architecto aperiam. Quae nihil maiores dolorem optio excepturi repellat totam.\n\nEsse doloribus nostrum architecto laudantium velit illum repudiandae. Quia magnam eveniet dignissimos porro nam voluptatem ipsum. Accusamus id laudantium tempora dicta voluptatibus.\n\nHarum odio voluptatibus blanditiis asperiores possimus atque. Praesentium odit voluptatibus impedit quia placeat enim. Quae occaecati veniam adipisci quaerat ad. Quae sit vero labore mollitia optio vitae a. Earum quibusdam autem quis libero tempore ducimus.\n\nPorro delectus magnam facilis atque sed molestiae ad. Aliquam cum fuga suscipit magni ad cumque odio. Animi nobis totam explicabo beatae.	49.77	\N	2017-11-28 00:10:03.579894+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
243	Roach-Morrow	Labore porro enim nisi. Quo deleniti iure tenetur minima. Ad eos sit laboriosam libero.\n\nHic reprehenderit quod expedita delectus deleniti eum. Maiores excepturi nam ipsa dignissimos. Ipsam tempore nam est aliquam. Provident delectus ipsa maxime fugiat.\n\nSoluta asperiores quibusdam ab. Doloribus officia ipsam nulla laboriosam. Libero quae atque harum quibusdam velit. Eum hic dolore voluptatibus et voluptatum deserunt dicta rerum. Vero aperiam possimus expedita modi esse veniam voluptatibus.\n\nAspernatur culpa molestiae labore. Incidunt doloremque aspernatur dicta ipsum beatae. Deserunt quidem ad porro beatae.\n\nQuam iure tempora adipisci. Dolore iure iure excepturi natus error animi dicta aut. Voluptatem sit nesciunt deleniti at. Ad porro deserunt quia id quae similique fugiat.	28.50	\N	2017-11-28 00:10:03.615063+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
245	Ward LLC	Error nam harum quibusdam corporis fugit a. Minus laboriosam amet nulla asperiores magnam. Inventore pariatur deserunt necessitatibus aspernatur aut occaecati. Sequi molestias numquam exercitationem odit harum soluta.\n\nNobis earum quisquam et itaque labore. Aliquam praesentium sapiente minus maxime. Incidunt laudantium sit error laboriosam quis.\n\nTemporibus consequuntur ut fuga ad. Ad officia sit iste sit quam. Mollitia iure quis numquam atque dolor. Suscipit sed delectus ratione nihil exercitationem praesentium esse minus.\n\nRecusandae explicabo optio at soluta ducimus temporibus. Quaerat reiciendis possimus nam tempora exercitationem sunt fugit. Nemo animi molestiae alias necessitatibus harum nemo dolorem.\n\nMagni vitae dignissimos in impedit vero vitae autem. Adipisci fugit ad hic cupiditate ducimus omnis tempora. Mollitia consequatur aperiam ipsa tempora.	16.22	\N	2017-11-28 00:10:03.723147+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
246	Romero-Mills	Eaque cumque magni quia. Eveniet quo numquam molestias odio inventore ipsa repellat hic. Quibusdam ab amet cum eos quo.\n\nVeniam corporis sequi quod autem excepturi iure iste. Maxime architecto necessitatibus repudiandae cum. Harum animi modi animi adipisci veritatis.\n\nDolor architecto maiores rem dolorum nulla possimus molestiae. Tenetur praesentium et rerum eos magnam. Odio modi occaecati dolorum reprehenderit. Corporis nulla temporibus iste quaerat.\n\nVoluptatibus odio voluptatem inventore voluptatem corrupti. Ipsam asperiores occaecati ea nesciunt. Quos tenetur nemo sint possimus explicabo qui.\n\nEsse maiores numquam sunt at natus. Quaerat aspernatur praesentium nam similique veniam delectus illo. Quas maiores ipsa nesciunt voluptate animi suscipit beatae. Optio aliquid reprehenderit architecto dignissimos.	89.18	\N	2017-11-28 00:10:03.777135+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
247	Wright, Weber and Myers	Provident reiciendis adipisci natus. Odio ipsam doloremque ab delectus porro necessitatibus. Officia eum provident alias recusandae inventore cupiditate voluptates illum.\n\nTempore aperiam reprehenderit excepturi dolorem facilis. Aperiam necessitatibus debitis fuga architecto illum. Sint ad deleniti sequi minima vero.\n\nAt dolore explicabo facilis impedit facilis fuga voluptates. Perspiciatis repudiandae accusantium repellat aut repellendus. Est soluta minus fugit quaerat quo. Iste non saepe omnis fugit provident.\n\nQuasi possimus quos ut neque autem. Corporis reprehenderit exercitationem porro itaque nisi optio beatae. Veritatis at dignissimos esse excepturi.\n\nEarum harum iure molestiae quaerat voluptate quo maiores. Nam doloribus quis quis earum dolore. Eius officia sapiente omnis corporis voluptatum sapiente. Sapiente recusandae velit error assumenda esse. Iste esse culpa corrupti et corrupti esse illo.	56.67	\N	2017-11-28 00:10:03.831053+00	1	"1"=>"2", "2"=>"3", "3"=>"6"	f	t
248	Gutierrez PLC	Doloremque libero laudantium delectus possimus. Impedit fugiat temporibus unde est. Repellat maxime libero blanditiis ipsum fugit repellendus unde. Natus iste facere deserunt iusto reprehenderit saepe.\n\nAmet autem voluptatem maxime. Consectetur molestias consectetur error quasi. Laborum accusantium labore aperiam ex. Sapiente nisi exercitationem esse at consectetur impedit quos. Ex est ullam sint necessitatibus culpa quod.\n\nMagnam qui maxime odio at. Culpa ipsum dolor perferendis voluptatum ab aut laboriosam. Quidem ipsa vel placeat doloremque odit.\n\nFugit blanditiis earum doloribus odio dicta. Quibusdam pariatur ut esse inventore nemo corrupti. Deserunt repellat quidem error ratione. Illum ex laborum voluptas accusamus esse.\n\nEnim ratione autem soluta aperiam molestiae ab. Quod culpa quam aliquam officiis distinctio. Officiis ipsam ea expedita distinctio quasi. Magnam alias ad ut perferendis repellendus.	89.59	\N	2017-11-28 00:10:03.874814+00	1	"1"=>"2", "2"=>"3", "3"=>"6"	f	t
249	Johnson Ltd	Quia aliquam adipisci distinctio sint quod. Consequatur pariatur quasi tenetur saepe maiores. Nisi quaerat placeat sunt atque nihil vitae.\n\nArchitecto sunt illum totam vitae. Odio occaecati vero corporis delectus eveniet odit fugit. Rem natus quidem numquam iure ea dolore. Aut est cupiditate iste alias vero ducimus dolorum.\n\nBlanditiis neque iusto doloribus fugiat. Necessitatibus inventore nesciunt libero quos quis temporibus odit. Sapiente voluptates fugit numquam laborum ad. Non corporis provident vitae ipsum laudantium.\n\nDeleniti dolor in nemo quibusdam repellat modi eligendi. Aspernatur culpa unde qui modi saepe. Porro labore tempora eum at sequi nobis voluptates commodi. Perspiciatis laudantium expedita quod vel.\n\nDolorum dolorum repellat dolor. Aliquid laboriosam saepe neque explicabo. Ad temporibus sapiente omnis sit et iste excepturi.	95.14	\N	2017-11-28 00:10:03.932146+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
250	Donovan-Brown	At corrupti nam nam vel et corporis numquam. Neque dolore repudiandae recusandae ipsum nobis libero ipsa necessitatibus. Quos eveniet sint nulla consequuntur. Quam modi repudiandae rerum totam maiores.\n\nEius nobis dolore temporibus maiores. Maiores excepturi sit sed nostrum explicabo consectetur. Tempora aspernatur expedita illum velit. Ipsa quibusdam ullam repudiandae quae quae accusamus.\n\nNemo enim dolorum ullam dolorem repellat. Mollitia necessitatibus soluta quo dolor. Consectetur itaque expedita in dignissimos quis voluptatum minus fugiat. Non enim architecto molestias nostrum.\n\nMinima sapiente nemo nihil fuga. Soluta adipisci non dignissimos pariatur perferendis quam. Quisquam nobis dicta hic sunt quae.\n\nCum beatae odit eligendi quisquam ut officiis. Pariatur debitis molestias harum dicta eos quibusdam dolore sequi. Doloribus molestiae ipsa qui hic. Distinctio quos qui blanditiis tempore.	31.40	\N	2017-11-28 00:10:03.974055+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
251	Barnett-Terry	Laudantium consequatur voluptatibus tempore ipsa nihil. Nobis eligendi officiis placeat soluta iusto magni harum.\n\nSuscipit praesentium excepturi atque sunt. Quibusdam quo nulla blanditiis asperiores inventore pariatur quisquam. Nulla explicabo possimus mollitia rerum fuga exercitationem.\n\nDeserunt amet sit itaque non nam corrupti vel. Voluptatem quia aperiam nobis molestias sit. Eaque nam repellat quam inventore possimus ipsum.\n\nNemo cupiditate facere maiores possimus ullam tempore. Sunt harum eius nobis blanditiis. Maiores ad molestiae voluptatibus quaerat maiores esse.\n\nError tempora tempore eligendi ipsam dolores sequi. Sed aliquid aspernatur dolore quos autem placeat rem ut.	71.95	\N	2017-11-28 00:10:04.024834+00	2	"3"=>"6"	f	t
254	Johnson Inc	Cupiditate voluptatibus dolorum temporibus possimus occaecati iure. Nisi sapiente in porro vero possimus. Et laudantium molestiae fugit temporibus aut sit.\n\nSapiente facere error natus quas consectetur fuga. Quaerat dolor explicabo quis id. Ullam neque expedita dicta nihil mollitia fugiat. Officia nisi magnam consectetur neque.\n\nIn accusamus expedita nihil labore eum. Aliquam numquam voluptatum fuga recusandae. Iure perferendis odio commodi cumque officiis. Similique sint cumque repudiandae beatae alias mollitia.\n\nQuisquam accusantium quas enim. Deserunt nesciunt doloremque voluptates modi nemo rem. Magnam dicta quasi modi eaque. Quisquam eligendi odit occaecati quam praesentium laboriosam minus.\n\nMollitia cumque deleniti quidem quas voluptatem ea. Ullam deserunt nesciunt iusto eaque reprehenderit culpa. Rem nam nesciunt neque odio possimus. Veniam facere nam officiis optio neque exercitationem.	41.50	\N	2017-11-28 00:10:04.119036+00	2	"3"=>"6"	f	t
255	Cantu LLC	Suscipit excepturi facere laboriosam deserunt suscipit exercitationem. Ea consequuntur fuga suscipit deserunt eligendi deleniti. Atque voluptatibus animi quos iure dignissimos quisquam est quisquam.\n\nOfficia ipsum voluptates porro ut similique. Animi vel magni voluptas saepe. Quasi repellendus excepturi quo consectetur quam ducimus.\n\nNam sequi ab cum maiores asperiores repellendus. Inventore quibusdam voluptatibus neque ex dolore similique ex. Sapiente itaque accusantium inventore quisquam inventore omnis. Ut rerum natus voluptatibus architecto nulla.\n\nDelectus ipsam earum sequi quo sapiente. Neque blanditiis molestias vero maiores quam. Possimus quos ea voluptatum aperiam occaecati ipsum.\n\nTenetur corrupti explicabo distinctio fugiat dolorum. Itaque reiciendis architecto pariatur sequi tenetur. Ducimus natus in illo. Aliquid reprehenderit nostrum quas unde ab eos eum. Dignissimos labore aliquid molestias repellendus.	86.34	\N	2017-11-28 00:10:04.140252+00	2	"3"=>"6"	f	t
256	Martinez-Schmidt	Consectetur magni sint voluptatum. Eligendi harum eligendi molestiae consequatur totam tenetur doloremque. Totam at similique possimus eius. Delectus sit laboriosam laborum fugiat.\n\nIllo et cum veniam tempora similique. Neque sed dicta fugit corrupti dolorum. Sequi molestias dolore dicta quibusdam. Voluptatem aut nostrum in voluptates distinctio placeat dolorem.\n\nLabore excepturi quo omnis commodi ad. Consequatur facilis rerum illum reiciendis. Hic vel sequi fuga earum. Quae natus in consequatur illo et quos.\n\nLibero iste dolore incidunt. Eum suscipit veritatis deserunt reiciendis odio vero eum facilis. Possimus eos sint praesentium optio aut. Repellendus laboriosam earum occaecati exercitationem voluptas repellat beatae totam.\n\nDelectus velit architecto cumque expedita placeat deserunt quisquam. Asperiores blanditiis delectus quibusdam odio. Voluptates enim facilis voluptatibus omnis quam consectetur.	12.92	\N	2017-11-28 00:10:04.162438+00	2	"3"=>"6"	f	t
257	Mcgee, Walker and Carey	Ut fuga voluptatum quasi temporibus illo accusantium quisquam. Perferendis voluptate tempora facere odit. Ad harum soluta nam ipsa. A est necessitatibus dignissimos molestiae.\n\nLaborum quasi vero exercitationem nulla maxime. Dolore nisi quod iste blanditiis quia corrupti hic. Animi culpa exercitationem ad recusandae.\n\nSed atque quod culpa sed tempora ipsum. Repudiandae quaerat tempore at ex laboriosam.\n\nAspernatur fugit accusantium iure vero harum. Ducimus recusandae incidunt incidunt veritatis soluta reiciendis. Nobis quaerat aliquid dolores reprehenderit deserunt minima.\n\nEarum id nihil sit repellendus distinctio. Aperiam nostrum dolores similique a doloribus velit omnis id. Voluptate voluptatum odit temporibus vitae dolorem dolor.	36.68	\N	2017-11-28 00:10:04.188923+00	2	"3"=>"6"	f	t
258	Smith-Mcfarland	Molestias totam assumenda ipsam quaerat esse. Tempora sint reiciendis eius laudantium amet in molestias. Amet consequatur tenetur nesciunt numquam iure magnam. Tempore corporis minima fugiat ipsa aspernatur cupiditate tenetur. Odio voluptas eveniet voluptate occaecati odio dignissimos.\n\nDolor perspiciatis dolor eius sapiente et. Aut natus quidem distinctio reprehenderit sunt autem eius. Eaque quos sapiente aut pariatur.\n\nQuam mollitia delectus quo dolor. Tenetur delectus ducimus magni perferendis minima dolorum officia. Possimus odit animi cum doloribus.\n\nImpedit qui ipsa itaque porro. Nobis deleniti assumenda quas inventore id aut illo. Ut aliquid nihil recusandae.\n\nTenetur repudiandae voluptate corporis dolore cum laboriosam velit. Minus ad laborum non corporis blanditiis perspiciatis ea. Suscipit culpa qui dolore saepe ut culpa voluptate.	31.46	\N	2017-11-28 00:10:04.209121+00	2	"3"=>"6"	f	t
252	Walker-Shelton	Voluptate inventore quibusdam fuga recusandae mollitia beatae dolorum numquam. Voluptates numquam accusamus sequi pariatur libero eligendi. Sint modi voluptatibus illum libero corporis inventore. Facere nam maiores illum voluptatum a dolorum.\n\nSint vitae expedita non sapiente facere dolor cupiditate. Sint praesentium dicta amet officia culpa. Magnam possimus sunt debitis illo vel corrupti.\n\nRepellat ratione facere itaque distinctio nostrum repellendus dolore perspiciatis. Harum quae fugit quibusdam voluptatem ad blanditiis.\n\nDebitis nam magni id eum. Assumenda laborum ipsum consequatur amet. Dignissimos quod aut odit excepturi atque quibusdam expedita exercitationem. Sunt vero perspiciatis repellat non dolor.\n\nSed dignissimos repellat vitae dicta iusto. Eligendi veritatis nihil dolorem eum ipsam. Commodi mollitia optio delectus quae. Est inventore ab distinctio nemo.	35.39	\N	2017-11-28 00:10:04.057998+00	2	"3"=>"6"	t	t
253	Collins Group	Animi eius cumque numquam neque officiis. Repellat ratione perferendis explicabo nesciunt. Sint consequatur praesentium est placeat ut odio.\n\nExercitationem mollitia et distinctio. Corrupti nihil rem sit aut eius illo odit.\n\nQuod aspernatur odit quod alias sapiente repellat amet. Porro similique vel quas temporibus inventore aliquam.\n\nNostrum dolores minima provident odio iusto deleniti recusandae. Saepe quod in cumque fuga facere reprehenderit tenetur. Minima dolores animi libero laboriosam ullam consequuntur. Aperiam quaerat at quis non.\n\nIllo deserunt fugit sequi nobis adipisci. Quaerat eligendi deserunt placeat omnis.	60.65	\N	2017-11-28 00:10:04.090101+00	2	"3"=>"6"	t	t
259	Randolph, Beasley and Pham	Voluptatem excepturi officia aliquid ullam harum repudiandae possimus. Omnis quas quo omnis qui cupiditate. Aliquam amet ab in culpa. Voluptates inventore enim ab occaecati quos.\n\nUllam neque veritatis voluptatum ipsam corrupti vero. Minima tempore soluta voluptate. Sapiente quo recusandae incidunt labore fugit.\n\nSit mollitia numquam dicta perferendis. Quasi amet reiciendis voluptate neque laboriosam. Nobis eaque quae debitis iste eveniet dolore saepe.\n\nTemporibus occaecati odio illo exercitationem sunt earum reiciendis ipsum. Eos aspernatur illo animi doloremque delectus quae autem. Ducimus possimus earum quam assumenda perferendis at.\n\nDeserunt officiis voluptatum repellendus cupiditate reprehenderit culpa porro. Atque perferendis autem assumenda possimus. Inventore ipsum minus sit.	92.70	\N	2017-11-28 00:10:04.230401+00	2	"3"=>"6"	f	t
260	Jordan Group	Repellendus optio porro esse incidunt veritatis ipsa. Laudantium sit asperiores numquam fugit maxime repellendus. Libero repudiandae saepe corrupti ipsum. Corrupti odio explicabo non fugit repellendus quisquam qui.\n\nAt minus impedit ab sapiente dicta blanditiis amet. Dolorum quos doloribus qui laboriosam doloremque. Nihil reiciendis voluptas alias iusto nobis quod excepturi.\n\nNesciunt nisi delectus eos illum omnis perferendis deserunt. Ullam sint expedita rerum harum perferendis deleniti corporis excepturi.\n\nOmnis saepe cupiditate quasi earum eaque. Architecto recusandae aliquid nesciunt iste sit animi.\n\nIpsam doloribus in hic dolor hic repudiandae maiores quo. Ratione architecto delectus sequi illum architecto temporibus. Fuga est numquam voluptas dicta fuga nam. Odit quas velit harum.	81.37	\N	2017-11-28 00:10:04.260333+00	2	"3"=>"6"	f	t
261	Cohen, Vega and Duncan	Cupiditate exercitationem odit maiores exercitationem. Quidem aperiam ea debitis esse. Quasi possimus unde praesentium deleniti porro neque enim.\n\nEt quos consequuntur quos pariatur tempore porro dolor. Perspiciatis unde impedit laboriosam voluptatem facere esse. Vel quibusdam doloremque sunt vero voluptate culpa. Mollitia praesentium cum itaque odio consectetur ex.\n\nOptio vitae iste sed doloremque. Distinctio facere deleniti sit. Inventore quas ipsum accusamus molestiae sequi cumque.\n\nNesciunt iure cum quia. Nobis corporis ipsa incidunt. Vero ad blanditiis error amet esse.\n\nLaborum nulla aspernatur numquam quae repellendus. In quis esse rerum optio reprehenderit sapiente. Nesciunt provident eum expedita.	6.75	\N	2017-11-28 00:10:04.28732+00	3	"3"=>"6", "5"=>"13"	f	t
262	Riley-Davies	Pariatur laboriosam incidunt quaerat voluptates repellendus praesentium. Eos incidunt ea dolores omnis. Dicta possimus repellendus deserunt natus cupiditate delectus suscipit. Eum esse nostrum quis magni quaerat est ut temporibus.\n\nTempora asperiores quod molestiae. Provident necessitatibus iure debitis. Exercitationem impedit consequuntur deleniti recusandae delectus. Recusandae facere inventore perspiciatis.\n\nOccaecati est labore fugit quis dolorum minus. Similique nisi dolore libero odit. Autem eius ab quis adipisci.\n\nAmet voluptatum reiciendis temporibus quasi ipsum ad. Adipisci asperiores dolorem molestias est possimus consequuntur. Quia magnam veritatis blanditiis provident voluptate perferendis quos.\n\nAliquid quis ex ab provident. Quae incidunt optio natus magnam occaecati nostrum corporis. Est laboriosam magnam temporibus esse cupiditate expedita. Perspiciatis atque amet quibusdam maxime. Sit rem aliquam aliquid sequi neque error.	76.11	\N	2017-11-28 00:10:04.338391+00	3	"3"=>"6", "5"=>"14"	f	t
263	Escobar-Rodriguez	Ut voluptas a officia. Iste cumque itaque cumque odit non ducimus. Voluptates tempore eaque nesciunt occaecati dolor quos.\n\nVoluptatem modi dicta doloremque asperiores dolor quia laudantium mollitia. Molestiae aliquid quae autem tempore labore iste. Praesentium et iusto facilis ipsa nemo cupiditate sit.\n\nLaborum quod veritatis ipsum voluptatibus voluptates. Consectetur necessitatibus illum eius totam aut laudantium nesciunt. Impedit repudiandae inventore in repudiandae sint.\n\nLibero expedita culpa laborum voluptas voluptatum. Reprehenderit dolor quod dicta earum reprehenderit in delectus quaerat. Aperiam velit nam pariatur impedit inventore expedita incidunt. Eveniet deleniti ex est impedit suscipit quod.\n\nQuibusdam rerum vero quaerat nam illo nulla voluptates. Facere velit pariatur optio. Consequuntur sequi quae alias dicta aperiam eos modi. Repudiandae ut ab repellendus totam soluta ad.	2.10	\N	2017-11-28 00:10:04.370782+00	3	"3"=>"6", "5"=>"14"	f	t
264	Dunn and Sons	Tempora odit provident excepturi. Ipsa porro facilis sequi modi voluptate. Dolore tenetur voluptas animi quaerat. Mollitia molestiae maiores atque nostrum doloremque consequatur.\n\nUnde accusamus aliquam esse consequuntur alias optio. At ratione fugiat voluptas iste libero necessitatibus facere. A provident dolorum quasi.\n\nIpsam modi maiores distinctio sapiente. Nemo minus voluptas cupiditate corrupti sunt quibusdam. Inventore occaecati deleniti unde repudiandae.\n\nConsectetur velit animi ut molestiae. Voluptate ut expedita saepe sapiente iste. Soluta earum quae amet deserunt. Ipsa consectetur vel omnis itaque asperiores culpa reprehenderit consectetur.\n\nCorrupti sit accusamus laborum veritatis maxime. Quis cumque doloribus labore cupiditate molestias adipisci. Harum eius aspernatur nulla illum. Illo odio tempore veritatis dolore consequatur.	89.85	\N	2017-11-28 00:10:04.413599+00	3	"3"=>"6", "5"=>"14"	f	t
265	Duncan, Wiley and Nichols	Veritatis facere ipsum reiciendis nulla ipsum nostrum. Itaque sit dolor dolorem. Harum delectus est quidem voluptates adipisci.\n\nAd voluptate excepturi sapiente necessitatibus optio corporis voluptatum. Qui numquam quos nam repudiandae occaecati consectetur. Atque tempora accusamus reiciendis consectetur illo fugit consectetur incidunt.\n\nQuisquam voluptates sequi quisquam excepturi error voluptatibus consequuntur. Sit ut soluta doloribus. Possimus accusamus blanditiis assumenda soluta vel ab. Tempora nisi earum ex aperiam qui accusantium.\n\nA soluta exercitationem reprehenderit. Enim earum dolorem ab dolores ullam maiores. Autem dolore sequi perspiciatis doloremque magnam nihil perferendis. Aperiam corporis sit suscipit in unde tempora odio.\n\nBeatae placeat assumenda deserunt dolores praesentium eligendi accusamus. Veritatis dolorum saepe voluptatum. Tempora sit atque modi laborum odio aut.	14.15	\N	2017-11-28 00:10:04.458432+00	3	"3"=>"6", "5"=>"13"	f	t
270	Allen, Nguyen and Barrett	Sapiente rerum labore magni suscipit sequi molestias. Hic quod illo voluptas ab temporibus numquam natus. Soluta corrupti natus exercitationem quaerat hic tenetur.\n\nTempora in nostrum rem voluptatem vitae amet. Sapiente repellat sunt omnis inventore. Magni ratione saepe culpa ea.\n\nEsse maxime tempore nostrum placeat. Eligendi ducimus quibusdam quo voluptatum recusandae aut. Dolorem minus nam in magnam. Officiis praesentium illo facere distinctio eaque.\n\nUt reiciendis dicta minima consectetur. Iure tenetur vel accusamus reprehenderit aliquam nam itaque ducimus. Quis corrupti illo odit magnam asperiores impedit quos.\n\nVeniam vero debitis placeat ad occaecati. Maxime voluptatibus neque temporibus laboriosam excepturi fugiat quo incidunt. Ab harum fuga sapiente et. Eaque a animi beatae officia unde.	39.16	\N	2017-11-28 00:10:04.727228+00	3	"3"=>"6", "5"=>"14"	f	t
271	Kelly Inc	Fuga eveniet dolorum qui laborum quasi amet non. Corporis officia animi doloremque aliquid dolore accusamus. Harum consequuntur officiis facere iste alias dolorum harum.\n\nDicta natus eius minima. Mollitia voluptate quo delectus repellendus maiores distinctio. A sunt aliquid perspiciatis beatae numquam modi voluptatum cupiditate. Maiores provident dolorem expedita.\n\nDeserunt nobis atque ullam sapiente sint. Minus reiciendis assumenda eum magnam minus voluptatibus. Dolorum soluta dolor eos ipsum fugit.\n\nRepellendus corporis debitis nisi error. Debitis illo neque quaerat ad commodi perferendis. In quod saepe blanditiis quaerat.\n\nCupiditate rerum maxime quod voluptatum. Explicabo dolorum necessitatibus quod ad quia dolorum. Ut vel culpa numquam aut voluptate. Fugiat iste veritatis architecto amet.	7.22	\N	2017-11-28 00:10:04.775907+00	4	"3"=>"6", "7"=>"19"	f	t
273	Hammond-Stephens	Ad delectus quasi ipsa accusantium sed adipisci nesciunt. Aspernatur perferendis quae maxime ea dicta maxime quas commodi. Velit nesciunt fugiat ullam assumenda alias itaque officia.\n\nQuas nobis corrupti fuga blanditiis dolor impedit commodi. Esse dolore corrupti quos nulla modi quaerat. Nihil a nam quae ut recusandae deserunt harum exercitationem. Dignissimos reiciendis rerum modi eveniet quas omnis illum dolorem.\n\nAtque reprehenderit odit et cum quasi eos. Incidunt unde molestias quos placeat quasi nihil. Placeat aliquid blanditiis voluptas voluptatem quia modi.\n\nDoloribus tempora sapiente commodi cum. Molestias accusantium veniam perferendis numquam. Qui adipisci corporis reprehenderit amet nemo quas. Ipsum voluptates deleniti iste eos.\n\nQuia magni similique quaerat quod ab soluta. Rem modi unde eos praesentium voluptatibus eveniet. Veniam impedit aspernatur sit aperiam voluptate sunt.	81.65	\N	2017-11-28 00:10:04.856182+00	4	"3"=>"6", "7"=>"20"	f	t
274	Glass-Schwartz	Voluptas et earum quas facere ea. Ullam earum labore reprehenderit odit saepe quasi reprehenderit. Atque animi nulla in voluptatibus mollitia delectus possimus cupiditate.\n\nCorporis eligendi praesentium sit nisi quisquam voluptatum voluptate nemo. Aut alias dicta assumenda ex pariatur voluptate cum saepe. Optio nihil repellat cum voluptates quia nesciunt.\n\nDeserunt molestiae quidem dicta nulla. In reiciendis quas totam in recusandae reprehenderit. Quas occaecati porro quia.\n\nSint natus quisquam quo tempore provident. In est iusto aliquam ea expedita iure nobis.\n\nRecusandae nihil maxime quia sunt. Eum voluptatum amet adipisci consequuntur. Impedit saepe in reiciendis maxime. Nam quod reiciendis praesentium fuga quam earum perspiciatis.	34.73	\N	2017-11-28 00:10:04.896613+00	4	"3"=>"6", "7"=>"20"	f	t
275	Knox-Washington	Illo commodi illo ducimus sed quis sunt. Atque consequatur earum itaque impedit deleniti pariatur. Reprehenderit dolorem dolorum atque eum saepe maxime.\n\nInventore asperiores quasi quod aperiam facere inventore. Molestiae quam ducimus commodi esse.\n\nDoloremque vero ea possimus minima consequuntur pariatur dolorum autem. Quae laboriosam minus magni laboriosam cumque. Inventore eum asperiores porro debitis atque.\n\nArchitecto ipsa officiis voluptates unde. Recusandae ab repudiandae assumenda nisi itaque non. Culpa eum ducimus nisi recusandae quas quia ullam eveniet. Eaque ab aliquid itaque praesentium possimus.\n\nVoluptatum quis a quo nisi in minima rerum. Consequuntur at est porro porro perspiciatis. Ratione commodi eveniet impedit quam dolorum praesentium sint. Voluptate ullam repellendus sit eaque.	47.96	\N	2017-11-28 00:10:04.94379+00	4	"3"=>"6", "7"=>"19"	f	t
269	Simon-Miller	Ex repudiandae voluptatem eligendi commodi a. Iure eveniet quidem consequatur soluta itaque molestiae similique. Dolorem tenetur sequi hic explicabo. Vitae reprehenderit ea totam dicta dicta cumque mollitia.\n\nOdit libero impedit recusandae blanditiis explicabo quos repellat. Ipsa tempore labore suscipit totam beatae. Fugit perspiciatis vitae nostrum sed quasi natus asperiores.\n\nAspernatur recusandae commodi adipisci sint natus ipsum fuga eos. Voluptas omnis quod reprehenderit maxime incidunt illo. Dignissimos eos odit eius molestiae labore omnis.\n\nQuidem perferendis ex consectetur consequuntur animi. Possimus perspiciatis dolor dolorem sint quisquam consequuntur cumque accusamus. Unde maxime ipsam possimus provident.\n\nNatus ad repellendus repellat blanditiis alias. A eius iure magni modi repudiandae beatae culpa. Pariatur eligendi dicta excepturi excepturi qui. Est corporis quidem commodi officia voluptas doloribus repudiandae.	83.26	\N	2017-11-28 00:10:04.681659+00	3	"3"=>"6", "5"=>"14"	t	t
276	Adams-Kirk	Assumenda facilis accusamus nostrum quam. Dignissimos quia atque quibusdam alias veniam consequuntur quo dignissimos.\n\nUt sapiente in hic quos. Fugit ut dolorem optio nulla. Quia quasi quia voluptatem officiis sapiente omnis.\n\nA eos vel nisi quos esse consequatur eveniet. Nisi est ab consequuntur odio error optio. Laudantium dolor temporibus cupiditate molestiae. Consectetur voluptatem animi facilis labore.\n\nQuos iste voluptatibus harum provident iure aperiam. Fuga quasi quam ex voluptatibus cumque autem. Unde porro quia porro sapiente nobis ex tempore. Explicabo ipsam saepe quas qui quaerat voluptate necessitatibus.\n\nQuis velit expedita sit illum nisi. Voluptatibus asperiores odio nisi. Voluptatibus omnis aut quidem nisi. Tempore commodi facilis alias quas. Nostrum sapiente doloribus ratione quibusdam.	45.17	\N	2017-11-28 00:10:04.978334+00	4	"3"=>"6", "7"=>"19"	f	t
277	Contreras, Ibarra and Barnes	Molestiae maiores minus commodi eveniet voluptatum. Saepe minima consequuntur rem earum ipsum alias nostrum commodi. Labore deserunt dolores porro minus velit.\n\nIpsa blanditiis repellendus quia commodi rerum et ex. Assumenda placeat eius voluptate rem placeat totam voluptatem. Itaque suscipit incidunt labore qui voluptates. Delectus rerum dolorem aperiam ullam voluptatibus.\n\nPariatur veniam libero cupiditate voluptas odio. Adipisci provident ratione aspernatur ipsam ducimus amet ad voluptates. Totam tenetur odit cumque itaque vitae. Aliquam voluptatem amet porro aliquam quam possimus eaque.\n\nAssumenda quis aut aliquam. Tempore ab voluptatem odio commodi dolor.\n\nQuae neque beatae dicta aut excepturi alias qui repellendus. Fugit dolorum consequatur harum praesentium. Accusamus laboriosam facere et odio fugit velit nam tempore. Unde repellendus nesciunt nam harum error eos.	11.56	\N	2017-11-28 00:10:05.030247+00	4	"3"=>"6", "7"=>"20"	f	t
278	Lowe, Nichols and Walker	Dolor perferendis laborum modi hic. Temporibus saepe atque deleniti at. Optio reiciendis iusto delectus consectetur voluptas quis.\n\nPerferendis quos quasi deserunt reiciendis. Quo incidunt rerum est dolor accusamus alias. Ratione eius officia soluta.\n\nMollitia praesentium totam delectus tempora et totam repellat. Quidem provident impedit similique ex.\n\nEarum similique deleniti eligendi officiis eveniet. Recusandae quos ratione assumenda rem ducimus ea modi. Exercitationem consequuntur sit voluptatibus fuga saepe.\n\nAdipisci deserunt eligendi maiores molestias. Eos beatae tenetur asperiores. Odio consequatur nihil molestias sed. Ipsum et corporis nihil repellat incidunt suscipit officiis.	99.41	\N	2017-11-28 00:10:05.083196+00	4	"3"=>"6", "7"=>"20"	f	t
279	Lopez, Moore and Williams	Sapiente molestias repellat beatae consectetur voluptatem amet. Maiores beatae dignissimos quasi optio ad. Impedit nam vitae nisi cumque pariatur aliquam.\n\nProvident sit veniam aliquid voluptas. Quam exercitationem at quia. Numquam reiciendis enim laborum iste dignissimos quasi. Nisi odio ut ipsum commodi veniam iure.\n\nNatus amet omnis cumque iure eveniet. Praesentium voluptas tempora quasi magni similique laborum excepturi. Rerum repellendus et unde aperiam. Laudantium ipsum hic illum autem neque sed itaque. Animi atque ut sunt vero quod.\n\nExercitationem voluptates minus exercitationem ratione in odio aut. Eaque iste dolorem explicabo rerum dignissimos itaque.\n\nAssumenda facilis voluptatum voluptas ullam doloremque. Accusamus nam odit temporibus hic at doloremque. Aut quae alias enim ipsum eveniet expedita.	64.15	\N	2017-11-28 00:10:05.121363+00	4	"3"=>"6", "7"=>"20"	f	t
280	Nguyen, Smith and Sweeney	Voluptatibus explicabo alias saepe magnam eligendi cum. Rerum molestiae facilis veniam nostrum nisi. Veritatis nobis totam distinctio iusto delectus facilis beatae.\n\nAlias repudiandae assumenda minima rem quod assumenda vitae. Animi delectus quis harum minima aliquid. In accusamus sunt suscipit saepe. Sit eius explicabo quod.\n\nOfficia ex consequatur expedita. Ut voluptatibus aut ex illo laboriosam distinctio. Illum nemo nobis reprehenderit fugiat ut blanditiis natus.\n\nA quod illum asperiores fugiat aliquam cumque quaerat. Assumenda vel libero maiores quo tempora. Repudiandae repellendus ut expedita sint pariatur nisi assumenda.\n\nQuasi illo nobis nihil iste deserunt corporis. Aliquid ducimus aliquam alias beatae. Delectus expedita est alias sequi aperiam necessitatibus minus rem. Facilis veniam magnam sed exercitationem odit quis. Alias veritatis incidunt animi sit iste veritatis laboriosam.	55.41	\N	2017-11-28 00:10:05.16055+00	4	"3"=>"6", "7"=>"20"	f	t
281	Logan-Hammond	Ea suscipit consectetur possimus voluptatem. Modi voluptas rerum soluta esse repellendus quaerat. Provident nemo eveniet numquam qui hic.\n\nAlias illo facilis fugiat quod dolore. Sapiente blanditiis iusto dolores impedit in voluptatem quas. Distinctio iure repudiandae tempore atque voluptas.\n\nVoluptate distinctio at officia necessitatibus dolor dolore occaecati. Facilis recusandae similique perferendis nulla unde fugit. Error perspiciatis officia ipsa illo ab sequi facilis.\n\nSequi culpa perferendis debitis facilis voluptatibus. Excepturi tempora asperiores placeat aperiam nostrum. Quasi nostrum aliquam itaque. Porro tempora distinctio at magnam ipsum laudantium eligendi.\n\nDebitis distinctio commodi enim eligendi explicabo ipsum. Maxime repudiandae asperiores ab quaerat fuga accusantium necessitatibus. Quia similique nam doloribus rem quam perspiciatis.	48.14	\N	2017-11-28 00:10:05.202185+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
282	Chavez Inc	Tenetur blanditiis impedit iusto doloribus illum. Culpa quia quaerat laudantium inventore. Nulla molestias nulla amet nobis illo.\n\nAdipisci itaque rerum delectus corrupti aut. Maiores repellendus exercitationem voluptatem libero rem ad aspernatur. Cumque dicta dolorem inventore ipsam odit.\n\nOptio neque nobis debitis est. Earum magnam enim dignissimos minus blanditiis repellat optio. Eius velit rerum quos doloribus iure ut iste.\n\nDoloribus tempora optio pariatur. Aliquid modi aliquid recusandae quis officia impedit odio. At veniam delectus delectus quaerat animi repudiandae corrupti. Autem officiis cumque ratione repellendus enim asperiores suscipit.\n\nAliquam id iure nemo quae vitae ipsam magni ex. Molestias animi quo ea aut quae pariatur. Vel praesentium alias molestias sint.	87.67	\N	2017-11-28 00:10:05.250029+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
283	Wilcox, Brown and Baker	Repudiandae omnis quibusdam amet perferendis. Amet dolorum cupiditate optio dicta. Neque minima eveniet aspernatur nisi.\n\nSunt voluptatem harum saepe iusto eum minima dolore. Dolor suscipit natus nobis. Aliquid dicta tempore cupiditate eum consectetur soluta eius quasi. Placeat voluptatem veritatis esse quae fugiat assumenda sed aspernatur.\n\nAmet deserunt consectetur velit neque quo. Sit similique delectus nam quod ipsa odit assumenda. Magnam delectus delectus at explicabo.\n\nProvident architecto omnis molestiae odit necessitatibus dolore. A dolor nihil consequuntur architecto veritatis qui id. Maxime soluta exercitationem vero aperiam est itaque. Qui animi quas omnis quod.\n\nVeniam asperiores natus beatae nobis perspiciatis officia. Praesentium tempora cumque sunt deserunt dolore. Quasi vero accusantium iste repellendus repellendus aliquid eligendi. Architecto deserunt possimus quisquam dolor corporis voluptatem soluta numquam. Velit sint est qui enim.	0.72	\N	2017-11-28 00:10:05.285948+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
284	Ross, Valdez and Pope	Quasi aliquid sed quasi aspernatur perferendis veritatis. Maxime animi quasi veniam similique molestiae numquam molestias. Aspernatur iste porro modi quod cumque.\n\nProvident libero quod soluta. Earum molestias harum ducimus placeat. Aliquam ipsam perferendis eos officia doloremque error. Dolorum similique eligendi earum qui officiis.\n\nCum aspernatur a molestiae. Exercitationem nulla adipisci totam consequuntur voluptatum expedita. Nulla sed perspiciatis sequi excepturi ut doloremque tenetur totam.\n\nCulpa eum labore adipisci corporis adipisci accusantium. Reprehenderit dolorem illo modi doloribus error quaerat. Quia modi sit amet quae ex minus saepe.\n\nMolestias voluptatibus unde temporibus accusantium. Quibusdam eveniet minima sequi eum. Eligendi optio molestiae in voluptatum. Laudantium repellendus explicabo recusandae eum.	63.14	\N	2017-11-28 00:10:05.334392+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
285	Boyd, Ruiz and Rios	Quibusdam esse quos esse impedit corrupti sed. Qui ratione placeat cumque ipsum laboriosam commodi. Nulla itaque earum voluptates numquam. Odio voluptatum ex laborum distinctio dignissimos est.\n\nCorporis assumenda ipsam eligendi pariatur similique. Facilis ducimus iste laudantium aperiam fugiat.\n\nEaque numquam aperiam voluptates itaque recusandae laborum. Quia molestiae minima nihil. Occaecati modi voluptatem commodi in non quam esse. Aliquam molestiae accusamus ex dolor.\n\nSapiente autem minima itaque sapiente illo esse neque laudantium. Dolorem dolor at blanditiis omnis impedit libero aspernatur molestiae. Dolorum impedit facere sed error consequuntur eius similique.\n\nQuidem saepe ut sunt commodi dolor autem. Quibusdam impedit earum numquam ea quas doloribus nostrum. Nam voluptatibus temporibus aliquid dolores autem minus consequuntur.	75.26	\N	2017-11-28 00:10:05.363719+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
286	Stone-Sanchez	Voluptate fugit porro totam consequatur voluptatum sit. Perspiciatis quis aliquam ut pariatur. Repellat nihil ut quam inventore accusamus. Nam laudantium doloremque perferendis distinctio.\n\nLabore aliquam ullam id rem officia. Accusantium optio dolorum maiores cum numquam quisquam. Dolor consectetur consectetur corrupti praesentium. Tenetur officiis nam qui qui distinctio voluptatum ullam.\n\nNecessitatibus maxime facilis reiciendis vitae provident fugiat laboriosam. Placeat deserunt voluptates perferendis eveniet. Voluptate est quae aut vel.\n\nTemporibus excepturi a inventore tempora facilis a accusantium. Vel officia doloremque saepe possimus. Voluptas dolorum ducimus perspiciatis occaecati.\n\nCum perferendis nam pariatur quia consequuntur quia officia. Laudantium quam corporis fuga eveniet unde dolorum. Fugiat maxime illo necessitatibus laudantium temporibus. Aspernatur pariatur molestias optio magnam autem.	94.25	\N	2017-11-28 00:10:05.407819+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
287	Davis, Dawson and Collins	Tempora molestiae consequuntur dolore reiciendis aliquam praesentium. Itaque adipisci totam velit deleniti. Tempora deleniti at repellendus.\n\nEsse iste voluptatibus iusto. Consequatur minima reiciendis repudiandae fugit nulla. Soluta aliquam rerum atque expedita corrupti ea recusandae odit. Nemo repudiandae deleniti sint deserunt nesciunt nulla.\n\nNam ex maxime pariatur ipsum minus modi. Rem placeat hic pariatur recusandae. Facere perspiciatis esse itaque. Possimus tenetur rem similique earum id reiciendis.\n\nOptio culpa occaecati voluptatem quasi quo sed ea qui. Maiores fuga doloribus nihil facilis consequuntur quod. Earum fugiat esse consequatur ex fuga expedita. Soluta dolores voluptatum ex ipsa atque autem.\n\nArchitecto quibusdam alias tempore quisquam ut natus consequuntur. Iure recusandae blanditiis nihil iure tempore qui eligendi. Maxime ipsa quibusdam ex provident magni necessitatibus.	12.69	\N	2017-11-28 00:10:05.435345+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
182	Chang, Henderson and Wallace	A consequuntur similique consequuntur esse atque facilis officiis. Iste sunt illum animi voluptates accusamus harum sint quaerat.\n\nLaudantium eum assumenda a aspernatur occaecati. Error quibusdam maiores quas delectus provident harum rerum. Unde excepturi dolorum voluptate ea. Dolorem beatae quas harum fuga quidem.\n\nSoluta commodi quia sunt molestiae. Cum error saepe facere. Similique vel nemo aut corporis corporis.\n\nMaiores atque ad molestiae unde maiores ipsa. Fugit culpa eius nostrum consequuntur impedit dolorum odit. Commodi accusantium in consequuntur beatae nemo.\n\nDucimus dolor nesciunt quasi recusandae. Totam doloribus nihil laborum autem. Ipsa magnam magni dolorum. Temporibus dolor eius animi possimus assumenda beatae excepturi.	88.40	\N	2017-11-27 23:49:11.538165+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	t	t
378	Soto, Carpenter and Ortega	Aspernatur quia quo earum ratione amet occaecati. Fugiat autem alias commodi odit cupiditate numquam deserunt aspernatur. Quam neque provident animi occaecati.\n\nQuibusdam iste velit voluptatibus temporibus explicabo magnam. Dolores possimus itaque nihil debitis ipsum. Odit tenetur iste repudiandae cupiditate.\n\nPlaceat voluptatibus saepe tempore harum iste recusandae excepturi. Quaerat natus autem eaque ducimus cum.\n\nVoluptatem labore impedit natus cum quo cupiditate officia. Animi magnam repudiandae maxime mollitia praesentium quas. Autem omnis eligendi beatae atque.\n\nDoloribus velit reprehenderit dicta officiis natus. Nulla veniam tenetur ratione nesciunt repellendus fugit voluptas. Dolorum nam aliquam perferendis quos libero. Illo reprehenderit deleniti minus laboriosam vel quae eaque accusantium.	86.17	\N	2017-12-02 22:51:34.36172+00	2	"3"=>"6"	f	t
288	Wood, Lozano and Griffin	Sit deserunt debitis facere laborum et hic iste. Quia quis atque fugiat reiciendis eveniet voluptates. Dicta molestias earum occaecati pariatur quia.\n\nQuis veritatis recusandae iusto quis quisquam vero quod similique. Odit fugiat commodi est nulla deleniti. Soluta architecto quas quo tenetur temporibus rem iusto. Aperiam cumque dolorem molestias corrupti.\n\nUnde earum possimus eius facere enim labore. Iure placeat est voluptatum consectetur repudiandae. Eius nemo aliquam at iure esse in.\n\nReprehenderit iusto officia fugiat est eligendi libero odio. Exercitationem accusamus totam pariatur impedit quas. Odit voluptatibus aperiam recusandae possimus fugit consectetur. Suscipit iusto itaque totam.\n\nCorrupti ratione similique quia omnis nostrum quod. Reprehenderit impedit deserunt adipisci expedita ipsum. Et facere nesciunt nulla quis quibusdam. Laudantium atque voluptatem animi repellat perspiciatis repellendus neque.	16.75	\N	2017-11-28 00:10:05.467226+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
289	Andrade Inc	Beatae esse eos quasi voluptatibus. Magni libero error cupiditate adipisci error incidunt. Numquam harum ut laborum cumque sint alias. Laudantium quaerat eius nobis asperiores vitae.\n\nDelectus possimus voluptatum soluta exercitationem voluptas. Illum dolorem officia accusantium assumenda corporis perferendis soluta. Numquam earum sed fugit cumque omnis doloremque debitis. Magnam laudantium sunt mollitia.\n\nEveniet quaerat esse rerum pariatur eligendi dolore aliquam fugit. Rerum saepe sunt a nostrum. Doloremque at eaque consectetur aperiam qui illum nam dolorem. Iure sed ipsa aliquid aliquam.\n\nFugit fuga commodi amet repudiandae labore est. Laborum eum dignissimos nam. Consequuntur non aperiam praesentium quisquam.\n\nNobis quod porro iusto exercitationem mollitia dolorem. Labore quam repellendus tempora blanditiis expedita. Qui velit consectetur accusantium commodi atque sunt. Quis iure adipisci cupiditate dolores aspernatur.	74.17	\N	2017-11-28 00:10:05.494085+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
290	Johnson PLC	Nobis exercitationem dolor rerum laudantium veritatis. Magnam officiis ipsam laudantium blanditiis. Tempore quia delectus impedit eaque.\n\nUllam reprehenderit reiciendis ex maiores. Cum sequi exercitationem eveniet. Ex ipsam tempora hic eum officiis et. Occaecati atque facere minus ex ad voluptas voluptatibus. Ullam aperiam id voluptates doloremque maxime.\n\nFacere doloremque corrupti nemo quis. Similique iure consequuntur quod sed. Quasi inventore harum eius quaerat nemo nemo repellat repellat.\n\nVoluptatum autem fugiat repellendus ipsa. Aut perspiciatis hic illum minima nobis. Dolorum fugit vitae odio adipisci consequuntur accusamus.\n\nEt eligendi facilis veritatis neque quod aperiam. Minus nesciunt laboriosam quis at architecto commodi. Maxime officiis rem suscipit nemo ullam natus voluptas. Omnis ad voluptate quisquam eum a.	9.59	\N	2017-11-28 00:10:05.531501+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
291	Robinson PLC	Cupiditate quaerat ex veniam quidem magni quidem eos. Aliquid commodi voluptatem voluptates cum. Nisi saepe fugiat quasi laborum.\n\nLaudantium iusto ex alias soluta possimus ratione. Ad ut ea dicta rerum. Dignissimos qui perspiciatis aperiam omnis placeat.\n\nNihil nam eos laborum rem. Sit nulla error quam veniam facilis architecto nemo. Incidunt reprehenderit praesentium velit nostrum. Nostrum doloribus iusto dolores voluptate ad deserunt. Accusamus nam culpa quae voluptate hic iusto eaque molestias.\n\nOfficiis saepe provident aut beatae recusandae qui natus. Deleniti illo velit molestias excepturi ad odio. Iure excepturi minus quam cupiditate occaecati. Voluptatem modi vel laudantium dolorum at.\n\nQuis adipisci iusto aspernatur est eum. Expedita odio ipsum dolorem fuga.	84.62	\N	2017-11-28 00:10:05.573013+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
292	Mooney, Wright and Jones	Exercitationem quibusdam aperiam reprehenderit repellendus veniam porro sit dignissimos. Omnis dolores neque aut sapiente facilis accusamus aliquam. Dignissimos porro possimus deleniti asperiores eveniet delectus totam eos. Commodi consequatur beatae est.\n\nAlias atque asperiores et. Deleniti provident accusamus tempora voluptatum id. Pariatur quaerat harum nam.\n\nInventore voluptate blanditiis facilis asperiores exercitationem totam officia fugit. Necessitatibus sequi fugit dignissimos assumenda deleniti ducimus nesciunt. Ducimus illum voluptatum nobis nam voluptas dicta.\n\nOdit excepturi molestias voluptate autem dolorum ullam. Officiis hic ullam natus suscipit. Fugiat odit aliquam magni quas. Ipsam dolore dolorum nihil reprehenderit iure laudantium repudiandae.\n\nLabore iste dolorum architecto tempora laborum. Vel accusantium nostrum placeat nam omnis aperiam. Ad veritatis asperiores eum provident quod officiis veritatis. Sed minus ea et omnis.	79.60	\N	2017-11-28 00:10:05.613774+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
293	Krause-Stevens	Debitis quae dicta necessitatibus inventore possimus laborum commodi. Ratione ad iure suscipit necessitatibus eius. Odio hic quas reprehenderit omnis porro quo.\n\nNobis nobis occaecati adipisci iure hic. Deserunt ipsum sint possimus similique temporibus et. Quasi debitis natus recusandae. Fuga iure porro officia iusto voluptatum minus aspernatur.\n\nAperiam debitis odio delectus aspernatur maxime. Incidunt ratione amet illum.\n\nEarum iusto qui officia soluta esse excepturi aliquam. Saepe cum maiores harum at minima. Doloribus quibusdam nesciunt ipsa cum cumque molestiae.\n\nId voluptas incidunt neque. Veniam quibusdam suscipit rerum quisquam expedita laborum iure laborum. Nostrum qui blanditiis pariatur. Quam possimus nemo odio minus.	17.12	\N	2017-11-28 00:10:05.652778+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
294	Flowers, Griffin and Perez	Quae sit eveniet fugit aspernatur. Totam ducimus animi quam ratione sapiente quis error laborum. Veniam perferendis vel neque sint maxime distinctio possimus. Recusandae illo modi quam et.\n\nLaboriosam veniam dolore unde exercitationem. Alias accusantium sapiente maiores deleniti. Veritatis dignissimos et optio. Iusto tempora aut et eum possimus quasi.\n\nEarum repellat cupiditate placeat asperiores quasi officia incidunt reprehenderit. At tempora iusto omnis quidem voluptate nemo.\n\nAperiam tempore ipsum corrupti exercitationem magni aperiam. Ex accusamus architecto iusto earum eveniet autem. Saepe esse possimus aliquid nesciunt molestias doloribus. Soluta quam facilis repudiandae aliquam illo.\n\nIn ipsa reiciendis magni repellendus adipisci commodi. Distinctio nulla veritatis reiciendis ad. Assumenda consectetur numquam eum iusto ipsum.	33.62	\N	2017-11-28 00:10:05.696148+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
295	Burke and Sons	Ipsum eum totam provident ipsum dolor dolore adipisci. Repellat atque soluta quibusdam totam quam. Dignissimos expedita nemo inventore dolore similique id nihil. Quibusdam odit enim recusandae adipisci impedit ratione.\n\nItaque reprehenderit qui quod saepe. Vero voluptate corporis quia labore. Quidem debitis excepturi vel. A eveniet corrupti odio minima enim sed.\n\nOfficiis voluptatem consequuntur quidem exercitationem. Consequatur non beatae et eveniet eaque. Consequuntur consectetur pariatur a laudantium eveniet. Fugit commodi vel optio nulla explicabo sunt sequi totam.\n\nOfficia iusto blanditiis illo sint quos beatae eum. Labore explicabo rerum quis suscipit quam ipsam. Neque quo doloribus velit consectetur impedit aliquam. Unde nisi voluptates facilis nam. Suscipit atque ut quidem magnam facilis maxime.\n\nOptio quo provident deserunt perspiciatis nisi. Itaque ab cumque reiciendis recusandae. Velit rerum blanditiis quaerat soluta. Possimus non corporis eum beatae. Praesentium similique iste exercitationem fugiat deleniti accusantium.	69.27	\N	2017-11-28 00:10:05.740396+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
298	Anderson, Owens and Phillips	Aut vero officiis vitae soluta vitae. Asperiores numquam mollitia porro commodi ipsam omnis sed.\n\nRepudiandae consectetur occaecati facilis dignissimos. Deleniti voluptatem expedita sit eligendi. Sunt reprehenderit non dicta harum distinctio numquam. Sunt corrupti vero illo veniam delectus.\n\nAb adipisci tempora autem dolore reiciendis nostrum. Dolorem ducimus ipsam inventore vitae. Enim magni ad libero modi corporis illo.\n\nMaxime doloremque aut veniam temporibus. Veniam voluptatibus modi consectetur nulla earum. Quis iure exercitationem asperiores.\n\nDolores consectetur aperiam nesciunt blanditiis. Nam qui ea laboriosam non excepturi eaque. Dolorem illum ullam perferendis doloribus quos.	26.90	\N	2017-11-28 00:10:05.843918+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
297	Nguyen, Mcbride and Brewer	Sint praesentium quia facilis temporibus culpa consequatur. Minima aliquid eum reiciendis veritatis nulla rem fugit.\n\nNostrum sit maxime tenetur doloremque culpa. Facere quibusdam facilis autem dolores distinctio ea dolores. Aliquid molestias esse eaque maiores cum error minus.\n\nOmnis eius dolorem laboriosam impedit labore nam soluta. Rerum excepturi et sed nemo. Eveniet molestiae voluptas culpa culpa tempore. Sed voluptate quam temporibus quidem.\n\nPlaceat nobis aliquid aliquam nesciunt saepe possimus. Ex quibusdam nihil inventore sit quo suscipit reprehenderit. Corporis doloribus ipsa eligendi iste recusandae perspiciatis consequatur.\n\nPossimus repudiandae iusto debitis ad animi vero quisquam cupiditate. Totam dolore vel non porro est ab ipsa. Est aliquam pariatur placeat architecto ratione.	7.25	\N	2017-11-28 00:10:05.812497+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
299	Hicks-Mitchell	Magnam fugit voluptates commodi delectus. Corporis laborum rerum inventore porro. Quia deleniti quasi perspiciatis necessitatibus doloribus accusantium. Eum repellendus itaque optio autem odio adipisci.\n\nHic officia at illo quaerat quasi placeat molestias. Labore error aut dolores tempora sunt cupiditate eveniet. Totam mollitia ab cum porro mollitia nesciunt.\n\nConsequuntur rerum praesentium autem dolorum quisquam. Unde praesentium explicabo facilis ab recusandae error placeat. Aspernatur nihil suscipit ad voluptatibus facilis reprehenderit est. Illo dicta quod dolorem.\n\nDolore nesciunt itaque vel consectetur. Quasi illo eligendi similique impedit odio. Aperiam assumenda nobis expedita vero. Quo ea consectetur aliquid accusamus totam minus voluptas.\n\nNecessitatibus fuga eveniet maxime impedit fugiat. Culpa debitis aliquid quibusdam aspernatur optio necessitatibus iure. Ea magni molestiae mollitia odit. Provident dolore ullam asperiores.	0.50	\N	2017-11-28 00:10:05.890794+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
300	Sanchez, Martinez and Hernandez	Quibusdam eaque sed praesentium soluta. Rem voluptas iure explicabo quisquam. Magni occaecati aperiam deserunt laborum cupiditate quae fuga ab. Inventore voluptatibus laboriosam architecto dolores cumque.\n\nPorro magni molestiae assumenda molestiae incidunt. Id omnis provident beatae repudiandae veniam maiores. Omnis necessitatibus mollitia voluptatibus. Vitae animi optio nam atque.\n\nCorporis quae eligendi omnis odit at minus repudiandae. Doloremque neque veniam eaque suscipit aspernatur perspiciatis. Alias quod eveniet ullam natus quos. Consectetur assumenda corrupti mollitia soluta modi odit doloribus. Ipsa molestias quasi doloremque beatae a laborum sint eaque.\n\nQui cumque unde deleniti non. Nostrum aspernatur quod perspiciatis rem. Amet corporis quia pariatur soluta nesciunt. At at architecto sequi incidunt autem beatae.\n\nConsequuntur totam eius aperiam dolores. Corporis blanditiis distinctio eum accusantium praesentium amet.	1.56	\N	2017-11-28 00:10:05.94053+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
19	Adams, Petty and George	Voluptate nulla tempore voluptatem blanditiis saepe. Architecto sit doloremque labore sit voluptatem facere. Hic neque esse vitae commodi omnis sint. Commodi a delectus amet fugit molestiae animi.\n\nQuae laboriosam hic laudantium commodi illum. Accusamus libero esse officiis saepe nulla corporis reprehenderit. Provident aspernatur modi rerum repellendus. Eius necessitatibus ducimus consequuntur aspernatur non.\n\nRerum accusantium est nesciunt optio. Culpa in earum ipsa magni perferendis nobis totam.\n\nVoluptatem officia et veniam commodi autem magnam distinctio. Quaerat ratione odio nostrum nulla itaque distinctio debitis. Sed ut officiis iure eligendi fugiat quidem mollitia. Fuga repudiandae magnam et est recusandae. Est deserunt ipsa iste molestias omnis.\n\nAliquam incidunt delectus molestiae deleniti sit labore cupiditate. Temporibus a natus numquam reiciendis sunt expedita esse. Nostrum ducimus facilis nisi molestiae recusandae cum.	96.18	\N	2017-11-22 20:26:55.020513+00	2	"3"=>"6"	t	t
115	Larson PLC	Aperiam non consequatur ad deleniti iure. Ab excepturi facere reiciendis delectus laborum minus aliquid. Alias et ut temporibus aliquam. Quia ad eius ipsam.\n\nSit eos ipsum iure fuga sit hic corporis. Magni nostrum inventore molestias iure ut ducimus quo.\n\nOmnis magni maiores eaque ducimus iusto vitae assumenda minus. Libero quae enim dolore dignissimos ab. Modi iure maiores itaque fugit quasi labore.\n\nPlaceat rerum vitae atque omnis alias deserunt eligendi. Adipisci illum repudiandae occaecati cumque quasi minus quos.\n\nQuo aspernatur non fugiat rerum placeat. Aliquid perferendis placeat dolores fuga. Incidunt ipsam eaque animi velit maiores consectetur.	11.58	\N	2017-11-27 23:21:09.364423+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	t	t
301	Huynh-Miller	Fuga officiis libero tempora. Unde voluptates ut non qui quo voluptatibus.\n\nEt exercitationem atque suscipit. Modi quis beatae dolores quis. Corrupti vel veritatis nemo asperiores eum odio magnam tenetur. Dolores quis incidunt optio deleniti.\n\nOmnis unde iure facilis repellendus beatae quibusdam sequi. Nostrum fugit iusto dolore aliquid vero dolor. Iusto eligendi explicabo dolorum assumenda in accusantium aliquid. Beatae possimus est delectus a similique soluta eligendi. Cupiditate facilis ipsam sed amet.\n\nConsectetur itaque hic vel nostrum. Repudiandae eos nemo excepturi at. Placeat numquam quibusdam suscipit veniam architecto perspiciatis. Id tenetur maiores optio excepturi.\n\nEnim quaerat nisi molestiae quis beatae error culpa nam. Iusto alias provident soluta fuga. Velit sit autem laboriosam corporis consequatur rem. Inventore sint sapiente omnis cumque ullam repellat. Unde optio sint ratione ipsum ipsa illum officiis recusandae.	77.27	\N	2017-12-02 22:21:07.514961+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
302	Rivers Inc	Natus assumenda ad ut sed quasi. Perferendis accusantium libero praesentium enim minus voluptatem error. Molestiae dicta quaerat quaerat pariatur. Minima blanditiis totam qui nesciunt veniam quia quis.\n\nExpedita iste magnam necessitatibus inventore totam suscipit. Quidem incidunt quaerat animi mollitia nobis beatae labore. Nam deleniti facere fugiat vero.\n\nQuia necessitatibus accusantium consequuntur distinctio enim nam magni. Inventore odio cumque vero laboriosam. Nam quasi itaque possimus consequatur sit soluta consequatur. Fugiat distinctio tenetur commodi.\n\nIpsa adipisci voluptatibus ipsa quae minus doloribus. Adipisci blanditiis voluptas voluptates quae. Iste praesentium laudantium animi consectetur iure non. Hic laudantium magni quis eum sed.\n\nVelit nihil ea iusto architecto voluptatem quam. Culpa sit saepe nostrum voluptatibus eaque rerum. Animi maxime provident placeat illo aliquid. Eius mollitia alias voluptatum id.	33.61	\N	2017-12-02 22:21:07.608328+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
303	Ferguson, Sanchez and Ellis	Perferendis incidunt itaque animi minima accusamus. Ut enim neque totam neque sapiente commodi. Fugit saepe atque quis quidem itaque quae aspernatur.\n\nAccusamus modi veritatis enim explicabo ipsam aperiam aliquid. Incidunt magnam est est odit.\n\nDolor corporis accusantium dolorum facere adipisci veritatis. Pariatur earum dolorem voluptatem quaerat unde. Occaecati pariatur et dolore illo.\n\nId quam necessitatibus porro quibusdam architecto fugiat. Dolorem iste voluptatibus eveniet sint iste tempore. Tempora pariatur sapiente minus rerum officia quasi repellendus. Maiores vitae debitis maiores deleniti consequatur placeat esse.\n\nQuasi deleniti autem facilis ex fuga quibusdam maxime. Ipsam dicta repudiandae reiciendis rerum dolor aliquid iure. Architecto optio beatae a.	23.40	\N	2017-12-02 22:21:07.64864+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
304	Valdez-Armstrong	Architecto dignissimos atque a doloremque deserunt soluta aliquam. Praesentium voluptates laborum dolorum reiciendis. Atque minus nobis cumque. Nobis dolorem quam quo suscipit.\n\nRatione facilis quod tempore praesentium. Necessitatibus nulla est debitis ea accusantium. Ducimus est minus perferendis eos est adipisci.\n\nImpedit sapiente cum fugit corrupti perspiciatis temporibus. Explicabo perspiciatis quisquam maxime illo suscipit. Est sit maiores laudantium voluptate culpa delectus laudantium.\n\nA qui officia at error recusandae. Fugiat perferendis doloremque deserunt cupiditate corrupti eligendi voluptatibus. Dolor repudiandae excepturi repudiandae delectus optio fugit mollitia.\n\nRepellat quisquam minima ea debitis repellat ab. Provident incidunt neque unde ducimus nisi. Reprehenderit ut accusamus earum delectus deserunt recusandae. Quae iure doloremque recusandae omnis excepturi eum eum.	20.22	\N	2017-12-02 22:21:07.703975+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
305	Fletcher-Wiley	Quae laboriosam quae nam quo rem amet sint. Cumque iure delectus mollitia nostrum dignissimos. Accusantium quod inventore magni maxime nisi sed recusandae.\n\nDeserunt amet hic magni maxime voluptates. Sit libero esse minima unde provident. Sapiente id velit minima et sint itaque dolore. Temporibus deleniti non vitae.\n\nSint tempora expedita natus officiis ducimus omnis. Aut recusandae deleniti ipsam enim asperiores sint.\n\nIpsa voluptatibus optio quam perspiciatis laboriosam corporis cumque. Dolore non qui rerum perferendis id aliquid.\n\nTenetur optio odit quasi eveniet soluta. Animi occaecati amet perferendis nulla quaerat fugit quibusdam. Consequuntur fugiat laboriosam laboriosam harum occaecati quisquam. Adipisci facilis occaecati autem aliquid magni eos.	7.13	\N	2017-12-02 22:21:07.754727+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
306	Clark-Carson	Nobis sequi veritatis rerum ipsam iusto porro officiis. Veritatis veniam in dolor blanditiis culpa iste ab. Nobis blanditiis assumenda doloribus id ab et. Ipsam voluptate pariatur facilis sapiente dignissimos optio distinctio cum.\n\nModi quis voluptatem aut ab dolor at. Laboriosam doloremque nulla doloribus nostrum dicta occaecati. Consectetur aut tenetur optio quasi deserunt vel ullam. Numquam amet vel vero rerum quo quibusdam ipsam.\n\nPorro nihil quam aut debitis dolor inventore. Sequi vel nihil cupiditate iusto nostrum. Exercitationem aut voluptatum voluptatum doloribus illo nemo. Perspiciatis quod repellendus incidunt.\n\nDucimus unde natus adipisci esse. Voluptatum magni enim vitae explicabo. Consectetur et dicta nemo aliquam eos omnis. Tempore aperiam iste soluta minus libero est tenetur.\n\nQuo modi pariatur temporibus. Distinctio repudiandae omnis illum ducimus quo quaerat. Officia nam ratione ipsa facere quae blanditiis autem. Ullam nulla maxime porro facere reiciendis suscipit accusantium.	60.16	\N	2017-12-02 22:21:07.808681+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
332	Pierce Ltd	Suscipit quas distinctio reprehenderit magni. Quasi adipisci corporis quidem enim explicabo aspernatur consequuntur. At recusandae iure neque nulla eos temporibus. Repellendus esse corrupti adipisci mollitia id sint porro.\n\nLaboriosam temporibus necessitatibus laboriosam ullam. Consequuntur repudiandae explicabo quis molestias labore. Culpa impedit consequuntur perferendis pariatur.\n\nPraesentium hic nobis laborum officia. Laborum commodi eligendi odit doloribus delectus nobis. Repellat deleniti molestias officiis iste nulla corrupti.\n\nEaque quibusdam aperiam voluptatum. Repellendus tenetur ratione nostrum molestias animi aut.\n\nNobis expedita et ratione maxime itaque libero beatae. Laborum unde soluta vero. Debitis sapiente nisi magni dolores illo dolores laboriosam.	18.81	\N	2017-12-02 22:21:08.734749+00	4	"3"=>"6", "7"=>"19"	f	t
307	Bennett-Clark	Adipisci amet omnis neque reprehenderit optio autem. Magnam corporis sequi culpa delectus. Quo ratione esse incidunt vero incidunt quidem.\n\nOptio ratione laboriosam nulla minus consequatur. Cum quidem impedit explicabo alias tempora. Pariatur iusto mollitia dolorem consequuntur libero distinctio. Veniam vero quas esse provident. Doloribus laboriosam saepe dicta mollitia quod.\n\nLaudantium optio nam laudantium laboriosam nisi quas dolor molestiae. Tempora iusto cupiditate ab eius. Molestiae minima veritatis eaque adipisci dolor explicabo. Dolores nihil inventore amet impedit dolorum sapiente.\n\nAdipisci optio totam quo debitis. Voluptatibus nihil minima accusamus vitae excepturi et. Quisquam nam dolorem soluta aperiam est magnam iste. Assumenda temporibus autem facere vitae.\n\nAssumenda reiciendis aliquid neque nostrum. Labore reprehenderit impedit placeat quas. Illo perferendis iure id qui non. Ab qui similique sequi fuga ex nam quae.	94.30	\N	2017-12-02 22:21:07.846732+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
309	Jones, Lawrence and Howard	Facilis nihil distinctio officiis odio. Nostrum odit perferendis unde commodi nulla possimus veniam nam. Doloribus quisquam aliquam natus ullam unde distinctio. Doloremque error quo nam consequatur.\n\nAb enim recusandae voluptatibus nulla voluptatem officiis ullam ad. Nobis expedita praesentium numquam error. Perferendis voluptas enim vel molestiae exercitationem.\n\nIure maiores quis earum dicta incidunt quisquam quas. Dolores labore reprehenderit culpa dolores distinctio aliquam reiciendis.\n\nExplicabo sed repellendus consequuntur. Quas libero cumque reiciendis tempore laboriosam hic tempora. Quidem molestiae fuga vero placeat non quas.\n\nMollitia beatae dicta quidem optio fuga asperiores. Molestias consequuntur dignissimos illo explicabo. Suscipit dicta magni officia blanditiis eaque. Nulla nisi accusamus ab voluptatibus amet.	88.55	\N	2017-12-02 22:21:07.952233+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
308	Lara-Nelson	Eius placeat hic sint debitis perspiciatis minus laboriosam. Atque quo sint asperiores. Soluta rerum temporibus dicta cupiditate dolorum repellat. Quibusdam ea repellendus totam illo facilis. Cupiditate fuga voluptate quis.\n\nOptio magni placeat occaecati odio pariatur. Quae fuga molestias fuga laboriosam temporibus quo. Laboriosam maxime quas eveniet ducimus nam qui eligendi. Ducimus enim vel voluptas. Laudantium asperiores deserunt quas ex sint aspernatur maxime.\n\nQuod ratione impedit nihil animi doloremque quibusdam omnis. Consequuntur doloremque unde qui.\n\nOfficiis corporis hic vitae quaerat dolor. Quis accusamus fugiat sapiente quae explicabo. Commodi ea rerum non officiis. Possimus nulla quaerat velit sapiente sequi facere velit.\n\nExplicabo atque tempore aperiam laudantium. Totam illum recusandae at esse quis. Neque animi recusandae laudantium alias vitae.	7.17	\N	2017-12-02 22:21:07.901012+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	t	t
311	Nelson-Jenkins	Quos enim quo amet labore sapiente at. Deserunt voluptatibus animi perferendis officia aliquam. Voluptatum qui fugit nostrum ad.\n\nMagnam blanditiis enim illum nostrum vitae. Assumenda inventore iste explicabo. Dolor culpa eos ab unde delectus officia. Velit illum alias rerum. Libero a tempora nesciunt iste.\n\nBlanditiis similique beatae et autem. Fugiat dicta iusto aliquam tenetur ratione. Voluptatum ipsum eaque suscipit. Modi illum officia ex nihil excepturi ab.\n\nAperiam fugiat minima dolorem recusandae. Dolorum temporibus non repudiandae facilis. Modi delectus repudiandae nemo facilis non architecto. Molestias eum veniam dolores aspernatur fugit.\n\nQuibusdam repellat expedita occaecati. Tempore nisi id dolores nemo doloremque totam. Libero quam eum repellendus ad neque. Impedit quaerat modi praesentium cum libero hic ducimus soluta. Distinctio delectus quisquam nostrum possimus possimus ea sapiente.	57.68	\N	2017-12-02 22:21:08.054851+00	2	"3"=>"6"	f	t
312	Atkins-Raymond	Provident eum dolorem quas. Saepe quibusdam animi quod neque. Provident a perferendis quod deleniti voluptate natus adipisci.\n\nOdio perspiciatis unde ipsa voluptates provident. Praesentium corrupti cupiditate natus.\n\nLabore nam labore asperiores ut. Temporibus animi tempora natus esse adipisci unde.\n\nNemo qui blanditiis minus possimus voluptatum. Maxime voluptatibus facilis totam sed. Sunt eos nemo quas quod animi. Quo voluptas illum illo nemo officiis. Quasi inventore minus earum nam distinctio nesciunt ab et.\n\nNostrum dignissimos magni voluptatem ipsum quibusdam. Repudiandae et eos unde ratione dolorum quod temporibus.	20.76	\N	2017-12-02 22:21:08.085502+00	2	"3"=>"6"	f	t
313	Moran LLC	Unde architecto eligendi at tempora quia. Quas non amet rerum nulla. Voluptatem molestiae blanditiis eveniet tempore error aliquid.\n\nVeniam est eveniet occaecati mollitia aperiam inventore eius vel. Quibusdam officiis accusamus ipsam ratione ea perferendis eligendi error. Recusandae ex culpa distinctio ipsam corporis. Architecto neque doloremque autem repudiandae harum explicabo.\n\nRepudiandae eius temporibus qui omnis quam praesentium optio. Laborum recusandae magni animi molestiae. Deleniti natus temporibus cum ad ut.\n\nIllum aut ipsum maxime nihil blanditiis neque. Quam enim impedit vel laboriosam fugiat molestiae. Doloribus vero et error aut doloribus voluptate. Iste molestiae eaque necessitatibus maiores.\n\nBlanditiis voluptate reprehenderit rem iste iste minima. Pariatur asperiores sapiente voluptatibus cum sit dolor. Sequi porro delectus unde iste omnis amet assumenda. Amet at voluptate voluptatem necessitatibus ullam quo quas.	61.32	\N	2017-12-02 22:21:08.123481+00	2	"3"=>"6"	f	t
310	Wright Ltd	Mollitia beatae ad rem quam occaecati quasi. Exercitationem temporibus sed numquam aut non nobis.\n\nConsequuntur adipisci vero adipisci quas accusantium dolorum accusantium. Autem nam excepturi ducimus numquam fuga occaecati. Ab et voluptatum optio dolores numquam laborum eligendi aliquid. Officiis reiciendis magnam tempore hic.\n\nPerspiciatis sapiente itaque consectetur rerum dolor facilis. Eaque atque ipsa veniam iure nostrum cumque. Tenetur fugit veniam earum eaque.\n\nNemo ullam aut ipsam eum voluptatem. Veritatis fuga itaque corporis numquam quod ipsum. Repudiandae eius perspiciatis ullam repudiandae labore id consectetur.\n\nSequi ut dolore ullam blanditiis atque reprehenderit. Eos delectus temporibus consequatur quibusdam magni exercitationem. Iure distinctio perspiciatis porro ullam asperiores assumenda.	17.15	\N	2017-12-02 22:21:07.999457+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	t	t
314	Anderson LLC	Incidunt occaecati eligendi sunt sequi deleniti. Accusantium cupiditate quos ducimus rem animi quos. Illo ea suscipit quod ipsa dolorum.\n\nIure totam beatae fugiat recusandae assumenda maiores. Sint in optio exercitationem facere molestiae nisi. Ratione quibusdam nesciunt quaerat odit aliquam. Laudantium illum totam repellat et ab est. Quos ipsa placeat natus suscipit illo.\n\nQuos recusandae fuga eius impedit. Commodi eum pariatur consectetur. At dicta ab ab commodi tempora est voluptate.\n\nRatione sequi pariatur quam dolorem. Sapiente quasi dolores consequatur labore unde aspernatur. Harum explicabo laboriosam ut suscipit natus numquam in. Eius ullam similique inventore fugit delectus. Harum eos assumenda aliquid maxime aperiam labore culpa facilis.\n\nExplicabo non enim culpa nihil unde dolor. Nesciunt quia adipisci omnis. Culpa earum accusamus corporis quae officia dignissimos. Quo earum quae nostrum dicta praesentium aperiam.	81.24	\N	2017-12-02 22:21:08.154711+00	2	"3"=>"6"	f	t
315	Beck-Kelly	Quasi earum velit ex occaecati quidem. Nisi delectus nemo voluptatum esse. Recusandae itaque harum accusantium ipsam nemo fuga. Voluptate suscipit dolore cumque aperiam. At eveniet natus natus numquam fugiat.\n\nAperiam odit impedit inventore ad assumenda rem. Pariatur cupiditate dolore recusandae voluptatem nobis at. Numquam voluptatum autem quasi asperiores. Quibusdam quibusdam error adipisci totam ab.\n\nOdio maiores architecto asperiores nihil. Enim suscipit illo illum. Quas fugiat laboriosam quidem quisquam. Ab at assumenda quas quae at sapiente itaque. Tenetur modi quaerat molestias ad repellendus itaque explicabo.\n\nQuam nesciunt eveniet suscipit at ea. Ratione occaecati sunt exercitationem accusantium minima.\n\nDucimus repudiandae nisi ratione earum asperiores. Assumenda pariatur voluptatum placeat corrupti nesciunt quos neque. Doloremque veritatis ad delectus unde eos iusto molestiae. Natus tenetur vel architecto error ipsum laborum.	5.97	\N	2017-12-02 22:21:08.188431+00	2	"3"=>"6"	f	t
316	Mack, Marshall and Young	Cupiditate eaque cupiditate ipsum blanditiis cumque eveniet. Accusantium officiis ea distinctio ab aliquam. Unde consequuntur veritatis reprehenderit tempore accusantium. Qui modi nisi ullam provident ex quos.\n\nDoloremque consectetur veritatis quod iusto tenetur dolorum id. Sed rerum magni dolorem at. Nostrum cupiditate temporibus reiciendis ratione ipsam omnis cumque.\n\nMollitia ipsam eligendi excepturi aliquam perspiciatis voluptates molestias. Vel culpa magnam non unde quaerat consectetur cum ut. Iure pariatur enim praesentium asperiores nulla.\n\nUt ipsa esse facilis eligendi. Iure culpa culpa itaque dolores atque consequuntur. Accusantium commodi deserunt fugit eum. Architecto ad praesentium velit sint.\n\nQuae velit consectetur tempore inventore inventore recusandae est. Repellat commodi sapiente aspernatur asperiores atque quisquam dicta. Quod totam est sit ab quos iure maxime debitis. At ea vero quos quibusdam quia quisquam magni fugiat.	14.78	\N	2017-12-02 22:21:08.224636+00	2	"3"=>"6"	f	t
317	Leonard-Marshall	Eveniet debitis iure exercitationem animi eum delectus provident at. Sapiente aliquid laudantium quod repellat quisquam dignissimos esse. Libero nesciunt aperiam doloremque repellendus nostrum debitis veritatis aliquam.\n\nDolor numquam voluptatibus doloribus aliquam. Nisi commodi asperiores saepe atque minus quas.\n\nConsequuntur voluptatum impedit vero dolore. Dicta voluptatem similique aliquid enim expedita dignissimos consequuntur. Voluptatum doloribus ex optio deserunt.\n\nMolestias porro quod labore asperiores nostrum ratione. Pariatur nobis earum asperiores sunt reiciendis. Rem sed odio commodi veniam. Aliquid sunt iure esse accusantium minus unde.\n\nIpsam ex magnam assumenda eos optio eum. Qui optio labore facere eos. Tempora molestias occaecati laboriosam qui saepe.	1.20	\N	2017-12-02 22:21:08.249252+00	2	"3"=>"6"	f	t
333	Santos Ltd	Maiores quam possimus nobis excepturi numquam. Maxime architecto non aspernatur in quas id magnam. Dolores placeat praesentium totam maiores. Vitae explicabo esse molestias.\n\nVoluptatum aut quidem eligendi aut. Vitae optio commodi nesciunt perspiciatis non. Consequatur iusto minus tempora nesciunt quis molestias. Quae accusantium facilis porro quibusdam distinctio id. Recusandae incidunt ipsam consequuntur.\n\nQuaerat accusantium molestias autem tempore architecto. Et sint explicabo ullam. Veritatis eligendi quaerat sapiente sunt inventore nesciunt. Nemo commodi sequi odit cum.\n\nCupiditate itaque officiis hic quisquam ea culpa. Nobis officia recusandae quas nisi. Dolor quidem impedit expedita quaerat. Qui cupiditate expedita qui praesentium soluta modi.\n\nNemo ipsa necessitatibus numquam non ab necessitatibus. Itaque hic enim autem illum quisquam sapiente blanditiis consectetur. Dolorem dolorum vero atque perspiciatis et possimus. Laudantium commodi eligendi labore quidem similique.	72.91	\N	2017-12-02 22:21:08.781879+00	4	"3"=>"6", "7"=>"19"	f	t
334	Mendoza Ltd	Minima saepe totam dolores corrupti facilis officiis accusamus. Possimus sed sed odit. Voluptas architecto adipisci inventore dolor praesentium illo accusamus quos. Voluptates similique at laborum nobis impedit minima.\n\nVoluptates cum necessitatibus voluptatum aperiam numquam. Ratione dolore nam iure minima aspernatur. Repellat esse impedit nam reprehenderit. Magnam ex labore iure iure quo ipsum.\n\nPerferendis qui ipsa cum soluta earum asperiores dolores. Consequatur amet quis doloremque ratione doloremque quo. Soluta natus veniam eius cumque.\n\nImpedit ad possimus nisi reiciendis perspiciatis. Ea perferendis ab vero distinctio. Eaque atque sapiente voluptatibus voluptate ipsa reprehenderit suscipit. Laborum aperiam veniam dolor cupiditate animi aspernatur.\n\nIpsam hic eaque fugiat corporis quas alias sapiente. Voluptatum debitis dolores corporis quia fugit. Suscipit consequatur nostrum pariatur iste hic iusto. Illo ipsam labore sequi autem eligendi sequi illum. Perferendis voluptate recusandae quos culpa possimus voluptate.	86.73	\N	2017-12-02 22:21:08.825813+00	4	"3"=>"6", "7"=>"19"	f	t
335	Chavez and Sons	Quae magni et saepe culpa accusantium illum. Mollitia autem dolor fugit. Quaerat sunt in necessitatibus officia quia soluta.\n\nNumquam delectus facere perspiciatis quos. Architecto consequatur quas cumque impedit cum facilis cupiditate. Sequi hic vitae et voluptate itaque sequi quos. Praesentium quam minus quasi odit.\n\nArchitecto veritatis repellat id illum dolorum. Mollitia est aliquid quaerat dolorum distinctio sit non. Esse repellat et tenetur placeat nam ab odit. Quo ut nam nemo dolor.\n\nLabore nulla laboriosam sed consequuntur. Dignissimos minima cumque eveniet similique neque expedita minus.\n\nTempore ut asperiores sit voluptatum sapiente odit exercitationem. Tempore occaecati praesentium reiciendis quidem inventore nostrum. Dicta deleniti quae commodi numquam.	14.36	\N	2017-12-02 22:21:08.918937+00	4	"3"=>"6", "7"=>"19"	f	t
386	Cox-Barajas	Deserunt beatae nesciunt ratione inventore. Veniam ducimus temporibus provident magnam. Quidem similique quas nihil aspernatur.\n\nIn animi hic reprehenderit. Debitis modi ipsum officiis non adipisci. Nemo optio eos pariatur labore iusto. Corrupti minima ipsum perspiciatis amet magnam.\n\nLabore aliquid odio itaque cumque corrupti maiores quae sequi. Nostrum velit beatae repellendus rerum similique. Quos ad totam ipsam excepturi sed beatae. Enim totam ab inventore.\n\nA blanditiis totam alias rem sint repellat quam hic. Asperiores alias soluta maxime necessitatibus earum. Voluptas doloremque quibusdam tempore quia perspiciatis.\n\nSaepe dignissimos animi perferendis deserunt maxime similique quasi cum. Inventore corporis dolores rerum iure labore id repudiandae. Sint odit vel occaecati cum tempore hic.	23.99	\N	2017-12-02 22:51:34.692716+00	3	"3"=>"6", "5"=>"14"	f	t
319	Kirby and Sons	Voluptate amet asperiores quibusdam aperiam. Architecto autem at possimus explicabo suscipit ut laudantium.\n\nEsse tenetur voluptatem fugiat perspiciatis saepe inventore modi. Rerum explicabo magni eos veritatis. Optio unde exercitationem impedit. Recusandae qui animi porro repellat neque porro nisi.\n\nNulla modi quia odit nemo. Nisi praesentium eum provident inventore minima molestiae inventore vero. Autem laboriosam quidem suscipit eligendi. Accusamus alias ut iure assumenda dignissimos nemo saepe.\n\nEst fugit perferendis unde animi magni repellendus. Aut rerum eos autem. In hic facilis sit doloribus voluptas. Impedit quaerat sit a non dolore vitae neque.\n\nAnimi ad laborum asperiores distinctio optio. Dicta sapiente explicabo beatae. Sed maxime alias quidem iure exercitationem tenetur autem cupiditate.	60.17	\N	2017-12-02 22:21:08.291133+00	2	"3"=>"6"	f	t
320	Lee, Parker and Garcia	Voluptatibus aut atque atque consequatur dolores accusamus eligendi. Praesentium quia consequuntur ea. Adipisci dolorum quos enim. Magni laboriosam deleniti tenetur.\n\nVelit quae tenetur mollitia aut provident. Inventore a quas deleniti illum eos ea minus similique. Praesentium quaerat numquam nisi consectetur voluptatem eveniet beatae nostrum. Neque corrupti provident architecto dolorem nisi quis accusamus.\n\nHic repellendus maxime quod sint alias quisquam temporibus. Alias impedit quam doloremque minima. A ratione officia voluptatem nisi qui.\n\nNumquam in cupiditate corporis quae officiis rerum sit. Saepe harum dolorum molestias aliquid facere natus voluptates.\n\nConsequuntur officia dolorum assumenda. Nostrum in possimus commodi molestias. Eum ullam ut impedit provident corporis sit.	80.11	\N	2017-12-02 22:21:08.308059+00	2	"3"=>"6"	f	t
321	Young PLC	Voluptate sunt distinctio nam. Totam explicabo eaque rem vel. Laboriosam iure eligendi laudantium quae sit sunt. Incidunt earum quam veritatis natus qui error perferendis.\n\nNihil sint beatae dolore atque corporis recusandae quos. Dignissimos debitis ipsum molestias animi qui accusantium cumque aliquid. Unde at explicabo illo ea dolores cumque.\n\nAliquam exercitationem vitae ratione deserunt. Nam facilis provident amet exercitationem sint. Odio voluptas mollitia nemo magnam excepturi a consequatur. Quo tempora dolorum in amet tempora deserunt quis.\n\nNihil rerum assumenda aspernatur sunt. Illo magnam eaque illo a quasi sint ut. Saepe iusto libero laudantium ea tempore expedita excepturi. Deleniti necessitatibus nulla vel aperiam odio quod saepe.\n\nAlias eius eaque laboriosam. Quisquam ipsum velit doloribus rerum temporibus dignissimos vero explicabo. Soluta reprehenderit repellendus nam tenetur dolores ducimus ratione. Alias culpa similique ut.	95.11	\N	2017-12-02 22:21:08.335514+00	3	"3"=>"6", "5"=>"13"	f	t
322	Perez, Robertson and Reynolds	Similique adipisci quisquam recusandae placeat ex quam occaecati. Harum repellendus accusantium alias ratione natus asperiores.\n\nRepellendus ullam enim maiores aut vero. Doloribus beatae aperiam et. Magni repellat incidunt iusto quidem. Voluptates suscipit dicta eaque adipisci.\n\nAccusantium eius non debitis doloremque suscipit magni. Fugiat nisi ea molestiae ipsam expedita a. Iure laboriosam eos rem.\n\nIllo ipsum eum nostrum est minima error. Deleniti error sit quis officia ducimus iure reiciendis quia. Doloribus omnis illo possimus accusantium eligendi magnam eius.\n\nUllam dignissimos alias deleniti. Vel nihil dolore ducimus dicta. Amet delectus fuga eos similique. Ducimus magni pariatur velit facere minima.	75.16	\N	2017-12-02 22:21:08.369998+00	3	"3"=>"6", "5"=>"13"	f	t
323	Anderson Inc	Maxime alias aspernatur id odio vitae delectus dolor quas. Corrupti exercitationem eum numquam quo illum non. Tenetur quaerat quasi accusantium id eligendi perspiciatis. Porro odit eveniet ut molestias. In fugit eum quae porro.\n\nVoluptatem rerum soluta iste eos. Eius quasi nihil impedit alias aliquid blanditiis laboriosam. Ut explicabo vel eum voluptates dignissimos officia doloribus. Perspiciatis sed facere soluta.\n\nSaepe nisi est aliquid possimus fugit. Asperiores nihil aspernatur deleniti atque sed quidem. Unde minima possimus ex quam. Sint cum sapiente voluptas quisquam error laudantium.\n\nMagnam culpa repellendus magni sint temporibus. Voluptatibus temporibus aut aperiam praesentium esse praesentium minus aliquam. At quam minus molestias illum fugiat ut culpa.\n\nAd amet doloribus culpa explicabo facere optio aperiam. Magni consequatur suscipit voluptas neque voluptates. Libero aliquid explicabo vel ipsa odit nobis reprehenderit amet. Iste eveniet rem est aspernatur labore voluptatum.	62.83	\N	2017-12-02 22:21:08.412023+00	3	"3"=>"6", "5"=>"13"	f	t
324	Thomas, Finley and Chavez	Totam qui a rerum quas. Fugiat porro explicabo laudantium totam inventore. Blanditiis distinctio fuga quas architecto labore. Architecto autem doloremque aperiam eveniet vel aut repellendus modi.\n\nAutem voluptates quaerat inventore occaecati voluptate quaerat molestiae. Voluptatum quae at blanditiis dolores maxime aut. Quibusdam cumque odit autem inventore iusto temporibus nesciunt ex. Asperiores ipsam totam nemo praesentium nam.\n\nQuod doloremque maxime sapiente dolorem. Totam rerum tenetur odio error. Eos nemo reiciendis expedita earum. Ipsum eum voluptatibus excepturi.\n\nDistinctio praesentium amet exercitationem culpa nihil soluta esse. Molestiae et praesentium ipsum aut. Autem pariatur ad adipisci in aliquid nisi.\n\nExercitationem fugit odio beatae quia quam perspiciatis quod. Numquam aperiam eveniet qui. Rerum magni facilis velit occaecati asperiores odio provident qui.	10.40	\N	2017-12-02 22:21:08.441455+00	3	"3"=>"6", "5"=>"13"	f	t
325	Berry Group	Excepturi excepturi ipsum voluptatum. Illo veritatis possimus perspiciatis impedit praesentium. Facere tempore blanditiis ex facilis quas. Numquam tempora voluptate neque culpa dolores reiciendis alias.\n\nConsequuntur necessitatibus consequuntur repellendus nobis maxime dolore. Minus perspiciatis perferendis totam ratione quae illum esse quibusdam. Deserunt qui repellat laborum deleniti et. Corporis tenetur cum dicta aperiam. Quam deleniti voluptatibus dignissimos dolore veniam eius culpa nesciunt.\n\nQuod officiis esse ducimus velit in pariatur. Hic facere reprehenderit autem eveniet error inventore laborum. Placeat totam consequuntur laboriosam maxime possimus. Amet unde quas doloremque eius veritatis dolorem amet consequuntur.\n\nPossimus voluptate occaecati porro magni. Est fuga iste eos quasi. Expedita mollitia temporibus iure odio.\n\nAsperiores cupiditate distinctio accusantium. Id voluptates minus inventore quis. Quae voluptatem impedit architecto ipsa molestias. Quasi quidem debitis sint cum dolores rem sed.	35.21	\N	2017-12-02 22:21:08.475645+00	3	"3"=>"6", "5"=>"14"	f	t
326	Russell and Sons	Tenetur hic quae perspiciatis odio ullam architecto quis. Odio quas ducimus ex enim fuga corrupti sint quam. Vero dignissimos praesentium dolorem atque sed earum nesciunt.\n\nVoluptate deserunt soluta veniam voluptas. Corporis architecto exercitationem repudiandae veritatis ex.\n\nIpsa illum cumque incidunt ab eligendi corrupti tempore. Officiis consequatur placeat saepe dolores. Aperiam voluptatem consequuntur expedita. Assumenda placeat natus libero reiciendis rem voluptatibus ex.\n\nTotam neque nulla praesentium expedita ut. Odit sequi sunt in libero.\n\nAccusamus est voluptatum placeat quae alias aperiam. Dicta rem non nesciunt cum minus sunt consectetur. Quia a similique excepturi magnam minus. Qui error nulla in laudantium accusamus.	65.71	\N	2017-12-02 22:21:08.503914+00	3	"3"=>"6", "5"=>"13"	f	t
327	Butler-Walters	Dolores voluptate voluptates tenetur. Temporibus modi itaque libero harum maxime eius inventore.\n\nRepellat quisquam architecto fugit ipsam quidem beatae dignissimos laborum. Sequi perspiciatis voluptatibus molestias atque voluptatem id inventore voluptatem. Odio voluptatibus cumque laboriosam quibusdam iste quidem voluptatum provident.\n\nOfficiis eius ex provident quia et soluta. Quidem aspernatur illum dicta accusantium nisi quidem iste.\n\nPariatur animi ratione voluptatibus doloribus nemo dignissimos error. Qui veritatis nostrum quam illum ipsam architecto omnis. Aliquam molestias odio ullam minus. Officia cumque placeat adipisci eius.\n\nArchitecto excepturi ipsa aliquid veritatis. Dolores itaque qui voluptatem esse perspiciatis. Eius dicta animi dolore cumque. Voluptatum porro dicta quo officia corporis dolorem quo.	33.52	\N	2017-12-02 22:21:08.546606+00	3	"3"=>"6", "5"=>"13"	f	t
328	Cooper, Munoz and Robinson	Minima nesciunt ab vitae consequuntur at quo. Aperiam repellendus laboriosam id eligendi eius ea illo. Fugit ducimus vero id rem deleniti beatae aperiam. Voluptates nobis facilis deserunt labore laboriosam id soluta.\n\nExpedita provident rerum repellat exercitationem ipsam maiores. Quaerat praesentium minima iusto sapiente officiis neque natus fuga. Natus adipisci debitis et temporibus nihil occaecati.\n\nIusto quo nihil dolorum dolores sunt repellat neque. Dolor doloremque at repudiandae. Beatae voluptate aut laborum dicta minus numquam suscipit. Sed repellat voluptates cupiditate mollitia perspiciatis iusto.\n\nNostrum nulla cum repellendus odit debitis rem qui. Architecto aliquam pariatur quia voluptas. Suscipit repellendus itaque illum maiores vitae quaerat. Impedit reiciendis in beatae dignissimos architecto sint architecto.\n\nQuas enim in deserunt quo cum fuga. Deserunt hic commodi ipsa modi. Laboriosam quo quas explicabo quis temporibus modi.	59.72	\N	2017-12-02 22:21:08.590994+00	3	"3"=>"6", "5"=>"14"	f	t
329	Frazier LLC	Harum distinctio quae quas similique. Laudantium saepe fuga nisi optio officia reprehenderit. Non eos accusantium id voluptatem.\n\nUllam qui quos neque vitae. Aliquid accusamus rerum beatae provident repudiandae quas cum ab. Eligendi vel temporibus quod in harum asperiores. Omnis quae nostrum reprehenderit.\n\nInventore commodi sint sed aut. Nostrum aperiam animi quidem cumque labore minima. Labore nulla reiciendis alias odio. Assumenda ab illo perspiciatis accusantium nemo esse dolorum.\n\nMinima molestiae unde perferendis doloremque suscipit praesentium maiores. Dolore at repellendus officia animi. Earum reiciendis fugiat explicabo dicta quos hic.\n\nIpsam deserunt eaque quod ex a dignissimos. Optio praesentium illo neque et corrupti officiis recusandae. Placeat sint mollitia nulla ipsam officia eum laboriosam eum. Cupiditate possimus labore aliquid dolore quae.	53.30	\N	2017-12-02 22:21:08.62636+00	3	"3"=>"6", "5"=>"13"	f	t
330	Phillips-Hall	Maiores minus dolorum eius. Nam natus quia dolores iste. In distinctio iste voluptate deserunt sed adipisci deleniti. Nam adipisci mollitia eius qui.\n\nQuos expedita ducimus commodi eaque quam quibusdam natus. Beatae esse provident nostrum esse ullam nam neque. Voluptatem itaque fuga qui sed.\n\nEius ea delectus nesciunt harum saepe animi. Animi tenetur iste mollitia. Harum blanditiis quod minus hic voluptatem quasi. Illo saepe accusamus ab accusantium ad. Consequatur dignissimos esse quo voluptates quis a.\n\nSit molestiae praesentium corrupti. Eaque incidunt labore ducimus quos odit. Nam autem laborum rem aperiam blanditiis fugit iure. Aspernatur necessitatibus pariatur labore tempora.\n\nPariatur ullam fuga veniam voluptatibus asperiores fugit. Aspernatur placeat quos molestias tempore optio. Sed non excepturi eveniet vitae assumenda.	41.42	\N	2017-12-02 22:21:08.663988+00	3	"3"=>"6", "5"=>"14"	f	t
331	Lara PLC	Dolorem facilis qui magnam fugit. Temporibus laboriosam eum iste magni excepturi. Quam aspernatur inventore tenetur fugit quisquam quam reiciendis quasi.\n\nSaepe error atque facilis nostrum. Tempore possimus vel porro quia harum. Sint voluptatibus impedit placeat distinctio.\n\nDolore optio sed labore ullam. Laudantium saepe placeat saepe adipisci quo vel dolore ipsam. Nostrum atque accusantium amet. Dolor cumque iste harum maiores dolore atque quae quis.\n\nMagnam a commodi rerum debitis nisi dolorum. Adipisci consectetur saepe ad voluptate veritatis et dicta. Est nobis repellendus impedit voluptates officiis. Excepturi at rerum occaecati dicta.\n\nQuas minima officia quidem aperiam reiciendis magnam nemo. Quidem optio sed quod in vero animi. Magnam repellendus cupiditate corrupti consequatur facere nulla sunt.	60.70	\N	2017-12-02 22:21:08.702538+00	4	"3"=>"6", "7"=>"20"	f	t
336	Flores-Sherman	Tempora nobis assumenda assumenda. Accusantium consequatur iure vel velit. Repudiandae molestiae recusandae architecto iure quidem fugiat ad quae. Quibusdam veniam culpa minus facere occaecati necessitatibus consectetur.\n\nFugiat voluptatum numquam itaque nulla. Quaerat excepturi sit expedita laboriosam commodi iure. Praesentium saepe blanditiis dolores debitis dolorem commodi repellendus.\n\nDoloribus nobis cupiditate laudantium autem quae aliquid ab ipsum. Natus quod voluptate deleniti et nesciunt. Officiis optio atque et perferendis laudantium minima recusandae.\n\nOfficiis officiis veniam fugit labore. Magnam itaque id eaque dignissimos amet sint. Consectetur dolore ipsam quod alias cumque itaque rerum. Beatae nihil fugiat odit sequi praesentium numquam minima.\n\nDeserunt tempora saepe placeat placeat vitae laboriosam. Eius facere dolores saepe tempore maiores officia nemo. Cumque distinctio molestias sint commodi nesciunt.	48.23	\N	2017-12-02 22:21:08.953901+00	4	"3"=>"6", "7"=>"20"	f	t
337	Collins Ltd	Iste inventore fugiat cumque atque. Totam temporibus impedit hic nobis numquam. Architecto omnis autem aliquid laboriosam atque. Nulla nulla quisquam ipsum at quibusdam.\n\nTempora doloribus est perferendis cupiditate saepe. Facere incidunt asperiores atque voluptatum minus rerum architecto. Quisquam illo nulla nobis amet. Nisi neque ullam quod asperiores animi consequatur.\n\nFugit occaecati architecto laboriosam quibusdam. Consequatur magnam ipsum numquam sint et. Dicta doloremque cupiditate assumenda esse laudantium atque magnam deserunt.\n\nTotam quos odit error aperiam nisi. Atque id tempora eos sit libero perferendis esse.\n\nExplicabo earum consequatur officia ab deleniti a. Maiores repellat nam mollitia amet. Occaecati libero praesentium fugit officiis modi labore ducimus.	70.88	\N	2017-12-02 22:21:08.986489+00	4	"3"=>"6", "7"=>"19"	f	t
338	Jones, Allen and Dalton	Quasi provident voluptatum ipsa. Cumque ab itaque quod sapiente iusto quas repellendus. Totam doloremque quasi aut eligendi at tenetur iste.\n\nA fugiat suscipit provident expedita assumenda consequuntur nulla. Eaque rem dolore minima deleniti minima. Voluptates odio quidem exercitationem provident earum. Eaque cupiditate minima est labore molestiae.\n\nUnde sunt aspernatur ullam veniam eius praesentium optio. Nulla dolorem adipisci harum earum expedita sed commodi ratione. Blanditiis magnam aperiam quo similique.\n\nNisi doloremque corrupti mollitia soluta hic consequuntur sint. Consequatur qui quaerat beatae ullam sed reprehenderit amet aliquam. Omnis nobis rerum nobis suscipit. Laudantium odio aperiam adipisci quam odit fuga aperiam.\n\nNostrum autem consectetur autem maxime. Eveniet commodi velit at repellat odit earum fugiat. Sequi voluptatibus at ullam impedit tempore quam atque. Ad sequi ad soluta modi nostrum odit. Doloribus enim quibusdam laudantium alias odit recusandae animi reiciendis.	48.77	\N	2017-12-02 22:21:09.030043+00	4	"3"=>"6", "7"=>"20"	f	t
339	Walker, Wilson and Martinez	Fugit accusantium fuga saepe incidunt quidem. Est eligendi laboriosam soluta ex. Itaque ipsam sit veniam animi. Modi optio accusantium mollitia natus.\n\nSed et ipsam aliquid cumque odio. Molestias commodi aut voluptatem dolorum laboriosam.\n\nVeritatis voluptates rerum nemo totam est deserunt autem. Velit iusto repellendus placeat impedit. Dolor adipisci suscipit quia cumque quasi.\n\nVoluptatem rem quis odit accusamus beatae provident doloribus. Quia dolore nostrum quo. Optio accusantium sapiente occaecati dolores nesciunt vel facere. Impedit inventore molestiae eum nobis ad quae perferendis harum.\n\nSoluta minima ut dolore laborum autem deleniti ipsum. Architecto nisi accusantium reiciendis vel. Veniam voluptatibus asperiores provident. Repudiandae tempora quo architecto cum quasi eos. Odio corporis delectus quibusdam tenetur.	47.60	\N	2017-12-02 22:21:09.061714+00	4	"3"=>"6", "7"=>"19"	f	t
340	Davis-Moss	Delectus saepe aliquid impedit et architecto. Quo maiores blanditiis tempore eius. At temporibus a debitis aliquid temporibus. Esse officia sequi veniam totam eius aspernatur aspernatur.\n\nFacilis quibusdam non sint exercitationem. Modi voluptatum voluptate voluptate nulla et libero minima. Minima totam sint nobis et labore debitis in. Nam animi velit at impedit.\n\nIncidunt repellendus rerum nesciunt vero odio a. Ab cum necessitatibus suscipit enim possimus. Illo suscipit eveniet corporis soluta eum quas. Perferendis a veritatis natus nesciunt rerum dolore.\n\nAmet in aperiam ab. Sapiente voluptatum corrupti voluptatibus quod exercitationem natus. Corrupti eos vero officiis porro accusamus vel. Deleniti veniam rerum molestiae iure dolor voluptatum atque voluptatum.\n\nQuis quas dignissimos animi cum vero explicabo. Ad nemo ratione molestias est. Eligendi quam asperiores quia assumenda dicta cum mollitia. Error modi soluta quis distinctio veniam debitis.	32.90	\N	2017-12-02 22:21:09.104429+00	4	"3"=>"6", "7"=>"20"	f	t
341	Barnes and Sons	Repellat cupiditate excepturi blanditiis quam. Aperiam quam repellat beatae voluptate id adipisci molestias. Harum commodi dolor occaecati.\n\nSit odit neque ipsum dignissimos impedit quo. Eveniet facere amet ipsa odit natus laborum deserunt. Fugiat eum adipisci ut ea magni laudantium nulla. Minus ullam alias mollitia incidunt perspiciatis.\n\nAd et veritatis tenetur pariatur nesciunt. Facilis facere recusandae doloribus repellat porro deserunt in. Dicta doloremque dolore expedita necessitatibus.\n\nExpedita ullam animi nobis possimus. Sed nihil cupiditate sequi aliquid sequi. Deleniti nemo a eius nihil possimus nihil. Laboriosam quae fugit maxime natus illo explicabo optio. Ea corrupti corrupti quasi quae veritatis perferendis.\n\nQuidem explicabo ducimus recusandae quod dolores officiis distinctio. Aut aperiam veritatis dolores odio cum.	35.13	\N	2017-12-02 22:21:09.141025+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
342	Espinoza, Stewart and Garcia	Rerum laboriosam fuga corporis facere a quidem blanditiis. Quia quidem fuga ab fugit eveniet inventore. Fugit dolores corrupti maxime maiores in.\n\nDolore accusamus hic incidunt perferendis quaerat. Doloremque et perferendis ab ipsum porro fuga. Odit totam deserunt mollitia et explicabo praesentium aspernatur ipsam. Nostrum tenetur eveniet maxime ea.\n\nVeritatis nihil rerum adipisci natus. Magnam mollitia nam quibusdam. Nesciunt quidem voluptatum nemo explicabo fugiat repellendus recusandae.\n\nFuga corrupti numquam placeat sed incidunt voluptatibus. Culpa expedita impedit veritatis modi fugiat officiis est. Sint accusamus suscipit quis aperiam.\n\nQuas quasi perspiciatis quam necessitatibus cumque quae. Accusantium cumque officia incidunt autem omnis. Quia occaecati debitis sunt. Temporibus id dignissimos quas natus dicta dolorem placeat.	34.89	\N	2017-12-02 22:21:09.186478+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
343	Garrett-Turner	Corrupti iure ex expedita rem eos. Expedita neque fuga temporibus. Ut laboriosam excepturi incidunt modi vel illo.\n\nReiciendis nobis quae est iusto. Tempora maxime tempora temporibus dolores incidunt dolorem sed. Fugit dolorum eius quasi ea doloribus.\n\nBlanditiis officiis a iste ipsam consequuntur adipisci eius officiis. Velit corrupti cum cupiditate earum enim cupiditate mollitia iusto. Aperiam porro error doloribus suscipit iusto.\n\nSuscipit quo perferendis nesciunt accusantium. Labore labore fugiat ab cum tempore exercitationem. Dignissimos consequatur deleniti ipsum adipisci illo eos. Fugiat deleniti optio sit ea in quod repudiandae.\n\nBlanditiis odit non quis doloremque exercitationem modi. Incidunt aliquam eligendi harum laudantium ducimus quas. Laboriosam voluptatem voluptatum itaque sit labore. Non aliquam assumenda ducimus iusto veritatis.	80.92	\N	2017-12-02 22:21:09.229482+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
344	Young PLC	Sunt fugiat quaerat a nisi minus numquam. Quibusdam officiis aliquid aperiam laudantium. Eius sequi sit dolor dolorem. Nostrum voluptate pariatur corrupti ipsum mollitia quaerat laboriosam omnis.\n\nIncidunt ipsam vel sequi quasi sequi cumque vero nulla. Non facilis labore minus earum unde porro iusto non.\n\nOptio incidunt id deleniti debitis error tempore ut. Amet magni magni fugiat maiores praesentium in distinctio laudantium. Maiores nulla inventore laborum suscipit voluptatem dicta.\n\nPossimus pariatur totam sapiente odio est. Rem ad quaerat impedit ex. Quae tempora earum atque itaque officia blanditiis deleniti asperiores. Necessitatibus sed ullam molestiae beatae exercitationem.\n\nTempore ducimus consectetur ipsam voluptates rerum. Modi laborum aspernatur quis magnam assumenda. Placeat esse minus dolorum quo.	32.94	\N	2017-12-02 22:21:09.278937+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
345	Rodriguez-White	Minus deleniti fugiat ducimus vel. Recusandae ducimus hic ad delectus. Quaerat corrupti magni mollitia cum voluptates modi nesciunt.\n\nNam eum at quam assumenda minus recusandae. Fuga eum error ducimus totam iure. Modi aut ratione atque aperiam quos.\n\nModi quas asperiores ipsum doloribus. Libero doloremque accusantium repellendus fuga. Sit beatae voluptate accusantium quas ratione asperiores fugit.\n\nAperiam debitis consectetur commodi occaecati rerum. Recusandae sed sapiente placeat officiis. Labore excepturi hic eius consequuntur. Delectus tenetur amet omnis aperiam dolorem iste deserunt.\n\nIste nesciunt labore et nostrum. Saepe pariatur animi iusto quasi. Deserunt sit beatae itaque fugiat veritatis sunt eius. Ut at aliquid ab illo tempore ea ad.	86.86	\N	2017-12-02 22:21:09.319442+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
346	Conway-Potter	Sapiente vel ut itaque et. Inventore placeat consequuntur rem quos repudiandae. Delectus sequi incidunt fugiat odit quia est nihil libero. In sit beatae repellat officiis facere culpa ex.\n\nUt id expedita similique laborum minima laborum possimus commodi. Sapiente explicabo dolore unde cum. Eius magnam necessitatibus eius vero consequuntur dolorem.\n\nFacilis assumenda laboriosam reprehenderit laudantium explicabo. Rerum architecto voluptas deserunt nemo. Veritatis voluptatem maiores delectus. Totam fugit nostrum illum fugiat aperiam quia illum.\n\nRepudiandae dolores in et ipsa. Nobis magni nobis commodi cumque. Est veritatis vitae vitae omnis excepturi perferendis nihil.\n\nVero sequi corporis quod. Omnis nam laboriosam laboriosam sint. Excepturi sint libero nesciunt deleniti eos voluptatum.	67.89	\N	2017-12-02 22:21:09.35868+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
347	Turner, Romero and Mills	Nobis laboriosam debitis unde ducimus. Harum impedit nihil doloribus natus. Culpa in possimus necessitatibus dolorum placeat aliquid fugiat alias.\n\nOfficia explicabo recusandae dolorum similique delectus soluta sunt. Explicabo minus sint eligendi non. Sit doloribus doloremque illum quos provident temporibus. Dolores corrupti nulla maiores dolorum nobis eligendi. Nulla qui quis velit iste natus.\n\nVoluptate eligendi deleniti impedit id. Incidunt velit cupiditate accusantium voluptates cupiditate cumque. Perspiciatis eligendi vitae sapiente incidunt. Consequatur maxime necessitatibus molestiae soluta ullam aliquid harum.\n\nSint minus dolorem sapiente totam voluptates suscipit maxime. Error dolor laudantium quaerat error architecto inventore veritatis minima. Eligendi excepturi quos qui suscipit. Exercitationem vitae in recusandae ea aspernatur.\n\nIpsam laboriosam quisquam modi rem enim repudiandae provident. Dicta nam inventore corrupti quisquam vero magni. Veniam tenetur natus quidem veniam.	28.59	\N	2017-12-02 22:21:09.405489+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
348	Drake-White	Qui facere magni praesentium autem. Debitis natus natus accusamus corrupti illo iure sint. Voluptas magni unde delectus. Autem alias expedita expedita similique incidunt dicta.\n\nAliquam vero pariatur in consectetur ullam. Amet eius suscipit voluptates ducimus omnis exercitationem rem. Officia perferendis suscipit explicabo iure.\n\nVoluptas dolor autem dolores. Laudantium quia qui enim blanditiis iste qui adipisci excepturi. Deleniti dolore labore exercitationem exercitationem. Illum omnis numquam ullam odit nulla.\n\nAperiam ut corrupti eius consequatur. Dolore vero hic ad dolores facilis minus. Eveniet vitae perspiciatis quod labore explicabo eum. Magnam nam sint ea sit aliquam error.\n\nSit placeat est illo modi nobis. Veniam quidem temporibus dolores laboriosam. Fugit distinctio unde officia ex facere nam officia. Eius expedita amet blanditiis repudiandae perferendis.	5.37	\N	2017-12-02 22:21:09.43688+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
349	Johnson, Rivas and Henry	Odit quidem minus molestias aut saepe. Voluptatibus odio voluptatibus sed recusandae sit sed iure. Praesentium possimus harum blanditiis.\n\nAutem sint sint sit saepe iure eos. Commodi corrupti totam impedit. Corrupti iure consequatur dolor animi culpa aperiam repudiandae quod. Odio natus vero impedit blanditiis placeat.\n\nAsperiores placeat ratione totam illum dicta saepe. Illum earum quod quia ratione ipsum dignissimos. Ipsum adipisci sit aut temporibus.\n\nEaque doloremque dolore ipsam tempore. Quos dolorum voluptatum natus voluptatibus maiores officia odit aut. In expedita labore impedit temporibus similique. Deleniti dolor aliquam amet assumenda.\n\nDeleniti repellendus ipsam corporis ad. Cum perspiciatis earum cupiditate architecto rem. Soluta maiores dolorem dolorem sint itaque qui.	43.62	\N	2017-12-02 22:21:09.47119+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
350	Lewis-Mccoy	Eos labore illum itaque ipsum. Totam iste adipisci dolores corrupti et. Quos expedita adipisci ipsa corrupti sit aliquid. Quos aperiam ad animi ipsa quis quidem.\n\nRecusandae tenetur porro quas temporibus iure alias perspiciatis. Reprehenderit quibusdam est aut iste ea totam aspernatur. Harum ipsam sed dolorem temporibus minima voluptate. Quisquam distinctio aperiam molestiae similique perferendis commodi.\n\nConsequuntur quo in repellat rerum. Sed officiis odit molestias accusantium. Quidem qui animi voluptatem minus aut iusto. Sapiente atque recusandae delectus porro.\n\nEos ratione neque illum quod. Asperiores laborum dolorem modi corporis quasi est voluptatibus quam. Impedit eaque ut quo quia enim.\n\nRerum maxime dicta suscipit soluta quam tenetur eligendi quibusdam. Vel impedit consectetur tenetur ipsa accusamus tenetur blanditiis consequatur. Aspernatur dolores molestias consequatur autem necessitatibus vero velit.	99.51	\N	2017-12-02 22:21:09.494248+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
351	Mcdonald, Reynolds and Mcguire	Quis perferendis dolor tenetur. Consequuntur ab blanditiis deleniti officia unde accusamus. Voluptate sit libero occaecati nihil. Inventore molestias quasi consequatur repudiandae cupiditate. Itaque iste officia amet.\n\nTempora amet optio error aliquid vitae saepe illum. Quas aspernatur iusto amet dolor. Alias magnam nostrum eius. Commodi dolorum minus omnis quos natus eaque.\n\nQuis repudiandae natus veniam ea eius. Illum molestiae corrupti quo. Sequi quam facere a sed laboriosam minima impedit. Culpa doloribus repellat molestiae vitae aspernatur quisquam ab. Voluptatibus illum ratione quis iste.\n\nDeleniti soluta cum corporis quaerat possimus. Facere quasi hic similique aperiam. Amet nisi officia laborum libero eligendi.\n\nAut reiciendis inventore molestiae magnam iste corrupti recusandae earum. Ad deleniti perspiciatis quae perferendis aspernatur. Dolorum inventore quos aut ab incidunt ipsa molestiae reiciendis. Odit unde repellendus commodi.	75.60	\N	2017-12-02 22:21:09.536455+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
352	Ortiz, Burgess and Anderson	Voluptatum quia consequuntur fugit eum veniam labore pariatur laboriosam. Fugiat corrupti harum iusto nostrum neque. Non accusamus rem fuga nam alias repellendus aut. Mollitia sit hic minus mollitia maxime dolores.\n\nA eaque odio illo dignissimos dolorem. Voluptatibus nemo occaecati fugit voluptatum rem. Molestias architecto aliquam soluta quaerat. Illo nostrum sapiente officia illo explicabo minima.\n\nEaque exercitationem perspiciatis eaque voluptas sint eos iste. Illo eius voluptates maiores itaque error. Voluptatibus qui voluptate perferendis quasi enim dolorum. Id numquam placeat sequi ex vel autem.\n\nSoluta ab porro amet molestiae odit commodi perferendis. Dolore natus ratione necessitatibus sit voluptas praesentium quisquam. Nostrum accusantium officiis est nobis. Excepturi doloremque nemo est aliquid esse mollitia. Alias rerum esse qui voluptas ullam debitis.\n\nQuo porro quae voluptatem praesentium veniam cumque atque natus. Animi in sapiente nulla recusandae deserunt repellendus consequatur. Minus voluptatem nam minus quod recusandae aperiam pariatur. In tempora molestias natus illum veniam rerum.	71.87	\N	2017-12-02 22:21:09.572399+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
353	White, Figueroa and Hamilton	In sed impedit at ipsa accusantium. Dignissimos rerum enim autem omnis sequi accusantium. Modi doloremque eius molestias laboriosam quis illum consequatur optio. Veritatis necessitatibus earum voluptate tempora fugiat inventore.\n\nOccaecati possimus doloribus possimus esse dolores tempore. Esse autem id neque assumenda ea. Saepe necessitatibus amet occaecati cumque. Maiores adipisci possimus quidem ipsam ipsum esse voluptatem.\n\nIste voluptatem ratione beatae minima consequuntur enim ipsam. Debitis repellat accusantium ducimus aliquid optio laboriosam ab. Totam molestias vero aut est. Tenetur numquam incidunt quo. Quibusdam eaque quibusdam amet voluptatum doloremque culpa.\n\nEt qui sunt recusandae at. Laboriosam sed dolorem pariatur harum nisi sed veniam. Nesciunt sunt deserunt cupiditate sit labore rerum.\n\nLabore quia fuga nulla hic. Delectus cumque veniam itaque recusandae veniam eligendi. Officiis delectus illum alias dolorem laudantium.	10.64	\N	2017-12-02 22:21:09.607847+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
354	Pierce, Gordon and Dougherty	Ratione perspiciatis id asperiores cumque. Hic dolores dolor consectetur. Inventore asperiores dolorem repellat dolor illo dolorum. Maxime laboriosam dolor iusto consectetur beatae excepturi sequi.\n\nOmnis quis sed assumenda doloremque. Aspernatur cupiditate tenetur dolores reiciendis temporibus vel. Nulla soluta magnam tempora aut nobis harum porro saepe.\n\nEt doloribus odit tempora temporibus. Dicta facere ipsam doloribus hic voluptatem.\n\nQuisquam asperiores vitae voluptas magni atque minus quia. Accusamus rerum aliquam repellat. Dolore quas modi temporibus voluptas inventore suscipit fuga vero. Nam est dicta blanditiis occaecati delectus.\n\nVel cupiditate ipsa officia eos officia blanditiis quo consectetur. Autem omnis accusantium odio consequatur illo quidem. Dolor voluptas in nulla ea facere provident quibusdam.	8.43	\N	2017-12-02 22:21:09.654477+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
355	Morgan PLC	Omnis facere labore quos. Dolorem blanditiis sequi eligendi ullam. Expedita minus odit at fugit minus.\n\nOfficiis quam praesentium hic quae laborum eum ratione. Rem neque voluptas magni.\n\nPerspiciatis quae dolore eum minus earum. At soluta vitae esse aspernatur aperiam. Facere non quia esse hic deleniti reiciendis. Excepturi vel itaque fugiat.\n\nQuod esse officiis ex corporis a voluptates. Suscipit eius tempora iusto est culpa. Commodi id error saepe non vitae est.\n\nVoluptate quis iure sit in impedit fuga repudiandae. Autem consequatur tempore assumenda totam. A quas eveniet quos ab.	2.37	\N	2017-12-02 22:21:09.700047+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
356	Carr LLC	Modi cum fuga ex dicta facilis deleniti ipsum. Fugit pariatur rerum delectus possimus provident. Omnis eius ad maxime sapiente omnis. Veritatis sed consequatur quaerat numquam saepe reiciendis.\n\nRepellat voluptatum iusto error aliquam. Iste non quod nostrum nam eum. Labore doloremque placeat suscipit eaque. Ea delectus eum modi natus magnam nisi nulla quae.\n\nNulla veritatis error repellendus earum tenetur tempora. Temporibus sed quasi totam cumque deleniti consectetur. Optio minima voluptates harum nostrum ad ipsa maxime.\n\nOccaecati quia aliquam alias similique accusamus deleniti. Quo eaque omnis et blanditiis hic. Iste cum est optio sequi quas. Atque necessitatibus quis est natus officiis sit. Earum quisquam id ullam praesentium.\n\nVoluptatem quaerat sint sunt sed numquam. Porro corporis eligendi quis. Culpa quis exercitationem deserunt exercitationem saepe.	73.11	\N	2017-12-02 22:21:09.730875+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
357	Grant, Woodward and Sandoval	Vel consequuntur voluptatum ullam nihil adipisci totam dolore iure. Repellat alias ipsam harum iste accusantium ipsam. Dolore autem impedit facilis corrupti quia culpa. Ad perferendis vitae nisi eos optio.\n\nMaxime cum accusantium officiis illo. Repudiandae voluptas eos corporis debitis. Omnis optio soluta corporis fuga. Ea fugiat illo qui quod in iure porro. Ratione placeat voluptate impedit exercitationem dolorem.\n\nLaboriosam autem amet ipsum voluptatibus. Fugiat officia quidem tempora alias. Cupiditate quam tempore maiores voluptatem maiores ipsam. Aspernatur eaque eligendi porro.\n\nNostrum ipsum id cupiditate dolores. Impedit cumque id dicta excepturi maiores enim. Repellat totam ab alias deserunt eveniet ipsum adipisci.\n\nOdio a sint recusandae blanditiis culpa deleniti. Eos sint voluptatibus alias ullam esse asperiores ullam. Atque animi consequatur quaerat doloremque rerum. Nostrum tenetur reiciendis rerum quisquam asperiores.	94.64	\N	2017-12-02 22:21:09.762125+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
358	Greer, Long and Roberts	Necessitatibus tenetur deserunt quibusdam labore vero esse tenetur temporibus. Modi deleniti animi accusantium explicabo. Cumque dolorum illum fuga. Earum iusto corrupti aliquid esse voluptatem odit.\n\nVoluptatem eos est non officiis quaerat. Nobis accusantium quos hic veritatis illo consectetur. Odio occaecati eius minus esse expedita nam autem vel.\n\nEum molestiae fugiat cumque. Pariatur officiis commodi dignissimos magnam ratione. Consequuntur aperiam cumque perspiciatis rem animi. Blanditiis sequi vitae facilis.\n\nRepellendus nam reprehenderit quas. Placeat quia sapiente dolore qui quia nostrum quisquam. Autem sint totam nihil laborum ut odit. Magnam distinctio veniam alias quam.\n\nIn similique est asperiores enim nesciunt delectus. Repellendus repudiandae quisquam adipisci a nulla dolores dolores. Ab mollitia earum eius deleniti reprehenderit iure. Nisi voluptatem repudiandae tenetur harum itaque voluptatibus ad qui.	27.62	\N	2017-12-02 22:21:09.796869+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
359	Sanders-Shea	Natus esse aspernatur voluptas nesciunt eligendi. Optio minus veritatis molestiae. Magnam culpa adipisci architecto sed neque.\n\nQuis est sunt doloribus earum molestias cupiditate. Esse necessitatibus assumenda dolores voluptatibus aspernatur culpa accusamus. Quisquam assumenda cumque magni aut iure dignissimos quasi.\n\nQuasi dolorem possimus magnam minus suscipit autem inventore omnis. Corporis dicta dolorem consequuntur a praesentium hic et. Eveniet inventore voluptas id iste ea dolorem. Sed tempora earum perspiciatis blanditiis.\n\nTemporibus modi vero iste vel. Quas sed dolores similique fugiat. Similique praesentium error cumque debitis. Facilis repellat necessitatibus cum dolores autem voluptas.\n\nPossimus ea doloremque tempore veniam labore eaque eaque. Ullam exercitationem fuga assumenda sequi modi. Fuga fugiat totam inventore commodi temporibus rem repellendus. Natus deserunt corporis veniam.	13.89	\N	2017-12-02 22:21:09.827391+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
360	Powell Group	Totam dolorem hic vitae nemo. Qui tempore modi magnam est perferendis similique ratione voluptates. Optio quam dolor nihil nobis voluptatibus ea ea.\n\nRepellat ipsa rerum aliquid sapiente. Qui incidunt est nobis. Ipsa minima et odit facere nobis.\n\nAut eos blanditiis velit illum atque laboriosam reprehenderit. Consequatur pariatur dolores sequi maiores modi placeat. Architecto iure laborum perferendis optio reiciendis at repudiandae.\n\nCupiditate nobis eius sint illo temporibus. Ratione atque laborum reprehenderit nihil tempora ipsam enim. Unde cum libero quae. Ullam rerum incidunt voluptatem culpa.\n\nLibero explicabo at optio quidem error possimus. Perspiciatis fugiat voluptate magni totam. Magnam tenetur odit dolorum tempora. Deserunt accusamus rem fugit pariatur.	9.76	\N	2017-12-02 22:21:09.905174+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
362	Morrison-Anderson	Neque iste inventore assumenda accusantium blanditiis libero. Praesentium consequatur voluptate quia optio.\n\nVoluptatibus molestias rem est sit doloremque officiis. Animi velit quos mollitia eaque quasi. Impedit accusantium corrupti delectus omnis suscipit saepe ad. Repellat ea minus quidem incidunt neque hic.\n\nVoluptatibus neque accusantium minima iste accusamus. A sed ratione animi tempora exercitationem veniam. Soluta deleniti id odit minus cupiditate vero.\n\nBeatae ut distinctio consectetur harum fuga at laudantium. Maxime repudiandae alias veritatis. Occaecati facere officiis possimus maiores quia.\n\nOmnis doloremque amet atque expedita. Perferendis dolorum fugiat adipisci aut minima similique ducimus. Non dolor quibusdam laudantium deleniti laudantium pariatur autem. Fuga quibusdam voluptatum illo quo aliquam dicta hic.	9.76	\N	2017-12-02 22:51:33.591411+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
363	Delgado Inc	Fugiat officia accusamus suscipit saepe. Reprehenderit velit rerum autem harum. Officiis voluptatum ipsum cum neque repellendus fugit.\n\nQuae explicabo est voluptatum explicabo nesciunt odit. Sit reprehenderit rerum dicta occaecati officiis. Voluptate incidunt est vel quidem quis corporis. Iste quidem officiis debitis unde nulla iusto illo.\n\nReprehenderit minus accusantium voluptas voluptatum dolorem impedit architecto modi. Inventore nihil laborum eius explicabo aperiam laudantium. Itaque voluptate eum quasi illo totam.\n\nMolestiae rerum tempora at odio alias blanditiis. Minus id expedita fugiat dolor tenetur. Quo voluptates nesciunt sint id. Placeat ducimus quidem quos atque iste optio.\n\nReprehenderit earum impedit ex iusto. Odit itaque sit aliquam molestiae. Natus itaque temporibus alias laborum minima.	73.40	\N	2017-12-02 22:51:33.643962+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
361	Christian-Garcia	Quisquam occaecati alias quae dicta quibusdam dignissimos. Itaque nobis rerum illum voluptas debitis sint temporibus. Odit voluptatibus qui aperiam deleniti odit. Sed consectetur consequuntur incidunt perspiciatis rerum.\n\nOccaecati vero distinctio nisi voluptatum molestias. Deleniti recusandae recusandae maxime perspiciatis iusto necessitatibus quis facere. Earum dignissimos tenetur voluptatibus impedit occaecati.\n\nAt ea suscipit dolor amet. Rerum neque tempora veritatis eaque.\n\nDicta odit aliquam velit non dignissimos. Dolorum aspernatur atque dolorum.\n\nDignissimos soluta suscipit sapiente dolor odit. Ad rem earum ratione. Provident dolore in perferendis perspiciatis voluptate eveniet fugit.	74.59	\N	2017-12-02 22:51:33.526028+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	t	t
364	Meyers, Larson and Gomez	Quaerat quia eveniet perferendis sunt eum. Aut mollitia vel maiores molestias iste quasi. Enim vitae et accusantium.\n\nIpsam voluptates quae mollitia ea reprehenderit alias maxime aliquid. Iusto nam tempora necessitatibus temporibus in quidem tempore. Vel corrupti tempora eum sint blanditiis. Quidem consectetur rem magnam quo. Accusamus sequi doloremque suscipit.\n\nEaque dolorum aperiam ullam enim quam blanditiis. At autem voluptate dolorum veniam. Soluta natus sed laudantium neque repudiandae necessitatibus sunt. Expedita possimus et dolore eum similique. Eligendi voluptates maxime quod.\n\nInventore consequuntur perferendis sequi tempora ratione. Sint illo quo quod voluptates. Ab esse quam quasi ex. Dicta vero iste ipsam sunt impedit.\n\nQuam itaque voluptate est blanditiis recusandae nesciunt adipisci. Deleniti neque corrupti inventore occaecati repudiandae. Minima dolorum ad quia ratione praesentium esse.	54.16	\N	2017-12-02 22:51:33.701654+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
365	Dean-Warren	Alias porro esse deleniti. Culpa eius modi minima illo fugiat voluptates ad. Blanditiis eius tempore quasi magnam dolores qui minima. Incidunt ullam sed mollitia quidem quasi.\n\nDebitis nisi earum nihil inventore delectus fugiat. Ut quaerat asperiores ratione fugiat saepe magnam atque. Nisi incidunt molestias omnis laudantium nesciunt.\n\nUt pariatur aperiam laudantium delectus molestiae. Placeat non blanditiis cupiditate a maxime quod porro. Debitis ducimus odit consequuntur laborum officia ad cumque.\n\nQuidem dolore quisquam totam nostrum incidunt ipsam hic. Laboriosam totam ex illum voluptatum molestiae nemo. Facere unde odit esse vitae velit. Harum magnam ipsam sint sunt officia commodi. Ipsa repudiandae eaque officiis illum provident.\n\nFugiat cumque deserunt officia excepturi inventore. Numquam necessitatibus temporibus ratione perspiciatis voluptate optio natus blanditiis. Fugit reiciendis tempore perspiciatis consectetur soluta.	59.17	\N	2017-12-02 22:51:33.761802+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
367	Snyder-Rogers	Vel earum officiis possimus excepturi qui illum. Explicabo doloribus porro consectetur blanditiis sequi facere. Repellat necessitatibus quidem pariatur delectus.\n\nSapiente voluptates optio natus cum sunt. Nam placeat quam distinctio error non et explicabo. Numquam ea non dolorum magni in. Aspernatur nihil amet dolore aperiam.\n\nVitae libero voluptas dolores laudantium. Non mollitia commodi molestiae earum harum laborum odio. Culpa suscipit cumque tenetur doloribus ullam non amet nisi.\n\nExcepturi aliquam officia a sapiente impedit. Fugit eligendi unde culpa dicta unde explicabo. Quia dolore impedit fugiat libero non iste. Numquam voluptate assumenda doloribus provident impedit ea.\n\nQuidem ducimus nobis molestiae placeat culpa. Ipsam suscipit voluptates sequi voluptatibus aut mollitia eos. Voluptate ipsum aliquid ducimus tenetur incidunt pariatur aut. Repellendus deleniti rerum fugiat quam.	72.58	\N	2017-12-02 22:51:33.879765+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
375	Kelly-Evans	Saepe accusamus eius modi ratione blanditiis corrupti porro voluptate. Molestiae optio repellat vero beatae consequatur est. A laborum ipsam voluptas occaecati perspiciatis repellat. Voluptate sint atque veritatis occaecati incidunt.\n\nEsse dolorum blanditiis tempora quos. Illo quisquam corporis ratione doloremque. Occaecati quos ex molestias animi asperiores assumenda fugit provident.\n\nEaque voluptatum est totam sint sit pariatur at occaecati. Sequi ad animi molestias facilis. Culpa facilis tempora quis recusandae magnam repellat tempore. Deserunt sapiente alias ratione sunt officiis.\n\nEx soluta sit natus pariatur incidunt minima. Occaecati autem nisi similique inventore corporis eaque nam. Dolor provident iure veritatis veritatis.\n\nAut laboriosam dolores quae saepe. Aut ut quis facere dignissimos facere tempora. Esse consequuntur nisi voluptate repudiandae.	97.47	\N	2017-12-02 22:51:34.279251+00	2	"3"=>"6"	f	t
376	Anderson-Dixon	Architecto totam suscipit modi. Odio eveniet sequi temporibus beatae. Enim amet omnis minus ullam. Fugit id nulla quos ipsum esse qui.\n\nQuo commodi architecto eveniet sint. Soluta odit fugit repellat cupiditate voluptatum. Quos pariatur doloremque quam aperiam ut enim.\n\nNon fuga harum exercitationem doloremque. Rem eius cumque voluptatibus laboriosam. Perspiciatis repellat quasi illum optio. Ut quo at earum beatae placeat deserunt.\n\nQui dignissimos quae quae. Itaque fugiat vel provident doloribus inventore temporibus. Itaque velit maxime tempora veniam sed soluta. Harum libero numquam in reprehenderit laudantium fugit.\n\nRepellat quibusdam maiores quae pariatur delectus inventore. Accusantium omnis id ipsa sed. Quaerat voluptatibus minima nemo officiis perferendis beatae error. Atque voluptatem necessitatibus fuga assumenda tempora.	73.19	\N	2017-12-02 22:51:34.311181+00	2	"3"=>"6"	f	t
377	Holder Group	At ea amet neque architecto repellat nostrum maxime sequi. Repellat quis quos provident voluptas numquam. Commodi minus voluptas numquam vero.\n\nDeleniti quae aperiam quibusdam asperiores cupiditate perferendis omnis. Harum nemo dignissimos enim minus maxime. Tempore omnis animi asperiores dolorum laudantium libero laborum.\n\nQuam repudiandae dolorem corporis eaque aperiam tempore dolor. Repudiandae libero quam omnis earum doloribus. Beatae repellendus dolorem rerum facere eveniet velit doloribus.\n\nAmet adipisci modi voluptatum explicabo commodi nobis minus tempora. Eligendi aperiam dolore nobis sunt tenetur. Quis laudantium expedita eius sint. At dignissimos minus odit.\n\nDoloribus voluptatibus odio inventore sint culpa laudantium perspiciatis. Quam nam aliquid dicta laborum ad laudantium ipsum. Neque ipsam provident nobis voluptate beatae. Suscipit iure ratione quidem deleniti nesciunt atque reprehenderit.	3.70	\N	2017-12-02 22:51:34.343793+00	2	"3"=>"6"	f	t
366	Martin and Sons	Facilis voluptatibus nemo laudantium at ipsum harum itaque. Distinctio cumque modi tempore iure perferendis facilis magnam. Neque ea ipsam totam tempore occaecati.\n\nSapiente at ea eveniet eligendi sunt quae officiis. Recusandae libero ipsa pariatur perspiciatis odio ab architecto. Earum quibusdam necessitatibus fuga repellendus vel aliquid itaque.\n\nQuas nostrum consequatur consectetur voluptatem quidem quis quia nemo. Eaque sequi quisquam rerum. Explicabo nostrum voluptate placeat itaque quasi sed. Voluptatem voluptatibus odio sequi cupiditate a laborum.\n\nNulla magnam a veritatis ipsum doloribus natus. Esse impedit sunt maiores occaecati temporibus ducimus. Facere labore vel error debitis corrupti. Odit at magnam hic fugit dolores reiciendis.\n\nIste autem possimus sapiente. Adipisci delectus saepe quod officia dolorem id. Quas corporis quibusdam nisi et asperiores ipsam quas.	8.19	\N	2017-12-02 22:51:33.816062+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	t	t
368	Ryan and Sons	Et doloribus doloribus suscipit aliquid quos placeat iure consectetur. Aperiam earum corporis eligendi quibusdam maiores. Recusandae voluptate minima doloremque ipsa deserunt autem.\n\nId esse temporibus voluptatum optio. Sed doloribus provident dignissimos suscipit quasi. Quo ex perspiciatis quae voluptatum quis quis nihil. Exercitationem suscipit debitis nisi distinctio.\n\nDucimus vitae ea iste eaque nemo repudiandae debitis. Necessitatibus vitae molestias aliquam. Numquam optio voluptatibus numquam provident adipisci doloremque ratione iusto.\n\nIn minus fugiat molestiae tempore. Totam repudiandae tempore autem eaque. Suscipit error possimus error nesciunt labore expedita totam eius. Voluptatum dolor corrupti eum eveniet.\n\nMolestiae amet ullam perspiciatis quisquam veniam reiciendis. Quo fugit nulla sequi deserunt vero repellendus voluptatem. Enim doloremque blanditiis sequi corrupti. Pariatur eos voluptates maxime ipsam eaque ipsam.	53.87	\N	2017-12-02 22:51:33.930588+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
369	Smith, Spencer and Carr	Dolore doloremque repellendus quasi sunt exercitationem sed amet. Dicta odit praesentium autem repellat amet ad molestiae. Perferendis sit tenetur numquam deleniti ipsam. Quo optio tempore neque numquam.\n\nHic eum id vero nesciunt sit consectetur. Ratione magni dignissimos quasi repellendus qui quas. Velit deserunt illo veritatis.\n\nRerum quisquam explicabo quos quasi officiis numquam. Eum quo delectus sunt error porro. Veritatis non unde mollitia officiis rerum omnis quibusdam. Perferendis magni exercitationem numquam repudiandae nobis natus repellendus. Tenetur et repudiandae maxime perferendis ullam eveniet.\n\nBlanditiis natus odio consectetur porro non similique. Ducimus blanditiis dicta nam accusantium maxime nemo eum quam. Eaque dignissimos hic quibusdam sit.\n\nIpsa eius tenetur necessitatibus. Ex minus fugit hic deleniti sapiente consectetur odio. Mollitia cupiditate tempore libero laboriosam.	67.11	\N	2017-12-02 22:51:33.981333+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
370	Mcdowell LLC	Nemo tempora libero sed perferendis assumenda placeat. Doloribus eos totam ipsum. Doloremque quam minima debitis id quaerat aliquid aliquam. Itaque blanditiis quo mollitia consequatur vero odit. Sapiente porro quae harum tenetur.\n\nSit corrupti eius aliquid ut sed perspiciatis animi. Ipsam veniam cum cum dolore molestiae. Laborum voluptates error quaerat inventore nam architecto. Magni architecto accusamus ab blanditiis tenetur voluptatem. Totam inventore exercitationem provident omnis voluptatibus officia.\n\nQuam alias ea voluptatem perferendis eius sunt. Ex quibusdam quaerat ut atque. At enim eligendi culpa. Ipsa veniam architecto ea quam consectetur.\n\nItaque delectus blanditiis aliquid ducimus quibusdam quis. Voluptates nihil distinctio ex dolorum laborum exercitationem. Tenetur recusandae quibusdam minus explicabo. Commodi amet aspernatur cum labore vel adipisci libero veniam.\n\nBeatae magni explicabo molestias consequatur impedit reprehenderit incidunt. Sapiente distinctio dolores nesciunt eos. Molestiae fugit est numquam assumenda rem eum illum. Quasi consectetur esse provident quaerat commodi voluptatem fugit.	1.24	\N	2017-12-02 22:51:34.031057+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
371	Lutz Ltd	Fuga quae magni illo. Harum aut quasi corrupti eos.\n\nPlaceat modi reprehenderit aperiam dignissimos placeat minus tempore. Aliquam culpa soluta labore doloremque. Asperiores molestias distinctio incidunt quam nulla ea eos. Ducimus odio beatae facere reiciendis. Labore fuga corrupti totam voluptas.\n\nAssumenda possimus minus quis quo iure temporibus quasi quibusdam. Quam quisquam asperiores ducimus. Sunt quibusdam magni dignissimos hic nobis quod.\n\nAlias alias autem reprehenderit veniam. Incidunt ex iste dicta tempore ullam corporis atque. Tenetur molestiae provident enim velit recusandae quibusdam perspiciatis. Nulla perferendis deserunt quod nemo.\n\nIllo voluptatem optio quidem ut. Minus aspernatur minima vel beatae incidunt. Voluptatibus voluptates totam quisquam incidunt voluptatibus dolorum accusantium. Quasi accusantium voluptatem earum modi facere eum corrupti.	80.44	\N	2017-12-02 22:51:34.09622+00	2	"3"=>"6"	f	t
372	Nelson, Heath and Reed	Dolorum quaerat ducimus mollitia quae ullam. Doloremque laudantium sint explicabo. Aut mollitia at ad esse occaecati quia.\n\nItaque magni neque dolore quos itaque quaerat aspernatur explicabo. Nulla dignissimos quaerat omnis quidem culpa ea inventore. Unde ad dolorum distinctio consectetur ipsum. Voluptatum veritatis possimus voluptates nulla error aliquid alias.\n\nEius excepturi perspiciatis et ipsum. Commodi qui commodi odit quibusdam dicta.\n\nTempora ipsum dolor eum harum tenetur possimus quod sint. Similique labore velit nobis fugit aliquam aut odit. Perspiciatis ipsam consequuntur expedita minima explicabo.\n\nVitae ab dolor doloremque ea. Est vel eos earum sapiente.	61.64	\N	2017-12-02 22:51:34.162386+00	2	"3"=>"6"	f	t
373	Harvey-Costa	Accusantium ducimus cumque excepturi nemo error id. Velit ipsum omnis ducimus itaque. Velit occaecati ab iste maiores sapiente libero.\n\nOccaecati voluptate aliquam ullam aliquid fuga iste. Consectetur est accusamus unde repellendus cumque aliquid.\n\nNisi rem asperiores repellendus amet. Dolore odio a occaecati rerum debitis. Natus adipisci earum eum facilis numquam quod.\n\nQuos minima quos natus ex. Occaecati dolores quia illum iure illum voluptatem quaerat. Voluptate occaecati eum dolorum vitae eum. Asperiores distinctio necessitatibus facilis animi.\n\nAliquam eaque quasi dolorum ipsam. Nisi doloribus accusantium nulla quasi. Odit rem molestiae qui earum magni unde repellendus consectetur. Nulla occaecati at recusandae debitis dicta.	86.56	\N	2017-12-02 22:51:34.19957+00	2	"3"=>"6"	f	t
374	Reyes-Ryan	Praesentium blanditiis debitis autem quo minima tenetur. Vel ipsum a provident ad sit provident quaerat. Adipisci officia consectetur sunt veritatis eaque. Iure ex sequi nam.\n\nAspernatur accusamus dicta quos vitae soluta quasi. Placeat illo nobis odio quis quo.\n\nCupiditate corrupti non animi dolorem iure officiis fugiat. Voluptates maiores eos reprehenderit hic earum.\n\nDolor necessitatibus odio dicta. Occaecati tempore suscipit quod. Laborum delectus id itaque libero aspernatur laborum.\n\nAccusamus est occaecati est a assumenda doloremque exercitationem qui. Magni iusto ipsa iure itaque fugiat est. Dignissimos saepe quo nostrum minima. At non adipisci unde.	0.47	\N	2017-12-02 22:51:34.23165+00	2	"3"=>"6"	f	t
379	Collins LLC	Reiciendis praesentium nihil animi aliquid provident ab labore. Commodi reprehenderit perferendis iure distinctio ullam. Nesciunt quia quam nobis.\n\nSapiente beatae quod repellendus iusto ipsum provident. Perspiciatis ducimus ad aliquid voluptates eum. Veritatis ut quasi porro enim. Error quo quis nobis corrupti. Occaecati alias voluptatem odio ad debitis enim temporibus.\n\nUllam tempora neque tenetur numquam. Amet error quas quasi odio dicta magni inventore ea. Facere dolorem incidunt eaque veniam provident recusandae dolorum. Eius quidem adipisci corporis qui perspiciatis.\n\nIpsum labore perferendis laudantium tenetur. Non expedita tempora earum consectetur voluptate minus dignissimos numquam. Libero quas veritatis aperiam praesentium esse.\n\nTemporibus occaecati fuga fuga reprehenderit possimus ratione. Impedit saepe accusantium aliquid aliquam. Reiciendis blanditiis sapiente a illum ipsum esse. Est aperiam tenetur deserunt debitis nam explicabo odio.	45.68	\N	2017-12-02 22:51:34.387113+00	2	"3"=>"6"	f	t
380	Sawyer, Rodriguez and Andrews	Accusamus harum harum saepe incidunt. Impedit tenetur quos ipsa dolorem voluptatem. Cupiditate eligendi cum veritatis incidunt ipsum.\n\nDeserunt ut asperiores nobis animi. At placeat repellendus temporibus. Fugit vitae consectetur occaecati harum non doloremque odio. Consequatur ea praesentium minima ab illo illum.\n\nEst laborum magni quis aliquam voluptatibus necessitatibus. Vel nostrum commodi repellendus quaerat quis recusandae ratione. Alias minima fugiat blanditiis quod aut optio. Reiciendis in eaque vel maxime minima.\n\nVoluptatum fugit fugit atque. Amet maxime deserunt non suscipit sequi veritatis sequi quidem. Debitis aliquam ipsam voluptatibus quos fuga vero.\n\nQuaerat quas assumenda asperiores itaque. Qui reprehenderit fugiat tempore excepturi beatae voluptates cumque accusantium. Odio fugiat et vitae nisi. Quos deserunt exercitationem aliquam velit ab repellendus odio.	66.45	\N	2017-12-02 22:51:34.410004+00	2	"3"=>"6"	f	t
381	Roberts Ltd	Alias ducimus enim dolorem vitae necessitatibus. Hic voluptatum autem sed doloribus ratione odio. Quo architecto ratione possimus eius delectus voluptatum placeat soluta. Voluptatum nostrum ab quod iste corporis labore perferendis accusantium. Beatae fuga laboriosam ratione doloremque inventore deserunt eius.\n\nQuo architecto officiis tenetur sequi facilis perspiciatis ullam. Est culpa saepe accusamus praesentium nesciunt consectetur inventore. Accusamus aperiam ut dolore molestias quod delectus quo.\n\nHic asperiores sunt ratione iusto. Ad fugiat sequi perspiciatis occaecati nobis sunt dolore. Eligendi eaque totam minus deserunt consequuntur. Quibusdam repellat quis perferendis consectetur optio.\n\nNecessitatibus voluptatum sequi voluptas minus corporis. Harum nobis cumque praesentium possimus alias provident. Harum magnam molestias suscipit laboriosam architecto voluptate quae ipsam. Eius quaerat adipisci explicabo doloremque ratione suscipit.\n\nEius quaerat et autem quam nobis veritatis. Similique odio repellendus dolorum eligendi quisquam sapiente. Est numquam similique aliquam atque consectetur. Debitis minus officia magni nemo libero eaque.	28.30	\N	2017-12-02 22:51:34.43582+00	3	"3"=>"6", "5"=>"14"	f	t
383	White Inc	Illo quia qui incidunt totam temporibus nesciunt dolore molestias. Nemo ad quo minus esse autem nemo eius. Ducimus minus inventore harum neque tempora quibusdam commodi.\n\nRerum qui doloribus et illo laborum aliquam dolores. Esse officiis facilis id magni rerum est.\n\nOptio quos expedita laboriosam libero esse vitae occaecati. Atque modi quia laborum distinctio accusantium. Dolor delectus suscipit dolorum facere unde. Esse iste inventore suscipit numquam amet.\n\nExplicabo nisi ab beatae occaecati libero. Odio eos aspernatur corporis assumenda omnis. Sit voluptatem ratione consequuntur ad saepe rem nisi. Dolore pariatur necessitatibus nesciunt quibusdam architecto excepturi.\n\nIpsam quas tempora placeat itaque soluta. Eligendi quisquam tenetur voluptatem dolor. Eaque est deserunt vel architecto necessitatibus dolorem reiciendis.	23.27	\N	2017-12-02 22:51:34.550722+00	3	"3"=>"6", "5"=>"14"	f	t
384	Hoffman, Ford and Ware	Voluptatem optio reiciendis deserunt impedit voluptatum. Molestias molestiae vel maxime excepturi rerum dolorum. Non animi quisquam aliquam voluptate repellat reprehenderit.\n\nNisi qui quibusdam molestiae alias aperiam tempore voluptatum deserunt. Suscipit numquam minus itaque magnam iste cum temporibus.\n\nMaxime natus blanditiis dolorum. Nulla omnis molestiae aliquam quas iure vero. Ducimus laboriosam placeat expedita nesciunt quidem.\n\nVeniam omnis voluptate doloribus quod cum quia mollitia dolorum. A dolorum aut repellat. Pariatur omnis eligendi cum excepturi. Tempore nobis enim vitae occaecati fugiat tempore.\n\nAsperiores eum eos optio fuga earum omnis necessitatibus. Inventore voluptate libero magnam est. Nihil hic eum facilis similique.	43.83	\N	2017-12-02 22:51:34.596349+00	3	"3"=>"6", "5"=>"13"	f	t
385	Colon, Tucker and Patrick	Et autem doloremque provident illo perferendis. Blanditiis suscipit deleniti exercitationem numquam molestias eveniet. Hic blanditiis officiis itaque repudiandae praesentium modi tempora.\n\nAb enim perspiciatis dicta quis hic. Accusantium debitis praesentium provident soluta dignissimos soluta. Error repudiandae quisquam atque rerum hic consequuntur voluptatibus. Non eos suscipit dolor ex.\n\nTenetur soluta optio ad nemo error rerum autem. Optio quis quia cumque quisquam. Explicabo fuga sequi commodi numquam.\n\nVel sed tenetur non fugit. Et optio natus maxime neque aliquid blanditiis quas. Sint veritatis doloremque vel soluta.\n\nNulla labore dicta placeat eligendi. Assumenda saepe maiores quia incidunt repudiandae. Tempora eaque numquam totam beatae ad molestiae neque voluptatum.	24.60	\N	2017-12-02 22:51:34.643265+00	3	"3"=>"6", "5"=>"13"	f	t
382	Hancock PLC	Adipisci alias atque delectus incidunt hic dolorum harum. Consectetur autem nesciunt tempore architecto qui. Unde unde molestias perferendis perferendis. Mollitia fuga temporibus accusantium blanditiis libero magni perferendis.\n\nQuaerat vero quisquam nemo. Sunt magni reiciendis eligendi deserunt impedit corrupti placeat animi. Fugit quo porro ratione.\n\nSaepe libero ad ullam aspernatur rem. Impedit eaque voluptatem laboriosam inventore labore quos quia tempora. Reiciendis dicta assumenda ut iure. Blanditiis tenetur ullam fuga perferendis.\n\nUnde fuga explicabo ut dolorem. Nisi qui qui sequi necessitatibus aliquid molestiae soluta et. Sint doloribus delectus libero quia eum provident porro. Laboriosam temporibus voluptas possimus animi.\n\nAliquam repellendus molestiae atque eos nemo soluta animi. Quia nobis nam quasi aspernatur nam quibusdam excepturi voluptatibus. Rerum error accusamus voluptatem recusandae modi consequatur.	12.00	\N	2017-12-02 22:51:34.494291+00	3	"3"=>"6", "5"=>"14"	t	t
387	Fernandez-Alvarado	Sit facilis et adipisci mollitia eligendi maxime perspiciatis. Repudiandae at repudiandae inventore. Sit quam quo rerum possimus vitae voluptatibus perspiciatis. Ab qui eligendi harum voluptatibus soluta ut.\n\nAssumenda fugit soluta maxime fuga. Voluptates voluptatibus fuga enim quae nesciunt corrupti.\n\nBlanditiis officia maxime architecto unde illo. Possimus illum iusto velit. Expedita fugit nihil deserunt nulla nisi beatae.\n\nDolore tempore sed officiis debitis. Eligendi nam vel repudiandae facere molestiae saepe amet. Ducimus nisi consequuntur cumque sit ad. Quaerat rerum dolor velit pariatur.\n\nDolorum voluptates enim nihil beatae eos. Commodi esse unde excepturi ipsa nesciunt labore dolore. Aspernatur dicta eaque corrupti porro. Rerum minus perferendis cupiditate.	88.46	\N	2017-12-02 22:51:34.727582+00	3	"3"=>"6", "5"=>"13"	f	t
388	Wallace-Nelson	Deserunt modi fuga distinctio eos harum molestias. Laboriosam laborum quo dolorem tempore consequatur aspernatur voluptatem. Incidunt libero rem dignissimos ullam cum incidunt. Quibusdam autem enim ratione esse molestias doloribus unde.\n\nQui facere molestias saepe id blanditiis quis magni. Officiis omnis minima quo dolore pariatur sunt sint. Natus rerum quidem quo debitis. Dolores quibusdam quia sed facere rerum illo eaque.\n\nSunt earum laborum corrupti reiciendis quos molestias. Quibusdam sapiente voluptate quae nihil distinctio consequatur. Eligendi molestiae harum possimus vel. Architecto unde deleniti nesciunt voluptatibus numquam.\n\nFugit animi dicta in iure error. Ducimus fugiat cumque enim. Nam eius voluptatibus quidem dolor nam. Mollitia modi eum reprehenderit tempore ea neque deleniti.\n\nAdipisci expedita iste delectus facilis. Voluptates fugit optio neque qui quis quia adipisci. Consequuntur vero atque praesentium saepe.	2.18	\N	2017-12-02 22:51:34.761838+00	3	"3"=>"6", "5"=>"14"	f	t
389	Morgan-Hunter	Laudantium repellat molestiae corporis aliquam consectetur. Officiis velit facere libero hic repellendus sequi modi. Sint magnam facilis ipsa expedita rem asperiores. Mollitia animi fugit dolor fuga.\n\nVeniam saepe error quaerat ea nobis velit quia. Quasi nam adipisci maiores. Sapiente eaque quod pariatur quaerat.\n\nRecusandae minus voluptate veritatis nemo ut id cum. Nulla quae nobis autem dolores dignissimos voluptatum debitis qui. Nostrum explicabo alias impedit nulla inventore animi. Incidunt sapiente sunt aliquam officia.\n\nOmnis ipsa quas accusantium nisi sit odio. Eum eaque eaque minus. Fugit enim delectus molestiae. Asperiores sequi molestias veritatis mollitia magni quis repellat.\n\nAsperiores necessitatibus itaque assumenda unde perspiciatis voluptas. Aperiam fugiat consectetur magni corporis quibusdam. Possimus magni ad vel quo.	74.21	\N	2017-12-02 22:51:34.805301+00	3	"3"=>"6", "5"=>"13"	f	t
390	Lambert, Allison and Castillo	Architecto cum accusantium fugiat. Distinctio suscipit facilis expedita illum optio. Vitae sequi nam reprehenderit perspiciatis voluptate labore. Alias nesciunt incidunt eos omnis optio officiis.\n\nNemo dolore eaque repellendus a voluptate. Mollitia commodi soluta nobis animi eaque temporibus. Possimus tenetur expedita earum sunt laudantium repellendus. Inventore culpa dolor vel explicabo modi reiciendis id natus.\n\nExcepturi ab iure temporibus quam ea. Quos dolores nam magnam incidunt dolorem soluta illum aperiam. Minus quaerat veniam nobis quia eius.\n\nCumque accusamus odit saepe velit ipsa architecto cupiditate. Ipsa veritatis eligendi perspiciatis velit. Ullam at unde quaerat cumque.\n\nMaiores qui consequuntur distinctio corrupti aliquid dolores ab. Officiis deleniti magni illum ipsum magnam atque eligendi. Mollitia consectetur molestias unde aperiam maxime dicta.	66.17	\N	2017-12-02 22:51:34.845883+00	3	"3"=>"6", "5"=>"14"	f	t
391	Mccall, Burns and Dominguez	Vitae fugit culpa at harum totam. Quia accusamus dolorum iste corporis excepturi. Quaerat culpa a facere sequi tempore omnis explicabo sapiente. Rerum provident adipisci odit quos odio.\n\nVoluptates debitis praesentium similique expedita quasi et. Quia pariatur soluta quisquam accusamus fugiat. Odio consequatur dolor amet tempora.\n\nVitae corporis odio error unde cupiditate. Sit ut ducimus officiis maiores aut autem repellendus. Eligendi eius sint nostrum quo magni.\n\nFugit eos praesentium corporis quidem error debitis deleniti. Veniam placeat enim magnam numquam. Non commodi consequuntur voluptates dolore facilis aspernatur explicabo. Dolorem recusandae eum ipsam.\n\nPlaceat voluptatum placeat eum ipsum voluptate. Porro nisi culpa quasi doloribus autem sunt voluptatum. Deleniti neque commodi consequatur omnis aperiam earum excepturi. Provident dolorum commodi maxime saepe totam doloribus. Cupiditate nemo optio praesentium tempore.	25.82	\N	2017-12-02 22:51:34.914773+00	4	"3"=>"6", "7"=>"20"	f	t
392	Pittman, Giles and Garcia	Illum deserunt cupiditate exercitationem autem doloribus earum facere. Iusto illo inventore est praesentium exercitationem expedita aliquid. Ea ut libero esse nostrum. Impedit debitis sed quibusdam ratione quisquam dolores ut debitis.\n\nMinus accusantium molestiae et nihil nulla eius odit. Alias quam aut dolorem quisquam iste. Fugiat rerum reiciendis suscipit omnis expedita dolores laboriosam maxime. Neque dolorum labore odio ut.\n\nCorporis ducimus itaque fugiat doloremque. Dolor cum veniam enim nemo. Odio fugiat veniam quaerat. Suscipit illo laudantium aliquid fugit.\n\nTemporibus aut alias sunt modi quam. Ut nam reiciendis sequi animi deserunt ratione. Debitis nostrum minima veniam dolor. Voluptate eveniet nostrum excepturi cupiditate eius molestiae.\n\nPorro quos sed laborum id non. Officiis nulla facere ipsa minima praesentium. Ipsum corrupti consequatur impedit. Ullam mollitia quaerat officiis perferendis.	84.95	\N	2017-12-02 22:51:34.955573+00	4	"3"=>"6", "7"=>"19"	f	t
399	Scott-Price	Cumque voluptates dicta non aperiam delectus perferendis. Nostrum ab impedit perspiciatis asperiores dicta ipsa. Quaerat fugit modi consequatur quis.\n\nCorrupti aliquam eaque dolore consequuntur consequatur earum error. Impedit eveniet facilis neque reiciendis enim. Vitae fuga eveniet officia dignissimos repellat dignissimos.\n\nVoluptates neque cum nobis voluptatem ullam. Delectus quibusdam quisquam repellendus provident. Velit maiores alias reiciendis natus provident.\n\nRepellendus incidunt quibusdam placeat fugiat reiciendis nesciunt. Dolores unde non modi iure. Eos ducimus optio dolorum nisi quo harum esse placeat. Perferendis temporibus tempore labore sint.\n\nAspernatur omnis quasi asperiores. Alias odit ad voluptate sed laborum eligendi. Illum culpa maxime nulla quibusdam commodi mollitia.	31.75	\N	2017-12-02 22:51:35.256425+00	4	"3"=>"6", "7"=>"19"	f	t
393	Hamilton, Mueller and Flores	Architecto perspiciatis officiis necessitatibus a quam provident. Nisi similique ut sed recusandae veniam reprehenderit voluptates. Repudiandae repellat dolorum veritatis facilis voluptate.\n\nLaudantium culpa reiciendis voluptates necessitatibus illo et doloremque. Saepe dolore laudantium aliquam earum dolore repudiandae. Architecto eaque dolore dolorum esse fugiat. Consequuntur itaque iusto omnis quibusdam.\n\nCulpa vero quis numquam. Provident maiores molestiae laudantium ipsum deleniti eos. Asperiores maxime rerum laboriosam nam in.\n\nUllam totam ad odio consequatur consequatur. Quidem rem rerum ducimus laborum debitis ullam. Delectus quasi consectetur ipsam provident debitis facilis. Debitis sunt minima delectus suscipit fuga maiores nemo.\n\nVoluptas incidunt debitis corrupti reprehenderit itaque temporibus laborum aliquam. Blanditiis impedit minus perspiciatis explicabo recusandae itaque qui. Officiis impedit sequi ab voluptate cupiditate harum sequi. Cumque dolore commodi facilis a commodi quisquam.	1.40	\N	2017-12-02 22:51:34.997214+00	4	"3"=>"6", "7"=>"20"	f	t
394	Rogers, Smith and Zuniga	Consequatur aperiam inventore accusantium dolorum. Possimus libero doloribus at. Beatae quaerat exercitationem atque tempore.\n\nOfficia neque libero voluptatibus beatae enim. Atque eum at voluptate qui voluptate. Dolor magnam veritatis veniam.\n\nEnim et aliquid ipsam recusandae minima laudantium aut. Sint velit modi eaque ducimus itaque neque nobis earum. Itaque voluptatibus magni quisquam facere. Inventore id itaque assumenda eum.\n\nHic doloremque dolorum voluptatem ipsa nesciunt ad ad. Doloribus officiis dignissimos eveniet occaecati consectetur perspiciatis placeat. Itaque possimus vitae debitis enim. Dolore consequatur vel aut ad odit nihil placeat eum.\n\nExpedita modi ipsam quis corporis corporis dolorum. Facilis laborum ullam expedita ratione commodi. Deserunt consectetur sed ullam delectus quaerat.	56.14	\N	2017-12-02 22:51:35.045479+00	4	"3"=>"6", "7"=>"20"	f	t
395	Tran, Campbell and Strickland	Libero aliquid expedita numquam placeat asperiores ipsa itaque. Ipsum eveniet ratione iste. Ipsum maxime voluptates suscipit nemo accusamus deserunt nobis. Deserunt et non maiores dolore vitae vel. Praesentium corporis vero sunt earum ipsa.\n\nCorporis excepturi tempora in neque. Quam magnam iure suscipit amet aliquid cum debitis. Nesciunt similique facilis asperiores id facilis.\n\nOfficia ullam sequi reiciendis fugiat possimus ratione sunt. Dignissimos distinctio ullam nam corporis repellat libero voluptate. Vero explicabo numquam neque impedit rerum animi corrupti. Ut tenetur saepe inventore pariatur ipsa. Dolorem illo quidem ad quisquam fuga.\n\nCum iste possimus laborum perspiciatis eum. Exercitationem sunt earum occaecati velit quibusdam exercitationem. Quidem amet ex harum ea quo expedita.\n\nOfficia officiis enim dolorem tempora consequuntur. Reiciendis voluptate ex voluptatum nemo. Quaerat quasi reiciendis a quaerat ullam.	50.97	\N	2017-12-02 22:51:35.092766+00	4	"3"=>"6", "7"=>"19"	f	t
396	Roy, Harris and Bowers	Maxime itaque numquam placeat vero. Accusantium eum tempora expedita molestias dolorum facere cumque. Beatae exercitationem doloremque voluptas eos facere repellat. Voluptatibus nisi fugiat tempora officiis aperiam fuga rem.\n\nOptio quis molestias vel in voluptas ipsa quae. Veritatis eveniet ab illo inventore. Natus molestias deleniti accusantium nemo.\n\nInventore quo nulla sit id alias odio. Fugit occaecati magni beatae quidem error. Magni modi ut qui fuga quidem. Sequi fugit ad non maiores quae vero.\n\nAd necessitatibus fuga similique tempora hic. Adipisci fugit cum molestiae accusamus sint veniam. Officiis voluptates nulla ullam voluptatem. Voluptas laudantium officiis quisquam non atque optio.\n\nVoluptates nulla ipsum aspernatur. Culpa repellat impedit maiores deleniti. Quaerat maxime sint autem veniam inventore quibusdam nihil. Dolore voluptas impedit cumque pariatur.	46.91	\N	2017-12-02 22:51:35.135921+00	4	"3"=>"6", "7"=>"19"	f	t
397	Stewart Group	Nam quisquam magni iure nisi. Quae numquam a officiis rem. Amet numquam autem pariatur culpa. Praesentium nobis accusamus molestias repellendus animi aperiam veniam quis.\n\nLaudantium tempora voluptatem est. Modi numquam accusamus eligendi voluptates laudantium dolorem laborum occaecati. Ab voluptates quas magnam dolor accusamus quo. Culpa natus tenetur reprehenderit veritatis.\n\nDoloribus eligendi veritatis unde. Laudantium aliquid omnis deserunt sint doloribus. Nesciunt molestias ratione unde recusandae molestias. Sed asperiores dolore voluptatibus cumque.\n\nMinus enim quod vel repellendus praesentium hic corrupti quibusdam. Nesciunt fugiat excepturi officiis in optio incidunt. Ab similique eius officiis ea quas. Laudantium doloribus vero sapiente illum hic. Nemo architecto placeat illum voluptatem ratione aliquam est.\n\nTenetur iure dolorem aliquid dolore placeat vel ipsam. Fugiat deserunt amet debitis cupiditate harum asperiores magnam. Dicta beatae architecto voluptas voluptates.	63.24	\N	2017-12-02 22:51:35.176115+00	4	"3"=>"6", "7"=>"19"	f	t
398	Orr-Jones	Voluptatem illo facere quisquam fugit accusamus soluta. Doloribus dignissimos asperiores odit ab minima error tempore excepturi. Eius alias commodi maiores neque quaerat esse.\n\nAccusantium earum ipsum dolor doloremque. Ex impedit ullam minima repellat possimus expedita assumenda. Accusantium iure aliquam repellendus ratione totam. Eligendi dolorum nisi expedita vitae tempora perspiciatis cum. Sapiente excepturi ipsa soluta.\n\nOccaecati perspiciatis officia sed modi quo officiis. Cupiditate ratione corporis pariatur voluptates commodi accusantium fuga. Quo atque sint tenetur vel inventore rem. Sed necessitatibus laborum quo distinctio vero quia.\n\nEnim a cupiditate dignissimos quae molestiae saepe sapiente suscipit. Vel voluptatem occaecati ad nihil corporis. Voluptates laboriosam necessitatibus nisi optio iure. Voluptatem quo alias id natus. Neque illo repellendus ipsum itaque asperiores animi voluptate facilis.\n\nModi architecto optio recusandae repellendus. Ut esse harum dolorem. Earum tenetur explicabo tempora assumenda expedita accusamus.	44.93	\N	2017-12-02 22:51:35.226282+00	4	"3"=>"6", "7"=>"19"	f	t
400	Wallace Inc	Rem doloribus odit minus possimus. Nostrum incidunt occaecati error atque. Autem omnis omnis ullam officiis blanditiis ipsum libero autem. Esse reprehenderit reprehenderit minima aperiam vero.\n\nIpsam alias neque iure minima nobis. Distinctio quod laboriosam alias quas molestiae eveniet. Reprehenderit voluptates cumque veniam similique minus facilis repellendus modi.\n\nNihil officiis consequuntur nisi voluptate id eveniet maxime. Sint quaerat eaque totam vel. Beatae fugit quae quas.\n\nTemporibus consectetur sed natus commodi eius. Officia expedita facere dolorum cumque ipsam. Molestiae maxime quod harum minus nam repellendus laboriosam dignissimos.\n\nEum veniam neque occaecati necessitatibus iste doloribus. Excepturi illo sequi atque excepturi quod officiis quod. Est accusamus debitis deleniti facere corrupti modi ullam.	60.21	\N	2017-12-02 22:51:35.299175+00	4	"3"=>"6", "7"=>"19"	f	t
401	Armstrong PLC	Reprehenderit occaecati deleniti illum corporis. Excepturi suscipit ut animi illum. Fuga est beatae accusantium perspiciatis commodi ut. Recusandae delectus omnis velit sint.\n\nEa neque aliquid architecto vitae culpa eum cumque. Impedit ea numquam sapiente ad impedit laudantium. Cum deserunt autem corporis tempora necessitatibus nisi minima odio. Quibusdam voluptates voluptatum alias. Enim omnis aut tempore laboriosam dolorum deleniti.\n\nOmnis quae provident expedita numquam aliquam deleniti nobis. Nulla reiciendis laboriosam eius aperiam deserunt. Nihil laborum blanditiis debitis asperiores doloremque veniam. Asperiores modi mollitia magni maiores.\n\nProvident voluptates nostrum maxime provident dolorem cumque sint. Harum illo veritatis et voluptates iste magnam recusandae.\n\nDistinctio nisi molestias praesentium ad eum id. Blanditiis explicabo qui alias occaecati pariatur. Officiis fugit ab laborum quo.	7.27	\N	2017-12-02 22:51:35.349849+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
402	Davis Group	Iure incidunt nam suscipit mollitia perspiciatis officiis. Minima doloribus voluptas ad quis maxime officia. Sequi pariatur quae natus exercitationem. Voluptates commodi suscipit nulla animi. Laudantium ipsum cumque ipsum placeat numquam velit repellat.\n\nAccusantium nisi ad quibusdam perferendis quis nulla. Placeat dolores veritatis harum quidem facilis deserunt. Exercitationem ullam excepturi consequatur rem perferendis. Repudiandae eaque aliquid natus hic qui consequuntur ut perferendis.\n\nDoloremque iusto temporibus alias qui at. Dolorum nobis mollitia voluptatem at. Tenetur similique eum inventore explicabo dolor numquam fuga.\n\nVoluptate saepe perspiciatis voluptatum nesciunt veniam hic quod. Et maiores doloribus illum itaque neque occaecati voluptas et. Consequatur dignissimos voluptatibus pariatur commodi nihil. Autem illo vitae impedit nulla.\n\nArchitecto nam odit necessitatibus iure earum ipsum. Eum deserunt esse maxime molestiae quas rerum. Exercitationem nemo iure labore.	4.75	\N	2017-12-02 22:51:35.39366+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
403	Wood-Bell	Non quis dolor aspernatur odit ullam. Ex ea commodi ipsa aliquid earum. Veniam quaerat voluptate doloremque error quaerat.\n\nVoluptatem eligendi numquam quibusdam et asperiores quae. Minima quo repellendus at mollitia voluptate reiciendis veritatis corrupti. Tempore sed eveniet ipsa dolor sit illo facere tempora.\n\nEum cumque eaque officiis tempore. Non necessitatibus minus amet molestias.\n\nIn autem non nostrum id quo neque deserunt. Aut ex ex laboriosam provident.\n\nSequi facere fugiat vel quos consequuntur animi. Vel atque facere doloremque sapiente. Distinctio aut harum a praesentium.	2.12	\N	2017-12-02 22:51:35.43316+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
404	Carney-Rodriguez	Illum vel enim laborum beatae impedit. Porro aperiam eos fugiat harum. Molestiae dignissimos occaecati iure facilis delectus distinctio cumque.\n\nRepellat sed mollitia eligendi aperiam quas rerum. Dolores in id excepturi dicta mollitia sapiente. Aperiam commodi animi laborum similique atque eum tenetur. Pariatur consequatur impedit quod odit autem.\n\nModi dolore magni at quisquam repellat omnis. Voluptatem quisquam ipsum quisquam. Voluptatum ab consequatur aperiam illo ut eveniet.\n\nCorrupti recusandae illum tempore sunt quo. Ut molestiae nihil ratione voluptatem. Id rem quae ut quis deleniti. Impedit corrupti enim placeat accusantium.\n\nCorrupti deserunt soluta laborum laborum similique accusantium voluptas. Ullam dolores accusamus minima modi. Expedita perferendis tempora maiores fugit voluptate dignissimos aliquid.	6.69	\N	2017-12-02 22:51:35.465845+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
405	Robinson, Harris and Joyce	Quia sequi et alias minus. Deserunt ipsum in adipisci voluptas voluptatibus occaecati.\n\nId tempore voluptas voluptates quo tempore magni ullam. Sunt inventore voluptatum optio officia sequi sequi consequuntur. Minima aut sapiente dolores aliquam at repellat temporibus. Quia dolorem minus a quo. Corporis inventore ipsam harum porro eius dignissimos sapiente.\n\nDistinctio sequi dignissimos voluptatum. Veniam nihil voluptates autem cum vero. Placeat hic nam molestiae culpa voluptatibus magnam minus.\n\nNumquam blanditiis delectus nesciunt excepturi dignissimos perferendis repellat. Voluptate consectetur quasi eaque numquam. Soluta et adipisci odio accusamus voluptatibus. Animi eveniet dolores ea occaecati corporis molestias. Quos possimus cumque reprehenderit eligendi vel ut temporibus.\n\nReiciendis aliquam recusandae quis. Tenetur numquam aut voluptatum. Expedita aliquid minus ex voluptates rem quis. Consequuntur veniam inventore eaque culpa eius laudantium.	73.78	\N	2017-12-02 22:51:35.510488+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
406	Frey-Noble	Temporibus molestiae nulla ab. Possimus aut cupiditate ea eaque nisi quas. Recusandae aliquid nisi amet dolorum tenetur recusandae.\n\nItaque corrupti reiciendis veniam rerum inventore numquam dolore. Sit dignissimos iusto sint beatae alias facere dolore fugit. At non voluptates accusantium eligendi ducimus sapiente deserunt. Itaque ab eos pariatur voluptatibus.\n\nRecusandae facere recusandae fugiat. Adipisci aliquam velit iusto.\n\nIllo reiciendis hic autem laborum voluptatem aut. Sed distinctio cum nostrum amet iste odit.\n\nEligendi reprehenderit optio vitae perferendis explicabo. Porro voluptatibus pariatur itaque in minus saepe explicabo. Quos voluptatem sapiente dolorem temporibus quos. Magnam aliquid recusandae quidem dignissimos magni.	13.10	\N	2017-12-02 22:51:35.542435+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
407	Marsh, Hernandez and Gonzalez	Amet accusamus quibusdam veritatis omnis nulla aut. Fuga numquam quisquam ex laborum rerum. Possimus blanditiis doloremque non. Perspiciatis laboriosam saepe dolorum quo corporis voluptatibus temporibus. Iste consequatur neque repellendus beatae eum qui assumenda.\n\nBlanditiis rem eos sunt praesentium. Consequatur excepturi voluptate occaecati maiores natus. Perferendis velit consequatur recusandae hic vel repellat. Non suscipit eligendi officiis aliquam illum.\n\nAspernatur iste quaerat odio quia. Eum veritatis et hic in enim blanditiis in. Earum reprehenderit sapiente adipisci fugiat ex amet ducimus veritatis. Nisi iusto ipsum magnam mollitia accusamus aperiam.\n\nPerferendis nobis numquam fugit numquam ullam. Earum vero rerum nemo nam id. Molestiae iste tempora deleniti animi reiciendis voluptate. Cum officiis exercitationem architecto amet tempora.\n\nMinus ex magnam non molestiae aliquid dolorum. Illum adipisci facilis ducimus alias. Asperiores totam omnis minima blanditiis cumque vel.	79.14	\N	2017-12-02 22:51:35.601415+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
408	Spears, Mills and Hurst	Eos odio saepe consequatur occaecati. Dicta libero laboriosam repudiandae occaecati placeat ad. Recusandae repudiandae quia eveniet voluptates ut dicta. In blanditiis officiis incidunt magni officia veniam dolores.\n\nAliquam itaque odit tenetur aliquid. Unde atque eaque quibusdam quisquam ipsam. Ipsa deleniti amet accusamus sequi fugit. Excepturi distinctio nihil voluptatibus. Praesentium veniam esse voluptas consectetur quia necessitatibus.\n\nDeleniti modi corporis fugiat ullam nobis cumque officia. Suscipit officiis debitis hic magnam. Sint quas quae ut eveniet.\n\nDolore reiciendis excepturi omnis maxime odio earum reiciendis. Atque iure a ex. Distinctio quisquam impedit dolor eos pariatur iure a. Perferendis cumque error corporis consequuntur cum minus soluta.\n\nNam suscipit sint voluptatem asperiores ullam id. Nesciunt accusantium harum numquam soluta quas vel eaque. Officiis assumenda nemo ea odit soluta. Pariatur aperiam expedita saepe fugit officiis rerum. Voluptates ex corrupti vel aut eos soluta maxime.	78.38	\N	2017-12-02 22:51:35.633159+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
409	Richardson and Sons	Consequuntur necessitatibus aut reprehenderit libero laborum expedita. Velit unde commodi accusantium quod mollitia consectetur illum. Rerum maiores repudiandae sequi odit quia amet fugiat.\n\nCulpa quibusdam perspiciatis fuga repellendus inventore minus saepe nam. Id quae fugit ex animi. Consequatur quos et dolorum perspiciatis aliquam maiores soluta sed.\n\nQuidem quod minima voluptatibus sunt pariatur aspernatur ratione. Nulla enim omnis tenetur provident quis magni accusamus. Aliquam temporibus amet qui natus mollitia mollitia excepturi.\n\nLaborum quibusdam exercitationem at deleniti consequatur neque. Sapiente consectetur repellat deleniti beatae sunt. Perferendis non maiores voluptates ratione labore.\n\nMaiores iste quidem a accusamus atque iste. Architecto occaecati maiores sequi cum. Commodi excepturi provident numquam iste incidunt ipsa. Praesentium autem aut pariatur excepturi quas nisi in.	47.00	\N	2017-12-02 22:51:35.672566+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
410	Martinez Group	Nobis debitis beatae voluptatibus culpa quos. Saepe fugiat magni reprehenderit minima. Laboriosam neque expedita ab asperiores numquam ducimus architecto. Laborum et eos veniam quas.\n\nOptio quod mollitia dicta perspiciatis. Deleniti nisi incidunt distinctio iure numquam quia veritatis. Ducimus unde quod suscipit expedita sapiente quisquam laboriosam.\n\nQuasi sit quidem at sunt nesciunt dolores. Commodi quibusdam quasi ipsum. Est natus amet at tempore deleniti recusandae delectus. Mollitia consequatur tenetur ipsam dolor amet.\n\nVoluptate alias aliquid hic commodi saepe. Numquam incidunt aperiam fugiat veritatis ipsam. Eius occaecati iure culpa iure minus dolores. Eos porro provident nemo eaque.\n\nNobis voluptatem natus harum sit aut enim sint. Laborum quo omnis exercitationem ipsam temporibus quidem. Facere praesentium earum aliquam. Sint repellat assumenda nemo numquam adipisci hic.	80.95	\N	2017-12-02 22:51:35.702701+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
411	Douglas, Cunningham and Mcbride	Eaque totam vitae sit reiciendis. Sunt aspernatur cum dicta. Unde omnis iste doloribus dolores laborum.\n\nAliquid labore aliquam tempora aspernatur quas modi mollitia. Distinctio autem illo possimus officia quo veniam ut. Eum amet qui fugiat ullam iste. Reprehenderit vero sit dolores porro.\n\nDicta eligendi harum velit consequuntur repudiandae. Officia possimus corrupti quis sed voluptas. Officiis molestias id impedit non esse ipsam molestias.\n\nReprehenderit repellendus eius animi neque similique. Magnam modi nihil quis reprehenderit ad dicta. Laboriosam itaque perferendis repellat vero.\n\nEius quisquam iste distinctio incidunt quo. Exercitationem harum consectetur molestias assumenda voluptatibus. Natus consectetur quia temporibus aut perspiciatis unde esse. A aliquam vero aliquam architecto omnis. Eius quos corrupti occaecati debitis temporibus harum.	6.60	\N	2017-12-02 22:51:35.729283+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
490	Becker, Bauer and Santos	Numquam pariatur laborum quidem dolore sunt nemo sit. Unde et harum doloremque unde asperiores aut nemo corporis. Animi quibusdam laborum aspernatur incidunt dolor vero veritatis tempora. Est iste natus qui vero blanditiis.\n\nNeque quae blanditiis dolorem optio. Nemo nemo atque harum atque ut. Asperiores laudantium unde itaque.\n\nAut odit corrupti quo hic blanditiis. Est facere odio quidem eveniet doloribus. Quasi quam libero neque ad sed ratione.\n\nNeque eius facere sunt perspiciatis aliquam repellendus quam. Pariatur numquam eaque molestiae quos. Rerum tempore velit ut quidem inventore labore.\n\nNisi minus nobis distinctio quos amet consequuntur et. Ipsum laborum sint ullam repudiandae dolor nam totam perspiciatis.	50.12	\N	2017-12-06 15:00:01.02191+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
491	Davis, Thomas and Snyder	Totam cupiditate tempore nisi asperiores mollitia vel tempore repellat. Qui vero nostrum laudantium cumque iusto.\n\nOfficia temporibus blanditiis nobis in totam consequatur. Aliquam ratione minima neque eveniet reiciendis dignissimos modi possimus. Iste doloremque officiis eum minima est aspernatur.\n\nError sequi aliquam voluptate qui harum. Atque recusandae officiis magnam in ut.\n\nSint nesciunt repellendus natus necessitatibus consequuntur modi a cum. Facere quia expedita laborum perferendis.\n\nAb velit rerum ratione unde similique laboriosam provident cumque. Doloribus voluptatibus labore rem voluptates impedit quis laudantium. Hic inventore perferendis cumque laborum vero. Similique modi unde asperiores quo laborum.	82.60	\N	2017-12-06 15:00:01.065672+00	2	"3"=>"6"	f	t
412	Gilbert Ltd	Libero rerum voluptatum nisi itaque provident labore. Reiciendis nam doloribus dolor in. Minima fugiat repellat veritatis unde.\n\nEveniet dignissimos sequi id odio enim sequi. Eligendi veniam eos maxime. Eligendi explicabo repellendus omnis fugit.\n\nAliquam occaecati distinctio sit repellendus. Rem porro deleniti facere laudantium maiores sequi. Corporis quas laborum maiores id laboriosam molestias tempore.\n\nSunt nostrum delectus necessitatibus cum deleniti. Maxime natus recusandae neque. Necessitatibus voluptatum consequuntur vero occaecati. Sequi praesentium voluptatum magnam doloremque possimus totam.\n\nPerferendis blanditiis laboriosam soluta cum distinctio. Animi sint tempora debitis asperiores eaque inventore similique quisquam. Aliquam ipsum molestias consequuntur fugit totam. Voluptatem asperiores inventore est.	44.10	\N	2017-12-02 22:51:35.761393+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
413	Anderson, Scott and Long	Omnis sequi adipisci quia quasi. Unde assumenda dicta dignissimos cumque consequatur earum. Perferendis vitae impedit nemo dolores nesciunt culpa corrupti. Quasi nihil odit fugit.\n\nNeque a doloribus sint quisquam. Occaecati nostrum porro praesentium maiores esse eligendi temporibus. Ullam deserunt commodi facilis ab ducimus vel ratione. Consequatur quisquam mollitia veniam consectetur qui corrupti quas.\n\nArchitecto quia sequi neque tenetur ab debitis molestiae. Nostrum cumque a maxime architecto maiores. Molestias ea enim nemo blanditiis repellat ipsa. Iste quisquam necessitatibus blanditiis dignissimos consequatur dicta. Molestias voluptatum impedit rerum amet quam impedit.\n\nVitae itaque maxime officia fuga impedit soluta repellendus. Consequatur voluptates reiciendis quo delectus vel voluptates optio. Facere voluptatem earum ad blanditiis deserunt. Perferendis quam voluptas voluptatum voluptas cum ut.\n\nOfficia sint error eos minima ipsam labore. Nihil numquam dicta perferendis amet nostrum. Dolores molestias id magni nostrum officia. Earum adipisci eos aliquid omnis provident.	35.81	\N	2017-12-02 22:51:35.790169+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
414	Stewart, Nelson and Martin	Odio ab doloremque placeat deleniti. Ab nesciunt voluptatum omnis nobis praesentium nulla. At a expedita eos voluptate error nisi.\n\nSequi quam molestias tenetur molestias odit omnis. Ipsam voluptatum omnis quam debitis optio quis. Esse quasi saepe rerum officiis. Minima maiores nesciunt dolorem atque iste inventore repudiandae.\n\nQuia eos aspernatur libero aut nostrum. Nostrum cupiditate alias incidunt molestias mollitia blanditiis nam in. Reprehenderit doloribus odit minima facere consectetur.\n\nMaxime voluptas reiciendis quasi libero quos ea cum debitis. Culpa vitae in qui nisi vero. Deleniti delectus cum necessitatibus cum et.\n\nLaudantium ipsa eius expedita nemo fugit. Repellat a repellat vel nostrum veritatis vero eum autem. Dolor mollitia qui qui saepe inventore nemo dolorem.	48.73	\N	2017-12-02 22:51:35.829208+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
415	Stevenson-Mendoza	Fuga maiores molestias aperiam amet voluptatibus impedit nesciunt. Consequuntur delectus porro doloribus quaerat harum minima labore. Atque deserunt laboriosam at molestias voluptas assumenda odio.\n\nOfficia nesciunt officia repudiandae quam unde alias. Ad unde quo distinctio ut. Laboriosam officiis sed sit perspiciatis incidunt velit.\n\nVoluptatum dolore dolore suscipit in. Iure officia sint id dolorem neque consectetur.\n\nSunt ab deleniti est aspernatur alias. Corrupti eius dicta exercitationem. Similique unde praesentium temporibus nobis. Cumque ad temporibus eveniet voluptas expedita.\n\nVeritatis cupiditate vero est nihil nulla. Vel debitis quod qui sed. Incidunt explicabo modi ducimus dolore.	25.29	\N	2017-12-02 22:51:35.865128+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
416	Green Inc	Consequatur id similique quasi reiciendis iusto omnis. Tempora dicta officia vitae. Laborum a iusto exercitationem amet. Earum reprehenderit aspernatur nam.\n\nDolorum voluptatum consequuntur voluptatem exercitationem commodi. Iste doloribus quae sapiente aspernatur ducimus doloribus esse eos. Voluptate iure magni tempora quae quo quo. Accusamus molestiae nisi odit quo illo.\n\nEnim minus debitis harum repellat possimus corporis. Sint sequi vero autem voluptatem nostrum. Eius fuga dolorum perspiciatis adipisci alias ducimus incidunt. Culpa explicabo sed necessitatibus fugit qui.\n\nUnde placeat sed voluptas non expedita repudiandae rem. Sed quasi possimus dicta illo tempora. Sequi vitae soluta vel pariatur aliquid ratione.\n\nMagnam consectetur minus dolores accusantium blanditiis dolorum veritatis. A dolorum asperiores veritatis vero rerum autem facere velit. Assumenda repudiandae ut quas totam asperiores voluptates delectus. Fugit fugiat officia eum excepturi atque.	38.35	\N	2017-12-02 22:51:35.897481+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
432	Hoffman-Duncan	Similique ad quasi dicta dignissimos aspernatur. Esse culpa eos cumque molestias delectus. Dolores itaque consectetur rem aut. Saepe eaque nisi natus a eius magni.\n\nCupiditate sapiente voluptatibus suscipit dolorum illum possimus. Laudantium quibusdam repellendus culpa quisquam. Doloremque neque repellendus optio voluptatum incidunt porro esse recusandae.\n\nMolestias minima mollitia adipisci natus iusto quae. Odit cupiditate consectetur quasi atque temporibus. Quidem maxime ipsa totam molestias maiores. Laudantium provident magni reprehenderit quasi.\n\nEum mollitia officiis officia eaque exercitationem magnam. Atque est unde voluptate maxime. Optio delectus beatae tempora dignissimos.\n\nDucimus accusamus consectetur placeat mollitia quaerat adipisci. Commodi ratione est necessitatibus voluptas adipisci cum aliquam debitis. Qui quasi corrupti occaecati officia iste itaque.	43.96	\N	2017-12-03 17:37:28.561769+00	2	"3"=>"6"	f	t
433	Fry Inc	Quia consectetur magni quae iste dolor. Atque eius repudiandae modi. Iste odit esse at culpa voluptatibus voluptate. Laboriosam dolores accusantium dolorum dicta tenetur perspiciatis quasi.\n\nPossimus iure saepe pariatur inventore adipisci dolorem aspernatur. Eaque magnam quia consequuntur provident possimus. Ipsam laboriosam incidunt enim in amet iste corporis.\n\nCommodi veritatis consequatur quas illo. Dolorem ipsa voluptate quasi. Quod cupiditate maxime eligendi magnam possimus. Iusto dolorum numquam id doloribus ea.\n\nSapiente minus dolor amet nam impedit iste quod. Dolorem debitis aut ad assumenda. Sit blanditiis dicta at ipsam ea quam minima.\n\nPlaceat provident iste praesentium modi assumenda neque. Voluptatum qui delectus nesciunt consectetur. Natus alias quo dolore consectetur. Recusandae odio deleniti minus.	99.93	\N	2017-12-03 17:37:28.593603+00	2	"3"=>"6"	f	t
417	Coleman-Campbell	Laudantium dolor odit corrupti reprehenderit aliquam. Impedit quia et quia minima. Exercitationem possimus cum at eligendi exercitationem numquam qui.\n\nLabore neque quae ratione placeat iste culpa. Reprehenderit ab dolore delectus voluptatem laudantium dolor. Distinctio rem ratione odit magnam. Nisi saepe corrupti ut laboriosam in nulla voluptatem.\n\nOptio alias delectus perspiciatis corporis maiores quis exercitationem vero. Ipsam harum eius error necessitatibus accusantium dolorum. Nemo molestias necessitatibus eius modi.\n\nDolore temporibus rerum porro ea aut. Veritatis voluptatibus dolores commodi natus quae nihil. Unde ex cum soluta consectetur mollitia sit ea. Dicta natus cupiditate cupiditate optio dolorem quaerat dolore.\n\nSimilique eum at sit voluptate quaerat. Possimus dolorem vel fuga non dolore in. Omnis sapiente culpa repellendus officia rem quisquam sunt quas. Reprehenderit impedit eaque at magni.	21.36	\N	2017-12-02 22:51:35.932595+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
418	Mccullough-Jennings	Molestias cumque sint quis vero perferendis maxime facere. Nobis pariatur doloribus a. Vero magnam cum reprehenderit suscipit architecto possimus accusamus quisquam.\n\nQuia aliquid quia eius. Cumque est nihil enim provident maxime culpa. Sunt alias animi vero repellat praesentium. Tempore nesciunt eum ab maiores voluptas magnam. Incidunt accusamus quam provident sequi natus nemo molestiae quia.\n\nEnim perferendis excepturi sapiente. Voluptatum minus non architecto deleniti in. Perspiciatis nulla quasi et quasi. Natus saepe tempora est.\n\nAliquam sunt neque est temporibus quas. Corrupti reprehenderit sapiente ipsa ducimus.\n\nIusto autem ab inventore totam. Ipsum consequatur quisquam ab veritatis earum modi non. Voluptatum quae ea ut sed. Expedita dolores voluptatum dolor.	2.32	\N	2017-12-02 22:51:35.975911+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
419	Welch-Simmons	Molestias quam accusantium adipisci ullam aliquid atque natus. Ut eaque quod consequatur quis quos asperiores aperiam. Illo eos cum ad excepturi cum autem vitae.\n\nEa placeat animi eum earum blanditiis ex aperiam. Iure magnam explicabo ipsum voluptatum suscipit illum eum. Itaque dolores eaque id possimus. Magni quam fugiat quos quaerat quibusdam.\n\nUt officiis sint nostrum nostrum aperiam. Temporibus quos est molestias maiores sit a laudantium. Odio veniam temporibus dolor adipisci id. Error illo magnam nesciunt sit sequi.\n\nSit velit iusto omnis libero qui. Illo magnam ducimus excepturi dicta culpa. Exercitationem quas atque non tempore provident dolorum voluptatum odio.\n\nNihil magni nihil dolores sunt illum. Suscipit voluptas minima incidunt repellat dolorem. Et numquam natus sunt architecto laboriosam ipsa. Repellat exercitationem autem facilis excepturi reiciendis.	24.50	\N	2017-12-02 22:51:36.007212+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
420	Jordan-Hall	Corporis voluptas corporis blanditiis culpa libero magnam. Officia recusandae sit voluptatem assumenda praesentium. Magnam excepturi nemo officiis.\n\nEarum placeat quibusdam esse. Quos iure architecto excepturi distinctio. Nam quibusdam unde dolore provident.\n\nEaque suscipit placeat iure dignissimos minus a vitae perferendis. Nam necessitatibus nam cupiditate sequi.\n\nVelit debitis cupiditate amet molestias aperiam minus. Voluptate nesciunt enim eum voluptatum. Tempora voluptatum libero dolores eos ex labore facere at. Id modi maxime pariatur et necessitatibus tenetur.\n\nMaxime perspiciatis placeat ipsum ratione perferendis in dolorem nesciunt. Consectetur odio quas sunt maxime impedit doloremque. Quas a aut doloribus aperiam eveniet aliquid.	25.53	\N	2017-12-02 22:51:36.039602+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
3	Fischer, Lang and Mejia	Iste id quos fuga facere et. Necessitatibus sed similique illum neque aspernatur dolores. Maiores voluptas corporis nostrum accusantium repellat. Iusto cumque impedit exercitationem.\n\nIure perferendis maiores fugiat nihil delectus. Aperiam sapiente expedita eligendi reprehenderit. Incidunt aliquid cupiditate itaque odit sequi. Veniam error rem deleniti excepturi mollitia ipsum voluptates.\n\nFacere voluptas architecto a sit vitae amet assumenda. Eum odit dolor doloremque iusto dicta velit atque. Molestiae et tempore at harum fugiat tenetur facere aliquid. Ullam quam velit porro itaque. Fuga consequatur sequi at laudantium.\n\nVoluptate tempora sint officiis alias nesciunt debitis unde. Necessitatibus nemo voluptatibus quae. Velit quae accusantium cum dignissimos amet tempora.\n\nEum sit sit earum in ipsam quibusdam quibusdam ullam. Doloribus dolores et esse dolore nisi accusamus. Placeat neque dignissimos nisi asperiores nam reiciendis reiciendis. Repudiandae quaerat explicabo omnis ratione consectetur.	21.57	\N	2017-11-22 20:26:54.253688+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	t	t
36	Wilcox-Hickman	Nisi doloribus sed vero tempora quidem perspiciatis nihil. A doloremque magni placeat ullam. Quas earum dicta commodi cum perspiciatis. Architecto quo expedita ullam culpa nihil porro error.\n\nSoluta repudiandae perferendis asperiores quasi atque quos laboriosam. Ducimus atque cupiditate distinctio incidunt atque blanditiis. Ea saepe asperiores necessitatibus temporibus perferendis. Dolorem culpa nam et perferendis voluptatibus.\n\nDelectus eligendi cum repellat officiis inventore. Error voluptates nesciunt voluptatem dolores temporibus numquam. Est laboriosam soluta repellendus error quibusdam quo praesentium. Animi repellendus tempore expedita enim doloremque illo.\n\nMaiores aliquid et dolorem impedit animi voluptatum. A esse ullam ad saepe. Totam minus aspernatur nobis deserunt.\n\nAccusantium ipsa dolor culpa ducimus maiores quidem corrupti eaque. Quidem sit reiciendis consequuntur est quam nemo dolor. Odit itaque maiores veniam non voluptas optio ut. Dolores incidunt eveniet facere provident eos.	34.65	\N	2017-11-22 20:26:55.893868+00	4	"3"=>"6", "7"=>"20"	t	t
272	Wood, Williams and Robbins	Laudantium mollitia id quis nam quisquam. Ducimus dolorem beatae temporibus illo autem ab.\n\nAccusantium quam ipsum dolorem quas est quis culpa optio. Dignissimos architecto quo perferendis alias aliquam inventore reprehenderit. Occaecati placeat autem iusto neque eos natus. Impedit distinctio fugit alias repellendus.\n\nRatione earum quia debitis aliquid reiciendis. Soluta incidunt dolorem sit totam. Error veniam dolore error autem numquam.\n\nOptio dignissimos sit inventore iste qui provident sed. Distinctio iste quo velit deserunt neque quasi sit. Eos ad officia incidunt voluptatem modi. Et a id deserunt temporibus quisquam. Ad velit autem voluptas accusantium.\n\nRepudiandae qui architecto voluptatum neque. Vero architecto hic deleniti assumenda. Quis exercitationem rem quidem quod. Iure ipsum nesciunt iure consequatur.	31.47	\N	2017-11-28 00:10:04.815399+00	4	"3"=>"6", "7"=>"20"	t	t
296	Rodriguez-Dixon	Pariatur quisquam eius sapiente itaque minima. Dolorem porro quisquam optio tenetur. Necessitatibus cupiditate repellat adipisci expedita vero eveniet. Quas distinctio sed a ratione sapiente tempora vero. Dolorum laborum quisquam dolor similique consequuntur excepturi.\n\nDolorum necessitatibus quos sunt ipsam sequi provident repellat. Quod beatae necessitatibus molestias accusantium sed reprehenderit.\n\nSimilique eum iste illum perferendis. Reiciendis sunt ut blanditiis laboriosam ex quibusdam eius atque. Dolorum natus odio esse.\n\nVelit magnam voluptates quod recusandae. Accusamus libero ducimus iure consequuntur animi tempora. Quam hic rerum atque aliquam minima.\n\nUt eius saepe enim cum perferendis. Expedita optio tempore laborum asperiores unde dolor. Tempore quos quibusdam vel excepturi incidunt harum.	55.46	\N	2017-11-28 00:10:05.783352+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	t	t
318	Aguilar Group	Quibusdam quasi veniam inventore ipsam commodi voluptate tempore. Repellat eligendi quisquam sit qui occaecati eum cupiditate dicta. Earum doloremque eaque voluptas optio explicabo laboriosam. Quia doloribus illo aut distinctio accusantium consectetur nesciunt officiis.\n\nExercitationem beatae officia maiores dolore magnam sequi molestiae voluptate. Voluptatum impedit sequi eaque quia. Officiis dolor odit accusamus explicabo. Voluptatibus suscipit velit consequatur qui ea neque.\n\nNumquam laudantium voluptate ipsam. Architecto cupiditate pariatur libero. Officiis cumque ab repudiandae eos odio necessitatibus dignissimos. Unde nihil eos accusamus ipsam quibusdam.\n\nQuibusdam porro neque aspernatur. Eos libero ipsam laudantium minima odit quibusdam sed. Exercitationem facere ex nam id minus modi quia. Eos soluta molestiae eum mollitia fugit fugiat dolorem.\n\nEsse voluptatem voluptate quos perspiciatis deserunt veritatis optio. Nemo eaque nemo fugit autem reprehenderit nulla voluptatum. Recusandae corrupti suscipit aliquid eius assumenda nisi quibusdam officiis.	71.99	\N	2017-12-02 22:21:08.26674+00	2	"3"=>"6"	t	t
421	Hogan, Schaefer and Miller	Ex explicabo enim porro deleniti. Neque qui consequatur placeat qui maiores non voluptate. Repudiandae accusantium itaque doloribus porro consequatur maiores ratione. Repellendus fugit quam nisi facere.\n\nVoluptatum atque corporis soluta vero. Nihil facilis earum est amet unde fuga accusamus. Blanditiis minus similique nihil cupiditate alias autem iure.\n\nOptio quasi expedita at repellat fugit aut itaque odio. Illo provident ad quisquam sequi cupiditate quasi. Suscipit consequuntur rerum dolor consequatur sit officiis nulla. Dignissimos impedit at velit atque.\n\nMaiores ea pariatur atque maiores itaque sint. Quae iusto voluptates non mollitia odit. Possimus dolor laboriosam corporis aperiam consequatur quidem.\n\nSunt voluptatum soluta nam dolore ea accusantium. Quia voluptatibus qui voluptatibus repudiandae qui omnis.	93.59	\N	2017-12-03 17:37:27.902285+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
434	Vincent-Mcguire	Soluta totam officiis nostrum. Sunt suscipit ducimus animi provident molestias necessitatibus quasi. Asperiores iure aperiam itaque quibusdam architecto. Suscipit a cum mollitia eos.\n\nDistinctio optio eos non accusamus labore distinctio delectus. Aliquid sequi cum deleniti quibusdam laborum ducimus. Laudantium ullam architecto cupiditate vitae voluptate veniam.\n\nCulpa quibusdam sequi officia pariatur consequuntur. Maxime incidunt explicabo provident quam atque harum. Aperiam quidem omnis officia dolorum. Corporis neque laboriosam expedita animi.\n\nAssumenda beatae eum expedita voluptatum vero. Quos voluptas omnis suscipit amet.\n\nAutem rem earum asperiores fugiat temporibus. Ad velit nulla numquam veniam corrupti tenetur. Cum odio ea doloremque et optio a iusto. Dolorem temporibus delectus dolorum quod neque.	56.95	\N	2017-12-03 17:37:28.617571+00	2	"3"=>"6"	f	t
435	Meyers LLC	Minus exercitationem quidem blanditiis tempora voluptate vero. Veniam fugit eligendi deleniti tempora unde.\n\nExplicabo molestias veritatis perferendis repellendus necessitatibus atque. Eveniet harum dignissimos veniam ipsam. Nesciunt laudantium aliquid nulla minus eos tempora. Consequatur iusto saepe dolor est aut quisquam perspiciatis nemo.\n\nEst corporis consectetur ut eveniet suscipit. Cum atque iure fugit quisquam tempore unde. Debitis iusto a ratione perspiciatis.\n\nRepudiandae ex ipsam necessitatibus optio. Cum voluptatem quia veniam asperiores voluptatem saepe incidunt ex. Non molestias praesentium occaecati.\n\nIncidunt atque excepturi vel. Quasi dolorem eligendi dolorum molestiae. Dolorem dicta non sapiente perferendis maiores adipisci vitae dolor. Cum maxime perspiciatis iusto laborum vero sit vero.	32.19	\N	2017-12-03 17:37:28.690965+00	2	"3"=>"6"	f	t
422	Harrison, Carey and Cook	Temporibus id unde asperiores quaerat quidem expedita. Optio minima dolore incidunt quibusdam. Inventore nihil cumque temporibus soluta numquam eius maiores nemo. Inventore minus aut ab sit. Amet at hic cupiditate molestiae quibusdam fugiat.\n\nQuam velit nihil natus repellat. Sint perferendis nam nihil ipsa magnam laudantium. Et laborum quidem iure earum magnam dolorum.\n\nDelectus architecto reprehenderit eligendi tenetur sapiente deserunt recusandae. Incidunt perspiciatis sit placeat a est commodi. Vitae eaque reprehenderit amet.\n\nNisi aperiam deleniti repellat sint fugit harum voluptatem. Optio officiis voluptatum fuga inventore natus facere numquam. Recusandae similique et adipisci dolore. Facilis deserunt ipsa corporis quis omnis reprehenderit doloribus. Nobis in nemo porro voluptas ea.\n\nDistinctio non quaerat quaerat. Fuga fugiat rem nesciunt odit facere suscipit expedita totam. Quibusdam dolorum doloribus quibusdam consequatur consequatur nemo voluptates.	62.94	\N	2017-12-03 17:37:27.985373+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
423	King Ltd	Aspernatur eos est placeat ipsum consectetur. Adipisci eveniet culpa illum a temporibus quisquam. Atque libero consequatur sint rerum quas. Nisi totam architecto deserunt iure veniam non repellat.\n\nPerspiciatis neque asperiores repellat repellendus atque. Magni quasi dolores molestiae eveniet. Fugiat odit ducimus aut perferendis amet. Quo vero quo maiores in deleniti alias.\n\nSimilique velit voluptatibus unde nesciunt aliquam. Veritatis voluptatum placeat ex tempore laboriosam earum impedit. Sit expedita eligendi nulla corporis modi fuga alias nostrum. Nihil autem perspiciatis reiciendis repellendus necessitatibus cumque laborum maiores. Iste facilis fugiat laboriosam eius.\n\nDolorem aliquid quae architecto maiores eius necessitatibus. Consectetur ratione dignissimos dignissimos adipisci similique cumque. Corporis ducimus aut eum fuga iure doloribus magni.\n\nQui sequi quasi beatae itaque suscipit quis corporis. Quisquam voluptatibus nisi sit hic sequi. Saepe quasi quisquam eveniet. Consequatur sapiente vitae quod quisquam delectus nostrum. Ut incidunt a quisquam quaerat exercitationem optio minus.	44.61	\N	2017-12-03 17:37:28.031946+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
424	Taylor-Fleming	Ad fugit tenetur dolore esse culpa illum. Autem provident architecto non exercitationem odit.\n\nExpedita consectetur voluptas fugit. Vitae dolorem magni sit totam. Tenetur quaerat cumque iure placeat minima reiciendis deleniti.\n\nMolestiae nobis animi blanditiis quod. Totam ipsam minus tempora maiores necessitatibus fugit recusandae. Iure dolorum minima suscipit quasi illum nisi neque.\n\nModi vel libero perspiciatis aut iusto debitis. Voluptatibus numquam eius quasi veritatis. Autem consequatur numquam cupiditate necessitatibus. Praesentium excepturi fugit error.\n\nDolor quasi dolore nam fugiat. Iure eius esse distinctio voluptates praesentium nobis sunt. Neque veritatis corrupti quas. Vero ea sed qui.	36.83	\N	2017-12-03 17:37:28.084896+00	1	"1"=>"2", "2"=>"3", "3"=>"6"	f	t
425	Smith-Hayes	Illo ex consequuntur impedit fugiat architecto. Commodi vel consequatur veniam perferendis illum ab. Facilis explicabo eius omnis placeat error laboriosam veniam.\n\nModi pariatur blanditiis libero. Quos odit cupiditate totam magni labore eius mollitia.\n\nOdit molestiae et harum quo dolorum error distinctio. Mollitia culpa placeat ratione doloribus maxime. Perspiciatis esse non quo.\n\nCorporis adipisci inventore sed cupiditate eius consectetur libero. Commodi debitis recusandae modi nemo eveniet tempore rem. Ad atque dicta fugiat iusto a enim fugit. Saepe illum nulla dolores nobis recusandae.\n\nIste ratione neque iste assumenda. Voluptatibus sint vero architecto praesentium. Accusantium vitae quas dolor qui. Accusamus cum reiciendis fugit veritatis officiis. Laborum ipsam dignissimos rem iusto accusantium.	87.80	\N	2017-12-03 17:37:28.148857+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
426	Oneill Ltd	Excepturi iste dolore delectus voluptatem explicabo ipsa. Labore veniam velit sapiente dicta enim dolorum. Assumenda saepe accusamus ducimus debitis temporibus odit.\n\nTenetur cumque ab nisi nihil nobis esse nulla. Consectetur impedit animi laboriosam similique saepe velit similique. Natus distinctio atque incidunt dolorum sequi.\n\nEx fuga dignissimos fugiat explicabo. Voluptatibus doloremque harum quae consequatur molestiae. Natus suscipit quos dolor accusamus.\n\nQuae quidem cumque consectetur quos enim et quae. Voluptatibus inventore ipsam porro nemo dolorum accusamus. Voluptas sequi debitis tempore sint. Itaque quas libero officia iure consectetur nesciunt aliquam. Illo beatae ducimus ex libero possimus occaecati.\n\nNostrum commodi dignissimos iusto sint repellat. Repellendus ratione exercitationem labore. Saepe laboriosam vel iure quia ipsa.	98.60	\N	2017-12-03 17:37:28.2122+00	1	"1"=>"2", "2"=>"5", "3"=>"6"	f	t
427	Bartlett LLC	Sed corporis repudiandae rerum esse harum architecto. Fuga quaerat sed veritatis at aliquid. Deserunt sequi aut assumenda voluptates. Explicabo dignissimos asperiores ipsum nobis excepturi quasi enim.\n\nDeserunt vel quisquam temporibus iure ut debitis aut. Rem dolorum dignissimos odio possimus quasi et eos. Officia nobis sunt dolore perspiciatis voluptas. Corporis mollitia rerum distinctio nihil culpa nulla ipsum.\n\nId tempore eius magni. Magnam architecto explicabo ea itaque laudantium.\n\nEligendi dicta sed dolorum rem asperiores sapiente ducimus. Unde saepe quisquam repudiandae deleniti. Suscipit consequatur quis aliquam iste dolore.\n\nCommodi nobis est ipsam quaerat voluptatum aperiam nisi cum. Dolorum quasi veritatis minus eaque accusamus cumque. Nostrum ab vel ut error ab voluptatibus explicabo.	87.30	\N	2017-12-03 17:37:28.255254+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
443	Brown-Franco	Eius enim alias nihil fuga id iusto ut. Ad quasi optio corporis ut quaerat ea expedita.\n\nPlaceat ipsa magni aspernatur. Earum assumenda reprehenderit velit vitae natus. Qui dolorum vitae voluptatibus esse blanditiis.\n\nDignissimos quisquam et laborum ad. Doloremque velit accusantium laudantium aut numquam quidem pariatur. Vel tenetur maiores asperiores itaque non quis.\n\nRepellendus quo eaque velit. Beatae minus voluptatum laboriosam praesentium vero odit. Non maxime quia dignissimos magnam.\n\nEum fugiat perferendis fugiat dolore. Aperiam placeat nihil ipsam dignissimos. Dolorem quam voluptatum id quas architecto aperiam. Sit animi modi sequi facere impedit velit.	71.19	\N	2017-12-03 17:37:29.158916+00	3	"3"=>"6", "5"=>"13"	f	t
428	Serrano Inc	Molestiae officiis nisi dolorem optio. Reprehenderit ullam nemo non esse soluta repellat. Accusantium facilis voluptatem odio a facere aspernatur.\n\nConsectetur perferendis sequi consectetur. Expedita cumque eius quidem consectetur. Beatae quae odit quibusdam maiores. Rerum ratione ab fuga.\n\nEos voluptates vitae illo officiis amet perspiciatis. Doloribus cum dolorem incidunt omnis ipsam voluptatibus. Hic voluptate sunt cumque dicta vero quia non aliquam. Saepe occaecati iure mollitia sunt ad molestias quas. Quibusdam animi enim molestiae adipisci doloremque quas excepturi.\n\nRecusandae eum consequatur doloremque voluptate dignissimos ad officiis. Delectus nulla quod excepturi quod. Cum quibusdam possimus est.\n\nTotam ad officia assumenda laborum ipsum voluptatum sequi. Accusantium natus expedita necessitatibus atque minima debitis ipsum placeat. Quo nulla veritatis provident corporis. Ex pariatur esse voluptates enim id ipsa ab. Iste ea tenetur fuga iusto.	88.22	\N	2017-12-03 17:37:28.306171+00	1	"1"=>"2", "2"=>"3", "3"=>"6"	f	t
429	Perez-Taylor	Aliquid aliquam expedita ut cumque possimus hic labore. Molestiae quis ea optio inventore libero velit. Sunt eveniet vel cupiditate assumenda nemo.\n\nDolorum ipsam quod iure quidem corporis voluptas. Pariatur perspiciatis dignissimos at sint provident earum.\n\nDignissimos aliquid ut voluptatum nisi nihil aliquid. Non cum cum saepe impedit corporis nam. Libero architecto nostrum velit tenetur mollitia. Quasi iusto tempora quaerat aspernatur quasi.\n\nBeatae id harum accusantium totam porro. Facilis impedit nesciunt expedita fugit autem.\n\nArchitecto veritatis modi commodi itaque sequi voluptatum placeat nostrum. Sequi corrupti atque id impedit praesentium facilis odit architecto. Amet sunt officia placeat amet maiores magni. Aliquid porro adipisci pariatur pariatur temporibus.	36.46	\N	2017-12-03 17:37:28.376342+00	1	"1"=>"2", "2"=>"3", "3"=>"6"	f	t
431	Davidson Inc	Illo saepe expedita tempore facere culpa nulla minus. Earum nemo dolorum eveniet. Non sunt suscipit quaerat id.\n\nNesciunt quisquam animi optio laboriosam sequi consequatur doloribus. Dicta ullam repellendus illum ipsum nam aut. Saepe voluptatibus enim doloremque cumque quibusdam temporibus. Saepe perferendis ratione aliquam ipsum ullam.\n\nMolestiae saepe minima provident doloremque dolorem cumque. Nihil vitae ab asperiores perspiciatis recusandae. Iusto odio consectetur possimus nostrum ea a dolore. Laudantium consequuntur tenetur sed alias voluptatibus voluptas nisi.\n\nNatus rem minima odio blanditiis consequatur. Corporis nostrum distinctio laboriosam ullam tenetur non consequuntur ad. Aliquid natus animi sed cumque officiis. Amet aut id corrupti iure. Nemo sed ipsam molestias aliquam.\n\nSaepe accusamus quas architecto fugiat optio. Ad deleniti magnam vel sit. Nam rem quae ipsa. Doloribus deleniti dolores id asperiores beatae nam.	4.84	\N	2017-12-03 17:37:28.500504+00	2	"3"=>"6"	f	t
430	Wright, Johnson and Li	Esse eum et quo qui explicabo. Deserunt deserunt ullam rem enim tempore. Vel modi maiores praesentium quaerat pariatur et. Commodi doloribus non est nesciunt odio.\n\nSunt harum quasi eveniet dolore fuga velit deserunt doloremque. Natus nobis consectetur ut dolorem.\n\nModi possimus veritatis odio quae repellendus. Fugiat officia asperiores dolores hic distinctio aliquid.\n\nDolores libero fuga odit deserunt cumque sunt possimus aspernatur. Numquam iusto quisquam rerum ratione voluptas.\n\nTempora non aperiam non ut qui. Explicabo eum nostrum iusto a eaque perspiciatis odio.	50.00	\N	2017-12-03 17:37:28.432094+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	t	t
436	Williams Group	Dolor repellat minus quae incidunt dolorem labore. Esse fugit minima nisi deserunt doloribus laudantium assumenda. Provident eos ipsam quos eveniet quibusdam. Laudantium incidunt consequatur odio autem harum. Alias labore libero dicta consectetur consequuntur similique praesentium amet.\n\nVeritatis perferendis fuga itaque aut repudiandae. Aliquam in in quaerat accusamus. Similique vitae quaerat voluptatibus. Itaque enim est in inventore soluta deleniti animi veniam.\n\nIllo neque porro perspiciatis beatae debitis veniam possimus. Dolor labore praesentium maiores praesentium quod perspiciatis possimus.\n\nQuis sapiente harum suscipit aut mollitia. Beatae ipsum nulla veritatis voluptas molestias sunt. Nobis harum ipsam voluptate accusantium voluptatem repellat. Magnam officiis explicabo excepturi incidunt blanditiis amet perspiciatis.\n\nRepudiandae quidem laboriosam temporibus ut repellat modi. Dolorum totam cupiditate molestiae culpa repudiandae tempore. Impedit voluptates quia reprehenderit fugiat cupiditate voluptatum.	51.71	\N	2017-12-03 17:37:28.753865+00	2	"3"=>"6"	f	t
437	Jackson, Lloyd and Bradley	Accusantium sunt sunt vero id labore iste. Dolorem alias in eius excepturi iure architecto. Molestias repudiandae ut minus quos itaque itaque. Sit quis minus explicabo voluptates et.\n\nRepellendus maxime ea fuga. Temporibus molestias eius tempora quaerat recusandae facilis. Suscipit rerum placeat repellendus dolorem quod nisi. Officia fuga et ipsa corrupti.\n\nMinima temporibus et debitis sapiente at maiores. Id soluta neque rem voluptatum impedit porro. Deserunt quod quidem doloremque pariatur animi. Reprehenderit eligendi eaque nam quasi nisi.\n\nNatus eos deserunt nemo incidunt ut. Dolorum saepe deserunt fugiat nostrum odit nulla doloribus sit. Iure porro eaque culpa aliquid cumque nostrum. Ratione laboriosam nam vitae.\n\nQuaerat eum consequatur suscipit. Doloremque corrupti maxime laboriosam incidunt aliquam vitae consequatur. Esse eos similique sed adipisci explicabo voluptas quia. Soluta ea inventore distinctio impedit saepe asperiores.	86.32	\N	2017-12-03 17:37:28.805217+00	2	"3"=>"6"	f	t
438	Sandoval, Schneider and Richards	Voluptate sit reiciendis voluptate maiores fugiat qui dolorum. Nostrum rem incidunt doloribus. Eligendi eum eos blanditiis id blanditiis. Facere fugit iste quia excepturi voluptates ut voluptatem.\n\nVitae dolorum distinctio blanditiis fuga aspernatur. Iste labore odit cum quisquam. Et dicta enim debitis et reiciendis amet vitae. Aperiam sit accusamus eos rem quo.\n\nExcepturi enim illum dolor cum praesentium quasi. Voluptatibus molestiae autem sunt ab accusantium ab.\n\nCorporis distinctio earum nesciunt laborum minima. Facere doloremque sed dignissimos aliquid. Necessitatibus debitis minima earum molestias quibusdam vel. Ipsum dolores itaque fugiat fuga sapiente.\n\nProvident minima inventore dolorem optio. Accusantium fuga cupiditate iste quis veritatis praesentium.	69.11	\N	2017-12-03 17:37:28.846925+00	2	"3"=>"6"	f	t
439	Moore, Taylor and Huang	Deleniti omnis provident perferendis laudantium totam ratione. Laudantium aut deleniti facere placeat aut. Sit eveniet eum dolorum maxime repellat.\n\nIste cum dicta odit voluptatibus vitae quaerat. Modi pariatur fugit sunt. Vero consectetur cumque voluptates architecto dolor. Velit iusto iusto occaecati porro ea accusantium est. Distinctio expedita occaecati exercitationem repudiandae vel hic impedit.\n\nFacere ullam a quis. Nulla ipsum ea rerum atque quam id optio. Fugiat sapiente ut ab. Consequatur incidunt unde id enim nisi dicta. Atque nemo eligendi animi nihil.\n\nSimilique animi quisquam fuga blanditiis voluptates error suscipit. Fuga voluptate harum consequatur dolores reiciendis tempora. Expedita amet quod optio pariatur laudantium. Recusandae quasi consequuntur odit beatae ratione at ex.\n\nDolores unde debitis neque nobis quis alias. Repellat nesciunt aspernatur numquam et eum dicta. Amet aliquam laborum error corrupti nesciunt vitae. Iure ratione doloribus quia eos.	38.41	\N	2017-12-03 17:37:28.893658+00	2	"3"=>"6"	f	t
440	Hall, Medina and Lewis	Delectus eius placeat vitae. Facere rerum tempore dolore. Tempore animi consectetur earum saepe tempore soluta.\n\nEveniet et quas assumenda veniam. Qui placeat repellat voluptate. Distinctio distinctio omnis necessitatibus blanditiis laboriosam non. Ab ea nulla ducimus iure.\n\nAssumenda asperiores laudantium corrupti. Quidem amet minima eum fugiat nulla corporis. Et ex inventore unde ipsum itaque. Et sunt eos incidunt itaque deleniti dolorum.\n\nUt sapiente perferendis eos unde. Enim architecto fuga quaerat at. Adipisci cupiditate ad deserunt eum nisi. Voluptatum fuga delectus voluptas facilis optio.\n\nAutem libero impedit quibusdam. Modi at sit voluptatum quis accusamus debitis. Corporis nam laudantium maiores adipisci quisquam ad. Atque ad velit rem rem totam repudiandae aut.	70.40	\N	2017-12-03 17:37:28.962551+00	2	"3"=>"6"	f	t
441	Cordova PLC	Ipsam fuga consectetur quia quaerat veritatis. Id at rem magni ea eius perferendis aperiam. Non tenetur nostrum laboriosam non fugiat autem minus.\n\nEos maiores veniam aut eligendi magni saepe illum odio. Id suscipit sunt eum exercitationem dicta. Eum provident commodi tenetur ut deserunt alias asperiores. Quas unde id libero consectetur amet sequi totam.\n\nLaudantium earum adipisci voluptates vel quas iusto voluptatibus. Reprehenderit repudiandae voluptates cumque repellat neque. Aperiam natus molestias eum beatae pariatur mollitia porro.\n\nReprehenderit laborum maiores dolorum animi dolorum non. Facilis ratione recusandae nemo totam dolorum deserunt at. Quisquam animi tempore incidunt animi recusandae repellendus quasi.\n\nSuscipit excepturi quia dicta maxime voluptatibus. Ipsam tenetur quod optio ducimus. Corporis laborum laudantium consequatur doloribus excepturi veniam non rem.	21.57	\N	2017-12-03 17:37:29.004646+00	3	"3"=>"6", "5"=>"14"	f	t
442	Barrett, Mason and Perez	Tenetur aliquid repudiandae necessitatibus quibusdam doloribus. Quisquam dolorum dolorem id amet porro atque. Corporis nihil tenetur veritatis praesentium.\n\nConsequatur iusto eligendi labore tenetur quisquam ullam error. Accusamus temporibus laboriosam aliquid quas consequuntur consectetur. Quae non perferendis tempore error nihil ipsum quam impedit.\n\nRepellendus minima distinctio animi veniam. Tempora similique soluta iste nam placeat. Aliquam optio facere corporis commodi deserunt sint omnis. Magnam at quibusdam quo blanditiis amet.\n\nPariatur quis nemo quisquam. Est labore accusantium provident unde natus. Illo ex ipsum enim nam debitis. Molestias optio cupiditate occaecati praesentium laudantium optio.\n\nEligendi aliquam praesentium aperiam occaecati. Accusamus vero pariatur rerum voluptatibus. Labore aliquid sit fuga totam nemo.	9.30	\N	2017-12-03 17:37:29.082093+00	3	"3"=>"6", "5"=>"13"	f	t
444	Martinez-Garrett	Sed neque eum fuga. Quidem sed dolorem quod fugiat. Sequi dolorum corporis modi aliquid.\n\nMaxime necessitatibus molestias tempora illo possimus rem. Veniam id repellat velit cumque eum libero consequatur ipsum. Ipsam voluptates labore perspiciatis quos voluptas. Esse doloremque odit minus enim.\n\nNobis accusantium possimus ducimus facere voluptatem quis placeat eum. Consectetur ab nostrum praesentium. Inventore aliquam fugiat reprehenderit ex nesciunt accusamus magni.\n\nId tenetur saepe fuga doloribus. Explicabo impedit laudantium ad placeat sint ratione placeat sed. Est occaecati aperiam ut facere a nihil odit impedit. Pariatur recusandae ducimus harum molestias accusamus.\n\nVero dignissimos dolores eos minus quo. Doloremque quidem laborum delectus voluptas eveniet ad. Repellendus ratione dolorem odit. Maxime pariatur sapiente voluptas placeat modi ullam. Occaecati eum quis doloremque repellat.	65.00	\N	2017-12-03 17:37:29.252603+00	3	"3"=>"6", "5"=>"14"	f	t
445	Briggs-Daniel	Voluptate quisquam veritatis eos. At officiis eos nostrum dolor aliquam vel rem. Similique iure hic ipsum vel veritatis.\n\nQuas placeat provident iusto error ut praesentium. Quisquam ea vitae laboriosam harum sint cumque iusto in. Quasi error suscipit atque doloribus fuga. Molestias dolore quae tenetur vel rerum.\n\nPraesentium totam odit magnam fugiat quis iste. Possimus ad qui et unde laboriosam. Numquam blanditiis et incidunt id nostrum.\n\nVelit exercitationem maxime voluptatem perspiciatis. Ducimus sit numquam rerum natus modi corporis. Sed libero ex tenetur aspernatur.\n\nQuas ab temporibus in sequi aspernatur. Temporibus voluptas facilis ipsam autem amet voluptatibus earum. Dolore laboriosam ab excepturi quas deserunt. Facilis aperiam eveniet exercitationem nulla magnam necessitatibus veritatis.	80.57	\N	2017-12-03 17:37:29.314497+00	3	"3"=>"6", "5"=>"14"	f	t
446	Cabrera Ltd	Voluptates nam fugit corporis velit accusantium est incidunt. Minus voluptatibus qui quisquam dolorem nobis. Harum ducimus dolorem et natus.\n\nTemporibus tempore ab reprehenderit dolores. Eligendi quos soluta quam animi voluptate minima voluptates. Harum maxime voluptate quis amet sed. Quo animi consequatur reprehenderit eligendi nam natus at nostrum. Similique explicabo eaque quam laborum ipsam quisquam.\n\nIncidunt modi eligendi dicta impedit. Illum ut consequatur minus accusantium dolorum. Perspiciatis voluptatibus voluptatibus a quisquam possimus id sapiente maiores. Eaque nobis corporis corporis cumque ab quos maiores.\n\nAccusamus esse itaque quo provident accusamus assumenda occaecati. Sequi impedit dolorum doloremque dolorem animi voluptas sequi ab. Similique fugiat est saepe unde exercitationem impedit impedit.\n\nError fuga dolor fugiat omnis temporibus. Magni soluta excepturi velit porro nostrum assumenda facere. Dolores quibusdam facilis adipisci nemo. Natus reprehenderit excepturi velit repudiandae quas sit hic.	3.60	\N	2017-12-03 17:37:29.42575+00	3	"3"=>"6", "5"=>"13"	f	t
447	Adams PLC	Ab fugiat consequuntur recusandae. Vel voluptas vero numquam possimus nesciunt. Alias molestias fugit natus recusandae.\n\nOccaecati facilis nostrum neque nemo libero quae fuga. Eaque distinctio vel et inventore in dicta sint. Corporis perspiciatis ullam quaerat. Nobis recusandae molestias dicta explicabo sapiente cum voluptas.\n\nReiciendis consectetur cumque at dignissimos. Quo tenetur officiis earum error cumque consectetur laborum. Ratione corrupti perspiciatis sit. Officia repellendus fugiat qui.\n\nOmnis ad quod ut voluptas repellendus aliquid earum. Aperiam illo quas accusamus delectus illum aliquid exercitationem ratione. Est similique numquam suscipit voluptatem voluptatibus odio.\n\nId repellat tempora quae veniam. Maiores placeat dolorem cumque sed fugiat.	47.61	\N	2017-12-03 17:37:29.496955+00	3	"3"=>"6", "5"=>"14"	f	t
448	Miller Inc	Quibusdam deleniti provident sapiente dignissimos possimus nostrum. Incidunt aut deserunt labore debitis enim praesentium rem occaecati. Numquam architecto neque expedita quae incidunt ducimus. Vitae blanditiis voluptatibus amet inventore.\n\nSint odit molestias repellendus ea dolorem ipsam sed. Dolore dolore voluptatibus unde omnis dolorem voluptate itaque. Minus optio sed dolorum culpa sint. Nesciunt officiis cupiditate totam quam.\n\nDeleniti similique voluptates temporibus labore. Molestias ab sequi illo vel deserunt nostrum blanditiis. Saepe doloremque alias harum quam voluptas veritatis temporibus.\n\nVoluptatem neque odio vitae. Architecto beatae repudiandae dolores itaque reiciendis fuga itaque. Aspernatur repellat laborum optio autem laboriosam expedita maiores. Nobis alias minus architecto non.\n\nQuae non mollitia voluptates at excepturi. Maxime nulla explicabo optio. Dicta expedita tenetur facilis ab laborum exercitationem. Maxime praesentium at ullam rerum.	57.80	\N	2017-12-03 17:37:29.563809+00	3	"3"=>"6", "5"=>"14"	f	t
449	Pearson, Lane and Davis	Distinctio dignissimos exercitationem mollitia esse. Reiciendis animi totam dolore dolor temporibus ex labore. Eaque et omnis sit ullam magnam.\n\nOccaecati numquam adipisci ea vero vel at quia esse. Omnis atque dolorum eaque illum.\n\nAsperiores illum delectus veritatis recusandae voluptate temporibus. Ipsa quod hic quia nemo nulla magnam ad. Nisi aut iusto dicta explicabo.\n\nSed culpa quisquam repudiandae iusto. Neque corporis quia nesciunt rem beatae. Tempora earum earum reiciendis officia alias ad aspernatur. Doloremque nesciunt molestias voluptate eaque laboriosam explicabo facilis.\n\nPerspiciatis quo aliquid iste perspiciatis. Modi possimus fugit molestias reprehenderit. Illo corrupti ducimus repudiandae eum. Repellat provident saepe repellendus vero explicabo quidem doloribus.	66.20	\N	2017-12-03 17:37:29.649567+00	3	"3"=>"6", "5"=>"14"	f	t
450	Stevenson, Boyle and Clark	Modi incidunt nemo enim illo. Quisquam id magni dolores dicta voluptatum qui. Laudantium minima voluptates recusandae repellendus.\n\nQuis autem reprehenderit totam necessitatibus placeat qui assumenda. Quaerat quod quidem veritatis assumenda consectetur veniam nostrum. Commodi nemo doloremque nam voluptatibus tempora. Autem modi eaque neque.\n\nLaboriosam suscipit deleniti officiis quibusdam sapiente. Commodi corporis unde adipisci eius ipsum recusandae tenetur. Cupiditate ducimus dolor similique ad. Animi deleniti modi maiores maiores cumque nemo.\n\nConsequatur illum commodi dicta assumenda occaecati debitis aspernatur. Quibusdam eaque facilis enim. Asperiores laboriosam alias officiis iusto dolor odit. Vero ipsam possimus numquam.\n\nQuas distinctio corporis earum minus praesentium dolore quae. Culpa eligendi asperiores autem facere esse incidunt modi. Soluta quisquam natus delectus accusantium blanditiis fugit laborum. Unde ratione nemo nesciunt fugit debitis.	83.92	\N	2017-12-03 17:37:29.689862+00	3	"3"=>"6", "5"=>"14"	f	t
451	Bright, Schultz and Thomas	Libero molestiae ab voluptates placeat reiciendis. Quam dolores id quaerat doloremque iure commodi molestias.\n\nCum nobis aliquid quod id fugit aut excepturi rem. Occaecati at cum quia aperiam. Itaque ullam sequi consequatur explicabo eos. Maxime atque molestiae asperiores ipsum.\n\nCorporis optio sit molestiae est nesciunt. Unde laudantium ad deleniti nisi quaerat id modi. Quod laboriosam aspernatur ullam totam inventore. Hic voluptatibus pariatur ab est.\n\nVelit placeat assumenda blanditiis distinctio nostrum placeat impedit. Occaecati minima totam veniam accusantium voluptatum. Blanditiis aut pariatur porro blanditiis consequatur fuga nesciunt.\n\nVeritatis facilis omnis sit rem. Nisi ipsum aliquid quia molestiae. Eum cumque tempora fugit quia id. Nam voluptates nemo at accusantium. Possimus illo eius excepturi recusandae.	25.60	\N	2017-12-03 17:37:29.743651+00	4	"3"=>"6", "7"=>"19"	f	t
452	Delgado Ltd	Exercitationem consequuntur corrupti mollitia atque aperiam repellat. Est ut numquam tempore cum deserunt. Deleniti laudantium eum natus pariatur. Dolorum qui laudantium pariatur explicabo.\n\nEaque a sunt sint nobis ullam. Doloremque voluptatibus possimus beatae temporibus. Culpa sit asperiores doloribus. Asperiores velit labore blanditiis quas. Repudiandae recusandae pariatur repellat ad.\n\nPerferendis iure explicabo distinctio deleniti dolores ut eos. Sit architecto excepturi iusto nam sed. Quisquam pariatur ea rerum vitae ipsam ratione totam.\n\nEveniet dolores rerum excepturi sequi. Earum corrupti perspiciatis dolores illo facilis eum nesciunt. Tempora eligendi labore iusto sint. Soluta aperiam nam itaque cum maxime.\n\nIllum dolor nihil incidunt excepturi repellat molestias. Accusamus alias ad pariatur ab. Molestiae sed temporibus inventore vel recusandae quod optio labore. Non qui aut cum quos.	13.51	\N	2017-12-03 17:37:29.792134+00	4	"3"=>"6", "7"=>"20"	f	t
453	Williams and Sons	Maxime aut laudantium alias. Aperiam nostrum magnam perferendis quasi molestias. In vero impedit in sapiente minus dolor.\n\nPossimus porro beatae culpa at architecto. Culpa reiciendis doloribus iste omnis dolorem omnis. Illum quia earum dicta beatae labore.\n\nNon occaecati nulla dignissimos impedit magnam aliquid magni. Dignissimos commodi quis tempora doloremque labore. Odit iusto accusamus id nam quibusdam dignissimos quod.\n\nEius culpa error sed veritatis fuga. Quae eveniet reiciendis molestias laborum minima aliquam. Sapiente odio delectus quaerat. Officiis laudantium aspernatur soluta. Quo quibusdam error natus officiis at neque.\n\nEarum veniam quibusdam incidunt asperiores dolorem sint libero. Assumenda totam nisi voluptate libero dolorum ea maiores. Mollitia quidem officiis dolorem sunt quos. Id explicabo aspernatur totam reprehenderit unde soluta voluptatum.	57.71	\N	2017-12-03 17:37:29.829865+00	4	"3"=>"6", "7"=>"20"	f	t
454	Watson-Bryant	Quos animi quo facilis accusamus quidem expedita. Inventore id vel esse qui ut vel.\n\nBlanditiis voluptatibus tempore ipsa ducimus cumque. Iste reiciendis occaecati perspiciatis suscipit unde eveniet.\n\nReiciendis laudantium adipisci culpa quos modi praesentium. Sapiente quas est qui quisquam harum reiciendis commodi. Consectetur placeat tenetur illo ea. Mollitia sequi ipsa eligendi quas molestias ea.\n\nDucimus illo harum tenetur nemo. Repellat voluptas odio nisi fuga maxime perferendis officiis.\n\nIpsa iure vitae necessitatibus possimus voluptates dolor. Neque cupiditate minima unde nesciunt. Iure corporis nesciunt similique fugit ut harum. Sunt corrupti harum maxime itaque.	86.80	\N	2017-12-03 17:37:29.874447+00	4	"3"=>"6", "7"=>"20"	f	t
455	West LLC	Eum doloribus quis ratione magni. Nobis nisi dignissimos praesentium suscipit velit quae id. Magnam commodi rerum tenetur deserunt tenetur corporis minus.\n\nSequi odit laudantium fugiat repellendus. Excepturi nisi impedit ut qui repellat eius in provident. Quia delectus quibusdam quae veritatis necessitatibus. Asperiores asperiores temporibus tempore dolores expedita consequatur.\n\nUt unde praesentium numquam harum. Laboriosam quae at accusamus praesentium. Perspiciatis officia dolores praesentium. Nesciunt neque maiores quas. Architecto quae sequi voluptates at.\n\nMaiores culpa labore omnis dolore. Libero eius molestias laudantium praesentium nisi quis temporibus unde. Omnis corporis laboriosam saepe minus sapiente officia incidunt fugiat. Incidunt minus maiores magnam iste perspiciatis hic doloribus.\n\nQuisquam dolores officia non laborum maiores ipsa est earum. Nobis repellendus consequatur quasi earum earum dolores cumque. Consequuntur eius quis recusandae voluptate porro. Quis asperiores neque et architecto tempore explicabo in.	25.80	\N	2017-12-03 17:37:29.921657+00	4	"3"=>"6", "7"=>"20"	f	t
456	Zavala, Harris and Gonzales	Consequuntur amet quibusdam maiores nihil. Illum dolor laborum esse at.\n\nQuam ducimus nostrum est. Assumenda porro nulla sunt fugit fuga possimus commodi nemo. Incidunt consequatur esse ab placeat.\n\nIpsam cum dolores vel quidem omnis recusandae recusandae est. Sit et incidunt minus fuga explicabo facere. Reprehenderit delectus quaerat voluptatem cumque facilis autem. Consectetur quia mollitia saepe ex officia.\n\nMolestias temporibus tenetur delectus omnis. Quas quas in incidunt repellendus consequuntur. Voluptas repellat consequatur ea accusantium eius temporibus.\n\nSimilique at fugiat ex magnam fugit. Commodi veniam quod tenetur beatae eos laborum nihil.	37.60	\N	2017-12-03 17:37:29.973112+00	4	"3"=>"6", "7"=>"19"	f	t
457	Gonzalez LLC	Ipsa pariatur numquam sit atque consequuntur illo. Ab ipsum soluta reprehenderit possimus inventore. Perspiciatis dolorem corporis nisi in similique sint.\n\nConsectetur eum voluptate corporis pariatur. Reprehenderit soluta error consectetur tenetur. Optio ducimus dolores cum suscipit assumenda deserunt. Veniam perferendis ipsum repellat labore.\n\nAut quae eligendi atque. Sunt reiciendis sunt provident aspernatur eos sapiente totam. Atque saepe odio quia veritatis repellendus.\n\nQuisquam culpa incidunt expedita. Adipisci hic alias asperiores quam. Itaque perspiciatis illum quo est.\n\nUt consequatur inventore animi dicta enim vitae enim. Accusamus harum dolorem illum voluptas. Aperiam temporibus fugit iusto deleniti assumenda. Voluptatibus aliquid molestiae magni pariatur est. Officiis rerum ipsa numquam laborum omnis totam nihil consectetur.	31.94	\N	2017-12-03 17:37:30.014998+00	4	"3"=>"6", "7"=>"19"	f	t
458	Parker Group	Odio ipsam tempora quaerat neque. Libero libero commodi neque dignissimos possimus esse reiciendis. Fugiat debitis quidem exercitationem esse sed vero soluta porro. Cupiditate magnam enim temporibus eaque.\n\nMollitia nemo asperiores nam fugit placeat dolorem. Eius perferendis illo dolorem dolores nam illum modi. Eos necessitatibus officiis minima ratione.\n\nRerum cupiditate laudantium laborum neque dicta quidem. Quam at inventore provident molestias ducimus veniam aut vero. Ducimus dolores occaecati fuga quis cupiditate beatae nulla. Perspiciatis pariatur cum fuga laborum alias et. Velit maiores dolorum et alias labore minima.\n\nQuod nesciunt quas quod voluptatum tempore pariatur. Corporis accusamus est eligendi possimus molestias. Eligendi iste fugit delectus provident eum in quam excepturi. Reiciendis cupiditate deserunt ipsum magnam harum magni nostrum.\n\nBeatae nisi vel aliquid autem maiores inventore. Minus qui placeat possimus ex praesentium neque velit. Ipsa autem nostrum sed voluptas libero beatae quibusdam.	8.31	\N	2017-12-03 17:37:30.067129+00	4	"3"=>"6", "7"=>"20"	f	t
459	Moore Ltd	Doloribus rem ipsa facilis eius. Dolorem repellat optio voluptas doloribus ipsa voluptates quam maiores. Rem aspernatur ducimus vero amet maiores reprehenderit.\n\nError eveniet architecto quasi. Commodi modi qui id. Asperiores modi atque porro velit dicta. Dolores maiores dolore aspernatur magnam error.\n\nPossimus soluta tenetur hic. Hic debitis doloremque nesciunt reprehenderit ea voluptatem voluptatem eum. Non laudantium officiis vitae blanditiis commodi illum.\n\nIncidunt a voluptatibus ab illum blanditiis. Provident quod eos placeat vel. Nemo delectus eum ipsum assumenda.\n\nQui accusantium fugiat doloremque. Iusto voluptates sint magnam cupiditate consequuntur. Soluta odit accusantium quibusdam. Non sequi iure officiis.	91.89	\N	2017-12-03 17:37:30.111568+00	4	"3"=>"6", "7"=>"19"	f	t
460	Garcia and Sons	Facilis eaque recusandae provident. Dolores quos vel debitis aperiam suscipit ipsa. Sunt reprehenderit quod vel porro magni earum.\n\nIusto repellat doloremque natus inventore corrupti officia culpa. Amet veritatis nam iure veniam asperiores sunt. Quae nihil tempora unde libero.\n\nProvident ducimus ab sapiente doloremque. Blanditiis aliquid qui nulla ullam nemo eveniet.\n\nVeritatis voluptate suscipit ipsam labore. Aliquid harum modi sapiente fugit voluptatem eligendi odio autem. Rem iure labore adipisci nulla.\n\nNecessitatibus ullam numquam eum rerum deserunt adipisci. Tempora quam nisi ad incidunt. Consectetur quo odio doloremque quae quibusdam voluptatem. Fugit aperiam ad maiores quidem quibusdam natus.	22.35	\N	2017-12-03 17:37:30.162239+00	4	"3"=>"6", "7"=>"19"	f	t
461	Clay Inc	Autem necessitatibus fugit voluptates praesentium ab modi dolorem. Reprehenderit sequi deleniti quia omnis quam dolore fuga. Sed nostrum a accusamus atque voluptatum alias. Temporibus est quis et repellendus corporis nesciunt.\n\nSuscipit neque occaecati maiores. Pariatur quibusdam voluptates fuga laboriosam culpa nostrum. Magnam reprehenderit voluptatum voluptate architecto consequatur alias. Reiciendis natus at mollitia velit eius error facere.\n\nNostrum nulla voluptatibus exercitationem quasi. Facilis adipisci mollitia officia et. Nihil tenetur itaque ad quam beatae odit.\n\nQuo dolorem natus officiis dicta dolor repudiandae consequatur. Ipsum minima a ab ad illo officia est. Molestias quae accusamus sapiente. Esse sequi minus quia accusantium.\n\nAliquid placeat corporis mollitia eveniet a tempore. Minus ducimus porro eos omnis. Nihil vitae debitis nihil qui ipsam omnis dolore.	30.87	\N	2017-12-03 17:37:30.204862+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
462	Smith, Costa and Reid	Provident debitis et laborum sequi magni itaque. Provident facilis alias quae velit. Neque mollitia alias exercitationem odio aut. Consequatur illum alias ullam sint velit et quas.\n\nConsequatur magni at blanditiis incidunt laborum. Aliquid dolor praesentium rem neque.\n\nPerspiciatis veritatis reprehenderit ex harum sequi perspiciatis. Ut voluptates ut rem ipsam. Accusamus debitis exercitationem minus nostrum cumque. Saepe rem ea aperiam.\n\nIste corrupti soluta quam accusamus fuga dolor laudantium. Cupiditate expedita autem vel optio voluptates sed. Numquam in fuga quas facilis error reiciendis qui. Modi nemo nesciunt minus possimus a.\n\nMagnam sequi maiores eligendi earum iusto reiciendis laborum. Eos quod sint distinctio. Fuga maiores laborum vero molestias asperiores earum. Illo voluptas atque unde expedita ipsum.	80.47	\N	2017-12-03 17:37:30.277063+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
463	Gonzales Inc	Molestiae saepe saepe et deleniti facilis sit. Similique tempore in reiciendis dolor. Est rerum cum nemo facere mollitia. Blanditiis odio ratione vitae eum omnis.\n\nDeserunt iure delectus optio dolore. Labore harum asperiores aspernatur inventore. Reiciendis a ratione voluptatum fuga.\n\nQuibusdam dignissimos nihil repellat sint eaque harum deserunt. Ullam suscipit sit itaque expedita.\n\nSaepe culpa excepturi velit ab velit neque totam. Quo enim unde nesciunt ullam neque a animi voluptas. Culpa fuga perspiciatis repellat necessitatibus ea.\n\nNulla adipisci facilis nisi temporibus nulla nostrum minus esse. Eveniet impedit consequatur maiores corrupti odit. Explicabo quidem quibusdam fugit eius excepturi inventore.	4.86	\N	2017-12-03 17:37:30.314729+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
464	Turner-Robinson	Delectus modi necessitatibus numquam. Minima reprehenderit voluptatum consequatur ut illo perspiciatis mollitia ducimus. Ad delectus accusamus qui sapiente enim quam.\n\nPerspiciatis facere voluptatibus eos fuga harum quaerat. Delectus ad maiores ea accusantium earum officia. Nobis quasi dignissimos cumque doloremque sequi.\n\nIn temporibus aperiam sunt laboriosam iure minima sunt. Ullam id est delectus exercitationem sunt dolore aliquam at. Tenetur praesentium harum nulla nobis.\n\nEa vero ullam culpa rem nobis facere aliquid. Quibusdam vero amet doloremque fugiat consectetur a. Accusantium fugit itaque temporibus dolore est dolor.\n\nAmet est laudantium nemo molestias. Accusamus voluptatum est officia odio quaerat similique commodi. Iste nihil consequuntur excepturi placeat voluptates.	87.30	\N	2017-12-03 17:37:30.369323+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
465	Duran Inc	Eum atque sed facere deleniti. Culpa rerum excepturi minima quidem consectetur. Voluptates suscipit aliquam vel exercitationem eos. Repellendus quidem explicabo modi voluptas sunt cupiditate nemo repellendus.\n\nMagni delectus harum quisquam totam quia. Praesentium iusto at minima occaecati explicabo. Fugiat maiores vero quisquam id consequuntur.\n\nFugiat saepe soluta vel ipsa ipsum maxime. Eius tempora dolor amet. Unde voluptas quibusdam magni quos maxime voluptatibus quidem.\n\nSed laudantium sequi maxime facilis similique odio. Ipsa illo voluptate nostrum quos tenetur. Consectetur error non suscipit.\n\nSequi minus accusamus quas. Voluptas id dolorem perferendis iste aut aliquam laboriosam. Vitae amet dolorem ut iure perspiciatis.	64.70	\N	2017-12-03 17:37:30.409321+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
466	Holmes, Wilson and Sharp	Recusandae aliquam perferendis aliquam sequi consequuntur eligendi. Nostrum nesciunt aspernatur voluptates voluptate mollitia maiores. Facere quae consequatur animi quidem porro quisquam maiores.\n\nDolorum totam occaecati similique. Quo sit saepe quasi quas totam molestiae.\n\nReiciendis aperiam neque quo consectetur quia laboriosam laboriosam. Eaque necessitatibus ipsa reiciendis voluptatum numquam. Amet vel asperiores provident. Laboriosam enim mollitia quidem inventore velit modi.\n\nDolores eaque doloremque dignissimos. Iusto totam at aspernatur quisquam minima aut. Minima quam quos quaerat explicabo placeat. Animi recusandae aperiam neque quam ab officia sunt.\n\nCorrupti quam eius provident quidem possimus molestiae. Reprehenderit vitae provident illo autem. Magnam inventore commodi modi. Repellendus blanditiis commodi minima ad officiis.	67.15	\N	2017-12-03 17:37:30.447636+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
482	Cabrera, Avila and Miller	Ducimus unde eos laborum temporibus quod ad. Praesentium ducimus iusto sapiente.\n\nCorporis blanditiis eaque placeat dicta harum. Sed debitis accusantium dolore vel dolorem corrupti dolores. Quidem qui quas veritatis nulla optio vel. Quo optio molestias quod est ex debitis officiis doloremque.\n\nIllum mollitia atque consequuntur dolore nam sunt quidem officiis. Hic neque voluptatibus laudantium odit similique laborum ratione. Vel molestiae facilis rerum quod molestias. Tempora voluptas iusto voluptas aut distinctio ullam mollitia.\n\nDolores corporis molestiae ea. Iure animi atque dicta maxime a quasi velit.\n\nIpsa deserunt provident aliquam minus. Ab illo asperiores officiis natus numquam. Iste iure impedit laboriosam. Cum asperiores autem nihil autem.	15.40	\N	2017-12-06 15:00:00.61269+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
467	Potts, Parker and Johnson	Harum praesentium quam sit error. Corrupti doloribus maxime ratione ut quam rerum veniam veniam.\n\nNesciunt voluptatibus odio suscipit sequi dolorum. Itaque magnam corrupti praesentium. Beatae dolorem tenetur ex saepe nostrum rem.\n\nSint quis ad tempora numquam. Quod accusamus amet maxime voluptatem cum blanditiis consequuntur. Placeat molestias porro ab quo.\n\nVitae perferendis hic tempora repellendus tempore atque. Laboriosam quam culpa tempore ex corporis nam repellat ut.\n\nVitae quis earum perspiciatis reprehenderit dolorum. Totam iste qui non sit reprehenderit blanditiis iste delectus. Ex earum quam delectus assumenda accusantium. Maiores qui pariatur fugit cupiditate nam enim veniam.	66.24	\N	2017-12-03 17:37:30.560808+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	t	t
481	King Ltd	Placeat aliquid repellendus velit tempore vero ut distinctio totam. Voluptatibus dolores architecto distinctio minima dolores voluptas eos. Enim doloremque sed enim dolor magni quis.\n\nQui dignissimos consequuntur voluptatibus asperiores maiores id eum. Quaerat quidem sapiente animi. Ea in recusandae voluptates ad.\n\nQuaerat ex non reiciendis maiores quasi consectetur. Quis tenetur consectetur suscipit. Fugiat laboriosam nihil exercitationem deserunt. Aspernatur sed nemo in quos asperiores velit voluptatibus nesciunt.\n\nVel sunt ea non unde. Laudantium dolorem accusamus harum animi laborum debitis.\n\nIpsa soluta dicta dignissimos voluptatem ipsa. Itaque maxime quidem quos praesentium. Ipsam laborum dolor dolores sit velit.	6.60	\N	2017-12-06 15:00:00.523941+00	1	"1"=>"1", "2"=>"5", "3"=>"6"	f	t
468	Combs-Bishop	Doloremque deserunt ipsum itaque accusamus vitae modi. Deleniti dolorum distinctio amet cum quaerat blanditiis reprehenderit. Tenetur dolorum dolorem doloremque numquam enim fugiat debitis dignissimos. Ullam saepe libero nesciunt unde optio fuga. Laudantium quidem ad inventore consequatur nesciunt autem.\n\nSequi pariatur sequi voluptatibus illo omnis provident. Consectetur vitae voluptatem incidunt minima ea saepe. Illo explicabo eius iure tenetur doloremque excepturi occaecati. Illo ullam esse pariatur sit.\n\nEst architecto doloremque voluptate possimus quas. Vel aspernatur saepe voluptates dolor pariatur. Pariatur atque neque mollitia nobis. Possimus vitae fugit aperiam laborum quo ea reprehenderit.\n\nEum eum nesciunt voluptatem magnam sit. At molestiae minima neque eos. Numquam illo consequuntur quia earum. Doloremque saepe ducimus quasi nihil natus nostrum saepe fugit.\n\nVelit saepe necessitatibus atque blanditiis sunt. Possimus reiciendis nostrum odit consequuntur.	95.64	\N	2017-12-03 17:37:30.609244+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
469	Johnson PLC	Accusamus accusantium illum consectetur ratione assumenda. Maxime eum hic tenetur dolorum totam reprehenderit. Odit libero laboriosam voluptatum nihil placeat.\n\nLaborum perspiciatis nulla ad excepturi pariatur pariatur nulla. Hic vel autem consectetur ea. Nam tempora enim hic eveniet modi impedit. Sunt ea ipsam corrupti nisi distinctio.\n\nSed deleniti incidunt et nobis doloremque ipsum tenetur eos. Mollitia nihil quo dolorem dolore harum libero. Earum est beatae nam porro quas.\n\nAdipisci eum ea voluptas illo. Quisquam recusandae maiores soluta laborum perferendis natus accusamus. Excepturi reiciendis enim consequatur temporibus blanditiis.\n\nDeleniti ducimus architecto labore recusandae doloremque facilis tenetur. Id fugiat explicabo aperiam quidem earum.	67.31	\N	2017-12-03 17:37:30.662739+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
470	Williams, Hess and Collins	Esse accusantium occaecati molestias nulla maiores. Ipsa molestias ratione alias. Officia soluta eum ab id veritatis facere excepturi.\n\nCommodi harum nulla ex temporibus esse ullam corporis. Dolore ea debitis minima aspernatur iure quis tempora. Qui officiis quos earum nemo. Sapiente sit officia voluptatum rerum animi asperiores.\n\nMaiores ullam tenetur temporibus. Deserunt labore accusamus porro aliquid porro debitis. Explicabo perferendis voluptas officia molestiae illum.\n\nFacere ipsam iure at consequatur. Repellat quia temporibus ab unde accusamus voluptatibus. Quibusdam libero laboriosam provident ipsam. Repudiandae ullam autem quam occaecati vero quaerat ab.\n\nAssumenda facere recusandae pariatur autem. Odio omnis ipsam accusantium aliquid magni officia alias praesentium. In optio recusandae soluta voluptates veniam quae. Et rerum modi quaerat sapiente. Iste quia soluta quam eum laboriosam sed ullam dolorum.	24.33	\N	2017-12-03 17:37:30.718206+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
471	Rogers and Sons	Impedit sit eaque vero impedit sed maiores rerum quibusdam. Nulla repudiandae nulla ipsa dolores recusandae cumque sunt. Tenetur adipisci maxime consectetur vitae nisi illo eligendi.\n\nSimilique explicabo mollitia quam velit rerum harum dolor ipsum. Perspiciatis odit nobis ullam voluptate distinctio. Quas ut atque autem ipsam eligendi. Asperiores quidem blanditiis commodi asperiores voluptate eveniet dicta.\n\nAd delectus debitis blanditiis reiciendis deserunt. Provident aliquam officia rerum quod quo. Quaerat voluptatum facere eos voluptate sed quidem.\n\nNihil quo quos corrupti cumque. Similique id sunt nemo voluptatem voluptate a. Eligendi dolorum rerum alias sequi ex. Delectus saepe repellat corporis.\n\nRecusandae dolores modi doloremque repellendus reprehenderit. Voluptas ex dolor at id animi non illum. Neque rem voluptates libero saepe veniam nam.	96.73	\N	2017-12-03 17:37:30.762255+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
472	Hinton-Bolton	Cumque minus excepturi veniam unde nam debitis commodi. Doloremque consectetur nam sunt. Beatae sunt officiis provident vel quaerat. Architecto accusamus dolorum id repellat quia iure ducimus.\n\nIpsam illo non totam ad voluptatem itaque. Nemo ex ipsam numquam autem perspiciatis delectus non. Laboriosam dolor magnam deserunt tenetur cum blanditiis pariatur.\n\nQuis a laboriosam facere laudantium. Earum quae omnis accusamus ipsa. Nam quas reprehenderit iure deleniti cum.\n\nExcepturi nostrum optio molestiae eum odio totam nisi. Soluta praesentium nesciunt explicabo sunt sint nam dolorum. Quam tenetur molestiae enim iusto iusto accusantium. Labore optio voluptatibus voluptatem provident.\n\nVoluptatem nulla natus autem commodi vero dolor ea. Possimus officia ea itaque expedita deserunt sit. Voluptates velit minima eaque id assumenda et.	17.14	\N	2017-12-03 17:37:30.816598+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
473	Taylor-Walker	Inventore autem natus similique earum. Id commodi in suscipit in laborum. Iste veniam eveniet suscipit.\n\nIure vero saepe laborum occaecati tempora voluptatibus. Dignissimos officiis nisi incidunt nisi. At harum debitis quod omnis similique nostrum. Minima sapiente exercitationem sapiente odit saepe culpa. Voluptates dignissimos unde qui possimus ut pariatur ad unde.\n\nAut eum adipisci id id. Enim itaque expedita dolor nisi dolores recusandae. Neque odit laboriosam eaque reprehenderit. Totam neque praesentium saepe et dolore molestias cum.\n\nArchitecto molestias voluptate dolores amet nam consequuntur fuga. Dignissimos laborum dolores deleniti cum neque tenetur. Est fuga labore doloremque eos. Cupiditate illum laborum iusto minus.\n\nLabore voluptas incidunt expedita quod delectus consequatur veritatis. Harum autem inventore dolores perspiciatis deleniti. Eos est quidem aliquam natus natus corporis. Esse rerum quos ratione quasi.	42.50	\N	2017-12-03 17:37:30.900344+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
474	Johnson-Salinas	Doloribus harum vel consequuntur laboriosam occaecati. Consequuntur tenetur quae sit in neque. Atque pariatur temporibus unde repellendus. Iusto eligendi ratione voluptates.\n\nUt quaerat quas est dolorum placeat possimus voluptatibus. Eius quia nostrum at eaque laborum libero tempore. Deserunt ipsum sapiente explicabo dolores ut. Inventore molestiae magnam illo quasi. At nihil praesentium veritatis.\n\nInventore libero tempora iusto consectetur facilis nemo beatae. Tempore ducimus quo quisquam. Debitis totam magnam omnis aliquid molestias praesentium ullam.\n\nItaque veritatis asperiores ullam recusandae aliquam repudiandae dolor. Aperiam aliquam minus architecto necessitatibus. Minus tenetur non maxime assumenda iusto. Dignissimos dolorum unde animi doloribus.\n\nNulla officiis quia deserunt. Provident harum amet deserunt veniam. Repellat quibusdam facilis id vitae.	70.22	\N	2017-12-03 17:37:30.968444+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
475	Hamilton, Stone and Rodriguez	Ipsa ea et voluptates consequuntur accusamus occaecati. Necessitatibus officia laborum architecto non. Fugit a vitae possimus voluptas. Repudiandae tempore laborum dolorem omnis delectus quo velit. Ratione incidunt dicta blanditiis aspernatur unde.\n\nAsperiores quis quae corrupti blanditiis illo. Architecto perferendis enim cumque nihil. Necessitatibus incidunt impedit pariatur distinctio. Cupiditate praesentium delectus nesciunt ad veniam et.\n\nNumquam est aliquid ea sapiente voluptatum quo. Exercitationem voluptatem sed quo magni. Deserunt suscipit repudiandae facilis officiis. Veritatis consectetur accusantium inventore nam hic fugiat maxime.\n\nPorro nihil provident praesentium maxime. Minus iste nemo quos magnam accusamus expedita. Cum provident natus illum. Dolores voluptates unde consectetur exercitationem quam nobis.\n\nEos fuga sit distinctio ratione velit. Adipisci sequi quod quae quibusdam sint minima. Suscipit iste placeat harum.	76.49	\N	2017-12-03 17:37:31.027374+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
476	West, Moore and Miller	Temporibus porro tempora dicta minus. Distinctio facere omnis eos doloremque minima id. Exercitationem qui natus fugiat soluta nesciunt possimus earum.\n\nFacilis consectetur iusto assumenda nemo quam molestiae. Provident quam saepe saepe consequuntur odio mollitia suscipit nihil. Ad eaque et odio nesciunt non doloribus distinctio. Ipsam repellendus sint molestias adipisci fuga expedita sit.\n\nVeniam fugit veritatis sit et quos quas tempora. Hic delectus quasi quos excepturi laboriosam. Tempore quas in perspiciatis eveniet fugit aperiam. Soluta explicabo optio earum. Sapiente magni in veniam ipsa deserunt.\n\nIncidunt dolores suscipit neque similique. Fugit pariatur tenetur iste autem voluptates inventore. Ipsa voluptatum nobis magnam placeat dolorem.\n\nCum eum libero inventore voluptas quidem laborum. Eum laudantium perferendis nostrum minus. Voluptatum dolorem laudantium velit nam nobis.	80.88	\N	2017-12-03 17:37:31.081273+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
477	Watkins and Sons	Animi quos neque nemo possimus consequatur. Eos sit quia dolores. Tenetur quasi dignissimos sequi. Aperiam quaerat similique sunt est numquam veniam aliquid.\n\nAlias eaque sint vitae architecto numquam laudantium delectus illum. Asperiores nobis quia alias quas aliquid. Illum facilis voluptas aperiam perferendis.\n\nItaque reprehenderit animi vitae. Eum sunt voluptatibus quisquam aliquid. Voluptatum voluptatibus eveniet dolores maxime animi minima. Animi unde necessitatibus minus similique delectus ratione.\n\nRem quos perspiciatis dicta facilis possimus eaque ipsum. Perspiciatis laudantium consequuntur fugiat veniam cupiditate. Eligendi ea suscipit fuga neque mollitia nemo eum. Delectus cupiditate aspernatur aperiam quam explicabo suscipit aperiam laboriosam.\n\nUnde commodi at earum illo illum. Quibusdam exercitationem praesentium numquam odio officia eius. Sint incidunt blanditiis minus nulla occaecati amet.	78.80	\N	2017-12-03 17:37:31.154174+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
478	Holden-Schwartz	Perspiciatis a praesentium nulla ipsum quisquam sequi assumenda. Odit perferendis excepturi aperiam nostrum deleniti ducimus vero.\n\nSaepe tempore ipsa omnis sequi tempora deleniti. Dolorem tempora vero iste in nihil quae voluptate. Fugiat voluptatibus ipsum ducimus eum aliquam. Inventore asperiores eius odio facere molestias exercitationem. Porro animi perspiciatis ipsam laboriosam.\n\nQuidem temporibus nulla animi aut cum id eligendi. Laboriosam aliquam excepturi inventore commodi eveniet dolor. Quam vero repudiandae iure voluptates tempora.\n\nSuscipit nihil voluptatibus eum inventore tenetur voluptatum. Laudantium quisquam dolore architecto eaque fuga eos optio. Consectetur repudiandae fuga molestias at veritatis. Adipisci id deserunt provident placeat similique.\n\nNatus dicta et ipsam alias voluptatum quidem. Maiores soluta ipsam provident animi cum. Error dolore rerum doloremque eligendi rem aperiam.	22.54	\N	2017-12-03 17:37:31.220399+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
479	Clark and Sons	Vel aperiam earum officiis reiciendis. Voluptatum sed quidem nisi sed quia vel. Facilis beatae rem reprehenderit quia natus error incidunt.\n\nVoluptatem explicabo quidem dolor sint cupiditate quod. Officia labore quasi rerum aliquid impedit blanditiis non. Voluptates dicta dolorum tempore deleniti.\n\nIllo natus eius quisquam ducimus laborum optio unde. Qui in repudiandae dicta occaecati labore a.\n\nPerspiciatis distinctio cum totam animi error eum itaque. Numquam possimus cum perferendis reprehenderit quisquam. Voluptatibus quod perferendis nobis exercitationem reiciendis illo.\n\nDistinctio autem sit omnis dolorum et eligendi. Doloribus nostrum accusamus laborum quod. Adipisci sint corrupti laborum. Ad fuga culpa corrupti facere dicta.	77.42	\N	2017-12-03 17:37:31.272547+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
480	Daniels-Hawkins	Nemo optio quibusdam mollitia ipsam dolor. Quasi minus molestiae tenetur. Quas minus praesentium molestiae mollitia quaerat. Odit autem nemo iure dolores.\n\nNumquam perferendis quisquam asperiores veritatis iure. Eos recusandae incidunt unde porro dolore voluptate.\n\nNostrum optio architecto rem illum. Dignissimos rerum modi amet. Minus eius ex libero exercitationem nostrum est earum.\n\nAnimi doloribus dolorem laboriosam. Dolorum illum cumque veniam voluptates.\n\nLaboriosam fugiat itaque aperiam dolore sapiente eveniet. Laudantium consequuntur nemo quas maxime a. Cumque exercitationem iusto exercitationem ducimus numquam.	78.64	\N	2017-12-03 17:37:31.365912+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
72	Gutierrez, Reed and Rogers	Aliquam impedit a culpa. Ex blanditiis excepturi doloremque fuga quasi. Nesciunt laudantium quod necessitatibus ratione eligendi officia hic quia. Voluptatum animi eum aperiam eum et consectetur explicabo.\n\nDebitis rerum officiis perferendis. Nemo ad blanditiis laudantium in corporis non soluta. Blanditiis neque inventore harum assumenda sapiente dolorum dignissimos.\n\nEa soluta esse facere optio ratione cum tempore totam. Itaque non fugit deserunt. Quibusdam suscipit omnis velit quod exercitationem quis.\n\nNihil velit dolore dolore blanditiis quae at. Deserunt tempora ipsum autem. Ducimus enim voluptas quos possimus exercitationem quae fugit consequuntur. At rem incidunt minima earum repellendus. Molestias occaecati dicta aspernatur a maxime.\n\nQuo blanditiis nesciunt eligendi quo maxime unde. Magnam ipsam ut tempora. Repudiandae provident neque alias suscipit nam in.	92.27	\N	2017-11-27 23:21:07.762811+00	2	"3"=>"6"	t	t
483	Pham Inc	Hic debitis inventore autem ipsam. Voluptatem a nisi mollitia repellat officiis. Provident dolores consequuntur occaecati fugit doloremque recusandae quo. Est alias voluptate possimus perferendis.\n\nIure quisquam odio error dolorem reprehenderit. Animi eos necessitatibus maxime dolorem et deserunt sapiente. Eaque expedita veniam sed.\n\nHic in ullam ipsam corporis assumenda totam. Doloremque tenetur corporis eligendi consequatur corrupti consequatur. Facilis facilis laudantium rerum nostrum et odit.\n\nRepellat architecto odio est ad doloremque. Excepturi sequi officiis voluptates quisquam officia quia. Modi harum nulla voluptatibus.\n\nQuo omnis magni odit quae. Quam magnam tempore suscipit placeat ducimus nihil quidem. Commodi nulla iusto laborum quae ad vero tenetur. Tempora quibusdam expedita laborum non dicta adipisci.	33.60	\N	2017-12-06 15:00:00.658852+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
484	Rice-Brady	Quae voluptatem quos animi nemo eligendi quo. Dicta vel est possimus. Enim ullam magni quasi dicta voluptatum. Et quisquam commodi totam eveniet qui ipsam quam.\n\nMagni animi omnis soluta provident ducimus sunt sunt. Voluptatibus in id dicta voluptatibus. Accusamus quasi eius ratione beatae.\n\nConsequuntur voluptate architecto adipisci aperiam ipsam aut. Labore distinctio esse accusantium ipsum excepturi itaque placeat. Optio adipisci quos dignissimos quasi dolores assumenda. Mollitia nemo provident omnis doloremque beatae magnam.\n\nVoluptas illum numquam cupiditate expedita deleniti. Architecto nesciunt a officiis accusamus incidunt dignissimos. Accusantium atque repellat quod optio amet. Voluptate dolores neque voluptates.\n\nId eligendi eligendi odit eos eaque. Placeat expedita ea architecto eius dolores facilis mollitia.	22.40	\N	2017-12-06 15:00:00.723302+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
485	Ho-Vega	Sapiente similique consectetur adipisci in saepe est id. Ipsam excepturi ducimus beatae minus. Excepturi numquam explicabo unde dolore dolorum asperiores. Nobis culpa blanditiis soluta laboriosam voluptatibus nulla.\n\nDolorem nostrum cumque fuga. Dolorem molestiae aliquam at ullam incidunt. Omnis quasi ipsam ea minima itaque. Harum omnis ipsa sit laborum cum dolorem eum assumenda.\n\nCupiditate tempore nostrum corrupti neque vero. Magnam exercitationem voluptate nostrum officia commodi delectus ea. Illum accusantium corrupti perferendis dolorum officiis perspiciatis ad.\n\nAd pariatur corrupti quis molestias voluptatibus hic enim. Porro id dolorum magnam cupiditate pariatur molestiae. Nemo voluptate ducimus ut laborum dolor eum ipsum animi.\n\nReprehenderit eveniet eos ipsum tempore architecto reiciendis. Cum dolores molestiae in voluptatum rerum.	52.40	\N	2017-12-06 15:00:00.782499+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
486	Mccoy, Campbell and Blackwell	Voluptatibus modi aliquid corporis consequuntur provident natus facere impedit. Nobis quidem molestias veniam asperiores. Doloremque expedita officiis saepe nisi perspiciatis nobis. Nobis laboriosam perferendis praesentium tempora velit labore unde consequatur.\n\nQuaerat eos asperiores quaerat eveniet ratione quos minima. Iusto inventore eveniet ea aperiam aspernatur. Doloribus beatae quo laborum.\n\nDignissimos cum alias sunt blanditiis dolor placeat fuga voluptas. Facere dolorum ad rerum quos possimus nesciunt nam. Laboriosam tempore eaque distinctio asperiores pariatur vitae. Amet quaerat fugiat ipsam eum possimus quam nisi.\n\nRerum velit nisi explicabo ex qui placeat natus. Magnam consequatur perferendis voluptate culpa eos. Vel dolorem ex magnam in.\n\nFugiat iste similique architecto dolorem accusamus hic. Deserunt atque omnis sunt autem necessitatibus. Animi numquam occaecati nisi culpa mollitia quaerat eveniet. Delectus repudiandae modi vel rerum culpa id. Distinctio eligendi veritatis cumque harum eos natus neque.	8.80	\N	2017-12-06 15:00:00.824988+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
487	Doyle-Rosales	Necessitatibus consectetur non vero. Rerum eos perferendis eos perferendis sed suscipit laborum tempora. Quia cupiditate modi inventore suscipit autem minima. Molestiae sequi enim fuga facere sequi cumque. Sequi voluptatem ullam officia deleniti cum ex.\n\nEius natus veritatis repellat repellendus accusantium. Quidem repudiandae dolore possimus rerum nostrum dolorem. Perferendis modi illum inventore et qui. Nobis ut excepturi omnis reiciendis neque. Rerum ullam maxime ullam omnis delectus.\n\nConsequatur aliquid beatae omnis tenetur ab. Veniam sequi incidunt expedita inventore quo vel.\n\nEos corrupti dignissimos quisquam quas ut dolorum. Eos ratione iusto quam dignissimos iure modi. Eveniet assumenda perferendis enim consequatur voluptatibus occaecati aperiam.\n\nTotam voluptas assumenda recusandae ipsum totam mollitia hic. Laborum facere adipisci cumque maxime fuga a cumque pariatur. Harum velit et odit neque.	1.49	\N	2017-12-06 15:00:00.862426+00	1	"1"=>"2", "2"=>"4", "3"=>"6"	f	t
488	May Group	Esse dicta consequatur officia qui quaerat. Reprehenderit minus quibusdam mollitia nostrum dicta dolores. Incidunt placeat at nam error voluptate.\n\nMinus aut necessitatibus impedit totam esse amet ab placeat. Animi odit odio nemo pariatur quas. Pariatur minima placeat expedita inventore. Laborum illum magnam cum voluptatibus commodi.\n\nAutem dolorum voluptate alias blanditiis temporibus quia excepturi. Aliquam animi exercitationem quos exercitationem. Odit eum ipsa rerum natus alias deleniti accusamus.\n\nEx aliquam fuga aut velit exercitationem. Fugiat consectetur explicabo quae ratione modi iste. Iusto nihil sunt in officiis.\n\nTotam laboriosam velit dolore sed delectus saepe ea. Nam tenetur neque iste facere repellat optio. Quam sit iure quo quae maxime quo. Quibusdam soluta hic eos labore quasi nulla. Sit accusamus fugiat non ab.	29.22	\N	2017-12-06 15:00:00.91266+00	1	"1"=>"1", "2"=>"3", "3"=>"6"	f	t
489	Garrison-Jones	Corrupti deleniti nobis nihil. Eaque omnis quasi ea deserunt soluta alias. Sed alias aut nulla consectetur tempora.\n\nAnimi reiciendis ex quibusdam nemo quae officia eos. Blanditiis cum atque esse similique est. Dignissimos laborum labore cumque cumque.\n\nNecessitatibus est beatae error assumenda. A enim accusamus esse mollitia necessitatibus labore aut. Cumque fuga tenetur voluptas rerum perspiciatis earum consequuntur.\n\nDoloremque facilis pariatur porro amet amet quo placeat. Pariatur tenetur maxime accusamus tempora fugit nobis. Quos molestias corrupti nesciunt sapiente tempora quae. Corrupti ea sit a ex animi incidunt quo itaque.\n\nAsperiores quod voluptatem quisquam exercitationem ab quisquam natus. Facilis omnis officia architecto consectetur doloremque reprehenderit saepe ipsa. Optio eius deserunt ex excepturi praesentium nam.	97.90	\N	2017-12-06 15:00:00.961401+00	1	"1"=>"1", "2"=>"4", "3"=>"6"	f	t
492	Fields, Buckley and Banks	Amet odio pariatur voluptatem repellat. Cupiditate error ab ducimus ducimus necessitatibus commodi. Nam eos quo ad veniam voluptates alias impedit.\n\nAsperiores sapiente corrupti asperiores vel voluptatibus. Consectetur voluptatibus ratione fugiat qui. Nam alias excepturi natus ducimus temporibus.\n\nPorro inventore velit a nulla. Deleniti quo ut similique dolores. Recusandae molestiae rerum aut esse hic ut. Ratione quae ex libero sint reprehenderit.\n\nLaboriosam vero facere velit nihil delectus porro. Nam recusandae itaque vero saepe modi totam porro laboriosam. Voluptas impedit eligendi illo necessitatibus earum expedita.\n\nOccaecati architecto magni quia. Ducimus nobis tenetur sequi vero voluptates. Quidem rem natus id reprehenderit placeat aspernatur accusamus beatae.	17.80	\N	2017-12-06 15:00:01.095979+00	2	"3"=>"6"	f	t
493	Schultz Ltd	Quidem doloremque enim veritatis error molestiae. Nesciunt incidunt deleniti illo mollitia. Laudantium illum cum omnis provident necessitatibus. Similique placeat explicabo doloremque deleniti et. Explicabo quas provident eius commodi.\n\nIpsum tenetur saepe nisi ex corporis non. Labore architecto molestiae ipsa. Voluptates illum mollitia consectetur rerum cum fuga aut.\n\nQuis nulla debitis omnis ratione distinctio. Enim cupiditate facilis deleniti nulla asperiores omnis cum. Eaque consectetur consectetur impedit nulla. Occaecati cupiditate quo repudiandae est eligendi.\n\nIpsa sit eligendi natus dolorum. Accusantium quam blanditiis ipsam nulla exercitationem harum occaecati. Veritatis assumenda beatae sunt nostrum alias.\n\nRepudiandae doloremque ex illum doloremque quas. Voluptatum non dolorum soluta cum fugit.	28.15	\N	2017-12-06 15:00:01.115439+00	2	"3"=>"6"	f	t
494	Lowe-Zhang	Deserunt debitis quaerat aut consequatur quisquam. Eveniet aliquam ad eaque. Earum ipsam beatae soluta.\n\nQuisquam a qui quia quidem cum quam. Deleniti porro distinctio tenetur aperiam architecto nostrum odio corrupti. Distinctio aliquid ipsa facilis nostrum nesciunt sint voluptas. Accusamus doloremque consequuntur eius commodi.\n\nQuo neque voluptate quis consectetur iure. Quidem debitis consequatur id incidunt possimus quisquam asperiores pariatur. Autem exercitationem unde repudiandae nisi architecto. Vitae est illum ab non reprehenderit.\n\nEsse tempora eius facere ipsum accusantium ducimus. Officia autem occaecati impedit alias. Maxime ipsa vero alias ipsa. Odit ut dolores quo.\n\nOccaecati quaerat reprehenderit atque in molestias adipisci. Dolorum incidunt reprehenderit iste facilis. Cum rerum doloribus sunt voluptates. Odio deleniti blanditiis veritatis alias corporis.	34.46	\N	2017-12-06 15:00:01.147268+00	2	"3"=>"6"	f	t
495	Wright, Caldwell and Cardenas	Similique quidem modi sapiente mollitia. Vitae vero ex culpa quibusdam. Aliquid veniam facilis veritatis quidem.\n\nLaborum tenetur consequatur vel expedita sapiente. Laborum recusandae libero excepturi distinctio hic. Dolorem dolores quaerat repellendus magni eum.\n\nRecusandae sed ipsum temporibus cupiditate dolorum asperiores. Cumque ratione quas quia aperiam perspiciatis ullam. Distinctio consequuntur excepturi occaecati nemo.\n\nOfficia repudiandae dolor provident perferendis. Ut nemo incidunt quidem quae minima possimus neque nobis. Eaque nisi est animi architecto.\n\nTempore asperiores omnis illum mollitia vel ratione velit. Quidem numquam doloribus porro eligendi. Incidunt doloribus a dolorem tempora laudantium. Ducimus itaque repudiandae vitae illo.	53.53	\N	2017-12-06 15:00:01.16653+00	2	"3"=>"6"	f	t
496	Cummings-Fritz	Quod magnam occaecati veniam cupiditate. Omnis quod quibusdam nihil placeat voluptatibus. Maiores a doloremque veniam illum voluptatem consequuntur vitae. A corporis reprehenderit laborum repellendus nisi velit aliquid.\n\nQuis consectetur quis eius sint ratione. Iusto velit voluptates voluptatibus non minima. Natus ut pariatur explicabo atque corporis.\n\nCorporis dolorem nobis maxime deserunt voluptas fuga labore. Ratione itaque fuga doloremque. A suscipit perferendis eum saepe quam beatae iusto. Ea ea officiis excepturi saepe laboriosam labore ullam.\n\nAspernatur sequi nulla quod itaque ex error. Ab provident mollitia eum occaecati magni. Veritatis velit reprehenderit pariatur earum earum amet vitae.\n\nNon dolorem suscipit in consequuntur. Nesciunt harum nihil ipsam saepe delectus.	5.92	\N	2017-12-06 15:00:01.185206+00	2	"3"=>"6"	f	t
497	Gonzales-Cardenas	Possimus illum voluptatibus ipsum saepe iure fugit a saepe. Sed maiores beatae iusto accusamus id repellat. Soluta officiis dicta totam itaque cumque sed iusto ad. Nostrum non dolor possimus distinctio.\n\nAlias deserunt tempore fugiat saepe sed numquam similique. Possimus voluptatum impedit saepe. Fugit accusantium quaerat omnis perferendis ipsam at assumenda itaque. Asperiores porro maxime fugiat sequi.\n\nEst atque laboriosam voluptates id officia. Corporis iusto atque pariatur voluptatem doloremque dolores cum. Quam eos quibusdam aut mollitia deleniti odio provident.\n\nNam quisquam aliquid provident nam quis nobis incidunt. Aliquid aut alias odit expedita ratione repellendus. Ea exercitationem ipsa nostrum esse.\n\nConsectetur dolores aperiam tempora quis error. Praesentium et ratione voluptas. Fuga rem impedit unde id. Doloribus in atque esse expedita repellat.	24.62	\N	2017-12-06 15:00:01.202621+00	2	"3"=>"6"	f	t
498	Davis LLC	Fugiat odio aliquam amet dolore. Consequatur a iusto quasi. Minus reiciendis aliquid corporis commodi exercitationem. Voluptas quia blanditiis unde nobis repellendus doloribus. Facilis ipsam ratione veritatis sequi.\n\nLibero hic fuga odit praesentium suscipit. Vitae beatae necessitatibus quis asperiores amet asperiores. Quidem architecto tenetur pariatur voluptatem.\n\nFacilis dolor rem est odit suscipit corporis. Nemo modi praesentium atque facilis dolores ad. Eligendi quos sed possimus neque. Facilis quia aliquam fugiat provident consequuntur tempora nam.\n\nOmnis rerum quaerat voluptas numquam dolore exercitationem veritatis. Sint ipsum neque magni repellat. Doloribus veniam voluptas facere optio fugiat doloribus. Ducimus expedita consequuntur impedit in.\n\nTotam ea sequi est sint asperiores accusantium iure. Unde eum doloribus ad perspiciatis quasi.	87.26	\N	2017-12-06 15:00:01.220613+00	2	"3"=>"6"	f	t
499	Young-Ingram	Aliquid explicabo ducimus doloribus enim. Odit commodi rem ducimus iste. Accusamus totam accusamus excepturi placeat veritatis tempora.\n\nId tempora quia totam odit. Odio veniam nesciunt quasi pariatur incidunt. Esse tempora veniam eaque magni incidunt et impedit.\n\nError illo corporis ad sequi eaque doloremque. Quae consequuntur earum laborum et laudantium. Similique rerum reprehenderit dolores quos.\n\nEx optio eveniet doloremque dolor quis aliquam at. Laborum nobis iusto id amet quam. Eum recusandae dolorum vel porro eum natus quod ducimus. Nulla hic assumenda tenetur ut asperiores cum inventore. Soluta eum tenetur voluptas inventore dolore.\n\nVel facere maiores aliquid et. Natus deserunt labore voluptatibus incidunt eius. Id delectus quia ipsa dolorum amet dignissimos eum.	99.75	\N	2017-12-06 15:00:01.243696+00	2	"3"=>"6"	f	t
500	Harris Inc	Labore porro molestiae ea voluptas natus modi deserunt eaque. Veniam dolores ab adipisci esse quo. Deserunt vero laudantium dolorum ipsam ad porro. Id commodi repellat quae sequi corrupti labore enim. Assumenda facere commodi atque quisquam eveniet.\n\nDistinctio debitis ea veniam qui. Officia reiciendis culpa voluptatem rem.\n\nNam nihil eveniet minima deserunt. Quia nemo quam possimus quisquam a hic nisi. Modi delectus tempore tempora nemo praesentium ipsa repudiandae.\n\nQuis adipisci mollitia ipsam neque. Adipisci impedit accusantium quidem repellat recusandae doloribus laudantium. Praesentium non maiores labore praesentium et non. Vitae saepe magnam porro.\n\nIpsa laudantium tenetur iste minima error expedita. Provident eligendi ullam debitis nam ullam eum. Culpa esse odit fuga odit et quo earum accusantium. Consequatur odio omnis optio sint praesentium blanditiis totam.	40.50	\N	2017-12-06 15:00:01.275662+00	2	"3"=>"6"	f	t
501	Porter LLC	Voluptate facere quis quidem. Nisi minima voluptatibus libero laborum. Molestiae placeat debitis recusandae cumque. Vero illo nesciunt odit et reiciendis.\n\nAmet repudiandae exercitationem natus dignissimos architecto. Repellat non officiis mollitia error placeat nobis. Delectus dignissimos at sit reiciendis cumque vitae quod. Ducimus voluptate dolorum ullam laboriosam quisquam dolorum.\n\nRecusandae dicta distinctio culpa quos dolorum. Ab alias sed necessitatibus alias amet illum porro exercitationem. Ea incidunt sunt molestias ipsam fugiat dolores.\n\nVoluptas modi quasi accusantium rerum culpa ratione reiciendis sint. Reprehenderit animi nam vitae totam omnis iste vel. Nam similique officia dolorum eaque vel deleniti.\n\nRepudiandae eligendi quos iusto voluptates ducimus soluta. Accusamus quidem nihil minus quas beatae. Nisi perferendis sequi consequatur perferendis. Alias necessitatibus possimus alias perferendis.	72.45	\N	2017-12-06 15:00:01.302654+00	3	"3"=>"6", "5"=>"13"	f	t
502	Gardner, Miller and Porter	Magni nihil eos aperiam nesciunt. Velit asperiores illum et doloremque in explicabo. Maxime odit ipsum non eum rem. Minus deserunt amet similique quasi exercitationem fugit.\n\nRepellat rem est nisi dignissimos dolore libero. Voluptas vero ut animi natus porro dicta tenetur. Repudiandae recusandae repellendus dolor in consectetur.\n\nMagnam numquam blanditiis reprehenderit amet velit. Et nostrum labore odio. Delectus eius iure eligendi reprehenderit.\n\nVero quasi quam vel. Esse quo corporis incidunt quod ab ullam rerum. Est adipisci libero voluptatibus aliquam officiis beatae impedit in.\n\nNesciunt nemo tempora voluptate quo voluptates nobis dolores qui. Quisquam eligendi iure illum magni. Repellendus numquam est cumque qui quos. Nemo id ratione voluptatum soluta asperiores.	8.19	\N	2017-12-06 15:00:01.35347+00	3	"3"=>"6", "5"=>"13"	f	t
503	Wheeler Inc	Sapiente quo consequatur blanditiis cupiditate at aliquam id. Alias voluptate sapiente cum ea a nostrum non. Cumque voluptatem ex natus qui.\n\nUt architecto sunt nihil magni tempora quod nobis. Ratione fugit sequi quae explicabo odio. Molestias cum error officia totam provident perferendis. Delectus vero facere quidem minus.\n\nProvident soluta nemo placeat magni facere at. Temporibus omnis sint quasi minus corporis assumenda debitis. Tempore dolores quasi natus ipsum. Facere quidem incidunt consequatur maxime esse cumque asperiores.\n\nProvident autem mollitia aliquam quod repudiandae ipsa saepe. Repudiandae placeat corporis impedit. Illum fugiat animi animi ea veniam nobis.\n\nUt iusto quis vitae ipsa. Expedita eum nulla aperiam libero. Laudantium dolorum laboriosam vel. Magni dolores corporis quae modi exercitationem occaecati cumque. Unde optio id autem impedit repellat deleniti optio repellat.	86.40	\N	2017-12-06 15:00:01.385528+00	3	"3"=>"6", "5"=>"13"	f	t
504	Quinn Group	Asperiores esse autem sunt asperiores voluptatem. At voluptates repellendus quibusdam atque doloremque earum. Suscipit inventore blanditiis quam. Distinctio et quas sit soluta soluta veritatis perferendis.\n\nConsequatur consequuntur nulla totam maxime. Qui labore magnam sint praesentium dolor corrupti. Quibusdam fuga animi nam aliquam.\n\nQuae provident porro tempore earum suscipit similique. Quidem consectetur cupiditate explicabo quas deserunt adipisci. Accusamus est error totam debitis.\n\nAb quisquam atque atque aperiam architecto atque. Beatae exercitationem rerum pariatur sit aperiam ea ea quibusdam. Culpa quisquam accusamus laboriosam assumenda ad exercitationem. At alias itaque repellendus sit.\n\nSimilique accusamus maxime nihil quae atque. Fuga rem cupiditate expedita iure nisi nesciunt. Inventore laboriosam placeat maiores tempora. Sit suscipit distinctio doloribus.	48.31	\N	2017-12-06 15:00:01.425146+00	3	"3"=>"6", "5"=>"14"	f	t
505	Young-Flores	Pariatur accusamus itaque odio dolore repellat hic temporibus. Illum qui nobis vero nostrum. Error quo neque asperiores recusandae nulla. Ab minima qui pariatur ullam asperiores.\n\nCorrupti quae illo architecto eligendi mollitia. Veniam sunt ut recusandae fugiat ullam recusandae. Distinctio voluptatibus cumque magnam. Eaque et aut veniam et exercitationem porro eaque.\n\nQuas maxime corrupti consequuntur magni animi ipsa ipsa. Qui reiciendis beatae impedit iste rerum. Necessitatibus autem autem beatae laboriosam aut sequi.\n\nNisi illum debitis delectus non. Sapiente odio in ducimus soluta enim reiciendis. Assumenda voluptas doloremque architecto omnis eum. Velit veniam dignissimos ad nam nesciunt.\n\nQuidem iure nesciunt sapiente quam ipsa recusandae. Nulla quis laudantium similique voluptatum voluptatibus sequi temporibus. Cupiditate voluptatibus exercitationem rem beatae at.	40.91	\N	2017-12-06 15:00:01.458334+00	3	"3"=>"6", "5"=>"14"	f	t
506	Clark, Allen and Matthews	Aperiam eos cumque mollitia incidunt voluptate quo rem corporis. Eaque nostrum ab quae eum quos. Velit perferendis atque alias voluptates ipsa eos itaque. Quis expedita qui dignissimos voluptatum tempora vero.\n\nQuibusdam illo fugit exercitationem necessitatibus accusantium. Magnam accusamus quae tempore amet. Molestias doloribus dolor repudiandae.\n\nRecusandae facilis minus enim ipsum minus culpa nisi sapiente. Cumque vel dolores voluptas dolorem quod ad. Eaque vitae veniam assumenda deleniti ducimus ullam consequatur.\n\nNisi eveniet facilis magni tempora. Unde dolor dolore tempore nam repudiandae. Perferendis laborum eligendi exercitationem deserunt. Similique sapiente mollitia quo doloremque aut ea.\n\nNam eius blanditiis libero numquam. Esse dolor quod voluptatem error sapiente expedita.	2.58	\N	2017-12-06 15:00:01.493197+00	3	"3"=>"6", "5"=>"13"	f	t
507	Johnson, Garcia and Valencia	Sapiente commodi deserunt quod natus magni. Optio dolorum possimus eveniet libero ducimus libero impedit. Voluptatibus nostrum tempore laudantium vitae.\n\nAspernatur repellat laudantium asperiores perferendis velit dolorem libero. Minus nostrum dolore omnis earum. Reiciendis esse enim rem. Iure voluptates soluta adipisci perferendis.\n\nSoluta ratione iure enim delectus deleniti doloremque. Nostrum in laudantium ratione molestiae ex officia. Labore eaque recusandae expedita quasi. Vitae voluptas consectetur nisi sequi quidem commodi illum.\n\nVoluptas veniam tenetur odio accusantium voluptatem optio dolorem. Veniam distinctio asperiores nesciunt laboriosam suscipit molestiae. Similique perferendis cupiditate atque explicabo facilis. Earum aliquam repudiandae autem quaerat saepe fugiat.\n\nVoluptate laborum voluptatibus fugiat sequi quisquam distinctio magni nihil. Nihil nostrum iure impedit molestias iure sit. Quae magni eaque nostrum est voluptas sit.	36.58	\N	2017-12-06 15:00:01.530711+00	3	"3"=>"6", "5"=>"14"	f	t
512	Sanders and Sons	Quo facere tempora sunt commodi. Facilis facere repellat quidem ipsum iure. Autem fuga vel molestiae asperiores modi aliquam necessitatibus magnam.\n\nLaborum eligendi enim quaerat nisi. Cupiditate ducimus cum fugiat nisi esse dolore. Animi laborum inventore dignissimos.\n\nVoluptatum excepturi libero dolorum. Consectetur quisquam atque sequi voluptatem labore similique. Culpa distinctio necessitatibus velit ipsum vel. Reprehenderit esse inventore dolore alias consequatur fugit.\n\nVoluptas earum nostrum quos eum perferendis. Fuga necessitatibus impedit eaque amet tempore quos. Porro porro iste nobis cum dolor.\n\nPlaceat repudiandae occaecati porro sapiente. Delectus voluptatibus ipsum esse veniam deserunt omnis esse. Aperiam quidem velit voluptatibus deserunt accusantium temporibus.	25.82	\N	2017-12-06 15:00:01.773888+00	4	"3"=>"6", "7"=>"20"	f	t
513	Johnson, Lopez and Phillips	Modi tempore dolorem ut iure maiores. Facere doloribus quod et odio eveniet delectus. Sit fugit dignissimos voluptatem fugit sapiente maxime. Nihil veritatis cum sapiente rerum veritatis.\n\nIure nostrum doloribus incidunt accusamus sequi. Deleniti minima molestiae non facere expedita ut maxime odit. Maxime nam modi magni expedita ducimus modi fugit. Eos quidem neque velit neque optio dignissimos magnam.\n\nMinima nesciunt debitis eum architecto. Esse doloremque tempora sint. Aliquid impedit eveniet ea ducimus. Consequuntur pariatur mollitia similique quibusdam quod aliquid repudiandae.\n\nVoluptatum ipsum voluptatum illum vitae occaecati dolorem. Doloremque sunt laborum nobis hic. Ducimus sunt similique modi ipsam cum. Tenetur tempora maxime exercitationem praesentium perferendis consequatur ipsum.\n\nPorro consequatur eum temporibus nostrum architecto natus quidem. Molestias quo nobis quo eius. Quae at aliquid nulla harum. Vel quidem voluptatem consectetur beatae.	52.89	\N	2017-12-06 15:00:01.808186+00	4	"3"=>"6", "7"=>"19"	f	t
508	Jones, Gordon and Vargas	Ipsam molestias molestias et natus consequatur blanditiis. Enim dolores iure saepe consequatur voluptatem dolorum possimus. Facere dolor optio saepe eos.\n\nVoluptatem odit nisi saepe assumenda officiis totam. Occaecati eligendi est quaerat laudantium. Ex aspernatur repudiandae occaecati ullam. Animi repellendus cupiditate velit fugit accusantium necessitatibus.\n\nRerum soluta officia animi cupiditate omnis dolor placeat fugit. Corporis iste ipsam neque eligendi. Ex dolor reprehenderit voluptatem error dolor. Dignissimos ipsam explicabo aperiam excepturi unde. Odio voluptatibus quo hic est eveniet rem voluptates.\n\nQuod quia voluptate iusto omnis odit porro maiores. Suscipit facere iure sit cum autem numquam maiores pariatur. Quisquam reiciendis expedita eaque consequatur quod tempore officia. Mollitia ut quasi reiciendis dolor nobis cumque.\n\nIpsam iusto et tempore neque dolore. Recusandae a saepe dolore iste. At blanditiis voluptatum aliquam velit minus.	97.59	\N	2017-12-06 15:00:01.577199+00	3	"3"=>"6", "5"=>"14"	f	t
509	Roberts-Novak	Explicabo modi eligendi mollitia doloribus ratione odit aliquam. Tempore aliquam similique quod nesciunt ab. Nihil autem numquam omnis natus quod excepturi occaecati.\n\nInventore occaecati dignissimos vero ab. Labore dolores molestias labore dolore a. Eaque fugiat beatae qui ea amet deserunt id. Id possimus optio laudantium repellat molestiae voluptatem. Laborum saepe ipsam reiciendis expedita aliquam debitis nihil quaerat.\n\nDeserunt accusamus voluptate quasi ex. Quis ipsam labore officia itaque quia. Rerum laudantium porro ut dicta amet repellat. Placeat sit eum dolore unde tenetur alias consectetur enim.\n\nSapiente esse voluptate esse soluta natus. Illo deleniti ea eum ducimus dignissimos architecto quidem illo. Fugit ea et est perspiciatis facilis recusandae distinctio. Sed atque iste eaque reiciendis. Iusto numquam neque omnis excepturi fuga nihil perspiciatis cupiditate.\n\nCommodi atque nam quae distinctio ab. Cupiditate quae optio reiciendis assumenda amet quod perferendis. Nesciunt tempora quis atque consectetur. Non ut magni eos consectetur tempora quia repellendus ea.	63.89	\N	2017-12-06 15:00:01.629784+00	3	"3"=>"6", "5"=>"14"	f	t
510	Simmons-Dixon	Magni nulla ipsa repellat assumenda distinctio maxime. Velit officiis inventore dignissimos officia expedita. Cumque dolores consequatur officiis laboriosam.\n\nEx aperiam rem ipsum quam libero deleniti optio at. Occaecati eaque consectetur sint laboriosam rerum nisi. Dignissimos eveniet vero amet cupiditate quidem incidunt. Cupiditate ducimus omnis illum laudantium nam omnis vel delectus.\n\nQuos mollitia fugit facere. Nesciunt culpa officia vitae dolores debitis sapiente explicabo ab. Ducimus a voluptate laudantium repellendus. Perspiciatis consectetur odit ipsam nam. Odit odio laboriosam nam totam eos quaerat sint.\n\nEa recusandae nemo tempore at. Sint a architecto recusandae at similique. Incidunt occaecati maxime voluptas. Labore animi dolores aperiam vero. Dicta odio nisi distinctio dolore nam.\n\nPerferendis sint voluptates nostrum quam. Temporibus rerum labore impedit sapiente tempora numquam animi. Sunt praesentium quia hic explicabo quos. Maxime voluptate eius omnis possimus.	95.61	\N	2017-12-06 15:00:01.67984+00	3	"3"=>"6", "5"=>"13"	f	t
511	Haley-Kennedy	Fuga distinctio modi omnis culpa mollitia similique. Cupiditate fugit totam laboriosam nam atque cumque. Repudiandae modi natus omnis odit nisi quo optio.\n\nCorrupti aliquid quam deleniti nobis. Quis distinctio est nostrum laborum cupiditate vitae itaque. Sunt perferendis provident nam numquam laboriosam.\n\nTempora earum velit beatae perferendis eius. Quaerat quo at iure ea sit. Possimus quidem fuga amet reiciendis.\n\nOmnis repellendus quas dolorem unde soluta eaque natus ut. Atque ut et assumenda tempore similique blanditiis molestias. Qui magnam consectetur veritatis veritatis velit ab. Maxime animi sunt odit repellendus rerum eos.\n\nExpedita eius accusantium vitae occaecati vero soluta. Dolorem inventore eos culpa velit eius.	65.79	\N	2017-12-06 15:00:01.72751+00	4	"3"=>"6", "7"=>"19"	f	t
514	Nunez, Moreno and Gibbs	Earum similique doloribus est suscipit nihil modi. Reprehenderit repellat ut praesentium mollitia.\n\nSint maxime incidunt ut tempora doloremque fuga error harum. Laudantium aut consequatur perferendis dolores eum similique. Impedit tenetur distinctio labore pariatur ducimus. Dolorum accusamus odio ratione vel consectetur.\n\nMollitia maxime impedit distinctio temporibus commodi consequuntur. Odit assumenda nemo quidem. Amet soluta necessitatibus veritatis. Vitae atque voluptatem tempora excepturi maiores modi.\n\nLaudantium vitae distinctio optio repudiandae commodi praesentium. Maxime aliquam recusandae molestiae facere accusamus minus consectetur. Alias asperiores aspernatur assumenda perspiciatis ipsa illum delectus. Recusandae praesentium molestiae et.\n\nPerferendis sint doloremque voluptatum iste laudantium. Repellat eius excepturi quasi vitae. Dignissimos magnam laborum rerum quas. Dolorem animi porro sit eveniet.	66.14	\N	2017-12-06 15:00:01.851728+00	4	"3"=>"6", "7"=>"19"	f	t
515	Thompson-Stephens	Debitis vitae ducimus atque voluptatem voluptatem cupiditate ducimus. Ea repellat aspernatur eos maiores voluptates omnis. At harum cum id ipsam sequi aspernatur necessitatibus. Quasi dolores cumque autem officiis.\n\nConsequuntur corrupti nisi facilis ipsum quae. Autem incidunt dicta laboriosam veniam dignissimos vero distinctio. Excepturi temporibus nemo cupiditate hic temporibus tempore distinctio.\n\nIpsum voluptatum iste nihil fugit minima. Dignissimos dicta laboriosam nulla unde dolores iste id. Voluptates similique praesentium exercitationem praesentium.\n\nFuga nam at dolorem ipsam est doloribus id. Voluptatibus odit a nulla atque eaque ea. Autem nihil commodi magnam suscipit neque. Ex commodi officiis tenetur. Recusandae quia maiores debitis ipsum.\n\nMaiores hic modi nisi dolores quasi aliquid placeat. Possimus commodi ullam eius culpa laboriosam suscipit provident. At excepturi quas dolore nobis minima placeat. Omnis maiores accusamus tempora dignissimos doloribus.	49.37	\N	2017-12-06 15:00:01.899012+00	4	"3"=>"6", "7"=>"20"	f	t
516	Meyers-Stein	Deleniti praesentium placeat quia praesentium. Aspernatur dolorum delectus doloribus sequi voluptatem quas distinctio. Quod ipsum laborum optio ratione eligendi.\n\nTenetur cumque deserunt occaecati pariatur dolor. Magnam culpa odio quam expedita rerum labore. Quos quia cumque nemo distinctio eius. Recusandae sint ut aspernatur quos tempora natus minus.\n\nQuasi ipsam sit quibusdam esse. Odit in dicta ab unde quos minus. Voluptates dolor molestiae minus consectetur voluptatum. Provident consequatur ex quis neque nam corrupti.\n\nDicta eveniet officiis illo ipsa expedita laborum ratione. Animi itaque maiores aperiam id minima est neque numquam. Beatae aspernatur laborum vel tempora facilis nisi.\n\nAccusamus cum maxime voluptates omnis mollitia. Ipsa quod ratione mollitia cum. Minima voluptas necessitatibus quis ullam quos dolor voluptates.	72.19	\N	2017-12-06 15:00:01.945816+00	4	"3"=>"6", "7"=>"19"	f	t
517	White and Sons	Maiores pariatur optio eveniet ex possimus quibusdam. Impedit magnam veritatis sed. Impedit reprehenderit ducimus voluptatem earum nulla eius placeat. Officiis corrupti praesentium accusantium dolorem.\n\nAlias corrupti sint nemo. Omnis delectus at dolor modi. Tempora exercitationem nemo blanditiis minus dolor assumenda. Sit beatae ullam non dolorum quo.\n\nIllum tempore eligendi error ipsam. Perferendis neque nihil mollitia soluta nam. Repudiandae fugiat odit adipisci nostrum odio. Corrupti unde sit rerum est dicta iusto.\n\nSint harum tenetur in. Assumenda numquam libero earum similique saepe possimus veritatis. Et dicta neque explicabo velit soluta tempore sint.\n\nVoluptatem exercitationem eveniet eaque dolorum similique neque. Magnam labore tempora recusandae vel sunt. Maxime nobis dolores quam ipsa illo. Eos dignissimos exercitationem quibusdam quo omnis earum.	68.70	\N	2017-12-06 15:00:01.994118+00	4	"3"=>"6", "7"=>"19"	f	t
518	Wilcox PLC	Vitae ullam nisi in eligendi reiciendis. Nihil culpa neque mollitia dolorum minus dolorum magni. Libero numquam cupiditate necessitatibus eos voluptate alias atque. Nihil iste a voluptas consequatur molestiae veritatis.\n\nEos nostrum voluptatibus eligendi ex nostrum vel rem. Eaque consequuntur deleniti neque. Rerum laborum at totam et eos iure.\n\nFuga id minima quisquam sunt. Blanditiis culpa corporis quo minima nostrum. Nesciunt nesciunt magnam harum nostrum.\n\nQuod provident omnis asperiores quidem. Laboriosam est cupiditate ipsum neque.\n\nEt praesentium explicabo mollitia dicta voluptatem earum. Veritatis consequatur aperiam deserunt est aspernatur nobis eaque. Pariatur quidem molestias voluptas fugiat.	50.12	\N	2017-12-06 15:00:02.030946+00	4	"3"=>"6", "7"=>"19"	f	t
519	Hughes Ltd	Ad saepe occaecati nemo minus vel. Omnis iste excepturi praesentium explicabo impedit. Placeat ullam labore atque vitae. Natus inventore alias aliquam fugit commodi.\n\nVero tempore odio facilis blanditiis officiis ab facere corrupti. Voluptatibus accusamus beatae voluptas placeat minima eius veritatis. Harum molestias deserunt tempore sed.\n\nQuae reiciendis ducimus ullam fugiat. Esse voluptas optio delectus rerum. Iure eius porro officia alias officia odit nostrum quis.\n\nVeritatis hic magni ipsam illo quis minus quod. Rem pariatur hic libero quam quod accusantium cum sequi. Fugiat repellat laborum doloribus accusamus. Laudantium ullam sequi quisquam perferendis aut modi vitae.\n\nHarum quisquam explicabo alias. Nihil perferendis accusantium occaecati aspernatur sed praesentium.	43.23	\N	2017-12-06 15:00:02.078113+00	4	"3"=>"6", "7"=>"19"	f	t
520	Williams LLC	Harum voluptatem non ducimus assumenda beatae rerum perspiciatis quae. Iure tempora eaque enim repellat a voluptatibus praesentium. Beatae tenetur mollitia nulla laboriosam.\n\nConsequuntur minus atque nemo debitis reprehenderit. Deserunt ullam rem architecto beatae sint aperiam. Non reprehenderit fuga itaque praesentium deserunt numquam soluta exercitationem. Sed sequi sint sed eos iste. Culpa amet eum architecto quas totam aperiam.\n\nRepudiandae assumenda illum impedit aliquid amet quasi. Laudantium porro sint doloremque ad. Atque velit dolorum earum nisi.\n\nEarum magni excepturi eligendi autem blanditiis repellendus. Totam voluptatem ea quasi itaque facilis. Labore nihil necessitatibus debitis corporis corporis. Ab autem dicta ratione cupiditate.\n\nId tempora quod dolorum. Quo dolores corporis quos recusandae nisi aliquid. Fugiat tempore laboriosam modi enim dolor.	0.58	\N	2017-12-06 15:00:02.111677+00	4	"3"=>"6", "7"=>"20"	f	t
521	Greene PLC	Modi eos ab tenetur. Nostrum quos deleniti odit reprehenderit. Ea alias praesentium quam eligendi numquam. Alias tempore quisquam eligendi deserunt corrupti.\n\nReiciendis tenetur rerum voluptatem ratione consectetur. Nemo sequi odio soluta laudantium. Et molestiae hic necessitatibus eum blanditiis molestiae impedit.\n\nTempore rem itaque nisi earum occaecati quibusdam distinctio. Veritatis cum nihil optio minima. Odio ratione nam id repudiandae eum. Quaerat ab doloremque dolor hic perferendis possimus.\n\nUllam laudantium est sunt. Accusamus dolorum iste alias doloremque. Facilis cum odio quaerat dolore praesentium dolorum. Esse beatae mollitia iste similique quam nemo.\n\nCorrupti possimus ut illum molestias totam. Laboriosam odio dolore molestias sed aliquam libero sequi. Adipisci iste ad consequatur quas ab eius pariatur.	60.73	\N	2017-12-06 15:00:02.146621+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
522	Parker, Martinez and Scott	At perspiciatis nam expedita accusantium asperiores labore modi. Distinctio dolore alias rerum id ea accusamus. Magnam est maxime porro alias nihil molestiae ipsa dicta. Inventore natus magni qui similique quia.\n\nQui cupiditate debitis accusamus facere repellendus numquam. Atque porro quo corporis temporibus fugit.\n\nNesciunt id possimus nisi officia optio excepturi nulla ut. Earum aliquid cumque voluptatem reiciendis. Enim eligendi est iste modi quod mollitia quas. Error saepe qui natus.\n\nOccaecati molestias rem placeat error. Temporibus sequi corrupti totam consectetur nulla numquam id. Corporis odio unde error omnis expedita vitae. Quos perferendis reiciendis repudiandae facere aut sequi iusto minus.\n\nLaudantium fuga at maxime quae maiores ut corporis voluptatum. Vel in quasi voluptas. Ipsam quae dolores ducimus consectetur et maiores. Nemo deserunt qui expedita alias non.	79.36	\N	2017-12-06 15:00:02.178976+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
523	Fisher, Bailey and Morris	Dignissimos harum iure totam eum. Sunt laboriosam maxime vel dicta asperiores hic officia occaecati. Qui vitae doloribus itaque fugit impedit.\n\nAmet consectetur blanditiis ducimus non temporibus voluptate dolore. Ab asperiores rem amet corporis itaque. Sed quos expedita fuga tempora. Magni labore cumque ab voluptas.\n\nCorrupti impedit rem amet quo unde debitis et. Reiciendis placeat eum repellendus quo.\n\nFacere nam qui pariatur adipisci ipsam. Fugiat repellendus distinctio saepe perferendis quis sequi. Doloribus ea voluptas ducimus. Placeat sequi suscipit fuga ipsum adipisci quo.\n\nFugiat possimus fugiat a temporibus deserunt. Eveniet perferendis libero eos placeat ipsum. Labore voluptatem non ipsam nulla. Cupiditate saepe veniam nihil atque. Nisi debitis deleniti impedit voluptatem sint laudantium incidunt.	52.87	\N	2017-12-06 15:00:02.21111+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
524	Duncan-Crane	Inventore libero rem eius beatae aspernatur. Blanditiis ipsum harum asperiores esse. Eum explicabo nobis dicta eveniet est eius dignissimos.\n\nNecessitatibus voluptatibus omnis quo blanditiis autem. Mollitia adipisci cum labore voluptatum tenetur. Quasi explicabo fuga deserunt fuga. Dolor ab reprehenderit quisquam modi doloremque consequuntur illum.\n\nCorrupti nihil architecto exercitationem aliquam tempora doloribus dolorem earum. Hic aperiam dolore architecto facilis. Temporibus harum cupiditate provident similique maiores ea ad.\n\nLaboriosam ullam pariatur pariatur neque. Illum repellendus reprehenderit accusamus cupiditate perspiciatis delectus. Error qui eum corporis reiciendis reprehenderit quia.\n\nFugit doloremque consectetur optio numquam veniam. Esse ipsam sequi quibusdam officiis occaecati odio esse. Temporibus mollitia ratione enim earum aut veniam voluptatum blanditiis.	11.88	\N	2017-12-06 15:00:02.236062+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
525	Stephens, Moore and Landry	Asperiores praesentium voluptatem iusto. Voluptatem facere laborum maiores veritatis ipsum. Iure nisi ipsum accusantium facere eius suscipit.\n\nVel accusantium consequatur odit debitis nobis provident. Quaerat labore amet inventore rerum. Commodi earum quae iure nobis.\n\nRatione eaque fuga earum. Asperiores delectus atque eum in eveniet maiores corporis maxime. Enim quod nam ipsam cupiditate at nobis consequuntur.\n\nA fuga modi facere ab praesentium dolor. Numquam natus modi cumque voluptatibus dolores libero. Illo veniam animi ipsa ut sint dicta. Minima atque tempora nemo magnam.\n\nConsequatur nobis unde accusamus ipsam. Ab facere corrupti alias expedita dolore quas iure. Ducimus ipsa hic ut numquam at distinctio.	93.34	\N	2017-12-06 15:00:02.262326+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
526	Aguirre Inc	Autem mollitia molestias pariatur ab sequi. Veniam vel labore illum aut est molestiae voluptatum quibusdam. Perferendis debitis laudantium repellendus tenetur quaerat nihil. Nulla dolorem officia consequatur eius.\n\nLaborum harum maxime deleniti maxime. Optio debitis neque ab quos eum asperiores. Quia ipsa veniam maxime maxime molestiae consequatur vitae mollitia. Perspiciatis magni aliquid error ipsa.\n\nA sint molestias nostrum deserunt est tempore. Blanditiis magni sit nesciunt repudiandae ipsa. Perferendis ad consectetur saepe.\n\nMinus blanditiis rerum ex sit iure ad. Eveniet ea vel nostrum consequatur voluptatem ea. At reprehenderit cumque aut.\n\nTotam asperiores laudantium odit repudiandae saepe. Porro quasi unde ad modi ipsa ea. Qui deserunt soluta quidem harum.	24.32	\N	2017-12-06 15:00:02.298823+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
527	Rocha-Wang	Quasi accusamus molestiae fugiat blanditiis. Error id earum culpa nostrum eaque. Architecto tempora neque delectus rerum. Iste maxime reiciendis repellat ullam enim facilis.\n\nEsse fugiat in vitae itaque vel reiciendis distinctio ipsa. Facilis qui neque dolores illum quas. Ad nisi quo fugit numquam consequatur deserunt expedita. Facere iusto aut quia perspiciatis repudiandae amet. Eos et aperiam ex eius numquam ea.\n\nEarum sint odit neque cum omnis. Blanditiis et accusamus tempora omnis officia quod quisquam. Porro qui odit assumenda ad.\n\nExplicabo repellendus nulla voluptatibus voluptatibus quas beatae in ipsum. Illo placeat accusantium veniam. Rem culpa velit repudiandae repudiandae quod voluptates dolores. Culpa eveniet sequi veritatis magnam eius beatae.\n\nFacilis qui mollitia ut quibusdam voluptatem labore. Consequuntur sunt in deleniti repellendus dolor doloremque. Assumenda harum perspiciatis vero omnis neque similique sequi. Nesciunt in atque dignissimos aspernatur aliquid.	6.88	\N	2017-12-06 15:00:02.33935+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
528	Garcia-Brown	Laborum dolore voluptas in natus asperiores blanditiis dolorum. Veritatis quibusdam adipisci dolores repellendus nostrum aliquam. Velit nam itaque magni nostrum. Adipisci porro fuga libero quod ad aspernatur ducimus.\n\nMinima necessitatibus illum expedita ea vitae. Natus impedit ducimus commodi qui praesentium. Accusantium velit rerum quia voluptatum ut sunt at.\n\nAmet reiciendis soluta cupiditate aperiam esse. Asperiores exercitationem tempora hic delectus dolor blanditiis vel. Consequuntur nemo neque ullam ipsum natus. Architecto labore excepturi minus exercitationem debitis et.\n\nAccusamus unde esse doloremque numquam corrupti ratione pariatur. Labore occaecati consequatur alias assumenda consequuntur minus eaque. Cumque soluta placeat nulla.\n\nEum ratione unde facilis earum aliquam. Expedita dolorum repellendus non deleniti pariatur beatae quod. Ullam harum in magnam corporis ipsa saepe quod. Ipsa perspiciatis laborum incidunt autem quaerat.	15.57	\N	2017-12-06 15:00:02.367376+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
529	Jones, Silva and Wheeler	Reprehenderit officiis error similique autem porro illo ea. Accusamus id occaecati rem nesciunt pariatur. Odio fuga eum fugiat eum.\n\nVero aperiam modi doloremque doloremque debitis ad ex. Non unde cupiditate inventore vel eius veritatis tempore corrupti. Voluptatibus cum autem minima voluptates saepe.\n\nVoluptas deserunt praesentium quos. Iusto accusamus impedit vel temporibus. Ad rerum magni provident aliquid laudantium exercitationem. Quia cupiditate necessitatibus rerum.\n\nDolore numquam provident voluptate nesciunt ex voluptatibus voluptate consequatur. Provident incidunt soluta amet libero delectus. Animi ut quo culpa.\n\nSuscipit ipsam distinctio excepturi cumque totam accusamus aspernatur. Et rem architecto sint ut aperiam repudiandae eius. Aliquid minima et possimus pariatur officia eos.	25.60	\N	2017-12-06 15:00:02.395211+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
530	Smith-Dixon	Fugiat placeat voluptatem amet accusantium temporibus. Molestias ratione corrupti dolores aliquid nemo. Distinctio ratione vel culpa non nobis. Impedit a sint delectus ad quam. Iste nesciunt fugit dolores iure aut provident.\n\nQui nihil minima hic voluptas iusto recusandae. Possimus vitae fugiat rerum quidem. Totam unde sequi dolores nostrum occaecati voluptatibus voluptates. Soluta dolorum quisquam doloremque vel culpa ipsa.\n\nDolores corrupti optio cumque cupiditate necessitatibus nulla quaerat. Accusamus officia sint blanditiis. Quod sapiente beatae assumenda deserunt illo dicta libero laboriosam. Officiis impedit officiis quidem aliquam ad.\n\nDicta hic vitae minus iste odit. Amet similique iure modi occaecati ipsam voluptatum minima. Molestias nostrum maxime iste. Fuga impedit molestiae atque sunt quae reiciendis.\n\nSed ipsa ut dolor illo aliquam quod. Cupiditate distinctio culpa illo molestias. Aliquam ad fuga similique nihil quae voluptatum.	62.63	\N	2017-12-06 15:00:02.436184+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
531	Chen, Newton and Johnson	Quaerat omnis dolore consequuntur distinctio soluta exercitationem. Perferendis dolores quae occaecati architecto tenetur dolore in. Eligendi nostrum distinctio natus. Laudantium blanditiis aliquid natus porro ipsam.\n\nIpsum quia totam quaerat dolores totam. Earum inventore expedita in officia temporibus. Explicabo veniam accusantium voluptas possimus sapiente hic. Laboriosam magni quos voluptatum maiores laudantium accusantium reprehenderit.\n\nEarum praesentium occaecati assumenda. Dolorum suscipit ex iste id. Possimus dicta quibusdam dignissimos quo eaque ipsum. Maxime molestias perferendis vero.\n\nItaque odio voluptas ipsam temporibus. Beatae dolorum impedit voluptatibus earum quaerat.\n\nQuia corrupti corrupti voluptatum fugit consequatur. Porro libero reprehenderit hic nemo illum est quos. Sunt rem quos officia vel dignissimos.	63.38	\N	2017-12-06 15:00:02.480376+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
532	Maynard PLC	Amet adipisci minus suscipit nemo odio. Atque earum iste blanditiis aperiam. Dolore unde iste fugiat quod libero maxime ipsum quibusdam.\n\nQuidem reprehenderit eveniet ipsam odio ea. Maiores esse provident cum voluptates. Doloremque corrupti reiciendis nobis veniam doloremque. Iusto ex aperiam aliquid numquam minus.\n\nOdit reprehenderit voluptate iusto aut incidunt vel. Laudantium modi qui totam culpa laboriosam quo. Unde sunt doloremque eius officia exercitationem. Earum excepturi vero explicabo nostrum deserunt ullam excepturi.\n\nFugit natus officia expedita nemo. Explicabo delectus assumenda sunt dolorem similique iusto officiis. Error delectus neque eaque nisi eligendi doloremque omnis.\n\nEligendi aut sequi libero a. Quas provident sunt corporis architecto quibusdam incidunt earum. Sapiente labore totam ea beatae saepe voluptates dolore reprehenderit. Facere ab earum quidem.	8.90	\N	2017-12-06 15:00:02.511334+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
533	Escobar-Stewart	Expedita officia error quae mollitia laboriosam aperiam. Amet debitis repellat mollitia. Consectetur aperiam nihil vero aliquid iure modi magnam quasi.\n\nVoluptatibus quod temporibus natus atque delectus tempora. Doloremque dolores aut officiis iusto fugiat necessitatibus. Omnis sapiente error cumque neque et. Accusantium fugit voluptates voluptas.\n\nDistinctio vel dicta nesciunt laudantium aut. Odit mollitia ipsa ipsam. Nobis numquam soluta earum similique. Dicta maiores architecto eos illo dolores maxime dolorem.\n\nRem aliquid ad error possimus magni voluptatibus repellat. Ut alias voluptas quo occaecati. Possimus odio molestias iste maxime cum. Libero commodi fugit repellat distinctio adipisci facere pariatur. Ab nisi excepturi beatae aut asperiores.\n\nVoluptate aliquid laborum impedit quis. Libero aperiam vel blanditiis in similique est eaque eveniet.	84.25	\N	2017-12-06 15:00:02.542102+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
534	Park, Orozco and Johnson	Quaerat nobis voluptas rerum culpa cum iure quisquam. Ipsum dolores omnis omnis dignissimos ipsum sunt odio occaecati. Enim et amet nulla architecto sint et necessitatibus. Debitis placeat accusantium deserunt aut deserunt sed.\n\nDistinctio at aliquid repellat quibusdam exercitationem. Odit repellendus occaecati deleniti quidem iste laboriosam nobis. Voluptatem amet et eum reiciendis eveniet laudantium nobis. Adipisci natus omnis sed hic excepturi iste rerum distinctio.\n\nNobis nesciunt vero similique. Architecto totam quo eaque iste in. In aut veniam odio alias veniam vero voluptatem.\n\nDebitis expedita dolore perferendis quae non voluptate. Asperiores adipisci praesentium praesentium laudantium possimus error omnis. Optio soluta quisquam dolor vel assumenda.\n\nOfficia ratione maxime in consequatur quidem est est. Nostrum officia eum distinctio reiciendis tempora. Adipisci voluptate delectus itaque deserunt sed deserunt. Architecto qui dolorum ea laudantium rem. Culpa laboriosam dolore molestias fugit.	92.70	\N	2017-12-06 15:00:02.580633+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
535	Burnett-Weber	Natus iusto consectetur itaque deserunt numquam optio labore ducimus. Mollitia saepe dolorem exercitationem ex ipsam necessitatibus. Delectus architecto dicta eius libero aliquam ab.\n\nRepellendus quasi asperiores sit ut eius. Autem quia ipsam quos ea. Optio saepe asperiores excepturi.\n\nEaque repellendus laudantium sapiente velit iste. Nobis amet voluptatem ab accusamus praesentium earum reprehenderit. Sit dolorum autem rerum dolores. Odit fugit deleniti incidunt natus.\n\nRepudiandae tempora saepe eum quisquam aspernatur. Illo aliquam tenetur est praesentium voluptates accusantium quos. Ullam assumenda adipisci rem mollitia at porro neque.\n\nIllum quibusdam quis possimus necessitatibus. Necessitatibus perspiciatis dolorum unde necessitatibus fuga. Harum animi rerum delectus blanditiis. Dolorem alias repellendus facere quibusdam molestias.	88.63	\N	2017-12-06 15:00:02.619636+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
536	Morales-Hill	Officia repudiandae quidem ea tempore distinctio facere. Doloremque nam molestiae temporibus voluptates quaerat. Eum culpa ratione similique.\n\nIpsa earum numquam sequi quasi esse. Reprehenderit debitis consequatur totam voluptate deleniti eum. Delectus reiciendis at laudantium porro expedita iusto consequuntur iste.\n\nEum ipsa delectus cumque ad necessitatibus dolore est ducimus. Exercitationem magnam aspernatur at. Quaerat ratione illum porro eligendi impedit. Suscipit ea veniam error illum.\n\nAnimi nam reiciendis voluptas id totam explicabo soluta eos. Deserunt corrupti voluptatum voluptatum corrupti. Earum placeat saepe debitis ex itaque. Esse quisquam quaerat ratione esse veritatis repellendus.\n\nIusto necessitatibus odit numquam sint. Enim delectus beatae voluptatibus voluptatum adipisci hic magni. Laudantium ea nulla reprehenderit dolorem magni.	12.55	\N	2017-12-06 15:00:02.660057+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
537	Collins PLC	Cupiditate ea nostrum beatae aliquid quas. Animi minima corporis cupiditate exercitationem ex laudantium nisi. Rerum enim expedita voluptatum sit accusamus et.\n\nError mollitia laborum commodi architecto animi perferendis beatae inventore. Reiciendis autem enim numquam. Dignissimos laboriosam dicta eius excepturi fugiat.\n\nQuam assumenda cum soluta perspiciatis. Placeat perferendis quisquam tenetur veniam. Totam aspernatur unde explicabo aliquam voluptate. Cupiditate similique repudiandae dignissimos beatae harum.\n\nQuisquam recusandae ipsa consectetur incidunt. Dicta adipisci explicabo veniam quidem ipsum. Reprehenderit reprehenderit nesciunt voluptas voluptatem repellendus nihil corrupti incidunt. Perspiciatis nostrum labore magnam magnam.\n\nFacilis voluptatibus repellendus repellendus. Maiores distinctio voluptates impedit corrupti vitae eveniet. Magni ullam officiis accusantium beatae quam aut optio quisquam. Velit iusto nihil earum facere laborum.	54.72	\N	2017-12-06 15:00:02.710471+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
538	Silva, Hale and Garrett	Animi vero debitis voluptatem corporis tempora soluta adipisci. Ab vero consequuntur odio earum consequuntur provident. Ea aperiam error aliquam debitis. Ab sapiente corrupti laborum.\n\nQuod sed facilis delectus at dignissimos quod. Consequatur deleniti tempora dolor debitis impedit sint et. Expedita nulla esse odit autem veritatis quisquam delectus. Magni architecto asperiores magnam vel cum.\n\nRecusandae excepturi iure inventore error. Adipisci sint aspernatur quasi ut fugiat doloribus.\n\nRem fugiat voluptate dignissimos et ea explicabo. Ea provident corporis porro consectetur voluptate ratione vitae. Quasi voluptas necessitatibus a sunt sit. Voluptatum ipsa rerum modi necessitatibus cumque quisquam sequi itaque.\n\nAdipisci voluptatum laboriosam sint recusandae est magni. Pariatur optio nesciunt dolor ab accusamus. Deserunt doloremque dolorem aliquid nostrum earum nesciunt. In reiciendis itaque eveniet temporibus est. Animi aliquam maxime dolorum eveniet.	16.38	\N	2017-12-06 15:00:02.762058+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
539	Torres, Burns and Johnson	Unde consequuntur corporis error maiores mollitia. Quis magnam blanditiis occaecati deserunt veritatis sapiente facilis. Laboriosam iste fugiat vero. Similique cumque odio voluptatem culpa laborum exercitationem.\n\nIpsa dolores inventore laboriosam facere assumenda. Delectus accusamus libero voluptas. Nostrum ipsum dicta dolore vitae. In nobis itaque suscipit veniam sit delectus.\n\nFugiat illum in quas. Possimus debitis assumenda modi voluptatum. Occaecati minus esse eos nulla maxime sequi. In ducimus perferendis laboriosam nobis perspiciatis.\n\nEum quaerat veritatis eos nemo. Itaque voluptas fugiat natus quasi rerum debitis eaque perspiciatis. Omnis expedita quae expedita ullam.\n\nSapiente consectetur officia quod neque officia minus. Voluptas fuga pariatur ut ipsa voluptates doloremque doloremque. Consequatur animi adipisci deserunt dolorem ipsum.	74.68	\N	2017-12-06 15:00:02.811079+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
540	Cook Ltd	Voluptatibus sit vitae laudantium delectus fugiat eaque ut. Quidem expedita reprehenderit nulla molestias. Repellat eos impedit sapiente accusamus eligendi animi repellendus quos.\n\nAdipisci dolore laborum repellendus commodi nihil possimus. Omnis incidunt eaque natus facere doloribus dolores. A mollitia cum explicabo suscipit.\n\nAliquam dolore illum neque impedit odio. Libero culpa cupiditate at nam nulla dolor. Eaque vitae placeat quaerat illo ipsum alias quae. Aut aliquam expedita totam consectetur. At perspiciatis possimus neque ab incidunt at soluta ipsam.\n\nNulla modi voluptatum amet cupiditate. Quidem ullam placeat expedita distinctio. Amet minima quas corporis inventore velit. Autem corrupti doloremque iusto fugiat officiis molestias aspernatur.\n\nNulla voluptate animi eveniet deleniti corporis. Nisi dolorem non veritatis rem nisi veniam nobis repudiandae. Culpa repellat ducimus asperiores fugit. Tempore doloribus debitis ratione ipsa.	77.71	\N	2017-12-06 15:00:02.84695+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
\.


--
-- Data for Name: product_product_categories; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_product_categories (id, product_id, category_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	1
11	11	2
12	12	2
13	13	2
14	14	2
15	15	2
16	16	2
17	17	2
18	18	2
19	19	2
20	20	2
21	21	3
22	22	3
23	23	3
24	24	3
25	25	3
26	26	3
27	27	3
28	28	3
29	29	3
30	30	3
31	31	3
32	32	3
33	33	3
34	34	3
35	35	3
36	36	3
37	37	3
38	38	3
39	39	3
40	40	3
41	41	4
42	42	4
43	43	4
44	44	4
45	45	4
46	46	4
47	47	4
48	48	4
49	49	4
50	50	4
51	51	4
52	52	4
53	53	4
54	54	4
55	55	4
56	56	4
57	57	4
58	58	4
59	59	4
60	60	4
61	61	1
62	62	1
63	63	1
64	64	1
65	65	1
66	66	1
67	67	1
68	68	1
69	69	1
70	70	1
71	71	2
72	72	2
73	73	2
74	74	2
75	75	2
76	76	2
77	77	2
78	78	2
79	79	2
80	80	2
81	81	3
82	82	3
83	83	3
84	84	3
85	85	3
86	86	3
87	87	3
88	88	3
89	89	3
90	90	3
91	91	3
92	92	3
93	93	3
94	94	3
95	95	3
96	96	3
97	97	3
98	98	3
99	99	3
100	100	3
101	101	4
102	102	4
103	103	4
104	104	4
105	105	4
106	106	4
107	107	4
108	108	4
109	109	4
110	110	4
111	111	4
112	112	4
113	113	4
114	114	4
115	115	4
116	116	4
117	117	4
118	118	4
119	119	4
120	120	4
121	121	1
122	122	1
123	123	1
124	124	1
125	125	1
126	126	1
127	127	1
128	128	1
129	129	1
130	130	1
131	131	2
132	132	2
133	133	2
134	134	2
135	135	2
136	136	2
137	137	2
138	138	2
139	139	2
140	140	2
141	141	3
142	142	3
143	143	3
144	144	3
145	145	3
146	146	3
147	147	3
148	148	3
149	149	3
150	150	3
151	151	3
152	152	3
153	153	3
154	154	3
155	155	3
156	156	3
157	157	3
158	158	3
159	159	3
160	160	3
161	161	4
162	162	4
163	163	4
164	164	4
165	165	4
166	166	4
167	167	4
168	168	4
169	169	4
170	170	4
171	171	4
172	172	4
173	173	4
174	174	4
175	175	4
176	176	4
177	177	4
178	178	4
179	179	4
180	180	4
181	181	1
182	182	1
183	183	1
184	184	1
185	185	1
186	186	1
187	187	1
188	188	1
189	189	1
190	190	1
191	191	2
192	192	2
193	193	2
194	194	2
195	195	2
196	196	2
197	197	2
198	198	2
199	199	2
200	200	2
201	201	3
202	202	3
203	203	3
204	204	3
205	205	3
206	206	3
207	207	3
208	208	3
209	209	3
210	210	3
211	211	3
212	212	3
213	213	3
214	214	3
215	215	3
216	216	3
217	217	3
218	218	3
219	219	3
220	220	3
221	221	4
222	222	4
223	223	4
224	224	4
225	225	4
226	226	4
227	227	4
228	228	4
229	229	4
230	230	4
231	231	4
232	232	4
233	233	4
234	234	4
235	235	4
236	236	4
237	237	4
238	238	4
239	239	4
240	240	4
241	241	1
242	242	1
243	243	1
244	244	1
245	245	1
246	246	1
247	247	1
248	248	1
249	249	1
250	250	1
251	251	2
252	252	2
253	253	2
254	254	2
255	255	2
256	256	2
257	257	2
258	258	2
259	259	2
260	260	2
261	261	3
262	262	3
263	263	3
264	264	3
265	265	3
266	266	3
267	267	3
268	268	3
269	269	3
270	270	3
271	271	3
272	272	3
273	273	3
274	274	3
275	275	3
276	276	3
277	277	3
278	278	3
279	279	3
280	280	3
281	281	4
282	282	4
283	283	4
284	284	4
285	285	4
286	286	4
287	287	4
288	288	4
289	289	4
290	290	4
291	291	4
292	292	4
293	293	4
294	294	4
295	295	4
296	296	4
297	297	4
298	298	4
299	299	4
300	300	4
301	301	1
302	302	1
303	303	1
304	304	1
305	305	1
306	306	1
307	307	1
308	308	1
309	309	1
310	310	1
311	311	2
312	312	2
313	313	2
314	314	2
315	315	2
316	316	2
317	317	2
318	318	2
319	319	2
320	320	2
321	321	3
322	322	3
323	323	3
324	324	3
325	325	3
326	326	3
327	327	3
328	328	3
329	329	3
330	330	3
331	331	3
332	332	3
333	333	3
334	334	3
335	335	3
336	336	3
337	337	3
338	338	3
339	339	3
340	340	3
341	341	4
342	342	4
343	343	4
344	344	4
345	345	4
346	346	4
347	347	4
348	348	4
349	349	4
350	350	4
351	351	4
352	352	4
353	353	4
354	354	4
355	355	4
356	356	4
357	357	4
358	358	4
359	359	4
360	360	4
361	361	1
362	362	1
363	363	1
364	364	1
365	365	1
366	366	1
367	367	1
368	368	1
369	369	1
370	370	1
371	371	2
372	372	2
373	373	2
374	374	2
375	375	2
376	376	2
377	377	2
378	378	2
379	379	2
380	380	2
381	381	3
382	382	3
383	383	3
384	384	3
385	385	3
386	386	3
387	387	3
388	388	3
389	389	3
390	390	3
391	391	3
392	392	3
393	393	3
394	394	3
395	395	3
396	396	3
397	397	3
398	398	3
399	399	3
400	400	3
401	401	4
402	402	4
403	403	4
404	404	4
405	405	4
406	406	4
407	407	4
408	408	4
409	409	4
410	410	4
411	411	4
412	412	4
413	413	4
414	414	4
415	415	4
416	416	4
417	417	4
418	418	4
419	419	4
420	420	4
421	421	1
422	422	1
423	423	1
424	424	1
425	425	1
426	426	1
427	427	1
428	428	1
429	429	1
430	430	1
431	431	2
432	432	2
433	433	2
434	434	2
435	435	2
436	436	2
437	437	2
438	438	2
439	439	2
440	440	2
441	441	3
442	442	3
443	443	3
444	444	3
445	445	3
446	446	3
447	447	3
448	448	3
449	449	3
450	450	3
451	451	3
452	452	3
453	453	3
454	454	3
455	455	3
456	456	3
457	457	3
458	458	3
459	459	3
460	460	3
461	461	4
462	462	4
463	463	4
464	464	4
465	465	4
466	466	4
467	467	4
468	468	4
469	469	4
470	470	4
471	471	4
472	472	4
473	473	4
474	474	4
475	475	4
476	476	4
477	477	4
478	478	4
479	479	4
480	480	4
481	481	1
482	482	1
483	483	1
484	484	1
485	485	1
486	486	1
487	487	1
488	488	1
489	489	1
490	490	1
491	491	2
492	492	2
493	493	2
494	494	2
495	495	2
496	496	2
497	497	2
498	498	2
499	499	2
500	500	2
501	501	3
502	502	3
503	503	3
504	504	3
505	505	3
506	506	3
507	507	3
508	508	3
509	509	3
510	510	3
511	511	3
512	512	3
513	513	3
514	514	3
515	515	3
516	516	3
517	517	3
518	518	3
519	519	3
520	520	3
521	521	4
522	522	4
523	523	4
524	524	4
525	525	4
526	526	4
527	527	4
528	528	4
529	529	4
530	530	4
531	531	4
532	532	4
533	533	4
534	534	4
535	535	4
536	536	4
537	537	4
538	538	4
539	539	4
540	540	4
\.


--
-- Data for Name: product_productattribute; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productattribute (id, slug, name) FROM stdin;
1	color	Color
2	collar	Collar
3	brand	Brand
4	size	Size
5	coffee-genre	Coffee Genre
6	box-size	Box Size
7	flavor	Flavor
8	candy-box-size	Candy Box Size
9	author	Author
10	publisher	Publisher
11	language	Language
12	cover	Cover
\.


--
-- Data for Name: product_productclass; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass (id, name, has_variants, is_shipping_required) FROM stdin;
1	T-Shirt	t	t
2	Mugs	t	t
3	Coffee	t	t
4	Candy	t	t
5	E-books	t	f
6	Books	t	t
\.


--
-- Data for Name: product_productclass_product_attributes; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass_product_attributes (id, productclass_id, productattribute_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	3
5	3	3
6	3	5
7	4	3
8	4	7
9	5	9
10	5	10
11	5	11
12	6	9
13	6	10
14	6	11
\.


--
-- Data for Name: product_productclass_variant_attributes; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass_variant_attributes (id, productclass_id, productattribute_id) FROM stdin;
1	1	4
2	3	6
3	4	8
4	6	12
\.


--
-- Data for Name: product_productimage; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productimage (id, image, ppoi, alt, "order", product_id) FROM stdin;
1	products/saleor/static/placeholders/t-shirts/6.jpg	0.5x0.5		0	1
2	products/saleor/static/placeholders/t-shirts/6_SXfI5xE.jpg	0.5x0.5		0	2
3	products/saleor/static/placeholders/t-shirts/6_GA36mje.jpg	0.5x0.5		0	3
4	products/saleor/static/placeholders/t-shirts/6_Tqd8IPQ.jpg	0.5x0.5		1	3
5	products/saleor/static/placeholders/t-shirts/6_KIMgGd2.jpg	0.5x0.5		2	3
6	products/saleor/static/placeholders/t-shirts/5.jpg	0.5x0.5		0	4
7	products/saleor/static/placeholders/t-shirts/5_CIRzXyu.jpg	0.5x0.5		1	4
8	products/saleor/static/placeholders/t-shirts/6_qS3XZ82.jpg	0.5x0.5		2	4
9	products/saleor/static/placeholders/t-shirts/6_lVhQ57J.jpg	0.5x0.5		0	5
10	products/saleor/static/placeholders/t-shirts/5_ODCMqvR.jpg	0.5x0.5		0	6
11	products/saleor/static/placeholders/t-shirts/6_tFnXJ44.jpg	0.5x0.5		1	6
12	products/saleor/static/placeholders/t-shirts/5_5AnrbKT.jpg	0.5x0.5		2	6
13	products/saleor/static/placeholders/t-shirts/5_v8Cgpxl.jpg	0.5x0.5		0	7
14	products/saleor/static/placeholders/t-shirts/5_LdwcxKI.jpg	0.5x0.5		1	7
15	products/saleor/static/placeholders/t-shirts/6_mQh8vqx.jpg	0.5x0.5		2	7
16	products/saleor/static/placeholders/t-shirts/5_FInkAgW.jpg	0.5x0.5		0	8
17	products/saleor/static/placeholders/t-shirts/5_egSFmEm.jpg	0.5x0.5		0	9
18	products/saleor/static/placeholders/t-shirts/5_DuHRLlN.jpg	0.5x0.5		0	10
19	products/saleor/static/placeholders/t-shirts/5_MVdZFoc.jpg	0.5x0.5		1	10
20	products/saleor/static/placeholders/t-shirts/5_z4wq2Oj.jpg	0.5x0.5		2	10
21	products/saleor/static/placeholders/mugs/4.jpg	0.5x0.5		0	11
22	products/saleor/static/placeholders/mugs/4_eFamK6L.jpg	0.5x0.5		1	11
23	products/saleor/static/placeholders/mugs/7.jpg	0.5x0.5		2	11
24	products/saleor/static/placeholders/mugs/3.jpg	0.5x0.5		3	11
25	products/saleor/static/placeholders/mugs/7_FKoja7g.jpg	0.5x0.5		0	12
26	products/saleor/static/placeholders/mugs/7_hgUrP69.jpg	0.5x0.5		1	12
27	products/saleor/static/placeholders/mugs/4_sqdQ8uR.jpg	0.5x0.5		0	13
28	products/saleor/static/placeholders/mugs/4_iopUK3I.jpg	0.5x0.5		1	13
29	products/saleor/static/placeholders/mugs/box_01.jpg	0.5x0.5		0	14
30	products/saleor/static/placeholders/mugs/7_8DAKe61.jpg	0.5x0.5		0	15
31	products/saleor/static/placeholders/mugs/4_7TIhUR0.jpg	0.5x0.5		1	15
32	products/saleor/static/placeholders/mugs/box_01_cZDRhmK.jpg	0.5x0.5		2	15
33	products/saleor/static/placeholders/mugs/box_01_bmN6wl7.jpg	0.5x0.5		0	16
34	products/saleor/static/placeholders/mugs/7_mAshgnn.jpg	0.5x0.5		1	16
35	products/saleor/static/placeholders/mugs/4_fHoPWT3.jpg	0.5x0.5		2	16
36	products/saleor/static/placeholders/mugs/3_RC6h6bM.jpg	0.5x0.5		3	16
37	products/saleor/static/placeholders/mugs/7_WeWIR78.jpg	0.5x0.5		0	17
38	products/saleor/static/placeholders/mugs/box_01_PwFA6we.jpg	0.5x0.5		1	17
39	products/saleor/static/placeholders/mugs/3_xIXZ4tp.jpg	0.5x0.5		2	17
40	products/saleor/static/placeholders/mugs/4_j4l20fP.jpg	0.5x0.5		0	18
41	products/saleor/static/placeholders/mugs/7_ARqBNWw.jpg	0.5x0.5		1	18
42	products/saleor/static/placeholders/mugs/3_nD0appZ.jpg	0.5x0.5		2	18
43	products/saleor/static/placeholders/mugs/7_j883eXu.jpg	0.5x0.5		3	18
44	products/saleor/static/placeholders/mugs/3_JIuHEWc.jpg	0.5x0.5		0	19
45	products/saleor/static/placeholders/mugs/box_01_koYppHq.jpg	0.5x0.5		1	19
46	products/saleor/static/placeholders/mugs/7_HJ7C68J.jpg	0.5x0.5		0	20
47	products/saleor/static/placeholders/mugs/4_dXcx6Cx.jpg	0.5x0.5		1	20
48	products/saleor/static/placeholders/mugs/4_uzI0sTN.jpg	0.5x0.5		2	20
49	products/saleor/static/placeholders/mugs/7_uUJhrRP.jpg	0.5x0.5		3	20
50	products/saleor/static/placeholders/coffee/8.jpg	0.5x0.5		0	21
51	products/saleor/static/placeholders/coffee/8_uyHYvNU.jpg	0.5x0.5		0	22
52	products/saleor/static/placeholders/coffee/8_8CnJdW0.jpg	0.5x0.5		0	23
53	products/saleor/static/placeholders/coffee/coffee_01.jpg	0.5x0.5		1	23
54	products/saleor/static/placeholders/coffee/coffee_01_k1SXMOb.jpg	0.5x0.5		0	24
55	products/saleor/static/placeholders/coffee/coffee_02.jpg	0.5x0.5		1	24
56	products/saleor/static/placeholders/coffee/coffee_02_jxRbFKU.jpg	0.5x0.5		0	25
57	products/saleor/static/placeholders/coffee/coffee_04.jpg	0.5x0.5		1	25
58	products/saleor/static/placeholders/coffee/coffee_04_JjHi5lF.jpg	0.5x0.5		2	25
59	products/saleor/static/placeholders/coffee/coffee_04_ECaIOuT.jpg	0.5x0.5		0	26
60	products/saleor/static/placeholders/coffee/coffee_01_l9IaDdu.jpg	0.5x0.5		0	27
61	products/saleor/static/placeholders/coffee/8_foV2zif.jpg	0.5x0.5		1	27
62	products/saleor/static/placeholders/coffee/8_hqyfJBb.jpg	0.5x0.5		2	27
63	products/saleor/static/placeholders/coffee/8_JeKhmrd.jpg	0.5x0.5		3	27
64	products/saleor/static/placeholders/coffee/coffee_01_AyKWBwT.jpg	0.5x0.5		0	28
65	products/saleor/static/placeholders/coffee/coffee_02_C1J2myQ.jpg	0.5x0.5		1	28
66	products/saleor/static/placeholders/coffee/coffee_04_HaAoai7.jpg	0.5x0.5		2	28
67	products/saleor/static/placeholders/coffee/8_ICuEDV3.jpg	0.5x0.5		0	29
68	products/saleor/static/placeholders/coffee/8_lqP5WBy.jpg	0.5x0.5		1	29
69	products/saleor/static/placeholders/coffee/coffee_01_2WvPCri.jpg	0.5x0.5		2	29
70	products/saleor/static/placeholders/coffee/coffee_01_NEkvfI9.jpg	0.5x0.5		3	29
71	products/saleor/static/placeholders/coffee/coffee_02_SuKY6Xm.jpg	0.5x0.5		0	30
72	products/saleor/static/placeholders/candy/2.jpg	0.5x0.5		0	31
73	products/saleor/static/placeholders/candy/2_A2OQpBL.jpg	0.5x0.5		1	31
74	products/saleor/static/placeholders/candy/2_91AnUzh.jpg	0.5x0.5		0	32
75	products/saleor/static/placeholders/candy/2_3ipz6m4.jpg	0.5x0.5		1	32
76	products/saleor/static/placeholders/candy/1.jpg	0.5x0.5		2	32
77	products/saleor/static/placeholders/candy/1_xcD7Cjo.jpg	0.5x0.5		0	33
78	products/saleor/static/placeholders/candy/2_BIygpAs.jpg	0.5x0.5		1	33
79	products/saleor/static/placeholders/candy/1_Pk9d9nq.jpg	0.5x0.5		0	34
80	products/saleor/static/placeholders/candy/2_Akn3rTY.jpg	0.5x0.5		1	34
81	products/saleor/static/placeholders/candy/1_O2GWGsa.jpg	0.5x0.5		2	34
82	products/saleor/static/placeholders/candy/2_jltmIAG.jpg	0.5x0.5		3	34
83	products/saleor/static/placeholders/candy/2_cxInDdX.jpg	0.5x0.5		0	35
84	products/saleor/static/placeholders/candy/2_eRhyRPD.jpg	0.5x0.5		1	35
85	products/saleor/static/placeholders/candy/2_zTFhMKp.jpg	0.5x0.5		0	36
86	products/saleor/static/placeholders/candy/2_bSI4VqN.jpg	0.5x0.5		0	37
87	products/saleor/static/placeholders/candy/1_QA9jNaR.jpg	0.5x0.5		1	37
88	products/saleor/static/placeholders/candy/2_vpzJw4g.jpg	0.5x0.5		2	37
89	products/saleor/static/placeholders/candy/1_TnzsH1d.jpg	0.5x0.5		0	38
90	products/saleor/static/placeholders/candy/1_EIOFjBT.jpg	0.5x0.5		1	38
91	products/saleor/static/placeholders/candy/2_McyrxCr.jpg	0.5x0.5		0	39
92	products/saleor/static/placeholders/candy/2_PcdWIPT.jpg	0.5x0.5		1	39
93	products/saleor/static/placeholders/candy/2_hgoCrqv.jpg	0.5x0.5		0	40
94	products/saleor/static/placeholders/candy/1_DmpHfeR.jpg	0.5x0.5		1	40
95	products/saleor/static/placeholders/books/book_02.jpg	0.5x0.5		0	41
96	products/saleor/static/placeholders/books/book_03.jpg	0.5x0.5		1	41
97	products/saleor/static/placeholders/books/book_03_vKcQ76A.jpg	0.5x0.5		2	41
98	products/saleor/static/placeholders/books/book_05.jpg	0.5x0.5		0	42
99	products/saleor/static/placeholders/books/book_01.jpg	0.5x0.5		1	42
100	products/saleor/static/placeholders/books/book_05_yoAxqeP.jpg	0.5x0.5		2	42
101	products/saleor/static/placeholders/books/book_03_Xst9UIh.jpg	0.5x0.5		0	43
102	products/saleor/static/placeholders/books/book_03_Od6dyS0.jpg	0.5x0.5		0	44
103	products/saleor/static/placeholders/books/book_01_NJVLQDq.jpg	0.5x0.5		1	44
104	products/saleor/static/placeholders/books/book_03_WIubjzP.jpg	0.5x0.5		2	44
105	products/saleor/static/placeholders/books/book_02_FQbsBIs.jpg	0.5x0.5		3	44
106	products/saleor/static/placeholders/books/book_05_kfuYUjD.jpg	0.5x0.5		0	45
107	products/saleor/static/placeholders/books/book_05_MxwIq4y.jpg	0.5x0.5		1	45
108	products/saleor/static/placeholders/books/book_03_DsbKHpY.jpg	0.5x0.5		2	45
109	products/saleor/static/placeholders/books/book_03_2SLaH8N.jpg	0.5x0.5		3	45
110	products/saleor/static/placeholders/books/book_05_U4Zhk2A.jpg	0.5x0.5		0	46
111	products/saleor/static/placeholders/books/book_03_rjGjrGo.jpg	0.5x0.5		1	46
112	products/saleor/static/placeholders/books/book_03_zdvFjbb.jpg	0.5x0.5		2	46
113	products/saleor/static/placeholders/books/book_01_9ngYhUm.jpg	0.5x0.5		3	46
114	products/saleor/static/placeholders/books/book_01_Qh7OD17.jpg	0.5x0.5		0	47
115	products/saleor/static/placeholders/books/book_04.jpg	0.5x0.5		1	47
116	products/saleor/static/placeholders/books/book_05_7eyO8JI.jpg	0.5x0.5		2	47
117	products/saleor/static/placeholders/books/book_04_ipXmiZp.jpg	0.5x0.5		3	47
118	products/saleor/static/placeholders/books/book_04_JxL8pKL.jpg	0.5x0.5		0	48
119	products/saleor/static/placeholders/books/book_02_22dvk0c.jpg	0.5x0.5		1	48
120	products/saleor/static/placeholders/books/book_02_9lUlyOU.jpg	0.5x0.5		2	48
121	products/saleor/static/placeholders/books/book_01_jB5D9dN.jpg	0.5x0.5		3	48
122	products/saleor/static/placeholders/books/book_02_TyT0jET.jpg	0.5x0.5		0	49
123	products/saleor/static/placeholders/books/book_04_YJZUa3E.jpg	0.5x0.5		0	50
124	products/saleor/static/placeholders/books/book_02_y9uPLBN.jpg	0.5x0.5		1	50
125	products/saleor/static/placeholders/books/book_03_SGxtcWR.jpg	0.5x0.5		2	50
126	products/saleor/static/placeholders/books/book_03_2U3k8q8.jpg	0.5x0.5		0	51
127	products/saleor/static/placeholders/books/book_04_hU85AQk.jpg	0.5x0.5		0	52
128	products/saleor/static/placeholders/books/book_01_Zu5QUtz.jpg	0.5x0.5		1	52
129	products/saleor/static/placeholders/books/book_01_8doAuQa.jpg	0.5x0.5		2	52
130	products/saleor/static/placeholders/books/book_01_e0lkYnN.jpg	0.5x0.5		3	52
131	products/saleor/static/placeholders/books/book_01_FECC7Al.jpg	0.5x0.5		0	53
132	products/saleor/static/placeholders/books/book_05_9cqOhZt.jpg	0.5x0.5		0	54
133	products/saleor/static/placeholders/books/book_05_6cRUPAh.jpg	0.5x0.5		1	54
134	products/saleor/static/placeholders/books/book_05_2U78q2p.jpg	0.5x0.5		2	54
135	products/saleor/static/placeholders/books/book_05_viDjKhY.jpg	0.5x0.5		0	55
136	products/saleor/static/placeholders/books/book_03_9HLKGs8.jpg	0.5x0.5		0	56
137	products/saleor/static/placeholders/books/book_01_ed3qvGM.jpg	0.5x0.5		1	56
138	products/saleor/static/placeholders/books/book_01_9t89vDH.jpg	0.5x0.5		2	56
139	products/saleor/static/placeholders/books/book_03_WhkZc56.jpg	0.5x0.5		0	57
140	products/saleor/static/placeholders/books/book_04_Rj870Gz.jpg	0.5x0.5		1	57
141	products/saleor/static/placeholders/books/book_01_vNxrnVD.jpg	0.5x0.5		0	58
142	products/saleor/static/placeholders/books/book_04_nV5JFoE.jpg	0.5x0.5		1	58
143	products/saleor/static/placeholders/books/book_04_glAcUfA.jpg	0.5x0.5		0	59
144	products/saleor/static/placeholders/books/book_02_JBBtTGt.jpg	0.5x0.5		1	59
145	products/saleor/static/placeholders/books/book_02_x40CP7S.jpg	0.5x0.5		0	60
146	products/saleor/static/placeholders/books/book_01_notN0Ca.jpg	0.5x0.5		1	60
147	products/saleor/static/placeholders/books/book_05_VUEcbVA.jpg	0.5x0.5		2	60
148	products/saleor/static/placeholders/t-shirts/5.jpg	0.5x0.5		0	61
149	products/saleor/static/placeholders/t-shirts/5_GhlvE1o.jpg	0.5x0.5		1	61
150	products/saleor/static/placeholders/t-shirts/6.jpg	0.5x0.5		0	62
151	products/saleor/static/placeholders/t-shirts/6_VYZSKJL.jpg	0.5x0.5		1	62
152	products/saleor/static/placeholders/t-shirts/5_rNemvxg.jpg	0.5x0.5		0	63
153	products/saleor/static/placeholders/t-shirts/6_GHjxNrd.jpg	0.5x0.5		1	63
154	products/saleor/static/placeholders/t-shirts/5_y5sMKvz.jpg	0.5x0.5		0	64
155	products/saleor/static/placeholders/t-shirts/6_SfplDxd.jpg	0.5x0.5		1	64
156	products/saleor/static/placeholders/t-shirts/6_TZvSOBy.jpg	0.5x0.5		2	64
157	products/saleor/static/placeholders/t-shirts/6_bEH0Hl2.jpg	0.5x0.5		0	65
158	products/saleor/static/placeholders/t-shirts/6_9Yk3Rmz.jpg	0.5x0.5		1	65
159	products/saleor/static/placeholders/t-shirts/6_nPUXz3N.jpg	0.5x0.5		2	65
160	products/saleor/static/placeholders/t-shirts/6_EnfAQTC.jpg	0.5x0.5		3	65
161	products/saleor/static/placeholders/t-shirts/5_loGyxtb.jpg	0.5x0.5		0	66
162	products/saleor/static/placeholders/t-shirts/5_J7FyZY5.jpg	0.5x0.5		1	66
163	products/saleor/static/placeholders/t-shirts/5_G0XvuHd.jpg	0.5x0.5		0	67
164	products/saleor/static/placeholders/t-shirts/6_34BeIyB.jpg	0.5x0.5		1	67
165	products/saleor/static/placeholders/t-shirts/6_qLKZrFt.jpg	0.5x0.5		0	68
166	products/saleor/static/placeholders/t-shirts/5_QRo25W2.jpg	0.5x0.5		1	68
167	products/saleor/static/placeholders/t-shirts/5_tm7ABRp.jpg	0.5x0.5		2	68
168	products/saleor/static/placeholders/t-shirts/5_X7uu942.jpg	0.5x0.5		0	69
169	products/saleor/static/placeholders/t-shirts/6_RbAuFH9.jpg	0.5x0.5		0	70
170	products/saleor/static/placeholders/t-shirts/5_qkyKHNp.jpg	0.5x0.5		1	70
171	products/saleor/static/placeholders/mugs/4.jpg	0.5x0.5		0	71
172	products/saleor/static/placeholders/mugs/4_L8AzJ7p.jpg	0.5x0.5		1	71
173	products/saleor/static/placeholders/mugs/box_01.jpg	0.5x0.5		2	71
174	products/saleor/static/placeholders/mugs/3.jpg	0.5x0.5		3	71
175	products/saleor/static/placeholders/mugs/7.jpg	0.5x0.5		0	72
176	products/saleor/static/placeholders/mugs/box_01_jzYXkwE.jpg	0.5x0.5		1	72
177	products/saleor/static/placeholders/mugs/4_oGZI9fd.jpg	0.5x0.5		2	72
178	products/saleor/static/placeholders/mugs/4_RhzCmFN.jpg	0.5x0.5		0	73
179	products/saleor/static/placeholders/mugs/4_Y9od7RT.jpg	0.5x0.5		1	73
180	products/saleor/static/placeholders/mugs/3_OyUPECO.jpg	0.5x0.5		2	73
181	products/saleor/static/placeholders/mugs/box_01_pt7pMep.jpg	0.5x0.5		3	73
182	products/saleor/static/placeholders/mugs/box_01_M3Q8SaI.jpg	0.5x0.5		0	74
183	products/saleor/static/placeholders/mugs/7_mY8FVFi.jpg	0.5x0.5		1	74
184	products/saleor/static/placeholders/mugs/7_AbsNdOb.jpg	0.5x0.5		2	74
185	products/saleor/static/placeholders/mugs/3_uZX98a8.jpg	0.5x0.5		0	75
186	products/saleor/static/placeholders/mugs/4_P15BoUI.jpg	0.5x0.5		0	76
187	products/saleor/static/placeholders/mugs/3_TjoEOvj.jpg	0.5x0.5		0	77
188	products/saleor/static/placeholders/mugs/3_1kHmbEg.jpg	0.5x0.5		0	78
189	products/saleor/static/placeholders/mugs/3_cEEzVw8.jpg	0.5x0.5		1	78
190	products/saleor/static/placeholders/mugs/box_01_60VnEB7.jpg	0.5x0.5		2	78
191	products/saleor/static/placeholders/mugs/3_jEM9JiD.jpg	0.5x0.5		3	78
192	products/saleor/static/placeholders/mugs/3_YwdS2H2.jpg	0.5x0.5		0	79
193	products/saleor/static/placeholders/mugs/box_01_2uZdDJv.jpg	0.5x0.5		1	79
194	products/saleor/static/placeholders/mugs/box_01_aaRBtSh.jpg	0.5x0.5		2	79
195	products/saleor/static/placeholders/mugs/box_01_SHQXPNK.jpg	0.5x0.5		3	79
196	products/saleor/static/placeholders/mugs/box_01_VfcRr1c.jpg	0.5x0.5		0	80
197	products/saleor/static/placeholders/coffee/8.jpg	0.5x0.5		0	81
198	products/saleor/static/placeholders/coffee/coffee_03.jpg	0.5x0.5		1	81
199	products/saleor/static/placeholders/coffee/coffee_03_05JdKac.jpg	0.5x0.5		2	81
200	products/saleor/static/placeholders/coffee/8_rUi34zE.jpg	0.5x0.5		3	81
201	products/saleor/static/placeholders/coffee/coffee_02.jpg	0.5x0.5		0	82
202	products/saleor/static/placeholders/coffee/coffee_02_58jAYaS.jpg	0.5x0.5		1	82
203	products/saleor/static/placeholders/coffee/coffee_03_I47pDlZ.jpg	0.5x0.5		0	83
204	products/saleor/static/placeholders/coffee/coffee_04.jpg	0.5x0.5		1	83
205	products/saleor/static/placeholders/coffee/coffee_04_kqMwmLO.jpg	0.5x0.5		0	84
206	products/saleor/static/placeholders/coffee/8_RufRigG.jpg	0.5x0.5		1	84
207	products/saleor/static/placeholders/coffee/coffee_02_zZIrod1.jpg	0.5x0.5		2	84
208	products/saleor/static/placeholders/coffee/coffee_03_6eWUgfS.jpg	0.5x0.5		0	85
209	products/saleor/static/placeholders/coffee/coffee_03_ZktaJkE.jpg	0.5x0.5		1	85
210	products/saleor/static/placeholders/coffee/coffee_04_kNse3eg.jpg	0.5x0.5		2	85
211	products/saleor/static/placeholders/coffee/coffee_01.jpg	0.5x0.5		0	86
212	products/saleor/static/placeholders/coffee/coffee_04_y52zN2E.jpg	0.5x0.5		1	86
213	products/saleor/static/placeholders/coffee/coffee_04_GRf4FoU.jpg	0.5x0.5		0	87
214	products/saleor/static/placeholders/coffee/coffee_04_6ZIrb12.jpg	0.5x0.5		1	87
215	products/saleor/static/placeholders/coffee/coffee_01_z8w7Fog.jpg	0.5x0.5		2	87
216	products/saleor/static/placeholders/coffee/coffee_01_hHlt6tf.jpg	0.5x0.5		3	87
217	products/saleor/static/placeholders/coffee/coffee_01_KyYVVmi.jpg	0.5x0.5		0	88
218	products/saleor/static/placeholders/coffee/coffee_03_BcB1oyR.jpg	0.5x0.5		1	88
219	products/saleor/static/placeholders/coffee/coffee_01_PL2Q7gq.jpg	0.5x0.5		0	89
220	products/saleor/static/placeholders/coffee/coffee_04_KpWUQK3.jpg	0.5x0.5		0	90
221	products/saleor/static/placeholders/coffee/coffee_02_vLllznq.jpg	0.5x0.5		1	90
222	products/saleor/static/placeholders/coffee/coffee_04_SfN36TV.jpg	0.5x0.5		2	90
223	products/saleor/static/placeholders/candy/1.jpg	0.5x0.5		0	91
224	products/saleor/static/placeholders/candy/2.jpg	0.5x0.5		1	91
225	products/saleor/static/placeholders/candy/2_5zQDoxY.jpg	0.5x0.5		2	91
226	products/saleor/static/placeholders/candy/2_vuy2TuK.jpg	0.5x0.5		3	91
227	products/saleor/static/placeholders/candy/2_qAWThhQ.jpg	0.5x0.5		0	92
228	products/saleor/static/placeholders/candy/2_QCmhuzV.jpg	0.5x0.5		1	92
229	products/saleor/static/placeholders/candy/2_MRy6aKB.jpg	0.5x0.5		2	92
230	products/saleor/static/placeholders/candy/1_upJ5fwQ.jpg	0.5x0.5		0	93
231	products/saleor/static/placeholders/candy/1_thvuz59.jpg	0.5x0.5		1	93
232	products/saleor/static/placeholders/candy/1_7V1TY3b.jpg	0.5x0.5		0	94
233	products/saleor/static/placeholders/candy/2_oD8r2o4.jpg	0.5x0.5		0	95
234	products/saleor/static/placeholders/candy/2_80gS3nP.jpg	0.5x0.5		1	95
235	products/saleor/static/placeholders/candy/2_wotHIIt.jpg	0.5x0.5		2	95
236	products/saleor/static/placeholders/candy/1_T4Uao0J.jpg	0.5x0.5		3	95
237	products/saleor/static/placeholders/candy/2_9mglWY5.jpg	0.5x0.5		0	96
238	products/saleor/static/placeholders/candy/1_kjOybf5.jpg	0.5x0.5		1	96
239	products/saleor/static/placeholders/candy/1_ypyFEKE.jpg	0.5x0.5		0	97
240	products/saleor/static/placeholders/candy/1_a8YhIkD.jpg	0.5x0.5		1	97
241	products/saleor/static/placeholders/candy/2_3ejLRhg.jpg	0.5x0.5		2	97
242	products/saleor/static/placeholders/candy/2_yXUgdd8.jpg	0.5x0.5		0	98
243	products/saleor/static/placeholders/candy/1_NBExgFm.jpg	0.5x0.5		0	99
244	products/saleor/static/placeholders/candy/1_Y7cUE9R.jpg	0.5x0.5		1	99
245	products/saleor/static/placeholders/candy/1_fNEvViH.jpg	0.5x0.5		0	100
246	products/saleor/static/placeholders/candy/2_x0OYRmQ.jpg	0.5x0.5		1	100
247	products/saleor/static/placeholders/books/book_03.jpg	0.5x0.5		0	101
248	products/saleor/static/placeholders/books/book_03_MPgptOl.jpg	0.5x0.5		1	101
249	products/saleor/static/placeholders/books/book_01.jpg	0.5x0.5		2	101
250	products/saleor/static/placeholders/books/book_02.jpg	0.5x0.5		3	101
251	products/saleor/static/placeholders/books/book_04.jpg	0.5x0.5		0	102
252	products/saleor/static/placeholders/books/book_03_k7XGmZp.jpg	0.5x0.5		1	102
253	products/saleor/static/placeholders/books/book_02_wc2aHSh.jpg	0.5x0.5		2	102
254	products/saleor/static/placeholders/books/book_05.jpg	0.5x0.5		3	102
255	products/saleor/static/placeholders/books/book_02_48zaSnT.jpg	0.5x0.5		0	103
256	products/saleor/static/placeholders/books/book_04_csDBu8Z.jpg	0.5x0.5		1	103
257	products/saleor/static/placeholders/books/book_02_OoLbT01.jpg	0.5x0.5		0	104
258	products/saleor/static/placeholders/books/book_04_scrELcB.jpg	0.5x0.5		1	104
259	products/saleor/static/placeholders/books/book_01_jdZAIMq.jpg	0.5x0.5		2	104
260	products/saleor/static/placeholders/books/book_02_6PfOSpp.jpg	0.5x0.5		0	105
261	products/saleor/static/placeholders/books/book_03_SMO8hiO.jpg	0.5x0.5		0	106
262	products/saleor/static/placeholders/books/book_03_gjcNgEi.jpg	0.5x0.5		1	106
263	products/saleor/static/placeholders/books/book_02_U4UX5IV.jpg	0.5x0.5		2	106
264	products/saleor/static/placeholders/books/book_01_XNlzNdo.jpg	0.5x0.5		0	107
265	products/saleor/static/placeholders/books/book_01_JZuvrhc.jpg	0.5x0.5		1	107
266	products/saleor/static/placeholders/books/book_04_C3pw26e.jpg	0.5x0.5		2	107
267	products/saleor/static/placeholders/books/book_02_DEM8Q05.jpg	0.5x0.5		3	107
268	products/saleor/static/placeholders/books/book_01_f3Xmhyj.jpg	0.5x0.5		0	108
269	products/saleor/static/placeholders/books/book_02_GXK0ZYa.jpg	0.5x0.5		1	108
270	products/saleor/static/placeholders/books/book_05_dDoImGq.jpg	0.5x0.5		0	109
271	products/saleor/static/placeholders/books/book_01_en1ooiQ.jpg	0.5x0.5		1	109
272	products/saleor/static/placeholders/books/book_05_xWqYQ7d.jpg	0.5x0.5		2	109
273	products/saleor/static/placeholders/books/book_01_XTvMVTV.jpg	0.5x0.5		3	109
274	products/saleor/static/placeholders/books/book_05_TnCLxms.jpg	0.5x0.5		0	110
275	products/saleor/static/placeholders/books/book_05_4htcpfS.jpg	0.5x0.5		0	111
276	products/saleor/static/placeholders/books/book_03_GmQIhWy.jpg	0.5x0.5		1	111
277	products/saleor/static/placeholders/books/book_01_N1fIBgp.jpg	0.5x0.5		2	111
278	products/saleor/static/placeholders/books/book_02_HpLjwkV.jpg	0.5x0.5		0	112
279	products/saleor/static/placeholders/books/book_05_0x13LDl.jpg	0.5x0.5		0	113
280	products/saleor/static/placeholders/books/book_03_02WpH9j.jpg	0.5x0.5		1	113
281	products/saleor/static/placeholders/books/book_03_Wyfywg9.jpg	0.5x0.5		0	114
282	products/saleor/static/placeholders/books/book_02_kvw3Dwt.jpg	0.5x0.5		1	114
283	products/saleor/static/placeholders/books/book_02_rlV7IGo.jpg	0.5x0.5		2	114
284	products/saleor/static/placeholders/books/book_03_nvamLj3.jpg	0.5x0.5		0	115
285	products/saleor/static/placeholders/books/book_04_mSVjx8A.jpg	0.5x0.5		1	115
286	products/saleor/static/placeholders/books/book_03_WTr8jjl.jpg	0.5x0.5		0	116
287	products/saleor/static/placeholders/books/book_04_Du6o251.jpg	0.5x0.5		0	117
288	products/saleor/static/placeholders/books/book_03_nnL9HqG.jpg	0.5x0.5		1	117
289	products/saleor/static/placeholders/books/book_02_X0pDzKh.jpg	0.5x0.5		0	118
290	products/saleor/static/placeholders/books/book_03_C5bWSdC.jpg	0.5x0.5		1	118
291	products/saleor/static/placeholders/books/book_03_JwOQU4L.jpg	0.5x0.5		2	118
292	products/saleor/static/placeholders/books/book_04_j13A7D1.jpg	0.5x0.5		3	118
293	products/saleor/static/placeholders/books/book_03_chH1oy0.jpg	0.5x0.5		0	119
294	products/saleor/static/placeholders/books/book_05_KLnuk7F.jpg	0.5x0.5		0	120
295	products/saleor/static/placeholders/books/book_02_tDyCCc0.jpg	0.5x0.5		1	120
296	products/saleor/static/placeholders/books/book_03_FzLJKMY.jpg	0.5x0.5		2	120
297	products/saleor/static/placeholders/t-shirts/6_APBhu8m.jpg	0.5x0.5		0	121
298	products/saleor/static/placeholders/t-shirts/5_hRmP0Ch.jpg	0.5x0.5		0	122
299	products/saleor/static/placeholders/t-shirts/5_tcd7b2K.jpg	0.5x0.5		1	122
300	products/saleor/static/placeholders/t-shirts/5_fymsUO4.jpg	0.5x0.5		2	122
301	products/saleor/static/placeholders/t-shirts/5_LF8ykny.jpg	0.5x0.5		3	122
302	products/saleor/static/placeholders/t-shirts/6_DNkNPCb.jpg	0.5x0.5		0	123
303	products/saleor/static/placeholders/t-shirts/5_byIwbLK.jpg	0.5x0.5		1	123
304	products/saleor/static/placeholders/t-shirts/6_p420hnS.jpg	0.5x0.5		0	124
305	products/saleor/static/placeholders/t-shirts/6_JNGmjHG.jpg	0.5x0.5		0	125
306	products/saleor/static/placeholders/t-shirts/5_2GQFOxb.jpg	0.5x0.5		1	125
307	products/saleor/static/placeholders/t-shirts/6_aGFh7HN.jpg	0.5x0.5		2	125
308	products/saleor/static/placeholders/t-shirts/5_FNBiThE.jpg	0.5x0.5		0	126
309	products/saleor/static/placeholders/t-shirts/6_hx1naL9.jpg	0.5x0.5		1	126
310	products/saleor/static/placeholders/t-shirts/5_suiCfxg.jpg	0.5x0.5		0	127
311	products/saleor/static/placeholders/t-shirts/5_YJ0jo9X.jpg	0.5x0.5		0	128
312	products/saleor/static/placeholders/t-shirts/5_LvXBLZf.jpg	0.5x0.5		1	128
313	products/saleor/static/placeholders/t-shirts/5_X16PAZW.jpg	0.5x0.5		2	128
314	products/saleor/static/placeholders/t-shirts/6_3B10tDZ.jpg	0.5x0.5		0	129
315	products/saleor/static/placeholders/t-shirts/5_f7OnI2S.jpg	0.5x0.5		0	130
316	products/saleor/static/placeholders/t-shirts/6_ij8k9iA.jpg	0.5x0.5		1	130
317	products/saleor/static/placeholders/t-shirts/5_3jN3AYo.jpg	0.5x0.5		2	130
318	products/saleor/static/placeholders/mugs/7_aRlCRnk.jpg	0.5x0.5		0	131
319	products/saleor/static/placeholders/mugs/4_GOzv5gF.jpg	0.5x0.5		1	131
320	products/saleor/static/placeholders/mugs/3_jbqFX8W.jpg	0.5x0.5		0	132
321	products/saleor/static/placeholders/mugs/7_ml5jbkD.jpg	0.5x0.5		1	132
322	products/saleor/static/placeholders/mugs/4_LGmTAbW.jpg	0.5x0.5		2	132
323	products/saleor/static/placeholders/mugs/3_EfYnEYu.jpg	0.5x0.5		0	133
324	products/saleor/static/placeholders/mugs/4_GE7Ey4z.jpg	0.5x0.5		1	133
325	products/saleor/static/placeholders/mugs/3_RfHswPp.jpg	0.5x0.5		2	133
326	products/saleor/static/placeholders/mugs/4_9fFrJkA.jpg	0.5x0.5		3	133
327	products/saleor/static/placeholders/mugs/3_9niZNRT.jpg	0.5x0.5		0	134
328	products/saleor/static/placeholders/mugs/4_4fuEY93.jpg	0.5x0.5		0	135
329	products/saleor/static/placeholders/mugs/box_01_6F4VEXz.jpg	0.5x0.5		1	135
330	products/saleor/static/placeholders/mugs/3_CTouLf2.jpg	0.5x0.5		2	135
331	products/saleor/static/placeholders/mugs/box_01_FsRyIVW.jpg	0.5x0.5		3	135
332	products/saleor/static/placeholders/mugs/box_01_0KKIb2T.jpg	0.5x0.5		0	136
333	products/saleor/static/placeholders/mugs/7_nFydshx.jpg	0.5x0.5		1	136
334	products/saleor/static/placeholders/mugs/4_1vJPaBq.jpg	0.5x0.5		2	136
335	products/saleor/static/placeholders/mugs/7_mPMWg9F.jpg	0.5x0.5		3	136
336	products/saleor/static/placeholders/mugs/7_PQULW0K.jpg	0.5x0.5		0	137
337	products/saleor/static/placeholders/mugs/3_70vTpiE.jpg	0.5x0.5		1	137
338	products/saleor/static/placeholders/mugs/box_01_SF2TvFZ.jpg	0.5x0.5		0	138
339	products/saleor/static/placeholders/mugs/4_3D9kGip.jpg	0.5x0.5		1	138
340	products/saleor/static/placeholders/mugs/7_2cVGSwI.jpg	0.5x0.5		2	138
341	products/saleor/static/placeholders/mugs/box_01_41BD4s7.jpg	0.5x0.5		3	138
342	products/saleor/static/placeholders/mugs/3_aiBNDSu.jpg	0.5x0.5		0	139
343	products/saleor/static/placeholders/mugs/3_wg9ieoO.jpg	0.5x0.5		1	139
344	products/saleor/static/placeholders/mugs/4_baY4osf.jpg	0.5x0.5		2	139
345	products/saleor/static/placeholders/mugs/7_kvbLdMW.jpg	0.5x0.5		0	140
346	products/saleor/static/placeholders/mugs/4_EOgvcdU.jpg	0.5x0.5		1	140
347	products/saleor/static/placeholders/coffee/8_wRysE6e.jpg	0.5x0.5		0	141
348	products/saleor/static/placeholders/coffee/8_lCLmhjV.jpg	0.5x0.5		1	141
349	products/saleor/static/placeholders/coffee/coffee_01_jF4Xba9.jpg	0.5x0.5		0	142
350	products/saleor/static/placeholders/coffee/coffee_04_5wvbsLY.jpg	0.5x0.5		1	142
351	products/saleor/static/placeholders/coffee/coffee_02_aRf1tSU.jpg	0.5x0.5		2	142
352	products/saleor/static/placeholders/coffee/coffee_02_4pG6Lzd.jpg	0.5x0.5		0	143
353	products/saleor/static/placeholders/coffee/coffee_02_8BmWzYd.jpg	0.5x0.5		0	144
354	products/saleor/static/placeholders/coffee/8_rckRGcF.jpg	0.5x0.5		1	144
355	products/saleor/static/placeholders/coffee/coffee_01_qbS2nmu.jpg	0.5x0.5		2	144
356	products/saleor/static/placeholders/coffee/8_1e5ds1g.jpg	0.5x0.5		0	145
357	products/saleor/static/placeholders/coffee/coffee_01_ILboW5D.jpg	0.5x0.5		1	145
358	products/saleor/static/placeholders/coffee/coffee_04_VDs0V71.jpg	0.5x0.5		2	145
359	products/saleor/static/placeholders/coffee/coffee_01_dx4ueez.jpg	0.5x0.5		3	145
360	products/saleor/static/placeholders/coffee/coffee_01_zQ3lrdM.jpg	0.5x0.5		0	146
361	products/saleor/static/placeholders/coffee/8_FuJXseu.jpg	0.5x0.5		1	146
362	products/saleor/static/placeholders/coffee/coffee_03_3zpPqzE.jpg	0.5x0.5		2	146
363	products/saleor/static/placeholders/coffee/coffee_01_IkGC3hv.jpg	0.5x0.5		3	146
364	products/saleor/static/placeholders/coffee/coffee_02_yD57EcU.jpg	0.5x0.5		0	147
365	products/saleor/static/placeholders/coffee/8_NXtbJ6g.jpg	0.5x0.5		1	147
366	products/saleor/static/placeholders/coffee/coffee_02_tPV6TxT.jpg	0.5x0.5		0	148
367	products/saleor/static/placeholders/coffee/coffee_01_FmsJwEc.jpg	0.5x0.5		0	149
368	products/saleor/static/placeholders/coffee/coffee_03_WW0BXbT.jpg	0.5x0.5		1	149
369	products/saleor/static/placeholders/coffee/coffee_04_NVQNBRf.jpg	0.5x0.5		0	150
370	products/saleor/static/placeholders/candy/1_qbjn5zp.jpg	0.5x0.5		0	151
371	products/saleor/static/placeholders/candy/1_TWfqbm0.jpg	0.5x0.5		1	151
372	products/saleor/static/placeholders/candy/2_LWBYvaf.jpg	0.5x0.5		0	152
373	products/saleor/static/placeholders/candy/1_OFzw7jr.jpg	0.5x0.5		0	153
374	products/saleor/static/placeholders/candy/1_z8h46AX.jpg	0.5x0.5		0	154
375	products/saleor/static/placeholders/candy/2_7dPTbYH.jpg	0.5x0.5		0	155
376	products/saleor/static/placeholders/candy/2_98BS6f2.jpg	0.5x0.5		1	155
377	products/saleor/static/placeholders/candy/1_AQlNhGk.jpg	0.5x0.5		0	156
378	products/saleor/static/placeholders/candy/2_UnBjJys.jpg	0.5x0.5		1	156
379	products/saleor/static/placeholders/candy/1_K9dSkLx.jpg	0.5x0.5		2	156
380	products/saleor/static/placeholders/candy/1_njHXOYF.jpg	0.5x0.5		0	157
381	products/saleor/static/placeholders/candy/2_jIoFpln.jpg	0.5x0.5		1	157
382	products/saleor/static/placeholders/candy/2_4bUp2Ig.jpg	0.5x0.5		2	157
383	products/saleor/static/placeholders/candy/1_nhD7sGm.jpg	0.5x0.5		3	157
384	products/saleor/static/placeholders/candy/2_qlMCRih.jpg	0.5x0.5		0	158
385	products/saleor/static/placeholders/candy/2_dsQI8OS.jpg	0.5x0.5		1	158
386	products/saleor/static/placeholders/candy/1_6A9FNno.jpg	0.5x0.5		0	159
387	products/saleor/static/placeholders/candy/2_shiICwg.jpg	0.5x0.5		1	159
388	products/saleor/static/placeholders/candy/1_QWNQyFG.jpg	0.5x0.5		2	159
389	products/saleor/static/placeholders/candy/1_YetCaVy.jpg	0.5x0.5		0	160
390	products/saleor/static/placeholders/candy/1_zeI15SP.jpg	0.5x0.5		1	160
391	products/saleor/static/placeholders/books/book_02_6RPHy6k.jpg	0.5x0.5		0	161
392	products/saleor/static/placeholders/books/book_02_4fAl1d7.jpg	0.5x0.5		1	161
393	products/saleor/static/placeholders/books/book_03_ec4Xuit.jpg	0.5x0.5		2	161
394	products/saleor/static/placeholders/books/book_05_5q0VbqO.jpg	0.5x0.5		0	162
395	products/saleor/static/placeholders/books/book_04_oyhJRq5.jpg	0.5x0.5		0	163
396	products/saleor/static/placeholders/books/book_01_LRs0bFz.jpg	0.5x0.5		1	163
397	products/saleor/static/placeholders/books/book_01_qwonJVg.jpg	0.5x0.5		2	163
398	products/saleor/static/placeholders/books/book_05_x77es51.jpg	0.5x0.5		3	163
399	products/saleor/static/placeholders/books/book_02_hUHTyq8.jpg	0.5x0.5		0	164
400	products/saleor/static/placeholders/books/book_04_F8A6N4R.jpg	0.5x0.5		1	164
401	products/saleor/static/placeholders/books/book_04_SlZDgCu.jpg	0.5x0.5		2	164
402	products/saleor/static/placeholders/books/book_04_En9RvE6.jpg	0.5x0.5		3	164
403	products/saleor/static/placeholders/books/book_05_Daqt23Y.jpg	0.5x0.5		0	165
404	products/saleor/static/placeholders/books/book_05_hAeismH.jpg	0.5x0.5		0	166
405	products/saleor/static/placeholders/books/book_02_4AF1E86.jpg	0.5x0.5		1	166
406	products/saleor/static/placeholders/books/book_02_ACSON1e.jpg	0.5x0.5		2	166
407	products/saleor/static/placeholders/books/book_02_FgIPnM9.jpg	0.5x0.5		0	167
408	products/saleor/static/placeholders/books/book_02_GIrYZ2C.jpg	0.5x0.5		0	168
409	products/saleor/static/placeholders/books/book_02_e7HHQKP.jpg	0.5x0.5		1	168
410	products/saleor/static/placeholders/books/book_03_WqrDgUg.jpg	0.5x0.5		2	168
411	products/saleor/static/placeholders/books/book_04_F3HUdXB.jpg	0.5x0.5		3	168
412	products/saleor/static/placeholders/books/book_02_vFj98do.jpg	0.5x0.5		0	169
413	products/saleor/static/placeholders/books/book_02_rjIFehS.jpg	0.5x0.5		0	170
414	products/saleor/static/placeholders/books/book_01_H4gKz3S.jpg	0.5x0.5		1	170
415	products/saleor/static/placeholders/books/book_01_L6EmKYN.jpg	0.5x0.5		2	170
416	products/saleor/static/placeholders/books/book_01_22WuYjh.jpg	0.5x0.5		0	171
417	products/saleor/static/placeholders/books/book_02_2f31yQ8.jpg	0.5x0.5		0	172
418	products/saleor/static/placeholders/books/book_01_1MfvJRx.jpg	0.5x0.5		1	172
419	products/saleor/static/placeholders/books/book_04_asC2Rbv.jpg	0.5x0.5		0	173
420	products/saleor/static/placeholders/books/book_03_oAwwcOT.jpg	0.5x0.5		1	173
421	products/saleor/static/placeholders/books/book_02_5R7G5Cj.jpg	0.5x0.5		2	173
422	products/saleor/static/placeholders/books/book_01_RkW7fww.jpg	0.5x0.5		3	173
423	products/saleor/static/placeholders/books/book_02_jrXSM1o.jpg	0.5x0.5		0	174
424	products/saleor/static/placeholders/books/book_04_Sb1BDJt.jpg	0.5x0.5		1	174
425	products/saleor/static/placeholders/books/book_02_hknIrh6.jpg	0.5x0.5		0	175
426	products/saleor/static/placeholders/books/book_03_nCXfMn0.jpg	0.5x0.5		1	175
427	products/saleor/static/placeholders/books/book_01_QSnwtD6.jpg	0.5x0.5		0	176
428	products/saleor/static/placeholders/books/book_02_GrIel7e.jpg	0.5x0.5		0	177
429	products/saleor/static/placeholders/books/book_03_pG5LFYM.jpg	0.5x0.5		1	177
430	products/saleor/static/placeholders/books/book_04_wha3iyt.jpg	0.5x0.5		2	177
431	products/saleor/static/placeholders/books/book_04_vRLhNjG.jpg	0.5x0.5		3	177
432	products/saleor/static/placeholders/books/book_01_cW8WEL1.jpg	0.5x0.5		0	178
433	products/saleor/static/placeholders/books/book_02_IobPfGJ.jpg	0.5x0.5		1	178
434	products/saleor/static/placeholders/books/book_03_QjXYqKh.jpg	0.5x0.5		2	178
435	products/saleor/static/placeholders/books/book_05_NwuGmAN.jpg	0.5x0.5		3	178
436	products/saleor/static/placeholders/books/book_01_aefzuOd.jpg	0.5x0.5		0	179
437	products/saleor/static/placeholders/books/book_05_s64n13k.jpg	0.5x0.5		1	179
438	products/saleor/static/placeholders/books/book_05_G37ttnU.jpg	0.5x0.5		2	179
439	products/saleor/static/placeholders/books/book_05_KHr79yR.jpg	0.5x0.5		0	180
440	products/saleor/static/placeholders/t-shirts/6_KLBRBI7.jpg	0.5x0.5		0	181
441	products/saleor/static/placeholders/t-shirts/6_0c6xxGL.jpg	0.5x0.5		1	181
442	products/saleor/static/placeholders/t-shirts/5_cm8ycmt.jpg	0.5x0.5		0	182
443	products/saleor/static/placeholders/t-shirts/6_fUYo9qD.jpg	0.5x0.5		1	182
444	products/saleor/static/placeholders/t-shirts/5_UTnyurI.jpg	0.5x0.5		0	183
445	products/saleor/static/placeholders/t-shirts/5_qnGciDG.jpg	0.5x0.5		1	183
446	products/saleor/static/placeholders/t-shirts/6_PeiCWKd.jpg	0.5x0.5		0	184
447	products/saleor/static/placeholders/t-shirts/5_uDcv75n.jpg	0.5x0.5		1	184
448	products/saleor/static/placeholders/t-shirts/5_RdKJk8h.jpg	0.5x0.5		2	184
449	products/saleor/static/placeholders/t-shirts/5_mE6SYxV.jpg	0.5x0.5		0	185
450	products/saleor/static/placeholders/t-shirts/5_rQKyA5W.jpg	0.5x0.5		1	185
451	products/saleor/static/placeholders/t-shirts/6_sWETlfr.jpg	0.5x0.5		2	185
452	products/saleor/static/placeholders/t-shirts/5_FrUW0CM.jpg	0.5x0.5		3	185
453	products/saleor/static/placeholders/t-shirts/5_ff4dJ23.jpg	0.5x0.5		0	186
454	products/saleor/static/placeholders/t-shirts/5_x6S0M1q.jpg	0.5x0.5		0	187
455	products/saleor/static/placeholders/t-shirts/6_q8WxFyV.jpg	0.5x0.5		1	187
456	products/saleor/static/placeholders/t-shirts/6_i5FJVI4.jpg	0.5x0.5		2	187
457	products/saleor/static/placeholders/t-shirts/6_uye1YZy.jpg	0.5x0.5		3	187
458	products/saleor/static/placeholders/t-shirts/6_LLiMovB.jpg	0.5x0.5		0	188
459	products/saleor/static/placeholders/t-shirts/5_CvwR34D.jpg	0.5x0.5		0	189
460	products/saleor/static/placeholders/t-shirts/5_0S2noo1.jpg	0.5x0.5		1	189
461	products/saleor/static/placeholders/t-shirts/6_ceoSD5j.jpg	0.5x0.5		2	189
462	products/saleor/static/placeholders/t-shirts/5_gu32E7R.jpg	0.5x0.5		3	189
463	products/saleor/static/placeholders/t-shirts/5_1eyqGrl.jpg	0.5x0.5		0	190
464	products/saleor/static/placeholders/t-shirts/6_A9i1yF2.jpg	0.5x0.5		1	190
465	products/saleor/static/placeholders/t-shirts/6_6SXCPEv.jpg	0.5x0.5		2	190
466	products/saleor/static/placeholders/mugs/4_bIZDW0C.jpg	0.5x0.5		0	191
467	products/saleor/static/placeholders/mugs/4_SXbKUNS.jpg	0.5x0.5		1	191
468	products/saleor/static/placeholders/mugs/box_01_shn3KXj.jpg	0.5x0.5		2	191
469	products/saleor/static/placeholders/mugs/3_xUh9EMi.jpg	0.5x0.5		3	191
470	products/saleor/static/placeholders/mugs/7_jGunwn2.jpg	0.5x0.5		0	192
471	products/saleor/static/placeholders/mugs/4_58OW4pE.jpg	0.5x0.5		1	192
472	products/saleor/static/placeholders/mugs/4_63In7Ts.jpg	0.5x0.5		0	193
473	products/saleor/static/placeholders/mugs/box_01_Ccc0qUl.jpg	0.5x0.5		1	193
474	products/saleor/static/placeholders/mugs/7_1SZXxsj.jpg	0.5x0.5		2	193
475	products/saleor/static/placeholders/mugs/box_01_kMaCzK5.jpg	0.5x0.5		0	194
476	products/saleor/static/placeholders/mugs/box_01_W0M2eij.jpg	0.5x0.5		1	194
477	products/saleor/static/placeholders/mugs/box_01_pvIN0Hk.jpg	0.5x0.5		0	195
478	products/saleor/static/placeholders/mugs/box_01_Kt4uC71.jpg	0.5x0.5		1	195
479	products/saleor/static/placeholders/mugs/7_ZF62tNs.jpg	0.5x0.5		2	195
480	products/saleor/static/placeholders/mugs/3_Tfa5zGj.jpg	0.5x0.5		3	195
481	products/saleor/static/placeholders/mugs/4_wAv4OKY.jpg	0.5x0.5		0	196
482	products/saleor/static/placeholders/mugs/box_01_4c4XkXB.jpg	0.5x0.5		1	196
483	products/saleor/static/placeholders/mugs/7_G9Tugu3.jpg	0.5x0.5		0	197
484	products/saleor/static/placeholders/mugs/7_SnXSh7X.jpg	0.5x0.5		1	197
485	products/saleor/static/placeholders/mugs/4_TWwl7J0.jpg	0.5x0.5		2	197
486	products/saleor/static/placeholders/mugs/3_7as9JTL.jpg	0.5x0.5		3	197
487	products/saleor/static/placeholders/mugs/4_d5ZyMoa.jpg	0.5x0.5		0	198
488	products/saleor/static/placeholders/mugs/4_NPmLCyL.jpg	0.5x0.5		1	198
489	products/saleor/static/placeholders/mugs/box_01_uPqft7f.jpg	0.5x0.5		2	198
490	products/saleor/static/placeholders/mugs/box_01_UeVJYQE.jpg	0.5x0.5		0	199
491	products/saleor/static/placeholders/mugs/3_01dneVK.jpg	0.5x0.5		1	199
492	products/saleor/static/placeholders/mugs/4_vHeSCmb.jpg	0.5x0.5		2	199
493	products/saleor/static/placeholders/mugs/7_oqSKBwm.jpg	0.5x0.5		3	199
494	products/saleor/static/placeholders/mugs/4_2KdAP6F.jpg	0.5x0.5		0	200
495	products/saleor/static/placeholders/mugs/7_p54QzAe.jpg	0.5x0.5		1	200
496	products/saleor/static/placeholders/mugs/7_gF8tCCY.jpg	0.5x0.5		2	200
497	products/saleor/static/placeholders/mugs/3_5hKAoEW.jpg	0.5x0.5		3	200
498	products/saleor/static/placeholders/coffee/8_ohKXeoc.jpg	0.5x0.5		0	201
499	products/saleor/static/placeholders/coffee/coffee_04_6m1yZTX.jpg	0.5x0.5		1	201
500	products/saleor/static/placeholders/coffee/8_4OyGCjA.jpg	0.5x0.5		2	201
501	products/saleor/static/placeholders/coffee/coffee_04_KSNUJqt.jpg	0.5x0.5		3	201
502	products/saleor/static/placeholders/coffee/coffee_01_P3PbuGj.jpg	0.5x0.5		0	202
503	products/saleor/static/placeholders/coffee/coffee_02_hh5vdCW.jpg	0.5x0.5		1	202
504	products/saleor/static/placeholders/coffee/coffee_02_LgQGaHG.jpg	0.5x0.5		0	203
505	products/saleor/static/placeholders/coffee/coffee_02_pRxw53W.jpg	0.5x0.5		1	203
506	products/saleor/static/placeholders/coffee/coffee_03_glTeFnV.jpg	0.5x0.5		0	204
507	products/saleor/static/placeholders/coffee/coffee_02_IpKTfXm.jpg	0.5x0.5		0	205
508	products/saleor/static/placeholders/coffee/coffee_04_brng00F.jpg	0.5x0.5		0	206
509	products/saleor/static/placeholders/coffee/coffee_03_PBqHRGh.jpg	0.5x0.5		1	206
510	products/saleor/static/placeholders/coffee/coffee_03_jHYptEo.jpg	0.5x0.5		2	206
511	products/saleor/static/placeholders/coffee/coffee_04_MePZzh6.jpg	0.5x0.5		3	206
512	products/saleor/static/placeholders/coffee/coffee_04_yzAZDp5.jpg	0.5x0.5		0	207
513	products/saleor/static/placeholders/coffee/coffee_04_ueuXM6p.jpg	0.5x0.5		1	207
514	products/saleor/static/placeholders/coffee/coffee_02_iCbu2HM.jpg	0.5x0.5		0	208
515	products/saleor/static/placeholders/coffee/coffee_03_XeS1QMH.jpg	0.5x0.5		1	208
516	products/saleor/static/placeholders/coffee/coffee_01_49obuex.jpg	0.5x0.5		2	208
517	products/saleor/static/placeholders/coffee/coffee_04_meVrVYH.jpg	0.5x0.5		3	208
518	products/saleor/static/placeholders/coffee/coffee_02_mK4gWCG.jpg	0.5x0.5		0	209
519	products/saleor/static/placeholders/coffee/coffee_02_1JmKB5J.jpg	0.5x0.5		1	209
520	products/saleor/static/placeholders/coffee/8_qgIpsWJ.jpg	0.5x0.5		0	210
521	products/saleor/static/placeholders/coffee/8_zo05AY8.jpg	0.5x0.5		1	210
522	products/saleor/static/placeholders/coffee/coffee_02_KTHrtZf.jpg	0.5x0.5		2	210
523	products/saleor/static/placeholders/candy/2_nbOaVqY.jpg	0.5x0.5		0	211
524	products/saleor/static/placeholders/candy/2_zuAETIN.jpg	0.5x0.5		0	212
525	products/saleor/static/placeholders/candy/2_QfC1Zs8.jpg	0.5x0.5		1	212
526	products/saleor/static/placeholders/candy/2_5PVjoUG.jpg	0.5x0.5		2	212
527	products/saleor/static/placeholders/candy/2_QhJ6EP7.jpg	0.5x0.5		0	213
528	products/saleor/static/placeholders/candy/1_m0q7KfP.jpg	0.5x0.5		1	213
529	products/saleor/static/placeholders/candy/2_KdRRsJ7.jpg	0.5x0.5		2	213
530	products/saleor/static/placeholders/candy/2_g3WaKX8.jpg	0.5x0.5		3	213
531	products/saleor/static/placeholders/candy/2_xTQs9Rh.jpg	0.5x0.5		0	214
532	products/saleor/static/placeholders/candy/1_rldrVfz.jpg	0.5x0.5		1	214
533	products/saleor/static/placeholders/candy/2_6aX01kL.jpg	0.5x0.5		2	214
534	products/saleor/static/placeholders/candy/1_ZefYI7W.jpg	0.5x0.5		3	214
535	products/saleor/static/placeholders/candy/2_V4QYIWd.jpg	0.5x0.5		0	215
536	products/saleor/static/placeholders/candy/1_ima0NEU.jpg	0.5x0.5		1	215
537	products/saleor/static/placeholders/candy/2_9fa1OWd.jpg	0.5x0.5		2	215
538	products/saleor/static/placeholders/candy/2_BhMcMA1.jpg	0.5x0.5		0	216
539	products/saleor/static/placeholders/candy/1_q2lYWjF.jpg	0.5x0.5		1	216
540	products/saleor/static/placeholders/candy/2_k4dXVTB.jpg	0.5x0.5		0	217
541	products/saleor/static/placeholders/candy/1_MzYYLz0.jpg	0.5x0.5		1	217
542	products/saleor/static/placeholders/candy/1_bHRKuXW.jpg	0.5x0.5		0	218
543	products/saleor/static/placeholders/candy/2_PDTzPX2.jpg	0.5x0.5		1	218
544	products/saleor/static/placeholders/candy/2_v9OIfEh.jpg	0.5x0.5		0	219
545	products/saleor/static/placeholders/candy/2_L6xKLoy.jpg	0.5x0.5		0	220
546	products/saleor/static/placeholders/candy/1_7JrNPLs.jpg	0.5x0.5		1	220
547	products/saleor/static/placeholders/candy/1_rHINN9j.jpg	0.5x0.5		2	220
548	products/saleor/static/placeholders/books/book_04_a1wVv16.jpg	0.5x0.5		0	221
549	products/saleor/static/placeholders/books/book_01_SNTBOGi.jpg	0.5x0.5		1	221
550	products/saleor/static/placeholders/books/book_03_RlsQ6Sn.jpg	0.5x0.5		2	221
551	products/saleor/static/placeholders/books/book_01_tu94JuZ.jpg	0.5x0.5		3	221
552	products/saleor/static/placeholders/books/book_05_m2RnCHt.jpg	0.5x0.5		0	222
553	products/saleor/static/placeholders/books/book_04_x1PTlkL.jpg	0.5x0.5		1	222
554	products/saleor/static/placeholders/books/book_03_ku2ETno.jpg	0.5x0.5		2	222
555	products/saleor/static/placeholders/books/book_03_AQsxoPb.jpg	0.5x0.5		3	222
556	products/saleor/static/placeholders/books/book_03_8yHC5AN.jpg	0.5x0.5		0	223
557	products/saleor/static/placeholders/books/book_03_HfHDP6B.jpg	0.5x0.5		1	223
558	products/saleor/static/placeholders/books/book_02_s4tN1zx.jpg	0.5x0.5		2	223
559	products/saleor/static/placeholders/books/book_01_AEsqLPB.jpg	0.5x0.5		3	223
560	products/saleor/static/placeholders/books/book_02_Px5B1vU.jpg	0.5x0.5		0	224
561	products/saleor/static/placeholders/books/book_04_O391RUn.jpg	0.5x0.5		1	224
562	products/saleor/static/placeholders/books/book_01_JHRpO3r.jpg	0.5x0.5		0	225
563	products/saleor/static/placeholders/books/book_04_8fryplF.jpg	0.5x0.5		1	225
564	products/saleor/static/placeholders/books/book_05_2SmKGLw.jpg	0.5x0.5		0	226
565	products/saleor/static/placeholders/books/book_03_RDtE0Pf.jpg	0.5x0.5		1	226
566	products/saleor/static/placeholders/books/book_03_BNCImty.jpg	0.5x0.5		2	226
567	products/saleor/static/placeholders/books/book_02_3AbExdy.jpg	0.5x0.5		0	227
568	products/saleor/static/placeholders/books/book_01_iEA3krJ.jpg	0.5x0.5		1	227
569	products/saleor/static/placeholders/books/book_02_py1Zgkm.jpg	0.5x0.5		0	228
570	products/saleor/static/placeholders/books/book_02_w6If117.jpg	0.5x0.5		1	228
571	products/saleor/static/placeholders/books/book_02_JpPkf9v.jpg	0.5x0.5		2	228
572	products/saleor/static/placeholders/books/book_04_7365Yn4.jpg	0.5x0.5		3	228
573	products/saleor/static/placeholders/books/book_02_iOYXYia.jpg	0.5x0.5		0	229
574	products/saleor/static/placeholders/books/book_05_Afw0AwX.jpg	0.5x0.5		0	230
575	products/saleor/static/placeholders/books/book_02_kPThkbS.jpg	0.5x0.5		1	230
576	products/saleor/static/placeholders/books/book_02_GO6T8Y6.jpg	0.5x0.5		2	230
577	products/saleor/static/placeholders/books/book_02_vYfF4LJ.jpg	0.5x0.5		3	230
578	products/saleor/static/placeholders/books/book_01_WjhWEAJ.jpg	0.5x0.5		0	231
579	products/saleor/static/placeholders/books/book_05_jxTG5xe.jpg	0.5x0.5		0	232
580	products/saleor/static/placeholders/books/book_05_i6Ki3Zk.jpg	0.5x0.5		1	232
581	products/saleor/static/placeholders/books/book_01_NDOF4oR.jpg	0.5x0.5		0	233
582	products/saleor/static/placeholders/books/book_01_8N2Wiof.jpg	0.5x0.5		1	233
583	products/saleor/static/placeholders/books/book_05_HZ5LUuo.jpg	0.5x0.5		2	233
584	products/saleor/static/placeholders/books/book_04_9EgeekF.jpg	0.5x0.5		0	234
585	products/saleor/static/placeholders/books/book_05_log1npd.jpg	0.5x0.5		1	234
586	products/saleor/static/placeholders/books/book_03_Jw0kJY6.jpg	0.5x0.5		2	234
587	products/saleor/static/placeholders/books/book_04_PQDX4lL.jpg	0.5x0.5		3	234
588	products/saleor/static/placeholders/books/book_03_MAE1SwI.jpg	0.5x0.5		0	235
589	products/saleor/static/placeholders/books/book_03_mA3QZAC.jpg	0.5x0.5		1	235
590	products/saleor/static/placeholders/books/book_02_8i4VV46.jpg	0.5x0.5		0	236
591	products/saleor/static/placeholders/books/book_05_9kWCdIA.jpg	0.5x0.5		1	236
592	products/saleor/static/placeholders/books/book_01_YSMwFZW.jpg	0.5x0.5		0	237
593	products/saleor/static/placeholders/books/book_04_ut2UzLh.jpg	0.5x0.5		1	237
594	products/saleor/static/placeholders/books/book_02_VGall2m.jpg	0.5x0.5		2	237
595	products/saleor/static/placeholders/books/book_01_20Ricde.jpg	0.5x0.5		0	238
596	products/saleor/static/placeholders/books/book_03_Nc0NBkE.jpg	0.5x0.5		1	238
597	products/saleor/static/placeholders/books/book_04_CqBKwXS.jpg	0.5x0.5		2	238
598	products/saleor/static/placeholders/books/book_04_YkqpPD5.jpg	0.5x0.5		3	238
599	products/saleor/static/placeholders/books/book_02_s56ak8N.jpg	0.5x0.5		0	239
600	products/saleor/static/placeholders/books/book_04_w5u7oG5.jpg	0.5x0.5		1	239
601	products/saleor/static/placeholders/books/book_03_qUdd7mS.jpg	0.5x0.5		2	239
602	products/saleor/static/placeholders/books/book_04_MGNY0ds.jpg	0.5x0.5		0	240
603	products/saleor/static/placeholders/books/book_01_Q6srC0Z.jpg	0.5x0.5		1	240
604	products/saleor/static/placeholders/t-shirts/6.jpg	0.5x0.5		0	241
605	products/saleor/static/placeholders/t-shirts/6_7ADUWiH.jpg	0.5x0.5		1	241
606	products/saleor/static/placeholders/t-shirts/6_qUTbDIr.jpg	0.5x0.5		2	241
607	products/saleor/static/placeholders/t-shirts/5.jpg	0.5x0.5		3	241
608	products/saleor/static/placeholders/t-shirts/6_LtuvjYd.jpg	0.5x0.5		0	242
609	products/saleor/static/placeholders/t-shirts/5_M4tkCIm.jpg	0.5x0.5		0	243
610	products/saleor/static/placeholders/t-shirts/6_fGSmh7Z.jpg	0.5x0.5		1	243
611	products/saleor/static/placeholders/t-shirts/6_gTBt9uN.jpg	0.5x0.5		2	243
612	products/saleor/static/placeholders/t-shirts/5_ViVRJph.jpg	0.5x0.5		3	243
613	products/saleor/static/placeholders/t-shirts/6_U6g7SlX.jpg	0.5x0.5		0	244
614	products/saleor/static/placeholders/t-shirts/6_bFCDYyt.jpg	0.5x0.5		1	244
615	products/saleor/static/placeholders/t-shirts/6_Mcj7H5C.jpg	0.5x0.5		2	244
616	products/saleor/static/placeholders/t-shirts/5_itrYcAh.jpg	0.5x0.5		3	244
617	products/saleor/static/placeholders/t-shirts/5_jr3ccE0.jpg	0.5x0.5		0	245
618	products/saleor/static/placeholders/t-shirts/6_53h3DTb.jpg	0.5x0.5		1	245
619	products/saleor/static/placeholders/t-shirts/5_ntiJWC1.jpg	0.5x0.5		2	245
620	products/saleor/static/placeholders/t-shirts/5_3jic5W1.jpg	0.5x0.5		0	246
621	products/saleor/static/placeholders/t-shirts/6_6oKOSD0.jpg	0.5x0.5		1	246
622	products/saleor/static/placeholders/t-shirts/5_RwFQozu.jpg	0.5x0.5		2	246
623	products/saleor/static/placeholders/t-shirts/6_VDq0Wrk.jpg	0.5x0.5		0	247
624	products/saleor/static/placeholders/t-shirts/6_6GCOh63.jpg	0.5x0.5		1	247
625	products/saleor/static/placeholders/t-shirts/6_I8CLCAj.jpg	0.5x0.5		0	248
626	products/saleor/static/placeholders/t-shirts/6_PumjJSC.jpg	0.5x0.5		1	248
627	products/saleor/static/placeholders/t-shirts/5_CfCr5Uj.jpg	0.5x0.5		2	248
628	products/saleor/static/placeholders/t-shirts/5_VfvL7ww.jpg	0.5x0.5		3	248
629	products/saleor/static/placeholders/t-shirts/6_BVtoeVk.jpg	0.5x0.5		0	249
630	products/saleor/static/placeholders/t-shirts/5_jOHcJnp.jpg	0.5x0.5		0	250
631	products/saleor/static/placeholders/t-shirts/6_DsOuLik.jpg	0.5x0.5		1	250
632	products/saleor/static/placeholders/t-shirts/5_6CUUam8.jpg	0.5x0.5		2	250
633	products/saleor/static/placeholders/mugs/3.jpg	0.5x0.5		0	251
634	products/saleor/static/placeholders/mugs/4.jpg	0.5x0.5		1	251
635	products/saleor/static/placeholders/mugs/box_01.jpg	0.5x0.5		2	251
636	products/saleor/static/placeholders/mugs/box_01_NzzqNgZ.jpg	0.5x0.5		0	252
637	products/saleor/static/placeholders/mugs/box_01_zmsmi2n.jpg	0.5x0.5		1	252
638	products/saleor/static/placeholders/mugs/box_01_84XaiOK.jpg	0.5x0.5		2	252
639	products/saleor/static/placeholders/mugs/3_3McjJc0.jpg	0.5x0.5		3	252
640	products/saleor/static/placeholders/mugs/box_01_7wm70fj.jpg	0.5x0.5		0	253
641	products/saleor/static/placeholders/mugs/7.jpg	0.5x0.5		1	253
642	products/saleor/static/placeholders/mugs/3_JPG7J0X.jpg	0.5x0.5		0	254
643	products/saleor/static/placeholders/mugs/7_0Qd00k5.jpg	0.5x0.5		1	254
644	products/saleor/static/placeholders/mugs/7_D7VsuIo.jpg	0.5x0.5		0	255
645	products/saleor/static/placeholders/mugs/box_01_1hkqoQ8.jpg	0.5x0.5		1	255
646	products/saleor/static/placeholders/mugs/4_TBNhTdv.jpg	0.5x0.5		0	256
647	products/saleor/static/placeholders/mugs/box_01_3nID56c.jpg	0.5x0.5		1	256
648	products/saleor/static/placeholders/mugs/4_PaFF8rC.jpg	0.5x0.5		2	256
649	products/saleor/static/placeholders/mugs/7_mvuE8hg.jpg	0.5x0.5		0	257
650	products/saleor/static/placeholders/mugs/7_qb9g03Z.jpg	0.5x0.5		0	258
651	products/saleor/static/placeholders/mugs/4_lciI2Cu.jpg	0.5x0.5		1	258
652	products/saleor/static/placeholders/mugs/4_QdVedng.jpg	0.5x0.5		0	259
653	products/saleor/static/placeholders/mugs/box_01_QT8gE0w.jpg	0.5x0.5		1	259
654	products/saleor/static/placeholders/mugs/4_bAMj94v.jpg	0.5x0.5		2	259
655	products/saleor/static/placeholders/mugs/3_hk5TQC3.jpg	0.5x0.5		3	259
656	products/saleor/static/placeholders/mugs/3_arAwyNT.jpg	0.5x0.5		0	260
657	products/saleor/static/placeholders/mugs/7_oVMOmQh.jpg	0.5x0.5		1	260
658	products/saleor/static/placeholders/coffee/coffee_02.jpg	0.5x0.5		0	261
659	products/saleor/static/placeholders/coffee/coffee_02_vOVTY23.jpg	0.5x0.5		1	261
660	products/saleor/static/placeholders/coffee/coffee_01.jpg	0.5x0.5		2	261
661	products/saleor/static/placeholders/coffee/coffee_04.jpg	0.5x0.5		3	261
662	products/saleor/static/placeholders/coffee/coffee_03.jpg	0.5x0.5		0	262
663	products/saleor/static/placeholders/coffee/coffee_04_WtehKYf.jpg	0.5x0.5		0	263
664	products/saleor/static/placeholders/coffee/coffee_01_CdfxEeF.jpg	0.5x0.5		1	263
665	products/saleor/static/placeholders/coffee/8.jpg	0.5x0.5		2	263
666	products/saleor/static/placeholders/coffee/coffee_02_D5P9Pp0.jpg	0.5x0.5		0	264
667	products/saleor/static/placeholders/coffee/coffee_01_XP5J3oF.jpg	0.5x0.5		1	264
668	products/saleor/static/placeholders/coffee/coffee_03_rwANZVd.jpg	0.5x0.5		2	264
669	products/saleor/static/placeholders/coffee/coffee_04_Jc1Y1cI.jpg	0.5x0.5		0	265
670	products/saleor/static/placeholders/coffee/coffee_01_hTMALcW.jpg	0.5x0.5		1	265
671	products/saleor/static/placeholders/coffee/coffee_03_RBtQkMQ.jpg	0.5x0.5		0	266
672	products/saleor/static/placeholders/coffee/coffee_03_2YLRpLc.jpg	0.5x0.5		1	266
673	products/saleor/static/placeholders/coffee/coffee_03_QBUnHa4.jpg	0.5x0.5		2	266
674	products/saleor/static/placeholders/coffee/coffee_03_CCVYJhy.jpg	0.5x0.5		3	266
675	products/saleor/static/placeholders/coffee/8_ALIkurL.jpg	0.5x0.5		0	267
676	products/saleor/static/placeholders/coffee/coffee_03_7h9eLx1.jpg	0.5x0.5		1	267
677	products/saleor/static/placeholders/coffee/8_dWSsErw.jpg	0.5x0.5		2	267
678	products/saleor/static/placeholders/coffee/coffee_02_4XUhe6o.jpg	0.5x0.5		0	268
679	products/saleor/static/placeholders/coffee/8_XCwm0wq.jpg	0.5x0.5		1	268
680	products/saleor/static/placeholders/coffee/coffee_01_0P4qlna.jpg	0.5x0.5		2	268
681	products/saleor/static/placeholders/coffee/coffee_01_BMpSKEd.jpg	0.5x0.5		0	269
682	products/saleor/static/placeholders/coffee/8_XLmrZBB.jpg	0.5x0.5		1	269
683	products/saleor/static/placeholders/coffee/coffee_01_tvlOutE.jpg	0.5x0.5		2	269
684	products/saleor/static/placeholders/coffee/coffee_01_h5mnJsL.jpg	0.5x0.5		0	270
685	products/saleor/static/placeholders/coffee/coffee_03_oWpeADI.jpg	0.5x0.5		1	270
686	products/saleor/static/placeholders/candy/1.jpg	0.5x0.5		0	271
687	products/saleor/static/placeholders/candy/1_Qn57y64.jpg	0.5x0.5		1	271
688	products/saleor/static/placeholders/candy/2.jpg	0.5x0.5		0	272
689	products/saleor/static/placeholders/candy/1_SHNqjuG.jpg	0.5x0.5		1	272
690	products/saleor/static/placeholders/candy/2_VNxA9MU.jpg	0.5x0.5		0	273
691	products/saleor/static/placeholders/candy/1_uoeeFp6.jpg	0.5x0.5		1	273
692	products/saleor/static/placeholders/candy/1_qDGH6Xl.jpg	0.5x0.5		0	274
693	products/saleor/static/placeholders/candy/2_J0O6spV.jpg	0.5x0.5		1	274
694	products/saleor/static/placeholders/candy/2_TeoR7Pt.jpg	0.5x0.5		2	274
695	products/saleor/static/placeholders/candy/2_YgJpW4Y.jpg	0.5x0.5		3	274
696	products/saleor/static/placeholders/candy/2_RmgDdSX.jpg	0.5x0.5		0	275
697	products/saleor/static/placeholders/candy/2_oDXfbIv.jpg	0.5x0.5		0	276
698	products/saleor/static/placeholders/candy/1_TNR1YL1.jpg	0.5x0.5		1	276
699	products/saleor/static/placeholders/candy/2_qgEKoaT.jpg	0.5x0.5		2	276
700	products/saleor/static/placeholders/candy/1_RfRrbbV.jpg	0.5x0.5		3	276
701	products/saleor/static/placeholders/candy/2_02UvrkU.jpg	0.5x0.5		0	277
702	products/saleor/static/placeholders/candy/1_8HoOZjo.jpg	0.5x0.5		1	277
703	products/saleor/static/placeholders/candy/1_wHBSNvK.jpg	0.5x0.5		2	277
704	products/saleor/static/placeholders/candy/1_brX2FTa.jpg	0.5x0.5		3	277
705	products/saleor/static/placeholders/candy/1_1yc9xTi.jpg	0.5x0.5		0	278
706	products/saleor/static/placeholders/candy/2_l06E7b7.jpg	0.5x0.5		0	279
707	products/saleor/static/placeholders/candy/1_uFqNpJb.jpg	0.5x0.5		1	279
708	products/saleor/static/placeholders/candy/1_sfGOERa.jpg	0.5x0.5		0	280
709	products/saleor/static/placeholders/books/book_05.jpg	0.5x0.5		0	281
710	products/saleor/static/placeholders/books/book_01.jpg	0.5x0.5		1	281
711	products/saleor/static/placeholders/books/book_05_lPxyi60.jpg	0.5x0.5		2	281
712	products/saleor/static/placeholders/books/book_05_WZnq7b0.jpg	0.5x0.5		0	282
713	products/saleor/static/placeholders/books/book_02.jpg	0.5x0.5		1	282
714	products/saleor/static/placeholders/books/book_03.jpg	0.5x0.5		0	283
715	products/saleor/static/placeholders/books/book_04.jpg	0.5x0.5		1	283
716	products/saleor/static/placeholders/books/book_01_aeaqBfY.jpg	0.5x0.5		2	283
717	products/saleor/static/placeholders/books/book_05_bosapE2.jpg	0.5x0.5		3	283
718	products/saleor/static/placeholders/books/book_05_hpFs9Ak.jpg	0.5x0.5		0	284
719	products/saleor/static/placeholders/books/book_03_c945i88.jpg	0.5x0.5		1	284
720	products/saleor/static/placeholders/books/book_04_lDvlMx9.jpg	0.5x0.5		0	285
721	products/saleor/static/placeholders/books/book_03_t6lyUyf.jpg	0.5x0.5		1	285
722	products/saleor/static/placeholders/books/book_02_W0luVfI.jpg	0.5x0.5		2	285
723	products/saleor/static/placeholders/books/book_04_pgd17Xq.jpg	0.5x0.5		3	285
724	products/saleor/static/placeholders/books/book_04_53EzTJX.jpg	0.5x0.5		0	286
725	products/saleor/static/placeholders/books/book_02_Hc7vkmF.jpg	0.5x0.5		0	287
726	products/saleor/static/placeholders/books/book_05_MVNuAQU.jpg	0.5x0.5		1	287
727	products/saleor/static/placeholders/books/book_05_3eefv5z.jpg	0.5x0.5		0	288
728	products/saleor/static/placeholders/books/book_05_JjASH8k.jpg	0.5x0.5		0	289
729	products/saleor/static/placeholders/books/book_03_UlJVFv4.jpg	0.5x0.5		1	289
730	products/saleor/static/placeholders/books/book_03_Xj5PAxi.jpg	0.5x0.5		2	289
731	products/saleor/static/placeholders/books/book_05_snlWDLG.jpg	0.5x0.5		0	290
732	products/saleor/static/placeholders/books/book_04_WLhrYxt.jpg	0.5x0.5		1	290
733	products/saleor/static/placeholders/books/book_04_K3GqEfL.jpg	0.5x0.5		2	290
734	products/saleor/static/placeholders/books/book_05_oNZH7fT.jpg	0.5x0.5		0	291
735	products/saleor/static/placeholders/books/book_01_PzH6AX1.jpg	0.5x0.5		1	291
736	products/saleor/static/placeholders/books/book_01_wKicrxr.jpg	0.5x0.5		0	292
737	products/saleor/static/placeholders/books/book_03_DlmznIS.jpg	0.5x0.5		0	293
738	products/saleor/static/placeholders/books/book_01_V35zLXx.jpg	0.5x0.5		1	293
739	products/saleor/static/placeholders/books/book_02_j2H2Uz1.jpg	0.5x0.5		2	293
740	products/saleor/static/placeholders/books/book_05_SmJf3na.jpg	0.5x0.5		0	294
741	products/saleor/static/placeholders/books/book_05_brZgeHE.jpg	0.5x0.5		1	294
742	products/saleor/static/placeholders/books/book_05_Lf7p8BW.jpg	0.5x0.5		2	294
743	products/saleor/static/placeholders/books/book_02_cGvJCaF.jpg	0.5x0.5		0	295
744	products/saleor/static/placeholders/books/book_03_9wHLmzh.jpg	0.5x0.5		1	295
745	products/saleor/static/placeholders/books/book_02_xSYO0oi.jpg	0.5x0.5		2	295
746	products/saleor/static/placeholders/books/book_03_6Fc0gYL.jpg	0.5x0.5		0	296
747	products/saleor/static/placeholders/books/book_02_pnZjXxk.jpg	0.5x0.5		0	297
748	products/saleor/static/placeholders/books/book_02_hBqNbbo.jpg	0.5x0.5		0	298
749	products/saleor/static/placeholders/books/book_02_X33IgA4.jpg	0.5x0.5		1	298
750	products/saleor/static/placeholders/books/book_02_LA2cO0D.jpg	0.5x0.5		2	298
751	products/saleor/static/placeholders/books/book_02_Jp8t3IL.jpg	0.5x0.5		3	298
752	products/saleor/static/placeholders/books/book_02_JG20q4L.jpg	0.5x0.5		0	299
753	products/saleor/static/placeholders/books/book_02_DwAa6ZZ.jpg	0.5x0.5		1	299
754	products/saleor/static/placeholders/books/book_03_pOM2zaj.jpg	0.5x0.5		2	299
755	products/saleor/static/placeholders/books/book_02_YlAJPah.jpg	0.5x0.5		3	299
756	products/saleor/static/placeholders/books/book_05_xEXcbo7.jpg	0.5x0.5		0	300
757	products/saleor/static/placeholders/books/book_05_5nDhcbc.jpg	0.5x0.5		1	300
758	products/saleor/static/placeholders/t-shirts/5_0hMteJX.jpg	0.5x0.5		0	301
759	products/saleor/static/placeholders/t-shirts/5_zfYKECz.jpg	0.5x0.5		1	301
760	products/saleor/static/placeholders/t-shirts/5_AeVZOcW.jpg	0.5x0.5		0	302
761	products/saleor/static/placeholders/t-shirts/6_B7qBTle.jpg	0.5x0.5		0	303
762	products/saleor/static/placeholders/t-shirts/6_90wHxKQ.jpg	0.5x0.5		1	303
763	products/saleor/static/placeholders/t-shirts/6_1UW8Ub5.jpg	0.5x0.5		2	303
764	products/saleor/static/placeholders/t-shirts/5_lWwzE8D.jpg	0.5x0.5		3	303
765	products/saleor/static/placeholders/t-shirts/6_WmncthW.jpg	0.5x0.5		0	304
766	products/saleor/static/placeholders/t-shirts/6_ZEi2FXa.jpg	0.5x0.5		1	304
767	products/saleor/static/placeholders/t-shirts/5_eOz6Nzg.jpg	0.5x0.5		2	304
768	products/saleor/static/placeholders/t-shirts/5_7Arwg6F.jpg	0.5x0.5		0	305
769	products/saleor/static/placeholders/t-shirts/6_sUq4iI8.jpg	0.5x0.5		1	305
770	products/saleor/static/placeholders/t-shirts/6_RF870oZ.jpg	0.5x0.5		2	305
771	products/saleor/static/placeholders/t-shirts/6_eTlR9Wg.jpg	0.5x0.5		3	305
772	products/saleor/static/placeholders/t-shirts/6_NUMAL0U.jpg	0.5x0.5		0	306
773	products/saleor/static/placeholders/t-shirts/5_uMc9jxS.jpg	0.5x0.5		0	307
774	products/saleor/static/placeholders/t-shirts/5_nLY2gLm.jpg	0.5x0.5		0	308
775	products/saleor/static/placeholders/t-shirts/5_Kfa4tjc.jpg	0.5x0.5		1	308
776	products/saleor/static/placeholders/t-shirts/5_HhUVuMh.jpg	0.5x0.5		2	308
777	products/saleor/static/placeholders/t-shirts/6_eu01Y0Y.jpg	0.5x0.5		3	308
778	products/saleor/static/placeholders/t-shirts/6_UUdbPD6.jpg	0.5x0.5		0	309
779	products/saleor/static/placeholders/t-shirts/5_JTvZifx.jpg	0.5x0.5		1	309
780	products/saleor/static/placeholders/t-shirts/6_0tjGb2q.jpg	0.5x0.5		2	309
781	products/saleor/static/placeholders/t-shirts/6_pE0yADF.jpg	0.5x0.5		3	309
782	products/saleor/static/placeholders/t-shirts/6_s02t1k1.jpg	0.5x0.5		0	310
783	products/saleor/static/placeholders/t-shirts/5_NLHUCbu.jpg	0.5x0.5		1	310
784	products/saleor/static/placeholders/t-shirts/5_uLm8ImS.jpg	0.5x0.5		2	310
785	products/saleor/static/placeholders/t-shirts/5_BNgJuxc.jpg	0.5x0.5		3	310
786	products/saleor/static/placeholders/mugs/3_CQXBrwm.jpg	0.5x0.5		0	311
787	products/saleor/static/placeholders/mugs/7_KLl8Yc5.jpg	0.5x0.5		1	311
788	products/saleor/static/placeholders/mugs/3_aKV8nEw.jpg	0.5x0.5		2	311
789	products/saleor/static/placeholders/mugs/4_t5SXYGh.jpg	0.5x0.5		3	311
790	products/saleor/static/placeholders/mugs/3_F515oIn.jpg	0.5x0.5		0	312
791	products/saleor/static/placeholders/mugs/4_ylPSvel.jpg	0.5x0.5		1	312
792	products/saleor/static/placeholders/mugs/box_01_lVwsmgS.jpg	0.5x0.5		2	312
793	products/saleor/static/placeholders/mugs/3_JaLY3wW.jpg	0.5x0.5		3	312
794	products/saleor/static/placeholders/mugs/4_sqrCDOh.jpg	0.5x0.5		0	313
795	products/saleor/static/placeholders/mugs/3_UB2vUA8.jpg	0.5x0.5		1	313
796	products/saleor/static/placeholders/mugs/3_2rzh3Mf.jpg	0.5x0.5		2	313
797	products/saleor/static/placeholders/mugs/7_qzha8uu.jpg	0.5x0.5		3	313
798	products/saleor/static/placeholders/mugs/7_hb3Psmm.jpg	0.5x0.5		0	314
799	products/saleor/static/placeholders/mugs/3_F0L9ipX.jpg	0.5x0.5		1	314
800	products/saleor/static/placeholders/mugs/3_HN5Ni3x.jpg	0.5x0.5		2	314
801	products/saleor/static/placeholders/mugs/7_g7oEeSV.jpg	0.5x0.5		3	314
802	products/saleor/static/placeholders/mugs/box_01_XvEtXLy.jpg	0.5x0.5		0	315
803	products/saleor/static/placeholders/mugs/7_XO6LqtN.jpg	0.5x0.5		1	315
804	products/saleor/static/placeholders/mugs/3_qJhpYJM.jpg	0.5x0.5		2	315
805	products/saleor/static/placeholders/mugs/box_01_xNlHsyQ.jpg	0.5x0.5		3	315
806	products/saleor/static/placeholders/mugs/3_YoUl0Cz.jpg	0.5x0.5		0	316
807	products/saleor/static/placeholders/mugs/3_pWw64CS.jpg	0.5x0.5		1	316
808	products/saleor/static/placeholders/mugs/3_O5FhWqL.jpg	0.5x0.5		0	317
809	products/saleor/static/placeholders/mugs/3_6rtGcdY.jpg	0.5x0.5		0	318
810	products/saleor/static/placeholders/mugs/4_pwnsF2I.jpg	0.5x0.5		1	318
811	products/saleor/static/placeholders/mugs/4_Av36kLa.jpg	0.5x0.5		0	319
812	products/saleor/static/placeholders/mugs/4_qsECJFo.jpg	0.5x0.5		0	320
813	products/saleor/static/placeholders/mugs/7_f2z8P54.jpg	0.5x0.5		1	320
814	products/saleor/static/placeholders/mugs/box_01_lVz7lsq.jpg	0.5x0.5		2	320
815	products/saleor/static/placeholders/coffee/8_03QbxF8.jpg	0.5x0.5		0	321
816	products/saleor/static/placeholders/coffee/coffee_03_BnCaUUT.jpg	0.5x0.5		0	322
817	products/saleor/static/placeholders/coffee/coffee_03_GyjBhAM.jpg	0.5x0.5		1	322
818	products/saleor/static/placeholders/coffee/coffee_01_RJ312SY.jpg	0.5x0.5		2	322
819	products/saleor/static/placeholders/coffee/coffee_03_rlsL054.jpg	0.5x0.5		0	323
820	products/saleor/static/placeholders/coffee/8_P2CJuR7.jpg	0.5x0.5		1	323
821	products/saleor/static/placeholders/coffee/coffee_02_JzPqNqF.jpg	0.5x0.5		0	324
822	products/saleor/static/placeholders/coffee/coffee_03_u6PbxVf.jpg	0.5x0.5		0	325
823	products/saleor/static/placeholders/coffee/coffee_02_bXHrYW2.jpg	0.5x0.5		0	326
824	products/saleor/static/placeholders/coffee/coffee_03_H7RRAJq.jpg	0.5x0.5		1	326
825	products/saleor/static/placeholders/coffee/coffee_02_vRPX0FI.jpg	0.5x0.5		2	326
826	products/saleor/static/placeholders/coffee/coffee_02_2tzftGC.jpg	0.5x0.5		0	327
827	products/saleor/static/placeholders/coffee/coffee_04_RFTTbr1.jpg	0.5x0.5		1	327
828	products/saleor/static/placeholders/coffee/8_Wf3yMpo.jpg	0.5x0.5		2	327
829	products/saleor/static/placeholders/coffee/coffee_04_7gcvpMS.jpg	0.5x0.5		3	327
830	products/saleor/static/placeholders/coffee/coffee_04_YRregcl.jpg	0.5x0.5		0	328
831	products/saleor/static/placeholders/coffee/coffee_04_awPM8TS.jpg	0.5x0.5		1	328
832	products/saleor/static/placeholders/coffee/coffee_03_S0GnIWU.jpg	0.5x0.5		0	329
833	products/saleor/static/placeholders/coffee/coffee_02_k0Iiz4s.jpg	0.5x0.5		1	329
834	products/saleor/static/placeholders/coffee/8_EhiUuco.jpg	0.5x0.5		2	329
835	products/saleor/static/placeholders/coffee/coffee_02_3lgZak2.jpg	0.5x0.5		0	330
836	products/saleor/static/placeholders/candy/1_FPjDYN8.jpg	0.5x0.5		0	331
837	products/saleor/static/placeholders/candy/1_jcgChSR.jpg	0.5x0.5		0	332
838	products/saleor/static/placeholders/candy/2_pucAsZJ.jpg	0.5x0.5		1	332
839	products/saleor/static/placeholders/candy/2_cLHGzSb.jpg	0.5x0.5		2	332
840	products/saleor/static/placeholders/candy/1_Cg6cwWv.jpg	0.5x0.5		3	332
841	products/saleor/static/placeholders/candy/1_koRC2de.jpg	0.5x0.5		0	333
842	products/saleor/static/placeholders/candy/2_BstVAzu.jpg	0.5x0.5		1	333
843	products/saleor/static/placeholders/candy/2_il2MGxD.jpg	0.5x0.5		2	333
844	products/saleor/static/placeholders/candy/2_vY032pr.jpg	0.5x0.5		0	334
845	products/saleor/static/placeholders/candy/2_T9R2rhj.jpg	0.5x0.5		1	334
846	products/saleor/static/placeholders/candy/1_MIe1czO.jpg	0.5x0.5		2	334
847	products/saleor/static/placeholders/candy/1_hsXNlBv.jpg	0.5x0.5		3	334
848	products/saleor/static/placeholders/candy/2_8bt1Dtv.jpg	0.5x0.5		0	335
849	products/saleor/static/placeholders/candy/1_moP7S5J.jpg	0.5x0.5		1	335
850	products/saleor/static/placeholders/candy/2_SbJ6nFy.jpg	0.5x0.5		0	336
851	products/saleor/static/placeholders/candy/1_9dzhNoE.jpg	0.5x0.5		0	337
852	products/saleor/static/placeholders/candy/2_AFo46Gy.jpg	0.5x0.5		1	337
853	products/saleor/static/placeholders/candy/2_6ttOgpY.jpg	0.5x0.5		2	337
854	products/saleor/static/placeholders/candy/1_lIM1Kch.jpg	0.5x0.5		0	338
855	products/saleor/static/placeholders/candy/2_HOJYW50.jpg	0.5x0.5		0	339
856	products/saleor/static/placeholders/candy/1_0A4mDWe.jpg	0.5x0.5		1	339
857	products/saleor/static/placeholders/candy/2_jFlktyB.jpg	0.5x0.5		2	339
858	products/saleor/static/placeholders/candy/2_bZnrUHa.jpg	0.5x0.5		0	340
859	products/saleor/static/placeholders/candy/1_8iEtaAP.jpg	0.5x0.5		1	340
860	products/saleor/static/placeholders/books/book_05_RFrrYir.jpg	0.5x0.5		0	341
861	products/saleor/static/placeholders/books/book_05_gBo3v7y.jpg	0.5x0.5		1	341
862	products/saleor/static/placeholders/books/book_03_cOSKpjE.jpg	0.5x0.5		2	341
863	products/saleor/static/placeholders/books/book_04_Xin7PWu.jpg	0.5x0.5		3	341
864	products/saleor/static/placeholders/books/book_01_ZalpRmH.jpg	0.5x0.5		0	342
865	products/saleor/static/placeholders/books/book_05_G9pDGQ3.jpg	0.5x0.5		1	342
866	products/saleor/static/placeholders/books/book_01_CPNsfnv.jpg	0.5x0.5		2	342
867	products/saleor/static/placeholders/books/book_05_4cgmROc.jpg	0.5x0.5		0	343
868	products/saleor/static/placeholders/books/book_03_9vxb2Ug.jpg	0.5x0.5		1	343
869	products/saleor/static/placeholders/books/book_04_Vlcb0SF.jpg	0.5x0.5		2	343
870	products/saleor/static/placeholders/books/book_02_Cvq2Jh4.jpg	0.5x0.5		3	343
871	products/saleor/static/placeholders/books/book_03_tqEXh46.jpg	0.5x0.5		0	344
872	products/saleor/static/placeholders/books/book_02_4DZCbYN.jpg	0.5x0.5		1	344
873	products/saleor/static/placeholders/books/book_02_dS3X4MP.jpg	0.5x0.5		2	344
874	products/saleor/static/placeholders/books/book_01_ZZjgtxp.jpg	0.5x0.5		3	344
875	products/saleor/static/placeholders/books/book_01_utOu0O0.jpg	0.5x0.5		0	345
876	products/saleor/static/placeholders/books/book_05_RGbCaHN.jpg	0.5x0.5		1	345
877	products/saleor/static/placeholders/books/book_01_uqLjV1O.jpg	0.5x0.5		2	345
878	products/saleor/static/placeholders/books/book_05_ZRAINoK.jpg	0.5x0.5		0	346
879	products/saleor/static/placeholders/books/book_03_TFk8wX6.jpg	0.5x0.5		1	346
880	products/saleor/static/placeholders/books/book_04_uEumNrq.jpg	0.5x0.5		2	346
881	products/saleor/static/placeholders/books/book_02_iBDZtvo.jpg	0.5x0.5		3	346
882	products/saleor/static/placeholders/books/book_01_GP3tdKV.jpg	0.5x0.5		0	347
883	products/saleor/static/placeholders/books/book_03_f3ayPlZ.jpg	0.5x0.5		1	347
884	products/saleor/static/placeholders/books/book_05_NOLqmjh.jpg	0.5x0.5		0	348
885	products/saleor/static/placeholders/books/book_04_eh1hc9h.jpg	0.5x0.5		1	348
886	products/saleor/static/placeholders/books/book_03_JX3UV43.jpg	0.5x0.5		0	349
887	products/saleor/static/placeholders/books/book_02_YRGtGjd.jpg	0.5x0.5		0	350
888	products/saleor/static/placeholders/books/book_02_xpfgEt4.jpg	0.5x0.5		1	350
889	products/saleor/static/placeholders/books/book_03_ppw6VDK.jpg	0.5x0.5		2	350
890	products/saleor/static/placeholders/books/book_02_LwuRQ1U.jpg	0.5x0.5		3	350
891	products/saleor/static/placeholders/books/book_03_KxJ2VvD.jpg	0.5x0.5		0	351
892	products/saleor/static/placeholders/books/book_02_Gl74MVS.jpg	0.5x0.5		1	351
893	products/saleor/static/placeholders/books/book_04_uLhphqu.jpg	0.5x0.5		0	352
894	products/saleor/static/placeholders/books/book_05_xOE2KJt.jpg	0.5x0.5		1	352
895	products/saleor/static/placeholders/books/book_02_A7WeaLD.jpg	0.5x0.5		0	353
896	products/saleor/static/placeholders/books/book_02_i3h7Anu.jpg	0.5x0.5		1	353
897	products/saleor/static/placeholders/books/book_02_R9exbLD.jpg	0.5x0.5		2	353
898	products/saleor/static/placeholders/books/book_04_9G8c7kE.jpg	0.5x0.5		3	353
899	products/saleor/static/placeholders/books/book_04_i4oWdZu.jpg	0.5x0.5		0	354
900	products/saleor/static/placeholders/books/book_04_ahGBfnp.jpg	0.5x0.5		1	354
901	products/saleor/static/placeholders/books/book_03_gGNB2g6.jpg	0.5x0.5		2	354
902	products/saleor/static/placeholders/books/book_01_IEXJyDJ.jpg	0.5x0.5		3	354
903	products/saleor/static/placeholders/books/book_02_hXytxxq.jpg	0.5x0.5		0	355
904	products/saleor/static/placeholders/books/book_04_6IIeWnO.jpg	0.5x0.5		0	356
905	products/saleor/static/placeholders/books/book_02_eJYLPPg.jpg	0.5x0.5		0	357
906	products/saleor/static/placeholders/books/book_01_d1yWYo9.jpg	0.5x0.5		1	357
907	products/saleor/static/placeholders/books/book_01_pGwd6Cb.jpg	0.5x0.5		0	358
908	products/saleor/static/placeholders/books/book_02_ni35Kqi.jpg	0.5x0.5		0	359
909	products/saleor/static/placeholders/books/book_05_YWbmfgB.jpg	0.5x0.5		1	359
910	products/saleor/static/placeholders/books/book_02_Y938EHk.jpg	0.5x0.5		2	359
911	products/saleor/static/placeholders/books/book_05_nWfSyoP.jpg	0.5x0.5		0	360
912	products/saleor/static/placeholders/t-shirts/5_Hau9QTF.jpg	0.5x0.5		0	361
913	products/saleor/static/placeholders/t-shirts/5_lqIKxjK.jpg	0.5x0.5		1	361
914	products/saleor/static/placeholders/t-shirts/6_mD8gvqL.jpg	0.5x0.5		0	362
915	products/saleor/static/placeholders/t-shirts/6_G4fiiIN.jpg	0.5x0.5		1	362
916	products/saleor/static/placeholders/t-shirts/6_UT9qD1j.jpg	0.5x0.5		2	362
917	products/saleor/static/placeholders/t-shirts/5_P7ay7ws.jpg	0.5x0.5		0	363
918	products/saleor/static/placeholders/t-shirts/6_Qb2Mubz.jpg	0.5x0.5		1	363
919	products/saleor/static/placeholders/t-shirts/5_44llvfQ.jpg	0.5x0.5		2	363
920	products/saleor/static/placeholders/t-shirts/5_1L33sC0.jpg	0.5x0.5		3	363
921	products/saleor/static/placeholders/t-shirts/6_pe721sJ.jpg	0.5x0.5		0	364
922	products/saleor/static/placeholders/t-shirts/6_hXvKweq.jpg	0.5x0.5		1	364
923	products/saleor/static/placeholders/t-shirts/5_asFo00K.jpg	0.5x0.5		2	364
924	products/saleor/static/placeholders/t-shirts/5_Pq3XlR9.jpg	0.5x0.5		3	364
925	products/saleor/static/placeholders/t-shirts/6_0UfpCkV.jpg	0.5x0.5		0	365
926	products/saleor/static/placeholders/t-shirts/6_JniP92q.jpg	0.5x0.5		1	365
927	products/saleor/static/placeholders/t-shirts/6_WXy4jeR.jpg	0.5x0.5		0	366
928	products/saleor/static/placeholders/t-shirts/6_UPdZy5W.jpg	0.5x0.5		0	367
929	products/saleor/static/placeholders/t-shirts/6_6iLR2kg.jpg	0.5x0.5		1	367
930	products/saleor/static/placeholders/t-shirts/6_tq5qwOK.jpg	0.5x0.5		0	368
931	products/saleor/static/placeholders/t-shirts/6_W0Lh8TU.jpg	0.5x0.5		1	368
932	products/saleor/static/placeholders/t-shirts/5_Kk3PL0q.jpg	0.5x0.5		0	369
933	products/saleor/static/placeholders/t-shirts/5_rTkg1Be.jpg	0.5x0.5		1	369
934	products/saleor/static/placeholders/t-shirts/6_HPBpYGB.jpg	0.5x0.5		0	370
935	products/saleor/static/placeholders/t-shirts/5_1R65fnW.jpg	0.5x0.5		1	370
936	products/saleor/static/placeholders/t-shirts/6_tYHSm6a.jpg	0.5x0.5		2	370
937	products/saleor/static/placeholders/mugs/box_01_CqAYMLT.jpg	0.5x0.5		0	371
938	products/saleor/static/placeholders/mugs/7_HV527tB.jpg	0.5x0.5		1	371
939	products/saleor/static/placeholders/mugs/4_DT560Xh.jpg	0.5x0.5		2	371
940	products/saleor/static/placeholders/mugs/box_01_A9610op.jpg	0.5x0.5		0	372
941	products/saleor/static/placeholders/mugs/4_Nw0rBtn.jpg	0.5x0.5		1	372
942	products/saleor/static/placeholders/mugs/box_01_wVr8yzl.jpg	0.5x0.5		2	372
943	products/saleor/static/placeholders/mugs/4_sTsqta7.jpg	0.5x0.5		3	372
944	products/saleor/static/placeholders/mugs/7_xoj5Ao1.jpg	0.5x0.5		0	373
945	products/saleor/static/placeholders/mugs/7_xgo52hX.jpg	0.5x0.5		1	373
946	products/saleor/static/placeholders/mugs/7_r9L5dXi.jpg	0.5x0.5		0	374
947	products/saleor/static/placeholders/mugs/7_7gC3wRy.jpg	0.5x0.5		1	374
948	products/saleor/static/placeholders/mugs/box_01_IrH5WK5.jpg	0.5x0.5		2	374
949	products/saleor/static/placeholders/mugs/3_zQaYOwv.jpg	0.5x0.5		3	374
950	products/saleor/static/placeholders/mugs/7_gV3vcWp.jpg	0.5x0.5		0	375
951	products/saleor/static/placeholders/mugs/4_1MTiMOX.jpg	0.5x0.5		1	375
952	products/saleor/static/placeholders/mugs/box_01_uKj416S.jpg	0.5x0.5		0	376
953	products/saleor/static/placeholders/mugs/7_Dvx7emA.jpg	0.5x0.5		1	376
954	products/saleor/static/placeholders/mugs/7_59owKcK.jpg	0.5x0.5		2	376
955	products/saleor/static/placeholders/mugs/4_VwAdsFi.jpg	0.5x0.5		0	377
956	products/saleor/static/placeholders/mugs/7_JP7P4Qi.jpg	0.5x0.5		0	378
957	products/saleor/static/placeholders/mugs/box_01_5bqLVQT.jpg	0.5x0.5		1	378
958	products/saleor/static/placeholders/mugs/box_01_SgYb75P.jpg	0.5x0.5		0	379
959	products/saleor/static/placeholders/mugs/7_sf31tdT.jpg	0.5x0.5		0	380
960	products/saleor/static/placeholders/mugs/3_DM3hHlO.jpg	0.5x0.5		1	380
961	products/saleor/static/placeholders/coffee/coffee_01_bNDJO2x.jpg	0.5x0.5		0	381
962	products/saleor/static/placeholders/coffee/8_f3QpFOd.jpg	0.5x0.5		1	381
963	products/saleor/static/placeholders/coffee/8_p9xMUyX.jpg	0.5x0.5		2	381
964	products/saleor/static/placeholders/coffee/coffee_01_XyyMLm6.jpg	0.5x0.5		3	381
965	products/saleor/static/placeholders/coffee/coffee_03_qNb7YPW.jpg	0.5x0.5		0	382
966	products/saleor/static/placeholders/coffee/coffee_01_WDg2Zro.jpg	0.5x0.5		1	382
967	products/saleor/static/placeholders/coffee/coffee_04_ktadRze.jpg	0.5x0.5		2	382
968	products/saleor/static/placeholders/coffee/8_BsyW0fv.jpg	0.5x0.5		0	383
969	products/saleor/static/placeholders/coffee/coffee_01_eS9N0mL.jpg	0.5x0.5		1	383
970	products/saleor/static/placeholders/coffee/coffee_03_dePaJlS.jpg	0.5x0.5		0	384
971	products/saleor/static/placeholders/coffee/8_Z2Ze6gy.jpg	0.5x0.5		1	384
972	products/saleor/static/placeholders/coffee/coffee_04_obh3m27.jpg	0.5x0.5		2	384
973	products/saleor/static/placeholders/coffee/coffee_01_w1PEvXG.jpg	0.5x0.5		0	385
974	products/saleor/static/placeholders/coffee/8_jmtZcUu.jpg	0.5x0.5		1	385
975	products/saleor/static/placeholders/coffee/8_CCpkzKw.jpg	0.5x0.5		2	385
976	products/saleor/static/placeholders/coffee/coffee_04_IsrKoF0.jpg	0.5x0.5		3	385
977	products/saleor/static/placeholders/coffee/coffee_03_WBcYQoe.jpg	0.5x0.5		0	386
978	products/saleor/static/placeholders/coffee/coffee_04_i6xOQGw.jpg	0.5x0.5		0	387
979	products/saleor/static/placeholders/coffee/coffee_02_W4zWYkC.jpg	0.5x0.5		0	388
980	products/saleor/static/placeholders/coffee/8_BMk5Ud0.jpg	0.5x0.5		1	388
981	products/saleor/static/placeholders/coffee/8_AvpyZxg.jpg	0.5x0.5		0	389
982	products/saleor/static/placeholders/coffee/8_hGwOqtA.jpg	0.5x0.5		0	390
983	products/saleor/static/placeholders/coffee/coffee_03_evf0Bkp.jpg	0.5x0.5		1	390
984	products/saleor/static/placeholders/coffee/coffee_02_ufpWkV7.jpg	0.5x0.5		2	390
985	products/saleor/static/placeholders/coffee/coffee_02_BjS9IrZ.jpg	0.5x0.5		3	390
986	products/saleor/static/placeholders/candy/1_TZg9zMa.jpg	0.5x0.5		0	391
987	products/saleor/static/placeholders/candy/2_5Zmg86V.jpg	0.5x0.5		1	391
988	products/saleor/static/placeholders/candy/1_rA74W1n.jpg	0.5x0.5		0	392
989	products/saleor/static/placeholders/candy/2_JLbvJia.jpg	0.5x0.5		1	392
990	products/saleor/static/placeholders/candy/2_l9VWtXE.jpg	0.5x0.5		2	392
991	products/saleor/static/placeholders/candy/2_Xz01wgb.jpg	0.5x0.5		0	393
992	products/saleor/static/placeholders/candy/2_2suMFWr.jpg	0.5x0.5		1	393
993	products/saleor/static/placeholders/candy/1_feRgF9F.jpg	0.5x0.5		2	393
994	products/saleor/static/placeholders/candy/2_peNyAZn.jpg	0.5x0.5		3	393
995	products/saleor/static/placeholders/candy/2_FQ83jZS.jpg	0.5x0.5		0	394
996	products/saleor/static/placeholders/candy/1_QGzXM4W.jpg	0.5x0.5		1	394
997	products/saleor/static/placeholders/candy/1_URKrMio.jpg	0.5x0.5		2	394
998	products/saleor/static/placeholders/candy/1_mNM3ff2.jpg	0.5x0.5		0	395
999	products/saleor/static/placeholders/candy/2_VEwRL4T.jpg	0.5x0.5		1	395
1000	products/saleor/static/placeholders/candy/2_6YoOW6K.jpg	0.5x0.5		2	395
1001	products/saleor/static/placeholders/candy/1_bT5a0YX.jpg	0.5x0.5		3	395
1002	products/saleor/static/placeholders/candy/2_UPp4p4y.jpg	0.5x0.5		0	396
1003	products/saleor/static/placeholders/candy/2_GOSa8bH.jpg	0.5x0.5		1	396
1004	products/saleor/static/placeholders/candy/2_r3CIpYP.jpg	0.5x0.5		2	396
1005	products/saleor/static/placeholders/candy/1_2JVCyld.jpg	0.5x0.5		0	397
1006	products/saleor/static/placeholders/candy/1_m9Z5rir.jpg	0.5x0.5		1	397
1007	products/saleor/static/placeholders/candy/2_bmfL6wu.jpg	0.5x0.5		2	397
1008	products/saleor/static/placeholders/candy/1_FwuVPe5.jpg	0.5x0.5		3	397
1009	products/saleor/static/placeholders/candy/1_e8geidS.jpg	0.5x0.5		0	398
1010	products/saleor/static/placeholders/candy/1_ETdTun0.jpg	0.5x0.5		0	399
1011	products/saleor/static/placeholders/candy/1_lXOLdFp.jpg	0.5x0.5		1	399
1012	products/saleor/static/placeholders/candy/1_VxNYkAp.jpg	0.5x0.5		2	399
1013	products/saleor/static/placeholders/candy/1_0FPHn5C.jpg	0.5x0.5		0	400
1014	products/saleor/static/placeholders/candy/2_5o0Yvil.jpg	0.5x0.5		1	400
1015	products/saleor/static/placeholders/candy/2_SjW6KzP.jpg	0.5x0.5		2	400
1016	products/saleor/static/placeholders/candy/1_aZFSNRN.jpg	0.5x0.5		3	400
1017	products/saleor/static/placeholders/books/book_02_63HchKu.jpg	0.5x0.5		0	401
1018	products/saleor/static/placeholders/books/book_01_gaXU7Ga.jpg	0.5x0.5		1	401
1019	products/saleor/static/placeholders/books/book_04_vCxhbnO.jpg	0.5x0.5		2	401
1020	products/saleor/static/placeholders/books/book_04_GiM6Q43.jpg	0.5x0.5		0	402
1021	products/saleor/static/placeholders/books/book_04_tkCoA7V.jpg	0.5x0.5		1	402
1022	products/saleor/static/placeholders/books/book_04_I4ZwFCx.jpg	0.5x0.5		2	402
1023	products/saleor/static/placeholders/books/book_02_CuoD8s5.jpg	0.5x0.5		0	403
1024	products/saleor/static/placeholders/books/book_01_1m33l2M.jpg	0.5x0.5		1	403
1025	products/saleor/static/placeholders/books/book_02_dB0rMpl.jpg	0.5x0.5		0	404
1026	products/saleor/static/placeholders/books/book_05_COJaE3y.jpg	0.5x0.5		1	404
1027	products/saleor/static/placeholders/books/book_01_9BMT9Qd.jpg	0.5x0.5		2	404
1028	products/saleor/static/placeholders/books/book_04_pjOB31H.jpg	0.5x0.5		3	404
1029	products/saleor/static/placeholders/books/book_01_bmhn13X.jpg	0.5x0.5		0	405
1030	products/saleor/static/placeholders/books/book_02_9SUGGhI.jpg	0.5x0.5		1	405
1031	products/saleor/static/placeholders/books/book_01_HsTB55e.jpg	0.5x0.5		0	406
1032	products/saleor/static/placeholders/books/book_03_U5Itm0N.jpg	0.5x0.5		1	406
1033	products/saleor/static/placeholders/books/book_02_7Dt64yN.jpg	0.5x0.5		2	406
1034	products/saleor/static/placeholders/books/book_03_aisGTOe.jpg	0.5x0.5		3	406
1035	products/saleor/static/placeholders/books/book_05_dqhbVXZ.jpg	0.5x0.5		0	407
1036	products/saleor/static/placeholders/books/book_01_4NfInc6.jpg	0.5x0.5		1	407
1037	products/saleor/static/placeholders/books/book_01_ijHK0Uv.jpg	0.5x0.5		0	408
1038	products/saleor/static/placeholders/books/book_05_NimZtOL.jpg	0.5x0.5		1	408
1039	products/saleor/static/placeholders/books/book_01_0efDsao.jpg	0.5x0.5		2	408
1040	products/saleor/static/placeholders/books/book_05_VsbLOxG.jpg	0.5x0.5		0	409
1041	products/saleor/static/placeholders/books/book_04_S3n8i6c.jpg	0.5x0.5		1	409
1042	products/saleor/static/placeholders/books/book_05_QC4mbHh.jpg	0.5x0.5		0	410
1043	products/saleor/static/placeholders/books/book_01_5WcTDUS.jpg	0.5x0.5		0	411
1044	products/saleor/static/placeholders/books/book_03_Qgq0hBx.jpg	0.5x0.5		0	412
1045	products/saleor/static/placeholders/books/book_03_5kcsqKe.jpg	0.5x0.5		0	413
1046	products/saleor/static/placeholders/books/book_05_OwmBR7b.jpg	0.5x0.5		1	413
1047	products/saleor/static/placeholders/books/book_04_kDEKgo5.jpg	0.5x0.5		0	414
1048	products/saleor/static/placeholders/books/book_03_zs3jhLJ.jpg	0.5x0.5		0	415
1049	products/saleor/static/placeholders/books/book_01_C8swQGv.jpg	0.5x0.5		1	415
1050	products/saleor/static/placeholders/books/book_01_P8uhavK.jpg	0.5x0.5		0	416
1051	products/saleor/static/placeholders/books/book_05_8V8MfIx.jpg	0.5x0.5		1	416
1052	products/saleor/static/placeholders/books/book_01_m4OFvYc.jpg	0.5x0.5		0	417
1053	products/saleor/static/placeholders/books/book_04_7TzOGWG.jpg	0.5x0.5		1	417
1054	products/saleor/static/placeholders/books/book_04_LXvcD9X.jpg	0.5x0.5		2	417
1055	products/saleor/static/placeholders/books/book_02_qcW1DuR.jpg	0.5x0.5		0	418
1056	products/saleor/static/placeholders/books/book_01_85dGqmW.jpg	0.5x0.5		0	419
1057	products/saleor/static/placeholders/books/book_01_I1VQ2HX.jpg	0.5x0.5		0	420
1058	products/saleor/static/placeholders/books/book_05_bKc7YJe.jpg	0.5x0.5		1	420
1059	products/saleor/static/placeholders/t-shirts/6.jpg	0.5x0.5		0	421
1060	products/saleor/static/placeholders/t-shirts/6_lIQK5Fa.jpg	0.5x0.5		0	422
1061	products/saleor/static/placeholders/t-shirts/6_0T4ubiX.jpg	0.5x0.5		0	423
1062	products/saleor/static/placeholders/t-shirts/5.jpg	0.5x0.5		0	424
1063	products/saleor/static/placeholders/t-shirts/5_N2G2SXO.jpg	0.5x0.5		1	424
1064	products/saleor/static/placeholders/t-shirts/5_X4FoAVH.jpg	0.5x0.5		2	424
1065	products/saleor/static/placeholders/t-shirts/6_IrYO1Jl.jpg	0.5x0.5		3	424
1066	products/saleor/static/placeholders/t-shirts/5_SNXpFv4.jpg	0.5x0.5		0	425
1067	products/saleor/static/placeholders/t-shirts/6_qWYMaDU.jpg	0.5x0.5		1	425
1068	products/saleor/static/placeholders/t-shirts/6_gYMLZYB.jpg	0.5x0.5		2	425
1069	products/saleor/static/placeholders/t-shirts/6_0RrG5qU.jpg	0.5x0.5		3	425
1070	products/saleor/static/placeholders/t-shirts/6_RhzQHqr.jpg	0.5x0.5		0	426
1071	products/saleor/static/placeholders/t-shirts/5_27zpAh6.jpg	0.5x0.5		0	427
1072	products/saleor/static/placeholders/t-shirts/5_TFJYnHr.jpg	0.5x0.5		1	427
1073	products/saleor/static/placeholders/t-shirts/5_JjvRsD3.jpg	0.5x0.5		2	427
1074	products/saleor/static/placeholders/t-shirts/5_pUaAlnJ.jpg	0.5x0.5		0	428
1075	products/saleor/static/placeholders/t-shirts/5_4gQ9vog.jpg	0.5x0.5		1	428
1076	products/saleor/static/placeholders/t-shirts/5_rXcf3GH.jpg	0.5x0.5		2	428
1077	products/saleor/static/placeholders/t-shirts/5_zmC5J3O.jpg	0.5x0.5		3	428
1078	products/saleor/static/placeholders/t-shirts/6_HxEsrBX.jpg	0.5x0.5		0	429
1079	products/saleor/static/placeholders/t-shirts/5_AIvbasE.jpg	0.5x0.5		1	429
1080	products/saleor/static/placeholders/t-shirts/6_E3vmUkj.jpg	0.5x0.5		0	430
1081	products/saleor/static/placeholders/t-shirts/6_O8SbCZ0.jpg	0.5x0.5		1	430
1082	products/saleor/static/placeholders/t-shirts/5_JYNOmLz.jpg	0.5x0.5		2	430
1083	products/saleor/static/placeholders/mugs/7.jpg	0.5x0.5		0	431
1084	products/saleor/static/placeholders/mugs/box_01.jpg	0.5x0.5		1	431
1085	products/saleor/static/placeholders/mugs/3.jpg	0.5x0.5		2	431
1086	products/saleor/static/placeholders/mugs/4.jpg	0.5x0.5		3	431
1087	products/saleor/static/placeholders/mugs/7_Gwjccxi.jpg	0.5x0.5		0	432
1088	products/saleor/static/placeholders/mugs/7_1JgQV0t.jpg	0.5x0.5		1	432
1089	products/saleor/static/placeholders/mugs/4_bkUW5Hd.jpg	0.5x0.5		2	432
1090	products/saleor/static/placeholders/mugs/3_0cuDFoo.jpg	0.5x0.5		0	433
1091	products/saleor/static/placeholders/mugs/4_Axbw3qV.jpg	0.5x0.5		0	434
1092	products/saleor/static/placeholders/mugs/7_ieLIhAo.jpg	0.5x0.5		1	434
1093	products/saleor/static/placeholders/mugs/4_SqDgX5G.jpg	0.5x0.5		2	434
1094	products/saleor/static/placeholders/mugs/box_01_8yzeMXL.jpg	0.5x0.5		3	434
1095	products/saleor/static/placeholders/mugs/4_cDWIUDP.jpg	0.5x0.5		0	435
1096	products/saleor/static/placeholders/mugs/4_W2WfeEw.jpg	0.5x0.5		1	435
1097	products/saleor/static/placeholders/mugs/4_3gXyBsW.jpg	0.5x0.5		2	435
1098	products/saleor/static/placeholders/mugs/4_cSnmnYc.jpg	0.5x0.5		0	436
1099	products/saleor/static/placeholders/mugs/box_01_1CNAjfz.jpg	0.5x0.5		1	436
1100	products/saleor/static/placeholders/mugs/7_r9f9Pzi.jpg	0.5x0.5		2	436
1101	products/saleor/static/placeholders/mugs/box_01_IkvZPh4.jpg	0.5x0.5		0	437
1102	products/saleor/static/placeholders/mugs/4_1dWR8iC.jpg	0.5x0.5		0	438
1103	products/saleor/static/placeholders/mugs/7_28Si4Eh.jpg	0.5x0.5		1	438
1104	products/saleor/static/placeholders/mugs/box_01_ur3Rbki.jpg	0.5x0.5		0	439
1105	products/saleor/static/placeholders/mugs/7_mGhsgXT.jpg	0.5x0.5		1	439
1106	products/saleor/static/placeholders/mugs/3_Wcsels4.jpg	0.5x0.5		0	440
1107	products/saleor/static/placeholders/mugs/box_01_iUd1Vt6.jpg	0.5x0.5		1	440
1108	products/saleor/static/placeholders/mugs/3_YkYMzKR.jpg	0.5x0.5		2	440
1109	products/saleor/static/placeholders/coffee/coffee_04.jpg	0.5x0.5		0	441
1110	products/saleor/static/placeholders/coffee/coffee_04_ZaEDCkb.jpg	0.5x0.5		1	441
1111	products/saleor/static/placeholders/coffee/coffee_01.jpg	0.5x0.5		2	441
1112	products/saleor/static/placeholders/coffee/coffee_04_VK5aVf1.jpg	0.5x0.5		0	442
1113	products/saleor/static/placeholders/coffee/coffee_03.jpg	0.5x0.5		1	442
1114	products/saleor/static/placeholders/coffee/8.jpg	0.5x0.5		2	442
1115	products/saleor/static/placeholders/coffee/coffee_04_GsbP28s.jpg	0.5x0.5		3	442
1116	products/saleor/static/placeholders/coffee/8_8tdtopP.jpg	0.5x0.5		0	443
1117	products/saleor/static/placeholders/coffee/coffee_02.jpg	0.5x0.5		1	443
1118	products/saleor/static/placeholders/coffee/coffee_03_8EcD83P.jpg	0.5x0.5		2	443
1119	products/saleor/static/placeholders/coffee/coffee_02_yi8XINU.jpg	0.5x0.5		3	443
1120	products/saleor/static/placeholders/coffee/coffee_04_a7u6q3R.jpg	0.5x0.5		0	444
1121	products/saleor/static/placeholders/coffee/coffee_01_OCtEEE3.jpg	0.5x0.5		1	444
1122	products/saleor/static/placeholders/coffee/coffee_04_eMgzxZD.jpg	0.5x0.5		2	444
1123	products/saleor/static/placeholders/coffee/coffee_03_bswt2Z8.jpg	0.5x0.5		0	445
1124	products/saleor/static/placeholders/coffee/coffee_02_hJq6CA0.jpg	0.5x0.5		1	445
1125	products/saleor/static/placeholders/coffee/coffee_02_ZA54Q8b.jpg	0.5x0.5		2	445
1126	products/saleor/static/placeholders/coffee/coffee_03_0Ta4pIs.jpg	0.5x0.5		0	446
1127	products/saleor/static/placeholders/coffee/8_M1yuaeo.jpg	0.5x0.5		1	446
1128	products/saleor/static/placeholders/coffee/coffee_02_1mx558S.jpg	0.5x0.5		0	447
1129	products/saleor/static/placeholders/coffee/coffee_04_FlWpG17.jpg	0.5x0.5		1	447
1130	products/saleor/static/placeholders/coffee/coffee_01_fN1VOaN.jpg	0.5x0.5		0	448
1131	products/saleor/static/placeholders/coffee/coffee_02_GFtIggW.jpg	0.5x0.5		1	448
1132	products/saleor/static/placeholders/coffee/coffee_02_rtRnh5d.jpg	0.5x0.5		2	448
1133	products/saleor/static/placeholders/coffee/coffee_03_F6iNguD.jpg	0.5x0.5		3	448
1134	products/saleor/static/placeholders/coffee/8_0WxgTC6.jpg	0.5x0.5		0	449
1135	products/saleor/static/placeholders/coffee/coffee_02_0DJ8OkL.jpg	0.5x0.5		0	450
1136	products/saleor/static/placeholders/coffee/8_vGwYpsr.jpg	0.5x0.5		1	450
1137	products/saleor/static/placeholders/coffee/coffee_04_V1uYfb7.jpg	0.5x0.5		2	450
1138	products/saleor/static/placeholders/candy/1.jpg	0.5x0.5		0	451
1139	products/saleor/static/placeholders/candy/1_QDNwrRQ.jpg	0.5x0.5		1	451
1140	products/saleor/static/placeholders/candy/2.jpg	0.5x0.5		2	451
1141	products/saleor/static/placeholders/candy/2_UuF7zph.jpg	0.5x0.5		0	452
1142	products/saleor/static/placeholders/candy/1_rmZAbYt.jpg	0.5x0.5		0	453
1143	products/saleor/static/placeholders/candy/1_T2VKEqH.jpg	0.5x0.5		1	453
1144	products/saleor/static/placeholders/candy/1_L8QyzKY.jpg	0.5x0.5		0	454
1145	products/saleor/static/placeholders/candy/1_efsALSd.jpg	0.5x0.5		1	454
1146	products/saleor/static/placeholders/candy/1_nbSlFil.jpg	0.5x0.5		2	454
1147	products/saleor/static/placeholders/candy/2_B4h1yWP.jpg	0.5x0.5		0	455
1148	products/saleor/static/placeholders/candy/1_bxVDl1a.jpg	0.5x0.5		1	455
1149	products/saleor/static/placeholders/candy/2_5Gct4dq.jpg	0.5x0.5		2	455
1150	products/saleor/static/placeholders/candy/1_Cat3xrJ.jpg	0.5x0.5		3	455
1151	products/saleor/static/placeholders/candy/1_c2z6Smt.jpg	0.5x0.5		0	456
1152	products/saleor/static/placeholders/candy/2_46N87rD.jpg	0.5x0.5		1	456
1153	products/saleor/static/placeholders/candy/2_ZYzvMRl.jpg	0.5x0.5		0	457
1154	products/saleor/static/placeholders/candy/1_ilk9jJK.jpg	0.5x0.5		1	457
1155	products/saleor/static/placeholders/candy/1_F4McvAt.jpg	0.5x0.5		2	457
1156	products/saleor/static/placeholders/candy/1_xfGgkvj.jpg	0.5x0.5		3	457
1157	products/saleor/static/placeholders/candy/2_4q0StBx.jpg	0.5x0.5		0	458
1158	products/saleor/static/placeholders/candy/2_gVnzhUS.jpg	0.5x0.5		1	458
1159	products/saleor/static/placeholders/candy/1_mTYnyxn.jpg	0.5x0.5		2	458
1160	products/saleor/static/placeholders/candy/2_nU60aWl.jpg	0.5x0.5		0	459
1161	products/saleor/static/placeholders/candy/2_x6UtUmS.jpg	0.5x0.5		1	459
1162	products/saleor/static/placeholders/candy/2_7tG3lPB.jpg	0.5x0.5		2	459
1163	products/saleor/static/placeholders/candy/1_bpDgms4.jpg	0.5x0.5		3	459
1164	products/saleor/static/placeholders/candy/1_O2nJ3HN.jpg	0.5x0.5		0	460
1165	products/saleor/static/placeholders/candy/2_lrIfLlm.jpg	0.5x0.5		1	460
1166	products/saleor/static/placeholders/books/book_02.jpg	0.5x0.5		0	461
1167	products/saleor/static/placeholders/books/book_04.jpg	0.5x0.5		1	461
1168	products/saleor/static/placeholders/books/book_05.jpg	0.5x0.5		2	461
1169	products/saleor/static/placeholders/books/book_04_VsqEjEA.jpg	0.5x0.5		0	462
1170	products/saleor/static/placeholders/books/book_05_sTPMzQl.jpg	0.5x0.5		1	462
1171	products/saleor/static/placeholders/books/book_01.jpg	0.5x0.5		2	462
1172	products/saleor/static/placeholders/books/book_05_ejyvqFR.jpg	0.5x0.5		0	463
1173	products/saleor/static/placeholders/books/book_05_iNNNk69.jpg	0.5x0.5		1	463
1174	products/saleor/static/placeholders/books/book_05_GkOWqKy.jpg	0.5x0.5		2	463
1175	products/saleor/static/placeholders/books/book_04_JzqRhc3.jpg	0.5x0.5		0	464
1176	products/saleor/static/placeholders/books/book_01_njR709v.jpg	0.5x0.5		1	464
1177	products/saleor/static/placeholders/books/book_02_tBmLBoD.jpg	0.5x0.5		2	464
1178	products/saleor/static/placeholders/books/book_05_WNONA4k.jpg	0.5x0.5		0	465
1179	products/saleor/static/placeholders/books/book_05_l9J05nU.jpg	0.5x0.5		1	465
1180	products/saleor/static/placeholders/books/book_02_am7OvP0.jpg	0.5x0.5		0	466
1181	products/saleor/static/placeholders/books/book_05_YaEF4XD.jpg	0.5x0.5		1	466
1182	products/saleor/static/placeholders/books/book_03.jpg	0.5x0.5		2	466
1183	products/saleor/static/placeholders/books/book_02_hqTwFeD.jpg	0.5x0.5		0	467
1184	products/saleor/static/placeholders/books/book_04_DZecmDH.jpg	0.5x0.5		0	468
1185	products/saleor/static/placeholders/books/book_03_3NISLes.jpg	0.5x0.5		0	469
1186	products/saleor/static/placeholders/books/book_04_az0g3y1.jpg	0.5x0.5		1	469
1187	products/saleor/static/placeholders/books/book_01_4kvT0b3.jpg	0.5x0.5		2	469
1188	products/saleor/static/placeholders/books/book_03_HXt9xZM.jpg	0.5x0.5		0	470
1189	products/saleor/static/placeholders/books/book_04_UqocDPa.jpg	0.5x0.5		0	471
1190	products/saleor/static/placeholders/books/book_03_aCTmd16.jpg	0.5x0.5		0	472
1191	products/saleor/static/placeholders/books/book_04_NRt6vmG.jpg	0.5x0.5		1	472
1192	products/saleor/static/placeholders/books/book_02_aWfetQH.jpg	0.5x0.5		2	472
1193	products/saleor/static/placeholders/books/book_01_jSog0vL.jpg	0.5x0.5		3	472
1194	products/saleor/static/placeholders/books/book_03_MiNB9rd.jpg	0.5x0.5		0	473
1195	products/saleor/static/placeholders/books/book_02_BmktzIF.jpg	0.5x0.5		1	473
1196	products/saleor/static/placeholders/books/book_01_QkQ2T9R.jpg	0.5x0.5		2	473
1197	products/saleor/static/placeholders/books/book_04_CgcRUEe.jpg	0.5x0.5		3	473
1198	products/saleor/static/placeholders/books/book_02_gQgezH7.jpg	0.5x0.5		0	474
1199	products/saleor/static/placeholders/books/book_02_0iULlvZ.jpg	0.5x0.5		1	474
1200	products/saleor/static/placeholders/books/book_02_SmkCizi.jpg	0.5x0.5		2	474
1201	products/saleor/static/placeholders/books/book_04_nlA93iS.jpg	0.5x0.5		0	475
1202	products/saleor/static/placeholders/books/book_02_NWrzlaA.jpg	0.5x0.5		1	475
1203	products/saleor/static/placeholders/books/book_05_yuIlkKc.jpg	0.5x0.5		2	475
1204	products/saleor/static/placeholders/books/book_02_YH4UInm.jpg	0.5x0.5		0	476
1205	products/saleor/static/placeholders/books/book_02_EpWWEW7.jpg	0.5x0.5		1	476
1206	products/saleor/static/placeholders/books/book_01_dAja7ST.jpg	0.5x0.5		2	476
1207	products/saleor/static/placeholders/books/book_04_DovYZ4g.jpg	0.5x0.5		3	476
1208	products/saleor/static/placeholders/books/book_03_Ty1r6nz.jpg	0.5x0.5		0	477
1209	products/saleor/static/placeholders/books/book_05_iE6SHTF.jpg	0.5x0.5		1	477
1210	products/saleor/static/placeholders/books/book_04_JjkLM60.jpg	0.5x0.5		2	477
1211	products/saleor/static/placeholders/books/book_05_VWmR6Ri.jpg	0.5x0.5		3	477
1212	products/saleor/static/placeholders/books/book_03_XhxBPmX.jpg	0.5x0.5		0	478
1213	products/saleor/static/placeholders/books/book_03_RkIoc32.jpg	0.5x0.5		1	478
1214	products/saleor/static/placeholders/books/book_05_8Z86zqH.jpg	0.5x0.5		0	479
1215	products/saleor/static/placeholders/books/book_05_ftvYkVc.jpg	0.5x0.5		1	479
1216	products/saleor/static/placeholders/books/book_04_BBgNV8D.jpg	0.5x0.5		2	479
1217	products/saleor/static/placeholders/books/book_05_Ae1oFxh.jpg	0.5x0.5		0	480
1218	products/saleor/static/placeholders/books/book_02_27GoZJ8.jpg	0.5x0.5		1	480
1219	products/saleor/static/placeholders/books/book_01_VNuhmrb.jpg	0.5x0.5		2	480
1220	products/saleor/static/placeholders/books/book_03_yXNxBON.jpg	0.5x0.5		3	480
1221	products/saleor/static/placeholders/t-shirts/5_hjFzUFZ.jpg	0.5x0.5		0	481
1222	products/saleor/static/placeholders/t-shirts/5_tKBDgzz.jpg	0.5x0.5		0	482
1223	products/saleor/static/placeholders/t-shirts/5_xyp38HJ.jpg	0.5x0.5		1	482
1224	products/saleor/static/placeholders/t-shirts/5_jrWyDmW.jpg	0.5x0.5		0	483
1225	products/saleor/static/placeholders/t-shirts/6_e01QqG1.jpg	0.5x0.5		1	483
1226	products/saleor/static/placeholders/t-shirts/6_tvqlFXd.jpg	0.5x0.5		2	483
1227	products/saleor/static/placeholders/t-shirts/6_Cl4nk59.jpg	0.5x0.5		0	484
1228	products/saleor/static/placeholders/t-shirts/5_hXQnmeG.jpg	0.5x0.5		1	484
1229	products/saleor/static/placeholders/t-shirts/5_Bp4z3uN.jpg	0.5x0.5		2	484
1230	products/saleor/static/placeholders/t-shirts/5_hekt6YT.jpg	0.5x0.5		3	484
1231	products/saleor/static/placeholders/t-shirts/6_eI63VzP.jpg	0.5x0.5		0	485
1232	products/saleor/static/placeholders/t-shirts/5_lxKQfqD.jpg	0.5x0.5		1	485
1233	products/saleor/static/placeholders/t-shirts/5_QDSAJ3B.jpg	0.5x0.5		0	486
1234	products/saleor/static/placeholders/t-shirts/6_3kdNclP.jpg	0.5x0.5		0	487
1235	products/saleor/static/placeholders/t-shirts/5_fOdFbzU.jpg	0.5x0.5		1	487
1236	products/saleor/static/placeholders/t-shirts/5_EN48qoM.jpg	0.5x0.5		2	487
1237	products/saleor/static/placeholders/t-shirts/5_OQJeMTm.jpg	0.5x0.5		0	488
1238	products/saleor/static/placeholders/t-shirts/5_XcftcYk.jpg	0.5x0.5		1	488
1239	products/saleor/static/placeholders/t-shirts/5_7Yoy3kX.jpg	0.5x0.5		0	489
1240	products/saleor/static/placeholders/t-shirts/5_ZsvVSzM.jpg	0.5x0.5		1	489
1241	products/saleor/static/placeholders/t-shirts/6_kz82dnV.jpg	0.5x0.5		2	489
1242	products/saleor/static/placeholders/t-shirts/5_1FdG4vT.jpg	0.5x0.5		3	489
1243	products/saleor/static/placeholders/t-shirts/6_VvHB6RF.jpg	0.5x0.5		0	490
1244	products/saleor/static/placeholders/t-shirts/6_oOeEMqO.jpg	0.5x0.5		1	490
1245	products/saleor/static/placeholders/mugs/box_01_1WnzLB0.jpg	0.5x0.5		0	491
1246	products/saleor/static/placeholders/mugs/4_kj7w9Sv.jpg	0.5x0.5		0	492
1247	products/saleor/static/placeholders/mugs/3_YD4xIzv.jpg	0.5x0.5		0	493
1248	products/saleor/static/placeholders/mugs/7_G1bbeqn.jpg	0.5x0.5		1	493
1249	products/saleor/static/placeholders/mugs/3_WeLrBkh.jpg	0.5x0.5		2	493
1250	products/saleor/static/placeholders/mugs/4_EIhPedy.jpg	0.5x0.5		3	493
1251	products/saleor/static/placeholders/mugs/4_FleqEiD.jpg	0.5x0.5		0	494
1252	products/saleor/static/placeholders/mugs/4_fr9g3Rl.jpg	0.5x0.5		0	495
1253	products/saleor/static/placeholders/mugs/3_wZMvbas.jpg	0.5x0.5		0	496
1254	products/saleor/static/placeholders/mugs/7_XRo8RXc.jpg	0.5x0.5		0	497
1255	products/saleor/static/placeholders/mugs/4_6EvoNe6.jpg	0.5x0.5		0	498
1256	products/saleor/static/placeholders/mugs/box_01_49jwLD2.jpg	0.5x0.5		1	498
1257	products/saleor/static/placeholders/mugs/7_pLYWY9S.jpg	0.5x0.5		0	499
1258	products/saleor/static/placeholders/mugs/4_IvlP8u7.jpg	0.5x0.5		1	499
1259	products/saleor/static/placeholders/mugs/4_RNINTVu.jpg	0.5x0.5		2	499
1260	products/saleor/static/placeholders/mugs/7_7YwjPQY.jpg	0.5x0.5		3	499
1261	products/saleor/static/placeholders/mugs/box_01_JRQBCB0.jpg	0.5x0.5		0	500
1262	products/saleor/static/placeholders/mugs/4_1sX7MLP.jpg	0.5x0.5		1	500
1263	products/saleor/static/placeholders/mugs/box_01_5634tSx.jpg	0.5x0.5		2	500
1264	products/saleor/static/placeholders/coffee/coffee_03_bSjv0Ok.jpg	0.5x0.5		0	501
1265	products/saleor/static/placeholders/coffee/coffee_03_HFFkbNi.jpg	0.5x0.5		1	501
1266	products/saleor/static/placeholders/coffee/coffee_02_GrlykWb.jpg	0.5x0.5		2	501
1267	products/saleor/static/placeholders/coffee/coffee_03_7LA8J5n.jpg	0.5x0.5		0	502
1268	products/saleor/static/placeholders/coffee/coffee_01_tHfUAp7.jpg	0.5x0.5		0	503
1269	products/saleor/static/placeholders/coffee/coffee_04_X7PuCtx.jpg	0.5x0.5		1	503
1270	products/saleor/static/placeholders/coffee/coffee_01_Irq7RlZ.jpg	0.5x0.5		0	504
1271	products/saleor/static/placeholders/coffee/coffee_04_5HjNJwP.jpg	0.5x0.5		0	505
1272	products/saleor/static/placeholders/coffee/coffee_01_Bx9aOWX.jpg	0.5x0.5		0	506
1273	products/saleor/static/placeholders/coffee/coffee_04_LECJa6n.jpg	0.5x0.5		1	506
1274	products/saleor/static/placeholders/coffee/coffee_01_2wLl3fh.jpg	0.5x0.5		0	507
1275	products/saleor/static/placeholders/coffee/coffee_04_WsjV8OC.jpg	0.5x0.5		0	508
1276	products/saleor/static/placeholders/coffee/coffee_03_2TNppG6.jpg	0.5x0.5		1	508
1277	products/saleor/static/placeholders/coffee/coffee_04_gbqW5Fc.jpg	0.5x0.5		0	509
1278	products/saleor/static/placeholders/coffee/coffee_02_hMTt0Ps.jpg	0.5x0.5		1	509
1279	products/saleor/static/placeholders/coffee/coffee_03_EBi695g.jpg	0.5x0.5		2	509
1280	products/saleor/static/placeholders/coffee/coffee_01_jvWivWr.jpg	0.5x0.5		3	509
1281	products/saleor/static/placeholders/coffee/coffee_02_eMs5C9n.jpg	0.5x0.5		0	510
1282	products/saleor/static/placeholders/coffee/8_pHZwRA5.jpg	0.5x0.5		1	510
1283	products/saleor/static/placeholders/candy/1_Di8s56r.jpg	0.5x0.5		0	511
1284	products/saleor/static/placeholders/candy/2_mOiF5Mq.jpg	0.5x0.5		1	511
1285	products/saleor/static/placeholders/candy/1_owru08j.jpg	0.5x0.5		2	511
1286	products/saleor/static/placeholders/candy/2_m84S1qF.jpg	0.5x0.5		0	512
1287	products/saleor/static/placeholders/candy/2_PikFWxT.jpg	0.5x0.5		0	513
1288	products/saleor/static/placeholders/candy/2_asPNSuM.jpg	0.5x0.5		1	513
1289	products/saleor/static/placeholders/candy/1_BYMITrd.jpg	0.5x0.5		2	513
1290	products/saleor/static/placeholders/candy/2_uuItugh.jpg	0.5x0.5		0	514
1291	products/saleor/static/placeholders/candy/2_6qseBIO.jpg	0.5x0.5		1	514
1292	products/saleor/static/placeholders/candy/2_cTVLKk4.jpg	0.5x0.5		2	514
1293	products/saleor/static/placeholders/candy/1_abiT5DM.jpg	0.5x0.5		3	514
1294	products/saleor/static/placeholders/candy/1_3M19yJY.jpg	0.5x0.5		0	515
1295	products/saleor/static/placeholders/candy/1_RYnskdi.jpg	0.5x0.5		1	515
1296	products/saleor/static/placeholders/candy/1_TRkSmqc.jpg	0.5x0.5		2	515
1297	products/saleor/static/placeholders/candy/2_EqNTBmi.jpg	0.5x0.5		3	515
1298	products/saleor/static/placeholders/candy/1_qF58A31.jpg	0.5x0.5		0	516
1299	products/saleor/static/placeholders/candy/1_5wP8zbk.jpg	0.5x0.5		1	516
1300	products/saleor/static/placeholders/candy/1_9XLTClx.jpg	0.5x0.5		2	516
1301	products/saleor/static/placeholders/candy/2_S0Sdrnb.jpg	0.5x0.5		3	516
1302	products/saleor/static/placeholders/candy/1_TlXagKT.jpg	0.5x0.5		0	517
1303	products/saleor/static/placeholders/candy/2_QvBX4XW.jpg	0.5x0.5		1	517
1304	products/saleor/static/placeholders/candy/2_qrro4uh.jpg	0.5x0.5		0	518
1305	products/saleor/static/placeholders/candy/2_i0e0ID8.jpg	0.5x0.5		1	518
1306	products/saleor/static/placeholders/candy/1_h6juS0R.jpg	0.5x0.5		2	518
1307	products/saleor/static/placeholders/candy/1_rSWcMGr.jpg	0.5x0.5		3	518
1308	products/saleor/static/placeholders/candy/1_MPinRi6.jpg	0.5x0.5		0	519
1309	products/saleor/static/placeholders/candy/2_64IgZNG.jpg	0.5x0.5		0	520
1310	products/saleor/static/placeholders/books/book_01_qpPRCHq.jpg	0.5x0.5		0	521
1311	products/saleor/static/placeholders/books/book_02_b8xs8dY.jpg	0.5x0.5		1	521
1312	products/saleor/static/placeholders/books/book_01_GqkfYBo.jpg	0.5x0.5		0	522
1313	products/saleor/static/placeholders/books/book_03_w6H3zHB.jpg	0.5x0.5		1	522
1314	products/saleor/static/placeholders/books/book_02_qAheBJz.jpg	0.5x0.5		0	523
1315	products/saleor/static/placeholders/books/book_04_frSA3Ez.jpg	0.5x0.5		0	524
1316	products/saleor/static/placeholders/books/book_05_G6oBWhY.jpg	0.5x0.5		0	525
1317	products/saleor/static/placeholders/books/book_01_OLLFtZh.jpg	0.5x0.5		1	525
1318	products/saleor/static/placeholders/books/book_05_mNZbRmy.jpg	0.5x0.5		2	525
1319	products/saleor/static/placeholders/books/book_02_FCxi9ry.jpg	0.5x0.5		0	526
1320	products/saleor/static/placeholders/books/book_03_GNnE5aN.jpg	0.5x0.5		1	526
1321	products/saleor/static/placeholders/books/book_01_HPDI4s9.jpg	0.5x0.5		2	526
1322	products/saleor/static/placeholders/books/book_02_U06WpRg.jpg	0.5x0.5		3	526
1323	products/saleor/static/placeholders/books/book_03_lBGFpON.jpg	0.5x0.5		0	527
1324	products/saleor/static/placeholders/books/book_01_JaK7WRm.jpg	0.5x0.5		0	528
1325	products/saleor/static/placeholders/books/book_02_e1oV1li.jpg	0.5x0.5		0	529
1326	products/saleor/static/placeholders/books/book_04_CETJfT2.jpg	0.5x0.5		1	529
1327	products/saleor/static/placeholders/books/book_03_vmG4lEa.jpg	0.5x0.5		2	529
1328	products/saleor/static/placeholders/books/book_03_a4n6fDX.jpg	0.5x0.5		3	529
1329	products/saleor/static/placeholders/books/book_04_ZOTMbuD.jpg	0.5x0.5		0	530
1330	products/saleor/static/placeholders/books/book_01_nvbsq0X.jpg	0.5x0.5		1	530
1331	products/saleor/static/placeholders/books/book_02_ZSY3R4x.jpg	0.5x0.5		2	530
1332	products/saleor/static/placeholders/books/book_03_VwpPO6G.jpg	0.5x0.5		3	530
1333	products/saleor/static/placeholders/books/book_03_Lvii5Mr.jpg	0.5x0.5		0	531
1334	products/saleor/static/placeholders/books/book_01_lNDbrr2.jpg	0.5x0.5		0	532
1335	products/saleor/static/placeholders/books/book_04_K9I6JIr.jpg	0.5x0.5		0	533
1336	products/saleor/static/placeholders/books/book_04_za4CV1L.jpg	0.5x0.5		0	534
1337	products/saleor/static/placeholders/books/book_04_TvO3uYC.jpg	0.5x0.5		1	534
1338	products/saleor/static/placeholders/books/book_03_HMr0YlH.jpg	0.5x0.5		0	535
1339	products/saleor/static/placeholders/books/book_01_eaK7YcH.jpg	0.5x0.5		1	535
1340	products/saleor/static/placeholders/books/book_02_wDk0cnc.jpg	0.5x0.5		0	536
1341	products/saleor/static/placeholders/books/book_05_GOT45AZ.jpg	0.5x0.5		1	536
1342	products/saleor/static/placeholders/books/book_01_ubKSgSG.jpg	0.5x0.5		2	536
1343	products/saleor/static/placeholders/books/book_02_7egRyUN.jpg	0.5x0.5		3	536
1344	products/saleor/static/placeholders/books/book_04_BtnqsKC.jpg	0.5x0.5		0	537
1345	products/saleor/static/placeholders/books/book_05_noXJTHK.jpg	0.5x0.5		1	537
1346	products/saleor/static/placeholders/books/book_01_jLdyRT4.jpg	0.5x0.5		2	537
1347	products/saleor/static/placeholders/books/book_02_eHozjQz.jpg	0.5x0.5		3	537
1348	products/saleor/static/placeholders/books/book_03_EJiAETU.jpg	0.5x0.5		0	538
1349	products/saleor/static/placeholders/books/book_05_fn6eGqi.jpg	0.5x0.5		1	538
1350	products/saleor/static/placeholders/books/book_05_qdK4KCd.jpg	0.5x0.5		2	538
1351	products/saleor/static/placeholders/books/book_03_m7pxnN2.jpg	0.5x0.5		0	539
1352	products/saleor/static/placeholders/books/book_05_acYaM8P.jpg	0.5x0.5		1	539
1353	products/saleor/static/placeholders/books/book_04_4V2TlXT.jpg	0.5x0.5		0	540
1354	products/saleor/static/placeholders/books/book_02_eAc4ZVS.jpg	0.5x0.5		1	540
1355	products/saleor/static/placeholders/books/book_05_Jux0JjO.jpg	0.5x0.5		2	540
\.


--
-- Data for Name: product_productvariant; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productvariant (id, sku, name, price_override, product_id, attributes) FROM stdin;
1	1-1337		\N	1	"4"=>"12"
2	1-1338		\N	1	"4"=>"11"
3	1-1339		\N	1	"4"=>"10"
4	1-1340		\N	1	"4"=>"9"
5	1-1341		\N	1	"4"=>"8"
6	1-1342		\N	1	"4"=>"7"
7	2-1337		\N	2	"4"=>"12"
8	2-1338		\N	2	"4"=>"11"
9	2-1339		\N	2	"4"=>"10"
10	2-1340		\N	2	"4"=>"9"
11	2-1341		\N	2	"4"=>"8"
12	2-1342		\N	2	"4"=>"7"
13	3-1337		\N	3	"4"=>"12"
14	3-1338		\N	3	"4"=>"11"
15	3-1339		\N	3	"4"=>"10"
16	3-1340		\N	3	"4"=>"9"
17	3-1341		\N	3	"4"=>"8"
18	3-1342		\N	3	"4"=>"7"
19	4-1337		\N	4	"4"=>"12"
20	4-1338		\N	4	"4"=>"11"
21	4-1339		\N	4	"4"=>"10"
22	4-1340		\N	4	"4"=>"9"
23	4-1341		\N	4	"4"=>"8"
24	4-1342		\N	4	"4"=>"7"
25	5-1337		\N	5	"4"=>"12"
26	5-1338		\N	5	"4"=>"11"
27	5-1339		\N	5	"4"=>"10"
28	5-1340		\N	5	"4"=>"9"
29	5-1341		\N	5	"4"=>"8"
30	5-1342		\N	5	"4"=>"7"
31	6-1337		\N	6	"4"=>"12"
32	6-1338		\N	6	"4"=>"11"
33	6-1339		\N	6	"4"=>"10"
34	6-1340		\N	6	"4"=>"9"
35	6-1341		\N	6	"4"=>"8"
36	6-1342		\N	6	"4"=>"7"
37	7-1337		\N	7	"4"=>"12"
38	7-1338		\N	7	"4"=>"11"
39	7-1339		\N	7	"4"=>"10"
40	7-1340		\N	7	"4"=>"9"
41	7-1341		\N	7	"4"=>"8"
42	7-1342		\N	7	"4"=>"7"
43	8-1337		\N	8	"4"=>"12"
44	8-1338		\N	8	"4"=>"11"
45	8-1339		\N	8	"4"=>"10"
46	8-1340		\N	8	"4"=>"9"
47	8-1341		\N	8	"4"=>"8"
48	8-1342		\N	8	"4"=>"7"
49	9-1337		\N	9	"4"=>"12"
50	9-1338		\N	9	"4"=>"11"
51	9-1339		\N	9	"4"=>"10"
52	9-1340		\N	9	"4"=>"9"
53	9-1341		\N	9	"4"=>"8"
54	9-1342		\N	9	"4"=>"7"
55	10-1337		\N	10	"4"=>"12"
56	10-1338		\N	10	"4"=>"11"
57	10-1339		\N	10	"4"=>"10"
58	10-1340		\N	10	"4"=>"9"
59	10-1341		\N	10	"4"=>"8"
60	10-1342		\N	10	"4"=>"7"
61	11-1337		\N	11	
62	12-1337		\N	12	
63	13-1337		\N	13	
64	14-1337		\N	14	
65	15-1337		\N	15	
66	16-1337		\N	16	
67	17-1337		\N	17	
68	18-1337		\N	18	
69	19-1337		\N	19	
70	20-1337		\N	20	
71	21-1337		72.87	21	"6"=>"18"
72	21-1338		66.71	21	"6"=>"17"
73	21-1339		25.69	21	"6"=>"16"
74	21-1340		21.77	21	"6"=>"15"
75	22-1337		99.16	22	"6"=>"18"
76	22-1338		93.38	22	"6"=>"17"
77	22-1339		37.66	22	"6"=>"16"
78	22-1340		8.01	22	"6"=>"15"
79	23-1337		125.18	23	"6"=>"18"
80	23-1338		109.12	23	"6"=>"17"
81	23-1339		107.62	23	"6"=>"16"
82	23-1340		51.50	23	"6"=>"15"
83	24-1337		146.97	24	"6"=>"18"
84	24-1338		145.26	24	"6"=>"17"
85	24-1339		94.46	24	"6"=>"16"
86	24-1340		53.05	24	"6"=>"15"
87	25-1337		146.59	25	"6"=>"18"
88	25-1338		134.75	25	"6"=>"17"
89	25-1339		117.19	25	"6"=>"16"
90	25-1340		82.41	25	"6"=>"15"
91	26-1337		142.59	26	"6"=>"18"
92	26-1338		132.50	26	"6"=>"17"
93	26-1339		76.49	26	"6"=>"16"
94	26-1340		61.65	26	"6"=>"15"
95	27-1337		75.53	27	"6"=>"18"
96	27-1338		53.65	27	"6"=>"17"
97	27-1339		35.59	27	"6"=>"16"
98	27-1340		26.63	27	"6"=>"15"
99	28-1337		130.32	28	"6"=>"18"
100	28-1338		118.89	28	"6"=>"17"
101	28-1339		99.88	28	"6"=>"16"
102	28-1340		94.69	28	"6"=>"15"
103	29-1337		139.79	29	"6"=>"18"
104	29-1338		83.80	29	"6"=>"17"
105	29-1339		79.26	29	"6"=>"16"
106	29-1340		73.47	29	"6"=>"15"
107	30-1337		143.75	30	"6"=>"18"
108	30-1338		125.73	30	"6"=>"17"
109	30-1339		111.54	30	"6"=>"16"
110	30-1340		56.13	30	"6"=>"15"
111	31-1337		144.79	31	"8"=>"23"
112	31-1338		109.49	31	"8"=>"22"
113	31-1339		84.78	31	"8"=>"21"
114	32-1337		89.48	32	"8"=>"23"
115	32-1338		81.02	32	"8"=>"22"
116	32-1339		72.02	32	"8"=>"21"
117	33-1337		109.33	33	"8"=>"23"
118	33-1338		32.57	33	"8"=>"22"
119	33-1339		25.43	33	"8"=>"21"
120	34-1337		152.64	34	"8"=>"23"
121	34-1338		120.07	34	"8"=>"22"
122	34-1339		100.30	34	"8"=>"21"
123	35-1337		107.00	35	"8"=>"23"
124	35-1338		70.00	35	"8"=>"22"
125	35-1339		48.68	35	"8"=>"21"
126	36-1337		88.13	36	"8"=>"23"
127	36-1338		85.01	36	"8"=>"22"
128	36-1339		58.53	36	"8"=>"21"
129	37-1337		120.65	37	"8"=>"23"
130	37-1338		117.20	37	"8"=>"22"
131	37-1339		114.41	37	"8"=>"21"
132	38-1337		97.90	38	"8"=>"23"
133	38-1338		65.69	38	"8"=>"22"
134	38-1339		25.20	38	"8"=>"21"
135	39-1337		137.53	39	"8"=>"23"
136	39-1338		121.53	39	"8"=>"22"
137	39-1339		97.94	39	"8"=>"21"
138	40-1337		133.16	40	"8"=>"23"
139	40-1338		117.14	40	"8"=>"22"
140	40-1339		107.83	40	"8"=>"21"
141	41-1337		\N	41	
142	42-1337		\N	42	
143	43-1337		\N	43	
144	44-1337		\N	44	
145	45-1337		\N	45	
146	46-1337		\N	46	
147	47-1337		\N	47	
148	48-1337		\N	48	
149	49-1337		\N	49	
150	50-1337		\N	50	
151	51-1337		85.64	51	"12"=>"31"
152	51-1338		45.63	51	"12"=>"30"
153	52-1337		126.93	52	"12"=>"31"
154	52-1338		101.81	52	"12"=>"30"
155	53-1337		134.67	53	"12"=>"31"
156	53-1338		118.46	53	"12"=>"30"
157	54-1337		72.02	54	"12"=>"31"
158	54-1338		63.76	54	"12"=>"30"
159	55-1337		41.22	55	"12"=>"31"
160	55-1338		21.95	55	"12"=>"30"
161	56-1337		110.37	56	"12"=>"31"
162	56-1338		38.55	56	"12"=>"30"
163	57-1337		155.67	57	"12"=>"31"
164	57-1338		134.80	57	"12"=>"30"
165	58-1337		131.40	58	"12"=>"31"
166	58-1338		89.45	58	"12"=>"30"
167	59-1337		89.63	59	"12"=>"31"
168	59-1338		75.40	59	"12"=>"30"
169	60-1337		171.04	60	"12"=>"31"
170	60-1338		136.16	60	"12"=>"30"
171	61-1337		\N	61	"4"=>"12"
172	61-1338		\N	61	"4"=>"11"
173	61-1339		\N	61	"4"=>"10"
174	61-1340		\N	61	"4"=>"9"
175	61-1341		\N	61	"4"=>"8"
176	61-1342		\N	61	"4"=>"7"
177	62-1337		\N	62	"4"=>"12"
178	62-1338		\N	62	"4"=>"11"
179	62-1339		\N	62	"4"=>"10"
180	62-1340		\N	62	"4"=>"9"
181	62-1341		\N	62	"4"=>"8"
182	62-1342		\N	62	"4"=>"7"
183	63-1337		\N	63	"4"=>"12"
184	63-1338		\N	63	"4"=>"11"
185	63-1339		\N	63	"4"=>"10"
186	63-1340		\N	63	"4"=>"9"
187	63-1341		\N	63	"4"=>"8"
188	63-1342		\N	63	"4"=>"7"
189	64-1337		\N	64	"4"=>"12"
190	64-1338		\N	64	"4"=>"11"
191	64-1339		\N	64	"4"=>"10"
192	64-1340		\N	64	"4"=>"9"
193	64-1341		\N	64	"4"=>"8"
194	64-1342		\N	64	"4"=>"7"
195	65-1337		\N	65	"4"=>"12"
196	65-1338		\N	65	"4"=>"11"
197	65-1339		\N	65	"4"=>"10"
198	65-1340		\N	65	"4"=>"9"
199	65-1341		\N	65	"4"=>"8"
200	65-1342		\N	65	"4"=>"7"
201	66-1337		\N	66	"4"=>"12"
202	66-1338		\N	66	"4"=>"11"
203	66-1339		\N	66	"4"=>"10"
204	66-1340		\N	66	"4"=>"9"
205	66-1341		\N	66	"4"=>"8"
206	66-1342		\N	66	"4"=>"7"
207	67-1337		\N	67	"4"=>"12"
208	67-1338		\N	67	"4"=>"11"
209	67-1339		\N	67	"4"=>"10"
210	67-1340		\N	67	"4"=>"9"
211	67-1341		\N	67	"4"=>"8"
212	67-1342		\N	67	"4"=>"7"
213	68-1337		\N	68	"4"=>"12"
214	68-1338		\N	68	"4"=>"11"
215	68-1339		\N	68	"4"=>"10"
216	68-1340		\N	68	"4"=>"9"
217	68-1341		\N	68	"4"=>"8"
218	68-1342		\N	68	"4"=>"7"
219	69-1337		\N	69	"4"=>"12"
220	69-1338		\N	69	"4"=>"11"
221	69-1339		\N	69	"4"=>"10"
222	69-1340		\N	69	"4"=>"9"
223	69-1341		\N	69	"4"=>"8"
224	69-1342		\N	69	"4"=>"7"
225	70-1337		\N	70	"4"=>"12"
226	70-1338		\N	70	"4"=>"11"
227	70-1339		\N	70	"4"=>"10"
228	70-1340		\N	70	"4"=>"9"
229	70-1341		\N	70	"4"=>"8"
230	70-1342		\N	70	"4"=>"7"
231	71-1337		\N	71	
232	72-1337		\N	72	
233	73-1337		\N	73	
234	74-1337		\N	74	
235	75-1337		\N	75	
236	76-1337		\N	76	
237	77-1337		\N	77	
238	78-1337		\N	78	
239	79-1337		\N	79	
240	80-1337		\N	80	
241	81-1337		94.83	81	"6"=>"18"
242	81-1338		94.56	81	"6"=>"17"
243	81-1339		81.28	81	"6"=>"16"
244	81-1340		62.05	81	"6"=>"15"
245	82-1337		78.62	82	"6"=>"18"
246	82-1338		35.76	82	"6"=>"17"
247	82-1339		26.39	82	"6"=>"16"
248	82-1340		16.10	82	"6"=>"15"
249	83-1337		196.26	83	"6"=>"18"
250	83-1338		191.33	83	"6"=>"17"
251	83-1339		189.98	83	"6"=>"16"
252	83-1340		184.49	83	"6"=>"15"
253	84-1337		168.50	84	"6"=>"18"
254	84-1338		141.82	84	"6"=>"17"
255	84-1339		116.27	84	"6"=>"16"
256	84-1340		92.81	84	"6"=>"15"
257	85-1337		153.78	85	"6"=>"18"
258	85-1338		132.02	85	"6"=>"17"
259	85-1339		125.15	85	"6"=>"16"
260	85-1340		109.88	85	"6"=>"15"
261	86-1337		110.01	86	"6"=>"18"
262	86-1338		83.32	86	"6"=>"17"
263	86-1339		48.06	86	"6"=>"16"
264	86-1340		31.20	86	"6"=>"15"
265	87-1337		126.97	87	"6"=>"18"
266	87-1338		119.48	87	"6"=>"17"
267	87-1339		118.18	87	"6"=>"16"
268	87-1340		87.39	87	"6"=>"15"
269	88-1337		106.58	88	"6"=>"18"
270	88-1338		71.57	88	"6"=>"17"
271	88-1339		58.26	88	"6"=>"16"
272	88-1340		23.45	88	"6"=>"15"
273	89-1337		171.22	89	"6"=>"18"
274	89-1338		133.66	89	"6"=>"17"
275	89-1339		100.01	89	"6"=>"16"
276	89-1340		82.04	89	"6"=>"15"
277	90-1337		118.45	90	"6"=>"18"
278	90-1338		116.08	90	"6"=>"17"
279	90-1339		99.66	90	"6"=>"16"
280	90-1340		94.03	90	"6"=>"15"
281	91-1337		128.70	91	"8"=>"23"
282	91-1338		93.70	91	"8"=>"22"
283	91-1339		79.20	91	"8"=>"21"
284	92-1337		107.87	92	"8"=>"23"
285	92-1338		104.35	92	"8"=>"22"
286	92-1339		81.81	92	"8"=>"21"
287	93-1337		104.61	93	"8"=>"23"
288	93-1338		99.11	93	"8"=>"22"
289	93-1339		34.85	93	"8"=>"21"
290	94-1337		112.60	94	"8"=>"23"
291	94-1338		79.81	94	"8"=>"22"
292	94-1339		36.63	94	"8"=>"21"
293	95-1337		149.34	95	"8"=>"23"
294	95-1338		120.99	95	"8"=>"22"
295	95-1339		65.86	95	"8"=>"21"
296	96-1337		190.32	96	"8"=>"23"
297	96-1338		115.99	96	"8"=>"22"
298	96-1339		109.76	96	"8"=>"21"
299	97-1337		189.37	97	"8"=>"23"
300	97-1338		106.81	97	"8"=>"22"
301	97-1339		106.03	97	"8"=>"21"
302	98-1337		116.13	98	"8"=>"23"
303	98-1338		109.42	98	"8"=>"22"
304	98-1339		98.96	98	"8"=>"21"
305	99-1337		126.76	99	"8"=>"23"
306	99-1338		122.17	99	"8"=>"22"
307	99-1339		102.72	99	"8"=>"21"
308	100-1337		63.41	100	"8"=>"23"
309	100-1338		48.87	100	"8"=>"22"
310	100-1339		38.94	100	"8"=>"21"
311	101-1337		\N	101	
312	102-1337		\N	102	
313	103-1337		\N	103	
314	104-1337		\N	104	
315	105-1337		\N	105	
316	106-1337		\N	106	
317	107-1337		\N	107	
318	108-1337		\N	108	
319	109-1337		\N	109	
320	110-1337		\N	110	
321	111-1337		108.29	111	"12"=>"31"
322	111-1338		94.39	111	"12"=>"30"
323	112-1337		155.40	112	"12"=>"31"
324	112-1338		98.09	112	"12"=>"30"
325	113-1337		106.82	113	"12"=>"31"
326	113-1338		81.83	113	"12"=>"30"
327	114-1337		104.98	114	"12"=>"31"
328	114-1338		95.59	114	"12"=>"30"
329	115-1337		102.72	115	"12"=>"31"
330	115-1338		39.99	115	"12"=>"30"
331	116-1337		132.72	116	"12"=>"31"
332	116-1338		116.30	116	"12"=>"30"
333	117-1337		75.56	117	"12"=>"31"
334	117-1338		63.39	117	"12"=>"30"
335	118-1337		92.73	118	"12"=>"31"
336	118-1338		63.38	118	"12"=>"30"
337	119-1337		183.05	119	"12"=>"31"
338	119-1338		142.61	119	"12"=>"30"
339	120-1337		40.99	120	"12"=>"31"
340	120-1338		26.99	120	"12"=>"30"
341	121-1337		\N	121	"4"=>"12"
342	121-1338		\N	121	"4"=>"11"
343	121-1339		\N	121	"4"=>"10"
344	121-1340		\N	121	"4"=>"9"
345	121-1341		\N	121	"4"=>"8"
346	121-1342		\N	121	"4"=>"7"
347	122-1337		\N	122	"4"=>"12"
348	122-1338		\N	122	"4"=>"11"
349	122-1339		\N	122	"4"=>"10"
350	122-1340		\N	122	"4"=>"9"
351	122-1341		\N	122	"4"=>"8"
352	122-1342		\N	122	"4"=>"7"
353	123-1337		\N	123	"4"=>"12"
354	123-1338		\N	123	"4"=>"11"
355	123-1339		\N	123	"4"=>"10"
356	123-1340		\N	123	"4"=>"9"
357	123-1341		\N	123	"4"=>"8"
358	123-1342		\N	123	"4"=>"7"
359	124-1337		\N	124	"4"=>"12"
360	124-1338		\N	124	"4"=>"11"
361	124-1339		\N	124	"4"=>"10"
362	124-1340		\N	124	"4"=>"9"
363	124-1341		\N	124	"4"=>"8"
364	124-1342		\N	124	"4"=>"7"
365	125-1337		\N	125	"4"=>"12"
366	125-1338		\N	125	"4"=>"11"
367	125-1339		\N	125	"4"=>"10"
368	125-1340		\N	125	"4"=>"9"
369	125-1341		\N	125	"4"=>"8"
370	125-1342		\N	125	"4"=>"7"
371	126-1337		\N	126	"4"=>"12"
372	126-1338		\N	126	"4"=>"11"
373	126-1339		\N	126	"4"=>"10"
374	126-1340		\N	126	"4"=>"9"
375	126-1341		\N	126	"4"=>"8"
376	126-1342		\N	126	"4"=>"7"
377	127-1337		\N	127	"4"=>"12"
378	127-1338		\N	127	"4"=>"11"
379	127-1339		\N	127	"4"=>"10"
380	127-1340		\N	127	"4"=>"9"
381	127-1341		\N	127	"4"=>"8"
382	127-1342		\N	127	"4"=>"7"
383	128-1337		\N	128	"4"=>"12"
384	128-1338		\N	128	"4"=>"11"
385	128-1339		\N	128	"4"=>"10"
386	128-1340		\N	128	"4"=>"9"
387	128-1341		\N	128	"4"=>"8"
388	128-1342		\N	128	"4"=>"7"
389	129-1337		\N	129	"4"=>"12"
390	129-1338		\N	129	"4"=>"11"
391	129-1339		\N	129	"4"=>"10"
392	129-1340		\N	129	"4"=>"9"
393	129-1341		\N	129	"4"=>"8"
394	129-1342		\N	129	"4"=>"7"
395	130-1337		\N	130	"4"=>"12"
396	130-1338		\N	130	"4"=>"11"
397	130-1339		\N	130	"4"=>"10"
398	130-1340		\N	130	"4"=>"9"
399	130-1341		\N	130	"4"=>"8"
400	130-1342		\N	130	"4"=>"7"
401	131-1337		\N	131	
402	132-1337		\N	132	
403	133-1337		\N	133	
404	134-1337		\N	134	
405	135-1337		\N	135	
406	136-1337		\N	136	
407	137-1337		\N	137	
408	138-1337		\N	138	
409	139-1337		\N	139	
410	140-1337		\N	140	
411	141-1337		136.89	141	"6"=>"18"
412	141-1338		123.24	141	"6"=>"17"
413	141-1339		80.61	141	"6"=>"16"
414	141-1340		59.55	141	"6"=>"15"
415	142-1337		92.82	142	"6"=>"18"
416	142-1338		73.63	142	"6"=>"17"
417	142-1339		68.38	142	"6"=>"16"
418	142-1340		35.09	142	"6"=>"15"
419	143-1337		124.48	143	"6"=>"18"
420	143-1338		94.47	143	"6"=>"17"
421	143-1339		83.99	143	"6"=>"16"
422	143-1340		63.88	143	"6"=>"15"
423	144-1337		64.92	144	"6"=>"18"
424	144-1338		38.07	144	"6"=>"17"
425	144-1339		33.29	144	"6"=>"16"
426	144-1340		15.60	144	"6"=>"15"
427	145-1337		90.38	145	"6"=>"18"
428	145-1338		88.31	145	"6"=>"17"
429	145-1339		79.80	145	"6"=>"16"
430	145-1340		53.28	145	"6"=>"15"
431	146-1337		165.66	146	"6"=>"18"
432	146-1338		151.64	146	"6"=>"17"
1253	433-1337		\N	433	
433	146-1339		142.17	146	"6"=>"16"
434	146-1340		120.74	146	"6"=>"15"
435	147-1337		159.18	147	"6"=>"18"
436	147-1338		107.27	147	"6"=>"17"
437	147-1339		100.86	147	"6"=>"16"
438	147-1340		91.52	147	"6"=>"15"
439	148-1337		165.24	148	"6"=>"18"
440	148-1338		151.44	148	"6"=>"17"
441	148-1339		88.94	148	"6"=>"16"
442	148-1340		73.93	148	"6"=>"15"
443	149-1337		123.72	149	"6"=>"18"
444	149-1338		118.42	149	"6"=>"17"
445	149-1339		109.57	149	"6"=>"16"
446	149-1340		34.66	149	"6"=>"15"
447	150-1337		151.45	150	"6"=>"18"
448	150-1338		134.15	150	"6"=>"17"
449	150-1339		108.59	150	"6"=>"16"
450	150-1340		98.82	150	"6"=>"15"
451	151-1337		149.11	151	"8"=>"23"
452	151-1338		133.77	151	"8"=>"22"
453	151-1339		95.05	151	"8"=>"21"
454	152-1337		134.07	152	"8"=>"23"
455	152-1338		133.37	152	"8"=>"22"
456	152-1339		103.69	152	"8"=>"21"
457	153-1337		121.28	153	"8"=>"23"
458	153-1338		103.76	153	"8"=>"22"
459	153-1339		100.39	153	"8"=>"21"
460	154-1337		64.70	154	"8"=>"23"
461	154-1338		56.61	154	"8"=>"22"
462	154-1339		34.22	154	"8"=>"21"
463	155-1337		83.96	155	"8"=>"23"
464	155-1338		65.19	155	"8"=>"22"
465	155-1339		45.95	155	"8"=>"21"
466	156-1337		116.95	156	"8"=>"23"
467	156-1338		115.52	156	"8"=>"22"
468	156-1339		106.48	156	"8"=>"21"
469	157-1337		103.99	157	"8"=>"23"
470	157-1338		44.93	157	"8"=>"22"
471	157-1339		41.11	157	"8"=>"21"
472	158-1337		69.00	158	"8"=>"23"
473	158-1338		55.64	158	"8"=>"22"
474	158-1339		51.47	158	"8"=>"21"
475	159-1337		67.87	159	"8"=>"23"
476	159-1338		34.46	159	"8"=>"22"
477	159-1339		22.75	159	"8"=>"21"
478	160-1337		168.42	160	"8"=>"23"
479	160-1338		167.87	160	"8"=>"22"
480	160-1339		153.56	160	"8"=>"21"
481	161-1337		\N	161	
482	162-1337		\N	162	
483	163-1337		\N	163	
484	164-1337		\N	164	
485	165-1337		\N	165	
486	166-1337		\N	166	
487	167-1337		\N	167	
488	168-1337		\N	168	
489	169-1337		\N	169	
490	170-1337		\N	170	
491	171-1337		138.03	171	"12"=>"31"
492	171-1338		80.83	171	"12"=>"30"
493	172-1337		117.63	172	"12"=>"31"
494	172-1338		107.55	172	"12"=>"30"
495	173-1337		128.63	173	"12"=>"31"
496	173-1338		70.03	173	"12"=>"30"
497	174-1337		61.95	174	"12"=>"31"
498	174-1338		56.95	174	"12"=>"30"
499	175-1337		122.36	175	"12"=>"31"
500	175-1338		88.79	175	"12"=>"30"
501	176-1337		85.54	176	"12"=>"31"
502	176-1338		81.72	176	"12"=>"30"
503	177-1337		122.52	177	"12"=>"31"
504	177-1338		100.25	177	"12"=>"30"
505	178-1337		141.64	178	"12"=>"31"
506	178-1338		84.10	178	"12"=>"30"
507	179-1337		55.87	179	"12"=>"31"
508	179-1338		30.76	179	"12"=>"30"
509	180-1337		83.42	180	"12"=>"31"
510	180-1338		79.48	180	"12"=>"30"
511	181-1337		\N	181	"4"=>"12"
512	181-1338		\N	181	"4"=>"11"
513	181-1339		\N	181	"4"=>"10"
514	181-1340		\N	181	"4"=>"9"
515	181-1341		\N	181	"4"=>"8"
516	181-1342		\N	181	"4"=>"7"
517	182-1337		\N	182	"4"=>"12"
518	182-1338		\N	182	"4"=>"11"
519	182-1339		\N	182	"4"=>"10"
520	182-1340		\N	182	"4"=>"9"
521	182-1341		\N	182	"4"=>"8"
522	182-1342		\N	182	"4"=>"7"
523	183-1337		\N	183	"4"=>"12"
524	183-1338		\N	183	"4"=>"11"
525	183-1339		\N	183	"4"=>"10"
526	183-1340		\N	183	"4"=>"9"
527	183-1341		\N	183	"4"=>"8"
528	183-1342		\N	183	"4"=>"7"
529	184-1337		\N	184	"4"=>"12"
530	184-1338		\N	184	"4"=>"11"
531	184-1339		\N	184	"4"=>"10"
532	184-1340		\N	184	"4"=>"9"
533	184-1341		\N	184	"4"=>"8"
534	184-1342		\N	184	"4"=>"7"
535	185-1337		\N	185	"4"=>"12"
536	185-1338		\N	185	"4"=>"11"
537	185-1339		\N	185	"4"=>"10"
538	185-1340		\N	185	"4"=>"9"
539	185-1341		\N	185	"4"=>"8"
540	185-1342		\N	185	"4"=>"7"
541	186-1337		\N	186	"4"=>"12"
542	186-1338		\N	186	"4"=>"11"
543	186-1339		\N	186	"4"=>"10"
544	186-1340		\N	186	"4"=>"9"
545	186-1341		\N	186	"4"=>"8"
546	186-1342		\N	186	"4"=>"7"
547	187-1337		\N	187	"4"=>"12"
548	187-1338		\N	187	"4"=>"11"
549	187-1339		\N	187	"4"=>"10"
550	187-1340		\N	187	"4"=>"9"
551	187-1341		\N	187	"4"=>"8"
552	187-1342		\N	187	"4"=>"7"
553	188-1337		\N	188	"4"=>"12"
554	188-1338		\N	188	"4"=>"11"
555	188-1339		\N	188	"4"=>"10"
556	188-1340		\N	188	"4"=>"9"
557	188-1341		\N	188	"4"=>"8"
558	188-1342		\N	188	"4"=>"7"
559	189-1337		\N	189	"4"=>"12"
560	189-1338		\N	189	"4"=>"11"
561	189-1339		\N	189	"4"=>"10"
562	189-1340		\N	189	"4"=>"9"
563	189-1341		\N	189	"4"=>"8"
564	189-1342		\N	189	"4"=>"7"
565	190-1337		\N	190	"4"=>"12"
566	190-1338		\N	190	"4"=>"11"
567	190-1339		\N	190	"4"=>"10"
568	190-1340		\N	190	"4"=>"9"
569	190-1341		\N	190	"4"=>"8"
570	190-1342		\N	190	"4"=>"7"
571	191-1337		\N	191	
572	192-1337		\N	192	
573	193-1337		\N	193	
574	194-1337		\N	194	
575	195-1337		\N	195	
576	196-1337		\N	196	
577	197-1337		\N	197	
578	198-1337		\N	198	
579	199-1337		\N	199	
580	200-1337		\N	200	
581	201-1337		112.39	201	"6"=>"18"
582	201-1338		104.47	201	"6"=>"17"
583	201-1339		89.91	201	"6"=>"16"
584	201-1340		83.58	201	"6"=>"15"
585	202-1337		165.43	202	"6"=>"18"
586	202-1338		159.89	202	"6"=>"17"
587	202-1339		157.32	202	"6"=>"16"
588	202-1340		92.42	202	"6"=>"15"
589	203-1337		134.67	203	"6"=>"18"
590	203-1338		108.99	203	"6"=>"17"
591	203-1339		107.00	203	"6"=>"16"
592	203-1340		41.01	203	"6"=>"15"
593	204-1337		137.85	204	"6"=>"18"
594	204-1338		105.56	204	"6"=>"17"
595	204-1339		80.52	204	"6"=>"16"
596	204-1340		76.04	204	"6"=>"15"
597	205-1337		131.89	205	"6"=>"18"
598	205-1338		123.93	205	"6"=>"17"
599	205-1339		107.86	205	"6"=>"16"
600	205-1340		86.05	205	"6"=>"15"
601	206-1337		145.38	206	"6"=>"18"
602	206-1338		130.81	206	"6"=>"17"
603	206-1339		88.87	206	"6"=>"16"
604	206-1340		62.99	206	"6"=>"15"
605	207-1337		137.26	207	"6"=>"18"
606	207-1338		92.03	207	"6"=>"17"
607	207-1339		88.87	207	"6"=>"16"
608	207-1340		66.30	207	"6"=>"15"
609	208-1337		191.14	208	"6"=>"18"
610	208-1338		157.58	208	"6"=>"17"
611	208-1339		150.94	208	"6"=>"16"
612	208-1340		100.25	208	"6"=>"15"
613	209-1337		173.87	209	"6"=>"18"
614	209-1338		171.52	209	"6"=>"17"
615	209-1339		158.95	209	"6"=>"16"
616	209-1340		144.18	209	"6"=>"15"
617	210-1337		110.45	210	"6"=>"18"
618	210-1338		100.06	210	"6"=>"17"
619	210-1339		23.43	210	"6"=>"16"
620	210-1340		17.16	210	"6"=>"15"
621	211-1337		111.59	211	"8"=>"23"
622	211-1338		69.31	211	"8"=>"22"
623	211-1339		61.46	211	"8"=>"21"
624	212-1337		147.59	212	"8"=>"23"
625	212-1338		114.29	212	"8"=>"22"
626	212-1339		103.18	212	"8"=>"21"
627	213-1337		131.11	213	"8"=>"23"
628	213-1338		128.60	213	"8"=>"22"
629	213-1339		120.18	213	"8"=>"21"
630	214-1337		78.37	214	"8"=>"23"
631	214-1338		44.02	214	"8"=>"22"
632	214-1339		31.45	214	"8"=>"21"
633	215-1337		140.59	215	"8"=>"23"
634	215-1338		79.23	215	"8"=>"22"
635	215-1339		68.73	215	"8"=>"21"
636	216-1337		112.80	216	"8"=>"23"
637	216-1338		97.17	216	"8"=>"22"
638	216-1339		30.96	216	"8"=>"21"
639	217-1337		178.43	217	"8"=>"23"
640	217-1338		100.28	217	"8"=>"22"
641	217-1339		99.13	217	"8"=>"21"
642	218-1337		50.42	218	"8"=>"23"
643	218-1338		36.23	218	"8"=>"22"
644	218-1339		8.91	218	"8"=>"21"
645	219-1337		128.03	219	"8"=>"23"
646	219-1338		110.26	219	"8"=>"22"
647	219-1339		105.11	219	"8"=>"21"
648	220-1337		123.36	220	"8"=>"23"
649	220-1338		113.71	220	"8"=>"22"
650	220-1339		71.06	220	"8"=>"21"
651	221-1337		\N	221	
652	222-1337		\N	222	
653	223-1337		\N	223	
654	224-1337		\N	224	
655	225-1337		\N	225	
656	226-1337		\N	226	
657	227-1337		\N	227	
658	228-1337		\N	228	
659	229-1337		\N	229	
660	230-1337		\N	230	
661	231-1337		123.07	231	"12"=>"31"
662	231-1338		111.78	231	"12"=>"30"
663	232-1337		144.86	232	"12"=>"31"
664	232-1338		139.33	232	"12"=>"30"
665	233-1337		87.08	233	"12"=>"31"
666	233-1338		41.77	233	"12"=>"30"
667	234-1337		103.57	234	"12"=>"31"
668	234-1338		85.58	234	"12"=>"30"
669	235-1337		143.31	235	"12"=>"31"
670	235-1338		90.25	235	"12"=>"30"
671	236-1337		28.86	236	"12"=>"31"
672	236-1338		20.19	236	"12"=>"30"
673	237-1337		183.36	237	"12"=>"31"
674	237-1338		103.66	237	"12"=>"30"
675	238-1337		106.16	238	"12"=>"31"
676	238-1338		74.37	238	"12"=>"30"
677	239-1337		90.00	239	"12"=>"31"
678	239-1338		84.16	239	"12"=>"30"
679	240-1337		171.56	240	"12"=>"31"
680	240-1338		87.25	240	"12"=>"30"
681	241-1337		\N	241	"4"=>"12"
682	241-1338		\N	241	"4"=>"11"
683	241-1339		\N	241	"4"=>"10"
684	241-1340		\N	241	"4"=>"9"
685	241-1341		\N	241	"4"=>"8"
686	241-1342		\N	241	"4"=>"7"
687	242-1337		\N	242	"4"=>"12"
688	242-1338		\N	242	"4"=>"11"
689	242-1339		\N	242	"4"=>"10"
690	242-1340		\N	242	"4"=>"9"
691	242-1341		\N	242	"4"=>"8"
692	242-1342		\N	242	"4"=>"7"
693	243-1337		\N	243	"4"=>"12"
694	243-1338		\N	243	"4"=>"11"
695	243-1339		\N	243	"4"=>"10"
696	243-1340		\N	243	"4"=>"9"
697	243-1341		\N	243	"4"=>"8"
698	243-1342		\N	243	"4"=>"7"
699	244-1337		\N	244	"4"=>"12"
700	244-1338		\N	244	"4"=>"11"
701	244-1339		\N	244	"4"=>"10"
702	244-1340		\N	244	"4"=>"9"
703	244-1341		\N	244	"4"=>"8"
704	244-1342		\N	244	"4"=>"7"
705	245-1337		\N	245	"4"=>"12"
706	245-1338		\N	245	"4"=>"11"
707	245-1339		\N	245	"4"=>"10"
708	245-1340		\N	245	"4"=>"9"
709	245-1341		\N	245	"4"=>"8"
710	245-1342		\N	245	"4"=>"7"
711	246-1337		\N	246	"4"=>"12"
712	246-1338		\N	246	"4"=>"11"
713	246-1339		\N	246	"4"=>"10"
714	246-1340		\N	246	"4"=>"9"
715	246-1341		\N	246	"4"=>"8"
716	246-1342		\N	246	"4"=>"7"
717	247-1337		\N	247	"4"=>"12"
718	247-1338		\N	247	"4"=>"11"
719	247-1339		\N	247	"4"=>"10"
720	247-1340		\N	247	"4"=>"9"
721	247-1341		\N	247	"4"=>"8"
722	247-1342		\N	247	"4"=>"7"
723	248-1337		\N	248	"4"=>"12"
724	248-1338		\N	248	"4"=>"11"
725	248-1339		\N	248	"4"=>"10"
726	248-1340		\N	248	"4"=>"9"
727	248-1341		\N	248	"4"=>"8"
728	248-1342		\N	248	"4"=>"7"
729	249-1337		\N	249	"4"=>"12"
730	249-1338		\N	249	"4"=>"11"
731	249-1339		\N	249	"4"=>"10"
732	249-1340		\N	249	"4"=>"9"
733	249-1341		\N	249	"4"=>"8"
734	249-1342		\N	249	"4"=>"7"
735	250-1337		\N	250	"4"=>"12"
736	250-1338		\N	250	"4"=>"11"
737	250-1339		\N	250	"4"=>"10"
738	250-1340		\N	250	"4"=>"9"
739	250-1341		\N	250	"4"=>"8"
740	250-1342		\N	250	"4"=>"7"
741	251-1337		\N	251	
742	252-1337		\N	252	
743	253-1337		\N	253	
744	254-1337		\N	254	
745	255-1337		\N	255	
746	256-1337		\N	256	
747	257-1337		\N	257	
748	258-1337		\N	258	
749	259-1337		\N	259	
750	260-1337		\N	260	
751	261-1337		103.94	261	"6"=>"18"
752	261-1338		75.91	261	"6"=>"17"
753	261-1339		69.64	261	"6"=>"16"
754	261-1340		67.64	261	"6"=>"15"
755	262-1337		155.97	262	"6"=>"18"
756	262-1338		141.00	262	"6"=>"17"
757	262-1339		134.11	262	"6"=>"16"
758	262-1340		93.35	262	"6"=>"15"
759	263-1337		89.20	263	"6"=>"18"
760	263-1338		84.84	263	"6"=>"17"
761	263-1339		81.87	263	"6"=>"16"
762	263-1340		26.67	263	"6"=>"15"
763	264-1337		178.28	264	"6"=>"18"
764	264-1338		138.00	264	"6"=>"17"
765	264-1339		136.64	264	"6"=>"16"
766	264-1340		112.69	264	"6"=>"15"
767	265-1337		100.93	265	"6"=>"18"
768	265-1338		78.36	265	"6"=>"17"
769	265-1339		57.36	265	"6"=>"16"
770	265-1340		21.42	265	"6"=>"15"
771	266-1337		165.87	266	"6"=>"18"
772	266-1338		137.33	266	"6"=>"17"
773	266-1339		125.02	266	"6"=>"16"
774	266-1340		118.37	266	"6"=>"15"
775	267-1337		109.40	267	"6"=>"18"
776	267-1338		85.32	267	"6"=>"17"
777	267-1339		64.82	267	"6"=>"16"
778	267-1340		29.98	267	"6"=>"15"
779	268-1337		154.87	268	"6"=>"18"
780	268-1338		151.57	268	"6"=>"17"
781	268-1339		144.17	268	"6"=>"16"
782	268-1340		80.18	268	"6"=>"15"
783	269-1337		181.96	269	"6"=>"18"
784	269-1338		173.46	269	"6"=>"17"
785	269-1339		151.91	269	"6"=>"16"
786	269-1340		92.44	269	"6"=>"15"
787	270-1337		75.63	270	"6"=>"18"
788	270-1338		66.26	270	"6"=>"17"
789	270-1339		66.01	270	"6"=>"16"
790	270-1340		63.16	270	"6"=>"15"
791	271-1337		47.71	271	"8"=>"23"
792	271-1338		30.18	271	"8"=>"22"
793	271-1339		22.02	271	"8"=>"21"
794	272-1337		85.84	272	"8"=>"23"
795	272-1338		76.67	272	"8"=>"22"
796	272-1339		36.77	272	"8"=>"21"
797	273-1337		156.02	273	"8"=>"23"
798	273-1338		146.09	273	"8"=>"22"
799	273-1339		108.99	273	"8"=>"21"
800	274-1337		129.22	274	"8"=>"23"
801	274-1338		116.53	274	"8"=>"22"
802	274-1339		113.60	274	"8"=>"21"
803	275-1337		131.86	275	"8"=>"23"
804	275-1338		81.92	275	"8"=>"22"
805	275-1339		59.62	275	"8"=>"21"
806	276-1337		137.75	276	"8"=>"23"
807	276-1338		132.89	276	"8"=>"22"
808	276-1339		53.94	276	"8"=>"21"
809	277-1337		109.30	277	"8"=>"23"
810	277-1338		51.72	277	"8"=>"22"
811	277-1339		45.86	277	"8"=>"21"
812	278-1337		142.16	278	"8"=>"23"
813	278-1338		128.59	278	"8"=>"22"
814	278-1339		124.51	278	"8"=>"21"
815	279-1337		149.45	279	"8"=>"23"
816	279-1338		95.34	279	"8"=>"22"
817	279-1339		68.27	279	"8"=>"21"
818	280-1337		140.01	280	"8"=>"23"
819	280-1338		119.90	280	"8"=>"22"
820	280-1339		117.57	280	"8"=>"21"
821	281-1337		\N	281	
822	282-1337		\N	282	
823	283-1337		\N	283	
824	284-1337		\N	284	
825	285-1337		\N	285	
826	286-1337		\N	286	
827	287-1337		\N	287	
828	288-1337		\N	288	
829	289-1337		\N	289	
830	290-1337		\N	290	
831	291-1337		101.42	291	"12"=>"31"
832	291-1338		90.13	291	"12"=>"30"
833	292-1337		175.76	292	"12"=>"31"
834	292-1338		102.03	292	"12"=>"30"
835	293-1337		79.36	293	"12"=>"31"
836	293-1338		33.76	293	"12"=>"30"
837	294-1337		108.00	294	"12"=>"31"
838	294-1338		42.81	294	"12"=>"30"
839	295-1337		158.98	295	"12"=>"31"
840	295-1338		118.42	295	"12"=>"30"
841	296-1337		77.29	296	"12"=>"31"
842	296-1338		62.90	296	"12"=>"30"
843	297-1337		74.35	297	"12"=>"31"
844	297-1338		42.96	297	"12"=>"30"
845	298-1337		120.58	298	"12"=>"31"
846	298-1338		42.01	298	"12"=>"30"
847	299-1337		61.18	299	"12"=>"31"
848	299-1338		13.03	299	"12"=>"30"
849	300-1337		24.53	300	"12"=>"31"
850	300-1338		18.45	300	"12"=>"30"
851	301-1337		\N	301	"4"=>"12"
852	301-1338		\N	301	"4"=>"11"
853	301-1339		\N	301	"4"=>"10"
854	301-1340		\N	301	"4"=>"9"
855	301-1341		\N	301	"4"=>"8"
856	301-1342		\N	301	"4"=>"7"
857	302-1337		\N	302	"4"=>"12"
858	302-1338		\N	302	"4"=>"11"
859	302-1339		\N	302	"4"=>"10"
860	302-1340		\N	302	"4"=>"9"
861	302-1341		\N	302	"4"=>"8"
862	302-1342		\N	302	"4"=>"7"
863	303-1337		\N	303	"4"=>"12"
864	303-1338		\N	303	"4"=>"11"
865	303-1339		\N	303	"4"=>"10"
866	303-1340		\N	303	"4"=>"9"
867	303-1341		\N	303	"4"=>"8"
868	303-1342		\N	303	"4"=>"7"
869	304-1337		\N	304	"4"=>"12"
870	304-1338		\N	304	"4"=>"11"
871	304-1339		\N	304	"4"=>"10"
872	304-1340		\N	304	"4"=>"9"
873	304-1341		\N	304	"4"=>"8"
874	304-1342		\N	304	"4"=>"7"
875	305-1337		\N	305	"4"=>"12"
876	305-1338		\N	305	"4"=>"11"
877	305-1339		\N	305	"4"=>"10"
878	305-1340		\N	305	"4"=>"9"
879	305-1341		\N	305	"4"=>"8"
880	305-1342		\N	305	"4"=>"7"
881	306-1337		\N	306	"4"=>"12"
882	306-1338		\N	306	"4"=>"11"
883	306-1339		\N	306	"4"=>"10"
884	306-1340		\N	306	"4"=>"9"
885	306-1341		\N	306	"4"=>"8"
886	306-1342		\N	306	"4"=>"7"
887	307-1337		\N	307	"4"=>"12"
888	307-1338		\N	307	"4"=>"11"
889	307-1339		\N	307	"4"=>"10"
890	307-1340		\N	307	"4"=>"9"
891	307-1341		\N	307	"4"=>"8"
892	307-1342		\N	307	"4"=>"7"
893	308-1337		\N	308	"4"=>"12"
894	308-1338		\N	308	"4"=>"11"
895	308-1339		\N	308	"4"=>"10"
896	308-1340		\N	308	"4"=>"9"
897	308-1341		\N	308	"4"=>"8"
898	308-1342		\N	308	"4"=>"7"
899	309-1337		\N	309	"4"=>"12"
900	309-1338		\N	309	"4"=>"11"
901	309-1339		\N	309	"4"=>"10"
902	309-1340		\N	309	"4"=>"9"
903	309-1341		\N	309	"4"=>"8"
904	309-1342		\N	309	"4"=>"7"
905	310-1337		\N	310	"4"=>"12"
906	310-1338		\N	310	"4"=>"11"
907	310-1339		\N	310	"4"=>"10"
908	310-1340		\N	310	"4"=>"9"
909	310-1341		\N	310	"4"=>"8"
910	310-1342		\N	310	"4"=>"7"
911	311-1337		\N	311	
912	312-1337		\N	312	
913	313-1337		\N	313	
914	314-1337		\N	314	
915	315-1337		\N	315	
916	316-1337		\N	316	
917	317-1337		\N	317	
918	318-1337		\N	318	
919	319-1337		\N	319	
920	320-1337		\N	320	
921	321-1337		191.53	321	"6"=>"18"
922	321-1338		187.86	321	"6"=>"17"
923	321-1339		169.77	321	"6"=>"16"
924	321-1340		101.50	321	"6"=>"15"
925	322-1337		140.86	322	"6"=>"18"
926	322-1338		132.65	322	"6"=>"17"
927	322-1339		113.69	322	"6"=>"16"
928	322-1340		113.12	322	"6"=>"15"
929	323-1337		108.12	323	"6"=>"18"
930	323-1338		76.68	323	"6"=>"17"
931	323-1339		75.04	323	"6"=>"16"
932	323-1340		74.94	323	"6"=>"15"
933	324-1337		107.09	324	"6"=>"18"
934	324-1338		51.20	324	"6"=>"17"
935	324-1339		28.29	324	"6"=>"16"
936	324-1340		18.28	324	"6"=>"15"
937	325-1337		130.16	325	"6"=>"18"
938	325-1338		98.61	325	"6"=>"17"
939	325-1339		93.17	325	"6"=>"16"
940	325-1340		68.64	325	"6"=>"15"
941	326-1337		154.41	326	"6"=>"18"
942	326-1338		147.51	326	"6"=>"17"
943	326-1339		96.41	326	"6"=>"16"
944	326-1340		77.30	326	"6"=>"15"
1254	434-1337		\N	434	
945	327-1337		125.72	327	"6"=>"18"
946	327-1338		118.24	327	"6"=>"17"
947	327-1339		56.78	327	"6"=>"16"
948	327-1340		40.16	327	"6"=>"15"
949	328-1337		159.44	328	"6"=>"18"
950	328-1338		145.18	328	"6"=>"17"
951	328-1339		118.69	328	"6"=>"16"
952	328-1340		114.23	328	"6"=>"15"
953	329-1337		152.06	329	"6"=>"18"
954	329-1338		126.27	329	"6"=>"17"
955	329-1339		77.29	329	"6"=>"16"
956	329-1340		62.11	329	"6"=>"15"
957	330-1337		112.92	330	"6"=>"18"
958	330-1338		76.40	330	"6"=>"17"
959	330-1339		69.32	330	"6"=>"16"
960	330-1340		66.52	330	"6"=>"15"
961	331-1337		102.90	331	"8"=>"23"
962	331-1338		87.06	331	"8"=>"22"
963	331-1339		86.00	331	"8"=>"21"
964	332-1337		73.44	332	"8"=>"23"
965	332-1338		25.36	332	"8"=>"22"
966	332-1339		23.15	332	"8"=>"21"
967	333-1337		144.83	333	"8"=>"23"
968	333-1338		75.41	333	"8"=>"22"
969	333-1339		75.06	333	"8"=>"21"
970	334-1337		142.15	334	"8"=>"23"
971	334-1338		121.60	334	"8"=>"22"
972	334-1339		110.23	334	"8"=>"21"
973	335-1337		102.46	335	"8"=>"23"
974	335-1338		36.35	335	"8"=>"22"
975	335-1339		18.94	335	"8"=>"21"
976	336-1337		136.57	336	"8"=>"23"
977	336-1338		55.53	336	"8"=>"22"
978	336-1339		51.33	336	"8"=>"21"
979	337-1337		140.53	337	"8"=>"23"
980	337-1338		127.14	337	"8"=>"22"
981	337-1339		90.05	337	"8"=>"21"
982	338-1337		118.77	338	"8"=>"23"
983	338-1338		55.47	338	"8"=>"22"
984	338-1339		54.96	338	"8"=>"21"
985	339-1337		142.20	339	"8"=>"23"
986	339-1338		108.52	339	"8"=>"22"
987	339-1339		84.03	339	"8"=>"21"
988	340-1337		127.50	340	"8"=>"23"
989	340-1338		93.41	340	"8"=>"22"
990	340-1339		42.17	340	"8"=>"21"
991	341-1337		\N	341	
992	342-1337		\N	342	
993	343-1337		\N	343	
994	344-1337		\N	344	
995	345-1337		\N	345	
996	346-1337		\N	346	
997	347-1337		\N	347	
998	348-1337		\N	348	
999	349-1337		\N	349	
1000	350-1337		\N	350	
1001	351-1337		137.43	351	"12"=>"31"
1002	351-1338		91.36	351	"12"=>"30"
1003	352-1337		125.77	352	"12"=>"31"
1004	352-1338		98.41	352	"12"=>"30"
1005	353-1337		102.30	353	"12"=>"31"
1006	353-1338		50.94	353	"12"=>"30"
1007	354-1337		39.94	354	"12"=>"31"
1008	354-1338		19.67	354	"12"=>"30"
1009	355-1337		89.77	355	"12"=>"31"
1010	355-1338		25.83	355	"12"=>"30"
1011	356-1337		135.23	356	"12"=>"31"
1012	356-1338		119.68	356	"12"=>"30"
1013	357-1337		158.75	357	"12"=>"31"
1014	357-1338		106.46	357	"12"=>"30"
1015	358-1337		67.41	358	"12"=>"31"
1016	358-1338		34.01	358	"12"=>"30"
1017	359-1337		69.54	359	"12"=>"31"
1018	359-1338		38.87	359	"12"=>"30"
1019	360-1337		65.86	360	"12"=>"31"
1020	360-1338		34.32	360	"12"=>"30"
1021	361-1337		\N	361	"4"=>"12"
1022	361-1338		\N	361	"4"=>"11"
1023	361-1339		\N	361	"4"=>"10"
1024	361-1340		\N	361	"4"=>"9"
1025	361-1341		\N	361	"4"=>"8"
1026	361-1342		\N	361	"4"=>"7"
1027	362-1337		\N	362	"4"=>"12"
1028	362-1338		\N	362	"4"=>"11"
1029	362-1339		\N	362	"4"=>"10"
1030	362-1340		\N	362	"4"=>"9"
1031	362-1341		\N	362	"4"=>"8"
1032	362-1342		\N	362	"4"=>"7"
1033	363-1337		\N	363	"4"=>"12"
1034	363-1338		\N	363	"4"=>"11"
1035	363-1339		\N	363	"4"=>"10"
1036	363-1340		\N	363	"4"=>"9"
1037	363-1341		\N	363	"4"=>"8"
1038	363-1342		\N	363	"4"=>"7"
1039	364-1337		\N	364	"4"=>"12"
1040	364-1338		\N	364	"4"=>"11"
1041	364-1339		\N	364	"4"=>"10"
1042	364-1340		\N	364	"4"=>"9"
1043	364-1341		\N	364	"4"=>"8"
1044	364-1342		\N	364	"4"=>"7"
1045	365-1337		\N	365	"4"=>"12"
1046	365-1338		\N	365	"4"=>"11"
1047	365-1339		\N	365	"4"=>"10"
1048	365-1340		\N	365	"4"=>"9"
1049	365-1341		\N	365	"4"=>"8"
1050	365-1342		\N	365	"4"=>"7"
1051	366-1337		\N	366	"4"=>"12"
1052	366-1338		\N	366	"4"=>"11"
1053	366-1339		\N	366	"4"=>"10"
1054	366-1340		\N	366	"4"=>"9"
1055	366-1341		\N	366	"4"=>"8"
1056	366-1342		\N	366	"4"=>"7"
1057	367-1337		\N	367	"4"=>"12"
1058	367-1338		\N	367	"4"=>"11"
1059	367-1339		\N	367	"4"=>"10"
1060	367-1340		\N	367	"4"=>"9"
1061	367-1341		\N	367	"4"=>"8"
1062	367-1342		\N	367	"4"=>"7"
1063	368-1337		\N	368	"4"=>"12"
1064	368-1338		\N	368	"4"=>"11"
1065	368-1339		\N	368	"4"=>"10"
1066	368-1340		\N	368	"4"=>"9"
1067	368-1341		\N	368	"4"=>"8"
1068	368-1342		\N	368	"4"=>"7"
1069	369-1337		\N	369	"4"=>"12"
1070	369-1338		\N	369	"4"=>"11"
1071	369-1339		\N	369	"4"=>"10"
1072	369-1340		\N	369	"4"=>"9"
1073	369-1341		\N	369	"4"=>"8"
1074	369-1342		\N	369	"4"=>"7"
1075	370-1337		\N	370	"4"=>"12"
1076	370-1338		\N	370	"4"=>"11"
1077	370-1339		\N	370	"4"=>"10"
1078	370-1340		\N	370	"4"=>"9"
1079	370-1341		\N	370	"4"=>"8"
1080	370-1342		\N	370	"4"=>"7"
1081	371-1337		\N	371	
1082	372-1337		\N	372	
1083	373-1337		\N	373	
1084	374-1337		\N	374	
1085	375-1337		\N	375	
1086	376-1337		\N	376	
1087	377-1337		\N	377	
1088	378-1337		\N	378	
1089	379-1337		\N	379	
1090	380-1337		\N	380	
1091	381-1337		110.01	381	"6"=>"18"
1092	381-1338		59.03	381	"6"=>"17"
1093	381-1339		54.01	381	"6"=>"16"
1094	381-1340		37.73	381	"6"=>"15"
1095	382-1337		96.58	382	"6"=>"18"
1096	382-1338		51.46	382	"6"=>"17"
1097	382-1339		49.32	382	"6"=>"16"
1098	382-1340		37.66	382	"6"=>"15"
1099	383-1337		60.77	383	"6"=>"18"
1100	383-1338		54.89	383	"6"=>"17"
1101	383-1339		54.46	383	"6"=>"16"
1102	383-1340		31.58	383	"6"=>"15"
1103	384-1337		122.43	384	"6"=>"18"
1104	384-1338		93.74	384	"6"=>"17"
1105	384-1339		80.47	384	"6"=>"16"
1106	384-1340		72.33	384	"6"=>"15"
1107	385-1337		102.92	385	"6"=>"18"
1108	385-1338		63.36	385	"6"=>"17"
1109	385-1339		52.85	385	"6"=>"16"
1110	385-1340		44.45	385	"6"=>"15"
1111	386-1337		104.35	386	"6"=>"18"
1112	386-1338		100.11	386	"6"=>"17"
1113	386-1339		91.30	386	"6"=>"16"
1114	386-1340		49.56	386	"6"=>"15"
1115	387-1337		180.32	387	"6"=>"18"
1116	387-1338		164.69	387	"6"=>"17"
1117	387-1339		143.25	387	"6"=>"16"
1118	387-1340		138.11	387	"6"=>"15"
1119	388-1337		84.63	388	"6"=>"18"
1120	388-1338		73.39	388	"6"=>"17"
1121	388-1339		63.54	388	"6"=>"16"
1122	388-1340		20.81	388	"6"=>"15"
1123	389-1337		140.71	389	"6"=>"18"
1124	389-1338		137.59	389	"6"=>"17"
1125	389-1339		118.71	389	"6"=>"16"
1126	389-1340		103.57	389	"6"=>"15"
1127	390-1337		109.77	390	"6"=>"18"
1128	390-1338		107.79	390	"6"=>"17"
1129	390-1339		86.87	390	"6"=>"16"
1130	390-1340		82.64	390	"6"=>"15"
1131	391-1337		102.40	391	"8"=>"23"
1132	391-1338		95.74	391	"8"=>"22"
1133	391-1339		84.07	391	"8"=>"21"
1134	392-1337		117.52	392	"8"=>"23"
1135	392-1338		95.69	392	"8"=>"22"
1136	392-1339		91.80	392	"8"=>"21"
1137	393-1337		89.24	393	"8"=>"23"
1138	393-1338		22.85	393	"8"=>"22"
1139	393-1339		16.60	393	"8"=>"21"
1140	394-1337		96.82	394	"8"=>"23"
1141	394-1338		93.24	394	"8"=>"22"
1142	394-1339		68.04	394	"8"=>"21"
1143	395-1337		124.08	395	"8"=>"23"
1144	395-1338		119.31	395	"8"=>"22"
1145	395-1339		52.81	395	"8"=>"21"
1146	396-1337		108.72	396	"8"=>"23"
1147	396-1338		98.55	396	"8"=>"22"
1148	396-1339		71.51	396	"8"=>"21"
1149	397-1337		161.93	397	"8"=>"23"
1150	397-1338		115.85	397	"8"=>"22"
1151	397-1339		103.76	397	"8"=>"21"
1152	398-1337		133.55	398	"8"=>"23"
1153	398-1338		113.50	398	"8"=>"22"
1154	398-1339		65.33	398	"8"=>"21"
1155	399-1337		95.04	399	"8"=>"23"
1156	399-1338		94.35	399	"8"=>"22"
1157	399-1339		42.11	399	"8"=>"21"
1158	400-1337		151.12	400	"8"=>"23"
1159	400-1338		124.47	400	"8"=>"22"
1160	400-1339		119.44	400	"8"=>"21"
1161	401-1337		\N	401	
1162	402-1337		\N	402	
1163	403-1337		\N	403	
1164	404-1337		\N	404	
1165	405-1337		\N	405	
1166	406-1337		\N	406	
1167	407-1337		\N	407	
1168	408-1337		\N	408	
1169	409-1337		\N	409	
1170	410-1337		\N	410	
1171	411-1337		42.84	411	"12"=>"31"
1172	411-1338		42.26	411	"12"=>"30"
1173	412-1337		79.60	412	"12"=>"31"
1174	412-1338		69.07	412	"12"=>"30"
1175	413-1337		101.41	413	"12"=>"31"
1176	413-1338		64.50	413	"12"=>"30"
1177	414-1337		96.25	414	"12"=>"31"
1178	414-1338		94.40	414	"12"=>"30"
1179	415-1337		97.92	415	"12"=>"31"
1180	415-1338		72.85	415	"12"=>"30"
1181	416-1337		118.87	416	"12"=>"31"
1182	416-1338		91.10	416	"12"=>"30"
1183	417-1337		45.58	417	"12"=>"31"
1184	417-1338		33.97	417	"12"=>"30"
1185	418-1337		83.58	418	"12"=>"31"
1186	418-1338		45.75	418	"12"=>"30"
1187	419-1337		61.04	419	"12"=>"31"
1188	419-1338		43.17	419	"12"=>"30"
1189	420-1337		80.16	420	"12"=>"31"
1190	420-1338		33.03	420	"12"=>"30"
1191	421-1337		\N	421	"4"=>"12"
1192	421-1338		\N	421	"4"=>"11"
1193	421-1339		\N	421	"4"=>"10"
1194	421-1340		\N	421	"4"=>"9"
1195	421-1341		\N	421	"4"=>"8"
1196	421-1342		\N	421	"4"=>"7"
1197	422-1337		\N	422	"4"=>"12"
1198	422-1338		\N	422	"4"=>"11"
1199	422-1339		\N	422	"4"=>"10"
1200	422-1340		\N	422	"4"=>"9"
1201	422-1341		\N	422	"4"=>"8"
1202	422-1342		\N	422	"4"=>"7"
1203	423-1337		\N	423	"4"=>"12"
1204	423-1338		\N	423	"4"=>"11"
1205	423-1339		\N	423	"4"=>"10"
1206	423-1340		\N	423	"4"=>"9"
1207	423-1341		\N	423	"4"=>"8"
1208	423-1342		\N	423	"4"=>"7"
1209	424-1337		\N	424	"4"=>"12"
1210	424-1338		\N	424	"4"=>"11"
1211	424-1339		\N	424	"4"=>"10"
1212	424-1340		\N	424	"4"=>"9"
1213	424-1341		\N	424	"4"=>"8"
1214	424-1342		\N	424	"4"=>"7"
1215	425-1337		\N	425	"4"=>"12"
1216	425-1338		\N	425	"4"=>"11"
1217	425-1339		\N	425	"4"=>"10"
1218	425-1340		\N	425	"4"=>"9"
1219	425-1341		\N	425	"4"=>"8"
1220	425-1342		\N	425	"4"=>"7"
1221	426-1337		\N	426	"4"=>"12"
1222	426-1338		\N	426	"4"=>"11"
1223	426-1339		\N	426	"4"=>"10"
1224	426-1340		\N	426	"4"=>"9"
1225	426-1341		\N	426	"4"=>"8"
1226	426-1342		\N	426	"4"=>"7"
1227	427-1337		\N	427	"4"=>"12"
1228	427-1338		\N	427	"4"=>"11"
1229	427-1339		\N	427	"4"=>"10"
1230	427-1340		\N	427	"4"=>"9"
1231	427-1341		\N	427	"4"=>"8"
1232	427-1342		\N	427	"4"=>"7"
1233	428-1337		\N	428	"4"=>"12"
1234	428-1338		\N	428	"4"=>"11"
1235	428-1339		\N	428	"4"=>"10"
1236	428-1340		\N	428	"4"=>"9"
1237	428-1341		\N	428	"4"=>"8"
1238	428-1342		\N	428	"4"=>"7"
1239	429-1337		\N	429	"4"=>"12"
1240	429-1338		\N	429	"4"=>"11"
1241	429-1339		\N	429	"4"=>"10"
1242	429-1340		\N	429	"4"=>"9"
1243	429-1341		\N	429	"4"=>"8"
1244	429-1342		\N	429	"4"=>"7"
1245	430-1337		\N	430	"4"=>"12"
1246	430-1338		\N	430	"4"=>"11"
1247	430-1339		\N	430	"4"=>"10"
1248	430-1340		\N	430	"4"=>"9"
1249	430-1341		\N	430	"4"=>"8"
1250	430-1342		\N	430	"4"=>"7"
1251	431-1337		\N	431	
1252	432-1337		\N	432	
1255	435-1337		\N	435	
1256	436-1337		\N	436	
1257	437-1337		\N	437	
1258	438-1337		\N	438	
1259	439-1337		\N	439	
1260	440-1337		\N	440	
1261	441-1337		72.01	441	"6"=>"18"
1262	441-1338		56.47	441	"6"=>"17"
1263	441-1339		35.18	441	"6"=>"16"
1264	441-1340		31.31	441	"6"=>"15"
1265	442-1337		109.27	442	"6"=>"18"
1266	442-1338		67.00	442	"6"=>"17"
1267	442-1339		31.53	442	"6"=>"16"
1268	442-1340		16.23	442	"6"=>"15"
1269	443-1337		133.95	443	"6"=>"18"
1270	443-1338		92.07	443	"6"=>"17"
1271	443-1339		83.99	443	"6"=>"16"
1272	443-1340		79.12	443	"6"=>"15"
1273	444-1337		161.50	444	"6"=>"18"
1274	444-1338		136.85	444	"6"=>"17"
1275	444-1339		110.60	444	"6"=>"16"
1276	444-1340		92.48	444	"6"=>"15"
1277	445-1337		155.70	445	"6"=>"18"
1278	445-1338		130.68	445	"6"=>"17"
1279	445-1339		119.33	445	"6"=>"16"
1280	445-1340		111.83	445	"6"=>"15"
1281	446-1337		72.97	446	"6"=>"18"
1282	446-1338		38.08	446	"6"=>"17"
1283	446-1339		33.87	446	"6"=>"16"
1284	446-1340		8.40	446	"6"=>"15"
1285	447-1337		128.29	447	"6"=>"18"
1286	447-1338		113.71	447	"6"=>"17"
1287	447-1339		94.57	447	"6"=>"16"
1288	447-1340		56.83	447	"6"=>"15"
1289	448-1337		129.33	448	"6"=>"18"
1290	448-1338		125.30	448	"6"=>"17"
1291	448-1339		77.62	448	"6"=>"16"
1292	448-1340		64.45	448	"6"=>"15"
1293	449-1337		121.78	449	"6"=>"18"
1294	449-1338		103.98	449	"6"=>"17"
1295	449-1339		100.35	449	"6"=>"16"
1296	449-1340		99.10	449	"6"=>"15"
1297	450-1337		159.58	450	"6"=>"18"
1298	450-1338		148.52	450	"6"=>"17"
1299	450-1339		89.77	450	"6"=>"16"
1300	450-1340		88.30	450	"6"=>"15"
1301	451-1337		113.37	451	"8"=>"23"
1302	451-1338		110.40	451	"8"=>"22"
1303	451-1339		45.41	451	"8"=>"21"
1304	452-1337		77.42	452	"8"=>"23"
1305	452-1338		63.85	452	"8"=>"22"
1306	452-1339		48.46	452	"8"=>"21"
1307	453-1337		78.54	453	"8"=>"23"
1308	453-1338		76.41	453	"8"=>"22"
1309	453-1339		64.55	453	"8"=>"21"
1310	454-1337		182.71	454	"8"=>"23"
1311	454-1338		154.54	454	"8"=>"22"
1312	454-1339		93.30	454	"8"=>"21"
1313	455-1337		85.65	455	"8"=>"23"
1314	455-1338		73.92	455	"8"=>"22"
1315	455-1339		32.77	455	"8"=>"21"
1316	456-1337		106.03	456	"8"=>"23"
1317	456-1338		94.48	456	"8"=>"22"
1318	456-1339		53.50	456	"8"=>"21"
1319	457-1337		108.43	457	"8"=>"23"
1320	457-1338		51.51	457	"8"=>"22"
1321	457-1339		49.88	457	"8"=>"21"
1322	458-1337		93.55	458	"8"=>"23"
1323	458-1338		93.28	458	"8"=>"22"
1324	458-1339		37.11	458	"8"=>"21"
1325	459-1337		138.49	459	"8"=>"23"
1326	459-1338		130.41	459	"8"=>"22"
1327	459-1339		115.82	459	"8"=>"21"
1328	460-1337		109.13	460	"8"=>"23"
1329	460-1338		95.83	460	"8"=>"22"
1330	460-1339		84.54	460	"8"=>"21"
1331	461-1337		\N	461	
1332	462-1337		\N	462	
1333	463-1337		\N	463	
1334	464-1337		\N	464	
1335	465-1337		\N	465	
1336	466-1337		\N	466	
1337	467-1337		\N	467	
1338	468-1337		\N	468	
1339	469-1337		\N	469	
1340	470-1337		\N	470	
1341	471-1337		144.49	471	"12"=>"31"
1342	471-1338		125.84	471	"12"=>"30"
1343	472-1337		79.58	472	"12"=>"31"
1344	472-1338		46.88	472	"12"=>"30"
1345	473-1337		101.29	473	"12"=>"31"
1346	473-1338		74.27	473	"12"=>"30"
1347	474-1337		120.17	474	"12"=>"31"
1348	474-1338		112.37	474	"12"=>"30"
1349	475-1337		176.25	475	"12"=>"31"
1350	475-1338		104.59	475	"12"=>"30"
1351	476-1337		152.52	476	"12"=>"31"
1352	476-1338		115.64	476	"12"=>"30"
1353	477-1337		175.31	477	"12"=>"31"
1354	477-1338		169.10	477	"12"=>"30"
1355	478-1337		94.99	478	"12"=>"31"
1356	478-1338		92.87	478	"12"=>"30"
1357	479-1337		149.67	479	"12"=>"31"
1358	479-1338		81.00	479	"12"=>"30"
1359	480-1337		159.99	480	"12"=>"31"
1360	480-1338		114.84	480	"12"=>"30"
1361	481-1337		\N	481	"4"=>"12"
1362	481-1338		\N	481	"4"=>"11"
1363	481-1339		\N	481	"4"=>"10"
1364	481-1340		\N	481	"4"=>"9"
1365	481-1341		\N	481	"4"=>"8"
1366	481-1342		\N	481	"4"=>"7"
1367	482-1337		\N	482	"4"=>"12"
1368	482-1338		\N	482	"4"=>"11"
1369	482-1339		\N	482	"4"=>"10"
1370	482-1340		\N	482	"4"=>"9"
1371	482-1341		\N	482	"4"=>"8"
1372	482-1342		\N	482	"4"=>"7"
1373	483-1337		\N	483	"4"=>"12"
1374	483-1338		\N	483	"4"=>"11"
1375	483-1339		\N	483	"4"=>"10"
1376	483-1340		\N	483	"4"=>"9"
1377	483-1341		\N	483	"4"=>"8"
1378	483-1342		\N	483	"4"=>"7"
1379	484-1337		\N	484	"4"=>"12"
1380	484-1338		\N	484	"4"=>"11"
1381	484-1339		\N	484	"4"=>"10"
1382	484-1340		\N	484	"4"=>"9"
1383	484-1341		\N	484	"4"=>"8"
1384	484-1342		\N	484	"4"=>"7"
1385	485-1337		\N	485	"4"=>"12"
1386	485-1338		\N	485	"4"=>"11"
1387	485-1339		\N	485	"4"=>"10"
1388	485-1340		\N	485	"4"=>"9"
1389	485-1341		\N	485	"4"=>"8"
1390	485-1342		\N	485	"4"=>"7"
1391	486-1337		\N	486	"4"=>"12"
1392	486-1338		\N	486	"4"=>"11"
1393	486-1339		\N	486	"4"=>"10"
1394	486-1340		\N	486	"4"=>"9"
1395	486-1341		\N	486	"4"=>"8"
1396	486-1342		\N	486	"4"=>"7"
1397	487-1337		\N	487	"4"=>"12"
1398	487-1338		\N	487	"4"=>"11"
1399	487-1339		\N	487	"4"=>"10"
1400	487-1340		\N	487	"4"=>"9"
1401	487-1341		\N	487	"4"=>"8"
1402	487-1342		\N	487	"4"=>"7"
1403	488-1337		\N	488	"4"=>"12"
1404	488-1338		\N	488	"4"=>"11"
1405	488-1339		\N	488	"4"=>"10"
1406	488-1340		\N	488	"4"=>"9"
1407	488-1341		\N	488	"4"=>"8"
1408	488-1342		\N	488	"4"=>"7"
1409	489-1337		\N	489	"4"=>"12"
1410	489-1338		\N	489	"4"=>"11"
1411	489-1339		\N	489	"4"=>"10"
1412	489-1340		\N	489	"4"=>"9"
1413	489-1341		\N	489	"4"=>"8"
1414	489-1342		\N	489	"4"=>"7"
1415	490-1337		\N	490	"4"=>"12"
1416	490-1338		\N	490	"4"=>"11"
1417	490-1339		\N	490	"4"=>"10"
1418	490-1340		\N	490	"4"=>"9"
1419	490-1341		\N	490	"4"=>"8"
1420	490-1342		\N	490	"4"=>"7"
1421	491-1337		\N	491	
1422	492-1337		\N	492	
1423	493-1337		\N	493	
1424	494-1337		\N	494	
1425	495-1337		\N	495	
1426	496-1337		\N	496	
1427	497-1337		\N	497	
1428	498-1337		\N	498	
1429	499-1337		\N	499	
1430	500-1337		\N	500	
1431	501-1337		171.57	501	"6"=>"18"
1432	501-1338		150.83	501	"6"=>"17"
1433	501-1339		133.74	501	"6"=>"16"
1434	501-1340		87.09	501	"6"=>"15"
1435	502-1337		73.66	502	"6"=>"18"
1436	502-1338		62.50	502	"6"=>"17"
1437	502-1339		48.19	502	"6"=>"16"
1438	502-1340		34.78	502	"6"=>"15"
1439	503-1337		168.51	503	"6"=>"18"
1440	503-1338		157.37	503	"6"=>"17"
1441	503-1339		150.91	503	"6"=>"16"
1442	503-1340		125.72	503	"6"=>"15"
1443	504-1337		141.46	504	"6"=>"18"
1444	504-1338		135.48	504	"6"=>"17"
1445	504-1339		94.58	504	"6"=>"16"
1446	504-1340		69.81	504	"6"=>"15"
1447	505-1337		116.41	505	"6"=>"18"
1448	505-1338		88.01	505	"6"=>"17"
1449	505-1339		82.32	505	"6"=>"16"
1450	505-1340		67.78	505	"6"=>"15"
1451	506-1337		62.07	506	"6"=>"18"
1452	506-1338		39.81	506	"6"=>"17"
1453	506-1339		21.91	506	"6"=>"16"
1454	506-1340		14.18	506	"6"=>"15"
1455	507-1337		113.98	507	"6"=>"18"
1456	507-1338		46.71	507	"6"=>"17"
1457	507-1339		40.70	507	"6"=>"16"
1458	507-1340		37.88	507	"6"=>"15"
1459	508-1337		148.48	508	"6"=>"18"
1460	508-1338		110.13	508	"6"=>"17"
1461	508-1339		108.42	508	"6"=>"16"
1462	508-1340		97.89	508	"6"=>"15"
1463	509-1337		153.71	509	"6"=>"18"
1464	509-1338		146.50	509	"6"=>"17"
1465	509-1339		114.48	509	"6"=>"16"
1466	509-1340		89.46	509	"6"=>"15"
1467	510-1337		166.79	510	"6"=>"18"
1468	510-1338		165.72	510	"6"=>"17"
1469	510-1339		142.33	510	"6"=>"16"
1470	510-1340		131.17	510	"6"=>"15"
1471	511-1337		156.46	511	"8"=>"23"
1472	511-1338		156.45	511	"8"=>"22"
1473	511-1339		68.93	511	"8"=>"21"
1474	512-1337		116.02	512	"8"=>"23"
1475	512-1338		43.23	512	"8"=>"22"
1476	512-1339		37.74	512	"8"=>"21"
1477	513-1337		120.31	513	"8"=>"23"
1478	513-1338		116.89	513	"8"=>"22"
1479	513-1339		115.44	513	"8"=>"21"
1480	514-1337		145.34	514	"8"=>"23"
1481	514-1338		129.56	514	"8"=>"22"
1482	514-1339		103.78	514	"8"=>"21"
1483	515-1337		143.27	515	"8"=>"23"
1484	515-1338		119.81	515	"8"=>"22"
1485	515-1339		102.50	515	"8"=>"21"
1486	516-1337		159.05	516	"8"=>"23"
1487	516-1338		130.77	516	"8"=>"22"
1488	516-1339		88.42	516	"8"=>"21"
1489	517-1337		158.85	517	"8"=>"23"
1490	517-1338		141.50	517	"8"=>"22"
1491	517-1339		101.50	517	"8"=>"21"
1492	518-1337		99.39	518	"8"=>"23"
1493	518-1338		69.62	518	"8"=>"22"
1494	518-1339		51.82	518	"8"=>"21"
1495	519-1337		113.23	519	"8"=>"23"
1496	519-1338		109.48	519	"8"=>"22"
1497	519-1339		104.33	519	"8"=>"21"
1498	520-1337		79.92	520	"8"=>"23"
1499	520-1338		8.36	520	"8"=>"22"
1500	520-1339		6.73	520	"8"=>"21"
1501	521-1337		\N	521	
1502	522-1337		\N	522	
1503	523-1337		\N	523	
1504	524-1337		\N	524	
1505	525-1337		\N	525	
1506	526-1337		\N	526	
1507	527-1337		\N	527	
1508	528-1337		\N	528	
1509	529-1337		\N	529	
1510	530-1337		\N	530	
1511	531-1337		141.30	531	"12"=>"31"
1512	531-1338		120.06	531	"12"=>"30"
1513	532-1337		91.08	532	"12"=>"31"
1514	532-1338		17.54	532	"12"=>"30"
1515	533-1337		154.64	533	"12"=>"31"
1516	533-1338		120.45	533	"12"=>"30"
1517	534-1337		172.61	534	"12"=>"31"
1518	534-1338		110.97	534	"12"=>"30"
1519	535-1337		188.59	535	"12"=>"31"
1520	535-1338		179.04	535	"12"=>"30"
1521	536-1337		38.44	536	"12"=>"31"
1522	536-1338		35.73	536	"12"=>"30"
1523	537-1337		148.54	537	"12"=>"31"
1524	537-1338		134.14	537	"12"=>"30"
1525	538-1337		87.56	538	"12"=>"31"
1526	538-1338		70.75	538	"12"=>"30"
1527	539-1337		139.30	539	"12"=>"31"
1528	539-1338		126.45	539	"12"=>"30"
1529	540-1337		153.47	540	"12"=>"31"
1530	540-1338		85.63	540	"12"=>"30"
\.


--
-- Data for Name: product_stock; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_stock (id, quantity, cost_price, variant_id, quantity_allocated, location_id) FROM stdin;
1	29	\N	1	0	1
2	41	\N	2	0	1
3	36	\N	3	0	1
4	39	\N	4	0	1
5	21	\N	5	0	1
6	21	\N	6	0	1
7	46	\N	7	0	1
8	26	\N	8	0	1
9	14	\N	9	0	1
10	8	\N	10	0	1
11	44	\N	11	0	1
12	14	\N	12	0	1
13	22	\N	13	0	1
14	18	\N	14	0	1
15	2	\N	15	0	1
16	24	\N	16	0	1
17	26	\N	17	0	1
18	2	\N	18	0	1
19	21	\N	19	0	1
20	45	\N	20	0	1
21	21	\N	21	0	1
22	20	\N	22	0	1
23	39	\N	23	0	1
24	22	\N	24	0	1
25	31	\N	25	0	1
26	3	\N	26	0	1
27	40	\N	27	0	1
28	35	\N	28	0	1
29	9	\N	29	0	1
30	1	\N	30	0	1
31	20	\N	31	0	1
32	29	\N	32	0	1
33	25	\N	33	0	1
34	28	\N	34	0	1
35	35	\N	35	0	1
36	12	\N	36	0	1
37	44	\N	37	0	1
38	21	\N	38	0	1
39	30	\N	39	0	1
40	49	\N	40	0	1
41	44	\N	41	0	1
42	28	\N	42	0	1
43	32	\N	43	0	1
44	36	\N	44	0	1
45	41	\N	45	0	1
46	6	\N	46	0	1
47	45	\N	47	0	1
48	4	\N	48	0	1
49	22	\N	49	0	1
50	23	\N	50	0	1
51	19	\N	51	0	1
52	4	\N	52	0	1
53	16	\N	53	0	1
54	26	\N	54	0	1
55	21	\N	55	0	1
56	1	\N	56	0	1
57	49	\N	57	0	1
58	14	\N	58	0	1
59	41	\N	59	0	1
60	6	\N	60	0	1
61	38	\N	61	0	1
62	5	\N	62	0	1
63	29	\N	63	0	1
64	44	\N	64	0	1
65	36	\N	65	0	1
66	45	\N	66	0	1
67	34	\N	67	0	1
68	48	\N	68	0	1
69	37	\N	69	0	1
70	41	\N	70	0	1
71	21	\N	71	0	1
72	6	\N	72	0	1
73	41	\N	73	0	1
74	44	\N	74	0	1
75	2	\N	75	0	1
76	13	\N	76	0	1
77	2	\N	77	0	1
78	34	\N	78	0	1
79	25	\N	79	0	1
80	10	\N	80	0	1
81	18	\N	81	0	1
82	18	\N	82	0	1
83	42	\N	83	0	1
84	11	\N	84	0	1
85	41	\N	85	0	1
86	27	\N	86	0	1
87	34	\N	87	0	1
88	47	\N	88	0	1
89	43	\N	89	0	1
90	23	\N	90	0	1
91	28	\N	91	0	1
92	11	\N	92	0	1
93	18	\N	93	0	1
94	48	\N	94	0	1
95	45	\N	95	0	1
96	17	\N	96	0	1
97	50	\N	97	0	1
98	30	\N	98	0	1
99	37	\N	99	0	1
100	23	\N	100	0	1
101	47	\N	101	0	1
102	32	\N	102	0	1
103	29	\N	103	0	1
104	36	\N	104	0	1
105	36	\N	105	0	1
106	27	\N	106	0	1
107	1	\N	107	0	1
108	12	\N	108	0	1
109	4	\N	109	0	1
110	26	\N	110	0	1
111	27	\N	111	0	1
112	31	\N	112	0	1
113	5	\N	113	0	1
114	46	\N	114	0	1
115	6	\N	115	0	1
116	7	\N	116	0	1
117	8	\N	117	0	1
118	36	\N	118	0	1
119	44	\N	119	0	1
120	18	\N	120	0	1
121	24	\N	121	0	1
122	42	\N	122	0	1
123	9	\N	123	0	1
124	26	\N	124	0	1
125	21	\N	125	0	1
126	31	\N	126	0	1
127	12	\N	127	0	1
128	11	\N	128	0	1
129	7	\N	129	0	1
130	33	\N	130	0	1
131	28	\N	131	0	1
132	29	\N	132	0	1
133	13	\N	133	0	1
134	22	\N	134	0	1
135	29	\N	135	0	1
136	21	\N	136	0	1
137	31	\N	137	0	1
138	35	\N	138	0	1
139	22	\N	139	0	1
140	39	\N	140	0	1
141	29	\N	141	0	1
142	25	\N	142	0	1
143	13	\N	143	0	1
144	14	\N	144	0	1
145	35	\N	145	0	1
146	1	\N	146	0	1
147	11	\N	147	0	1
148	13	\N	148	0	1
149	35	\N	149	0	1
150	7	\N	150	0	1
151	39	\N	151	0	1
152	26	\N	152	0	1
153	33	\N	153	0	1
154	25	\N	154	0	1
155	12	\N	155	0	1
156	44	\N	156	0	1
157	39	\N	157	0	1
158	18	\N	158	0	1
159	38	\N	159	0	1
160	7	\N	160	0	1
161	48	\N	161	0	1
162	6	\N	162	0	1
163	40	\N	163	0	1
164	8	\N	164	0	1
165	43	\N	165	0	1
166	8	\N	166	0	1
167	48	\N	167	0	1
168	45	\N	168	0	1
169	25	\N	169	0	1
170	29	\N	170	0	1
171	7	\N	171	0	1
172	2	\N	172	0	1
173	41	\N	173	0	1
174	14	\N	174	0	1
175	17	\N	175	0	1
176	36	\N	176	0	1
177	42	\N	177	0	1
178	19	\N	178	0	1
179	28	\N	179	0	1
180	23	\N	180	0	1
181	23	\N	181	0	1
182	21	\N	182	0	1
183	10	\N	183	0	1
184	43	\N	184	0	1
185	33	\N	185	0	1
186	7	\N	186	0	1
187	49	\N	187	0	1
188	15	\N	188	0	1
189	25	\N	189	0	1
190	17	\N	190	0	1
191	34	\N	191	0	1
192	43	\N	192	0	1
193	5	\N	193	0	1
194	49	\N	194	0	1
195	1	\N	195	0	1
196	44	\N	196	0	1
197	31	\N	197	0	1
198	20	\N	198	0	1
199	15	\N	199	0	1
200	26	\N	200	0	1
201	35	\N	201	0	1
202	33	\N	202	0	1
203	9	\N	203	0	1
204	13	\N	204	0	1
205	8	\N	205	0	1
206	39	\N	206	0	1
207	14	\N	207	0	1
208	1	\N	208	0	1
209	20	\N	209	0	1
210	42	\N	210	0	1
211	33	\N	211	0	1
212	12	\N	212	0	1
213	20	\N	213	0	1
214	6	\N	214	0	1
215	35	\N	215	0	1
216	31	\N	216	0	1
217	19	\N	217	0	1
218	7	\N	218	0	1
219	9	\N	219	0	1
220	23	\N	220	0	1
221	6	\N	221	0	1
222	6	\N	222	0	1
223	27	\N	223	0	1
224	33	\N	224	0	1
225	18	\N	225	0	1
226	49	\N	226	0	1
227	15	\N	227	0	1
228	7	\N	228	0	1
229	47	\N	229	0	1
230	41	\N	230	0	1
231	18	\N	231	0	1
232	33	\N	232	0	1
233	28	\N	233	0	1
234	8	\N	234	0	1
235	47	\N	235	0	1
236	11	\N	236	0	1
237	9	\N	237	0	1
238	30	\N	238	0	1
239	18	\N	239	0	1
240	40	\N	240	0	1
241	40	\N	241	0	1
242	8	\N	242	0	1
243	26	\N	243	0	1
244	1	\N	244	0	1
245	48	\N	245	0	1
246	44	\N	246	0	1
247	4	\N	247	0	1
248	27	\N	248	0	1
249	15	\N	249	0	1
250	37	\N	250	0	1
251	17	\N	251	0	1
252	30	\N	252	0	1
253	45	\N	253	0	1
254	17	\N	254	0	1
255	29	\N	255	0	1
256	13	\N	256	0	1
257	9	\N	257	0	1
258	29	\N	258	0	1
259	41	\N	259	0	1
260	11	\N	260	0	1
261	24	\N	261	0	1
262	25	\N	262	0	1
263	17	\N	263	0	1
264	15	\N	264	0	1
265	12	\N	265	0	1
266	11	\N	266	0	1
267	13	\N	267	0	1
268	1	\N	268	0	1
269	39	\N	269	0	1
270	34	\N	270	0	1
271	33	\N	271	0	1
272	10	\N	272	0	1
273	28	\N	273	0	1
274	29	\N	274	0	1
275	38	\N	275	0	1
276	11	\N	276	0	1
277	28	\N	277	0	1
278	9	\N	278	0	1
279	13	\N	279	0	1
280	4	\N	280	0	1
281	11	\N	281	0	1
282	46	\N	282	0	1
283	29	\N	283	0	1
284	37	\N	284	0	1
285	46	\N	285	0	1
286	36	\N	286	0	1
287	36	\N	287	0	1
288	46	\N	288	0	1
289	30	\N	289	0	1
290	22	\N	290	0	1
291	11	\N	291	0	1
292	41	\N	292	0	1
293	38	\N	293	0	1
294	2	\N	294	0	1
295	30	\N	295	0	1
296	6	\N	296	0	1
297	26	\N	297	0	1
298	27	\N	298	0	1
299	21	\N	299	0	1
300	44	\N	300	0	1
301	46	\N	301	0	1
302	7	\N	302	0	1
303	14	\N	303	0	1
304	5	\N	304	0	1
305	27	\N	305	0	1
306	30	\N	306	0	1
307	12	\N	307	0	1
308	36	\N	308	0	1
309	45	\N	309	0	1
310	19	\N	310	0	1
311	19	\N	311	0	1
312	14	\N	312	0	1
313	21	\N	313	0	1
314	19	\N	314	0	1
315	1	\N	315	0	1
316	24	\N	316	0	1
317	37	\N	317	0	1
318	3	\N	318	0	1
319	31	\N	319	0	1
320	8	\N	320	0	1
321	33	\N	321	0	1
322	39	\N	322	0	1
323	26	\N	323	0	1
324	42	\N	324	0	1
325	47	\N	325	0	1
326	33	\N	326	0	1
327	4	\N	327	0	1
328	43	\N	328	0	1
329	40	\N	329	0	1
330	42	\N	330	0	1
331	11	\N	331	0	1
332	25	\N	332	0	1
333	40	\N	333	0	1
334	35	\N	334	0	1
335	17	\N	335	0	1
336	19	\N	336	0	1
337	45	\N	337	0	1
338	38	\N	338	0	1
339	6	\N	339	0	1
340	3	\N	340	0	1
341	25	\N	341	0	1
342	13	\N	342	0	1
343	47	\N	343	0	1
344	13	\N	344	0	1
345	12	\N	345	0	1
346	12	\N	346	0	1
347	47	\N	347	0	1
348	24	\N	348	0	1
349	39	\N	349	0	1
350	42	\N	350	0	1
351	39	\N	351	0	1
352	5	\N	352	0	1
353	26	\N	353	0	1
354	40	\N	354	0	1
355	45	\N	355	0	1
356	49	\N	356	0	1
357	38	\N	357	0	1
358	30	\N	358	0	1
359	12	\N	359	0	1
360	29	\N	360	0	1
361	8	\N	361	0	1
362	43	\N	362	0	1
363	23	\N	363	0	1
364	32	\N	364	0	1
365	2	\N	365	0	1
366	23	\N	366	0	1
367	14	\N	367	0	1
368	5	\N	368	0	1
369	19	\N	369	0	1
370	13	\N	370	0	1
371	10	\N	371	0	1
372	25	\N	372	0	1
373	31	\N	373	0	1
374	22	\N	374	0	1
375	49	\N	375	0	1
376	49	\N	376	0	1
377	20	\N	377	0	1
378	4	\N	378	0	1
379	9	\N	379	0	1
380	26	\N	380	0	1
381	47	\N	381	0	1
382	10	\N	382	0	1
383	5	\N	383	0	1
384	13	\N	384	0	1
385	39	\N	385	0	1
386	21	\N	386	0	1
387	48	\N	387	0	1
388	5	\N	388	0	1
389	28	\N	389	0	1
390	30	\N	390	0	1
391	33	\N	391	0	1
392	28	\N	392	0	1
393	50	\N	393	0	1
394	1	\N	394	0	1
395	26	\N	395	0	1
396	11	\N	396	0	1
397	2	\N	397	0	1
398	43	\N	398	0	1
399	12	\N	399	0	1
400	46	\N	400	0	1
401	34	\N	401	0	1
402	27	\N	402	0	1
403	28	\N	403	0	1
404	42	\N	404	0	1
405	8	\N	405	0	1
406	10	\N	406	0	1
407	20	\N	407	0	1
408	48	\N	408	0	1
409	33	\N	409	0	1
410	25	\N	410	0	1
411	23	\N	411	0	1
412	27	\N	412	0	1
413	7	\N	413	0	1
414	22	\N	414	0	1
415	19	\N	415	0	1
416	47	\N	416	0	1
417	24	\N	417	0	1
418	50	\N	418	0	1
419	18	\N	419	0	1
420	24	\N	420	0	1
421	46	\N	421	0	1
422	15	\N	422	0	1
423	40	\N	423	0	1
424	45	\N	424	0	1
425	41	\N	425	0	1
426	20	\N	426	0	1
427	10	\N	427	0	1
428	43	\N	428	0	1
429	27	\N	429	0	1
430	46	\N	430	0	1
431	33	\N	431	0	1
432	39	\N	432	0	1
433	15	\N	433	0	1
434	25	\N	434	0	1
435	13	\N	435	0	1
436	18	\N	436	0	1
437	41	\N	437	0	1
438	50	\N	438	0	1
439	28	\N	439	0	1
440	40	\N	440	0	1
441	18	\N	441	0	1
442	19	\N	442	0	1
443	6	\N	443	0	1
444	33	\N	444	0	1
445	30	\N	445	0	1
446	20	\N	446	0	1
447	40	\N	447	0	1
448	29	\N	448	0	1
449	13	\N	449	0	1
450	42	\N	450	0	1
451	38	\N	451	0	1
452	37	\N	452	0	1
453	47	\N	453	0	1
454	32	\N	454	0	1
455	8	\N	455	0	1
456	20	\N	456	0	1
457	36	\N	457	0	1
458	22	\N	458	0	1
459	10	\N	459	0	1
460	27	\N	460	0	1
461	1	\N	461	0	1
462	18	\N	462	0	1
463	36	\N	463	0	1
464	28	\N	464	0	1
465	48	\N	465	0	1
466	26	\N	466	0	1
467	4	\N	467	0	1
468	38	\N	468	0	1
469	12	\N	469	0	1
470	37	\N	470	0	1
471	6	\N	471	0	1
472	35	\N	472	0	1
473	12	\N	473	0	1
474	36	\N	474	0	1
475	44	\N	475	0	1
476	29	\N	476	0	1
477	19	\N	477	0	1
478	50	\N	478	0	1
479	42	\N	479	0	1
480	44	\N	480	0	1
481	36	\N	481	0	1
482	44	\N	482	0	1
483	16	\N	483	0	1
484	46	\N	484	0	1
485	9	\N	485	0	1
486	31	\N	486	0	1
487	6	\N	487	0	1
488	2	\N	488	0	1
489	19	\N	489	0	1
490	36	\N	490	0	1
491	10	\N	491	0	1
492	44	\N	492	0	1
493	38	\N	493	0	1
494	3	\N	494	0	1
495	13	\N	495	0	1
496	15	\N	496	0	1
497	19	\N	497	0	1
498	6	\N	498	0	1
499	9	\N	499	0	1
500	32	\N	500	0	1
501	40	\N	501	0	1
502	7	\N	502	0	1
503	20	\N	503	0	1
504	23	\N	504	0	1
505	23	\N	505	0	1
506	46	\N	506	0	1
507	14	\N	507	0	1
508	25	\N	508	0	1
509	2	\N	509	0	1
510	21	\N	510	0	1
511	36	\N	511	0	1
512	30	\N	512	0	1
513	19	\N	513	0	1
514	25	\N	514	0	1
515	36	\N	515	0	1
516	24	\N	516	0	1
517	19	\N	517	0	1
518	25	\N	518	0	1
519	31	\N	519	0	1
520	48	\N	520	0	1
521	44	\N	521	0	1
522	49	\N	522	0	1
523	30	\N	523	0	1
524	8	\N	524	0	1
525	32	\N	525	0	1
526	34	\N	526	0	1
527	13	\N	527	0	1
528	23	\N	528	0	1
529	41	\N	529	0	1
530	44	\N	530	0	1
531	3	\N	531	0	1
532	4	\N	532	0	1
533	44	\N	533	0	1
534	4	\N	534	0	1
535	49	\N	535	0	1
536	29	\N	536	0	1
537	5	\N	537	0	1
538	35	\N	538	0	1
539	28	\N	539	0	1
540	7	\N	540	0	1
541	9	\N	541	0	1
542	13	\N	542	0	1
543	18	\N	543	0	1
544	40	\N	544	0	1
545	25	\N	545	0	1
546	39	\N	546	0	1
547	7	\N	547	0	1
548	46	\N	548	0	1
549	44	\N	549	0	1
550	37	\N	550	0	1
551	33	\N	551	0	1
552	18	\N	552	0	1
553	47	\N	553	0	1
554	31	\N	554	0	1
555	16	\N	555	0	1
556	50	\N	556	0	1
557	14	\N	557	0	1
558	17	\N	558	0	1
559	20	\N	559	0	1
560	25	\N	560	0	1
561	21	\N	561	0	1
562	46	\N	562	0	1
563	19	\N	563	0	1
564	32	\N	564	0	1
565	48	\N	565	0	1
566	12	\N	566	0	1
567	35	\N	567	0	1
568	15	\N	568	0	1
569	42	\N	569	0	1
570	36	\N	570	0	1
571	7	\N	571	0	1
572	11	\N	572	0	1
573	3	\N	573	0	1
574	41	\N	574	0	1
575	46	\N	575	0	1
576	37	\N	576	0	1
577	33	\N	577	0	1
578	12	\N	578	0	1
579	30	\N	579	0	1
580	9	\N	580	0	1
581	47	\N	581	0	1
582	27	\N	582	0	1
583	33	\N	583	0	1
584	38	\N	584	0	1
585	47	\N	585	0	1
586	11	\N	586	0	1
587	34	\N	587	0	1
588	8	\N	588	0	1
589	50	\N	589	0	1
590	16	\N	590	0	1
591	9	\N	591	0	1
592	26	\N	592	0	1
593	41	\N	593	0	1
594	36	\N	594	0	1
595	8	\N	595	0	1
596	18	\N	596	0	1
597	43	\N	597	0	1
598	25	\N	598	0	1
599	9	\N	599	0	1
600	42	\N	600	0	1
601	27	\N	601	0	1
602	40	\N	602	0	1
603	16	\N	603	0	1
604	27	\N	604	0	1
605	13	\N	605	0	1
606	38	\N	606	0	1
607	2	\N	607	0	1
608	41	\N	608	0	1
609	49	\N	609	0	1
610	32	\N	610	0	1
611	20	\N	611	0	1
612	48	\N	612	0	1
613	29	\N	613	0	1
614	14	\N	614	0	1
615	42	\N	615	0	1
616	27	\N	616	0	1
617	40	\N	617	0	1
618	24	\N	618	0	1
619	38	\N	619	0	1
620	16	\N	620	0	1
621	31	\N	621	0	1
622	12	\N	622	0	1
623	14	\N	623	0	1
624	7	\N	624	0	1
625	35	\N	625	0	1
626	41	\N	626	0	1
627	10	\N	627	0	1
628	23	\N	628	0	1
629	44	\N	629	0	1
630	15	\N	630	0	1
631	8	\N	631	0	1
632	11	\N	632	0	1
633	14	\N	633	0	1
634	41	\N	634	0	1
635	21	\N	635	0	1
636	19	\N	636	0	1
637	2	\N	637	0	1
638	50	\N	638	0	1
639	48	\N	639	0	1
640	6	\N	640	0	1
641	32	\N	641	0	1
642	18	\N	642	0	1
643	37	\N	643	0	1
644	31	\N	644	0	1
645	18	\N	645	0	1
646	30	\N	646	0	1
647	29	\N	647	0	1
648	50	\N	648	0	1
649	16	\N	649	0	1
650	34	\N	650	0	1
651	19	\N	651	0	1
652	9	\N	652	0	1
653	36	\N	653	0	1
654	7	\N	654	0	1
655	30	\N	655	0	1
656	42	\N	656	0	1
657	22	\N	657	0	1
658	27	\N	658	0	1
659	44	\N	659	0	1
660	13	\N	660	0	1
661	41	\N	661	0	1
662	10	\N	662	0	1
663	18	\N	663	0	1
664	6	\N	664	0	1
665	5	\N	665	0	1
666	32	\N	666	0	1
667	21	\N	667	0	1
668	50	\N	668	0	1
669	3	\N	669	0	1
670	45	\N	670	0	1
671	22	\N	671	0	1
672	38	\N	672	0	1
673	4	\N	673	0	1
674	5	\N	674	0	1
675	37	\N	675	0	1
676	12	\N	676	0	1
677	28	\N	677	0	1
678	39	\N	678	0	1
679	37	\N	679	0	1
680	4	\N	680	0	1
681	46	\N	681	0	1
682	9	\N	682	0	1
683	17	\N	683	0	1
684	15	\N	684	0	1
685	31	\N	685	0	1
686	22	\N	686	0	1
687	21	\N	687	0	1
688	9	\N	688	0	1
689	42	\N	689	0	1
690	4	\N	690	0	1
691	14	\N	691	0	1
692	11	\N	692	0	1
693	6	\N	693	0	1
694	11	\N	694	0	1
695	13	\N	695	0	1
696	17	\N	696	0	1
697	40	\N	697	0	1
698	32	\N	698	0	1
699	9	\N	699	0	1
700	37	\N	700	0	1
701	25	\N	701	0	1
702	33	\N	702	0	1
703	10	\N	703	0	1
704	20	\N	704	0	1
705	14	\N	705	0	1
706	34	\N	706	0	1
707	5	\N	707	0	1
708	45	\N	708	0	1
709	17	\N	709	0	1
710	25	\N	710	0	1
711	40	\N	711	0	1
712	5	\N	712	0	1
713	33	\N	713	0	1
714	18	\N	714	0	1
715	32	\N	715	0	1
716	11	\N	716	0	1
717	50	\N	717	0	1
718	14	\N	718	0	1
719	43	\N	719	0	1
720	49	\N	720	0	1
721	24	\N	721	0	1
722	42	\N	722	0	1
723	23	\N	723	0	1
724	32	\N	724	0	1
725	43	\N	725	0	1
726	5	\N	726	0	1
727	23	\N	727	0	1
728	33	\N	728	0	1
729	15	\N	729	0	1
730	37	\N	730	0	1
731	37	\N	731	0	1
732	10	\N	732	0	1
733	29	\N	733	0	1
734	30	\N	734	0	1
735	36	\N	735	0	1
736	31	\N	736	0	1
737	22	\N	737	0	1
738	3	\N	738	0	1
739	22	\N	739	0	1
740	38	\N	740	0	1
741	13	\N	741	0	1
742	24	\N	742	0	1
743	41	\N	743	0	1
744	3	\N	744	0	1
745	39	\N	745	0	1
746	5	\N	746	0	1
747	11	\N	747	0	1
748	15	\N	748	0	1
749	29	\N	749	0	1
750	9	\N	750	0	1
751	33	\N	751	0	1
752	8	\N	752	0	1
753	23	\N	753	0	1
754	48	\N	754	0	1
755	12	\N	755	0	1
756	41	\N	756	0	1
757	15	\N	757	0	1
758	38	\N	758	0	1
759	1	\N	759	0	1
760	25	\N	760	0	1
761	18	\N	761	0	1
762	41	\N	762	0	1
763	11	\N	763	0	1
764	4	\N	764	0	1
765	13	\N	765	0	1
766	29	\N	766	0	1
767	2	\N	767	0	1
768	42	\N	768	0	1
769	47	\N	769	0	1
770	19	\N	770	0	1
771	33	\N	771	0	1
772	39	\N	772	0	1
773	16	\N	773	0	1
774	40	\N	774	0	1
775	17	\N	775	0	1
776	28	\N	776	0	1
777	6	\N	777	0	1
778	19	\N	778	0	1
779	45	\N	779	0	1
780	50	\N	780	0	1
781	29	\N	781	0	1
782	22	\N	782	0	1
783	44	\N	783	0	1
784	6	\N	784	0	1
785	29	\N	785	0	1
786	47	\N	786	0	1
787	19	\N	787	0	1
788	39	\N	788	0	1
789	20	\N	789	0	1
790	24	\N	790	0	1
791	50	\N	791	0	1
792	16	\N	792	0	1
793	32	\N	793	0	1
794	45	\N	794	0	1
795	3	\N	795	0	1
796	45	\N	796	0	1
797	7	\N	797	0	1
798	11	\N	798	0	1
799	22	\N	799	0	1
800	13	\N	800	0	1
801	11	\N	801	0	1
802	3	\N	802	0	1
803	41	\N	803	0	1
804	6	\N	804	0	1
805	7	\N	805	0	1
806	30	\N	806	0	1
807	43	\N	807	0	1
808	29	\N	808	0	1
809	33	\N	809	0	1
810	46	\N	810	0	1
811	6	\N	811	0	1
812	49	\N	812	0	1
813	49	\N	813	0	1
814	11	\N	814	0	1
815	41	\N	815	0	1
816	16	\N	816	0	1
817	37	\N	817	0	1
818	21	\N	818	0	1
819	31	\N	819	0	1
820	5	\N	820	0	1
821	29	\N	821	0	1
822	20	\N	822	0	1
823	49	\N	823	0	1
824	35	\N	824	0	1
825	42	\N	825	0	1
826	10	\N	826	0	1
827	37	\N	827	0	1
828	17	\N	828	0	1
829	6	\N	829	0	1
830	43	\N	830	0	1
831	48	\N	831	0	1
832	15	\N	832	0	1
833	26	\N	833	0	1
834	8	\N	834	0	1
835	3	\N	835	0	1
836	10	\N	836	0	1
837	28	\N	837	0	1
838	15	\N	838	0	1
839	45	\N	839	0	1
840	44	\N	840	0	1
841	12	\N	841	0	1
842	23	\N	842	0	1
843	25	\N	843	0	1
844	37	\N	844	0	1
845	48	\N	845	0	1
846	40	\N	846	0	1
847	43	\N	847	0	1
848	8	\N	848	0	1
849	41	\N	849	0	1
850	33	\N	850	0	1
851	2	\N	851	0	1
852	10	\N	852	0	1
853	13	\N	853	0	1
854	23	\N	854	0	1
855	43	\N	855	0	1
856	18	\N	856	0	1
857	14	\N	857	0	1
858	22	\N	858	0	1
859	34	\N	859	0	1
860	4	\N	860	0	1
861	34	\N	861	0	1
862	6	\N	862	0	1
863	34	\N	863	0	1
864	48	\N	864	0	1
865	1	\N	865	0	1
866	38	\N	866	0	1
867	32	\N	867	0	1
868	25	\N	868	0	1
869	25	\N	869	0	1
870	13	\N	870	0	1
871	27	\N	871	0	1
872	38	\N	872	0	1
873	48	\N	873	0	1
874	43	\N	874	0	1
875	9	\N	875	0	1
876	25	\N	876	0	1
877	12	\N	877	0	1
878	12	\N	878	0	1
879	35	\N	879	0	1
880	25	\N	880	0	1
881	19	\N	881	0	1
882	33	\N	882	0	1
883	23	\N	883	0	1
884	45	\N	884	0	1
885	27	\N	885	0	1
886	3	\N	886	0	1
887	23	\N	887	0	1
888	36	\N	888	0	1
889	17	\N	889	0	1
890	12	\N	890	0	1
891	22	\N	891	0	1
892	1	\N	892	0	1
893	47	\N	893	0	1
894	24	\N	894	0	1
895	20	\N	895	0	1
896	1	\N	896	0	1
897	47	\N	897	0	1
898	42	\N	898	0	1
899	33	\N	899	0	1
900	19	\N	900	0	1
901	24	\N	901	0	1
902	30	\N	902	0	1
903	11	\N	903	0	1
904	20	\N	904	0	1
905	4	\N	905	0	1
906	17	\N	906	0	1
907	16	\N	907	0	1
908	40	\N	908	0	1
909	45	\N	909	0	1
910	9	\N	910	0	1
911	40	\N	911	0	1
912	46	\N	912	0	1
913	24	\N	913	0	1
914	39	\N	914	0	1
915	28	\N	915	0	1
916	6	\N	916	0	1
917	34	\N	917	0	1
918	22	\N	918	0	1
919	37	\N	919	0	1
920	8	\N	920	0	1
921	44	\N	921	0	1
922	41	\N	922	0	1
923	36	\N	923	0	1
924	5	\N	924	0	1
925	27	\N	925	0	1
926	6	\N	926	0	1
927	14	\N	927	0	1
928	24	\N	928	0	1
929	34	\N	929	0	1
930	33	\N	930	0	1
931	48	\N	931	0	1
932	35	\N	932	0	1
933	19	\N	933	0	1
934	13	\N	934	0	1
935	5	\N	935	0	1
936	9	\N	936	0	1
937	46	\N	937	0	1
938	38	\N	938	0	1
939	2	\N	939	0	1
940	38	\N	940	0	1
941	19	\N	941	0	1
942	9	\N	942	0	1
943	7	\N	943	0	1
944	49	\N	944	0	1
945	15	\N	945	0	1
946	9	\N	946	0	1
947	37	\N	947	0	1
948	17	\N	948	0	1
949	11	\N	949	0	1
950	25	\N	950	0	1
951	48	\N	951	0	1
952	31	\N	952	0	1
953	10	\N	953	0	1
954	4	\N	954	0	1
955	9	\N	955	0	1
956	7	\N	956	0	1
957	48	\N	957	0	1
958	14	\N	958	0	1
959	33	\N	959	0	1
960	10	\N	960	0	1
961	5	\N	961	0	1
962	6	\N	962	0	1
963	34	\N	963	0	1
964	27	\N	964	0	1
965	3	\N	965	0	1
966	1	\N	966	0	1
967	10	\N	967	0	1
968	41	\N	968	0	1
969	46	\N	969	0	1
970	17	\N	970	0	1
971	2	\N	971	0	1
972	32	\N	972	0	1
973	12	\N	973	0	1
974	49	\N	974	0	1
975	46	\N	975	0	1
976	26	\N	976	0	1
977	6	\N	977	0	1
978	46	\N	978	0	1
979	24	\N	979	0	1
980	7	\N	980	0	1
981	4	\N	981	0	1
982	4	\N	982	0	1
983	18	\N	983	0	1
984	26	\N	984	0	1
985	15	\N	985	0	1
986	22	\N	986	0	1
987	1	\N	987	0	1
988	26	\N	988	0	1
989	47	\N	989	0	1
990	11	\N	990	0	1
991	3	\N	991	0	1
992	25	\N	992	0	1
993	5	\N	993	0	1
994	47	\N	994	0	1
995	47	\N	995	0	1
996	49	\N	996	0	1
997	3	\N	997	0	1
998	26	\N	998	0	1
999	20	\N	999	0	1
1000	18	\N	1000	0	1
1001	34	\N	1001	0	1
1002	24	\N	1002	0	1
1003	43	\N	1003	0	1
1004	17	\N	1004	0	1
1005	43	\N	1005	0	1
1006	33	\N	1006	0	1
1007	26	\N	1007	0	1
1008	20	\N	1008	0	1
1009	41	\N	1009	0	1
1010	36	\N	1010	0	1
1011	13	\N	1011	0	1
1012	37	\N	1012	0	1
1013	41	\N	1013	0	1
1014	32	\N	1014	0	1
1015	48	\N	1015	0	1
1016	14	\N	1016	0	1
1017	37	\N	1017	0	1
1018	38	\N	1018	0	1
1019	18	\N	1019	0	1
1020	48	\N	1020	0	1
1021	30	\N	1021	0	1
1022	31	\N	1022	0	1
1023	17	\N	1023	0	1
1024	37	\N	1024	0	1
1025	20	\N	1025	0	1
1026	14	\N	1026	0	1
1027	29	\N	1027	0	1
1028	44	\N	1028	0	1
1029	34	\N	1029	0	1
1030	7	\N	1030	0	1
1031	45	\N	1031	0	1
1032	44	\N	1032	0	1
1033	36	\N	1033	0	1
1034	41	\N	1034	0	1
1035	7	\N	1035	0	1
1036	18	\N	1036	0	1
1037	27	\N	1037	0	1
1038	49	\N	1038	0	1
1039	10	\N	1039	0	1
1040	15	\N	1040	0	1
1041	32	\N	1041	0	1
1042	14	\N	1042	0	1
1043	33	\N	1043	0	1
1044	39	\N	1044	0	1
1045	41	\N	1045	0	1
1046	18	\N	1046	0	1
1047	43	\N	1047	0	1
1048	35	\N	1048	0	1
1049	19	\N	1049	0	1
1050	50	\N	1050	0	1
1051	21	\N	1051	0	1
1052	40	\N	1052	0	1
1053	1	\N	1053	0	1
1054	48	\N	1054	0	1
1055	12	\N	1055	0	1
1056	19	\N	1056	0	1
1057	18	\N	1057	0	1
1058	6	\N	1058	0	1
1059	13	\N	1059	0	1
1060	10	\N	1060	0	1
1061	30	\N	1061	0	1
1062	19	\N	1062	0	1
1063	31	\N	1063	0	1
1064	24	\N	1064	0	1
1065	36	\N	1065	0	1
1066	1	\N	1066	0	1
1067	45	\N	1067	0	1
1068	25	\N	1068	0	1
1069	31	\N	1069	0	1
1070	38	\N	1070	0	1
1071	5	\N	1071	0	1
1072	33	\N	1072	0	1
1073	10	\N	1073	0	1
1074	10	\N	1074	0	1
1075	32	\N	1075	0	1
1076	43	\N	1076	0	1
1077	24	\N	1077	0	1
1078	34	\N	1078	0	1
1079	35	\N	1079	0	1
1080	8	\N	1080	0	1
1081	28	\N	1081	0	1
1082	28	\N	1082	0	1
1083	27	\N	1083	0	1
1084	21	\N	1084	0	1
1085	8	\N	1085	0	1
1086	23	\N	1086	0	1
1087	28	\N	1087	0	1
1088	35	\N	1088	0	1
1089	17	\N	1089	0	1
1090	6	\N	1090	0	1
1091	4	\N	1091	0	1
1092	12	\N	1092	0	1
1093	15	\N	1093	0	1
1094	34	\N	1094	0	1
1095	46	\N	1095	0	1
1096	2	\N	1096	0	1
1097	14	\N	1097	0	1
1098	36	\N	1098	0	1
1099	18	\N	1099	0	1
1100	11	\N	1100	0	1
1101	9	\N	1101	0	1
1102	41	\N	1102	0	1
1103	21	\N	1103	0	1
1104	33	\N	1104	0	1
1105	49	\N	1105	0	1
1106	32	\N	1106	0	1
1107	45	\N	1107	0	1
1108	31	\N	1108	0	1
1109	17	\N	1109	0	1
1110	29	\N	1110	0	1
1111	31	\N	1111	0	1
1112	7	\N	1112	0	1
1113	18	\N	1113	0	1
1114	23	\N	1114	0	1
1115	22	\N	1115	0	1
1116	35	\N	1116	0	1
1117	23	\N	1117	0	1
1118	11	\N	1118	0	1
1119	26	\N	1119	0	1
1120	50	\N	1120	0	1
1121	50	\N	1121	0	1
1122	16	\N	1122	0	1
1123	23	\N	1123	0	1
1124	34	\N	1124	0	1
1125	45	\N	1125	0	1
1126	25	\N	1126	0	1
1127	46	\N	1127	0	1
1128	50	\N	1128	0	1
1129	21	\N	1129	0	1
1130	10	\N	1130	0	1
1131	36	\N	1131	0	1
1132	34	\N	1132	0	1
1133	38	\N	1133	0	1
1134	41	\N	1134	0	1
1135	5	\N	1135	0	1
1136	36	\N	1136	0	1
1137	43	\N	1137	0	1
1138	39	\N	1138	0	1
1139	16	\N	1139	0	1
1140	23	\N	1140	0	1
1141	35	\N	1141	0	1
1142	31	\N	1142	0	1
1143	4	\N	1143	0	1
1144	45	\N	1144	0	1
1145	5	\N	1145	0	1
1146	32	\N	1146	0	1
1147	38	\N	1147	0	1
1148	45	\N	1148	0	1
1149	29	\N	1149	0	1
1150	9	\N	1150	0	1
1151	46	\N	1151	0	1
1152	17	\N	1152	0	1
1153	44	\N	1153	0	1
1154	47	\N	1154	0	1
1155	9	\N	1155	0	1
1156	14	\N	1156	0	1
1157	20	\N	1157	0	1
1158	14	\N	1158	0	1
1159	24	\N	1159	0	1
1160	23	\N	1160	0	1
1161	8	\N	1161	0	1
1162	26	\N	1162	0	1
1163	30	\N	1163	0	1
1164	7	\N	1164	0	1
1165	11	\N	1165	0	1
1166	1	\N	1166	0	1
1167	25	\N	1167	0	1
1168	42	\N	1168	0	1
1169	20	\N	1169	0	1
1170	10	\N	1170	0	1
1171	45	\N	1171	0	1
1172	20	\N	1172	0	1
1173	6	\N	1173	0	1
1174	7	\N	1174	0	1
1175	8	\N	1175	0	1
1176	2	\N	1176	0	1
1177	33	\N	1177	0	1
1178	12	\N	1178	0	1
1179	42	\N	1179	0	1
1180	18	\N	1180	0	1
1181	5	\N	1181	0	1
1182	26	\N	1182	0	1
1183	47	\N	1183	0	1
1184	28	\N	1184	0	1
1185	28	\N	1185	0	1
1186	18	\N	1186	0	1
1187	48	\N	1187	0	1
1188	33	\N	1188	0	1
1189	6	\N	1189	0	1
1190	16	\N	1190	0	1
1191	18	\N	1191	0	1
1192	4	\N	1192	0	1
1193	7	\N	1193	0	1
1194	50	\N	1194	0	1
1195	49	\N	1195	0	1
1196	22	\N	1196	0	1
1197	22	\N	1197	0	1
1198	30	\N	1198	0	1
1199	15	\N	1199	0	1
1200	9	\N	1200	0	1
1201	19	\N	1201	0	1
1202	38	\N	1202	0	1
1203	43	\N	1203	0	1
1204	45	\N	1204	0	1
1205	46	\N	1205	0	1
1206	4	\N	1206	0	1
1207	44	\N	1207	0	1
1208	34	\N	1208	0	1
1209	36	\N	1209	0	1
1210	7	\N	1210	0	1
1211	13	\N	1211	0	1
1212	47	\N	1212	0	1
1213	2	\N	1213	0	1
1214	40	\N	1214	0	1
1215	10	\N	1215	0	1
1216	20	\N	1216	0	1
1217	38	\N	1217	0	1
1218	26	\N	1218	0	1
1219	20	\N	1219	0	1
1220	12	\N	1220	0	1
1221	37	\N	1221	0	1
1222	4	\N	1222	0	1
1223	34	\N	1223	0	1
1224	27	\N	1224	0	1
1225	39	\N	1225	0	1
1226	36	\N	1226	0	1
1227	7	\N	1227	0	1
1228	36	\N	1228	0	1
1229	37	\N	1229	0	1
1230	32	\N	1230	0	1
1231	31	\N	1231	0	1
1232	17	\N	1232	0	1
1233	50	\N	1233	0	1
1234	45	\N	1234	0	1
1235	18	\N	1235	0	1
1236	43	\N	1236	0	1
1237	38	\N	1237	0	1
1238	20	\N	1238	0	1
1239	10	\N	1239	0	1
1240	11	\N	1240	0	1
1241	39	\N	1241	0	1
1242	2	\N	1242	0	1
1243	36	\N	1243	0	1
1244	18	\N	1244	0	1
1245	23	\N	1245	0	1
1246	26	\N	1246	0	1
1247	6	\N	1247	0	1
1248	50	\N	1248	0	1
1249	18	\N	1249	0	1
1250	13	\N	1250	0	1
1251	50	\N	1251	0	1
1252	11	\N	1252	0	1
1253	47	\N	1253	0	1
1254	34	\N	1254	0	1
1255	40	\N	1255	0	1
1256	6	\N	1256	0	1
1257	29	\N	1257	0	1
1258	23	\N	1258	0	1
1259	9	\N	1259	0	1
1260	35	\N	1260	0	1
1261	29	\N	1261	0	1
1262	41	\N	1262	0	1
1263	23	\N	1263	0	1
1264	44	\N	1264	0	1
1265	49	\N	1265	0	1
1266	50	\N	1266	0	1
1267	10	\N	1267	0	1
1268	22	\N	1268	0	1
1269	26	\N	1269	0	1
1270	48	\N	1270	0	1
1271	10	\N	1271	0	1
1272	38	\N	1272	0	1
1273	20	\N	1273	0	1
1274	14	\N	1274	0	1
1275	9	\N	1275	0	1
1276	24	\N	1276	0	1
1277	9	\N	1277	0	1
1278	14	\N	1278	0	1
1279	19	\N	1279	0	1
1280	21	\N	1280	0	1
1281	24	\N	1281	0	1
1282	35	\N	1282	0	1
1283	7	\N	1283	0	1
1284	13	\N	1284	0	1
1285	21	\N	1285	0	1
1286	12	\N	1286	0	1
1287	12	\N	1287	0	1
1288	2	\N	1288	0	1
1289	48	\N	1289	0	1
1290	48	\N	1290	0	1
1291	12	\N	1291	0	1
1292	45	\N	1292	0	1
1293	2	\N	1293	0	1
1294	16	\N	1294	0	1
1295	4	\N	1295	0	1
1296	32	\N	1296	0	1
1297	21	\N	1297	0	1
1298	21	\N	1298	0	1
1299	19	\N	1299	0	1
1300	21	\N	1300	0	1
1301	21	\N	1301	0	1
1302	44	\N	1302	0	1
1303	23	\N	1303	0	1
1304	28	\N	1304	0	1
1305	5	\N	1305	0	1
1306	15	\N	1306	0	1
1307	27	\N	1307	0	1
1308	2	\N	1308	0	1
1309	41	\N	1309	0	1
1310	44	\N	1310	0	1
1311	25	\N	1311	0	1
1312	13	\N	1312	0	1
1313	48	\N	1313	0	1
1314	33	\N	1314	0	1
1315	43	\N	1315	0	1
1316	8	\N	1316	0	1
1317	20	\N	1317	0	1
1318	5	\N	1318	0	1
1319	37	\N	1319	0	1
1320	3	\N	1320	0	1
1321	38	\N	1321	0	1
1322	16	\N	1322	0	1
1323	22	\N	1323	0	1
1324	30	\N	1324	0	1
1325	10	\N	1325	0	1
1326	17	\N	1326	0	1
1327	36	\N	1327	0	1
1328	48	\N	1328	0	1
1329	23	\N	1329	0	1
1330	10	\N	1330	0	1
1331	15	\N	1331	0	1
1332	14	\N	1332	0	1
1333	48	\N	1333	0	1
1334	34	\N	1334	0	1
1335	18	\N	1335	0	1
1336	13	\N	1336	0	1
1337	31	\N	1337	0	1
1338	38	\N	1338	0	1
1339	29	\N	1339	0	1
1340	2	\N	1340	0	1
1341	23	\N	1341	0	1
1342	38	\N	1342	0	1
1343	28	\N	1343	0	1
1344	21	\N	1344	0	1
1345	18	\N	1345	0	1
1346	30	\N	1346	0	1
1347	2	\N	1347	0	1
1348	47	\N	1348	0	1
1349	6	\N	1349	0	1
1350	41	\N	1350	0	1
1351	11	\N	1351	0	1
1352	25	\N	1352	0	1
1353	30	\N	1353	0	1
1354	21	\N	1354	0	1
1355	1	\N	1355	0	1
1356	20	\N	1356	0	1
1357	31	\N	1357	0	1
1358	39	\N	1358	0	1
1359	34	\N	1359	0	1
1360	26	\N	1360	0	1
1361	41	\N	1361	0	1
1362	45	\N	1362	0	1
1363	7	\N	1363	0	1
1364	13	\N	1364	0	1
1365	9	\N	1365	0	1
1366	2	\N	1366	0	1
1367	3	\N	1367	0	1
1368	16	\N	1368	0	1
1369	1	\N	1369	0	1
1370	41	\N	1370	0	1
1371	15	\N	1371	0	1
1372	48	\N	1372	0	1
1373	46	\N	1373	0	1
1374	5	\N	1374	0	1
1375	9	\N	1375	0	1
1376	38	\N	1376	0	1
1377	25	\N	1377	0	1
1378	42	\N	1378	0	1
1379	47	\N	1379	0	1
1380	32	\N	1380	0	1
1381	24	\N	1381	0	1
1382	46	\N	1382	0	1
1383	34	\N	1383	0	1
1384	39	\N	1384	0	1
1385	44	\N	1385	0	1
1386	40	\N	1386	0	1
1387	34	\N	1387	0	1
1388	42	\N	1388	0	1
1389	19	\N	1389	0	1
1390	22	\N	1390	0	1
1391	35	\N	1391	0	1
1392	25	\N	1392	0	1
1393	9	\N	1393	0	1
1394	16	\N	1394	0	1
1395	38	\N	1395	0	1
1396	29	\N	1396	0	1
1397	12	\N	1397	0	1
1398	43	\N	1398	0	1
1399	44	\N	1399	0	1
1400	49	\N	1400	0	1
1401	9	\N	1401	0	1
1402	27	\N	1402	0	1
1403	19	\N	1403	0	1
1404	28	\N	1404	0	1
1405	25	\N	1405	0	1
1406	25	\N	1406	0	1
1407	2	\N	1407	0	1
1408	27	\N	1408	0	1
1409	15	\N	1409	0	1
1410	42	\N	1410	0	1
1411	16	\N	1411	0	1
1412	40	\N	1412	0	1
1413	12	\N	1413	0	1
1414	50	\N	1414	0	1
1415	48	\N	1415	0	1
1416	36	\N	1416	0	1
1417	22	\N	1417	0	1
1418	10	\N	1418	0	1
1419	33	\N	1419	0	1
1420	50	\N	1420	0	1
1421	7	\N	1421	0	1
1422	24	\N	1422	0	1
1423	17	\N	1423	0	1
1424	47	\N	1424	0	1
1425	35	\N	1425	0	1
1426	21	\N	1426	0	1
1427	43	\N	1427	0	1
1428	22	\N	1428	0	1
1429	19	\N	1429	0	1
1430	13	\N	1430	0	1
1431	10	\N	1431	0	1
1432	36	\N	1432	0	1
1433	14	\N	1433	0	1
1434	5	\N	1434	0	1
1435	9	\N	1435	0	1
1436	40	\N	1436	0	1
1437	27	\N	1437	0	1
1438	37	\N	1438	0	1
1439	27	\N	1439	0	1
1440	7	\N	1440	0	1
1441	50	\N	1441	0	1
1442	29	\N	1442	0	1
1443	20	\N	1443	0	1
1444	3	\N	1444	0	1
1445	33	\N	1445	0	1
1446	24	\N	1446	0	1
1447	23	\N	1447	0	1
1448	33	\N	1448	0	1
1449	6	\N	1449	0	1
1450	25	\N	1450	0	1
1451	15	\N	1451	0	1
1452	2	\N	1452	0	1
1453	28	\N	1453	0	1
1454	33	\N	1454	0	1
1455	48	\N	1455	0	1
1456	35	\N	1456	0	1
1457	43	\N	1457	0	1
1458	47	\N	1458	0	1
1459	11	\N	1459	0	1
1460	21	\N	1460	0	1
1461	13	\N	1461	0	1
1462	24	\N	1462	0	1
1463	13	\N	1463	0	1
1464	23	\N	1464	0	1
1465	23	\N	1465	0	1
1466	26	\N	1466	0	1
1467	18	\N	1467	0	1
1468	24	\N	1468	0	1
1469	31	\N	1469	0	1
1470	13	\N	1470	0	1
1471	24	\N	1471	0	1
1472	26	\N	1472	0	1
1473	48	\N	1473	0	1
1474	27	\N	1474	0	1
1475	13	\N	1475	0	1
1476	44	\N	1476	0	1
1477	9	\N	1477	0	1
1478	18	\N	1478	0	1
1479	35	\N	1479	0	1
1480	10	\N	1480	0	1
1481	1	\N	1481	0	1
1482	14	\N	1482	0	1
1483	38	\N	1483	0	1
1484	7	\N	1484	0	1
1485	32	\N	1485	0	1
1486	9	\N	1486	0	1
1487	41	\N	1487	0	1
1488	5	\N	1488	0	1
1489	37	\N	1489	0	1
1490	36	\N	1490	0	1
1491	42	\N	1491	0	1
1492	17	\N	1492	0	1
1493	23	\N	1493	0	1
1494	50	\N	1494	0	1
1495	6	\N	1495	0	1
1496	11	\N	1496	0	1
1497	19	\N	1497	0	1
1498	16	\N	1498	0	1
1499	26	\N	1499	0	1
1500	10	\N	1500	0	1
1501	31	\N	1501	0	1
1502	40	\N	1502	0	1
1503	37	\N	1503	0	1
1504	29	\N	1504	0	1
1505	11	\N	1505	0	1
1506	48	\N	1506	0	1
1507	47	\N	1507	0	1
1508	32	\N	1508	0	1
1509	36	\N	1509	0	1
1510	23	\N	1510	0	1
1511	5	\N	1511	0	1
1512	30	\N	1512	0	1
1513	11	\N	1513	0	1
1514	37	\N	1514	0	1
1515	11	\N	1515	0	1
1516	35	\N	1516	0	1
1517	33	\N	1517	0	1
1518	28	\N	1518	0	1
1519	43	\N	1519	0	1
1520	49	\N	1520	0	1
1521	39	\N	1521	0	1
1522	6	\N	1522	0	1
1523	1	\N	1523	0	1
1524	38	\N	1524	0	1
1525	36	\N	1525	0	1
1526	33	\N	1526	0	1
1527	41	\N	1527	0	1
1528	39	\N	1528	0	1
1529	6	\N	1529	0	1
1530	31	\N	1530	0	1
\.


--
-- Data for Name: product_stocklocation; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_stocklocation (id, name) FROM stdin;
1	default
\.


--
-- Data for Name: product_variantimage; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_variantimage (id, image_id, variant_id) FROM stdin;
\.


--
-- Data for Name: shipping_shippingmethod; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY shipping_shippingmethod (id, name, description) FROM stdin;
1	UPC	
2	DHL	
3	UPC	
4	DHL	
5	UPC	
6	DHL	
7	UPC	
8	DHL	
9	UPC	
10	DHL	
11	UPC	
12	DHL	
13	UPC	
14	DHL	
15	UPC	
16	DHL	
17	UPC	
18	DHL	
\.


--
-- Data for Name: shipping_shippingmethodcountry; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY shipping_shippingmethodcountry (id, country_code, price, shipping_method_id) FROM stdin;
1		37.18	1
2		1.80	2
3	US	94.90	2
4		99.54	3
5		76.23	4
6		91.59	5
7		50.00	6
8		11.70	7
9		46.85	8
10		30.59	9
11		59.93	10
12		89.12	11
13		37.55	12
14		26.43	13
15		93.31	14
16		2.25	15
17		16.44	16
18		55.92	17
19		52.52	18
\.


--
-- Data for Name: site_authorizationkey; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY site_authorizationkey (id, name, key, password, site_settings_id) FROM stdin;
\.


--
-- Data for Name: site_sitesettings; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY site_sitesettings (id, header_text, description, site_id) FROM stdin;
1	Test Saleor - a sample shop!		1
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY social_auth_partial (id, token, next_step, backend, data, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY social_auth_usersocialauth (id, provider, uid, extra_data, user_id) FROM stdin;
\.


--
-- Data for Name: userprofile_address; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_address (id, first_name, last_name, company_name, street_address_1, street_address_2, city, postal_code, country, country_area, phone, city_area) FROM stdin;
1	Thomas	Harper		49841 Courtney Mission Suite 707		Melvinchester	99283-9140	KH			
2	Morgan	Thompson		9544 Armstrong Causeway Apt. 298		Carrollbury	90961	US			
3	Brandon	King		678 Gardner Skyway Apt. 930		Grahamfort	75205-1663	TO			
4	Willie	Coleman		69752 Samantha Summit Suite 624		West Teresaland	12017-8526	SD			
5	Matthew	Cooper		64511 Eric Island Apt. 630		Port Julieberg	49145-3808	SC			
6	Jessica	Johnson		84100 Aaron Shore		Carterhaven	69349	KN			
7	Max	Johnson		8370 Jones Grove Suite 474		Joshuafurt	37962	GQ			
8	Jill	Griffin		59098 Ellis Spur Apt. 360		Tristanburgh	73646-4578	ET			
9	William	Anderson		222 Norma Union Apt. 252		Port Jasonchester	85900	RW			
10	Toni	Howard		962 Nicholas Cove Suite 809		West Patriciaside	75661	AU			
11	Jason	Nguyen		85033 Brown Alley Suite 668		New Melissaberg	21006	TM			
12	Robert	Klein		509 Lisa Ranch Apt. 743		Port Tonyfort	38385	GT			
13	Chad	Pearson		61941 Jeremy Union		Floresview	10087	BH			
14	Kevin	Daniels		4357 Jessica Ramp		Bakerport	34647-3579	UZ			
15	Roberto	Lynch		382 Michael Union		Hessshire	46570	MN			
16	Donna	Washington		3579 Knox Common		South Georgeburgh	82678-5171	MK			
17	Matthew	Keith		924 Rivera Village Apt. 195		Franciscoshire	53141	CH			
18	Michelle	Smith		64294 Belinda Loaf Suite 582		Port Justin	43371	HR			
19	Patrick	Irwin		91027 Rodriguez Village		Johnville	47943	GH			
20	Christian	Conrad		665 Morris Coves		Bakerland	85638-2006	BO			
21	Christian	Fisher		5531 Stephanie Stravenue		Port Brandon	33094	BI			
22	Mitchell	Mathis		85936 Monica Mount		Vaughntown	95609	CD			
23	Alan	Casey		66525 Jordan Plaza		Port Maria	39242-9124	HU			
24	Mandy	Reynolds		20032 Heather Estate Apt. 355		West Adamtown	90403	RW			
25	Jeffrey	Peterson		8892 Stacy Glen		Dawsonberg	59460-5827	PW			
26	Sandy	Parks		742 Harris Route Suite 642		North Jeffreyport	63214-7899	FM			
27	David	Mcgee		62272 Brown Branch		South Jaredfurt	71863-6087	TJ			
28	Gregory	Sanders		630 Lopez Orchard		East Ashley	27367	MG			
29	Jennifer	Reeves		9767 Chelsea Loop		West Jennaside	57785-2267	LC			
30	Derrick	Davis		6459 Bates Brooks		Kingbury	87944-4773	AM			
31	Mandy	Terry		806 Carpenter Ranch		New Shannon	55235-4815	LY			
32	Christopher	Sherman		86174 Williams Parks		Port Anneborough	45403-6279	CR			
33	Charles	Hernandez		822 Stephanie Squares		Nicoleside	81390	NP			
34	Juan	Todd		4613 David Port Suite 500		Scottbury	79153-1013	AL			
35	Kenneth	Beard		6700 Eric Inlet Apt. 611		Cruzmouth	49640	CY			
36	Michelle	Wright		88260 Brandon Isle		Reyeschester	94159	NO			
37	Brooke	Turner		168 Cassandra Junctions		North Tanya	50452-9808	VN			
38	Amber	Gordon		94429 Beasley Mountains Suite 395		Guzmanbury	74847	LV			
39	Brenda	Davies		843 Diane Cove Suite 394		Mcdonaldland	15056	KW			
40	Julia	Smith		1549 Craig Meadow		Sarabury	32283	NZ			
41	Jesse	Wheeler		151 Jackson Ville		Brownview	83395-7473	EE			
42	Gabrielle	Harrington		36606 Nicole Pass		North Samanthaburgh	40178-1671	AD			
43	Joshua	Sampson		400 Christina Lodge Apt. 433		Mistytown	88448-2148	HN			
44	Kevin	Smith		45433 Williams Cliffs Apt. 273		West Karenland	50321-6366	OM			
45	Hannah	Thompson		671 Vargas Station		East Richardstad	95678-7052	VC			
46	Eric	Myers		080 Bradley Wells		South Chadberg	58125-4614	LC			
47	Vanessa	Thomas		162 James Drive Suite 495		Leestad	33130	LI			
48	Brittany	Watson		513 Ferguson Ports Apt. 205		North Michaelberg	36106	PW			
49	William	Wilkinson		239 Greene Junctions Suite 131		West Lorishire	23462-2908	MW			
50	Nicole	Hernandez		75157 Valerie Knolls Suite 472		West Arthur	81773	BR			
51	Edward	Goodwin		4525 Wong Field		Lamfurt	05603	SI			
52	Elizabeth	Horne		1110 Brandon Fall		Macdonaldport	51944	HN			
53	Ashley	Roberts		705 Lisa Pass Suite 835		East Bryanhaven	22816-4459	JM			
54	Richard	Jimenez		281 Tran Keys Suite 048		West Jeffreymouth	31007-7545	IR			
55	Caitlin	Houston		582 Anthony Pine Apt. 884		Port Jennifer	80078	CV			
56	Rachel	Davis		021 James Ports		Taylormouth	54548-1194	MM			
57	Samantha	Cook		9266 Ronnie Glens		Rosariomouth	52887-9289	VA			
58	David	Silva		58785 Lopez Expressway		Petersmouth	96335-4775	TJ			
59	Scott	Wood		093 Johnson Green		South Timothytown	37189	IE			
60	Robert	Wright		898 Crawford Point		Petersonchester	28634-0941	CA			
61	Tamara	Oliver		208 Thomas Street		Amyport	97479-3704	NL			
62	Jennifer	Castillo		152 John Trail Apt. 534		New Kelly	33381-0239	SR			
63	Dawn	Carrillo		536 Webster Port Suite 865		Allisonborough	68121	CV			
64	Joseph	Harris		9022 Duane Village		South Jamesview	71185	GB			
65	Kimberly	Maldonado		0892 Pamela Burg		Sethside	72850	US			
66	Anne	Hood		16065 Meyers Square Suite 332		East Clinton	15279	NP			
67	Rick	Benitez		7304 Wells Camp		West Mark	14328	AG			
68	Oscar	Holland		748 Kent Stravenue Suite 275		South Meganberg	02043	LI			
69	Jennifer	Davis		483 William Overpass Apt. 353		North Kevinmouth	02457-4711	SR			
70	Martha	Hebert		3826 Roy Cape		Stephenberg	50675-2923	GT			
71	Aaron	Gray		3511 Justin Shore		South Edwardhaven	39510-7161	TM			
72	Jeffrey	Campbell		335 Thomas Lock		West Josephborough	26767-3799	SK			
73	Kim	Stevens		3333 Fisher Ford Suite 104		Ruizmouth	79843	IT			
74	Jonathan	Meyer		5732 Jeremiah Drives		Jeremiahchester	27300	GM			
75	Molly	Vance		859 Cabrera Valleys		South Andrea	99953-2793	CM			
76	Jeff	Schultz		8730 Lucas Station		Port Jessica	32424	CA			
77	Joseph	Murphy		5459 Callahan Groves		North Josephland	76616-6670	BJ			
78	Joe	Wade		765 Henry Lakes		Maxburgh	96986-3762	KE			
79	Christian	Waters		309 Campos Springs Suite 234		Crawfordview	36335-0733	CV			
80	Stephen	Burns		315 Ryan Stream Apt. 382		Mathewsfort	58145-7898	GN			
81	Vanessa	Chapman		2383 Joseph Neck Suite 407		North Robert	67202	CD			
82	Ryan	Watson		4660 Williams Village Suite 716		Lucasbury	37853	AF			
83	Tammy	Merritt		684 Lisa Shores		Thomasborough	36488	FI			
84	Elijah	Robinson		295 Bruce Forges Suite 363		Russellborough	92967-5962	MT			
85	Brittany	Bradley		1051 Gardner Field		Alexandershire	39694-8265	EE			
86	Beth	Johnston		387 Lance Expressway Suite 673		Robertfort	94652-2640	SC			
87	Vanessa	Sanders		901 Adkins Brook		Kleinhaven	82035	TV			
88	Tiffany	Torres		16921 Elizabeth Pine Suite 255		Scottfurt	99048	CZ			
89	Dennis	Duncan		27871 Laura Mountain		Port Kayla	38369-4827	RW			
90	Robert	Hill		81538 Moore Cape Apt. 113		Walterview	49996	GD			
91	Michelle	Barrett		601 Lee Tunnel Apt. 260		Lawrencefort	79542-7681	VU			
92	Dustin	Gilbert		802 Lee Trail Suite 501		Markberg	41975	IR			
93	Kimberly	Williams		12891 Lisa Mount		South Terriborough	58385	AO			
94	Sherry	Brown		716 Green Meadows		Websterberg	35285-6278	KR			
95	Stephanie	Jones		7051 Jonathan Forest		Jenniferport	58979-4073	MM			
96	Christopher	Dean		7144 Hendricks Mill		Chungview	05914-2692	BT			
97	Krystal	Crawford		84789 Marshall Inlet Suite 433		Jordanfurt	20351	AO			
98	Stephen	Foster		078 Kathleen Pass Suite 835		Port Donald	46123	TR			
99	Jeanne	Jones		655 Roberts Passage		North Jimmyfurt	98685-6800	KP			
100	Kenneth	Irwin		2197 Phillips Ferry Suite 760		Clineside	53597-5713	JM			
101	Andre	Lambert		0952 Murray Street Suite 176		North Tiffanyfurt	90044	PE			
102	Matthew	Collins		0283 Emily Inlet Suite 086		Jennifershire	46321	DJ			
103	James	Watts		64038 Sanders Stream		Port James	52753	TD			
104	Denise	Estes		6208 Michael Locks		Christopherbury	77642	JP			
105	Cory	Taylor		629 Baldwin Brooks		Grimesside	26685	AL			
106	Nicole	Castro		1296 Jones Field		Lake Paulland	71727-2760	BJ			
107	Michael	Wright		55675 Michael Isle Apt. 388		West Adrianberg	26754	AG			
108	Lisa	Browning		01157 Douglas Ports Apt. 277		Reedland	09989-9034	NE			
109	Sabrina	Smith		0363 Mcclain Fort Apt. 233		Stephensshire	85410	EE			
110	Raymond	Gomez		9307 Garcia Garden		East Jacobberg	66005-2343	HR			
111	Kimberly	Miller		5217 Jacqueline Village		North Kathleen	04964-3335	BZ			
112	Kenneth	Duran		04957 Harmon Locks Apt. 417		Port Rachelport	74340-9679	TL			
113	Oscar	Young		3075 Garrett Mountain		New Alexis	95136	AE			
114	Nicole	Ramirez		49457 Debra Port Suite 193		South Davidstad	21932	EE			
115	Robin	Boyle		4043 Hendricks Cliff		Walkerport	50794-7690	CF			
116	Juan	Bartlett		2784 Cory Throughway		Port Jenniferfurt	38521-3226	GA			
117	Christopher	Ryan		2719 Nguyen Villages		Garrettland	38507	CG			
118	Stephanie	Daugherty		543 Jacob Inlet Apt. 304		New Mary	13981-3741	FJ			
119	Matthew	Brooks		34002 Mark Pine Apt. 801		Michealmouth	46265-1532	KM			
120	Antonio	Glass		547 Tucker Points Suite 559		Hunterside	87252-4946	GA			
121	Tanner	Taylor		2763 Shannon Run Apt. 616		Darrellmouth	52214	UA			
122	Frederick	Bell		5512 Sarah Pine Suite 489		West Justin	95123	BJ			
123	Yolanda	Banks		64596 Charles Oval Suite 091		Kellyberg	06172-3161	TV			
124	Kirk	Gomez		511 Davis Highway Apt. 470		West Mirandafort	61008-6490	CF			
125	Brian	Woods		9216 Michelle Spur		Palmerfort	88969	YE			
126	Stephanie	Wilson		2738 Henderson Shoal		East Alice	53073-7381	MM			
127	Colton	Hopkins		763 Franklin Crossing Apt. 276		South Charlesmouth	80806	IE			
128	Omar	Casey		80237 Padilla Road Suite 936		Owenschester	27512-3921	IE			
129	Eric	Cole		4445 Cooke Oval Suite 423		South Jefferystad	38892	TN			
130	Emily	Adams		098 Swanson Pass		South Dylanton	41446	DK			
131	Melvin	Roberts		7671 Heather Loop		Smithfort	25655-9491	NI			
132	William	Neal		10856 Lori Junction		North Amyland	71403	BJ			
133	Kathryn	Navarro		5320 Mark Views		Port Tony	58092	GB			
134	Carol	Baker		6454 Lisa Harbors		Caldwellland	26755-8060	JM			
135	Donald	Montgomery		139 Frederick Street Suite 493		Thomasshire	63011	SR			
136	Sara	Williams		068 Brianna Islands		Robertside	06168-8214	NI			
137	Kristopher	Sanders		908 Jones Street		Lake Melissachester	31641-1593	NL			
138	Adam	Douglas		3645 Keith Mills Suite 758		East Paulshire	44879	AU			
139	Stephanie	Cunningham		00726 Mary Keys Suite 092		Lake Jeffreyhaven	52736	NA			
140	Tricia	Robinson		2399 Carroll Crescent Suite 050		West Donaldberg	14121	SL			
141	Patricia	Roberts		35684 Nicole Lodge Suite 881		North Yvonne	65087-9339	TO			
142	Kevin	Jackson		473 Jeffrey Throughway Apt. 130		North Ashleyland	97129	NA			
143	Jessica	Duncan		52801 Rodriguez Locks Apt. 688		North Brianna	57457	KM			
144	Valerie	Brooks		62351 Victor Valleys		North Bryanfurt	81730-3250	IT			
145	Rebecca	Andrade		69476 Ricky Camp Suite 599		Laurenfort	48892-0711	TH			
146	Bobby	Hudson		12262 Brent Rue Suite 374		Jamesburgh	15128	NO			
147	Dakota	Chase		209 Stacey Mountains		Sanfordport	16866-1007	CI			
148	Jill	West		232 Kristin Bridge Suite 243		New David	26852-0649	GD			
149	Kevin	Brooks		96635 Diamond Valley Suite 974		Amyshire	03186-0473	LR			
150	Mitchell	Walters		96119 Johnson Route Suite 573		New Paulafurt	78216-8478	SZ			
151	Mary	Reyes		9486 Denise Ford Suite 792		East Chasetown	49501	BG			
152	Travis	Larson		4622 Jennifer Crescent Suite 882		Melindafort	98221	AG			
153	John	Rodriguez		4567 Jennings Point Suite 189		Stephanieville	56281-1004	LK			
154	Dawn	Mann		798 Rachel Ports Suite 181		Lake George	36519	NL			
155	Stephanie	Morse		04619 Johnson Mills Apt. 046		Moralesport	69707	HN			
156	Brandon	Russell		86931 Laura Island		Bryanmouth	78093-6677	TG			
157	Sabrina	Weaver		34636 Erin Islands		Lake Daniel	14530	MV			
158	Sherry	Brown		752 Harper Ridges		Marissafort	75197	LB			
159	Joel	Stone		04409 Nguyen Port		West Elizabethborough	21303	ME			
160	Samuel	King		4212 Clark Garden		Aaronhaven	72054-0164	ME			
161	Jeffrey	Smith		438 Betty Mall Suite 076		New Nicholas	16285	PG			
162	Vincent	Miller		846 Julie Stravenue		East Nathanland	17472	SN			
163	Megan	Zimmerman		427 John Court		North Nicolehaven	32408-5719	SA			
164	Mary	Garcia		5859 Cruz Bypass Apt. 034		Lake Michael	34377	KN			
165	Jennifer	Robinson		245 Ethan Burg Apt. 336		Thompsonview	91769	SO			
166	Jill	Mitchell		718 Wilson Turnpike		Nancyfurt	89461-0271	BJ			
167	Heather	Petty		822 Larry Center		Lake Angelicafort	48172-9634	AT			
168	Lorraine	Butler		025 Dunlap Valleys Apt. 142		Phillipstad	84347-6300	BD			
169	Natasha	Blevins		258 Wesley Ports Suite 427		Dustinport	65352	PL			
170	Kelsey	Martinez		1491 Kyle Road		Robertmouth	03005	SG			
171	Rhonda	Mitchell		710 Joe Oval Apt. 231		Manuelfort	01685	CU			
172	Michael	Barnes		2975 Marie Valleys Suite 450		Lake Cory	44814-8645	IL			
173	Marilyn	Sanchez		556 Christine Crest Suite 524		Jennifermouth	87422	SG			
174	Nathan	Perez		0210 Stephanie Road Suite 288		Davidchester	72245-5653	AL			
175	Jamie	Robles		152 Carrillo Route		North Jason	14530-5771	MG			
176	Brian	James		93782 Paul Flat Suite 767		Smithshire	92874	MW			
177	Jeffrey	Huber		67088 French Highway		South Kevin	34467-0664	FM			
178	Tanya	Young		33949 Chang Pike		Port Jamie	29810-4498	NO			
179	Michael	Black		700 Ball Station Suite 644		Lake Christinamouth	68359	AO			
180	Karen	Carr		483 Trevor Rapid Suite 422		New Larrytown	81807	SN			
181	Donald	Rodriguez		7126 Smith Crossing		Watsonton	91944	BW			
182	Maria	Winters		719 Michaela Ford Suite 484		Richardburgh	37167-2149	MN			
183	Ryan	White		842 Gordon Meadow Suite 943		New Christopher	90517	NL			
184	Andrea	Hayden		182 Tamara Causeway Suite 575		North Lisa	74728	RU			
185	Frank	Gray		811 Carter Mountain		Hannahchester	62049-9812	LR			
186	Amanda	Taylor		45969 Christina Track		West Cameronchester	93428	TR			
187	David	Little		763 Stewart Road Apt. 874		Francisstad	66404	TN			
188	Christy	Acosta		10126 John Ridge Apt. 770		Gallegoston	25270-1122	BN			
189	Hayley	Clark		4238 Hall Row		East Victoriaville	60107	BS			
190	Rebecca	Woods		52974 Mary Pine Apt. 956		Parrishview	41337-6450	CG			
191	Michael	Davis		67403 Hayes Route Apt. 417		Susanmouth	97430-1163	PE			
192	Billy	Moore		0983 Estrada Overpass		Knightfort	67436	FJ			
193	Theodore	Shaw		640 Kelly Lodge		Ramirezfurt	92510	HR			
194	Michelle	Wood		24261 Reid Isle Suite 760		Jessicaborough	18360-4321	US			
195	Glenn	Olson		55799 Jackson Expressway Suite 894		Lawrencestad	55691-9683	TT			
196	David	Alvarez		202 Williams Walks Suite 884		New Brandonchester	30518	TL			
197	Megan	Goodwin		03183 James Shore		Jeffreyhaven	61736-8431	GH			
198	Gwendolyn	White		840 Brian Springs		Haletown	46276	FJ			
199	Daniel	Santana		540 Smith Shores		Lorichester	57308	MK			
200	Karen	Grant		5434 Rivera Way		Lake Lisabury	84937-0582	FR			
201	Jeffrey	Schaefer		23312 Becker Extension		Schroederton	48786-5425	SR			
202	Alexander	Warner		020 Michael Motorway		Michaelville	83430	EC			
203	Holly	Perez		48989 Harrison Place		Port Douglas	35547	FR			
204	Heather	Erickson		88814 Jill Stravenue		South Veronica	54017	IR			
205	Brian	Morris		40573 Peterson Roads Suite 352		Fordville	69005-7084	AM			
206	Andrew	White		3739 Helen Summit Suite 591		Wellschester	12542	AG			
207	Victoria	Moore		0415 Wolfe Rue		South Sarah	48698-0464	RS			
208	Samantha	Jones		33320 James Shore Apt. 599		North Kristin	11235	MG			
209	Heather	Jackson		24702 Stephanie Mission Suite 567		Smithmouth	48224	ML			
210	William	Daniels		05841 Dana Mountains		Drewfurt	52949-6372	LU			
211	Debra	Smith		8520 Reed Parks		Danielburgh	44868-2597	MU			
212	Bruce	Payne		984 Williams Flat Apt. 708		Stephenton	74324	PK			
213	Rachael	Garcia		709 Smith Ranch		Odomshire	49018	PG			
214	Dawn	Harper		820 Kristin Hollow Suite 993		Jenniferhaven	70862-3295	IQ			
215	Eric	Crawford		98308 Graham Island Apt. 895		East Arianafort	96986	PG			
216	Daniel	Kelly		642 Natalie Forge		Leviland	13248	TV			
217	Alexander	Young		6771 Reed Creek		North Vanessaton	70706-6837	AO			
218	Erin	Black		4320 Stanley Springs Suite 185		Clarkeshire	02366	BJ			
219	Mark	Stark		1716 Donna Camp		North Johnstad	60486	PK			
220	Michael	Guerra		084 Lewis Pine		Christopherhaven	78867-3648	KI			
221	Tiffany	Downs		700 Hernandez Islands Apt. 234		Phillipston	39569	GE			
222	Maria	Green		9707 Pedro Motorway		East Brian	83172	SL			
223	Michelle	Little		83562 Erik Stream Apt. 348		East Andrew	80011-5114	GE			
224	Christine	Keith		89843 Robert Meadows		Hartmouth	33001	IE			
225	Elizabeth	Gonzales		64100 Scott Tunnel		East Geraldbury	69922	MM			
226	Tom	Brown		106 Dorothy Spurs Suite 492		South Kyletown	30529	CY			
227	Christopher	Scott		34311 Robert Meadows Suite 401		New Holly	75639-8700	GH			
228	Kathryn	Castillo		8982 Laura Springs Suite 546		Roseborough	26858	AT			
229	Tammy	Schneider		3451 Sonya Isle		Manuelhaven	75154	MX			
230	Jack	Davis		0804 Janet Valleys Apt. 499		West James	04870	CN			
231	Dustin	Williams		074 Elizabeth Drive		Berryview	36103	BG			
232	Raven	Phillips		430 Vargas Summit		North Kathleenview	82722	MY			
233	Lisa	Bennett		8615 Rita Views		Smithfurt	25901-6974	MU			
234	Aaron	David		177 Michael Junctions Apt. 724		Mejiaside	91401	RW			
235	Brianna	Bailey		76151 Cheryl Plaza		North Barbaramouth	18911	SE			
236	Bridget	Richardson		87458 James Viaduct Suite 504		Port Desireeshire	44213-0104	NA			
237	Debra	Howard		146 Haas Knolls Apt. 369		North Jacquelinebury	60482-9434	VU			
238	Tammie	Vance		84621 Aaron Forges		Conniehaven	31884	MD			
239	Elizabeth	Barnes		231 Tanner Pike Apt. 582		Gillhaven	68090	LT			
240	Laura	Myers		925 Mark Walk		Murphyville	20118	ZW			
\.


--
-- Data for Name: userprofile_user; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user (id, is_superuser, email, is_staff, is_active, password, date_joined, last_login, default_billing_address_id, default_shipping_address_id) FROM stdin;
1	f	thomas.harper@example.com	f	t	pbkdf2_sha256$36000$Kf2qSoqwzdtl$hgj8JXmDNVdWekSyegVg4f1O+8Kokc2uPg0Zh0UdCLg=	2017-11-22 20:26:57.198498+00	\N	1	1
2	f	morgan.thompson@example.com	f	t	pbkdf2_sha256$36000$rvWvrPBKZwVV$SBK2feMx385G9dxh/kccBM7S5e4mCWniv7x9V9I4hX0=	2017-11-22 20:26:57.290496+00	\N	2	2
3	f	brandon.king@example.com	f	t	pbkdf2_sha256$36000$C4tcXiiqGnHe$9+LSQPy9OB/JgBPBjH0x2NTfkon3WyD/5En3lkGI/r4=	2017-11-22 20:26:57.387409+00	\N	3	3
4	f	willie.coleman@example.com	f	t	pbkdf2_sha256$36000$t7W3o6g6RI1a$WH4E/Im+l/ExjjaOQcBADxIFpf+ZeqUatf4AvJoAPYU=	2017-11-22 20:26:57.490102+00	\N	4	4
5	f	matthew.cooper@example.com	f	t	pbkdf2_sha256$36000$NY1z4HWPcqrJ$prwGok7KMNN/uxYdxeId4yVQbOc+lo1w8pSsRR0JFEc=	2017-11-22 20:26:57.588004+00	\N	5	5
6	f	jessica.johnson@example.com	f	t	pbkdf2_sha256$36000$w7pDanWzaIRY$iMwMv2wUYK7/T5vpzM5C7Lmk2vAVLAYaun5TO43uuNc=	2017-11-22 20:26:57.674951+00	\N	6	6
7	f	max.johnson@example.com	f	t	pbkdf2_sha256$36000$xzGurVWrUAuO$i2en5nDA2OF1TPPc+kwXWek47seg6DYHm9LpiN99Oew=	2017-11-22 20:26:57.763764+00	\N	7	7
8	f	jill.griffin@example.com	f	t	pbkdf2_sha256$36000$9kcsYcn3SdZr$cSnbAcTTMsuqNjqWz9mT4LFpc+UGnM0E6Oywr1jIaCc=	2017-11-22 20:26:57.844709+00	\N	8	8
9	f	william.anderson@example.com	f	t	pbkdf2_sha256$36000$gzZQawHNfu69$TKUsICr+5J38sue5+8uO/KMuncLg4g+3JvzSTrOtq8k=	2017-11-22 20:26:57.936301+00	\N	9	9
10	f	toni.howard@example.com	f	t	pbkdf2_sha256$36000$T9xSy5AUu3Vk$taeHM/DwcBWblOzM7TXWx1BQxntJRxKfmxfYo7KyNqU=	2017-11-22 20:26:58.027269+00	\N	10	10
11	f	jason.nguyen@example.com	f	t	pbkdf2_sha256$36000$Kxtnf7OLlUqR$8ItW4+USZzGuWNKhFBm1RrxXCE7O1H+b7burzQud9us=	2017-11-22 20:26:58.1187+00	\N	11	11
12	f	robert.klein@example.com	f	t	pbkdf2_sha256$36000$hH8aV1UmBoLc$rS8sHD1+KoVFFm8ROgYMA43sjtpI3KZ9uPwIoUoLCgc=	2017-11-22 20:26:58.203617+00	\N	12	12
13	f	chad.pearson@example.com	f	t	pbkdf2_sha256$36000$zGozSibdiF5O$DG/p3r1NecIyZce1IxUeEM4jWaUHbtKhhAvQ6ixP6Zc=	2017-11-22 20:26:58.289135+00	\N	13	13
14	f	kevin.daniels@example.com	f	t	pbkdf2_sha256$36000$Wug5QtZqvDQQ$PZ7A7PMonnEBBAQf2ycKtJen+fq1y1sX2nuAHtMA3Tg=	2017-11-22 20:26:58.385174+00	\N	14	14
15	f	roberto.lynch@example.com	f	t	pbkdf2_sha256$36000$NAgIDuOuE2kD$E/gVJfYKnp9QWo7UtyQzlGgaodb+78+04+33X1nibJU=	2017-11-22 20:26:58.503189+00	\N	15	15
16	f	donna.washington@example.com	f	t	pbkdf2_sha256$36000$vE8ZSPn8cjn9$1oCaCgRJQRE68F0xbqO05Y9OCrTvOG2k3tluihJhJgA=	2017-11-22 20:26:58.597973+00	\N	16	16
17	f	matthew.keith@example.com	f	t	pbkdf2_sha256$36000$8DlruiwKFKqP$LpY1OR3uLO7kITS2C2Hwj7jhZcQECfaMHWn/nzJOyeE=	2017-11-22 20:26:58.688782+00	\N	17	17
18	f	michelle.smith@example.com	f	t	pbkdf2_sha256$36000$6m2WbXgEhcWM$PCWw8GFT9dw0WsE3QMTJgYRfXTtP+QhOHumlR/h6GSo=	2017-11-22 20:26:58.790462+00	\N	18	18
19	f	patrick.irwin@example.com	f	t	pbkdf2_sha256$36000$5dOI1erOLyi9$AN2dXgO2ouL9kJm6HtlkT+8zg/UNUcxna1wV58UY5Yc=	2017-11-22 20:26:58.880995+00	\N	19	19
20	f	christian.conrad@example.com	f	t	pbkdf2_sha256$36000$AdlbjPcHGGeX$k8aJOeSnXm7n8PFb9+GuU8ZULsjpO0FaTxqGbW3zgqU=	2017-11-22 20:26:58.989789+00	\N	20	20
21	f	derrick.davis@example.com	f	t	pbkdf2_sha256$36000$FUljIv0vOiTN$5+OCnKZnXKFXFH6kiw8m7d7Dq2WJblLndohunBlJJq0=	2017-11-27 23:21:09.684551+00	\N	30	30
22	f	mandy.terry@example.com	f	t	pbkdf2_sha256$36000$YWyUobhJyMxK$4wPA+8+RsJSaRCLJsuaKHwP4jJl3lSU7lhOyoSGk7Zg=	2017-11-27 23:21:09.754616+00	\N	31	31
23	f	christopher.sherman@example.com	f	t	pbkdf2_sha256$36000$jJlSTrm2oh2i$61XytWZbHlqvt2WLNYvHYcbYdcI36F5IexiZQ14iIPc=	2017-11-27 23:21:09.823189+00	\N	32	32
24	f	charles.hernandez@example.com	f	t	pbkdf2_sha256$36000$DGOoVMjGAU2j$Uq0YdfFB0+XmjWJsRXx2ppwZFrEESGsJqp/IPMxJnrg=	2017-11-27 23:21:09.889776+00	\N	33	33
25	f	juan.todd@example.com	f	t	pbkdf2_sha256$36000$TrnPzf2QyzIt$4/0nf4lorJ1gGZKeTffvCot2SBUyQwuZcM0mHk+1ME8=	2017-11-27 23:21:09.95937+00	\N	34	34
26	f	kenneth.beard@example.com	f	t	pbkdf2_sha256$36000$ieCaTibyPe4d$pBdpSbn2gDGHLCgAjzNpia+hS5AOXxUDqYFdi7pTjtY=	2017-11-27 23:21:10.026427+00	\N	35	35
27	f	michelle.wright@example.com	f	t	pbkdf2_sha256$36000$n9kY6zZrfQY4$FJWfQz190A7e1W9B2qAuoJHjIbHbWwwduBWiAJlFmjY=	2017-11-27 23:21:10.094913+00	\N	36	36
28	f	brooke.turner@example.com	f	t	pbkdf2_sha256$36000$KYOd1IziUjvC$OZyPDnC4m+kH7NUmADjuR51ivJzkowSwZ3paYtcJWj0=	2017-11-27 23:21:10.161258+00	\N	37	37
29	f	amber.gordon@example.com	f	t	pbkdf2_sha256$36000$XnBwUHxSgpSB$a4ABDV7GzyufguIWh28HyKg4bg5nXbCOT+cfCt3DCsk=	2017-11-27 23:21:10.236518+00	\N	38	38
30	f	brenda.davies@example.com	f	t	pbkdf2_sha256$36000$U5JIuyJ84ZNz$bSmgIQijH3cMmVi19X14Whkzgnh3506F8FVwzAjmf2o=	2017-11-27 23:21:10.310827+00	\N	39	39
31	f	julia.smith@example.com	f	t	pbkdf2_sha256$36000$ylEzUm21Qrkc$Rup7eKkSnuQH13SUl1KixfJVd7Phn/UhT9SGzj512D8=	2017-11-27 23:21:10.373305+00	\N	40	40
32	f	jesse.wheeler@example.com	f	t	pbkdf2_sha256$36000$15byG2cerLup$88ZW//QacvVqthv5kTBjOm7phhWmgHaUQqWC1jzDrec=	2017-11-27 23:21:10.437923+00	\N	41	41
33	f	gabrielle.harrington@example.com	f	t	pbkdf2_sha256$36000$4XKF5uCmUIM4$e2woIpyX0QzKG+iCdFNC2BOEGwqsmOFE6zFevc30dzM=	2017-11-27 23:21:10.508759+00	\N	42	42
34	f	joshua.sampson@example.com	f	t	pbkdf2_sha256$36000$JfrKbVulgfuh$Kn8kQcGXozEKrpozxzxSZqSUBNYQRB8usVJswnT1uqc=	2017-11-27 23:21:10.572624+00	\N	43	43
35	f	kevin.smith@example.com	f	t	pbkdf2_sha256$36000$IvV7R9RsxZmU$naZFxHaFfSlfdZ5BXdYeqhUkjdqyF4/Veq0ndVV/IhM=	2017-11-27 23:21:10.640781+00	\N	44	44
36	f	hannah.thompson@example.com	f	t	pbkdf2_sha256$36000$EC0qNW6BJQ1X$agJFdAPgA/ZmZvyJxz3EW6wLtBjOPwcMt0qK+XWa8KU=	2017-11-27 23:21:10.706978+00	\N	45	45
37	f	eric.myers@example.com	f	t	pbkdf2_sha256$36000$8aBYNNEJbS2p$3sQ5r+7mKeAzZ4cWoCzR2djMmvgsYSkjEN3w24Fo0/0=	2017-11-27 23:21:10.774791+00	\N	46	46
38	f	vanessa.thomas@example.com	f	t	pbkdf2_sha256$36000$pv82W0nVHBII$4w8/JqsRyjNtBSPU+C1t4lgWs/UMl0CrclEkOsVt7Co=	2017-11-27 23:21:10.841244+00	\N	47	47
39	f	brittany.watson@example.com	f	t	pbkdf2_sha256$36000$Sib2fgTlTHIp$dIX+Vhp3JJeEtMtr7MiyRzsLOgBPtFEq5bKx1aAKbr8=	2017-11-27 23:21:10.902332+00	\N	48	48
40	f	william.wilkinson@example.com	f	t	pbkdf2_sha256$36000$HyESRjuNBAXh$WyS7lprvUh43UhCB1ho6RXYHdDotuetWPfadDlggyrE=	2017-11-27 23:21:10.978346+00	\N	49	49
41	f	samantha.cook@example.com	f	t	pbkdf2_sha256$36000$7OH3Nm7w6ez0$UqniB7MXbh6PVD0Bl1jY/XPjoRZoP/ADV/huROfRB3M=	2017-11-27 23:30:50.562574+00	\N	57	57
42	f	david.silva@example.com	f	t	pbkdf2_sha256$36000$rNJQbOQdZkau$oroR6jSbU8vBUpM4CWTt54Os/OdzZYz9AJgxZzK5XYg=	2017-11-27 23:30:50.624717+00	\N	58	58
43	f	scott.wood@example.com	f	t	pbkdf2_sha256$36000$fQGYPuIT41WE$IUeXMQCuNMttX8E8nQoNQW0hI2/T9gi4KFbnm0myVZE=	2017-11-27 23:30:50.680112+00	\N	59	59
44	f	robert.wright@example.com	f	t	pbkdf2_sha256$36000$dDGFhVMGfzvH$QNsSwRFZ4eMGQ+w5zFnmqWMSEAlzpbkbN8LPbnUVZcc=	2017-11-27 23:30:50.735163+00	\N	60	60
45	f	tamara.oliver@example.com	f	t	pbkdf2_sha256$36000$8vA6aWL7o088$kypERe7jCLuD5tRnZ14JZCmijrAyaXMEdmEY0frgWE8=	2017-11-27 23:30:50.78871+00	\N	61	61
46	f	jennifer.castillo@example.com	f	t	pbkdf2_sha256$36000$2i8nPD6NtK68$mdW7KgNY6XQdhZNPRHqe8CmrJpSHAYU0cJ6mV9TIRuI=	2017-11-27 23:30:50.846534+00	\N	62	62
47	f	dawn.carrillo@example.com	f	t	pbkdf2_sha256$36000$o3hmH10nrg7R$CDa3medkeOyFig39m+IHfhXmVCLk0jQB534M/lpzutY=	2017-11-27 23:30:50.902507+00	\N	63	63
61	f	beth.johnston@example.com	f	t	pbkdf2_sha256$36000$w6m7SpGp4yvm$4XN1FZdW1xszH/YAOqVlE5ulF422Ut/fmJnekDUduG0=	2017-11-27 23:49:14.43934+00	\N	86	86
48	f	joseph.harris@example.com	f	t	pbkdf2_sha256$36000$LAzNznMyxhRw$9onsSFBKlRN65DpCAFAUArGt4gVcrOzBfaP6Dm3sN3E=	2017-11-27 23:30:50.960481+00	\N	64	64
134	f	michael.davis@example.com	f	t	pbkdf2_sha256$36000$zG5qhHmRZ2L0$n+dHNi8zM6RDojz5LDCHXvnmR3F4ErkU+k4WNdSN04I=	2017-12-03 17:37:31.780749+00	\N	191	191
49	f	kimberly.maldonado@example.com	f	t	pbkdf2_sha256$36000$Fxab6blUXfLg$3UGzRbxiSSSZrF0JoAWgkhUsHB98DED+u6nkdv/spHU=	2017-11-27 23:30:51.018816+00	\N	65	65
62	f	vanessa.sanders@example.com	f	t	pbkdf2_sha256$36000$6NzK0j1LBFlV$6U4s5jn6ednanfvV4N9e2SwJHLxb5JAusY71hF1xROM=	2017-11-27 23:49:14.533423+00	\N	87	87
50	f	anne.hood@example.com	f	t	pbkdf2_sha256$36000$ZczwYK7lA0su$xEx66tCK3vH8/Nx00hx7sIFfTo5Hja+372IOOepUPSc=	2017-11-27 23:30:51.075768+00	\N	66	66
51	f	rick.benitez@example.com	f	t	pbkdf2_sha256$36000$2DiLR4zqnqlu$UgJkhRo9CC0RBHzxGdZqUtVM6bBdcMCkfhDsU2VzYxg=	2017-11-27 23:30:51.130167+00	\N	67	67
63	f	tiffany.torres@example.com	f	t	pbkdf2_sha256$36000$plyz90Ogh322$OpwgI3kHrWHY4ht2JIjMGdo6RQ314QmUgQHJstqrZvI=	2017-11-27 23:49:14.620641+00	\N	88	88
52	f	oscar.holland@example.com	f	t	pbkdf2_sha256$36000$dXdtiJNpxjlk$gUBujHEjq1oCRzCtkT+r9jwmeDaVK3dIDAVBwYwg1G0=	2017-11-27 23:30:51.183137+00	\N	68	68
53	f	jennifer.davis@example.com	f	t	pbkdf2_sha256$36000$8XmURI7GXtb7$7ZMdtM/IPRYEYIkeZOXGZ9ULOQedaytlmGbWf/r+QbU=	2017-11-27 23:30:51.231558+00	\N	69	69
64	f	dennis.duncan@example.com	f	t	pbkdf2_sha256$36000$dn4Ygw4NV0zC$ZD/jBTbqUZCFtIlNFT/+gxUf/5mqgj+NXEVRRSWtpfU=	2017-11-27 23:49:14.698126+00	\N	89	89
54	f	martha.hebert@example.com	f	t	pbkdf2_sha256$36000$EyNSsIGbre1S$mb02krciitSXnl9t/896iiwGm1C5xGmP+/v8V390em0=	2017-11-27 23:30:51.287481+00	\N	70	70
55	f	aaron.gray@example.com	f	t	pbkdf2_sha256$36000$eYuFfUKcPfa8$7JVvObahupwfRu9cip3ZIACvA9d2AVQ+9R+FBPQCu8U=	2017-11-27 23:30:51.343313+00	\N	71	71
65	f	robert.hill@example.com	f	t	pbkdf2_sha256$36000$HCkdJwbgWCpS$VmGKR0KJqW8FXtJYFseURZypWDMK4bsWp96qwrGaf60=	2017-11-27 23:49:14.783342+00	\N	90	90
56	f	jeffrey.campbell@example.com	f	t	pbkdf2_sha256$36000$d7VVpVsQ7ojp$c8Z0jWxlfkhOBzvRM1eMSlILjKKJ6D0qWLR0M9jPdvE=	2017-11-27 23:30:51.400267+00	\N	72	72
57	f	kim.stevens@example.com	f	t	pbkdf2_sha256$36000$wkxWxBBOVntx$W4UkOMn7l4nHO1l0c3XghaKKXaCjzDxvgad2S+ZNNho=	2017-11-27 23:30:51.460269+00	\N	73	73
66	f	michelle.barrett@example.com	f	t	pbkdf2_sha256$36000$0HRdWVQTjsXW$4IZhAdq8B87ud4LCuhWoRNaG0nz2qJeOc0CJjt8BSII=	2017-11-27 23:49:14.859069+00	\N	91	91
58	f	jonathan.meyer@example.com	f	t	pbkdf2_sha256$36000$YuTCMX6GMjYW$GT0beCh658QDNSM8t7FMBkwtNeXzWM8NgW5BBTCE1L4=	2017-11-27 23:30:51.518891+00	\N	74	74
59	f	molly.vance@example.com	f	t	pbkdf2_sha256$36000$hRClbwy40FrB$PF22ooBUB1SISfYljx87A3c9NMp0lc1UYA3j0Tym9cY=	2017-11-27 23:30:51.576694+00	\N	75	75
67	f	dustin.gilbert@example.com	f	t	pbkdf2_sha256$36000$bDiqt1s1reZp$c9uYIPvnN9FCTmPYO+FfGA6NPQ8i4ftPijiuiWrGcuI=	2017-11-27 23:49:14.935762+00	\N	92	92
60	f	jeff.schultz@example.com	f	t	pbkdf2_sha256$36000$zUsSUv6twaNq$DIgwKHAKlyHObJzfQmOMbg7XNaxjMirQ68OU5znUJpE=	2017-11-27 23:30:51.635325+00	\N	76	76
68	f	kimberly.williams@example.com	f	t	pbkdf2_sha256$36000$qndFRumrgS0t$C67jpKa2drKtCAXTVhcvozu7BxSvYDUcS4luRoJOYik=	2017-11-27 23:49:15.014342+00	\N	93	93
69	f	sherry.brown@example.com	f	t	pbkdf2_sha256$36000$iErYgVGhsCgb$zJmN9xWNdlfks/gp0GRmL6aISSCXOJaZZqx+wPl/Ei0=	2017-11-27 23:49:15.096401+00	\N	94	94
70	f	stephanie.jones@example.com	f	t	pbkdf2_sha256$36000$LlQnzxUzmiPf$KNIFQJgBw4APH3WApHnG+Z93HBaBSTXISMQ4TgzgWKA=	2017-11-27 23:49:15.174155+00	\N	95	95
71	f	christopher.dean@example.com	f	t	pbkdf2_sha256$36000$s1pioUiMTOsA$5qcMfVLL4oy8mZRysCfs2S3nMRoOEhQo5GHPioLwg/4=	2017-11-27 23:49:15.255051+00	\N	96	96
72	f	krystal.crawford@example.com	f	t	pbkdf2_sha256$36000$aJSgv4zHYOOz$bKMEk7yj5uGLK7zGQbyDSf5aYmtLvLwdT4o3BMaG6zU=	2017-11-27 23:49:15.336131+00	\N	97	97
73	f	stephen.foster@example.com	f	t	pbkdf2_sha256$36000$9Wrl9ZXJV4XJ$J4ylUEwAAu1gTjOuJfW9HNLN9iWqAcbUCAP2xSswkUI=	2017-11-27 23:49:15.417796+00	\N	98	98
74	f	jeanne.jones@example.com	f	t	pbkdf2_sha256$36000$GBuuLUMACa40$NUi9HPd6BPE/9ZLD4vvV39FlLV7ifrxddty0dV7EO7Q=	2017-11-27 23:49:15.460184+00	\N	99	99
75	f	kenneth.irwin@example.com	f	t	pbkdf2_sha256$36000$JgseHqrYcvsL$nU6hApGo9MJQdX7nHa5+Tjq1HEDCuvAR7RtVY5UnilA=	2017-11-27 23:49:15.504826+00	\N	100	100
76	f	andre.lambert@example.com	f	t	pbkdf2_sha256$36000$JPYtceOa7RyN$uILjEQIAHBQqTZdfuJGNPN2hbPyqQHv87Z2tVKMNJTQ=	2017-11-27 23:49:15.55887+00	\N	101	101
77	f	matthew.collins@example.com	f	t	pbkdf2_sha256$36000$cE37T8aasxJ0$HAzPD81XwgVUrn+HS0OP7qyl7OjvbhBPhAZL4rh8cwE=	2017-11-27 23:49:15.655929+00	\N	102	102
78	f	james.watts@example.com	f	t	pbkdf2_sha256$36000$oqbJRYdM2F9W$OKh/6YTDD/k0WoVLZWRVdiiLJJgy4xU3Xoy1lby4kyU=	2017-11-27 23:49:15.731118+00	\N	103	103
79	f	denise.estes@example.com	f	t	pbkdf2_sha256$36000$F4d2kjnQyafY$PM1QWb9U/2H7hskdyz+1ay6FX0hoKa2GwUnP7vMBe2I=	2017-11-27 23:49:15.808436+00	\N	104	104
80	f	cory.taylor@example.com	f	t	pbkdf2_sha256$36000$bQzGYk8ytDB8$dc8n4TBqKpy/KtFuFA50mm+sPrl+andCHZpI+xx8+Vs=	2017-11-27 23:49:15.884953+00	\N	105	105
81	f	stephanie.daugherty@example.com	f	t	pbkdf2_sha256$36000$7cXCWEYox3Uh$B38K1ryySMrhN9wsba3g9F3cKV/ko2xVFOe6AMkOFQg=	2017-11-28 00:10:06.076843+00	\N	118	118
82	f	matthew.brooks@example.com	f	t	pbkdf2_sha256$36000$q6iDiz1bv6SJ$AG737/9nsyWyDNjOc62X6RNXwNP62p6u/JE6Ikwg5lc=	2017-11-28 00:10:06.162171+00	\N	119	119
83	f	antonio.glass@example.com	f	t	pbkdf2_sha256$36000$6bX3FwIvfzeH$g7Nt7GjXqsH3AKGvm2+WYEAlBEbra0ZeFbdqQ/jKtb4=	2017-11-28 00:10:06.242129+00	\N	120	120
84	f	tanner.taylor@example.com	f	t	pbkdf2_sha256$36000$R9yaAgqSKrXw$UlzYOzwTGAuZ69KFlN4rGV7LYD+TOUA6ROCQK/r1nuw=	2017-11-28 00:10:06.31772+00	\N	121	121
85	f	frederick.bell@example.com	f	t	pbkdf2_sha256$36000$zMh4TpiOIYeE$ktqUf+YXj9l5BE+y41Qy8aITZBgBbdmuXPFEcO9mOC0=	2017-11-28 00:10:06.403941+00	\N	122	122
86	f	yolanda.banks@example.com	f	t	pbkdf2_sha256$36000$da8jE5MGof1z$4imKdqK8LOYru7Bm/kfm2MLajx8kML9YWFMunu7p+C0=	2017-11-28 00:10:06.485221+00	\N	123	123
87	f	kirk.gomez@example.com	f	t	pbkdf2_sha256$36000$Q1aUoseC6Y6U$rjB8yWgVFIkPCoeK4qw6tf+AKFZWriTNgwDPX+b6pcc=	2017-11-28 00:10:06.570631+00	\N	124	124
88	f	brian.woods@example.com	f	t	pbkdf2_sha256$36000$SscVBfmlH5PK$PyJULWiU3Ua8guSAzkJ8Bda+yO+QbXNxIPmCs9jgkRM=	2017-11-28 00:10:06.659278+00	\N	125	125
89	f	stephanie.wilson@example.com	f	t	pbkdf2_sha256$36000$L4gGXbtYn1VF$elYFhWgIx8etp/io9vyRXQ8+vG+TtyF2o8v0iQxEbk0=	2017-11-28 00:10:06.737566+00	\N	126	126
90	f	colton.hopkins@example.com	f	t	pbkdf2_sha256$36000$KZ2MLFoRu0OJ$GRe56nzGyZVc5MF3krEm26qexbzTjMDIg49D8XcMsL0=	2017-11-28 00:10:06.805964+00	\N	127	127
91	f	omar.casey@example.com	f	t	pbkdf2_sha256$36000$xVJ6vkGUi2Z7$NjegVBSMTzoPtRlsF6X7hCVFjFlVVQwNbuFGjg1bkvQ=	2017-11-28 00:10:06.881376+00	\N	128	128
92	f	eric.cole@example.com	f	t	pbkdf2_sha256$36000$owfqaEH6Eixt$3KMREGes+Qsq9RIlpE5S9TCbKh8i23AzS7LPfWSmYFs=	2017-11-28 00:10:06.954062+00	\N	129	129
93	f	emily.adams@example.com	f	t	pbkdf2_sha256$36000$o0s0f3MQyVyN$y3Mah62W0kP3h8eE4PDadmPT0QwiY8xoHvc/GPU7L4Y=	2017-11-28 00:10:07.026428+00	\N	130	130
94	f	melvin.roberts@example.com	f	t	pbkdf2_sha256$36000$8VKmgj35GyyV$8ro9rkQq/ntajID8JgigzTB/OKJ0C6zEacxemprk5hY=	2017-11-28 00:10:07.106233+00	\N	131	131
95	f	william.neal@example.com	f	t	pbkdf2_sha256$36000$IYEGzR0NAJEM$OEXeJK61bXbhK7KFfnSctNb7YNodQXuATja1clfDhZc=	2017-11-28 00:10:07.179107+00	\N	132	132
135	f	billy.moore@example.com	f	t	pbkdf2_sha256$36000$35ru0Tt2rPmy$U6nyi89mwbIN0EDiXglcF8K8KroQipAk58TjWviC5AY=	2017-12-03 17:37:31.892609+00	\N	192	192
96	f	kathryn.navarro@example.com	f	t	pbkdf2_sha256$36000$ycrhR0WRM7q3$FxpZLqVkoU8FHM43a8mcHngUsSom0lj4cXYb6puK5Ks=	2017-11-28 00:10:07.251321+00	\N	133	133
97	f	carol.baker@example.com	f	t	pbkdf2_sha256$36000$D8KXWfSws8Z5$B5SObNWwOLPAJz1LGFB+EcIy7O3IXJyxjXMlEpKdOn4=	2017-11-28 00:10:07.317822+00	\N	134	134
136	f	theodore.shaw@example.com	f	t	pbkdf2_sha256$36000$an0YbNhDHx3e$yPw9Bj3fg5z7EBlx9D1QoWFM+7cQegdfhXX7fZQ9kWc=	2017-12-03 17:37:31.99487+00	\N	193	193
98	f	donald.montgomery@example.com	f	t	pbkdf2_sha256$36000$jigdsGQoMfPm$jTkBBBg+0fCKAVTg9NgNY8cEK5mCyAO9iLndmzSc1UM=	2017-11-28 00:10:07.375185+00	\N	135	135
99	f	sara.williams@example.com	f	t	pbkdf2_sha256$36000$jUFIC8GRlgy5$FE6qmzMA9ZU9GxA+EaL23EQRxKEb2gbNIH+8pvLdi2E=	2017-11-28 00:10:07.444536+00	\N	136	136
137	f	michelle.wood@example.com	f	t	pbkdf2_sha256$36000$4KcsFiMeKr2K$+KMX8jxF6z3DI8AOXiFJOxL9tMpMaYC38khOWvKgi7A=	2017-12-03 17:37:32.116269+00	\N	194	194
100	f	kristopher.sanders@example.com	f	t	pbkdf2_sha256$36000$mRX9KIqY2BvY$hLz+Yd4wGCPqRclFqCoR+jBK7Z0g0tVXJuWGhCkgSTU=	2017-11-28 00:10:07.52321+00	\N	137	137
101	f	bobby.hudson@example.com	f	t	pbkdf2_sha256$36000$IROFQ3VAo6ZF$wy1VjMJk/cZkf6FR3W6rNnTBwYFqxfApWcS3eiDF+NA=	2017-12-02 22:21:10.075819+00	\N	146	146
138	f	glenn.olson@example.com	f	t	pbkdf2_sha256$36000$PQY0AdEoG13t$IR6AxCfttuGnfpiJHFS9d5DGlDiSufkdLitZWWlWTSw=	2017-12-03 17:37:32.205008+00	\N	195	195
102	f	dakota.chase@example.com	f	t	pbkdf2_sha256$36000$dEeSLWK2PCYy$YJ/V9ysUSzn/nXdOOl9CITxGnr/6BuFo6Do3nn2Muc4=	2017-12-02 22:21:10.164278+00	\N	147	147
103	f	jill.west@example.com	f	t	pbkdf2_sha256$36000$RcNEaCJy6tGM$mvxSrHIjTFnjTQz3FJbn6f80znL/OLNIPE6dkA20p7g=	2017-12-02 22:21:10.245407+00	\N	148	148
139	f	david.alvarez@example.com	f	t	pbkdf2_sha256$36000$vx7dQx9hNscL$Q3depZ0qIPd9985EuHres8mft9GP1obNJX/Sd9+ADj4=	2017-12-03 17:37:32.287019+00	\N	196	196
104	f	kevin.brooks@example.com	f	t	pbkdf2_sha256$36000$HMnxSAPWRbo2$5bHa1UqpFzE4Hd4mwudiMSA49ZjIPWuQo7WGygD+L1g=	2017-12-02 22:21:10.326573+00	\N	149	149
105	f	mitchell.walters@example.com	f	t	pbkdf2_sha256$36000$DVll2NJKK4wU$LMJdQolWmTo3Ml0sPvnfzgSQYuOjLSPR2k+xC2J7sio=	2017-12-02 22:21:10.4092+00	\N	150	150
140	f	megan.goodwin@example.com	f	t	pbkdf2_sha256$36000$2Ljy3bBEijlL$WUMFlgtrJz+DkZnXfR62Ch1IaNWUbtNMLmUwGMOULTs=	2017-12-03 17:37:32.382186+00	\N	197	197
106	f	mary.reyes@example.com	f	t	pbkdf2_sha256$36000$wNpqXb2qyfrq$d9Y4aOb/1PUmJgFPUwHevHTUrbTSf9PxfikmonzbagM=	2017-12-02 22:21:10.492387+00	\N	151	151
107	f	travis.larson@example.com	f	t	pbkdf2_sha256$36000$CCkIVptz1wVN$j+X82cb5ItlFZUdZgiLZeQ8rAqyq4iB+gmDmjMtMp5w=	2017-12-02 22:21:10.568404+00	\N	152	152
141	f	gwendolyn.white@example.com	f	t	pbkdf2_sha256$36000$KXrX7JQJTiu5$q2YNCjIyNsDj7DzaZ4s80o4nvqlnSSArmVqhWfSyt2c=	2017-12-03 17:37:32.457603+00	\N	198	198
108	f	john.rodriguez@example.com	f	t	pbkdf2_sha256$36000$sUGUTxAN0Co1$pmvAIrJaljDGNRQdPuj4qpC5mXXe7uNVUOb6wXlu7uI=	2017-12-02 22:21:10.646186+00	\N	153	153
109	f	dawn.mann@example.com	f	t	pbkdf2_sha256$36000$pJb6PqKsWiMs$1Yfy6qrG0sMmma1SR23Fg0lfQpeSmMMtBIJuL7fI8yw=	2017-12-02 22:21:10.720347+00	\N	154	154
142	f	daniel.santana@example.com	f	t	pbkdf2_sha256$36000$DqmhOcbgsdty$YtvPaj0B0FarJLDhfS/P4VCCZqUzK4DdAfyhsjC44Wg=	2017-12-03 17:37:32.54183+00	\N	199	199
110	f	stephanie.morse@example.com	f	t	pbkdf2_sha256$36000$ECsv5K3QLA9A$aPmFmwONWRrlX/sNDuLmj38wjgLJ2lks7CLbeUULIBM=	2017-12-02 22:21:10.776698+00	\N	155	155
111	f	brandon.russell@example.com	f	t	pbkdf2_sha256$36000$BiYrgogdpfrK$82/GUH8M1yVCZvO/2PTwFfffNUW+A0HhqNCX/6wXFxg=	2017-12-02 22:21:10.820713+00	\N	156	156
143	f	karen.grant@example.com	f	t	pbkdf2_sha256$36000$0VFTUPkfwO0c$6Kg/ZmFpjGWZ2gArDmRBKcD0an1aRwF7L4H5wxQ/suA=	2017-12-03 17:37:32.632626+00	\N	200	200
112	f	sabrina.weaver@example.com	f	t	pbkdf2_sha256$36000$0iyEYJVTQB8j$23IgL4IZPTe27dnt1gTLwMTXoTIPmFj2mJQ3pBtqd+M=	2017-12-02 22:21:10.870457+00	\N	157	157
114	f	joel.stone@example.com	f	t	pbkdf2_sha256$36000$kkqjulQmJT1j$r/J+sgKMvLnoqs5PXzWaww727wVIUnDWZKT8dP4Oouk=	2017-12-02 22:51:36.166147+00	\N	159	159
115	f	samuel.king@example.com	f	t	pbkdf2_sha256$36000$RAAQSByezdR5$Hu+ZV7f9zLdTyO7fmxEoN+ZYSN0HgpR4rz7Iv7mQyxc=	2017-12-02 22:51:36.245635+00	\N	160	160
116	f	jeffrey.smith@example.com	f	t	pbkdf2_sha256$36000$rZnf7U4wGIG3$qoysLNwb2gZasQ2Qj3WGMqELBrdyNzSRrnYxIhXWpc0=	2017-12-02 22:51:36.316422+00	\N	161	161
117	f	vincent.miller@example.com	f	t	pbkdf2_sha256$36000$KUq5oSettRnQ$ph6WLvpBWG5aFPdrueLTM9/W7rgtl84qr/Sx6uAL9Sw=	2017-12-02 22:51:36.368014+00	\N	162	162
118	f	megan.zimmerman@example.com	f	t	pbkdf2_sha256$36000$PwttnkAFQrt5$Xm4C+22L1Jrh25grPh9pgrJ/1iW2SloBbDd5bE5MyS4=	2017-12-02 22:51:36.423349+00	\N	163	163
119	f	mary.garcia@example.com	f	t	pbkdf2_sha256$36000$NoU8DLTxPivu$OyxjgH+Jc8UrKBm8924spJzHUKGOpBuplMxMOta0OW0=	2017-12-02 22:51:36.503689+00	\N	164	164
120	f	jennifer.robinson@example.com	f	t	pbkdf2_sha256$36000$M5vRPFGjILKq$+YX5X38/lLMaMam08NPSVyOmM/tbXRVN0nrns1pJEoQ=	2017-12-02 22:51:36.574156+00	\N	165	165
121	f	jill.mitchell@example.com	f	t	pbkdf2_sha256$36000$xa75NtVsuQml$FTVUpU0kLtGk7iEB6Vwz2Qwk6NiNvwttDtwKfyw/yXM=	2017-12-02 22:51:36.628223+00	\N	166	166
122	f	heather.petty@example.com	f	t	pbkdf2_sha256$36000$fZIxFbRWs1oG$HKxnT/qP5nkcmNSerH803HALWmKAi7fCQ7RAcSRo1pA=	2017-12-02 22:51:36.676929+00	\N	167	167
123	f	lorraine.butler@example.com	f	t	pbkdf2_sha256$36000$rH3Fss4LK9Pn$jlulKK+Msxqi9XO7sY3XQMsKjSSAVKiN2xixA7AJAKU=	2017-12-02 22:51:36.729934+00	\N	168	168
124	f	natasha.blevins@example.com	f	t	pbkdf2_sha256$36000$zUZPAIZElSN4$sLt+RUXsMi33mad6RBC/rrnoEHJ4WQjLVEGoal7uhFU=	2017-12-02 22:51:36.778126+00	\N	169	169
125	f	kelsey.martinez@example.com	f	t	pbkdf2_sha256$36000$BfpVEIQ3nNvK$frNXpXuZyxJ8sx90FQPc5/pjYYaoEx16RMsbsyrEiMs=	2017-12-02 22:51:36.831337+00	\N	170	170
126	f	rhonda.mitchell@example.com	f	t	pbkdf2_sha256$36000$zYVq2njbtptQ$ZZlYOiTM9ECqp1yYWIIN2+B6xFiNZvf7MbEV7oWW808=	2017-12-02 22:51:36.886427+00	\N	171	171
127	f	michael.barnes@example.com	f	t	pbkdf2_sha256$36000$4L9QFUlLcnBc$kvesYRXu/1/4Q7ng6tbGXLxJqfBvKZCCOQgpm6Qp92U=	2017-12-02 22:51:36.936185+00	\N	172	172
128	f	marilyn.sanchez@example.com	f	t	pbkdf2_sha256$36000$tfIFlgVV9kSW$slLSraQZubbOwfMsazb+vDuyhEG9FYLxiJDG5C2Deig=	2017-12-02 22:51:36.984708+00	\N	173	173
129	f	nathan.perez@example.com	f	t	pbkdf2_sha256$36000$93HQwdX288W2$5urhGqWxpG8fUAzClHjvBO/gniCcaw72VV2SzAgt2OY=	2017-12-02 22:51:37.034331+00	\N	174	174
130	f	jamie.robles@example.com	f	t	pbkdf2_sha256$36000$zDtbHWs8KTUS$YAgWaoarSWA9yUDeC7nvtkHcg7pI5ChMlCXkZ9NRETo=	2017-12-02 22:51:37.086855+00	\N	175	175
131	f	brian.james@example.com	f	t	pbkdf2_sha256$36000$YOfmUcJdPwRS$v6JN1lIQhMfpt/of5+eVDcqmV5mo0z+srpcIa0G6dzI=	2017-12-02 22:51:37.140484+00	\N	176	176
132	f	jeffrey.huber@example.com	f	t	pbkdf2_sha256$36000$1aZzh2Q1Mz4D$FI+4IctIi0iCy8Ifhyg8A29MgltmuHxlP7cjmjvVbrg=	2017-12-02 22:51:37.191507+00	\N	177	177
133	f	tanya.young@example.com	f	t	pbkdf2_sha256$36000$3R7xwFhtHDAt$07wfmQ6vV7P98S5TXSfjgIqu0s9cCcHWbwfwhj4hqbo=	2017-12-02 22:51:37.239216+00	\N	178	178
144	f	jeffrey.schaefer@example.com	f	t	pbkdf2_sha256$36000$t6QB4r29WpLi$QytLij2ibBsM9m0XKUHgJpXJRikGEYZ67s918pU7t1o=	2017-12-03 17:37:32.704189+00	\N	201	201
145	f	alexander.warner@example.com	f	t	pbkdf2_sha256$36000$R1RwUIEP1mmV$GRkQD3xum5maGUhcs4/5Mr+8vTWoV3lYXC0yyt98EB4=	2017-12-03 17:37:32.773937+00	\N	202	202
146	f	holly.perez@example.com	f	t	pbkdf2_sha256$36000$gzphLhbS0jtV$CG2QgR5DHy+4dTpluPYE6mHg8uXw0IoVijn272c1Fi4=	2017-12-03 17:37:32.839863+00	\N	203	203
147	f	heather.erickson@example.com	f	t	pbkdf2_sha256$36000$PBKoEV5jhp1o$t+5SMfiPOS/4NRZCpyLfMgxNXwXrCxdH1Do4LXQwR5A=	2017-12-03 17:37:32.912791+00	\N	204	204
148	f	brian.morris@example.com	f	t	pbkdf2_sha256$36000$AgFkOpiOjSfZ$1NocVI8QG93wdxZB70AF7X5M45j7noVcYJ6WKaUTY1E=	2017-12-03 17:37:32.982168+00	\N	205	205
149	f	andrew.white@example.com	f	t	pbkdf2_sha256$36000$UasTa1JKlaKO$U+SGzKo6OE33jX2VOtd6KuZeC9zSk/h3xn6yPKzgKsw=	2017-12-03 17:37:33.049806+00	\N	206	206
150	f	victoria.moore@example.com	f	t	pbkdf2_sha256$36000$acjpx6hrEp0k$XEHf8dYFryzZWOtZDO8GTmRsx92V/glHChDynYNIDew=	2017-12-03 17:37:33.117652+00	\N	207	207
151	f	samantha.jones@example.com	f	t	pbkdf2_sha256$36000$xwDQ09qkjBhd$7ZBwYKLVR/21YUXHLxbi+ObZMrg6VCLP9qoP8lFnGjU=	2017-12-03 17:37:33.184187+00	\N	208	208
152	f	heather.jackson@example.com	f	t	pbkdf2_sha256$36000$lLbUGj2hZVPy$5qCYmUR1jTjqxVaOxg8o1W0OsRi2LQn6J7PvrVfLQjo=	2017-12-03 17:37:33.253745+00	\N	209	209
153	f	william.daniels@example.com	f	t	pbkdf2_sha256$36000$gbYhYqrHDutS$s2EO9DbHV/+3/aDpiabI99EtO8g9ADEZB4IaVGP9fbI=	2017-12-03 17:37:33.319603+00	\N	210	210
154	f	michael.guerra@example.com	f	t	pbkdf2_sha256$36000$diy9KtjGmdng$u/Du3yGD0tUzNPVb/zexUJarU0ayGL3o/vsPwX4hrwk=	2017-12-06 15:00:02.996948+00	\N	220	220
155	f	tiffany.downs@example.com	f	t	pbkdf2_sha256$36000$Iym6mGE2Ontl$ABO81jPSkSCKFkTfTjVo9TWlfg2BcG43NHwhZ/DB14o=	2017-12-06 15:00:03.087079+00	\N	221	221
156	f	maria.green@example.com	f	t	pbkdf2_sha256$36000$Jpwzc6uzVKAA$TxmF+vuzqsFTTZJbTJ0d8m3vZQJt+tjberpMuFm3RxI=	2017-12-06 15:00:03.168914+00	\N	222	222
157	f	michelle.little@example.com	f	t	pbkdf2_sha256$36000$PzZfqaCAurLM$8cQkwc1a6ogg4adlSBXaUmUndCGH84sMO7Vwemt1TZ0=	2017-12-06 15:00:03.245146+00	\N	223	223
158	f	christine.keith@example.com	f	t	pbkdf2_sha256$36000$ghdcQ7Wnpz88$DrN1Cbz/FWMKeQymevS7eRQaq4xRz0wWrJlpXSoGJyM=	2017-12-06 15:00:03.318503+00	\N	224	224
159	f	elizabeth.gonzales@example.com	f	t	pbkdf2_sha256$36000$MSeVn3ckjEuF$oDXtGj1dKcAfy5PAfBIAhELxpDU709J6br06zGJ/TzE=	2017-12-06 15:00:03.393241+00	\N	225	225
160	f	tom.brown@example.com	f	t	pbkdf2_sha256$36000$fup70IMjmIbc$+oUq7CBMq9WYNANkRfM6M6lTy8pZ6EjwpkT0tAiYF10=	2017-12-06 15:00:03.469714+00	\N	226	226
161	f	christopher.scott@example.com	f	t	pbkdf2_sha256$36000$XyngoleTyb0n$DqvR9CYvwVv0k79rzoc+cltqqNW6ygEQ3qk+XkOWs7s=	2017-12-06 15:00:03.542819+00	\N	227	227
162	f	kathryn.castillo@example.com	f	t	pbkdf2_sha256$36000$Y8JZPUFCRfav$Dz0OLgHTXuSyRbDnR3Ju+sEI10RRRBym0yHoD1iBXN8=	2017-12-06 15:00:03.620595+00	\N	228	228
163	f	tammy.schneider@example.com	f	t	pbkdf2_sha256$36000$Qol8ZnemUebh$06q/3YeDCRtZel0GKFMRJJLvA8euyTOnLXbDs5r8ZnQ=	2017-12-06 15:00:03.682416+00	\N	229	229
164	f	jack.davis@example.com	f	t	pbkdf2_sha256$36000$1QLS64muZwHH$kiqT9sUQCPJw/DHj27Xj+6bP/bIzAdO3mPnWLt6CWcs=	2017-12-06 15:00:03.737699+00	\N	230	230
165	f	dustin.williams@example.com	f	t	pbkdf2_sha256$36000$7sQATtlC5ke0$LTyKDFEajriQX5Y3V3V6OjmvryEbkvHEV1AXIh2NtQU=	2017-12-06 15:00:03.793196+00	\N	231	231
166	f	raven.phillips@example.com	f	t	pbkdf2_sha256$36000$jbPlQgJWPzd9$P1su2gHWTT2rGjb+DM7tWsi1/exnt8aCINULH/nmLi4=	2017-12-06 15:00:03.846684+00	\N	232	232
167	f	lisa.bennett@example.com	f	t	pbkdf2_sha256$36000$7heV68MFHAYg$wrbUFjVw7YVKCFibv32zmIWdeSAhBviTrLxChMO6j6k=	2017-12-06 15:00:03.899676+00	\N	233	233
168	f	aaron.david@example.com	f	t	pbkdf2_sha256$36000$AldMsXJ3AyLo$QzY05GhdVpoSDBnS15+Of3d7PUuYgxE2BxnhrQz+3wI=	2017-12-06 15:00:03.949548+00	\N	234	234
169	f	brianna.bailey@example.com	f	t	pbkdf2_sha256$36000$HCzTiXpGbjgu$E+zWN8oeKHas4rOiOz61MPmP/80Y7iQO9Jf3aByLMNc=	2017-12-06 15:00:03.999391+00	\N	235	235
170	f	bridget.richardson@example.com	f	t	pbkdf2_sha256$36000$8ir39NQiA0VH$kE/4X3hUn6mXXCDf0TwXritpNF0ceWIVNAExsS+mM+0=	2017-12-06 15:00:04.044096+00	\N	236	236
171	f	debra.howard@example.com	f	t	pbkdf2_sha256$36000$odoWdLXBD0Kr$gAi8FcnXRuFSlyNvXB2e0v1p61gb1g4Nsgsr0WKbNXs=	2017-12-06 15:00:04.098289+00	\N	237	237
172	f	tammie.vance@example.com	f	t	pbkdf2_sha256$36000$klyN4yOwTd0I$WSkSTJ8sqs+9GZablsV/WgN+CTYzBVCpgB8A9b/Yey8=	2017-12-06 15:00:04.179159+00	\N	238	238
173	f	elizabeth.barnes@example.com	f	t	pbkdf2_sha256$36000$FsYOrU6NujXn$pHTZIDFInJ7x60fO4JoWkiTa4c8A+f/jbBSGkpLirR4=	2017-12-06 15:00:04.258382+00	\N	239	239
\.


--
-- Data for Name: userprofile_user_addresses; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user_addresses (id, user_id, address_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
6	6	6
7	7	7
8	8	8
9	9	9
10	10	10
11	11	11
12	12	12
13	13	13
14	14	14
15	15	15
16	16	16
17	17	17
18	18	18
19	19	19
20	20	20
21	21	30
22	22	31
23	23	32
24	24	33
25	25	34
26	26	35
27	27	36
28	28	37
29	29	38
30	30	39
31	31	40
32	32	41
33	33	42
34	34	43
35	35	44
36	36	45
37	37	46
38	38	47
39	39	48
40	40	49
41	41	57
42	42	58
43	43	59
44	44	60
45	45	61
46	46	62
47	47	63
48	48	64
49	49	65
50	50	66
51	51	67
52	52	68
53	53	69
54	54	70
55	55	71
56	56	72
57	57	73
58	58	74
59	59	75
60	60	76
61	61	86
62	62	87
63	63	88
64	64	89
65	65	90
66	66	91
67	67	92
68	68	93
69	69	94
70	70	95
71	71	96
72	72	97
73	73	98
74	74	99
75	75	100
76	76	101
77	77	102
78	78	103
79	79	104
80	80	105
81	81	118
82	82	119
83	83	120
84	84	121
85	85	122
86	86	123
87	87	124
88	88	125
89	89	126
90	90	127
91	91	128
92	92	129
93	93	130
94	94	131
95	95	132
96	96	133
97	97	134
98	98	135
99	99	136
100	100	137
101	101	146
102	102	147
103	103	148
104	104	149
105	105	150
106	106	151
107	107	152
108	108	153
109	109	154
110	110	155
111	111	156
112	112	157
113	114	159
114	115	160
115	116	161
116	117	162
117	118	163
118	119	164
119	120	165
120	121	166
121	122	167
122	123	168
123	124	169
124	125	170
125	126	171
126	127	172
127	128	173
128	129	174
129	130	175
130	131	176
131	132	177
132	133	178
133	134	191
134	135	192
135	136	193
136	137	194
137	138	195
138	139	196
139	140	197
140	141	198
141	142	199
142	143	200
143	144	201
144	145	202
145	146	203
146	147	204
147	148	205
148	149	206
149	150	207
150	151	208
151	152	209
152	153	210
153	154	220
154	155	221
155	156	222
156	157	223
157	158	224
158	159	225
159	160	226
160	161	227
161	162	228
162	163	229
163	164	230
164	165	231
165	166	232
166	167	233
167	168	234
168	169	235
169	170	236
170	171	237
171	172	238
172	173	239
\.


--
-- Data for Name: userprofile_user_groups; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: userprofile_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 2, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('auth_permission_id_seq', 148, true);


--
-- Name: cart_cartline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('cart_cartline_id_seq', 1, true);


--
-- Name: discount_sale_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_categories_id_seq', 1, false);


--
-- Name: discount_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_id_seq', 45, true);


--
-- Name: discount_sale_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_products_id_seq', 180, true);


--
-- Name: discount_voucher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_voucher_id_seq', 2, true);


--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_celery_results_taskresult_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_content_type_id_seq', 40, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_migrations_id_seq', 155, true);


--
-- Name: django_prices_openexchangerates_conversionrate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_prices_openexchangerates_conversionrate_id_seq', 1, false);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('impersonate_impersonationlog_id_seq', 1, false);


--
-- Name: order_deliverygroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_deliverygroup_id_seq', 141, true);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_order_id_seq', 141, true);


--
-- Name: order_ordereditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_ordereditem_id_seq', 368, true);


--
-- Name: order_orderhistoryentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_orderhistoryentry_id_seq', 1, false);


--
-- Name: order_ordernote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_ordernote_id_seq', 1, false);


--
-- Name: order_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_payment_id_seq', 140, true);


--
-- Name: product_attributechoicevalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_attributechoicevalue_id_seq', 31, true);


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_category_id_seq', 4, true);


--
-- Name: product_product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_product_categories_id_seq', 540, true);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_product_id_seq', 540, true);


--
-- Name: product_productattribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productattribute_id_seq', 12, true);


--
-- Name: product_productclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_id_seq', 6, true);


--
-- Name: product_productclass_product_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_product_attributes_id_seq', 14, true);


--
-- Name: product_productclass_variant_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_variant_attributes_id_seq', 4, true);


--
-- Name: product_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productimage_id_seq', 1355, true);


--
-- Name: product_productvariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productvariant_id_seq', 1530, true);


--
-- Name: product_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_stock_id_seq', 1530, true);


--
-- Name: product_stocklocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_stocklocation_id_seq', 1, true);


--
-- Name: product_variantimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_variantimage_id_seq', 1, false);


--
-- Name: shipping_shippingmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('shipping_shippingmethod_id_seq', 18, true);


--
-- Name: shipping_shippingmethodcountry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('shipping_shippingmethodcountry_id_seq', 19, true);


--
-- Name: site_authorizationkey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('site_authorizationkey_id_seq', 1, false);


--
-- Name: site_sitesettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('site_sitesettings_id_seq', 1, true);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: userprofile_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_address_id_seq', 240, true);


--
-- Name: userprofile_user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_addresses_id_seq', 172, true);


--
-- Name: userprofile_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_groups_id_seq', 1, false);


--
-- Name: userprofile_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_id_seq', 173, true);


--
-- Name: userprofile_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: cart_cart cart_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cart
    ADD CONSTRAINT cart_cart_pkey PRIMARY KEY (token);


--
-- Name: cart_cartline cart_cartline_cart_id_product_id_data_fc3556b7_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cartline
    ADD CONSTRAINT cart_cartline_cart_id_product_id_data_fc3556b7_uniq UNIQUE (cart_id, variant_id, data);


--
-- Name: cart_cartline cart_cartline_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cartline
    ADD CONSTRAINT cart_cartline_pkey PRIMARY KEY (id);


--
-- Name: discount_sale_categories discount_sale_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_categories
    ADD CONSTRAINT discount_sale_categories_pkey PRIMARY KEY (id);


--
-- Name: discount_sale_categories discount_sale_categories_sale_id_category_id_be438401_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_categories
    ADD CONSTRAINT discount_sale_categories_sale_id_category_id_be438401_uniq UNIQUE (sale_id, category_id);


--
-- Name: discount_sale discount_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale
    ADD CONSTRAINT discount_sale_pkey PRIMARY KEY (id);


--
-- Name: discount_sale_products discount_sale_products_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_products
    ADD CONSTRAINT discount_sale_products_pkey PRIMARY KEY (id);


--
-- Name: discount_sale_products discount_sale_products_sale_id_product_id_1c2df1f8_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_products
    ADD CONSTRAINT discount_sale_products_sale_id_product_id_1c2df1f8_uniq UNIQUE (sale_id, product_id);


--
-- Name: discount_voucher discount_voucher_code_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_voucher
    ADD CONSTRAINT discount_voucher_code_key UNIQUE (code);


--
-- Name: discount_voucher discount_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_voucher
    ADD CONSTRAINT discount_voucher_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_task_id_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_task_id_key UNIQUE (task_id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_prices_openexchangerates_conversionrate django_prices_openexchangerates_conversionrate_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_prices_openexchangerates_conversionrate
    ADD CONSTRAINT django_prices_openexchangerates_conversionrate_pkey PRIMARY KEY (id);


--
-- Name: django_prices_openexchangerates_conversionrate django_prices_openexchangerates_conversionrate_to_currency_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_prices_openexchangerates_conversionrate
    ADD CONSTRAINT django_prices_openexchangerates_conversionrate_to_currency_key UNIQUE (to_currency);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: impersonate_impersonationlog impersonate_impersonationlog_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY impersonate_impersonationlog
    ADD CONSTRAINT impersonate_impersonationlog_pkey PRIMARY KEY (id);


--
-- Name: order_deliverygroup order_deliverygroup_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_deliverygroup
    ADD CONSTRAINT order_deliverygroup_pkey PRIMARY KEY (id);


--
-- Name: order_order order_order_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_pkey PRIMARY KEY (id);


--
-- Name: order_order order_order_token_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_token_key UNIQUE (token);


--
-- Name: order_orderline order_ordereditem_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderline
    ADD CONSTRAINT order_ordereditem_pkey PRIMARY KEY (id);


--
-- Name: order_orderhistoryentry order_orderhistoryentry_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderhistoryentry
    ADD CONSTRAINT order_orderhistoryentry_pkey PRIMARY KEY (id);


--
-- Name: order_ordernote order_ordernote_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_pkey PRIMARY KEY (id);


--
-- Name: order_payment order_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_payment
    ADD CONSTRAINT order_payment_pkey PRIMARY KEY (id);


--
-- Name: product_attributechoicevalue product_attributechoicevalue_display_attribute_id_6d8b2d87_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_attributechoicevalue
    ADD CONSTRAINT product_attributechoicevalue_display_attribute_id_6d8b2d87_uniq UNIQUE (name, attribute_id);


--
-- Name: product_attributechoicevalue product_attributechoicevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_attributechoicevalue
    ADD CONSTRAINT product_attributechoicevalue_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_product_categories product_product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product_categories
    ADD CONSTRAINT product_product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_product_categories product_product_categories_product_id_category_id_fdd1154c_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product_categories
    ADD CONSTRAINT product_product_categories_product_id_category_id_fdd1154c_uniq UNIQUE (product_id, category_id);


--
-- Name: product_product product_product_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product
    ADD CONSTRAINT product_product_pkey PRIMARY KEY (id);


--
-- Name: product_productattribute product_productattribute_name_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productattribute
    ADD CONSTRAINT product_productattribute_name_key UNIQUE (slug);


--
-- Name: product_productattribute product_productattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productattribute
    ADD CONSTRAINT product_productattribute_pkey PRIMARY KEY (id);


--
-- Name: product_productclass product_productclass_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass
    ADD CONSTRAINT product_productclass_pkey PRIMARY KEY (id);


--
-- Name: product_productclass_product_attributes product_productclass_pro_productclass_id_producta_0f5adffd_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_product_attributes
    ADD CONSTRAINT product_productclass_pro_productclass_id_producta_0f5adffd_uniq UNIQUE (productclass_id, productattribute_id);


--
-- Name: product_productclass_product_attributes product_productclass_product_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_product_attributes
    ADD CONSTRAINT product_productclass_product_attributes_pkey PRIMARY KEY (id);


--
-- Name: product_productclass_variant_attributes product_productclass_var_productclass_id_producta_99509fad_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_variant_attributes
    ADD CONSTRAINT product_productclass_var_productclass_id_producta_99509fad_uniq UNIQUE (productclass_id, productattribute_id);


--
-- Name: product_productclass_variant_attributes product_productclass_variant_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_variant_attributes
    ADD CONSTRAINT product_productclass_variant_attributes_pkey PRIMARY KEY (id);


--
-- Name: product_productimage product_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productimage
    ADD CONSTRAINT product_productimage_pkey PRIMARY KEY (id);


--
-- Name: product_productvariant product_productvariant_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productvariant
    ADD CONSTRAINT product_productvariant_pkey PRIMARY KEY (id);


--
-- Name: product_productvariant product_productvariant_sku_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productvariant
    ADD CONSTRAINT product_productvariant_sku_key UNIQUE (sku);


--
-- Name: product_stock product_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stock
    ADD CONSTRAINT product_stock_pkey PRIMARY KEY (id);


--
-- Name: product_stock product_stock_variant_id_location_link_id_38bdcb0a_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stock
    ADD CONSTRAINT product_stock_variant_id_location_link_id_38bdcb0a_uniq UNIQUE (variant_id, location_id);


--
-- Name: product_stocklocation product_stocklocation_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stocklocation
    ADD CONSTRAINT product_stocklocation_pkey PRIMARY KEY (id);


--
-- Name: product_variantimage product_variantimage_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_variantimage
    ADD CONSTRAINT product_variantimage_pkey PRIMARY KEY (id);


--
-- Name: shipping_shippingmethod shipping_shippingmethod_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethod
    ADD CONSTRAINT shipping_shippingmethod_pkey PRIMARY KEY (id);


--
-- Name: shipping_shippingmethodcountry shipping_shippingmethodc_country_code_shipping_me_0e63c403_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethodcountry
    ADD CONSTRAINT shipping_shippingmethodc_country_code_shipping_me_0e63c403_uniq UNIQUE (country_code, shipping_method_id);


--
-- Name: shipping_shippingmethodcountry shipping_shippingmethodcountry_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethodcountry
    ADD CONSTRAINT shipping_shippingmethodcountry_pkey PRIMARY KEY (id);


--
-- Name: site_authorizationkey site_authorizationkey_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_authorizationkey
    ADD CONSTRAINT site_authorizationkey_pkey PRIMARY KEY (id);


--
-- Name: site_authorizationkey site_authorizationkey_site_settings_id_name_c5f8d1e6_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_authorizationkey
    ADD CONSTRAINT site_authorizationkey_site_settings_id_name_c5f8d1e6_uniq UNIQUE (site_settings_id, name);


--
-- Name: site_sitesettings site_sitesettings_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_sitesettings
    ADD CONSTRAINT site_sitesettings_pkey PRIMARY KEY (id);


--
-- Name: site_sitesettings site_sitesettings_site_id_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_sitesettings
    ADD CONSTRAINT site_sitesettings_site_id_key UNIQUE (site_id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: userprofile_address userprofile_address_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_address
    ADD CONSTRAINT userprofile_address_pkey PRIMARY KEY (id);


--
-- Name: userprofile_user_addresses userprofile_user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_addresses
    ADD CONSTRAINT userprofile_user_addresses_pkey PRIMARY KEY (id);


--
-- Name: userprofile_user_addresses userprofile_user_addresses_user_id_address_id_6cb87bcc_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_addresses
    ADD CONSTRAINT userprofile_user_addresses_user_id_address_id_6cb87bcc_uniq UNIQUE (user_id, address_id);


--
-- Name: userprofile_user userprofile_user_email_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user
    ADD CONSTRAINT userprofile_user_email_key UNIQUE (email);


--
-- Name: userprofile_user_groups userprofile_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_groups
    ADD CONSTRAINT userprofile_user_groups_pkey PRIMARY KEY (id);


--
-- Name: userprofile_user_groups userprofile_user_groups_user_id_group_id_90ce1781_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_groups
    ADD CONSTRAINT userprofile_user_groups_user_id_group_id_90ce1781_uniq UNIQUE (user_id, group_id);


--
-- Name: userprofile_user userprofile_user_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user
    ADD CONSTRAINT userprofile_user_pkey PRIMARY KEY (id);


--
-- Name: userprofile_user_user_permissions userprofile_user_user_pe_user_id_permission_id_706d65c8_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_user_permissions
    ADD CONSTRAINT userprofile_user_user_pe_user_id_permission_id_706d65c8_uniq UNIQUE (user_id, permission_id);


--
-- Name: userprofile_user_user_permissions userprofile_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_user_permissions
    ADD CONSTRAINT userprofile_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: cart_cart_user_id_9b4220b9; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX cart_cart_user_id_9b4220b9 ON cart_cart USING btree (user_id);


--
-- Name: cart_cart_voucher_id_625b79ba; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX cart_cart_voucher_id_625b79ba ON cart_cart USING btree (voucher_id);


--
-- Name: cart_cartline_cart_id_c7b9981e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX cart_cartline_cart_id_c7b9981e ON cart_cartline USING btree (cart_id);


--
-- Name: cart_cartline_product_id_1a54130f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX cart_cartline_product_id_1a54130f ON cart_cartline USING btree (variant_id);


--
-- Name: discount_sale_categories_category_id_64e132af; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_sale_categories_category_id_64e132af ON discount_sale_categories USING btree (category_id);


--
-- Name: discount_sale_categories_sale_id_2aeee4a7; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_sale_categories_sale_id_2aeee4a7 ON discount_sale_categories USING btree (sale_id);


--
-- Name: discount_sale_products_product_id_d42c9636; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_sale_products_product_id_d42c9636 ON discount_sale_products USING btree (product_id);


--
-- Name: discount_sale_products_sale_id_10e3a20f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_sale_products_sale_id_10e3a20f ON discount_sale_products USING btree (sale_id);


--
-- Name: discount_voucher_category_id_8a52278e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_voucher_category_id_8a52278e ON discount_voucher USING btree (category_id);


--
-- Name: discount_voucher_code_ff8dc52c_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_voucher_code_ff8dc52c_like ON discount_voucher USING btree (code varchar_pattern_ops);


--
-- Name: discount_voucher_product_id_8ff28542; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX discount_voucher_product_id_8ff28542 ON discount_voucher USING btree (product_id);


--
-- Name: django_celery_results_taskresult_hidden_cd77412f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_celery_results_taskresult_hidden_cd77412f ON django_celery_results_taskresult USING btree (hidden);


--
-- Name: django_celery_results_taskresult_task_id_de0d95bf_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_celery_results_taskresult_task_id_de0d95bf_like ON django_celery_results_taskresult USING btree (task_id varchar_pattern_ops);


--
-- Name: django_prices_openexchan_to_currency_92c4a4e1_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_prices_openexchan_to_currency_92c4a4e1_like ON django_prices_openexchangerates_conversionrate USING btree (to_currency varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: impersonate_impersonationlog_impersonating_id_afd114fc; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX impersonate_impersonationlog_impersonating_id_afd114fc ON impersonate_impersonationlog USING btree (impersonating_id);


--
-- Name: impersonate_impersonationlog_impersonator_id_1ecfe8ce; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX impersonate_impersonationlog_impersonator_id_1ecfe8ce ON impersonate_impersonationlog USING btree (impersonator_id);


--
-- Name: order_deliverygroup_order_id_9fdf192e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_deliverygroup_order_id_9fdf192e ON order_deliverygroup USING btree (order_id);


--
-- Name: order_order_billing_address_id_8fe537cf; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_order_billing_address_id_8fe537cf ON order_order USING btree (billing_address_id);


--
-- Name: order_order_shipping_address_id_57e64931; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_order_shipping_address_id_57e64931 ON order_order USING btree (shipping_address_id);


--
-- Name: order_order_token_ddb7fb7b_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_order_token_ddb7fb7b_like ON order_order USING btree (token varchar_pattern_ops);


--
-- Name: order_order_user_id_7cf9bc2b; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_order_user_id_7cf9bc2b ON order_order USING btree (user_id);


--
-- Name: order_order_voucher_id_0748ca22; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_order_voucher_id_0748ca22 ON order_order USING btree (voucher_id);


--
-- Name: order_ordereditem_delivery_group_id_e2d5d724; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_ordereditem_delivery_group_id_e2d5d724 ON order_orderline USING btree (delivery_group_id);


--
-- Name: order_ordereditem_product_id_e7b719d3; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_ordereditem_product_id_e7b719d3 ON order_orderline USING btree (product_id);


--
-- Name: order_ordereditem_stock_id_b12d2997; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_ordereditem_stock_id_b12d2997 ON order_orderline USING btree (stock_id);


--
-- Name: order_orderhistoryentry_order_id_ea3bf4c4; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_orderhistoryentry_order_id_ea3bf4c4 ON order_orderhistoryentry USING btree (order_id);


--
-- Name: order_orderhistoryentry_user_id_1070bf50; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_orderhistoryentry_user_id_1070bf50 ON order_orderhistoryentry USING btree (user_id);


--
-- Name: order_ordernote_order_id_7d97583d; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_ordernote_order_id_7d97583d ON order_ordernote USING btree (order_id);


--
-- Name: order_ordernote_user_id_48d7a672; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_ordernote_user_id_48d7a672 ON order_ordernote USING btree (user_id);


--
-- Name: order_payment_order_id_588933b6; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX order_payment_order_id_588933b6 ON order_payment USING btree (order_id);


--
-- Name: product_attributechoicevalue_attribute_id_c28c6c92; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_attributechoicevalue_attribute_id_c28c6c92 ON product_attributechoicevalue USING btree (attribute_id);


--
-- Name: product_attributechoicevalue_slug_e0d2d25b; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_attributechoicevalue_slug_e0d2d25b ON product_attributechoicevalue USING btree (slug);


--
-- Name: product_attributechoicevalue_slug_e0d2d25b_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_attributechoicevalue_slug_e0d2d25b_like ON product_attributechoicevalue USING btree (slug varchar_pattern_ops);


--
-- Name: product_category_level_b59332d3; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_level_b59332d3 ON product_category USING btree (level);


--
-- Name: product_category_lft_3708054f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_lft_3708054f ON product_category USING btree (lft);


--
-- Name: product_category_parent_id_f6860923; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_parent_id_f6860923 ON product_category USING btree (parent_id);


--
-- Name: product_category_rght_fcbf9e79; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_rght_fcbf9e79 ON product_category USING btree (rght);


--
-- Name: product_category_slug_e1f8ccc4; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_slug_e1f8ccc4 ON product_category USING btree (slug);


--
-- Name: product_category_slug_e1f8ccc4_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_slug_e1f8ccc4_like ON product_category USING btree (slug varchar_pattern_ops);


--
-- Name: product_category_tree_id_f3c46461; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_category_tree_id_f3c46461 ON product_category USING btree (tree_id);


--
-- Name: product_product_categories_category_id_edc0e025; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_product_categories_category_id_edc0e025 ON product_product_categories USING btree (category_id);


--
-- Name: product_product_categories_product_id_f73e32d0; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_product_categories_product_id_f73e32d0 ON product_product_categories USING btree (product_id);


--
-- Name: product_product_product_class_id_0547c998; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_product_product_class_id_0547c998 ON product_product USING btree (product_class_id);


--
-- Name: product_productattribute_name_97ca2b51_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productattribute_name_97ca2b51_like ON product_productattribute USING btree (slug varchar_pattern_ops);


--
-- Name: product_productclass_produ_productattribute_id_de46d651; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productclass_produ_productattribute_id_de46d651 ON product_productclass_product_attributes USING btree (productattribute_id);


--
-- Name: product_productclass_produ_productclass_id_afa141a4; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productclass_produ_productclass_id_afa141a4 ON product_productclass_product_attributes USING btree (productclass_id);


--
-- Name: product_productclass_varia_productattribute_id_4843d626; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productclass_varia_productattribute_id_4843d626 ON product_productclass_variant_attributes USING btree (productattribute_id);


--
-- Name: product_productclass_varia_productclass_id_0903f8b6; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productclass_varia_productclass_id_0903f8b6 ON product_productclass_variant_attributes USING btree (productclass_id);


--
-- Name: product_productimage_product_id_544084bb; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productimage_product_id_544084bb ON product_productimage USING btree (product_id);


--
-- Name: product_productvariant_product_id_43c5a310; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productvariant_product_id_43c5a310 ON product_productvariant USING btree (product_id);


--
-- Name: product_productvariant_sku_50706818_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_productvariant_sku_50706818_like ON product_productvariant USING btree (sku varchar_pattern_ops);


--
-- Name: product_stock_location_link_id_5b29dec0; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_stock_location_link_id_5b29dec0 ON product_stock USING btree (location_id);


--
-- Name: product_stock_variant_id_be911028; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_stock_variant_id_be911028 ON product_stock USING btree (variant_id);


--
-- Name: product_variantimage_image_id_bef14106; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_variantimage_image_id_bef14106 ON product_variantimage USING btree (image_id);


--
-- Name: product_variantimage_variant_id_81123814; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_variantimage_variant_id_81123814 ON product_variantimage USING btree (variant_id);


--
-- Name: shipping_shippingmethodcountry_shipping_method_id_9b026f8b; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX shipping_shippingmethodcountry_shipping_method_id_9b026f8b ON shipping_shippingmethodcountry USING btree (shipping_method_id);


--
-- Name: site_authorizationkey_site_settings_id_d8397c0f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX site_authorizationkey_site_settings_id_d8397c0f ON site_authorizationkey USING btree (site_settings_id);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_code_code_a2393167 ON social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_code_code_a2393167_like ON social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_code_timestamp_176b341f ON social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_partial_token_3017fea3 ON social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON social_auth_usersocialauth USING btree (user_id);


--
-- Name: userprofile_user_addresses_address_id_ad7646b4; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_addresses_address_id_ad7646b4 ON userprofile_user_addresses USING btree (address_id);


--
-- Name: userprofile_user_addresses_user_id_bb5aa55e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_addresses_user_id_bb5aa55e ON userprofile_user_addresses USING btree (user_id);


--
-- Name: userprofile_user_default_billing_address_id_0489abf1; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_default_billing_address_id_0489abf1 ON userprofile_user USING btree (default_billing_address_id);


--
-- Name: userprofile_user_default_shipping_address_id_aae7a203; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_default_shipping_address_id_aae7a203 ON userprofile_user USING btree (default_shipping_address_id);


--
-- Name: userprofile_user_email_b0fb0137_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_email_b0fb0137_like ON userprofile_user USING btree (email varchar_pattern_ops);


--
-- Name: userprofile_user_groups_group_id_c7eec74e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_groups_group_id_c7eec74e ON userprofile_user_groups USING btree (group_id);


--
-- Name: userprofile_user_groups_user_id_5e712a24; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_groups_user_id_5e712a24 ON userprofile_user_groups USING btree (user_id);


--
-- Name: userprofile_user_user_permissions_permission_id_1caa8a71; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_user_permissions_permission_id_1caa8a71 ON userprofile_user_user_permissions USING btree (permission_id);


--
-- Name: userprofile_user_user_permissions_user_id_6d654469; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_user_permissions_user_id_6d654469 ON userprofile_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cart cart_cart_user_id_9b4220b9_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cart
    ADD CONSTRAINT cart_cart_user_id_9b4220b9_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cart cart_cart_voucher_id_625b79ba_fk_discount_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cart
    ADD CONSTRAINT cart_cart_voucher_id_625b79ba_fk_discount_voucher_id FOREIGN KEY (voucher_id) REFERENCES discount_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartline cart_cartline_cart_id_c7b9981e_fk_cart_cart_token; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cartline
    ADD CONSTRAINT cart_cartline_cart_id_c7b9981e_fk_cart_cart_token FOREIGN KEY (cart_id) REFERENCES cart_cart(token) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartline cart_cartline_variant_id_dbca56c9_fk_product_productvariant_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cartline
    ADD CONSTRAINT cart_cartline_variant_id_dbca56c9_fk_product_productvariant_id FOREIGN KEY (variant_id) REFERENCES product_productvariant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_sale_categories discount_sale_catego_category_id_64e132af_fk_product_c; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_categories
    ADD CONSTRAINT discount_sale_catego_category_id_64e132af_fk_product_c FOREIGN KEY (category_id) REFERENCES product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_sale_categories discount_sale_categories_sale_id_2aeee4a7_fk_discount_sale_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_categories
    ADD CONSTRAINT discount_sale_categories_sale_id_2aeee4a7_fk_discount_sale_id FOREIGN KEY (sale_id) REFERENCES discount_sale(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_sale_products discount_sale_produc_product_id_d42c9636_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_products
    ADD CONSTRAINT discount_sale_produc_product_id_d42c9636_fk_product_p FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_sale_products discount_sale_products_sale_id_10e3a20f_fk_discount_sale_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_sale_products
    ADD CONSTRAINT discount_sale_products_sale_id_10e3a20f_fk_discount_sale_id FOREIGN KEY (sale_id) REFERENCES discount_sale(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_voucher discount_voucher_category_id_8a52278e_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_voucher
    ADD CONSTRAINT discount_voucher_category_id_8a52278e_fk_product_category_id FOREIGN KEY (category_id) REFERENCES product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: discount_voucher discount_voucher_product_id_8ff28542_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY discount_voucher
    ADD CONSTRAINT discount_voucher_product_id_8ff28542_fk_product_product_id FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: impersonate_impersonationlog impersonate_imperson_impersonating_id_afd114fc_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY impersonate_impersonationlog
    ADD CONSTRAINT impersonate_imperson_impersonating_id_afd114fc_fk_userprofi FOREIGN KEY (impersonating_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: impersonate_impersonationlog impersonate_imperson_impersonator_id_1ecfe8ce_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY impersonate_impersonationlog
    ADD CONSTRAINT impersonate_imperson_impersonator_id_1ecfe8ce_fk_userprofi FOREIGN KEY (impersonator_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_deliverygroup order_deliverygroup_order_id_9fdf192e_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_deliverygroup
    ADD CONSTRAINT order_deliverygroup_order_id_9fdf192e_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_billing_address_id_8fe537cf_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_billing_address_id_8fe537cf_fk_userprofi FOREIGN KEY (billing_address_id) REFERENCES userprofile_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_shipping_address_id_57e64931_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_shipping_address_id_57e64931_fk_userprofi FOREIGN KEY (shipping_address_id) REFERENCES userprofile_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_user_id_7cf9bc2b_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_user_id_7cf9bc2b_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_voucher_id_0748ca22_fk_discount_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_voucher_id_0748ca22_fk_discount_voucher_id FOREIGN KEY (voucher_id) REFERENCES discount_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderline order_ordereditem_delivery_group_id_e2d5d724_fk_order_del; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderline
    ADD CONSTRAINT order_ordereditem_delivery_group_id_e2d5d724_fk_order_del FOREIGN KEY (delivery_group_id) REFERENCES order_deliverygroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderline order_ordereditem_product_id_e7b719d3_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderline
    ADD CONSTRAINT order_ordereditem_product_id_e7b719d3_fk_product_product_id FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderline order_ordereditem_stock_id_b12d2997_fk_product_stock_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderline
    ADD CONSTRAINT order_ordereditem_stock_id_b12d2997_fk_product_stock_id FOREIGN KEY (stock_id) REFERENCES product_stock(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderhistoryentry order_orderhistoryentry_order_id_ea3bf4c4_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderhistoryentry
    ADD CONSTRAINT order_orderhistoryentry_order_id_ea3bf4c4_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderhistoryentry order_orderhistoryentry_user_id_1070bf50_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_orderhistoryentry
    ADD CONSTRAINT order_orderhistoryentry_user_id_1070bf50_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote order_ordernote_order_id_7d97583d_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_order_id_7d97583d_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote order_ordernote_user_id_48d7a672_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_user_id_48d7a672_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_payment order_payment_order_id_588933b6_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_payment
    ADD CONSTRAINT order_payment_order_id_588933b6_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_attributechoicevalue product_attributecho_attribute_id_c28c6c92_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_attributechoicevalue
    ADD CONSTRAINT product_attributecho_attribute_id_c28c6c92_fk_product_p FOREIGN KEY (attribute_id) REFERENCES product_productattribute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_category product_category_parent_id_f6860923_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_parent_id_f6860923_fk_product_category_id FOREIGN KEY (parent_id) REFERENCES product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product_categories product_product_cate_category_id_edc0e025_fk_product_c; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product_categories
    ADD CONSTRAINT product_product_cate_category_id_edc0e025_fk_product_c FOREIGN KEY (category_id) REFERENCES product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product_categories product_product_cate_product_id_f73e32d0_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product_categories
    ADD CONSTRAINT product_product_cate_product_id_f73e32d0_fk_product_p FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_product_class_id_0547c998_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_product
    ADD CONSTRAINT product_product_product_class_id_0547c998_fk_product_p FOREIGN KEY (product_class_id) REFERENCES product_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productclass_variant_attributes product_productclass_productattribute_id_4843d626_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_variant_attributes
    ADD CONSTRAINT product_productclass_productattribute_id_4843d626_fk_product_p FOREIGN KEY (productattribute_id) REFERENCES product_productattribute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productclass_product_attributes product_productclass_productattribute_id_de46d651_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_product_attributes
    ADD CONSTRAINT product_productclass_productattribute_id_de46d651_fk_product_p FOREIGN KEY (productattribute_id) REFERENCES product_productattribute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productclass_variant_attributes product_productclass_productclass_id_0903f8b6_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_variant_attributes
    ADD CONSTRAINT product_productclass_productclass_id_0903f8b6_fk_product_p FOREIGN KEY (productclass_id) REFERENCES product_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productclass_product_attributes product_productclass_productclass_id_afa141a4_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productclass_product_attributes
    ADD CONSTRAINT product_productclass_productclass_id_afa141a4_fk_product_p FOREIGN KEY (productclass_id) REFERENCES product_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productimage product_productimage_product_id_544084bb_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productimage
    ADD CONSTRAINT product_productimage_product_id_544084bb_fk_product_product_id FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productvariant product_productvaria_product_id_43c5a310_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_productvariant
    ADD CONSTRAINT product_productvaria_product_id_43c5a310_fk_product_p FOREIGN KEY (product_id) REFERENCES product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_stock product_stock_location_id_22a978d5_fk_product_stocklocation_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stock
    ADD CONSTRAINT product_stock_location_id_22a978d5_fk_product_stocklocation_id FOREIGN KEY (location_id) REFERENCES product_stocklocation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_stock product_stock_variant_id_be911028_fk_product_productvariant_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_stock
    ADD CONSTRAINT product_stock_variant_id_be911028_fk_product_productvariant_id FOREIGN KEY (variant_id) REFERENCES product_productvariant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_variantimage product_variantimage_image_id_bef14106_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_variantimage
    ADD CONSTRAINT product_variantimage_image_id_bef14106_fk_product_p FOREIGN KEY (image_id) REFERENCES product_productimage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_variantimage product_variantimage_variant_id_81123814_fk_product_p; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY product_variantimage
    ADD CONSTRAINT product_variantimage_variant_id_81123814_fk_product_p FOREIGN KEY (variant_id) REFERENCES product_productvariant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shipping_shippingmethodcountry shipping_shippingmet_shipping_method_id_9b026f8b_fk_shipping_; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY shipping_shippingmethodcountry
    ADD CONSTRAINT shipping_shippingmet_shipping_method_id_9b026f8b_fk_shipping_ FOREIGN KEY (shipping_method_id) REFERENCES shipping_shippingmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: site_authorizationkey site_authorizationke_site_settings_id_d8397c0f_fk_site_site; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_authorizationkey
    ADD CONSTRAINT site_authorizationke_site_settings_id_d8397c0f_fk_site_site FOREIGN KEY (site_settings_id) REFERENCES site_sitesettings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: site_sitesettings site_sitesettings_site_id_64dd8ff8_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY site_sitesettings
    ADD CONSTRAINT site_sitesettings_site_id_64dd8ff8_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersoci_user_id_17d28448_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersoci_user_id_17d28448_fk_userprofi FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_addresses userprofile_user_add_address_id_ad7646b4_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_addresses
    ADD CONSTRAINT userprofile_user_add_address_id_ad7646b4_fk_userprofi FOREIGN KEY (address_id) REFERENCES userprofile_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_addresses userprofile_user_add_user_id_bb5aa55e_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_addresses
    ADD CONSTRAINT userprofile_user_add_user_id_bb5aa55e_fk_userprofi FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user userprofile_user_default_billing_addr_0489abf1_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user
    ADD CONSTRAINT userprofile_user_default_billing_addr_0489abf1_fk_userprofi FOREIGN KEY (default_billing_address_id) REFERENCES userprofile_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user userprofile_user_default_shipping_add_aae7a203_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user
    ADD CONSTRAINT userprofile_user_default_shipping_add_aae7a203_fk_userprofi FOREIGN KEY (default_shipping_address_id) REFERENCES userprofile_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_groups userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_groups
    ADD CONSTRAINT userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_groups userprofile_user_groups_user_id_5e712a24_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_groups
    ADD CONSTRAINT userprofile_user_groups_user_id_5e712a24_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_user_permissions userprofile_user_use_permission_id_1caa8a71_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_user_permissions
    ADD CONSTRAINT userprofile_user_use_permission_id_1caa8a71_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: userprofile_user_user_permissions userprofile_user_use_user_id_6d654469_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY userprofile_user_user_permissions
    ADD CONSTRAINT userprofile_user_use_user_id_6d654469_fk_userprofi FOREIGN KEY (user_id) REFERENCES userprofile_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

