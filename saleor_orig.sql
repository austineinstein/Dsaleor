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
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
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
10	Can add group	4	add_group
11	Can change group	4	change_group
12	Can delete group	4	delete_group
13	Can add permission	5	add_permission
14	Can change permission	5	change_permission
15	Can delete permission	5	delete_permission
16	Can add address	7	add_address
17	Can change address	7	change_address
18	Can delete address	7	delete_address
19	Can add user	6	add_user
20	Can change user	6	change_user
21	Can delete user	6	delete_user
22	Can view users	6	view_user
23	Can edit users	6	edit_user
24	Can view groups	6	view_group
25	Can edit groups	6	edit_group
26	Can view staff	6	view_staff
27	Can edit staff	6	edit_staff
28	Can impersonate users	6	impersonate_user
29	Can add voucher	8	add_voucher
30	Can change voucher	8	change_voucher
31	Can delete voucher	8	delete_voucher
32	Can view vouchers	8	view_voucher
33	Can edit vouchers	8	edit_voucher
34	Can add sale	9	add_sale
35	Can change sale	9	change_sale
36	Can delete sale	9	delete_sale
37	Can view sales	9	view_sale
38	Can edit sales	9	edit_sale
39	Can add stock location	12	add_stocklocation
40	Can change stock location	12	change_stocklocation
41	Can delete stock location	12	delete_stocklocation
42	Can view stock location	12	view_stock_location
43	Can edit stock location	12	edit_stock_location
44	Can add category	10	add_category
45	Can change category	10	change_category
46	Can delete category	10	delete_category
47	Can view categories	10	view_category
48	Can edit categories	10	edit_category
49	Can add product	11	add_product
50	Can change product	11	change_product
51	Can delete product	11	delete_product
52	Can view products	11	view_product
53	Can edit products	11	edit_product
54	Can view product properties	11	view_properties
55	Can edit product properties	11	edit_properties
56	Can add product variant	14	add_productvariant
57	Can change product variant	14	change_productvariant
58	Can delete product variant	14	delete_productvariant
59	Can add product image	15	add_productimage
60	Can change product image	15	change_productimage
61	Can delete product image	15	delete_productimage
62	Can add attribute choice value	17	add_attributechoicevalue
63	Can change attribute choice value	17	change_attributechoicevalue
64	Can delete attribute choice value	17	delete_attributechoicevalue
65	Can add variant image	18	add_variantimage
66	Can change variant image	18	change_variantimage
67	Can delete variant image	18	delete_variantimage
68	Can add product attribute	16	add_productattribute
69	Can change product attribute	16	change_productattribute
70	Can delete product attribute	16	delete_productattribute
71	Can add stock	19	add_stock
72	Can change stock	19	change_stock
73	Can delete stock	19	delete_stock
74	Can add product class	13	add_productclass
75	Can change product class	13	change_productclass
76	Can delete product class	13	delete_productclass
77	Can add cart	21	add_cart
78	Can change cart	21	change_cart
79	Can delete cart	21	delete_cart
80	Can add cart line	20	add_cartline
81	Can change cart line	20	change_cartline
82	Can delete cart line	20	delete_cartline
83	Can add payment	24	add_payment
84	Can change payment	24	change_payment
85	Can delete payment	24	delete_payment
86	Can add Ordered line	26	add_orderline
87	Can change Ordered line	26	change_orderline
88	Can delete Ordered line	26	delete_orderline
89	Can add order	27	add_order
90	Can change order	27	change_order
91	Can delete order	27	delete_order
92	Can view orders	27	view_order
93	Can edit orders	27	edit_order
94	Can add order note	22	add_ordernote
95	Can change order note	22	change_ordernote
96	Can delete order note	22	delete_ordernote
97	Can add delivery group	25	add_deliverygroup
98	Can change delivery group	25	change_deliverygroup
99	Can delete delivery group	25	delete_deliverygroup
100	Can add order history entry	23	add_orderhistoryentry
101	Can change order history entry	23	change_orderhistoryentry
102	Can delete order history entry	23	delete_orderhistoryentry
103	Can add shipping method	29	add_shippingmethod
104	Can change shipping method	29	change_shippingmethod
105	Can delete shipping method	29	delete_shippingmethod
106	Can view shipping method	29	view_shipping
107	Can edit shipping method	29	edit_shipping
108	Can add shipping method country	28	add_shippingmethodcountry
109	Can change shipping method country	28	change_shippingmethodcountry
110	Can delete shipping method country	28	delete_shippingmethodcountry
111	Can add site settings	31	add_sitesettings
112	Can change site settings	31	change_sitesettings
113	Can delete site settings	31	delete_sitesettings
114	Can edit site settings	31	edit_settings
115	Can view site settings	31	view_settings
116	Can add authorization key	30	add_authorizationkey
117	Can change authorization key	30	change_authorizationkey
118	Can delete authorization key	30	delete_authorizationkey
119	Can add conversion rate	32	add_conversionrate
120	Can change conversion rate	32	change_conversionrate
121	Can delete conversion rate	32	delete_conversionrate
122	Can add association	37	add_association
123	Can change association	37	change_association
124	Can delete association	37	delete_association
125	Can add user social auth	33	add_usersocialauth
126	Can change user social auth	33	change_usersocialauth
127	Can delete user social auth	33	delete_usersocialauth
128	Can add code	35	add_code
129	Can change code	35	change_code
130	Can delete code	35	delete_code
131	Can add partial	36	add_partial
132	Can change partial	36	change_partial
133	Can delete partial	36	delete_partial
134	Can add nonce	34	add_nonce
135	Can change nonce	34	change_nonce
136	Can delete nonce	34	delete_nonce
137	Can add task result	38	add_taskresult
138	Can change task result	38	change_taskresult
139	Can delete task result	38	delete_taskresult
140	Can add impersonation log	39	add_impersonationlog
141	Can change impersonation log	39	change_impersonationlog
142	Can delete impersonation log	39	delete_impersonationlog
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cart (status, created, last_status_change, email, token, checkout_data, total, quantity, user_id, voucher_id) FROM stdin;
\.


--
-- Data for Name: cart_cartline; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cartline (id, quantity, data, cart_id, variant_id) FROM stdin;
\.


--
-- Data for Name: discount_sale; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_sale (id, name, type, value) FROM stdin;
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
\.


--
-- Data for Name: discount_voucher; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_voucher (id, type, name, code, usage_limit, used, start_date, end_date, discount_value_type, discount_value, apply_to, "limit", category_id, product_id) FROM stdin;
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
4	auth	group
5	auth	permission
6	userprofile	user
7	userprofile	address
8	discount	voucher
9	discount	sale
10	product	category
11	product	product
12	product	stocklocation
13	product	productclass
14	product	productvariant
15	product	productimage
16	product	productattribute
17	product	attributechoicevalue
18	product	variantimage
19	product	stock
20	cart	cartline
21	cart	cart
22	order	ordernote
23	order	orderhistoryentry
24	order	payment
25	order	deliverygroup
26	order	orderline
27	order	order
28	shipping	shippingmethodcountry
29	shipping	shippingmethod
30	site	authorizationkey
31	site	sitesettings
32	django_prices_openexchangerates	conversionrate
33	social_django	usersocialauth
34	social_django	nonce
35	social_django	code
36	social_django	partial
37	social_django	association
38	django_celery_results	taskresult
39	impersonate	impersonationlog
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-02-22 09:56:26.415307+00
2	contenttypes	0002_remove_content_type_name	2018-02-22 09:56:26.589159+00
3	auth	0001_initial	2018-02-22 09:56:26.712592+00
4	auth	0002_alter_permission_name_max_length	2018-02-22 09:56:26.734961+00
5	auth	0003_alter_user_email_max_length	2018-02-22 09:56:26.758819+00
6	auth	0004_alter_user_username_opts	2018-02-22 09:56:26.786848+00
7	auth	0005_alter_user_last_login_null	2018-02-22 09:56:26.811286+00
8	auth	0006_require_contenttypes_0002	2018-02-22 09:56:26.813814+00
9	auth	0007_alter_validators_add_error_messages	2018-02-22 09:56:26.90297+00
10	auth	0008_alter_user_username_max_length	2018-02-22 09:56:26.926102+00
11	django_celery_results	0001_initial	2018-02-22 09:56:26.953475+00
12	django_prices_openexchangerates	0001_initial	2018-02-22 09:56:26.979416+00
13	django_prices_openexchangerates	0002_auto_20160329_0702	2018-02-22 09:56:27.009138+00
14	django_prices_openexchangerates	0003_auto_20161018_0707	2018-02-22 09:56:27.058024+00
15	django_prices_openexchangerates	0004_auto_20170316_0944	2018-02-22 09:56:27.077462+00
16	product	0001_initial	2018-02-22 09:57:27.6806+00
17	product	0002_auto_20150722_0545	2018-02-22 09:57:27.701878+00
18	product	0003_auto_20150820_2016	2018-02-22 09:57:27.76905+00
19	product	0003_auto_20150820_1955	2018-02-22 09:57:27.788307+00
20	product	0004_merge	2018-02-22 09:57:27.790933+00
21	product	0005_auto_20150825_1433	2018-02-22 09:57:27.952357+00
22	product	0006_product_updated_at	2018-02-22 09:57:27.978818+00
23	product	0007_auto_20160112_1025	2018-02-22 09:57:28.051722+00
24	product	0008_auto_20160114_0733	2018-02-22 09:57:28.129117+00
25	product	0009_discount_categories	2018-02-22 09:57:28.170532+00
26	product	0010_auto_20160129_0826	2018-02-22 09:57:28.237982+00
27	product	0011_stock_quantity_allocated	2018-02-22 09:57:28.267367+00
28	product	0012_auto_20160218_0812	2018-02-22 09:57:28.332557+00
29	userprofile	0001_initial	2018-02-22 09:57:28.484589+00
30	discount	0001_initial	2018-02-22 09:57:28.537522+00
31	discount	0002_voucher	2018-02-22 09:57:28.583514+00
32	discount	0003_auto_20160207_0534	2018-02-22 09:57:28.81344+00
33	cart	0001_initial	2018-02-22 09:57:28.965313+00
34	cart	0002_auto_20161014_1221	2018-02-22 09:57:29.057385+00
35	cart	fix_empty_data_in_lines	2018-02-22 09:57:29.120412+00
36	cart	0001_auto_20170113_0435	2018-02-22 09:57:29.29586+00
37	cart	0002_auto_20170206_0407	2018-02-22 09:57:29.587734+00
38	cart	0003_auto_20170906_0556	2018-02-22 09:57:29.621528+00
39	cart	0004_auto_20171129_1004	2018-02-22 09:57:29.684167+00
40	discount	0004_auto_20170206_0407	2018-02-22 09:57:30.003025+00
41	discount	0005_auto_20170919_0839	2018-02-22 09:57:30.050572+00
42	discount	0006_auto_20171129_1004	2018-02-22 09:57:30.108641+00
43	impersonate	0001_initial	2018-02-22 09:57:30.160558+00
44	order	0001_initial	2018-02-22 09:57:30.583517+00
45	order	0002_auto_20150820_1955	2018-02-22 09:57:30.613401+00
46	order	0003_auto_20150825_1433	2018-02-22 09:57:30.675833+00
47	order	0004_order_total	2018-02-22 09:57:30.713531+00
48	order	0005_deliverygroup_last_updated	2018-02-22 09:57:30.75523+00
49	order	0006_deliverygroup_shipping_method	2018-02-22 09:57:30.796017+00
50	order	0007_deliverygroup_tracking_number	2018-02-22 09:57:30.837219+00
51	order	0008_auto_20151026_0820	2018-02-22 09:57:30.956164+00
52	order	0009_auto_20151201_0820	2018-02-22 09:57:31.072082+00
53	order	0010_auto_20160119_0541	2018-02-22 09:57:31.178436+00
54	order	0011_auto_20160207_0534	2018-02-22 09:57:31.311398+00
55	order	0012_auto_20160216_1032	2018-02-22 09:57:31.502003+00
56	order	0013_auto_20160906_0741	2018-02-22 09:57:31.67035+00
57	order	0014_auto_20161028_0955	2018-02-22 09:57:31.706639+00
58	order	0015_auto_20170206_0407	2018-02-22 09:57:32.7315+00
59	order	0016_order_language_code	2018-02-22 09:57:32.783576+00
60	order	0017_auto_20170906_0556	2018-02-22 09:57:32.82531+00
61	order	0018_auto_20170919_0839	2018-02-22 09:57:32.878931+00
62	order	0019_auto_20171109_1423	2018-02-22 09:57:33.137705+00
63	order	0020_auto_20171123_0609	2018-02-22 09:57:33.234575+00
64	order	0021_auto_20171129_1004	2018-02-22 09:57:33.413002+00
65	product	0013_auto_20161207_0555	2018-02-22 09:57:33.595476+00
66	product	0014_auto_20161207_0840	2018-02-22 09:57:33.617861+00
67	product	0015_transfer_locations	2018-02-22 09:57:33.688435+00
68	product	0016_auto_20161207_0843	2018-02-22 09:57:33.719638+00
69	product	0017_remove_stock_location	2018-02-22 09:57:33.747777+00
70	product	0018_auto_20161207_0844	2018-02-22 09:57:33.835816+00
71	product	0019_auto_20161212_0230	2018-02-22 09:57:33.977035+00
72	product	0020_attribute_data_to_class	2018-02-22 09:57:34.050147+00
73	product	0021_add_hstore_extension	2018-02-22 09:57:34.194525+00
74	product	0022_auto_20161212_0301	2018-02-22 09:57:34.350975+00
75	product	0023_auto_20161211_1912	2018-02-22 09:57:34.388239+00
76	product	0024_migrate_json_data	2018-02-22 09:57:34.528784+00
77	product	0025_auto_20161219_0517	2018-02-22 09:57:34.55069+00
78	product	0026_auto_20161230_0347	2018-02-22 09:57:34.576818+00
79	product	0027_auto_20170113_0435	2018-02-22 09:57:34.708395+00
80	product	0013_auto_20161130_0608	2018-02-22 09:57:34.720774+00
81	product	0014_remove_productvariant_attributes	2018-02-22 09:57:34.754504+00
82	product	0015_productvariant_attributes	2018-02-22 09:57:34.806036+00
83	product	0016_auto_20161204_0311	2018-02-22 09:57:35.040911+00
84	product	0017_attributechoicevalue_slug	2018-02-22 09:57:35.098404+00
85	product	0018_auto_20161212_0725	2018-02-22 09:57:35.351036+00
86	product	0026_merge_20161221_0845	2018-02-22 09:57:35.363116+00
87	product	0028_merge_20170116_1016	2018-02-22 09:57:35.367375+00
88	product	0029_product_is_featured	2018-02-22 09:57:35.51176+00
89	product	0030_auto_20170206_0407	2018-02-22 09:57:36.527552+00
90	product	0031_auto_20170206_0601	2018-02-22 09:57:36.658816+00
91	product	0032_auto_20170216_0438	2018-02-22 09:57:36.735775+00
92	product	0033_auto_20170227_0757	2018-02-22 09:57:36.966307+00
93	product	0034_product_is_published	2018-02-22 09:57:37.023432+00
94	product	0035_auto_20170919_0846	2018-02-22 09:57:37.130881+00
95	product	0036_auto_20171115_0608	2018-02-22 09:57:37.217822+00
96	product	0037_auto_20171124_0847	2018-02-22 09:57:37.273976+00
97	product	0038_auto_20171129_0616	2018-02-22 09:57:37.483717+00
98	product	0037_auto_20171129_1004	2018-02-22 09:57:37.690091+00
99	product	0039_merge_20171130_0727	2018-02-22 09:57:37.693146+00
100	sessions	0001_initial	2018-02-22 09:57:37.719148+00
101	shipping	0001_initial	2018-02-22 09:57:37.786265+00
102	shipping	0002_auto_20160906_0741	2018-02-22 09:57:37.839989+00
103	shipping	0003_auto_20170116_0700	2018-02-22 09:57:37.863729+00
104	shipping	0004_auto_20170206_0407	2018-02-22 09:57:38.11423+00
105	shipping	0005_auto_20170906_0556	2018-02-22 09:57:38.131011+00
106	shipping	0006_auto_20171109_0908	2018-02-22 09:57:38.150845+00
107	shipping	0007_auto_20171129_1004	2018-02-22 09:57:38.18939+00
108	sites	0001_initial	2018-02-22 09:57:38.226351+00
109	sites	0002_alter_domain_unique	2018-02-22 09:57:38.250873+00
110	site	0001_initial	2018-02-22 09:57:38.276368+00
111	site	0002_add_default_data	2018-02-22 09:57:38.385501+00
112	site	0003_sitesettings_description	2018-02-22 09:57:38.415939+00
113	site	0004_auto_20170221_0426	2018-02-22 09:57:38.471095+00
114	site	0005_auto_20170906_0556	2018-02-22 09:57:38.491295+00
115	site	0006_auto_20171025_0454	2018-02-22 09:57:38.519975+00
116	site	0007_auto_20171027_0856	2018-02-22 09:57:38.630434+00
117	site	0008_auto_20171027_0856	2018-02-22 09:57:38.703365+00
118	site	0009_auto_20171109_0849	2018-02-22 09:57:38.725518+00
119	site	0010_auto_20171113_0958	2018-02-22 09:57:38.74726+00
120	default	0001_initial	2018-02-22 09:57:38.986375+00
121	social_auth	0001_initial	2018-02-22 09:57:38.989481+00
122	default	0002_add_related_name	2018-02-22 09:57:39.07846+00
123	social_auth	0002_add_related_name	2018-02-22 09:57:39.081545+00
124	default	0003_alter_email_max_length	2018-02-22 09:57:39.109638+00
125	social_auth	0003_alter_email_max_length	2018-02-22 09:57:39.112785+00
126	default	0004_auto_20160423_0400	2018-02-22 09:57:39.173735+00
127	social_auth	0004_auto_20160423_0400	2018-02-22 09:57:39.176971+00
128	social_auth	0005_auto_20160727_2333	2018-02-22 09:57:39.201973+00
129	social_django	0006_partial	2018-02-22 09:57:39.241893+00
130	social_django	0007_code_timestamp	2018-02-22 09:57:39.271199+00
131	social_django	0008_partial_timestamp	2018-02-22 09:57:39.313503+00
132	userprofile	0002_auto_20150907_0602	2018-02-22 09:57:39.430535+00
133	userprofile	0003_auto_20151104_1102	2018-02-22 09:57:39.510124+00
134	userprofile	0004_auto_20160114_0419	2018-02-22 09:57:39.554001+00
135	userprofile	0005_auto_20160205_0651	2018-02-22 09:57:39.637861+00
136	userprofile	0006_auto_20160829_0819	2018-02-22 09:57:39.836442+00
137	userprofile	0007_auto_20161115_0940	2018-02-22 09:57:39.93518+00
138	userprofile	0008_auto_20161115_1011	2018-02-22 09:57:39.987027+00
139	userprofile	0009_auto_20170206_0407	2018-02-22 09:57:40.196479+00
140	userprofile	0010_auto_20170919_0839	2018-02-22 09:57:40.253547+00
141	userprofile	0011_auto_20171110_0552	2018-02-22 09:57:40.307439+00
142	userprofile	0012_auto_20171117_0846	2018-02-22 09:57:40.355252+00
143	userprofile	0013_auto_20171120_0521	2018-02-22 09:57:40.513303+00
144	userprofile	0014_auto_20171129_1004	2018-02-22 09:57:40.594185+00
145	social_django	0002_add_related_name	2018-02-22 09:57:40.599045+00
146	social_django	0003_alter_email_max_length	2018-02-22 09:57:40.601617+00
147	social_django	0004_auto_20160423_0400	2018-02-22 09:57:40.604241+00
148	social_django	0001_initial	2018-02-22 09:57:40.606756+00
149	social_django	0005_auto_20160727_2333	2018-02-22 09:57:40.609507+00
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
\.


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_order (id, status, created, last_status_change, tracking_client_id, user_email, token, billing_address_id, shipping_address_id, user_id, total_net, total_tax, discount_amount, discount_name, voucher_id, language_code) FROM stdin;
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
\.


--
-- Data for Name: product_attributechoicevalue; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_attributechoicevalue (id, name, color, attribute_id, slug) FROM stdin;
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_category (id, name, slug, description, hidden, lft, rght, tree_id, level, parent_id) FROM stdin;
\.


--
-- Data for Name: product_product; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_product (id, name, description, price, available_on, updated_at, product_class_id, attributes, is_featured, is_published) FROM stdin;
\.


--
-- Data for Name: product_product_categories; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_product_categories (id, product_id, category_id) FROM stdin;
\.


--
-- Data for Name: product_productattribute; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productattribute (id, slug, name) FROM stdin;
\.


--
-- Data for Name: product_productclass; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass (id, name, has_variants, is_shipping_required) FROM stdin;
\.


--
-- Data for Name: product_productclass_product_attributes; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass_product_attributes (id, productclass_id, productattribute_id) FROM stdin;
\.


--
-- Data for Name: product_productclass_variant_attributes; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass_variant_attributes (id, productclass_id, productattribute_id) FROM stdin;
\.


--
-- Data for Name: product_productimage; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productimage (id, image, ppoi, alt, "order", product_id) FROM stdin;
\.


--
-- Data for Name: product_productvariant; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productvariant (id, sku, name, price_override, product_id, attributes) FROM stdin;
\.


--
-- Data for Name: product_stock; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_stock (id, quantity, cost_price, variant_id, quantity_allocated, location_id) FROM stdin;
\.


--
-- Data for Name: product_stocklocation; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_stocklocation (id, name) FROM stdin;
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
\.


--
-- Data for Name: shipping_shippingmethodcountry; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY shipping_shippingmethodcountry (id, country_code, price, shipping_method_id) FROM stdin;
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
\.


--
-- Data for Name: userprofile_user; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user (id, is_superuser, email, is_staff, is_active, password, date_joined, last_login, default_billing_address_id, default_shipping_address_id) FROM stdin;
\.


--
-- Data for Name: userprofile_user_addresses; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY userprofile_user_addresses (id, user_id, address_id) FROM stdin;
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

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('auth_permission_id_seq', 142, true);


--
-- Name: cart_cartline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('cart_cartline_id_seq', 1, false);


--
-- Name: discount_sale_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_categories_id_seq', 1, false);


--
-- Name: discount_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_id_seq', 1, false);


--
-- Name: discount_sale_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_sale_products_id_seq', 1, false);


--
-- Name: discount_voucher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('discount_voucher_id_seq', 1, false);


--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_celery_results_taskresult_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_content_type_id_seq', 39, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_migrations_id_seq', 149, true);


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

SELECT pg_catalog.setval('order_deliverygroup_id_seq', 1, false);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_order_id_seq', 1, false);


--
-- Name: order_ordereditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_ordereditem_id_seq', 1, false);


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

SELECT pg_catalog.setval('order_payment_id_seq', 1, false);


--
-- Name: product_attributechoicevalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_attributechoicevalue_id_seq', 1, false);


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_category_id_seq', 1, false);


--
-- Name: product_product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_product_categories_id_seq', 1, false);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_product_id_seq', 1, false);


--
-- Name: product_productattribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productattribute_id_seq', 1, false);


--
-- Name: product_productclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_id_seq', 1, false);


--
-- Name: product_productclass_product_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_product_attributes_id_seq', 1, false);


--
-- Name: product_productclass_variant_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productclass_variant_attributes_id_seq', 1, false);


--
-- Name: product_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productimage_id_seq', 1, false);


--
-- Name: product_productvariant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_productvariant_id_seq', 1, false);


--
-- Name: product_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_stock_id_seq', 1, false);


--
-- Name: product_stocklocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_stocklocation_id_seq', 1, false);


--
-- Name: product_variantimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('product_variantimage_id_seq', 1, false);


--
-- Name: shipping_shippingmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('shipping_shippingmethod_id_seq', 1, false);


--
-- Name: shipping_shippingmethodcountry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('shipping_shippingmethodcountry_id_seq', 1, false);


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

SELECT pg_catalog.setval('userprofile_address_id_seq', 1, false);


--
-- Name: userprofile_user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_addresses_id_seq', 1, false);


--
-- Name: userprofile_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_groups_id_seq', 1, false);


--
-- Name: userprofile_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_id_seq', 1, false);


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

