--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.11
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
-- Name: account_address; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE account_address (
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


ALTER TABLE account_address OWNER TO aa;

--
-- Name: account_user; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE account_user (
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


ALTER TABLE account_user OWNER TO aa;

--
-- Name: account_user_addresses; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE account_user_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE account_user_addresses OWNER TO aa;

--
-- Name: account_user_groups; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE account_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE account_user_groups OWNER TO aa;

--
-- Name: account_user_user_permissions; Type: TABLE; Schema: public; Owner: aa
--

CREATE TABLE account_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE account_user_user_permissions OWNER TO aa;

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

ALTER SEQUENCE userprofile_address_id_seq OWNED BY account_address.id;


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

ALTER SEQUENCE userprofile_user_addresses_id_seq OWNED BY account_user_addresses.id;


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

ALTER SEQUENCE userprofile_user_groups_id_seq OWNED BY account_user_groups.id;


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

ALTER SEQUENCE userprofile_user_id_seq OWNED BY account_user.id;


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

ALTER SEQUENCE userprofile_user_user_permissions_id_seq OWNED BY account_user_user_permissions.id;


--
-- Name: account_address id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_address ALTER COLUMN id SET DEFAULT nextval('userprofile_address_id_seq'::regclass);


--
-- Name: account_user id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user ALTER COLUMN id SET DEFAULT nextval('userprofile_user_id_seq'::regclass);


--
-- Name: account_user_addresses id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_addresses ALTER COLUMN id SET DEFAULT nextval('userprofile_user_addresses_id_seq'::regclass);


--
-- Name: account_user_groups id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_groups ALTER COLUMN id SET DEFAULT nextval('userprofile_user_groups_id_seq'::regclass);


--
-- Name: account_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('userprofile_user_user_permissions_id_seq'::regclass);


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
-- Data for Name: account_address; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY account_address (id, first_name, last_name, company_name, street_address_1, street_address_2, city, postal_code, country, country_area, phone, city_area) FROM stdin;
1	Sean	Ellison		1157 Sean Estates		Kellyview	37883-9121	BT			
2	Randy	Turner		60284 Claudia Crescent Suite 421		Stevenville	99993	BI			
3	William	Meadows		2525 Joshua Path		East Katherine	95821	KN			
4	Theresa	Miller		26188 Castillo Square Apt. 794		Tammyfurt	38381-4462	ML			
5	Alexander	Nixon		29252 Peterson Terrace		West Christianburgh	95429	MH			
6	Anthony	Durham		773 Wilson Parkway Apt. 561		East Christopher	54626	MW			
7	Kendra	Stevens		327 Haynes Stravenue Apt. 244		Lake Ravenport	67955	BN			
8	Amy	Frey		016 Karen Springs		Randychester	68318-0094	ID			
9	Samantha	Lopez		5521 Denise Inlet Apt. 878		Chambersside	07861-6255	GN			
10	Joel	Mckee		14884 Samuel Centers		Port Claudia	71190-7093	KE			
11	Lisa	Daniels		32169 Richard Corner Apt. 391		South Raymondfurt	79447	KR			
12	John	Lopez		08244 Garcia Corners Apt. 064		Port Hannahside	39267	BR			
13	Evan	Lowery		969 Robert Flat		Amyborough	41706	MU			
14	David	Hamilton		0765 Kristen Key Apt. 434		Pierceburgh	46331	AF			
15	Anthony	Pierce		440 Perez Groves		Banksborough	78137-5621	FJ			
16	Angela	Duarte		63007 Espinoza Burgs		East Adam	35374-2983	DE			
17	Trevor	Brown		0281 Shelton Crossroad		New Emilyside	81917-8351	VN			
18	Cynthia	Hudson		2945 Cassandra Springs		Marshallmouth	68355	GE			
19	Steve	Jones		968 Atkins Shoals		Port Bobbychester	39467	NP			
20	Nicholas	Maynard		780 Monique Summit Suite 806		Vasquezfort	59277	CN			
21	Patricia	Wong		257 Garcia Passage Apt. 732		Sullivanshire	17344-3287	NG			
22	Joshua	Porter		6351 Matthews Station Suite 714		West Robert	70299	GM			
23	Manuel	Taylor		8217 Brian Lake Suite 226		Kaylachester	67474	LS			
24	Glenn	Torres		622 Estrada Circle Suite 261		Lake Dana	13064	CR			
25	Janice	Rodriguez		3448 William Mountains Apt. 666		Alisonport	86432	AU			
26	Monique	Cervantes		8237 Juan Orchard		Davisbury	14640-0984	EE			
27	Mark	Norris		718 Lewis Tunnel Apt. 290		Lake Melodyland	71581	SO			
28	Colleen	Marshall		3164 Holt Mountains Suite 935		New Robert	85740-3239	CI			
29	Melanie	Collins		7827 Harvey Roads		South Danielstad	27835	KN			
30	Cassandra	Dixon		51415 Taylor Station Suite 600		Markmouth	34784-9737	LK			
31	Michael	Jenkins		1663 Rogers Highway Apt. 783		Colemouth	23377-9632	CA			
32	Jeffrey	Hanson		380 Kelli Place Apt. 335		East Alejandro	70492-5712	LS			
33	Emily	Williams		8303 Rhodes Meadow Suite 254		Robertfurt	15691-5190	NR			
34	Raymond	Hardy		3329 Marshall Shoal		East Mariaburgh	96399-2727	BY			
35	Yolanda	Lara		99288 Wall Curve Suite 631		Careystad	33899	GT			
36	John	Green		661 Anthony Flats		New Jaredberg	88385-7757	MC			
37	Bryan	Lopez		374 Eaton Wells Suite 947		Traceyton	98581-2804	KH			
38	Steven	Aguilar		0723 Kimberly Course		New Joel	36997-3042	LB			
39	Krystal	Neal		149 Tyler Fields Apt. 276		North Tracy	33609-3827	SR			
40	Lori	Cowan		83223 Kyle Isle Suite 609		East Tracy	78798-4689	ET			
41	Peter	Hogan		92177 Crystal Forest		New Benjamin	96785	BW			
42	Peter	Keith		887 Katherine Mews		South Carolynhaven	39414-8237	SZ			
43	Dustin	Peterson		591 Baker Islands Apt. 898		Port Noahtown	85255-2845	KI			
44	Tamara	Rivera		478 Hall Club		North Danielle	05864-4524	LT			
45	Tara	Pham		27218 Daniel Divide		Lake Jamestown	76357	PH			
46	Dylan	Rivera		2865 Mark Estate		Lake Kristophertown	71746	BN			
47	Joshua	Jones		8169 Cindy Fork Apt. 413		East Eric	22201-8580	LU			
48	Anthony	Mccoy		861 Rice Island		West Derrickton	04736-2062	LU			
49	Sarah	Padilla		602 Walker Street Apt. 860		South George	91886-2232	KH			
50	Joseph	Perez		8168 Jackson Forge Apt. 308		Carpenterstad	07101-2764	PL			
51	Judith	Cardenas		21710 Bowen Orchard		Lake Johnathan	47648-3001	BE			
52	Bethany	Jimenez		185 Duncan Locks Apt. 470		Lake Jillfurt	35869	NR			
53	Crystal	Williams		01422 Donald Knoll		Callahanchester	55125	CI			
54	Cameron	Perry		4830 Olson Squares Suite 107		Gregoryton	01296-8255	KI			
55	Kristin	Summers		86666 Andrew Ways		East Susan	68236-1859	MN			
56	Donald	Olson		5521 Horton Common Apt. 014		Barnesland	21471-0850	UA			
57	Lisa	Johnson		93190 Barron Freeway Apt. 111		Port Kim	44270	TR			
58	Sarah	Nelson		8296 Carol Lodge Suite 289		North Sergioside	42867	VC			
59	Jesus	Reed		69060 Cameron Cove Suite 684		Jonesstad	64107-3121	CF			
60	Mary	Cordova		90193 David Spring Apt. 365		Lake Claudiaberg	60953	TR			
61	Nancy	Johnson		623 Mendez Centers Suite 838		West Brian	72891-9191	ER			
62	Zachary	Allen		9378 Brown Station		East Elizabeth	33778-6179	CO			
63	Benjamin	Vance		40898 Griffin Lodge Suite 504		Ramirezland	17068-8645	MZ			
64	Tammy	Chambers		240 Steven Shoals		Susanview	25674	LV			
65	Jacqueline	Odonnell		583 Yang Spurs Suite 908		Lake Corey	43866	BS			
66	Darrell	Jennings		92685 Evans Rest Suite 239		New Jacqueline	22188	MG			
67	Stacey	Hudson		127 Cohen Centers		Angelaborough	24793-3038	BZ			
68	Elizabeth	Davis		762 Howell Branch Apt. 102		Hansonshire	85683	BG			
69	Kristina	Clark		74365 Davis Lodge		Lake Ellen	21420	PE			
70	Robert	Blevins		634 Ortiz Stravenue Suite 942		East Danielport	34413	KW			
71	Shannon	Hanson		344 Bailey Junctions Suite 260		Port Thomas	95936	AZ			
72	Tommy	Barrera		70444 Sarah Lake Suite 159		New John	10960-5843	GN			
73	Thomas	Ramirez		0495 Hawkins Green		Lake Sharonview	41151-8639	AD			
74	Dustin	Perez		630 Montgomery Wells Suite 194		South Nicholas	69148	BZ			
75	Crystal	Lynch		085 Mendoza Locks		Carlsonport	77147-4540	FJ			
76	Leslie	Gardner		22777 Marissa Mill Apt. 513		Marymouth	60460	SB			
77	Harold	Beasley		5420 Soto Square Suite 321		Martinchester	53857	GH			
78	Joyce	Reyes		94204 Sara Union Suite 796		West Roger	96554-1656	CV			
79	Leslie	Lane		32186 Christopher Hills Apt. 533		Port Annette	47614	IT			
80	Sarah	Hernandez		813 Kim Drive		Hallmouth	10135	ZW			
81	Gloria	Bell		1040 John Landing		Tracyton	16094	CF			
82	Kathleen	Howell		25128 Sandra Ville		North Angela	65920-0899	AF			
83	Deanna	Howe		335 Anderson Green		East Jerome	99505-8671	HN			
84	Benjamin	Arroyo		22276 William Club Apt. 352		New Elizabethberg	07552-1050	KW			
85	Cameron	Ward		462 Hendricks Springs Apt. 260		Port Joshuaville	32429-6167	HR			
86	Daniel	Scott		322 Sandra Mills		Trevorside	92412-1072	HU			
87	Joshua	Cruz		65704 Green Pass Suite 806		Kathystad	15050	ID			
88	Pamela	Robinson		88340 Kristen Rapid Suite 884		Lake Tyler	29606-4031	ID			
89	Jose	Baker		191 Kathryn Grove Apt. 387		North Brian	76144	NI			
90	Monica	Gibson		006 Bryan Flat		New Jonathanbury	41835-2769	MV			
91	Stanley	Gentry		1791 Freeman Plains		Phillipsland	11065	SI			
92	James	Franco		960 Kyle Haven Suite 765		Johnsonview	64024	KZ			
93	Carol	Boone		5735 Gill Viaduct Suite 160		East Jeffreyville	71486	GT			
94	Joshua	Tran		558 Amanda Walk Apt. 180		South Jennyton	15332	ME			
95	Scott	Glass		570 Samuel Knoll Suite 285		Lake Margaret	59199-8491	SD			
96	Yolanda	Hooper		37607 Shelton Forest		Port Peter	28961-7239	MY			
97	Debra	Perez		6736 Thompson Fall Apt. 214		East Robert	32013	EE			
98	Robin	Giles		62010 Callahan Fords Suite 369		Adkinsberg	08847-7006	NR			
99	Michael	Joseph		1038 Kimberly View		Richardmouth	32774-1103	HN			
100	Dustin	Shepard		80556 Rice Street Apt. 825		Grayberg	86435	MY			
101	Ashley	Baird		994 Lowe Canyon		Richardfurt	77364-2846	KN			
102	Andrea	Mitchell		98700 Jill Prairie		New Lindaborough	25134	TO			
103	Veronica	Bowers		6848 Daniel Walks		Port Juliachester	12908	PH			
104	Craig	Cardenas		6240 Amber Branch Apt. 646		West Lindamouth	18656	MT			
105	Tiffany	Thomas		0962 Carlson Station Apt. 079		Lopezhaven	01840-9238	LV			
106	Julie	Cole		154 Brandon Extensions Suite 548		Bettymouth	37319	DJ			
107	Cody	Robinson		086 Gray Fort Suite 521		Williamsland	22191-7112	BO			
108	Richard	Mccoy		620 Anderson Fall		Munozview	44588	CY			
109	Matthew	Conley		168 Gina Crest Apt. 472		Olsonside	41949	BR			
110	Glenn	Clark		057 James Hills		New Ray	86484-6170	SR			
111	Joann	Baker		50122 Virginia Villages		Port Jennifer	77121	LI			
112	Theodore	Flowers		93980 Lee Stream		Danielchester	05270	QA			
113	Maurice	Hubbard		7242 Mark Highway Suite 607		Kingland	62317	PT			
114	Maria	Morton		3551 Sarah Flats Suite 679		Robertstad	80363	BZ			
115	Michelle	Knight		545 Travis Courts		Port Tiffany	63718	IR			
116	Daniel	Swanson		0974 Huerta Mews Suite 424		South Maryborough	88236	IE			
117	Mason	Patel		50996 Benjamin Valleys Suite 619		Coreyhaven	92699	PH			
118	Molly	Bennett		907 Ruth Bridge		Davidfurt	19610-9530	SG			
119	Richard	Martin		4219 Cunningham Mountain Apt. 552		East Anitaland	17069-1313	SV			
120	Jason	Simon		297 Mercer Mews		East Lisashire	18248	CN			
121	Dustin	Johnston		830 Amy Plains Apt. 247		Lake Maryport	23110-2334	ST			
122	Shannon	Browning		3434 Hill Creek Apt. 338		West Corey	39488	LI			
123	James	Villarreal		83106 Moreno Canyon Apt. 866		Williammouth	90781	MW			
124	Daniel	Evans		4354 Susan Wells		Brianbury	27920-7142	SG			
125	Kendra	Bruce		984 James Lodge Suite 316		Fuentesfurt	90272	KZ			
126	Phillip	Clark		84019 Evans Stream		Nielsenfort	27746	GB			
127	Susan	Cooper		3699 Holmes Hollow		Ariasberg	38650-4176	RW			
128	Mary	Powell		62821 Meghan Pass Apt. 320		Eileenchester	16517-3168	ZM			
129	Christopher	Johnson		7197 Robert Roads Apt. 493		Spencerborough	60665	TR			
130	Anthony	Peterson		7042 Eric Lodge Apt. 392		Valeriestad	47502-8755	MX			
131	Sonya	Morris		1417 Dennis Island Suite 708		Nancyville	98897-4335	HR			
132	Gary	Perry		8825 Miller Island		Petersburgh	32861	CI			
133	Luke	Sutton		222 Donald Shoals Suite 824		West Raymondton	49939	DM			
134	Manuel	Dunn		702 Jonathan Forks		Shawport	35088-4025	NG			
135	Christopher	Rivera		8301 Charles Corner Apt. 739		North Sarah	46052-7349	MU			
136	Karla	Brown		46296 Wilkinson Mountain		Buchananstad	92131	MU			
137	Michael	Duncan		3493 Murray Views Suite 236		Johnfurt	66279	IN			
138	Kelli	Hughes		7419 Hernandez Crossroad Apt. 117		New Ana	08056	GQ			
139	Yolanda	Moore		3025 Donna Meadow Suite 181		Evansmouth	71566-3595	CY			
140	Carla	Wade		747 Richard Points Apt. 495		Jeffreytown	29581-6030	AZ			
141	Alex	Miller		90116 David Plains		Jordanbury	04490-4440	AR			
142	Eric	Hunter		13347 Emily Alley Apt. 456		East Lisa	71654-7694	LU			
143	Linda	Small		976 Kelly Squares		Wardshire	83711-3266	ZA			
144	Frederick	Fisher		92440 Monica Glen Apt. 906		South Lisa	04421-0869	YE			
145	Diana	Mack		963 Delgado Junction Suite 088		Scottside	35893-9795	TM			
146	Robert	Gutierrez		0785 Horton Squares Suite 799		Port Jessicaview	53733	UY			
147	Jonathan	Riley		693 Woods Extension		Wendyhaven	47190	NP			
148	Christopher	Valenzuela		7525 Megan Prairie Suite 113		Davidshire	98424	RS			
149	Mitchell	Guerrero		56747 Ayers Dale Apt. 958		Medinamouth	66656-5741	BG			
150	Kevin	Hayes		597 Butler Pines Suite 983		Lake Michaelhaven	70887	PW			
151	Amanda	Stout		49051 Jessica Way Apt. 834		Brycebury	33981-4233	RO			
152	Cynthia	Edwards		84558 Anderson Viaduct Apt. 715		South Tylerview	45996-6101	LT			
153	Kyle	Maynard		214 David Forest		Heathermouth	73442	LR			
154	Diane	Carlson		94839 Medina Rapid Apt. 852		Clementstown	88523-9542	NE			
155	Judith	Macdonald		56423 Brown Crossing Suite 394		New Travis	41458	SE			
156	Emily	Gill		5324 Shields Alley Apt. 883		New Joel	59702	MR			
157	Jennifer	Rhodes		013 Katherine Rapid Suite 260		North Cassandrahaven	70330	JO			
158	Jamie	Boyer		99562 Miller Corners Suite 879		Susanton	17905	US			
159	Nichole	Wiley		54331 Eric Greens Suite 315		Derekside	25512-5256	SB			
160	Kevin	Perez		0333 Hogan Pike Apt. 050		Danielside	43852	PK			
161	John	Freeman		2939 Michael Land Apt. 918		South Carolchester	62772	JP			
162	Mary	Barnes		867 Michael Gateway		Brownland	42751	PW			
163	David	Green		2611 Felicia Ford Suite 335		South Logan	31253	AD			
164	Cory	Walker		43838 Smith Isle Apt. 416		Port Hunterview	04438	NO			
177	Jerome	Winters		1780 Hansen Neck		Sarahport	30956-4333	BG			
178	Ashley	Schneider		83460 Jesus Village		East Deborahside	89568	UZ			
179	Debra	Burke		001 Cook Point Suite 586		Lake Lisa	82942	MK			
180	Antonio	Campbell		1064 Garcia Haven		North Amy	56237	CR			
181	Scott	Martin		5128 Schwartz Road		Port Joseph	17196	BG			
182	Scott	Larsen		614 Lawrence Via Apt. 048		Wallhaven	98585	TT			
183	Timothy	Young		23254 Parker Lodge		Port Aaron	68684-1738	CO			
184	Natasha	Novak		4473 Burton Village		New Jennifer	04712-6646	AL			
185	Alejandra	Blackburn		006 Alexandra Course		Lake Steven	16898	SO			
186	Claire	Cross		18588 Carter Viaduct Apt. 842		South Johnburgh	68723-3011	LB			
187	Donna	Williams		62597 Kim Flat		South Ellen	06969	ZM			
188	Karen	Lambert		004 Atkins Skyway		Lake Aliciaview	99819-6072	SN			
189	Philip	Garcia		9821 Mercedes Burgs Apt. 861		Collinsmouth	55724-8358	PK			
190	Kristin	Wong		852 Jorge Isle Suite 965		Lake Jenniferfurt	30519-1912	TV			
191	Christine	Bennett		9942 Rivera Skyway Apt. 658		Lake Troytown	13488	BH			
192	Christopher	Hernandez		4027 Salas Springs Suite 125		New Deborah	91813-6490	BZ			
193	Kyle	Miller		945 Chelsea View Apt. 742		Heatherhaven	42016	PY			
194	Glen	Erickson		71887 Aaron Harbor Suite 826		Port Christopher	02350	VC			
195	Michael	Ali		1557 Jessica Square		Michaelstad	36004-9898	BG			
196	Zachary	Butler		73045 Thompson Lodge		Ramireztown	49558	PH			
197	Mark	Melendez		7533 Miller Manor		Lake Carrie	84069-3032	CY			
198	Courtney	Lee		0213 Aaron Islands		Scottville	24113	GM			
199	Gregory	Austin		92021 Robert Trail		North Margaretstad	87782-0799	BE			
200	Anna	Robinson		7713 Benjamin Mall Apt. 575		Kevinville	89828	AM			
201	Katrina	Russell		8607 Ferguson Trace		West Samuelview	44021-6398	AO			
202	Carlos	Anderson		748 Vargas Park Suite 308		Port Donnaton	27122-6168	OM			
203	Gerald	Greene		4178 Natalie Highway Suite 764		West Brittanyland	31352	SM			
204	Brian	Anderson		12381 Stanley Skyway Apt. 331		South Davidshire	91670	EC			
205	Bradley	Patel		440 Alexis Highway Apt. 748		Kristinville	84188	KW			
206	Jeanette	Perez		20900 David Corners		Gilbertville	59422	MZ			
207	Christine	Beck		941 Hall Valley Suite 393		Allenburgh	69102	FM			
208	Heidi	Thompson		3891 Gary Villages Suite 837		Port Alexanderstad	63086	JM			
209	Elizabeth	Livingston		740 Gina Brooks		South Kaylahaven	26185	MW			
210	Matthew	Brown		3227 Torres Field		North Davidfurt	88632-3364	CG			
211	Christine	Jones		115 Patrick Manors		South Timothymouth	17236-2277	NI			
212	Caleb	Howell		1172 Chapman Circle Suite 051		Herbertchester	81295-0993	GB			
213	Evan	Nguyen		631 Moore Cliff		North Robintown	17567-8606	DO			
214	Ryan	Dennis		88055 Farley Harbors		Matthewmouth	04088-5834	GA			
215	Jimmy	Rodriguez		476 Little Bridge		Briannamouth	23618-3215	GB			
216	Jeremiah	Cain		2298 Gina Plains		New Johnview	56466	IS			
217	Kenneth	Compton		071 Tara Locks Apt. 909		Sharonfurt	60736	AD			
\.


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY account_user (id, is_superuser, email, is_staff, is_active, password, date_joined, last_login, default_billing_address_id, default_shipping_address_id) FROM stdin;
1	f	sean.ellison@example.com	f	t	pbkdf2_sha256$36000$4IFxGfGzayeC$R+bHedXpBcubhlx4xWmtVjqIv6z3VcI/o/2TEfCz/Kg=	2018-02-22 10:00:36.879681+00	\N	1	1
2	f	randy.turner@example.com	f	t	pbkdf2_sha256$36000$X2UsNTc6jHoQ$oTG7T1lF7f0QNFVOBkC9eDrzI+vrzSSFN96eoX1Ei1g=	2018-02-22 10:00:36.950299+00	\N	2	2
3	f	william.meadows@example.com	f	t	pbkdf2_sha256$36000$ShCNLpPpIMDL$z5Eh5a07hXBt13Cv4qJI36MxJpR2d2dJFCLEnrFoSm0=	2018-02-22 10:00:37.01523+00	\N	3	3
4	f	theresa.miller@example.com	f	t	pbkdf2_sha256$36000$BoQXeyKwu10N$cDUH5G5e651ZsO7vrez98leoLtwq8YaB58J7iB8N9jw=	2018-02-22 10:00:37.074349+00	\N	4	4
21	f	admin@yahoo.com	f	t	pbkdf2_sha256$36000$ZoaVSYykGr7b$yr/mZuu9yx9QeReob5rfWtf80alI0knIsBqhwqzMhL0=	2018-02-22 10:25:19.014687+00	2018-03-13 05:05:39.16745+00	\N	\N
5	f	alexander.nixon@example.com	f	t	pbkdf2_sha256$36000$G8siXMKBHurS$wNlAHir1dMIubIGn0ZFL+fPT9xehpDwO9OiIHjXL4sg=	2018-02-22 10:00:37.135584+00	\N	5	5
6	f	anthony.durham@example.com	f	t	pbkdf2_sha256$36000$H4aFlasDg4le$3QWqCOV7B7LXSwi0uZS8ESz9amsj+08IxDJB1xWaHwA=	2018-02-22 10:00:37.193696+00	\N	6	6
7	f	kendra.stevens@example.com	f	t	pbkdf2_sha256$36000$A8gFeHfznVIi$FNjUXc7aV1HtYoUJ+sWB/+sm7/q+lujmo5zUdYBr5vo=	2018-02-22 10:00:37.258966+00	\N	7	7
8	f	amy.frey@example.com	f	t	pbkdf2_sha256$36000$Z8WO7NfFRsPY$wI4+oql1HBaU5O0H7L6UDUq+DLC6nRsoOxIrCgFBajE=	2018-02-22 10:00:37.31584+00	\N	8	8
9	f	samantha.lopez@example.com	f	t	pbkdf2_sha256$36000$4M4YrNbwSmid$7I7et0Ad8a+SOfeaVeVH6vo2NFOSVayPqyUTwkGbLoA=	2018-02-22 10:00:37.370946+00	\N	9	9
10	f	joel.mckee@example.com	f	t	pbkdf2_sha256$36000$lMy5g3rYi5cq$B7brYp9Fl8KnYA9OqmVAnnh1N3uLTYTT1hMDwSJyN7g=	2018-02-22 10:00:37.432651+00	\N	10	10
11	f	lisa.daniels@example.com	f	t	pbkdf2_sha256$36000$3A7Nt0M2bNZr$6ybN7/vERzm8WZWDzQhpmGSDaV77T4HVg39QEM2ho4o=	2018-02-22 10:00:37.491227+00	\N	11	11
12	f	john.lopez@example.com	f	t	pbkdf2_sha256$36000$9PLSTEXQMf79$qAUzsMivOK9ZInAIFx9n+7BmdEmqEGT2GGJ3ZG7dKfU=	2018-02-22 10:00:37.550003+00	\N	12	12
13	f	evan.lowery@example.com	f	t	pbkdf2_sha256$36000$cn8UJfa8N6Hu$DQANA/r9muBiXm7R6tguxJ72Ovg64gq5no5v2SGVuks=	2018-02-22 10:00:37.607665+00	\N	13	13
14	f	david.hamilton@example.com	f	t	pbkdf2_sha256$36000$wwUIUjk7lG6e$C9ZTZhqDU76zzg8lbSOg04SPlBcw7tu4FQLRZu4McZM=	2018-02-22 10:00:37.664536+00	\N	14	14
15	f	anthony.pierce@example.com	f	t	pbkdf2_sha256$36000$C7qql3OtmE4m$xlgDsU9BvpUIcWPkstaXYmwDYQX8bLU9MG3mJ7sPLIs=	2018-02-22 10:00:37.722638+00	\N	15	15
16	f	angela.duarte@example.com	f	t	pbkdf2_sha256$36000$iKPvMCXD2nq4$hUee7z/RMDd//4eudAXIjhq9JLTd8OrleS9zhR7xJMA=	2018-02-22 10:00:37.779484+00	\N	16	16
17	f	trevor.brown@example.com	f	t	pbkdf2_sha256$36000$tX1yFCisX3cJ$/BZSI7DjbQAQxm4u/QcFDcRsajkQ+/F0BIGLwN1G7sU=	2018-02-22 10:00:37.839829+00	\N	17	17
18	f	cynthia.hudson@example.com	f	t	pbkdf2_sha256$36000$RU2Lc8HDClhH$f7NyfSbp6md86WDaNtldWN6dVEWzZu32MB04CVh0eJc=	2018-02-22 10:00:37.896724+00	\N	18	18
19	f	steve.jones@example.com	f	t	pbkdf2_sha256$36000$4RL15j97nj6N$d9iWTcGj0bxxgyavJQi392ao8NrYCMn16UhAlF2ruIE=	2018-02-22 10:00:37.954153+00	\N	19	19
20	f	nicholas.maynard@example.com	f	t	pbkdf2_sha256$36000$5VuZMX0CiTA2$TGB10kE89ySNJTdDhiBmK13+kRrjKydYnHm7Je1kn7E=	2018-02-22 10:00:38.010783+00	\N	20	20
22	t	thmaxx@yahoo.com	t	t	pbkdf2_sha256$36000$qClgO3XeiE8J$kzHjc6lGJHK6D6Q53auOYMo7k82wK3dkLlYzTjiBl8k=	2018-02-24 14:28:12.936639+00	\N	\N	\N
23	f	cassandra.dixon@example.com	f	t	pbkdf2_sha256$36000$cXYAJDmE64Bz$Hc+BQkJ3L/py9wJhGHyBuvY/e4KLzvDxJbYGxlaXZuQ=	2018-02-24 14:34:09.041513+00	\N	30	30
24	f	michael.jenkins@example.com	f	t	pbkdf2_sha256$36000$qC4SOEEMf8iw$cSVAtyVvCKIVWy2M4hae7YcHdGyvVMztF6I9sWl9ZLY=	2018-02-24 14:34:09.219066+00	\N	31	31
25	f	jeffrey.hanson@example.com	f	t	pbkdf2_sha256$36000$8tH3XA6eYVij$d5IRG44ydxauG7zPe2G/Dz8hDDJTw6FR7PUxAVHmRSg=	2018-02-24 14:34:09.356895+00	\N	32	32
26	f	emily.williams@example.com	f	t	pbkdf2_sha256$36000$T52df293Xz59$0nbw8K2KGpnfdHL7PMZ02OfI7yB7FUEJuwquAvxglF8=	2018-02-24 14:34:09.446062+00	\N	33	33
27	f	raymond.hardy@example.com	f	t	pbkdf2_sha256$36000$Dw0XtEn6hOwb$NcZECstOMnf8aw3OQRgekrFKOwOeVKuAqXlQDmyqw74=	2018-02-24 14:34:09.543174+00	\N	34	34
28	f	yolanda.lara@example.com	f	t	pbkdf2_sha256$36000$OSVPKF3Fuzs5$5Naew7YZa/tlyMadehjXZTuMYr9RD/OcNNpfHT21HLg=	2018-02-24 14:34:09.857586+00	\N	35	35
29	f	john.green@example.com	f	t	pbkdf2_sha256$36000$jeIRCRysh55m$MaFedOyf7+XWx21BUFovt9TzwAhiBCrPZzZXGzvCrw8=	2018-02-24 14:34:10.031743+00	\N	36	36
30	f	bryan.lopez@example.com	f	t	pbkdf2_sha256$36000$feV2OzWkpTNG$0KK+w42N+j+a1+sr0XK6cvxPh313FNSEMGCpZkL7/Vk=	2018-02-24 14:34:10.182514+00	\N	37	37
31	f	steven.aguilar@example.com	f	t	pbkdf2_sha256$36000$jNOBeBZmFrU6$ocSRefwqRgsWml2QVts9HjfcoXN3/F3ZqZffWDQu9dM=	2018-02-24 14:34:10.3485+00	\N	38	38
32	f	krystal.neal@example.com	f	t	pbkdf2_sha256$36000$5jr0L89sMWn2$Uxpl+ij7+exsuruW2Qkv7HSgWMYcE/rz4ZYnu00owGo=	2018-02-24 14:34:10.433467+00	\N	39	39
33	f	lori.cowan@example.com	f	t	pbkdf2_sha256$36000$5LbuZnmCyY5y$beRJEzlRczYM4yBJdZAXwHRg64ht01sjcXWGlrXU6dI=	2018-02-24 14:34:10.534564+00	\N	40	40
34	f	peter.hogan@example.com	f	t	pbkdf2_sha256$36000$62GGeGGKQSoo$iSBdT805DX6VUjehBOQ6D4WkWGAJPCFv4WHqTzRZnTU=	2018-02-24 14:34:10.627633+00	\N	41	41
35	f	peter.keith@example.com	f	t	pbkdf2_sha256$36000$DZ44OmPCy1Ln$9ko3Qe8mgTWKgbtFjuhVEZk08vOlB10urqRhuS0ywWI=	2018-02-24 14:34:10.708239+00	\N	42	42
36	f	dustin.peterson@example.com	f	t	pbkdf2_sha256$36000$SSjDqv3SlfEb$HHzYN8f+8QZk9VpKHT0gsNbUsQ7X/GrFmfs7dCu5PCo=	2018-02-24 14:34:10.809287+00	\N	43	43
37	f	tamara.rivera@example.com	f	t	pbkdf2_sha256$36000$sKvuBlArVQSy$mNRZLKLQbvNtPf8hO5ekygDKYFNXvexqaIESLiVhXXQ=	2018-02-24 14:34:10.892973+00	\N	44	44
38	f	tara.pham@example.com	f	t	pbkdf2_sha256$36000$jepmukdhPY2R$q/Jw8N147fr6XxKa+k9yIwT3L/V6tdFIKpV8FmDmuKM=	2018-02-24 14:34:10.972698+00	\N	45	45
39	f	dylan.rivera@example.com	f	t	pbkdf2_sha256$36000$bEzsMxWj4F5u$9AsX0KFuloyCwlabhplRCCYn71csOZ/Ge8MRy5lhjAw=	2018-02-24 14:34:11.063346+00	\N	46	46
40	f	joshua.jones@example.com	f	t	pbkdf2_sha256$36000$2ZbB8y2RY3HO$XYF1JG7KCFLQnb7uwIL1FGzSR0XYwgWEQsuTgo78hiE=	2018-02-24 14:34:11.159385+00	\N	47	47
41	f	anthony.mccoy@example.com	f	t	pbkdf2_sha256$36000$Fk4h45IYccdH$mz6RJRiVeYLmpNHOo0ZNyqrmvEOlcaqEsit4uwLaSYQ=	2018-02-24 14:34:11.244324+00	\N	48	48
42	f	sarah.padilla@example.com	f	t	pbkdf2_sha256$36000$gzgCG3TBbADt$kLBEqmp3gyqZr7YW8O1SHRt5Cg4cEYKdUsAHNEAkOI0=	2018-02-24 14:34:11.322074+00	\N	49	49
43	f	zachary.allen@example.com	f	t	pbkdf2_sha256$36000$QEKTDEDjIYez$dPvedTQo/oNr6DZ1XMpE+cjyTkNGTOQW1QHJdXLKuSM=	2018-02-26 19:31:06.132233+00	\N	62	62
44	f	benjamin.vance@example.com	f	t	pbkdf2_sha256$36000$88B8Tc0UTm41$jRNpW1fVVgH1XuGDTuItnz5aA0GIJlIp0h30otvahrg=	2018-02-26 19:31:06.230287+00	\N	63	63
45	f	tammy.chambers@example.com	f	t	pbkdf2_sha256$36000$EHhZmYToblfo$15tGlDLNjK70PFyzMhStrpaqSOh5WNzQyHcVSTopunE=	2018-02-26 19:31:06.319572+00	\N	64	64
46	f	jacqueline.odonnell@example.com	f	t	pbkdf2_sha256$36000$51IG1v673YwL$VS0OPFq1nyN+G8XrjHbFL+qXONbPG+6obFnZOd0ZKeI=	2018-02-26 19:31:06.407934+00	\N	65	65
47	f	darrell.jennings@example.com	f	t	pbkdf2_sha256$36000$W0pU3nSYQaR6$58keGvNbrwCLJ7GGfUSNDVBmLURHDVa/YG9+mt/ugVk=	2018-02-26 19:31:06.521959+00	\N	66	66
63	f	deanna.howe@example.com	f	t	pbkdf2_sha256$36000$TxLC09l4ZeyH$aqhmOGoRXvJj5HYTq5aO3Pwrq48hLHhgNzuK3c66g3I=	2018-02-26 19:43:46.591999+00	\N	83	83
48	f	stacey.hudson@example.com	f	t	pbkdf2_sha256$36000$uDY3T2oVCkzN$OliPCfHAN8Di4UEEa31FbkxAP/MSaWVYMNd7t9Me5cw=	2018-02-26 19:31:06.614651+00	\N	67	67
49	f	elizabeth.davis@example.com	f	t	pbkdf2_sha256$36000$KGzarZ195Rrs$4pAkzuAogiujSTo5htifz/P1oP8X5cUdh1cdMdNBqkg=	2018-02-26 19:31:06.718236+00	\N	68	68
64	f	benjamin.arroyo@example.com	f	t	pbkdf2_sha256$36000$cWPxZVLjuVAw$YtdLJkbFkxIjA8COm8oMuE/i2NWrx17eCZj90xvYu+E=	2018-02-26 19:43:46.68306+00	\N	84	84
50	f	kristina.clark@example.com	f	t	pbkdf2_sha256$36000$VL3MRldM82so$WIwaZ6JJaYZ7L/ZCgQpriJR6Erwd5DTQbAwV3QaIA9E=	2018-02-26 19:31:06.816166+00	\N	69	69
51	f	robert.blevins@example.com	f	t	pbkdf2_sha256$36000$pv47SDURB2ja$pyJf9NAMYb7UAwWDD4AzYxzh4C5n7wL95CTk1N+4xlU=	2018-02-26 19:31:06.908032+00	\N	70	70
65	f	cameron.ward@example.com	f	t	pbkdf2_sha256$36000$6sqSXK7kQEjx$95tylWrFUlAPrZCJlSNfpL9oSNKd5xOcYT4XXIriw8M=	2018-02-26 19:43:46.774732+00	\N	85	85
52	f	shannon.hanson@example.com	f	t	pbkdf2_sha256$36000$at249FIAEng9$F36dBw0yvIMLRMd047kfSmsZ+WSK6aku6dwmgz/YuwM=	2018-02-26 19:31:06.997978+00	\N	71	71
53	f	tommy.barrera@example.com	f	t	pbkdf2_sha256$36000$VrJXQA8t2z9I$Xm08yUvr05TbrOS+J32GbOvHryDxYqhL6sXM/yr/lZg=	2018-02-26 19:31:07.080136+00	\N	72	72
66	f	daniel.scott@example.com	f	t	pbkdf2_sha256$36000$BO72Hf1eHfwf$pMQO/d8Fsq2Fl9ZElMi8Si+a5K7Y/EXFYgp0O4z735A=	2018-02-26 19:43:46.863833+00	\N	86	86
54	f	thomas.ramirez@example.com	f	t	pbkdf2_sha256$36000$GDN5Z1M1HxjH$FUfwJ2n2cYhCGf1P62nw0nfmTPDig4c1szr8Bq1OOD0=	2018-02-26 19:31:07.140461+00	\N	73	73
55	f	dustin.perez@example.com	f	t	pbkdf2_sha256$36000$WYDBpg7EvpsD$/bJtdhjG0MgctVgDfAD39sJnZXx3ShxZO2K3uMF5TdY=	2018-02-26 19:31:07.198915+00	\N	74	74
67	f	joshua.cruz@example.com	f	t	pbkdf2_sha256$36000$DWxyelPNGH1k$Af/ECpvzIYu/wt/G3NYh4s1wKQeS2hs6RkVCWHF1SjQ=	2018-02-26 19:43:46.953484+00	\N	87	87
56	f	crystal.lynch@example.com	f	t	pbkdf2_sha256$36000$KzY1t9VmEz3T$Kug0H4thbjqpV5AZsU3Y29FwPSE8ocvw/CzKv7boy1s=	2018-02-26 19:31:07.260074+00	\N	75	75
57	f	leslie.gardner@example.com	f	t	pbkdf2_sha256$36000$7Mz0B01IpsXi$AKyni8KcDnLzpSA4zGxEApZaTahb28elHoRYAXorH4w=	2018-02-26 19:31:07.325833+00	\N	76	76
68	f	pamela.robinson@example.com	f	t	pbkdf2_sha256$36000$BHGZWQx2NasS$hfL7mx8YwzDE0C3EUizQeooRjp5cIGGEENGGKeoLwr8=	2018-02-26 19:43:47.040661+00	\N	88	88
58	f	harold.beasley@example.com	f	t	pbkdf2_sha256$36000$lVtjIq1W9HiS$M+nqJUUyGR7yW01AJAjMRtmRQ92pej6Eslcy3GIdpJE=	2018-02-26 19:31:07.38285+00	\N	77	77
59	f	joyce.reyes@example.com	f	t	pbkdf2_sha256$36000$ZDhPcycJEKxf$yVsFfO/K1PGt3bzebRO58z5D+0n3d13BdiYtN1JOfH0=	2018-02-26 19:31:07.44153+00	\N	78	78
69	f	jose.baker@example.com	f	t	pbkdf2_sha256$36000$NtZ0wwo4tdZM$B0riNGoJJ8dxM1TPmgOXb4UEQkGqEUB8jf/q1WAIQ3g=	2018-02-26 19:43:47.127793+00	\N	89	89
60	f	leslie.lane@example.com	f	t	pbkdf2_sha256$36000$AEbzq78hngFc$abJWMmZKhGW7tRhV9/IRqVSaL3AMNJ5mPcaUfR7royI=	2018-02-26 19:31:07.527738+00	\N	79	79
61	f	sarah.hernandez@example.com	f	t	pbkdf2_sha256$36000$uGnv3n3JQKVC$vRzew6NNM+ksyvw0Px0tWYyfrclSL8LY8wQoW42JbPk=	2018-02-26 19:31:07.610531+00	\N	80	80
70	f	monica.gibson@example.com	f	t	pbkdf2_sha256$36000$2u6cEZoYyMep$NfuNkenJqH7CsSTDaEeCbzBDPaC+0/1jSbkOrPrMRnQ=	2018-02-26 19:43:47.216747+00	\N	90	90
62	f	gloria.bell@example.com	f	t	pbkdf2_sha256$36000$WUJWhT41ZNKt$ZoIumO63og2U+SgM7liEWdxm6F82wNMblELUeC+Gkvk=	2018-02-26 19:31:07.700391+00	\N	81	81
71	f	stanley.gentry@example.com	f	t	pbkdf2_sha256$36000$5APrZ0e9lnHY$RTRVruZXslBwFtxYJ/fcKvvW7i4Tyy08jiyVexOMCeE=	2018-02-26 19:43:47.306331+00	\N	91	91
72	f	james.franco@example.com	f	t	pbkdf2_sha256$36000$5JuFmegDZQBf$8AZMBy2pa61HJ3emrQ8VjTq8uc27By7T4Ok1Jiste1s=	2018-02-26 19:43:47.394217+00	\N	92	92
73	f	carol.boone@example.com	f	t	pbkdf2_sha256$36000$xIijpGAzyqVt$rqJCv/q06iank28vw0qKh/isZfgz4AXYznAfJVJflK0=	2018-02-26 19:43:47.480771+00	\N	93	93
74	f	joshua.tran@example.com	f	t	pbkdf2_sha256$36000$JNUNYqOLWVhI$tXDgIcGEzslcxgLXKUOPFa0LUNg8dtz2pE1y0XDvnQI=	2018-02-26 19:43:47.570018+00	\N	94	94
75	f	scott.glass@example.com	f	t	pbkdf2_sha256$36000$Jkql28cL8gaA$Rm1DBlYRzrhf/KsEJfwmCosmOv4jWnA14BrfI1GEtcs=	2018-02-26 19:43:47.657406+00	\N	95	95
76	f	yolanda.hooper@example.com	f	t	pbkdf2_sha256$36000$yQxvtULSzILT$G6qkmfmMGOZ8bFBF4LnhlfxwF8ubrvuzIWqnAaMJOMk=	2018-02-26 19:43:47.743415+00	\N	96	96
77	f	debra.perez@example.com	f	t	pbkdf2_sha256$36000$W1kbECChJOao$xp9whKNTVh5RX4185gmqqf3NqtopFEbTs87Vfim7JQI=	2018-02-26 19:43:47.83654+00	\N	97	97
78	f	robin.giles@example.com	f	t	pbkdf2_sha256$36000$bXE9b622uG0A$9NEwnTXSXf8fV/fQERxfSQXbhAf77KPFRVnTYDlVTFs=	2018-02-26 19:43:47.925709+00	\N	98	98
79	f	michael.joseph@example.com	f	t	pbkdf2_sha256$36000$97kabV02nAY4$OaNUHYxTTpSpdyQdqzLR3THVLTsjlghv393osUbcslI=	2018-02-26 19:43:48.016534+00	\N	99	99
80	f	dustin.shepard@example.com	f	t	pbkdf2_sha256$36000$16NyLT1wX3A7$nxmv4rLXzGHQnuNVSpYUdRZd/U5HDn80/PttG1pIeF4=	2018-02-26 19:43:48.105604+00	\N	100	100
81	f	ashley.baird@example.com	f	t	pbkdf2_sha256$36000$XUaSL3HEhpBH$ByawF45IZoy7j7YvbjFTqIszLW09tlX8ij9s0+eeQ6o=	2018-02-26 19:43:48.192189+00	\N	101	101
82	f	andrea.mitchell@example.com	f	t	pbkdf2_sha256$36000$67dmwADvgZrR$oQJPJ6VdALjnlPwY7tkYb5R1VW42FxpqiVyK0wT8gqQ=	2018-02-26 19:43:48.284145+00	\N	102	102
83	f	craig.cardenas@example.com	f	t	pbkdf2_sha256$36000$wK9r2aEVFJlW$6yWO/rMsIs2ot/ZNZemIS0NDkZFMnN45KTzlCyo96uo=	2018-03-02 17:24:08.015302+00	\N	104	104
84	f	tiffany.thomas@example.com	f	t	pbkdf2_sha256$36000$DHmuHgYz1xjU$10IfefvBpBiZaWiRROFsfeWJx40d2moABiLBWwkdNpI=	2018-03-02 17:24:08.083861+00	\N	105	105
85	f	julie.cole@example.com	f	t	pbkdf2_sha256$36000$S7Yi3sAQ77sV$INAEejw8njGbPxBrujxZvgu+day2pJqHNSwz4X8rImY=	2018-03-02 17:24:08.144369+00	\N	106	106
86	f	cody.robinson@example.com	f	t	pbkdf2_sha256$36000$d0hjpX9vhhS2$iJK0L/wZoNGS6UT9zuAaGWpeJQZaqrmo1BiTUyzwNn4=	2018-03-02 17:24:08.205033+00	\N	107	107
87	f	richard.mccoy@example.com	f	t	pbkdf2_sha256$36000$1FOFK2PfdWiy$a3GjI+JXji66scu6vNDwSxlkSY1TGQSSMLsdV/rVZJo=	2018-03-02 17:24:08.279763+00	\N	108	108
88	f	matthew.conley@example.com	f	t	pbkdf2_sha256$36000$800ktjVo8JNf$lRnz26PLxmYOPIQiZwPmAF0BntFt9HuyJrutZHPlwh8=	2018-03-02 17:24:08.341827+00	\N	109	109
89	f	glenn.clark@example.com	f	t	pbkdf2_sha256$36000$7HJgLtjeBGhX$fVAI+Ywd4hjBji9pmjCiPxyRFUWWB2xtm1Ph3R1cHfU=	2018-03-02 17:24:08.402927+00	\N	110	110
90	f	joann.baker@example.com	f	t	pbkdf2_sha256$36000$FnDVnTGfj4c0$DFVWjAMTn6DZ/AolJ8ytt7RyimioLQtXgnDjQWYVCJE=	2018-03-02 17:24:08.46263+00	\N	111	111
91	f	theodore.flowers@example.com	f	t	pbkdf2_sha256$36000$idDi7L71zu9A$cMSUxHt2L3R/DKYtSNHvIBbb9/wyi8p/aewLdsntR6M=	2018-03-02 17:24:08.524895+00	\N	112	112
92	f	maurice.hubbard@example.com	f	t	pbkdf2_sha256$36000$TpcolqcTEaZa$z+4VjvHJYNjaTEW73E95i/bmLVkcv3LVSUAinq+kTkY=	2018-03-02 17:24:08.58321+00	\N	113	113
93	f	maria.morton@example.com	f	t	pbkdf2_sha256$36000$e1fRpkNj7OJK$fBm5ParJU7CDY9zA3H2v8+3RB5DNcUKmSKwyIUtMxNY=	2018-03-02 17:24:08.642117+00	\N	114	114
94	f	michelle.knight@example.com	f	t	pbkdf2_sha256$36000$EWNl1lJlQhcy$PLMa9X/mNUZ/Oh1vmR6xFkPGqJV5R2CuZcOohY0SH6w=	2018-03-02 17:24:08.69868+00	\N	115	115
95	f	daniel.swanson@example.com	f	t	pbkdf2_sha256$36000$n6kTqdfopStQ$5fDj9EtG/hhtU7eKzQ2n0fmUOdkD1Dz/dm0BTalm3Js=	2018-03-02 17:24:08.757442+00	\N	116	116
96	f	mason.patel@example.com	f	t	pbkdf2_sha256$36000$bsIZC5D3Q3U0$6x78uEC8UKqGQRSMky5cVidw0HPnSM4kr3YsWD7EYkY=	2018-03-02 17:24:08.826707+00	\N	117	117
97	f	molly.bennett@example.com	f	t	pbkdf2_sha256$36000$Ncn6KtpCPG6I$2xvu9jgk4e2N17UDsmPg54lAyXclqbHKXpFejCDICEo=	2018-03-02 17:24:08.88315+00	\N	118	118
98	f	richard.martin@example.com	f	t	pbkdf2_sha256$36000$q8yB0ukvZ9xG$XG9WdjHwvJcs5mHinGmni7pSaVDKbcBZxjKJV5xTTzw=	2018-03-02 17:24:08.950884+00	\N	119	119
99	f	jason.simon@example.com	f	t	pbkdf2_sha256$36000$x9lJn7prqx7S$bF+LXejcUGdQudV8naKcY/VgoG4XdKqsqejG/aTrF8M=	2018-03-02 17:24:09.016837+00	\N	120	120
100	f	dustin.johnston@example.com	f	t	pbkdf2_sha256$36000$p14whXv1XoSk$9lZBabCSRGDCr/k5ZvA4ujLtw/FK5v6F/5emywMNQYE=	2018-03-02 17:24:09.081984+00	\N	121	121
101	f	shannon.browning@example.com	f	t	pbkdf2_sha256$36000$0tK25W4zi9zk$hzVneDpaWaeLC9DIsUJCXR+wExe3LK21sBWJ0zv7bOA=	2018-03-02 17:24:09.146101+00	\N	122	122
102	f	james.villarreal@example.com	f	t	pbkdf2_sha256$36000$tabc6ut5mFfY$zesZ6Uku/c9It7g8RbTSaZUjzzqWeFYUH88G+hIwmCU=	2018-03-02 17:24:09.208201+00	\N	123	123
103	f	kendra.bruce@example.com	f	t	pbkdf2_sha256$36000$YNGVztuo5me5$Ga+wGwMnUNsq0ZrCj9p282Ldq9iygDFwLwHIIgW2PN0=	2018-03-03 17:20:30.067736+00	\N	125	125
104	f	phillip.clark@example.com	f	t	pbkdf2_sha256$36000$y9zzllANIaJo$+NFb4zXBsQCVTjiggAuEdsMWjQqwYloUS89ot7NGOHY=	2018-03-03 17:20:30.168313+00	\N	126	126
105	f	susan.cooper@example.com	f	t	pbkdf2_sha256$36000$tr4tDbu42tgE$xRe1oko/Z79d142rX3Yp3BeR+yi2q4CeTHDrpN7trxU=	2018-03-03 17:20:30.253139+00	\N	127	127
106	f	mary.powell@example.com	f	t	pbkdf2_sha256$36000$JMUKjK0dZWzc$8VJI+uOqlRnLCUGXqPaZ0saV8t44JROBcC/h/1HfPAE=	2018-03-03 17:20:30.343145+00	\N	128	128
107	f	christopher.johnson@example.com	f	t	pbkdf2_sha256$36000$IedjKkARmLXR$mD3mfCVsbaMgZLkazJWC2h8dYEratqXIHToNWPAxAoU=	2018-03-03 17:20:30.430591+00	\N	129	129
108	f	anthony.peterson@example.com	f	t	pbkdf2_sha256$36000$oHQa7d00JOLx$/Mv64Lru0e5Sft8ht+TjWTjF8TD1UY8dwhBbI45q5a4=	2018-03-03 17:20:30.515634+00	\N	130	130
109	f	sonya.morris@example.com	f	t	pbkdf2_sha256$36000$bLpwZIMne44C$O2I/p4F0hLKr90ZuI4uusiuPHuxEtKHW8xWKBlF7Xz0=	2018-03-03 17:20:30.594713+00	\N	131	131
110	f	gary.perry@example.com	f	t	pbkdf2_sha256$36000$c2qaV8mt5uZB$Og/z/y7eKy1h9Xtj/V++1SwfgfkFlkkXSfUt+h75LWg=	2018-03-03 17:20:30.684551+00	\N	132	132
111	f	luke.sutton@example.com	f	t	pbkdf2_sha256$36000$39yFPf6sK1zE$rGFRaNetvgCRxn7ZtRegP3zwxarXrh1KXYWImJjZZbY=	2018-03-03 17:20:30.775363+00	\N	133	133
112	f	manuel.dunn@example.com	f	t	pbkdf2_sha256$36000$HtBoYKz4XA3x$jdRhvY5ya7k3FG0lew83h5jb3IeahUFEte5LakKlIxk=	2018-03-03 17:20:30.861175+00	\N	134	134
113	f	christopher.rivera@example.com	f	t	pbkdf2_sha256$36000$uR9jmiwohudi$DuRwwQIZl6jy9G2XnFF1wHBIkJIy7B9gUSkteyp0KNk=	2018-03-03 17:20:30.965743+00	\N	135	135
114	f	karla.brown@example.com	f	t	pbkdf2_sha256$36000$hUHt4Kb5gQIO$L3WJXsKkMMNnVVrLzTN+fWg/8m65rJzewSWdHTcsuQY=	2018-03-03 17:20:31.052949+00	\N	136	136
115	f	michael.duncan@example.com	f	t	pbkdf2_sha256$36000$9QrLxNKY28tZ$iWjmfLpXx35t59zScwl0888WMpP+2sDLZDDhLrA+bl8=	2018-03-03 17:20:31.141515+00	\N	137	137
116	f	kelli.hughes@example.com	f	t	pbkdf2_sha256$36000$mbjwbkgywCkB$m4GBa5DDpnJTGcRJ6f7lRb1lHpKb71FFc3I+v6Q7z/Y=	2018-03-03 17:20:31.246778+00	\N	138	138
117	f	yolanda.moore@example.com	f	t	pbkdf2_sha256$36000$dbQrpqaYezlO$+aDpo5/9ydawglCbQQDW5ivvzxkpCylGSL6O+yWkh8A=	2018-03-03 17:20:31.346135+00	\N	139	139
118	f	carla.wade@example.com	f	t	pbkdf2_sha256$36000$qvqU6zAaMQcg$6FmTynIXrCVjpIiTOx5Q1aETT2G9WRly84wYCUVeJXI=	2018-03-03 17:20:31.431126+00	\N	140	140
119	f	alex.miller@example.com	f	t	pbkdf2_sha256$36000$sIZTvr0JNXJ9$ZZye9e9PaMlH4+EFZ85yVc5RnKi55aj2MaNThcHYDpU=	2018-03-03 17:20:31.518205+00	\N	141	141
120	f	eric.hunter@example.com	f	t	pbkdf2_sha256$36000$TdA4X5SwkMLv$PAs5rx7mXq88ffueviyF8/ooMMNKoUZGRCkwLA/X9UI=	2018-03-03 17:20:31.5958+00	\N	142	142
121	f	linda.small@example.com	f	t	pbkdf2_sha256$36000$x4CMbAzjTEnD$jtKzegIXJWUAaGePJbZ/LX/r3r5WOEOhd0/5DluGMhM=	2018-03-03 17:20:31.687728+00	\N	143	143
122	f	frederick.fisher@example.com	f	t	pbkdf2_sha256$36000$jb4jW1sfvtf9$03Di/7qlInLi4l6cpWk6o6cvAs4gmlfMTkCQTUG5NVs=	2018-03-03 17:20:31.786561+00	\N	144	144
123	f	diana.mack@example.com	f	t	pbkdf2_sha256$36000$ZZP5wDjKgMZT$lbj/LTr8GfHz4l3Bel2wgyB2h8TkoS+6jzd7B+h5kTg=	2018-03-13 03:22:31.76719+00	\N	145	145
124	f	robert.gutierrez@example.com	f	t	pbkdf2_sha256$36000$irqWOgKeQoWs$P4lLed6Iv0h2QW2oShzwkVzn4KnSSXiSuRsZi2MAiC0=	2018-03-13 03:22:31.846118+00	\N	146	146
125	f	jonathan.riley@example.com	f	t	pbkdf2_sha256$36000$HnbvciUhhO28$1LVCXNlSo4x8lDMgKHA6f+iiq+Gyh9CZ/7e0EDwnIqw=	2018-03-13 03:22:31.905549+00	\N	147	147
126	f	christopher.valenzuela@example.com	f	t	pbkdf2_sha256$36000$zbExFNh6vxmz$KK5JiUd6sESpNZKxBJezhqjaTIsmtTyW2gc6vMFSCKw=	2018-03-13 03:22:31.96621+00	\N	148	148
127	f	mitchell.guerrero@example.com	f	t	pbkdf2_sha256$36000$kCEtU8QBAd9T$AVloKTyL+LnStAitwQLlzLa0YQSsa5/YTCaQmullBdw=	2018-03-13 03:22:32.029541+00	\N	149	149
128	f	kevin.hayes@example.com	f	t	pbkdf2_sha256$36000$z7hv0uqeIz68$JwnPRi7Zg0KV/Lzfh60rnjnPDJl9ZWKqGVwtuZ4dF58=	2018-03-13 03:22:32.093771+00	\N	150	150
129	f	amanda.stout@example.com	f	t	pbkdf2_sha256$36000$YKgQbuEaplkK$ddKD4b0/62ErwUbuPAYE8+bkqJRTayptE0rJBz0IseI=	2018-03-13 03:22:32.178935+00	\N	151	151
130	f	cynthia.edwards@example.com	f	t	pbkdf2_sha256$36000$e9r630UbNt03$uaeLHRFf0sLtZ3Nl1QIoMU4DE/MKehxDEkF6dzVG0T8=	2018-03-13 03:22:32.261721+00	\N	152	152
131	f	kyle.maynard@example.com	f	t	pbkdf2_sha256$36000$wMyRVayZ5dp6$Ntr6PgCbQR7VipdWoAUSYCTAQLPNhfTPEVferw//lZQ=	2018-03-13 03:22:32.32638+00	\N	153	153
132	f	diane.carlson@example.com	f	t	pbkdf2_sha256$36000$uGyxtR5Mblpa$wyCD55eauo3rZGNfHp2AKZbcOMBURJOuGXe4fg5F2Y4=	2018-03-13 03:22:32.382846+00	\N	154	154
133	f	judith.macdonald@example.com	f	t	pbkdf2_sha256$36000$0rqg0j5pQRwu$IbEn+oMFLBCcXvlwy/Fhj4herREngeBzxnp79I6F0qY=	2018-03-13 03:22:32.44562+00	\N	155	155
134	f	emily.gill@example.com	f	t	pbkdf2_sha256$36000$tiCna8widd4V$GmD+MPvw4AJDjNKXL9SCkTzuSRHO/sKJbD0blBxo6Aw=	2018-03-13 03:22:32.504511+00	\N	156	156
135	f	jennifer.rhodes@example.com	f	t	pbkdf2_sha256$36000$tpUELqQpiOlX$Yo1BivuQKCkQUrOsDC5PUzX0642Foln4P5yOXd9V0xo=	2018-03-13 03:22:32.562859+00	\N	157	157
136	f	jamie.boyer@example.com	f	t	pbkdf2_sha256$36000$qpni040nfmXE$Acw0XKBY58qKAQML1PteIaVnM23yqQXtBTH0HeSK660=	2018-03-13 03:22:32.632763+00	\N	158	158
137	f	nichole.wiley@example.com	f	t	pbkdf2_sha256$36000$AJTutnu76NWf$2NcQEgKZtIHA5jBmLVVfZ602XmKToUGc67vXt0Oy6UA=	2018-03-13 03:22:32.687945+00	\N	159	159
138	f	kevin.perez@example.com	f	t	pbkdf2_sha256$36000$lnuD4mZsuXQp$FdvYgDQs7/sXt1dI+ZSZY+l+vQ4kYOD898+46X129UM=	2018-03-13 03:22:32.745075+00	\N	160	160
139	f	john.freeman@example.com	f	t	pbkdf2_sha256$36000$IiroU3kXLw9n$SIR9lOXGmztr+esXG3KAEBuXz+RbktP+zc0E9rPeUoo=	2018-03-13 03:22:32.80274+00	\N	161	161
140	f	mary.barnes@example.com	f	t	pbkdf2_sha256$36000$4eTG4j9QsfCS$TF1cFjD5i8spm0P5HMNuTC6QeFogIv4SntgdlDuvEuc=	2018-03-13 03:22:32.862105+00	\N	162	162
141	f	david.green@example.com	f	t	pbkdf2_sha256$36000$l8wabf1piXCg$fQHse56kBfrtHaUXSllXodsWDoUt5hwzkM1m7GfHiBY=	2018-03-13 03:22:32.920676+00	\N	163	163
143	t	admin@example.com	t	t	pbkdf2_sha256$36000$Xp9Q2WPlwIrG$J3YkcYiqk71DdvdLWXJOOx6HxA/BOijiENOTZdKyB/k=	2018-03-13 05:09:28.932203+00	2018-03-14 04:00:36.985824+00	\N	\N
142	f	cory.walker@example.com	f	t	pbkdf2_sha256$36000$vacJNsmL60Gk$ISlW/z0a9mYLoIQOcD+jQKz/Q+Q7sKZBh7PYREYJgdA=	2018-03-13 03:22:32.981337+00	\N	164	164
144	f	jerome.winters@example.com	f	t	pbkdf2_sha256$36000$2JYbwT0oLRsP$aOeCk52J03d7NxFFsFXmU969T8vDnPDuT+gSqj+WrZQ=	2018-03-13 05:21:44.014397+00	\N	177	177
145	f	ashley.schneider@example.com	f	t	pbkdf2_sha256$36000$BjpMRKMhd0Aq$NcDU/Q/nxDiU/rQfppx+vWaNQXrEhF4yCIO7lsOsSsc=	2018-03-13 05:21:44.084174+00	\N	178	178
146	f	debra.burke@example.com	f	t	pbkdf2_sha256$36000$PjeshZPW1ZIy$v8ZdbVZpNMgW45Ut/Y2av7jSHoJqLAiWZBqE8ueqI6g=	2018-03-13 05:21:44.162347+00	\N	179	179
147	f	antonio.campbell@example.com	f	t	pbkdf2_sha256$36000$S0NwXZTFYTS5$LBno7nKOGUJzFRE6yOmEhs1FZxxCeB8lidYBQIk+ULQ=	2018-03-13 05:21:44.226553+00	\N	180	180
148	f	scott.martin@example.com	f	t	pbkdf2_sha256$36000$fKzPTGXOTwI6$jZUYw+EaI12HHdJcL5naSBoVr9fiLr8q0JtEaj/l51Q=	2018-03-13 05:21:44.295816+00	\N	181	181
149	f	scott.larsen@example.com	f	t	pbkdf2_sha256$36000$3VpKV2VFKqrF$6lYj6sWMcYpz0NOWcB6qh+l4WJT8CDzKKLoUkiY4i44=	2018-03-13 05:21:44.367518+00	\N	182	182
150	f	timothy.young@example.com	f	t	pbkdf2_sha256$36000$owIyniBNdRDe$JDMs2I/GRNjul+fcpAF82Py9S2NYqj2YtrHw7D/WCNM=	2018-03-13 05:21:44.442642+00	\N	183	183
151	f	natasha.novak@example.com	f	t	pbkdf2_sha256$36000$TCF4HJraa8w3$g5W5CMEipT7gR3Z/PuQTLkKAikRMsGAtYH+qrIrRvoQ=	2018-03-13 05:21:44.513452+00	\N	184	184
152	f	alejandra.blackburn@example.com	f	t	pbkdf2_sha256$36000$cflWU19CoA7J$wj7s8fc75O8Mp+JGqGP9c+j8Jtr3Lsbb/4vsWhkZjg8=	2018-03-13 05:21:44.580702+00	\N	185	185
153	f	claire.cross@example.com	f	t	pbkdf2_sha256$36000$ZshAKjCEqxDN$98DceXQLVlJ5Bj0tV4+AY0E/tkAzJ+1T8Lw2fjAaRxQ=	2018-03-13 05:21:44.657634+00	\N	186	186
154	f	donna.williams@example.com	f	t	pbkdf2_sha256$36000$PdMubPtu4k6K$wkknSZhoitZUosr0NgDkF+K3hFmG1YbXCTi2kdGE5r8=	2018-03-13 05:21:44.733204+00	\N	187	187
155	f	karen.lambert@example.com	f	t	pbkdf2_sha256$36000$YWKufVGEKs4h$TRR+RNu/HcIEC8wRqoTwIzln8UcX5rnyO8+qQyXT0nU=	2018-03-13 05:21:44.803954+00	\N	188	188
156	f	philip.garcia@example.com	f	t	pbkdf2_sha256$36000$rbzMJBKJqof3$bfTzj5yA/AlQ1QvB0lke3yOZeAe5hT6CLSmM1E0gtvo=	2018-03-13 05:21:44.873459+00	\N	189	189
157	f	kristin.wong@example.com	f	t	pbkdf2_sha256$36000$rTxhcA8gei95$8LR6AhUqbLsz8cOBzWJ0eIS0YTeHZvoeQzO7s1JwLik=	2018-03-13 05:21:44.958847+00	\N	190	190
158	f	christine.bennett@example.com	f	t	pbkdf2_sha256$36000$i1dtisD8KZn6$FdwfDFarp5idhB+u9QkbA1MwguZjt5L8y13JWg+WM3E=	2018-03-13 05:21:45.039294+00	\N	191	191
159	f	christopher.hernandez@example.com	f	t	pbkdf2_sha256$36000$uhfaMEvfSaCb$jRx2gn/gNFaANylyqy7nGfyVmxJaL6NH571u7T8mj3o=	2018-03-13 05:21:45.109959+00	\N	192	192
160	f	kyle.miller@example.com	f	t	pbkdf2_sha256$36000$nGHPOwQPD8X5$5+PFf3b4a3osVtpApBZ+JGsAry3WCdEaunjP1anTuII=	2018-03-13 05:21:45.175937+00	\N	193	193
161	f	glen.erickson@example.com	f	t	pbkdf2_sha256$36000$Raaqj2DNO044$Ex9HLBGewaFUy2WKdFlZv9x2wLe9pVbFBlqo7d7wVM0=	2018-03-13 05:21:45.242493+00	\N	194	194
162	f	michael.ali@example.com	f	t	pbkdf2_sha256$36000$SGSigkVuQn1i$P3jwwUVaUfqtYk1hgQddjmacnjTJ+FMDA2i9VtRvipo=	2018-03-13 05:21:45.313066+00	\N	195	195
163	f	zachary.butler@example.com	f	t	pbkdf2_sha256$36000$N5NufitjCamD$4T5QxwNBfohoGP9K6rOjvwFk3NxSCYfC+5B9ZCQiAtA=	2018-03-13 05:21:45.377421+00	\N	196	196
164	f	courtney.lee@example.com	f	t	pbkdf2_sha256$36000$aekHGcg2DMi9$8bvctQMUgd93Z3TVt1c5NJdA9ZaUc/x45xITZIvSOi4=	2018-03-13 05:22:18.926686+00	\N	198	198
165	f	gregory.austin@example.com	f	t	pbkdf2_sha256$36000$FWHnAclQExz4$p8pXxHy35icF/AANsj8b/wjvYmWgYtnVYAL9G2KNlhU=	2018-03-13 05:22:18.996542+00	\N	199	199
166	f	anna.robinson@example.com	f	t	pbkdf2_sha256$36000$ul1wZTPtzfqv$zkqXnUeYctrQqRy8hXByUFNjOfPsgY5SU/7Jj0Conz0=	2018-03-13 05:22:19.062129+00	\N	200	200
167	f	katrina.russell@example.com	f	t	pbkdf2_sha256$36000$AFsjpLr1ycEq$+ukQaVPUTu5TPT2IEJPqL3dEZKntZ9wSFlyPQhQxzEc=	2018-03-13 05:22:19.126526+00	\N	201	201
168	f	carlos.anderson@example.com	f	t	pbkdf2_sha256$36000$eroZE0zzd6Pw$4tU6v5G33AvGCPTh1FXryurVz+cMmF3AFhXHHX5LQxs=	2018-03-13 05:22:19.196167+00	\N	202	202
169	f	gerald.greene@example.com	f	t	pbkdf2_sha256$36000$0NQ6irZKPqEn$5GP1LYu1550GaHTbiAA3ATmHhJrLLS2Fsa1EhvthZ5k=	2018-03-13 05:22:19.263407+00	\N	203	203
170	f	brian.anderson@example.com	f	t	pbkdf2_sha256$36000$hX3um7PQyWjB$BrX6N557K+00rz+UbvL7H1Ty6tHxxYUkQBV10NHZ6WE=	2018-03-13 05:22:19.327796+00	\N	204	204
171	f	bradley.patel@example.com	f	t	pbkdf2_sha256$36000$rz7MYjCDGW89$ZyfO2mp+Di49GRJBI0qQlpR/GsPWOnZ4IB/fTGNmRV4=	2018-03-13 05:22:19.393053+00	\N	205	205
172	f	jeanette.perez@example.com	f	t	pbkdf2_sha256$36000$HnUMIWNYWAy0$l1Uddrn3I7xwAsEPm2W+/fToh+pQAckRlB0zvOpDeaQ=	2018-03-13 05:22:19.465184+00	\N	206	206
173	f	christine.beck@example.com	f	t	pbkdf2_sha256$36000$dUtODOBWR5Ki$44BqZIYQinE3vWqKLy3Zgnjm2EfAMzrmbUpMIyiHA5c=	2018-03-13 05:22:19.532226+00	\N	207	207
174	f	heidi.thompson@example.com	f	t	pbkdf2_sha256$36000$tLr9eqNdFweD$6XmCPBZVngxqPe8k6kfkdVD5ewFt/C9ximbjx63RdAo=	2018-03-13 05:22:19.60863+00	\N	208	208
175	f	elizabeth.livingston@example.com	f	t	pbkdf2_sha256$36000$P43ehdkHgucZ$9BwTW0ueCAcxbtULKqQil+nmeoT8dw2G+lk49jl2hWM=	2018-03-13 05:22:19.683898+00	\N	209	209
176	f	matthew.brown@example.com	f	t	pbkdf2_sha256$36000$YdJ7FEtmFIze$YSl8QbSYQEIWgv9J6EBvU805Fy7HPIY4PSjbjStWRk0=	2018-03-13 05:22:19.756599+00	\N	210	210
177	f	christine.jones@example.com	f	t	pbkdf2_sha256$36000$trbTLikvMoWX$iOz2GjNbbQSHIXjP7mSomVCajfWF0WgzcL6i2ETqOps=	2018-03-13 05:22:19.832595+00	\N	211	211
178	f	caleb.howell@example.com	f	t	pbkdf2_sha256$36000$9LMSVCTSxHtW$7bCBWs2mRYLmuplF7PnQCs+aK9vHfowyODWUWTN4+vw=	2018-03-13 05:22:19.904577+00	\N	212	212
179	f	evan.nguyen@example.com	f	t	pbkdf2_sha256$36000$Ekps8ghwQmIb$VDWIUd+DUPNK9AuqRFFoY0VcyZDaWjuCzbhWc67zyPY=	2018-03-13 05:22:19.968643+00	\N	213	213
180	f	ryan.dennis@example.com	f	t	pbkdf2_sha256$36000$xRQLvkoQAbLi$sttSDqfHwAEfOp+DfhCrQ/K2ufl3TJq6pKrdyuhe7Gk=	2018-03-13 05:22:20.036598+00	\N	214	214
181	f	jimmy.rodriguez@example.com	f	t	pbkdf2_sha256$36000$7bBmkVKikulp$oIB0kchpG3Q5+n+Xscf3Vf997VaIN/Q2ZEg06bPMxJ4=	2018-03-13 05:22:20.110087+00	\N	215	215
182	f	jeremiah.cain@example.com	f	t	pbkdf2_sha256$36000$kTzPsLK3mix2$9qhA49h+9euoma9iB0ihIHDCAcGTdCbk9l9HPorW72E=	2018-03-13 05:22:20.175097+00	\N	216	216
183	f	kenneth.compton@example.com	f	t	pbkdf2_sha256$36000$uM2B83U8STMI$sshY9iHFV4nZucQmGQYbiVMDXWiknn4hTiOK+/xoqNU=	2018-03-13 05:22:20.239484+00	\N	217	217
\.


--
-- Data for Name: account_user_addresses; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY account_user_addresses (id, user_id, address_id) FROM stdin;
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
21	23	30
22	24	31
23	25	32
24	26	33
25	27	34
26	28	35
27	29	36
28	30	37
29	31	38
30	32	39
31	33	40
32	34	41
33	35	42
34	36	43
35	37	44
36	38	45
37	39	46
38	40	47
39	41	48
40	42	49
41	43	62
42	44	63
43	45	64
44	46	65
45	47	66
46	48	67
47	49	68
48	50	69
49	51	70
50	52	71
51	53	72
52	54	73
53	55	74
54	56	75
55	57	76
56	58	77
57	59	78
58	60	79
59	61	80
60	62	81
61	63	83
62	64	84
63	65	85
64	66	86
65	67	87
66	68	88
67	69	89
68	70	90
69	71	91
70	72	92
71	73	93
72	74	94
73	75	95
74	76	96
75	77	97
76	78	98
77	79	99
78	80	100
79	81	101
80	82	102
81	83	104
82	84	105
83	85	106
84	86	107
85	87	108
86	88	109
87	89	110
88	90	111
89	91	112
90	92	113
91	93	114
92	94	115
93	95	116
94	96	117
95	97	118
96	98	119
97	99	120
98	100	121
99	101	122
100	102	123
101	103	125
102	104	126
103	105	127
104	106	128
105	107	129
106	108	130
107	109	131
108	110	132
109	111	133
110	112	134
111	113	135
112	114	136
113	115	137
114	116	138
115	117	139
116	118	140
117	119	141
118	120	142
119	121	143
120	122	144
121	123	145
122	124	146
123	125	147
124	126	148
125	127	149
126	128	150
127	129	151
128	130	152
129	131	153
130	132	154
131	133	155
132	134	156
133	135	157
134	136	158
135	137	159
136	138	160
137	139	161
138	140	162
139	141	163
140	142	164
145	144	177
146	145	178
147	146	179
148	147	180
149	148	181
150	149	182
151	150	183
152	151	184
153	152	185
154	153	186
155	154	187
156	155	188
157	156	189
158	157	190
159	158	191
160	159	192
161	160	193
162	161	194
163	162	195
164	163	196
165	164	198
166	165	199
167	166	200
168	167	201
169	168	202
170	169	203
171	170	204
172	171	205
173	172	206
174	173	207
175	174	208
176	175	209
177	176	210
178	177	211
179	178	212
180	179	213
181	180	214
182	181	215
183	182	216
184	183	217
\.


--
-- Data for Name: account_user_groups; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY account_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: account_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY account_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


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
1	1	53
2	1	52
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
143	Can add Ordered item	40	add_ordereditem
144	Can change Ordered item	40	change_ordereditem
145	Can delete Ordered item	40	delete_ordereditem
146	Can add user	41	add_user
147	Can change user	41	change_user
148	Can delete user	41	delete_user
149	Can view users	41	view_user
150	Can edit users	41	edit_user
151	Can view groups	41	view_group
152	Can edit groups	41	edit_group
153	Can view staff	41	view_staff
154	Can edit staff	41	edit_staff
155	Can impersonate users	41	impersonate_user
156	Can add address	42	add_address
157	Can change address	42	change_address
158	Can delete address	42	delete_address
159	Can add product type	43	add_producttype
160	Can change product type	43	change_producttype
161	Can delete product type	43	delete_producttype
162	Can add collection	44	add_collection
163	Can change collection	44	change_collection
164	Can delete collection	44	delete_collection
165	Can add fulfillment	45	add_fulfillment
166	Can change fulfillment	45	change_fulfillment
167	Can delete fulfillment	45	delete_fulfillment
168	Can add fulfillment line	46	add_fulfillmentline
169	Can change fulfillment line	46	change_fulfillmentline
170	Can delete fulfillment line	46	delete_fulfillmentline
171	Can add page	47	add_page
172	Can change page	47	change_page
173	Can delete page	47	delete_page
174	Can view pages	47	view_page
175	Can edit pages	47	edit_page
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cart (status, created, last_status_change, email, token, checkout_data, total, quantity, user_id, voucher_id) FROM stdin;
open	2018-02-22 10:06:32.513702+00	2018-02-22 10:06:32.513728+00	\N	0f49416d-b61b-4da4-b406-074200ef036c	\N	0.00	1	\N	\N
open	2018-02-26 17:11:38.069402+00	2018-02-26 17:11:38.069483+00	\N	83a2f7cf-a0ce-4378-9569-b9e73b7e5ea0	\N	0.00	1	\N	\N
open	2018-02-26 20:23:01.343077+00	2018-02-26 20:23:01.343132+00	\N	1c2e461e-56ae-492d-990c-cec3f8471a8b	\N	0.00	1	\N	\N
open	2018-02-28 18:52:34.916613+00	2018-02-28 18:52:34.91665+00	\N	fb217c3a-2761-4887-9648-a6cbd1ca63df	\N	0.00	2	\N	\N
open	2018-03-04 00:10:51.410652+00	2018-03-04 00:10:51.4108+00	\N	2b86e4c2-b800-464e-913b-89a5b7491919	\N	0.00	1	\N	\N
canceled	2018-03-13 03:26:39.66055+00	2018-03-13 04:48:21.796434+00	\N	bb8d0321-20cc-4a2c-8ee0-1b301c0243c9	\N	0.00	1	21	\N
open	2018-03-13 04:48:10.138564+00	2018-03-13 04:48:10.138591+00	\N	fbeb0225-b9a3-4ffc-85cf-71b38c0fe5ed	\N	0.00	1	21	\N
open	2018-03-14 04:00:29.717511+00	2018-03-14 04:00:29.717547+00	\N	7786c52f-0c1f-417e-a55c-7835c5006b50	\N	0.00	1	143	\N
\.


--
-- Data for Name: cart_cartline; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY cart_cartline (id, quantity, data, cart_id, variant_id) FROM stdin;
1	1	{}	0f49416d-b61b-4da4-b406-074200ef036c	25
2	1	{}	83a2f7cf-a0ce-4378-9569-b9e73b7e5ea0	42
3	1	{}	1c2e461e-56ae-492d-990c-cec3f8471a8b	59
4	2	{}	fb217c3a-2761-4887-9648-a6cbd1ca63df	4
5	1	{}	2b86e4c2-b800-464e-913b-89a5b7491919	59
6	1	{}	bb8d0321-20cc-4a2c-8ee0-1b301c0243c9	42
7	1	{}	fbeb0225-b9a3-4ffc-85cf-71b38c0fe5ed	4
8	1	{}	7786c52f-0c1f-417e-a55c-7835c5006b50	4
\.


--
-- Data for Name: discount_sale; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_sale (id, name, type, value) FROM stdin;
1	Happy sapiente day!	percentage	30.00
2	Happy sapiente day!	percentage	20.00
3	Happy illum day!	percentage	40.00
4	Happy minus day!	percentage	30.00
5	Happy nihil day!	percentage	40.00
6	Happy reprehenderit day!	percentage	30.00
7	Happy ullam day!	percentage	10.00
8	Happy odio day!	percentage	20.00
9	Happy autem day!	percentage	20.00
10	Happy adipisci day!	percentage	40.00
11	Happy voluptates day!	percentage	30.00
12	Happy culpa day!	percentage	30.00
13	Happy dicta day!	percentage	10.00
14	Happy vel day!	percentage	40.00
15	Happy occaecati day!	percentage	50.00
16	Happy nulla day!	percentage	50.00
17	Happy id day!	percentage	20.00
18	Happy praesentium day!	percentage	10.00
19	Happy numquam day!	percentage	10.00
20	Happy iste day!	percentage	10.00
21	Happy consequatur day!	percentage	20.00
22	Happy consectetur day!	percentage	30.00
23	Happy quos day!	percentage	20.00
24	Happy modi day!	percentage	20.00
25	Happy laboriosam day!	percentage	10.00
26	Happy a day!	percentage	20.00
27	Happy architecto day!	percentage	10.00
28	Happy dolor day!	percentage	20.00
29	Happy quasi day!	percentage	30.00
30	Happy laudantium day!	percentage	40.00
31	Happy ducimus day!	percentage	20.00
32	Happy ipsa day!	percentage	20.00
33	Happy fugit day!	percentage	10.00
34	Happy amet day!	percentage	20.00
35	Happy ducimus day!	percentage	50.00
36	Happy beatae day!	percentage	10.00
37	Happy ea day!	percentage	50.00
38	Happy veritatis day!	percentage	50.00
39	Happy id day!	percentage	20.00
40	Happy necessitatibus day!	percentage	30.00
41	Happy veniam day!	percentage	20.00
42	Happy dolore day!	percentage	30.00
43	Happy saepe day!	percentage	10.00
44	Happy sit day!	percentage	10.00
45	Happy assumenda day!	percentage	40.00
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
1	1	39
2	1	45
3	1	38
4	1	17
5	2	54
6	2	32
7	2	41
8	2	55
9	3	6
10	3	21
11	3	29
12	3	45
13	4	33
14	4	15
15	4	21
16	4	20
17	5	56
18	5	24
19	5	23
20	5	1
21	6	73
22	6	88
23	6	97
24	6	1
25	7	100
26	7	95
27	7	68
28	7	34
29	8	6
30	8	26
31	8	10
32	8	63
33	9	98
34	9	30
35	9	84
36	9	43
37	10	30
38	10	80
39	10	103
40	10	61
41	11	103
42	11	179
43	11	97
44	11	126
45	12	20
46	12	126
47	12	167
48	12	16
49	13	74
50	13	123
51	13	96
52	13	35
53	14	176
54	14	77
55	14	85
56	14	6
57	15	4
58	15	150
59	15	7
60	15	49
61	16	207
62	16	240
63	16	147
64	16	75
65	17	14
66	17	220
67	17	124
68	17	115
69	18	67
70	18	36
71	18	33
72	18	61
73	19	220
74	19	157
75	19	237
76	19	132
77	20	73
78	20	111
79	20	84
80	20	224
81	21	165
82	21	99
83	21	145
84	21	88
85	22	66
86	22	223
87	22	83
88	22	97
89	23	192
90	23	169
91	23	165
92	23	293
93	24	213
94	24	224
95	24	244
96	24	160
97	25	251
98	25	242
99	25	42
100	25	178
101	26	89
102	26	143
103	26	259
104	26	264
105	27	223
106	27	193
107	27	245
108	27	297
109	28	58
110	28	348
111	28	149
112	28	223
113	29	148
114	29	27
115	29	66
116	29	291
117	30	336
118	30	333
119	30	253
120	30	72
121	31	191
122	31	374
123	31	332
124	31	183
125	32	375
126	32	19
127	32	328
128	32	127
129	33	354
130	33	61
131	33	138
132	33	93
133	34	288
134	34	211
135	34	23
136	34	297
137	35	66
138	35	105
139	35	190
140	35	36
141	36	334
142	36	149
143	36	189
144	36	199
145	37	176
146	37	249
147	37	465
148	37	374
149	38	343
150	38	297
151	38	55
152	38	349
153	39	232
154	39	128
155	39	16
156	39	382
157	40	79
158	40	444
159	40	438
160	40	81
161	41	436
162	41	172
163	41	165
164	41	517
165	42	502
166	42	504
167	42	217
168	42	250
169	43	503
170	43	345
171	43	480
172	43	291
173	44	403
174	44	285
175	44	386
176	44	494
177	45	420
178	45	302
179	45	378
180	45	436
\.


--
-- Data for Name: discount_voucher; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY discount_voucher (id, type, name, code, usage_limit, used, start_date, end_date, discount_value_type, discount_value, apply_to, "limit", category_id, product_id) FROM stdin;
1	shipping	Free shipping	FREESHIPPING	\N	0	2018-02-22	\N	percentage	100.00	\N	\N	\N	\N
2	value	Big order discount	DISCOUNT	\N	0	2018-02-22	\N	fixed	25.00	\N	200.00	\N	\N
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
40	order	ordereditem
41	account	user
42	account	address
43	product	producttype
44	product	collection
45	order	fulfillment
46	order	fulfillmentline
47	page	page
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
150	cart	0005_auto_20180224_0811	2018-02-24 14:13:05.720786+00
151	discount	0007_auto_20180224_0811	2018-02-24 14:13:05.855831+00
152	order	0022_auto_20180224_0811	2018-02-24 14:13:06.087181+00
153	product	0040_auto_20180224_0811	2018-02-24 14:13:06.360508+00
154	shipping	0008_auto_20180224_0811	2018-02-24 14:13:06.380927+00
155	userprofile	0015_auto_20171213_0734	2018-03-15 04:30:46.1567+00
156	userprofile	0016_auto_20180108_0814	2018-03-15 04:30:46.782146+00
157	account	0017_auto_20180206_0957	2018-03-15 04:30:46.823288+00
158	auth	0009_alter_user_last_name_max_length	2018-03-15 04:30:46.843979+00
159	cart	0005_auto_20180108_0814	2018-03-15 04:30:47.329109+00
160	cart	0006_auto_20180221_0825	2018-03-15 04:30:47.353664+00
161	discount	0007_auto_20180108_0814	2018-03-15 04:30:47.838698+00
162	product	0040_auto_20171205_0428	2018-03-15 04:36:33.460617+00
163	product	0041_auto_20171205_0546	2018-03-15 04:36:33.464859+00
164	product	0042_auto_20171206_0501	2018-03-15 04:36:33.468897+00
165	product	0043_auto_20171207_0839	2018-03-15 04:36:33.474288+00
166	product	0044_auto_20180108_0814	2018-03-15 04:36:33.478302+00
167	product	0045_md_to_html	2018-03-15 04:36:33.48219+00
168	product	0046_product_category	2018-03-15 04:36:33.485907+00
169	product	0047_auto_20180117_0359	2018-03-15 04:36:33.49042+00
170	product	0048_product_class_to_type	2018-03-15 04:36:33.49338+00
171	order	0022_auto_20171205_0428	2018-03-15 04:36:33.49642+00
172	order	0023_auto_20171206_0506	2018-03-15 04:36:33.499396+00
173	order	0024_remove_order_status	2018-03-15 04:36:33.503359+00
174	order	0025_auto_20171214_1015	2018-03-15 04:36:33.505868+00
175	order	0026_auto_20171218_0428	2018-03-15 04:36:33.508197+00
176	order	0027_auto_20180108_0814	2018-03-15 04:36:33.511532+00
177	order	0028_status_fsm	2018-03-15 04:36:33.514834+00
178	order	0029_auto_20180111_0845	2018-03-15 04:36:33.521303+00
179	order	0030_auto_20180118_0605	2018-03-15 04:36:33.524457+00
180	order	0031_auto_20180119_0405	2018-03-15 04:36:33.527702+00
181	order	0032_orderline_is_shipping_required	2018-03-15 04:36:33.53051+00
182	order	0033_auto_20180123_0832	2018-03-15 04:36:33.534791+00
183	order	0034_auto_20180221_1056	2018-03-15 04:36:33.538221+00
184	order	0035_auto_20180221_1057	2018-03-15 04:36:33.54132+00
185	order	0036_remove_order_total_tax	2018-03-15 04:36:33.544299+00
186	order	0037_auto_20180228_0450	2018-03-15 04:36:33.546963+00
187	order	0038_auto_20180228_0451	2018-03-15 04:36:33.549937+00
188	order	0039_auto_20180312_1203	2018-03-15 04:36:33.552835+00
189	order	0040_auto_20180210_0422	2018-03-15 04:36:33.555151+00
190	order	0041_auto_20180222_0458	2018-03-15 04:36:33.558566+00
191	order	0042_auto_20180227_0436	2018-03-15 04:36:33.562421+00
192	page	0001_initial	2018-03-15 04:36:33.565173+00
193	product	0049_collection	2018-03-15 04:36:33.568564+00
194	product	0050_auto_20180131_0746	2018-03-15 04:36:33.572723+00
195	product	0051_auto_20180202_1106	2018-03-15 04:36:33.57603+00
196	product	0052_slug_field_length	2018-03-15 04:36:33.578597+00
197	shipping	0008_auto_20180108_0814	2018-03-15 04:36:33.58096+00
198	site	0011_auto_20180108_0814	2018-03-15 04:36:33.583649+00
199	account	0012_auto_20171117_0846	2018-03-15 04:36:33.588428+00
200	account	0003_auto_20151104_1102	2018-03-15 04:36:33.591089+00
201	account	0007_auto_20161115_0940	2018-03-15 04:36:33.595608+00
202	account	0008_auto_20161115_1011	2018-03-15 04:36:33.598563+00
203	account	0015_auto_20171213_0734	2018-03-15 04:36:33.601356+00
204	account	0006_auto_20160829_0819	2018-03-15 04:36:33.605387+00
205	account	0001_initial	2018-03-15 04:36:33.607713+00
206	account	0010_auto_20170919_0839	2018-03-15 04:36:33.609855+00
207	account	0004_auto_20160114_0419	2018-03-15 04:36:33.611998+00
208	account	0014_auto_20171129_1004	2018-03-15 04:36:33.616222+00
209	account	0002_auto_20150907_0602	2018-03-15 04:36:33.619462+00
210	account	0013_auto_20171120_0521	2018-03-15 04:36:33.622955+00
211	account	0009_auto_20170206_0407	2018-03-15 04:36:33.625243+00
212	account	0005_auto_20160205_0651	2018-03-15 04:36:33.627384+00
213	account	0011_auto_20171110_0552	2018-03-15 04:36:33.63001+00
214	account	0016_auto_20180108_0814	2018-03-15 04:36:33.632357+00
215	cart	0007_auto_20180315_0548	2018-03-15 04:48:27.618846+00
216	discount	0008_auto_20180315_0548	2018-03-15 04:48:27.674827+00
217	order	0043_auto_20180315_0548	2018-03-15 04:48:27.871236+00
218	product	0053_auto_20180315_0548	2018-03-15 04:48:27.916109+00
219	shipping	0009_auto_20180315_0548	2018-03-15 04:48:27.927589+00
220	cart	0007_auto_20180317_2151	2018-03-17 20:59:05.518248+00
221	discount	0008_auto_20180317_2151	2018-03-17 20:59:05.591155+00
222	order	0043_auto_20180317_2151	2018-03-17 20:59:05.774496+00
223	product	0053_auto_20180317_2151	2018-03-17 20:59:05.813751+00
224	shipping	0009_auto_20180317_2151	2018-03-17 20:59:05.823337+00
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
1	shipped	55.8800	1	2018-02-22 10:00:38.083769+00		DHL Rest of World
2	shipped	44.5000	2	2018-02-22 10:00:38.124119+00		UPC Rest of World
3	new	55.8800	3	2018-02-22 10:00:38.162097+00		DHL Rest of World
4	shipped	34.6600	4	2018-02-22 10:00:38.204558+00		UPC Germany
5	shipped	55.8800	5	2018-02-22 10:00:38.250275+00		DHL Rest of World
6	shipped	55.8800	6	2018-02-22 10:00:38.275935+00		DHL Rest of World
7	new	55.8800	7	2018-02-22 10:00:38.311656+00		DHL Rest of World
8	shipped	55.8800	8	2018-02-22 10:00:38.357846+00		DHL Rest of World
9	shipped	55.8800	9	2018-02-22 10:00:38.405857+00		DHL Rest of World
10	new	44.5000	10	2018-02-22 10:00:38.450139+00		UPC Rest of World
11	shipped	44.5000	11	2018-02-22 10:00:38.499317+00		UPC Rest of World
12	shipped	44.5000	12	2018-02-22 10:00:38.523813+00		UPC Rest of World
13	shipped	44.5000	13	2018-02-22 10:00:38.566038+00		UPC Rest of World
14	new	44.5000	14	2018-02-22 10:00:38.624518+00		UPC Rest of World
15	new	44.5000	15	2018-02-22 10:00:38.665499+00		UPC Rest of World
16	shipped	44.5000	16	2018-02-22 10:00:38.71792+00		UPC Rest of World
17	shipped	55.8800	17	2018-02-22 10:00:38.756819+00		DHL Rest of World
18	new	44.5000	18	2018-02-22 10:00:38.802532+00		UPC Rest of World
19	shipped	55.8800	19	2018-02-22 10:00:38.835237+00		DHL Rest of World
20	new	55.8800	20	2018-02-22 10:00:38.890308+00		DHL Rest of World
21	shipped	77.8800	21	2018-02-24 14:34:11.42551+00		UPC Poland
22	new	75.8200	22	2018-02-24 14:34:11.495771+00		UPC Rest of World
23	shipped	75.8200	23	2018-02-24 14:34:11.541696+00		UPC Rest of World
24	shipped	55.8800	24	2018-02-24 14:34:11.593989+00		DHL Rest of World
25	new	75.8200	25	2018-02-24 14:34:11.643963+00		UPC Rest of World
26	shipped	44.5000	26	2018-02-24 14:34:11.700647+00		UPC Rest of World
27	new	55.8800	27	2018-02-24 14:34:11.779476+00		DHL Rest of World
28	shipped	8.8300	28	2018-02-24 14:34:11.8218+00		DHL Germany
29	shipped	44.2900	29	2018-02-24 14:34:11.852081+00		DHL Rest of World
30	new	55.8800	30	2018-02-24 14:34:11.884525+00		DHL Rest of World
31	new	44.2900	31	2018-02-24 14:34:11.939582+00		DHL Rest of World
32	new	44.2900	32	2018-02-24 14:34:11.991722+00		DHL Rest of World
33	shipped	44.2900	33	2018-02-24 14:34:12.018357+00		DHL Rest of World
34	new	44.5000	34	2018-02-24 14:34:12.055319+00		UPC Rest of World
35	shipped	75.8200	35	2018-02-24 14:34:12.104702+00		UPC Rest of World
36	shipped	75.8200	36	2018-02-24 14:34:12.134308+00		UPC Rest of World
37	shipped	44.2900	37	2018-02-24 14:34:12.17101+00		DHL Rest of World
38	shipped	75.8200	38	2018-02-24 14:34:12.220771+00		UPC Rest of World
39	new	75.8200	39	2018-02-24 14:34:12.251142+00		UPC Rest of World
40	shipped	44.5000	40	2018-02-24 14:34:12.300702+00		UPC Rest of World
41	shipped	44.5000	41	2018-02-26 19:31:07.819029+00		UPC Rest of World
42	shipped	98.4500	42	2018-02-26 19:43:48.373163+00		DHL Rest of World
43	shipped	44.2900	43	2018-03-02 17:24:09.297481+00		DHL Rest of World
44	shipped	75.8200	44	2018-03-03 17:20:31.944256+00		UPC Rest of World
45	shipped	99.7000	45	2018-03-13 03:22:33.051171+00		DHL Rest of World
50	new	43.9100	50	2018-03-13 05:21:45.469344+00		UPC Rest of World
51	new	98.4500	51	2018-03-13 05:22:20.323197+00		DHL Rest of World
\.


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY order_order (id, status, created, last_status_change, tracking_client_id, user_email, token, billing_address_id, shipping_address_id, user_id, total_net, total_tax, discount_amount, discount_name, voucher_id, language_code) FROM stdin;
31	payment-pending	2018-02-24 14:34:11.929616+00	2018-02-24 14:34:11.929635+00		lisa.johnson@example.com	ed8d3edd-c47c-4686-a845-8f1e2506444b	57	57	\N	668.98	0.00	\N		\N	en-us
1	payment-pending	2018-02-22 10:00:38.071103+00	2018-02-22 10:00:38.071126+00		patricia.wong@example.com	9c351a38-e9ef-4038-b8cf-fe630398f6d1	21	21	\N	452.22	0.00	\N		\N	en-us
24	payment-pending	2018-02-24 14:34:11.585072+00	2018-02-24 14:34:11.585089+00		crystal.williams@example.com	af2f2918-bf76-49ab-9332-2d4b402f0e9c	53	53	\N	131.44	0.00	\N		\N	en-us
2	fully-paid	2018-02-22 10:00:38.114172+00	2018-02-22 10:00:38.114189+00			80a04446-5204-4907-9f09-e9cf8be31bdc	6	6	6	482.20	0.00	\N		\N	en-us
15	shipped	2018-02-22 10:00:38.655269+00	2018-02-22 10:00:38.655304+00		mark.norris@example.com	cd7c7824-e5de-4fb5-a00f-5bde56812566	27	27	\N	698.30	0.00	\N		\N	en-us
3	fully-paid	2018-02-22 10:00:38.154395+00	2018-02-22 10:00:38.154407+00			e859ab70-34ce-4206-b13b-5d54f97d7886	11	11	11	263.16	0.00	\N		\N	en-us
4	payment-pending	2018-02-22 10:00:38.192834+00	2018-02-22 10:00:38.192846+00			6f504537-b76a-4006-892f-5acb2e0d9e15	16	16	16	298.13	0.00	\N		\N	en-us
40	payment-pending	2018-02-24 14:34:12.291872+00	2018-02-24 14:34:12.29189+00		nancy.johnson@example.com	dd17678a-01bd-4cd8-8eca-9cc01654eb92	61	61	\N	743.29	0.00	\N		\N	en-us
5	payment-pending	2018-02-22 10:00:38.243424+00	2018-02-22 10:00:38.243437+00		joshua.porter@example.com	31461471-a005-4e95-836d-2d955a814299	22	22	\N	382.48	0.00	\N		\N	en-us
25	fully-paid	2018-02-24 14:34:11.635458+00	2018-02-24 14:34:11.635478+00		cameron.perry@example.com	672adb6b-112c-454c-802f-df88ff950393	54	54	\N	593.92	0.00	\N		\N	en-us
16	shipped	2018-02-22 10:00:38.709432+00	2018-02-22 10:00:38.70945+00			4b14cf44-d7a8-4587-9ca2-be3f2e4ed4ef	6	6	6	70.94	0.00	\N		\N	en-us
6	fully-paid	2018-02-22 10:00:38.268237+00	2018-02-22 10:00:38.26825+00			ef1cd7a9-5f40-460f-b9f8-520b16cc52bb	8	8	8	188.68	0.00	\N		\N	en-us
7	payment-pending	2018-02-22 10:00:38.303706+00	2018-02-22 10:00:38.303724+00			beab9ed3-de45-428c-8831-ac3452756074	5	5	5	369.13	0.00	\N		\N	en-us
17	payment-pending	2018-02-22 10:00:38.748164+00	2018-02-22 10:00:38.748176+00		colleen.marshall@example.com	00d09269-3a38-4924-923a-35262e4f45d3	28	28	\N	575.43	0.00	\N		\N	en-us
8	fully-paid	2018-02-22 10:00:38.349123+00	2018-02-22 10:00:38.349136+00		manuel.taylor@example.com	8413a788-615f-4dac-83b3-97e6330d0417	23	23	\N	555.99	0.00	\N		\N	en-us
32	payment-pending	2018-02-24 14:34:11.98124+00	2018-02-24 14:34:11.981258+00			6ef199ab-c0c5-4ac2-8818-a0423cccd750	48	48	41	199.13	0.00	\N		\N	en-us
18	payment-pending	2018-02-22 10:00:38.795548+00	2018-02-22 10:00:38.795563+00			553a7187-854b-430c-a9c1-a622c704255c	15	15	15	98.11	0.00	\N		\N	en-us
9	shipped	2018-02-22 10:00:38.397388+00	2018-02-22 10:00:38.397401+00			b94709ea-70b7-49ee-93e3-6d02dbd502e0	6	6	6	251.75	0.00	\N		\N	en-us
19	payment-pending	2018-02-22 10:00:38.825514+00	2018-02-22 10:00:38.825527+00		melanie.collins@example.com	5dd079cb-1688-47bf-b2bc-7e2e15b182cf	29	29	\N	424.96	0.00	\N		\N	en-us
10	shipped	2018-02-22 10:00:38.443599+00	2018-02-22 10:00:38.443612+00		glenn.torres@example.com	722d76ea-5ff4-402a-a0fc-5fec187d8fac	24	24	\N	405.64	0.00	\N		\N	en-us
11	payment-pending	2018-02-22 10:00:38.491633+00	2018-02-22 10:00:38.491661+00		janice.rodriguez@example.com	ae36ffac-9e65-4b58-a7b3-bc8fa0b5fdd6	25	25	\N	244.02	0.00	\N		\N	en-us
26	fully-paid	2018-02-24 14:34:11.692272+00	2018-02-24 14:34:11.692287+00		kristin.summers@example.com	a41cfa7a-4c9e-40b1-8eb9-de08275f2894	55	55	\N	657.58	0.00	\N		\N	en-us
12	payment-pending	2018-02-22 10:00:38.515056+00	2018-02-22 10:00:38.515068+00			2600e6eb-43eb-4852-9508-3e9b61debdba	10	10	10	414.38	0.00	\N		\N	en-us
20	payment-pending	2018-02-22 10:00:38.880956+00	2018-02-22 10:00:38.880975+00			138a4e14-9aa5-4bf0-8d24-9eb7708b7559	10	10	10	551.61	0.00	\N		\N	en-us
13	payment-pending	2018-02-22 10:00:38.557204+00	2018-02-22 10:00:38.557265+00			04f6ba40-9d9a-4b57-93cf-b8825721d1fd	20	20	20	659.06	0.00	\N		\N	en-us
14	payment-pending	2018-02-22 10:00:38.61494+00	2018-02-22 10:00:38.614959+00		monique.cervantes@example.com	3caf4e27-362d-471f-8d4d-e7b97c7a2523	26	26	\N	155.06	0.00	\N		\N	en-us
37	payment-pending	2018-02-24 14:34:12.161176+00	2018-02-24 14:34:12.161195+00		jesus.reed@example.com	4873a878-08cc-44b6-9c5c-23529154133f	59	59	\N	308.74	0.00	\N		\N	en-us
21	fully-paid	2018-02-24 14:34:11.404023+00	2018-02-24 14:34:11.404044+00		joseph.perez@example.com	03340f92-53a6-4c9d-b210-cc3bfe7cbe7f	50	50	\N	195.99	0.00	\N		\N	en-us
27	payment-pending	2018-02-24 14:34:11.770287+00	2018-02-24 14:34:11.770305+00		donald.olson@example.com	a0cea4ca-2e25-4ea9-a42e-8c54956abfbe	56	56	\N	257.88	0.00	\N		\N	en-us
22	payment-pending	2018-02-24 14:34:11.48757+00	2018-02-24 14:34:11.487588+00		judith.cardenas@example.com	cbb9fead-e4b7-43e6-b20e-345872f049ac	51	51	\N	361.25	0.00	\N		\N	en-us
33	payment-pending	2018-02-24 14:34:12.008254+00	2018-02-24 14:34:12.008266+00			18778390-95a5-4cf4-9f88-e44632ff824b	15	15	15	370.97	0.00	\N		\N	en-us
28	payment-pending	2018-02-24 14:34:11.80936+00	2018-02-24 14:34:11.809378+00			8761e214-4ed0-4e69-aefb-37f3fbe866af	16	16	16	158.65	0.00	\N		\N	en-us
23	shipped	2018-02-24 14:34:11.530862+00	2018-02-24 14:34:11.530881+00		bethany.jimenez@example.com	078603e5-c003-4b61-be61-959a9dd15bbc	52	52	\N	487.51	0.00	\N		\N	en-us
29	payment-pending	2018-02-24 14:34:11.843635+00	2018-02-24 14:34:11.843653+00			3daf8680-da55-4a65-a566-76a7a648512f	32	32	25	391.29	0.00	\N		\N	en-us
30	payment-pending	2018-02-24 14:34:11.875188+00	2018-02-24 14:34:11.875205+00			2c6a3f8a-2151-4a46-bb8e-d28ef08f4488	35	35	28	451.81	0.00	\N		\N	en-us
34	payment-pending	2018-02-24 14:34:12.047793+00	2018-02-24 14:34:12.047806+00		sarah.nelson@example.com	4734be40-c787-417c-8765-0e6bdbb642b9	58	58	\N	535.84	0.00	\N		\N	en-us
38	payment-pending	2018-02-24 14:34:12.211157+00	2018-02-24 14:34:12.211176+00		mary.cordova@example.com	cf8e7ca5-3ed8-48a8-9503-6c03e7fd3105	60	60	\N	332.68	0.00	\N		\N	en-us
35	payment-pending	2018-02-24 14:34:12.095908+00	2018-02-24 14:34:12.095921+00			0223f729-7906-4c17-99f1-b41d1ae7982c	13	13	13	221.94	0.00	\N		\N	en-us
36	payment-pending	2018-02-24 14:34:12.124222+00	2018-02-24 14:34:12.124238+00			5a4b8840-69b6-4f85-8cee-6411a42237fb	8	8	8	181.78	0.00	\N		\N	en-us
41	payment-pending	2018-02-26 19:31:07.803885+00	2018-02-26 19:31:07.803909+00		kathleen.howell@example.com	096a205a-077a-4777-a9ea-921ec2be2832	82	82	\N	\N	\N	\N		\N	en-us
39	payment-pending	2018-02-24 14:34:12.241968+00	2018-02-24 14:34:12.241985+00			e65108b7-3f45-47ea-9b04-71e19d9c2275	36	36	29	305.03	0.00	\N		\N	en-us
43	payment-pending	2018-03-02 17:24:09.283069+00	2018-03-02 17:24:09.283084+00		daniel.evans@example.com	7414c70a-01de-4123-bcf6-efdbe1902f5c	124	124	\N	\N	\N	\N		\N	en-us
42	payment-pending	2018-02-26 19:43:48.363799+00	2018-02-26 19:43:48.363814+00		veronica.bowers@example.com	88f2686a-f022-42ff-81ae-7c2c229ad3b6	103	103	\N	\N	\N	\N		\N	en-us
44	payment-pending	2018-03-03 17:20:31.898653+00	2018-03-03 17:20:31.898678+00			ee058d85-9cde-4d41-8ada-848cdf11455f	118	118	97	\N	\N	\N		\N	en-us
45	payment-pending	2018-03-13 03:22:33.037398+00	2018-03-13 03:22:33.037413+00			1539ba43-4eeb-4cae-abb9-31c4e1ad4ea8	128	128	106	\N	\N	\N		\N	en-us
50	payment-pending	2018-03-13 05:21:45.458599+00	2018-03-13 05:21:45.458615+00		mark.melendez@example.com	e8a23790-4dc1-46c2-a71a-9ceffe8fe6af	197	197	\N	\N	\N	\N		\N	en-us
51	payment-pending	2018-03-13 05:22:20.313676+00	2018-03-13 05:22:20.313691+00			7a30d1e7-e519-4de0-81ac-d39577f743ed	156	156	134	\N	\N	\N		\N	en-us
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
1	Warner, Sanchez and Fowler	42-1338	4	57.2100	57.2100	1	42	\N	
2	Leonard-Vasquez	28-1339	2	83.7500	83.7500	1	28	\N	
3	Johnson-English	48-1338	4	68.6000	68.6000	2	48	\N	
4	Palmer Group	57-1337	2	81.6500	81.6500	2	57	\N	
5	Ellison, Coleman and Johnson	37-1342	2	90.2000	90.2000	3	37	\N	
6	Wright, Valencia and Hart	6-1340	2	13.4400	13.4400	3	6	\N	
7	Johnston-Rodriguez	33-1342	2	13.7400	13.7400	4	33	\N	
8	Arnold-Moran	16-1337	3	41.6500	41.6500	4	16	\N	
9	Martin, Lara and Schneider	54-1337	2	13.2200	13.2200	4	54	\N	
10	Morgan-Collins	7-1340	3	28.2000	28.2000	4	7	\N	
11	Palmer Group	57-1337	4	81.6500	81.6500	5	57	\N	
12	Riley, Johnson and Walker	23-1339	4	33.2000	33.2000	6	23	\N	
13	Reynolds Inc	15-1337	1	99.6200	99.6200	7	15	\N	
14	Arnold-Moran	16-1337	3	41.6500	41.6500	7	16	\N	
15	Murray, Harris and Frank	17-1337	4	8.9200	8.9200	7	17	\N	
16	Morgan, Day and Martinez	47-1338	1	53.0000	53.0000	7	47	\N	
17	Riley Inc	1-1340	3	88.2600	88.2600	8	1	\N	
18	Palmer Group	57-1337	1	81.6500	81.6500	8	57	\N	
19	Reynolds-Pratt	19-1337	1	57.7000	57.7000	8	19	\N	
20	Williams-Owens	14-1337	2	47.9900	47.9900	8	14	\N	
21	Acosta Group	12-1337	2	57.1100	57.1100	9	12	\N	
22	Palmer Group	57-1337	1	81.6500	81.6500	9	57	\N	
23	Stanton-Mathews	44-1338	3	73.5000	73.5000	10	44	\N	
24	Wright, Valencia and Hart	6-1340	2	13.4400	13.4400	10	6	\N	
25	Cline Ltd	10-1340	2	56.8800	56.8800	10	10	\N	
26	Gonzalez, Morris and Cole	24-1339	2	99.7600	99.7600	11	24	\N	
27	Bullock-Baker	55-1337	4	9.3300	9.3300	12	55	\N	
28	Knight, Mccoy and Elliott	21-1339	2	33.1000	33.1000	12	21	\N	
29	Montes, Terry and Johnson	27-1339	3	74.7100	74.7100	12	27	\N	
30	Reid LLC	51-1337	1	42.2300	42.2300	12	51	\N	
31	Acosta Group	12-1337	1	57.1100	57.1100	13	12	\N	
32	Roberts-Williams	59-1337	3	35.1500	35.1500	13	59	\N	
33	Wade LLC	60-1337	4	24.7400	24.7400	13	60	\N	
34	Riley Inc	1-1340	4	88.2600	88.2600	13	1	\N	
35	Mendoza LLC	3-1340	4	27.6400	27.6400	14	3	\N	
36	Murray, Harris and Frank	17-1337	4	8.9200	8.9200	15	17	\N	
37	Ellison, Coleman and Johnson	37-1342	3	90.2000	90.2000	15	37	\N	
38	Hartman Ltd	58-1337	4	86.8800	86.8800	15	58	\N	
39	Martin, Lara and Schneider	54-1337	2	13.2200	13.2200	16	54	\N	
40	Young PLC	34-1342	2	67.5900	67.5900	17	34	\N	
41	Martinez-Morgan	18-1337	3	23.3000	23.3000	17	18	\N	
42	Williams-Morrow	46-1338	1	86.9500	86.9500	17	46	\N	
43	Cline Ltd	10-1340	4	56.8800	56.8800	17	10	\N	
44	Berg, Horton and Bennett	45-1338	1	53.6100	53.6100	18	45	\N	
45	Roberts-Williams	59-1337	2	35.1500	35.1500	19	59	\N	
46	Mitchell-Larson	30-1339	1	56.4500	56.4500	19	30	\N	
47	Johnson-English	48-1338	3	68.6000	68.6000	19	48	\N	
48	Decker PLC	52-1337	1	36.5300	36.5300	19	52	\N	
49	Castaneda-Mccullough	9-1340	2	45.8200	45.8200	20	9	\N	
50	Morgan, Day and Martinez	47-1338	4	53.0000	53.0000	20	47	\N	
51	Valdez-Hawkins	26-1339	3	6.3300	6.3300	20	26	\N	
52	Reynolds-Pratt	19-1337	3	57.7000	57.7000	20	19	\N	
53	Williams, Stafford and Oconnor	78-1337	2	23.2000	23.2000	21	78	\N	
54	Moore, Larsen and Black	94-1337	1	44.2300	44.2300	21	94	\N	
55	Johnston-Rodriguez	33-1337	2	13.7400	13.7400	21	33	\N	
56	Johnson and Sons	115-1337	4	55.9000	55.9000	22	115	\N	
57	Johnson and Sons	118-1337	3	20.6100	20.6100	22	118	\N	
58	Ellison, Coleman and Johnson	37-1337	4	90.2000	90.2000	23	37	\N	
59	Higgins Ltd	90-1337	1	50.8900	50.8900	23	90	\N	
60	Benton and Sons	13-1337	4	7.4400	7.4400	24	13	\N	
61	Schwartz, Key and Leon	102-1337	3	10.6500	10.6500	24	102	\N	
62	Barber, Rodriguez and Simpson	53-1337	1	13.8500	13.8500	24	53	\N	
63	Davis, Gay and Warner	40-1337	1	89.9000	89.9000	25	40	\N	
64	Reed-Olson	85-1337	4	38.4200	38.4200	25	85	\N	
65	Thompson-Glass	119-1337	4	68.6300	68.6300	25	119	\N	
66	Jackson Inc	114-1337	3	86.7900	86.7900	26	114	\N	
67	Reid LLC	51-1337	4	42.2300	42.2300	26	51	\N	
68	Acosta Group	12-1337	1	57.1100	57.1100	26	12	\N	
69	Davenport-Williams	4-1337	2	63.3400	63.3400	26	4	\N	
70	Martinez and Sons	70-1337	2	55.4000	55.4000	27	70	\N	
71	Contreras PLC	100-1337	3	30.4000	30.4000	27	100	\N	
72	Martinez LLC	39-1337	2	74.9100	74.9100	28	39	\N	
73	Martin and Sons	77-1337	4	86.7500	86.7500	29	77	\N	
74	Rhodes, Farmer and Myers	105-1337	1	62.3000	62.3000	30	105	\N	
75	Lopez-Hall	83-1337	3	48.2000	48.2000	30	83	\N	
76	Anderson-White	49-1337	2	81.6700	81.6700	30	49	\N	
77	Taylor-Barajas	79-1337	1	25.6900	25.6900	30	79	\N	
78	Wright, Valencia and Hart	6-1337	4	13.4400	13.4400	31	6	\N	
79	Chapman-Phillips	64-1337	3	21.2100	21.2100	31	64	\N	
80	Gonzales Inc	111-1337	3	69.4800	69.4800	31	111	\N	
81	Reynolds Inc	15-1337	3	99.6200	99.6200	31	15	\N	
82	Craig-Clements	38-1337	2	77.4200	77.4200	32	38	\N	
83	Anderson-White	49-1337	4	81.6700	81.6700	33	49	\N	
84	Arnold-Moran	16-1337	2	41.6500	41.6500	34	16	\N	
85	Rollins-Oneill	32-1337	3	28.3400	28.3400	34	32	\N	
86	Adams PLC	2-1337	3	79.5200	79.5200	34	2	\N	
87	Reid LLC	51-1337	2	42.2300	42.2300	34	51	\N	
88	Decker PLC	52-1337	4	36.5300	36.5300	35	52	\N	
89	Taylor Ltd	29-1337	4	26.4900	26.4900	36	29	\N	
90	Martin and Sons	77-1337	1	86.7500	86.7500	37	77	\N	
91	Johnson-English	48-1337	1	68.6000	68.6000	37	48	\N	
92	Harvey, Hudson and Jones	56-1337	2	54.5500	54.5500	37	56	\N	
93	Franklin-Cannon	74-1337	3	85.6200	85.6200	38	74	\N	
94	Chapman-Phillips	64-1337	4	21.2100	21.2100	39	64	\N	
95	Martinez and Sons	70-1337	2	55.4000	55.4000	39	70	\N	
96	Duarte, Cruz and Villegas	97-1337	3	11.1900	11.1900	39	97	\N	
97	Leonard-Vasquez	28-1337	3	83.7500	83.7500	40	28	\N	
98	Jackson Inc	114-1337	3	86.7900	86.7900	40	114	\N	
99	Marshall PLC	99-1337	2	47.4800	47.4800	40	99	\N	
100	Mayer, Hutchinson and Olson	104-1337	1	92.2100	92.2100	40	104	\N	
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
1	default	waiting	unknown		2018-02-22 10:00:38.10412+00	2018-02-22 10:00:38.104167+00	55980	USD	452.22	55.88	0.00		Patricia	Wong	257 Garcia Passage Apt. 732		Sullivanshire	17344-3287	NG			165.71.12.188			e9175a68-3b6e-488c-b07c-86a11ad7b193	0.00	1
2	default	confirmed	unknown		2018-02-22 10:00:38.141119+00	2018-02-22 10:00:38.143512+00	20752	USD	482.20	44.50	0.00		Anthony	Durham	773 Wilson Parkway Apt. 561		East Christopher	54626	MW			65.118.240.118			d9b383bb-e9af-4b2d-b4a0-ffae4191969f	482.20	2
3	default	confirmed	unknown		2018-02-22 10:00:38.180184+00	2018-02-22 10:00:38.183362+00	9752	USD	263.16	55.88	0.00		Lisa	Daniels	32169 Richard Corner Apt. 391		South Raymondfurt	79447	KR			238.10.29.218			325b5196-fb07-47a9-88fb-517a611e0add	263.16	3
4	default	preauth	unknown		2018-02-22 10:00:38.230563+00	2018-02-22 10:00:38.230587+00	67486	USD	298.13	34.66	0.00		Angela	Duarte	63007 Espinoza Burgs		East Adam	35374-2983	DE			152.100.182.33			82829f61-6fb4-4c2d-bbeb-eadf70c9238a	0.00	4
5	default	waiting	unknown		2018-02-22 10:00:38.26201+00	2018-02-22 10:00:38.262035+00	20196	USD	382.48	55.88	0.00		Joshua	Porter	6351 Matthews Station Suite 714		West Robert	70299	GM			8.218.204.213			33399601-921b-4803-b301-3368d7996d9b	0.00	5
6	default	confirmed	unknown		2018-02-22 10:00:38.290129+00	2018-02-22 10:00:38.293512+00	75718	USD	188.68	55.88	0.00		Amy	Frey	016 Karen Springs		Randychester	68318-0094	ID			228.95.249.109			0fd1dc39-2b95-4ad4-b018-2c4f4769bc47	188.68	6
7	default	waiting	unknown		2018-02-22 10:00:38.337509+00	2018-02-22 10:00:38.337533+00	23209	USD	369.13	55.88	0.00		Alexander	Nixon	29252 Peterson Terrace		West Christianburgh	95429	MH			13.20.100.12			db266f26-b9d9-47b3-9041-c9e9e5f416d4	0.00	7
8	default	confirmed	unknown		2018-02-22 10:00:38.383619+00	2018-02-22 10:00:38.386444+00	99352	USD	555.99	55.88	0.00		Manuel	Taylor	8217 Brian Lake Suite 226		Kaylachester	67474	LS			240.86.191.249			c150eacc-4e95-4422-b29a-3fa51da52296	555.99	8
9	default	confirmed	unknown		2018-02-22 10:00:38.420214+00	2018-02-22 10:00:38.422553+00	68522	USD	251.75	55.88	0.00		Anthony	Durham	773 Wilson Parkway Apt. 561		East Christopher	54626	MW			157.221.223.127			30c81f3d-6c2d-4ccb-962f-2ddee9cfc848	251.75	9
10	default	confirmed	unknown		2018-02-22 10:00:38.471491+00	2018-02-22 10:00:38.473749+00	82792	USD	405.64	44.50	0.00		Glenn	Torres	622 Estrada Circle Suite 261		Lake Dana	13064	CR			188.73.113.205			61aaa80b-8483-4883-8643-c91137d128d7	405.64	10
11	default	preauth	unknown		2018-02-22 10:00:38.509442+00	2018-02-22 10:00:38.509464+00	79679	USD	244.02	44.50	0.00		Janice	Rodriguez	3448 William Mountains Apt. 666		Alisonport	86432	AU			1.15.116.113			44311723-9735-46dc-9068-e67b9963bacd	0.00	11
12	default	preauth	unknown		2018-02-22 10:00:38.548392+00	2018-02-22 10:00:38.548422+00	72325	USD	414.38	44.50	0.00		Joel	Mckee	14884 Samuel Centers		Port Claudia	71190-7093	KE			87.248.84.201			ef058619-8d69-4f59-bf9f-f53e9e8d3cb2	0.00	12
13	default	preauth	unknown		2018-02-22 10:00:38.597585+00	2018-02-22 10:00:38.59762+00	86575	USD	659.06	44.50	0.00		Nicholas	Maynard	780 Monique Summit Suite 806		Vasquezfort	59277	CN			125.161.151.126			09c04691-0f09-44b5-ab55-2adf993a520d	0.00	13
14	default	preauth	unknown		2018-02-22 10:00:38.638213+00	2018-02-22 10:00:38.638246+00	92158	USD	155.06	44.50	0.00		Monique	Cervantes	8237 Juan Orchard		Davisbury	14640-0984	EE			77.37.222.58			5566ebe9-fc2a-4bab-a9d3-3b6854b21279	0.00	14
15	default	confirmed	unknown		2018-02-22 10:00:38.69082+00	2018-02-22 10:00:38.693772+00	79198	USD	698.30	44.50	0.00		Mark	Norris	718 Lewis Tunnel Apt. 290		Lake Melodyland	71581	SO			142.159.212.110			a91dd66d-50b5-489c-8a58-51a8eaada209	698.30	15
16	default	confirmed	unknown		2018-02-22 10:00:38.728048+00	2018-02-22 10:00:38.730375+00	13151	USD	70.94	44.50	0.00		Anthony	Durham	773 Wilson Parkway Apt. 561		East Christopher	54626	MW			176.217.69.243			5648ad79-0eef-4099-8346-9655943d3d38	70.94	16
17	default	waiting	unknown		2018-02-22 10:00:38.785414+00	2018-02-22 10:00:38.785449+00	49100	USD	575.43	55.88	0.00		Colleen	Marshall	3164 Holt Mountains Suite 935		New Robert	85740-3239	CI			8.10.15.182			73576b46-e24f-4fbb-b3d1-79abcba985d4	0.00	17
18	default	waiting	unknown		2018-02-22 10:00:38.814454+00	2018-02-22 10:00:38.814478+00	5252	USD	98.11	44.50	0.00		Anthony	Pierce	440 Perez Groves		Banksborough	78137-5621	FJ			28.166.220.132			cf3b1886-b911-4d61-ba67-ce2432f13933	0.00	18
19	default	preauth	unknown		2018-02-22 10:00:38.867878+00	2018-02-22 10:00:38.867911+00	40180	USD	424.96	55.88	0.00		Melanie	Collins	7827 Harvey Roads		South Danielstad	27835	KN			118.155.17.47			8fd3e9ae-a16a-43d6-8e08-e2116610cb94	0.00	19
20	default	preauth	unknown		2018-02-22 10:00:38.92689+00	2018-02-22 10:00:38.926927+00	87915	USD	551.61	55.88	0.00		Joel	Mckee	14884 Samuel Centers		Port Claudia	71190-7093	KE			106.27.107.213			bac3ba2d-f2e7-4bff-95bb-bce209f2da6a	0.00	20
21	default	confirmed	unknown		2018-02-24 14:34:11.463448+00	2018-02-24 14:34:11.468521+00	50294	NGN	195.99	77.88	0.00		Joseph	Perez	8168 Jackson Forge Apt. 308		Carpenterstad	07101-2764	PL			181.183.178.175			a677576c-8574-4218-9b48-5b709a10e3af	195.99	21
22	default	waiting	unknown		2018-02-24 14:34:11.512398+00	2018-02-24 14:34:11.512432+00	58531	NGN	361.25	75.82	0.00		Judith	Cardenas	21710 Bowen Orchard		Lake Johnathan	47648-3001	BE			52.15.33.185			6378f8ea-f506-472b-9e7a-942088c95c49	0.00	22
23	default	confirmed	unknown		2018-02-24 14:34:11.558287+00	2018-02-24 14:34:11.561203+00	49214	NGN	487.51	75.82	0.00		Bethany	Jimenez	185 Duncan Locks Apt. 470		Lake Jillfurt	35869	NR			247.86.42.26			47a036fd-04ba-4107-b67c-4bc899ca4ef5	487.51	23
24	default	waiting	unknown		2018-02-24 14:34:11.616975+00	2018-02-24 14:34:11.61701+00	1043	NGN	131.44	55.88	0.00		Crystal	Williams	01422 Donald Knoll		Callahanchester	55125	CI			230.67.238.221			656e9cd8-7901-483f-99ae-3814de618f33	0.00	24
25	default	confirmed	unknown		2018-02-24 14:34:11.6672+00	2018-02-24 14:34:11.672901+00	74033	NGN	593.92	75.82	0.00		Cameron	Perry	4830 Olson Squares Suite 107		Gregoryton	01296-8255	KI			170.117.206.163			b683198f-32ea-4435-87e1-306ec979fefc	593.92	25
26	default	confirmed	unknown		2018-02-24 14:34:11.732378+00	2018-02-24 14:34:11.750152+00	6038	NGN	657.58	44.50	0.00		Kristin	Summers	86666 Andrew Ways		East Susan	68236-1859	MN			207.173.160.235			3039f9df-2346-458b-b2f3-b1dfea0f9ad6	657.58	26
27	default	waiting	unknown		2018-02-24 14:34:11.799493+00	2018-02-24 14:34:11.799523+00	44883	NGN	257.88	55.88	0.00		Donald	Olson	5521 Horton Common Apt. 014		Barnesland	21471-0850	UA			218.18.43.215			827d1c1b-4325-4ada-8cd1-5d92ee126764	0.00	27
28	default	preauth	unknown		2018-02-24 14:34:11.834605+00	2018-02-24 14:34:11.834638+00	98395	NGN	158.65	8.83	0.00		Angela	Duarte	63007 Espinoza Burgs		East Adam	35374-2983	DE			61.142.197.253			4b18ce24-04f1-4873-9023-a56ce1995138	0.00	28
29	default	preauth	unknown		2018-02-24 14:34:11.86634+00	2018-02-24 14:34:11.866376+00	36434	NGN	391.29	44.29	0.00		Jeffrey	Hanson	380 Kelli Place Apt. 335		East Alejandro	70492-5712	LS			89.26.228.69			bf9b720b-5b71-4364-876b-a4fe4eb49785	0.00	29
30	default	preauth	unknown		2018-02-24 14:34:11.912258+00	2018-02-24 14:34:11.912292+00	44136	NGN	451.81	55.88	0.00		Yolanda	Lara	99288 Wall Curve Suite 631		Careystad	33899	GT			240.254.219.160			7ceee633-ecc8-4cb5-b853-00c4f737b78b	0.00	30
31	default	preauth	unknown		2018-02-24 14:34:11.972559+00	2018-02-24 14:34:11.972593+00	87404	NGN	668.98	44.29	0.00		Lisa	Johnson	93190 Barron Freeway Apt. 111		Port Kim	44270	TR			19.179.163.32			00b4019b-4946-4ddf-aeb6-db49467c2543	0.00	31
32	default	preauth	unknown		2018-02-24 14:34:12.002001+00	2018-02-24 14:34:12.002022+00	66272	NGN	199.13	44.29	0.00		Anthony	Mccoy	861 Rice Island		West Derrickton	04736-2062	LU			250.43.157.102			758406d8-937e-41bc-8bce-baf50287a9ec	0.00	32
33	default	waiting	unknown		2018-02-24 14:34:12.033889+00	2018-02-24 14:34:12.033925+00	17368	NGN	370.97	44.29	0.00		Anthony	Pierce	440 Perez Groves		Banksborough	78137-5621	FJ			86.136.153.43			b4847312-dd86-455a-a901-0d769da29f8c	0.00	33
34	default	preauth	unknown		2018-02-24 14:34:12.088618+00	2018-02-24 14:34:12.088655+00	12067	NGN	535.84	44.50	0.00		Sarah	Nelson	8296 Carol Lodge Suite 289		North Sergioside	42867	VC			203.27.105.76			bee40408-6eb8-4877-a6e0-9159f832a9fe	0.00	34
35	default	preauth	unknown		2018-02-24 14:34:12.116024+00	2018-02-24 14:34:12.116052+00	85134	NGN	221.94	75.82	0.00		Evan	Lowery	969 Robert Flat		Amyborough	41706	MU			112.110.116.195			ded82882-db8a-4a06-b451-3a3861a22d5a	0.00	35
36	default	preauth	unknown		2018-02-24 14:34:12.148355+00	2018-02-24 14:34:12.14838+00	19242	NGN	181.78	75.82	0.00		Amy	Frey	016 Karen Springs		Randychester	68318-0094	ID			11.1.50.106			b8fd9011-cdef-4ade-8601-929a0b7e4863	0.00	36
37	default	waiting	unknown		2018-02-24 14:34:12.196994+00	2018-02-24 14:34:12.197062+00	48737	NGN	308.74	44.29	0.00		Jesus	Reed	69060 Cameron Cove Suite 684		Jonesstad	64107-3121	CF			103.208.158.12			462cab55-de39-4f5c-b653-3b261df785ac	0.00	37
38	default	preauth	unknown		2018-02-24 14:34:12.233055+00	2018-02-24 14:34:12.233089+00	36104	NGN	332.68	75.82	0.00		Mary	Cordova	90193 David Spring Apt. 365		Lake Claudiaberg	60953	TR			18.162.193.81			cb850715-4e1d-481b-87e9-3879602f31ee	0.00	38
39	default	preauth	unknown		2018-02-24 14:34:12.275606+00	2018-02-24 14:34:12.27564+00	81828	NGN	305.03	75.82	0.00		John	Green	661 Anthony Flats		New Jaredberg	88385-7757	MC			29.73.228.0			ea54f2d0-3a0e-47ee-bfc0-cfb7809c5565	0.00	39
40	default	preauth	unknown		2018-02-24 14:34:12.331071+00	2018-02-24 14:34:12.331104+00	63404	NGN	743.29	44.50	0.00		Nancy	Johnson	623 Mendez Centers Suite 838		West Brian	72891-9191	ER			87.171.54.132			bd1fd017-3212-4e2b-a7b6-5126d2109f77	0.00	40
\.


--
-- Data for Name: product_attributechoicevalue; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_attributechoicevalue (id, name, color, attribute_id, slug) FROM stdin;
1	Saleor		1	saleor
2	Arabica		2	arabica
3	Robusta		2	robusta
4	100g		3	100g
5	250g		3	250g
6	500g		3	500g
7	1kg		3	1kg
8	Sour		4	sour
9	Sweet		4	sweet
10	100g		5	100g
11	250g		5	250g
12	500g		5	500g
13	Blue		6	blue
14	White		6	white
15	Round		7	round
16	V-Neck		7	v-neck
17	Polo		7	polo
18	XS		8	xs
19	S		8	s
20	M		8	m
21	L		8	l
22	XL		8	xl
23	XXL		8	xxl
24	Mirumee Press		9	mirumee-press
25	Saleor Publishing		9	saleor-publishing
26	English		10	english
27	Pirate		10	pirate
28	John Doe		11	john-doe
29	Milionare Pirate		11	milionare-pirate
30	Soft		12	soft
31	Hard		12	hard
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_category (id, name, slug, description, hidden, lft, rght, tree_id, level, parent_id) FROM stdin;
1	Groceries	groceries	Placeat odio nisi tenetur molestias suscipit eveniet. Ad error nihil laborum velit doloribus nemo. Et expedita mollitia in a consequuntur eius quo. Impedit ullam voluptatibus a ducimus.	f	1	2	1	0	\N
2	Accessories	accessories	Esse vel inventore autem libero voluptate repellendus modi beatae. Vel quo ab voluptate aut quia autem.	f	1	2	2	0	\N
3	Apparel	apparel	Dignissimos quidem aliquid error delectus. Suscipit quidem omnis inventore dolores occaecati. Optio itaque recusandae eaque assumenda sed fugit rerum at.	f	1	2	3	0	\N
4	Books	books	Officiis ut hic ab culpa nulla voluptatibus. Rerum veniam molestiae ipsa error officiis magnam beatae et. Id architecto reiciendis quibusdam laborum.	f	1	2	4	0	\N
\.


--
-- Data for Name: product_product; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_product (id, name, description, price, available_on, updated_at, product_class_id, attributes, is_featured, is_published) FROM stdin;
2	Adams PLC	Dolor ad vel voluptas ex numquam. Maiores necessitatibus beatae error quasi.\n\nError maiores dolorem excepturi itaque quas quibusdam enim. Sint nemo adipisci eum error velit. Reiciendis facere alias voluptatum debitis debitis magnam temporibus tempora. Fugiat laborum aut dignissimos animi beatae culpa.\n\nAnimi excepturi ex quis. Corrupti necessitatibus distinctio natus voluptas maxime. Asperiores odit molestias sit dolores iusto eligendi molestiae. Aliquid voluptate unde error praesentium molestiae soluta.\n\nVoluptates officia enim doloribus iure enim consequuntur. Quia quod accusantium maxime debitis voluptate mollitia veniam. Eveniet ipsam libero optio amet. Illum ex nobis sit rerum cum laborum iure voluptatem.\n\nQuasi esse numquam officiis. Harum fuga quidem fugiat nisi repudiandae et sit aliquam. Beatae nulla nisi commodi vitae nisi. Qui ipsa necessitatibus in culpa.	79.52	\N	2018-02-22 10:00:33.764927+00	1	"1"=>"1", "2"=>"3"	f	t
3	Mendoza LLC	Porro aliquam unde ipsum corrupti perspiciatis. Nihil praesentium iste distinctio nesciunt dignissimos provident dolor explicabo. Excepturi quaerat alias accusantium debitis ab. Voluptates dolor sit accusamus libero minus.\n\nAtque dolore molestias ab a fugit autem neque. Harum quisquam delectus in consequuntur autem qui perspiciatis. Amet dolorem eaque fugit suscipit porro beatae. Perspiciatis sequi cumque praesentium porro cupiditate itaque voluptates.\n\nInventore sapiente tempora temporibus vero impedit quas officia. Perferendis voluptas consectetur inventore vel nemo est atque. Sint velit ad quaerat facere ducimus totam. Officiis voluptates blanditiis quam natus voluptatem eum.\n\nPraesentium quam accusantium nesciunt voluptate aut consequatur dolorum. Beatae vero odit eveniet suscipit inventore harum porro. Quia totam maxime voluptas. Repellendus doloribus fugit nisi.\n\nCulpa dolorum numquam modi magnam voluptatibus temporibus corporis. Quia totam explicabo neque nostrum voluptas. Excepturi corporis vero aliquid asperiores.	27.64	\N	2018-02-22 10:00:33.819985+00	1	"1"=>"1", "2"=>"3"	f	t
4	Davenport-Williams	Debitis quam tenetur sed cum magni sit illo. Ratione sit libero minima veniam inventore impedit. Alias recusandae voluptas minus fuga officia saepe.\n\nSed accusamus quas dolores dolorem. Ipsum autem impedit inventore veniam deleniti in commodi nihil. Ratione magni magnam fugit.\n\nLibero iusto cum accusantium doloribus dolore et explicabo. Quos cum enim veritatis reprehenderit dolores recusandae. Rerum nostrum repellendus quas esse harum rem dolorum. Hic debitis delectus necessitatibus.\n\nDolorem recusandae magnam consequatur architecto. Exercitationem maiores labore perferendis nemo dolorem explicabo perferendis. Cumque labore ipsum aliquid quidem ullam.\n\nOccaecati neque at odit dolorem aliquid maiores. Dignissimos asperiores amet et ea eligendi. Optio reprehenderit earum officia nesciunt ipsa accusantium.	63.34	\N	2018-02-22 10:00:33.885887+00	1	"1"=>"1", "2"=>"3"	f	t
5	Brown, Callahan and Prince	Quae perferendis accusantium minima. Cupiditate cum doloremque earum tempora fugiat. Pariatur omnis omnis nesciunt magnam perspiciatis soluta. Ipsa sit atque mollitia officia vero hic.\n\nOdit fugit reprehenderit accusamus perferendis veritatis fugit libero perferendis. Quis asperiores cupiditate distinctio aliquam. Magni aperiam reprehenderit saepe nam quas in tenetur.\n\nDicta excepturi dolorem temporibus explicabo nisi. Alias dolor magnam earum porro ullam excepturi. Ratione accusantium illo aspernatur optio molestias.\n\nLibero ea exercitationem libero expedita corrupti saepe odit. Consectetur cumque corrupti est voluptatum. Eum consequatur consectetur natus possimus at iusto facere. Voluptatem vitae saepe adipisci consequatur aliquid. Quibusdam at optio dolore asperiores sapiente sed.\n\nMagni ad aperiam incidunt animi voluptatem minima reprehenderit. Error natus odit totam tempora cupiditate ea aperiam. Mollitia facilis vitae et culpa ad.	75.46	\N	2018-02-22 10:00:33.938704+00	1	"1"=>"1", "2"=>"2"	f	t
6	Wright, Valencia and Hart	Laudantium sunt porro cupiditate sed. Ratione soluta amet ex fugit. Eos labore impedit atque. Nihil magni voluptatem rerum dolorem ex fuga occaecati.\n\nOdit itaque error ex consequuntur voluptates inventore. Quaerat molestias autem dolor eum nemo.\n\nDolorem qui quaerat est dolore alias soluta itaque. Nulla debitis adipisci possimus quae ratione vero magnam. Aspernatur eius placeat neque voluptatum. Pariatur eius quos tempore a.\n\nCorrupti accusamus quod soluta dicta temporibus neque. Nesciunt incidunt odio reiciendis possimus dignissimos omnis doloremque assumenda.\n\nTemporibus reiciendis dolorum autem at tempore molestias. Nostrum aliquid distinctio molestias sed iste laudantium. Nisi possimus deserunt veritatis quam sed in. Minima excepturi officiis autem animi.	13.44	\N	2018-02-22 10:00:33.996078+00	1	"1"=>"1", "2"=>"3"	f	t
1	Riley Inc	Nesciunt corporis magni numquam rem voluptatum quod cumque. Eius deleniti amet nulla illum quasi doloribus. Optio unde neque unde perferendis corrupti non neque.\n\nRepudiandae possimus rem illo iusto ab consectetur. Qui repellat voluptatum deserunt voluptatibus harum ullam quaerat. Numquam eius temporibus quidem rerum. Cumque est necessitatibus esse eum ex id laboriosam quia.\n\nDolores laudantium repellat error molestiae minus. Beatae enim aut consectetur nostrum fugit voluptate. Reiciendis amet velit beatae libero itaque dolorem ad. Doloribus sint corporis explicabo illum consequuntur.\n\nVelit nulla repudiandae at odio quae porro. Modi deleniti ea rem enim impedit sapiente quis accusantium. Culpa nisi dolores reprehenderit est enim error.\n\nFugit maiores ipsam doloribus mollitia repudiandae. Distinctio unde ullam veniam dolores enim. Explicabo quibusdam iste molestiae distinctio.	88.26	\N	2018-02-22 10:00:33.699787+00	1	"1"=>"1", "2"=>"2"	t	t
7	Morgan-Collins	Dignissimos veritatis mollitia vitae. Voluptates quaerat praesentium ipsam nesciunt. Occaecati occaecati illo sequi esse ipsa officia. Excepturi accusantium architecto dolores incidunt dolor nesciunt doloremque.\n\nLaudantium dicta animi dolore fugiat culpa facilis exercitationem. Tempora nesciunt tempore blanditiis eaque id iusto odit. Eius facilis laborum debitis debitis ab praesentium quia. Consequatur aspernatur velit dolorem nesciunt suscipit quidem totam debitis.\n\nSaepe quae similique quis omnis est temporibus. Assumenda quos occaecati nemo eos dolorem. Assumenda aperiam blanditiis deserunt vero labore voluptate.\n\nEos natus suscipit vel veniam odio modi. Nostrum facilis aspernatur veritatis id enim.\n\nNostrum earum illo aperiam aperiam dolorum nobis. Ipsum aut facere hic quos sequi totam ex.	28.20	\N	2018-02-22 10:00:34.054789+00	1	"1"=>"1", "2"=>"2"	t	t
9	Castaneda-Mccullough	Quas accusamus ullam nesciunt laudantium. Voluptate harum officia ad perferendis quos enim magnam reiciendis. Eos neque reprehenderit quam quod. Nulla quam quam magni numquam.\n\nIpsum placeat delectus qui molestias ut. Ut aspernatur iure voluptate porro. Blanditiis voluptatum tempora exercitationem dicta deleniti veniam nobis perferendis. Unde similique debitis tempore voluptatum odit. Optio nihil aspernatur nemo impedit.\n\nPossimus voluptate asperiores dolor dolorum eius est commodi soluta. Ullam minus ullam odit doloremque distinctio provident. Sint vero labore quos sunt harum tempora animi.\n\nEum praesentium excepturi quibusdam repellat. Odio corrupti placeat officia voluptatum dolorum tempora aut. Delectus mollitia vel deleniti numquam.\n\nAccusantium animi et quasi modi architecto rem pariatur iure. Quasi laboriosam optio magnam a nihil vero. Fuga non perferendis fugit ea cumque tempora consequatur. Provident necessitatibus a possimus ipsam error.	45.82	\N	2018-02-22 10:00:34.1404+00	1	"1"=>"1", "2"=>"2"	f	t
10	Cline Ltd	Repellendus voluptate blanditiis iusto sint necessitatibus debitis qui. Perspiciatis aperiam nihil ratione debitis numquam ab dolor ipsam. Amet quibusdam magnam necessitatibus sed eligendi.\n\nFugit dicta maiores reiciendis nam. Ex architecto exercitationem facere numquam ipsum nisi eum. Animi cupiditate perspiciatis quam explicabo hic. Rerum exercitationem quaerat dolorum.\n\nHic mollitia occaecati a consectetur. Nisi quia ipsam blanditiis voluptate aliquid. Asperiores sequi soluta architecto libero minus. Nostrum labore eveniet repudiandae incidunt dolor animi.\n\nDelectus nobis libero iure id minima. Impedit sit quae repudiandae amet accusamus. Ab fugiat vero corrupti maxime. Reprehenderit excepturi quidem suscipit autem odio aliquid.\n\nModi tempore officia laudantium ipsam magni repudiandae. Officia totam dolores eos earum sed quibusdam culpa perferendis. Maiores voluptatum porro in. Laudantium necessitatibus veritatis voluptatem.	56.88	\N	2018-02-22 10:00:34.18898+00	1	"1"=>"1", "2"=>"3"	f	t
8	Davis, Morgan and Romero	Expedita dolorum cupiditate quibusdam quasi perspiciatis nihil id. Amet natus ratione nobis rerum. Dolorum explicabo voluptates quod quibusdam. Totam asperiores et quae magnam.\n\nVel quae quod amet inventore molestias. Provident quam sunt ipsum. Animi porro voluptatum quasi nostrum consectetur consequuntur. Eum voluptatem ea harum unde ipsa facilis. Beatae suscipit rem ut quia consequuntur maiores neque aut.\n\nOptio numquam laborum vitae. Deserunt labore cumque quia.\n\nCorrupti aut quod nulla doloribus. Optio impedit iste fugiat cupiditate autem praesentium. Placeat ipsa in necessitatibus totam quaerat non. Quo inventore at dolores cumque accusantium iure eum alias.\n\nEius eum vitae nostrum aspernatur rem ex aspernatur. Aut dolor cupiditate sapiente cum quaerat. Facere natus praesentium recusandae consequuntur placeat distinctio. Ipsam ab possimus deserunt aliquid.	57.10	\N	2018-02-22 10:00:34.097029+00	1	"1"=>"1", "2"=>"3"	t	t
12	Acosta Group	Pariatur nobis facere corporis vitae suscipit doloribus impedit. Dolorum iste harum illum eius consequuntur cupiditate.\n\nVelit cumque incidunt numquam doloremque. Placeat esse nobis minima totam. Quasi at architecto nam adipisci autem non. Illum consequuntur exercitationem nisi consequatur unde ducimus quae odio.\n\nVoluptatem praesentium totam cupiditate totam sit et commodi. Cupiditate nisi iure explicabo dicta reiciendis molestiae consectetur. Quaerat dolore ullam blanditiis voluptate voluptates commodi dolorum.\n\nVoluptate quibusdam soluta iure hic optio ab voluptate. Voluptates sapiente ut debitis fugiat. Architecto iste consequatur ea soluta magni optio.\n\nAlias repellat unde ea laudantium. Sapiente atque magni sit nobis non aperiam.	57.11	\N	2018-02-22 10:00:34.278777+00	2	"1"=>"1"	f	t
13	Benton and Sons	Harum assumenda cum ducimus hic quasi molestiae aliquid. A officiis nemo quaerat necessitatibus eveniet quia. Debitis nesciunt fugiat beatae consequatur. Similique corrupti sequi unde repellendus asperiores autem.\n\nRerum rerum molestiae ex reiciendis. Aliquid quaerat esse pariatur aperiam dignissimos debitis. Et deleniti illum numquam harum dolor quaerat.\n\nPorro aliquid earum odio tempore illum doloremque fuga. Nostrum ipsam itaque labore animi. Eos ipsa quia tenetur laboriosam. Aut ipsum corporis incidunt perferendis voluptatibus repellat.\n\nEligendi dolorem magni non beatae. Reprehenderit architecto molestiae natus voluptate eum iure sunt. Voluptatum facilis rerum libero labore alias.\n\nIste sed nisi mollitia. Ratione quos ratione iusto provident quod. Tenetur dignissimos quia veniam incidunt dolore tempora corrupti. Ab voluptate dolores minima similique qui a.	7.44	\N	2018-02-22 10:00:34.32539+00	2	"1"=>"1"	f	t
15	Reynolds Inc	Eligendi labore enim laudantium vero. Tempora sapiente nobis similique blanditiis est. Ab aliquid praesentium itaque velit sunt ab blanditiis.\n\nFuga natus repudiandae ipsum explicabo. Harum rerum perferendis quam tenetur maiores ab. Maiores blanditiis distinctio aperiam qui id et eius incidunt. Minus in doloremque nostrum suscipit expedita corrupti.\n\nEt nesciunt numquam nesciunt doloribus occaecati. Voluptates assumenda nisi harum cum.\n\nQuasi illo enim dolore unde. Hic eos tempora sunt fuga mollitia eligendi modi. Delectus iure neque cum deserunt dignissimos porro iste. Repellat sed explicabo ipsum aperiam reprehenderit voluptatem.\n\nMagni tempora totam alias optio nostrum. Ipsam quisquam quis dolor. Nihil repellat illo doloremque minima quidem sed. Magni ratione deserunt facere consequuntur explicabo.	99.62	\N	2018-02-22 10:00:34.400287+00	2	"1"=>"1"	f	t
16	Arnold-Moran	Magnam ex culpa minima laborum asperiores sapiente recusandae. Quia illo minus minima ab quam sed harum. Sunt aspernatur quae fugit quos deleniti est.\n\nQuaerat enim ratione porro debitis ipsam ut laboriosam. Incidunt dolore placeat iure sunt omnis dolore. Rem placeat odit ab reprehenderit. Optio quaerat repellat nemo eius fuga eligendi quae voluptatibus.\n\nDucimus nesciunt ipsum cupiditate tempora. At commodi provident totam reiciendis quas. Consequatur in non earum. Mollitia dolorem animi ipsa ea saepe rem.\n\nAutem nesciunt voluptates sunt voluptate. Deserunt assumenda reiciendis dolorum incidunt porro hic. Qui nesciunt recusandae maxime sequi a porro.\n\nAb nihil iste ipsa quaerat inventore reiciendis. Consectetur nostrum commodi nulla quisquam facilis. Quam soluta consequuntur enim consequuntur explicabo nemo impedit nobis.	41.65	\N	2018-02-22 10:00:34.433219+00	2	"1"=>"1"	f	t
17	Murray, Harris and Frank	Repellendus harum excepturi libero nostrum explicabo facilis. Odio suscipit necessitatibus inventore quod cum dignissimos. Necessitatibus delectus reiciendis magni illum excepturi. Inventore atque maiores dolor.\n\nNulla officia iste repudiandae dignissimos. Unde omnis pariatur adipisci. Accusamus quisquam odio eaque quis.\n\nRatione occaecati enim sit sapiente fugiat saepe. Dolore vero atque aperiam quia. Voluptates iste dolore libero mollitia ratione.\n\nFugiat nesciunt neque iusto ipsa dolorum iusto. Eum ullam veritatis dolorum officiis. Officia quod similique magnam. Ratione nemo ex sit commodi quam officiis corrupti. Fugiat ipsum minima totam dicta ea atque necessitatibus totam.\n\nTenetur officia provident quos praesentium. Enim voluptas architecto ipsum consectetur nostrum. Quae officia dolorum alias expedita similique. Vitae beatae natus doloribus quasi. Necessitatibus soluta delectus quisquam veritatis dolorum debitis.	8.92	\N	2018-02-22 10:00:34.466881+00	2	"1"=>"1"	f	t
19	Reynolds-Pratt	Necessitatibus consequuntur fuga dolorem distinctio libero. Dolorum quae amet dolor. Excepturi cum eligendi mollitia eveniet perspiciatis dolorum veniam voluptatum.\n\nAdipisci ad occaecati neque facere magni assumenda. Minus veritatis laboriosam alias molestiae provident quaerat dolorem.\n\nDebitis dolores dicta esse corrupti dolorem eum. Nostrum nostrum qui earum atque. Ab quod perferendis officiis quis. Et quos porro soluta rerum asperiores officia ad.\n\nQuam accusamus voluptate voluptatum eligendi non porro illo. Maxime optio exercitationem temporibus aliquid at. Facere eligendi neque accusantium iure consequuntur. Beatae placeat distinctio dolore natus architecto vero at reprehenderit.\n\nCommodi eum quibusdam laudantium minima. Reiciendis fuga quis quae veritatis ducimus ut iusto. Reiciendis atque repellendus cum.	57.70	\N	2018-02-22 10:00:34.552105+00	2	"1"=>"1"	f	t
21	Knight, Mccoy and Elliott	Autem eveniet delectus placeat autem quo praesentium. Rem ipsa numquam occaecati dolore ipsa nesciunt minus. Quo et ad veniam aliquam alias voluptatum.\n\nEsse eius magni enim blanditiis. Commodi provident nostrum debitis blanditiis. Repellat expedita corporis consequatur odio quas.\n\nRatione vel necessitatibus necessitatibus aspernatur dolores. Illum iure ut placeat dolorum incidunt eius atque. Sed nulla praesentium unde et voluptate. Molestias iste possimus consequatur culpa.\n\nPraesentium id impedit est ipsa fugiat est. Adipisci recusandae qui quo molestiae incidunt unde omnis. Voluptatem nostrum facilis porro. Id reprehenderit aliquam quo voluptates cupiditate adipisci quia.\n\nAliquam hic facilis placeat aspernatur at voluptatum. Et voluptatibus natus itaque magni.	33.10	\N	2018-02-22 10:00:34.630909+00	3	"1"=>"1", "4"=>"8"	f	t
18	Martinez-Morgan	Nesciunt sapiente incidunt deleniti. Suscipit cupiditate unde quibusdam quia consequatur nihil.\n\nLaudantium similique esse voluptatibus aut aliquam. Cum soluta incidunt magnam sit magnam a. Neque magni explicabo occaecati consectetur. Sapiente autem vitae suscipit cupiditate minus nesciunt corporis sunt. Voluptatem eum expedita culpa temporibus dolore.\n\nUnde nobis earum fugiat perferendis fugit perferendis. Eaque dolor nam amet minus alias dolore soluta. Quo temporibus ex sed itaque sunt dolorum aperiam. Mollitia aliquid accusantium cupiditate rerum possimus alias.\n\nSint cupiditate nisi atque inventore in. Reprehenderit numquam consequuntur quod. Id possimus quaerat voluptate expedita aspernatur.\n\nAssumenda mollitia ad repellendus. Repellat hic commodi quisquam non. Tenetur magnam culpa quaerat architecto veritatis repellat. Corporis debitis quo laudantium molestiae doloremque.	23.30	\N	2018-02-22 10:00:34.511404+00	2	"1"=>"1"	t	t
22	Campbell Group	Sapiente illo consectetur deserunt vel esse expedita. Autem rem pariatur fuga quod repudiandae ut quisquam maxime. Explicabo quaerat pariatur dignissimos praesentium ad quam vitae. Maxime vero perferendis minus maxime.\n\nPorro distinctio adipisci pariatur quos error culpa aspernatur et. Quaerat dignissimos a necessitatibus ad consectetur animi. Velit eum unde consectetur adipisci.\n\nQuibusdam eaque assumenda a cum. Veniam quasi corporis maiores sapiente recusandae enim totam enim. Inventore voluptatum labore doloribus explicabo quas. Ex quae laboriosam voluptatibus vel perspiciatis.\n\nRepellendus veniam rem atque commodi ipsa. Enim tempora cupiditate sequi iste nostrum aspernatur. Reprehenderit explicabo temporibus alias. Repellat corporis officiis tempore eaque ut sit.\n\nA modi vero architecto. Omnis veniam sunt eveniet fuga eum architecto illo tenetur. Laborum in quidem nemo pariatur nemo laboriosam laboriosam.	0.87	\N	2018-02-22 10:00:34.673133+00	3	"1"=>"1", "4"=>"8"	f	t
24	Gonzalez, Morris and Cole	Quisquam impedit dolores excepturi delectus neque. Perferendis quibusdam recusandae quod quas. Odio placeat atque consequuntur hic voluptates sint.\n\nDolore facilis sapiente quasi. Ipsam sed quia cupiditate hic tempora rerum. Natus provident quidem sint.\n\nCulpa quasi quibusdam quis quidem id. Explicabo voluptatum quod commodi maiores enim. Inventore voluptatibus corporis corrupti illo dolorem et aliquid. Perspiciatis nulla deleniti quaerat pariatur eaque.\n\nNisi voluptatum quia cum suscipit nihil. Minus fugiat veritatis officiis placeat. Ipsum sapiente illo est qui inventore. Accusamus unde alias sequi non quod quo corporis numquam.\n\nTempore debitis aspernatur minus accusantium repellat. Quae provident quos inventore reiciendis. Ipsa dicta quisquam necessitatibus est.	99.76	\N	2018-02-22 10:00:34.772841+00	3	"1"=>"1", "4"=>"8"	f	t
25	Duncan, Martinez and Patton	Similique rerum maxime illo fugiat vitae nam. Maxime dolorum consequuntur repellat quae. Sit autem magni consectetur doloremque repudiandae placeat.\n\nAssumenda laborum veritatis molestiae repellendus tempore id. Delectus corporis praesentium magnam culpa exercitationem nesciunt beatae. At nulla deserunt cupiditate alias beatae maiores hic molestiae. Odit temporibus nihil vel facere voluptas hic.\n\nSequi at fugiat eos amet corporis debitis. Eligendi tempore illo a suscipit quaerat similique beatae. Iusto veniam vitae repudiandae nemo ipsum aspernatur.\n\nMagni aperiam enim tenetur animi voluptas reiciendis tempora. Sequi maxime labore ut laudantium neque praesentium.\n\nRatione veniam dolores blanditiis earum. Omnis pariatur aspernatur dolorum sint.	99.71	\N	2018-02-22 10:00:34.827469+00	3	"1"=>"1", "4"=>"9"	f	t
28	Leonard-Vasquez	Quas error expedita esse adipisci deleniti repellat. Totam fugiat repellendus totam tenetur dignissimos consectetur accusamus. Facere voluptatibus provident consequuntur facere corrupti dolor. Unde enim culpa ipsa quod facilis deserunt.\n\nAd earum reprehenderit nisi voluptate perferendis architecto alias dolorum. Natus magnam aut adipisci error. Quam ipsa facilis aperiam sed.\n\nEst placeat quasi id placeat eius. Et officia suscipit laboriosam aut nostrum. Officia quia provident totam nihil facere ratione repudiandae.\n\nRecusandae repellat quos nobis vitae sit velit. Possimus sint est libero dolores modi at tenetur. Facilis ullam distinctio in voluptate ea. Exercitationem magni mollitia cumque nesciunt id perspiciatis.\n\nPerferendis ad laudantium in sed. Deserunt nesciunt repellendus vitae ipsum iste iure. Ipsum quasi repellendus aliquid ipsam corrupti sed culpa.	83.75	\N	2018-02-22 10:00:35.009471+00	3	"1"=>"1", "4"=>"9"	f	t
23	Riley, Johnson and Walker	Eveniet ad libero tempore molestias veritatis ratione. In at ut molestias aperiam voluptatibus debitis.\n\nIste enim veritatis reprehenderit unde optio. Dolores temporibus unde voluptas ratione. Officiis nostrum hic recusandae excepturi consectetur nostrum.\n\nConsequuntur praesentium earum laborum accusamus iusto occaecati. Eum porro vitae laboriosam excepturi asperiores ex totam sapiente. Ullam et commodi vero cumque. Id at dicta explicabo tenetur magnam hic.\n\nCorporis asperiores debitis id ratione dolorem veniam possimus voluptas. Sed omnis quis sint doloribus aspernatur. Perferendis ad fugiat optio nisi expedita molestias. Illum consectetur voluptas minus hic. Tempore vero voluptatum sint.\n\nLaboriosam reiciendis quaerat cum sapiente beatae suscipit. Quasi aliquam ad laudantium numquam nesciunt perspiciatis. Excepturi distinctio commodi nam vero voluptate aliquid doloribus.	33.20	\N	2018-02-22 10:00:34.724218+00	3	"1"=>"1", "4"=>"9"	t	t
30	Mitchell-Larson	Velit officiis nobis sint ad quos. Vero sunt in nisi nulla in porro excepturi. Optio eaque odit accusantium totam ut illum alias quis.\n\nOfficia exercitationem explicabo quidem. Ad laborum distinctio tempore sequi at.\n\nExplicabo voluptatem sapiente dolore at dolorem. Voluptate accusamus iure voluptas consequatur delectus cumque. Veniam cum tenetur veritatis ex officia.\n\nVero minus explicabo illo adipisci consequuntur illum quidem. Quam voluptatibus nulla sapiente adipisci placeat repellat quaerat.\n\nIpsa aut ipsum eaque ipsam voluptatum aut saepe. Iste odit consequatur laudantium at voluptatem excepturi ea debitis. Et repellendus iure quas expedita dolore pariatur dolorem.	56.45	\N	2018-02-22 10:00:35.105104+00	3	"1"=>"1", "4"=>"8"	f	t
32	Rollins-Oneill	Deleniti nam amet quos magnam perferendis. Vitae suscipit illo soluta dolorum. Necessitatibus tenetur natus excepturi dolorem ut sequi.\n\nUllam cum incidunt reiciendis. Possimus sapiente sit corrupti. Repellendus dolore eveniet aperiam blanditiis dolor expedita earum.\n\nQuod nisi dolores rerum alias nisi animi fugiat voluptas. Iste error incidunt eaque quis.\n\nExplicabo sit asperiores fugiat earum nisi asperiores quo. Pariatur consectetur labore ad exercitationem doloremque ut. Qui quia nobis rerum sed similique omnis error.\n\nMagnam corporis et natus. Repellat iure laudantium modi. Id illo quo cupiditate perspiciatis.	28.34	\N	2018-02-22 10:00:35.251505+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
34	Young PLC	Adipisci in hic natus neque ab consequatur. Omnis eveniet in sint ex iste asperiores.\n\nVoluptates molestiae a numquam consequatur dolor repellendus autem modi. Doloribus eaque dicta dolores. Quam porro nisi eligendi fugiat ad architecto repellat.\n\nIncidunt cum maiores corporis porro excepturi. Quod dicta magnam in hic totam cumque. Laboriosam reprehenderit dolorum beatae assumenda blanditiis possimus minima. Laborum quisquam quas aliquid magni.\n\nEt minima optio officiis necessitatibus. Sed consequatur quisquam sit. Fuga tempora non est perferendis. Error adipisci ducimus animi nostrum.\n\nRepudiandae iste est reiciendis rem iste mollitia. Molestiae quam labore iure at sit eaque. Voluptatibus soluta possimus ex id ipsam.	67.59	\N	2018-02-22 10:00:35.38019+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
29	Taylor Ltd	Ratione esse quasi dolorem alias nam quaerat. Dolores vitae facilis neque temporibus quisquam odio. Officia ullam illo molestiae facere pariatur.\n\nOfficia reiciendis aspernatur vel at iusto dolore libero. Pariatur laborum nisi voluptate repellendus placeat voluptas. Occaecati ullam voluptatem ea quos minus ex enim soluta.\n\nEst quae veritatis ullam saepe. Nam sint aliquid facere. Ab quia quis repellat qui. Ab velit eum perferendis eveniet illo.\n\nReiciendis tenetur repudiandae rem magnam. Praesentium veritatis sit architecto rem. Necessitatibus hic vitae qui quas. Laudantium iste sed excepturi ducimus illum earum aut.\n\nSapiente voluptatum corporis sit accusamus at facere officia architecto. Dicta minus tempora repellendus ratione minima magni modi. Placeat cumque sequi dicta possimus minus ipsa commodi.	26.49	\N	2018-02-22 10:00:35.056161+00	3	"1"=>"1", "4"=>"9"	t	t
88	Bell-Vargas	Veniam totam similique amet debitis assumenda porro eligendi. Illum inventore vero odit quisquam unde. Voluptates provident doloremque quos optio. Enim quasi eligendi voluptatum temporibus quae delectus cum.\n\nNostrum tempora vel iure ratione distinctio ex. Dolorem dolor corporis quod nemo nostrum eligendi. Modi facilis eos nostrum a illo dolorem officia. Optio facere totam dolorum minima asperiores animi.\n\nRecusandae architecto dolor quo. Perspiciatis necessitatibus soluta at cum. Facere nisi cum nostrum quos facilis odit veniam.\n\nMollitia dolore temporibus repudiandae eum voluptatem. Exercitationem modi fugiat quasi repudiandae.\n\nFugit odio ducimus minima repudiandae rem dignissimos ex numquam. Odit molestias ducimus natus iure ut. Culpa aperiam ea provident.	43.31	\N	2018-02-24 14:34:05.671921+00	3	"1"=>"1", "4"=>"9"	f	t
96	Williams LLC	Ipsa laborum ut aut sunt dicta iure commodi. Quasi eum consequuntur ipsam eius. Voluptatum mollitia doloribus debitis ipsum.\n\nReprehenderit autem iure reprehenderit ab quis cupiditate rerum minima. Non minus inventore ducimus accusantium eum. Quos ab est eius quod accusamus alias.\n\nDolore similique dolorem repellendus harum quibusdam nesciunt dolore quo. Molestias eligendi rem dolores ipsa rerum laborum sit. Architecto numquam aliquam consequatur qui molestiae.\n\nFugit natus rerum eaque blanditiis. Aperiam culpa ad perferendis odio adipisci dolorum. Porro ipsa quisquam aperiam nostrum quaerat mollitia. Incidunt assumenda corporis illo ratione asperiores repellat perferendis explicabo.\n\nQuasi reiciendis illum sapiente beatae incidunt incidunt. Odit animi tenetur fuga sed cum. Voluptatum vitae eveniet voluptas maiores facere ipsum. Assumenda est mollitia libero consectetur modi eum unde.	37.15	\N	2018-02-24 14:34:06.795385+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
111	Gonzales Inc	Dicta voluptatibus sed commodi asperiores voluptates fugit deserunt. Cum magnam voluptate culpa quisquam blanditiis aut repudiandae. Ea provident provident velit natus.\n\nCumque animi ipsam quas minus officia. Doloribus vel numquam et.\n\nOfficiis impedit qui perspiciatis sit. Ipsam est eum sed corporis deleniti animi odio. Amet hic ea aliquid ipsam expedita. Autem aut blanditiis voluptatem.\n\nEligendi tenetur inventore molestias. Quod officia sint quam cum pariatur quaerat sapiente. Veritatis earum commodi inventore eos voluptatum delectus molestiae. Perspiciatis nisi a aspernatur rerum praesentium.\n\nRepellat consequatur temporibus esse ex quisquam ad assumenda voluptates. Delectus amet doloribus praesentium officia. Adipisci quaerat laborum quasi officia ipsa culpa. Et adipisci rem commodi dolore veritatis laboriosam. Officiis temporibus laudantium quod velit.	69.48	\N	2018-02-24 14:34:08.163745+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
35	Singleton-Goodman	Non tempore officia excepturi nemo atque modi. Blanditiis libero asperiores quod eaque. Necessitatibus nam tempora et voluptatibus. Nesciunt possimus inventore minima asperiores consequuntur culpa ipsa. Explicabo reiciendis perspiciatis quod nisi.\n\nQuisquam enim maxime earum voluptatibus sequi officiis. Cumque reiciendis ad rem pariatur libero mollitia. Deleniti dignissimos cum quibusdam ea laborum maxime.\n\nQuis in maiores dolores expedita. Perferendis veritatis iure quaerat molestias adipisci facere cumque. Inventore minima ducimus iusto unde officiis culpa maxime. Totam corporis autem asperiores laudantium. Tempora error velit veritatis voluptates magni minima dolorem.\n\nAt illum culpa veritatis pariatur commodi itaque facere. Aliquid nulla earum libero. Velit enim aspernatur labore quis dignissimos. Veniam asperiores error repudiandae sed perferendis.\n\nQuaerat commodi sint totam similique. Accusantium esse quo quisquam quod. Porro suscipit impedit ea tempora iusto voluptas repellendus. Rem delectus voluptas asperiores sed magnam consectetur cum dolore.	51.60	\N	2018-02-22 10:00:35.44024+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
36	Oliver-Peck	Ratione quisquam ex quaerat recusandae. Modi enim culpa id nisi. Beatae facere ipsam ratione quas atque impedit. Illo dignissimos accusamus tempora maiores quas expedita distinctio.\n\nImpedit tempore doloribus atque sit illum magni. Ducimus laudantium facilis ducimus. Magni aperiam incidunt earum neque deserunt sint iste.\n\nQuibusdam ipsa autem quia ipsa provident. Quo corrupti perspiciatis non voluptatum possimus provident quidem. Modi delectus nobis quaerat reprehenderit iure consequuntur eaque.\n\nEarum necessitatibus impedit recusandae unde hic quas deserunt. Eligendi quae architecto reprehenderit iure accusantium consequuntur eveniet. Non reprehenderit atque quaerat minus. Illo nemo voluptas earum sapiente sit modi itaque.\n\nCommodi officiis velit culpa voluptatem id. Quod nisi similique soluta cupiditate illo ullam. Iste cupiditate magni totam reiciendis reiciendis culpa aperiam. Distinctio eos ipsa atque similique labore quo.	16.90	\N	2018-02-22 10:00:35.513274+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
37	Ellison, Coleman and Johnson	Accusantium asperiores consequuntur laborum in voluptate in consectetur. Eveniet cumque aliquid accusamus incidunt omnis nam amet. Deserunt fugiat esse quae modi beatae optio. Inventore ratione consequatur possimus sequi voluptate.\n\nSapiente deleniti similique autem iure amet voluptas. Mollitia cumque delectus rerum tenetur. Ut consequatur aliquam eius minus at nam.\n\nSit quod nobis illo doloremque consequuntur eligendi. Amet vel nulla laudantium.\n\nCumque repellat deleniti tenetur dolorum aliquam. Reprehenderit adipisci iusto voluptates expedita quidem velit. Quas voluptatibus mollitia nesciunt.\n\nIllum officiis debitis ex veritatis expedita aut. Dolores similique quaerat dolorem saepe laboriosam. Tempore culpa labore nostrum quis. Quo labore quam quis cum.	90.20	\N	2018-02-22 10:00:35.564887+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
39	Martinez LLC	Temporibus dolore culpa iste tempore aliquam. Ut consequuntur qui labore amet temporibus a molestiae. Reprehenderit corporis tempora ex ad.\n\nLabore animi voluptatibus similique veritatis. Eius ipsa asperiores sequi in delectus odit. Cupiditate aperiam modi ratione praesentium aspernatur cupiditate odit. Rerum tempora ipsam autem doloribus odio commodi officia.\n\nDeserunt nihil eius vel consectetur ad veritatis ipsam illum. Nobis quod distinctio cum adipisci quaerat. Ex optio at corporis doloribus facere eligendi quos.\n\nExpedita nisi rerum tenetur consequuntur. Pariatur minus rerum vero dignissimos eius corrupti quaerat veritatis. Odit voluptatibus impedit magni accusantium. Quas placeat illo molestiae veniam optio ut eius.\n\nLaborum dolor fuga aliquid. Cupiditate laudantium amet temporibus minima quod voluptates. Labore reiciendis quam consequatur saepe tenetur ex. Error non molestias cupiditate inventore ipsam sequi tenetur.	74.91	\N	2018-02-22 10:00:35.710033+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
26	Valdez-Hawkins	Iste pariatur minima aut odio praesentium vero quia. Ullam consectetur eius quibusdam mollitia beatae. Minima modi rerum iure quis repudiandae deserunt. Ea perspiciatis voluptatem inventore.\n\nAutem sapiente ratione nostrum explicabo. Asperiores debitis unde reiciendis ipsum nostrum quos quisquam. Omnis veniam temporibus deserunt. Deserunt magni perferendis occaecati dolores.\n\nInventore quos eum officiis dignissimos quam. Perspiciatis debitis cum non nam eveniet necessitatibus mollitia. Dolor doloremque facilis velit doloremque laudantium totam. Occaecati maxime aliquid voluptatum et quod culpa cupiditate.\n\nQuae eligendi tempore facere soluta quidem. At ducimus vero porro error. Natus quasi quaerat tenetur culpa. Ex minus accusantium atque libero.\n\nExplicabo eos ducimus minus sequi excepturi. Nostrum explicabo quas quis at veritatis officia.	6.33	\N	2018-02-22 10:00:34.881339+00	3	"1"=>"1", "4"=>"9"	t	t
54	Martin, Lara and Schneider	Nemo in perferendis consectetur modi sit iste. Eum at distinctio tempore est optio quo. Maiores in minus asperiores.\n\nVoluptatibus corporis libero laborum. Optio tempora error hic doloremque molestiae. Fugit odio quas accusantium.\n\nEius excepturi nam ab vel beatae. Distinctio repellendus iste non accusantium sint autem. Ipsam cum voluptatem voluptatibus odio fugiat dolor maiores illo. Eius fuga beatae ea nam consequuntur.\n\nAb beatae eligendi odit soluta maiores exercitationem dicta. Iusto omnis earum nihil nobis laborum laboriosam necessitatibus beatae. Eos aliquid eos commodi natus sit similique.\n\nPraesentium blanditiis eos officiis aspernatur inventore. Iure dignissimos atque ab at ducimus rerum aperiam impedit. Ea sed perspiciatis reiciendis veritatis magni. Quidem eligendi temporibus distinctio laboriosam sapiente accusantium veniam.	13.22	\N	2018-02-22 10:00:36.479547+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
41	Howard PLC	Id in optio placeat praesentium dolores quis voluptatibus. Non odio deleniti esse sequi laboriosam asperiores vitae adipisci. Earum eligendi debitis atque natus quas ullam quos corrupti.\n\nAutem ad possimus ipsum inventore odio nesciunt. Perferendis suscipit earum quae iure optio rerum. Neque iure sapiente maxime odit incidunt non beatae. Repellat iste facilis adipisci rerum temporibus beatae.\n\nMinima tempora ullam quibusdam animi non explicabo molestiae. Autem iste molestiae illum ut quam saepe quis. Non magni ut veniam laboriosam minus voluptatem ipsa eum.\n\nImpedit dignissimos placeat animi reprehenderit ex. Aperiam veritatis tempore iusto iure ipsum magnam reprehenderit. Doloremque eligendi iste recusandae minus perferendis. Dignissimos voluptatum et quo corrupti quam.\n\nNisi laboriosam eaque dolorum fuga facilis. Iusto est officiis harum quisquam nemo aperiam iste consequatur. Placeat fugiat omnis dolorum pariatur aperiam id. Quam dignissimos similique expedita nulla mollitia nam laudantium aspernatur. Animi pariatur id veritatis cupiditate excepturi optio officia.	43.10	\N	2018-02-22 10:00:35.838823+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
42	Warner, Sanchez and Fowler	Magni eos optio perspiciatis esse occaecati maxime libero earum. Et quis voluptates minus tempora. Quas quam error veritatis blanditiis.\n\nIpsa pariatur voluptas repellat porro quam nobis. Quaerat error impedit labore explicabo consequuntur enim. Excepturi ea dolores odit modi eos numquam voluptatibus. Nobis modi voluptatibus facere in.\n\nQuis quidem delectus similique placeat explicabo nostrum. Molestias non ex qui vero vero. Quos voluptates adipisci voluptate. In fuga cupiditate error earum iusto.\n\nNecessitatibus pariatur reiciendis qui hic cum occaecati delectus. Nihil ab dolor animi dolore voluptatum magni. Corrupti labore exercitationem dolorem repellat esse. Eveniet inventore corrupti at minus delectus.\n\nInventore beatae modi inventore nostrum saepe deserunt placeat. Laborum tenetur consectetur aut voluptatem ab vel. Repellendus molestias eos nihil at molestias sed. Officia rem expedita porro officiis eius eligendi.	57.21	\N	2018-02-22 10:00:35.89211+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
43	Patterson Ltd	Maxime nisi sint ipsam quisquam saepe neque. Rem magnam voluptatem tenetur aspernatur. Distinctio voluptates molestiae culpa at aliquam hic. Id quasi cumque atque quaerat nihil atque ut reprehenderit.\n\nMagni natus eum officiis natus maxime perferendis quibusdam. Dolore molestiae rem a maiores. Totam maiores debitis expedita ipsa. Nobis deserunt eius quas omnis at ut.\n\nEst fugit rerum consequuntur quae commodi numquam. Ex veritatis sequi ipsa inventore enim modi. Distinctio hic voluptatibus reiciendis reprehenderit sapiente. Placeat delectus expedita illo reiciendis.\n\nPraesentium odit facere error nihil repellat quibusdam nemo in. Recusandae ipsa illum neque velit. Nemo incidunt nesciunt repudiandae ipsum tempore. Est numquam corporis temporibus laboriosam enim occaecati. Beatae deserunt accusamus sunt asperiores.\n\nRem impedit corrupti molestiae minima officia quod consequuntur eligendi. Doloribus recusandae aliquid est quis non voluptate. Repudiandae fuga est commodi temporibus eius accusamus.	82.14	\N	2018-02-22 10:00:35.956943+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
210	Spencer-Wood	Numquam ratione sed aliquid ducimus consequuntur. Voluptatem ipsam vero voluptas aliquam repudiandae.\n\nPorro magni non modi esse fuga. Molestiae hic perferendis molestias nisi cumque. Quas nobis maiores quia incidunt vero modi.\n\nImpedit animi dolorum accusamus architecto. Corrupti consectetur eaque tempora sequi recusandae.\n\nEos consequuntur nulla saepe molestiae deleniti consequatur. Neque officiis suscipit nihil nam deleniti non. Earum enim consequatur voluptatibus nostrum culpa eos.\n\nQuibusdam corporis sint ab ut nulla dolor. Ea sunt nisi deserunt inventore necessitatibus.	21.60	\N	2018-02-26 19:43:44.442606+00	3	"1"=>"1", "4"=>"9"	f	t
40	Davis, Gay and Warner	Officiis odit aut dolor animi consectetur non. Quae qui quisquam mollitia labore debitis odio. Tempora modi eveniet sequi voluptas impedit distinctio.\n\nDicta nesciunt nulla quos harum saepe. Officia dolore aliquam quia vel dignissimos ipsum. Pariatur vitae laborum necessitatibus repudiandae omnis corrupti.\n\nFuga tenetur nulla doloribus fuga optio. Iste reprehenderit voluptates eum excepturi deleniti. Consequatur possimus sapiente reprehenderit eum impedit nulla harum. Alias libero veritatis autem libero debitis at earum.\n\nIllo fugit facilis enim maxime cupiditate iure harum. Quasi ab eos beatae sint esse unde repellat deleniti. Commodi nam repellat quasi aliquid. Ullam commodi exercitationem maiores ratione.\n\nSed molestias rem eligendi ex doloribus quibusdam provident. Eius hic cum ipsum reprehenderit quo. Veritatis consequuntur omnis cupiditate repellat similique nesciunt commodi. Exercitationem a nihil culpa cupiditate doloremque voluptatum qui.	89.90	\N	2018-02-22 10:00:35.770977+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	t	t
211	Johnson-Ramirez	Voluptatem corporis quis omnis labore qui quos quam. Laudantium quia maiores provident id fugit veniam reiciendis. Est optio voluptatem laudantium ipsam dolorum. Vero adipisci placeat suscipit blanditiis.\n\nConsectetur ratione optio occaecati repellat. Excepturi praesentium velit omnis dolorum voluptate eius doloribus.\n\nPerferendis voluptatem voluptates quia tenetur sunt aliquid. Tenetur sunt accusantium saepe distinctio corporis harum. Earum repellat quod fugit eaque. Ratione blanditiis maxime eos incidunt deserunt natus suscipit.\n\nVoluptatum delectus doloribus omnis ab aspernatur. Vero aliquam nulla praesentium delectus tenetur quis optio qui.\n\nUt nostrum expedita fuga tenetur animi praesentium. Praesentium est sapiente saepe quibusdam quod. Maiores asperiores facere quisquam porro cumque hic ea aut. Beatae provident dignissimos adipisci tempore iste unde.	57.58	\N	2018-02-26 19:43:44.517013+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
243	Campbell, Wong and Barnes	Dolor voluptatum esse fugiat soluta quod dolor illum totam. Quisquam ea provident veniam minus reprehenderit molestiae. Facere id saepe voluptates at rem nam.\n\nOfficia deleniti provident aspernatur tempora vitae explicabo. Natus harum vel quo at placeat illum. Doloribus nostrum recusandae vitae magnam eum optio ullam. Facere perspiciatis porro laborum occaecati similique.\n\nSit numquam tempore quod sapiente molestias sed. Maxime modi iste ducimus fugiat doloremque provident.\n\nAssumenda odio molestias cupiditate deserunt. Vel quas placeat maxime eius deleniti. Nostrum excepturi cumque asperiores blanditiis a quia dolorem. Adipisci rem ea similique provident temporibus facilis eveniet.\n\nMaiores eum debitis voluptate saepe. Blanditiis alias quaerat aliquid omnis ipsa quae. Magni nihil quae tempora unde nesciunt tenetur.	88.57	\N	2018-03-02 17:24:05.047401+00	1	"1"=>"1", "2"=>"2"	f	t
47	Morgan, Day and Martinez	Modi omnis rerum esse rerum id et fugit aliquam. Nemo eos quis ratione maiores ut voluptatum rerum. Voluptatum officia commodi eum aliquid nobis nesciunt placeat. Quo earum nobis inventore quam.\n\nConsequuntur quaerat rerum at saepe repellendus tempora provident. Doloremque est labore eos corporis veritatis. Incidunt nulla dignissimos a asperiores beatae asperiores qui.\n\nOfficia fugiat laudantium corrupti blanditiis. Voluptatibus aliquam accusamus molestias recusandae quia animi.\n\nMagnam inventore accusantium esse incidunt excepturi. Esse quidem maiores nemo. Pariatur magni nostrum perspiciatis vitae at deserunt voluptatem.\n\nTotam odio ratione velit assumenda tempora. Dolorum officia repellendus ullam nemo. Expedita expedita labore distinctio qui quasi sint consectetur. Omnis consequatur beatae veritatis natus saepe pariatur minus.	53.00	\N	2018-02-22 10:00:36.169907+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
48	Johnson-English	Velit rerum repudiandae quas facilis illum quas quia. Facilis quibusdam enim magni quos nihil commodi. Quidem voluptatum delectus est quisquam. Dolores inventore deserunt sed similique labore blanditiis molestiae magnam.\n\nQuia aliquid eos accusamus porro atque dolores. Voluptate ut eum voluptates libero. Vitae adipisci doloremque earum natus ducimus ipsam.\n\nUt laudantium exercitationem unde quia velit sunt. Dicta necessitatibus ipsam amet nam in facere. Doloribus tempore explicabo accusamus reprehenderit sapiente velit dolorum.\n\nQuos quod facilis dolorem atque autem. Officiis suscipit cupiditate nulla facere voluptates. Distinctio placeat veritatis veritatis natus consequatur nemo. Pariatur at consectetur recusandae expedita iste saepe nostrum.\n\nPerspiciatis suscipit molestiae harum esse. Nulla quaerat nobis laudantium rerum odit perferendis. Enim quia fugiat ratione.	68.60	\N	2018-02-22 10:00:36.222379+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
46	Williams-Morrow	Quas vitae recusandae in vero adipisci. Alias rem velit iusto accusantium. Beatae officiis eligendi voluptatum sapiente pariatur molestias cupiditate. Totam amet tenetur beatae explicabo fugit architecto quos.\n\nAmet architecto enim officiis. Eos in magni suscipit dolores saepe exercitationem explicabo. Sit nesciunt debitis ratione aut.\n\nTotam itaque voluptatum eligendi fugit. Distinctio facere vel id accusamus esse nam. Dolore nostrum eos excepturi tempore inventore. Vel libero modi iste illo magni nihil a cum. Eveniet tempora labore aliquid libero.\n\nInventore debitis ex sunt recusandae. Blanditiis occaecati odio minus reprehenderit amet magnam impedit. Delectus eligendi fuga ab eum vero.\n\nEnim nulla iusto enim incidunt amet soluta repellendus. Dolorem ipsa facere laboriosam occaecati. Iste dolore quam commodi voluptate facilis maxime cumque. Optio optio suscipit vel voluptatem distinctio quaerat quae. Ad iste odit occaecati tenetur.	86.95	\N	2018-02-22 10:00:36.115742+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	t	t
49	Anderson-White	Labore reiciendis beatae itaque quasi ipsa. Veniam dolores assumenda modi iusto. Tenetur dicta eligendi sit exercitationem id odio quas.\n\nVeritatis dolores cumque non facere dolore ipsa aliquid. Cumque ratione non expedita ullam repellendus. Esse corporis cupiditate modi laboriosam nulla facilis optio. Aliquam minus pariatur saepe consectetur provident.\n\nId dolorem ut iusto. In repellat repellendus ipsum rem tempore vel ab dicta. Debitis corrupti est nam accusantium. Deleniti quo consequuntur ducimus modi incidunt facere.\n\nModi debitis reprehenderit quas impedit magnam. Necessitatibus laboriosam repudiandae praesentium temporibus. Quis beatae non maiores possimus in nihil consequatur. Aut est ex odit dolorem soluta impedit voluptates.\n\nSequi quia porro assumenda dolorem. Aliquam repellat exercitationem mollitia dolor deserunt. Sapiente voluptas quo rem voluptas deleniti impedit necessitatibus. Reprehenderit adipisci nam consequatur quibusdam placeat illo autem.	81.67	\N	2018-02-22 10:00:36.265675+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	t	t
70	Martinez and Sons	Culpa commodi consequatur amet aliquid. Molestias mollitia repellat molestiae rerum tenetur. At accusantium fugit illo necessitatibus. Commodi soluta cumque ducimus voluptatem nihil.\n\nVoluptatibus ut repellat suscipit rerum nesciunt id. Consequatur atque facilis natus. Ad eveniet laborum dolorum harum autem possimus.\n\nVoluptatibus sit animi fugit dicta beatae perspiciatis. Odio facilis vel itaque eius ad natus alias et. Repudiandae ipsum debitis voluptatem unde unde vero.\n\nOdit quod delectus optio veritatis vero eius deserunt. Sed sed beatae officiis dignissimos quidem esse quo. Unde voluptates autem quasi. Atque ipsam deserunt eaque voluptate veritatis.\n\nNobis tenetur dicta in iusto nam sapiente fugiat officia. Repudiandae assumenda cupiditate inventore corporis voluptate. Animi beatae qui voluptatibus dicta esse similique nulla quisquam.	55.40	\N	2018-02-24 14:34:04.666411+00	1	"1"=>"1", "2"=>"2"	f	t
71	Bass, Snow and Stokes	Placeat eum animi odit beatae. Nemo veritatis eaque quis dolore sit tempore. Totam fugit error eum.\n\nEveniet rem reiciendis excepturi ipsa officia fuga voluptas. Laboriosam minus dolore autem tempora veniam totam. Debitis eaque incidunt repellendus quisquam.\n\nNon voluptatem soluta ad perspiciatis pariatur sint soluta. Odit dolor amet alias. Quam repudiandae iure fuga beatae.\n\nUt ad iure labore odio tenetur. Tempore vitae ducimus molestiae consectetur. Maxime sed corporis impedit molestias nostrum.\n\nDistinctio consequatur blanditiis atque quasi. Expedita doloribus corporis voluptatem iste commodi accusamus dolorum iusto. Impedit cupiditate consequuntur dolorem tempore repudiandae.	99.75	\N	2018-02-24 14:34:04.726122+00	2	"1"=>"1"	f	t
50	Evans LLC	Itaque esse officiis asperiores. Consectetur dolores esse repellendus debitis sunt doloribus natus. Quis quo nulla est sit quos.\n\nNam fugiat illum ea rem repudiandae labore corporis dicta. Natus tempora quaerat reiciendis rem similique inventore. Dolores quam sapiente officia iste neque in. Quidem sapiente voluptates minima blanditiis sequi commodi.\n\nAccusamus perferendis vel occaecati ipsum. Necessitatibus libero molestiae non error. Magnam id fuga maiores doloremque facere ab a. Assumenda dignissimos pariatur accusantium vel maiores occaecati.\n\nCorrupti repellendus dolor illum. Necessitatibus omnis ipsa provident tenetur. Culpa natus debitis ad molestias veritatis officia. Facilis inventore totam aliquam doloribus consequuntur dolorem repellendus.\n\nSapiente ipsum omnis optio voluptates quidem. Modi quaerat eaque eaque tempore earum. Soluta sint inventore quam.	79.54	\N	2018-02-22 10:00:36.309115+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	t	t
51	Reid LLC	Ea esse magni numquam recusandae quasi rerum dolorem. A dolorum earum quasi sequi amet ut. Velit suscipit explicabo est sed reiciendis ipsam deserunt. Quos voluptatum tenetur quis expedita similique commodi. Ratione explicabo modi eligendi iusto ut.\n\nMinima impedit occaecati minus modi aspernatur. Esse sapiente suscipit eos sequi fuga earum suscipit. Quis voluptates mollitia porro dolores quisquam porro amet voluptates.\n\nBeatae repudiandae quibusdam error mollitia. Maiores dolore nihil corporis accusamus. Provident minus ad numquam recusandae doloribus eum ipsa.\n\nPlaceat voluptatum qui ut aliquid illo animi. Minus recusandae enim aperiam dolore autem magnam blanditiis. Sit similique molestiae unde saepe laudantium fuga.\n\nAliquid explicabo vero ad eaque debitis aut provident. Soluta inventore sed ad a rerum. Quibusdam asperiores corrupti cumque voluptatibus eligendi nam. Dolorem suscipit nemo corporis repellat.	42.23	\N	2018-02-22 10:00:36.355544+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
52	Decker PLC	Fugiat unde dolorum explicabo rerum. Ipsum omnis dolore qui accusamus cum cupiditate. Corrupti distinctio sed aspernatur recusandae error fugiat. Unde corrupti totam accusamus dolor.\n\nAb quaerat distinctio et eveniet quasi suscipit. Error aliquam sequi quo unde possimus. Repellendus illum ipsa ullam ratione voluptates soluta ducimus.\n\nInventore ipsum laboriosam est dolorum. Architecto fuga doloribus magni nesciunt error ipsa. Vero amet ullam tenetur voluptates fugit minima.\n\nAperiam dolorum minus ex nulla officiis. Totam ipsa pariatur impedit eius quae. Earum repudiandae dolor exercitationem eum debitis.\n\nPorro ipsum non corporis. Beatae sed distinctio libero hic voluptatibus. Numquam cumque quo fugiat est fugiat.	36.53	\N	2018-02-22 10:00:36.395293+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
56	Harvey, Hudson and Jones	Quis unde iure reprehenderit labore nostrum. Nihil fuga necessitatibus eaque dolores suscipit atque.\n\nEius at deserunt mollitia porro perspiciatis accusamus qui non. Quos at iste quis occaecati. Doloremque praesentium non consequuntur reiciendis hic.\n\nRepudiandae soluta velit illum explicabo ab at unde. Temporibus aliquam sunt quidem aperiam voluptas inventore nisi. Consequuntur explicabo rem eius molestiae expedita earum eius illo.\n\nOccaecati dolor modi sequi vitae fugit recusandae. Suscipit tenetur dolorem aut vitae. Quaerat illo enim vel consequatur. Harum laboriosam veritatis tempora vero debitis.\n\nVoluptatem a expedita perspiciatis et. Ab ipsam aliquid dolore corporis nulla. Maxime expedita quos veniam. Cupiditate sequi ea est similique.	54.55	\N	2018-02-22 10:00:36.547697+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
53	Barber, Rodriguez and Simpson	Quas exercitationem temporibus consequuntur nostrum ipsam repellat odio. Iste molestiae blanditiis ad nostrum possimus. Consequatur ad maiores ad.\n\nEt quasi modi aspernatur dolorem voluptatum maiores. Recusandae temporibus earum eos ullam veritatis. Quo aperiam totam deleniti.\n\nUt numquam ducimus consequatur ab. Modi autem magni accusamus. Illo veritatis iste illo dolore cupiditate rem ipsum. Quod quae laborum fugiat sapiente nobis.\n\nItaque culpa earum totam laudantium id assumenda. Tenetur eligendi veniam fugiat enim eveniet fugiat nobis. Assumenda incidunt libero fugit doloremque consectetur.\n\nQuod cumque distinctio earum eveniet laborum sapiente. Odit consectetur repellendus nihil placeat optio veniam expedita. Esse excepturi libero odio nostrum consectetur.	13.85	\N	2018-02-22 10:00:36.437925+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
58	Hartman Ltd	Occaecati praesentium incidunt doloremque. Maiores similique assumenda officia dolorem vel culpa. Aspernatur quisquam totam expedita ut fuga inventore. Voluptatem accusamus itaque ipsam occaecati.\n\nPraesentium id blanditiis illum voluptatum blanditiis recusandae. Repudiandae eum ducimus ipsum eius. Ipsum voluptatibus blanditiis blanditiis. Natus reiciendis amet et sed provident distinctio laboriosam.\n\nSit doloremque quibusdam necessitatibus voluptate accusamus at. Odit voluptatibus quia facere aperiam laudantium quo beatae. Quasi similique impedit nobis ab repellat non.\n\nQuis distinctio quis eos reprehenderit maiores. Inventore nesciunt saepe aspernatur a ipsa. Molestias eum harum eaque dignissimos voluptates. Ad blanditiis aspernatur debitis architecto est quia aliquam natus.\n\nIncidunt asperiores ratione illum quisquam est. Unde id eius repellendus et odio velit aliquid. Repellendus sint ratione consequuntur fugit minus odio.	86.88	\N	2018-02-22 10:00:36.6344+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
59	Roberts-Williams	Id officiis necessitatibus numquam ab eos. Accusantium vitae vel veritatis quae quidem repudiandae alias. Accusantium labore repudiandae id eos similique.\n\nQuia cupiditate earum unde. Nemo harum laboriosam voluptates porro dolorum laborum expedita. Qui temporibus molestiae cumque reiciendis officia sit recusandae.\n\nIpsum officiis commodi reprehenderit quis est sequi itaque. Officia aperiam nam atque accusantium. Quibusdam ducimus dolores facilis totam quidem sit officiis.\n\nMaiores dolores officia ad odit illum ipsam voluptate ut. Placeat dignissimos quisquam id reprehenderit. Dicta sit delectus nihil voluptas veniam.\n\nDelectus quae veniam nulla repellat repellat. Quae pariatur eius magnam dolore. Vero iste officiis doloremque voluptatum aliquam. Velit vel ad commodi. Voluptatum ipsa maxime perspiciatis rerum distinctio minus.	35.15	\N	2018-02-22 10:00:36.689778+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
60	Wade LLC	Ratione tempora adipisci eaque eos nostrum tempora. Voluptatem non dolore pariatur ipsam quidem. In voluptatibus voluptatem nostrum suscipit totam. Deleniti quos aliquam reprehenderit rerum.\n\nAutem possimus magnam minima asperiores quasi nostrum. Magni cum nobis deserunt voluptatum sequi. Autem quaerat dolores fugiat nam doloremque adipisci necessitatibus.\n\nSoluta debitis ullam quisquam ducimus laborum odit. Mollitia tenetur necessitatibus fuga. Exercitationem provident earum dolorum veniam sint perferendis totam. Molestias in laborum harum excepturi.\n\nSunt optio harum accusantium repellendus ut. Quidem cupiditate asperiores excepturi laboriosam. Eos quasi excepturi tenetur id eligendi recusandae.\n\nNon perferendis facere est corrupti architecto quae. Vitae corrupti vero delectus officiis. Vitae temporibus et suscipit iste modi in. Pariatur sit repudiandae ipsam.	24.74	\N	2018-02-22 10:00:36.721401+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
11	Hill, Campbell and Baker	Illum corporis expedita alias voluptate optio error molestiae ratione. Incidunt ipsa quos est tenetur nulla. Cupiditate quos tempore ducimus fuga laudantium beatae at. Numquam adipisci quos odio.\n\nPossimus facilis ullam molestias iure culpa. Voluptatum a beatae repellendus inventore suscipit porro earum. Aut ad et consectetur voluptatem error maiores.\n\nRepellat tenetur quaerat similique repudiandae. Illo laudantium unde earum nulla aut distinctio reprehenderit. Ullam quo aperiam quod eveniet nostrum illum.\n\nDolore temporibus asperiores veritatis alias. Eos architecto eos illum distinctio ex natus repudiandae. Similique reiciendis aperiam natus atque minus. Corrupti nulla nemo quaerat reprehenderit est ut occaecati.\n\nVoluptates libero vitae fugit vel aliquam ratione fugit. Commodi deserunt optio voluptate nobis facilis provident quas tempora.	30.93	\N	2018-02-22 10:00:34.244943+00	2	"1"=>"1"	t	t
14	Williams-Owens	Officia beatae ea amet modi. Aperiam dicta doloremque praesentium nostrum. Odio repellat quidem cupiditate nemo asperiores molestias animi.\n\nVitae reprehenderit consectetur facilis consequuntur. Eligendi aut qui quod eaque quam quasi veritatis. Iste ea molestias incidunt tempore. Saepe iste totam rem magni culpa fugit.\n\nRepudiandae perferendis amet hic ut corporis ratione ipsa soluta. Corrupti reprehenderit fugiat molestias rerum.\n\nMolestiae saepe voluptate quod at veritatis labore. Cupiditate suscipit alias recusandae eos quasi. Impedit magnam error officia. Provident ipsam numquam amet eveniet expedita.\n\nNam vero ratione optio excepturi. Adipisci accusamus iste minima cum aliquid error. Porro in deserunt consectetur amet. Libero omnis sint porro deleniti voluptate autem reprehenderit dolor.	47.99	\N	2018-02-22 10:00:34.367017+00	2	"1"=>"1"	t	t
20	Caldwell and Sons	Quasi debitis culpa sunt in laborum vero tempore. Dolorem temporibus neque sunt earum at sed magnam tenetur. Veniam aut similique consequatur laboriosam.\n\nVeritatis occaecati numquam quae ipsam. Dolorum laboriosam odio cupiditate ipsam quos. Suscipit hic sit voluptatum a nostrum error temporibus.\n\nAccusamus ea quibusdam aliquam optio quasi ut facilis. In nemo aspernatur iusto unde omnis quisquam. Neque illo autem fuga iusto quibusdam.\n\nDignissimos ipsam beatae dolor maiores. Quam voluptate in voluptatibus aperiam ullam.\n\nAccusantium quis temporibus cum aspernatur. Fugiat exercitationem exercitationem error. Explicabo consequatur beatae quis non. Assumenda asperiores corrupti adipisci ex praesentium minus distinctio modi.	51.40	\N	2018-02-22 10:00:34.587237+00	2	"1"=>"1"	t	t
55	Bullock-Baker	Non temporibus molestias fugit. Aliquid odit exercitationem nulla aspernatur aut. Excepturi aspernatur quibusdam iure laborum. Quam vero ratione reiciendis ut optio itaque.\n\nVoluptatum velit sit repellendus eligendi porro delectus veritatis dolor. Molestias eos sequi quam magnam placeat laboriosam eos modi. Recusandae veniam totam quo beatae distinctio deleniti blanditiis. Velit molestiae modi commodi harum nisi.\n\nConsequuntur aliquam qui sapiente autem similique. Quibusdam vel occaecati dignissimos debitis minima vel optio. In quae cum temporibus id sit. Excepturi eveniet dicta repudiandae architecto voluptatibus quia minima.\n\nRepudiandae delectus ipsum vel sit repellat. Et ipsa ducimus officia repellat.\n\nCorrupti quas vel harum sapiente vero repellat. Velit sapiente sunt voluptatibus ea mollitia possimus est nostrum. Ut similique provident recusandae magni distinctio odio. In fugit enim voluptatibus odit eius facilis.	9.33	\N	2018-02-22 10:00:36.517225+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
62	Richard-Jones	Fuga sapiente cum autem minima aspernatur. Cum itaque exercitationem ea possimus voluptates consequatur. Maiores soluta earum dignissimos blanditiis facilis.\n\nSoluta dolore aliquid ullam exercitationem laborum sequi. Minus quo voluptatibus nemo similique. Magnam sequi quod labore vitae repellat odit. Beatae doloribus laborum laborum nesciunt.\n\nFugiat alias corporis veritatis ut ducimus quidem. Perspiciatis facere neque quasi molestiae fugiat perferendis atque. At corrupti earum alias ea consequatur impedit.\n\nSoluta sunt eaque iure earum. Nostrum deleniti in qui commodi. Illo recusandae temporibus suscipit porro.\n\nPorro deleniti autem aspernatur repellendus asperiores consequuntur. Voluptates quaerat in dolorum ratione deserunt iure. Sit provident aperiam blanditiis officia earum. Eum optio dolore laboriosam neque architecto.	92.73	\N	2018-02-24 14:34:04.195746+00	1	"1"=>"1", "2"=>"2"	f	t
63	Clark, Hawkins and Hopkins	Debitis optio laudantium laudantium earum. Aspernatur quidem sunt beatae officiis. Facere tempora deleniti quod.\n\nCulpa accusamus maiores ea impedit optio itaque repudiandae. Consequuntur earum hic quod repellat cupiditate error. Non libero nihil vitae beatae magni facilis. Provident amet sapiente aliquid assumenda officiis.\n\nBeatae eius neque sint minus. Sed commodi unde exercitationem excepturi esse esse. Repudiandae quo ex repudiandae nihil excepturi temporibus nesciunt voluptatibus. Repudiandae inventore quis quibusdam doloremque quos.\n\nAut aliquid eveniet perferendis et ducimus ex. Quas assumenda quod reprehenderit dolore harum. Sint ipsam quidem est rem quos laboriosam.\n\nEa optio aspernatur voluptatem minima illum reiciendis ea tempore. Repudiandae eveniet sunt repudiandae perferendis. Deserunt eos consectetur possimus sed aperiam illo delectus. Veritatis odit vel veniam consectetur deserunt laudantium facilis.	74.18	\N	2018-02-24 14:34:04.260109+00	1	"1"=>"1", "2"=>"2"	f	t
64	Chapman-Phillips	Expedita accusantium commodi fuga atque saepe maiores. A non laborum quasi consequuntur consectetur itaque voluptatibus dolor. Officia numquam quod perspiciatis alias nam.\n\nPariatur voluptatem distinctio ut aliquid consectetur. Dolorem magnam amet nobis accusamus eos facilis non. Quos sed eos asperiores quasi dolores itaque. Ex quam nisi aspernatur mollitia nisi sunt.\n\nDistinctio corrupti consequatur aliquid temporibus fugiat. Perspiciatis ut dolor fugit adipisci. Eligendi recusandae animi nisi ullam doloremque.\n\nAlias aliquam nam eum nulla ipsa reiciendis officiis eaque. Officia sint ipsum similique hic. Nostrum tempora debitis ipsum suscipit quidem. Iusto iusto fugiat distinctio animi enim.\n\nAlias recusandae quam sint dolore consequuntur nam excepturi. Fugiat cumque molestiae blanditiis quam beatae at error. Quibusdam assumenda quae quam eligendi natus. Ut quaerat libero nemo reprehenderit quisquam.	21.21	\N	2018-02-24 14:34:04.323387+00	1	"1"=>"1", "2"=>"3"	f	t
65	Christensen-Garcia	Aut non architecto excepturi dolore laudantium possimus. Ex quisquam itaque illum accusantium dicta temporibus. Fugiat iure ullam quidem voluptates harum iure recusandae. Itaque doloremque tempora maxime at voluptates omnis saepe veritatis.\n\nRem est distinctio sint. Architecto nihil iusto necessitatibus repellat non quidem numquam. Autem laborum possimus animi quod in sunt molestiae aliquid. Quibusdam fuga omnis ab dolor officiis assumenda aliquam.\n\nAccusantium eum illum sit laboriosam. Soluta sunt nihil animi aliquam. Praesentium dignissimos corporis modi incidunt quos voluptatem earum.\n\nQuos minima maiores mollitia iusto labore fugiat. Porro quia esse iste aperiam cupiditate aspernatur. Tenetur vero molestiae ullam ipsa consequuntur veritatis sed.\n\nRepudiandae amet ipsam accusantium ipsa. A tempore ad quo quidem distinctio harum commodi. Vitae laudantium sint veniam excepturi.	28.20	\N	2018-02-24 14:34:04.362926+00	1	"1"=>"1", "2"=>"2"	f	t
57	Palmer Group	Laborum ad perferendis blanditiis nam ut repellendus eligendi amet. Consectetur voluptates delectus et inventore earum tempora. Rerum itaque harum nihil commodi. Illo veniam voluptates tempore officia.\n\nIpsa ab placeat officiis. Maiores expedita velit praesentium assumenda odit modi commodi. Itaque et est recusandae necessitatibus alias.\n\nAccusantium ipsum corporis nobis explicabo. Natus magnam neque vel suscipit numquam. Consequuntur corrupti eum facilis omnis.\n\nUllam vel quidem aperiam fuga. Placeat animi expedita nostrum dolorem ipsa non corrupti. Odio voluptatum voluptates voluptate dolore architecto.\n\nLibero ducimus ea rem cupiditate. Repudiandae blanditiis voluptatem ipsum molestiae illo totam animi. Animi accusantium totam quis.	81.65	\N	2018-02-22 10:00:36.597734+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	t	t
66	Preston-Holmes	Tempore exercitationem animi totam natus laborum. Aspernatur recusandae ipsa unde necessitatibus at dignissimos reiciendis. Praesentium corporis magni iste deleniti provident. Neque sed adipisci eum qui asperiores deleniti porro veritatis. Aliquam reprehenderit consequatur officia fugit sapiente nemo.\n\nQuibusdam cum natus ut ipsa tenetur. Blanditiis ut dolor modi nemo. Quisquam ea impedit inventore. Placeat aperiam perspiciatis autem adipisci hic alias consectetur iste. Itaque expedita quam laborum qui harum ut vero sunt.\n\nAsperiores fuga a voluptates incidunt iure eveniet voluptatum. Alias magnam eos explicabo non. Laudantium voluptate quae nam natus pariatur accusamus. Natus natus repellat laborum aut atque officia.\n\nFugit ratione deleniti laborum modi occaecati qui. Fugiat debitis eos nemo laboriosam magnam sapiente sequi nam. Quas eaque itaque accusantium fugit ut voluptatibus repudiandae quo.\n\nAutem repellat harum atque ratione asperiores. Quisquam quaerat nemo excepturi quisquam pariatur qui id. Suscipit ullam consequuntur itaque incidunt necessitatibus. Occaecati ad placeat adipisci eligendi quidem.	19.60	\N	2018-02-24 14:34:04.448586+00	1	"1"=>"1", "2"=>"2"	f	t
67	White-Ramos	Consequuntur pariatur facere neque ipsum. Voluptatibus tempore reiciendis corrupti aliquam veritatis veniam. Illum dolorum expedita fugit dolorem.\n\nVoluptatem est cupiditate facilis eveniet quas repellat soluta. Expedita consequatur libero qui. Quas similique voluptatem velit cum sed repellat. Quidem omnis maiores ex et corrupti quod ullam sed.\n\nPerferendis pariatur distinctio laborum ullam molestias eum dolore. Amet excepturi nesciunt sed. Beatae molestiae eaque sapiente perferendis. Maxime perferendis consectetur laborum in tempore.\n\nHarum eius accusantium doloremque sint alias molestiae molestiae pariatur. Id deserunt qui similique repudiandae quasi neque. Officiis consequatur veniam necessitatibus enim adipisci reprehenderit molestiae natus.\n\nAliquam esse debitis nostrum rem magnam quam rerum. Magni veniam iure voluptas modi possimus. Voluptatibus iste maiores totam beatae. Expedita optio doloribus quaerat provident nam facere iusto.	91.43	\N	2018-02-24 14:34:04.488964+00	1	"1"=>"1", "2"=>"2"	f	t
68	Nelson-Strong	Nulla recusandae quos autem qui minus. Voluptatum facere excepturi recusandae voluptates. Aperiam atque architecto magnam alias similique expedita. Repellat et labore quo et at.\n\nTemporibus dolor quisquam excepturi odio. Quos maiores eius totam suscipit. Tempore quam nesciunt nesciunt beatae odit atque similique. Aspernatur laborum soluta nihil corrupti sint officiis.\n\nHic ducimus ipsa iste quaerat neque maiores error aliquam. Laboriosam provident illo doloribus id. Fugiat eius architecto deserunt eius ex similique.\n\nAssumenda sint voluptatem quaerat. Maxime atque veritatis autem. In adipisci quos quaerat eos doloremque pariatur enim. Voluptates repellat blanditiis fugiat libero. Fugiat harum ut aspernatur error numquam dolorum saepe.\n\nPerspiciatis consectetur libero odit cumque. Blanditiis totam dignissimos nemo architecto. Sit dolore quia ut vitae. Architecto ut necessitatibus perspiciatis adipisci maiores laboriosam. Vero reprehenderit velit enim ipsum vitae deserunt.	43.40	\N	2018-02-24 14:34:04.561749+00	1	"1"=>"1", "2"=>"3"	f	t
69	Jackson Ltd	Cupiditate vero nostrum molestiae non nobis. Dicta in rerum autem necessitatibus distinctio quas praesentium.\n\nRepudiandae corporis pariatur corporis est veritatis cumque iste. Non voluptatibus voluptas quasi fuga.\n\nFugiat tenetur omnis aliquam nemo placeat incidunt accusantium. Alias eum adipisci ducimus accusantium ipsam adipisci error. Aspernatur placeat odio facere est. Minima cupiditate ullam doloribus. Itaque placeat aperiam tempore molestiae.\n\nDebitis exercitationem placeat architecto dolorem aperiam accusantium delectus veritatis. Ipsum architecto qui porro expedita dolore. Laborum sint ullam ab voluptas eius tempore.\n\nQuasi ea architecto temporibus dolor ipsa. Voluptatibus distinctio dolore doloremque. Excepturi quas corporis delectus accusantium tenetur qui neque veniam.	12.65	\N	2018-02-24 14:34:04.602749+00	1	"1"=>"1", "2"=>"3"	f	t
72	Morales Ltd	Dolorem quam corporis culpa odit saepe. Eligendi nostrum facere eum.\n\nPossimus nulla voluptatibus ipsa asperiores architecto eligendi beatae. Quis consectetur quia maxime minus numquam ipsum. Laborum voluptas ducimus laboriosam.\n\nAb sed at dignissimos provident. Exercitationem excepturi minima et accusamus ipsam voluptatum totam. Nemo doloremque dignissimos vero saepe.\n\nQuis praesentium eveniet accusamus impedit temporibus iusto. Dolor voluptates cupiditate perferendis cumque fugiat itaque porro. Doloribus provident modi illum nihil dolor quaerat. Odio nisi vel tempora illum.\n\nAperiam beatae rerum adipisci itaque aliquam reprehenderit quis. Hic quibusdam dicta doloribus suscipit iure nobis. Aliquam impedit beatae a eum.	79.30	\N	2018-02-24 14:34:04.806869+00	2	"1"=>"1"	f	t
73	Chambers-Anderson	Sunt consequatur similique reiciendis laboriosam culpa ad sunt occaecati. Cumque soluta eligendi cupiditate itaque iusto quas libero. Iusto nostrum porro aperiam consectetur ea nihil accusantium.\n\nExercitationem adipisci consequuntur quibusdam tempora placeat velit labore. Tempore nisi alias temporibus atque. Animi illo voluptas optio quod ratione adipisci sequi. Consequuntur dicta illum nam ratione.\n\nNulla occaecati unde assumenda qui enim sunt pariatur. Dicta similique molestiae impedit sequi soluta. Accusamus deserunt molestiae ducimus.\n\nEos ab nostrum sit nobis. Aliquid earum eius vero ratione laborum veritatis vitae perferendis. Quod perspiciatis repellat enim reiciendis.\n\nDolorum nobis occaecati aut similique voluptates. Consequatur recusandae esse ipsam velit. Vero tempora quis accusamus.	33.34	\N	2018-02-24 14:34:04.83854+00	2	"1"=>"1"	f	t
112	Clay LLC	Labore fugiat eum esse non nostrum placeat adipisci. Quasi reprehenderit modi doloremque corrupti beatae ducimus nobis. Nihil quae fugiat quisquam. Provident autem nobis assumenda accusantium eaque unde.\n\nQuisquam deserunt quae saepe placeat voluptatem nesciunt perferendis. Fugiat voluptatum quis inventore.\n\nIure sapiente aspernatur officiis nisi blanditiis nam. Dolorem illo inventore impedit excepturi sapiente ipsam.\n\nVeniam voluptatem alias voluptatibus minus. Numquam laboriosam qui in aspernatur. Recusandae ut eligendi qui.\n\nEveniet totam nulla non voluptatum amet qui repellendus. Magni pariatur expedita officia quis optio soluta. Sunt saepe nam sequi debitis. Est voluptatum nostrum ab.	66.80	\N	2018-02-24 14:34:08.216744+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	t	t
74	Franklin-Cannon	Quidem modi nisi dignissimos incidunt recusandae similique laudantium hic. Nemo nihil harum quibusdam cumque enim. Aut ut temporibus excepturi quibusdam mollitia et ipsum. Optio fugit dolor ea suscipit quasi. Voluptatum quisquam cum cum maxime occaecati illo.\n\nRepellendus fuga vel sequi. Eos similique praesentium error laboriosam rerum recusandae placeat. Neque est amet in minus cum quis. Velit laudantium rem dolor animi aut accusamus soluta.\n\nIste ducimus laborum libero veniam explicabo odit. Magni unde expedita nisi dicta ipsum officia quaerat. Sed aperiam explicabo ut provident veritatis corporis voluptatibus. Expedita deserunt vero tempora veniam velit sed aut. Quam error veritatis debitis nam.\n\nReprehenderit quam reiciendis illum dolor earum nihil. Cum et iste iste fugit possimus. Sit nobis corrupti esse. In ipsa cupiditate facere alias porro commodi iste.\n\nCulpa voluptates quos occaecati sapiente. Blanditiis debitis cum laborum iure numquam illum. Voluptates voluptatum ex aspernatur sit vel culpa veniam a. Quisquam perspiciatis sit facere velit voluptatibus distinctio totam.	85.62	\N	2018-02-24 14:34:04.890246+00	2	"1"=>"1"	f	t
75	Blair-Bryant	Corrupti occaecati dolorum quibusdam praesentium. Eveniet fugiat ducimus perspiciatis officia voluptatum fugit mollitia.\n\nDeserunt possimus nobis quibusdam incidunt eaque adipisci numquam et. Officiis ab ipsam dolores nemo voluptatum libero. Necessitatibus pariatur animi maiores mollitia expedita. Voluptates magni laboriosam consectetur doloremque.\n\nConsectetur nesciunt libero nemo commodi quae possimus. Accusamus voluptates sint laboriosam nihil possimus. Quo dolorum ut ipsa ipsa atque porro odio.\n\nRerum minima laudantium exercitationem consequuntur aspernatur odit. Dolor ipsam magnam magnam quidem. Necessitatibus ratione veniam recusandae omnis.\n\nSapiente debitis dolorum nihil vel commodi expedita quae. Distinctio quibusdam doloremque velit quod suscipit.	9.10	\N	2018-02-24 14:34:04.924052+00	2	"1"=>"1"	f	t
76	Washington, Rasmussen and Humphrey	Temporibus exercitationem ratione ab. Pariatur dignissimos eos velit. Dolorem blanditiis quae non repellat tempora.\n\nQuam impedit ratione tempora corporis aliquid ipsum natus. Numquam est eum quibusdam assumenda libero quisquam quo. Illo libero sed est quae explicabo voluptatem. Ipsa iste velit dolor aspernatur blanditiis. Aliquid magnam iure consequuntur fugit debitis quod.\n\nDeserunt aperiam voluptatibus quo repellat velit. Eligendi neque cum omnis aliquam ducimus. Tempora minus ipsa beatae error numquam beatae.\n\nProvident recusandae voluptatem magni eum beatae impedit repellat. Aut iusto repellendus consectetur. Doloribus reprehenderit provident explicabo officia a laborum deleniti.\n\nVoluptatibus voluptatum fugiat asperiores iusto minus nisi quia. Corrupti eius nobis nemo quis ut esse aperiam. Corrupti delectus cupiditate ratione nemo quas nostrum.	24.56	\N	2018-02-24 14:34:04.991823+00	2	"1"=>"1"	f	t
77	Martin and Sons	Est ex mollitia quia. Neque expedita consequatur repudiandae quia voluptatem. Quasi praesentium sunt quo alias quae iusto corporis.\n\nExpedita rem eaque dolores adipisci similique fuga. Ipsa provident totam provident incidunt voluptas. In est ipsum aspernatur voluptates praesentium officiis sequi.\n\nDignissimos praesentium ratione quasi. Ipsa quisquam esse rerum quis blanditiis placeat. Commodi pariatur deleniti sit fuga.\n\nVoluptates expedita mollitia expedita voluptatem. Ipsa sint animi dolore. Ullam ad nisi quibusdam rem. Quaerat illum dignissimos enim.\n\nVel temporibus iusto eos porro veritatis inventore. Et consequuntur cupiditate quasi. Quas pariatur ratione itaque quae. Veritatis iusto dolorum alias quas numquam.	86.75	\N	2018-02-24 14:34:05.040293+00	2	"1"=>"1"	f	t
78	Williams, Stafford and Oconnor	Corporis est alias quasi ipsum voluptate. Necessitatibus maiores perspiciatis eius sit. Eveniet accusamus similique illum incidunt voluptates. Facilis possimus eum assumenda.\n\nTotam quas et esse sit omnis illo quam. Cum numquam doloremque tempora impedit mollitia impedit. Ipsa quas itaque itaque dignissimos alias distinctio.\n\nUt occaecati soluta quis neque quae architecto. Excepturi quam quidem ad explicabo. Aliquam corrupti mollitia facilis nisi.\n\nAtque fuga totam blanditiis quia occaecati. Autem magnam non porro expedita aspernatur dignissimos. Sed ab ex atque repellendus blanditiis atque optio.\n\nAutem repellendus aut placeat quis quis soluta quia. Officia consequuntur aliquid nobis. Nulla ad aperiam esse quo. Illum mollitia eaque itaque quas quis alias accusantium. Necessitatibus quibusdam laboriosam similique modi porro.	23.20	\N	2018-02-24 14:34:05.091359+00	2	"1"=>"1"	f	t
79	Taylor-Barajas	Dicta tenetur voluptatem laboriosam fuga perferendis. Tempora vel ex tenetur minus. Autem cum nemo veritatis non perferendis eius nihil perferendis. Numquam saepe consequuntur nesciunt provident blanditiis laboriosam.\n\nPossimus cum deleniti ipsum. Autem doloremque doloremque explicabo vero. Cupiditate amet ipsum amet dolor dignissimos itaque. Harum corrupti suscipit inventore laudantium illo autem.\n\nQuidem amet similique voluptatum. Amet illo atque reprehenderit non consequatur aspernatur provident quibusdam. Cupiditate quas illum culpa est alias nam. Recusandae tenetur praesentium inventore ipsam. Pariatur voluptatum nobis doloribus molestiae assumenda.\n\nAd unde qui deserunt quasi quibusdam aperiam aut. Pariatur voluptates totam adipisci vitae beatae repellendus corporis iste.\n\nMollitia quos sunt animi. Minima vel fugit inventore quam saepe molestias. Maxime vitae hic ea eveniet quod eius alias maiores. Pariatur ullam possimus nemo illum.	25.69	\N	2018-02-24 14:34:05.140649+00	2	"1"=>"1"	f	t
80	Davis, Conway and Medina	Quasi sunt iusto explicabo. Repellendus molestias debitis nihil nostrum repellat. Sunt possimus doloribus mollitia commodi culpa nulla.\n\nQuae ipsam placeat veritatis eligendi. Consequuntur reiciendis voluptate eaque non nisi quisquam temporibus vitae. Asperiores sequi molestias neque quia minus occaecati tenetur.\n\nIpsa esse perspiciatis quas odit. Dolores facere illum eveniet delectus at repudiandae explicabo quam. Quam quibusdam non ipsam placeat perferendis eum. Veritatis dignissimos vitae iure voluptates.\n\nVelit voluptatibus laborum officia quaerat magnam. Sed saepe sed inventore. Sapiente harum perferendis quisquam ipsum. Reprehenderit suscipit suscipit unde dolor consectetur ad itaque.\n\nCumque facere eligendi perspiciatis maxime quidem. Eos totam eos veniam sunt eligendi veritatis saepe pariatur. At quam eveniet ipsa ipsam laboriosam quibusdam quam quos. Itaque reprehenderit eum numquam eius.	3.92	\N	2018-02-24 14:34:05.191086+00	2	"1"=>"1"	f	t
81	Hendricks, Garner and Jackson	Vero quasi laboriosam culpa praesentium et itaque. In dignissimos corrupti accusamus. Aut adipisci accusamus corporis aliquam quasi amet veritatis.\n\nQuibusdam omnis corrupti praesentium doloremque saepe iure. Hic itaque eligendi adipisci quo nobis aut dolore. Labore soluta eveniet beatae nobis harum nihil incidunt sed. Aliquid repellendus iure nam ex iusto.\n\nDolores officia minima esse exercitationem aspernatur. Similique laboriosam cumque earum. Nulla quae voluptate ex exercitationem. Dicta et saepe molestiae voluptate.\n\nHic magni iste optio sapiente consequatur autem. Molestiae alias adipisci pariatur a. Nemo error ad voluptatem autem quod. Sunt fugit repellendus hic dolore quidem pariatur.\n\nExercitationem nostrum amet deleniti quia est. In libero omnis repudiandae possimus recusandae hic natus. Exercitationem illum veritatis laudantium.	50.62	\N	2018-02-24 14:34:05.225105+00	3	"1"=>"1", "4"=>"9"	f	t
83	Lopez-Hall	Necessitatibus eos neque debitis blanditiis voluptate. Accusantium iste nisi iusto molestiae nemo velit. Doloribus excepturi magnam velit beatae explicabo quae corrupti.\n\nOdio error officia at impedit autem nam asperiores officia. Optio quibusdam amet non. Dolorem ab dolorem atque quos amet expedita atque. Nobis impedit voluptatum architecto libero explicabo.\n\nDignissimos repudiandae perspiciatis ut laboriosam sequi explicabo. Numquam porro accusamus suscipit incidunt. Impedit tempora voluptatem vel repellat est occaecati possimus. Suscipit asperiores esse eveniet expedita quis cupiditate.\n\nOdit et nulla eveniet. Eum sapiente possimus excepturi pariatur ipsam ad rerum quos. Facere et quidem veritatis dicta mollitia.\n\nQuos quia distinctio quia sequi. Quos itaque voluptates dolore consequuntur magni eum. Delectus est non est ad voluptatum quidem.	48.20	\N	2018-02-24 14:34:05.327845+00	3	"1"=>"1", "4"=>"8"	f	t
85	Reed-Olson	Repudiandae ipsum tempora recusandae enim rerum. At corrupti itaque nobis architecto laboriosam incidunt maxime. Nihil necessitatibus aliquid pariatur delectus amet similique. Dignissimos nobis incidunt esse debitis ad consequuntur rerum nostrum.\n\nMaxime neque laborum iure voluptatibus autem cum. Molestias totam doloribus nemo inventore odio perferendis. In odio odit voluptatem distinctio.\n\nAliquid velit nulla optio in unde. Repellat delectus ab quidem culpa dolorem adipisci nam. Minus id aliquid vero.\n\nEius enim omnis quasi eveniet explicabo. Aut non reiciendis voluptatem in deleniti. Consequatur placeat ex aliquid. Nulla distinctio dolores ab id.\n\nSaepe pariatur odio itaque qui animi voluptatibus. Sequi corrupti magni labore expedita. Iusto porro ullam animi voluptatem.	38.42	\N	2018-02-24 14:34:05.445261+00	3	"1"=>"1", "4"=>"8"	f	t
86	Mills Inc	Perspiciatis quibusdam similique aperiam dolores odio ex quis. Nihil odit rerum reprehenderit accusamus.\n\nQuia error est deserunt quibusdam dolorem. Assumenda quaerat esse aliquid assumenda occaecati itaque illum minus. Facilis ipsum dignissimos et neque possimus.\n\nCum cum optio dolor numquam eos. Quod natus numquam dicta soluta voluptas. Cum doloremque necessitatibus officiis animi culpa dolorem. In et placeat rerum possimus. Repellendus laboriosam culpa doloremque vero eligendi.\n\nAssumenda asperiores fuga voluptas ex et cum in. Sunt voluptates ipsam saepe ad. Sint aliquid expedita omnis a odio.\n\nMagnam illo veritatis minus sint consequatur velit. Pariatur nobis dolore ducimus assumenda quos.	76.93	\N	2018-02-24 14:34:05.537493+00	3	"1"=>"1", "4"=>"9"	f	t
87	Moore, Mendoza and Kim	Nesciunt perspiciatis voluptates earum officiis quos. Expedita aperiam deleniti perferendis perspiciatis numquam libero dolorum. Incidunt laborum nam quaerat ab minus natus dicta.\n\nMinima non suscipit laboriosam tenetur nisi corporis. Ullam possimus laudantium iste. Perspiciatis quo ad quo natus veritatis culpa maiores.\n\nIncidunt optio aspernatur amet neque officia nam nam. Libero ex repellendus non distinctio quo at. Soluta incidunt voluptate rem error nisi et quibusdam.\n\nQuo maiores distinctio tenetur excepturi quidem. Officia hic magnam explicabo repudiandae saepe esse reprehenderit.\n\nMolestias officia debitis sed ad vitae sequi unde. Aspernatur quaerat debitis incidunt dolore veritatis. Tempore nemo doloremque alias repellat temporibus quae optio.	69.40	\N	2018-02-24 14:34:05.613846+00	3	"1"=>"1", "4"=>"9"	f	t
82	Booth-Bates	Harum assumenda veritatis amet sunt quibusdam temporibus numquam. Similique neque dolore expedita odio provident veritatis sunt ab. Molestias ducimus facilis blanditiis hic blanditiis officia.\n\nBeatae earum veritatis et quidem laudantium beatae. Nihil architecto nesciunt quis vel aliquid velit quasi. Officiis unde voluptates porro inventore soluta blanditiis nostrum praesentium. Labore consectetur sunt assumenda ipsam.\n\nBlanditiis ex aliquam illum non officia deleniti perferendis. Nemo nulla ratione esse accusantium provident repellendus earum. Minima a explicabo incidunt soluta quis cum eos. Sit sit illum minus perspiciatis soluta veritatis.\n\nHic esse non dolorem consequuntur fuga sequi beatae. Fuga recusandae eaque a. Commodi quo fuga sunt eveniet commodi esse odio. Quia voluptatibus porro minus pariatur soluta asperiores. Quam necessitatibus consequuntur deserunt officia explicabo.\n\nAb natus autem aspernatur laudantium voluptatibus cumque esse. Cupiditate iure aliquam fuga. Possimus doloribus maxime odit nihil error est odit.	22.41	\N	2018-02-24 14:34:05.275527+00	3	"1"=>"1", "4"=>"9"	t	t
89	Williams-Cohen	Officia ipsa delectus vero dolores expedita excepturi. Quo eveniet consequatur numquam repudiandae ratione praesentium. Facilis consequuntur occaecati iusto tempore suscipit et commodi. Laborum debitis corporis et quaerat culpa ex.\n\nAsperiores alias temporibus cum vitae nihil commodi. Expedita dolorem molestiae magnam a earum saepe. Magni facere quasi ipsa. Cumque exercitationem iste totam.\n\nTotam consequatur natus labore blanditiis. Voluptate cupiditate quia esse impedit non sapiente totam. Corporis quia exercitationem maiores earum quidem iure cupiditate. Ea commodi voluptatibus hic expedita ad dolore numquam.\n\nMagni commodi natus placeat pariatur eveniet. Numquam nostrum iure recusandae tempora facilis corrupti soluta. Dolor suscipit ipsam iste id. Sed reiciendis exercitationem debitis. Tempore assumenda voluptate quibusdam dicta tempora consectetur.\n\nExplicabo repellat veritatis distinctio expedita consectetur minima. Molestiae ut eius saepe nobis cumque eligendi labore deserunt. Asperiores quos quas optio omnis laboriosam. Id saepe eveniet adipisci ratione ipsum.	1.63	\N	2018-02-24 14:34:06.153512+00	3	"1"=>"1", "4"=>"8"	f	t
90	Higgins Ltd	Repellendus voluptas ullam omnis. Aut consectetur alias enim totam repellendus.\n\nA incidunt sapiente corporis nostrum accusantium. Iure rerum itaque illo quae unde quasi. Quas sequi voluptate accusamus placeat a.\n\nQuo dolorum quos modi itaque voluptas ipsum nemo. At tempora perspiciatis maxime eligendi impedit unde. Modi dolorum laboriosam nihil perspiciatis.\n\nNesciunt culpa cumque optio voluptas. Nesciunt magni incidunt corrupti necessitatibus laborum quis fuga. Suscipit perferendis consequuntur hic excepturi dolor consectetur dolores. Iste temporibus in placeat enim ratione temporibus.\n\nEaque ratione magnam fugiat perferendis ullam. Alias natus tenetur fuga. Possimus quos vel nisi beatae.	50.89	\N	2018-02-24 14:34:06.250433+00	3	"1"=>"1", "4"=>"9"	f	t
91	Martin PLC	Tempore fuga excepturi voluptatibus beatae similique quis quia ipsam. Culpa corrupti maxime molestiae cupiditate iure sit. Molestiae ea porro ratione eligendi. Consectetur iste adipisci pariatur iusto sunt. Iure consequuntur optio itaque tempore quaerat.\n\nConsequuntur odio deleniti minima. Consectetur voluptate labore labore. Eligendi quam quasi possimus impedit. Repellendus in tenetur quam saepe molestiae quaerat.\n\nVoluptas eaque nihil est repudiandae. Ullam vel id facere placeat. Voluptate praesentium fuga est sit accusantium vel.\n\nSed nemo sequi doloremque nulla pariatur cupiditate alias. Quasi voluptas sed nulla deleniti in molestias. Voluptatibus neque eaque placeat provident placeat autem. Ipsum quidem labore ratione laudantium asperiores earum esse aspernatur.\n\nIllum accusamus deserunt quis placeat architecto omnis minima. Debitis nam ipsa quis expedita. Dicta nam assumenda tenetur eligendi ad.	80.96	\N	2018-02-24 14:34:06.352853+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
92	Jackson-Mason	Iure id dolorem suscipit dicta sint fugit harum. Quisquam maxime maiores consequatur iure laborum. Commodi eos magnam provident repudiandae quisquam.\n\nAliquam asperiores et est tempore dolorum tempora libero. Officia id laborum cupiditate quasi. Ipsa cum veritatis consequatur blanditiis.\n\nRem incidunt ducimus exercitationem laboriosam ipsum natus unde. Iure at quam praesentium accusantium nam. Fugiat neque placeat laborum doloribus velit.\n\nEos magni minus velit modi ex. Quibusdam architecto odit debitis. Perferendis officia nostrum rerum harum laboriosam aliquam.\n\nNumquam est pariatur maiores voluptas necessitatibus perferendis. Optio earum ab culpa animi. Dolorem cupiditate necessitatibus tempore placeat beatae.	27.41	\N	2018-02-24 14:34:06.469811+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
93	Martin, Vega and Hamilton	Recusandae ad repudiandae nihil iure suscipit quo voluptatibus. Veniam quia sed omnis ut autem recusandae sapiente voluptatem.\n\nVitae et molestiae magnam iste. Praesentium neque ipsum dolor quos. Nemo aut commodi commodi deleniti libero ipsa. Possimus laboriosam molestias eos tempore.\n\nIure quod tenetur voluptatibus perspiciatis alias. Officia eligendi quos voluptatem debitis laudantium sint vero perferendis.\n\nQuia dolorem error assumenda totam. Reprehenderit laboriosam atque fuga vitae eum illo. Iure officia id eveniet distinctio aperiam quis. Assumenda quae corporis doloribus officiis.\n\nConsequuntur deleniti sit odio atque. Suscipit modi in libero eaque. Architecto sunt corrupti assumenda ullam sit quis vitae inventore. Ipsam ab nisi expedita placeat modi adipisci vero.	30.41	\N	2018-02-24 14:34:06.538245+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
94	Moore, Larsen and Black	Nostrum itaque rerum tempore voluptate veritatis. Reprehenderit qui exercitationem assumenda placeat. Dignissimos quasi ab possimus quo placeat repellat.\n\nAspernatur consequuntur odio quibusdam iure. Aut possimus a ad iusto aut. A non repellat nihil quas perferendis reprehenderit non. Repudiandae libero voluptas inventore error voluptatibus quia pariatur.\n\nFugit quod saepe numquam corporis natus totam incidunt. Voluptatibus impedit eos facilis accusamus. Adipisci eius exercitationem vitae deleniti sunt id et.\n\nEos itaque vel doloribus facilis quasi consequatur aut aperiam. Vel sapiente accusantium enim eius accusantium reiciendis. Ad architecto nihil veritatis veritatis earum eum.\n\nIn quo consectetur mollitia beatae atque officiis. In ducimus eveniet perferendis. Quasi omnis sed repellat nobis odio asperiores.	44.23	\N	2018-02-24 14:34:06.606188+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
95	Kramer, Brock and Hernandez	Magni quibusdam aut aspernatur cumque placeat dolorem aspernatur veritatis. Sunt laudantium repudiandae porro reiciendis. Nostrum recusandae ad maiores sint explicabo.\n\nPariatur aut odio porro aperiam quasi debitis. Dolores modi itaque cumque adipisci vel. Similique unde totam eveniet nam. Pariatur nostrum pariatur ea consequatur ullam nesciunt perspiciatis. Consectetur quae distinctio praesentium perspiciatis tenetur doloribus est libero.\n\nBeatae unde ratione sequi nobis pariatur excepturi. Iure dicta dolor excepturi voluptatibus asperiores sunt. Provident omnis dolore modi occaecati consequuntur commodi iste.\n\nBlanditiis dolor voluptatem cupiditate quidem delectus exercitationem. Laudantium rerum similique reprehenderit laborum. Ipsum repellat iusto doloremque tempora.\n\nAut rerum animi aperiam facere laborum aut. Quam nam quisquam alias sint fugiat. Est explicabo expedita sequi soluta repudiandae sit aspernatur.	90.50	\N	2018-02-24 14:34:06.688167+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
97	Duarte, Cruz and Villegas	Unde aut a at similique quia rem repellendus. Voluptatem temporibus pariatur exercitationem totam aliquid. Ad aut occaecati dolor iusto at ut natus dicta.\n\nSaepe laudantium at pariatur quaerat repellendus. Suscipit labore placeat tempora voluptate debitis earum consectetur. Qui necessitatibus alias officiis eaque maiores minima autem blanditiis.\n\nDoloremque repellendus architecto fugit nulla similique. Minus dolorum dolore assumenda esse totam. Ipsam qui occaecati ipsam. Provident similique vero ex officia modi explicabo voluptatem. Fuga consequatur laboriosam quia quam quia optio odio impedit.\n\nMolestias dicta repudiandae omnis delectus nostrum quas magnam. Est minima labore sapiente in nam. Dolore hic atque minima sapiente expedita laboriosam placeat odit.\n\nLaborum cum nihil commodi nesciunt. Laboriosam nam nesciunt aliquid officiis quos quod vel et. Corrupti adipisci nulla earum. In culpa fugiat commodi porro assumenda tenetur id asperiores.	11.19	\N	2018-02-24 14:34:06.860407+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
98	Flores LLC	Recusandae ducimus accusantium reprehenderit a numquam perspiciatis iste. Temporibus dignissimos aliquid sequi qui amet ad. Culpa aliquid quam blanditiis temporibus sed.\n\nAd earum omnis at placeat impedit porro. Ut officiis reprehenderit iusto eius. Laborum reiciendis quam nesciunt consequuntur. Dolores reiciendis consectetur sunt ullam.\n\nAb neque enim quia illo quibusdam dolorum. Asperiores accusamus ea nemo quos ratione. Odio voluptas sequi quam similique debitis illo labore. Atque mollitia unde voluptates illum maxime.\n\nHarum ipsa molestias corporis distinctio quisquam quis molestiae. Alias culpa dolore vitae. Excepturi magni libero cupiditate. Tempore iste inventore eaque magnam.\n\nIllum excepturi eligendi vel iure. Blanditiis fugit consectetur eum tempore velit vel. Maiores alias porro qui perspiciatis aperiam. Reiciendis temporibus aliquam et dolore quas.	94.71	\N	2018-02-24 14:34:06.929726+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
100	Contreras PLC	Voluptate aliquam nobis possimus iste delectus. Numquam deleniti laborum porro molestiae neque sapiente. Repellendus voluptatum ullam occaecati. Tempora nam repellat consectetur ducimus perspiciatis quod enim placeat.\n\nDeleniti consequuntur laborum commodi earum sequi vitae. Facilis minus magnam mollitia optio exercitationem dolor in in. Laudantium doloremque eveniet voluptate ratione quidem commodi.\n\nCupiditate debitis iste perspiciatis. Excepturi id laudantium earum ipsam. Quod quas nostrum at eius.\n\nLaudantium amet perspiciatis facere incidunt labore. At unde recusandae hic nemo. Aperiam eaque maxime sunt mollitia quis aperiam reiciendis tempora.\n\nCommodi ipsum repellat saepe ut ut praesentium optio. Doloribus odio facilis recusandae. Iste maiores incidunt a quisquam nemo.	30.40	\N	2018-02-24 14:34:07.065739+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
101	Jones, Wu and Wagner	Quo est optio laudantium vel ratione. Accusamus debitis ex et aperiam animi laboriosam. Possimus debitis maiores accusamus soluta.\n\nIure necessitatibus veritatis accusantium tenetur culpa facere. Optio mollitia quis necessitatibus dicta. Ratione repudiandae expedita optio cum nemo doloribus.\n\nExplicabo modi dignissimos nesciunt laborum ducimus quasi dolorem. In assumenda optio sapiente beatae.\n\nAnimi ipsum numquam dolores voluptates nemo adipisci fuga perspiciatis. Distinctio accusantium molestias eaque quae. Soluta laborum blanditiis officia officia adipisci. Repudiandae consequatur est et quaerat.\n\nModi provident repellendus beatae id ipsa ex facilis. Saepe sapiente officiis nostrum porro dolore repellat veniam. Quia ea sapiente dignissimos beatae ullam. Beatae at cupiditate aliquam in recusandae corporis.	30.60	\N	2018-02-24 14:34:07.136676+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
102	Schwartz, Key and Leon	Dolorum facere praesentium dolores iure error. Inventore dicta culpa ab tenetur ipsam id doloribus. Deleniti dignissimos veritatis quod quod iste. Cum pariatur vel doloremque in sequi.\n\nExplicabo autem culpa laborum reiciendis quis voluptas. Aliquid laudantium officia at quos. Neque ipsam odit similique rem perspiciatis.\n\nExpedita qui optio soluta sint culpa blanditiis aperiam. Ratione illo sed eveniet nesciunt accusantium esse. Totam consequuntur error ducimus mollitia veniam. Laudantium commodi saepe ducimus.\n\nDolor vel est velit corporis cupiditate incidunt dicta. Molestias odio culpa ducimus voluptate impedit. Non veniam fugiat nulla magnam provident optio hic. Sunt porro necessitatibus alias nulla.\n\nA fugiat tempore ratione accusamus earum. Excepturi harum eveniet sapiente ipsam sint. Aspernatur beatae ipsum aut omnis quidem. Qui nam alias facere commodi minima.	10.65	\N	2018-02-24 14:34:07.199535+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
103	Wood, Leonard and Edwards	Fugit dolor aut laudantium amet dolore temporibus. Nostrum eveniet vitae illo repellat. Quia quod blanditiis fugiat doloremque.\n\nEum dolorem vero nesciunt dicta. Nostrum impedit sapiente dignissimos iste earum aperiam fugit. Enim ea quis quisquam mollitia a.\n\nLaudantium quisquam consequuntur laborum ad officia laudantium vel. Excepturi aliquam facere quod soluta vel totam.\n\nVoluptatibus iure consectetur commodi non id. Autem saepe excepturi veniam molestias. Incidunt quis numquam voluptas. Praesentium sequi placeat quisquam commodi.\n\nIllum hic perferendis repudiandae vitae ab. Consectetur minima quos ipsa rem totam unde impedit. Saepe fuga magni beatae veritatis ullam dolorem. Excepturi odio ipsa repellat error quibusdam.	79.84	\N	2018-02-24 14:34:07.251751+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
99	Marshall PLC	Minima placeat neque consequuntur. Fugit sunt maiores quam mollitia ipsum laboriosam. Saepe eius esse nemo aut vero ipsum corporis. Suscipit quod iure qui recusandae consequatur laboriosam.\n\nLabore tempora maiores qui reprehenderit perferendis neque modi animi. Natus alias et earum necessitatibus aperiam. Temporibus distinctio sit aliquid. Similique cupiditate rem assumenda.\n\nQuibusdam ducimus fuga vero temporibus tenetur. Sed tempore iusto expedita dolorem iure quam. Sequi dolore culpa provident ea nulla. Occaecati fuga praesentium consequuntur repellendus commodi nesciunt.\n\nLaudantium perferendis optio voluptates necessitatibus. Expedita eius doloribus cum cupiditate atque. Modi quasi ipsam vero odio molestiae qui voluptatibus ut. Mollitia rem perferendis repellat fugiat maiores saepe. Nostrum ipsum excepturi debitis molestiae tempora.\n\nIusto quam quod doloribus quisquam. Quaerat id doloribus officia. Corrupti quia error earum animi.	47.48	\N	2018-02-24 14:34:06.999085+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	t	t
104	Mayer, Hutchinson and Olson	Quidem debitis aliquam ut ullam sed incidunt. Beatae cum asperiores delectus eius commodi perspiciatis labore. Ratione quod laborum autem laudantium deserunt sint. Dolorum aut perspiciatis rerum aliquid exercitationem.\n\nMolestias tenetur ex id placeat voluptate beatae. Eius perferendis ullam occaecati doloremque culpa. Commodi error hic perferendis.\n\nCumque inventore perferendis explicabo ea ratione mollitia voluptas. Aperiam commodi quo perferendis ipsum ea ad ipsam rem. Atque velit tempora nulla fugiat quos magnam vitae. Delectus possimus consequatur animi repellendus a voluptas quam. Eligendi delectus officia sunt inventore.\n\nAmet dolorum illum totam deserunt doloribus. Nemo unde blanditiis error nam molestiae.\n\nQuod sit sit omnis iure vero esse unde. Quis aliquid doloremque sapiente recusandae impedit voluptatum. Distinctio itaque sint architecto fugit at accusamus est. Consequuntur eligendi amet placeat explicabo dolor.	92.21	\N	2018-02-24 14:34:07.341379+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
105	Rhodes, Farmer and Myers	Laudantium commodi beatae ipsum vel repellat quis perspiciatis. Voluptatum maxime quam eligendi autem numquam. Ipsum veniam placeat esse totam vero ab. Consectetur vitae maiores quo qui.\n\nAsperiores recusandae blanditiis dicta eaque similique repellendus modi. Quibusdam in sed ratione quod incidunt dolore iste sed. Repudiandae recusandae molestias commodi facilis.\n\nExcepturi quam dolores voluptatum ipsum tenetur eos. Id unde soluta assumenda aspernatur. Dolorum illum accusantium quae sequi.\n\nBeatae corporis labore nostrum veniam esse temporibus tempore. Quidem placeat totam numquam ratione.\n\nIpsam eveniet maxime corrupti cum a nisi. Cum iste maxime pariatur commodi delectus. Suscipit debitis ut reiciendis libero nisi tempora.	62.30	\N	2018-02-24 14:34:07.395338+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
106	Weber Ltd	Corporis quaerat nulla cumque inventore. Optio similique in tempore voluptas animi dignissimos laudantium at. Autem voluptatibus voluptate a. Id recusandae sunt deserunt assumenda amet.\n\nLaboriosam quod id explicabo. Nobis molestiae minima voluptates placeat magnam facere. Corporis aperiam dolores quos nostrum voluptas aperiam similique.\n\nAliquam voluptas nemo unde nisi hic ullam quibusdam sit. Necessitatibus mollitia quis quos molestiae ipsam. Recusandae non neque delectus ipsum. Natus suscipit mollitia quibusdam autem maiores animi fugit.\n\nQuidem magnam impedit aspernatur culpa enim dolore. Voluptatem commodi facilis reprehenderit illum doloremque harum. Eaque incidunt debitis dicta. Voluptatibus cum necessitatibus facilis natus exercitationem at fuga.\n\nVel autem eligendi nam maiores iste. Vitae deserunt magnam libero ad. Exercitationem laborum deserunt repudiandae ipsam magnam. Dicta molestias voluptate laborum dignissimos dolorem doloremque pariatur. Fuga voluptatum voluptas quod culpa sit.	56.65	\N	2018-02-24 14:34:07.512543+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
107	Torres, Barajas and Scott	Voluptate consequuntur praesentium nesciunt saepe ut. Veritatis nisi accusantium reprehenderit ea similique.\n\nMolestias perspiciatis ab explicabo dolor nulla numquam non. Magni numquam qui autem a nesciunt dolorum possimus ex. Distinctio sunt itaque tenetur quis quidem quaerat occaecati. Accusamus quidem quidem consequuntur voluptatem reprehenderit. Animi cupiditate possimus ducimus perferendis laudantium vero quo.\n\nExplicabo eius voluptates impedit perferendis animi error. Quidem facere itaque ab illum accusantium aliquid eius. Ipsa quod libero distinctio reiciendis.\n\nDolore adipisci tenetur error aspernatur a quo. Unde officia hic officia sapiente. Perferendis est velit minima minima sequi dolores eum sed. Quas labore cupiditate iure ratione consequuntur quidem neque.\n\nDeserunt quia aut amet placeat deleniti provident totam. Culpa quia hic eius tenetur ut non. Vitae iste dolor provident rerum.	68.78	\N	2018-02-24 14:34:07.844443+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
108	Acevedo, Castillo and Lopez	Exercitationem rem ipsa quae culpa qui. Necessitatibus possimus pariatur distinctio quod minus.\n\nOmnis facere possimus veniam officia. Corrupti dolores veniam nemo illum fugiat quibusdam. Temporibus nostrum distinctio soluta ipsam.\n\nIure itaque eaque expedita labore. Distinctio expedita laboriosam minus est. Fuga mollitia placeat commodi voluptatum nemo. Vel assumenda qui ab eius explicabo praesentium repellendus.\n\nEum cumque voluptate dolores totam assumenda. Numquam numquam ab perspiciatis totam inventore cum quia. Dicta maiores aliquam fugit possimus cumque excepturi.\n\nDolorum optio dolorem laborum eligendi culpa deserunt repellendus et. Saepe exercitationem recusandae sit at delectus.	64.53	\N	2018-02-24 14:34:07.998518+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
109	Simon PLC	Eius ullam eaque modi amet eius. Eligendi sequi debitis culpa nam reprehenderit aspernatur vel.\n\nModi iste esse neque aliquam ipsam voluptatem assumenda. Quaerat qui necessitatibus deserunt ullam. Amet saepe tempore cum soluta. Dolore quod ipsum non corporis.\n\nRatione consequuntur architecto consequatur soluta assumenda hic vero aspernatur. Culpa at officia corporis cum similique. Molestias ratione exercitationem nam placeat iste.\n\nRem ab dolores facilis aliquam animi. Totam ea in saepe nisi. Mollitia labore quo maiores quis non. Ducimus ipsa ut sunt aperiam totam voluptatibus.\n\nEarum molestiae ex explicabo sapiente. Ducimus adipisci est non est tempora corporis mollitia doloremque. Consequatur vero voluptatem rerum optio.	0.20	\N	2018-02-24 14:34:08.070582+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
110	Carson, Saunders and Guerrero	Sunt voluptates nulla omnis possimus earum illum nam blanditiis. Laboriosam earum facilis veritatis assumenda dolor quae. Ducimus ratione tempora sequi. Ratione vitae ullam hic aliquid quis assumenda.\n\nSapiente nemo praesentium quaerat nisi necessitatibus. Neque maiores cum soluta dignissimos voluptatum minus. Quam asperiores necessitatibus expedita occaecati a sed. Sapiente molestias magni nesciunt est aperiam in eos.\n\nVoluptatem dolorem quas minus rem. Ut perspiciatis earum placeat nemo. Repudiandae esse eum adipisci voluptate. Libero amet suscipit dolorum dolorem porro.\n\nConsectetur reiciendis veritatis quis officia nemo asperiores. Maxime ducimus distinctio error amet corrupti delectus. Commodi officiis illum vero.\n\nDistinctio quod officia ea. Nihil soluta aperiam iste dolorum. Labore incidunt voluptatum veritatis aut harum numquam error.	86.75	\N	2018-02-24 14:34:08.122524+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
113	Todd and Sons	Architecto dolor ad rerum a. Accusantium quis architecto architecto nam quasi. Dolorem nostrum at corporis.\n\nDignissimos veniam vitae occaecati nulla pariatur harum. Perspiciatis temporibus aut sapiente ducimus labore. Quam aut optio earum cum hic. Unde consectetur officiis consequatur repellat. Blanditiis quibusdam doloremque error similique eligendi.\n\nEx iste perspiciatis exercitationem doloremque fugiat. Aliquid impedit modi sapiente tenetur fuga iure culpa. A sint reprehenderit iste dicta quam libero et.\n\nAdipisci inventore dolor architecto eveniet. Molestiae itaque quisquam commodi fugiat culpa modi deserunt. Perspiciatis magnam eveniet facilis hic molestiae itaque.\n\nAsperiores incidunt et perferendis fugiat qui ullam. Ipsa perferendis velit architecto corrupti odio accusamus nisi qui.	65.54	\N	2018-02-24 14:34:08.315519+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
114	Jackson Inc	Corporis debitis quasi sint corporis tempore accusamus. Nobis omnis nihil odit dolores optio tenetur. In inventore cupiditate beatae quia.\n\nEx vero quisquam vitae natus. Totam reprehenderit nobis rem voluptate reiciendis. Voluptatibus eius nostrum hic earum fuga iusto. Molestias quasi animi minus unde sit.\n\nUllam dicta nam sapiente pariatur. Unde illo a vitae expedita. Quasi maiores dicta quidem maiores qui iusto quidem officiis. Architecto rerum enim ratione voluptatum tenetur.\n\nConsectetur quo dolore at earum facere. Dolor corporis expedita minima amet.\n\nSoluta aspernatur sed maxime dicta possimus minima. Nisi aspernatur modi veritatis omnis. Minus repudiandae molestias magnam cum totam. Ducimus eveniet unde magni sunt nisi. Ipsum culpa commodi officiis dicta.	86.79	\N	2018-02-24 14:34:08.383365+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
115	Johnson and Sons	Sequi dolores molestiae minima. Est voluptatibus doloribus eaque molestias.\n\nVelit ut labore laudantium expedita laboriosam assumenda. A impedit beatae rem natus optio. Odit mollitia saepe mollitia temporibus.\n\nLaboriosam facilis id incidunt dolor. Suscipit unde reiciendis consectetur. Optio tempore magnam eum consequatur incidunt. Ducimus corporis tempore dicta accusantium quasi explicabo necessitatibus.\n\nOmnis similique qui sunt vero recusandae. Blanditiis voluptates placeat odio quasi possimus esse. Occaecati soluta aperiam recusandae repellendus. Nostrum saepe suscipit sequi sunt delectus delectus dolor. Eum maiores quam quas a rerum.\n\nAut consequuntur aliquid sint similique aut dolore dolorem. Dolore consequatur eaque officiis dolorum nisi. Occaecati quis provident doloremque. Voluptatem repellendus molestias quia odio.	55.90	\N	2018-02-24 14:34:08.423895+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
116	Suarez and Sons	Minus adipisci illum tempore laborum. Blanditiis voluptatem suscipit iusto voluptatem corrupti et ut. Itaque dolorum ducimus ducimus et dicta.\n\nSed dolore assumenda odio delectus dignissimos. Cum molestiae adipisci molestias perspiciatis animi necessitatibus sapiente qui. Ducimus nulla corrupti qui ipsum amet.\n\nRepudiandae animi adipisci rerum optio dolorem reprehenderit sapiente. Illo veniam aut voluptate sint animi beatae. Accusamus similique totam iusto nisi. Adipisci nam numquam reprehenderit minima.\n\nDolore perferendis vel quidem blanditiis numquam rerum veritatis magni. Cum occaecati natus totam laborum. Quae debitis sed necessitatibus unde. Cupiditate cum eum minus voluptatum minus.\n\nSit fuga aliquid delectus esse quasi eaque. Ullam perferendis debitis mollitia vero. Dolore nam nihil provident corrupti.	89.70	\N	2018-02-24 14:34:08.50876+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
117	Moore-Todd	Deserunt eum velit quod quod autem. Accusamus ullam culpa itaque nihil molestias.\n\nPerferendis corporis vel qui consequatur iste magni. Rerum iusto amet eos beatae facere. Fugiat ipsam qui ducimus voluptatum dicta aperiam. Voluptas eveniet numquam quo sint cum nihil non. Deleniti voluptatem quo delectus dolore iure doloribus eveniet.\n\nPorro earum illum cupiditate fuga ab beatae perspiciatis quae. Impedit harum alias libero error libero doloremque. Ullam saepe fuga consequuntur officia. Aperiam tenetur dolores delectus ducimus ducimus.\n\nCommodi vero impedit non adipisci veniam. Asperiores facere tempora vel dolore. Nihil ex commodi ducimus vel nihil.\n\nSit saepe repudiandae fugiat odit et. Culpa architecto voluptas ex optio deserunt. Aliquid mollitia inventore expedita dolorem ex explicabo. Dolor asperiores culpa voluptatibus ratione. Voluptatem incidunt delectus asperiores inventore.	98.40	\N	2018-02-24 14:34:08.570928+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
118	Johnson and Sons	Facilis doloribus quae alias sit accusamus. Neque unde repudiandae consectetur tempore. Possimus eius rem harum ad.\n\nUt vel aspernatur distinctio quo. In facilis esse quo provident. Eligendi id tenetur tempore perferendis commodi minima dolores nostrum.\n\nIllo odit quis rem totam est. Ut dolores earum vero. Voluptas harum libero ullam molestiae.\n\nPorro pariatur voluptates occaecati pariatur error itaque. Sequi officiis ullam eaque maiores labore. Adipisci molestias ducimus dicta quos aperiam.\n\nHarum fugiat atque sit rerum. Asperiores ad sequi debitis earum earum minus. Cupiditate molestias voluptate reiciendis repellendus.	20.61	\N	2018-02-24 14:34:08.693015+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
44	Stanton-Mathews	Aperiam maiores beatae quibusdam ab doloremque. Quasi odit architecto cum deleniti modi molestiae voluptatem. Consequuntur quisquam blanditiis neque.\n\nEligendi maiores et soluta veniam. Quas quasi magni aperiam dignissimos iste nam. Architecto libero officiis fugiat pariatur. Ut recusandae occaecati quo veniam quidem et temporibus.\n\nNam est necessitatibus deserunt suscipit alias. Incidunt alias sint veniam est. Ipsa occaecati qui nihil in voluptatem. Reprehenderit vel delectus doloremque eligendi.\n\nIpsam iure repellat magni. Iste architecto necessitatibus quo unde. Ipsa assumenda expedita libero vitae quibusdam eligendi dolores.\n\nFugit aliquam neque ipsum odit. Sint ipsam soluta architecto dolor quia corporis. Cumque fugit doloribus nihil.	73.50	\N	2018-02-22 10:00:36.009417+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	t	t
119	Thompson-Glass	Vitae ex iure omnis quaerat. Soluta amet mollitia ipsa odit. Nostrum nemo natus autem quidem debitis eius.\n\nAccusantium vero atque non quae inventore reiciendis. Cum illum sequi aperiam est. At quasi quae asperiores magni laborum temporibus. Odit necessitatibus ducimus laborum quibusdam vitae ratione ullam.\n\nSed sit magni necessitatibus dignissimos sed. Doloremque tempore reprehenderit necessitatibus consequatur vel iure. Tenetur iste veritatis excepturi natus error accusantium consequatur. Neque recusandae saepe porro labore laudantium quidem voluptatum.\n\nEarum unde officiis velit iste. Quos blanditiis dolore magnam incidunt quia repellat. Aut accusantium cupiditate alias nemo odit quos quia. Quas hic consequuntur occaecati quia ea sapiente at.\n\nSimilique pariatur magni excepturi autem. Illo ducimus porro sunt ipsam facilis commodi. In animi vero voluptatem nulla nemo.	68.63	\N	2018-02-24 14:34:08.771807+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
120	Rhodes-Rowland	Veritatis blanditiis corporis rerum natus assumenda quae eaque. Assumenda vero dolorem consequuntur nostrum occaecati quis molestias. In veniam cupiditate rerum.\n\nOfficia maiores placeat voluptates magnam tempora eligendi. Enim mollitia impedit incidunt. Veniam reprehenderit molestiae deserunt quis.\n\nIpsum assumenda eos necessitatibus repudiandae labore. Veritatis enim maxime nobis. Et accusamus cupiditate modi vel iste. Consectetur blanditiis laborum iste delectus rerum.\n\nDelectus architecto maiores impedit impedit vitae neque quam alias. Nemo animi nam magni quod recusandae possimus. Explicabo dolores delectus quidem nihil eos quasi officia neque. Ipsa maiores incidunt soluta odio consequuntur alias blanditiis.\n\nQuidem doloremque numquam adipisci mollitia. Accusantium provident ipsam alias ab impedit reiciendis. Quidem id quas quis deleniti fuga dolorem commodi. Cumque nobis reprehenderit tempora sint magnam.	77.83	\N	2018-02-24 14:34:08.811314+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
31	Andrews, Richards and Garrett	Fugiat voluptate porro deleniti similique explicabo. Labore similique sequi ipsam illum assumenda culpa. Dicta cum aliquid beatae dolor.\n\nInventore corporis ea dolore mollitia molestiae. Fuga ipsa ducimus sit minus placeat. Iste recusandae nam alias autem. Ipsum rem iusto quo doloremque esse non.\n\nPerferendis corrupti quae cumque odio debitis quidem facere. Aspernatur rem doloribus quas quidem blanditiis aliquid ut minima. Voluptas mollitia unde similique doloremque aut. Eveniet officia doloremque dicta maiores impedit.\n\nItaque corrupti facilis molestias blanditiis voluptate accusamus ipsum. Dignissimos adipisci dicta eum praesentium. Quidem esse nisi accusamus impedit.\n\nAb cum fugiat facilis quis atque asperiores. Quasi deserunt voluptate quo nihil vitae accusantium nulla perspiciatis. A nobis quos incidunt ad.	8.42	\N	2018-02-22 10:00:35.169722+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	t	t
33	Johnston-Rodriguez	Autem magnam expedita totam quod eos quibusdam qui eaque. Animi mollitia facilis fuga at. Consequatur consequuntur dolorum similique. Ex ad veritatis est.\n\nReprehenderit repellendus laborum aperiam placeat cum. Deserunt ullam molestiae a saepe. Repellat ullam praesentium in nulla quam quidem voluptatibus. Illo placeat saepe vel provident consectetur itaque.\n\nHic dicta deleniti delectus tempore beatae quo. Expedita cum cupiditate asperiores magnam veritatis. Eius similique minus rem. Ducimus porro laudantium ut atque fugiat dignissimos.\n\nRatione et quis dicta ipsam eveniet quia incidunt. Sunt excepturi similique sit porro qui aspernatur in.\n\nReiciendis molestiae cumque iure sapiente earum a. Sit quam deleniti eligendi dolores vero quibusdam. Sint provident necessitatibus nostrum velit amet. Necessitatibus in vitae ratione repellendus.	13.74	\N	2018-02-22 10:00:35.316572+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	t	t
38	Craig-Clements	Quidem tenetur quaerat tenetur dolor consequuntur porro ipsam. Consectetur nostrum alias et.\n\nAt cupiditate sequi commodi nam pariatur quas incidunt. Quas exercitationem veniam omnis architecto. Maiores distinctio quas laudantium ea mollitia suscipit.\n\nAnimi commodi odio harum facilis nesciunt ipsam officiis. Id vel fugiat voluptate nostrum alias ab. Veritatis molestiae aliquid minus eius porro.\n\nSimilique cupiditate laboriosam debitis sed quo quae dolorem. Repellat ratione laboriosam hic ratione. Fugit laudantium harum beatae inventore ullam.\n\nSed sunt in mollitia ipsum blanditiis. Molestias a iste saepe voluptates amet reiciendis consequuntur. Eaque assumenda quisquam cumque fugiat vel temporibus. Harum nihil quaerat dolorem quas.	77.42	\N	2018-02-22 10:00:35.639519+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	t	t
27	Montes, Terry and Johnson	Delectus tenetur modi quae dolorem amet voluptates aperiam. Accusamus fugit nostrum laudantium deserunt exercitationem. Maiores fugit impedit aspernatur adipisci. Pariatur rem dolores delectus reprehenderit et repellat.\n\nSuscipit temporibus similique numquam inventore. Reiciendis dolorem deserunt porro possimus illum quasi. Soluta totam qui nemo rem esse dolores. In eius laudantium nam qui natus ab qui quasi.\n\nDebitis cum reiciendis tenetur laboriosam. Labore assumenda tenetur recusandae aliquid sint omnis.\n\nDicta vero est eos maiores. Est quas occaecati veniam necessitatibus assumenda inventore ut. Tempora quibusdam voluptas distinctio nam eos vero commodi voluptate.\n\nFugit eaque at provident iusto laudantium. A similique unde reiciendis saepe quasi. Saepe praesentium necessitatibus temporibus doloremque dolorum provident excepturi amet.	74.71	\N	2018-02-22 10:00:34.95093+00	3	"1"=>"1", "4"=>"9"	t	t
45	Berg, Horton and Bennett	Saepe officia sequi doloremque ipsum optio dignissimos nemo. Odit distinctio a quod expedita. Qui saepe nisi eaque quis dolor.\n\nEst pariatur amet accusamus ipsa iure. Quam iure quibusdam odio veritatis officiis. Architecto atque eligendi quibusdam atque. Cum itaque sunt blanditiis illo iusto ipsa distinctio.\n\nExplicabo dolore sunt dolor voluptas debitis odit at. Quis quibusdam culpa perferendis quae deleniti praesentium. Nemo commodi ducimus quia voluptatum tempora.\n\nEos iste enim maxime natus eaque non. Quos omnis neque excepturi iste. Corrupti non quibusdam dolorum nihil earum iure.\n\nPraesentium maxime sequi fuga suscipit fuga veniam harum quaerat. Voluptatibus excepturi eos exercitationem sed nemo deserunt at. Debitis adipisci a voluptatum accusantium accusantium. Dolore consequuntur nostrum et necessitatibus.	53.61	\N	2018-02-22 10:00:36.066405+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	t	t
61	Lopez Group	Molestiae optio officia nihil blanditiis. Quisquam provident odio illo suscipit itaque accusamus. Quia veniam vel non dolorum. Tenetur magni eum amet quod velit perferendis ad eius.\n\nHic corrupti nobis deleniti eum. Repudiandae aut corporis voluptatem quod sint officia enim. Perferendis voluptatem commodi quod.\n\nSit iste assumenda nemo ullam repudiandae. Tempore facere vero eius optio harum ipsum temporibus quibusdam. Animi reiciendis ut architecto excepturi amet eum unde.\n\nEa ad at eaque earum in. Cum non rem dicta sed ullam deserunt. Facilis sapiente ipsam ducimus. Dolorem libero eos temporibus officia numquam.\n\nNihil dolorem accusamus ipsum dolorem eligendi. Explicabo quasi quaerat ex assumenda maiores eos inventore provident. Magni incidunt facilis placeat ipsam. Illo voluptates deleniti dolor mollitia maiores debitis saepe.	1.16	\N	2018-02-24 14:34:04.031243+00	1	"1"=>"1", "2"=>"2"	t	t
84	Durham Group	Omnis ipsa perspiciatis rerum magnam omnis suscipit. Nobis corporis ad saepe doloribus sapiente excepturi. Repellendus esse illum nulla aliquid quaerat quis cumque.\n\nRerum cumque quo eligendi voluptatum at repudiandae quisquam quo. Quos possimus exercitationem repellendus asperiores corporis voluptatem voluptatum. Possimus molestiae nisi cupiditate fugit. Beatae ad cumque repellendus.\n\nQuis nostrum voluptatibus aperiam recusandae explicabo sequi sequi. Recusandae at magnam qui earum sit. Ex veritatis vero itaque accusamus.\n\nExplicabo nesciunt earum sequi. Qui unde vero omnis optio. Soluta fugit sapiente voluptatem placeat nesciunt.\n\nIpsa doloribus sequi ratione. Qui sunt facere reprehenderit dolorum minus asperiores quo. Iusto necessitatibus vitae fugiat adipisci fuga dicta numquam est.	15.61	\N	2018-02-24 14:34:05.39084+00	3	"1"=>"1", "4"=>"8"	t	t
121	Hill-Jones	Magnam quidem doloribus explicabo ab possimus. Autem officiis temporibus magnam ab. Consequatur velit placeat veniam quasi illo fuga mollitia.\n\nRepellendus id consequuntur vitae praesentium cupiditate error cupiditate. At molestias iste sed velit aut accusantium iusto. Veniam adipisci modi quod sed eveniet beatae iure maiores. Laudantium deleniti pariatur distinctio numquam in dolor.\n\nAdipisci impedit corporis dolorem. Saepe nostrum id modi similique. Qui alias hic dolor laudantium reiciendis totam suscipit. Sequi molestias quo explicabo vitae.\n\nQuaerat exercitationem porro ratione asperiores cum culpa. Dolorum ipsam neque molestias hic. Recusandae molestias exercitationem quasi ea.\n\nNecessitatibus itaque earum vero blanditiis. Recusandae molestiae ea debitis. A earum autem consequuntur exercitationem ducimus adipisci nostrum. Tempore rerum temporibus quasi reiciendis temporibus.	77.42	\N	2018-02-26 19:31:02.03159+00	1	"1"=>"1", "2"=>"3"	f	t
122	Smith Ltd	Labore nemo ad officia asperiores aliquam maxime delectus. Nisi consequuntur corporis a dolore facere nostrum velit. Tempore aperiam impedit deleniti sequi necessitatibus. Deserunt veritatis eveniet nobis sapiente quam quidem.\n\nMinus numquam fuga a. Ducimus debitis non totam optio minus nostrum iste. Explicabo suscipit saepe tempora rerum rem possimus aperiam.\n\nEarum fuga exercitationem quaerat aperiam. Id vero ducimus doloribus laudantium eligendi deleniti facere. Eum aut nihil provident omnis. Reiciendis vero rem ab ipsam et quas. Quod aspernatur mollitia illum veniam rem pariatur modi vel.\n\nTotam dicta officia veniam itaque tenetur. Fugit voluptas dicta in. Voluptatem repellat consequuntur perspiciatis odio. Quibusdam pariatur tempore autem laudantium laborum.\n\nIllo harum sit dolor eveniet maxime. Voluptatum iure suscipit illo tempore. Enim iure aperiam nihil ut.	11.92	\N	2018-02-26 19:31:02.156892+00	1	"1"=>"1", "2"=>"2"	f	t
123	Nguyen, Duran and Garner	Ipsum exercitationem nisi tempora quam. Enim perspiciatis repudiandae eos praesentium. Quia quidem tempore reiciendis sapiente dolorum quae.\n\nQui odit provident aliquam veritatis culpa. Perspiciatis accusantium incidunt voluptatibus et. Animi tenetur nam sequi iste praesentium ex. Cupiditate dolorum debitis sapiente sapiente ut aspernatur ad.\n\nNulla cum culpa eos. Aperiam tempore dolore delectus aspernatur ipsa tempora blanditiis.\n\nTenetur quisquam voluptatibus ad libero a. Facilis sit deleniti occaecati recusandae nemo eius voluptas. Iusto fugiat dolor fugit iure iure ipsa voluptatem. Officiis quis a error eveniet voluptatum.\n\nPraesentium quod illum delectus delectus possimus. Repudiandae consequuntur illum saepe esse sit dolore. Nobis quaerat omnis culpa. Quo corrupti officia eos ut laboriosam itaque consequuntur.	84.70	\N	2018-02-26 19:31:02.204878+00	1	"1"=>"1", "2"=>"2"	f	t
124	Roberts Inc	Minima ullam et eum facilis ea debitis praesentium eaque. Voluptatibus repellendus ipsa at quo cumque. Optio harum ipsam ad iusto.\n\nRepudiandae nostrum itaque at quam. Dolore nostrum deleniti suscipit. Quod commodi aspernatur perspiciatis eius ipsum. Nemo voluptates dolore error quia ea.\n\nMagnam sapiente est neque ea. Aliquam omnis facere adipisci sit. Impedit possimus corporis dolorum optio velit.\n\nAspernatur exercitationem ea qui molestias recusandae ab dignissimos. Laborum nam incidunt cum fugit molestias sunt laboriosam. Cumque blanditiis cumque aspernatur consectetur similique fugiat itaque.\n\nRepudiandae quae molestiae illo adipisci corrupti reiciendis quisquam. Non amet corporis excepturi sed veritatis fugit. Magni nobis explicabo dicta occaecati dolorum aliquam. Dignissimos delectus reprehenderit asperiores ab corporis laborum vel architecto.	44.55	\N	2018-02-26 19:31:02.268099+00	1	"1"=>"1", "2"=>"3"	f	t
125	Bush PLC	Occaecati repudiandae praesentium odio sapiente eveniet accusantium nisi. Exercitationem quasi minus repudiandae quos delectus est. Tempore blanditiis officiis nemo.\n\nHarum tempora esse consequuntur sapiente enim porro minima. Veniam deserunt tempora pariatur blanditiis voluptatum. Corporis quod voluptate inventore numquam modi ipsam.\n\nDeleniti hic nisi in cupiditate qui aliquid voluptas. Sapiente id sapiente repellendus nostrum inventore eius. Facere expedita sunt tempore inventore rem. Architecto non sit facere eaque.\n\nCupiditate libero similique a necessitatibus blanditiis. Ex at tempore minus laboriosam. Consectetur voluptatum et voluptates distinctio odio eaque ipsum. Tempore aliquid facere unde aperiam veniam cupiditate tempore. Eveniet vitae facilis aspernatur provident nam doloribus iusto.\n\nDebitis cumque exercitationem soluta non. Iusto aut nesciunt perferendis quam libero. Laborum velit dolorum odio qui debitis. Facilis labore possimus fugit explicabo hic.	78.30	\N	2018-02-26 19:31:02.314297+00	1	"1"=>"1", "2"=>"2"	f	t
126	Huang and Sons	Ipsam tenetur laudantium porro reprehenderit. Quos dolorem ut iure iusto. Doloremque eaque expedita sunt dicta.\n\nDolorum dolorem fuga officiis enim doloribus officia. Incidunt ut ab commodi natus quae expedita. Illo dolorum repellendus neque alias tenetur. Enim saepe quia praesentium optio laborum pariatur.\n\nEaque animi doloribus voluptatem modi. Velit repudiandae accusamus eius incidunt rem optio. Quis minus a laudantium sed. Tempore ipsam ex sed quia in occaecati.\n\nFacilis ad sequi necessitatibus dolorem nemo veniam. Sit eaque pariatur inventore. Minima excepturi itaque veniam velit. Quidem fuga laudantium nesciunt in. Quia minus ad eveniet odit consequuntur illum aliquid.\n\nAspernatur asperiores optio excepturi perferendis sed odit. Tempora tenetur earum aspernatur suscipit. Inventore amet minus aperiam repellat fuga incidunt iste. Commodi voluptatibus aut quisquam animi in quae excepturi.	30.21	\N	2018-02-26 19:31:02.360122+00	1	"1"=>"1", "2"=>"2"	f	t
127	Schmidt PLC	Sed id pariatur fugiat at. Suscipit ad in molestias optio iste repellat. Magnam voluptate nam adipisci fugiat.\n\nEaque nobis ullam dolor dolor neque sed excepturi. Architecto sed aspernatur corrupti eum. Cumque officia voluptate dolorum quae minus occaecati neque culpa. Repellat ab facilis repellendus autem esse quo.\n\nVeniam sequi velit molestiae ut illum aliquid. Impedit ipsum maxime aut delectus adipisci explicabo eveniet. Incidunt veniam quaerat quo saepe nisi quibusdam atque.\n\nRepudiandae modi minima dolores iste. Commodi rem laudantium itaque cupiditate sequi eaque temporibus sit. Itaque mollitia a praesentium rerum quas dolorem quibusdam. Culpa rem hic vero itaque ratione libero placeat.\n\nEnim esse nesciunt dolores officia ad velit. Culpa ratione delectus illo error distinctio. Magni architecto voluptatum nisi labore beatae velit eaque.	41.88	\N	2018-02-26 19:31:02.414858+00	1	"1"=>"1", "2"=>"2"	f	t
128	Fowler, Brandt and Moreno	Aliquam officiis suscipit distinctio animi reiciendis. Voluptates ipsum sint sint nihil quibusdam. Ab distinctio reprehenderit tenetur animi nemo aliquid quo. Cum quaerat ab placeat reiciendis.\n\nNatus eligendi vel nam esse explicabo id exercitationem. Repellat debitis voluptas molestiae mollitia id magni corrupti maxime. Voluptate quibusdam iure quaerat aperiam officia reiciendis.\n\nLaboriosam corrupti in officiis inventore recusandae nihil. Incidunt beatae ipsa repellat ab facilis. Pariatur provident reiciendis et cupiditate ipsa accusamus magnam ex. Eveniet labore aspernatur praesentium tempora.\n\nNulla dolorum sed asperiores harum optio. Neque nesciunt tempora facilis voluptatibus. Laboriosam nesciunt quod molestiae sed temporibus amet.\n\nFugit nihil consectetur tenetur sequi. Provident rerum cumque iure explicabo quos maiores possimus. Eaque voluptatibus perspiciatis accusantium. Nihil repellendus quas itaque eveniet.	86.79	\N	2018-02-26 19:31:02.516108+00	1	"1"=>"1", "2"=>"2"	f	t
129	Rogers, Rivera and Wood	Animi delectus harum officia atque omnis illum ea. Illo sequi saepe ipsam. Officiis ipsa illo recusandae vitae a in facilis vel. Dolores incidunt ullam voluptatibus fuga incidunt doloribus.\n\nAliquid quaerat aspernatur optio praesentium molestias repellat. Modi accusantium suscipit in aut minus. Labore nihil et exercitationem quo.\n\nDolor ipsa in hic debitis hic beatae officia ut. Repudiandae qui explicabo natus. Nihil iure ex a laudantium. Aliquid suscipit odio ad impedit nesciunt molestiae enim.\n\nPerferendis cupiditate et ea molestiae architecto necessitatibus doloremque. Quae similique rem deleniti dolorem quaerat tempore.\n\nTempore quos et recusandae doloribus. Ea eveniet perferendis perferendis asperiores earum. Deserunt alias non commodi cumque vitae.	93.10	\N	2018-02-26 19:31:02.601848+00	1	"1"=>"1", "2"=>"3"	f	t
130	Johnson-Williams	Itaque in animi mollitia molestias. Possimus porro nam saepe enim debitis. Laboriosam placeat sed eaque expedita.\n\nLibero expedita sunt dicta adipisci. Possimus cupiditate perspiciatis perspiciatis quisquam cumque. Doloremque labore dolorum quia nihil harum autem. Vel quia earum optio.\n\nPossimus dolor nisi minus quidem ullam. Explicabo nesciunt fugit aut perspiciatis eaque. Odio tempore eaque dolorum fugit.\n\nAssumenda veritatis aperiam nihil inventore. Ipsum omnis optio quod sunt quia. Ullam corrupti reprehenderit minima saepe vel quam.\n\nPerferendis omnis eligendi provident occaecati unde pariatur. Similique ad odio harum consequuntur. Id ipsam sit placeat possimus laboriosam numquam nisi perferendis. Esse rem magni sapiente qui ipsa autem.	46.41	\N	2018-02-26 19:31:02.68444+00	1	"1"=>"1", "2"=>"3"	f	t
131	Stout Group	Quasi rerum atque reprehenderit reiciendis expedita ipsum consectetur. Enim voluptate consequatur expedita sunt. Et perspiciatis quisquam debitis explicabo voluptas quae in eos. Id illo maxime quas blanditiis maxime. Nihil eveniet harum magnam ex.\n\nVoluptatibus quaerat sit vel sunt aperiam eos praesentium. Cupiditate minus ullam ipsum maiores omnis nostrum debitis. Cum totam dolores dolore quas hic. Placeat dolorum repudiandae consectetur sunt rem dignissimos.\n\nQuasi perspiciatis numquam maiores vero. Qui omnis deleniti voluptatem expedita eum dolor numquam. Vitae inventore adipisci velit. Amet non consectetur vitae nisi inventore dicta.\n\nVel doloribus exercitationem at cumque magnam. Dolorem culpa blanditiis reiciendis sapiente voluptatum.\n\nIllo earum praesentium facere vero dignissimos cumque. Quas vero commodi quaerat reiciendis repellendus nam. Atque blanditiis architecto minus facere.	33.65	\N	2018-02-26 19:31:02.794804+00	2	"1"=>"1"	f	t
132	Mcintosh-Coleman	Aperiam occaecati maxime quae eveniet velit incidunt. Eos voluptas nesciunt quaerat fugiat deleniti. Magnam provident vero voluptas ullam itaque.\n\nSequi in reprehenderit sapiente explicabo officiis alias. Ut quibusdam ab laudantium fuga. Alias nihil voluptatum qui aliquid. Voluptatum culpa consequatur itaque asperiores officiis deleniti. Eligendi quo excepturi soluta voluptate delectus nostrum.\n\nMollitia vitae odit laborum praesentium error itaque. Facilis temporibus nostrum tempora vero excepturi odio. Odio earum earum beatae provident a ullam praesentium voluptatem.\n\nHarum debitis laboriosam tempore. Voluptatem assumenda reiciendis praesentium pariatur dolore. Delectus accusantium sunt eveniet tempora illo officia architecto. Fugiat earum adipisci ea corrupti voluptatem ab optio expedita. Aut consectetur rem expedita.\n\nEligendi dolorem expedita necessitatibus. Non nesciunt quaerat incidunt dolores voluptates. Voluptatum facere eos explicabo. Error excepturi delectus reprehenderit eum.	30.76	\N	2018-02-26 19:31:02.831536+00	2	"1"=>"1"	f	t
133	Scott Inc	Rem dolore tenetur adipisci dignissimos. Corporis ducimus eos excepturi non.\n\nDolorum aspernatur doloribus error quibusdam ullam. Repellendus doloremque commodi sit cumque excepturi. Harum repellat veniam amet at nisi minus porro.\n\nQuos quia veritatis eaque natus officia ab. Veritatis nobis aperiam sed odit. Illo tempora veniam minus minima ea quae. Accusamus dignissimos molestias asperiores amet assumenda.\n\nError debitis temporibus iste fugiat officia corrupti necessitatibus neque. Totam dolores quod nisi totam sed. Dolorem quos architecto maxime necessitatibus praesentium numquam. Maxime quos repudiandae minima non assumenda inventore.\n\nQuaerat iusto nemo consequatur. Alias dolorum commodi temporibus consequatur. Quod alias doloribus earum sapiente eos consectetur magnam.	41.75	\N	2018-02-26 19:31:02.86837+00	2	"1"=>"1"	f	t
134	Kim, Elliott and Cole	Iure dolorum corporis officia numquam. Voluptates repellendus est itaque error. Quibusdam ab fugiat animi dolores fuga. Alias dolorum similique mollitia accusantium quibusdam laboriosam omnis.\n\nEnim similique repudiandae consequatur perferendis dolor. Commodi officiis esse deserunt quam earum ad. Magni exercitationem non ad dignissimos.\n\nNisi sapiente hic repellat accusamus ea accusamus repudiandae. Corporis placeat ipsa fugit iure. Dolorum harum minus exercitationem ut quis sapiente quae.\n\nAliquam sint odit veniam accusantium molestias voluptates. Temporibus beatae eos dolore repellat debitis quam assumenda qui. Vero voluptates recusandae quibusdam quibusdam harum nesciunt vero. Eum quo quasi minus aspernatur nesciunt laudantium ex.\n\nOdio perspiciatis occaecati quia suscipit. Delectus tenetur doloremque dolores ducimus impedit. Dolorem earum perferendis quibusdam itaque labore. Quasi adipisci vero quae earum delectus voluptatem.	90.83	\N	2018-02-26 19:31:02.91582+00	2	"1"=>"1"	f	t
135	Davis LLC	Laborum ab quia nemo deleniti occaecati repudiandae non. Exercitationem magnam neque corporis illo reprehenderit. Illo sunt officia ab repudiandae qui veniam.\n\nItaque harum doloremque reprehenderit dolorum quam et. Deserunt quaerat deleniti doloremque harum dignissimos. Reiciendis commodi nesciunt corrupti modi libero vel corporis.\n\nQuisquam veniam ratione quisquam dolorem sint exercitationem. Blanditiis illum non consequuntur. Inventore voluptate ex quisquam sint vero nesciunt maxime. Quia pariatur nisi quisquam ullam.\n\nNam dolore repudiandae commodi. Non repudiandae tempora occaecati sed. Consequatur hic illum maiores provident.\n\nDolores inventore eos omnis aliquid. Optio accusantium rem repellendus similique fugiat. Quasi voluptates aliquid molestias nemo repudiandae rem possimus. Et ab quo fugiat praesentium nisi et fugit.	45.39	\N	2018-02-26 19:31:02.951797+00	2	"1"=>"1"	f	t
136	Smith-Clark	Doloribus distinctio voluptatibus facere magnam deserunt reprehenderit. Doloribus a qui exercitationem. Quasi vitae illum accusamus libero eligendi laborum vitae.\n\nMagni iusto cumque quia. Sint nostrum at dignissimos beatae. Non architecto maxime pariatur aut quisquam quia. Laborum nostrum alias blanditiis quod quaerat voluptate earum.\n\nSuscipit aspernatur nesciunt beatae laboriosam mollitia incidunt animi laborum. In odit modi cumque reiciendis. Labore nostrum natus nesciunt.\n\nLaboriosam in repellendus omnis laboriosam laudantium. Facere itaque iure laudantium itaque.\n\nPlaceat excepturi quos amet minima error. Hic aut in sequi saepe harum. Nostrum recusandae corporis voluptas ex totam facilis aliquid. Et nostrum sequi tempora maxime explicabo.	85.63	\N	2018-02-26 19:31:02.997526+00	2	"1"=>"1"	f	t
137	Rodriguez-Brooks	Impedit odit dolore atque minus accusantium. Aut alias nulla error natus laudantium. At ex beatae facilis consequuntur repellat.\n\nNam fugiat culpa vitae ea autem. Illo voluptatibus tempora odio nostrum. Commodi nemo harum voluptas libero aspernatur blanditiis repudiandae.\n\nConsectetur voluptates quasi repudiandae totam porro saepe veniam. Asperiores eos commodi numquam alias. Cum necessitatibus ipsum error atque necessitatibus enim facilis.\n\nOfficia officiis aliquid ut nisi voluptatem. Voluptatibus id corrupti ipsa quasi corrupti hic nam. Vero fuga a molestiae aut sunt. Voluptatem pariatur commodi distinctio sed quod. Suscipit nisi rerum quisquam eum cupiditate optio.\n\nDignissimos nemo ipsam debitis. Amet aliquid reprehenderit iure illo. At sit esse voluptate neque excepturi. Doloribus cumque rem eum nihil nostrum et.	35.53	\N	2018-02-26 19:31:03.060754+00	2	"1"=>"1"	f	t
138	Melendez Ltd	Harum quia quas quis deserunt fugiat. Exercitationem tempora adipisci dolore dignissimos omnis recusandae dolore. Ad inventore voluptatem harum aliquid.\n\nNulla aperiam dignissimos unde. Eligendi animi ex iure corporis. Maxime rem et velit doloribus repellendus quod. Nulla accusantium nihil ab repellendus dolores.\n\nFugit voluptas fuga dignissimos consectetur nostrum. Minima dignissimos laborum quia natus omnis doloremque. Nihil consequuntur totam praesentium. Tempora laboriosam officia ut qui quasi. Non magni suscipit consequatur.\n\nIure asperiores ducimus necessitatibus. Aspernatur distinctio quos aspernatur facere eaque. At ipsam tenetur consequuntur sint nisi perferendis labore perferendis. Temporibus delectus doloribus veniam architecto sapiente ex provident.\n\nQuis nihil pariatur maiores maiores odio. Numquam impedit ipsum asperiores saepe nihil. Blanditiis quas vitae sint dolores dolore eaque ipsum. Cum quis quia assumenda nihil hic.	3.48	\N	2018-02-26 19:31:03.094893+00	2	"1"=>"1"	f	t
139	Campbell, Ford and Ramirez	Molestias dolores ipsam facere alias enim tempora minima. Fuga ea atque corrupti perspiciatis quis. Eveniet quisquam architecto quam voluptatem possimus eum.\n\nQuaerat modi ex a porro soluta expedita. Dolorem praesentium sequi nemo. Rem id enim commodi tempore esse molestiae. Iusto sint saepe alias unde voluptatem provident. Atque incidunt earum perferendis repellat magni animi.\n\nCumque eius nesciunt tempora odio quae. Sed expedita fuga iste voluptatem nulla voluptatum. Consectetur unde repudiandae consectetur occaecati.\n\nIure molestias voluptates provident est. Tenetur inventore nam iste consectetur delectus qui. Totam quis autem totam ducimus consectetur. Veritatis quos dolorum reiciendis provident.\n\nConsequuntur vero corporis maxime repellat aliquid. Officia rem porro exercitationem magni velit sit. Totam distinctio accusantium natus aliquid deleniti. Odio beatae unde cumque natus.	40.37	\N	2018-02-26 19:31:03.13206+00	2	"1"=>"1"	f	t
140	Ferguson PLC	Officiis ratione quas molestiae harum commodi. Sequi neque ab voluptates illo consectetur nostrum ducimus suscipit.\n\nRepellendus doloribus nobis eum maiores fugiat accusantium. Distinctio delectus deserunt vitae maiores quis. Voluptatem enim facere iusto quae exercitationem ad.\n\nIpsum minus cumque natus. Non distinctio libero quam hic dolores veniam nisi. Earum eveniet tempora fugit quidem vero fugit a.\n\nVeritatis qui consectetur explicabo eveniet. Aut exercitationem laborum sequi alias eaque id laboriosam. Officiis quibusdam ipsa quasi temporibus sit similique.\n\nDolorum ipsa earum quo nesciunt debitis. Voluptatum sunt ad sit aperiam. Ab in tenetur minima rem odit ex impedit.	32.10	\N	2018-02-26 19:31:03.168921+00	2	"1"=>"1"	f	t
141	Downs-Williams	Natus deleniti eligendi modi ratione aperiam at sit inventore. Blanditiis placeat magnam rem quisquam corporis placeat. Repudiandae ad eius quae officia ea occaecati. Voluptates exercitationem sequi mollitia amet sequi illum voluptatibus.\n\nBeatae reiciendis voluptates laudantium ipsam optio dolorum quas animi. Modi aliquam dolor sed dicta omnis maxime. Soluta voluptatibus optio nam illum eaque.\n\nVoluptates voluptatibus voluptatem perferendis ullam. Provident placeat deleniti autem rem aspernatur voluptate error. Id architecto aut a corporis quibusdam atque ullam quo.\n\nReiciendis rem labore nihil qui quibusdam voluptatem. Expedita dolores sit laborum quod. Exercitationem quae omnis repudiandae aliquid consectetur consequuntur eos. Labore nesciunt delectus quas id doloribus iusto dignissimos.\n\nNobis esse aspernatur nemo. Consequatur a culpa soluta iusto nemo repudiandae praesentium.	52.73	\N	2018-02-26 19:31:03.206646+00	3	"1"=>"1", "4"=>"8"	f	t
142	Smith, Rodriguez and Morales	Quae tempora vitae perferendis exercitationem soluta. Non reprehenderit magnam expedita ipsum aliquam et quisquam. Numquam sapiente eveniet velit ducimus soluta ipsam exercitationem. In voluptas voluptas ex similique consequatur.\n\nAb eum quod consequuntur nemo. Sapiente labore esse totam. Ducimus recusandae reiciendis dicta a libero. Laudantium architecto possimus modi unde quos iste quis. Corporis laudantium doloribus eum vero porro.\n\nMinima impedit quis quos fugit ratione repellat autem. Sunt culpa rem odit magnam rerum quaerat. Autem amet veniam ab neque a totam asperiores.\n\nDelectus ea error blanditiis qui quae a. Iste ut iste exercitationem. Architecto ipsa vero temporibus. Ipsa dolore neque neque amet. Similique deserunt molestiae sequi dicta voluptatum deserunt perspiciatis.\n\nAdipisci error fugiat nostrum molestias. Quod autem repudiandae minus voluptatum explicabo occaecati. Earum quas totam eligendi expedita voluptatibus repellat.	29.61	\N	2018-02-26 19:31:03.281371+00	3	"1"=>"1", "4"=>"9"	f	t
143	Ross-Brown	Aperiam facere harum aut rem id. At similique neque atque blanditiis ratione voluptas omnis. Fugiat quas quia deserunt blanditiis maiores qui. Laboriosam aliquam accusantium velit dignissimos sit perspiciatis aliquam.\n\nExplicabo eos voluptates doloremque. Delectus quam saepe doloribus quibusdam repellat maiores. Neque voluptates aperiam beatae soluta ea dicta. Iure cumque unde ipsum vel.\n\nQuaerat dolorum quo veniam. Eum iusto assumenda laboriosam nam laborum reprehenderit quos. Facere neque ab pariatur ipsa veniam vero fugiat. Eum blanditiis similique quae distinctio in laboriosam nisi.\n\nSoluta cupiditate sequi sint esse aspernatur iure possimus. Cum autem qui quia laboriosam deserunt repudiandae. Ipsa cupiditate ipsam quibusdam quasi facilis cum neque. Praesentium at dolorum corporis totam ea quibusdam.\n\nBeatae rerum sapiente qui aut quibusdam. Perferendis totam dicta soluta vero qui iusto accusamus laboriosam. Et eum aspernatur quo nemo.	14.90	\N	2018-02-26 19:31:03.341674+00	3	"1"=>"1", "4"=>"8"	f	t
144	Cunningham-Gillespie	Facilis tenetur dolor nesciunt excepturi expedita explicabo. Aperiam consectetur doloremque error nemo adipisci accusantium. Repellat ipsum totam nemo explicabo.\n\nMagnam excepturi eius similique quidem. Fugit expedita quisquam totam minima impedit tenetur reiciendis. Tenetur nobis illo facere inventore distinctio porro iure.\n\nNatus minus sit perspiciatis autem dolores veritatis. Distinctio et necessitatibus ex quibusdam. Dolorem nemo vel est beatae. Blanditiis cupiditate magni cum atque.\n\nPerspiciatis eveniet ullam veritatis. Maxime suscipit ducimus similique officia voluptatem perspiciatis. Ad nihil accusantium corporis temporibus deserunt rem nulla cum.\n\nAb esse amet corporis commodi. Molestiae dignissimos dicta eum nobis maxime quos tempore. Itaque eligendi repellat deserunt earum corrupti ducimus unde.	6.10	\N	2018-02-26 19:31:03.39468+00	3	"1"=>"1", "4"=>"8"	f	t
145	Garcia-Miranda	Animi amet doloremque hic nobis dolorum et maiores veniam. Sequi sit veritatis repudiandae atque. Occaecati mollitia consequuntur laudantium dolor reiciendis qui suscipit.\n\nDistinctio repellat aperiam a similique perferendis sed. Sapiente nemo architecto ab ad. Hic dolore aliquam minus eligendi veniam sint.\n\nDoloremque quo perspiciatis id mollitia laboriosam. Laudantium commodi ipsa harum odio. Consequatur iure delectus nisi a ut tempora harum.\n\nAccusamus voluptas aliquam optio. Beatae at quibusdam odit amet ad pariatur. Id reiciendis adipisci ducimus reiciendis repudiandae voluptate consequuntur. Illum praesentium earum iste numquam reiciendis.\n\nQuas recusandae facilis nostrum aut sit ducimus. Fugiat eum quo dicta nulla asperiores provident voluptas. Quod ad aliquid tempora illo hic et odit voluptates. Magni excepturi impedit provident maiores voluptas dolores ipsa. Quidem necessitatibus itaque officiis perferendis iusto et.	97.88	\N	2018-02-26 19:31:03.473707+00	3	"1"=>"1", "4"=>"8"	f	t
146	Monroe PLC	Mollitia quibusdam delectus tempore fuga cupiditate accusantium dolor. Vero doloremque dolorem id ratione. Quibusdam minima quaerat tempore quidem autem explicabo quidem.\n\nNobis modi aliquid tempore libero rerum aliquam necessitatibus. Inventore ipsam non ullam repudiandae eum id beatae. Necessitatibus ex tempora id animi iusto molestiae blanditiis modi.\n\nOmnis labore laborum labore quas eos. Molestias vitae quam aspernatur excepturi minima nulla tempora recusandae. Explicabo omnis odit facilis at eum corrupti porro minus. Exercitationem in dolorem nostrum facilis in blanditiis.\n\nPariatur numquam sequi molestiae illo. Laborum totam laboriosam iste temporibus minima recusandae dolores.\n\nMaxime necessitatibus vero molestiae fugit ullam mollitia aspernatur. Ut odit nihil minus iure incidunt incidunt saepe. At voluptatem modi facilis quo asperiores. Accusantium veniam porro autem tempore quo neque.	51.24	\N	2018-02-26 19:31:03.52978+00	3	"1"=>"1", "4"=>"8"	f	t
147	Long and Sons	Quaerat ea reprehenderit accusantium officia nulla. Reiciendis porro totam magni dicta excepturi corrupti nulla natus. Blanditiis nam est nam ut. Aspernatur consequuntur accusamus consequatur ipsa minus nisi eaque quibusdam.\n\nNumquam et aspernatur aut voluptatibus nostrum natus totam. Suscipit non corporis unde corporis voluptate placeat placeat. Illum qui nobis vitae veniam. Perspiciatis itaque sint sed suscipit enim recusandae.\n\nSit magni quae culpa corporis officiis possimus. Sunt excepturi dolorum cupiditate blanditiis maxime perspiciatis. Placeat soluta repudiandae dicta numquam.\n\nMinima asperiores doloremque numquam natus voluptatibus. Veniam repellendus dolor impedit praesentium tenetur. Voluptatem natus molestiae sequi itaque porro. Expedita deserunt id reiciendis modi qui iusto.\n\nRepudiandae modi suscipit vel expedita commodi ad. Aperiam aspernatur deserunt sunt iure dignissimos id qui. Repellat ipsum adipisci illo unde saepe explicabo. Voluptatum amet doloremque qui aliquam laboriosam neque. Veniam hic eveniet odit officiis cum.	72.42	\N	2018-02-26 19:31:03.590336+00	3	"1"=>"1", "4"=>"8"	f	t
148	Jones-Barton	Ullam quae ab commodi. Sapiente nihil laborum est numquam nam saepe maxime veniam. Ullam iste officiis eum id.\n\nEnim rerum provident maiores itaque vero. Ratione commodi exercitationem nobis. Eos culpa alias harum error hic non. Ab nihil reprehenderit libero voluptatibus voluptatibus ut quod.\n\nNecessitatibus quasi quam vitae id ducimus quos. Dolorem quam distinctio est excepturi expedita mollitia. Maiores rerum consequatur nemo unde natus nostrum accusantium.\n\nAdipisci omnis porro beatae voluptatem rerum nulla sunt. Cum occaecati ullam eos nobis animi doloribus quas. Quaerat hic quas aliquam repellendus modi dolor. Harum mollitia suscipit earum harum officia ullam dolorum. Voluptatibus distinctio accusamus pariatur aliquam rerum debitis tenetur.\n\nAccusamus adipisci commodi occaecati odit. Omnis nostrum maxime veritatis tempore eos atque. Occaecati accusantium repudiandae fugit perferendis ipsam.	6.75	\N	2018-02-26 19:31:03.671572+00	3	"1"=>"1", "4"=>"9"	f	t
149	Best, Lewis and Frey	Asperiores sint repellat debitis. Facere adipisci officiis laudantium est. Natus qui nisi consequuntur rem at reiciendis.\n\nVoluptas aliquam quos ut tempore modi atque porro. Enim sequi itaque reprehenderit ipsum in minus possimus. Ipsum dolor hic nobis aperiam. Ipsam ab distinctio suscipit in.\n\nVoluptatum dolore maiores consectetur eaque doloremque. Dolore cupiditate possimus laboriosam praesentium dolore hic illo. Delectus voluptates ratione facere enim dolorem distinctio repudiandae. Voluptas ex facilis sapiente.\n\nPerferendis maxime temporibus delectus eum. Voluptates veniam dolore sapiente atque est error. Nostrum molestias eius quidem sapiente rerum odio soluta. Sapiente maxime tempora quibusdam.\n\nQuisquam id vero eius laboriosam tempora nobis. Vel in expedita earum est. Nemo iste cupiditate sapiente error tenetur dolorum ut.	19.95	\N	2018-02-26 19:31:03.745932+00	3	"1"=>"1", "4"=>"8"	f	t
150	Bird-Levy	Eaque fugiat iste necessitatibus perspiciatis sequi. Sint sunt impedit animi expedita incidunt pariatur natus. Quasi perspiciatis ad expedita. Nostrum temporibus iure assumenda accusamus dolor nihil quaerat reprehenderit.\n\nEarum voluptate mollitia a voluptatem quam sed. Vel omnis ipsa nihil nostrum. Quaerat exercitationem sed eos commodi hic.\n\nVoluptate cum repudiandae a iste. Autem rerum quam eligendi expedita ipsam.\n\nModi incidunt deleniti iste animi. Amet alias aliquam nobis saepe earum nostrum molestias deleniti. Debitis officiis similique blanditiis debitis placeat temporibus sunt.\n\nInventore atque est atque totam magni dolore deserunt aliquid. Amet suscipit temporibus iusto in deleniti impedit. Nulla minus sit deleniti cum exercitationem labore aliquid labore. Nobis est delectus molestias perferendis dolor.	72.98	\N	2018-02-26 19:31:03.838083+00	3	"1"=>"1", "4"=>"9"	f	t
151	Price, Sanchez and Thompson	Libero distinctio provident minima ratione nisi illo. Animi unde quisquam sunt aperiam at. Quisquam occaecati tempore quo quas.\n\nAlias est praesentium voluptatum ipsum optio. Consequatur ratione maiores aliquam numquam repellendus. Ullam aut cumque exercitationem sit ut eum pariatur.\n\nPraesentium non quas atque ipsa sunt laborum. Tempore occaecati odit fugit sit iure. Temporibus laborum nulla quas cupiditate.\n\nRepellat modi occaecati hic. Deleniti temporibus soluta eveniet repellat deserunt animi. Fugit recusandae dicta nisi unde illo. Cum iste facilis repellat iste ipsum occaecati.\n\nQuis libero consequatur nisi perferendis deleniti quis inventore. Culpa error amet accusamus iusto nam. Voluptatibus tenetur ab ducimus reprehenderit quam. Temporibus sapiente necessitatibus maiores.	53.23	\N	2018-02-26 19:31:03.900585+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
152	Schaefer, Salinas and Booth	Delectus maxime nisi hic deleniti. Neque alias ex fugit necessitatibus. Corrupti officia ad fuga assumenda vitae recusandae fugit.\n\nPraesentium consectetur maxime voluptatibus fugiat ab. Quaerat a pariatur laboriosam. Dicta consequuntur velit quam quasi aliquid rerum.\n\nFugit sequi est quod modi excepturi. Distinctio ut eius omnis deleniti. Ullam consectetur nobis reiciendis. Quaerat quis ipsa eius consectetur sunt temporibus ducimus assumenda.\n\nAliquid dolorum consequuntur aspernatur pariatur veritatis nihil dignissimos quasi. Officia earum voluptate minus maxime. Cum harum consequatur illum repellendus quidem expedita.\n\nEos cum laudantium sed vitae alias nulla enim iste. Officia similique eligendi voluptates ipsum placeat. Sunt rem totam enim sapiente fuga beatae ea officia. Est culpa eos impedit rem optio facere.	27.47	\N	2018-02-26 19:31:03.98868+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
153	James, Nelson and Martinez	Reprehenderit aliquam earum consequatur sequi nihil pariatur facere reiciendis. Beatae fugiat nihil modi at explicabo distinctio beatae. Voluptates corrupti qui et soluta. Assumenda molestiae cum soluta.\n\nAd cumque autem placeat officia itaque impedit voluptas. Error rerum dicta eius occaecati nemo. Voluptate amet ut tempore inventore minima beatae. Et eligendi in corrupti temporibus nemo. Occaecati atque debitis quidem dolor reprehenderit molestias beatae.\n\nDoloribus rerum corrupti occaecati laboriosam itaque qui praesentium. Dolorem voluptas reiciendis recusandae quod at. Architecto sit eum iusto quisquam ducimus eveniet.\n\nHic autem velit nesciunt incidunt earum velit. Similique dolores blanditiis impedit dicta sit alias. Omnis doloremque amet perferendis illum sed eligendi. Esse quidem minima nihil numquam dignissimos inventore quae.\n\nVel distinctio fuga non vitae deleniti assumenda sit. Laborum doloremque accusantium deserunt non. Dolorem non molestiae tenetur. Repudiandae in totam totam ipsa porro dicta.	66.69	\N	2018-02-26 19:31:04.090566+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
154	Perez LLC	Beatae quaerat ipsa laboriosam recusandae iure. Enim repellendus nam natus ab ullam maiores. Eveniet laudantium non quaerat porro occaecati vero quo.\n\nEa distinctio fuga harum fugit libero. Corporis nulla quasi labore amet enim laboriosam.\n\nAtque ipsam provident at. Eius amet labore illum consectetur sint officia temporibus. Molestiae perferendis saepe recusandae aperiam explicabo alias quae itaque. Voluptatum unde delectus nobis nesciunt ea soluta autem.\n\nVoluptatibus iusto assumenda amet reiciendis deleniti. In quae neque debitis voluptate soluta fugiat. Officia soluta eius eius et suscipit. Cupiditate aliquid nihil possimus facilis ullam quaerat.\n\nEt possimus nulla numquam. Dicta illo vel possimus modi. Magnam odit porro dignissimos perferendis fugit.	83.30	\N	2018-02-26 19:31:04.17648+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
155	Powell and Sons	Atque magni reprehenderit dolorem distinctio. Quasi laboriosam delectus unde dolorum praesentium.\n\nNisi iste fuga eos qui. Nostrum totam doloremque officia quasi illo neque aliquid. Ipsam vitae incidunt eaque magni nihil minus ipsum.\n\nDoloribus nam similique accusamus. Itaque sunt voluptas iusto totam odio. Expedita in impedit nesciunt iusto nihil quibusdam dolore. Saepe molestiae totam quam voluptatum.\n\nOccaecati ducimus voluptates quia est voluptatibus voluptas. Laborum tempore accusantium ullam similique in enim. Blanditiis quae libero sapiente suscipit rerum corporis. Cum suscipit sapiente ipsa temporibus quasi totam.\n\nUllam autem soluta temporibus odit. Dolores fugiat sit est dolorum ex iusto possimus. A ut minus sapiente veritatis voluptates facere asperiores. Iste ducimus doloribus hic magnam sint harum minus.	26.95	\N	2018-02-26 19:31:04.239722+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
156	Pratt-Riddle	Nemo vel doloribus culpa ipsa quis reprehenderit quo culpa. Aut autem occaecati ipsa culpa accusantium. Quam culpa optio quae eaque. Odio facere architecto nulla iste.\n\nTempore in explicabo a. Saepe deleniti molestias id repellat. Assumenda corrupti accusantium consequatur. Commodi laborum sint minima dicta error ipsam asperiores molestiae. Sequi excepturi quas quasi esse.\n\nProvident perferendis natus alias voluptas recusandae. Voluptatibus maiores labore ratione velit fugiat. Tempora voluptas veritatis voluptatibus reprehenderit beatae quam labore. Modi voluptatem ut ipsa ipsam eaque sit. Recusandae incidunt cupiditate nesciunt incidunt provident corporis illo.\n\nExercitationem minus id nihil recusandae reprehenderit autem ipsum. Nobis voluptatem amet necessitatibus esse eligendi. Eaque facilis assumenda odit magnam.\n\nFacere mollitia maxime rem aspernatur qui aliquid quisquam. Nesciunt exercitationem suscipit voluptatem explicabo. Vel architecto nam alias fugit esse commodi eveniet. Omnis quas possimus aut soluta.	90.30	\N	2018-02-26 19:31:04.324286+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
157	Alvarez PLC	Eius cumque quae sapiente nobis. Quos porro aliquid eligendi necessitatibus enim modi. Dolore soluta fugiat nemo quae dolorem nulla. Aliquid dolor quasi ipsum expedita.\n\nIure itaque illo dolores corporis molestiae. Earum expedita officiis explicabo provident. Labore deleniti tempore porro sunt saepe.\n\nFugiat fugiat in est tenetur vitae maxime. Ab iste alias voluptate libero. Modi perferendis placeat in. Nesciunt dignissimos ullam saepe.\n\nNecessitatibus qui aliquid earum repellat. Vero minus magnam voluptate facere. Culpa suscipit qui eligendi culpa ea nam.\n\nAutem repellendus aliquid magni at aperiam nemo at perferendis. Corrupti possimus id quae accusantium quis. Suscipit maiores rerum distinctio libero maxime.	50.40	\N	2018-02-26 19:31:04.398849+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
158	Parker, Bell and Martin	Voluptatem dolore veniam veritatis blanditiis enim. Officia repellendus dolores distinctio quis earum minima consectetur autem. Ut vitae sunt blanditiis repellat ad. Eos error quia ipsum unde. Suscipit accusantium excepturi odio hic.\n\nVoluptates ut ratione dignissimos est vero aspernatur. Facere nobis consequatur ullam reiciendis delectus consectetur. Mollitia quaerat possimus voluptates inventore. Esse cupiditate cum labore mollitia numquam.\n\nDelectus delectus delectus assumenda nobis itaque. A sunt reiciendis distinctio. Facere earum at iusto. Explicabo impedit praesentium adipisci praesentium doloremque.\n\nEveniet amet facere fuga accusamus. Tempore labore dignissimos reiciendis totam quidem commodi. Vel magnam eveniet blanditiis. Autem aliquam quaerat dolore.\n\nQuibusdam accusantium porro libero assumenda. Eius nulla beatae dolor distinctio ratione iusto. Beatae corrupti tempora adipisci atque quidem quasi. Quod cum iusto eligendi ratione ipsum.	76.36	\N	2018-02-26 19:31:04.489538+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
159	Bishop, Dunlap and Oconnor	Libero maxime ea sed eveniet dicta quasi. Dignissimos ea eaque eaque eum. Dolores corrupti rem odit distinctio ipsam. Maxime laudantium officia eius quam aliquam.\n\nIure quis consectetur perferendis odio eligendi error maxime ut. Est repellat corrupti tempora placeat commodi molestias sunt. Accusantium laboriosam est tenetur beatae provident necessitatibus reprehenderit fugit. Cum minus voluptas architecto a.\n\nAb iusto debitis excepturi distinctio. Blanditiis illo omnis facere velit esse. At tempora possimus dignissimos dolore architecto molestiae.\n\nDoloribus ipsa similique veritatis ullam ipsa aliquid quae. Sapiente corrupti doloribus temporibus voluptates optio. Repellendus tenetur illo deleniti illum.\n\nNobis reiciendis corporis aspernatur tempora veniam. Voluptatem non voluptatum animi fugiat laudantium. Dolorem fugit quidem vitae cum. Mollitia unde autem neque quibusdam dicta.	63.20	\N	2018-02-26 19:31:04.578525+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
160	Mason-Myers	Ullam veritatis quia earum repellat ducimus. Esse libero similique aut perspiciatis. Ipsam eveniet quo quos animi esse consequatur neque.\n\nEius quia quam dolorum dicta at quas. Quos iusto velit eligendi dolore odit laborum numquam. Quidem facilis nesciunt pariatur velit quidem quia ipsum. Vero alias est quo praesentium.\n\nAperiam rerum cum eveniet asperiores sapiente alias fugiat reiciendis. Laudantium sapiente velit sapiente nesciunt recusandae. Deleniti recusandae occaecati assumenda iste. Eius ratione vero harum reprehenderit excepturi.\n\nAperiam accusamus quod quis aliquam laudantium possimus hic. Placeat quam doloremque blanditiis error. Molestias maiores maxime tenetur ipsam.\n\nUt omnis voluptatum sint. Eligendi ipsum consequatur architecto. Eaque earum perferendis a quas molestias. Hic minus non repudiandae repudiandae velit beatae.	89.19	\N	2018-02-26 19:31:04.644804+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
161	Mejia PLC	Nemo illo totam cum itaque eaque delectus laboriosam. Quisquam laborum corrupti occaecati expedita. Labore laborum possimus voluptatibus nisi ipsum modi. Placeat doloremque eaque sed doloribus vero commodi tenetur laboriosam. Officia et atque laudantium.\n\nDeleniti officiis ex vitae perferendis harum. Alias et doloribus ipsum repellendus. Eligendi voluptates eius delectus earum. Sunt repellat vel commodi.\n\nRepudiandae et tenetur cumque veritatis. Placeat quasi blanditiis deleniti repudiandae voluptate nihil omnis. Ullam ipsa velit ullam iure molestiae vitae.\n\nSit quasi omnis alias. Voluptate eius quod dolores ipsam explicabo velit aperiam nobis. Occaecati commodi modi voluptatum aliquid quis dolor.\n\nEx aspernatur impedit delectus. Repellendus vero culpa fuga fugit doloremque nemo deleniti tempora. Omnis deserunt suscipit minus dignissimos natus quibusdam. Iste accusantium quam neque perferendis.	32.10	\N	2018-02-26 19:31:04.723431+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
162	Casey-Shelton	Ad debitis delectus tempore atque. Voluptas facere iure consectetur. Doloremque aut laboriosam accusantium tenetur. Iusto minima temporibus velit.\n\nError voluptates asperiores magnam accusantium autem voluptatum. Repellendus nostrum rerum placeat distinctio nam. Nesciunt est earum perspiciatis deleniti. Ea iusto in iusto quisquam consectetur sint.\n\nAmet aperiam molestias nisi aliquid. Nemo blanditiis animi maiores rem quaerat earum. Sunt voluptas iste sunt sed repudiandae dignissimos. Libero nostrum veniam minima tenetur accusantium.\n\nCorporis nihil repudiandae molestias quod labore at. Quam rem nihil qui optio. Voluptate iste autem nemo officiis.\n\nDignissimos corrupti aliquid provident vel expedita quis. Iusto itaque sed repudiandae error libero quos temporibus. Aperiam aliquam maiores porro. Provident commodi blanditiis ullam fugit.	33.62	\N	2018-02-26 19:31:04.798693+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
163	Dyer-Monroe	Culpa optio totam minus debitis debitis eligendi quos. Vero ut voluptatem fugit sequi consectetur deserunt accusantium. Nulla possimus vitae consectetur in dignissimos.\n\nHic perspiciatis suscipit nemo natus ipsum mollitia. Consequatur nemo quis expedita. Illum distinctio perspiciatis quisquam itaque nostrum. Praesentium quisquam eum aperiam tempora ipsam alias.\n\nSequi doloremque enim corrupti numquam magnam impedit. Id iste recusandae vel ullam ab. Doloribus ut reiciendis nisi tenetur. Nisi explicabo ullam nobis consectetur aliquam ipsum fugiat tenetur.\n\nQui laboriosam iste ab corporis. Neque unde quas qui culpa.\n\nFuga eligendi numquam eaque eaque totam incidunt sequi. Sunt vel enim corrupti nemo labore molestias.	96.75	\N	2018-02-26 19:31:04.87351+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
164	Perez-Reed	Est dolore suscipit sapiente maiores pariatur laboriosam magni. Dignissimos tempora reprehenderit dignissimos. Reprehenderit tenetur omnis cum ab alias molestiae cupiditate.\n\nVero in id cupiditate odit. Deleniti veniam magnam dolor assumenda dignissimos dignissimos unde. Repudiandae praesentium qui aut officia excepturi ad illo delectus.\n\nQuod nisi in vero tenetur rerum. Assumenda fuga ut ducimus impedit excepturi. Quidem blanditiis sed maxime necessitatibus id incidunt. Quisquam quam harum illo eveniet sed.\n\nDolorum tempora expedita impedit pariatur. Explicabo dolor est alias ex ea. Odio dolor ad doloremque odio. Facere enim nam eos architecto eos velit. Nihil nulla occaecati omnis inventore praesentium animi atque.\n\nNesciunt dignissimos illum tenetur suscipit. Commodi officiis quasi dolor ipsum. In eveniet alias perspiciatis consectetur soluta dolorem ea. Ratione ipsa vitae reiciendis occaecati harum.	76.93	\N	2018-02-26 19:31:04.954737+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
165	Nicholson-Ortega	Ipsa dolore corporis veritatis veniam. Quos voluptatibus quis amet eaque distinctio.\n\nAssumenda alias debitis aliquam perspiciatis id nostrum. Nesciunt nam ducimus sit rem repellendus rem. Illum quo labore magnam at.\n\nEst occaecati asperiores officia quibusdam eveniet sunt assumenda. Iste iure tempora sunt facere aut illo at quos. Incidunt ab maiores dicta perspiciatis officiis.\n\nModi doloribus qui in alias molestias eligendi. Numquam corporis corrupti odio sint dolorem veniam. Possimus sint qui aliquam facere beatae alias. Facilis tenetur suscipit quibusdam voluptatem fuga quasi.\n\nOfficia ab eos soluta dolorem quo. Officiis at architecto iure quasi aspernatur eos laudantium. Velit quae provident magnam officia ut deleniti numquam. Alias perspiciatis fugit non tempora harum.	39.30	\N	2018-02-26 19:31:04.998785+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
166	Goodman, Williams and Murphy	Mollitia dolorem officia maxime veniam officiis molestiae. Quam dolores dignissimos id quibusdam labore assumenda quod.\n\nOfficia quo tenetur reiciendis eaque doloribus aperiam. Recusandae blanditiis hic quidem nostrum sequi numquam harum. Voluptatem dignissimos labore harum ipsam voluptatibus quod quo dolorum.\n\nId laboriosam provident id quod distinctio. Incidunt quod voluptatum sit rerum commodi aut. Laudantium qui quidem nesciunt quis saepe nostrum nisi.\n\nSunt nihil rem in quo. Soluta quos aspernatur fuga atque. Quisquam vero minima molestias inventore dicta quos recusandae neque.\n\nAutem nemo molestiae veniam rerum sint molestias voluptatem illo. Officia labore accusamus temporibus laudantium omnis. Nisi sit velit delectus. Nemo atque odio nam laborum aspernatur. At adipisci rerum quibusdam reprehenderit cupiditate facere.	98.57	\N	2018-02-26 19:31:05.067975+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
167	Carlson, Chapman and Morris	Rerum corporis tempore quibusdam. Suscipit eaque officiis ab molestiae. Omnis temporibus numquam omnis necessitatibus.\n\nUnde facilis ipsa dolore. Saepe alias accusantium suscipit recusandae.\n\nCupiditate a vel illo ullam deserunt. Dignissimos sint expedita modi itaque voluptas veritatis laboriosam. Repudiandae non voluptatibus possimus corporis quod quas accusantium. Suscipit ex quis eaque suscipit officia.\n\nSoluta porro tempora nemo. Voluptatum atque fugiat sequi. Debitis molestiae delectus minus.\n\nInventore quae optio tempore quaerat est. Cumque molestias officiis debitis quod delectus eius error. Illum soluta quos repellat minima aut explicabo nam. Quaerat voluptatum quas corrupti voluptates.	33.74	\N	2018-02-26 19:31:05.145095+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
168	Griffin-Little	Ducimus fugit soluta saepe officia nisi temporibus dolorum nemo. Nesciunt aut atque porro eaque cum. Aliquam molestias repudiandae voluptates. Sapiente unde consectetur at asperiores repudiandae nobis.\n\nPraesentium tempora sapiente sapiente. Delectus molestiae neque sequi natus. Exercitationem porro repudiandae magni dolorum sint necessitatibus facilis.\n\nEt totam debitis ipsam fugiat repellat explicabo dolore debitis. Voluptates tempora impedit cupiditate qui totam. Sequi et officia nisi facilis mollitia aperiam eos. Asperiores magnam officiis maxime.\n\nIste voluptatibus libero eveniet nobis. Nesciunt libero sit neque minus voluptas quas. Dignissimos maiores tempora impedit totam eum ducimus. Asperiores voluptatibus fugit eos necessitatibus.\n\nFacilis neque adipisci aliquid pariatur. Iure numquam ratione vitae esse pariatur libero. Delectus saepe voluptates laudantium dicta magni praesentium itaque iusto. Quos molestias inventore nostrum perferendis ipsum. Minus temporibus laudantium maiores assumenda ab ullam modi sequi.	20.41	\N	2018-02-26 19:31:05.200356+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
169	Bridges, Rice and Bruce	Facilis est corrupti quos necessitatibus. Illum aspernatur ad vitae pariatur cum consequuntur iure. Sit beatae deserunt architecto dolorem ducimus maiores omnis.\n\nAd ea doloremque cupiditate laboriosam aliquid accusamus. Nisi aliquam dolor reiciendis.\n\nAccusantium exercitationem ipsam ipsa ducimus. Harum nobis quas adipisci veritatis aperiam distinctio. Soluta odit possimus omnis vitae laborum quisquam assumenda. Maxime ullam est iste soluta atque incidunt accusamus.\n\nOdio sint eligendi molestiae modi omnis. Harum doloribus similique atque aliquid nihil maxime. Quidem ipsum enim accusantium aliquam nulla.\n\nSapiente tempore tenetur dolor at ut eaque. Ipsa dolor eaque eaque distinctio. Doloribus harum reiciendis commodi ad dolor alias numquam. Minus natus quam voluptate architecto voluptates cumque voluptatibus. Totam asperiores reiciendis minima quisquam eaque minima dicta eos.	41.82	\N	2018-02-26 19:31:05.288433+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
170	Brown-Gomez	Quia officiis sint consequatur quaerat omnis dolore. Minus labore inventore sed totam nihil. Animi nulla neque libero alias deleniti.\n\nQuos nihil mollitia neque unde earum. Culpa ipsum nostrum in alias cupiditate provident voluptate. Laborum totam dolorum aspernatur tempore quia nulla iure. Dignissimos ea asperiores ipsa quia quaerat.\n\nNobis dolores culpa beatae sunt repellat repudiandae. Quas dolor molestiae minus corporis iusto eum. Cupiditate rerum asperiores repellendus inventore.\n\nPlaceat eum non quae sequi tempora quisquam. Natus magni corrupti sunt ab officia placeat dolor. Saepe aperiam soluta iure beatae enim numquam cumque. Tempore atque doloribus dignissimos est nulla.\n\nExplicabo pariatur ea repellat occaecati recusandae. Similique at impedit impedit corporis modi atque. Provident recusandae quod doloremque laudantium.	89.61	\N	2018-02-26 19:31:05.355126+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
171	Marshall, Spencer and Miles	Suscipit deserunt eligendi ducimus magnam cupiditate deserunt beatae. In excepturi ut earum officia iure aliquid. Minus rem libero nostrum. Corporis tempora doloribus voluptate.\n\nOccaecati nemo doloribus dignissimos soluta cumque a. Quibusdam reiciendis enim nesciunt ex tempore voluptatibus ut. Nesciunt assumenda eligendi dolores ab maiores ducimus.\n\nProvident animi saepe dolore laborum. Aliquam odio ex deserunt inventore magni pariatur. Aut vitae velit consequatur expedita harum hic. Amet a voluptatem natus a labore. Enim quo ratione repellat vero natus.\n\nHarum architecto consectetur molestias quis. Mollitia pariatur error id assumenda magnam adipisci. Molestiae dicta reiciendis dolor modi. Rerum delectus consequatur doloremque pariatur. Ducimus architecto aliquam sequi laudantium.\n\nIpsam tempore beatae incidunt aperiam possimus nihil. Recusandae ducimus placeat ab dicta. Quibusdam numquam velit id dolorum nobis dolorem rem. Ullam nam beatae ipsam quis.	84.26	\N	2018-02-26 19:31:05.415593+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
192	Kaiser, Lester and Carpenter	Nihil dicta quo neque sapiente distinctio sequi nobis. Eos maxime labore vero aspernatur totam. Ducimus autem placeat deserunt. Soluta a vel esse sed.\n\nQuidem id accusantium alias repellendus fuga quidem error. Facere odio ipsa impedit accusantium. Reprehenderit illo laboriosam sunt labore.\n\nQuos occaecati quo iure quis. Voluptatibus alias eum quos rerum quo nemo officia.\n\nVoluptas voluptate soluta a earum voluptatum neque. Sunt ipsum aliquid maiores repellendus labore reprehenderit. Quod doloribus voluptatem necessitatibus saepe nam molestiae assumenda.\n\nPariatur excepturi culpa sequi. Illo ducimus facilis nemo quas placeat ex facilis. Molestias aliquam repudiandae molestiae at expedita aut repellendus. Laborum incidunt molestias quis quos odit beatae labore ex.	94.36	\N	2018-02-26 19:43:43.580623+00	2	"1"=>"1"	f	t
193	Smith-Johnson	Voluptas animi rerum pariatur nam incidunt consequatur. Dolore aperiam minus quo itaque doloribus odit.\n\nFugit voluptas soluta voluptas numquam corrupti maiores nostrum qui. Fugiat cum iusto cupiditate modi ad soluta. Saepe omnis maiores explicabo ad. Iure iure aut est autem ut.\n\nIusto non temporibus laudantium cum illum id adipisci. Facilis id aliquam unde a accusamus. Vel molestias omnis delectus blanditiis beatae quisquam. Consequuntur voluptates molestias sed magni inventore maxime.\n\nLibero aliquam voluptates dignissimos unde cupiditate facilis consequatur. Tempore voluptate non ipsam labore modi sequi. Sed delectus natus facere sed voluptatum nemo totam. Facilis saepe at praesentium odit.\n\nQuod nostrum voluptate nostrum distinctio. Rem ipsam quod asperiores dolorum dolorum iure voluptatum. Recusandae temporibus aut nemo veniam explicabo vero. Provident suscipit perferendis deserunt odit voluptate.	80.62	\N	2018-02-26 19:43:43.618949+00	2	"1"=>"1"	f	t
172	Walsh-Park	Dolores rerum dicta ab provident quod totam neque. Dolores itaque magnam vero impedit. Minima ex blanditiis totam saepe. Assumenda aliquam est accusantium ab eligendi velit. Consequatur rerum aliquam fugit nobis tenetur autem.\n\nEt praesentium dolor nobis delectus debitis fuga iure. Debitis veritatis iure reprehenderit accusantium possimus quod. Alias quos ea inventore inventore. Cumque optio ex ullam cum nisi.\n\nCupiditate tempore minima reprehenderit tempora. Molestiae quasi illo nesciunt eveniet impedit. Occaecati amet voluptas est labore voluptate explicabo quod.\n\nAnimi sunt blanditiis odit saepe nostrum praesentium. Quibusdam tempore nulla natus vero quibusdam pariatur. Occaecati suscipit omnis fugiat officia. Consectetur alias odio asperiores hic neque aperiam.\n\nOfficiis animi odio ipsam. Voluptatibus tempore vel vel delectus rem dolorem porro. Et at libero veritatis nostrum dolores aut quis nemo. Magnam aut rerum nulla in expedita commodi magni.	32.13	\N	2018-02-26 19:31:05.480121+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
173	Gentry and Sons	Dolorem praesentium at ab ducimus dicta tempora facilis. Ut doloremque rerum quaerat doloribus distinctio dignissimos. Tenetur aperiam voluptatibus odio iste omnis officiis. Ipsum animi dignissimos at eligendi temporibus voluptatibus sint.\n\nNecessitatibus sint assumenda rerum quaerat tempora. Occaecati nulla modi mollitia autem. Pariatur asperiores soluta reprehenderit veritatis hic temporibus architecto. Voluptatem exercitationem tempora nisi beatae quam.\n\nAutem et officiis sint ipsa omnis error. Autem quos provident ut inventore nesciunt. Sequi eligendi veniam rerum impedit ad.\n\nRecusandae omnis vero sed minima ex molestias doloribus. Exercitationem itaque incidunt placeat maiores. Dolore nam eum iusto occaecati nam alias delectus. Ad sequi molestiae praesentium distinctio quaerat sunt.\n\nNon voluptates dignissimos amet fuga natus illum porro temporibus. Odit officia nisi ipsam nobis voluptatibus provident. Corporis enim debitis temporibus id. Provident laborum velit ullam dolorum.	46.60	\N	2018-02-26 19:31:05.54761+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
174	Hart Ltd	Rem facere alias corrupti praesentium temporibus et. Reprehenderit quas repudiandae mollitia quibusdam vero est eveniet. Perferendis ut ut quaerat tempore nam esse consectetur. Ex numquam illo soluta doloremque doloremque sed perspiciatis a.\n\nPraesentium vel doloremque explicabo aperiam veritatis. Nam at recusandae reiciendis animi. Iure sed consequuntur beatae eius quisquam in.\n\nIn eaque sapiente debitis a ducimus nemo. Dolores delectus odio iure nihil nobis nulla. Repellat consequatur incidunt fugit dolorem consectetur itaque voluptate. Quaerat eligendi quo suscipit.\n\nConsequatur adipisci ullam adipisci distinctio. Est voluptates quas eaque illum fugit. Atque cumque hic molestiae eos reiciendis itaque. Praesentium ipsa tempore exercitationem amet cumque officia.\n\nIpsa tenetur illum nobis facilis quibusdam in cupiditate. Repellendus omnis voluptatum ullam sed eaque deleniti. Quisquam voluptatum omnis quasi cum illo possimus. Neque culpa quasi illum minima blanditiis. Possimus corrupti vero adipisci porro et.	61.31	\N	2018-02-26 19:31:05.592535+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
175	Wade, Rodriguez and Mason	Tenetur cupiditate quam laboriosam harum quam dolor ratione. Voluptate doloribus alias labore assumenda tenetur incidunt. Nihil officiis iste praesentium sequi quasi reprehenderit consectetur itaque.\n\nDignissimos dignissimos vero eveniet nihil modi ipsa nam. Nobis quod quasi iure perferendis in voluptatum. Sunt quos nobis earum dolore. Quos quas adipisci reiciendis quod unde fugiat consectetur. Molestiae id at labore velit similique dicta dignissimos sit.\n\nMaiores dicta soluta tenetur. Maiores dolores ut vitae quas esse rerum. Quaerat excepturi doloribus impedit tempore voluptatum quis iste.\n\nProvident quaerat inventore velit sint. Suscipit ratione fugit in labore eum alias quisquam. Temporibus dolores optio nisi voluptatibus doloribus beatae ad. Atque ipsa facilis similique consequatur esse.\n\nEos assumenda ut quibusdam consequatur laborum necessitatibus. Dolor cumque accusamus autem modi. Quas maxime quibusdam inventore perspiciatis ratione natus accusantium error. Nostrum amet perferendis eligendi. Dignissimos molestias soluta quod dolor iste.	23.86	\N	2018-02-26 19:31:05.664086+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
176	Pena, Terry and Wells	Doloremque blanditiis quia sunt earum. Doloribus vero voluptates delectus saepe adipisci veritatis corporis. Fuga et mollitia debitis necessitatibus rerum.\n\nNemo optio consequuntur provident excepturi. Numquam et voluptates consequuntur accusantium aut. Laudantium veritatis debitis repudiandae illo sed.\n\nReprehenderit amet reiciendis quaerat architecto. Quis doloremque temporibus eveniet. Voluptatibus fuga veniam occaecati cumque impedit corporis atque atque. Dignissimos omnis sit ad.\n\nMaiores itaque dolores consectetur veritatis libero cupiditate. Exercitationem adipisci aut nam delectus magni. Soluta consectetur veritatis modi quis placeat. Eligendi magni molestiae magni.\n\nTempora odio totam ipsum placeat quo. Incidunt sunt dicta expedita dolor. Doloribus asperiores illo aliquid magni beatae adipisci. Sit consequuntur ratione perferendis tempore quia quidem.	64.61	\N	2018-02-26 19:31:05.719421+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
177	Foster-Martinez	Soluta nobis quaerat facilis. Qui reprehenderit similique vitae doloribus aperiam nobis. Occaecati quos quo soluta. Facilis iusto magnam vitae recusandae molestias.\n\nExercitationem maiores nemo voluptas harum quasi. Culpa consequatur omnis impedit soluta. Molestiae exercitationem quasi minus. Labore numquam animi vel corrupti.\n\nVoluptatibus tempore porro minima dolorum. Et eligendi itaque minima ducimus ex magnam saepe. Quos nisi error ea cumque. Maxime eaque rerum repellendus ut accusamus aliquid.\n\nMollitia in enim dolore dignissimos dolore beatae cum. Iusto laborum officia repudiandae quos nam saepe maiores.\n\nIllum facilis culpa omnis nemo modi iure. Officia labore mollitia nostrum modi ut est illum. Quis qui soluta placeat soluta amet odio.	55.81	\N	2018-02-26 19:31:05.79208+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
178	Parker, Jimenez and Miller	Reiciendis incidunt necessitatibus culpa ipsa. Ipsum blanditiis recusandae non. Eum ut laudantium saepe eius repudiandae quod facere.\n\nHarum tempore quam eligendi at distinctio. Fuga illum consectetur saepe. Mollitia beatae molestiae quas quidem ipsam alias.\n\nRerum beatae cum optio. Quos sequi at nulla dolore.\n\nSequi odit harum veniam. Nam ab provident dignissimos voluptatibus aliquid quod velit nobis. Sed eum fugiat nihil repellat deleniti.\n\nExcepturi quis debitis aut neque. Corrupti quisquam dolorem doloremque corrupti cum quo dicta. Error explicabo expedita tempora dolorem omnis.	98.46	\N	2018-02-26 19:31:05.836121+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
207	Graham, Gomez and Barrera	Odio placeat ullam laborum laboriosam voluptatem. Assumenda corrupti porro unde cum accusamus explicabo nihil. Eaque veniam dicta eius ex cupiditate tenetur mollitia. Ratione harum distinctio doloribus facere cum.\n\nAliquam delectus optio facere debitis quos ad quis. Libero blanditiis autem at dolor dolorum totam. Error ipsum minima omnis animi ipsum.\n\nLaboriosam cupiditate voluptatibus a temporibus repellat itaque. Accusantium ad a dolore ab asperiores voluptatem labore. Laborum placeat deserunt doloremque laudantium perspiciatis hic expedita.\n\nEst pariatur maxime aliquid ab cum quo at. Nulla temporibus ipsum deleniti exercitationem doloribus nam. Iusto blanditiis sapiente hic.\n\nRerum consequatur similique illum laudantium. Adipisci doloremque beatae porro veritatis cumque ratione neque. Similique quibusdam veniam magni.	84.87	\N	2018-02-26 19:43:44.259991+00	3	"1"=>"1", "4"=>"8"	f	t
179	Hancock, Pena and Walker	Possimus beatae autem debitis. Sapiente beatae veniam inventore incidunt placeat ducimus. Dicta mollitia fugit quam.\n\nTotam maxime repudiandae cupiditate. Quia earum dolor iusto consectetur neque perspiciatis. Quidem rem excepturi officiis corporis corrupti illum ipsum. Ipsum quia nobis voluptatem perspiciatis libero.\n\nAsperiores laboriosam pariatur consequatur fugit aliquam odit doloribus laudantium. Facere accusamus laboriosam facilis molestiae hic. Illum hic libero atque ducimus rerum impedit fugiat. Aut tempore molestiae officiis minus placeat veniam. Reprehenderit dignissimos quibusdam totam amet possimus aspernatur dolor repudiandae.\n\nMaiores accusantium ea praesentium recusandae. Voluptas odio culpa eius voluptas explicabo in. Ipsam autem voluptatem earum nesciunt modi blanditiis. Minima adipisci esse ut maiores corrupti facere sunt modi.\n\nPossimus maxime asperiores cumque velit dolorem dolorum iure. Inventore commodi hic aliquam. In quas tenetur laboriosam ab provident veniam a.	76.98	\N	2018-02-26 19:31:05.880835+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
180	Black, Hill and Clark	Blanditiis tenetur culpa eos aspernatur aliquid dolore libero architecto. Perferendis neque harum eius cupiditate a aperiam. Facere quo aliquam tenetur voluptate quaerat.\n\nIllo esse iure tempore asperiores distinctio error reiciendis. Voluptatem occaecati deserunt perspiciatis dolorem reiciendis voluptates laboriosam. Veritatis assumenda dolorum iste dolorem nam laboriosam illo. Voluptates quasi corporis expedita vel totam.\n\nIusto quis quis ad impedit deserunt. Porro repellendus natus nemo. Unde eaque eum quia ad illum quos.\n\nDoloremque eveniet modi iusto rem aut pariatur. Vero doloremque nisi ipsa. Quidem dicta id velit nam non iste quidem at. Nisi dignissimos eum quos at.\n\nVoluptas atque natus tempore fuga ab. Labore fugiat eius libero impedit voluptatibus nostrum. Nesciunt perspiciatis ea aut labore. Quibusdam hic nemo accusamus impedit soluta illum.	71.18	\N	2018-02-26 19:31:05.939345+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
181	Smith and Sons	Reiciendis earum veniam excepturi quibusdam. Incidunt molestias perspiciatis ea voluptatum debitis. Voluptatum repellendus provident quam incidunt maxime eos. Alias rerum sit sed adipisci nobis.\n\nItaque sequi neque hic occaecati. Dolore doloremque et quam voluptatum quisquam corporis eveniet. Esse earum iusto ipsa officiis. Quae amet possimus perspiciatis enim.\n\nPlaceat perferendis illum minus nobis suscipit minima in. Voluptates vitae est nobis nobis magni delectus nihil. Non totam voluptatum ut eius cupiditate. Reiciendis nesciunt non mollitia aperiam iste cumque nisi optio. Aspernatur mollitia reprehenderit deserunt magni impedit magnam.\n\nPlaceat veniam illum ducimus odit dolore. Cum error explicabo alias error delectus earum. Veniam explicabo sit ut voluptatum minus. Labore nulla enim laudantium facilis ducimus eligendi. Quidem est voluptates molestias aspernatur error reprehenderit laudantium.\n\nVoluptatum necessitatibus natus temporibus nesciunt. Architecto distinctio voluptatibus ab nisi ut blanditiis. Fuga voluptatum suscipit reprehenderit ipsum impedit consectetur.	71.70	\N	2018-02-26 19:43:42.877694+00	1	"1"=>"1", "2"=>"2"	f	t
182	Spencer, Evans and Todd	Itaque exercitationem ipsum dolorem adipisci. Qui id dolor temporibus. Distinctio aliquam provident accusantium sunt. Explicabo nam facere amet dolorum quod nobis.\n\nMaiores dolores enim similique reprehenderit minus earum. Magnam velit vitae natus quis. Commodi fuga minima nisi tempora quisquam recusandae magnam modi.\n\nAdipisci suscipit porro dolores enim voluptates maiores. Cupiditate veniam dicta hic voluptate molestiae. Beatae quas maiores dicta eveniet consectetur deserunt occaecati natus. Incidunt vel nam modi doloremque. Cumque soluta magni eos nostrum harum sed molestiae.\n\nExpedita corrupti voluptatibus nulla maiores iste debitis eaque. Hic pariatur qui fugiat quo. Officiis accusantium sequi magnam laborum quam dignissimos. Pariatur minima earum doloribus repellat qui alias a.\n\nMagni quas aut laudantium ducimus ea. Quisquam libero omnis laboriosam ad porro vitae. Earum ipsa natus minima maiores eum debitis.	4.51	\N	2018-02-26 19:43:43.004153+00	1	"1"=>"1", "2"=>"2"	f	t
183	Clark and Sons	Dignissimos eum nihil id repudiandae. Illo reprehenderit provident quisquam. Tempore magni nulla laboriosam dolore.\n\nAt sit ratione pariatur. Suscipit excepturi voluptatem ipsum culpa voluptatem quaerat nihil. Cupiditate deleniti ipsam numquam sit. Sed sint nisi quasi voluptatum temporibus tempore nostrum atque. Nihil ducimus temporibus perferendis.\n\nHic cum reprehenderit facilis doloremque ullam itaque. Dolorem ipsam aliquid explicabo maiores voluptatibus. Possimus quae at cum minus ex consectetur. Nostrum quo tenetur laboriosam. Officiis sunt quo molestiae eum fuga voluptate.\n\nAut assumenda suscipit fuga veritatis nobis dicta doloremque. Cum deserunt dolore architecto fuga error repellendus quo.\n\nNon quibusdam odio consectetur. Necessitatibus voluptatum hic ratione velit amet repudiandae asperiores. Corporis laboriosam similique doloribus accusantium natus. Aliquid at delectus molestias sequi magni. Eveniet provident vel quas perspiciatis neque.	32.34	\N	2018-02-26 19:43:43.043241+00	1	"1"=>"1", "2"=>"3"	f	t
184	Zamora-Beard	Culpa nihil ut veritatis rerum impedit. Eveniet maxime aut nostrum quos.\n\nRepellat quos ad quaerat eligendi cum unde. Illo vitae quasi eligendi possimus nesciunt facere. Odit recusandae assumenda explicabo distinctio rerum at id.\n\nVoluptates consequuntur corrupti velit quos assumenda. Harum eveniet cupiditate voluptas dolor illo magnam asperiores. Blanditiis asperiores mollitia quia tenetur cumque illo maxime quod.\n\nQuidem accusantium fuga quo ab tempore voluptatum magni eaque. Possimus laudantium non sequi nisi. A reprehenderit voluptatem velit eligendi a ullam suscipit. Praesentium minus aliquid eum natus.\n\nUllam eligendi nihil doloribus suscipit temporibus. Occaecati nulla corrupti quisquam sed. Ipsam occaecati omnis facilis eveniet libero neque.	46.99	\N	2018-02-26 19:43:43.106701+00	1	"1"=>"1", "2"=>"2"	f	t
208	Miller-Lee	Velit culpa ipsam nobis itaque doloribus. Impedit quasi recusandae numquam repudiandae. Nulla voluptatibus provident beatae magnam ad iste.\n\nMolestiae odio voluptas impedit ut voluptatum ipsam. Quas doloribus ex nam accusantium enim nam ducimus. Quia vero nesciunt vel quaerat maiores.\n\nAd esse nam quisquam qui. Ut fuga natus sapiente ex. Ea facere minima voluptatum amet. Architecto suscipit nesciunt maxime similique dolor magnam.\n\nHic autem error itaque alias doloribus ex rerum nulla. Eaque vel cum maiores facilis molestiae atque exercitationem. A dolorem est quam et esse itaque nemo. Optio pariatur sunt veritatis illo vero voluptatibus.\n\nRepellat iure blanditiis soluta. Placeat illum aliquam tempore velit libero a autem. Fuga libero ipsa dicta animi perspiciatis. Delectus optio eius soluta.	95.30	\N	2018-02-26 19:43:44.313582+00	3	"1"=>"1", "4"=>"8"	f	t
274	Chambers Group	Possimus reprehenderit voluptates voluptas explicabo eum. Dolore velit harum iste molestiae.\n\nExplicabo odio iste fugit hic voluptas voluptatum maxime. Distinctio quo tempore at commodi dolor. Exercitationem officia cumque voluptatum ea. Architecto aliquid aut tenetur natus suscipit incidunt ut.\n\nFacere praesentium officiis illo laboriosam libero occaecati. Eligendi tenetur id provident tenetur soluta voluptatem. Beatae officia voluptate tempora excepturi.\n\nCupiditate repellat voluptatem nesciunt vero minus aliquam. Provident quos natus ut aliquam. Fuga nostrum eveniet facilis quam.\n\nOptio fugit porro accusamus commodi. Totam assumenda non ullam atque distinctio. Harum consequuntur incidunt ratione quae eum.	72.90	\N	2018-03-02 17:24:06.493314+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
185	Bridges Group	Doloribus delectus ipsam ratione. Unde sit tempora nisi exercitationem alias odio officia. Veritatis ea iure blanditiis totam corporis non occaecati.\n\nExcepturi fuga delectus neque dolore facilis sunt. Adipisci veritatis molestiae alias ex recusandae deserunt. Nisi amet nemo magni laboriosam maiores saepe ipsam. Animi ad ab nemo neque vero repudiandae.\n\nVoluptatum occaecati incidunt atque. Doloremque recusandae atque commodi quos nihil numquam ipsa. Eum nobis quos numquam.\n\nEst reiciendis hic enim nulla accusantium. Dignissimos temporibus impedit nihil doloribus voluptatem quos ipsa tempora. Ipsam praesentium ipsam quae voluptatem mollitia ad. Error fugiat quisquam aperiam dolorum et.\n\nCommodi nihil repellat repellat voluptatum distinctio. Facere qui labore quod iusto quaerat veritatis perferendis voluptates. Quam ducimus nulla amet fugit. Dicta eos modi reiciendis facilis reiciendis neque.	42.46	\N	2018-02-26 19:43:43.165534+00	1	"1"=>"1", "2"=>"3"	f	t
186	Erickson Inc	Similique quod doloribus excepturi placeat impedit reiciendis. Nobis sed quo officia ad iusto debitis. Quas rerum quasi fugit nisi amet praesentium. Blanditiis et consequuntur officia similique sint ad.\n\nDicta rem vitae labore omnis atque quaerat. Ratione quaerat animi quidem provident dolores qui perferendis magnam. Debitis sit blanditiis corporis eveniet laborum aspernatur quo. Minus est facere magni.\n\nAutem doloremque reiciendis optio hic. Praesentium libero eaque laudantium nihil quis. Temporibus est molestiae aut.\n\nSint eaque delectus quis aut unde iure. Sequi temporibus nihil saepe beatae odio ad. Voluptates praesentium alias magni atque sed nihil ratione. A inventore iure et possimus. Excepturi quis facilis officiis officia.\n\nNumquam fugit id illo nam. Dolorem ea excepturi dolores illo cupiditate ut dignissimos.	86.60	\N	2018-02-26 19:43:43.223417+00	1	"1"=>"1", "2"=>"2"	f	t
187	Smith-Morales	Aperiam sit commodi distinctio explicabo impedit dolorem fuga. Impedit accusamus aliquid autem illo sit debitis. Unde vel debitis amet quaerat.\n\nDeleniti animi nemo neque occaecati voluptas aliquid. Ducimus distinctio iusto magnam perferendis temporibus dolorem. Perferendis rerum excepturi doloremque hic ullam minima repudiandae.\n\nTempore iure expedita corporis commodi. Esse cupiditate ipsa eaque soluta animi tempore facilis. Suscipit ut tenetur ea esse.\n\nQuas ipsam iusto modi inventore. Culpa at voluptatum sapiente ab dignissimos. Voluptatum tempore dolores possimus quaerat doloremque. Impedit aut eveniet velit.\n\nDolorem cumque incidunt eveniet tempora tempore. Odit quis eaque assumenda repellat sit debitis.	48.80	\N	2018-02-26 19:43:43.281742+00	1	"1"=>"1", "2"=>"3"	f	t
188	Wood, Williams and Blair	Optio aliquid tempora molestias ipsam sit. Eaque unde in quidem necessitatibus veritatis aperiam harum. Atque qui blanditiis maxime accusantium similique exercitationem architecto. Totam magni veniam excepturi quia. Voluptatibus laboriosam corporis placeat sint quae nihil culpa.\n\nQuae nemo reprehenderit eum eos id reprehenderit. Quidem vero exercitationem ab incidunt esse assumenda. Illum minima possimus nostrum praesentium. Magnam atque consequuntur perferendis magni. Itaque quae fuga beatae ipsa ipsam fugiat.\n\nFacilis sunt iusto eaque. Dolor modi nemo voluptatibus. Officia nesciunt eius hic dolorum. Aspernatur pariatur qui nesciunt nam impedit iusto.\n\nEos suscipit iure quidem officia similique. Provident dicta quam consequuntur temporibus commodi sed voluptas at. Et facilis consequuntur aspernatur voluptatem odio.\n\nQuos sapiente ea odio. Exercitationem accusantium assumenda necessitatibus error inventore.	19.12	\N	2018-02-26 19:43:43.340656+00	1	"1"=>"1", "2"=>"2"	f	t
189	Smith-Sosa	Iste sint modi animi tenetur at at. Eaque dignissimos vero reprehenderit quisquam dicta eum. Nam velit quidem necessitatibus non illo.\n\nProvident sit iste aspernatur. Deserunt placeat quisquam quibusdam quasi. Odio voluptatibus ducimus consectetur quidem.\n\nSint rem repellendus in qui laborum distinctio dolorem. Maxime laudantium reprehenderit est quaerat voluptas vel minus iure. At quia iusto nihil delectus odio perspiciatis.\n\nUt in sed omnis totam. Voluptate rem vero optio repellat earum ratione.\n\nRatione quos labore cupiditate cupiditate aperiam. Iste alias quos odit illo facere reiciendis. Voluptate similique expedita quia incidunt veniam magnam recusandae vitae. Tempora pariatur magnam ex nesciunt provident maxime amet quia.	28.00	\N	2018-02-26 19:43:43.408386+00	1	"1"=>"1", "2"=>"2"	f	t
190	Pham, Wise and Gilmore	Perspiciatis quia recusandae ullam tempore. Cum praesentium voluptatem magni cum animi soluta in. Numquam sint aut cupiditate voluptas maiores autem quaerat. Unde dicta voluptates assumenda dolor debitis unde.\n\nMagnam officia molestias suscipit nesciunt adipisci earum. Nobis ea quis nostrum ratione ad voluptate. Aspernatur deleniti fugiat aspernatur voluptas.\n\nPariatur esse accusantium temporibus. Porro magni rerum corrupti doloremque minus deserunt cum excepturi. Repudiandae totam molestias iusto totam doloribus veritatis.\n\nBlanditiis nostrum tempora esse necessitatibus ipsum aut. Animi fugiat numquam incidunt nemo totam. Ducimus minima numquam molestiae excepturi facere aspernatur. Nam dolores odit delectus maiores.\n\nQuae praesentium voluptatem ea nam. Sapiente assumenda nostrum libero dolorem. Aperiam eum blanditiis blanditiis excepturi ea molestiae aliquid.	71.61	\N	2018-02-26 19:43:43.476975+00	1	"1"=>"1", "2"=>"3"	f	t
191	Huber Ltd	Magni incidunt amet reprehenderit temporibus expedita voluptatum. Fugiat nostrum culpa error rem. Voluptatum ducimus quae natus facere. Sed exercitationem enim quo expedita corporis.\n\nIpsam modi aut consequatur velit. Corporis hic eos quidem numquam cum. Nulla deserunt repudiandae voluptatum repudiandae odio ducimus. Placeat ipsam nisi incidunt consequuntur.\n\nAdipisci ex amet facere dolorum. Amet sit accusantium unde numquam eveniet quis animi id. Voluptatem facilis nesciunt harum sequi sint sint quos distinctio. Perferendis beatae ut ut ea consequuntur optio ipsam. Officiis architecto cupiditate cumque quas doloremque assumenda dolorem.\n\nQuibusdam provident inventore quas. Consequatur vel at animi sed reprehenderit sed quae. Quam exercitationem iusto similique magni.\n\nDolorem sed dolorem odio recusandae odit. Debitis officiis voluptatum itaque dolor soluta porro. Natus eligendi soluta et repellat animi commodi.	94.64	\N	2018-02-26 19:43:43.540077+00	2	"1"=>"1"	f	t
194	Ford-Lane	Saepe in aliquam error tenetur cum culpa molestiae. Minima soluta corporis exercitationem. Corrupti quo laborum quisquam animi voluptate a quis provident. Ipsum impedit deleniti enim quaerat eaque.\n\nAut unde adipisci fugiat accusantium. Ipsam magnam officia illo consequatur dolor rerum. Fugiat nemo quia iure natus incidunt vel saepe. Saepe voluptatum aperiam voluptates neque explicabo dolorem.\n\nEa quae fugit ipsa porro. Ratione accusamus veritatis quasi ea inventore aperiam aperiam. Sed neque consequuntur perspiciatis error ipsa consequatur unde. Sint error minima quo dignissimos culpa cumque omnis.\n\nAspernatur esse doloribus quo voluptatibus iure. Quod nihil rerum consectetur quia nihil maxime qui animi. Doloremque reiciendis nesciunt ex fuga. Qui vel sequi sunt mollitia ipsum adipisci unde.\n\nMaxime ipsam voluptate illum saepe. Fugit illum corrupti minus. Esse dolorem iure animi tempora eveniet minima labore. Ullam qui quam atque labore aperiam animi.	27.74	\N	2018-02-26 19:43:43.670983+00	2	"1"=>"1"	f	t
195	Smith Group	Voluptates vero voluptatibus itaque similique doloremque dolores provident. Iure natus porro quibusdam aperiam delectus. Odit quaerat suscipit est repellat suscipit rem accusantium.\n\nCumque minima inventore itaque reprehenderit minima eveniet illo. Nisi pariatur eveniet perspiciatis tempora quasi animi. Voluptatibus ea odio necessitatibus. Maiores illum excepturi ratione necessitatibus dolorem.\n\nQuisquam quo libero excepturi. Debitis corporis tenetur blanditiis voluptatum quo. Neque ad ducimus quam et. Deserunt impedit officia doloribus dolores quidem dignissimos illo.\n\nVoluptatum molestiae nisi veniam sapiente. Itaque ab veniam velit consequatur nostrum. Ab animi molestias error exercitationem ea porro.\n\nNulla placeat mollitia molestiae alias facere impedit provident. Voluptates explicabo magnam consequuntur saepe eos optio voluptates doloremque. Odio cumque sapiente voluptatem soluta quaerat.	24.82	\N	2018-02-26 19:43:43.701088+00	2	"1"=>"1"	f	t
196	Jacobson, Ward and Levine	Libero error quas molestias cupiditate. Qui blanditiis eaque ad pariatur earum rem rerum. Modi rem numquam animi voluptatem est amet consequatur officia.\n\nPorro maiores eos facere accusamus quibusdam. Similique nihil quaerat debitis quam itaque similique soluta. Nesciunt voluptates ab laboriosam iure.\n\nSaepe id corporis nostrum sint. Labore pariatur praesentium odio quis dignissimos iure. Laborum officia laborum debitis velit odit inventore asperiores.\n\nCupiditate quis debitis distinctio voluptatem aspernatur. Impedit distinctio est quaerat recusandae neque quis omnis. Facere nisi sapiente rerum quos maiores voluptatem.\n\nNulla corrupti unde error sunt. Consectetur optio enim sapiente. Cumque fugiat similique ipsum laborum blanditiis.	44.81	\N	2018-02-26 19:43:43.731032+00	2	"1"=>"1"	f	t
197	Church-Lewis	A ratione ipsa hic cum veritatis. Velit minus illum sunt voluptatibus harum. Porro velit pariatur officiis cum distinctio hic nemo. Sint praesentium harum dolorem magnam libero soluta.\n\nExercitationem rerum voluptatem aperiam nostrum consectetur quaerat id. Inventore eius architecto illo officia itaque. Nisi veniam tempore quis dolore.\n\nReprehenderit voluptas autem voluptate rerum magni autem vitae. Accusantium similique suscipit velit blanditiis. Adipisci sed molestiae totam rem. Vel voluptatem delectus adipisci architecto distinctio.\n\nVeritatis voluptatibus libero atque enim molestiae ipsa. Recusandae corporis adipisci laudantium voluptate ratione. Corrupti autem tempore doloremque perspiciatis enim recusandae iure.\n\nDeserunt tempore architecto porro aut est. Delectus velit soluta illum rerum explicabo et. Sint nihil veniam harum labore officia. Dolorum minus tempore sed non officiis ullam officiis.	81.23	\N	2018-02-26 19:43:43.767831+00	2	"1"=>"1"	f	t
198	Smith, Wright and Brown	Provident illo error libero non sapiente dolor. Amet non natus eum dicta animi. Consequatur sapiente iure eveniet repellendus deserunt sapiente facere. Corporis vel quia minus ea doloremque.\n\nFuga commodi repudiandae laudantium deleniti accusantium blanditiis nemo. Vero cumque eum ullam est veniam. Amet eos similique facilis culpa.\n\nFuga dolores iste amet quos vel. Iste iure minima molestias sit officia dolorem. Ullam ullam quas amet sit. Quibusdam modi natus nisi error at enim autem praesentium.\n\nSaepe deleniti aliquid odio vero veniam numquam quaerat. Inventore quas possimus ab explicabo natus laboriosam rem. Neque facere vero nobis voluptatum magni. Dolores adipisci repellendus delectus illum. Maxime repellat explicabo ut quaerat rem similique iure expedita.\n\nFugit corrupti nemo magnam vel culpa iusto molestias fugiat. Esse sequi officiis debitis exercitationem quam. Ab repellat voluptatibus nobis blanditiis. Porro doloremque neque laudantium.	78.60	\N	2018-02-26 19:43:43.807194+00	2	"1"=>"1"	f	t
199	Romero LLC	Labore itaque ipsa dolores nesciunt quis. Cum iure illum corporis provident. Voluptatibus iste repellat saepe cupiditate nesciunt voluptatem. Repellendus ipsam architecto aliquid eveniet ipsum. Quod placeat veritatis cupiditate nemo cupiditate nesciunt excepturi pariatur.\n\nAmet blanditiis explicabo aperiam similique. Omnis magni quas maxime. Dignissimos tempora saepe dolores quae sunt voluptatem.\n\nRatione itaque tempora quae suscipit voluptatum consequatur. Magni debitis ipsum tempora officia. Architecto dicta numquam tempore officia. Amet est pariatur repellendus voluptates quod aliquid assumenda.\n\nHarum nobis amet iure voluptas. Dignissimos eaque nihil dolore nemo illo minima quis. Quo quae at veritatis vitae.\n\nItaque et quidem rerum deleniti eaque officia architecto assumenda. Quibusdam vero fugiat laborum nostrum aperiam totam atque vitae. Consequuntur atque ea similique sit. Omnis suscipit eaque harum.	23.78	\N	2018-02-26 19:43:43.848896+00	2	"1"=>"1"	f	t
209	Wade-Booker	Eos aliquid recusandae nulla deserunt. Perspiciatis voluptatum distinctio quidem. At vitae eligendi illum perferendis itaque enim ducimus.\n\nVoluptatibus consectetur ducimus quisquam adipisci. Mollitia possimus quis debitis distinctio amet sint eos a. Voluptatem vel laborum esse enim facere. Molestiae laborum in quas natus suscipit.\n\nSapiente odio praesentium enim sunt. Dicta excepturi porro ratione quibusdam. Ratione veritatis iusto soluta alias. Atque officia repellendus tenetur ut possimus possimus quis.\n\nIpsam tempore quas impedit magnam quidem suscipit quam. Doloribus saepe illum ut eum eveniet. Excepturi repellendus cumque facere.\n\nPorro veritatis deleniti doloremque libero cum odit error. Tempora eos nam culpa perferendis possimus. Expedita aspernatur nihil veritatis laborum possimus expedita nam. Magnam fugit alias doloremque magnam itaque.	84.18	\N	2018-02-26 19:43:44.377827+00	3	"1"=>"1", "4"=>"8"	f	t
200	Olsen and Sons	Sed molestias excepturi blanditiis consectetur soluta soluta. Suscipit pariatur corrupti molestiae consectetur nesciunt enim quam. Voluptates voluptatem aspernatur laborum voluptatem quaerat saepe. Quibusdam hic nisi ex.\n\nDignissimos unde quam est molestias. Placeat aliquam ab nesciunt illum. Fugit enim quod autem amet earum quod reprehenderit.\n\nSit aspernatur adipisci beatae alias est. Minima ut ad facilis quis beatae dolorem aliquam. Facilis modi rerum sunt atque aspernatur saepe rem. Nisi mollitia quaerat quam quam reiciendis nesciunt autem.\n\nNumquam quaerat non atque accusantium inventore eius. Sunt minima minima provident dolores dolore occaecati consectetur. Maiores perspiciatis consequuntur unde perspiciatis ea ipsam quo. Maiores provident sapiente quas commodi inventore necessitatibus.\n\nLaudantium architecto quaerat natus. Distinctio fugiat deleniti placeat fuga eius dicta sed. Ex dolorum accusantium neque necessitatibus fuga vitae earum. Nesciunt nobis quia excepturi illo dolorem atque eveniet.	49.25	\N	2018-02-26 19:43:43.889679+00	2	"1"=>"1"	f	t
201	Turner LLC	Voluptatibus necessitatibus voluptate nostrum. Accusantium alias vero quisquam corporis corrupti vitae libero tempore.\n\nQuae quod nobis voluptatem quae velit. Minus harum distinctio fuga molestiae ut. Nesciunt a culpa quas cupiditate pariatur eos possimus placeat. Voluptatem quae tenetur mollitia sit officia consectetur fuga.\n\nCorrupti mollitia deleniti quia perferendis. Ullam ea deleniti aperiam dolore. Accusantium aut doloribus occaecati temporibus quae vitae repellat.\n\nLabore ea unde ut quam et est illo. Totam magni ea eum incidunt autem temporibus nisi. Sapiente sit ea consequatur maxime. Delectus sequi perferendis ab eligendi vero ratione officiis.\n\nArchitecto cupiditate minus delectus vitae qui reprehenderit ab. Enim nisi molestiae optio voluptates aliquam facilis. Dolorem a enim animi voluptatem sequi.	18.65	\N	2018-02-26 19:43:43.931988+00	3	"1"=>"1", "4"=>"8"	f	t
202	Krueger-Morgan	Architecto quae aut id non veniam voluptate atque. Modi quos illo sint eveniet aut. Minima quaerat nesciunt adipisci excepturi quibusdam.\n\nOdit laudantium qui odio sed saepe occaecati. Magnam pariatur accusamus repellat nobis.\n\nCupiditate porro iusto voluptates tempore voluptate officia. Molestias dolorum nostrum dolores repellendus tempora. Laudantium itaque consequatur perferendis eveniet corrupti. Enim et explicabo minima quas ipsam repellat.\n\nExcepturi tempore omnis facere. Praesentium veritatis eaque perspiciatis. Adipisci qui occaecati tempora iusto in culpa voluptatem. Qui optio tenetur ea ratione libero a est minima.\n\nDolorem commodi vel officiis harum non. Consequatur iure quos autem eum incidunt. Asperiores ex error rerum recusandae veniam laborum esse facere.	70.54	\N	2018-02-26 19:43:43.979169+00	3	"1"=>"1", "4"=>"9"	f	t
203	Thompson, Woods and Hughes	Deserunt alias minus necessitatibus ipsum tenetur laboriosam impedit. Quasi dolorum repellendus repellendus inventore quis.\n\nEius perspiciatis doloremque ipsum quidem laudantium. Ducimus culpa illum odio eveniet enim. Aspernatur exercitationem eaque fuga corporis. Voluptatum deleniti nisi id facilis dolorem iste.\n\nDolorem magni et fugit eligendi. Recusandae cumque sint ab esse doloribus rerum.\n\nAspernatur sint nobis pariatur. Laudantium laborum quos ducimus inventore consectetur sit nesciunt dolore.\n\nNeque quaerat recusandae cum explicabo sapiente recusandae recusandae. Assumenda totam eos cupiditate. Consectetur cupiditate possimus aliquam.	76.38	\N	2018-02-26 19:43:44.039606+00	3	"1"=>"1", "4"=>"9"	f	t
204	Wright, Brown and Robinson	Eveniet sed eaque culpa sequi recusandae. Nostrum repellat eum dolorum laboriosam distinctio esse. Illo iure temporibus rerum iusto soluta iste omnis.\n\nEt iure quidem esse. Iste enim ut sapiente eveniet cupiditate quo.\n\nVoluptatibus laboriosam asperiores ut accusamus mollitia ab. Accusantium quo molestias tempore doloribus. Maiores quaerat omnis ad similique. Quibusdam accusantium esse totam eligendi consectetur nostrum velit.\n\nSuscipit rerum minima esse et odio ratione. Saepe dignissimos eaque quas magni maxime cum eaque. Molestias odio eveniet cumque. Impedit amet id quas ipsum ducimus saepe totam.\n\nEst consequuntur eaque doloremque doloremque quasi. Repudiandae aliquid maxime perspiciatis. Accusamus ipsam minima quisquam necessitatibus odio.	2.99	\N	2018-02-26 19:43:44.09284+00	3	"1"=>"1", "4"=>"9"	f	t
205	Whitaker Group	Animi facere a architecto veniam repellendus. Reprehenderit itaque consequatur sunt suscipit cum. Dolorem accusantium praesentium exercitationem deserunt voluptatem rerum dolorum. Occaecati eaque veritatis id eos voluptatibus ullam dolor.\n\nVelit doloremque earum adipisci ipsam recusandae soluta distinctio. Atque saepe fuga quas magnam debitis minima. Autem sit vel accusantium ducimus.\n\nConsectetur provident architecto fuga. Temporibus fugit quaerat velit non sint aliquam consequuntur. Illum sit exercitationem earum aspernatur debitis. Dolore recusandae distinctio inventore aliquam quidem.\n\nOdit nam esse in voluptas delectus quas minima iste. Atque soluta voluptates at unde numquam. Non nostrum voluptates in itaque vitae tempora. Repellendus cupiditate corporis esse mollitia sint.\n\nNeque ab eveniet inventore. Exercitationem alias id nulla sapiente commodi illum corporis. Voluptatibus magnam enim animi explicabo maiores perspiciatis. Praesentium architecto iste sapiente.	8.42	\N	2018-02-26 19:43:44.151563+00	3	"1"=>"1", "4"=>"8"	f	t
206	Parks, Haynes and Kim	Porro odio vel similique ex ullam nostrum. Autem eveniet quia neque quibusdam fuga. Eos eveniet molestiae asperiores accusantium temporibus atque.\n\nHarum iusto mollitia eum eaque. Dolor fugit pariatur unde doloribus ipsa voluptas. Reiciendis rem accusantium error corporis asperiores sit corrupti.\n\nProvident ut expedita beatae eius accusantium ullam minus. Tenetur impedit quia natus earum iure. Quibusdam occaecati suscipit repellendus commodi. At laboriosam voluptatibus consectetur et iure totam.\n\nLaudantium sunt expedita quisquam incidunt labore. Nobis adipisci numquam incidunt earum quaerat aliquid. Quod hic quaerat illum ipsam at. Excepturi enim dolore sapiente non facilis natus nostrum.\n\nQuod ipsa dolores quasi a sit reprehenderit sit. Eligendi perspiciatis assumenda officia dolore. Iure quis eligendi totam maxime. Rerum illo est voluptatum aspernatur blanditiis.	26.40	\N	2018-02-26 19:43:44.208737+00	3	"1"=>"1", "4"=>"8"	f	t
212	Barton-Reed	Facere nulla perspiciatis sit provident ab quasi. Odio architecto qui itaque voluptatum magnam id saepe. Pariatur ipsum necessitatibus distinctio nemo. Eveniet expedita nihil tempore sunt dignissimos.\n\nExpedita atque sapiente unde ad accusantium. Perferendis tenetur quas nisi voluptas fugiat consequuntur numquam porro. Sequi deleniti assumenda reiciendis laboriosam distinctio.\n\nLabore quisquam praesentium reiciendis vel. Reiciendis dicta adipisci sequi adipisci voluptatem. Veritatis aliquam minus ad ut suscipit incidunt dignissimos. Optio dolorum officiis est illum.\n\nVoluptatum dolores eos molestias perferendis. Mollitia voluptatum maiores fugiat corrupti asperiores dolorem occaecati reprehenderit. Voluptatum saepe maiores alias libero beatae.\n\nFacilis quod dignissimos ut qui. Inventore labore dolor cum commodi aperiam. Laudantium officia similique quibusdam illum ipsam cum voluptatum non. Error veritatis eos blanditiis in architecto unde.	46.57	\N	2018-02-26 19:43:44.588728+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
213	Moore Ltd	Sequi optio quasi quaerat incidunt minima. Itaque itaque aliquam natus labore ducimus iste.\n\nSaepe corporis facilis id ipsum fuga quod eligendi. Soluta facilis aut aliquam autem cumque ducimus in. Sunt facere delectus ducimus quasi iusto eius voluptatem facilis. Accusantium quasi consectetur maiores minima error inventore voluptates ad.\n\nReiciendis dolorem enim facilis sunt rerum cumque. Nam inventore voluptatum provident iusto quo ipsa. Mollitia ut veritatis odio in adipisci. Amet ea corporis ipsum assumenda. Id adipisci numquam fuga suscipit.\n\nDoloremque debitis nulla voluptatibus sapiente. Iusto commodi deserunt alias et. Voluptatem repellat dolore earum impedit tenetur cupiditate illum. Iure accusantium voluptatibus odit occaecati sed repellat est pariatur.\n\nConsectetur repellat suscipit voluptatum asperiores reprehenderit quam. Autem beatae ipsum nihil delectus illo fugit nulla. Ex officiis impedit suscipit provident sunt iure. Quae hic dignissimos culpa labore.	59.30	\N	2018-02-26 19:43:44.67111+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
214	Clark LLC	Amet debitis dolore similique. Magni perspiciatis doloremque qui voluptatum qui. Accusantium cum minus accusamus tempora qui at reprehenderit. Possimus cumque repudiandae reprehenderit error voluptates temporibus a.\n\nOdio tenetur odit sint vel quo nihil alias. Velit consectetur reprehenderit facere exercitationem voluptatum porro. Nam velit excepturi nemo asperiores.\n\nOfficia pariatur aperiam recusandae a doloribus deserunt. Minima saepe ad dolores atque. Beatae necessitatibus laborum modi quam ut et iure eveniet. Aliquam soluta iste quas nihil doloremque.\n\nOfficiis expedita vero possimus cupiditate magni voluptas exercitationem. Quod hic veniam aliquam recusandae cum repellendus quos placeat. Molestias debitis at perspiciatis. Accusamus sequi inventore ipsum quasi.\n\nQuibusdam quos voluptatibus unde non repellendus dolore quas error. Excepturi ipsum blanditiis perferendis voluptas. Voluptas dolorum corrupti minus voluptatum tempora animi consectetur sit. Necessitatibus quasi quasi fuga.	72.33	\N	2018-02-26 19:43:44.750912+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
215	Carpenter, Figueroa and Owen	Modi possimus vero quae. Maxime quo porro deleniti quod.\n\nAmet eaque quasi vitae repellat nulla quo. Id minus quaerat distinctio alias. Cupiditate quibusdam cumque excepturi doloribus. Ipsam hic libero voluptates nihil consequatur reiciendis.\n\nRerum quas non atque impedit delectus voluptatem in exercitationem. Ipsa ipsum vitae vel explicabo.\n\nAliquid nobis animi non. Laudantium rerum maxime consectetur distinctio. Cum tenetur corrupti nemo officiis neque consequuntur.\n\nMagnam quisquam quod quod delectus accusamus. Ducimus consequuntur fugit eligendi commodi illo. Tempore odit totam commodi officiis id consequuntur.	85.94	\N	2018-02-26 19:43:44.813669+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
216	Grimes-Vincent	Dicta quo dolorum quis ipsum. Sequi excepturi amet necessitatibus ab. Quae at voluptatibus numquam delectus fugiat adipisci laborum. Debitis ipsa consequuntur velit nisi provident.\n\nNecessitatibus magni non amet ducimus minima. Earum necessitatibus neque voluptatem nesciunt omnis explicabo vitae.\n\nVoluptatem adipisci laborum sit. Ullam sit enim temporibus. Incidunt asperiores ducimus veritatis veniam similique deserunt. Ad incidunt debitis aliquam tempora odio. Adipisci officia minus at perspiciatis dolorum ducimus quia magni.\n\nPossimus eligendi rem numquam neque doloribus dolore quibusdam odit. Aliquid ad nemo quisquam deleniti ut. Laudantium aliquid eum voluptatem esse cumque similique. Vero consectetur accusantium mollitia asperiores commodi voluptates culpa. Explicabo expedita officiis ratione quo itaque.\n\nConsequatur vero odit temporibus porro. Rerum suscipit dolorem a aliquid quae perferendis. Maiores ipsum provident libero cumque in natus numquam.	76.48	\N	2018-02-26 19:43:44.886843+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
310	Villa, Clayton and Maxwell	At error possimus eligendi accusamus. Neque autem amet debitis non facere repellendus labore. Tenetur consequuntur illo sed. Voluptates necessitatibus saepe tenetur eligendi.\n\nEius eveniet voluptatem odit id voluptates explicabo sapiente repellat. Excepturi natus voluptatibus minus ut dolor earum magni. Modi at doloribus harum commodi possimus et.\n\nId fugit eos perferendis cumque harum inventore. Ducimus esse dolore debitis error cupiditate earum quae.\n\nAsperiores officia soluta repellendus quia aliquid minus. Nesciunt enim quisquam voluptas hic.\n\nOfficia non expedita soluta eum quidem corrupti eligendi. Corporis nobis beatae neque minima. Vel sed voluptas voluptatibus minus.	46.56	\N	2018-03-03 17:20:26.539402+00	1	"1"=>"1", "2"=>"3"	f	t
311	Williamson-Martinez	Totam sed consequuntur porro voluptatum optio. Magni impedit animi repudiandae neque eos itaque. Quibusdam perferendis molestias pariatur suscipit perferendis inventore.\n\nMinus quas saepe vero. Ratione voluptatibus possimus quibusdam reiciendis.\n\nHic enim exercitationem magni. Adipisci debitis commodi delectus provident dolores perspiciatis nulla. Rerum aliquam dolore voluptatem libero.\n\nId voluptatibus deserunt libero atque excepturi. Atque laborum cum fuga veniam. Ullam quasi debitis minima enim. Ratione nam impedit autem molestias enim.\n\nExercitationem placeat eos vel. Occaecati esse repudiandae doloremque possimus placeat dolore. Nostrum totam quisquam corporis iure.	13.94	\N	2018-03-03 17:20:26.602875+00	2	"1"=>"1"	f	t
217	Marquez-Odom	Adipisci quod aperiam numquam iusto vitae cupiditate harum. Accusamus ex nam eaque aliquid vitae. Facilis eius vel autem dicta iure a id. Id maiores odio in excepturi.\n\nModi iusto repellat repellendus doloremque natus necessitatibus. Repellendus aliquam illo sapiente. Repellendus tempore consequuntur dignissimos et numquam. Perspiciatis eaque officiis fugit itaque veritatis cupiditate neque.\n\nEst nihil pariatur et odio corrupti sunt reprehenderit suscipit. Eius eaque perferendis consectetur tempora sapiente. Nihil asperiores assumenda architecto ipsa velit eius maxime. Corrupti quos at tempore a doloremque.\n\nCupiditate natus tempore quae ab. Alias quia tenetur distinctio voluptatibus quia magnam. Qui reiciendis suscipit quasi distinctio veritatis vitae.\n\nEx quia debitis explicabo placeat architecto fugit rerum totam. Eveniet nisi magnam velit magnam at dolores fuga. Quibusdam aliquam quo similique quas non magni labore. At possimus eum placeat facilis dolorum aut.	76.68	\N	2018-02-26 19:43:44.971678+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
218	Young-Wilson	Atque ut dignissimos omnis saepe reiciendis. Praesentium cupiditate optio excepturi cum nam numquam. Quidem a similique corporis non eos. Accusantium mollitia dolorum aut suscipit.\n\nNam nostrum libero quas at temporibus odit. Magni debitis voluptatum enim eaque corporis eaque. Corrupti enim nesciunt delectus repellendus quos.\n\nQuibusdam rerum corporis sapiente doloremque fugit suscipit officiis alias. Deleniti facilis quis nesciunt maiores fugit dolore.\n\nVel nobis perferendis esse labore iure ipsa. Minima fuga minus provident adipisci non repudiandae dicta. Libero consequatur aliquid eveniet rem delectus repellat accusantium. Delectus eum dolore possimus beatae quidem.\n\nBeatae minima corrupti aperiam aspernatur ut occaecati. Impedit ipsam modi porro nemo. Error aut nostrum voluptatum vel qui ducimus neque tempora.	0.23	\N	2018-02-26 19:43:45.045456+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
219	Bender, Mills and Williams	Accusantium incidunt eligendi animi saepe. Nihil sed illum molestias dolorum. Quidem illum esse beatae maiores deserunt soluta exercitationem. Magnam blanditiis molestias deleniti inventore. Eum officia tenetur in labore.\n\nReprehenderit doloremque harum illo voluptatum qui ullam. Dolor odit magnam eos rerum libero. Excepturi rerum cupiditate dignissimos provident ratione commodi eius perferendis. Amet rerum velit sint.\n\nEos expedita repellat minima perferendis sapiente debitis. Cum fugiat sequi autem quae debitis molestiae modi. Dolore aspernatur sunt accusamus laborum accusantium. Itaque distinctio nihil hic deserunt a doloremque.\n\nVoluptate totam libero delectus perferendis enim. Expedita dolore dolorum eligendi enim quasi.\n\nMolestias aut amet recusandae. Vel doloremque incidunt voluptate itaque pariatur voluptatum commodi delectus. Eligendi occaecati delectus nesciunt dolor voluptates non quod. Itaque atque commodi nostrum suscipit pariatur sapiente.	54.40	\N	2018-02-26 19:43:45.128546+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
220	Stone, Anderson and Mercer	Debitis ipsam atque architecto illum unde. Adipisci eius molestiae esse quo. Magnam nemo fuga quo. Doloremque ea ex totam veniam voluptatibus.\n\nImpedit eveniet ut veritatis. Nobis ex reprehenderit accusantium vitae dolor.\n\nVitae soluta ut similique odio. Dolore fugiat nobis voluptatum ab. Repellat accusantium ullam animi.\n\nDebitis provident maxime tenetur cumque nulla. Eos quos soluta reprehenderit.\n\nTenetur inventore totam ratione amet voluptatem. Voluptates rerum saepe saepe eligendi labore sint. Temporibus ipsam nam velit esse tenetur facere.	37.86	\N	2018-02-26 19:43:45.200105+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
221	Wilkins-Hernandez	Cupiditate hic quo magnam itaque officia. Veritatis neque esse ad facere. Consectetur ullam tempora reprehenderit qui a reiciendis minus.\n\nRatione consequuntur quod quidem libero quas unde. Corporis corrupti commodi veniam eligendi. Iure quisquam placeat ratione eveniet earum possimus.\n\nPossimus odit reiciendis consequuntur hic. Ullam quae voluptatum qui quo voluptates facilis optio. Voluptatem quia cumque dolore numquam animi optio tenetur. Aperiam iste adipisci porro similique.\n\nNisi deleniti nam natus porro iusto libero. A magni animi alias ad incidunt laborum. Maiores hic blanditiis sed atque porro eum veritatis. Sed maiores accusantium ipsam eos. Impedit aliquam illum facilis ab.\n\nModi vero id reiciendis vitae veritatis. Quas reiciendis accusamus occaecati in provident. Labore et explicabo mollitia veritatis nemo laboriosam.	9.86	\N	2018-02-26 19:43:45.265764+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
222	Carter Inc	Quod molestias ducimus unde. Occaecati nulla in laborum veniam quasi. Unde reiciendis eveniet corporis. Rerum dignissimos occaecati quod quibusdam quasi animi.\n\nNihil molestias eaque quia hic. Beatae praesentium consequatur dicta provident. Sequi dolores error ea.\n\nModi nesciunt tempora eius consectetur ducimus. Corrupti sunt adipisci amet expedita.\n\nNisi soluta eaque quaerat amet recusandae nam odit. Quos hic fugit ea voluptatum nihil unde. Adipisci molestiae incidunt iste nobis quos fugit.\n\nSaepe similique ad consectetur consequuntur occaecati esse. Aperiam neque eum dignissimos ut.	63.73	\N	2018-02-26 19:43:45.327568+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
245	Brown-Scott	Suscipit numquam dolorem aliquid possimus. Non neque culpa quo itaque vitae iusto. Voluptatum laudantium modi similique commodi. Excepturi reprehenderit hic quos quaerat facilis.\n\nDistinctio voluptate unde eaque. In doloremque ducimus deserunt facere alias nihil. Provident dicta inventore est.\n\nRerum cum molestias voluptas doloremque facere numquam facere. Consequatur mollitia a quos nemo dolor dicta. Rem sunt quis sapiente nulla ipsum. Laborum provident deleniti molestias numquam.\n\nAccusamus quo esse et. Debitis hic velit amet deleniti nulla. Amet fuga nam impedit quaerat dicta harum vitae. Deleniti deleniti sint laborum fuga voluptate esse. Aut porro aperiam architecto veniam fugiat.\n\nId laboriosam soluta cum modi. Tempora soluta doloremque nihil consectetur aut. Dolores qui cupiditate autem consequuntur.	31.66	\N	2018-03-02 17:24:05.15668+00	1	"1"=>"1", "2"=>"3"	f	t
223	Page-Stokes	Nesciunt nam cupiditate hic. Voluptatum dolor doloremque nostrum quas nisi inventore illum laudantium. Qui suscipit sequi accusamus quis nemo exercitationem. Incidunt magni minima ut laborum aliquam non. Accusantium consequatur quos nobis eaque odio adipisci ratione.\n\nEx odio excepturi odio aspernatur tempore. Recusandae fugit nihil eius dolorem. Perspiciatis non expedita quia qui non. Assumenda reiciendis reprehenderit consequuntur dolor molestias rerum neque.\n\nEos in ea vitae aliquid commodi maxime animi. Dolores repellat adipisci animi rem consequatur. Quae reprehenderit tenetur non quos quasi corrupti facilis.\n\nUnde dolor explicabo vel tenetur aspernatur asperiores. Temporibus sit veniam delectus architecto commodi.\n\nReiciendis nesciunt culpa odit laborum cumque repellendus. Delectus eaque quis harum ullam temporibus unde. Debitis eius quod veritatis laborum omnis quaerat. Deleniti doloribus necessitatibus neque tenetur amet. Doloribus qui pariatur velit corporis eius.	72.70	\N	2018-02-26 19:43:45.382108+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
224	Smith-Cook	Quas quisquam debitis recusandae molestias vero cupiditate. Ea blanditiis possimus culpa id dolores. Doloribus et magni sit modi totam dicta cum. Atque quo hic repellat quis eius quisquam.\n\nEx porro ex minima nemo inventore voluptatum. Iste corrupti sed aliquam sunt commodi aut ad. Et odio illo veniam officiis iste eos.\n\nSimilique facilis quisquam occaecati minus tenetur. Rem tenetur quam natus dicta omnis. Nisi laudantium consequuntur dolorum.\n\nNostrum autem rerum incidunt eos cumque quo molestiae. Similique quia labore deleniti velit magni. Animi facere temporibus asperiores quia numquam deserunt itaque dignissimos. Aspernatur quo officia quisquam recusandae architecto voluptatibus in dolor.\n\nPerferendis neque ipsum iure expedita. Voluptate dolore quos et animi quis ut. Eos mollitia nostrum autem commodi voluptate iste.	9.90	\N	2018-02-26 19:43:45.468994+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
225	Williams-Miller	Labore explicabo est rem rem ipsum deserunt placeat. Et exercitationem reiciendis dolores iusto. Repudiandae tempore consequatur blanditiis accusamus. Molestiae voluptates at architecto perspiciatis veniam necessitatibus minima.\n\nConsectetur facere autem quod suscipit a. Accusantium quidem dolorum sequi. Ex architecto unde voluptatum sit accusantium doloribus modi. Quibusdam cum aliquam animi nostrum quos voluptatibus omnis. Velit architecto ex repellendus beatae animi rem quia.\n\nMaiores rem cumque perspiciatis qui numquam suscipit voluptatem delectus. Aperiam id numquam ut temporibus vero inventore. Dolorum dolores minima a ex sapiente rem temporibus. Voluptatum facilis officiis itaque.\n\nMaxime nostrum quam ducimus nesciunt eaque iste et assumenda. Vel eligendi molestias reprehenderit velit veniam reprehenderit.\n\nDebitis fugiat eaque quos vero aperiam. Nihil sed officia similique. Facilis voluptatem quibusdam veniam laudantium voluptatum.	74.27	\N	2018-02-26 19:43:45.526141+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
226	Valdez, Smith and Green	Dolor sit sunt illum tempora. Laboriosam mollitia ab voluptate in in sapiente exercitationem.\n\nIure iusto debitis minima. Libero aspernatur excepturi odio corporis dolorem. Officiis tempore nesciunt et numquam adipisci. Vero autem delectus quod dignissimos exercitationem itaque dolorum.\n\nDoloribus corrupti ratione mollitia saepe aut quam commodi. Quibusdam sint rerum laborum. Autem quas odio dolor alias corporis ipsam fugiat. Fuga provident consequatur quasi pariatur quasi excepturi est.\n\nSimilique cupiditate accusantium illum deleniti vero sequi pariatur. Reprehenderit sunt dolores saepe nostrum eum.\n\nNumquam facilis veniam quas aliquam nostrum culpa. Vel ut iusto eos officiis. Laborum dolor illum porro enim nesciunt labore doloribus. Velit alias repellat voluptatibus cumque expedita similique ipsa.	23.45	\N	2018-02-26 19:43:45.614646+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
227	Davis-Shields	Sapiente praesentium deleniti sint repellendus officia aperiam. Accusamus quisquam pariatur ea repellat rem possimus. Quo aperiam autem consectetur amet. Dolore excepturi aliquid veniam quae reprehenderit rerum vero.\n\nLaboriosam in sapiente ipsam adipisci repudiandae ipsam magnam amet. Quos reiciendis perspiciatis excepturi nesciunt. At perspiciatis nihil voluptate modi excepturi. At eius placeat odit deleniti.\n\nSint temporibus voluptatum provident quo exercitationem. Quibusdam laudantium rem unde. Possimus quam recusandae architecto. Explicabo quia corporis sapiente sed fuga unde rerum.\n\nConsequatur consequatur labore voluptatem ducimus dolorum eos. Saepe veniam nihil magnam voluptates. Asperiores cumque dignissimos quaerat perspiciatis quidem laudantium.\n\nQuae labore facilis eveniet reprehenderit tenetur dolorem quis. Officiis cupiditate corrupti iste distinctio accusamus repellendus aperiam. Alias consequatur voluptatum magnam asperiores eveniet voluptas minus.	48.44	\N	2018-02-26 19:43:45.688034+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
228	Mccullough, Johnson and Carr	Quo odio deleniti suscipit. Laborum cupiditate sint dicta dolor quod. Tempore doloremque dolor sed labore possimus cupiditate.\n\nPlaceat explicabo cum corrupti atque facere quasi. Occaecati nam porro quia recusandae quia harum impedit molestiae. Eaque quia asperiores ut facere sequi quae corporis. Sint officiis omnis voluptatibus reiciendis accusamus ratione beatae.\n\nQui exercitationem illo autem vero adipisci quos unde. Molestiae iusto ea nisi laboriosam inventore. A sed dicta iste. Possimus placeat ut blanditiis delectus recusandae rerum exercitationem.\n\nVoluptatem expedita modi sequi. Dicta sed quis occaecati quisquam. Qui ex tempora nisi molestiae unde.\n\nSoluta veniam excepturi consectetur. Beatae nostrum enim voluptate temporibus quos sit officia. Repellat cumque illo ipsum ea tempore nulla.	81.44	\N	2018-02-26 19:43:45.751286+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
229	Ho-Delgado	Quas harum harum nesciunt occaecati. Veniam consequuntur doloribus earum cupiditate illum. Quam rerum ullam quis cum odio. Praesentium aperiam accusamus cumque.\n\nPossimus unde delectus nostrum suscipit eligendi aspernatur. Dignissimos velit mollitia nesciunt reprehenderit unde deserunt mollitia consequuntur. Totam sed illo ut facere quidem.\n\nOccaecati corrupti ipsam labore asperiores. Veniam vel repellat rerum velit culpa repudiandae. Omnis officia excepturi numquam repellat vero quaerat illum nemo. Qui doloremque sed autem reprehenderit suscipit eligendi fugiat.\n\nDolorem consectetur quae ea temporibus corporis. Provident ut incidunt eius aliquam.\n\nFugit aliquam doloremque maxime impedit error id pariatur. Vero quos labore aliquid aliquid ratione dolorum. Officiis natus ipsam eos doloremque ducimus quidem. Ipsam quam similique est ut ea.	17.62	\N	2018-02-26 19:43:45.802742+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
244	Stafford-Chandler	Dicta doloremque harum tempore excepturi nesciunt. Ut beatae assumenda maiores dicta aperiam non. Voluptatum expedita earum labore excepturi a. Eos ea fuga quaerat fugit provident dolore pariatur.\n\nCumque esse consequuntur cumque fuga rem et. Sed et itaque reiciendis libero. Reprehenderit sed alias praesentium dolor praesentium reiciendis.\n\nDolorum vel voluptates corporis. Odit perspiciatis corporis deserunt rerum illum. Tenetur quasi tempore dolore perferendis culpa sint. Dolor nostrum consequuntur iusto doloribus.\n\nRerum temporibus exercitationem sapiente. Nisi aperiam debitis labore similique adipisci sit. Aliquid mollitia porro accusantium. Delectus eos cum fugit ratione quasi nam ipsam quas.\n\nNatus voluptate accusamus aperiam officia repellendus sint eaque dolorem. Quas in magnam voluptatum est perspiciatis culpa veritatis natus. Odio sint distinctio eaque dicta.	54.72	\N	2018-03-02 17:24:05.097199+00	1	"1"=>"1", "2"=>"3"	f	t
230	Blair, Perkins and Martin	Tempora at non nostrum. Occaecati quaerat nemo facilis laboriosam sed eligendi. Nemo dolores repudiandae occaecati voluptas minima tempora dolorum ipsum. Commodi voluptas molestias non amet vero quas adipisci.\n\nAsperiores unde dolore corporis neque possimus nisi iusto esse. Eligendi officiis iusto ducimus nemo similique dolorum.\n\nIn repellendus facere veniam neque neque maiores. Pariatur velit odio quibusdam ipsum exercitationem minus. Iusto modi sequi voluptas commodi reprehenderit. Maxime rem id reprehenderit perferendis suscipit dolor corporis.\n\nVelit accusamus excepturi rem veniam ex corporis. Necessitatibus eaque corrupti odio ipsa temporibus quaerat quidem. Ipsam voluptatem magni eius adipisci voluptatibus molestiae minima. Aliquam perspiciatis vero optio in repellendus asperiores.\n\nDolor corrupti perferendis ullam velit non quae. Culpa voluptatem est explicabo quo sapiente. Magni illo quasi magnam repellat placeat. Nobis sequi voluptatum quisquam unde.	88.51	\N	2018-02-26 19:43:45.875187+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
231	Dodson Group	Totam rerum recusandae excepturi et ad fugiat placeat omnis. Nesciunt beatae nostrum ullam cum. Eos cupiditate ad ex consequuntur suscipit animi fugiat nihil.\n\nOdio nesciunt magni occaecati porro commodi cumque. In quos odio aut ut. Laudantium eligendi commodi voluptatum cumque ipsam perferendis. Non natus minus placeat facere adipisci fuga.\n\nQuos impedit itaque odio cum commodi voluptas. Fuga quisquam unde debitis. Hic ratione quasi provident voluptates nulla impedit laborum quidem. Quas magni temporibus incidunt dolorum fuga. Beatae similique libero consequatur iusto fugiat inventore quidem odit.\n\nReiciendis recusandae officiis odio dolor nemo suscipit. Repellat eaque nemo cumque laborum odit facere. Rem quas dignissimos provident vitae fugiat rerum. Cumque facere ipsa ipsa repellat. Inventore perspiciatis quod quidem quidem eveniet eius.\n\nEst nulla assumenda non quo ea recusandae repudiandae et. Ex occaecati facilis accusantium fuga. Fugit ab suscipit sapiente officiis iure.	4.64	\N	2018-02-26 19:43:45.951677+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
232	Whitaker PLC	Impedit architecto quam inventore laborum. Eveniet autem blanditiis quos sed quae non. Beatae consequuntur tempora natus vel id optio.\n\nRepellendus voluptate tenetur quaerat facilis. Ipsa sequi reiciendis nemo laudantium ullam praesentium. Enim debitis enim nisi facilis ea dolore corrupti.\n\nIpsa temporibus pariatur laudantium possimus possimus. Culpa aut officiis minus deleniti facere. Deserunt ut dolores molestiae deserunt beatae voluptatem.\n\nIure consequuntur odit eius dicta nulla omnis. Doloribus eos impedit recusandae temporibus illum velit. Asperiores impedit quae error laboriosam perferendis.\n\nVoluptatem blanditiis doloremque odio deserunt totam. Repellat error quidem veniam eaque delectus ad. Inventore vel iure cum nihil dolor aliquam optio. Voluptate animi fugiat accusantium.	90.60	\N	2018-02-26 19:43:45.995418+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
233	Ward, Moreno and Ferguson	Porro accusamus eius error. Labore nulla nihil cum unde nulla in nemo. Alias unde itaque quis. Tempore ab harum ab rerum nobis reprehenderit veritatis.\n\nVeniam vero dolorum quod quisquam ratione assumenda. Ad quasi quod optio accusamus officia suscipit. Illo dicta nihil illum ducimus nesciunt reiciendis ex modi. Tempora ipsa quaerat occaecati blanditiis.\n\nDignissimos nihil eaque optio. Incidunt asperiores repellat natus laborum. Nobis expedita maxime similique deleniti.\n\nNulla commodi reprehenderit laborum repellat. Repellat itaque pariatur recusandae suscipit accusantium provident. Corrupti quis dolorem dolorem. Facilis animi quas velit beatae aut eius ea sit.\n\nExcepturi officiis optio eum consequatur officia magnam officiis. Provident nemo voluptates cum sed. Impedit nisi sunt alias repudiandae aspernatur et voluptatum. Qui a sunt maiores.	56.52	\N	2018-02-26 19:43:46.045926+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
234	Ramirez-Smith	Enim quia possimus debitis consectetur reiciendis possimus dolore. Minus accusamus perferendis sunt nulla animi hic magni.\n\nAssumenda omnis dolorum tenetur exercitationem culpa voluptatum eum. Incidunt molestias beatae hic sed consectetur esse eius sequi.\n\nEa architecto sit perferendis veritatis. Omnis facere ratione natus temporibus magni iste inventore. Ab porro cumque quod amet porro vitae.\n\nPariatur tempora dolorem distinctio quibusdam laudantium neque voluptates nam. At vero nobis quas doloribus nam. Consectetur eaque reprehenderit rem aut autem.\n\nQuidem rerum magni cum cumque sunt. A expedita voluptatum doloremque fugiat. Rem doloribus voluptas tenetur aperiam.	82.55	\N	2018-02-26 19:43:46.097378+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
235	Davis-Trevino	Maiores corrupti cupiditate et commodi optio quis. Perferendis aliquam veniam earum soluta. Quas perspiciatis officiis maiores voluptate excepturi temporibus in ullam. Deleniti odio quidem non assumenda nobis dolorum quibusdam.\n\nVeniam natus mollitia nisi ipsam quam aliquam. Veniam qui ullam eius similique eaque perferendis culpa. Earum doloremque ipsum ipsum nulla voluptatum. Porro similique error quibusdam. Dolorum quia eveniet atque doloribus incidunt eius.\n\nVoluptate et esse veritatis corrupti autem ipsum. Maxime veniam minus a labore odit. Aperiam vero veritatis maxime eveniet.\n\nMagnam ipsum exercitationem rem mollitia ab. At quibusdam dolor enim. Dolorem dolore quibusdam placeat voluptates corrupti fuga commodi. Iusto necessitatibus earum placeat fugit quas. Laboriosam architecto nostrum iure totam labore numquam.\n\nLaudantium praesentium accusantium atque accusamus quaerat quaerat. Non maiores molestias explicabo aperiam. Eligendi quo dignissimos officiis esse temporibus. Doloremque possimus officia blanditiis debitis exercitationem commodi.	73.80	\N	2018-02-26 19:43:46.15804+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
236	Lopez-Burke	Harum qui numquam vero accusantium. Nobis sint soluta eum officia cum iure incidunt. In ipsa hic voluptates incidunt.\n\nVoluptas minus laboriosam quos nihil atque sit velit. Nulla dolores neque cumque numquam dolor beatae explicabo. Mollitia accusantium sed sunt.\n\nIusto illo ad asperiores deserunt voluptate odit officiis. Repellat aperiam ad cum corrupti deserunt quidem maxime id.\n\nOdio debitis dolorem dicta nemo quidem. Magni facilis tenetur officiis amet minima mollitia. Atque corrupti magnam ea. Possimus alias laudantium consequatur voluptas dolor.\n\nNobis facere nulla minima voluptatem aliquid. Nesciunt corrupti ea aliquid sit. Iste ratione repellendus nulla quisquam nostrum quaerat deleniti. Quaerat quos beatae fugiat saepe nulla fugiat. Placeat error inventore nobis ipsam sequi quis fuga officia.	45.13	\N	2018-02-26 19:43:46.203828+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
240	Johnson, Woods and Kelley	Ducimus blanditiis dolorem accusamus deserunt. Ut perspiciatis delectus explicabo numquam illum iste beatae.\n\nLaborum incidunt quaerat laudantium aperiam delectus. Hic quo mollitia incidunt ratione tempore fuga eos eveniet. Fuga minima sunt impedit cupiditate odit doloremque consectetur. Tenetur rem provident doloribus aperiam neque.\n\nAt dignissimos aliquam rem possimus. Autem veritatis dolor asperiores. Nesciunt odio molestiae nostrum nihil vitae nam beatae mollitia. Occaecati sint earum temporibus nam.\n\nDebitis id hic quos quia consequatur vero. Eum tempora quaerat explicabo rerum natus. Explicabo quibusdam quis fuga qui adipisci. Nihil quam inventore vel laborum.\n\nIpsam autem mollitia quia laborum nostrum necessitatibus. Voluptatum nemo repellat beatae veniam ipsum. Deserunt eveniet inventore nisi aliquam et. Modi id excepturi at quidem. Ad qui impedit inventore laboriosam.	65.90	\N	2018-02-26 19:43:46.390719+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
237	Page, Riley and Jones	Modi beatae consequatur totam accusantium voluptas. Iure sapiente nobis accusamus dolore molestias magni iure sequi. Nobis illum magnam magni aliquid incidunt quod incidunt. Quia vitae nulla laudantium laudantium maxime asperiores.\n\nAt error repellendus dolorem iusto occaecati reprehenderit. Numquam corrupti quasi suscipit magnam. Possimus nesciunt exercitationem excepturi odit officia harum. Aut quasi esse ab quas vero. Qui quam odit sapiente consequuntur ea quibusdam maiores.\n\nSimilique possimus nulla cum libero porro quisquam quisquam. Porro cumque sit illum beatae at. Suscipit neque dolorem accusamus sapiente est odio ad modi.\n\nQuos ut facere hic non debitis. Tempora exercitationem laborum laborum harum quaerat itaque quaerat inventore. Exercitationem sunt quaerat assumenda temporibus repudiandae veritatis. Doloremque laudantium quas porro vitae expedita voluptate iste.\n\nDoloribus aperiam iste molestiae rem exercitationem. Saepe porro tempora recusandae incidunt consequatur delectus. Repellendus atque dignissimos mollitia quis perspiciatis officia praesentium corporis. Iusto dicta dicta deleniti id explicabo tenetur.	78.47	\N	2018-02-26 19:43:46.243783+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
238	Freeman, Stewart and Guzman	Minima et ducimus fuga repellat quis quos. Ea quo eligendi quis iure placeat sit. Rerum ea est reiciendis adipisci. Libero excepturi temporibus repellendus sit magni.\n\nBlanditiis amet odio cupiditate fugit magni cum fugiat. Ipsam nobis nihil autem neque explicabo perspiciatis. Reprehenderit voluptas nihil eligendi nulla.\n\nMinus labore eligendi atque impedit possimus laboriosam excepturi. Magni ullam voluptate eius dolores reiciendis rerum. Nemo asperiores ut nisi earum corrupti fugiat illo.\n\nIure laborum voluptatum magnam. Dicta maiores ex est labore rem dolor esse occaecati. Quam in fuga laborum laborum dicta sunt. Odio placeat occaecati architecto mollitia. Necessitatibus distinctio odio amet facere temporibus.\n\nIn veniam deleniti dolores. Ut deserunt quisquam nobis distinctio.	22.67	\N	2018-02-26 19:43:46.28083+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
239	Vasquez-Erickson	Qui veniam quia officia fuga ab odio mollitia. Quaerat ipsum quas ad. Quis earum fugiat temporibus nam odit libero.\n\nHarum dolor nihil nihil placeat consequuntur cumque. Molestias velit dolor dolorum adipisci natus. Porro consequatur molestias nihil eius officia animi. Sequi optio suscipit saepe dicta pariatur.\n\nAccusantium consequatur error excepturi beatae. Distinctio eaque inventore a consequuntur. Excepturi reprehenderit assumenda assumenda. Placeat vel ducimus commodi eligendi.\n\nHarum iure placeat beatae officia eius dolorum possimus enim. Culpa esse velit sit velit ullam repellendus optio. Aut voluptatibus culpa cupiditate quod enim natus a. Nisi at corrupti fugiat ab alias eligendi dolorem.\n\nIpsa esse quibusdam cupiditate quasi. Molestias commodi quod unde quibusdam ut. Perferendis praesentium a reprehenderit.	65.19	\N	2018-02-26 19:43:46.337293+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
241	Harris, Chavez and Smith	Id repellendus quasi atque accusamus enim non. Ipsam recusandae similique reiciendis quasi assumenda sunt veniam perferendis. Quam accusamus incidunt nesciunt. Voluptatem quibusdam recusandae occaecati nulla quisquam.\n\nOdit dolorem perspiciatis atque. Rerum itaque molestiae veritatis perferendis saepe quia. Rem ducimus id veniam.\n\nSunt cupiditate harum officia incidunt esse suscipit. Repellat eos voluptas ea reprehenderit sapiente impedit reiciendis sapiente. Aliquam deleniti velit quam deserunt cum asperiores. Est mollitia minima optio ab maxime aliquam. Tempore tempore enim fugiat deleniti ex.\n\nDeleniti ut sint laborum perferendis dolor velit. Maiores consequuntur soluta autem fuga harum. Tenetur nihil eius sequi totam. Quia natus tempore sed neque.\n\nAd sit voluptatum similique odio in. Repudiandae deserunt cum quam dolorum incidunt cum non hic. Eaque error id dolorum sequi doloremque qui facere.	62.53	\N	2018-03-02 17:24:04.876915+00	1	"1"=>"1", "2"=>"2"	f	t
242	Mendoza and Sons	Nihil reiciendis ea explicabo explicabo neque. Similique illum ut molestiae et voluptates cumque aut. Veritatis nesciunt laboriosam nesciunt excepturi illum nam assumenda. Dolores sed nihil cum beatae asperiores.\n\nTempora deserunt quibusdam voluptatum quis corrupti deserunt sunt minus. Asperiores quos cupiditate itaque voluptatem velit illo. Dignissimos totam veniam sit id.\n\nHarum dignissimos quidem praesentium exercitationem aspernatur. Iure dignissimos expedita ipsum vitae quas qui pariatur. Eaque debitis sunt temporibus cupiditate necessitatibus quae minus. Est vero sit odit architecto vero.\n\nQuos quasi molestias et distinctio dolores. Molestiae vero qui expedita ab deleniti. Velit tempore sit eligendi aperiam alias sed.\n\nMagni architecto molestiae at voluptatibus blanditiis. Iure rerum error quis explicabo. Omnis facilis sequi suscipit quisquam ut repellat amet. Rerum quia soluta amet distinctio repellat beatae.	34.12	\N	2018-03-02 17:24:04.979458+00	1	"1"=>"1", "2"=>"3"	f	t
326	Jackson, Farmer and Reed	Occaecati sint odio aliquid a. Alias laboriosam molestiae minus quos commodi ad totam.\n\nBlanditiis vero recusandae sit at magni reprehenderit. Neque mollitia asperiores voluptate porro architecto distinctio. Consectetur reiciendis et asperiores delectus sapiente tempore sint.\n\nEum illo harum unde tempore sit cum fugit. Maiores illum voluptatibus debitis incidunt quaerat distinctio.\n\nVoluptate nihil necessitatibus temporibus soluta. Adipisci cumque ducimus unde officiis aliquam. Qui odit eaque culpa harum adipisci quaerat quisquam. Inventore aliquid magnam assumenda veniam accusamus.\n\nMollitia officiis amet commodi reiciendis. Cum quae impedit consectetur. Earum maiores minus expedita deleniti voluptatem.	33.22	\N	2018-03-03 17:20:27.548067+00	3	"1"=>"1", "4"=>"9"	f	t
327	Spencer, Rosales and Smith	Unde saepe optio fugiat deleniti voluptas corrupti autem. Enim nesciunt quaerat eveniet animi quibusdam. Laboriosam sint quo rerum.\n\nNisi inventore ad molestias aliquid dicta repellat laborum. Laboriosam enim quisquam animi ipsa error neque. Cumque suscipit unde nesciunt at atque.\n\nSuscipit quia culpa sed aspernatur incidunt aliquid eum. Distinctio repudiandae magnam rerum velit. Sapiente laudantium fuga incidunt quidem nemo. Earum voluptatum cumque nulla ipsum.\n\nAlias magnam iste fugiat commodi quaerat. Amet aperiam ea accusamus eveniet. Dolorum dignissimos omnis non officia consequatur inventore ipsum. Porro sit perspiciatis unde odit facilis.\n\nDistinctio quasi voluptatum laudantium culpa aperiam veniam est. Pariatur amet maiores ex placeat dolorum veritatis. Magni dolores doloremque officia aperiam esse quis. Magnam deleniti quis beatae optio.	5.15	\N	2018-03-03 17:20:27.60706+00	3	"1"=>"1", "4"=>"8"	f	t
246	Foster, Harvey and Sullivan	Nulla dolorum laboriosam alias impedit ducimus cupiditate. Enim ratione consequatur tempora. Expedita eaque distinctio tempore libero cumque. Corporis iure quia porro deleniti.\n\nAt sed quis corrupti iste veritatis ea quisquam ut. Reiciendis voluptate tempora nulla libero. Esse labore similique quas exercitationem neque quisquam. Soluta autem tempore suscipit.\n\nTempora incidunt dolorum quisquam ipsum magnam. Numquam nesciunt recusandae sunt aliquam dolore. Quaerat ad repellat sapiente consequatur. Sint necessitatibus quam ad magnam dolore recusandae nostrum nostrum.\n\nPlaceat tempora dolores repudiandae esse iure ad. Excepturi ex excepturi beatae ea. Ipsa perferendis quam architecto excepturi aperiam quasi possimus nulla.\n\nQuis fuga tempora fuga animi animi sed. Non dolores assumenda aut. Repudiandae tempore esse ut corrupti facilis. Dicta itaque nemo qui eaque. Iste quo est pariatur consectetur laudantium in beatae amet.	7.92	\N	2018-03-02 17:24:05.209086+00	1	"1"=>"1", "2"=>"3"	f	t
247	Reyes-Hudson	In distinctio error ipsa minima accusantium. Error ea animi ipsum nisi. Rem dolorum numquam sunt dolores. Minus fuga ex accusamus assumenda aliquam nihil maiores.\n\nRecusandae molestiae dolorem totam tempore sed. Provident earum culpa at minus. Doloremque quae perspiciatis eligendi nostrum nemo illum. Inventore perspiciatis reprehenderit fugit ipsum. Quas ratione perferendis voluptate.\n\nNesciunt quam ab facilis iure. Quo ipsum ad molestias molestiae praesentium numquam doloremque officia. Aliquam numquam eum commodi necessitatibus. Sunt nemo nisi quod veritatis ipsum earum.\n\nOdit omnis tempore delectus fugiat reprehenderit. Iste doloremque reiciendis eligendi veniam doloremque eum. Asperiores doloremque ratione minus voluptatem laudantium quis necessitatibus pariatur.\n\nRepellat expedita iste placeat qui. Totam eveniet deleniti nesciunt nam sit tenetur voluptates. Inventore quam animi neque nihil aliquam.	27.55	\N	2018-03-02 17:24:05.253895+00	1	"1"=>"1", "2"=>"2"	f	t
248	Ramsey, Hooper and Caldwell	Cumque quia hic ut doloribus. Id delectus autem iure laudantium odit ex. Culpa molestiae eum dolorum voluptate voluptatem doloribus alias ab.\n\nQuam laborum ducimus rerum sit et atque molestiae. Accusamus amet molestias suscipit saepe. Nemo ipsum nostrum ipsum nam magnam.\n\nNecessitatibus cupiditate odit fugiat odio porro inventore. Similique totam atque deserunt ipsam voluptatum occaecati beatae. Doloremque deserunt odio voluptates eos.\n\nCommodi id eius rerum doloribus est. Architecto minus modi libero ex doloribus quis veritatis. Nulla magnam hic asperiores nulla reiciendis saepe officia nesciunt. Itaque nihil harum commodi omnis veniam fuga minus.\n\nAtque nulla quasi laudantium illo illo. Atque in ea numquam officia iste cupiditate. Vel dolores commodi laudantium non vitae.	1.78	\N	2018-03-02 17:24:05.317472+00	1	"1"=>"1", "2"=>"2"	f	t
249	White-Rodriguez	Ullam tempore veniam illo in natus tempore mollitia ratione. At quia optio adipisci aliquam nesciunt consequatur nulla. Exercitationem delectus magni dolor illo et. Possimus necessitatibus iste rerum maiores sapiente quidem.\n\nMinima odio dolorem fuga quo ad. Repudiandae eum adipisci natus similique inventore voluptate modi. Et occaecati vitae quos optio rem quos. Ullam inventore illo sed magni voluptatibus exercitationem nesciunt. In id expedita quidem velit.\n\nDebitis repellat optio alias cumque. Occaecati non impedit consectetur corrupti ad eaque eaque. Placeat reprehenderit nostrum eaque.\n\nCupiditate laborum necessitatibus provident distinctio consectetur tenetur nihil cupiditate. Iste ipsam blanditiis dolor minima possimus. Omnis beatae quod consequatur fugiat exercitationem reiciendis excepturi. Voluptates quaerat nostrum dolores earum asperiores corrupti sed.\n\nMinus sint et ipsam nisi aspernatur. Eius est vitae voluptas cumque ad nam rem. Modi corrupti magni molestiae dicta. Inventore ipsum rem omnis aliquid non nostrum.	59.52	\N	2018-03-02 17:24:05.359824+00	1	"1"=>"1", "2"=>"2"	f	t
250	Pennington-Taylor	Aperiam deleniti voluptate ad aperiam dolorem. Earum dicta nemo sit impedit excepturi provident. Ipsam laudantium impedit praesentium quis. Velit perspiciatis quaerat unde dolores.\n\nInventore a enim et velit. Reprehenderit aspernatur voluptas saepe nam. Consectetur accusamus ex dolor sit soluta. Sapiente ab quaerat numquam quidem aperiam asperiores.\n\nEligendi sequi ad alias aliquid rerum. Facere veritatis eveniet pariatur maxime facere. Adipisci sapiente maiores hic unde deleniti autem.\n\nNeque eos repellendus illo dolores. Velit ratione nam necessitatibus ipsam eius suscipit aspernatur quos. Commodi minus accusantium voluptates possimus aut officia rem.\n\nDoloremque recusandae vel eaque facere illum ea. Quo impedit possimus accusamus amet tempora eligendi delectus. Commodi ipsa consequatur amet eius atque alias doloribus. Harum earum delectus nam eius mollitia.	73.26	\N	2018-03-02 17:24:05.423108+00	1	"1"=>"1", "2"=>"2"	f	t
264	Farmer, Miller and Stark	Voluptatum laudantium reiciendis suscipit est nihil incidunt perspiciatis autem. Nisi debitis ipsum sunt molestiae. Aut reiciendis facere esse soluta nobis voluptates. Nulla praesentium autem laudantium nulla. Expedita ab vel provident beatae dicta eum tempore.\n\nSed rem officia commodi dolor deleniti reiciendis enim. Inventore fugiat rem dolore est ea vitae. Sequi vel voluptatibus id facilis ipsam qui tempora laborum.\n\nNeque dolore veniam mollitia soluta earum nobis harum. Qui at magnam ratione.\n\nUt architecto suscipit eligendi mollitia. Sit dicta voluptates modi. Nam aliquid cumque at blanditiis vero natus aperiam. Itaque veritatis dolore itaque.\n\nDeleniti unde asperiores praesentium. Totam animi consequatur repellat at sunt inventore minima. Quo praesentium dolorum animi natus corporis.	65.15	\N	2018-03-02 17:24:05.958947+00	3	"1"=>"1", "4"=>"9"	f	t
265	Wilson, Coffey and Simpson	Placeat dignissimos neque nihil ad iste reiciendis totam. Ex debitis maxime a dolorum dignissimos cumque quam. Reiciendis in mollitia praesentium eligendi explicabo eaque. Deleniti autem deleniti tenetur commodi tempora qui quis.\n\nQui distinctio ad iusto aperiam natus. Libero nulla quas ducimus necessitatibus fuga. Iste ipsum consequuntur doloribus. Repellat accusamus ex rem.\n\nSit ratione architecto porro. Suscipit voluptate fugiat eum hic voluptatum quisquam odio. Iusto numquam officiis voluptate consectetur corrupti.\n\nAtque dolorum voluptates qui earum delectus repudiandae vel. Eligendi placeat accusantium iste excepturi. Molestias accusamus sint inventore dignissimos id voluptatibus. Quibusdam quaerat laborum a aliquid exercitationem nihil maiores fuga.\n\nQuisquam atque voluptas expedita fugiat earum. Rem impedit animi tempora recusandae. Aperiam excepturi porro veniam odio incidunt harum.	97.25	\N	2018-03-02 17:24:06.007091+00	3	"1"=>"1", "4"=>"9"	f	t
251	Allen-Shah	Ullam id architecto autem explicabo magni ducimus eligendi quo. Quia error tempore nobis. Iste dignissimos in nostrum minima. Voluptate tempore impedit tenetur nostrum atque.\n\nImpedit recusandae dolorem esse deleniti facere harum maxime. Officiis consectetur tenetur iste laboriosam dolores sapiente earum cumque. Eum qui impedit numquam est praesentium delectus sit. Nihil voluptate aut possimus sapiente nihil cum expedita optio.\n\nAperiam ipsa quasi sunt repellendus incidunt alias similique. Facere accusantium ex cumque inventore perferendis eligendi. Eum iusto iste animi officia iure quia sed asperiores. Alias officia quaerat placeat explicabo nam.\n\nOccaecati neque placeat et nemo. Nam hic repellat vitae sapiente. Inventore aut laborum laudantium iusto qui quidem ut.\n\nSit corporis deserunt eius ipsum illum molestiae harum. Explicabo sed odio itaque repellendus voluptatem. Voluptatem corrupti eum ex aliquam excepturi laudantium odio. Omnis inventore architecto occaecati neque sequi.	79.66	\N	2018-03-02 17:24:05.472673+00	2	"1"=>"1"	f	t
252	Matthews Ltd	Quidem animi dolorum ducimus expedita cum. Cum dignissimos nesciunt possimus illo. Quos adipisci voluptatum totam ipsum.\n\nNon totam maiores accusamus deleniti amet eum eum eligendi. Corrupti quia omnis minima repellendus deleniti. Iusto ab nesciunt ex cumque similique.\n\nQuo veritatis vero debitis velit totam culpa. Illum nisi suscipit illo repudiandae sequi temporibus quis. Expedita aspernatur commodi consequuntur odio rem veniam. Cupiditate cupiditate nemo laboriosam reiciendis quod ut.\n\nFacilis corporis ad aliquid veniam. Quasi animi praesentium qui. Amet dignissimos quia deserunt tempora beatae quas. Facilis consequatur blanditiis sint aspernatur perspiciatis doloribus.\n\nQuae distinctio a tempore quam doloribus quam libero ipsam. Similique laboriosam aperiam expedita. Laudantium reprehenderit occaecati velit temporibus. Minima asperiores esse natus officia distinctio necessitatibus maxime.	76.56	\N	2018-03-02 17:24:05.503959+00	2	"1"=>"1"	f	t
253	Ward, Mcbride and Calhoun	Quod tempore inventore repudiandae ut. Quos possimus sapiente nulla inventore laborum. Vel voluptate consequatur laboriosam non molestiae odit. Distinctio perferendis eveniet vero inventore optio fugit magnam.\n\nSunt quae at veritatis. Illum voluptates enim autem. Nobis dignissimos voluptatem illo vero architecto illum.\n\nNesciunt itaque libero eaque ipsa. Molestias molestias repellat sequi itaque nulla. Veritatis quo distinctio autem quaerat.\n\nReprehenderit quo expedita enim fugiat. Voluptatibus amet eveniet voluptatum soluta harum dicta placeat. Deserunt veniam iste dolorum dolores ipsa dolore. Vitae nobis unde deleniti incidunt officia assumenda.\n\nDignissimos ipsam doloribus ut ipsum laborum. Inventore modi eius magnam doloremque facere consectetur velit. Quis quasi ex cupiditate dolorum praesentium in.	49.99	\N	2018-03-02 17:24:05.541981+00	2	"1"=>"1"	f	t
254	Rogers-Myers	Eum iste incidunt eius officiis error. Minima ea harum nostrum ea ea possimus labore. Beatae reiciendis perferendis non non quo quaerat illo.\n\nNihil numquam nobis dolores repellat animi magnam. Quidem voluptatum eveniet in atque. Delectus voluptates aut blanditiis. Laborum quos quidem fugit libero.\n\nQui error pariatur nesciunt modi laboriosam eos dignissimos. Exercitationem quidem odio nihil optio itaque vel libero omnis. Dolores aliquam assumenda voluptates corporis dicta maxime occaecati.\n\nFuga dolorem sint fuga vitae. Quo voluptatibus cupiditate dolor vel placeat. Magni beatae blanditiis accusantium.\n\nQuas omnis aliquid voluptatem beatae quisquam recusandae ipsam. Adipisci distinctio perspiciatis cum. Neque beatae vitae quidem perferendis.	31.60	\N	2018-03-02 17:24:05.574447+00	2	"1"=>"1"	f	t
255	Rodriguez PLC	Omnis qui accusamus porro quisquam eius ipsa. Suscipit saepe voluptatem mollitia repellendus repellendus nam accusantium unde. Incidunt aut natus reiciendis.\n\nTotam possimus minus fuga amet tempora vel iure quod. Tenetur quaerat cum tenetur voluptatum unde assumenda. Consequuntur nesciunt quibusdam incidunt vitae sint aspernatur non.\n\nEsse necessitatibus soluta nihil quae vitae neque soluta. Neque eos quasi excepturi. Facere nemo ex quam nam.\n\nQuod quidem animi nemo. Maiores amet asperiores tenetur repudiandae dolor dolorum fugit. Quas illum iusto assumenda distinctio hic perferendis. Molestiae dolor et explicabo placeat libero accusantium.\n\nAut iste aut esse. Eveniet quas non quaerat. Adipisci veniam laboriosam perspiciatis nam explicabo illum.	47.25	\N	2018-03-02 17:24:05.598086+00	2	"1"=>"1"	f	t
256	Buchanan-Guerrero	Nostrum odio vitae iusto fugiat. Eum quo perferendis expedita assumenda cumque eaque debitis maxime. Fugit blanditiis accusamus praesentium voluptatem animi ipsam nisi. Aperiam aspernatur quis eligendi nobis harum voluptates quo.\n\nIpsa accusamus ipsa architecto aperiam occaecati ipsam maxime sunt. Alias optio officiis ducimus saepe perferendis. Deserunt sed laudantium aliquam esse.\n\nSoluta tempore architecto fugiat. Assumenda consectetur maxime reiciendis impedit repellendus repellendus. Maiores voluptate deserunt quo ducimus.\n\nMolestiae non saepe enim adipisci quisquam quas. Laudantium sit occaecati fugit commodi quibusdam expedita sunt. Repellat aliquam explicabo quibusdam expedita incidunt itaque.\n\nOdit adipisci voluptatibus sint magnam facilis nihil eum. Minima dolore maxime suscipit dolor eveniet. Tenetur molestias reprehenderit fugiat voluptates vitae rerum sapiente.	69.60	\N	2018-03-02 17:24:05.632878+00	2	"1"=>"1"	f	t
257	Jackson Inc	Laborum fugit deleniti nemo natus. Exercitationem libero delectus rem nemo neque. Illum ipsa maxime cupiditate nihil corporis. Aspernatur veniam porro provident esse modi incidunt molestias consectetur.\n\nRerum facere tempora inventore. Ex beatae iste iste magni earum eveniet architecto quo. Corrupti eos cupiditate mollitia illo.\n\nDistinctio voluptatibus occaecati qui assumenda. Vitae repellendus odit corporis perferendis nulla delectus excepturi cumque. Consectetur delectus doloribus sed eveniet ea nulla soluta.\n\nAliquid esse ab quibusdam suscipit repellat reiciendis. Eos vel ducimus dignissimos dolorem neque.\n\nIllo ab cumque quibusdam explicabo. Delectus dolore quam autem ex. Consequatur saepe voluptas maxime fuga placeat. Laborum maxime provident reprehenderit autem.	87.57	\N	2018-03-02 17:24:05.665977+00	2	"1"=>"1"	f	t
258	Ruiz, Zimmerman and Mcpherson	Exercitationem laboriosam pariatur ab sequi nulla illo. Illo quo quisquam odit consequuntur. Similique deleniti ab aliquid commodi. Facilis voluptatum consectetur non esse quam tempore inventore.\n\nSimilique delectus iure officiis. Tempora sunt nihil natus laborum suscipit iure. Eius impedit iste nam nostrum distinctio ab. Optio cupiditate expedita repudiandae iste fuga veritatis voluptatibus.\n\nOfficia similique nostrum sequi aliquid nobis aperiam porro illum. Maxime modi consequuntur ut pariatur placeat minima occaecati. Eveniet harum illum quaerat recusandae id asperiores omnis.\n\nQuisquam modi nobis nulla minima nesciunt aliquam necessitatibus perspiciatis. Atque beatae voluptates in ducimus similique. Itaque adipisci odit aperiam laudantium quidem harum possimus.\n\nPerferendis suscipit ad corporis voluptates quos dolore magni soluta. Deleniti itaque adipisci provident voluptate et modi. Repudiandae praesentium blanditiis quis quae. Eveniet sunt delectus sit quod quisquam.	90.43	\N	2018-03-02 17:24:05.704188+00	2	"1"=>"1"	f	t
259	Meadows, Richmond and Perez	Atque est debitis accusantium totam ab illum voluptas. Voluptatum harum modi architecto. Eligendi ea occaecati dicta laborum alias. Dicta autem delectus vitae.\n\nQui doloribus modi sint beatae dolore. Illo maxime assumenda debitis. Quaerat corrupti consequatur quas pariatur hic mollitia.\n\nFuga ipsa at vitae non repudiandae. Assumenda fugit dolorem delectus quasi voluptatum. Quasi consequatur repudiandae vel.\n\nNam ullam maxime consequuntur adipisci voluptate. Aspernatur temporibus quae dolorem maiores. Accusamus voluptatem ducimus reiciendis cumque explicabo commodi. Enim ab illum omnis harum explicabo perferendis.\n\nCum corporis aliquam ducimus magni quis nemo. Explicabo qui quasi magni officia aspernatur. Hic quia porro amet sapiente nesciunt quidem quae.	5.60	\N	2018-03-02 17:24:05.739263+00	2	"1"=>"1"	f	t
260	Farrell Group	Architecto modi aperiam placeat accusamus eveniet inventore. Error dicta quo vero nesciunt aliquid. Mollitia iure ut enim corrupti. Ullam consectetur quia animi.\n\nUt nesciunt aliquid quibusdam dolore non velit rerum. Consequatur saepe enim minima nobis. Labore dolore iste deleniti. Ab enim repellendus est accusantium in. Facilis repellat aspernatur ipsa asperiores.\n\nVoluptate iusto eos odit. Repellendus voluptate corporis repellat non est. Dicta perferendis non commodi.\n\nNesciunt illum assumenda animi illum hic dolorem. Molestias doloribus unde ratione ullam omnis asperiores placeat dolores. Accusamus neque ducimus quisquam alias illum itaque incidunt ab. Modi eum tempora rem porro aut doloribus expedita.\n\nNulla rem voluptatum reprehenderit id. Laudantium debitis sapiente eaque nostrum temporibus. Nulla repellat amet rerum.	7.76	\N	2018-03-02 17:24:05.775386+00	2	"1"=>"1"	f	t
261	Reyes, Ware and Johnson	Et sapiente numquam tenetur. Delectus error pariatur soluta nostrum deleniti voluptates quo.\n\nFacere at commodi harum. Numquam architecto et voluptatum.\n\nIure nulla sunt quam quia eaque. Iure et delectus beatae nam hic illo. Itaque reprehenderit necessitatibus voluptas. Esse quasi ipsam nostrum molestiae alias quia.\n\nNemo dolore dolor assumenda debitis dicta. Earum rem odio nulla mollitia harum. Ullam laboriosam corrupti blanditiis in dolores eveniet.\n\nNihil accusamus exercitationem libero nobis hic rerum nihil nulla. Consequatur voluptas vel eaque a repellat similique cum.	90.16	\N	2018-03-02 17:24:05.818939+00	3	"1"=>"1", "4"=>"9"	f	t
262	Young, Hancock and Nelson	Minus a saepe pariatur quaerat iusto in sint. Excepturi labore doloremque eveniet suscipit ipsa tenetur. Soluta corporis neque cum officia quibusdam libero. Quas sint mollitia et provident sapiente possimus praesentium.\n\nOfficia illum accusantium id vel recusandae impedit. Eius sit nihil ipsa assumenda autem libero. Ea libero cumque mollitia officia deleniti ullam eius nobis.\n\nOdio aliquam voluptas laudantium perspiciatis voluptate. Quisquam laboriosam illo fuga iure. Esse ipsum sequi blanditiis debitis porro itaque. Eveniet nostrum reiciendis nisi recusandae blanditiis. Facilis incidunt quis illo quis dicta veniam ab quasi.\n\nMolestias eos expedita at cum totam amet aperiam. Nemo dignissimos facere vero. Voluptatibus voluptatibus amet dolores dolores nihil non aspernatur.\n\nCorporis explicabo et adipisci. Alias deserunt error at dolores.	80.48	\N	2018-03-02 17:24:05.873033+00	3	"1"=>"1", "4"=>"9"	f	t
263	Castro, Smith and Vargas	Temporibus facilis corporis eos ratione. Quam deleniti ipsum exercitationem corporis. Fuga sunt consectetur perspiciatis magni. A odit aliquam doloribus sapiente numquam eos.\n\nAperiam nostrum reprehenderit ipsum. Accusamus repellendus quae exercitationem nisi. Nihil nulla facere porro praesentium dolore provident.\n\nReiciendis explicabo velit ducimus unde ipsum corporis atque dolores. Ea minus explicabo deserunt adipisci perferendis ex recusandae. Rerum culpa laudantium maxime doloribus.\n\nImpedit illum cumque fuga consectetur atque. Dolorum cum animi quaerat delectus repellat quaerat voluptas natus. Voluptates deserunt ratione vero.\n\nVeritatis placeat officia aspernatur. Distinctio officia voluptatum voluptatum nobis temporibus aperiam commodi.	91.67	\N	2018-03-02 17:24:05.917266+00	3	"1"=>"1", "4"=>"9"	f	t
266	Scott, Anderson and Frank	Illo quia impedit ad sunt fugit. Laboriosam rerum reiciendis quisquam accusamus hic. Aperiam possimus eius magni porro quam error.\n\nEnim eaque itaque perferendis alias provident. Fugit reprehenderit quis asperiores error inventore hic ipsam. Quam voluptas minima illum debitis nulla eum enim.\n\nVeritatis incidunt delectus distinctio aut nisi. Repellat ab minima deleniti laudantium quisquam aliquam iure perspiciatis. Unde nostrum alias quod voluptate. Suscipit nostrum odit harum aliquam.\n\nOfficiis cupiditate quo nostrum. Placeat illo tempore illo corrupti in harum consectetur.\n\nQuasi voluptas quod in nemo provident doloribus harum sint. Est esse beatae culpa culpa fugit. Quaerat vitae placeat minima. Delectus tempora nobis quos dolores recusandae eum tempora.	69.93	\N	2018-03-02 17:24:06.063508+00	3	"1"=>"1", "4"=>"8"	f	t
343	Horne-Foster	Quo blanditiis sapiente incidunt quidem at. Deserunt veniam placeat harum quod odio. Ipsum dicta dolores qui labore. Dolor deleniti et dolorum sed officia a aspernatur.\n\nDicta vitae quae quisquam animi fugit architecto dolorem. Ducimus eveniet omnis ut quam aspernatur repellat. Nihil aut laudantium saepe esse nesciunt.\n\nEnim praesentium quas debitis minima dolorem. Enim enim sunt explicabo optio. Sit quas delectus ipsa est tempora.\n\nNemo dolores vitae facere hic ipsum. Quod totam molestias libero minus. Iusto asperiores rerum in accusamus. Dolore quae architecto nemo voluptatum molestias.\n\nAtque numquam a quae cum corrupti officiis. Nobis ex nobis dolorem unde. Consequuntur dignissimos neque eum ducimus omnis quidem.	67.00	\N	2018-03-03 17:20:28.890892+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
267	Alexander-Bryant	Consequuntur eum vero eos mollitia. Sit facere mollitia est ad ut neque officia repudiandae. Doloremque itaque nobis eius illo reiciendis dolorum. Ratione perspiciatis quas at commodi officia consequuntur doloribus.\n\nVelit praesentium aliquam delectus porro accusantium officia eveniet. Laudantium nisi impedit ad velit quo distinctio ad. Laboriosam doloribus dolor quo corrupti enim.\n\nMagnam reiciendis est vel occaecati ullam sequi alias occaecati. Laudantium dolorem natus nobis quod id quae. Ab asperiores praesentium esse delectus deserunt.\n\nQuisquam tempore odit possimus beatae et fugit. Quia impedit laudantium adipisci eligendi alias atque quo dolor. Nam asperiores rerum quas suscipit aperiam sit.\n\nDoloribus libero commodi inventore repellat. Occaecati veritatis id at quibusdam.	28.91	\N	2018-03-02 17:24:06.111981+00	3	"1"=>"1", "4"=>"9"	f	t
268	Chen Group	Laboriosam saepe vero impedit dicta consectetur a optio eveniet. Quas molestiae repellendus pariatur non.\n\nVoluptatibus temporibus repudiandae incidunt tempora explicabo. Similique voluptatibus officia et odio. Unde omnis repellat quis voluptates molestias magni fuga cupiditate. Enim ipsum eum consequatur voluptates nobis necessitatibus voluptate. Consequatur amet at eligendi fugiat sint praesentium eius.\n\nNobis inventore accusamus cum aperiam et. Repudiandae laudantium magnam provident tempore. Soluta nisi fuga quos consectetur voluptatem iste.\n\nError doloribus et corporis sunt esse. In sed fuga quis optio. Nisi explicabo modi tempora laborum dolore ullam sint.\n\nRatione ipsa possimus cumque quisquam modi aliquam. Nihil accusamus a id ut voluptas commodi. Officiis corporis reiciendis culpa nesciunt quaerat fugit.	52.60	\N	2018-03-02 17:24:06.153557+00	3	"1"=>"1", "4"=>"9"	f	t
269	Zamora-Daniels	Dolorum laborum voluptatibus delectus voluptate numquam. Ab cumque neque dolore molestiae molestias excepturi ea. Atque enim veritatis dolore voluptate praesentium. Reiciendis fugit praesentium voluptatibus animi sit numquam perferendis.\n\nOptio nobis quisquam esse inventore minima laudantium natus accusamus. Cupiditate impedit molestias asperiores iusto provident iste. Animi eius quae aspernatur consectetur deleniti iste. Occaecati distinctio necessitatibus occaecati harum iste minus. Adipisci minus sapiente praesentium asperiores deleniti quisquam cumque labore.\n\nAutem facere magni tenetur rerum quo error incidunt ut. Officiis eius animi reprehenderit ullam. Adipisci dolore ut rem reiciendis deleniti.\n\nMolestias dolorem voluptatem autem eos aspernatur non ut. Eligendi veritatis itaque rerum reprehenderit numquam voluptates. Corporis autem quis optio necessitatibus vitae error facere.\n\nSoluta delectus tenetur labore facilis veniam totam. Nemo iste eum modi perferendis error quam. Voluptate accusamus aut perspiciatis aspernatur recusandae minus sed. Atque deleniti totam soluta quasi provident quam nihil.	42.64	\N	2018-03-02 17:24:06.1999+00	3	"1"=>"1", "4"=>"9"	f	t
270	Rivera, Graham and Holmes	Doloribus laborum molestias error cum quisquam. Doloremque perspiciatis necessitatibus rem. Hic veniam exercitationem culpa sit officiis laboriosam recusandae.\n\nQuos quaerat iusto eligendi soluta ullam. Eos maxime ut molestias repellendus modi corrupti. Ducimus commodi repudiandae molestias maxime libero hic. Veniam molestias nobis reiciendis molestias tempora eum tempore.\n\nAspernatur eaque rem cupiditate quis dolorem qui. Similique a labore aspernatur atque. Rem magnam excepturi dolor dolor quaerat placeat nostrum.\n\nDebitis dignissimos placeat animi non magni soluta ad ratione. Ut aspernatur consectetur molestias temporibus illum ullam ipsa.\n\nInventore dolor beatae nostrum harum similique ab. Quaerat tempora maxime dolorem vero. Quo tenetur quisquam ab minima porro velit natus. Dolorum ut facilis unde suscipit.	84.30	\N	2018-03-02 17:24:06.246528+00	3	"1"=>"1", "4"=>"8"	f	t
271	Parker PLC	Unde magni culpa iusto autem. Neque placeat perferendis nulla saepe nesciunt perspiciatis. Blanditiis molestiae dicta voluptatem totam eligendi. Quo atque provident quos.\n\nDicta aperiam error illo. Odio minus necessitatibus minus expedita ducimus.\n\nFacilis eaque corrupti eum provident fugit maiores sunt ipsam. At provident maiores facere provident eum. Officiis consequuntur amet sunt velit minus ipsum fuga voluptatem. Sint incidunt consequuntur tempora occaecati fugit.\n\nAt fugiat atque alias repudiandae quasi quas. Id explicabo perferendis itaque itaque consequatur.\n\nOdio quibusdam ipsam odio mollitia eius quidem. Vel repellat modi dolor illum nam praesentium dolores. Vero sunt iure illum nam magni.	39.23	\N	2018-03-02 17:24:06.310651+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
272	Gregory Group	Magni quibusdam dolor adipisci quo omnis eligendi est amet. A aliquid quaerat cumque earum amet. Enim ullam tempore nesciunt ab minima modi. Fuga repudiandae fugit tempore odit.\n\nVoluptatibus autem accusamus quas ut quo ex. Blanditiis ipsum possimus ratione nisi neque ipsam. Ipsam odio repellendus illum in dolore reiciendis. Harum iure totam aliquid.\n\nPerferendis nostrum in est natus ea nihil. Odio molestias quis similique facilis impedit placeat et. Labore nihil magni eveniet excepturi doloremque laudantium cumque.\n\nCorporis accusamus libero vitae velit reiciendis architecto. Dolorum repellendus laudantium distinctio vel commodi asperiores. Iure esse non voluptatum quod blanditiis.\n\nError dolores voluptate dicta unde corporis. Incidunt eum aliquid debitis inventore iure iste. Voluptas aspernatur magni laborum minus aut molestiae qui distinctio. Magnam possimus occaecati repellat molestias. Tempore minus sint quam doloribus accusantium.	84.22	\N	2018-03-02 17:24:06.376882+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
273	Thompson Ltd	Reprehenderit provident ut cum neque pariatur accusamus. Dolorum perspiciatis itaque nam natus possimus odit. Molestiae suscipit cum suscipit officiis atque repudiandae. Quo a vero ab ullam.\n\nIncidunt ducimus minus enim sit aperiam facere. Quas tempora id inventore placeat sit accusamus eum cupiditate. Ea doloribus molestias error dolore.\n\nSoluta iusto recusandae reiciendis quo beatae ipsam totam. Enim debitis laborum cumque exercitationem dicta.\n\nRem illo libero beatae nihil officiis. Dolores dolores laborum explicabo voluptatem. Est neque nemo ut odio porro. Est hic nam saepe illum voluptatibus sint.\n\nFugit repudiandae ipsum ducimus eaque deleniti architecto iusto. Quas recusandae repellat necessitatibus tempore pariatur nobis eius.	85.44	\N	2018-03-02 17:24:06.426333+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
275	Turner-Sanchez	Voluptatibus perferendis reprehenderit iusto suscipit ratione. Consequuntur necessitatibus unde illum.\n\nNam ex distinctio sapiente laborum sapiente. Iure eligendi reiciendis dolores. Deleniti qui et ratione repudiandae commodi quo praesentium temporibus.\n\nQuibusdam molestias tempore mollitia ullam a repellendus. Beatae veniam dolorum accusantium non omnis unde. Nemo tempora voluptate sunt hic.\n\nNihil ducimus dolore molestias iusto quibusdam nesciunt. Voluptatum inventore doloribus soluta minus beatae a quos et. Voluptatum magni odit ratione delectus ullam neque accusamus tenetur. Officiis voluptatum vero consequuntur voluptate quas culpa cupiditate.\n\nExpedita delectus ratione nesciunt error saepe blanditiis quas excepturi. Illo architecto blanditiis officia corporis minima nam voluptatibus. Quia consectetur aperiam veritatis laborum totam eos.	95.31	\N	2018-03-02 17:24:06.557765+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
276	Wood-Brown	Laborum dolore natus quod et. Repellat possimus aut vel animi animi debitis nemo expedita. Voluptatibus dolorum voluptas cupiditate sunt laboriosam. Ratione deserunt repellat repellat facere aut maiores asperiores.\n\nReiciendis reiciendis expedita ipsa tenetur expedita atque animi. Doloremque optio modi ipsa est. Laborum aliquid reprehenderit molestias sunt voluptatem commodi. Nulla aspernatur praesentium soluta reiciendis dicta pariatur nesciunt.\n\nRecusandae voluptates aperiam nesciunt perspiciatis. Alias molestias ex doloribus commodi eligendi. Distinctio velit quis quas tempora quos harum velit. Fuga magnam incidunt possimus optio.\n\nDelectus quasi ducimus voluptatum eum rem quia cupiditate. Saepe reprehenderit accusamus vero laudantium ab.\n\nNam neque excepturi voluptate at accusamus aspernatur voluptatum. Deleniti corrupti est aut. Quibusdam corporis natus ipsa consequatur dolor.	35.38	\N	2018-03-02 17:24:06.616368+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
277	Lee PLC	Vitae inventore consectetur commodi in. Accusamus aliquam atque et adipisci nesciunt. Consequatur neque molestiae corporis assumenda sit minima tenetur. Nemo placeat laudantium perferendis provident dolorum rem.\n\nDeleniti expedita aliquam qui saepe totam repudiandae rem. Veritatis molestiae itaque eius possimus. Accusantium maxime doloribus eaque numquam minus aspernatur doloremque.\n\nUnde rem necessitatibus iure neque voluptates voluptatum odit. Vel quisquam accusamus repellendus hic iste. Culpa dolorum eaque rerum similique quas. Veniam vel sed suscipit eos.\n\nIste recusandae dolorem expedita modi consectetur. Quam possimus dolor cupiditate impedit possimus neque quaerat illum. Incidunt quibusdam laborum vitae velit eveniet ea voluptas. Aspernatur saepe recusandae magnam.\n\nCorporis ullam magnam eos similique consectetur nisi nostrum. Nesciunt itaque vitae nisi nobis sapiente nisi. Odio ullam inventore accusamus recusandae nemo dolores. Expedita enim esse optio eveniet eaque at.	74.42	\N	2018-03-02 17:24:06.684876+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
278	Gutierrez-Gonzalez	Doloribus exercitationem accusantium rerum provident. Sit tempora perferendis et numquam ex perferendis aliquam. Libero consequatur dolorem tempora reprehenderit nam culpa. Quas dolore cum sed fugit beatae occaecati quo.\n\nAspernatur ratione veniam quasi eius. Esse nulla distinctio pariatur iusto aperiam pariatur veniam. Quia tempora voluptatibus veritatis.\n\nDolore fuga consectetur magni cumque illum debitis. Ab sunt minus facere necessitatibus ab illo. Perspiciatis nesciunt recusandae veniam corporis ipsa.\n\nQuo veritatis sint mollitia id minus aut. Ipsum ipsam ipsum itaque ipsam sit. Repellat consequatur veniam corporis ex.\n\nNesciunt illum adipisci eligendi. Iste dicta quas fugiat expedita distinctio ut mollitia alias. Nisi voluptate porro autem dolorem nam fugit. Aut quas labore facilis unde voluptatem. A eum expedita in iusto quidem eaque harum dolorem.	97.86	\N	2018-03-02 17:24:06.750153+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
279	Mcdonald-Watson	Corrupti eius alias nisi temporibus sequi impedit fugiat. Sequi reiciendis autem enim. Vero ab doloribus id modi a dicta repellat eos.\n\nMaxime odit qui occaecati minus accusantium expedita natus magni. Fugiat voluptas saepe quia quia ipsum rem aut. Animi aspernatur cum sed esse.\n\nMagnam deserunt nihil dicta necessitatibus error. Laudantium rem repellendus accusamus tempore hic. Aspernatur nostrum labore consequatur dolores iste tenetur repellat nemo.\n\nMolestiae consectetur temporibus quam at. Ut eveniet rem maiores alias dolore amet illo fugit. Rerum inventore eligendi optio nostrum qui sunt.\n\nDucimus eligendi veniam odit accusantium earum nemo voluptate. Quisquam porro dolore eum reprehenderit enim tempore beatae. Ex molestiae assumenda sed adipisci odit error odit excepturi. Explicabo sint aliquid minus dicta provident similique temporibus dolorum.	10.69	\N	2018-03-02 17:24:06.811265+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
294	Willis-Zamora	Cumque quasi ad ipsum dolore laudantium distinctio. Natus doloremque aliquam fuga distinctio omnis esse.\n\nQuam nostrum nihil eligendi rem voluptas inventore ducimus. Quas exercitationem commodi distinctio deserunt. Ex nostrum praesentium dolorum ipsum consequuntur ex molestias.\n\nQuae minima molestias omnis exercitationem iste nihil. Itaque possimus repellat aliquid sapiente saepe. Quo molestias sit dicta exercitationem quam quam. Neque ab quas pariatur harum sunt veniam qui.\n\nNulla autem sit repellendus iusto. Ex eligendi autem repellendus nihil fuga doloremque alias. Vitae facere quod atque odit maxime. Eius alias fugiat commodi assumenda hic. Quidem consequatur fugit quas error aperiam.\n\nQuaerat deserunt non voluptatibus facere provident nihil. Delectus temporibus mollitia neque quo. Minus culpa unde aliquam quam consectetur perferendis repellat.	51.77	\N	2018-03-02 17:24:07.608488+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
295	Williams-Saunders	Rem fuga quasi consequuntur ut. Illo impedit facere laboriosam aliquid soluta tempora. Molestiae architecto sed consequatur cupiditate quos similique recusandae.\n\nIpsa illum quia quidem adipisci quo dolorem. Vero dolore modi nesciunt animi sapiente. Fugiat velit eum consequuntur animi. Magni magnam placeat fugiat.\n\nImpedit occaecati exercitationem suscipit molestiae earum. Id doloremque excepturi molestiae assumenda. Ipsum tempore libero occaecati architecto.\n\nIncidunt earum quae sapiente eaque earum debitis assumenda. Id labore consequuntur hic perspiciatis. Iste fuga consectetur natus tempore eveniet accusamus.\n\nAccusantium sed hic porro dolores porro tenetur. Beatae illum eaque repudiandae delectus sequi animi voluptatem quas. Saepe magnam dolorem in odit pariatur sint cum optio.	40.18	\N	2018-03-02 17:24:07.652005+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
280	Ellis, Woodward and Henderson	Sed unde facere quasi amet. Est reiciendis exercitationem qui adipisci odio. Inventore minus facilis itaque sunt fugit. Odio officia reprehenderit aspernatur sint. Asperiores veniam molestias non et id esse impedit.\n\nSequi animi non deleniti et odio voluptate sit tempore. Perspiciatis alias illo recusandae esse officia. Rerum tenetur sint voluptate fuga sapiente architecto. Culpa maiores quia inventore nam totam fugit. Natus qui error laboriosam iste eligendi amet aliquam.\n\nDeleniti sint est est officia. Porro aliquam earum suscipit. Dignissimos consequatur dolores dolores omnis explicabo porro commodi. Amet placeat accusamus perferendis.\n\nVoluptatibus molestiae nulla magnam sint modi et. Voluptatem fugiat non natus quidem animi harum. Quas sit nobis quaerat corrupti dolorem voluptates vero omnis. Aliquam molestias omnis ab dolor.\n\nAliquid modi voluptatibus eos iusto quae optio. Quas accusamus ullam molestiae asperiores dolores consequuntur vel. Dignissimos quo sint illo iste suscipit.	52.55	\N	2018-03-02 17:24:06.888182+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
281	Vargas Ltd	Blanditiis neque cumque quibusdam laborum alias facilis. Repellat adipisci asperiores molestias incidunt quaerat. Eligendi labore at eaque atque necessitatibus. Aliquam est labore dolorum.\n\nEaque voluptate est eaque omnis maiores soluta nam. Neque voluptates hic officia praesentium maxime sunt fugit.\n\nEst minus minima eveniet quos. Dolores consequuntur facere reiciendis sequi necessitatibus labore. Delectus eveniet eius praesentium.\n\nModi sequi incidunt recusandae optio ut ab. Dolorem dicta optio enim maxime voluptatem nihil. Sint maxime eos inventore nobis consectetur sapiente quia. Deserunt totam voluptas quidem similique hic necessitatibus. Itaque quam nisi aperiam earum eius vitae.\n\nCumque voluptate exercitationem cumque ullam. Velit a similique laudantium cumque voluptatum architecto. Perspiciatis enim culpa iure quidem consequatur iste. Vitae vitae architecto dicta molestias impedit rem accusamus.	81.66	\N	2018-03-02 17:24:06.951325+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
282	Walker LLC	Sed natus tenetur cumque. Quia qui neque deserunt iusto enim consequatur eum. Ab cupiditate excepturi eligendi. Velit ullam sequi ipsum occaecati nihil. Pariatur doloremque ipsum adipisci.\n\nQuod excepturi aliquam facilis amet. Quibusdam rem nulla assumenda consequuntur quam sapiente molestiae quis. Officia expedita iste officia harum. Esse temporibus labore ad eligendi.\n\nQuod tempore nisi rem qui ullam. Numquam commodi voluptas enim error nam provident ab quasi. Corporis repellat quo fugit labore sunt quod dicta. Quod ad rem doloremque eum laborum. Voluptate facilis numquam corporis assumenda.\n\nEx placeat mollitia quas quia assumenda fuga. Exercitationem eveniet nesciunt voluptatum. Dicta placeat consequatur minus quasi itaque. Id autem architecto dolore sint optio.\n\nAssumenda iste a laborum expedita voluptate in. Voluptatem sequi nostrum sapiente praesentium esse nesciunt sint.	10.48	\N	2018-03-02 17:24:06.984361+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
283	Lee-Edwards	Iure ab pariatur minus repellendus. Ratione mollitia vel veritatis consequatur.\n\nSoluta dignissimos repellendus rem numquam ipsa provident animi. Eaque voluptatibus culpa dolorum explicabo. Officia dolores maxime ut error ab. Cum suscipit minima vel sit nobis fugiat inventore. Eligendi illo ipsam ullam temporibus soluta tenetur exercitationem.\n\nAb molestias dolorum possimus vitae delectus dolores. Omnis dolores voluptas magnam fugit. Adipisci quidem quod omnis ducimus laboriosam a corrupti doloremque.\n\nVoluptatum fugiat consequatur a sed. Repudiandae porro at impedit. Voluptatibus voluptatibus soluta quas iste vero provident earum quis.\n\nIllo animi illum omnis quasi molestias praesentium similique. Est veritatis omnis culpa. Ab velit facere ipsam iusto.	27.18	\N	2018-03-02 17:24:07.035762+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
284	Hernandez-Curry	Repellendus laborum cupiditate quod libero quae culpa. Vitae dolorum libero consequuntur nostrum dolor culpa exercitationem. Eius perspiciatis nobis fugit aperiam earum. Sint odio porro error natus.\n\nCumque sunt eos deleniti similique harum qui. Officiis minima similique quia vero doloribus eveniet. Minima et enim reiciendis repudiandae fuga. Tenetur esse explicabo maiores earum praesentium asperiores.\n\nLaborum ullam illo inventore repudiandae reprehenderit quidem eaque. Cupiditate accusantium odio consectetur harum eaque sit. Blanditiis suscipit ratione aliquid delectus natus.\n\nIusto qui voluptatem architecto fuga odit possimus consequatur. Amet ipsam impedit consequuntur dolor illo. Earum amet distinctio optio laudantium maiores. Tempore ducimus libero id libero quisquam cupiditate.\n\nTempore quas asperiores eos. Rem dolor quod ab. Nemo dolores laboriosam doloremque repellendus. Quam laborum quas quidem quaerat est neque. Debitis id praesentium libero autem molestias dolores ullam.	66.00	\N	2018-03-02 17:24:07.084709+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
285	Nash, Leon and Cuevas	Quidem non nesciunt voluptatem nemo. At aperiam sapiente error laboriosam.\n\nRepudiandae rerum rerum aut quam accusamus magni exercitationem. Fuga quos aperiam placeat nihil aut similique porro id. Quod est id asperiores. Laborum quidem aliquam vitae.\n\nRepudiandae exercitationem ut saepe labore eaque. Consequuntur quis perspiciatis quae eos iste dignissimos iste. Iure earum impedit est magni.\n\nMolestias officiis delectus vero corporis illum debitis distinctio. Nam qui voluptatum doloremque reprehenderit cumque omnis voluptas natus. Quod suscipit corporis totam vel. Tenetur sit tempore tempore vel qui facere.\n\nEt deserunt saepe sed voluptates nihil. Laboriosam illum iure sit distinctio aliquam. Optio voluptatibus corporis animi voluptatibus debitis. Voluptatibus ex corrupti sint.	35.12	\N	2018-03-02 17:24:07.144787+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
286	Stanley, Young and Hooper	Labore reiciendis ea neque totam facere laboriosam ullam eveniet. Repudiandae magni facere cumque quam corporis quidem. Mollitia inventore enim aspernatur illo officia dolorum. Blanditiis assumenda repellendus tenetur aliquam.\n\nConsequuntur dolore mollitia unde aut. Accusantium ipsum libero laboriosam ab ad aperiam voluptatum. Excepturi ducimus quo deleniti facere. Quidem illo ab corrupti voluptas veniam ipsam.\n\nQuae impedit temporibus enim odio. Repellendus nobis quia unde non corrupti suscipit quasi. Ex delectus excepturi architecto autem tempore amet maxime.\n\nVoluptatum facilis praesentium qui in. Quis ipsam temporibus asperiores mollitia nobis. Architecto placeat eligendi corrupti libero omnis. Rerum nobis aperiam architecto illo voluptas.\n\nImpedit fugiat repellendus unde nemo hic. Numquam totam minima eius occaecati.	61.67	\N	2018-03-02 17:24:07.181494+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
287	Williams PLC	Aliquid minus assumenda consequuntur ad neque provident cupiditate. Veniam id aut perferendis ad nihil ex eveniet. Quos nemo velit quo. Sequi nesciunt iusto odit consectetur cupiditate itaque repudiandae.\n\nQuibusdam voluptatibus similique repudiandae eligendi asperiores. Distinctio nihil architecto odio nisi pariatur illum commodi. Necessitatibus aspernatur eligendi laudantium modi. Praesentium nostrum iure animi iste quasi.\n\nHic ipsa doloribus totam nostrum officia similique iste. Iure eius voluptatum voluptatibus consequuntur facere vero. Ducimus laborum cum itaque voluptas asperiores debitis officiis.\n\nAssumenda dicta atque ad cumque quisquam magnam. Velit vitae sint illum nostrum.\n\nA autem blanditiis expedita velit iure id. Sunt voluptate asperiores dolor tempore ea quibusdam. Voluptatum odit nobis placeat reiciendis velit recusandae. Vero unde officiis corrupti dolore. Quidem fugit ut voluptatem aliquam.	71.66	\N	2018-03-02 17:24:07.218543+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
288	Fowler-Jackson	Optio exercitationem laborum corporis libero dolorem. Earum sequi quod hic rem. Corporis error quidem optio atque.\n\nEa facere nulla error voluptate voluptatem amet similique. Quidem accusamus iure hic saepe ducimus. Laboriosam totam suscipit illum quae.\n\nMagnam aperiam rerum totam tenetur et nam placeat. Voluptatibus porro eum voluptatum ipsa esse dolore. In aliquam alias eaque reiciendis. Molestias sapiente quia error ipsam. Saepe ab dolore esse inventore distinctio.\n\nSunt sit necessitatibus quidem optio nulla ducimus sit. Assumenda in aliquam ullam voluptates. Repellat provident ipsum repellendus sunt. Repellendus saepe nemo alias autem officiis.\n\nNesciunt laboriosam voluptas sed dolore. Nesciunt nemo quas nihil ipsam.	66.13	\N	2018-03-02 17:24:07.295504+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
289	Montgomery Ltd	Culpa animi necessitatibus sunt. Doloribus nemo reprehenderit cumque repellendus. Repudiandae fugiat dolores vitae. Explicabo modi earum quia.\n\nNatus mollitia ab accusantium officiis itaque sapiente iure. Sequi dolorum facilis ratione eos ex nisi. Officia dolorem veniam vitae fuga deleniti aspernatur.\n\nEsse fuga consectetur veritatis iure libero ullam minima. Natus earum repellat quo. Iste recusandae numquam accusamus commodi.\n\nAliquam sapiente consequuntur consectetur dicta assumenda aliquam voluptas. Aliquam iste asperiores sapiente veniam doloribus. Consequatur numquam distinctio iste asperiores architecto illo. Totam commodi asperiores adipisci. Voluptates iste et dolor fugit.\n\nCum earum maxime vel vitae. Nam neque aliquam adipisci non quas fugiat. Molestias explicabo repellendus architecto officiis mollitia.	17.90	\N	2018-03-02 17:24:07.354586+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
290	Morgan-Travis	Sit dolorem similique sit magni animi suscipit. Quo magni incidunt aperiam sapiente quas perferendis assumenda. Sunt quasi harum reprehenderit voluptate nulla consequatur excepturi similique.\n\nIusto repellat officia magni ducimus. Voluptatibus consectetur doloribus delectus suscipit. Amet alias occaecati veniam consectetur corporis accusamus. Quisquam totam necessitatibus eveniet blanditiis inventore quam.\n\nAnimi culpa odio veritatis fugit possimus. Incidunt molestias vitae vel fugiat pariatur magni rerum debitis. Culpa repellat totam modi. Natus dolores corporis consectetur sequi dolorem aliquam.\n\nMaiores labore repellendus veritatis animi neque. Itaque delectus omnis molestiae numquam maiores. Quos dolorum cumque accusantium. Velit sequi saepe natus fugiat vel ipsam possimus laboriosam.\n\nCupiditate quos accusantium sit ipsam aliquid illo placeat illo. Occaecati accusantium occaecati quam nemo. Dignissimos nostrum nam commodi iure suscipit magni voluptates. Ab aperiam alias reiciendis consequatur vitae cupiditate.	82.36	\N	2018-03-02 17:24:07.407842+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
291	Guerra-Baker	Iusto temporibus fuga atque adipisci animi error. Dignissimos harum reprehenderit vero consequuntur libero. Autem aspernatur repellat maiores rerum similique soluta assumenda. Numquam dolore harum numquam velit id fugit reprehenderit. Officia ut at ut ea nemo nostrum dolorum.\n\nQuas pariatur natus sunt asperiores veniam nam. Nam minima accusamus hic nemo esse consectetur natus veritatis. Eligendi reprehenderit cum ratione perspiciatis sequi quam.\n\nEst beatae asperiores aliquam. Iure quis assumenda adipisci eius reiciendis. Commodi itaque ex quis ex ex.\n\nDolores sequi voluptas id corrupti facere expedita. Modi quam nemo ullam laboriosam aliquam temporibus. Cumque debitis nulla accusantium quidem ullam.\n\nPlaceat nemo reiciendis quidem quas voluptatibus vitae. Nostrum temporibus nam unde velit ad voluptate a. Molestiae laudantium quisquam magni eveniet hic officia vel ducimus. Nam inventore consequatur excepturi minima.	88.19	\N	2018-03-02 17:24:07.473383+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
292	Whitaker Ltd	Delectus illo error recusandae expedita. Animi aut quasi adipisci animi doloribus nisi. Corrupti aspernatur nihil alias impedit voluptate consectetur.\n\nSaepe sed vitae ullam blanditiis omnis. At excepturi possimus non sint aliquam magnam exercitationem laborum. Tenetur laudantium accusantium eum totam dolorem.\n\nOdit rerum cumque nesciunt doloribus repellendus quae temporibus nostrum. Debitis consequatur repellat consequuntur non. Quasi nobis illo earum doloribus quaerat.\n\nNemo at tempora sapiente quam. Eius quaerat aspernatur dignissimos laboriosam esse quos. Molestiae sint corporis dolores quisquam quas rerum suscipit. Quasi nesciunt iste illo perferendis hic eligendi doloribus porro.\n\nQuas libero doloremque maxime cum quidem blanditiis. Mollitia optio ipsam similique distinctio culpa. Alias sapiente quo iusto provident assumenda.	43.87	\N	2018-03-02 17:24:07.514708+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
293	Fields-Nelson	Quia laudantium vero unde nulla veritatis laudantium. Amet alias amet praesentium repellat provident quam. Tenetur eos dolorum tempora odio alias rerum eaque. Vero excepturi sunt et eaque commodi accusantium.\n\nBlanditiis harum odit dicta iure eius ratione autem. Ab voluptatibus labore ratione blanditiis doloribus. Illum ab odit tempore nemo officia magni.\n\nEt consectetur voluptatum in. Pariatur tenetur quod nesciunt. Eaque soluta fuga autem illo aliquid. Voluptatem dignissimos laudantium praesentium eveniet dolore odio voluptatibus.\n\nQuos labore perspiciatis hic. Quidem excepturi dolorum eum vero. Molestiae ratione pariatur fugiat esse at. Illo quam adipisci rerum nihil ducimus sit fugiat.\n\nBeatae fugiat neque quae cumque. Sit quis unde enim aliquid fugit nulla facilis. Laudantium laudantium magnam soluta aspernatur non minima.	89.36	\N	2018-03-02 17:24:07.560563+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
296	Collins, Andrews and Williams	Sequi eum recusandae animi totam explicabo soluta totam. Possimus totam recusandae expedita corporis a voluptatum. Accusamus reprehenderit aperiam illo repudiandae consequuntur.\n\nRepudiandae laborum mollitia assumenda dicta. Accusamus quaerat iure veniam unde assumenda. Iure at necessitatibus nobis dolore. Quibusdam et tenetur debitis.\n\nRepellat sed similique in ab eos incidunt sit. Dolorem asperiores atque ab. Fugiat expedita nemo iusto neque. Praesentium voluptas autem fugit deleniti officia.\n\nVeritatis cum voluptatum a sed sapiente magni. Culpa quae nesciunt provident itaque quasi. Ex voluptas eveniet dicta.\n\nCorporis sapiente voluptates adipisci nisi. Dignissimos sunt sit repudiandae sed. Ipsum non ab pariatur porro recusandae ratione.	1.21	\N	2018-03-02 17:24:07.696856+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
297	Smith-Huffman	Excepturi atque qui dolores eaque est. Corporis odit voluptatum nihil voluptatem odio dicta. Libero occaecati praesentium nemo consequatur. Earum culpa cupiditate ea quibusdam.\n\nAsperiores dolorem officiis quo doloribus facere molestias. Ratione iusto laborum doloribus aliquam maiores quas. Ab sint sint commodi nostrum consequatur nam beatae.\n\nDolorem hic sint totam quam reprehenderit eos necessitatibus. Non minus ex eveniet tempore in in laborum delectus. Necessitatibus beatae quos veniam eos.\n\nIusto tempora fuga facilis deserunt eum minima. Provident ut nam reprehenderit earum labore voluptatem nobis dignissimos. Sequi quis nesciunt corrupti eius debitis. Reiciendis veritatis mollitia eaque tenetur.\n\nPossimus culpa harum quae. Quisquam ad consectetur maiores necessitatibus dolorum esse nostrum a. Nostrum voluptatum consequuntur maxime mollitia. Ipsum impedit corporis saepe aut rem architecto molestiae.	99.61	\N	2018-03-02 17:24:07.741804+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
298	Schneider, Garcia and Lopez	Perferendis porro dolorum maiores quo amet nihil quos. Nemo aspernatur consequatur ducimus ex sint quam. Ullam laborum recusandae dolor sit.\n\nRerum dolor neque asperiores perferendis. Suscipit corporis libero porro debitis exercitationem ipsam libero. Atque nulla alias nisi fugit delectus corrupti est libero.\n\nVoluptatem eos ab sunt veniam laudantium soluta laborum. Quidem iste reprehenderit exercitationem nam molestias incidunt repellat. Assumenda magnam quam a sunt molestiae laboriosam.\n\nCulpa ducimus dolore iusto ipsum possimus. Illum beatae adipisci autem in. Voluptatibus commodi exercitationem tempora officia ullam laudantium dicta. Quia quam soluta illum placeat totam quis.\n\nQuos necessitatibus corrupti nihil vitae. Voluptatibus a quos facilis quia. Earum accusantium sequi nostrum voluptate. Illum modi assumenda repellat dolores distinctio earum.	45.97	\N	2018-03-02 17:24:07.779424+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
299	Mullins-Nelson	Aliquam recusandae omnis provident sit. Quod libero ipsam mollitia animi odio pariatur minima. Praesentium enim libero eum distinctio.\n\nExcepturi optio perspiciatis unde impedit dignissimos. Praesentium rerum veritatis adipisci nisi reprehenderit ratione. Asperiores officia non deleniti sunt labore.\n\nRepellat nam eius ea nihil accusamus rem molestiae. Optio numquam consequatur doloribus consequuntur maxime quasi blanditiis. Voluptatibus molestias maxime delectus error velit. Asperiores voluptate magni eveniet eligendi molestiae perferendis possimus blanditiis.\n\nQuam corrupti cumque dicta aspernatur exercitationem. Ut exercitationem amet repudiandae repudiandae hic aperiam reprehenderit. Inventore tempora atque accusantium repellendus quam magni.\n\nFugit necessitatibus accusamus quas eaque culpa cupiditate. Ipsum nulla praesentium aliquid omnis sit similique. Distinctio reprehenderit accusantium distinctio itaque. Dicta magni sapiente quia dolor suscipit unde earum. Dolores maiores ex tempora tempore doloribus.	75.60	\N	2018-03-02 17:24:07.830252+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
307	Fox-Weaver	Excepturi consectetur dolorum dolorum excepturi commodi libero. Alias repellendus animi omnis eos animi. Hic dignissimos minus eius debitis hic.\n\nNumquam fugit recusandae iure hic aliquid. Molestiae at mollitia earum laudantium consequatur. Animi voluptatibus blanditiis voluptate quod aut.\n\nNumquam magni esse beatae quibusdam. Odio modi sit quasi molestias placeat officiis eius. Ratione dolor ut temporibus repellendus debitis. Sequi animi excepturi ex rem similique hic voluptas assumenda. At ad tempore delectus ullam veniam.\n\nNatus quo autem perspiciatis necessitatibus quidem. Illo odio quaerat fugit quod possimus veritatis fugit ullam. Pariatur nam ex soluta iure sequi a deleniti. Culpa adipisci sint vel veritatis ullam.\n\nSunt deleniti officia reprehenderit dolorem. Consequatur ipsam odio inventore harum sequi ab molestiae.	36.91	\N	2018-03-03 17:20:26.321119+00	1	"1"=>"1", "2"=>"2"	f	t
308	Williamson and Sons	Fuga temporibus et a laboriosam sunt quae adipisci. Sequi velit quidem vel error saepe est officia. In vel nobis dicta reprehenderit eos possimus pariatur.\n\nVoluptate animi in saepe impedit amet doloribus. Provident accusamus voluptate autem debitis perspiciatis.\n\nQuam quidem qui tenetur amet consectetur officiis laboriosam. Odio dolores deserunt atque consequatur. Minima blanditiis atque ad iste fuga.\n\nEx earum distinctio incidunt provident cumque nostrum. Quae quos occaecati harum fugit facere corrupti deleniti. Doloribus quidem aliquid culpa nulla minus voluptatem neque. Asperiores quidem illo officia labore quia enim hic.\n\nFuga adipisci eum autem voluptates aut. Et esse eius commodi nobis quia ea cum. Expedita quaerat quae eveniet minus alias. Voluptatum nostrum voluptates enim perspiciatis.	75.90	\N	2018-03-03 17:20:26.399408+00	1	"1"=>"1", "2"=>"2"	f	t
309	Sanders PLC	Neque minus ipsa mollitia necessitatibus dolorem sequi. Qui facere facilis maiores placeat modi dicta voluptas est. Culpa et repellat est quibusdam porro occaecati autem. Soluta enim iste dicta velit.\n\nUllam rem dolor eius accusantium a. Nemo accusamus asperiores at sed sint aspernatur deserunt. Ipsum molestias magnam minus necessitatibus mollitia.\n\nLaudantium hic dolore ducimus consectetur odit. Magni illum hic esse a. Impedit aliquid sed animi sint. Totam libero ipsa maxime ex corrupti cum repudiandae.\n\nVoluptate reprehenderit illo perferendis reiciendis. Inventore adipisci laborum quibusdam ipsam laboriosam eligendi ducimus. Soluta omnis ullam suscipit at quibusdam nihil nobis.\n\nIpsa id fugit eaque quam omnis. Fugit laboriosam modi nostrum. Atque necessitatibus consequatur distinctio fugiat asperiores quae.	98.43	\N	2018-03-03 17:20:26.466652+00	1	"1"=>"1", "2"=>"2"	f	t
300	Hendrix-Hansen	Eum aliquam doloremque at provident eum excepturi accusantium. Harum autem culpa quod eum. Blanditiis dolorem fuga nulla facilis eveniet. Laudantium eos voluptatum assumenda mollitia adipisci.\n\nArchitecto voluptatum quae laudantium fugit. Numquam repellat natus dignissimos aspernatur est laboriosam. Neque excepturi unde corporis officia ratione blanditiis nam. Ex voluptatibus vitae harum ullam quasi. Repudiandae recusandae natus dolorem adipisci repudiandae quasi.\n\nIncidunt natus perferendis rerum quos. Veniam quidem totam dolor eos incidunt voluptatem. Nisi tempora nam repellat aperiam voluptas quod cum.\n\nVoluptas ullam tempore aliquam et voluptas praesentium distinctio voluptatibus. Aperiam consequatur dignissimos necessitatibus mollitia numquam. Voluptatem voluptatibus illum provident vitae.\n\nEveniet optio reiciendis occaecati dolore. Fugit occaecati explicabo aperiam molestiae. Porro at unde deserunt nostrum. Non consectetur quis vero facilis quia quisquam earum voluptates.	65.95	\N	2018-03-02 17:24:07.863072+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
301	Campbell-Bell	Tenetur cum ad eum eos earum repudiandae. Dolore dolorum deleniti consectetur ut occaecati fugiat iure itaque. Voluptatibus ratione repellat atque.\n\nCulpa dolor commodi maiores reiciendis. Beatae itaque facilis provident quidem. Explicabo hic quos et reprehenderit laudantium debitis.\n\nSed est atque ullam dolorum iste. Error vitae corrupti explicabo placeat expedita a quam. Recusandae aut corrupti blanditiis voluptatem labore dolore alias. Laboriosam odio quas aliquid modi quod hic eum expedita. Incidunt debitis occaecati explicabo architecto.\n\nTenetur illo ab incidunt aspernatur in. Dolorum quos cumque quasi repellat dolore. Repellat ea alias optio deleniti reprehenderit culpa beatae.\n\nInventore soluta at unde distinctio. Eaque voluptatum harum odit quos natus cumque aliquam vero.	84.89	\N	2018-03-03 17:20:25.714707+00	1	"1"=>"1", "2"=>"3"	f	t
302	James Group	Autem ex tempora dolor provident fugit enim ut. Ducimus optio eligendi molestiae. Similique eius distinctio dolores ab.\n\nLibero sit ut quibusdam sunt. Autem repellat ipsam necessitatibus dolorum veritatis molestiae. Veritatis enim et similique blanditiis aliquam.\n\nEius id quo quas perferendis alias placeat corporis harum. Quisquam provident illo neque. Tenetur alias enim consequuntur commodi impedit aliquam perspiciatis neque.\n\nAmet officia maiores consectetur. Voluptas aut aspernatur quibusdam culpa eligendi inventore. Dignissimos cum at nostrum nulla repudiandae et.\n\nVoluptatem iste iusto perferendis quia. Dolore deleniti maiores quo sit eius dolore sint repellat. Eius id fugiat exercitationem fugit illum molestiae.	34.50	\N	2018-03-03 17:20:25.951954+00	1	"1"=>"1", "2"=>"2"	f	t
303	Joseph, Swanson and Powell	Similique quo sint repellendus blanditiis numquam maiores repudiandae vero. Sed tempora repellendus voluptatibus rerum dicta architecto at. Aut distinctio neque ipsum praesentium. Porro rem cupiditate aliquam asperiores quod odit maiores.\n\nCorrupti neque deleniti non magni possimus repellat vel quas. Placeat fugiat nulla tempora provident laborum tempora necessitatibus. Maiores ea ea ratione repudiandae saepe voluptatum. Quia saepe esse placeat dolor asperiores odit impedit. Ducimus laboriosam dolorum aut consectetur sequi velit incidunt.\n\nUllam voluptates tenetur quo accusamus voluptatibus at. Architecto nihil pariatur doloremque qui impedit rem porro. Assumenda maiores iusto recusandae atque nam harum impedit.\n\nIncidunt molestiae assumenda est sed optio. Enim officiis omnis veniam laborum. Nostrum sit tempora autem. Ratione officia quae laudantium blanditiis incidunt sint earum.\n\nImpedit at aperiam beatae ex fugit odit. Nulla corporis ad ad quod.	62.90	\N	2018-03-03 17:20:26.011573+00	1	"1"=>"1", "2"=>"3"	f	t
304	Bates Inc	Quia optio necessitatibus alias quas vero. Expedita similique eaque quisquam doloribus ab. Quisquam ipsum velit eum.\n\nIste itaque commodi ducimus harum quos. Iusto corrupti expedita maxime aspernatur aperiam. Cupiditate quos sequi architecto beatae consequatur dignissimos temporibus.\n\nSuscipit incidunt ex repellendus magni odit ad asperiores harum. Tenetur maxime iure voluptatem alias dolores expedita dicta. Porro dolores delectus voluptas iure.\n\nSaepe eos vitae fugiat reiciendis id doloremque. Dicta repudiandae eius animi qui odit molestiae nostrum eos. Dolore magni soluta perferendis provident. Quae libero ab eos dolore voluptates odio dignissimos.\n\nMolestias dolorem excepturi accusamus. Repudiandae porro ut officia occaecati ipsam modi delectus. Cumque quo debitis vitae dolores doloremque praesentium odit animi. Non atque quidem harum tempora placeat.	89.14	\N	2018-03-03 17:20:26.072134+00	1	"1"=>"1", "2"=>"3"	f	t
305	Kaiser and Sons	Ad quod quod debitis provident nam. Modi minus in iusto sint minima placeat sint debitis. Quaerat eveniet eligendi ad illo quod est impedit rerum.\n\nNemo nam tempora autem tempore accusamus sint. Natus ea nisi natus commodi facere quia. Esse aperiam magnam voluptatibus quisquam harum. Esse facilis odit inventore fugit commodi.\n\nDistinctio dolorum velit ipsum enim veritatis cupiditate tempore. Sed magni laboriosam eligendi corporis numquam facere praesentium architecto. Repellendus occaecati illum officia ratione nisi.\n\nUnde molestiae recusandae quas blanditiis illo tenetur est. Non provident minus fuga aperiam repellat repellat suscipit. Laudantium minima ullam ratione beatae fugit laborum.\n\nCupiditate unde dolor harum similique velit eum. Ab adipisci molestiae quam est delectus. Aspernatur ratione corporis molestias beatae ad impedit occaecati.	87.60	\N	2018-03-03 17:20:26.160706+00	1	"1"=>"1", "2"=>"2"	f	t
306	Arnold, Cummings and French	Dolorum placeat eos impedit ullam necessitatibus laudantium. Beatae ratione maiores harum dolorum neque voluptate enim. Veniam et dolorem odio in.\n\nRatione exercitationem rerum nemo minus vero alias. Magni soluta laboriosam sequi earum adipisci asperiores tenetur. Vitae cum totam animi vero dolore reprehenderit amet.\n\nSapiente recusandae architecto excepturi tempora neque aliquam nesciunt. Distinctio quos magni qui voluptatibus voluptate distinctio. Nemo corrupti reiciendis fugiat minima magnam maiores ad. Modi vero vel totam dolor placeat tempora dolorum.\n\nVeniam natus reprehenderit animi atque. Eligendi quo laborum molestias inventore amet in. Saepe velit doloribus dicta nam corrupti sequi.\n\nAut distinctio labore rerum neque. Voluptate est maiores dicta explicabo. Minus fugit minus excepturi fugiat animi cumque. Quam accusamus ea architecto fuga laboriosam aspernatur placeat quidem. Ducimus impedit eos enim minus.	82.78	\N	2018-03-03 17:20:26.239005+00	1	"1"=>"1", "2"=>"3"	f	t
312	Fox-Williams	Commodi ut itaque possimus quos. Quasi modi numquam nemo soluta. Doloremque excepturi delectus minima mollitia vel fugiat quidem error. Ducimus rerum repellat cum quas modi placeat ea est.\n\nTenetur quibusdam odit sit non. Molestias architecto impedit aliquid cumque. Eos vero dignissimos minima explicabo qui. Aperiam debitis minus nisi labore maiores.\n\nQuaerat consequatur ab ea maxime consequatur nostrum dignissimos. In cum cum impedit porro quis quo. Reprehenderit eveniet corporis eum soluta laboriosam nisi. Debitis vitae fugiat minus sapiente enim vel.\n\nNam voluptates aliquid veniam nihil sequi ea repellat. Animi nihil et quo quibusdam voluptate maiores perspiciatis. Ducimus unde occaecati quidem quibusdam. Fugiat ipsam voluptate id illum laboriosam ea.\n\nInventore libero placeat facilis voluptatem vel. Aliquam voluptatum explicabo doloremque rem recusandae vero. Perspiciatis accusantium facilis reiciendis et ratione.	99.47	\N	2018-03-03 17:20:26.680399+00	2	"1"=>"1"	f	t
313	Austin, Kelly and Castillo	Quis molestiae architecto nisi error at error praesentium. Natus culpa maxime eum repellat dignissimos distinctio. Doloremque reiciendis repellat architecto eligendi ut blanditiis tempora. Vitae incidunt magnam eveniet molestias.\n\nHarum reiciendis aspernatur officia. Ad minus provident repellendus. Rem esse explicabo nemo cupiditate similique fuga.\n\nIn maxime non eaque labore veniam exercitationem. Cum odit perspiciatis eveniet vel asperiores. Doloribus exercitationem quaerat ipsa excepturi.\n\nIpsum adipisci non deleniti animi dolorum aperiam nulla. Eum repudiandae velit fugiat unde architecto. At odio commodi itaque sunt id. Eligendi natus iure sit explicabo ratione.\n\nA optio sapiente corrupti quis. Cumque id assumenda sunt quo modi voluptate cupiditate. Quod officiis dolore ratione.	17.36	\N	2018-03-03 17:20:26.76879+00	2	"1"=>"1"	f	t
314	Booker, Knight and Guerrero	Praesentium laboriosam fugiat beatae aliquam. Quos necessitatibus tenetur exercitationem.\n\nQuia neque illum ullam possimus nam dolore iste. Nemo quia perferendis eos provident doloremque. Delectus nobis unde accusantium totam voluptatem.\n\nVitae numquam distinctio omnis sunt voluptatem. Alias blanditiis magnam soluta optio. Illo alias reiciendis nobis vitae nobis. Quas iure voluptatum doloribus vero ut modi.\n\nSed a vitae iusto placeat. Sit repudiandae possimus blanditiis nam iure molestiae accusantium. Ullam vero dicta beatae delectus.\n\nVoluptatem dignissimos dignissimos ullam dolores sit asperiores. Odio cupiditate rem deleniti quasi sequi. Blanditiis quis incidunt soluta quisquam eligendi doloribus enim. Possimus dicta quod doloremque ut perferendis temporibus sit. Dolor praesentium possimus libero ut necessitatibus.	90.31	\N	2018-03-03 17:20:26.840862+00	2	"1"=>"1"	f	t
315	Hughes Inc	Consectetur eveniet veritatis enim iusto sunt omnis. Dolore aut impedit repellat deserunt recusandae laudantium sunt. Animi ea tenetur consequatur officia. Aut doloribus est id possimus quas exercitationem. Minima necessitatibus nobis dicta recusandae ab quaerat.\n\nOfficia quo ipsum qui sunt repellendus eligendi. Expedita laudantium quibusdam deserunt consequatur nostrum. Qui porro maxime cupiditate id quos. Iure sunt magni necessitatibus sunt.\n\nRem voluptate sequi officia delectus. Porro quisquam expedita ratione possimus. Officiis ex distinctio officia perferendis.\n\nVitae minus officia doloribus officiis voluptatem in. Velit odio sunt rerum nulla est. Possimus incidunt officia alias molestiae.\n\nExercitationem explicabo iusto ea sint excepturi commodi. Aliquid recusandae culpa magni eos cumque. Soluta ullam fugiat assumenda.	33.24	\N	2018-03-03 17:20:26.886652+00	2	"1"=>"1"	f	t
316	Lucero Ltd	Officia doloremque earum quis ea quia voluptatem vero facilis. Dolorum pariatur incidunt culpa nam sequi iure eveniet. Suscipit aut magni similique nisi eligendi occaecati.\n\nSaepe quaerat eligendi doloremque quam rerum ducimus dolorum. Iure delectus nulla exercitationem quia.\n\nDignissimos non ab aperiam iusto architecto cum. Eligendi atque aperiam libero aliquam dignissimos laboriosam odio. Placeat possimus error dolor placeat.\n\nEum vitae molestias dignissimos itaque voluptatum consequatur veritatis. Odit ullam deleniti iure ab voluptatem repudiandae alias.\n\nDolorem ex dolore magni nostrum. Doloribus doloribus eaque illo iste sed dolor suscipit. Placeat sequi laudantium nihil culpa quaerat qui aspernatur.	60.69	\N	2018-03-03 17:20:26.963395+00	2	"1"=>"1"	f	t
317	Ford-Grimes	Similique molestiae aperiam optio eveniet eum cupiditate autem doloribus. Inventore porro mollitia excepturi natus. Neque provident placeat corporis itaque. Totam necessitatibus corporis mollitia suscipit. Temporibus iure deleniti minus ipsum beatae tempore expedita animi.\n\nRepudiandae laboriosam laboriosam doloribus. Magnam dolorem iusto esse illum dolorem beatae. Officia veniam distinctio quas eius officiis.\n\nNesciunt eveniet optio voluptate quas autem modi perspiciatis. Alias aspernatur eveniet doloremque. Odit incidunt occaecati quaerat atque. Omnis aliquam corrupti delectus.\n\nAccusantium dolore animi iste beatae distinctio reiciendis nisi. Nemo fuga asperiores accusamus est consequatur. Officiis iste sunt iste ea vero. Quasi suscipit quisquam itaque aliquid suscipit quasi repellendus facilis.\n\nEt et dolorum magni quae in. Iusto magnam perferendis alias. Pariatur sint sapiente hic at.	76.48	\N	2018-03-03 17:20:27.024955+00	2	"1"=>"1"	f	t
318	Snyder Inc	Odio quaerat soluta numquam tempora libero earum doloremque harum. Laborum optio sint perferendis. Id sint nemo mollitia libero aut asperiores officiis. Nihil laudantium eius fugiat commodi minus dolorum. Maiores eaque similique earum architecto reiciendis.\n\nNon cupiditate quam quas quibusdam odio. Sint ad officiis at accusamus quasi. Impedit aperiam alias molestias eaque deleniti iure voluptas molestiae. Alias perspiciatis facere sunt et.\n\nIllum maxime laborum quibusdam temporibus dicta ratione explicabo tempora. Dolorum minima rem labore pariatur sunt eligendi quo voluptas. Quasi adipisci qui corporis aperiam. Cum provident et occaecati qui suscipit.\n\nDistinctio ipsum neque eos explicabo. Ex veritatis corporis doloribus incidunt laboriosam voluptatum eum dolore. Sapiente sunt ipsam officiis nobis veniam eaque. Beatae impedit nulla quibusdam beatae ipsum saepe. Eveniet deleniti laudantium tenetur aperiam sapiente sunt.\n\nEius totam doloribus expedita beatae. Assumenda mollitia eius officia porro. Modi adipisci quas minus quasi fuga.	53.80	\N	2018-03-03 17:20:27.068798+00	2	"1"=>"1"	f	t
319	Madden, Mitchell and Murphy	Quo necessitatibus itaque tempore impedit optio dicta. Ipsam molestias laudantium ab adipisci ullam maiores.\n\nQuaerat repellendus consequuntur pariatur qui. Praesentium adipisci iusto occaecati repudiandae voluptates pariatur. Fuga porro laboriosam sit ab aperiam. Molestias eum laboriosam aspernatur quo.\n\nEligendi facere officia illum repudiandae adipisci. Quibusdam ullam dignissimos vero officia. Qui accusantium recusandae ab sit mollitia aperiam fugiat doloribus. Asperiores veritatis exercitationem facilis inventore.\n\nAspernatur quisquam modi voluptatibus quae. Exercitationem voluptas delectus doloremque dolor officiis ullam voluptatem distinctio. Consequatur ullam unde odio nostrum tenetur quod beatae. Dolorem nesciunt recusandae quam consequatur unde amet distinctio.\n\nVitae tenetur cum voluptatibus. Earum fugiat ut a quae. Rerum explicabo saepe deleniti esse pariatur ab eaque. Eos ad laudantium temporibus cupiditate atque.	60.42	\N	2018-03-03 17:20:27.116836+00	2	"1"=>"1"	f	t
320	Phillips, Chen and Green	Aspernatur id commodi sequi. Maiores ullam perferendis cupiditate eaque voluptatum. Quas ipsum omnis cumque doloremque mollitia.\n\nPorro iste accusantium eum quo quae. Deserunt mollitia dolorem possimus rem molestiae. Sunt nam corporis officia cupiditate. Harum ipsam illo dicta dolores reiciendis odio unde.\n\nIn iusto dignissimos quis quis. Nesciunt natus ab corrupti.\n\nTotam nulla nemo ipsa pariatur. Rem dolores facilis esse commodi possimus. Facere recusandae reiciendis porro quaerat maxime eligendi id ratione.\n\nFacere delectus aliquid distinctio totam iusto. Recusandae praesentium libero modi amet quo tempore accusantium. Voluptate nam dolor ab commodi dolorem.	81.20	\N	2018-03-03 17:20:27.167377+00	2	"1"=>"1"	f	t
321	Martin-Baker	Esse quos beatae sed voluptates occaecati autem eveniet. Placeat amet modi ducimus veniam. Fugit eligendi corporis optio tenetur. Vero tempore nulla blanditiis non magnam dolores. Soluta cupiditate animi reprehenderit maiores earum fugit.\n\nDelectus voluptas possimus exercitationem similique. Asperiores eos ipsum mollitia corporis tempore cupiditate praesentium. Occaecati voluptatibus nulla iste tenetur.\n\nAd quae maiores necessitatibus atque corrupti repudiandae. Molestiae harum unde vel optio ullam harum nam. Neque quo laudantium fuga explicabo inventore.\n\nDeserunt veniam suscipit ipsam asperiores voluptas laudantium perspiciatis. Laudantium inventore vel harum odio expedita similique. Distinctio nemo et cum unde et.\n\nDicta ut illum molestias aliquid minima deserunt consequatur. Quos culpa qui officia amet. Qui blanditiis deserunt cupiditate.	94.29	\N	2018-03-03 17:20:27.227215+00	3	"1"=>"1", "4"=>"9"	f	t
322	Dalton-Black	Omnis qui quis ipsa debitis. Dolores velit ipsum exercitationem nam.\n\nDelectus eligendi at sint dignissimos quam eos. Unde quia expedita ea voluptatibus labore. Debitis autem quis distinctio rerum qui tempore quae. Nulla excepturi ad fuga fugit delectus. Similique quia vero impedit officia.\n\nProvident placeat dolor error ducimus et. Ullam neque quidem id mollitia. Excepturi accusantium pariatur voluptatibus doloribus tempora saepe cum a. Sint modi laboriosam necessitatibus delectus veritatis. Eaque non reiciendis consequuntur quos illum explicabo.\n\nModi accusantium alias vitae optio quae deleniti. Ratione explicabo asperiores mollitia tempora. Libero dolorum recusandae nostrum soluta reiciendis. Saepe ratione perferendis suscipit.\n\nRerum facilis ad facilis tenetur incidunt temporibus. Ea voluptas aut nulla minus quia.	2.53	\N	2018-03-03 17:20:27.303952+00	3	"1"=>"1", "4"=>"8"	f	t
323	Wong Ltd	Incidunt magni ipsa omnis. Velit excepturi rerum natus saepe. Facilis ducimus magnam laudantium doloribus consequatur iste.\n\nQuo earum corrupti praesentium itaque adipisci vel voluptates debitis. Aliquam saepe nihil voluptatum vel. Suscipit atque perferendis tenetur reiciendis. Odio id animi deserunt pariatur sed voluptate. Corporis voluptatum autem itaque eligendi eligendi.\n\nDeserunt corporis quidem iure voluptatum placeat fuga explicabo. Officiis enim enim officia cupiditate quidem ullam. Laborum dolore perspiciatis praesentium in vero perferendis. Atque ullam eius voluptatem laborum totam. Distinctio officiis iure totam hic eum ipsam in.\n\nCulpa cumque veritatis eveniet recusandae labore dicta. Non quod iure sunt iste animi officia ex. Expedita neque sapiente iusto suscipit.\n\nOfficia laudantium temporibus quas in incidunt. Qui quo itaque quia fugiat nobis qui atque velit. Quod provident iusto fugit dolorem eligendi. Aperiam occaecati porro quaerat ullam aliquam fugit.	47.90	\N	2018-03-03 17:20:27.354181+00	3	"1"=>"1", "4"=>"9"	f	t
324	Jones-Castro	Voluptatem enim autem placeat vel officia nemo vero reprehenderit. Dolorum quod at atque totam corrupti voluptas fuga. Non ea ea optio in earum dolorem illum.\n\nAb quas earum earum enim. Temporibus ratione deleniti nesciunt eius nostrum necessitatibus voluptatibus. Laudantium quibusdam optio vel cum et. Eius eos iste iusto assumenda inventore quidem rerum. Ipsam alias blanditiis molestias hic alias.\n\nImpedit odio voluptate accusantium temporibus iusto eum. Et sequi fugit vel. Ipsam dicta repellendus quasi placeat. Aperiam saepe minus exercitationem velit beatae.\n\nOdit ex minima dicta rem libero voluptatibus. Illum facere occaecati optio alias ratione fugit. Nulla nobis laboriosam cumque optio dolorem.\n\nDelectus est ipsum facere laudantium. Nostrum unde reprehenderit labore quidem totam repellendus cupiditate explicabo. Dolor quidem iste dignissimos iusto dolorum nesciunt corrupti.	52.47	\N	2018-03-03 17:20:27.415416+00	3	"1"=>"1", "4"=>"9"	f	t
325	Willis-Simpson	Cum ab distinctio odio rerum. Voluptates facere totam blanditiis dignissimos itaque. Omnis ratione totam blanditiis eveniet accusantium quibusdam.\n\nVoluptas nobis dolor ullam. Repellendus nisi accusantium rem laboriosam doloremque sint.\n\nAut vel numquam consectetur officia distinctio dignissimos. Qui id fugit ullam ullam magnam. Dolor inventore officiis atque. Aliquid perferendis occaecati qui consectetur excepturi.\n\nFacere cum magnam blanditiis. Cum distinctio officia veritatis totam quia adipisci.\n\nQuia dicta ratione id repudiandae id doloremque. Id ex odio aspernatur voluptas fuga.	30.95	\N	2018-03-03 17:20:27.484674+00	3	"1"=>"1", "4"=>"8"	f	t
328	Burch-Mckay	Autem perferendis dicta assumenda unde minus velit modi atque. Deleniti accusamus quae hic perspiciatis enim possimus. Libero quos autem veniam delectus vel incidunt.\n\nVoluptas suscipit explicabo sequi nostrum. Dolore rem dolor itaque. Error laudantium cumque sequi temporibus natus excepturi quos.\n\nSed esse ratione nesciunt cupiditate sed. Dolorum adipisci laudantium culpa explicabo quaerat rem numquam expedita. Rem ea maxime quisquam quos perspiciatis iste maiores repellat. Sit sunt quis nemo in pariatur quam repudiandae.\n\nMolestias commodi est unde deserunt asperiores. Alias enim corrupti tempora exercitationem. Nam a vero deleniti non enim nihil.\n\nLibero repellat doloremque error expedita quibusdam pariatur. Porro harum adipisci iusto fugit. Doloribus sed quas suscipit reiciendis et.	92.47	\N	2018-03-03 17:20:27.676367+00	3	"1"=>"1", "4"=>"9"	f	t
329	Roberts Ltd	Suscipit maxime occaecati dolor commodi eligendi enim. Facilis neque laudantium quis repellendus. Eum totam aliquam illo deleniti pariatur.\n\nOfficiis natus exercitationem sed delectus temporibus. Nemo quisquam accusamus quasi. Praesentium suscipit laboriosam quo magni aliquam aliquid assumenda.\n\nNemo nam tenetur ullam. Minima atque occaecati ea enim maiores occaecati autem.\n\nBlanditiis sunt ipsam enim architecto facilis. Ex reprehenderit praesentium provident veniam. Fuga nulla voluptatum velit deserunt dolores dolores.\n\nOdio odit possimus veritatis molestias facilis. Dicta atque reiciendis velit facere. Ad aut libero nulla fugit velit. Culpa tempora doloribus architecto dolor.	65.78	\N	2018-03-03 17:20:27.734142+00	3	"1"=>"1", "4"=>"9"	f	t
330	Hicks-Grant	Distinctio quae dolorum consequuntur tempore sint. Tenetur corrupti dolorem ea tenetur. Possimus provident harum id blanditiis quisquam.\n\nMaiores voluptatum eum expedita ipsam. Itaque temporibus dignissimos illo atque repellat eligendi deserunt. Officia quo quidem tenetur id saepe.\n\nUnde commodi nemo delectus quia. Voluptatem molestiae repudiandae quo quisquam aperiam sunt. Quibusdam corporis beatae quas dolore ullam. Dolor ullam repellat consequatur explicabo reiciendis ullam officiis.\n\nError iure magnam omnis aspernatur sunt. Labore ipsum perferendis fuga. Aperiam distinctio et tempore.\n\nError molestiae illo nemo in cumque dicta. Illo iure laudantium tenetur laudantium. Cumque iusto quam natus tempora molestiae a voluptates. Rerum animi dolores eaque sed.	63.84	\N	2018-03-03 17:20:27.792888+00	3	"1"=>"1", "4"=>"8"	f	t
331	Perry-Carr	Illum sunt assumenda reiciendis. Quaerat asperiores impedit voluptas. Voluptatem esse voluptate asperiores ipsa officiis. Optio nemo culpa nemo possimus tenetur.\n\nIpsum repudiandae consequuntur occaecati aspernatur ipsa a distinctio. Rem quas culpa ipsum nisi impedit. Consectetur veniam fugiat ex fugiat quisquam labore sit itaque. Aspernatur quasi officia ut quisquam laborum.\n\nVoluptatibus tempora deleniti provident. Porro ipsa modi rem vel. Eum veritatis accusamus perferendis ullam qui tempora tempore debitis.\n\nIncidunt et explicabo nihil magnam ducimus animi dolorum. Neque qui nam unde vitae enim quaerat. Autem debitis natus ipsa quod odit.\n\nVel quas modi excepturi optio nesciunt vero accusamus. Rerum quae provident laudantium facere a ipsam labore temporibus. Harum ad tempora ea odit. Sit accusantium harum harum quo autem veritatis quaerat.	23.50	\N	2018-03-03 17:20:27.872972+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
416	Brooks-Marshall	A ipsam tenetur doloremque ea. Adipisci magnam facere voluptas impedit a. Distinctio dolore pariatur eos voluptate officia.\n\nIusto voluptatem voluptas repudiandae dolor. Iste qui blanditiis repudiandae. Nisi quisquam velit sequi ducimus odit. Rem a mollitia quidem.\n\nLaborum autem odit quas esse autem quae. Ab aperiam ut ipsum culpa soluta. Consequatur necessitatibus ab optio architecto. Recusandae dolorum nesciunt porro voluptas dignissimos.\n\nA perspiciatis rem repellendus ab error quia. Distinctio explicabo dignissimos reiciendis rerum ea est sequi. Sequi veniam voluptatibus ipsa inventore quis.\n\nDolorem deleniti velit porro tempora adipisci. Animi rerum error rem nobis. Tempora accusantium a delectus quos consequuntur.	68.61	\N	2018-03-13 03:22:31.417602+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
417	Williams-Reid	Deserunt autem magnam in dolores enim reprehenderit. Doloremque accusamus iste sint quae omnis nisi quidem ipsam. Aliquam laboriosam at voluptas minus mollitia.\n\nNumquam nobis nulla atque cum. Dolores eveniet error dolore voluptatem id nobis. Ad debitis autem velit sint voluptate. Quam rem tempora animi tempore animi omnis.\n\nPorro dignissimos impedit quo animi blanditiis labore. Dignissimos nemo non aut natus. Nemo sed voluptatem non similique eos iste quibusdam.\n\nMinus quibusdam qui ratione cum. Sint et saepe quo nulla suscipit perferendis ipsum. Exercitationem dolore officiis consectetur ex saepe dolore nobis.\n\nDebitis ad enim quibusdam beatae assumenda. Minima velit nemo dolores quis perferendis. Sequi quisquam totam consequuntur quia inventore dolorem.	30.92	\N	2018-03-13 03:22:31.462449+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
332	Marquez Inc	Voluptate nisi sequi ducimus distinctio ipsam. Optio illum ut deserunt totam maiores delectus nam. Perferendis adipisci iusto officiis blanditiis nostrum explicabo.\n\nMolestias ex distinctio magnam iure. Doloribus fuga officiis minima mollitia minus. Expedita quisquam recusandae laborum placeat. Voluptatibus necessitatibus voluptatem reprehenderit in beatae.\n\nExercitationem cupiditate eligendi recusandae distinctio. Temporibus illum assumenda corporis magnam nobis quam. Ipsum quos sapiente suscipit sunt laudantium. Commodi deleniti sint officia ullam suscipit aspernatur.\n\nExplicabo quod saepe occaecati sapiente veritatis unde consequuntur ipsum. Eos itaque mollitia deserunt cupiditate. Mollitia corrupti voluptas itaque perferendis. Aut voluptates sunt corporis totam perspiciatis non.\n\nQuae odio id eum dolores quaerat deserunt tempora. Nostrum illo quibusdam maiores laudantium accusamus possimus delectus. A vitae nihil molestiae praesentium distinctio. Eius fuga laudantium dolore blanditiis quis quaerat consequatur.	63.18	\N	2018-03-03 17:20:27.99303+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
333	Harper, Holt and Evans	Aliquid vero quaerat praesentium. Consectetur eum commodi a dolore est unde.\n\nNecessitatibus accusamus dolore molestias quos repudiandae dolorem. Corporis sequi dolore ab quod praesentium modi. Vel vel animi quas rerum saepe eos maxime. Asperiores aliquid laudantium quisquam magnam nihil nesciunt a cumque.\n\nDeleniti aspernatur doloremque laudantium pariatur aut quam hic sint. Doloribus tempore eos odio. Repellat eum modi eos hic possimus. Ut esse repellendus omnis laudantium.\n\nId sint consequatur assumenda beatae. Aliquam eos quaerat molestiae ut. Porro vel distinctio veniam ad nisi pariatur maxime.\n\nTempora nobis nemo minus dolorum suscipit vero vero. Maxime consequuntur eaque ullam aspernatur distinctio officiis natus. Deleniti iure minima necessitatibus saepe. Officiis iure aut cumque modi.	77.90	\N	2018-03-03 17:20:28.090248+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
334	Madden Group	Hic rerum iusto eaque sequi neque modi impedit. Ipsa mollitia inventore reprehenderit. Atque voluptas ut aut excepturi quos ullam. Dolorem repellendus sapiente eveniet id.\n\nOfficia beatae quo nobis similique. Rem nihil quos veniam nisi natus odit. Nemo dignissimos officiis vitae quisquam.\n\nError minus vel quae harum rem non delectus. Ipsam eum officia magni dolorem dignissimos. Labore sapiente iusto porro fugiat sed ullam.\n\nUnde impedit laboriosam praesentium molestiae blanditiis aperiam. Velit et ipsam illum voluptate dolorum. Unde dolorum a dignissimos ducimus aperiam. Nostrum nemo laboriosam exercitationem earum fugiat odio.\n\nIure nulla debitis dolore consequuntur. Nulla beatae iusto repudiandae tenetur neque ab sapiente.	59.40	\N	2018-03-03 17:20:28.175826+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
335	Burns-Schroeder	Nesciunt fuga maxime harum quis. Deserunt non veritatis magni molestiae. Eaque earum culpa quasi magnam vel cum ipsam. Enim amet delectus molestiae quo nesciunt.\n\nRatione nesciunt quaerat suscipit sunt sed. Facere velit omnis incidunt odio accusamus. Maxime officiis at modi sint.\n\nEaque facere sapiente veritatis laboriosam laborum animi. Culpa enim sapiente saepe ratione exercitationem numquam repudiandae consequuntur. Iure eos odit similique necessitatibus.\n\nMaxime adipisci incidunt laudantium aspernatur aliquid. Nobis nam iure quaerat voluptatum cumque accusantium. Ducimus temporibus veniam eum vel facere. Sunt id ea dolore culpa minus ad.\n\nId recusandae architecto quibusdam laborum exercitationem. Dolore nam voluptatum fugit officiis ullam repellendus facere. Ratione repudiandae quibusdam dignissimos eveniet quae culpa. Eveniet quas at corporis harum aliquid rem.	23.62	\N	2018-03-03 17:20:28.261622+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
336	Riley and Sons	Doloribus reiciendis voluptate voluptatibus odio culpa. Possimus eveniet iure ducimus ea. Occaecati quibusdam odit fugit dolore at facilis quo.\n\nPraesentium quos tempore deleniti corrupti quia atque tempore. Corporis qui quasi consectetur iusto neque nemo soluta. Ducimus eaque quas quasi cupiditate. Quam soluta quo magnam.\n\nQuibusdam saepe esse doloribus magnam saepe quas consectetur. Aliquam temporibus optio natus occaecati unde architecto libero. Dicta adipisci exercitationem dolorem. Reprehenderit veritatis nostrum eius qui asperiores.\n\nDolor in fugiat at. Libero illum repudiandae iure dolor perspiciatis incidunt commodi. Explicabo velit itaque odit cumque molestias error tempore. Assumenda veritatis earum quasi repellendus.\n\nNisi unde distinctio sint repellendus porro. Voluptas unde molestias aut similique odit ratione sapiente praesentium. Nulla aliquid laboriosam pariatur tempore nihil dignissimos. Dolor suscipit reprehenderit in ab sit iusto.	97.30	\N	2018-03-03 17:20:28.331425+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
341	Arnold and Sons	Dolores molestiae labore voluptate sit ab dicta nisi. Totam quod iste vel dolor laboriosam architecto dignissimos. Ratione accusantium et est magnam. Debitis asperiores nesciunt quod aliquid tenetur.\n\nDoloremque enim animi nobis cumque. Praesentium libero earum natus necessitatibus quod necessitatibus. Consequuntur veritatis placeat temporibus. Eligendi quaerat praesentium excepturi tempora similique et.\n\nQuis doloremque quaerat magni porro distinctio. Voluptates neque tenetur molestiae magni esse asperiores.\n\nEligendi quae magni fuga quaerat deleniti error. Reiciendis voluptates quaerat saepe sunt. Veritatis voluptas perferendis quia optio quas tempore provident.\n\nAtque amet exercitationem labore minus deserunt repudiandae doloribus. Dicta est nam consequatur iusto natus recusandae. Neque nulla et voluptatum minus dolore voluptatum.	71.81	\N	2018-03-03 17:20:28.748932+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
342	Ramirez LLC	Vitae eligendi fugiat exercitationem nihil quam doloribus. Veritatis ut nostrum officia. Temporibus similique maxime ipsa vel nam atque. Temporibus modi reprehenderit eum nemo.\n\nVoluptate laborum assumenda accusamus fuga illo ipsum eveniet dolorem. Fugit quae sed at dolor. Labore blanditiis recusandae reiciendis earum. Dignissimos ut ad minima aspernatur repellat sequi assumenda nemo.\n\nRepellat sapiente dicta omnis sapiente excepturi. Voluptatum veniam odio dolorum.\n\nAsperiores non temporibus exercitationem quisquam sit modi. Animi id velit harum odit molestiae tempora. Similique aut sed cumque quam. Blanditiis ab rerum ratione ab modi facilis. Distinctio cum dicta quae ipsa saepe.\n\nVeniam quidem cupiditate qui voluptate provident dolor magnam. Cupiditate tempora deleniti veniam accusamus quos sint. Alias laudantium a amet hic autem quas debitis. Soluta cumque in minus modi quos quidem sint.	57.67	\N	2018-03-03 17:20:28.824829+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
337	Stuart and Sons	Voluptas modi id inventore dolor amet officiis. Omnis eveniet sed nesciunt quis aut ducimus. Provident ratione sapiente ipsam modi corrupti. Molestiae quo veritatis voluptatibus odio.\n\nFuga reprehenderit sunt exercitationem voluptatem ea ipsa. Similique iste rerum cumque minima fugiat quaerat. Perferendis delectus sed iste porro qui.\n\nRatione est vitae aspernatur impedit cum eveniet. Maxime odio reprehenderit facere excepturi repudiandae. Facere esse dolor architecto sapiente.\n\nCommodi placeat magni quam a quibusdam. Temporibus fuga earum voluptate error voluptate corrupti dolore dolor. Veniam placeat omnis nulla optio occaecati sint quod id. Blanditiis eligendi ipsum officiis hic animi esse nam voluptatum.\n\nMagnam ducimus recusandae nulla molestias dolorum. Nemo amet minus neque earum occaecati sunt. Sint eos architecto voluptatibus blanditiis illo. Quis at deleniti debitis doloremque nemo commodi saepe adipisci.	90.83	\N	2018-03-03 17:20:28.414515+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
338	Chang-Holden	Modi saepe minima officiis quae odio occaecati praesentium. Non necessitatibus qui delectus doloribus mollitia hic dignissimos ratione. Quidem odio molestiae ut architecto est quis aperiam harum. Laboriosam error exercitationem fugiat libero consequatur.\n\nRerum impedit non eum et dolor unde qui consequatur. Tempore minima asperiores est. Inventore sit laudantium sapiente.\n\nQuod consectetur corrupti eaque. Pariatur asperiores eligendi aspernatur doloribus. Recusandae delectus quia repellat ex voluptatem. Reiciendis quibusdam vel dicta suscipit ex eius libero. Autem corrupti quidem ut molestias molestiae.\n\nIpsam ratione repudiandae consectetur quos laborum animi ipsum. Illum eos suscipit aspernatur praesentium. Velit molestiae minima repellat. Corrupti repellat quod quas fuga dolore.\n\nEveniet delectus modi architecto voluptatibus quis placeat. Quaerat doloribus perferendis tempora sequi corporis dolorem. Culpa dolore rerum expedita nobis magnam.	67.40	\N	2018-03-03 17:20:28.497906+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
339	Smith and Sons	Iste laborum fugit quos vitae accusamus. Recusandae eligendi rem aspernatur temporibus harum quasi. Earum rerum consequatur culpa.\n\nRerum aliquam quasi odio placeat deserunt quae consequuntur laborum. Natus eveniet id aspernatur numquam eaque. Voluptates aut ratione corporis. Autem numquam voluptates architecto minus. Beatae aut alias ea quis assumenda fugit.\n\nConsectetur unde repellendus nulla. Quasi sequi culpa id voluptatibus animi.\n\nTenetur laborum assumenda quos porro ducimus. Voluptate quibusdam tempora aliquid minus veniam. Rerum labore nulla soluta. Similique soluta corrupti blanditiis eaque. Nulla nam odit incidunt architecto.\n\nMolestias labore reiciendis placeat impedit laudantium. Temporibus et aliquam animi pariatur sunt. Id laborum quaerat minus iure quisquam iusto nulla. Similique nostrum architecto voluptates asperiores dolor nulla.	14.87	\N	2018-03-03 17:20:28.575945+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
340	Holland, Silva and Campbell	Optio quis est exercitationem dolor pariatur ex. At architecto corrupti incidunt similique beatae.\n\nTempore cumque vel labore sunt reiciendis nemo voluptate. Soluta quas qui enim rerum quis. Vitae incidunt eaque ut nihil illo temporibus enim. Dolorem aliquid voluptas fugit sint libero molestias consequuntur explicabo. Perspiciatis ab eveniet nemo consectetur.\n\nIllo minima iusto molestias non nostrum impedit. Repellat et laudantium officia reiciendis sit consequuntur nostrum. Consequatur nemo impedit libero reprehenderit corporis. Quisquam minus doloremque officia error enim labore facere.\n\nExercitationem nam ab culpa at temporibus laborum. Velit perferendis quis eius. Vero magni expedita fuga quod eligendi culpa. Consequuntur vero architecto in omnis.\n\nSint sit ea blanditiis perspiciatis quis facere quisquam. Totam quae explicabo voluptatibus quod nesciunt. Porro maiores officiis atque ab. Cumque quasi harum eos nulla. Hic earum expedita quibusdam fugit.	67.90	\N	2018-03-03 17:20:28.657117+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
344	Anderson Group	Eos numquam modi odit totam amet. Repellendus perferendis iste reprehenderit fuga autem. Inventore provident commodi sequi numquam. Eos tempore optio fuga dolore quaerat.\n\nMollitia totam nihil voluptates error assumenda eaque voluptatibus. Magni magnam totam minima possimus. Qui aliquid nostrum iusto vero magnam repudiandae. Sequi repellendus debitis neque harum.\n\nEum exercitationem quia magni repellendus aspernatur. Mollitia ut a vero quibusdam autem. Ratione voluptatum ullam dolorum similique dolore nulla quibusdam.\n\nRepudiandae provident numquam commodi facere. Reprehenderit placeat ad sapiente commodi commodi repudiandae minus maiores. Voluptatibus in magnam aut nemo.\n\nMaxime quo illum deleniti laboriosam. Iusto velit expedita ipsum reprehenderit. Assumenda modi saepe eum sit itaque suscipit ratione eaque.	25.70	\N	2018-03-03 17:20:28.964326+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
345	Reese PLC	Praesentium sapiente blanditiis repudiandae omnis sed. Odio nihil error dolor placeat velit repudiandae. Fugiat ducimus illum dolores vero. Magnam reprehenderit tenetur labore minus ad.\n\nDoloremque rem beatae doloribus deleniti ipsum deserunt. Dolorum odio illum occaecati animi. Nostrum ducimus voluptas sunt voluptatibus. Ipsam officia sequi dolor repellat.\n\nDoloribus modi dolorem modi voluptate. Harum ex cupiditate totam sunt sint omnis est. Ipsum quisquam quod facere ut maiores maiores.\n\nIste enim inventore quo minima autem. Nostrum maxime atque consectetur aliquam ipsum doloremque. Eaque praesentium eveniet placeat dolorem debitis veritatis. Ratione ad dignissimos neque.\n\nQuis ratione vel facilis labore. Enim at distinctio vel impedit quaerat. Ipsa magni maiores reprehenderit nisi possimus reprehenderit animi. Occaecati tempore praesentium expedita alias officia.	57.23	\N	2018-03-03 17:20:29.023924+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
346	Aguirre, Thomas and Schroeder	Sapiente reiciendis similique repudiandae. Debitis cupiditate voluptatem aspernatur nostrum perspiciatis. Suscipit repudiandae magnam optio accusantium. Non qui quae consequatur fugiat in minima libero labore.\n\nQuos eaque voluptate odit a dolorum. Dolor vero mollitia ipsam nobis. Dolor voluptatibus maiores ipsam iure. Ab blanditiis quidem libero debitis impedit.\n\nVelit iusto et sint ex impedit sequi voluptates. Omnis quo eaque quae a. Harum possimus ab odit iure voluptate est in quisquam. Labore voluptas quos voluptas neque occaecati.\n\nCulpa ex deleniti tenetur atque. Distinctio quis quia distinctio repellendus. Magni numquam ipsam sapiente ad eligendi nisi corrupti. Alias nihil eligendi nobis accusantium quo aspernatur. Nisi cumque suscipit numquam animi accusamus ad architecto.\n\nFugit neque praesentium vitae veritatis ipsam consectetur. Labore voluptates autem nihil numquam nesciunt. Dolore praesentium corporis a esse aliquid nisi numquam. Fuga rem maxime ex velit consequuntur nisi earum.	27.70	\N	2018-03-03 17:20:29.080491+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
347	Reyes, Nichols and Lewis	Soluta neque ea doloribus excepturi cupiditate labore. Suscipit molestiae vel aspernatur in minima. Nobis expedita eveniet laudantium deleniti veritatis nesciunt. Consequuntur molestias adipisci officiis.\n\nNeque eius distinctio accusamus dignissimos dignissimos quae. Aperiam iure provident nobis harum. Quisquam incidunt ea voluptates dolore.\n\nIn dignissimos saepe sunt cumque dicta. Doloremque odio iure rerum. Consequuntur ducimus aut aliquid amet tempora aspernatur pariatur harum.\n\nIste distinctio in iste ipsam provident aut. Earum blanditiis nobis nesciunt consequuntur maxime quod. Tenetur cum commodi voluptas odio. Sed inventore tenetur perferendis consequatur cumque ipsum soluta.\n\nDicta dolore eligendi temporibus aut minima voluptate neque quidem. Ipsum iure nam in perferendis est illo nemo pariatur. Aut adipisci cupiditate fuga autem minus quo vitae quos.	21.10	\N	2018-03-03 17:20:29.140182+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
370	Jones LLC	Minus architecto architecto dignissimos quae consectetur. Vel placeat quibusdam incidunt suscipit. Laborum perferendis et repellendus incidunt facilis beatae.\n\nEst commodi necessitatibus beatae alias nostrum modi. Voluptates quibusdam beatae commodi quibusdam odit dolorum omnis. Asperiores laborum omnis officiis doloremque. Occaecati beatae voluptatem officia architecto perspiciatis sit.\n\nAliquid maiores odit cupiditate amet nisi. Inventore amet ratione atque nemo maiores ipsum.\n\nFacere facere sunt tempore error. Magni sunt illo voluptate. Consequuntur ex optio aliquid ab tenetur voluptatum. Rem quaerat debitis veritatis impedit quo earum architecto.\n\nReprehenderit cupiditate alias architecto corporis officiis magnam reiciendis. Eligendi rerum magnam ab dignissimos pariatur. Minima doloremque repudiandae fugiat aperiam quam natus.	75.54	\N	2018-03-13 03:22:29.026425+00	1	"1"=>"1", "2"=>"3"	f	t
371	Pacheco-Wilcox	Provident soluta explicabo architecto inventore. Id minima harum libero magnam. Corporis pariatur explicabo sequi quos dicta laudantium. Magnam quae ex saepe placeat magni molestias.\n\nIllo consequuntur consequuntur deserunt fugit. Quos laborum tempora sequi asperiores. Excepturi eius eveniet quibusdam quas. Tempora exercitationem voluptate excepturi a rerum. At blanditiis dolorem perspiciatis quae ut rerum animi.\n\nOdio quos quis veritatis facere praesentium saepe blanditiis. Laudantium culpa repellendus corporis ea accusantium. Sequi asperiores praesentium unde. Quia mollitia perspiciatis occaecati quis.\n\nInventore illo suscipit sequi deleniti quae. Voluptatem cupiditate recusandae quod laborum ad quod. Est reprehenderit ullam vero omnis nulla eveniet sed.\n\nPossimus quae neque voluptatem commodi excepturi. In vitae id alias mollitia ut ipsa. Quo aliquid officiis quia dolore.	84.87	\N	2018-03-13 03:22:29.07566+00	2	"1"=>"1"	f	t
372	Whitney-Nelson	Corrupti quam praesentium molestiae harum ipsam ratione. Voluptate soluta tenetur impedit consequatur molestiae in. Nesciunt qui perferendis iure porro sequi quos.\n\nQuae quam ut suscipit cum magnam consequuntur. Accusamus accusamus ex odio dolore quos. Optio quam fugiat at delectus. Aspernatur cumque dolorem repellendus consequuntur officia dolor fuga.\n\nModi eligendi alias nobis eveniet. Quisquam qui quas laboriosam modi quos nemo aliquam totam. Voluptatum corporis dicta aspernatur hic enim iure perspiciatis.\n\nTenetur non veniam nobis beatae officiis. Eligendi facere sint corrupti modi illum. Architecto sed delectus mollitia necessitatibus unde enim omnis.\n\nEx rem laudantium doloribus veritatis sequi. Ipsa praesentium recusandae iusto magnam culpa vel cumque. Voluptates autem explicabo totam libero sint.	3.35	\N	2018-03-13 03:22:29.11404+00	2	"1"=>"1"	f	t
348	Clark, Little and Moran	Nulla laborum ipsam minus dolore sunt ab perferendis. Aliquam reprehenderit soluta porro eligendi nulla. Illo facere nam minus sed non repellendus vero fugiat. Voluptatibus dolorem vero iure doloribus impedit perferendis.\n\nBeatae enim quisquam repellendus impedit dolore dolore consequuntur. Dolores excepturi esse dolorem aliquam expedita itaque. Laboriosam iusto architecto excepturi natus laboriosam.\n\nSoluta illo nobis nobis quas necessitatibus repellendus est. Explicabo dolores commodi eaque incidunt illo tempore unde. Quidem consequuntur corrupti rem commodi enim.\n\nAt aperiam beatae laborum nulla sequi ipsum ducimus. Debitis ad quos adipisci et officiis est. Doloribus blanditiis velit necessitatibus ad quasi hic voluptatibus dolor. Velit corrupti soluta suscipit nulla cupiditate quasi laboriosam.\n\nIure repellat neque aliquam dignissimos quidem distinctio rerum. Exercitationem exercitationem dolores dignissimos in. Sequi temporibus vitae temporibus nam ratione temporibus ipsum quisquam. Soluta libero sequi voluptatum quis recusandae.	19.56	\N	2018-03-03 17:20:29.198086+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
349	Lucas and Sons	Culpa officiis dolor quam ea. Error occaecati ab recusandae ut voluptates.\n\nRepellat cum debitis ipsa molestiae odit eaque soluta. Dicta aperiam pariatur occaecati repudiandae. Minus inventore ipsa impedit sit veniam molestiae assumenda. Minus odio hic quisquam voluptates quisquam fuga.\n\nEst reprehenderit placeat in eos. Consequuntur corrupti blanditiis soluta accusamus qui doloribus. Expedita corporis aliquid non eum voluptatem quis quasi.\n\nNesciunt facilis ipsa libero. Nemo doloremque tempore ut neque rerum maxime voluptatibus. Maiores sed unde culpa distinctio soluta est. Ad dolorem quibusdam itaque molestiae aspernatur sunt.\n\nTotam nam soluta pariatur quae. Iste deleniti quod omnis omnis assumenda omnis natus. Consectetur nesciunt porro aut sit. Ipsa culpa natus quaerat sequi tempora. Nobis aut illum corrupti repellendus quos.	46.82	\N	2018-03-03 17:20:29.25048+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
350	Kennedy Inc	In labore esse impedit quis eligendi nesciunt voluptate. Quam vitae earum illo minus voluptatem dicta reiciendis. Quasi optio quas quae sequi quasi. Quos dolorum quos qui repudiandae ipsum aliquid rerum.\n\nMaxime impedit autem praesentium placeat laboriosam quis. Dolor repudiandae maiores eveniet tempora. Itaque doloremque ullam ut ab reprehenderit ea cumque.\n\nSaepe corrupti officia mollitia impedit quisquam. Corporis vel facere cumque id. Similique quidem occaecati nobis iure. A officiis dolores ut sit.\n\nAnimi eligendi ipsum fuga. Sint nam similique eum eaque molestias eius. Enim laudantium repellat hic pariatur animi.\n\nPorro voluptas deleniti numquam. Dolores repellendus ducimus animi magnam. Earum rem qui aut. Doloremque sit mollitia minima dolore ea laborum.	53.40	\N	2018-03-03 17:20:29.308664+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
351	Kennedy-Harris	Illo blanditiis qui corrupti. Porro tempora quas nostrum. Officia nesciunt sunt molestias et nihil facere dolore. Voluptatibus libero atque rem omnis minima.\n\nIure expedita ullam nemo labore. Vel veritatis quisquam distinctio veritatis nulla. Earum reiciendis enim voluptas nisi soluta officiis. Odio quis necessitatibus quibusdam.\n\nMagnam neque totam earum. Autem deleniti velit illo alias. Ex amet eaque dolore magnam corporis temporibus harum recusandae.\n\nDolorem dolor id aperiam. Ad similique voluptatem modi quibusdam reprehenderit repellat ratione tenetur. Eaque fuga culpa nulla repudiandae quaerat. Aliquid similique reprehenderit libero quas inventore voluptate.\n\nCumque eum hic similique iure dolorem saepe aliquid. Ipsa id quia voluptatibus.	2.37	\N	2018-03-03 17:20:29.369744+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
352	Roberson LLC	Ab veritatis sint sequi occaecati iure. Dolores libero exercitationem hic aperiam error dolore ipsa. Voluptas eligendi dignissimos quae similique repudiandae molestias impedit. Ex possimus commodi optio ab consectetur. Voluptates est illo sunt.\n\nTempore dolore pariatur aspernatur illum. Dolor facere ratione quos ab. Id dolorum quas ab corporis provident laudantium. Rerum delectus expedita sit quam. Excepturi error deleniti ratione asperiores.\n\nRepellendus sed nihil officia consectetur facilis placeat vitae. Delectus omnis dolor veniam reiciendis minus officia doloremque. Et eaque rem similique autem beatae.\n\nSequi numquam nostrum blanditiis sequi velit ratione atque numquam. Autem nobis quasi alias odit.\n\nPerspiciatis aut nemo aperiam nulla ipsam. Aliquam harum possimus asperiores.	6.94	\N	2018-03-03 17:20:29.413638+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
353	Washington, White and Nolan	Eius repellat sunt provident suscipit. Eaque quas modi mollitia ut. Omnis harum eos aliquam.\n\nCorporis facere cumque officiis sit tempora. Adipisci quo repellat optio illum. Dolores corrupti fuga doloribus libero.\n\nQuae rerum accusamus eligendi laborum officia praesentium. Accusamus debitis fuga at quis dolorem inventore vitae.\n\nAsperiores blanditiis suscipit repellat quaerat minus asperiores quidem. Ipsum tempora atque corrupti similique. Illo possimus voluptas saepe neque.\n\nFacilis consequuntur eum ratione adipisci. Aut tenetur mollitia repudiandae nam. Ex ex nostrum rerum doloremque.	67.96	\N	2018-03-03 17:20:29.459313+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
373	Herman Ltd	Enim perspiciatis ab velit nulla dicta distinctio perferendis. Autem iure ipsam repellendus labore dolores incidunt repudiandae. Laborum soluta officia possimus dolores soluta.\n\nRatione quisquam doloribus veritatis sequi corporis voluptas. Iure qui perspiciatis maiores corporis eum perferendis earum saepe.\n\nItaque sed rerum excepturi repellendus non. Qui reprehenderit distinctio itaque minima. Autem at eos architecto autem eius quos. Ab ea optio voluptate dolor voluptatum.\n\nLibero iusto tenetur culpa. Ea maiores quae consectetur voluptates. Odit a dignissimos eaque unde ad quasi. Illo iure earum similique cumque nostrum.\n\nDelectus reiciendis odio amet et aut. Amet tempore minima porro adipisci consectetur distinctio. Velit atque quibusdam repellat officiis illum id dolore.	30.48	\N	2018-03-13 03:22:29.158398+00	2	"1"=>"1"	f	t
354	Larson, Scott and Murray	Omnis hic in alias in. Esse iste voluptatibus necessitatibus temporibus mollitia corporis eveniet. Fugit minus rem sint. Laboriosam asperiores itaque dolorum repellat excepturi. Dolorum optio beatae minima provident iure.\n\nIllo adipisci quisquam porro accusamus alias officia enim dolorum. Praesentium perferendis dolore vero necessitatibus vero dolorum totam. Dolores veniam cumque maiores ea suscipit quos. Laborum tempora accusamus ipsum minus harum.\n\nIste repellat sit occaecati minima. Fuga ab aspernatur sunt id ratione doloribus. Voluptatem corrupti nulla dignissimos. Earum eaque veniam tempora vel.\n\nRatione animi quisquam similique eveniet. Sequi dicta ut facilis veniam molestiae accusamus enim. Ab at quidem dolore. Nihil vero eligendi possimus nesciunt saepe.\n\nEarum eius suscipit nemo temporibus quo alias. Esse perspiciatis corrupti ullam soluta. Facere nam vitae dolorum inventore.	51.93	\N	2018-03-03 17:20:29.505071+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
355	Salazar-Berry	Qui assumenda accusamus consectetur perspiciatis quaerat illum. Aut assumenda earum fugit eius repellendus. Facere ea aperiam odit blanditiis unde. Consectetur voluptatibus quo eligendi fuga vel repellendus quis consequuntur.\n\nQuibusdam expedita error nesciunt repellendus quam deserunt iusto. Sunt praesentium maxime fuga autem totam dolore. Illo ducimus incidunt maiores accusamus autem ea laboriosam quisquam. Magnam dolores laudantium maxime neque molestias quisquam voluptate. Ea reiciendis accusantium architecto ullam fuga.\n\nProvident nobis inventore inventore dolore repudiandae reiciendis. Laboriosam reiciendis similique iure voluptatibus debitis. Ut consectetur maiores deserunt maiores. Optio nisi doloremque ex amet animi cupiditate. Praesentium minus laudantium esse eveniet animi corporis minus ex.\n\nUt ipsum assumenda veniam occaecati voluptatum. Mollitia nostrum maxime animi.\n\nFuga perspiciatis voluptates nisi quia ad. Amet corporis excepturi consectetur laudantium accusamus itaque. Perferendis architecto repellat accusantium perspiciatis totam optio delectus. Animi quo modi pariatur incidunt sint.	84.72	\N	2018-03-03 17:20:29.563982+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
356	Taylor, Mueller and King	Dolorem ratione non asperiores harum. Sint deserunt suscipit sequi ipsum consequatur eos. Soluta maxime sapiente temporibus explicabo voluptate perferendis id.\n\nUt ad beatae id exercitationem. Sapiente eum facere reprehenderit. Adipisci beatae ut labore.\n\nRepellendus necessitatibus modi fuga voluptas. Quas corporis explicabo voluptatum ad distinctio inventore. Adipisci nulla cupiditate nesciunt expedita praesentium eos. Similique neque cupiditate soluta minima iure unde accusamus.\n\nDolor repellat ut eos facilis dolor suscipit debitis. Consequuntur maxime odit sapiente commodi illum. Ratione aspernatur ex labore velit itaque minus quibusdam.\n\nRerum quis similique sunt non fugiat tenetur temporibus. Ullam aspernatur sit veniam libero. Temporibus provident expedita nam veritatis. Ea sapiente aut fuga veritatis excepturi earum.	80.67	\N	2018-03-03 17:20:29.60622+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
357	Turner, Watson and Schmidt	Unde laudantium ab nobis totam iure. Asperiores nesciunt modi excepturi distinctio nihil. Similique temporibus dolor nobis omnis. Neque doloremque eos assumenda dolorem.\n\nBeatae ad labore quod consequatur autem placeat ut. Velit ea quas nisi. Numquam ipsum similique dolor nam. Velit quas officia ullam exercitationem.\n\nDicta quas explicabo sequi assumenda quos. Tempore dignissimos a a ipsum eaque culpa. Maxime libero sapiente maxime consequuntur molestias quis.\n\nPariatur iure non accusantium minima quasi. Perspiciatis modi sunt vel sit itaque libero. Sed facere perferendis laboriosam eveniet esse amet vitae. A aut reprehenderit voluptas quo hic.\n\nHarum itaque commodi placeat soluta reprehenderit quibusdam. Doloribus saepe adipisci inventore totam veniam eveniet quam. Vitae tenetur perferendis voluptate dignissimos. Nobis suscipit ex rerum porro minus facere.	65.20	\N	2018-03-03 17:20:29.65478+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
358	Stafford Ltd	Non nostrum sint itaque corrupti atque earum labore. Odit temporibus esse beatae molestias placeat. Ad repellendus fuga odio ipsa ipsam porro necessitatibus. Animi nisi repellendus porro repellat doloribus.\n\nFugit praesentium minus asperiores explicabo aliquid. Temporibus odio repellat facilis fuga repellat earum explicabo. Ab dolorem ea tempora. Error accusantium nemo quidem.\n\nAliquam vel explicabo ea quisquam molestias. Itaque voluptatibus pariatur velit adipisci. Occaecati eum nobis perferendis totam accusantium quam.\n\nAdipisci animi provident veritatis autem. Veritatis porro officia quisquam deserunt aliquid asperiores. Dolore tenetur occaecati aspernatur quam a rem aspernatur.\n\nOmnis quo eum voluptatum neque ipsa rem commodi aliquid. Nisi occaecati repellendus at assumenda. Illum ab doloremque pariatur est voluptate totam ut. Autem nisi saepe maiores dolor neque nobis magni.	32.16	\N	2018-03-03 17:20:29.69737+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
359	Hudson LLC	Distinctio odit consequatur voluptatum eveniet cumque assumenda placeat. Id repudiandae eaque molestiae. Doloribus nesciunt minus dolor saepe tenetur maxime.\n\nQuis facilis ipsam error ea in tenetur. Quam iste culpa esse. Ipsum consequuntur quisquam dolore sint suscipit mollitia consequatur. Harum quasi molestias voluptatum tempore sunt vero.\n\nSuscipit tempore at fugiat praesentium. Quas provident officiis ut sapiente cumque. Corrupti ex autem quas expedita laudantium dignissimos. At sit debitis non consequuntur magnam ipsam.\n\nId iusto ipsum veniam quia cumque corrupti ratione. Repellendus harum at ad consequatur corrupti quam asperiores. Fugiat laudantium labore pariatur iusto architecto magnam ea. Explicabo voluptatibus asperiores eaque. Consectetur temporibus vero occaecati totam.\n\nInventore quibusdam vero harum ducimus beatae consectetur mollitia. Ipsam explicabo dolores aspernatur nesciunt occaecati. Quos temporibus doloribus maxime. Totam culpa saepe aspernatur error maiores nam.	39.80	\N	2018-03-03 17:20:29.759157+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
360	Wise, Lin and Abbott	Quas eveniet fugit commodi. Sit laboriosam itaque ratione error. Voluptates harum iusto voluptas numquam voluptas magni tempore.\n\nBeatae et eveniet nulla asperiores. Temporibus recusandae dolores repudiandae ut. Ullam perspiciatis perferendis ducimus voluptatem.\n\nQuaerat sunt aliquid at sequi natus. Delectus minus consequuntur reiciendis dolores suscipit. Sequi soluta repellendus facere ut. Ex ipsam vel amet recusandae perferendis eum aspernatur.\n\nAccusantium voluptatibus laudantium quae. Necessitatibus beatae laudantium similique magni accusamus iure nulla. Cupiditate excepturi quibusdam laborum sed.\n\nVel impedit iusto illum porro. Nisi quaerat deserunt iste accusantium laudantium at accusantium aut. Unde impedit quis asperiores nihil cumque cumque.	51.40	\N	2018-03-03 17:20:29.824016+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
361	Rodgers-Meyer	Distinctio sequi ea dignissimos voluptatibus occaecati est. Vero iure nulla deleniti placeat totam.\n\nQuas necessitatibus eos sequi iusto minima in. Recusandae quod omnis aliquid saepe optio doloremque. Molestias accusantium labore in officiis.\n\nA eius quod labore quaerat exercitationem laudantium. Modi sit dicta aliquid dolorum. Fugiat consequuntur molestias magni consectetur cumque animi consequuntur id.\n\nSequi laborum modi quas ratione. Sequi perspiciatis eligendi voluptatum libero veniam eveniet aperiam beatae. Sint possimus accusamus voluptatibus sint ipsa illum necessitatibus.\n\nError quod id ea voluptatibus. Cumque accusantium quod reiciendis nobis repudiandae delectus.	32.25	\N	2018-03-13 03:22:28.381761+00	1	"1"=>"1", "2"=>"2"	f	t
362	Roman LLC	Inventore similique modi in fugiat fugit veniam officia. Distinctio cum doloremque excepturi hic.\n\nAccusantium dolorum quaerat et expedita. Fugiat maxime tempora quam consectetur sit. Tempora eaque error unde enim.\n\nIn nihil minus consequatur aliquam voluptatem rem officiis. Tempora repellendus illo beatae itaque ut. Aliquam quibusdam accusantium accusantium sequi illum. Quae vitae maiores beatae laborum.\n\nNon possimus quae odit molestias provident quia. Adipisci accusantium quas maiores vero. Debitis illo sit vel doloribus ab eos vero.\n\nNam laudantium necessitatibus expedita nulla iste ad voluptate velit. Nostrum molestiae temporibus veritatis quibusdam quod. Laudantium est veritatis accusantium aliquam fuga. Consequatur consequatur voluptatibus explicabo at quo odio maxime nobis.	74.53	\N	2018-03-13 03:22:28.476229+00	1	"1"=>"1", "2"=>"2"	f	t
363	Avery-Vega	Repellendus vitae officia aspernatur. Neque odit sint pariatur illum quod tenetur. Dolorum ullam ullam laborum voluptatem possimus. Harum nesciunt accusantium repellendus dolores dignissimos ab provident ullam.\n\nUt voluptatum doloribus cumque illum atque minus. Quia quo eum voluptates et mollitia atque. Veritatis dolores saepe sunt voluptatibus animi itaque. Quos aperiam cumque voluptate repudiandae ratione.\n\nPerferendis expedita facilis aliquam quis nisi repudiandae adipisci quos. Id sequi autem illo eius. Laborum sed impedit nulla eum voluptates. Fugit aliquam neque autem perspiciatis. Quia dolorem labore ratione sunt eaque.\n\nDolore ratione quidem minima. Cupiditate aut dolores incidunt repellat impedit cupiditate aut. Quasi laboriosam soluta facere dignissimos corporis incidunt rem placeat. Excepturi voluptatibus sed quasi.\n\nVelit perferendis consectetur nisi consequatur quod quasi. Dignissimos laborum molestias eligendi dolores perferendis ipsa. Ipsa mollitia commodi voluptate soluta modi expedita.	87.47	\N	2018-03-13 03:22:28.592196+00	1	"1"=>"1", "2"=>"2"	f	t
364	Rios, Gonzalez and Lopez	Nihil repellendus cumque libero voluptates ducimus magni accusamus. Reprehenderit nisi nesciunt odit quasi. At non nulla modi accusantium architecto dolore.\n\nEarum fugit tempora sunt minus sit corporis tempora. Laborum nobis recusandae pariatur praesentium sapiente dolore. Occaecati inventore a rerum consequuntur perferendis doloremque necessitatibus.\n\nArchitecto odit quos qui dolores omnis cumque. Quod voluptate sequi repellat dolores. Suscipit doloribus neque laboriosam labore eum impedit. Eos corrupti aliquid quod atque rerum vitae.\n\nDebitis veritatis et ullam eos natus asperiores pariatur. Ex quod reprehenderit quaerat nostrum tempora laboriosam.\n\nError quibusdam rerum porro laboriosam. Impedit hic fuga odit laudantium expedita. Eos praesentium quo cupiditate eveniet. Qui ullam soluta temporibus dolor occaecati ipsum. Doloribus est facilis nemo nostrum porro provident.	68.70	\N	2018-03-13 03:22:28.653877+00	1	"1"=>"1", "2"=>"2"	f	t
365	Turner PLC	Inventore facilis at temporibus nostrum magnam praesentium. Sapiente labore ipsa pariatur voluptates consequuntur. Fuga ullam veritatis illo at magni non corporis.\n\nQuo aut alias culpa perferendis. Soluta accusamus illo totam illum tenetur quo distinctio. Nulla alias harum ullam eligendi.\n\nIure dignissimos iusto veniam autem dolor. Recusandae vero quas quasi ipsam debitis autem velit. Repellendus eaque saepe dolorem facilis nam harum provident. Dignissimos suscipit eius praesentium.\n\nQui maxime voluptas veniam quidem. Excepturi doloremque reiciendis tempora accusantium. Sit dolorum libero maiores optio suscipit aliquam quia.\n\nIllum voluptatum perferendis enim voluptas nobis. Autem repellendus numquam delectus exercitationem. Alias aut tenetur rerum possimus sunt. Et reprehenderit non nulla magni rem suscipit. Culpa ducimus culpa molestiae magni.	29.52	\N	2018-03-13 03:22:28.704108+00	1	"1"=>"1", "2"=>"3"	f	t
366	Patterson Inc	Veniam tenetur facere at maiores molestias. Laboriosam similique consectetur esse enim at voluptas. Labore facere vero culpa pariatur culpa. Non aut dolorem accusantium.\n\nFacere corporis temporibus explicabo consectetur aliquid. Rerum numquam dolor amet asperiores cumque aspernatur. Maiores molestiae incidunt fugit omnis delectus illo.\n\nSit accusamus vitae sed. Dolore nam corrupti eveniet accusamus. Cum sequi iure hic quia nisi labore.\n\nAssumenda sunt eaque a aperiam. Suscipit tempora eveniet tenetur distinctio ex molestias fugit. Odit ut autem corporis quas. Ratione molestias eius veritatis iusto doloremque.\n\nPariatur praesentium ab totam beatae corporis. Sequi repellat incidunt laborum voluptatem quidem sunt vero optio. Natus saepe at sed dignissimos soluta ipsa.	33.64	\N	2018-03-13 03:22:28.750159+00	1	"1"=>"1", "2"=>"2"	f	t
367	Bell, Ruiz and Adams	Possimus voluptatibus laudantium nostrum fugiat magni exercitationem quibusdam. Iusto voluptates porro voluptas sunt commodi. Earum repellendus illo in accusantium debitis dolorum dolorum. Doloribus soluta eum natus esse.\n\nEa quibusdam ex quis dolores ratione eius numquam. Quidem explicabo a est facilis dolorem mollitia. Beatae impedit nobis distinctio. Nisi molestias ullam corporis inventore.\n\nAb unde consequuntur velit facilis voluptates exercitationem voluptas. Vitae optio nam non est incidunt aliquid.\n\nEnim laborum a vel facere itaque. Deserunt ipsam ea atque reprehenderit veniam eum. Cupiditate modi ipsa ab eos facere placeat vero rerum.\n\nSit perferendis neque sit nam cupiditate facere. Inventore asperiores animi ducimus adipisci unde illum ipsa adipisci. Quas ea autem voluptates nemo. Iste ipsum vero alias quas.	42.51	\N	2018-03-13 03:22:28.808757+00	1	"1"=>"1", "2"=>"2"	f	t
368	Dixon, Guzman and Gray	Fuga necessitatibus expedita nemo vero cum minima aperiam. Delectus eum vel adipisci ullam id nam culpa. Beatae quisquam sed dolores. Excepturi facere accusantium pariatur culpa aperiam laudantium cum. Vero nemo ipsam adipisci.\n\nOccaecati illum eaque alias tempore fuga. Expedita deleniti dolore voluptates ullam occaecati. Rerum fuga provident pariatur animi minima delectus vel.\n\nVoluptas occaecati in voluptate blanditiis incidunt et. Nemo quibusdam magnam nemo deleniti sapiente ducimus. Aliquam hic ab quibusdam neque porro sint ipsum. Magnam natus cum accusantium tempore sequi perferendis itaque qui.\n\nAspernatur nulla voluptas molestiae quam natus aut aut. Voluptatem a illo provident dicta.\n\nOdio debitis ex sapiente optio. Sunt impedit officiis ullam totam. Veniam sed omnis porro dolores fugiat eaque neque. Quisquam harum asperiores unde labore.	65.40	\N	2018-03-13 03:22:28.887459+00	1	"1"=>"1", "2"=>"3"	f	t
369	Bernard PLC	In numquam vel quas voluptates dolore impedit ipsum. Sunt voluptatum illo amet. Error rem expedita voluptatum expedita. Ad earum impedit accusantium officiis voluptates.\n\nVoluptatem quo excepturi quo laudantium quo praesentium. Quisquam aut ipsum voluptatum dolorem porro. Soluta explicabo enim necessitatibus sequi. Dolorem necessitatibus quidem a cumque nostrum incidunt hic. Fugit dolorum consectetur pariatur adipisci repudiandae suscipit optio doloremque.\n\nVoluptates hic architecto tempore maxime cupiditate soluta. Voluptatem totam incidunt neque corporis. Consectetur molestias reiciendis illo labore nostrum officiis beatae at.\n\nVero expedita similique molestias dignissimos aperiam accusantium aliquid. Sapiente quia earum quos expedita unde. Quod non consequatur similique quasi at quis.\n\nNatus ea accusantium amet cumque autem voluptatum cumque. Autem nobis voluptatem nihil cupiditate accusantium. Optio ea autem maiores aut vel inventore maxime. In in voluptatem fugiat.	48.86	\N	2018-03-13 03:22:28.970687+00	1	"1"=>"1", "2"=>"2"	f	t
374	Cisneros, Barnett and Meyer	Voluptatibus fugit atque officia corporis aliquam. Dolore voluptatum quisquam nisi distinctio fuga incidunt ea. Quo provident velit fugit expedita eligendi ipsa enim.\n\nRerum similique blanditiis exercitationem sint. Cum dicta nemo nobis fugit ut pariatur reiciendis. Dicta delectus exercitationem quaerat nam. Dignissimos dignissimos velit aut est.\n\nIure at iure rerum maxime. Culpa dolorem consequuntur soluta culpa asperiores voluptate. Nemo minima excepturi quod explicabo temporibus. Earum cupiditate enim corporis.\n\nEa est rem pariatur. Porro dignissimos at praesentium fugiat. Ab maiores voluptate suscipit. Quas quasi ex aliquid doloribus doloremque fugiat a.\n\nFacilis hic voluptatem magni distinctio. Autem corrupti tempora et voluptatibus cum. Labore nam corporis ut animi vero occaecati itaque.	96.23	\N	2018-03-13 03:22:29.206211+00	2	"1"=>"1"	f	t
375	Murphy-Dominguez	Hic dolorem reprehenderit accusantium. Dolor ex voluptate at autem similique fugit quo. Libero maiores reiciendis velit.\n\nEt ducimus quaerat sint autem ipsum. Harum magni vel veritatis temporibus beatae quasi neque in.\n\nQuidem natus eaque cupiditate ex numquam. Iste cum rem perspiciatis consequatur eos exercitationem dolorum. Doloribus reprehenderit delectus quo alias. Incidunt maiores maxime est veritatis modi quod fugiat. Sunt deserunt esse voluptatibus facere.\n\nVoluptates animi laborum similique deleniti ipsum tempore distinctio. Suscipit adipisci ex deleniti necessitatibus est illum facere. Autem ipsam dolores recusandae eaque voluptatum dolorem rerum.\n\nAspernatur voluptates eaque nobis odio soluta. Magni asperiores ut adipisci blanditiis excepturi ullam. Quaerat ut ullam aperiam in consectetur quo eveniet. Modi nemo quod laborum aut dolorem nihil.	91.71	\N	2018-03-13 03:22:29.238758+00	2	"1"=>"1"	f	t
376	Morris-Hardy	Aspernatur animi assumenda omnis perspiciatis non exercitationem ratione. Iure saepe soluta cumque consectetur. Quidem quasi nam numquam quos. Culpa quasi soluta tempora ad occaecati vel voluptatem fugiat.\n\nNam hic quam nobis perferendis officiis. Labore molestiae eveniet doloribus impedit eum at. Aperiam aspernatur voluptatem unde.\n\nAb excepturi unde deserunt non quasi corporis occaecati. Autem exercitationem eum fugit tempore alias iure. Eos eaque laudantium molestias quidem facilis.\n\nInventore officiis est qui culpa. Consequuntur laborum placeat recusandae excepturi ipsa illum vitae. Tenetur saepe necessitatibus voluptatem placeat aut molestiae accusantium. Asperiores facilis veniam sit.\n\nOfficia error excepturi illo aperiam. Velit aperiam repellat iure possimus natus aliquid. Consectetur officiis nam similique ex sapiente. Excepturi nam necessitatibus quis incidunt autem magni nam.	51.50	\N	2018-03-13 03:22:29.271998+00	2	"1"=>"1"	f	t
377	Wilson-Nelson	Ratione modi suscipit dolore aliquam a voluptates quos at. Vero fuga mollitia blanditiis nobis numquam iure natus delectus. Maxime odit sequi odit quod.\n\nVelit voluptatum repellat voluptatum dolore harum fugiat iste. Itaque excepturi reprehenderit cupiditate ab magnam ab veritatis. Unde dolore dignissimos pariatur quibusdam maxime adipisci aliquid. Fugit quas architecto ipsa quia.\n\nOdit in incidunt sapiente explicabo hic id. Voluptas earum odit ducimus fugiat. Commodi sed debitis saepe. A alias rerum harum debitis.\n\nQui quam magnam necessitatibus molestias consequatur est enim. Laborum corrupti saepe reiciendis cupiditate voluptate. Ea reiciendis adipisci vitae deleniti nostrum reprehenderit. Magnam ipsum ad ipsum adipisci architecto.\n\nItaque voluptate facilis iste numquam delectus nostrum et. Suscipit voluptatem similique mollitia debitis natus quae commodi sint.	81.52	\N	2018-03-13 03:22:29.315406+00	2	"1"=>"1"	f	t
378	Choi Group	Non iusto dolor qui eligendi quam occaecati nostrum. Quod pariatur ea dolor magni harum assumenda. Alias quibusdam pariatur soluta omnis magnam occaecati dolor ullam. Sed minima velit nobis doloremque. Doloribus ipsam recusandae amet fuga nisi itaque voluptatem.\n\nVero blanditiis aliquid ut animi occaecati. Quam maiores magnam nulla. Tempore aut eaque voluptates quidem quam ullam non.\n\nNostrum voluptatibus vel pariatur ab earum nobis. Modi aliquid ipsum deserunt nemo debitis. Odit iste fuga aperiam facere.\n\nPossimus eveniet necessitatibus sapiente voluptas eius. Delectus autem voluptate accusamus quae. Itaque delectus labore repellat veniam.\n\nIpsam at recusandae ducimus sequi. Nostrum voluptatum nobis libero laboriosam ratione illum quod repellendus. Eligendi blanditiis inventore voluptatum asperiores debitis quas fugit perspiciatis. Dolorum provident sequi distinctio laudantium dolorum odit. Repudiandae adipisci cumque nisi ab sunt.	32.29	\N	2018-03-13 03:22:29.350112+00	2	"1"=>"1"	f	t
379	Rivera Inc	Dignissimos veritatis omnis asperiores debitis magnam qui nisi. Quod natus aut accusantium. Necessitatibus eaque vero at placeat velit.\n\nSint ipsa aliquam optio ex animi. Quas ratione molestias asperiores minus eligendi iste incidunt.\n\nQuisquam harum perferendis sint. Repudiandae ut laboriosam inventore. Ut in aperiam ut quae maxime.\n\nDolorum earum veniam illum quis magnam in. Blanditiis natus nostrum labore voluptatum quo culpa sapiente. Minima dolore dolore amet expedita.\n\nQuos similique inventore libero fugit unde quasi doloremque aliquam. Cumque cumque vitae incidunt corrupti vero dolor repudiandae. Maiores eveniet dicta quod doloremque maxime sed.	84.41	\N	2018-03-13 03:22:29.378655+00	2	"1"=>"1"	f	t
380	Sanchez-Lewis	Ipsa maiores quae sequi natus. Inventore praesentium molestiae nemo consectetur nemo perspiciatis nobis. Sapiente repellat sint eveniet.\n\nConsectetur ipsam illum odio expedita natus id. Quisquam unde illum dicta fugit magni beatae id. Molestias excepturi id necessitatibus. Laboriosam accusamus accusamus eos facere.\n\nDucimus dolore est qui. Tenetur dolore voluptate repellat molestias. Nobis iusto excepturi accusamus delectus unde dolore. Nulla delectus dolorem officiis expedita id.\n\nPerferendis dolorem magni suscipit. Sunt beatae repellat ab tempore nulla.\n\nUnde suscipit deleniti laborum sint. Eum tempore deleniti animi eum aut atque placeat delectus. Doloremque animi aut dignissimos repellendus et fugiat laudantium. Culpa accusamus eveniet dolorem quibusdam ea accusantium laborum.	70.49	\N	2018-03-13 03:22:29.413407+00	2	"1"=>"1"	f	t
381	Silva LLC	Saepe sequi qui sequi fuga. Ab ducimus maxime corporis minus ipsa. Magni soluta delectus minus nemo veritatis.\n\nVoluptas minima voluptatem ducimus consequuntur beatae quos explicabo ipsa. Dignissimos adipisci hic molestias omnis tenetur repellat ad molestiae. Exercitationem blanditiis reiciendis vero eum maiores.\n\nIpsum maiores illo neque odio at quod illum. Quis necessitatibus omnis voluptatibus unde dicta minus minima. Dolorem aliquam repudiandae similique illo porro maiores.\n\nNihil nisi vel modi accusamus voluptatem. Molestias voluptate laudantium iusto. Adipisci totam cum earum accusamus dignissimos aliquid. Saepe rerum quibusdam qui debitis numquam.\n\nMinima dolores optio voluptatibus labore. In veritatis dicta incidunt veniam doloribus voluptatibus ad quis. Enim vitae quibusdam dolores. Vitae ea voluptates delectus tempore aliquid nisi cum asperiores.	50.20	\N	2018-03-13 03:22:29.439793+00	3	"1"=>"1", "4"=>"8"	f	t
382	Smith Inc	Maiores libero dolores voluptatibus sit modi. Earum impedit impedit facere at doloremque eaque. Id at officiis vero possimus quae.\n\nEaque sequi dicta eius ipsum quia voluptatum repellat. Esse in veniam porro unde autem sequi ab. Molestias voluptate repudiandae distinctio praesentium vel maxime.\n\nEligendi quidem temporibus delectus nostrum est earum. Nemo vitae ab iste non atque iusto reprehenderit. Consequuntur deleniti odio necessitatibus nesciunt eos doloribus alias. Amet nemo error quo repellendus.\n\nVero porro tempora nisi consectetur alias esse. Odio nostrum repudiandae ea hic nam repudiandae officia. Numquam ipsum facilis numquam dignissimos reiciendis.\n\nUllam maiores deserunt doloremque minima odit quos beatae consequuntur. Consequuntur ullam unde nihil. Eaque dolor beatae excepturi iste adipisci deleniti temporibus. Adipisci debitis excepturi consequatur distinctio itaque impedit.	38.80	\N	2018-03-13 03:22:29.482533+00	3	"1"=>"1", "4"=>"8"	f	t
383	Mack-Diaz	Alias minima laudantium labore dicta corrupti. Laboriosam dolores soluta cum impedit autem nostrum. Explicabo inventore deserunt quaerat tempora ipsa.\n\nHic ratione dolorum a vero voluptas. Mollitia deserunt dolorem magni error.\n\nSit exercitationem libero veniam magni. Voluptate voluptatem laborum ea error voluptatibus dolores blanditiis. Excepturi et modi exercitationem expedita eaque fugit.\n\nConsequatur cumque magni atque quam. Iusto provident consequatur ducimus totam delectus. Expedita cum quo quae officia possimus. Ad beatae rerum commodi architecto provident ipsa a.\n\nMaiores nulla molestias ratione ad. Nam distinctio temporibus ratione sed facere. Expedita fugiat non quo voluptatem. Iusto aliquam minima dolorem temporibus earum eligendi ipsa.	39.86	\N	2018-03-13 03:22:29.528202+00	3	"1"=>"1", "4"=>"9"	f	t
384	Lewis-Gordon	Animi voluptatum veniam numquam placeat. Cum culpa iste error perspiciatis architecto voluptas. Architecto repudiandae ipsa culpa enim placeat saepe cumque. Officia tempora ullam autem voluptatibus iure.\n\nVoluptate molestias maiores vitae eos. Voluptates tenetur ad perspiciatis veniam officia assumenda omnis ad. Delectus ea doloribus magni reprehenderit quis hic perferendis.\n\nCupiditate cum cupiditate harum veniam doloribus consectetur iure. Illo ducimus repellat nesciunt odio ab. Quas dolor iste ipsam. Molestiae perspiciatis ea incidunt modi.\n\nMolestias sunt eum aliquam amet tempore. Rem vero magni ipsa vero sit dolorem hic. Quia assumenda omnis veritatis iusto quam. Animi unde doloremque ex minus vero.\n\nQui et molestiae maxime magnam doloribus. Rerum asperiores repellendus tenetur adipisci a. Vero repellat dolorum amet delectus labore. Dolor sequi facere tempore tempora et.	84.83	\N	2018-03-13 03:22:29.595224+00	3	"1"=>"1", "4"=>"9"	f	t
385	Ramos Group	Expedita voluptatem fugiat nobis totam explicabo. Voluptatum ex dolorem consequuntur perspiciatis non. Atque soluta quae ratione excepturi. Asperiores doloribus voluptatibus tenetur neque magni.\n\nOfficia ratione optio quam voluptatem itaque autem. Repellendus quasi cumque odit sed. Eligendi blanditiis quas rem dignissimos dolorem. Consequatur nulla voluptates repellat dolorem voluptas ad.\n\nSuscipit non molestias illum delectus repellat architecto explicabo suscipit. Nisi cumque ex aliquid beatae mollitia nisi vitae. Cumque eius itaque delectus culpa.\n\nDolorum odit consequuntur atque dolorum. Blanditiis accusantium illum soluta. Est vero iusto aliquam ex exercitationem suscipit.\n\nAliquid unde incidunt laborum aliquam. Veritatis quo autem iste fugiat. Dolorum minus iusto maiores culpa pariatur eos.	29.10	\N	2018-03-13 03:22:29.647153+00	3	"1"=>"1", "4"=>"8"	f	t
386	Rodriguez, Garrison and Williamson	Optio occaecati ab at minima ab laboriosam eligendi. Blanditiis dolor doloribus dolorem nobis minima in quasi nulla. Doloribus voluptates vel voluptates exercitationem maxime commodi eveniet perferendis. Velit laudantium velit minima voluptates corporis tempora.\n\nUt nihil minus molestias. Iusto reiciendis ipsum iure occaecati perspiciatis. Tenetur odit fugit saepe quisquam nemo earum maiores esse. Maxime aliquid aliquid saepe est.\n\nRepellendus libero iste quam sapiente modi quaerat dolorum. Assumenda perspiciatis laboriosam nesciunt quia.\n\nVoluptas necessitatibus iste architecto totam in nam molestiae temporibus. Quam tempore consequatur placeat dolor vitae a. Voluptatibus possimus maxime omnis debitis.\n\nDucimus quasi numquam voluptatum alias reiciendis. Nulla itaque odio odit blanditiis incidunt maxime. Facere quam explicabo suscipit sunt sequi quam iure fugiat. Unde laudantium fuga reiciendis eveniet iste reprehenderit.	36.60	\N	2018-03-13 03:22:29.704611+00	3	"1"=>"1", "4"=>"9"	f	t
387	Haynes, Bass and Bird	Repudiandae nihil repellat delectus occaecati voluptatem. Eveniet rerum exercitationem cupiditate quos accusantium. Tempora optio molestias expedita labore. Exercitationem ipsum molestias sunt velit.\n\nUllam aliquam assumenda impedit. Nulla odit doloremque assumenda consectetur aperiam. Reiciendis voluptas culpa natus ipsa. Iure perferendis vero sint in.\n\nMollitia dignissimos repellendus vel at reprehenderit repellat repellat. Est nam consectetur voluptatem occaecati iure exercitationem rem. Minus ipsam eaque itaque. A error provident assumenda facere.\n\nQuaerat amet ducimus porro ut ut laborum. Numquam accusantium aliquam quaerat laudantium explicabo ea ratione. Quaerat nulla et dolorum asperiores hic laudantium. Cum voluptatem in expedita architecto cupiditate nobis. Ratione tempore illo quas dolore enim adipisci.\n\nFacilis in cupiditate alias quas modi. Dicta doloribus a asperiores exercitationem tenetur.	18.62	\N	2018-03-13 03:22:29.766009+00	3	"1"=>"1", "4"=>"8"	f	t
388	Henson-Stevens	Doloribus porro quis repudiandae. Quod ullam excepturi dicta temporibus asperiores. Minus ullam aut est nam dolores ipsum culpa.\n\nRepellat eius cupiditate et odit. Aliquid doloremque itaque ab reprehenderit voluptatem dolor. Voluptatibus suscipit unde natus minus ex labore. Aliquid fuga voluptates tenetur repudiandae cumque nemo sequi iure. Aspernatur explicabo explicabo possimus ex dolore voluptatibus vel.\n\nDeserunt animi sit dolorem voluptates voluptatem. Neque facere iure dolor perferendis quasi. Perspiciatis veniam quidem incidunt aliquid dolore. At modi ab repudiandae itaque numquam natus animi. Blanditiis nostrum magnam mollitia illo soluta incidunt libero.\n\nId cupiditate porro minima illum fugiat repellat veritatis. Ducimus veritatis excepturi consequatur veritatis iste numquam culpa. Explicabo reiciendis distinctio maxime explicabo.\n\nNatus quisquam ipsa excepturi fugiat voluptas cum nam ea. Illo nobis corrupti sit excepturi est. Illo architecto placeat quos alias veniam voluptatibus. Magni earum quis eligendi incidunt.	86.74	\N	2018-03-13 03:22:29.829888+00	3	"1"=>"1", "4"=>"8"	f	t
389	Johnson-Evans	A impedit architecto atque temporibus. Fugit quos temporibus placeat veniam doloribus illo aut. Praesentium magni iusto tenetur deleniti. Pariatur perspiciatis at vitae error.\n\nSequi placeat omnis fugit quas. Repellendus voluptatem repudiandae facere ipsum commodi eius ut. Placeat ut eaque vitae maxime incidunt pariatur facilis. Maxime expedita laboriosam corporis ipsam quae delectus eveniet consequatur.\n\nOmnis velit cumque blanditiis consequatur doloribus voluptatum atque delectus. Hic commodi earum in tenetur deleniti minima. Fugit minima laborum iusto. Voluptatem culpa perspiciatis numquam non aliquam.\n\nSuscipit modi magnam modi porro. Molestiae esse quis accusamus. Minus eos rem consectetur.\n\nOfficiis dolore esse quos expedita voluptatibus saepe perspiciatis. Autem odio ipsam quibusdam repudiandae magni in. Placeat voluptate tempore asperiores officiis.	45.34	\N	2018-03-13 03:22:29.87653+00	3	"1"=>"1", "4"=>"9"	f	t
390	Scott, Hall and Smith	Facilis incidunt minima vero asperiores architecto. Animi cumque error ex quis et delectus voluptas beatae.\n\nOfficiis aliquid alias deleniti. Deleniti amet modi pariatur labore ratione dolore. Magnam tenetur dolores a ipsa at at repudiandae.\n\nMolestias dolore culpa magni rem fugit. Animi cupiditate repellat voluptas quas officiis nobis molestias. Autem corrupti sequi accusamus quidem.\n\nAliquam qui voluptate tempora quasi sit eum aut. Reiciendis non labore totam illo commodi quidem. Delectus voluptatum incidunt iste qui incidunt molestiae. Nihil eum corporis facere.\n\nQuidem voluptatibus est voluptatem doloremque est. Numquam in unde eaque delectus placeat. Totam sapiente eius inventore eos fuga soluta.	82.87	\N	2018-03-13 03:22:29.93282+00	3	"1"=>"1", "4"=>"8"	f	t
391	Foley, Lopez and Reed	Mollitia aut deserunt iure quod ea eos accusantium. Sint amet veritatis voluptas unde vel maxime deserunt alias. Hic inventore occaecati consequatur sed porro.\n\nVel earum totam nostrum inventore. Odio ipsum accusantium laboriosam atque iste tempora. Labore odio ex temporibus unde quibusdam.\n\nIpsam sunt quibusdam facilis nulla. Ipsa accusamus blanditiis ea excepturi. Quam nostrum adipisci sint doloribus alias. Iusto deleniti quod eveniet ipsum rerum nisi nihil.\n\nCupiditate vel numquam amet doloribus. Voluptates nesciunt harum alias nobis ex qui. Tempora voluptatibus non aspernatur mollitia ratione autem sequi. Facere provident inventore vero.\n\nConsequuntur quo nisi repellat nostrum provident eveniet. Perferendis eveniet dolor ipsa unde esse corrupti. Corporis provident veritatis est possimus neque voluptas.	15.81	\N	2018-03-13 03:22:29.998192+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
392	Gonzales, Torres and Allen	Saepe occaecati aspernatur maiores ab quaerat beatae. Similique ducimus explicabo quisquam illum atque maiores dolor dicta. Voluptate odio amet earum error. Laboriosam ad nesciunt occaecati aliquid maxime incidunt nam repudiandae.\n\nEx ut quibusdam magnam iure libero sequi maxime earum. Aliquam nisi sequi ex suscipit. Sit assumenda nulla excepturi vitae excepturi similique. Amet molestiae id perspiciatis aut.\n\nAssumenda saepe sequi tempore inventore deleniti aliquid maiores aliquid. Ab magnam ad dolor odio ipsum laudantium. Rerum aut consectetur dolor tempora iusto ipsa. Odio sed vitae odit iure accusantium facere molestias excepturi.\n\nQui rem modi possimus quo repellat consequuntur neque. Odit quia expedita necessitatibus. Eos asperiores sunt dolorum blanditiis ut temporibus tempore.\n\nVero nobis labore amet. Fugit provident quam ipsam voluptatem consectetur. Provident dolores dignissimos culpa neque minus odio necessitatibus. Culpa laudantium quasi non natus nisi.	87.61	\N	2018-03-13 03:22:30.073711+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
405	Smith-Miller	Dolorum debitis itaque distinctio dignissimos illum. Dolore minima soluta sunt perspiciatis. Quibusdam corporis cum voluptate nostrum inventore laborum delectus.\n\nSoluta sed nesciunt soluta laborum asperiores. Architecto quia optio ratione maiores. Distinctio accusantium similique eaque quia perferendis expedita. Ut neque voluptate dignissimos facere rem quisquam.\n\nIure iste porro excepturi consectetur tempore laborum quibusdam commodi. Laboriosam debitis tempore eaque eligendi eius natus. Earum provident consectetur quos aliquam.\n\nRepellat porro est cupiditate voluptas ab. Laborum tempora in eos expedita sit. Vero dignissimos ad commodi qui iure praesentium quod. Dicta tempora fugiat accusantium esse iusto.\n\nAsperiores illo temporibus possimus iste suscipit quisquam. Magnam iste cupiditate at adipisci debitis commodi eaque dicta. Asperiores nostrum veritatis officiis consequatur eius.	47.84	\N	2018-03-13 03:22:30.874494+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
406	Hernandez-Pruitt	Cumque impedit autem quas tempora sed dignissimos excepturi. Mollitia consequatur nulla laboriosam veritatis corporis ea nostrum. Nesciunt veniam vitae quidem odit. Veritatis nemo consequatur consectetur.\n\nAb tempora eligendi commodi incidunt quae. Ipsam ut maiores debitis delectus accusantium saepe. In eligendi nobis impedit vero.\n\nEst eum hic commodi accusamus eos qui sint. Quo totam laudantium consequatur eum quo vel. Velit illum blanditiis molestias doloremque reprehenderit. Reiciendis voluptatem debitis soluta vitae.\n\nReprehenderit perspiciatis quae rerum neque quas dolore a. Maiores odit beatae corporis reiciendis. Sit ad molestiae consequuntur a perspiciatis.\n\nCum quod numquam at doloremque aut rerum. Aperiam aperiam libero error occaecati iusto expedita suscipit. Molestias nobis neque aperiam maiores voluptatem. Itaque adipisci eligendi iusto veritatis blanditiis mollitia. Occaecati harum magni libero at.	32.45	\N	2018-03-13 03:22:30.913743+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
393	Donovan-Rios	Expedita veritatis qui quae quasi inventore enim. Architecto sequi reprehenderit corporis iusto placeat. Quia magnam aliquid deleniti corrupti quod accusamus odit.\n\nEius laborum soluta facere similique minima repudiandae. Dolorem sed impedit sint autem tempore modi. Reiciendis cumque laborum nam eum voluptas nobis.\n\nMaiores sapiente quos unde. Vel facilis itaque libero dolorum. Deleniti eaque tenetur voluptates. Ad quidem alias voluptatem cupiditate. Voluptates animi explicabo iusto quaerat.\n\nQuaerat quibusdam modi nemo corporis veritatis excepturi recusandae voluptatum. Autem quo cum provident tempore consequatur voluptate quae. Velit nisi aspernatur qui beatae. Laudantium laboriosam quia commodi maxime harum cumque accusantium occaecati. Ipsum quidem itaque accusamus mollitia vero dolor.\n\nInventore nostrum id accusamus distinctio fugit illum aperiam. Eligendi pariatur nostrum incidunt blanditiis ipsum rerum ipsum dolorem.	80.70	\N	2018-03-13 03:22:30.141632+00	4	"1"=>"1", "6"=>"14", "7"=>"16"	f	t
394	Williams-Graham	Error neque nobis praesentium tempora beatae at. Officia nesciunt consequatur neque unde ratione nostrum explicabo. Commodi aut quae cumque in aut exercitationem itaque.\n\nMagni quasi odio at incidunt quae minima voluptatibus. Corporis quas qui eos soluta aut. Blanditiis repudiandae assumenda enim officia quae voluptatibus. Voluptatum sed delectus sequi delectus laborum sequi reiciendis.\n\nQuas quae magni voluptates ipsam et quidem. Porro praesentium perferendis ab expedita beatae temporibus. Eaque libero dolore maiores nemo in.\n\nDolor vel consequatur illo quaerat maiores saepe fuga. Adipisci officiis officiis debitis porro reprehenderit. Harum expedita esse nisi repellat rerum natus occaecati voluptatum. Porro atque sed ab neque recusandae.\n\nOmnis officia sunt recusandae nostrum dolorem pariatur. Sequi quod a porro provident odio nemo. Natus accusantium quasi ullam laborum. Voluptates officia ipsa sequi nam tempore. Consectetur ea fugiat eaque quia autem.	31.66	\N	2018-03-13 03:22:30.202079+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
395	Hernandez Group	Reiciendis saepe possimus commodi non odio odio laborum. Officiis aliquam reprehenderit maxime dolore sint doloremque minus.\n\nError totam eos aperiam aliquid quasi illum quidem hic. Accusantium iusto libero consequuntur. Officia nostrum architecto saepe eaque doloribus qui. Doloribus necessitatibus dolorem nostrum mollitia.\n\nPerspiciatis dolorum similique adipisci beatae. Officiis iure iure nam quisquam praesentium. Officia nemo pariatur dolorem neque temporibus quisquam. Incidunt recusandae a maxime.\n\nRecusandae natus minus ab voluptatibus itaque. Iusto suscipit assumenda eveniet blanditiis corporis illo. Dolor placeat impedit distinctio. Illum aliquam possimus laborum nemo ducimus adipisci corrupti praesentium.\n\nTemporibus distinctio quisquam sequi. Nisi reiciendis alias enim quaerat fugiat doloribus aperiam. Unde enim nihil natus ipsum officiis sequi minima modi.	15.40	\N	2018-03-13 03:22:30.275876+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
396	Gardner, Rivera and Humphrey	Non doloribus omnis iure quis. Dolor amet alias voluptatum qui eaque. Corrupti quis ex quisquam accusantium aperiam ipsa accusamus.\n\nQuas veritatis libero quo at. Facilis enim placeat unde unde nisi consequatur. Unde doloremque cum nulla aliquam ad atque vel.\n\nTemporibus deserunt ex necessitatibus explicabo. Mollitia dolorem voluptatum veritatis nulla autem. Harum exercitationem sint possimus delectus est. Architecto sint voluptates expedita ducimus.\n\nDolorem suscipit excepturi ipsum dolor impedit in. Repellat incidunt excepturi totam voluptatibus delectus laborum. Dolor explicabo sit maiores voluptatum laboriosam cupiditate quae.\n\nInventore velit totam nobis ea. Dolorum culpa aliquam hic nam fugit. Natus odit dolore neque ipsum ipsum quas occaecati. Doloremque voluptas saepe suscipit quidem magnam dolorem.	62.65	\N	2018-03-13 03:22:30.340569+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
397	Webb-Bullock	Itaque quisquam nemo aliquid. Vel impedit expedita quasi mollitia delectus totam quaerat debitis. Necessitatibus fugit aperiam ut neque praesentium facilis sit. Fugit tempora consequatur rem suscipit beatae hic.\n\nEos occaecati architecto sit perspiciatis. Inventore quia velit veritatis eligendi consectetur quo. Culpa asperiores cum aspernatur maxime ad impedit. Adipisci explicabo nulla consectetur natus. Magnam ut vero qui maiores tenetur.\n\nIusto animi eos porro. Eum aperiam error occaecati occaecati quos sed debitis suscipit. Numquam ab enim deserunt tempore itaque voluptas culpa. Animi aperiam facere error libero.\n\nOfficia autem temporibus eum dicta excepturi quae ipsum. Nemo voluptatum voluptatum officia quos. Fugit debitis veritatis quo sequi sed voluptatibus.\n\nSapiente facere impedit fugiat nostrum harum excepturi corrupti eligendi. Rerum laborum eos totam repudiandae culpa vero.	50.30	\N	2018-03-13 03:22:30.403921+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
398	Sullivan-Hall	At deleniti odit quis adipisci. Laudantium repellat veniam omnis voluptatum. Vitae rerum sint nostrum impedit aliquid ullam iste.\n\nEst aspernatur rerum ut optio ipsa aperiam. Molestiae tempora nostrum magni reiciendis non. Consequuntur reprehenderit vitae aut deserunt natus. Atque quibusdam reprehenderit nihil hic laboriosam harum.\n\nRepellendus ab alias eos quaerat molestias repellendus. Tempore labore accusantium magni eos. Cumque voluptas nam pariatur suscipit explicabo.\n\nFugit et dolorem unde vitae. Pariatur veniam ipsa neque esse. Nemo corrupti nulla veniam sunt illum enim reiciendis quae. Ex atque quod vitae laboriosam.\n\nAt maiores adipisci quia veritatis quia accusantium quod. Numquam cumque eligendi delectus quia velit provident non. Fuga blanditiis architecto iure porro autem quibusdam. Consequuntur impedit porro ab nostrum quae et reiciendis harum.	39.29	\N	2018-03-13 03:22:30.470142+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
399	Cordova, Brown and Evans	Suscipit quaerat doloribus dolore impedit maxime sit voluptas. Velit excepturi accusamus in maiores veritatis blanditiis. Eos harum fugiat magni fugit officia quos sint. Placeat enim assumenda ratione quod.\n\nAliquid maxime enim ipsum minus tenetur. Est quis placeat vero nihil beatae sint. Eaque mollitia asperiores quod quod expedita eius. Illum molestiae unde a nemo.\n\nLaboriosam alias odio culpa aspernatur minus quo dolor. Accusantium vel voluptas accusantium quis soluta. Quos sapiente neque maiores dolor laborum. Eum maiores voluptatem ducimus accusantium esse neque.\n\nMollitia commodi minima vitae eveniet perspiciatis. Voluptate eos officiis exercitationem ipsum at. Consequatur ex minima nesciunt explicabo sequi.\n\nQuo sapiente repellendus rerum dolores distinctio magni. Repellendus suscipit fuga quae. Nam eos eos quas quae delectus nisi iusto.	68.95	\N	2018-03-13 03:22:30.533231+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
407	Combs-Lopez	Deleniti repellendus molestiae labore corrupti rem aliquid. Animi saepe aspernatur deleniti modi atque tempore error. Placeat doloribus nihil unde praesentium dicta minus. Tempora quibusdam recusandae impedit quibusdam.\n\nMaxime fugit laudantium earum amet. Incidunt accusantium praesentium iste excepturi. Pariatur accusantium consequatur cupiditate praesentium. Eligendi nihil dolores neque voluptatibus officiis dicta rerum.\n\nLabore eaque porro mollitia autem. Nihil quam blanditiis sunt voluptate error odit. Libero repellat et id dignissimos odio harum.\n\nPorro consequuntur tempore porro et. Ut veritatis delectus sit doloribus voluptatibus.\n\nIn fugit esse expedita vero vitae. Impedit consequatur maxime laborum sunt doloremque eaque. Odio non quae provident porro enim.	18.32	\N	2018-03-13 03:22:30.966666+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
400	Rice, Miller and King	Modi rem laborum temporibus velit. Illo dolore debitis totam nam perspiciatis labore optio. Officia deserunt molestias vel. Repellat minus animi quidem ipsam.\n\nFacilis libero optio distinctio explicabo adipisci recusandae. Mollitia aspernatur impedit error non veniam maiores id. Esse ratione deleniti voluptatem repudiandae maiores. Deleniti architecto nostrum magni nihil magni quam quasi.\n\nCulpa repellat tempora quis cum non. Blanditiis laboriosam incidunt saepe tempora suscipit aperiam. Deleniti veniam mollitia qui ex iste officiis.\n\nQuidem iure laudantium tempora ratione dolore aliquid vel. Ducimus velit dignissimos nesciunt natus accusamus recusandae. In mollitia natus voluptates suscipit id labore. Maiores necessitatibus earum dignissimos fugiat asperiores recusandae excepturi nihil.\n\nVoluptatibus earum voluptates non nobis cum dolores perferendis. Quae facere magni nisi nemo. Asperiores odio quo saepe iure laudantium et. Repudiandae velit veritatis debitis vel.	51.32	\N	2018-03-13 03:22:30.591326+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
401	King Group	Expedita amet nam illo libero vel minima distinctio. Possimus vitae eaque vero doloremque dolorem. Recusandae dignissimos reiciendis ducimus saepe earum. Velit corrupti reiciendis nisi rem animi repudiandae. Fuga expedita odio assumenda exercitationem voluptatem alias.\n\nNam molestias dicta laudantium aliquid voluptatem sit blanditiis. Autem assumenda aut reprehenderit ratione sequi animi occaecati. Dolorem nostrum fuga amet doloremque officia quidem.\n\nNobis optio at architecto atque minus. Et corrupti perferendis minima saepe perspiciatis. Aliquam vero perferendis nam aspernatur hic amet. Perspiciatis voluptatum assumenda esse aliquam.\n\nRem labore itaque quod soluta repellat repellendus. Quo officia nihil consectetur et sunt eius.\n\nAnimi totam eligendi ipsam soluta. Beatae ex itaque sit laborum. Magnam omnis a reiciendis laborum beatae accusantium dicta.	87.59	\N	2018-03-13 03:22:30.677281+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
402	Hopkins, Castillo and Campos	Tenetur nemo iste esse consectetur esse. Optio ullam officiis saepe omnis quae. Ipsam eligendi provident vel distinctio explicabo qui.\n\nOdio quam saepe ut iusto. Facilis reiciendis voluptate nostrum cumque suscipit voluptatum ad. Id harum eos voluptas autem vel totam omnis. Voluptates error voluptatibus magnam ipsum vero.\n\nVero vitae magni id fuga aliquam. Nulla quibusdam dignissimos molestias quia accusamus repudiandae placeat. Voluptatem repudiandae error cum ea nam possimus quae. Sit quia incidunt molestiae impedit accusamus ratione accusantium. Molestias temporibus rem iusto soluta qui.\n\nAccusantium alias totam asperiores. Aperiam quibusdam at quidem voluptas eaque similique totam molestias. Similique ratione reprehenderit deserunt minus quaerat. Mollitia sapiente sint in ducimus deleniti est. Ipsa doloribus ut repellendus numquam cupiditate alias.\n\nIure expedita hic dolorem placeat. Ipsa laborum sit voluptate praesentium maxime fugit tempora deleniti. Quasi nobis eum suscipit.	23.12	\N	2018-03-13 03:22:30.71793+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
403	Brown LLC	Architecto id debitis earum corrupti tempora ipsum reiciendis. Voluptate ipsam molestias dolorem odio. Modi expedita maxime autem nihil occaecati. Fugit atque ex suscipit quae a laboriosam. Rem quia eum alias animi eos minus dolorem.\n\nIpsum eum ex sapiente tenetur voluptate laudantium atque voluptatem. Temporibus reiciendis voluptatem aperiam earum accusantium. Similique enim tempora ad officia at. Rem quia laboriosam dolores at iusto. Maxime dolorum velit veniam voluptates.\n\nAb possimus numquam dolor ut excepturi reiciendis laudantium. Sint perspiciatis quam excepturi perferendis. Nostrum ea neque nam velit. Veritatis officia quod iste quia ea.\n\nA ipsum voluptatem porro explicabo sed maiores. Accusamus officia sed minima cupiditate.\n\nLaborum rem officiis officiis explicabo sequi. Maiores tempora assumenda ipsam iusto repudiandae nesciunt. Quasi iusto veritatis quos cumque rem dicta accusantium.	11.46	\N	2018-03-13 03:22:30.75552+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
404	Murray and Sons	Aperiam voluptate voluptate nesciunt rem. Laboriosam maxime consequuntur inventore ut repellendus commodi atque. Quod ullam ullam natus.\n\nSequi odit nam nemo. Voluptatibus dolores adipisci harum minima harum veniam neque aperiam. Dolor sequi dolores voluptas ullam ducimus voluptas ducimus. Perspiciatis non harum modi incidunt expedita dicta excepturi aliquam.\n\nFugit similique dolore quibusdam rem. Officiis officia fuga ad accusamus ad quam facere. Repellat ipsam ipsam soluta repudiandae beatae quas. Laborum possimus eius sint dolorum consectetur.\n\nVitae molestias sint omnis. Cum sunt quae amet qui. Voluptatibus deleniti quos ratione minima facere incidunt quam velit. Delectus aspernatur praesentium dolorum.\n\nQuasi minus aspernatur nulla magnam officiis hic. Voluptatum commodi ipsam iure itaque dolorum nostrum. Eos consequatur dolor et eum voluptas minus. Quis eos et at odio veritatis incidunt ad.	75.64	\N	2018-03-13 03:22:30.808459+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
408	Rice, Anderson and Hubbard	Nemo velit sint vel quam amet sit. Ratione ratione debitis perspiciatis similique. Fuga dolores reiciendis porro aspernatur velit a.\n\nModi quaerat ratione occaecati vel. Quam porro molestias fugit recusandae excepturi harum assumenda. Laborum quos in totam voluptatum. Iste quisquam aperiam libero rem error cupiditate voluptas.\n\nSint quasi molestiae officia explicabo quo doloremque. Ducimus mollitia vero quod laudantium reprehenderit explicabo. Esse repellat alias voluptatum atque numquam facere et.\n\nMaiores recusandae voluptas nulla totam nihil culpa. Veniam ut quasi incidunt cum fuga perferendis illum. Temporibus error sit dignissimos veritatis dolores dicta.\n\nQuae nulla ipsam illum magnam animi quo. Dolorum ea fuga officia illum sequi aliquam. Inventore deserunt ab non minus. Beatae enim dolore ut rem hic.	50.21	\N	2018-03-13 03:22:31.016917+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
409	Butler and Sons	Necessitatibus dolor asperiores doloremque accusamus at eveniet. Sequi quidem molestias sequi eveniet. Natus rem delectus fugit aperiam maiores impedit. Animi neque cupiditate velit excepturi sapiente suscipit.\n\nIpsa corrupti mollitia fuga numquam unde vero nihil. Ea doloribus cum ad suscipit veritatis nobis ab. Esse deserunt provident occaecati.\n\nPossimus perspiciatis alias nam est non ipsam eius. Enim laudantium fuga nesciunt minus. Accusantium ipsum est quod at delectus fugit aperiam.\n\nVelit pariatur quidem praesentium atque. Rerum repellat illum tempore rem consectetur asperiores dolorem sequi. Eum illo placeat molestias.\n\nReprehenderit illo rem repellat deserunt aspernatur itaque. Alias ad ipsam quos enim. Suscipit quasi occaecati quidem voluptate.	36.85	\N	2018-03-13 03:22:31.065035+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
410	Crawford, Murillo and Stokes	Hic expedita nisi rem natus maxime neque. Debitis fugiat quasi praesentium impedit quibusdam.\n\nOfficiis nemo ducimus placeat. Maxime nulla velit eveniet. Inventore delectus ab occaecati facilis architecto enim quis.\n\nIpsa cumque aut explicabo illo ipsum dolore. Ducimus doloribus ipsa doloremque laudantium. Deserunt ab enim suscipit. Corporis ducimus doloremque totam enim corrupti praesentium.\n\nEst ab maxime sit nobis fugiat quod error atque. Dolorum nisi numquam quasi unde. Explicabo nostrum deserunt illum.\n\nEa fuga eveniet accusantium rerum quis amet tempore. Accusamus autem assumenda doloribus magnam odio. Praesentium excepturi perferendis accusantium. Corrupti facilis ab totam accusamus omnis facere ad.	94.34	\N	2018-03-13 03:22:31.109013+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
411	Singleton Group	Culpa tempore dicta quis error placeat magnam. Explicabo voluptate sit dolorum numquam omnis. Nobis praesentium voluptatum doloremque quos adipisci voluptas.\n\nRepellendus dolorem modi exercitationem incidunt fugiat voluptatum deserunt nulla. Quaerat necessitatibus repudiandae a voluptatum voluptas. Debitis velit nisi optio.\n\nAspernatur in eius aliquid sed eligendi et iusto odio. Excepturi distinctio culpa quibusdam eius culpa ipsam incidunt. Vel minus unde nesciunt doloremque.\n\nNeque vel explicabo soluta architecto et. Repellat alias ad illum numquam. Rerum mollitia commodi eius soluta iusto exercitationem.\n\nNumquam rem pariatur molestiae delectus officia. Aliquam tenetur cum maiores cupiditate amet totam. Quasi aliquid voluptates nostrum. Optio a magnam odio nisi inventore inventore.	89.48	\N	2018-03-13 03:22:31.170218+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
412	Wells, Holmes and Carter	Eaque soluta alias officia amet nulla. Iure eos consequuntur sed laudantium. Laborum autem cum quia. Consectetur explicabo modi dolores consectetur recusandae.\n\nMagni illo officiis est cupiditate impedit quis magni. Ex quisquam nulla quia a ut laborum blanditiis. Voluptatibus dolorem doloribus porro nisi porro qui. Deserunt error assumenda dolores tempora saepe perspiciatis.\n\nEx ea rem numquam vel minima. Nostrum sed velit sapiente provident provident error quae. Vel quae aperiam fugiat dolore reiciendis.\n\nAliquid repellendus quibusdam vero. Assumenda velit consequatur atque pariatur quo necessitatibus rem labore.\n\nBlanditiis cum vitae beatae ea. Id minima necessitatibus magni magni. Assumenda ex numquam beatae cumque ex inventore.	11.90	\N	2018-03-13 03:22:31.22072+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
413	Dawson Inc	Totam deleniti omnis consequatur doloremque enim alias explicabo quaerat. Excepturi distinctio aliquam rem fugiat nihil odit doloremque. Sint sequi sunt architecto eius tempora. Corrupti perferendis illo aut.\n\nRepudiandae eaque accusantium dolorum. Ex beatae doloribus id laboriosam ex in suscipit.\n\nQuos sit esse nemo praesentium animi molestias. Vel pariatur aspernatur veniam cupiditate maiores corporis voluptas. Ipsum officia nemo hic. Fugit magni id deleniti non culpa at quibusdam.\n\nIste natus atque quam ratione quaerat. Dicta doloremque optio totam sequi dicta eveniet commodi. Adipisci magnam reprehenderit fugit quidem.\n\nVitae soluta aliquid natus officia doloribus. Expedita minus nulla eum adipisci quibusdam aspernatur quibusdam.	67.17	\N	2018-03-13 03:22:31.255931+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
414	Bailey, Hernandez and Lopez	Exercitationem quaerat id id dicta iusto. Perferendis possimus cumque iure accusamus illo. Maiores suscipit iusto modi non iusto ab.\n\nQuos reprehenderit necessitatibus ut harum non. Quod architecto illum quia at. Quos exercitationem ratione dolores quas eaque quo doloribus eveniet.\n\nSaepe sed minus unde sit. Dolor laborum quas voluptas ad sed laudantium. Possimus quis accusantium eum aut.\n\nDicta earum sint ab nesciunt minus. Ipsam sit iste est sit tempore. Est hic architecto optio molestias. Sequi numquam quis nemo.\n\nSit reiciendis vel provident quam. Ratione accusantium reiciendis eum corporis pariatur.	72.97	\N	2018-03-13 03:22:31.323343+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
415	Watson and Sons	Laborum in quae deleniti temporibus. Quidem ex ratione cumque hic nulla rem quasi sapiente. Animi enim unde officia iusto cum amet laboriosam.\n\nEos eius cumque odit dolorum similique sed nisi. Molestias quasi ducimus nam perferendis suscipit nihil ex fugit. Ipsa rem minima atque doloremque. Accusantium at quia sunt aut.\n\nLibero officia quaerat ea. Tenetur molestiae tempora quis delectus incidunt dicta nulla. Placeat error reiciendis quas error explicabo ipsa.\n\nNumquam a iure reiciendis laborum sunt excepturi perferendis. Sapiente non illo ullam distinctio provident. Suscipit quas asperiores dolorem aliquid.\n\nCulpa quaerat quos doloribus minima alias. Minus sunt est voluptate modi architecto a. Dicta eos repellendus quaerat quibusdam eveniet.	16.21	\N	2018-03-13 03:22:31.370676+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
418	Ortiz-Frost	Harum odio voluptatem est nam consequatur eligendi. Officia dolorem itaque corrupti accusamus natus consequuntur eius explicabo. Eos adipisci consequuntur eius nisi a. Voluptatibus possimus ex dolorum dolores neque.\n\nQuibusdam eligendi laboriosam occaecati omnis corrupti. Voluptas rem error reprehenderit nemo consequatur quod omnis. Fugit eos eum atque facilis veniam. Voluptatum cum dolorem eos cumque.\n\nIllum vitae laborum possimus veritatis sequi. Sint ad nam veniam ratione ipsa porro voluptatibus doloribus. Quia eius animi commodi commodi.\n\nReprehenderit esse suscipit nostrum quas id ut doloribus. Itaque quia reiciendis delectus quasi repudiandae pariatur dolore nihil. Adipisci veniam vel hic. Laborum fugit aut laudantium voluptas officiis quae.\n\nNeque eum a quisquam voluptatum quos. Quidem nulla nihil fugiat culpa architecto consequuntur ullam sit. Cupiditate nostrum ullam possimus est laudantium. Facilis incidunt asperiores cumque error. Provident ipsa vero laborum quae quis officiis ratione quibusdam.	45.56	\N	2018-03-13 03:22:31.495152+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
419	Smith, Burke and Landry	Quibusdam vitae odio incidunt ex corrupti. Reprehenderit non quos asperiores numquam exercitationem eveniet provident. Iste laboriosam natus aut iusto dolore accusamus repudiandae.\n\nAnimi iure maiores quasi aliquid vitae voluptate doloremque voluptates. Nisi voluptatibus sint quas nobis. Voluptatum numquam voluptas mollitia accusantium esse necessitatibus tempora.\n\nAtque deleniti provident quaerat nulla corporis vitae id. At velit aliquam recusandae. Eum asperiores et eos aspernatur harum suscipit. Commodi nisi ratione tempora unde quo voluptatum odit.\n\nCum hic ratione placeat. Laborum delectus quia explicabo magnam. Suscipit tempore sapiente eos temporibus minima earum. Quibusdam quo expedita veritatis commodi animi distinctio.\n\nRem eos ad eos accusamus. Magni reprehenderit itaque sed pariatur. Fugiat quisquam quam molestiae nobis quidem.	28.62	\N	2018-03-13 03:22:31.553979+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
420	Perry-Haynes	Et numquam dolor consequatur exercitationem itaque soluta. Voluptatum minus reprehenderit quos nulla quas magni. Deleniti deserunt repudiandae cupiditate dolor reprehenderit.\n\nConsectetur commodi quisquam pariatur necessitatibus debitis sequi vel atque. Distinctio provident ullam minima similique. Aperiam facilis asperiores suscipit earum. Doloremque illo consectetur molestias quibusdam.\n\nConsectetur ipsum unde veniam similique amet voluptate. In esse reiciendis aliquam natus eos quas. A ipsum laborum sit nam ipsa voluptatum rem. Aspernatur quia provident delectus nam deserunt nisi itaque.\n\nMaxime sint dolores maxime blanditiis nulla. Aliquid ipsa repellendus beatae qui quae minus praesentium. Dolores exercitationem praesentium perferendis cum dignissimos pariatur temporibus quas.\n\nAperiam beatae dolor voluptatem error illum. Sint ullam velit aliquam quas. Eveniet impedit reiciendis fuga sint aperiam dolore.	51.55	\N	2018-03-13 03:22:31.603223+00	6	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
421	Anderson-Martin	Pariatur odit exercitationem vero ipsam ad officiis. Dignissimos reprehenderit beatae eius eum unde debitis. Aut recusandae debitis accusantium ducimus labore alias molestias inventore. Quidem dolorum facere minima eveniet doloremque.\n\nAsperiores deserunt nam vel quos quod sequi eius dolores. Amet iste sequi maiores neque ad suscipit iste. Dolor reiciendis repudiandae repellendus eum voluptates error beatae.\n\nIn sunt nesciunt reprehenderit tempora ducimus nostrum. Asperiores qui natus maiores. Dicta alias fugit reiciendis at eligendi dolore repudiandae. Minus ut officiis beatae officia ad laudantium. Labore nobis molestias corporis esse a.\n\nHic ullam deserunt temporibus repellendus quis. Nulla atque error ex fuga omnis quo ipsa. Rerum architecto odit a praesentium quis sint sapiente. Explicabo repellendus harum dolorem et. Tempora explicabo cum quasi eveniet iste ipsam dolorum.\n\nDucimus corporis architecto optio non sit modi aut. Soluta autem asperiores quae reprehenderit. Occaecati voluptatibus architecto sapiente laudantium nesciunt et non. Accusantium deserunt ipsam cumque nam vitae.	27.90	\N	2018-03-13 05:21:40.335713+00	1	"1"=>"1", "2"=>"2"	f	t
422	Mejia, Mckinney and Smith	Cupiditate corrupti nemo ratione porro numquam. Tenetur dolorem quia sit odio aspernatur. Doloribus ratione reprehenderit nesciunt explicabo facere. Molestiae quas cum nemo aspernatur rem odit blanditiis.\n\nFacere inventore impedit neque at. Qui sit distinctio eligendi voluptatum sapiente unde veniam. Animi cumque fugiat aut dolor inventore iste. Officia culpa repudiandae reiciendis dignissimos aperiam architecto voluptatibus ex.\n\nTenetur ad aut illo totam accusamus vero. Molestiae velit ducimus architecto eligendi saepe sit vel facere. Harum adipisci ab distinctio blanditiis facilis atque. Tenetur porro praesentium quidem ipsam eveniet cumque amet.\n\nSint placeat temporibus consequatur cumque sapiente. Excepturi consequatur tenetur accusamus inventore.\n\nSint aliquam quae odit odio odit. Laboriosam est nostrum voluptas similique numquam. Nobis molestiae rem aperiam quisquam perspiciatis laborum.	78.70	\N	2018-03-13 05:21:40.4434+00	1	"1"=>"1", "2"=>"3"	f	t
423	Parsons, Garcia and Gray	Sequi illum quo quas reiciendis temporibus quidem. Repellat sequi qui distinctio et quam quo perferendis sapiente. Harum cumque tempore qui nulla animi dolore. Delectus laudantium aperiam molestias labore.\n\nReprehenderit tenetur quasi et eum quae libero autem. Rerum blanditiis non nesciunt vero quis ad quasi. Dolores magnam corporis distinctio recusandae vitae tenetur.\n\nExpedita libero voluptatibus delectus velit maiores nobis nobis beatae. Rerum cum soluta placeat aliquid at provident ad. Dolorum quod aliquam officiis iste illum.\n\nCulpa commodi culpa saepe repudiandae. Repudiandae ipsum odio odit minus porro id quisquam. Enim aut mollitia eum dignissimos cupiditate. Adipisci labore nostrum enim aliquid eligendi error ipsam.\n\nDelectus molestias accusamus voluptate ipsum perferendis aliquid. Modi praesentium odit amet laborum.	82.90	\N	2018-03-13 05:21:40.564579+00	1	"1"=>"1", "2"=>"2"	f	t
424	Cooper, Moore and Palmer	Expedita cumque soluta aspernatur. Esse voluptatibus officia vitae eaque alias laborum. Aliquid harum saepe esse modi. Sequi rerum recusandae iusto aut id culpa ad quas.\n\nDolor nam velit nobis pariatur placeat ducimus aut. Occaecati autem rem adipisci dicta. Sint consectetur quam eveniet beatae enim pariatur veritatis. Quibusdam optio distinctio ab facere doloribus.\n\nTemporibus quidem corrupti dolore velit incidunt possimus. Qui distinctio sunt quae reprehenderit. Quod vero cumque nisi sit.\n\nNobis consequuntur fugiat nostrum enim perspiciatis enim labore. Aperiam labore aliquam dolore asperiores ipsum.\n\nError amet nisi a iste mollitia explicabo. Consectetur assumenda id animi rem exercitationem. Alias provident impedit provident.	61.36	\N	2018-03-13 05:21:40.635161+00	1	"1"=>"1", "2"=>"3"	f	t
425	Perry Ltd	Debitis illo dolores recusandae ea repudiandae similique. Amet delectus alias vitae consectetur eum. Molestiae vero magnam nostrum illo vero. Quidem inventore magnam aliquid cumque minima quod necessitatibus.\n\nMaxime natus fuga consectetur eos. Sint illo ea doloribus commodi sunt totam ipsam. Occaecati iure hic facilis rem culpa magnam. Inventore amet repellat eum excepturi ea.\n\nSimilique vel repellat alias dolores autem ut. Ut aliquam eaque cupiditate consequuntur voluptates laudantium repellat. Numquam pariatur quia beatae voluptates itaque voluptatibus aperiam.\n\nNon possimus esse fuga debitis. Occaecati facilis ad maiores dicta. Error in inventore eligendi error error. Enim totam natus autem maxime perspiciatis.\n\nQuaerat atque distinctio quas explicabo. Esse illo sint culpa in dolor. Iste nam ipsum consequuntur dolorum.	85.22	\N	2018-03-13 05:21:40.717483+00	1	"1"=>"1", "2"=>"3"	f	t
426	Kramer PLC	Dolorem soluta suscipit similique dolorem fugit numquam assumenda molestias. Atque saepe veniam quae.\n\nOmnis doloribus at architecto. Cumque fugiat iste officiis facere cupiditate. Error assumenda qui earum ratione. Ipsa accusamus impedit repellat ab.\n\nIpsum quia libero adipisci occaecati nulla. Rerum earum blanditiis repudiandae nobis neque. Laudantium autem mollitia delectus amet odit fuga. Id enim aliquid consequatur cumque voluptate rem.\n\nMinima exercitationem aperiam occaecati quos quae. Et deserunt minus cupiditate vel corrupti occaecati dicta. Reprehenderit nostrum sed commodi laudantium eius. A temporibus voluptatum adipisci maiores nobis ratione.\n\nQuam animi est debitis aliquam. Recusandae ratione asperiores ipsum corrupti quis. Amet optio reiciendis facere quaerat tenetur.	11.12	\N	2018-03-13 05:21:40.773731+00	1	"1"=>"1", "2"=>"3"	f	t
427	Jones PLC	Fugiat incidunt dolor consequatur distinctio placeat. Aspernatur possimus rerum ex reiciendis maxime. Nemo quia ad voluptatem maiores.\n\nEnim voluptate cupiditate molestias numquam nesciunt assumenda quas. Nisi provident nulla dolore asperiores. Repellendus porro modi deserunt reprehenderit. Officia delectus eius nulla sit.\n\nDolorum fugit cum maxime eum nam fuga. Molestiae quasi libero architecto voluptatum. Voluptate officia a saepe dignissimos amet fuga soluta.\n\nRepellendus et quibusdam dicta. Nulla consectetur nemo fuga tenetur explicabo nisi. At eligendi explicabo perspiciatis neque a.\n\nIllo doloribus et totam aperiam. Suscipit repellat enim similique soluta doloremque adipisci. Saepe architecto voluptates inventore earum nostrum aspernatur.	68.87	\N	2018-03-13 05:21:40.828681+00	1	"1"=>"1", "2"=>"3"	f	t
428	Taylor Inc	Assumenda et voluptatibus voluptatum quam minus ipsa. Vel dolor deserunt accusantium ipsam occaecati. Natus iusto ipsam vitae animi exercitationem est magni.\n\nVoluptatem eos quidem id pariatur expedita. Magnam neque harum exercitationem aut vero iure. Corporis adipisci velit suscipit magni tempora. Eum molestiae similique provident sapiente commodi totam quos.\n\nAsperiores similique asperiores cum libero cumque quae. Repellendus sint voluptas veritatis dolorum. Ut tenetur dolorem optio a voluptate ex quaerat.\n\nAliquam nisi quas voluptates veniam voluptatem quasi. Delectus explicabo repudiandae adipisci mollitia quibusdam corrupti voluptatum.\n\nVitae quae enim illo aliquid voluptas reprehenderit sapiente. Nulla nam modi reiciendis officia velit eius. Harum eum eveniet aperiam dignissimos facere accusamus.	54.95	\N	2018-03-13 05:21:40.893462+00	1	"1"=>"1", "2"=>"2"	f	t
429	Mccall and Sons	Officiis modi eum qui tempore ea. Culpa sint non soluta quam reiciendis et minima. Voluptate qui accusantium dicta fugiat.\n\nVoluptatum nulla praesentium mollitia tenetur. Debitis commodi dolorem id temporibus laboriosam. Corporis laudantium maxime inventore unde alias aliquid sed.\n\nQuod nostrum dicta voluptas temporibus repellat quod. Explicabo illum porro ad eos. Ipsa perferendis nesciunt culpa voluptates. Sint necessitatibus ut suscipit eligendi vel.\n\nIllum iusto consectetur repellat repellendus similique. Minus alias illum molestiae repellat veniam cupiditate. Aut voluptatibus suscipit ducimus repellendus assumenda iste explicabo.\n\nQuasi laudantium dicta laboriosam ipsam sapiente ipsa modi laborum. Odit soluta optio quae harum incidunt occaecati.	58.32	\N	2018-03-13 05:21:40.940037+00	1	"1"=>"1", "2"=>"3"	f	t
430	Ortega-White	Natus eveniet sit error quibusdam officia beatae tempore. Inventore error quisquam eos occaecati minima rerum. Nam ea tempora cupiditate voluptatibus molestiae atque ab.\n\nAb quaerat quod maxime architecto. Minus sequi unde cumque cumque facilis. Eligendi aperiam expedita voluptatem libero sunt necessitatibus dolores. Praesentium fugit dolorum modi omnis accusantium hic cupiditate doloribus.\n\nVoluptatem molestiae ducimus veritatis error omnis corrupti exercitationem. Cumque explicabo nisi iste ullam nihil occaecati sit. Dolorem eveniet ea aperiam iste quas. Numquam omnis nostrum dolore repellendus dolore hic.\n\nDoloremque molestiae ab tenetur. Magni possimus ratione sunt necessitatibus molestiae. Consequuntur aperiam quia quasi quos similique a.\n\nEos autem consectetur consequuntur nulla quisquam. Facilis quaerat cupiditate corrupti dignissimos itaque harum vitae debitis. Fugit sint aut laudantium voluptatum temporibus.	11.48	\N	2018-03-13 05:21:40.992482+00	1	"1"=>"1", "2"=>"3"	f	t
431	Hernandez, Mayer and Brown	Iusto esse illum facere inventore. Earum quis quae officia nostrum asperiores vel aut repudiandae. Rerum assumenda ducimus quod.\n\nReprehenderit numquam corrupti ad dicta itaque vel sapiente. Voluptatem fuga corporis repellat rem iste explicabo. Amet tempora explicabo harum.\n\nExercitationem praesentium harum rerum porro culpa numquam ab. Ratione recusandae consectetur explicabo quas ratione. Quas provident cum optio repudiandae quia quisquam animi.\n\nIusto sapiente qui dolore cum perferendis. Est suscipit nisi odit quo. Totam praesentium minima dolorum similique commodi cum unde. Nobis consectetur libero recusandae tenetur similique. Nulla accusantium quasi atque explicabo labore.\n\nNisi occaecati illum porro sequi placeat libero occaecati. Accusantium sint at nobis animi aut omnis sequi. Expedita cumque a labore. Modi illo laboriosam distinctio temporibus nam maxime. Ipsam quo accusantium eligendi.	44.33	\N	2018-03-13 05:21:41.050085+00	2	"1"=>"1"	f	t
432	Hughes, Hughes and Thompson	Incidunt assumenda in doloribus. Dolorem numquam ex aliquam consequuntur. Rerum rerum nisi eligendi possimus dignissimos quasi consequatur. Repellendus eos maiores incidunt dolorum mollitia quasi nam laborum. A nihil cumque repellat sapiente sed eum inventore.\n\nExercitationem doloribus assumenda cum dolorem pariatur voluptatibus qui illum. Est aut nisi voluptatum excepturi nihil vitae. Voluptates vitae harum beatae ea hic voluptates. Ab corrupti voluptatum pariatur sit. Dicta quasi omnis maxime earum omnis nobis perspiciatis.\n\nAb inventore impedit perspiciatis reiciendis assumenda. Itaque rerum illum quod aliquid. Soluta quod modi cupiditate assumenda reprehenderit.\n\nPerspiciatis fugiat odit praesentium rerum aliquam placeat sit accusantium. Asperiores minus aperiam occaecati commodi eligendi. Labore unde nisi commodi eius aliquam doloribus. Molestiae iusto exercitationem quos maiores est incidunt earum.\n\nVoluptates illum atque molestias sunt accusantium. Perspiciatis impedit tenetur ex.	19.78	\N	2018-03-13 05:21:41.093727+00	2	"1"=>"1"	f	t
433	Martin LLC	Quos animi numquam quisquam. Perspiciatis consequatur neque alias consectetur error doloremque odit fugiat. Veritatis molestias quae ullam itaque dolorum. Temporibus explicabo tempore fugiat quis ratione.\n\nCum eveniet architecto debitis. Consequatur officia eveniet labore reiciendis iure. Tempore architecto eos reprehenderit ab nulla eveniet. Minus eligendi nulla tempore expedita.\n\nSuscipit ex iste ipsam nobis eligendi earum nihil. Ipsa iste perferendis illo assumenda ratione ipsam iure. Voluptatibus pariatur unde dolorem odit. Dolorum consequuntur rerum molestias nam voluptatem impedit architecto.\n\nPlaceat modi voluptatibus beatae. Fuga voluptate ea minima quos autem dicta autem. Iste omnis ratione dignissimos autem aspernatur. Porro est cum reiciendis nisi eveniet sed.\n\nSit asperiores reprehenderit amet. Ab facere neque non soluta omnis asperiores accusantium eos. Aut possimus quia laboriosam pariatur.	56.31	\N	2018-03-13 05:21:41.145165+00	2	"1"=>"1"	f	t
434	Gonzalez-Edwards	Aut necessitatibus deleniti ab sequi. Ducimus dolores consequatur qui nulla consequuntur voluptatibus explicabo ea. Accusantium itaque reiciendis corporis corrupti perferendis. Aliquid non sapiente consequatur consectetur impedit unde culpa.\n\nVeniam harum deserunt id earum reprehenderit quasi ipsa. Odio esse assumenda nostrum id commodi. Eos eaque officiis consectetur quas dignissimos. Fugiat eligendi iste repudiandae esse.\n\nNobis sit magni corporis optio. Nemo odio quos eius. Vero distinctio iste quisquam et itaque est quisquam ratione.\n\nOfficiis atque eaque aspernatur quo dicta. Fugit tempora aut quod. Sequi voluptatibus nesciunt quidem vero quo pariatur aliquid esse.\n\nSaepe alias delectus a dignissimos accusamus provident. Vitae eaque distinctio error aut itaque. Deserunt voluptate deserunt cumque ad eum. Quibusdam incidunt aliquid aut temporibus possimus unde illo.	14.60	\N	2018-03-13 05:21:41.186583+00	2	"1"=>"1"	f	t
435	Mitchell-Morgan	Ab cupiditate deserunt dicta neque occaecati repellat facere molestiae. Animi debitis tempora atque ab consequuntur id vero. Minima amet et explicabo ex aliquid explicabo impedit.\n\nSit id nostrum sunt recusandae eveniet esse iste. Quis fugiat amet quo omnis praesentium. Ipsam quaerat voluptate perferendis molestias quos eligendi nihil. Numquam est non quaerat harum error.\n\nQuia expedita illum cum aliquid consequatur pariatur. Cum illo qui fugit magnam nisi. Blanditiis saepe occaecati earum ipsum. Esse libero sed nam exercitationem consequatur veritatis cupiditate.\n\nUt commodi labore natus numquam dolore. Cupiditate aliquid architecto atque ipsa ab sapiente possimus. Quia atque ratione error veniam quisquam.\n\nHarum unde velit cumque blanditiis voluptate soluta nulla. Qui soluta quos iste harum sint provident. Nobis quas nostrum quibusdam commodi. Neque culpa animi amet.	49.20	\N	2018-03-13 05:21:41.235896+00	2	"1"=>"1"	f	t
436	Kane, Dillon and Perkins	Quae ratione voluptatem doloremque facere veniam repellendus adipisci. Sapiente facilis molestias at ex. Maxime esse cupiditate voluptate. Maxime provident vel sapiente excepturi corporis nulla.\n\nEaque quia consectetur deserunt veniam eum praesentium et illo. Labore aspernatur a a in.\n\nExpedita in soluta dolorum harum pariatur possimus. Officiis perspiciatis tempore laboriosam voluptatem iusto velit. Nostrum ipsa eveniet dolore eos fuga fuga neque.\n\nQuos ducimus eveniet praesentium totam. Itaque et quasi dolor incidunt culpa. Ab similique eum eligendi quas sapiente provident incidunt. Tempora fugit placeat saepe vel. Beatae ipsum illo deserunt ducimus velit at.\n\nNulla rerum amet nisi repudiandae corrupti iusto. Repellat non minima quos doloribus incidunt dolorem eligendi. Odio magnam natus voluptates alias odit magni vero. Officiis placeat qui delectus distinctio.	45.70	\N	2018-03-13 05:21:41.285946+00	2	"1"=>"1"	f	t
437	Nelson, Newman and Solomon	Nam perspiciatis nemo id maiores earum adipisci occaecati. Iure perferendis neque sunt eum autem. Dolores incidunt exercitationem pariatur expedita.\n\nItaque sunt aspernatur sunt unde deleniti exercitationem. Quam cupiditate cum voluptates distinctio amet maxime. Eius dolore aliquid hic recusandae dolores.\n\nOfficiis in vel aperiam quo excepturi quidem dolorum corporis. Culpa blanditiis natus impedit suscipit quisquam mollitia perferendis.\n\nPorro ratione harum ea deleniti enim error. Consequuntur ducimus amet vero iure architecto doloribus. Accusantium harum sit necessitatibus repudiandae cupiditate.\n\nMolestiae eius eos iste natus autem officiis. Molestias fuga quod consectetur ad expedita. Eaque itaque nisi nesciunt minus nihil ullam.	33.56	\N	2018-03-13 05:21:41.321792+00	2	"1"=>"1"	f	t
438	Cherry-Jackson	Possimus inventore repudiandae vero sit quia tenetur sed. Ducimus rem voluptate delectus labore similique fugit optio. Minus ea ullam non aspernatur porro.\n\nError saepe consectetur deleniti ipsum minima. Harum voluptatum assumenda dolore at ab quasi. Suscipit saepe optio minus aut.\n\nNumquam eaque aperiam beatae sunt. Debitis placeat ipsam nam harum dignissimos architecto perspiciatis. Tempore velit similique officia quod deserunt illum.\n\nDolore ipsa quisquam provident velit. Nulla consequatur quasi adipisci quos. Officia reiciendis est accusantium quis quibusdam neque.\n\nIpsa ratione placeat quis totam facilis quisquam. Ipsa iste quam eius. Similique nulla laboriosam dicta deleniti enim eligendi dolore. Amet doloribus temporibus optio iusto laboriosam maiores cumque in.	59.79	\N	2018-03-13 05:21:41.356612+00	2	"1"=>"1"	f	t
439	Howard, Gray and Pearson	In veritatis ducimus maxime placeat tempora at asperiores. Vel cum animi magni nesciunt. Voluptates veritatis deserunt unde ad harum quo ex.\n\nIllo inventore repudiandae incidunt veniam autem vel animi. Omnis illum reprehenderit omnis deserunt quisquam quia. Nam assumenda asperiores neque facere. Dicta officia ratione officia molestiae et.\n\nEa dignissimos ratione autem molestiae odit. Illo sit maiores voluptatem illo ipsa molestiae explicabo non. Ipsa omnis delectus ipsa consequatur.\n\nDolorem voluptatibus sed perspiciatis autem accusamus. Possimus explicabo voluptas quaerat vero repudiandae. Eveniet quidem excepturi vitae quae esse nam praesentium.\n\nRepellendus nisi ex ratione deserunt explicabo laudantium. Odit aperiam minus quibusdam aperiam illo doloribus. Reiciendis voluptatem illum et rerum. Sint voluptatibus ad quisquam magni ex consectetur id qui.	54.96	\N	2018-03-13 05:21:41.408472+00	2	"1"=>"1"	f	t
440	Herman, Wilson and Lewis	Sunt aspernatur maiores accusantium unde hic esse possimus. Inventore delectus fuga nisi quasi. Sed pariatur et expedita incidunt. Voluptate ad similique vel.\n\nVeniam exercitationem repudiandae nostrum consequuntur veniam expedita aliquam tempora. Quibusdam velit magni ad. Totam quis cum natus hic aspernatur officia laboriosam pariatur.\n\nNecessitatibus itaque illo laborum officia qui. Doloremque amet quia cumque architecto necessitatibus sit. Ducimus a saepe ducimus libero omnis impedit voluptas. Ipsum est odit possimus facere ullam iusto.\n\nPerspiciatis fugiat soluta odio numquam sequi. Ducimus placeat sapiente animi fugiat voluptatum. Excepturi nobis laboriosam maiores neque veritatis laudantium molestiae.\n\nLaborum nemo quibusdam quisquam illum omnis maxime. Architecto vero placeat omnis nostrum ipsum totam rerum. Labore cum incidunt ut hic.	4.60	\N	2018-03-13 05:21:41.457638+00	2	"1"=>"1"	f	t
441	Quinn LLC	Neque placeat dolore error reprehenderit esse. Non recusandae laborum iste voluptate dolor a. Voluptas culpa molestias quos veritatis. Recusandae hic cumque eligendi aliquid velit adipisci ex.\n\nEveniet corrupti aliquid nostrum pariatur hic eveniet excepturi magni. Labore expedita aliquid vero molestiae. Unde tempora molestias optio quia voluptatum totam nesciunt.\n\nEst cumque veritatis labore eum. Natus rerum culpa cumque quasi corporis nulla. Quidem ipsa placeat ad minus cupiditate facilis.\n\nDucimus laudantium sit consectetur laboriosam beatae deserunt. Nisi illo dolor eum minus repellat expedita qui. Dolores et doloribus voluptas ex laboriosam culpa.\n\nDolores harum neque cumque ut. Quod necessitatibus tempore id. In voluptatibus rerum voluptas. Ex aliquid quis beatae maxime adipisci eaque eaque.	26.84	\N	2018-03-13 05:21:41.499969+00	3	"1"=>"1", "4"=>"8"	f	t
442	Hudson Ltd	Magnam inventore eum porro placeat. Maxime ab debitis commodi quaerat officiis odio. Iusto voluptatum inventore aliquam fugit corrupti a fuga inventore. Officia quod molestias animi inventore laborum natus.\n\nDeserunt nisi iure corporis ipsam numquam. Nobis tempore repellendus laboriosam dolorem totam nostrum. Dolorum minus similique quasi nesciunt ipsam necessitatibus enim. Quas earum dolores nihil iure laborum maiores sapiente.\n\nAspernatur ad dolorem aut suscipit aspernatur voluptatem ad maxime. Veniam assumenda excepturi velit sunt voluptate. Labore inventore illum itaque aut. Occaecati nulla quo voluptatibus nobis enim voluptatibus.\n\nAlias enim itaque pariatur officiis iusto reprehenderit facilis. Officia maiores quasi repellat dolorum. Enim cumque eos sit voluptate quod. Ex aspernatur harum deserunt officiis.\n\nPossimus nesciunt atque veniam cum eaque dolorem. Aut commodi qui ducimus alias pariatur quo at. Voluptate aspernatur illo incidunt ut unde dolorem occaecati.	45.59	\N	2018-03-13 05:21:41.576749+00	3	"1"=>"1", "4"=>"9"	f	t
443	Waller-Jones	Architecto dolores at debitis inventore veniam libero natus. Delectus doloremque aperiam omnis tenetur ut hic. Tenetur deserunt et tempore quia.\n\nFuga molestiae aspernatur aliquam iste. Dolorum laboriosam provident nobis atque illo atque. Minima ratione saepe non laboriosam quibusdam sunt. Repellendus facilis in assumenda illum nihil beatae.\n\nCupiditate consequatur beatae vel laborum totam consectetur. Est soluta soluta dolores repellat modi nulla eligendi. Similique at odio officiis vero impedit.\n\nNeque harum nobis vitae unde. Magni molestiae optio dolore iusto distinctio earum nobis. Animi id necessitatibus a veniam at deleniti voluptate. Itaque at dolore impedit molestiae vero pariatur.\n\nNulla labore numquam quas non odit cumque adipisci repudiandae. Magni cupiditate porro enim accusamus expedita laborum sed. Officiis tempora dolores ut saepe.	14.36	\N	2018-03-13 05:21:41.624155+00	3	"1"=>"1", "4"=>"8"	f	t
444	Frazier-Jennings	Minima ab voluptates natus quae aut. Aut omnis repellat eligendi quam recusandae ipsam. Cumque sed quia magni nam itaque aspernatur laudantium temporibus. Veritatis provident beatae voluptatibus.\n\nTempore quidem mollitia expedita libero. Explicabo accusantium omnis quaerat ipsam hic. Qui doloremque aliquid saepe sequi accusamus. Officiis beatae nostrum eum id doloremque officia officiis inventore.\n\nIpsa ad fugiat natus unde. Unde porro ducimus tempore praesentium sunt dolores consequuntur. Iure quia neque magnam deserunt officiis dolore laudantium.\n\nQuidem soluta delectus eveniet adipisci. Tempora sit perferendis voluptatum voluptas in rem omnis enim. Provident itaque vel vitae quidem possimus tenetur.\n\nPerferendis magni sint quasi praesentium magnam perferendis mollitia labore. Reprehenderit sapiente quasi accusantium neque dicta cupiditate. Voluptate eum officia expedita atque facere assumenda est. Nemo perferendis iure quo ipsa.	26.38	\N	2018-03-13 05:21:41.701048+00	3	"1"=>"1", "4"=>"9"	f	t
449	White, Reynolds and Fernandez	Harum quibusdam beatae error saepe nam ea. Velit quae iste quia accusantium velit officia fuga. Nesciunt nostrum ipsum quos vitae eum enim incidunt.\n\nAccusantium eius ipsum enim quae nemo. Dolorum harum inventore ad.\n\nRecusandae perspiciatis neque sunt perferendis accusamus cupiditate eum. Facilis debitis ipsa suscipit sed aliquid quaerat. Quasi delectus fuga autem voluptatibus necessitatibus nihil nisi repellendus. Quaerat labore in eligendi quod ipsum sapiente.\n\nAutem est est voluptate ipsum blanditiis incidunt accusantium. Autem molestiae asperiores eos dolorum nesciunt. Aperiam esse est doloribus nostrum tenetur dicta nobis ipsum. Sequi nemo dignissimos excepturi mollitia. Sapiente tempora commodi cupiditate dolorum nesciunt consequuntur.\n\nInventore atque voluptate consequuntur sunt expedita et. Quae dolorem rem ratione eius distinctio.	45.73	\N	2018-03-13 05:21:41.982727+00	3	"1"=>"1", "4"=>"8"	f	t
445	Dyer, Dunn and Allen	Dolore suscipit culpa omnis dicta a vero. Minus perspiciatis sint veniam similique accusantium maiores. Ratione facilis aspernatur tenetur aliquam vero consequuntur.\n\nEaque culpa ullam harum aspernatur cupiditate. Alias dolore earum distinctio mollitia modi consequuntur placeat harum. Neque corporis excepturi sint placeat ipsa nihil. Voluptatibus magnam praesentium maiores. Natus temporibus dolorem reprehenderit.\n\nMagnam fuga est dolore sequi temporibus amet. Occaecati dicta nisi id dolorem a eveniet. Officia animi ab iure odit harum aperiam possimus. Vel temporibus pariatur ea fugiat rem voluptatum voluptatum laudantium.\n\nDolorum excepturi dolorum sint at sapiente dolor. Nam corrupti repellat adipisci. Quod quis necessitatibus ab cum alias.\n\nAtque facilis dicta mollitia tenetur molestias sint vel. Sed molestias eligendi officia debitis. Error aut rerum eveniet laudantium similique voluptatem. Necessitatibus voluptatum quaerat voluptatem esse nam quam ipsum.	42.84	\N	2018-03-13 05:21:41.752024+00	3	"1"=>"1", "4"=>"8"	f	t
446	Jenkins, Horton and Kim	Dignissimos neque maiores saepe doloremque quisquam quis. Nulla repellat doloribus numquam odio quo sint. Quos laudantium quibusdam illo accusantium ab pariatur molestias.\n\nOptio praesentium architecto ducimus consequuntur. Esse animi veritatis enim laborum aliquid. Commodi quas eligendi sit. Quos voluptatibus doloremque labore laudantium id.\n\nTempore distinctio nemo aspernatur sequi quis. Ex ad magnam eligendi placeat. Mollitia sapiente fugiat impedit accusantium perspiciatis impedit impedit. Delectus tenetur omnis natus eligendi culpa labore occaecati.\n\nAsperiores aliquam repudiandae magnam porro fugit inventore. Enim dolor reprehenderit quae quas quidem nam. A temporibus a aliquam laboriosam possimus qui reprehenderit dolorum. Architecto nemo unde assumenda aspernatur.\n\nSaepe perspiciatis modi omnis commodi pariatur asperiores. Optio accusantium temporibus possimus delectus quos. Facilis quidem placeat ducimus quas harum earum. Ea est corrupti enim mollitia ipsum ipsum minus.	35.45	\N	2018-03-13 05:21:41.813235+00	3	"1"=>"1", "4"=>"8"	f	t
447	Suarez, Colon and Johnson	Sint quis optio unde ducimus. Voluptate enim autem quae quo reprehenderit. Placeat expedita accusantium quidem quisquam.\n\nLabore consequatur labore non enim beatae. Mollitia ex accusamus nulla consequuntur quam alias fugiat similique. Sapiente iusto voluptate velit qui laboriosam ipsum. Reprehenderit assumenda inventore itaque sequi aliquid quae.\n\nNemo vero eius error numquam doloribus in. Necessitatibus eius nobis earum molestias. Laboriosam alias asperiores officia fuga iste quisquam. Sit pariatur accusamus saepe incidunt velit autem.\n\nDolore voluptates vero praesentium accusantium incidunt eos. Minima esse ipsum asperiores at numquam numquam praesentium. Et et ullam quas dolores quis ab voluptatum. Beatae a consequuntur enim perferendis.\n\nAliquam praesentium nisi quam autem. Consequuntur ex sit ea nam praesentium soluta. Unde saepe repudiandae quos debitis laudantium. Dicta deleniti at odio magni repellat.	96.27	\N	2018-03-13 05:21:41.863661+00	3	"1"=>"1", "4"=>"8"	f	t
448	Jones-Martinez	Distinctio itaque cupiditate atque. Soluta assumenda deserunt reprehenderit dignissimos qui architecto.\n\nQuas excepturi saepe quos doloribus optio. Laudantium distinctio molestias fugiat adipisci accusantium ex dolorum. Atque nemo impedit neque nemo soluta magni iure.\n\nDoloremque itaque voluptatum totam at amet laudantium rerum. Laudantium aut asperiores iure corrupti tenetur est neque. Delectus itaque non voluptatibus officia distinctio facilis blanditiis. Animi dicta sequi dolorum tempora.\n\nEligendi nisi cum assumenda mollitia perferendis praesentium occaecati. Nobis delectus deserunt vero eius nesciunt. Quisquam nam alias cum quasi.\n\nModi eaque ea consequuntur dolores corrupti. Quae dolore modi repellat. Expedita saepe sunt assumenda consequuntur maxime eum libero. Nam nobis repudiandae sunt dolores repellendus earum. Nihil aut magnam a ratione dignissimos aliquam.	9.72	\N	2018-03-13 05:21:41.922967+00	3	"1"=>"1", "4"=>"9"	f	t
450	Johnson, Moore and Glenn	Consequatur porro itaque possimus eius est. Quod sapiente pariatur ipsum voluptate minima temporibus. Cum at asperiores nemo.\n\nVoluptatibus mollitia magni ipsum voluptatum. Laborum sunt suscipit esse ex atque dicta eius. Suscipit nihil ut minima aliquam velit.\n\nIpsam tempora deleniti nobis ad dolor quae voluptatum similique. Accusantium eos rerum necessitatibus libero molestias necessitatibus quia. Omnis numquam sit ab. Labore voluptate accusamus qui est quos sit quam. Dolorum illum dolores perspiciatis at iure.\n\nNemo quia iure esse vitae nam. Dolore eligendi eum aspernatur nostrum. Nihil nesciunt aspernatur vitae fuga praesentium.\n\nRepellendus aliquam ex possimus. Quibusdam modi exercitationem quae. Modi laboriosam consequuntur enim iusto. Ad aliquid assumenda illum necessitatibus assumenda est est.	82.67	\N	2018-03-13 05:21:42.067452+00	3	"1"=>"1", "4"=>"8"	f	t
451	Snyder, Fisher and Blankenship	Vitae qui consequuntur suscipit ea a. Tempora labore ipsa cumque exercitationem a aut incidunt tempora. Consequatur excepturi est rem adipisci voluptate eius.\n\nFacere laboriosam consequuntur mollitia. Recusandae repudiandae minus commodi unde. Qui ut nemo blanditiis laboriosam nulla incidunt autem quod. Voluptates suscipit aperiam ipsam architecto quibusdam sapiente.\n\nVitae maxime fugiat ad autem libero. Corporis possimus impedit mollitia id. Quas fugiat deserunt quae est.\n\nExercitationem provident porro ab rem eos. Consequuntur earum in distinctio distinctio. Ipsam consequatur doloribus velit consequuntur at.\n\nAperiam deleniti eum hic minima similique. Accusamus temporibus quas facilis quaerat asperiores quasi maiores. Repudiandae maiores aspernatur veniam iste quas. Esse voluptates nemo vitae.	30.44	\N	2018-03-13 05:21:42.137272+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
452	Perez, Hansen and Hughes	Occaecati iste quibusdam quae qui. Cumque maiores voluptas itaque cupiditate dolores distinctio. Eaque numquam pariatur vero sit ut optio labore.\n\nError distinctio accusantium et qui debitis illo molestias. Repellendus harum enim ratione esse minus ea minus nihil. Hic officiis impedit consequatur necessitatibus explicabo maxime. Consectetur repudiandae vel fugiat commodi cupiditate delectus aperiam.\n\nDeleniti minima ut nostrum doloribus corrupti. Cumque officiis expedita commodi.\n\nTempora consequuntur quia qui dolore saepe. Dolorum illo eius reiciendis. Temporibus veritatis esse soluta assumenda facilis cupiditate praesentium.\n\nSimilique placeat ullam ad aliquid dolorum consectetur voluptatum. Eligendi at soluta reiciendis tempore. Illo architecto modi ipsum at hic at cum.	26.85	\N	2018-03-13 05:21:42.211628+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
453	Hill Group	Autem modi enim non tempore doloribus soluta. Aspernatur earum fugit quo corrupti quae.\n\nMagnam dolor est ex a. Incidunt ducimus quod aliquam libero placeat. Itaque nobis totam perspiciatis quis amet quia minima.\n\nPariatur doloribus culpa consequatur quaerat qui dignissimos tempora nulla. Cupiditate porro similique nam distinctio.\n\nAccusamus consequuntur facere perspiciatis. Non suscipit consequuntur labore incidunt iste repellat. Impedit iure sapiente ratione possimus nemo dicta. Hic molestiae alias ipsa temporibus voluptate deserunt aliquam. Aperiam minima magni dolore rerum dolor eveniet nemo.\n\nVel assumenda suscipit magnam fugit sequi hic dolores. Nulla molestiae possimus officiis.	88.46	\N	2018-03-13 05:21:42.282137+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
454	Alexander, Smith and Morrison	Quasi error hic quasi voluptates quisquam soluta voluptatibus. Possimus saepe sequi voluptatum aliquid. Ducimus mollitia dolore eaque sapiente ad.\n\nAd amet temporibus ratione repellendus qui nobis. Aperiam iure dolore assumenda tenetur quas est inventore.\n\nIn eligendi sit deserunt deleniti. Iure quam quas temporibus ut aliquid quo quis. Voluptates omnis doloremque magnam dolorem voluptatem.\n\nAliquid autem minus minima quia ut. Nemo temporibus dolorum ad ipsa harum. Molestias sequi vitae quaerat architecto ipsam modi eaque. Quibusdam sunt cumque voluptatibus voluptates rem cupiditate. Tempora quia natus similique eos accusantium laboriosam.\n\nPariatur similique autem repellat magnam temporibus blanditiis. Laborum natus iste beatae dicta saepe est.	69.83	\N	2018-03-13 05:21:42.367507+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
455	Kane, Cooper and Oconnell	Molestias quam totam error quos asperiores eius. Accusantium aut deleniti tempora repellat exercitationem voluptatum. Ad qui voluptatem labore consectetur. Vel non adipisci commodi vero laudantium.\n\nRerum natus occaecati officia et modi. Saepe animi quaerat tenetur laboriosam officiis veritatis.\n\nLaborum libero tenetur accusantium quasi. Dolorum id eos amet reiciendis facere odit. Non facere debitis quos porro. Quas sit architecto cupiditate voluptates quas eos aut sunt.\n\nVeritatis consequuntur ullam assumenda nobis fuga explicabo. Velit illo temporibus nesciunt architecto soluta ipsa adipisci eum. Aut porro necessitatibus rerum nam distinctio aspernatur dolorem sequi. Non repudiandae magni atque suscipit atque itaque aperiam.\n\nDicta cum ullam suscipit ratione. Rerum inventore ut cumque nihil magni totam porro. Distinctio dolore error nam quam reiciendis adipisci officiis. Ipsum omnis cum ut illo fuga.	97.52	\N	2018-03-13 05:21:42.426724+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
456	Logan-Kline	Accusantium adipisci tenetur sapiente dolor mollitia. Enim illo repellat cum eius est adipisci.\n\nNatus dicta ad voluptatem modi natus labore. Possimus perferendis facere quod ut tenetur nemo quas. Accusamus optio expedita molestiae expedita velit voluptas voluptatum.\n\nSuscipit impedit aliquam molestias officiis. Alias officia repudiandae qui eos saepe voluptas. Totam molestias voluptate sit accusamus error asperiores harum. Sed nulla nulla eveniet eligendi.\n\nAd maiores asperiores nesciunt minima accusamus rerum praesentium harum. Repellat esse ex sed nobis qui ad quis. Commodi esse dolor expedita rerum ab. Saepe quaerat provident corporis modi sequi.\n\nSapiente inventore natus quasi expedita officia laborum deleniti perferendis. Ullam ex consectetur voluptas voluptatem magni sed tempora. Vitae nesciunt saepe ullam quod corporis mollitia.	11.47	\N	2018-03-13 05:21:42.494277+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
457	Richards-Riley	Iure voluptatibus enim quod voluptates accusantium. Adipisci veniam molestiae natus reprehenderit doloremque. Modi in vel similique quidem deleniti veniam omnis voluptatem. Ipsa quos occaecati temporibus rem minima ab voluptatibus.\n\nNam voluptas adipisci id ducimus ea iusto quisquam. Eveniet voluptatum distinctio ut deleniti cumque reiciendis itaque. Velit repellat vero cupiditate vero eligendi quia fugiat. Maxime et odit explicabo sequi libero reprehenderit.\n\nQuas corrupti modi asperiores nostrum quibusdam et nulla. Pariatur laboriosam quibusdam itaque ad. Laborum hic dolore quisquam nisi. Pariatur corporis excepturi omnis velit adipisci dolor ab tenetur.\n\nEaque accusamus possimus perferendis rerum saepe necessitatibus. Ex earum a distinctio ipsam similique odio repellat. Voluptate sint corrupti illum reiciendis.\n\nIllum dolores ad maiores laudantium eligendi. Libero ab itaque sequi. Provident earum explicabo repellendus ab vero suscipit placeat. Ratione praesentium esse ratione nulla.	15.60	\N	2018-03-13 05:21:42.567006+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
458	Clark LLC	Aspernatur culpa quae deleniti temporibus eos fugit. Placeat porro eos dolore eaque. Sapiente ipsam dolorum dicta perspiciatis nobis quo necessitatibus. Consequatur architecto commodi doloribus. Qui animi numquam vel quaerat at vitae error.\n\nEius tenetur illum minus dolor. Illum illum blanditiis culpa architecto error. Odit quod quisquam minima. Ratione tenetur facilis qui alias expedita ut.\n\nDolor consequatur excepturi dicta exercitationem. Omnis consequatur saepe tempore deleniti. Nemo earum provident occaecati vero earum reprehenderit dolores quam. Placeat eligendi voluptate corrupti et.\n\nSint quisquam voluptatibus sunt quo tenetur aperiam. Itaque cumque dolorem distinctio quaerat. Aut voluptates sit dolore culpa dolorem in alias. Praesentium quis autem ratione officia.\n\nMagnam veniam facere dicta laudantium repellat doloribus doloribus. Velit eaque repudiandae id corrupti ipsum voluptates. Earum tenetur non similique occaecati rerum. Odio iste a accusantium quo ipsa perspiciatis tempore.	47.84	\N	2018-03-13 05:21:42.641126+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
459	Holloway-Kelly	Temporibus corrupti totam id facere. Eveniet nobis ab hic accusamus. Odit nulla quidem dignissimos quibusdam.\n\nExcepturi cumque inventore eveniet quibusdam mollitia esse. Accusantium neque quaerat explicabo deserunt ipsam a fugiat dicta. Quibusdam ullam ab natus consectetur quas quae.\n\nItaque eaque possimus amet quaerat eius quas odit. Praesentium amet molestias vitae.\n\nIusto quis distinctio dolore necessitatibus corrupti. Quae reprehenderit cumque sint eos cum aut aspernatur. Rerum velit harum sunt sint aliquam neque aliquid. Unde delectus iusto eaque tenetur itaque cum. Dolores iusto vel blanditiis sed sequi.\n\nInventore corrupti vel quaerat pariatur corrupti earum ipsa nisi. Atque quibusdam incidunt sunt id amet modi repellendus.	70.14	\N	2018-03-13 05:21:42.714256+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
460	Berger PLC	Reiciendis exercitationem vero aliquam aliquid blanditiis. Neque in recusandae vitae dolor porro delectus. Nihil nobis enim explicabo reiciendis error odio.\n\nCulpa architecto ducimus necessitatibus sapiente eos commodi dolore. Sint officia sint odit sit. Reprehenderit cum provident perferendis. Minima laudantium in laudantium repellat quibusdam quod ea.\n\nItaque quasi vel iste ipsum placeat amet ducimus. Dignissimos accusantium eos earum magnam.\n\nPraesentium nisi aspernatur exercitationem itaque. Officia fuga autem minus numquam reiciendis similique voluptates. Est minima velit facere fugiat quae qui. Dolor quaerat sed voluptas soluta.\n\nNemo rerum delectus officiis distinctio voluptate ducimus. Voluptas omnis iste minus. Sapiente aperiam neque laudantium dicta unde.	32.52	\N	2018-03-13 05:21:42.778266+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
461	Ayers, Williams and Rivas	Perferendis necessitatibus dolores odio dolor molestiae cumque. Accusamus quaerat dolor aliquam numquam blanditiis nihil. Molestias recusandae soluta quo itaque earum. Sit aliquid quia animi fugiat iure tempore dolorum.\n\nNulla nulla explicabo quam eligendi. Autem sint quo minus deleniti reiciendis quidem tempora iusto. Nemo quas voluptas non ipsa cum voluptas. Assumenda ipsa veritatis exercitationem veniam cumque cum sequi.\n\nLaboriosam odit aut a beatae. Ullam totam odio dolore quo. Eos optio sint asperiores voluptate. Consequuntur repellendus velit assumenda consectetur.\n\nVoluptate molestias porro sed dicta. Iure alias reiciendis nisi fugiat dicta. Dolorum non quae fugiat deserunt cum beatae in. Eveniet velit iure perferendis accusamus corrupti debitis error.\n\nEaque beatae exercitationem vero officia vero deleniti. Animi aspernatur architecto libero ratione ullam consectetur ad. Quas fugit autem incidunt.	31.87	\N	2018-03-13 05:21:42.849223+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
469	Mcgee-Reese	Corporis numquam voluptatum dolorum consequatur id consequuntur. Ut laudantium in sunt porro minima. Quaerat deserunt similique quis omnis nemo provident quo. Consequuntur repellat praesentium sunt voluptate labore nostrum nisi.\n\nNulla explicabo dolore libero placeat sint temporibus error nihil. Dolorem dignissimos soluta similique quas cum nisi corporis alias. Nisi possimus nobis corporis voluptatibus vel.\n\nVeniam labore in labore quos dicta nemo. Fugit sequi sint aliquam autem dignissimos. Sit totam quod corporis aut quod earum voluptatibus. Numquam nemo facere sed autem voluptates exercitationem.\n\nNisi dicta alias magni. Aperiam velit harum iure ratione cum totam vel eligendi. Est esse assumenda voluptatum pariatur. Cum iste debitis corporis quas.\n\nVoluptatibus harum est provident rem quod. Modi excepturi culpa eos esse. Qui molestias mollitia quo saepe.	81.96	\N	2018-03-13 05:21:43.287025+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
462	Wyatt, Alexander and Donovan	Pariatur quas fugiat laudantium. Tempore natus ab eveniet unde illo hic doloremque cumque. Temporibus vel minima repudiandae ullam ipsum nisi incidunt. Ratione aspernatur quaerat cum atque. Iste aliquid incidunt nisi recusandae explicabo necessitatibus blanditiis sequi.\n\nVitae cum cumque possimus. Sapiente molestias reprehenderit nobis quidem sunt. Assumenda neque distinctio corrupti rerum nam sint optio. Expedita laboriosam amet odit voluptatum.\n\nOmnis saepe ea reiciendis et praesentium odio. Recusandae quos cupiditate cum ducimus expedita illo. Deserunt fugiat id praesentium deserunt.\n\nSint beatae dicta nemo voluptatem. Velit deleniti voluptate ipsa laborum debitis nulla quod. Ipsa soluta fugiat totam voluptate.\n\nMinima quas neque deserunt enim distinctio. Veritatis debitis corporis quod assumenda molestiae assumenda odio ex. Nisi necessitatibus ipsam totam maiores suscipit. Rerum placeat praesentium error.	89.48	\N	2018-03-13 05:21:42.912456+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
463	Pollard PLC	Adipisci laudantium quia voluptates officia magnam dolorem. Porro voluptates nesciunt id fuga magnam cum. Rem totam provident perferendis totam.\n\nEt asperiores reprehenderit suscipit. Eos sed suscipit consequuntur totam tempora. Aut facilis blanditiis sunt nihil. Distinctio explicabo aliquid laboriosam ut ipsa tempora dolorum.\n\nCorrupti tempore at adipisci dicta cumque repellat vel. Distinctio tempora ipsa ipsa accusamus natus. Minus eaque ratione quae laudantium vero. Soluta placeat iste natus quibusdam quam doloribus.\n\nAccusamus accusantium incidunt ducimus ut magnam assumenda. Nisi omnis nam eaque ullam consequuntur. Odio possimus nihil nemo illum porro modi. Quos voluptas laboriosam commodi tenetur molestias.\n\nQuae repellendus autem in corporis aut. Repellendus similique voluptatibus atque asperiores enim. Sequi vero atque ex illo debitis. Animi dolorem perferendis vero laudantium unde tempore cumque.	7.00	\N	2018-03-13 05:21:42.972361+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
464	Arroyo Inc	Doloribus pariatur id quia. Est asperiores at sapiente esse dolorum cum. Possimus facilis dolore vel aliquam nemo.\n\nNostrum dicta maiores consequatur. Maiores fugit sed ullam soluta neque impedit. Sit quae molestiae tempore porro quam. Reprehenderit modi libero inventore.\n\nMagnam sapiente laudantium cupiditate ipsam optio ab beatae adipisci. Cumque sed minima eligendi porro nesciunt beatae aliquam. Quo atque veniam necessitatibus necessitatibus quos deleniti.\n\nAtque at ratione dignissimos nam sed. Exercitationem minima culpa velit inventore expedita officiis voluptate.\n\nNumquam fugit voluptatibus ipsam nisi fugiat similique. Esse expedita harum harum aliquam assumenda. Similique ipsa explicabo provident non nisi earum cum accusantium. Adipisci nulla et nobis temporibus quidem.	37.32	\N	2018-03-13 05:21:43.011011+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
465	Wells PLC	Tempore vel tempora nobis assumenda. Reiciendis nam accusantium voluptas est ducimus dolorum corporis. Deleniti repellendus assumenda porro corrupti nostrum officia. Ipsam quod ad odit vel. Quaerat earum id ea.\n\nSed aliquid rerum aspernatur nihil minus aperiam repudiandae temporibus. Ea autem ipsam quaerat. Repudiandae consequuntur quidem deserunt repudiandae. Exercitationem assumenda sint voluptate nemo quidem illum beatae molestias.\n\nError architecto aperiam temporibus officia sed dolorem. Explicabo aliquam aliquam harum tenetur culpa. Unde dolorum quod cumque quae.\n\nOfficiis excepturi rem tempore pariatur vel reiciendis sapiente. Nesciunt deserunt doloribus iste facilis ipsa ratione. Unde nemo quod occaecati numquam unde velit. Error repellendus vero fugit ullam velit.\n\nOfficiis quasi totam quam vitae occaecati. Nemo alias error eius accusamus laudantium asperiores cumque. Praesentium inventore mollitia quasi inventore excepturi.	13.67	\N	2018-03-13 05:21:43.054222+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
466	Conway-Evans	Enim blanditiis animi ut sequi deleniti natus. Amet praesentium molestias rem. Repellendus labore quae sint dolorem suscipit. Reiciendis quod quaerat nostrum quam.\n\nMinima natus debitis accusantium. Reiciendis libero soluta animi suscipit.\n\nRem eligendi sequi similique culpa illo earum. Nihil omnis ratione perspiciatis distinctio molestiae ea. Rerum consequuntur similique fugit recusandae. Placeat expedita dolore fuga.\n\nMollitia porro voluptate porro perspiciatis voluptate officia doloremque. Tenetur praesentium aspernatur architecto aperiam excepturi laboriosam assumenda suscipit. Molestias sint possimus quis veniam labore quisquam.\n\nCommodi veniam similique nostrum enim quos. Quo asperiores magni blanditiis.	59.89	\N	2018-03-13 05:21:43.111245+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
467	Richards, Dennis and Davis	Quasi fuga consequuntur amet accusamus. Eius dolorum adipisci occaecati.\n\nIpsum distinctio assumenda veniam quibusdam nihil. Neque eveniet accusantium velit reprehenderit unde culpa. Natus porro laboriosam a non. Ipsam id error aspernatur autem quae ipsam. Tenetur doloremque sed optio laudantium ipsum ipsa delectus perspiciatis.\n\nEsse earum quo odio eveniet cumque. Accusantium dicta harum distinctio sequi sunt laudantium praesentium. Soluta omnis eveniet vero dolor.\n\nOptio voluptatem velit quo fugiat amet. Ullam quisquam voluptate illum magnam natus eaque. Saepe reprehenderit ex saepe nisi.\n\nReiciendis nisi ratione fugit excepturi. Incidunt distinctio adipisci a velit reprehenderit. Corporis dolor veniam culpa quam assumenda.	84.42	\N	2018-03-13 05:21:43.173565+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
468	Gay PLC	Dolorum necessitatibus fugiat repudiandae eveniet delectus velit a. Pariatur minima ipsam iusto corporis facilis impedit culpa. Labore doloremque sit fugit quisquam. Magni accusamus accusamus laborum sunt.\n\nNon exercitationem quasi impedit necessitatibus vel neque. Possimus inventore nostrum odit laboriosam optio laborum illo. Dolorum placeat aliquam dolorum porro blanditiis ipsa laudantium repellendus.\n\nEt praesentium quidem eaque aspernatur temporibus. Ipsam corporis quos recusandae quidem. Nemo sed quos aperiam dolorem explicabo quidem eaque.\n\nSimilique exercitationem alias fugit alias tempore. Dolores laboriosam ea facere minus. Eaque odio omnis beatae nulla iusto qui adipisci consequatur.\n\nNatus necessitatibus voluptatibus amet voluptate voluptates. Doloribus aliquam eum dolores vero nihil perferendis deserunt aspernatur. Quos rerum incidunt labore dolore voluptate.	47.25	\N	2018-03-13 05:21:43.210906+00	5	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
470	Gomez, Lee and Stevens	Quo similique necessitatibus tempore officia excepturi. Minus at magnam consequuntur odit. Labore nostrum sit minus repellat et. Commodi dolorum enim itaque corrupti exercitationem aspernatur consequuntur.\n\nEx rem voluptatibus inventore reprehenderit autem voluptatibus. Occaecati officiis laudantium ut consequuntur sapiente cumque ad. Eaque fugit placeat ab commodi maiores officia. Debitis eos rerum architecto sunt nulla. Facilis reprehenderit eos fuga assumenda distinctio vero omnis.\n\nCommodi incidunt velit officia voluptatem. Provident voluptas illum nam eum distinctio sed. Officiis suscipit impedit aliquam a. Expedita similique qui magnam optio quo ab voluptatem iusto. Repudiandae nesciunt distinctio illo vel odio quasi impedit quae.\n\nNisi doloremque exercitationem eum nostrum labore hic eligendi. Voluptatum culpa maxime aliquid nisi nostrum. Magni eveniet vero sint necessitatibus fugit non totam ad. Delectus inventore sunt laudantium consequatur cumque ipsa.\n\nUllam temporibus pariatur aspernatur nulla expedita distinctio sint reprehenderit. Dolore nam sequi occaecati sequi molestiae soluta. Impedit ullam magni dolore odio commodi tenetur. Dolores aperiam omnis delectus rem debitis a cumque totam.	95.66	\N	2018-03-13 05:21:43.355637+00	5	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
471	Jones-Smith	Aliquam exercitationem minus quisquam eveniet. Odit hic alias laborum debitis qui a. Nobis doloremque esse veniam ut porro officia. Commodi maiores autem eius ratione facere.\n\nError nulla pariatur occaecati accusantium. Officiis magni minima ad in vitae ut neque. Fugit incidunt amet quis rem doloremque pariatur error.\n\nAtque adipisci non maiores esse fuga. Cupiditate inventore nesciunt nisi rem molestias quidem. Eos quasi quibusdam rem consectetur.\n\nNeque ipsa culpa facilis quia quaerat quod. Dignissimos quidem asperiores quidem sequi. Ratione nam nesciunt enim sapiente non sit. Exercitationem officiis commodi amet aperiam fugiat.\n\nDoloremque tempore perferendis placeat et voluptatibus. Aliquam voluptatem ipsum excepturi incidunt quaerat.	72.37	\N	2018-03-13 05:21:43.416892+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
472	Thornton, Thomas and Haley	A ea labore fugit earum atque similique quo. Repudiandae quo possimus incidunt harum expedita consequuntur laudantium. Nemo laboriosam nihil consequuntur recusandae velit sapiente dolorem.\n\nNulla omnis quas aliquid corporis. Voluptatum laboriosam quaerat eius praesentium dolor repellendus necessitatibus. Totam accusantium dicta distinctio quaerat deleniti. Vero nulla provident sed reprehenderit adipisci ea rerum vitae.\n\nDolorem deleniti a tempora omnis mollitia facere. Incidunt unde nam animi. Ducimus impedit atque incidunt at quas. Culpa mollitia quo architecto optio.\n\nVoluptate dolorum laudantium a aut cupiditate maxime. Sapiente eveniet nostrum nesciunt velit quam deserunt odit. Repellendus rerum voluptatum est corporis exercitationem rem facilis maxime. Explicabo dolorum quibusdam quos facere.\n\nTenetur aperiam architecto vitae molestias officiis accusamus nemo. Facilis quasi quaerat odio eligendi pariatur. Impedit vel veniam saepe eveniet iure rerum. Iste vero soluta eaque dignissimos perferendis.	60.98	\N	2018-03-13 05:21:43.47097+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
473	Page-Henderson	Natus hic in tenetur error ipsam nulla. Distinctio ea veritatis in perspiciatis cupiditate rerum reiciendis. Dolorum reprehenderit nisi dolores quae.\n\nItaque inventore deserunt est deleniti. Perferendis quasi eveniet culpa dolores quidem ipsam mollitia asperiores. Fuga officia dolorem error. Illo voluptatibus pariatur maxime quis. Iste corrupti voluptatibus excepturi ad error quisquam cupiditate.\n\nIure voluptate laudantium natus facilis unde ex perspiciatis rerum. Quod atque repellat quasi accusantium cum expedita ducimus. Quis blanditiis nam alias quod illum atque. Excepturi corrupti ab voluptas error recusandae dolorem.\n\nSed expedita voluptatem temporibus cum. In iste sed alias vitae quia. Soluta et voluptate eos ipsum. Veritatis eos possimus doloribus.\n\nAliquam quod reiciendis similique quod. Quis magnam tempora numquam dolorem similique id nihil. Hic ut eius quod provident repellendus. Est inventore enim omnis aut voluptatem earum consequatur.	56.55	\N	2018-03-13 05:21:43.505639+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
474	Torres Group	Eum dolore explicabo quis facilis accusantium itaque. Vel rerum architecto magni facere. Asperiores veritatis accusantium quibusdam.\n\nExercitationem velit atque dicta atque nulla enim eos. Error adipisci eveniet quos atque ex neque assumenda vel. Dolorem dignissimos error rem.\n\nQui earum velit eos repellat iusto consequatur ipsam. Magni voluptatum voluptas placeat odit assumenda. Magni iste inventore nemo placeat molestiae officiis asperiores.\n\nExercitationem atque dolorem vero quidem ea eveniet. Saepe ipsum aliquid facilis. Nam sunt incidunt iure repellendus blanditiis amet occaecati. Excepturi voluptate ex ipsam.\n\nLaborum quis ullam et officiis quis doloribus. Recusandae rem error fugit doloremque doloremque. Deserunt repudiandae voluptates dicta. Atque earum distinctio quaerat ipsum pariatur.	86.57	\N	2018-03-13 05:21:43.534226+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
499	Brown, Fowler and Reed	Assumenda voluptatum repellendus dolore saepe expedita pariatur iure. Quae omnis ut officia. Doloribus quam nostrum tempora iure doloremque aliquid mollitia repudiandae. Blanditiis vitae deleniti consequuntur sit asperiores autem corrupti corporis.\n\nOfficiis aspernatur inventore esse corporis officia alias. Necessitatibus dolor necessitatibus culpa sit officiis nostrum.\n\nNulla ex minima in qui. Sequi sapiente earum nisi ab sapiente. Voluptatem quo iusto vero doloremque perspiciatis nobis.\n\nNecessitatibus nam nulla a saepe quis doloremque. Corporis sequi labore dolorem itaque earum molestiae a. Dolorem corrupti voluptates odit dolore ex impedit blanditiis. Suscipit blanditiis debitis blanditiis quas.\n\nIpsum consectetur sunt fuga ullam consectetur quam. Est soluta et voluptatum.	88.89	\N	2018-03-13 05:22:16.373673+00	2	"1"=>"1"	f	t
475	Ritter, Davis and Vazquez	Odio laboriosam pariatur perferendis maiores. Eligendi perspiciatis nisi at. Praesentium quis distinctio reprehenderit ullam vel eius nostrum fuga. Ad cupiditate vitae saepe temporibus repudiandae ipsa. Minus dignissimos quo dolores saepe alias.\n\nIncidunt libero delectus illum earum adipisci recusandae. Facere minima hic quod enim quasi voluptatum sunt asperiores. Eligendi labore quasi ab vitae. Sunt ea provident totam cupiditate similique consequuntur.\n\nQuos id delectus eligendi nostrum et. Corporis officia laborum assumenda voluptate deleniti non repudiandae. Cupiditate quae tempora qui cum. Reiciendis id error nisi voluptate molestiae aperiam ea deleniti.\n\nSed ut nihil placeat corporis. Cupiditate temporibus excepturi saepe natus non officia.\n\nEaque explicabo nesciunt aperiam saepe. Non labore possimus ex odio doloremque excepturi.	77.10	\N	2018-03-13 05:21:43.582076+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
476	Farmer, Madden and Douglas	Exercitationem molestias maxime a quas. Earum ut dolorum dolorum vel doloremque inventore. Error pariatur doloribus eligendi consectetur.\n\nIpsam magni in libero reprehenderit quasi. Explicabo delectus facilis voluptas suscipit ab ullam suscipit. Velit vel incidunt inventore dolore autem praesentium. In corporis ut eum dicta fugiat laudantium.\n\nVeritatis rem ipsam excepturi. Omnis maxime fugit exercitationem porro cupiditate officiis dolore. Nam dolores et cupiditate quas.\n\nHarum qui delectus et fugit placeat quidem. Culpa nostrum repudiandae aliquid culpa iure quod amet expedita. Magnam labore maxime aliquam consectetur nisi ipsam laboriosam.\n\nId mollitia doloribus sint aliquid necessitatibus. Aperiam perferendis modi ipsum. Atque placeat explicabo architecto dolorem voluptate perferendis.	25.26	\N	2018-03-13 05:21:43.636756+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
477	Morris, Peterson and Stewart	Maxime saepe blanditiis molestias. Quo nam cum aspernatur amet tempore nemo nam ad. Facilis iusto quo maxime nihil molestiae. Totam ad sequi architecto quae ullam rerum tempora.\n\nPariatur quisquam modi deserunt saepe recusandae voluptas. Asperiores expedita non tenetur nam omnis. Ducimus voluptatum adipisci dignissimos deleniti quos odio esse.\n\nQuaerat temporibus veniam nostrum assumenda modi dignissimos. Nulla eos exercitationem tempore sit dolorem libero corporis. Suscipit beatae saepe quam aliquam dolores soluta numquam laborum. Veritatis dolores odit ab dolorem occaecati.\n\nFugiat error corporis ut iste dignissimos officiis. Soluta corrupti recusandae accusantium nostrum quidem sequi nisi. Debitis voluptatem dolorum suscipit aut illo earum voluptas. Dicta dolor occaecati cum exercitationem. Et quibusdam quasi sit.\n\nQuis ad rerum numquam incidunt illo cum animi. Sed ad recusandae laborum voluptates. Vero repudiandae mollitia veniam ab rem. Ducimus facere fuga aspernatur aspernatur quae.	4.82	\N	2018-03-13 05:21:43.70038+00	6	"9"=>"25", "10"=>"27", "11"=>"28"	f	t
478	Butler LLC	A doloribus tempora quaerat quo. Repudiandae quas corrupti inventore. Pariatur iusto eum quod at. Placeat magnam doloremque reprehenderit perferendis amet dolore assumenda. Omnis laborum inventore architecto repellat nam.\n\nMagni cupiditate consequuntur cupiditate odit ipsum molestiae ipsam. Animi illum voluptate consequatur itaque provident quos occaecati. Provident sit tempore animi illo possimus.\n\nQuae deleniti quam fugiat deserunt vero possimus. Deleniti at pariatur esse ipsum. Neque ut vel rem officia beatae. Veritatis quod excepturi ad maxime eos accusamus nisi.\n\nRecusandae debitis eligendi facilis sequi optio occaecati deleniti. Labore aut architecto fugiat asperiores distinctio.\n\nQuisquam laudantium eveniet a blanditiis. Perferendis consequatur accusantium sit labore necessitatibus. Deserunt earum ipsam autem possimus sit quos odit. Mollitia quod eos magnam.	59.46	\N	2018-03-13 05:21:43.733212+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
479	Beard-Stewart	Repudiandae pariatur soluta ad. Magni mollitia tempore doloribus recusandae assumenda iure maxime. Laboriosam reiciendis mollitia nemo dolorem reprehenderit.\n\nExcepturi similique at quaerat eligendi veniam eos sequi praesentium. Quo commodi harum nesciunt expedita sequi tenetur. Distinctio minima dolor tenetur nostrum.\n\nUnde accusamus maiores sint corrupti sequi odio. Iusto autem iste autem facere eligendi. Distinctio similique quaerat saepe. Dolorum nobis ipsam sequi ipsam ea.\n\nEsse maiores molestias porro sit nemo mollitia nisi. Atque rerum adipisci nulla nisi quam recusandae hic. Quia provident modi ipsum facere unde animi in.\n\nQuibusdam doloribus ut architecto architecto. Corrupti in officia dolorem quaerat nulla.	14.69	\N	2018-03-13 05:21:43.788799+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
480	Mcdonald, Clarke and Gordon	Ipsa tempora itaque repellat maxime laborum incidunt adipisci. Quod quas consectetur ducimus explicabo. Explicabo officia officia cumque odio dolorum ea fugit. Recusandae culpa neque ut dolorum cumque veritatis at.\n\nAb numquam aliquid doloribus nam ipsum dolor. Eaque fugit modi facere doloremque nostrum nihil sint. Tenetur assumenda ipsa numquam sint esse deleniti. Vitae unde illo iure necessitatibus perferendis amet.\n\nIllum magni totam asperiores. Numquam animi tenetur odio reprehenderit. Labore in reprehenderit laudantium corporis eius sit.\n\nModi quas optio aut ab asperiores esse. Fuga repudiandae aspernatur animi. Labore aliquam debitis assumenda quidem natus.\n\nDignissimos earum sunt vel dolor fuga recusandae deserunt. Placeat molestias repellendus doloremque quae voluptatibus. Et aliquam ducimus voluptas ratione at.	25.81	\N	2018-03-13 05:21:43.839176+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
481	Evans-Rodriguez	Dolorem quam quos ipsam exercitationem provident cupiditate veniam nobis. Aliquam voluptatem nisi consequatur nostrum quaerat. Dolor dolor accusamus temporibus consequatur nobis. Dicta facere veritatis sed consequatur voluptatum eveniet labore.\n\nMaxime velit id unde recusandae occaecati quos maxime explicabo. Animi ratione ab laudantium incidunt eos iusto adipisci. Unde libero praesentium sit exercitationem. Reiciendis numquam nisi quibusdam cum quos magnam.\n\nNemo beatae consequuntur eius iusto consequatur. Ullam repellat consequuntur provident ab. Ad provident at voluptates amet.\n\nDolores impedit mollitia voluptas molestiae perspiciatis fuga. Ea numquam delectus veritatis veritatis quis nemo. Modi perferendis aliquam quia sit atque quibusdam illum. Doloribus atque vero impedit accusantium.\n\nInventore officiis maiores optio veniam ipsam nostrum. Quod placeat sint ea. Ipsam vero ratione sed. Numquam officia recusandae rerum officiis.	90.66	\N	2018-03-13 05:22:15.263875+00	1	"1"=>"1", "2"=>"2"	f	t
482	Robinson-Wiggins	Similique labore repudiandae temporibus facilis doloremque. Earum placeat nihil delectus perspiciatis vitae facilis itaque. Atque consequatur architecto itaque nobis perspiciatis voluptate ex. Voluptas quo fugit praesentium suscipit numquam suscipit id.\n\nQuidem odit nisi hic cum nihil. At iste culpa exercitationem recusandae sed illum. Optio minus soluta consequuntur quod.\n\nAnimi laborum aliquid at alias deserunt iusto eligendi. Quos porro impedit cum perferendis eligendi. Voluptatum hic commodi rerum quidem. Reiciendis laboriosam reprehenderit architecto beatae natus error.\n\nDeleniti amet iusto at suscipit autem a. Iure soluta aliquid asperiores velit saepe impedit veritatis. Aliquam quam ea quisquam. Laborum dolores rerum in provident maxime iure.\n\nVitae vero dolorum perspiciatis ducimus illo. Repellendus maiores assumenda iusto.	6.10	\N	2018-03-13 05:22:15.332853+00	1	"1"=>"1", "2"=>"3"	f	t
483	Snow-Cummings	Asperiores adipisci iste sint asperiores laboriosam. Accusamus molestias quis fuga sit harum vitae. Nobis architecto doloribus magni libero sed.\n\nDeserunt minima eveniet eaque iusto iste. Aut sapiente labore vitae aliquam. Inventore temporibus inventore accusamus eius placeat. Labore atque autem atque sequi quia.\n\nIpsa tempore modi necessitatibus vitae optio quaerat occaecati. Ab eveniet laborum esse nostrum neque aspernatur neque. Architecto molestias nostrum harum dolorem at dolorum. Qui similique sequi occaecati quae eum amet quam.\n\nPerspiciatis asperiores officiis quibusdam voluptatibus corrupti nisi perspiciatis aperiam. Soluta tempore rerum rem commodi quia. Recusandae impedit quasi dicta dignissimos at et dolore. Veritatis rerum voluptatibus non facere. Reiciendis placeat aliquam provident hic.\n\nRepellendus aut necessitatibus maiores et porro ipsum ipsam. Molestiae nisi eveniet totam officiis. Enim quis esse nihil fugiat dolorum. Aliquid sit quis quaerat vero odit et sequi aliquid. Corrupti consequatur sapiente nihil exercitationem unde.	33.86	\N	2018-03-13 05:22:15.486438+00	1	"1"=>"1", "2"=>"2"	f	t
484	Smith Group	Voluptate placeat veniam possimus ipsa debitis. Facilis dolorem esse quia. Explicabo nobis magni eligendi atque voluptates iusto tenetur.\n\nA quisquam aliquam maiores. Quas possimus voluptas explicabo libero ratione animi. Occaecati reprehenderit quod iure corrupti cumque tempore. Quisquam dolorem molestiae esse dolorum sunt temporibus nemo.\n\nConsequuntur iste esse perspiciatis et officia quod voluptatibus accusamus. Cupiditate veniam sunt fugit esse reprehenderit. Iure quidem distinctio quod vel porro quidem tenetur nostrum.\n\nQuis impedit perspiciatis beatae tenetur explicabo numquam ut aliquam. Sit corporis ex quibusdam deserunt fugit nostrum illo ipsa. Ex nam ad molestias assumenda quis adipisci. Illo excepturi voluptatibus rem natus fuga eaque magnam. Cum provident quia ad excepturi dolorem eius beatae.\n\nAccusamus recusandae illum nisi voluptatem itaque. Cumque molestiae repellat distinctio nesciunt. Corrupti cumque cum occaecati quam. Officia neque in quis fugiat suscipit dignissimos.	50.72	\N	2018-03-13 05:22:15.540903+00	1	"1"=>"1", "2"=>"2"	f	t
485	Sandoval, Miller and Macdonald	A nisi officiis rem perferendis ex. Unde odio architecto laboriosam possimus optio. Saepe unde doloribus placeat tempora assumenda soluta.\n\nVeritatis quos dolorum maiores sunt saepe est ex. Perspiciatis nobis repellat animi deleniti assumenda cum. Eligendi id illo fugit cum earum. Incidunt sapiente enim id.\n\nQuod numquam iusto soluta odit fuga. Illum esse nihil rem a nostrum consequuntur. Ipsam rerum quis repellat. Eum minima reprehenderit ad animi consequatur excepturi.\n\nMaiores quod corrupti ullam sit repellendus voluptate. Incidunt error vitae commodi eaque laudantium numquam est dolorum. Atque nulla expedita ipsa natus accusantium minus dolore. Perferendis necessitatibus id quia ex eaque numquam.\n\nDeleniti vitae quod voluptatum. Voluptatibus pariatur molestiae expedita sint. Quod molestiae praesentium possimus quibusdam ratione. Distinctio in repudiandae repellat cum.	80.71	\N	2018-03-13 05:22:15.604695+00	1	"1"=>"1", "2"=>"2"	f	t
486	Dickerson, Hunt and Neal	Doloribus incidunt dolore voluptas quidem tempora sunt. Rem iure sed temporibus.\n\nFacilis assumenda natus quidem fuga. Fuga optio repudiandae deleniti voluptates earum deserunt optio. Similique doloremque magnam nobis accusamus provident voluptatum.\n\nSequi laudantium pariatur quia sequi. Et asperiores quod fugiat quod perferendis fugit doloribus. Perspiciatis quibusdam eos maxime aliquid.\n\nExplicabo vitae iste quas quam. Praesentium natus rem qui. Porro ipsum praesentium enim esse sapiente. Quas explicabo dolores iure eos quam architecto labore.\n\nReprehenderit incidunt aperiam sapiente minus commodi quaerat illum. Nobis deserunt dolorem saepe beatae. Reiciendis ipsam animi placeat nesciunt repudiandae.	21.75	\N	2018-03-13 05:22:15.653827+00	1	"1"=>"1", "2"=>"2"	f	t
487	Hill, Miller and Jensen	Necessitatibus esse eum consectetur voluptates. Incidunt esse molestias amet minus veritatis veniam soluta. Fuga cumque nulla libero fugit at sunt laudantium ipsam.\n\nSit error molestias facere reprehenderit odio beatae. Itaque quod sint similique magni laudantium.\n\nLaboriosam accusamus unde voluptas ab nesciunt rerum perferendis repellendus. Fuga vel veritatis aliquam quam illum quasi dolores. Dolor asperiores ipsa mollitia officia nisi.\n\nDucimus itaque corporis veritatis soluta. Saepe quam molestias velit asperiores nisi quos. Occaecati quisquam quibusdam ad iste ut assumenda iusto.\n\nLaborum assumenda eius molestias ipsa. Quisquam consectetur sunt voluptatibus. Atque illo labore alias dolorum repudiandae dolor doloribus. Assumenda ea velit iusto debitis. Laborum rem repellat ad ex modi non ullam.	48.50	\N	2018-03-13 05:22:15.758135+00	1	"1"=>"1", "2"=>"2"	f	t
488	Hanson-Knight	Sequi sit id ratione ratione ducimus eligendi nostrum. Tempora excepturi velit minus itaque. Voluptatibus laudantium libero quo officia reprehenderit qui voluptas. Animi distinctio cumque earum porro.\n\nAd quibusdam ea cupiditate deserunt. Commodi voluptates ex aut a neque quod. Saepe et natus excepturi voluptatibus soluta ipsa voluptates.\n\nDolores possimus debitis atque porro quam. Cumque sunt consequatur distinctio corrupti modi. Exercitationem in alias corrupti aspernatur odit.\n\nVero voluptatibus officiis praesentium debitis temporibus. Ipsa totam tempore totam omnis laboriosam veniam perferendis. Dignissimos blanditiis laudantium pariatur ratione atque excepturi.\n\nItaque corporis cupiditate amet repellat repudiandae. Facere cupiditate saepe unde facilis nisi beatae modi reiciendis. Repellat aspernatur vel officia aut. Veritatis in esse beatae excepturi.	81.15	\N	2018-03-13 05:22:15.814113+00	1	"1"=>"1", "2"=>"2"	f	t
489	Patel, Wong and Hickman	Aliquam rerum maiores saepe aspernatur aliquid laudantium accusamus. Ut eligendi id reprehenderit vero. Dolore quo molestias incidunt corrupti exercitationem. Quae minus dicta quidem repellendus placeat molestiae.\n\nDolores modi optio quo ipsam ab quibusdam atque. Suscipit error distinctio cupiditate assumenda. Nesciunt quae natus consequuntur ullam aliquam. Minus natus velit totam assumenda.\n\nRepellat optio ad quis. Quasi repudiandae unde eos quibusdam voluptates nulla expedita. Corrupti perspiciatis minus veritatis nesciunt quas. Culpa cum incidunt optio tenetur totam.\n\nAut quos exercitationem perspiciatis voluptatum placeat. Saepe ut sequi possimus ratione. In quia voluptatibus totam totam quod.\n\nPariatur perferendis sed necessitatibus cumque nemo error explicabo. Non suscipit modi dicta laudantium magnam odit laboriosam. Nemo itaque officiis tempore distinctio. Dolorum quos provident at delectus quisquam adipisci numquam.	39.80	\N	2018-03-13 05:22:15.875433+00	1	"1"=>"1", "2"=>"3"	f	t
490	Lucas Inc	Amet dolor repellendus vero molestias. Cupiditate consequatur dolore eos beatae vel esse dolorem. Ipsam unde perspiciatis quo quibusdam quibusdam eligendi commodi dolorem. Magnam vero deleniti impedit sapiente.\n\nQuaerat sequi expedita maxime voluptatem autem temporibus. Commodi aliquid alias officiis quis nobis aliquam tempora. Tempore occaecati inventore tenetur reiciendis. Sit ratione exercitationem earum culpa.\n\nVitae optio sapiente earum odit rem dicta delectus. Voluptatibus rerum deserunt soluta exercitationem. Ut soluta modi repudiandae corporis provident.\n\nQuidem dolore cumque sunt saepe nostrum. Ex illum recusandae ipsa cum. Quis odio incidunt aut harum quam.\n\nVitae quo nulla inventore quae reiciendis eaque deleniti. Deserunt nihil officiis laborum voluptatibus velit nemo perferendis. Quod sunt iste sint dignissimos. At odit dicta molestias dolores animi quia.	38.38	\N	2018-03-13 05:22:15.946117+00	1	"1"=>"1", "2"=>"2"	f	t
491	Reilly and Sons	Ipsam optio maiores accusantium cupiditate. Numquam corrupti ipsam amet magni odio. Molestiae debitis esse accusamus vero aliquam inventore.\n\nIpsa necessitatibus temporibus ea perferendis delectus tempora enim. Labore temporibus quam laudantium illo ipsum ratione ea eum. Quam ipsam voluptatum expedita molestiae facere aperiam.\n\nSint eaque laboriosam quod. Optio perspiciatis tenetur a repellendus saepe harum. Officia quo aut nemo iste.\n\nVeritatis iste laboriosam sit dolorem. Et omnis facere repudiandae hic omnis.\n\nRem nostrum nisi explicabo. Exercitationem eius reiciendis maiores exercitationem assumenda ipsa praesentium voluptatem. Unde earum sint nihil veritatis asperiores ullam blanditiis. Totam corporis nobis quis facilis dolorem sint.	96.44	\N	2018-03-13 05:22:16.0228+00	2	"1"=>"1"	f	t
492	Bowen, Thompson and Hernandez	Beatae impedit veniam officiis ex quisquam ipsum. Debitis necessitatibus harum dignissimos eum. Expedita sequi velit aliquam impedit beatae earum quo ullam. Occaecati a quod ratione nihil numquam.\n\nQuod laboriosam molestias ut ad voluptatum vitae. Omnis vitae dolore in neque. Aliquid quia in placeat nihil ut aspernatur corporis est. Dignissimos beatae consequuntur ducimus delectus doloremque.\n\nRepudiandae animi corrupti modi vitae excepturi eum quidem. Atque voluptatibus ut voluptatum minima expedita recusandae. In non vitae exercitationem incidunt. Sequi culpa nobis sed provident iste placeat hic eos.\n\nDolores hic consequatur ab hic explicabo voluptatem neque. Voluptates quo labore dolorem at qui optio. Quia numquam dolore dignissimos blanditiis cupiditate omnis.\n\nNihil ipsa in distinctio consequuntur ea. Sunt quam facere dolorum quia.	92.39	\N	2018-03-13 05:22:16.06062+00	2	"1"=>"1"	f	t
493	Dunn, Evans and Anderson	Atque aut harum numquam odio sint molestias. Reprehenderit deleniti nihil porro. Impedit repudiandae enim facilis expedita aspernatur inventore repellat aliquam. Saepe suscipit consectetur enim doloremque hic accusantium voluptatem. Mollitia repellendus asperiores laboriosam tenetur velit nesciunt.\n\nA deserunt provident quia facilis. Ipsa error perferendis provident quos architecto. Eius veniam libero perspiciatis cupiditate at quis fugiat quas.\n\nRecusandae labore vero ea ea voluptas. Maiores exercitationem eligendi repellendus fugit neque dolorum. Officia nulla eius nihil non quisquam necessitatibus expedita.\n\nId debitis et hic consequatur quidem possimus perferendis facilis. Pariatur minus ducimus recusandae harum tenetur voluptate. Doloribus nam doloremque harum voluptas veniam vel consequuntur numquam. Reprehenderit placeat quae minus deleniti.\n\nVeritatis amet maiores deleniti reiciendis omnis accusantium. Reprehenderit fugit eveniet deleniti corporis quidem numquam vero. Doloribus earum numquam accusamus ipsum ullam.	60.77	\N	2018-03-13 05:22:16.100527+00	2	"1"=>"1"	f	t
494	Liu, Harvey and Norris	Fugit ut autem corrupti cupiditate sed. Facere beatae quibusdam asperiores beatae ipsam numquam at quisquam. Odio porro ipsam saepe fugiat.\n\nQuis nisi veniam earum nihil deserunt ducimus. Rem at totam architecto sed voluptatibus. Tenetur aspernatur fuga corrupti aperiam odio mollitia.\n\nOptio veniam iure dignissimos dolorum. Libero eos molestias saepe molestiae tenetur numquam. Eum incidunt quae consequuntur maxime eaque ipsa.\n\nNisi harum id assumenda nemo. Quasi odio quos fuga blanditiis ea placeat excepturi. Voluptatum nulla dolorum consectetur iste.\n\nEum doloribus eos aliquid. Recusandae minus asperiores non molestias excepturi soluta. A tenetur id ab deleniti labore ullam.	84.83	\N	2018-03-13 05:22:16.15435+00	2	"1"=>"1"	f	t
495	Lambert, Bell and Ramirez	Consectetur vero ipsum tempora a cupiditate. Laudantium laudantium deleniti possimus corporis quos quisquam doloribus. Nesciunt dignissimos veritatis libero corporis. Nesciunt optio deleniti nobis quidem sunt. Ad magnam minus aliquid.\n\nModi aut unde labore libero. Nemo quasi quos fugit esse inventore ut. Nisi pariatur dolorum saepe sequi atque.\n\nIpsa optio ratione blanditiis nesciunt. Rerum mollitia iure officia voluptas consectetur doloremque iusto. Nisi eum cum omnis tempore neque.\n\nAtque iste cupiditate sit esse odio facilis. Sit beatae quam rerum asperiores repudiandae. Laborum repellat inventore velit sequi distinctio eum similique. Eum dicta odit et magni maxime dolore. Eligendi animi sapiente consequatur eligendi veritatis veniam at tempore.\n\nAutem architecto expedita vero voluptate excepturi quae. Perspiciatis quam harum consequuntur. Earum minus explicabo facilis nemo aperiam soluta ea sapiente.	27.59	\N	2018-03-13 05:22:16.183631+00	2	"1"=>"1"	f	t
496	Williamson and Sons	Aperiam possimus eos alias provident earum omnis. Magnam nisi quae magni est iste ut.\n\nPossimus ipsum recusandae itaque. Unde expedita odio iure cupiditate quia. Voluptatibus aliquid repellendus quis voluptate beatae porro. Id quae voluptatem itaque tempore exercitationem. Nisi reiciendis fugiat voluptatibus esse accusamus perspiciatis excepturi officia.\n\nDelectus porro nulla voluptates dolorem occaecati quas occaecati nulla. Similique maiores vitae consequuntur nemo blanditiis perspiciatis provident expedita. Neque modi tempore ullam officiis occaecati culpa. Voluptas ullam ea voluptatum.\n\nPraesentium vitae recusandae repudiandae error possimus. Accusantium neque ex facere tenetur sit nobis beatae. Eius perspiciatis distinctio recusandae quis. At unde magni odio cum iste sapiente.\n\nSimilique maiores molestias odio ab. Ad consequuntur accusantium eveniet vel eaque eveniet.	72.67	\N	2018-03-13 05:22:16.224986+00	2	"1"=>"1"	f	t
497	Hayes Ltd	Debitis quisquam temporibus aliquid adipisci beatae. Distinctio ex consectetur voluptatem velit delectus nostrum commodi.\n\nDolor ad non illum ratione et nisi. Assumenda harum quos corporis. Ea consectetur dolorem dicta ducimus. Inventore incidunt veritatis vel quis expedita.\n\nFuga dolor non velit voluptatibus. Quisquam eveniet rem praesentium temporibus animi cumque illum. Eaque officia enim quibusdam ipsa. Ullam vitae dolorum sequi voluptatum nesciunt accusamus.\n\nDoloribus dicta ex ipsum id facere a soluta. Pariatur commodi officia vel doloribus nam explicabo. Eveniet natus asperiores quae unde delectus totam sapiente. Sunt nemo sit consectetur minima eius quis.\n\nNemo et sint ex odit commodi quasi. Eaque veniam laudantium cum modi earum facere labore. Accusamus repellendus fugiat nesciunt atque aspernatur repellendus ipsam. Et ducimus distinctio error occaecati natus inventore rem.	16.50	\N	2018-03-13 05:22:16.27776+00	2	"1"=>"1"	f	t
498	Campbell, Rosales and Gonzalez	Ut aspernatur nisi enim magni. Inventore quasi laborum magni quos doloribus minus.\n\nNesciunt eius necessitatibus facilis assumenda. Aspernatur omnis sunt tenetur animi cum minima. Fugit odio ut eaque consequuntur veniam quod deserunt.\n\nEum nostrum aut alias occaecati fugit pariatur magnam ratione. Recusandae totam consequuntur officiis vitae unde. Ipsam enim voluptatem voluptatibus vitae natus.\n\nVoluptatem rerum ea optio quis. Eaque molestiae dolorem aliquam accusantium eveniet quisquam. Similique cupiditate at dolorem voluptas. Quam id placeat corporis quaerat nostrum illum rem.\n\nA officiis iure atque ipsa fugit repellendus modi. Atque reprehenderit est exercitationem quis. Eveniet sequi blanditiis non porro minus sunt veniam.	53.30	\N	2018-03-13 05:22:16.326763+00	2	"1"=>"1"	f	t
500	Murray, Flynn and Townsend	Fugiat voluptate laborum ipsum deserunt. Nihil voluptas placeat deleniti consequatur hic sunt porro alias. Mollitia assumenda est animi repellat. Tempore totam dicta velit molestiae culpa asperiores similique.\n\nVoluptate quod aliquid in doloribus et. Nihil cupiditate quas est cumque. Consequuntur assumenda dignissimos tempora. Iure pariatur maxime accusamus dolorum dolorem eius assumenda.\n\nEos saepe ipsam id reprehenderit eveniet. Deserunt nesciunt possimus commodi facilis porro modi. Tenetur ipsam cumque similique repudiandae laboriosam.\n\nMinima mollitia animi eos inventore similique maiores fuga. Sed aliquid est assumenda.\n\nInventore reiciendis explicabo reiciendis inventore iste placeat. Temporibus eum eaque quos quae velit harum. Eum voluptate aliquid eum ipsam. Molestias ipsum harum nisi quod inventore adipisci deleniti.	57.74	\N	2018-03-13 05:22:16.415854+00	2	"1"=>"1"	f	t
501	Caldwell, Porter and White	Aut minima quidem ullam maxime. Itaque debitis possimus consequuntur. Ex beatae maiores blanditiis. Iusto ea odio cum repellat voluptatibus.\n\nAliquid reiciendis ipsum perspiciatis cum quo non impedit. Iure quidem accusantium optio incidunt tempora consequatur totam. Officia natus in culpa culpa. Fugit iste nisi aliquam veritatis molestiae iusto minima.\n\nVelit voluptas quis nam ea quaerat a. Tenetur aliquam molestias sunt dolorem ex. Quibusdam ipsum qui fuga sint vero. Dolore blanditiis doloremque ullam sit blanditiis.\n\nNumquam repellat hic nisi itaque sed eius ex nam. Molestiae facere veritatis doloremque adipisci aut est odit maxime. Itaque optio consequatur repudiandae minus architecto ea impedit. Hic corporis dolore earum.\n\nEos ipsum occaecati repellendus ut facere tenetur. Laudantium iusto ut delectus veniam autem blanditiis qui. Nesciunt ratione veniam necessitatibus alias error cum. Facilis velit porro nam maiores quibusdam. Vitae laudantium voluptas neque optio distinctio.	96.38	\N	2018-03-13 05:22:16.46306+00	3	"1"=>"1", "4"=>"8"	f	t
502	Moore, Grant and Gonzalez	Odit inventore ex officiis voluptatum iusto doloremque perferendis. Odio reprehenderit aliquam vel alias possimus illum beatae. Officia aperiam debitis voluptatum magnam rem beatae. Aliquam unde possimus corrupti distinctio.\n\nRepellendus ab nam maiores vel. Et esse occaecati dolorem placeat fuga. Explicabo quos sequi voluptates. Ab optio dolore doloremque beatae a.\n\nLibero veritatis minima provident quibusdam maiores odio. Illum eveniet minus modi enim ipsum ipsa. Unde a incidunt aliquid accusamus cum consequuntur sequi. Explicabo incidunt porro recusandae voluptatibus esse dolorum eius fugit.\n\nAutem laboriosam beatae cum id incidunt. Esse fugit repellendus ipsam vitae. Tenetur fuga velit iure.\n\nAtque tempore aliquid quae expedita error fuga doloribus. Nobis eum corporis hic optio explicabo voluptates. Cupiditate nesciunt alias nemo omnis eius ullam iure. Dicta id id saepe nihil dicta exercitationem officia similique. Natus vel iste eos ab.	28.30	\N	2018-03-13 05:22:16.521465+00	3	"1"=>"1", "4"=>"8"	f	t
503	Cervantes, Fisher and Melendez	Reiciendis rem fuga repellat corporis doloribus voluptates. Dolores provident numquam odit occaecati aperiam architecto voluptate. Laborum culpa nobis tenetur sequi eius blanditiis in.\n\nBeatae officiis distinctio voluptate tempore deserunt maxime rerum. Quaerat corrupti fugit quaerat culpa iusto reprehenderit nostrum. Recusandae quod itaque enim temporibus culpa temporibus architecto. Natus doloremque veniam officiis quis quos asperiores sint.\n\nIpsa architecto occaecati at numquam magni sunt ad praesentium. Velit eveniet nisi similique natus iusto. Quod quisquam nam natus itaque nostrum autem. Saepe voluptates et quibusdam pariatur quae rerum.\n\nMollitia perspiciatis culpa pariatur tenetur accusantium dolorem neque. Hic quis veritatis quod praesentium cupiditate ad. Et inventore accusamus quia soluta. Dolorum a laboriosam nisi nam mollitia at perspiciatis.\n\nAt mollitia enim enim maiores itaque eaque rerum. Aliquid quibusdam possimus illum accusantium sed corporis doloribus. Nobis nesciunt quas repellendus architecto eaque quia doloremque.	62.70	\N	2018-03-13 05:22:16.580555+00	3	"1"=>"1", "4"=>"8"	f	t
504	Collins Inc	Perspiciatis minus commodi veritatis. Numquam assumenda ipsa maiores reiciendis consequuntur. Neque rem saepe ullam excepturi fugiat praesentium sed. Fuga tempora labore fuga.\n\nNumquam minus aperiam minima ea iusto perferendis. Accusamus saepe sapiente soluta earum. Ad quod modi deleniti qui quod perspiciatis odio.\n\nEveniet ex cumque ipsum dolorum libero fugiat. Voluptatibus libero magnam voluptates illum. Ipsa dolor facere blanditiis occaecati ullam voluptates aut.\n\nSimilique laborum voluptas ex nihil asperiores a. Accusamus quod voluptatibus deleniti optio iusto. Architecto suscipit iste aliquam quae dolorem. Occaecati quis dignissimos ad quas perspiciatis.\n\nNatus sint eius nihil exercitationem omnis. Quam natus et numquam occaecati est inventore nihil.	61.70	\N	2018-03-13 05:22:16.632977+00	3	"1"=>"1", "4"=>"9"	f	t
540	Miller-Butler	Mollitia totam ad eveniet quaerat mollitia aspernatur dolore. Eos ratione adipisci quod molestiae ad. Unde ipsam odit labore hic. Odio blanditiis debitis distinctio nam a ab maxime. Sit impedit fuga distinctio unde praesentium.\n\nDolorum id odio amet quam. Rerum libero deleniti aperiam libero.\n\nDolorum in ea corrupti quidem voluptatum fugit deleniti. Est eius perferendis unde tempore natus magni ex. Excepturi odio ullam dolores nam ullam hic.\n\nVel doloremque iusto id inventore enim fuga. Cupiditate quibusdam perspiciatis error dicta quasi saepe aut. Quod inventore ipsum temporibus maiores est et rem.\n\nImpedit accusantium excepturi rem quaerat nobis earum. Quibusdam quos eaque aspernatur optio eum cupiditate. Magnam sit accusamus quos quos nam vero adipisci. Iste suscipit odio dolorem esse dignissimos voluptates labore.	84.67	\N	2018-03-13 05:22:18.766805+00	6	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
505	Gray and Sons	Velit esse consequatur nesciunt quisquam. Dignissimos corporis nihil explicabo sequi atque quidem eius. Fugit dolores distinctio dolor dignissimos. Vero dicta molestias quam optio alias accusantium.\n\nCupiditate odit aut itaque maxime quod magni dolorem nisi. Maxime doloribus sequi laboriosam exercitationem quam debitis quae. Aliquid aliquam iure inventore adipisci placeat.\n\nFacilis illum mollitia consequuntur nihil excepturi in facere doloremque. Debitis molestiae tempore quidem assumenda. Vitae ut temporibus suscipit quae tempore.\n\nVoluptas tempora voluptatem perferendis sint asperiores fugiat. Nihil perspiciatis quasi alias nemo iste aliquam. Cumque reiciendis laborum nihil. Quas veniam officiis similique non assumenda labore quia nostrum. Eius officia minima cupiditate saepe assumenda pariatur dolor.\n\nOdio nihil cupiditate cum ab labore nulla eum. Praesentium quo dolorum beatae libero eos temporibus. Magnam hic fuga officiis. Eaque quam perspiciatis aperiam animi officiis quis sapiente.	69.78	\N	2018-03-13 05:22:16.698082+00	3	"1"=>"1", "4"=>"9"	f	t
506	Hatfield-Shaw	Animi reiciendis a sit totam laborum temporibus ipsam. Enim maiores accusamus quod. Aspernatur consequuntur quasi perspiciatis.\n\nMollitia ex vel dignissimos iusto deleniti minus numquam voluptate. Modi officiis dolor suscipit illum. Provident debitis nesciunt quaerat autem deleniti.\n\nFugiat cumque vero maxime. Minima veritatis quia et. Magni et quos minus molestiae ab. Nisi dolores debitis molestias nemo. Ducimus consequatur nihil ex eius illo reprehenderit aspernatur.\n\nDeserunt est dicta alias praesentium temporibus excepturi odio. Ipsam nobis quos distinctio sint ipsam. Quam autem ducimus alias excepturi asperiores. Similique possimus esse doloremque sint officia.\n\nAlias deleniti quam illum. Officiis fugiat velit autem enim ad adipisci. Ipsum ullam natus odio ab officiis tempora. Quia omnis nesciunt distinctio adipisci explicabo.	64.70	\N	2018-03-13 05:22:16.754237+00	3	"1"=>"1", "4"=>"9"	f	t
507	Robinson-Coleman	Necessitatibus similique eveniet voluptates ipsum recusandae. Ipsa nobis provident minima ea. Quaerat laboriosam exercitationem expedita velit laboriosam. Ut reprehenderit maxime sint voluptatem est provident.\n\nPerferendis rem sit sed a praesentium officiis. Voluptate asperiores exercitationem quis ex ipsum dolor.\n\nLaborum architecto ratione minus possimus voluptates quas. Nesciunt quae quidem aspernatur quisquam laudantium impedit est pariatur. Doloremque delectus architecto quia occaecati suscipit dignissimos ea reprehenderit. Ratione reprehenderit praesentium possimus placeat. Molestias saepe quam sunt expedita magni.\n\nTenetur dicta illum nulla iusto in dicta amet. Ducimus soluta odio harum assumenda libero. Dignissimos quos corporis quaerat nobis quibusdam minima. Totam fuga est laborum tempora nulla eveniet molestias.\n\nEt molestiae tenetur illum. Dignissimos assumenda doloribus debitis asperiores nam omnis neque. Consequuntur quos harum eaque aliquid amet ipsum.	36.36	\N	2018-03-13 05:22:16.814603+00	3	"1"=>"1", "4"=>"8"	f	t
508	Johnson, Hicks and Rodgers	Reprehenderit sequi nemo error laboriosam tenetur. Fugit adipisci cupiditate nobis perspiciatis dolorum voluptatum delectus. Ad magnam iure asperiores quo aut. Perspiciatis sed magni officia.\n\nQuam eos porro similique dolorum doloremque provident. Sunt quam accusamus nobis dolore maiores magnam. Maxime eum consequuntur nulla omnis a.\n\nAccusamus unde perspiciatis rerum nobis ad. Eos facere culpa necessitatibus quo et vel dolorem. Inventore cum magni dicta laborum magnam atque dolorum.\n\nCumque fuga aut officia quaerat fugiat atque rerum deleniti. Voluptas corporis maiores nisi. Aut reiciendis recusandae architecto quasi nostrum. Numquam mollitia deserunt itaque. Veniam adipisci quia voluptatum architecto soluta qui.\n\nVoluptatem deserunt omnis inventore pariatur hic pariatur. Vel labore asperiores minima culpa laudantium laborum ex. Autem enim harum adipisci officiis.	72.21	\N	2018-03-13 05:22:16.862345+00	3	"1"=>"1", "4"=>"8"	f	t
509	Stevenson-Melendez	Cupiditate quidem dicta qui officiis ut incidunt debitis. Veritatis saepe laboriosam earum corporis perspiciatis hic. Quasi ullam consectetur eos eaque quibusdam pariatur ipsam.\n\nEum reprehenderit aperiam ipsum accusamus unde. Molestias asperiores nihil doloribus cumque excepturi voluptas. Totam fuga eligendi incidunt sit ab maiores ipsum.\n\nConsequuntur blanditiis suscipit fugit accusamus saepe culpa. Ex laboriosam magni ipsa sit harum magni. Commodi quisquam praesentium aperiam mollitia adipisci aspernatur quibusdam. Illum sed ducimus suscipit.\n\nEum facere dicta mollitia laudantium. Exercitationem accusamus neque placeat aperiam eius quae. Quis quaerat ipsa similique deserunt officia. Dicta ad illum sit recusandae eligendi iusto.\n\nOdio pariatur accusamus occaecati quis sunt sed. Accusantium saepe delectus ut quas maiores occaecati accusamus. Natus libero alias velit quis nihil excepturi maxime facere. Perferendis qui aspernatur eveniet eius autem.	75.58	\N	2018-03-13 05:22:16.906479+00	3	"1"=>"1", "4"=>"8"	f	t
510	Ellis-Fisher	Eos quidem quae assumenda accusantium odio. Expedita debitis eius nihil similique architecto. Ex similique accusantium impedit qui hic corporis ratione.\n\nNemo perferendis temporibus itaque ullam quam facilis. Impedit id inventore eos. Exercitationem cumque nulla eius nesciunt amet dolorum earum accusantium.\n\nIpsam doloribus expedita reprehenderit doloremque cum porro quas. Occaecati rerum omnis suscipit quisquam harum inventore at. Harum pariatur tempore saepe commodi aliquid molestias.\n\nNihil provident qui laborum. Accusantium dolorem tempora sint possimus.\n\nIpsum harum rerum temporibus quod consequatur. Sed quod illo fugit excepturi ad possimus accusamus. Nobis expedita modi dolores dolor ducimus sit.	46.97	\N	2018-03-13 05:22:16.950355+00	3	"1"=>"1", "4"=>"9"	f	t
511	Anderson-Howard	Quos fugiat aut corporis tenetur. Incidunt modi voluptatum debitis. Commodi aperiam velit quaerat laboriosam quae.\n\nNihil distinctio est deserunt autem laborum sit eum. Occaecati voluptates nulla eius saepe. Consequatur ipsam ipsum necessitatibus doloribus molestias similique. Quas ex est consectetur nostrum ut aliquam.\n\nSaepe expedita nobis ipsa. Molestias cupiditate tempore deserunt accusantium adipisci quaerat. Laboriosam fugiat sapiente aut a blanditiis.\n\nMollitia placeat iure culpa dolores. Commodi temporibus quia accusamus aliquam nemo architecto. Voluptatem facere beatae neque dolorum temporibus minima quibusdam.\n\nVitae quos sint quidem dolore quos. Itaque excepturi reiciendis sapiente eius laboriosam dolore tenetur cupiditate. Quidem iusto incidunt accusamus facere aut recusandae tenetur.	18.60	\N	2018-03-13 05:22:17.012589+00	4	"1"=>"1", "6"=>"14", "7"=>"17"	f	t
512	Green-Bradley	Ad voluptates modi quis cupiditate. Tenetur et quas ad. Non odio tenetur ipsa rem itaque.\n\nDoloribus quasi similique nemo enim ullam aut perferendis. Accusamus vel culpa nulla. Eum incidunt beatae possimus. Aperiam hic maxime veritatis delectus atque pariatur.\n\nModi maiores aliquam recusandae veritatis placeat. Nobis sit dolore vel eligendi quam praesentium aliquid. Iure accusamus quos rem atque. Maiores ipsa libero nesciunt quos voluptate est tempora ad.\n\nVel dolores nostrum minus itaque quaerat. Dignissimos aut deserunt quam dolorem. Animi itaque voluptatem quas.\n\nConsectetur iure ducimus blanditiis sint quas. Asperiores repellat veniam quia totam aspernatur neque velit. Consequuntur asperiores mollitia ea harum. Suscipit natus tempore quidem tempore aliquid doloribus est.	46.51	\N	2018-03-13 05:22:17.083514+00	4	"1"=>"1", "6"=>"14", "7"=>"15"	f	t
513	Ross-Turner	In magnam sit dolore occaecati quis amet quia voluptates. Voluptate quia eum similique voluptatibus asperiores. Aperiam perspiciatis nesciunt dicta. Eveniet blanditiis sint sint iusto molestias.\n\nItaque dolores aspernatur facere recusandae eius. Voluptatem iste amet doloribus magnam et temporibus tenetur. Occaecati tempora voluptatem odio deleniti consequuntur.\n\nVoluptatum eveniet voluptatum distinctio asperiores impedit laborum neque. Laudantium rerum possimus expedita facilis ipsa eligendi. Sunt ducimus repellat voluptates adipisci.\n\nAliquam fuga aut natus rerum cupiditate. Velit fuga fugit quibusdam unde similique. Porro earum itaque eveniet accusamus tempore repudiandae voluptates.\n\nNecessitatibus aliquid molestiae aperiam. Voluptatem dolores odit repellendus repellat. Possimus corporis modi nemo minus nobis. Earum expedita nobis ipsam earum non error repudiandae.	13.23	\N	2018-03-13 05:22:17.160206+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
514	Lopez, Morales and Powell	Adipisci culpa blanditiis cumque. Error doloremque facere expedita. Facilis vel sapiente dolorem iste.\n\nSed optio similique iure. Illo porro nulla rem perspiciatis minima. Velit minima ratione a tenetur.\n\nNecessitatibus impedit perferendis est illum facere. Rem aliquam similique eum nobis distinctio porro. Temporibus mollitia labore aliquid fugiat omnis exercitationem eum.\n\nSaepe laboriosam debitis praesentium architecto corrupti. Fuga inventore distinctio velit nihil itaque eos voluptatem. Non laboriosam et rem voluptatum.\n\nVoluptates repudiandae nesciunt magnam repudiandae molestiae. Ab iusto impedit sunt. Tempora aliquid quae saepe corrupti nisi eligendi laborum. Amet aspernatur quos sequi cum similique.	39.37	\N	2018-03-13 05:22:17.237477+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
515	Hill PLC	Incidunt debitis nesciunt eveniet quia ab. Commodi non in et eaque. Quasi culpa accusantium eos mollitia. Possimus possimus voluptatibus laboriosam sit fugiat eveniet fuga.\n\nAut occaecati mollitia tenetur est. Doloribus quod pariatur architecto earum aperiam labore. Earum vel harum illum adipisci eos. Unde quis optio nisi. Repellendus maxime deserunt tenetur quis.\n\nEt saepe quaerat deserunt culpa hic enim. Repellendus consequatur nulla laboriosam nam explicabo. Est dolor iste eius quasi explicabo atque dolores. Mollitia aspernatur omnis cumque aspernatur.\n\nOfficiis dolore dicta officiis atque. Perferendis cupiditate sapiente rerum eius minima expedita ea. Occaecati laboriosam voluptatum provident doloribus commodi. Quaerat cupiditate pariatur nesciunt ex nihil facere dignissimos.\n\nConsequuntur aliquid voluptatibus quae sequi. Vitae commodi facilis in a cumque dolores. Inventore pariatur necessitatibus vel quae dicta possimus nisi.	37.62	\N	2018-03-13 05:22:17.300451+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
516	Salinas, Davis and Barber	Atque ut reprehenderit quis dignissimos facere quod et. Facere iste molestiae quis deleniti. Dolorem ea perspiciatis omnis similique a repellendus dolores facilis. Facere ab reiciendis cum.\n\nAccusamus est eaque architecto. Magnam assumenda eos aliquid est doloribus. Nihil a eum ab quibusdam at minus.\n\nSequi asperiores officiis aspernatur cupiditate itaque eveniet enim. Illum illum asperiores quae maiores. Tenetur consequatur facilis voluptatem similique assumenda. Nesciunt veniam vero vitae cumque accusantium. Eligendi mollitia maxime numquam ratione id recusandae quidem.\n\nNulla distinctio ad delectus cum amet quo quaerat culpa. Fugiat minus illo blanditiis deleniti deserunt sed totam. Placeat beatae ipsam eos architecto inventore architecto itaque. Soluta repellat ullam qui alias.\n\nVel esse nihil exercitationem voluptatibus. Magnam maxime ratione doloremque sed quas. A dolor fugiat voluptas odit vitae. Saepe ea commodi praesentium magnam corporis pariatur corrupti.	3.90	\N	2018-03-13 05:22:17.358362+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
517	Gonzalez Group	Omnis possimus reprehenderit laborum aut voluptatibus praesentium. Deleniti optio iure quidem earum quam. Hic ut expedita et voluptate doloremque quas veniam. Unde rerum perspiciatis minima. Animi illum id quae ea.\n\nMinus vel praesentium accusamus magni ducimus. Nobis ducimus animi odio odio. Est corporis eos nesciunt quaerat.\n\nBlanditiis iste maxime possimus fuga eveniet. Quisquam expedita quo enim dolor. Dignissimos dolorum eligendi quis odio iusto non.\n\nVeniam sed molestias magnam suscipit blanditiis quam dicta. Aliquid enim ducimus omnis ut. Eaque iste ipsa possimus. Nemo voluptas nulla optio vero praesentium.\n\nRecusandae iste quae recusandae. Velit neque facere ipsam veniam quam maxime. Mollitia nostrum architecto et voluptate.	49.60	\N	2018-03-13 05:22:17.421706+00	4	"1"=>"1", "6"=>"13", "7"=>"17"	f	t
518	Gonzalez-Phillips	Maxime laborum tenetur quibusdam aspernatur mollitia. Maxime incidunt totam consectetur dolore provident rem est. Dolores porro natus error voluptates. Aspernatur vitae aspernatur voluptate inventore alias voluptatibus autem.\n\nAut cumque voluptatibus non modi aliquam. Ratione accusamus cupiditate cumque illum architecto iste. Harum quis repudiandae ipsum nihil. Cumque quae laudantium sunt maxime expedita cumque. Modi ullam vel similique tempora assumenda nemo omnis.\n\nMaxime necessitatibus molestias exercitationem ut nesciunt. In soluta similique eveniet odit magnam a repellat. Repudiandae ducimus modi odit consequuntur molestiae ipsa. Possimus nemo suscipit aperiam corporis.\n\nQuaerat temporibus dolorem provident quae veniam ipsa. Odit placeat temporibus nemo fugit dolore numquam. Laboriosam mollitia assumenda quas eveniet mollitia odio tenetur.\n\nEos odio sint voluptas deserunt quis voluptas. Voluptas temporibus maiores incidunt sint occaecati reiciendis quam. Deserunt ratione architecto sunt nam quae voluptates impedit.	10.17	\N	2018-03-13 05:22:17.486564+00	4	"1"=>"1", "6"=>"13", "7"=>"16"	f	t
519	Taylor-Bates	Facilis et neque suscipit ab ullam in. Doloribus debitis molestiae minus esse repellat consequatur minus iste. Repudiandae eveniet cum consectetur quaerat aut aspernatur. Voluptatibus assumenda animi odio ullam veniam unde atque.\n\nImpedit laudantium quis quisquam reprehenderit doloribus. Temporibus debitis porro deleniti debitis odit similique. Adipisci iusto consectetur sint unde.\n\nAlias quis dignissimos culpa. Eius laborum eum sunt atque iure sint fugit quam.\n\nCumque amet debitis nemo quo. Voluptatum in quaerat quam veniam sequi asperiores. Iusto accusamus molestias quae minus.\n\nEligendi corporis similique optio quod sint facere possimus. Commodi vero cumque corrupti officia. Voluptatibus iste quaerat explicabo nobis accusantium praesentium optio.	16.36	\N	2018-03-13 05:22:17.542553+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
520	Gomez-Jacobs	Accusamus atque dolores omnis corporis. Ut exercitationem sed harum. Minima sequi minus eveniet voluptatibus quas porro.\n\nQuos nisi harum esse illo laborum. Sed reprehenderit incidunt temporibus eligendi dolorem perferendis quo.\n\nVoluptatem quae possimus quos a veniam facilis natus. Nulla eum occaecati beatae. Fuga laudantium a neque ab repudiandae soluta temporibus.\n\nAccusantium animi repudiandae saepe sed temporibus repudiandae eius maxime. Dolores sit quidem occaecati voluptatum. Eveniet voluptatem provident maiores dolore porro.\n\nPraesentium repudiandae molestias molestias distinctio quod quaerat iste. Molestias eaque repellendus cum eius atque ea. Vero nihil officiis reiciendis incidunt alias. Consequatur nostrum fuga rerum eaque.	21.32	\N	2018-03-13 05:22:17.606112+00	4	"1"=>"1", "6"=>"13", "7"=>"15"	f	t
521	Ward, Mcdowell and Parker	Dolores atque sapiente unde illo repudiandae ex natus nisi. Sequi animi aliquam corrupti veniam. Dignissimos minima ut dignissimos maiores nemo amet. Repudiandae illo explicabo quisquam non magnam.\n\nHic voluptatibus alias voluptatem adipisci cumque dolorum maxime dolore. Vel consequuntur atque dignissimos eveniet tempore vero cupiditate atque. Consequatur laborum tenetur voluptatem fugit.\n\nNecessitatibus magnam fugiat non distinctio. Architecto ipsam ab quasi doloribus quam distinctio. Suscipit quae quis odio dolorem. At vero iure tempora.\n\nUt officia quo quasi porro exercitationem nulla. Placeat sed odio eaque dolores rerum voluptas quasi. Consectetur libero pariatur in cumque commodi voluptas.\n\nEos ea provident saepe saepe. Voluptatibus incidunt vel laboriosam ullam soluta minima.	44.79	\N	2018-03-13 05:22:17.692955+00	5	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
522	Wise PLC	Vitae numquam cumque rem. Amet ut magnam asperiores quod laudantium numquam dolorum. Dolorum corrupti voluptatum magnam.\n\nConsequuntur veritatis minima culpa temporibus voluptate soluta. Amet assumenda incidunt temporibus nulla quod.\n\nAperiam cum nam laudantium eveniet. Suscipit eveniet eum at autem occaecati sit eaque deleniti. Voluptatibus omnis cupiditate distinctio sit labore ducimus distinctio aperiam.\n\nEst totam magni quasi impedit repudiandae vero. Dignissimos accusantium dolorum sed molestiae. Possimus illum esse repellendus corporis voluptatibus veritatis mollitia.\n\nModi quod et ullam autem porro. Ex recusandae eligendi eum optio possimus sint doloribus. Ab illo consequatur mollitia quae.	18.55	\N	2018-03-13 05:22:17.76036+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
523	Esparza Ltd	Quaerat hic debitis magnam totam perspiciatis. Quidem similique est sequi a dignissimos occaecati dolorem. Dolor ipsa cum laboriosam. Optio quaerat blanditiis beatae facilis enim quas officiis.\n\nNesciunt in velit ratione. Esse quibusdam nihil harum eaque tempora voluptate. Ipsa nam ad fuga est modi eaque. Dolor praesentium cupiditate et nam aut.\n\nDolorum aspernatur esse omnis nulla laboriosam. Impedit ad vero tempore nostrum libero adipisci accusamus. Tempore voluptatum ipsam deleniti. Ad repellendus excepturi dicta illum nesciunt.\n\nLaborum nisi delectus eaque neque. Autem neque accusantium esse voluptatem at quis pariatur. Maiores nihil ut debitis suscipit eaque illum enim fugiat. Vitae minus ullam deserunt sapiente velit alias. Possimus vero dolor ea.\n\nVero adipisci eius similique porro culpa neque. Autem fugit sunt consequuntur quasi nihil. Temporibus alias veritatis nulla architecto totam exercitationem minima. Repudiandae minima minima quam dolorum nostrum facilis perspiciatis aspernatur.	4.47	\N	2018-03-13 05:22:17.797414+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
524	Hill, Evans and Peterson	Unde molestias quaerat animi sapiente aut odit. Quod maxime animi quam cum cupiditate consequatur consequatur reprehenderit. Quidem veritatis esse odio repudiandae.\n\nPerferendis vitae sapiente beatae iusto iusto. Quos culpa nostrum natus voluptate. Vitae ut ex nisi tempore.\n\nNam labore molestiae repellendus ab nobis repudiandae. Blanditiis delectus reprehenderit perspiciatis sed blanditiis necessitatibus quo. Minima dolore quidem deleniti veniam cumque quod. Dicta esse libero quis impedit assumenda quidem.\n\nSuscipit quod praesentium at officiis consequuntur labore. Sapiente magnam dolor ut voluptas nisi. Dicta aspernatur nobis similique et. Eos distinctio ad voluptatibus commodi veritatis.\n\nVeritatis assumenda optio facilis ut officiis assumenda hic. Optio dolor at suscipit corrupti neque optio quae. Quae ducimus veritatis laborum unde. Quis dignissimos vitae nulla doloribus vero reprehenderit.	55.44	\N	2018-03-13 05:22:17.859598+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
525	Williams-Schmidt	Tenetur recusandae sed magnam repellendus libero. Illo saepe fuga eos quaerat nesciunt. Quos omnis laboriosam odit fugit consequatur.\n\nQuidem culpa repudiandae veniam tempore. Consectetur iste soluta numquam officiis optio perspiciatis labore. Quo tenetur soluta labore magni sint itaque hic.\n\nArchitecto optio voluptatem fuga exercitationem quisquam illum. Magnam harum porro delectus. Natus laborum quisquam animi. Ab accusantium voluptatum unde ab quis aliquid delectus molestiae.\n\nBeatae quis hic tempora distinctio deserunt architecto. Dolorum commodi quos expedita odit harum officiis. Voluptatibus assumenda tenetur libero autem iusto.\n\nSint repellendus tempore repellendus unde ullam. Non reprehenderit nostrum molestiae est dolores architecto consequuntur. Excepturi molestiae totam impedit ad. Quas quam neque similique. Fugit non ducimus sapiente quaerat inventore voluptatibus totam.	47.22	\N	2018-03-13 05:22:17.924858+00	5	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
526	Rodriguez, Juarez and Johnson	Corrupti doloremque nihil et reiciendis numquam magni. Magni iusto rerum repellat ipsam nulla illum id. Illum voluptas velit doloremque cupiditate.\n\nFacilis vel expedita iusto aliquid rem animi quia. Velit corrupti quae hic. Excepturi impedit placeat dolorum magni corporis error quas quae. Dolores beatae repudiandae quaerat incidunt voluptates.\n\nPerferendis assumenda modi itaque vel. Quisquam fugit voluptas quidem voluptatibus eligendi beatae nemo numquam. Quidem provident dignissimos asperiores possimus.\n\nDolorum quia fuga et alias labore. Eius repellendus repellat suscipit libero sequi ad. Unde corrupti architecto quod.\n\nCommodi iusto ad culpa ab. Quibusdam deleniti architecto odio omnis inventore soluta. Quasi cum doloremque officia amet.	96.72	\N	2018-03-13 05:22:18.042192+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
527	Olsen, Robinson and Chang	Distinctio officiis omnis earum soluta doloribus ad in. Recusandae aspernatur quo tenetur eius. Reprehenderit eligendi dolore quo magni assumenda ducimus quod.\n\nIpsum sed repellat dolorum atque pariatur. Consequuntur officiis porro officia iusto officiis iste cupiditate. Error consequuntur quasi numquam accusamus.\n\nIure atque quod quidem cum distinctio temporibus tempora. Rerum aliquam nobis laudantium libero nesciunt. Occaecati quam maiores veniam fugit. Suscipit eaque non magnam quo reprehenderit officia mollitia.\n\nNesciunt nulla voluptate aliquam natus. Tempore voluptas iure eius impedit placeat eligendi tempore. Amet nihil repellat corrupti repudiandae.\n\nAmet explicabo dolorum dicta perspiciatis. Eaque quam rem dolore necessitatibus dicta sapiente. Rem repudiandae veniam numquam tempore accusamus.	20.90	\N	2018-03-13 05:22:18.123361+00	5	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
532	Cook, Morrison and Stewart	Excepturi qui deserunt eos quidem fugit consequatur. Provident placeat saepe quasi eius. Iusto assumenda reprehenderit consectetur ab perferendis incidunt. Consequuntur perspiciatis harum minima consequuntur dolorum ex.\n\nQuasi fugiat iure tempora. Dignissimos molestiae natus nisi maxime doloribus odit. Dolor quae dolores ducimus aliquam porro placeat iusto consectetur.\n\nAdipisci similique dolores ipsum eveniet corrupti optio. Laborum corporis architecto neque quia autem culpa et. Architecto quasi hic laboriosam non laudantium. Perferendis optio ex inventore tempore nostrum.\n\nDeserunt labore sapiente quos minima. Occaecati veritatis sit sequi expedita perspiciatis. Corrupti itaque deleniti sequi libero debitis blanditiis accusantium.\n\nItaque ad commodi labore doloremque impedit molestiae maxime. Nam magni itaque nisi assumenda ducimus velit esse. Consequuntur neque soluta quibusdam esse soluta rerum soluta.	1.22	\N	2018-03-13 05:22:18.407417+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
528	Watkins LLC	Architecto possimus nisi tempore porro animi. Optio ratione provident id sapiente pariatur dolor iusto maiores. Quo provident repellendus nisi.\n\nRatione incidunt eum quisquam alias. Fuga nesciunt cumque ipsa alias non aperiam illum. Eveniet ipsa perferendis dolore fugit dolores optio. Reprehenderit cupiditate ea quo culpa labore incidunt. Ex nihil vitae earum corporis pariatur occaecati pariatur.\n\nNumquam sunt inventore culpa sed expedita suscipit. Provident laborum consectetur tempore unde rem at quos minima. Ducimus harum voluptatibus accusantium ratione. Similique quam amet qui sed ducimus aliquid dolore inventore.\n\nRatione labore eius maxime voluptas. Doloremque iusto at expedita perspiciatis ut minus id. Tempora distinctio similique pariatur nulla recusandae veniam minus. Est maxime pariatur nobis. Sequi aliquid sunt nostrum non.\n\nEnim officia beatae vero quae placeat quaerat placeat. Atque inventore consequatur eos accusamus saepe tenetur. Impedit minus quam quae modi sint voluptatum. Sapiente cupiditate quo perferendis repudiandae a debitis saepe.	71.34	\N	2018-03-13 05:22:18.177405+00	5	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
529	Thompson-Hernandez	Enim accusantium sint possimus consectetur voluptatem. Nulla officiis necessitatibus ullam quisquam vitae distinctio. Autem delectus esse laborum impedit. In quaerat eos veritatis illo voluptates nihil inventore.\n\nIusto alias cupiditate unde impedit ratione. Id saepe dicta quia vitae officia aperiam eum sunt. Aliquid earum perspiciatis debitis facilis laborum nulla ipsum.\n\nUnde sit sunt et nisi inventore. Iusto eius expedita veritatis molestias. Officia illum exercitationem corporis voluptate.\n\nExcepturi blanditiis sunt aspernatur. Natus optio dolorem autem provident molestias quae non. Autem aliquam iure a illum eius repudiandae magni. Vitae illum tenetur dolorum odit.\n\nDignissimos ratione voluptatem reiciendis magnam nam commodi. Deserunt rerum facilis odio natus. Nobis voluptatibus deleniti vitae praesentium. Iste minus quas cum cupiditate fuga ratione ipsam. Iure veritatis ipsa eius excepturi.	74.50	\N	2018-03-13 05:22:18.230504+00	5	"9"=>"25", "10"=>"26", "11"=>"29"	f	t
530	Nelson-Powell	Quod sequi laudantium molestiae nemo. Earum ex neque tempora odit nulla id autem. Pariatur dolorem eos atque illum. Culpa quidem libero vitae quod ipsam tempora.\n\nDoloribus nihil similique saepe officiis enim. Minima alias velit id velit perspiciatis. Tempora neque natus saepe fuga rem consequatur. Magni aut itaque veritatis aspernatur.\n\nCulpa unde officia suscipit facilis consequatur iure ea. Eos consequuntur itaque illo praesentium aliquid voluptatibus consequuntur. Consequuntur saepe odio quia.\n\nQuod beatae officiis ipsa quidem. Consectetur alias reiciendis quam saepe aspernatur et. Perspiciatis recusandae maiores doloribus nemo ratione nam sequi. Velit nostrum atque atque adipisci saepe in illum quas.\n\nReprehenderit dolor rerum officia ratione error molestias ut atque. Impedit excepturi mollitia rerum voluptates sequi. Quo nisi commodi dicta ipsum quis veniam neque consectetur. Voluptatum numquam ipsum perspiciatis tempore porro totam error.	53.11	\N	2018-03-13 05:22:18.294796+00	5	"9"=>"25", "10"=>"26", "11"=>"28"	f	t
531	Hayden LLC	Corporis sequi numquam libero porro inventore. Ducimus praesentium saepe nihil ex.\n\nDolorum assumenda dicta quis voluptatem impedit molestiae. Rem nemo laborum inventore illo atque quidem. Voluptates dolorum recusandae harum atque veniam amet cumque. Sequi iste non debitis quam.\n\nVeritatis cumque temporibus qui. Est ducimus odit id. Inventore ipsa architecto impedit alias consectetur a possimus.\n\nOfficia dolore cum sapiente inventore similique corporis. Corporis corporis excepturi magni. Vitae ut at tempore quaerat nostrum itaque.\n\nFacilis accusamus laudantium magni dolorum sunt commodi doloremque voluptate. Odit perspiciatis pariatur ducimus sapiente labore ut saepe quasi. Quas animi eveniet eos deleniti autem. Repellat sunt cumque maiores vero temporibus accusamus. Repudiandae quasi ratione ipsam illum cumque porro consectetur.	15.80	\N	2018-03-13 05:22:18.364064+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
533	Smith, Williams and Powell	Iure cum inventore delectus reprehenderit repudiandae beatae minus natus. Eos minima voluptate distinctio praesentium eum. Laborum delectus nesciunt itaque dolorem est officia debitis. Ratione eaque modi sint sed at itaque alias perferendis.\n\nRepudiandae molestiae vero deserunt soluta. Atque recusandae quibusdam voluptatem laborum aliquam facere. Consequatur at officia fugit eius quae.\n\nAnimi voluptate blanditiis eligendi facilis atque sequi. Similique cumque explicabo iusto ipsum dicta nihil. Iure optio minus iure laborum voluptatibus totam facere. Doloribus nam blanditiis voluptas natus minima tempora.\n\nVoluptatibus ratione ab praesentium unde accusantium nobis voluptas nobis. Voluptatem alias explicabo aliquid earum esse blanditiis. Dolor magni dignissimos pariatur consequatur.\n\nDolor iusto quisquam sunt ratione quae natus. Rerum alias repudiandae possimus quam quibusdam. Esse voluptatibus eos quibusdam numquam quo dolorem dolorum. Praesentium quisquam quas aperiam sint odit.	68.44	\N	2018-03-13 05:22:18.444958+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
534	Mcgee-Simmons	Dolore iste animi qui laudantium voluptatem. Ex nam magni voluptate debitis nam sunt. Saepe quibusdam at placeat ad. Nihil eaque molestias incidunt ipsam est atque ducimus.\n\nFacilis corporis officia numquam voluptatem ut similique. Culpa blanditiis ipsum neque ullam tenetur officiis accusantium fugiat. Ex maxime eius praesentium ducimus fuga.\n\nCum debitis vero vitae. Reprehenderit quaerat id magnam nesciunt. Suscipit non unde ipsum magnam animi minima quod. Neque necessitatibus quaerat ipsum.\n\nBeatae neque laborum odio voluptate quos veniam. Molestias ratione dolorem debitis maxime. Dolorum harum numquam minima est velit quisquam facilis. Voluptatem quod eius eos fuga natus reiciendis.\n\nQuidem voluptates in error et exercitationem nemo. Repudiandae laudantium non doloremque veniam eaque iure. Neque quaerat vitae amet ab. Nostrum recusandae eos laborum sequi ad nesciunt eaque.	57.56	\N	2018-03-13 05:22:18.50533+00	6	"9"=>"24", "10"=>"26", "11"=>"28"	f	t
535	Jones, Rodriguez and Andrews	Quae ducimus officiis velit occaecati. Expedita accusamus repellendus autem. Laboriosam consectetur nemo consequuntur.\n\nOfficia odit optio explicabo sit. Natus quia eum qui aspernatur rem vitae. Quo veritatis atque incidunt sunt.\n\nAliquid doloremque occaecati recusandae fugit. Ducimus aliquam quaerat expedita. At laudantium hic modi hic esse debitis.\n\nEt quam voluptate rerum. Unde perferendis suscipit et voluptate. Numquam maiores sed eum hic soluta nihil. Maxime ab assumenda pariatur.\n\nVero quibusdam asperiores molestias aliquid qui. Rerum eaque quam placeat ad. Dolor autem animi eius in. Perspiciatis nostrum iure quibusdam accusamus odio cupiditate.	18.25	\N	2018-03-13 05:22:18.542062+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
536	Williams-Lawrence	Nemo voluptatibus explicabo recusandae accusantium ipsa. Odio quibusdam placeat enim dolore numquam eligendi illum. Expedita hic molestias dignissimos doloribus non. Molestiae fugiat eos quos sunt eligendi quis explicabo. Facere nesciunt mollitia architecto facere.\n\nEt beatae aspernatur ullam accusantium. Autem esse reiciendis at at quod et aspernatur aliquam. Nobis error assumenda dolor perspiciatis voluptates accusantium. Repellendus assumenda repellat aliquid placeat.\n\nNostrum inventore qui expedita saepe tempore. Ullam labore quod fugit enim earum natus deserunt. Pariatur necessitatibus corrupti temporibus optio. Sint facilis ut laudantium earum nemo facere.\n\nCumque quibusdam iste ipsum eligendi. Pariatur doloribus pariatur inventore aut quae enim dicta.\n\nOdio suscipit occaecati nulla placeat minima. Repudiandae hic labore voluptas. Dolorem rem deleniti corrupti iste dolorum assumenda repellendus. Vero inventore consequatur rem expedita deleniti. Officia sequi dolorem dolores sint explicabo.	44.16	\N	2018-03-13 05:22:18.599236+00	6	"9"=>"24", "10"=>"26", "11"=>"29"	f	t
537	Wilson-Hendrix	Doloribus perferendis inventore animi molestias. Fugit quos aliquid voluptas omnis eum nostrum enim. Harum quia voluptatem odit numquam.\n\nHic ex non facere quisquam saepe. Animi quibusdam excepturi atque nulla dicta minus. Voluptatibus ea ipsam corporis modi.\n\nPerspiciatis sapiente debitis enim rem. Ad reiciendis corporis soluta. In explicabo vel mollitia vero illum adipisci at.\n\nExplicabo optio porro est quas earum sunt magnam mollitia. Vero omnis ut fuga corporis facilis soluta neque voluptatum. Repellendus enim eaque quae optio animi quae cum. Provident mollitia recusandae enim nesciunt fugiat dolorum quibusdam sapiente.\n\nLibero totam quidem facilis nihil atque excepturi. Deleniti magni eveniet provident pariatur dolores. Ex magnam deleniti aspernatur eligendi. Maiores delectus ut nam quam voluptates accusamus.	71.71	\N	2018-03-13 05:22:18.627688+00	6	"9"=>"24", "10"=>"27", "11"=>"29"	f	t
538	Crawford, Fox and Harrell	Voluptate sunt occaecati est odio minus. Optio placeat quasi voluptates quia ipsam modi nobis. Excepturi maxime rerum aperiam ratione natus dignissimos.\n\nEarum tempore suscipit maxime delectus quaerat alias tempora aspernatur. Voluptates nostrum praesentium ut excepturi. Tempore suscipit nisi necessitatibus quisquam nam.\n\nSuscipit distinctio eveniet nobis illo dolorem. A ducimus dolorem qui voluptate iusto possimus. Quis eligendi natus facilis laudantium.\n\nAutem voluptatum doloribus voluptatum enim. Possimus sit placeat laborum eveniet doloremque eum quo. Ratione voluptates saepe quod ab in perspiciatis. Consequuntur quos accusamus reprehenderit debitis doloribus rem.\n\nTempora molestias repellendus aliquam repellat voluptas. Temporibus architecto sint recusandae unde soluta expedita. Tempore non corporis esse accusamus quidem ea. Eligendi itaque neque magnam tenetur corrupti.	84.40	\N	2018-03-13 05:22:18.674674+00	6	"9"=>"25", "10"=>"27", "11"=>"29"	f	t
539	Bryant and Sons	Veritatis doloremque cumque illo. Ratione animi nisi ducimus porro ullam quam labore. Quae consequatur provident accusamus veniam eaque nulla.\n\nEt quia totam cumque cum porro non doloremque. Enim dignissimos corrupti repellendus ea repellendus. Fugit maiores eligendi perferendis voluptatem libero provident recusandae nam.\n\nIncidunt veniam non illum quasi esse ab dolorum nulla. Error quam dolor quia. Quaerat vero quam fuga quod. Nisi possimus saepe nesciunt totam saepe.\n\nDucimus dicta dolor occaecati distinctio saepe sapiente. Asperiores saepe voluptas aut. Voluptatum ex officiis hic provident fugiat ex. Qui exercitationem quidem atque adipisci reprehenderit quis veritatis illum.\n\nTemporibus doloremque dicta animi sequi commodi veritatis quasi maxime. Esse atque minus iste suscipit dolorem assumenda. Dolorem illum saepe eius voluptates quod itaque cupiditate.	2.84	\N	2018-03-13 05:22:18.713981+00	6	"9"=>"24", "10"=>"27", "11"=>"28"	f	t
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
21	21	1
22	22	1
23	23	1
24	24	1
25	25	1
26	26	1
27	27	1
28	28	1
29	29	1
30	30	1
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
81	81	1
82	82	1
83	83	1
84	84	1
85	85	1
86	86	1
87	87	1
88	88	1
89	89	1
90	90	1
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
141	141	1
142	142	1
143	143	1
144	144	1
145	145	1
146	146	1
147	147	1
148	148	1
149	149	1
150	150	1
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
201	201	1
202	202	1
203	203	1
204	204	1
205	205	1
206	206	1
207	207	1
208	208	1
209	209	1
210	210	1
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
261	261	1
262	262	1
263	263	1
264	264	1
265	265	1
266	266	1
267	267	1
268	268	1
269	269	1
270	270	1
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
321	321	1
322	322	1
323	323	1
324	324	1
325	325	1
326	326	1
327	327	1
328	328	1
329	329	1
330	330	1
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
381	381	1
382	382	1
383	383	1
384	384	1
385	385	1
386	386	1
387	387	1
388	388	1
389	389	1
390	390	1
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
441	441	1
442	442	1
443	443	1
444	444	1
445	445	1
446	446	1
447	447	1
448	448	1
449	449	1
450	450	1
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
501	501	1
502	502	1
503	503	1
504	504	1
505	505	1
506	506	1
507	507	1
508	508	1
509	509	1
510	510	1
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
1	brand	Brand
2	coffee-genre	Coffee Genre
3	box-size	Box Size
4	flavor	Flavor
5	candy-box-size	Candy Box Size
6	color	Color
7	collar	Collar
8	size	Size
9	publisher	Publisher
10	language	Language
11	author	Author
12	cover	Cover
\.


--
-- Data for Name: product_productclass; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass (id, name, has_variants, is_shipping_required) FROM stdin;
1	Coffee	t	t
2	Mugs	t	t
3	Candy	t	t
4	T-Shirt	t	t
5	Books	t	t
6	E-books	t	f
\.


--
-- Data for Name: product_productclass_product_attributes; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productclass_product_attributes (id, productclass_id, productattribute_id) FROM stdin;
1	1	1
2	1	2
3	2	1
4	3	1
5	3	4
6	4	1
7	4	6
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
1	1	3
2	3	5
3	4	8
4	5	12
\.


--
-- Data for Name: product_productimage; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productimage (id, image, ppoi, alt, "order", product_id) FROM stdin;
1	products/saleor/static/placeholders/coffee/coffee_03_ImZ6Fti.jpg	0.5x0.5		0	1
2	products/saleor/static/placeholders/coffee/coffee_01_UJWpoGZ.jpg	0.5x0.5		0	2
3	products/saleor/static/placeholders/coffee/coffee_02_HG0e7JP.jpg	0.5x0.5		1	2
4	products/saleor/static/placeholders/coffee/coffee_01_lMmw8Bk.jpg	0.5x0.5		0	3
5	products/saleor/static/placeholders/coffee/coffee_01_NuJCPWu.jpg	0.5x0.5		1	3
6	products/saleor/static/placeholders/coffee/coffee_01_QaM6fR2.jpg	0.5x0.5		2	3
7	products/saleor/static/placeholders/coffee/coffee_01_BbpmuGt.jpg	0.5x0.5		0	4
8	products/saleor/static/placeholders/coffee/coffee_03_TYw4xPG.jpg	0.5x0.5		1	4
9	products/saleor/static/placeholders/coffee/8_seewRBX.jpg	0.5x0.5		2	4
10	products/saleor/static/placeholders/coffee/coffee_03_RXuyjdX.jpg	0.5x0.5		0	5
11	products/saleor/static/placeholders/coffee/8_ds6IECZ.jpg	0.5x0.5		1	5
12	products/saleor/static/placeholders/coffee/coffee_02_giS5XvK.jpg	0.5x0.5		2	5
13	products/saleor/static/placeholders/coffee/coffee_03_YNukOvC.jpg	0.5x0.5		3	5
14	products/saleor/static/placeholders/coffee/coffee_03_5pHU64f.jpg	0.5x0.5		0	6
15	products/saleor/static/placeholders/coffee/8_7wFjD7P.jpg	0.5x0.5		1	6
16	products/saleor/static/placeholders/coffee/coffee_04_IdOOdOl.jpg	0.5x0.5		2	6
17	products/saleor/static/placeholders/coffee/8_CbHqsG0.jpg	0.5x0.5		3	6
18	products/saleor/static/placeholders/coffee/coffee_01_JWRcV0Y.jpg	0.5x0.5		0	7
19	products/saleor/static/placeholders/coffee/coffee_02_eJR9qPu.jpg	0.5x0.5		0	8
20	products/saleor/static/placeholders/coffee/coffee_04_6XXUuhB.jpg	0.5x0.5		0	9
21	products/saleor/static/placeholders/coffee/coffee_02_PBcf9Sy.jpg	0.5x0.5		1	9
22	products/saleor/static/placeholders/coffee/coffee_04_GsYmUyZ.jpg	0.5x0.5		2	9
23	products/saleor/static/placeholders/coffee/coffee_03_StGziB9.jpg	0.5x0.5		0	10
24	products/saleor/static/placeholders/coffee/coffee_03_QooQmsv.jpg	0.5x0.5		1	10
25	products/saleor/static/placeholders/mugs/3_8WCGLZb.jpg	0.5x0.5		0	11
26	products/saleor/static/placeholders/mugs/3_UEUrZFB.jpg	0.5x0.5		0	12
27	products/saleor/static/placeholders/mugs/box_01_x1fau6V.jpg	0.5x0.5		1	12
28	products/saleor/static/placeholders/mugs/7_94zZh5X.jpg	0.5x0.5		2	12
29	products/saleor/static/placeholders/mugs/3_UmDOv2Q.jpg	0.5x0.5		0	13
30	products/saleor/static/placeholders/mugs/4_Jiy3CLa.jpg	0.5x0.5		1	13
31	products/saleor/static/placeholders/mugs/box_01_ro7eCE5.jpg	0.5x0.5		2	13
32	products/saleor/static/placeholders/mugs/4_Fh4Xdis.jpg	0.5x0.5		3	13
33	products/saleor/static/placeholders/mugs/4_j7dCtkb.jpg	0.5x0.5		0	14
34	products/saleor/static/placeholders/mugs/4_mO1Dcwy.jpg	0.5x0.5		1	14
35	products/saleor/static/placeholders/mugs/7_Pt5MAdB.jpg	0.5x0.5		2	14
36	products/saleor/static/placeholders/mugs/box_01_zQ9WliU.jpg	0.5x0.5		0	15
37	products/saleor/static/placeholders/mugs/3_PgiQ3yR.jpg	0.5x0.5		1	15
38	products/saleor/static/placeholders/mugs/box_01_Zh0TEz1.jpg	0.5x0.5		0	16
39	products/saleor/static/placeholders/mugs/box_01_awyHhTk.jpg	0.5x0.5		0	17
40	products/saleor/static/placeholders/mugs/box_01_6ENxUAO.jpg	0.5x0.5		1	17
41	products/saleor/static/placeholders/mugs/box_01_vxPWEda.jpg	0.5x0.5		2	17
42	products/saleor/static/placeholders/mugs/7_ObYY5IJ.jpg	0.5x0.5		0	18
43	products/saleor/static/placeholders/mugs/4_dAqHUey.jpg	0.5x0.5		1	18
44	products/saleor/static/placeholders/mugs/7_4orpDHf.jpg	0.5x0.5		0	19
45	products/saleor/static/placeholders/mugs/box_01_fnwY2FO.jpg	0.5x0.5		1	19
46	products/saleor/static/placeholders/mugs/3_m6kqVi6.jpg	0.5x0.5		0	20
47	products/saleor/static/placeholders/mugs/4_YOXHn2c.jpg	0.5x0.5		1	20
48	products/saleor/static/placeholders/mugs/4_CHFSB8P.jpg	0.5x0.5		2	20
49	products/saleor/static/placeholders/mugs/box_01_NbCHvdX.jpg	0.5x0.5		3	20
50	products/saleor/static/placeholders/candy/1_YYj34QI.jpg	0.5x0.5		0	21
51	products/saleor/static/placeholders/candy/2_CtZUuBj.jpg	0.5x0.5		1	21
52	products/saleor/static/placeholders/candy/1_m2BJEz9.jpg	0.5x0.5		0	22
53	products/saleor/static/placeholders/candy/2_WkuE25f.jpg	0.5x0.5		1	22
54	products/saleor/static/placeholders/candy/1_vGXU3hB.jpg	0.5x0.5		0	23
55	products/saleor/static/placeholders/candy/1_ZuKLgnd.jpg	0.5x0.5		0	24
56	products/saleor/static/placeholders/candy/1_incNx8J.jpg	0.5x0.5		1	24
57	products/saleor/static/placeholders/candy/2_HzAuz2G.jpg	0.5x0.5		2	24
58	products/saleor/static/placeholders/candy/1_W04ZsWz.jpg	0.5x0.5		0	25
59	products/saleor/static/placeholders/candy/1_HDG3lio.jpg	0.5x0.5		0	26
60	products/saleor/static/placeholders/candy/1_tjiCPxQ.jpg	0.5x0.5		1	26
61	products/saleor/static/placeholders/candy/2_20K8Vcd.jpg	0.5x0.5		2	26
62	products/saleor/static/placeholders/candy/1_Z6q8WzZ.jpg	0.5x0.5		3	26
63	products/saleor/static/placeholders/candy/1_nPIwb0U.jpg	0.5x0.5		0	27
64	products/saleor/static/placeholders/candy/1_QQOT8B7.jpg	0.5x0.5		1	27
65	products/saleor/static/placeholders/candy/1_Z4JBPUq.jpg	0.5x0.5		0	28
66	products/saleor/static/placeholders/candy/2_irLl5Ir.jpg	0.5x0.5		1	28
67	products/saleor/static/placeholders/candy/1_HQMYb4s.jpg	0.5x0.5		0	29
68	products/saleor/static/placeholders/candy/1_LrO2gXm.jpg	0.5x0.5		1	29
69	products/saleor/static/placeholders/candy/2_k6PZD3S.jpg	0.5x0.5		0	30
70	products/saleor/static/placeholders/candy/1_IdGB0gA.jpg	0.5x0.5		1	30
71	products/saleor/static/placeholders/candy/2_57VLCxq.jpg	0.5x0.5		2	30
72	products/saleor/static/placeholders/t-shirts/5_ngSbius.jpg	0.5x0.5		0	31
73	products/saleor/static/placeholders/t-shirts/5_qPjHXX8.jpg	0.5x0.5		1	31
74	products/saleor/static/placeholders/t-shirts/5_pFBwx4D.jpg	0.5x0.5		2	31
75	products/saleor/static/placeholders/t-shirts/6_PQc9qCH.jpg	0.5x0.5		3	31
76	products/saleor/static/placeholders/t-shirts/5_36CbmUF.jpg	0.5x0.5		0	32
77	products/saleor/static/placeholders/t-shirts/6_uPv10Dk.jpg	0.5x0.5		1	32
78	products/saleor/static/placeholders/t-shirts/5_N4F0cQP.jpg	0.5x0.5		0	33
79	products/saleor/static/placeholders/t-shirts/6_d78q5nw.jpg	0.5x0.5		1	33
80	products/saleor/static/placeholders/t-shirts/6_qn81x1C.jpg	0.5x0.5		2	33
81	products/saleor/static/placeholders/t-shirts/6_mONfyT2.jpg	0.5x0.5		3	33
82	products/saleor/static/placeholders/t-shirts/5_PLcvDlG.jpg	0.5x0.5		0	34
83	products/saleor/static/placeholders/t-shirts/5_zfs7EVK.jpg	0.5x0.5		0	35
84	products/saleor/static/placeholders/t-shirts/6_iF975Km.jpg	0.5x0.5		1	35
85	products/saleor/static/placeholders/t-shirts/5_4ZQEV4f.jpg	0.5x0.5		2	35
86	products/saleor/static/placeholders/t-shirts/5_kOFirDt.jpg	0.5x0.5		0	36
87	products/saleor/static/placeholders/t-shirts/6_JjQGVmb.jpg	0.5x0.5		0	37
88	products/saleor/static/placeholders/t-shirts/6_XuRmS6N.jpg	0.5x0.5		1	37
89	products/saleor/static/placeholders/t-shirts/5_ovMaSGZ.jpg	0.5x0.5		2	37
90	products/saleor/static/placeholders/t-shirts/6_6MZKvmE.jpg	0.5x0.5		3	37
91	products/saleor/static/placeholders/t-shirts/6_JbQEoV5.jpg	0.5x0.5		0	38
92	products/saleor/static/placeholders/t-shirts/5_2lFu4cn.jpg	0.5x0.5		1	38
93	products/saleor/static/placeholders/t-shirts/6_nYEGVdi.jpg	0.5x0.5		2	38
94	products/saleor/static/placeholders/t-shirts/6_R1wVYTs.jpg	0.5x0.5		0	39
95	products/saleor/static/placeholders/t-shirts/5_rK6PzIe.jpg	0.5x0.5		0	40
96	products/saleor/static/placeholders/t-shirts/5_86vhafl.jpg	0.5x0.5		1	40
97	products/saleor/static/placeholders/t-shirts/6_C5C0Z4U.jpg	0.5x0.5		2	40
98	products/saleor/static/placeholders/books/book_01_NceCBpZ.jpg	0.5x0.5		0	41
99	products/saleor/static/placeholders/books/book_05_0dal5Za.jpg	0.5x0.5		0	42
100	products/saleor/static/placeholders/books/book_04_jmpZNjM.jpg	0.5x0.5		1	42
101	products/saleor/static/placeholders/books/book_02_woyrerG.jpg	0.5x0.5		2	42
102	products/saleor/static/placeholders/books/book_01_7pXV8re.jpg	0.5x0.5		3	42
103	products/saleor/static/placeholders/books/book_02_N91B4cZ.jpg	0.5x0.5		0	43
104	products/saleor/static/placeholders/books/book_03_cxvYdqI.jpg	0.5x0.5		1	43
105	products/saleor/static/placeholders/books/book_03_3GE0xv6.jpg	0.5x0.5		0	44
106	products/saleor/static/placeholders/books/book_04_XH4eByT.jpg	0.5x0.5		1	44
107	products/saleor/static/placeholders/books/book_01_fzA0F6p.jpg	0.5x0.5		0	45
108	products/saleor/static/placeholders/books/book_02_0ZSIC18.jpg	0.5x0.5		1	45
109	products/saleor/static/placeholders/books/book_04_RESSMe4.jpg	0.5x0.5		2	45
110	products/saleor/static/placeholders/books/book_02_PU92YHv.jpg	0.5x0.5		0	46
111	products/saleor/static/placeholders/books/book_03_0zKQUXC.jpg	0.5x0.5		1	46
112	products/saleor/static/placeholders/books/book_04_LBz43fx.jpg	0.5x0.5		2	46
113	products/saleor/static/placeholders/books/book_02_9g1AomH.jpg	0.5x0.5		0	47
114	products/saleor/static/placeholders/books/book_01_2KfJlw4.jpg	0.5x0.5		1	47
115	products/saleor/static/placeholders/books/book_02_GpCj0v8.jpg	0.5x0.5		2	47
116	products/saleor/static/placeholders/books/book_02_OQqbvLs.jpg	0.5x0.5		0	48
117	products/saleor/static/placeholders/books/book_03_PIu1p8l.jpg	0.5x0.5		1	48
118	products/saleor/static/placeholders/books/book_03_ghGlPCS.jpg	0.5x0.5		0	49
119	products/saleor/static/placeholders/books/book_04_77kVIIl.jpg	0.5x0.5		1	49
120	products/saleor/static/placeholders/books/book_02_If9l5zM.jpg	0.5x0.5		0	50
121	products/saleor/static/placeholders/books/book_02_dfgH59k.jpg	0.5x0.5		1	50
122	products/saleor/static/placeholders/books/book_03_n9zXYJB.jpg	0.5x0.5		2	50
123	products/saleor/static/placeholders/books/book_04_PV7Nzq3.jpg	0.5x0.5		0	51
124	products/saleor/static/placeholders/books/book_02_PyJeN1V.jpg	0.5x0.5		1	51
125	products/saleor/static/placeholders/books/book_04_xWHKwmk.jpg	0.5x0.5		2	51
126	products/saleor/static/placeholders/books/book_04_QeahPmq.jpg	0.5x0.5		0	52
127	products/saleor/static/placeholders/books/book_05_98o8L6Z.jpg	0.5x0.5		1	52
128	products/saleor/static/placeholders/books/book_02_gdqaw5x.jpg	0.5x0.5		2	52
129	products/saleor/static/placeholders/books/book_03_HNaH6EP.jpg	0.5x0.5		0	53
130	products/saleor/static/placeholders/books/book_05_KBcsD51.jpg	0.5x0.5		0	54
131	products/saleor/static/placeholders/books/book_04_471ZYIc.jpg	0.5x0.5		1	54
132	products/saleor/static/placeholders/books/book_02_wyBNCYr.jpg	0.5x0.5		0	55
133	products/saleor/static/placeholders/books/book_05_8Vg9axX.jpg	0.5x0.5		0	56
134	products/saleor/static/placeholders/books/book_04_WnlXsmw.jpg	0.5x0.5		1	56
135	products/saleor/static/placeholders/books/book_04_yLuY1eM.jpg	0.5x0.5		2	56
136	products/saleor/static/placeholders/books/book_03_OvVTbk2.jpg	0.5x0.5		3	56
137	products/saleor/static/placeholders/books/book_05_N1QOcBr.jpg	0.5x0.5		0	57
138	products/saleor/static/placeholders/books/book_03_TpTMg2S.jpg	0.5x0.5		1	57
139	products/saleor/static/placeholders/books/book_03_x7z8Xcj.jpg	0.5x0.5		0	58
140	products/saleor/static/placeholders/books/book_02_ZAaMVDh.jpg	0.5x0.5		1	58
141	products/saleor/static/placeholders/books/book_05_EKNUl00.jpg	0.5x0.5		2	58
142	products/saleor/static/placeholders/books/book_02_guL5b7B.jpg	0.5x0.5		3	58
143	products/saleor/static/placeholders/books/book_03_KXV4FHf.jpg	0.5x0.5		0	59
144	products/saleor/static/placeholders/books/book_04_o1VXh5p.jpg	0.5x0.5		0	60
145	products/saleor/static/placeholders/books/book_01_cRbCNUZ.jpg	0.5x0.5		1	60
146	products/saleor/static/placeholders/books/book_02_xgposv9.jpg	0.5x0.5		2	60
147	products/saleor/static/placeholders/coffee/coffee_03_dxOhZ0f.jpg	0.5x0.5		0	61
148	products/saleor/static/placeholders/coffee/coffee_03_OSFTyqE.jpg	0.5x0.5		0	62
149	products/saleor/static/placeholders/coffee/coffee_04_hHUN2ec.jpg	0.5x0.5		1	62
150	products/saleor/static/placeholders/coffee/coffee_01_YySextg.jpg	0.5x0.5		2	62
151	products/saleor/static/placeholders/coffee/coffee_04_bAUufk4.jpg	0.5x0.5		0	63
152	products/saleor/static/placeholders/coffee/8_klLopJr.jpg	0.5x0.5		1	63
153	products/saleor/static/placeholders/coffee/coffee_01_FKCUb0o.jpg	0.5x0.5		2	63
154	products/saleor/static/placeholders/coffee/coffee_02_Y7HxqFC.jpg	0.5x0.5		3	63
155	products/saleor/static/placeholders/coffee/coffee_04_Gu3Kl8C.jpg	0.5x0.5		0	64
156	products/saleor/static/placeholders/coffee/coffee_03_vMPIRLa.jpg	0.5x0.5		0	65
157	products/saleor/static/placeholders/coffee/coffee_03_3TW4vi9.jpg	0.5x0.5		1	65
158	products/saleor/static/placeholders/coffee/coffee_04_KW16u9F.jpg	0.5x0.5		2	65
159	products/saleor/static/placeholders/coffee/coffee_03_OYxXJda.jpg	0.5x0.5		0	66
160	products/saleor/static/placeholders/coffee/coffee_02_iscXn72.jpg	0.5x0.5		0	67
161	products/saleor/static/placeholders/coffee/coffee_01_17G2Glw.jpg	0.5x0.5		1	67
162	products/saleor/static/placeholders/coffee/coffee_04_fIYo3Zx.jpg	0.5x0.5		2	67
163	products/saleor/static/placeholders/coffee/coffee_02_wwf5FLW.jpg	0.5x0.5		3	67
164	products/saleor/static/placeholders/coffee/coffee_04_qFCGqU6.jpg	0.5x0.5		0	68
165	products/saleor/static/placeholders/coffee/coffee_04_yg8Lro3.jpg	0.5x0.5		0	69
166	products/saleor/static/placeholders/coffee/coffee_02_8pjnMgq.jpg	0.5x0.5		1	69
167	products/saleor/static/placeholders/coffee/coffee_02_KKicifH.jpg	0.5x0.5		2	69
168	products/saleor/static/placeholders/coffee/coffee_04_Q0b9ziV.jpg	0.5x0.5		3	69
169	products/saleor/static/placeholders/coffee/coffee_02_GMi6vub.jpg	0.5x0.5		0	70
170	products/saleor/static/placeholders/coffee/coffee_03_BQ6lIwd.jpg	0.5x0.5		1	70
171	products/saleor/static/placeholders/coffee/coffee_04_5a7HN2V.jpg	0.5x0.5		2	70
172	products/saleor/static/placeholders/coffee/8_2xgxT8l.jpg	0.5x0.5		3	70
173	products/saleor/static/placeholders/mugs/box_01_1g1AufZ.jpg	0.5x0.5		0	71
174	products/saleor/static/placeholders/mugs/box_01_MhXiBzB.jpg	0.5x0.5		1	71
175	products/saleor/static/placeholders/mugs/7_AI8DA3p.jpg	0.5x0.5		2	71
176	products/saleor/static/placeholders/mugs/box_01_yKB7zZa.jpg	0.5x0.5		3	71
177	products/saleor/static/placeholders/mugs/3_wDFqkFa.jpg	0.5x0.5		0	72
178	products/saleor/static/placeholders/mugs/4_YfocpQn.jpg	0.5x0.5		0	73
179	products/saleor/static/placeholders/mugs/3_EDQZeTw.jpg	0.5x0.5		1	73
180	products/saleor/static/placeholders/mugs/box_01_Vp8emHC.jpg	0.5x0.5		2	73
181	products/saleor/static/placeholders/mugs/3_3tHgTru.jpg	0.5x0.5		0	74
182	products/saleor/static/placeholders/mugs/3_FzETOsU.jpg	0.5x0.5		1	74
183	products/saleor/static/placeholders/mugs/7_ExWjENi.jpg	0.5x0.5		0	75
184	products/saleor/static/placeholders/mugs/box_01_mOBuMtC.jpg	0.5x0.5		1	75
185	products/saleor/static/placeholders/mugs/7_a9aTq0j.jpg	0.5x0.5		2	75
186	products/saleor/static/placeholders/mugs/7_qoZFvUB.jpg	0.5x0.5		0	76
187	products/saleor/static/placeholders/mugs/3_Ab4MA9A.jpg	0.5x0.5		1	76
188	products/saleor/static/placeholders/mugs/7_HJRTMxS.jpg	0.5x0.5		2	76
189	products/saleor/static/placeholders/mugs/4_5tLSkIa.jpg	0.5x0.5		3	76
190	products/saleor/static/placeholders/mugs/7_GEHisdT.jpg	0.5x0.5		0	77
191	products/saleor/static/placeholders/mugs/3_85oo2NS.jpg	0.5x0.5		1	77
192	products/saleor/static/placeholders/mugs/box_01_uv0xtYT.jpg	0.5x0.5		2	77
193	products/saleor/static/placeholders/mugs/7_exU8Dl5.jpg	0.5x0.5		0	78
194	products/saleor/static/placeholders/mugs/4_FAidIp8.jpg	0.5x0.5		1	78
195	products/saleor/static/placeholders/mugs/3_CIV3Rs8.jpg	0.5x0.5		2	78
196	products/saleor/static/placeholders/mugs/7_5C2EfCd.jpg	0.5x0.5		0	79
197	products/saleor/static/placeholders/mugs/box_01_vNCPMP0.jpg	0.5x0.5		1	79
198	products/saleor/static/placeholders/mugs/4_LMtmGPR.jpg	0.5x0.5		2	79
199	products/saleor/static/placeholders/mugs/box_01_j3VUqNE.jpg	0.5x0.5		3	79
200	products/saleor/static/placeholders/mugs/4_3burD33.jpg	0.5x0.5		0	80
201	products/saleor/static/placeholders/candy/2_JySoLTv.jpg	0.5x0.5		0	81
202	products/saleor/static/placeholders/candy/2_dQ28E0y.jpg	0.5x0.5		0	82
203	products/saleor/static/placeholders/candy/1_xwQierw.jpg	0.5x0.5		1	82
204	products/saleor/static/placeholders/candy/1_JGaGRZZ.jpg	0.5x0.5		2	82
205	products/saleor/static/placeholders/candy/2_2XlNUwd.jpg	0.5x0.5		0	83
206	products/saleor/static/placeholders/candy/1_rRu5mRE.jpg	0.5x0.5		1	83
207	products/saleor/static/placeholders/candy/2_agOO8TA.jpg	0.5x0.5		2	83
208	products/saleor/static/placeholders/candy/2_izZ6avr.jpg	0.5x0.5		3	83
209	products/saleor/static/placeholders/candy/1_SgvO3MT.jpg	0.5x0.5		0	84
210	products/saleor/static/placeholders/candy/1_wxTUr0I.jpg	0.5x0.5		1	84
211	products/saleor/static/placeholders/candy/2_5iqa16y.jpg	0.5x0.5		2	84
212	products/saleor/static/placeholders/candy/1_VvgkjVD.jpg	0.5x0.5		3	84
213	products/saleor/static/placeholders/candy/2_u5jQ7Sx.jpg	0.5x0.5		0	85
214	products/saleor/static/placeholders/candy/1_vkAhVjZ.jpg	0.5x0.5		1	85
215	products/saleor/static/placeholders/candy/2_eMlOUuJ.jpg	0.5x0.5		2	85
216	products/saleor/static/placeholders/candy/2_BKTK32P.jpg	0.5x0.5		0	86
217	products/saleor/static/placeholders/candy/2_HNGWktD.jpg	0.5x0.5		1	86
218	products/saleor/static/placeholders/candy/1_eVXU0Oz.jpg	0.5x0.5		2	86
219	products/saleor/static/placeholders/candy/2_t3TURLl.jpg	0.5x0.5		0	87
220	products/saleor/static/placeholders/candy/2_zPBz1nU.jpg	0.5x0.5		1	87
221	products/saleor/static/placeholders/candy/2_pos9v64.jpg	0.5x0.5		2	87
222	products/saleor/static/placeholders/candy/2_K14RP31.jpg	0.5x0.5		0	88
223	products/saleor/static/placeholders/candy/1_KUAFTx7.jpg	0.5x0.5		1	88
224	products/saleor/static/placeholders/candy/1_rkaPLa9.jpg	0.5x0.5		2	88
225	products/saleor/static/placeholders/candy/2_IXlv2Yy.jpg	0.5x0.5		3	88
226	products/saleor/static/placeholders/candy/2_cReRqWU.jpg	0.5x0.5		0	89
227	products/saleor/static/placeholders/candy/1_kFphML9.jpg	0.5x0.5		1	89
228	products/saleor/static/placeholders/candy/2_3jyAqde.jpg	0.5x0.5		2	89
229	products/saleor/static/placeholders/candy/2_CHxVPcG.jpg	0.5x0.5		0	90
230	products/saleor/static/placeholders/candy/2_ibJpfXC.jpg	0.5x0.5		1	90
231	products/saleor/static/placeholders/candy/1_8ohfr8o.jpg	0.5x0.5		2	90
232	products/saleor/static/placeholders/t-shirts/6_78jkpJn.jpg	0.5x0.5		0	91
233	products/saleor/static/placeholders/t-shirts/5_v1VtDwz.jpg	0.5x0.5		1	91
234	products/saleor/static/placeholders/t-shirts/6_q987Ud9.jpg	0.5x0.5		0	92
235	products/saleor/static/placeholders/t-shirts/6_ha0wwRf.jpg	0.5x0.5		0	93
236	products/saleor/static/placeholders/t-shirts/5_ft9ivM9.jpg	0.5x0.5		0	94
237	products/saleor/static/placeholders/t-shirts/5_PRefF5V.jpg	0.5x0.5		1	94
238	products/saleor/static/placeholders/t-shirts/6_0uxjIgy.jpg	0.5x0.5		2	94
239	products/saleor/static/placeholders/t-shirts/5_CnqHT7i.jpg	0.5x0.5		3	94
240	products/saleor/static/placeholders/t-shirts/5_InE5lv0.jpg	0.5x0.5		0	95
241	products/saleor/static/placeholders/t-shirts/6_AlntHrT.jpg	0.5x0.5		1	95
242	products/saleor/static/placeholders/t-shirts/6_C47bDHh.jpg	0.5x0.5		2	95
243	products/saleor/static/placeholders/t-shirts/5_etRRQWg.jpg	0.5x0.5		3	95
244	products/saleor/static/placeholders/t-shirts/6_bnFXCVC.jpg	0.5x0.5		0	96
245	products/saleor/static/placeholders/t-shirts/5_2vjkEy4.jpg	0.5x0.5		1	96
246	products/saleor/static/placeholders/t-shirts/5_fNpsMUL.jpg	0.5x0.5		0	97
247	products/saleor/static/placeholders/t-shirts/5_ACwd2mi.jpg	0.5x0.5		1	97
248	products/saleor/static/placeholders/t-shirts/6_H4C46Bj.jpg	0.5x0.5		0	98
249	products/saleor/static/placeholders/t-shirts/5_EaJsj3r.jpg	0.5x0.5		1	98
250	products/saleor/static/placeholders/t-shirts/6_fvseHcM.jpg	0.5x0.5		2	98
251	products/saleor/static/placeholders/t-shirts/5_jSYBhZq.jpg	0.5x0.5		3	98
252	products/saleor/static/placeholders/t-shirts/5_lLtVQom.jpg	0.5x0.5		0	99
253	products/saleor/static/placeholders/t-shirts/5_Gn1v9oV.jpg	0.5x0.5		1	99
254	products/saleor/static/placeholders/t-shirts/5_fxLBcOs.jpg	0.5x0.5		2	99
255	products/saleor/static/placeholders/t-shirts/5_JAXSdQU.jpg	0.5x0.5		3	99
256	products/saleor/static/placeholders/t-shirts/6_6tlGQrl.jpg	0.5x0.5		0	100
257	products/saleor/static/placeholders/t-shirts/5_HSIj9gC.jpg	0.5x0.5		1	100
258	products/saleor/static/placeholders/books/book_05_T6tCqJJ.jpg	0.5x0.5		0	101
259	products/saleor/static/placeholders/books/book_04_uIbxE94.jpg	0.5x0.5		1	101
260	products/saleor/static/placeholders/books/book_04_Hcr8pgk.jpg	0.5x0.5		2	101
261	products/saleor/static/placeholders/books/book_01_IrrWkYq.jpg	0.5x0.5		0	102
262	products/saleor/static/placeholders/books/book_01_kdNSk6i.jpg	0.5x0.5		1	102
263	products/saleor/static/placeholders/books/book_03_H1BV0Wo.jpg	0.5x0.5		0	103
264	products/saleor/static/placeholders/books/book_04_38VpBTt.jpg	0.5x0.5		1	103
265	products/saleor/static/placeholders/books/book_03_Xt7vjgc.jpg	0.5x0.5		2	103
266	products/saleor/static/placeholders/books/book_04_dPlPaGv.jpg	0.5x0.5		3	103
267	products/saleor/static/placeholders/books/book_04_iWdwrET.jpg	0.5x0.5		0	104
268	products/saleor/static/placeholders/books/book_01_5cssGCo.jpg	0.5x0.5		1	104
269	products/saleor/static/placeholders/books/book_02_1frZQf3.jpg	0.5x0.5		0	105
270	products/saleor/static/placeholders/books/book_01_QaSSR8f.jpg	0.5x0.5		0	106
271	products/saleor/static/placeholders/books/book_02_yqCespc.jpg	0.5x0.5		1	106
272	products/saleor/static/placeholders/books/book_03_ZRNBrMA.jpg	0.5x0.5		0	107
273	products/saleor/static/placeholders/books/book_04_sFbs9VJ.jpg	0.5x0.5		1	107
274	products/saleor/static/placeholders/books/book_04_4VaV4nx.jpg	0.5x0.5		2	107
275	products/saleor/static/placeholders/books/book_02_RlUYlr7.jpg	0.5x0.5		0	108
276	products/saleor/static/placeholders/books/book_02_Ih9LM1r.jpg	0.5x0.5		1	108
277	products/saleor/static/placeholders/books/book_05_TgM7MXL.jpg	0.5x0.5		2	108
278	products/saleor/static/placeholders/books/book_03_3jV7CY2.jpg	0.5x0.5		3	108
279	products/saleor/static/placeholders/books/book_02_P1Z0KWC.jpg	0.5x0.5		0	109
280	products/saleor/static/placeholders/books/book_04_T6mWHZU.jpg	0.5x0.5		0	110
281	products/saleor/static/placeholders/books/book_04_gb0yDMN.jpg	0.5x0.5		0	111
282	products/saleor/static/placeholders/books/book_05_AJNUhvT.jpg	0.5x0.5		1	111
283	products/saleor/static/placeholders/books/book_05_NbMhXbG.jpg	0.5x0.5		2	111
284	products/saleor/static/placeholders/books/book_05_493KHpj.jpg	0.5x0.5		3	111
285	products/saleor/static/placeholders/books/book_04_bZHmqVa.jpg	0.5x0.5		0	112
286	products/saleor/static/placeholders/books/book_03_vQRPHfn.jpg	0.5x0.5		1	112
287	products/saleor/static/placeholders/books/book_05_Dk9FckC.jpg	0.5x0.5		2	112
288	products/saleor/static/placeholders/books/book_01_yJ750rz.jpg	0.5x0.5		3	112
289	products/saleor/static/placeholders/books/book_03_knrunGU.jpg	0.5x0.5		0	113
290	products/saleor/static/placeholders/books/book_05_PwAEXvN.jpg	0.5x0.5		1	113
291	products/saleor/static/placeholders/books/book_03_glv4Z5b.jpg	0.5x0.5		2	113
292	products/saleor/static/placeholders/books/book_05_TaiSc9n.jpg	0.5x0.5		3	113
293	products/saleor/static/placeholders/books/book_05_8Fg0qKq.jpg	0.5x0.5		0	114
294	products/saleor/static/placeholders/books/book_03_2GxIC5M.jpg	0.5x0.5		1	114
295	products/saleor/static/placeholders/books/book_05_Qmzk1yw.jpg	0.5x0.5		0	115
296	products/saleor/static/placeholders/books/book_05_ObEe3bK.jpg	0.5x0.5		1	115
297	products/saleor/static/placeholders/books/book_03_nXjHuuU.jpg	0.5x0.5		2	115
298	products/saleor/static/placeholders/books/book_03_99rc76I.jpg	0.5x0.5		3	115
299	products/saleor/static/placeholders/books/book_05_29NmSfe.jpg	0.5x0.5		0	116
300	products/saleor/static/placeholders/books/book_03_pZzrTrN.jpg	0.5x0.5		1	116
301	products/saleor/static/placeholders/books/book_02_vZH7nK7.jpg	0.5x0.5		2	116
302	products/saleor/static/placeholders/books/book_02_IDX3Kji.jpg	0.5x0.5		0	117
303	products/saleor/static/placeholders/books/book_02_J3JALiz.jpg	0.5x0.5		1	117
304	products/saleor/static/placeholders/books/book_01_B5cbLdr.jpg	0.5x0.5		2	117
305	products/saleor/static/placeholders/books/book_05_xV3hnMA.jpg	0.5x0.5		3	117
306	products/saleor/static/placeholders/books/book_04_AFMre5R.jpg	0.5x0.5		0	118
307	products/saleor/static/placeholders/books/book_05_VZqIqid.jpg	0.5x0.5		1	118
308	products/saleor/static/placeholders/books/book_05_udLI5T9.jpg	0.5x0.5		2	118
309	products/saleor/static/placeholders/books/book_04_7TFDlr5.jpg	0.5x0.5		0	119
310	products/saleor/static/placeholders/books/book_03_gxEh9zb.jpg	0.5x0.5		1	119
311	products/saleor/static/placeholders/books/book_05_qzRCwk1.jpg	0.5x0.5		0	120
312	products/saleor/static/placeholders/books/book_05_WKHxObm.jpg	0.5x0.5		1	120
313	products/saleor/static/placeholders/books/book_01_d7cvqfm.jpg	0.5x0.5		2	120
314	products/saleor/static/placeholders/coffee/coffee_03_JAGG46l.jpg	0.5x0.5		0	121
315	products/saleor/static/placeholders/coffee/coffee_03_8940NZN.jpg	0.5x0.5		0	122
316	products/saleor/static/placeholders/coffee/8_bfFeWiW.jpg	0.5x0.5		1	122
317	products/saleor/static/placeholders/coffee/coffee_04_zjgYvSx.jpg	0.5x0.5		0	123
318	products/saleor/static/placeholders/coffee/coffee_04_XxujHgm.jpg	0.5x0.5		1	123
319	products/saleor/static/placeholders/coffee/8_q6hiFij.jpg	0.5x0.5		2	123
320	products/saleor/static/placeholders/coffee/8_OYAiBm1.jpg	0.5x0.5		3	123
321	products/saleor/static/placeholders/coffee/coffee_01_m5Bviqn.jpg	0.5x0.5		0	124
322	products/saleor/static/placeholders/coffee/8_37PY3Bh.jpg	0.5x0.5		1	124
323	products/saleor/static/placeholders/coffee/coffee_01_GazPskQ.jpg	0.5x0.5		0	125
324	products/saleor/static/placeholders/coffee/coffee_04_x15iqc1.jpg	0.5x0.5		1	125
325	products/saleor/static/placeholders/coffee/coffee_04_tWi8AUB.jpg	0.5x0.5		0	126
326	products/saleor/static/placeholders/coffee/coffee_03_o40OW1P.jpg	0.5x0.5		1	126
327	products/saleor/static/placeholders/coffee/coffee_02_mxtTPNr.jpg	0.5x0.5		2	126
328	products/saleor/static/placeholders/coffee/coffee_03_5VRcrur.jpg	0.5x0.5		0	127
329	products/saleor/static/placeholders/coffee/coffee_04_GqV3Ct5.jpg	0.5x0.5		1	127
330	products/saleor/static/placeholders/coffee/coffee_03_8jnerKJ.jpg	0.5x0.5		2	127
331	products/saleor/static/placeholders/coffee/8_rxp6UfN.jpg	0.5x0.5		3	127
332	products/saleor/static/placeholders/coffee/coffee_04_vajqXMs.jpg	0.5x0.5		0	128
333	products/saleor/static/placeholders/coffee/coffee_02_O5q9T4A.jpg	0.5x0.5		1	128
334	products/saleor/static/placeholders/coffee/8_Lxa5GqA.jpg	0.5x0.5		2	128
335	products/saleor/static/placeholders/coffee/coffee_01_QygX8lZ.jpg	0.5x0.5		0	129
336	products/saleor/static/placeholders/coffee/8_SLOpGKL.jpg	0.5x0.5		1	129
337	products/saleor/static/placeholders/coffee/coffee_02_vwlPLOG.jpg	0.5x0.5		2	129
338	products/saleor/static/placeholders/coffee/coffee_02_3rangca.jpg	0.5x0.5		3	129
339	products/saleor/static/placeholders/coffee/coffee_02_L91TJBA.jpg	0.5x0.5		0	130
340	products/saleor/static/placeholders/coffee/coffee_04_47reWAp.jpg	0.5x0.5		1	130
341	products/saleor/static/placeholders/coffee/coffee_02_z8zQYgW.jpg	0.5x0.5		2	130
342	products/saleor/static/placeholders/coffee/coffee_01_qxgDCH1.jpg	0.5x0.5		3	130
343	products/saleor/static/placeholders/mugs/4_s9ppbW9.jpg	0.5x0.5		0	131
344	products/saleor/static/placeholders/mugs/7_pUxD19C.jpg	0.5x0.5		0	132
345	products/saleor/static/placeholders/mugs/7_IwPLcPf.jpg	0.5x0.5		1	132
346	products/saleor/static/placeholders/mugs/box_01_G57fWI1.jpg	0.5x0.5		0	133
347	products/saleor/static/placeholders/mugs/box_01_MyblfDn.jpg	0.5x0.5		1	133
348	products/saleor/static/placeholders/mugs/3_3Z5jCzc.jpg	0.5x0.5		0	134
349	products/saleor/static/placeholders/mugs/4_jyTVqlF.jpg	0.5x0.5		1	134
350	products/saleor/static/placeholders/mugs/7_wziZ0GZ.jpg	0.5x0.5		0	135
351	products/saleor/static/placeholders/mugs/7_KCjwIdb.jpg	0.5x0.5		1	135
352	products/saleor/static/placeholders/mugs/3_6rBriCn.jpg	0.5x0.5		2	135
353	products/saleor/static/placeholders/mugs/7_Ez2dCOV.jpg	0.5x0.5		0	136
354	products/saleor/static/placeholders/mugs/3_3wqtoct.jpg	0.5x0.5		1	136
355	products/saleor/static/placeholders/mugs/3_luWxgMV.jpg	0.5x0.5		2	136
356	products/saleor/static/placeholders/mugs/box_01_s5j6beS.jpg	0.5x0.5		3	136
357	products/saleor/static/placeholders/mugs/4_3l9ESIB.jpg	0.5x0.5		0	137
358	products/saleor/static/placeholders/mugs/4_2Rr1RI8.jpg	0.5x0.5		1	137
359	products/saleor/static/placeholders/mugs/3_by2qyAX.jpg	0.5x0.5		0	138
360	products/saleor/static/placeholders/mugs/4_1S7M4GS.jpg	0.5x0.5		0	139
361	products/saleor/static/placeholders/mugs/box_01_xpR5X8b.jpg	0.5x0.5		1	139
362	products/saleor/static/placeholders/mugs/3_oO00JcP.jpg	0.5x0.5		0	140
363	products/saleor/static/placeholders/candy/1_Uzh1E3w.jpg	0.5x0.5		0	141
364	products/saleor/static/placeholders/candy/1_MdYxoWp.jpg	0.5x0.5		1	141
365	products/saleor/static/placeholders/candy/2_6E6ih98.jpg	0.5x0.5		2	141
366	products/saleor/static/placeholders/candy/1_mk3mi6I.jpg	0.5x0.5		0	142
367	products/saleor/static/placeholders/candy/1_wSCptQm.jpg	0.5x0.5		1	142
368	products/saleor/static/placeholders/candy/2_MdPcIsl.jpg	0.5x0.5		2	142
369	products/saleor/static/placeholders/candy/2_TAEQax6.jpg	0.5x0.5		0	143
370	products/saleor/static/placeholders/candy/1_7DCMT7U.jpg	0.5x0.5		0	144
371	products/saleor/static/placeholders/candy/2_qtbuZsT.jpg	0.5x0.5		1	144
372	products/saleor/static/placeholders/candy/1_llDb71x.jpg	0.5x0.5		2	144
373	products/saleor/static/placeholders/candy/1_tx6F38p.jpg	0.5x0.5		0	145
374	products/saleor/static/placeholders/candy/2_wywouZj.jpg	0.5x0.5		0	146
375	products/saleor/static/placeholders/candy/2_o4TFsuH.jpg	0.5x0.5		1	146
376	products/saleor/static/placeholders/candy/2_kOAZu1V.jpg	0.5x0.5		0	147
377	products/saleor/static/placeholders/candy/2_2krynjo.jpg	0.5x0.5		1	147
378	products/saleor/static/placeholders/candy/1_cXgA7me.jpg	0.5x0.5		2	147
379	products/saleor/static/placeholders/candy/2_7DWjkuy.jpg	0.5x0.5		0	148
380	products/saleor/static/placeholders/candy/2_Zsu4xeW.jpg	0.5x0.5		1	148
381	products/saleor/static/placeholders/candy/1_hTMENdZ.jpg	0.5x0.5		2	148
382	products/saleor/static/placeholders/candy/1_P7RMEyH.jpg	0.5x0.5		0	149
383	products/saleor/static/placeholders/candy/2_6CshuE7.jpg	0.5x0.5		1	149
384	products/saleor/static/placeholders/candy/1_tXSnoUS.jpg	0.5x0.5		2	149
385	products/saleor/static/placeholders/candy/1_SaliJlb.jpg	0.5x0.5		3	149
386	products/saleor/static/placeholders/candy/2_OqIzLfy.jpg	0.5x0.5		0	150
387	products/saleor/static/placeholders/t-shirts/6_KrXh8ka.jpg	0.5x0.5		0	151
388	products/saleor/static/placeholders/t-shirts/5_hZ8nrDY.jpg	0.5x0.5		1	151
389	products/saleor/static/placeholders/t-shirts/6_AZH7kGW.jpg	0.5x0.5		0	152
390	products/saleor/static/placeholders/t-shirts/5_5wluswm.jpg	0.5x0.5		1	152
391	products/saleor/static/placeholders/t-shirts/5_FgS8238.jpg	0.5x0.5		2	152
392	products/saleor/static/placeholders/t-shirts/6_nLNztJu.jpg	0.5x0.5		0	153
393	products/saleor/static/placeholders/t-shirts/6_RAnyoaa.jpg	0.5x0.5		1	153
394	products/saleor/static/placeholders/t-shirts/6_iy57PIT.jpg	0.5x0.5		2	153
395	products/saleor/static/placeholders/t-shirts/5_y93Inu1.jpg	0.5x0.5		3	153
396	products/saleor/static/placeholders/t-shirts/5_aoZM9nf.jpg	0.5x0.5		0	154
397	products/saleor/static/placeholders/t-shirts/6_C6SCPO1.jpg	0.5x0.5		0	155
398	products/saleor/static/placeholders/t-shirts/6_QiqfzZd.jpg	0.5x0.5		1	155
399	products/saleor/static/placeholders/t-shirts/6_qTMICTb.jpg	0.5x0.5		0	156
400	products/saleor/static/placeholders/t-shirts/6_EvG4gn4.jpg	0.5x0.5		1	156
401	products/saleor/static/placeholders/t-shirts/6_rmlNYwy.jpg	0.5x0.5		2	156
402	products/saleor/static/placeholders/t-shirts/5_VxLa1aB.jpg	0.5x0.5		0	157
403	products/saleor/static/placeholders/t-shirts/5_uG5qmqu.jpg	0.5x0.5		1	157
404	products/saleor/static/placeholders/t-shirts/5_o32j34w.jpg	0.5x0.5		2	157
405	products/saleor/static/placeholders/t-shirts/5_xbuTRcE.jpg	0.5x0.5		3	157
406	products/saleor/static/placeholders/t-shirts/6_4zp1Bns.jpg	0.5x0.5		0	158
407	products/saleor/static/placeholders/t-shirts/5_IFoHBGH.jpg	0.5x0.5		1	158
408	products/saleor/static/placeholders/t-shirts/6_89Xw8Mv.jpg	0.5x0.5		2	158
409	products/saleor/static/placeholders/t-shirts/5_ixCzjAf.jpg	0.5x0.5		3	158
410	products/saleor/static/placeholders/t-shirts/5_YbINQ07.jpg	0.5x0.5		0	159
411	products/saleor/static/placeholders/t-shirts/6_mPm2Its.jpg	0.5x0.5		0	160
412	products/saleor/static/placeholders/t-shirts/5_mBoci8v.jpg	0.5x0.5		1	160
413	products/saleor/static/placeholders/t-shirts/5_XqpnXVZ.jpg	0.5x0.5		2	160
414	products/saleor/static/placeholders/t-shirts/5_ObC0Z2u.jpg	0.5x0.5		3	160
415	products/saleor/static/placeholders/books/book_01_oe30ExE.jpg	0.5x0.5		0	161
416	products/saleor/static/placeholders/books/book_01_acpKxIP.jpg	0.5x0.5		1	161
417	products/saleor/static/placeholders/books/book_02_d6Ku61s.jpg	0.5x0.5		2	161
418	products/saleor/static/placeholders/books/book_05_6IM70pE.jpg	0.5x0.5		3	161
419	products/saleor/static/placeholders/books/book_03_G0flgU3.jpg	0.5x0.5		0	162
420	products/saleor/static/placeholders/books/book_01_lbqbJe9.jpg	0.5x0.5		1	162
421	products/saleor/static/placeholders/books/book_01_48DiIvi.jpg	0.5x0.5		2	162
422	products/saleor/static/placeholders/books/book_01_5vg07op.jpg	0.5x0.5		3	162
423	products/saleor/static/placeholders/books/book_04_hiZSaXM.jpg	0.5x0.5		0	163
424	products/saleor/static/placeholders/books/book_02_tvWMqPZ.jpg	0.5x0.5		1	163
425	products/saleor/static/placeholders/books/book_04_K1Nc13a.jpg	0.5x0.5		2	163
426	products/saleor/static/placeholders/books/book_03_GqLCs4O.jpg	0.5x0.5		0	164
427	products/saleor/static/placeholders/books/book_01_ISJBXd1.jpg	0.5x0.5		0	165
428	products/saleor/static/placeholders/books/book_01_jZrfaO0.jpg	0.5x0.5		0	166
429	products/saleor/static/placeholders/books/book_05_Lk7e9E4.jpg	0.5x0.5		1	166
430	products/saleor/static/placeholders/books/book_05_vunPDMu.jpg	0.5x0.5		2	166
431	products/saleor/static/placeholders/books/book_02_TLoFFCl.jpg	0.5x0.5		3	166
432	products/saleor/static/placeholders/books/book_02_0q0CC5J.jpg	0.5x0.5		0	167
433	products/saleor/static/placeholders/books/book_02_Oo0I9QP.jpg	0.5x0.5		0	168
434	products/saleor/static/placeholders/books/book_05_507Q4ZS.jpg	0.5x0.5		1	168
435	products/saleor/static/placeholders/books/book_05_eB2pFye.jpg	0.5x0.5		2	168
436	products/saleor/static/placeholders/books/book_01_mh4EXiB.jpg	0.5x0.5		0	169
437	products/saleor/static/placeholders/books/book_03_F93ONcD.jpg	0.5x0.5		1	169
438	products/saleor/static/placeholders/books/book_05_spwZCrM.jpg	0.5x0.5		2	169
439	products/saleor/static/placeholders/books/book_03_WBR5CBf.jpg	0.5x0.5		0	170
440	products/saleor/static/placeholders/books/book_05_3oQbuJa.jpg	0.5x0.5		0	171
441	products/saleor/static/placeholders/books/book_02_TMB5Xn8.jpg	0.5x0.5		1	171
442	products/saleor/static/placeholders/books/book_02_RQ7Zn3f.jpg	0.5x0.5		0	172
443	products/saleor/static/placeholders/books/book_05_JlJZidQ.jpg	0.5x0.5		1	172
444	products/saleor/static/placeholders/books/book_01_0xIJQt3.jpg	0.5x0.5		0	173
445	products/saleor/static/placeholders/books/book_02_ViZzXbj.jpg	0.5x0.5		1	173
446	products/saleor/static/placeholders/books/book_01_0KjfLFW.jpg	0.5x0.5		0	174
447	products/saleor/static/placeholders/books/book_04_LBwR6lU.jpg	0.5x0.5		1	174
448	products/saleor/static/placeholders/books/book_03_w1FgQ9F.jpg	0.5x0.5		2	174
449	products/saleor/static/placeholders/books/book_02_gBLtiMI.jpg	0.5x0.5		0	175
450	products/saleor/static/placeholders/books/book_01_EidpqWH.jpg	0.5x0.5		1	175
451	products/saleor/static/placeholders/books/book_05_1QrJypW.jpg	0.5x0.5		0	176
452	products/saleor/static/placeholders/books/book_02_g57xkWT.jpg	0.5x0.5		1	176
453	products/saleor/static/placeholders/books/book_05_CYltX15.jpg	0.5x0.5		2	176
454	products/saleor/static/placeholders/books/book_04_axYNwVT.jpg	0.5x0.5		3	176
455	products/saleor/static/placeholders/books/book_02_qESBjMm.jpg	0.5x0.5		0	177
456	products/saleor/static/placeholders/books/book_04_aQmNRVK.jpg	0.5x0.5		1	177
457	products/saleor/static/placeholders/books/book_02_mXSpDqJ.jpg	0.5x0.5		0	178
458	products/saleor/static/placeholders/books/book_01_F1Zvg29.jpg	0.5x0.5		0	179
459	products/saleor/static/placeholders/books/book_05_SUipoef.jpg	0.5x0.5		1	179
460	products/saleor/static/placeholders/books/book_05_TH3AvyU.jpg	0.5x0.5		2	179
461	products/saleor/static/placeholders/books/book_03_EuCSe8x.jpg	0.5x0.5		0	180
462	products/saleor/static/placeholders/books/book_01_UjombcD.jpg	0.5x0.5		1	180
463	products/saleor/static/placeholders/books/book_02_Ve4DB2O.jpg	0.5x0.5		2	180
464	products/saleor/static/placeholders/coffee/coffee_02_xfkdNZC.jpg	0.5x0.5		0	181
465	products/saleor/static/placeholders/coffee/coffee_01_P5XKrTR.jpg	0.5x0.5		1	181
466	products/saleor/static/placeholders/coffee/coffee_04_U7Vih7g.jpg	0.5x0.5		2	181
467	products/saleor/static/placeholders/coffee/coffee_04_M4M1LBU.jpg	0.5x0.5		3	181
468	products/saleor/static/placeholders/coffee/coffee_01_BaONGpt.jpg	0.5x0.5		0	182
469	products/saleor/static/placeholders/coffee/coffee_03_umHIblT.jpg	0.5x0.5		0	183
470	products/saleor/static/placeholders/coffee/coffee_03_uVet9Gc.jpg	0.5x0.5		1	183
471	products/saleor/static/placeholders/coffee/coffee_03_Y5O8rdM.jpg	0.5x0.5		2	183
472	products/saleor/static/placeholders/coffee/coffee_02_c72mwGM.jpg	0.5x0.5		3	183
473	products/saleor/static/placeholders/coffee/coffee_01_PcQNtBZ.jpg	0.5x0.5		0	184
474	products/saleor/static/placeholders/coffee/coffee_01_DGhIV4S.jpg	0.5x0.5		1	184
475	products/saleor/static/placeholders/coffee/coffee_03_mHE5bOa.jpg	0.5x0.5		0	185
476	products/saleor/static/placeholders/coffee/coffee_01_mmbinCj.jpg	0.5x0.5		1	185
477	products/saleor/static/placeholders/coffee/coffee_01_aZDpLS1.jpg	0.5x0.5		2	185
478	products/saleor/static/placeholders/coffee/coffee_04_2PlBOs5.jpg	0.5x0.5		3	185
479	products/saleor/static/placeholders/coffee/coffee_01_Oe0mVAG.jpg	0.5x0.5		0	186
480	products/saleor/static/placeholders/coffee/coffee_03_3VZjX6C.jpg	0.5x0.5		1	186
481	products/saleor/static/placeholders/coffee/8_1BIAd7v.jpg	0.5x0.5		2	186
482	products/saleor/static/placeholders/coffee/coffee_02_S3MhM8n.jpg	0.5x0.5		3	186
483	products/saleor/static/placeholders/coffee/8_ZVRseID.jpg	0.5x0.5		0	187
484	products/saleor/static/placeholders/coffee/coffee_01_t90v5dS.jpg	0.5x0.5		1	187
485	products/saleor/static/placeholders/coffee/8_FUIGvgq.jpg	0.5x0.5		2	187
486	products/saleor/static/placeholders/coffee/8_vDhALot.jpg	0.5x0.5		3	187
487	products/saleor/static/placeholders/coffee/8_bktNrUo.jpg	0.5x0.5		0	188
488	products/saleor/static/placeholders/coffee/coffee_01_zzSENyR.jpg	0.5x0.5		1	188
489	products/saleor/static/placeholders/coffee/8_7g4kraq.jpg	0.5x0.5		2	188
490	products/saleor/static/placeholders/coffee/coffee_01_8jJEEbR.jpg	0.5x0.5		0	189
491	products/saleor/static/placeholders/coffee/coffee_03_ZEPUfWG.jpg	0.5x0.5		1	189
492	products/saleor/static/placeholders/coffee/coffee_03_NI4fKOJ.jpg	0.5x0.5		0	190
493	products/saleor/static/placeholders/coffee/coffee_03_tFsKWzN.jpg	0.5x0.5		1	190
494	products/saleor/static/placeholders/coffee/coffee_04_NZF1F17.jpg	0.5x0.5		2	190
495	products/saleor/static/placeholders/coffee/coffee_03_GkwEo1H.jpg	0.5x0.5		3	190
496	products/saleor/static/placeholders/mugs/7_qvz2fyZ.jpg	0.5x0.5		0	191
497	products/saleor/static/placeholders/mugs/7_EpKiRGP.jpg	0.5x0.5		1	191
498	products/saleor/static/placeholders/mugs/3_iJaLjTp.jpg	0.5x0.5		0	192
499	products/saleor/static/placeholders/mugs/7_K9ZeSaW.jpg	0.5x0.5		1	192
500	products/saleor/static/placeholders/mugs/box_01_5Xfin7J.jpg	0.5x0.5		2	192
501	products/saleor/static/placeholders/mugs/3_n3Lv66A.jpg	0.5x0.5		0	193
502	products/saleor/static/placeholders/mugs/4_fwx6NIs.jpg	0.5x0.5		1	193
503	products/saleor/static/placeholders/mugs/4_nRAuUsv.jpg	0.5x0.5		2	193
504	products/saleor/static/placeholders/mugs/box_01_6SCIbXJ.jpg	0.5x0.5		3	193
505	products/saleor/static/placeholders/mugs/box_01_nX2hysJ.jpg	0.5x0.5		0	194
506	products/saleor/static/placeholders/mugs/4_TSIlkUh.jpg	0.5x0.5		0	195
507	products/saleor/static/placeholders/mugs/box_01_lyqREai.jpg	0.5x0.5		0	196
508	products/saleor/static/placeholders/mugs/3_d5yWBHK.jpg	0.5x0.5		1	196
509	products/saleor/static/placeholders/mugs/box_01_hb3YTAK.jpg	0.5x0.5		0	197
510	products/saleor/static/placeholders/mugs/7_TWOVHPw.jpg	0.5x0.5		1	197
511	products/saleor/static/placeholders/mugs/4_XiWja9r.jpg	0.5x0.5		2	197
512	products/saleor/static/placeholders/mugs/3_Qp7eV63.jpg	0.5x0.5		0	198
513	products/saleor/static/placeholders/mugs/7_ZhCDWdG.jpg	0.5x0.5		1	198
514	products/saleor/static/placeholders/mugs/3_oy7pm2W.jpg	0.5x0.5		2	198
515	products/saleor/static/placeholders/mugs/4_QZC7m2z.jpg	0.5x0.5		3	198
516	products/saleor/static/placeholders/mugs/3_RLKe0AA.jpg	0.5x0.5		0	199
517	products/saleor/static/placeholders/mugs/4_Jg03KLY.jpg	0.5x0.5		1	199
518	products/saleor/static/placeholders/mugs/7_ZQ3HdrV.jpg	0.5x0.5		2	199
519	products/saleor/static/placeholders/mugs/box_01_hYE14Gt.jpg	0.5x0.5		0	200
520	products/saleor/static/placeholders/candy/2_QSaWVMB.jpg	0.5x0.5		0	201
521	products/saleor/static/placeholders/candy/2_EXrvNyJ.jpg	0.5x0.5		0	202
522	products/saleor/static/placeholders/candy/2_aQ82I2P.jpg	0.5x0.5		1	202
523	products/saleor/static/placeholders/candy/2_Y5iQmY4.jpg	0.5x0.5		2	202
524	products/saleor/static/placeholders/candy/1_yQwPqqY.jpg	0.5x0.5		0	203
525	products/saleor/static/placeholders/candy/1_xFAbkkI.jpg	0.5x0.5		0	204
526	products/saleor/static/placeholders/candy/1_7an54WB.jpg	0.5x0.5		1	204
527	products/saleor/static/placeholders/candy/1_v8lFSIN.jpg	0.5x0.5		2	204
528	products/saleor/static/placeholders/candy/1_j6FDHQX.jpg	0.5x0.5		0	205
529	products/saleor/static/placeholders/candy/1_6Pf7DSl.jpg	0.5x0.5		1	205
530	products/saleor/static/placeholders/candy/2_6wkcFJu.jpg	0.5x0.5		2	205
531	products/saleor/static/placeholders/candy/1_SPCAR8T.jpg	0.5x0.5		0	206
532	products/saleor/static/placeholders/candy/2_GfS8E7M.jpg	0.5x0.5		0	207
533	products/saleor/static/placeholders/candy/1_QL8ih6n.jpg	0.5x0.5		1	207
534	products/saleor/static/placeholders/candy/2_ov65Fro.jpg	0.5x0.5		0	208
535	products/saleor/static/placeholders/candy/1_w222W9K.jpg	0.5x0.5		1	208
536	products/saleor/static/placeholders/candy/1_2bgp2K5.jpg	0.5x0.5		2	208
537	products/saleor/static/placeholders/candy/2_jOt4PQp.jpg	0.5x0.5		3	208
538	products/saleor/static/placeholders/candy/1_6s5rYBj.jpg	0.5x0.5		0	209
539	products/saleor/static/placeholders/candy/1_9TAhtOC.jpg	0.5x0.5		1	209
540	products/saleor/static/placeholders/candy/1_U7evpg8.jpg	0.5x0.5		2	209
541	products/saleor/static/placeholders/candy/2_VPtiXeP.jpg	0.5x0.5		3	209
542	products/saleor/static/placeholders/candy/1_ZTTMZbq.jpg	0.5x0.5		0	210
543	products/saleor/static/placeholders/candy/1_LoNwhim.jpg	0.5x0.5		1	210
544	products/saleor/static/placeholders/candy/2_BOVEIrD.jpg	0.5x0.5		2	210
545	products/saleor/static/placeholders/candy/2_RAoqOqQ.jpg	0.5x0.5		3	210
546	products/saleor/static/placeholders/t-shirts/6_7BPT1Jq.jpg	0.5x0.5		0	211
547	products/saleor/static/placeholders/t-shirts/6_svKV1T4.jpg	0.5x0.5		1	211
548	products/saleor/static/placeholders/t-shirts/5_1lVg9Jh.jpg	0.5x0.5		0	212
549	products/saleor/static/placeholders/t-shirts/6_OHhsrrS.jpg	0.5x0.5		1	212
550	products/saleor/static/placeholders/t-shirts/6_6dv7EW1.jpg	0.5x0.5		2	212
551	products/saleor/static/placeholders/t-shirts/6_DV1VA44.jpg	0.5x0.5		3	212
552	products/saleor/static/placeholders/t-shirts/6_ZpDq0wr.jpg	0.5x0.5		0	213
553	products/saleor/static/placeholders/t-shirts/6_nOXnln1.jpg	0.5x0.5		1	213
554	products/saleor/static/placeholders/t-shirts/6_akY9Bkn.jpg	0.5x0.5		2	213
555	products/saleor/static/placeholders/t-shirts/5_5cZkaLM.jpg	0.5x0.5		3	213
556	products/saleor/static/placeholders/t-shirts/6_433IiVo.jpg	0.5x0.5		0	214
557	products/saleor/static/placeholders/t-shirts/5_I0xj2vf.jpg	0.5x0.5		0	215
558	products/saleor/static/placeholders/t-shirts/5_Ztqm63I.jpg	0.5x0.5		1	215
559	products/saleor/static/placeholders/t-shirts/5_Cv7uvlT.jpg	0.5x0.5		2	215
560	products/saleor/static/placeholders/t-shirts/5_WZiQboK.jpg	0.5x0.5		0	216
561	products/saleor/static/placeholders/t-shirts/5_sDirdXA.jpg	0.5x0.5		1	216
562	products/saleor/static/placeholders/t-shirts/5_SIoQy2r.jpg	0.5x0.5		2	216
563	products/saleor/static/placeholders/t-shirts/5_Q5oCdiB.jpg	0.5x0.5		3	216
564	products/saleor/static/placeholders/t-shirts/6_PJZvjS4.jpg	0.5x0.5		0	217
565	products/saleor/static/placeholders/t-shirts/5_rwKb6TZ.jpg	0.5x0.5		1	217
566	products/saleor/static/placeholders/t-shirts/6_6ucZZQ0.jpg	0.5x0.5		2	217
567	products/saleor/static/placeholders/t-shirts/5_BtKUscl.jpg	0.5x0.5		0	218
568	products/saleor/static/placeholders/t-shirts/5_WIO4cBA.jpg	0.5x0.5		1	218
569	products/saleor/static/placeholders/t-shirts/5_TSgUAbF.jpg	0.5x0.5		2	218
570	products/saleor/static/placeholders/t-shirts/6_6QWfegs.jpg	0.5x0.5		3	218
571	products/saleor/static/placeholders/t-shirts/6_NjEI267.jpg	0.5x0.5		0	219
572	products/saleor/static/placeholders/t-shirts/5_PzoeXrW.jpg	0.5x0.5		1	219
573	products/saleor/static/placeholders/t-shirts/6_2ZeweMA.jpg	0.5x0.5		0	220
574	products/saleor/static/placeholders/books/book_03_4xwo7PY.jpg	0.5x0.5		0	221
575	products/saleor/static/placeholders/books/book_01_xnnnV6j.jpg	0.5x0.5		1	221
576	products/saleor/static/placeholders/books/book_04_cmR5Fjz.jpg	0.5x0.5		2	221
577	products/saleor/static/placeholders/books/book_03_dVXwQuU.jpg	0.5x0.5		3	221
578	products/saleor/static/placeholders/books/book_03_ndgz0xn.jpg	0.5x0.5		0	222
579	products/saleor/static/placeholders/books/book_04_8qNK4Re.jpg	0.5x0.5		1	222
580	products/saleor/static/placeholders/books/book_03_EBzwrNC.jpg	0.5x0.5		2	222
581	products/saleor/static/placeholders/books/book_01_LZsuCbH.jpg	0.5x0.5		0	223
582	products/saleor/static/placeholders/books/book_05_JB71HVK.jpg	0.5x0.5		1	223
583	products/saleor/static/placeholders/books/book_02_Bkn0bQm.jpg	0.5x0.5		2	223
584	products/saleor/static/placeholders/books/book_02_ElSe3vx.jpg	0.5x0.5		0	224
585	products/saleor/static/placeholders/books/book_01_zzCRNUB.jpg	0.5x0.5		1	224
586	products/saleor/static/placeholders/books/book_01_DyxWrSz.jpg	0.5x0.5		0	225
587	products/saleor/static/placeholders/books/book_04_lyzQygT.jpg	0.5x0.5		1	225
588	products/saleor/static/placeholders/books/book_02_kulXLGE.jpg	0.5x0.5		2	225
589	products/saleor/static/placeholders/books/book_03_dcbuOKe.jpg	0.5x0.5		3	225
590	products/saleor/static/placeholders/books/book_02_AGfbtu9.jpg	0.5x0.5		0	226
591	products/saleor/static/placeholders/books/book_03_QeBjOJy.jpg	0.5x0.5		1	226
592	products/saleor/static/placeholders/books/book_01_tDtB2Fs.jpg	0.5x0.5		2	226
593	products/saleor/static/placeholders/books/book_05_xhm0FRA.jpg	0.5x0.5		0	227
594	products/saleor/static/placeholders/books/book_02_zC0q72p.jpg	0.5x0.5		1	227
595	products/saleor/static/placeholders/books/book_05_meFjWcu.jpg	0.5x0.5		2	227
596	products/saleor/static/placeholders/books/book_04_gs1avN1.jpg	0.5x0.5		0	228
597	products/saleor/static/placeholders/books/book_01_odAzkMF.jpg	0.5x0.5		1	228
598	products/saleor/static/placeholders/books/book_04_qUS2dRs.jpg	0.5x0.5		0	229
599	products/saleor/static/placeholders/books/book_04_GgRnAPL.jpg	0.5x0.5		1	229
600	products/saleor/static/placeholders/books/book_02_pk15X8M.jpg	0.5x0.5		2	229
601	products/saleor/static/placeholders/books/book_04_dNMSaAM.jpg	0.5x0.5		3	229
602	products/saleor/static/placeholders/books/book_02_ScjJ41V.jpg	0.5x0.5		0	230
603	products/saleor/static/placeholders/books/book_01_l01UQBS.jpg	0.5x0.5		1	230
604	products/saleor/static/placeholders/books/book_02_Z8Uwl8W.jpg	0.5x0.5		2	230
605	products/saleor/static/placeholders/books/book_02_CN3Q9mR.jpg	0.5x0.5		3	230
606	products/saleor/static/placeholders/books/book_05_IGcvPLu.jpg	0.5x0.5		0	231
607	products/saleor/static/placeholders/books/book_05_PRDtGyT.jpg	0.5x0.5		1	231
608	products/saleor/static/placeholders/books/book_03_rZuR0NO.jpg	0.5x0.5		2	231
609	products/saleor/static/placeholders/books/book_05_ZFKHLCX.jpg	0.5x0.5		0	232
610	products/saleor/static/placeholders/books/book_01_Y6AwNno.jpg	0.5x0.5		1	232
611	products/saleor/static/placeholders/books/book_03_sWXqedi.jpg	0.5x0.5		0	233
612	products/saleor/static/placeholders/books/book_04_EapV38z.jpg	0.5x0.5		1	233
613	products/saleor/static/placeholders/books/book_03_yh6z45a.jpg	0.5x0.5		2	233
614	products/saleor/static/placeholders/books/book_04_z0kNgRq.jpg	0.5x0.5		0	234
615	products/saleor/static/placeholders/books/book_02_1JRAQsY.jpg	0.5x0.5		1	234
616	products/saleor/static/placeholders/books/book_02_cDgkjC0.jpg	0.5x0.5		2	234
617	products/saleor/static/placeholders/books/book_03_2M18BBT.jpg	0.5x0.5		3	234
618	products/saleor/static/placeholders/books/book_02_Emr5CA5.jpg	0.5x0.5		0	235
619	products/saleor/static/placeholders/books/book_04_vpL1Cs5.jpg	0.5x0.5		1	235
620	products/saleor/static/placeholders/books/book_02_BSgOiQd.jpg	0.5x0.5		0	236
621	products/saleor/static/placeholders/books/book_03_2GQ795V.jpg	0.5x0.5		0	237
622	products/saleor/static/placeholders/books/book_02_PrWuyfa.jpg	0.5x0.5		0	238
623	products/saleor/static/placeholders/books/book_04_FoUzbz9.jpg	0.5x0.5		1	238
624	products/saleor/static/placeholders/books/book_02_jk62uTx.jpg	0.5x0.5		2	238
625	products/saleor/static/placeholders/books/book_03_ERThTzN.jpg	0.5x0.5		3	238
626	products/saleor/static/placeholders/books/book_02_xRjfwHh.jpg	0.5x0.5		0	239
627	products/saleor/static/placeholders/books/book_01_m89itF7.jpg	0.5x0.5		1	239
628	products/saleor/static/placeholders/books/book_02_BvscHPK.jpg	0.5x0.5		2	239
629	products/saleor/static/placeholders/books/book_03_K9wK23R.jpg	0.5x0.5		0	240
630	products/saleor/static/placeholders/books/book_05_JPATX56.jpg	0.5x0.5		1	240
631	products/saleor/static/placeholders/books/book_04_gTpvcDr.jpg	0.5x0.5		2	240
632	products/saleor/static/placeholders/coffee/coffee_03_fTRhYZv.jpg	0.5x0.5		0	241
633	products/saleor/static/placeholders/coffee/8_k8cLPKE.jpg	0.5x0.5		1	241
634	products/saleor/static/placeholders/coffee/8_G22zGGJ.jpg	0.5x0.5		0	242
635	products/saleor/static/placeholders/coffee/coffee_04_V2H3mR8.jpg	0.5x0.5		1	242
636	products/saleor/static/placeholders/coffee/8_Y2olM0C.jpg	0.5x0.5		2	242
637	products/saleor/static/placeholders/coffee/coffee_01_3vTsCrF.jpg	0.5x0.5		3	242
638	products/saleor/static/placeholders/coffee/coffee_03_i5AoXpv.jpg	0.5x0.5		0	243
639	products/saleor/static/placeholders/coffee/coffee_04_Y7ooBPn.jpg	0.5x0.5		0	244
640	products/saleor/static/placeholders/coffee/coffee_01_dupygeX.jpg	0.5x0.5		1	244
641	products/saleor/static/placeholders/coffee/coffee_04_pW2h3JF.jpg	0.5x0.5		2	244
642	products/saleor/static/placeholders/coffee/coffee_02_60J5xXh.jpg	0.5x0.5		3	244
643	products/saleor/static/placeholders/coffee/coffee_02_aaJyKt6.jpg	0.5x0.5		0	245
644	products/saleor/static/placeholders/coffee/coffee_02_qAGh9Fe.jpg	0.5x0.5		0	246
645	products/saleor/static/placeholders/coffee/coffee_01_Pa60S7B.jpg	0.5x0.5		0	247
646	products/saleor/static/placeholders/coffee/coffee_01_wycMsm0.jpg	0.5x0.5		0	248
647	products/saleor/static/placeholders/coffee/8_KCijnPs.jpg	0.5x0.5		0	249
648	products/saleor/static/placeholders/coffee/coffee_03_SDNg9nv.jpg	0.5x0.5		1	249
649	products/saleor/static/placeholders/coffee/8_20zhiDf.jpg	0.5x0.5		2	249
650	products/saleor/static/placeholders/coffee/coffee_04_xAe6uDG.jpg	0.5x0.5		3	249
651	products/saleor/static/placeholders/coffee/coffee_03_6h2axHw.jpg	0.5x0.5		0	250
652	products/saleor/static/placeholders/coffee/coffee_04_4m8YZH2.jpg	0.5x0.5		1	250
653	products/saleor/static/placeholders/mugs/3_1o1G53z.jpg	0.5x0.5		0	251
654	products/saleor/static/placeholders/mugs/4_24UZpXI.jpg	0.5x0.5		1	251
655	products/saleor/static/placeholders/mugs/box_01_q21PAAx.jpg	0.5x0.5		0	252
656	products/saleor/static/placeholders/mugs/4_sQepvvl.jpg	0.5x0.5		1	252
657	products/saleor/static/placeholders/mugs/4_BhamrY0.jpg	0.5x0.5		0	253
658	products/saleor/static/placeholders/mugs/7_XlKz3TV.jpg	0.5x0.5		1	253
659	products/saleor/static/placeholders/mugs/7_UNg7JNC.jpg	0.5x0.5		0	254
660	products/saleor/static/placeholders/mugs/box_01_GsmumDQ.jpg	0.5x0.5		0	255
661	products/saleor/static/placeholders/mugs/box_01_D0dqkIY.jpg	0.5x0.5		0	256
662	products/saleor/static/placeholders/mugs/box_01_vWdT6JD.jpg	0.5x0.5		1	256
663	products/saleor/static/placeholders/mugs/7_LWIfo1H.jpg	0.5x0.5		2	256
664	products/saleor/static/placeholders/mugs/4_P7jvG6V.jpg	0.5x0.5		0	257
665	products/saleor/static/placeholders/mugs/box_01_KvjFiBw.jpg	0.5x0.5		1	257
666	products/saleor/static/placeholders/mugs/4_bHLCiiR.jpg	0.5x0.5		2	257
667	products/saleor/static/placeholders/mugs/7_O8G2K5T.jpg	0.5x0.5		0	258
668	products/saleor/static/placeholders/mugs/3_vBRIzun.jpg	0.5x0.5		1	258
669	products/saleor/static/placeholders/mugs/4_xceOVFR.jpg	0.5x0.5		2	258
670	products/saleor/static/placeholders/mugs/7_LF5NxcP.jpg	0.5x0.5		0	259
671	products/saleor/static/placeholders/mugs/4_1WK3GcX.jpg	0.5x0.5		1	259
672	products/saleor/static/placeholders/mugs/box_01_Lc4dXGB.jpg	0.5x0.5		2	259
673	products/saleor/static/placeholders/mugs/7_fvFgupL.jpg	0.5x0.5		3	259
674	products/saleor/static/placeholders/mugs/4_QmieHCm.jpg	0.5x0.5		0	260
675	products/saleor/static/placeholders/mugs/7_D34uCFr.jpg	0.5x0.5		1	260
676	products/saleor/static/placeholders/mugs/3_y48VfzM.jpg	0.5x0.5		2	260
677	products/saleor/static/placeholders/candy/1_8yiYGC2.jpg	0.5x0.5		0	261
678	products/saleor/static/placeholders/candy/2_unRUxQJ.jpg	0.5x0.5		1	261
679	products/saleor/static/placeholders/candy/1_qihxkB8.jpg	0.5x0.5		2	261
680	products/saleor/static/placeholders/candy/2_f6Qqnvs.jpg	0.5x0.5		0	262
681	products/saleor/static/placeholders/candy/1_uPhIXy1.jpg	0.5x0.5		1	262
682	products/saleor/static/placeholders/candy/1_D2Yl80L.jpg	0.5x0.5		0	263
683	products/saleor/static/placeholders/candy/1_BxA7APu.jpg	0.5x0.5		0	264
684	products/saleor/static/placeholders/candy/1_1gj9ozk.jpg	0.5x0.5		1	264
685	products/saleor/static/placeholders/candy/1_nIlzMIN.jpg	0.5x0.5		0	265
686	products/saleor/static/placeholders/candy/1_RvjYRcP.jpg	0.5x0.5		1	265
687	products/saleor/static/placeholders/candy/1_RtuT1JG.jpg	0.5x0.5		2	265
688	products/saleor/static/placeholders/candy/1_95ucPIP.jpg	0.5x0.5		3	265
689	products/saleor/static/placeholders/candy/2_mKW5US4.jpg	0.5x0.5		0	266
690	products/saleor/static/placeholders/candy/2_XKmKQGa.jpg	0.5x0.5		1	266
691	products/saleor/static/placeholders/candy/2_dASp7bP.jpg	0.5x0.5		0	267
692	products/saleor/static/placeholders/candy/1_dN5eQI0.jpg	0.5x0.5		0	268
693	products/saleor/static/placeholders/candy/2_plivVrS.jpg	0.5x0.5		1	268
694	products/saleor/static/placeholders/candy/1_28NWQs2.jpg	0.5x0.5		0	269
695	products/saleor/static/placeholders/candy/1_SqsBfW0.jpg	0.5x0.5		1	269
696	products/saleor/static/placeholders/candy/1_hoenQkh.jpg	0.5x0.5		0	270
697	products/saleor/static/placeholders/candy/1_Qh3OZb7.jpg	0.5x0.5		1	270
698	products/saleor/static/placeholders/t-shirts/6_rIYjxAF.jpg	0.5x0.5		0	271
699	products/saleor/static/placeholders/t-shirts/5_McYDSIr.jpg	0.5x0.5		1	271
700	products/saleor/static/placeholders/t-shirts/5_TZGqvbj.jpg	0.5x0.5		2	271
701	products/saleor/static/placeholders/t-shirts/6_v7jmW5F.jpg	0.5x0.5		3	271
702	products/saleor/static/placeholders/t-shirts/6_O2Hz7t0.jpg	0.5x0.5		0	272
703	products/saleor/static/placeholders/t-shirts/5_24StHrB.jpg	0.5x0.5		0	273
704	products/saleor/static/placeholders/t-shirts/5_zR1UuWX.jpg	0.5x0.5		1	273
705	products/saleor/static/placeholders/t-shirts/5_1zuHiw5.jpg	0.5x0.5		2	273
706	products/saleor/static/placeholders/t-shirts/5_4N0Upoe.jpg	0.5x0.5		3	273
707	products/saleor/static/placeholders/t-shirts/5_qwZDFf5.jpg	0.5x0.5		0	274
708	products/saleor/static/placeholders/t-shirts/5_XoLrLmY.jpg	0.5x0.5		1	274
709	products/saleor/static/placeholders/t-shirts/6_BczUJP0.jpg	0.5x0.5		2	274
710	products/saleor/static/placeholders/t-shirts/6_Ssaye6D.jpg	0.5x0.5		3	274
711	products/saleor/static/placeholders/t-shirts/5_HsPYlRe.jpg	0.5x0.5		0	275
712	products/saleor/static/placeholders/t-shirts/6_PFb4qOu.jpg	0.5x0.5		1	275
713	products/saleor/static/placeholders/t-shirts/5_fLbWa06.jpg	0.5x0.5		0	276
714	products/saleor/static/placeholders/t-shirts/5_9Jzgcg2.jpg	0.5x0.5		1	276
715	products/saleor/static/placeholders/t-shirts/6_DLSoqYO.jpg	0.5x0.5		2	276
716	products/saleor/static/placeholders/t-shirts/6_4LRItsI.jpg	0.5x0.5		3	276
717	products/saleor/static/placeholders/t-shirts/5_MikH2QM.jpg	0.5x0.5		0	277
718	products/saleor/static/placeholders/t-shirts/5_sKE9y73.jpg	0.5x0.5		1	277
719	products/saleor/static/placeholders/t-shirts/6_80s619p.jpg	0.5x0.5		2	277
720	products/saleor/static/placeholders/t-shirts/6_ABWvULG.jpg	0.5x0.5		3	277
721	products/saleor/static/placeholders/t-shirts/5_YwaRcpJ.jpg	0.5x0.5		0	278
722	products/saleor/static/placeholders/t-shirts/5_LWGTgMP.jpg	0.5x0.5		1	278
723	products/saleor/static/placeholders/t-shirts/6_njw51eD.jpg	0.5x0.5		0	279
724	products/saleor/static/placeholders/t-shirts/5_Y1g9Syt.jpg	0.5x0.5		1	279
725	products/saleor/static/placeholders/t-shirts/5_ikGMiUV.jpg	0.5x0.5		2	279
726	products/saleor/static/placeholders/t-shirts/5_U79xZC6.jpg	0.5x0.5		3	279
727	products/saleor/static/placeholders/t-shirts/6_ejBkAOj.jpg	0.5x0.5		0	280
728	products/saleor/static/placeholders/t-shirts/6_TZWuxMm.jpg	0.5x0.5		1	280
729	products/saleor/static/placeholders/t-shirts/5_QfMIcje.jpg	0.5x0.5		2	280
730	products/saleor/static/placeholders/books/book_04_lXrGWXp.jpg	0.5x0.5		0	281
731	products/saleor/static/placeholders/books/book_05_zCZ2d5k.jpg	0.5x0.5		0	282
732	products/saleor/static/placeholders/books/book_02_TvW0NF6.jpg	0.5x0.5		1	282
733	products/saleor/static/placeholders/books/book_05_t862jXG.jpg	0.5x0.5		0	283
734	products/saleor/static/placeholders/books/book_05_oDqzAIl.jpg	0.5x0.5		1	283
735	products/saleor/static/placeholders/books/book_01_9yXdryk.jpg	0.5x0.5		2	283
736	products/saleor/static/placeholders/books/book_01_MCys0rX.jpg	0.5x0.5		0	284
737	products/saleor/static/placeholders/books/book_03_mtQzIV1.jpg	0.5x0.5		1	284
738	products/saleor/static/placeholders/books/book_01_SBF5A1V.jpg	0.5x0.5		2	284
739	products/saleor/static/placeholders/books/book_04_KCCHDHQ.jpg	0.5x0.5		0	285
740	products/saleor/static/placeholders/books/book_03_BZr85B0.jpg	0.5x0.5		0	286
741	products/saleor/static/placeholders/books/book_01_VKCn0co.jpg	0.5x0.5		0	287
742	products/saleor/static/placeholders/books/book_01_LprHOiP.jpg	0.5x0.5		1	287
743	products/saleor/static/placeholders/books/book_02_xVhUMKs.jpg	0.5x0.5		2	287
744	products/saleor/static/placeholders/books/book_04_F6xafYJ.jpg	0.5x0.5		0	288
745	products/saleor/static/placeholders/books/book_02_e0O9Drg.jpg	0.5x0.5		1	288
746	products/saleor/static/placeholders/books/book_03_AU9ci4r.jpg	0.5x0.5		2	288
747	products/saleor/static/placeholders/books/book_02_iiUcB0Q.jpg	0.5x0.5		3	288
748	products/saleor/static/placeholders/books/book_01_ok3Licr.jpg	0.5x0.5		0	289
749	products/saleor/static/placeholders/books/book_01_CxqJFEK.jpg	0.5x0.5		1	289
750	products/saleor/static/placeholders/books/book_04_euE5M18.jpg	0.5x0.5		2	289
751	products/saleor/static/placeholders/books/book_01_vmwjekL.jpg	0.5x0.5		3	289
752	products/saleor/static/placeholders/books/book_01_TpGdw0U.jpg	0.5x0.5		0	290
753	products/saleor/static/placeholders/books/book_03_MlvwIio.jpg	0.5x0.5		1	290
754	products/saleor/static/placeholders/books/book_02_0jwuYNL.jpg	0.5x0.5		2	290
755	products/saleor/static/placeholders/books/book_04_e6uPmSi.jpg	0.5x0.5		3	290
756	products/saleor/static/placeholders/books/book_05_s1rnfhA.jpg	0.5x0.5		0	291
757	products/saleor/static/placeholders/books/book_05_sxuLm5e.jpg	0.5x0.5		1	291
758	products/saleor/static/placeholders/books/book_01_V1fODtX.jpg	0.5x0.5		2	291
759	products/saleor/static/placeholders/books/book_03_A62t3nh.jpg	0.5x0.5		3	291
760	products/saleor/static/placeholders/books/book_02_vQCNW68.jpg	0.5x0.5		0	292
761	products/saleor/static/placeholders/books/book_01_CGRrboL.jpg	0.5x0.5		1	292
762	products/saleor/static/placeholders/books/book_01_94x4bTZ.jpg	0.5x0.5		2	292
763	products/saleor/static/placeholders/books/book_05_JiANtKx.jpg	0.5x0.5		3	292
764	products/saleor/static/placeholders/books/book_02_CXWJp4y.jpg	0.5x0.5		0	293
765	products/saleor/static/placeholders/books/book_04_OyQSU5a.jpg	0.5x0.5		1	293
766	products/saleor/static/placeholders/books/book_05_VA21wmq.jpg	0.5x0.5		2	293
767	products/saleor/static/placeholders/books/book_05_3WbjSxq.jpg	0.5x0.5		3	293
768	products/saleor/static/placeholders/books/book_05_2dCeVm3.jpg	0.5x0.5		0	294
769	products/saleor/static/placeholders/books/book_04_kglB8Nw.jpg	0.5x0.5		1	294
770	products/saleor/static/placeholders/books/book_04_xoBiPAo.jpg	0.5x0.5		2	294
771	products/saleor/static/placeholders/books/book_05_uLpjzDE.jpg	0.5x0.5		0	295
772	products/saleor/static/placeholders/books/book_04_zl7YSEh.jpg	0.5x0.5		0	296
773	products/saleor/static/placeholders/books/book_01_mQAeSDW.jpg	0.5x0.5		1	296
774	products/saleor/static/placeholders/books/book_04_JhpImI0.jpg	0.5x0.5		2	296
775	products/saleor/static/placeholders/books/book_02_bztbhF4.jpg	0.5x0.5		0	297
776	products/saleor/static/placeholders/books/book_03_HhL4Pyr.jpg	0.5x0.5		0	298
777	products/saleor/static/placeholders/books/book_04_RZI5i67.jpg	0.5x0.5		1	298
778	products/saleor/static/placeholders/books/book_05_MZPHwwv.jpg	0.5x0.5		2	298
779	products/saleor/static/placeholders/books/book_02_ajcwH2p.jpg	0.5x0.5		3	298
780	products/saleor/static/placeholders/books/book_05_YOM6ysn.jpg	0.5x0.5		0	299
781	products/saleor/static/placeholders/books/book_01_iVEcAKe.jpg	0.5x0.5		0	300
782	products/saleor/static/placeholders/books/book_02_xXI17te.jpg	0.5x0.5		1	300
783	products/saleor/static/placeholders/coffee/coffee_02_8FVHuMM.jpg	0.5x0.5		0	301
784	products/saleor/static/placeholders/coffee/coffee_02_iaxX12g.jpg	0.5x0.5		0	302
785	products/saleor/static/placeholders/coffee/coffee_04_TgpOIFE.jpg	0.5x0.5		0	303
786	products/saleor/static/placeholders/coffee/coffee_02_PAWzMnH.jpg	0.5x0.5		0	304
787	products/saleor/static/placeholders/coffee/coffee_01_LCD51Rd.jpg	0.5x0.5		1	304
788	products/saleor/static/placeholders/coffee/coffee_01_F7OyuVr.jpg	0.5x0.5		2	304
789	products/saleor/static/placeholders/coffee/coffee_04_ZxvP58Y.jpg	0.5x0.5		0	305
790	products/saleor/static/placeholders/coffee/coffee_03_NbgJbHa.jpg	0.5x0.5		1	305
791	products/saleor/static/placeholders/coffee/coffee_01_wUOsO1p.jpg	0.5x0.5		2	305
792	products/saleor/static/placeholders/coffee/coffee_01_UlYu99Q.jpg	0.5x0.5		0	306
793	products/saleor/static/placeholders/coffee/coffee_02_GJ2kVMQ.jpg	0.5x0.5		1	306
794	products/saleor/static/placeholders/coffee/8_VrOaiDz.jpg	0.5x0.5		2	306
795	products/saleor/static/placeholders/coffee/coffee_01_NNUkZYo.jpg	0.5x0.5		0	307
796	products/saleor/static/placeholders/coffee/coffee_02_wOqYD7c.jpg	0.5x0.5		1	307
797	products/saleor/static/placeholders/coffee/coffee_03_HIMZBBv.jpg	0.5x0.5		2	307
798	products/saleor/static/placeholders/coffee/coffee_04_nHrccvs.jpg	0.5x0.5		0	308
799	products/saleor/static/placeholders/coffee/coffee_03_AOOOLrR.jpg	0.5x0.5		1	308
800	products/saleor/static/placeholders/coffee/coffee_03_aLLfyNa.jpg	0.5x0.5		2	308
801	products/saleor/static/placeholders/coffee/coffee_04_IsceE0t.jpg	0.5x0.5		0	309
802	products/saleor/static/placeholders/coffee/coffee_04_tjSAqMm.jpg	0.5x0.5		1	309
803	products/saleor/static/placeholders/coffee/coffee_01_8zu72Iu.jpg	0.5x0.5		0	310
804	products/saleor/static/placeholders/mugs/7_m1PdczA.jpg	0.5x0.5		0	311
805	products/saleor/static/placeholders/mugs/box_01_iRGaCnO.jpg	0.5x0.5		1	311
806	products/saleor/static/placeholders/mugs/7_0MX2wqb.jpg	0.5x0.5		2	311
807	products/saleor/static/placeholders/mugs/3_LypyExk.jpg	0.5x0.5		3	311
808	products/saleor/static/placeholders/mugs/3_Mr7RSCi.jpg	0.5x0.5		0	312
809	products/saleor/static/placeholders/mugs/3_dmsycpa.jpg	0.5x0.5		1	312
810	products/saleor/static/placeholders/mugs/7_mXPBFgp.jpg	0.5x0.5		2	312
811	products/saleor/static/placeholders/mugs/3_vUDVZ3s.jpg	0.5x0.5		0	313
812	products/saleor/static/placeholders/mugs/3_t4vJAUE.jpg	0.5x0.5		1	313
813	products/saleor/static/placeholders/mugs/3_gkPKH8R.jpg	0.5x0.5		2	313
814	products/saleor/static/placeholders/mugs/box_01_MTHJ7EL.jpg	0.5x0.5		0	314
815	products/saleor/static/placeholders/mugs/box_01_DFT6ok1.jpg	0.5x0.5		1	314
816	products/saleor/static/placeholders/mugs/7_45cziVa.jpg	0.5x0.5		0	315
817	products/saleor/static/placeholders/mugs/3_Emghpbq.jpg	0.5x0.5		1	315
818	products/saleor/static/placeholders/mugs/3_AIT1tQ0.jpg	0.5x0.5		2	315
819	products/saleor/static/placeholders/mugs/7_1BUf1fB.jpg	0.5x0.5		0	316
820	products/saleor/static/placeholders/mugs/3_kwcJlZJ.jpg	0.5x0.5		1	316
821	products/saleor/static/placeholders/mugs/3_pv1iYBH.jpg	0.5x0.5		2	316
822	products/saleor/static/placeholders/mugs/box_01_8k6TD3r.jpg	0.5x0.5		3	316
823	products/saleor/static/placeholders/mugs/box_01_0sSkenm.jpg	0.5x0.5		0	317
824	products/saleor/static/placeholders/mugs/box_01_jU2xIwF.jpg	0.5x0.5		1	317
825	products/saleor/static/placeholders/mugs/box_01_XNy9VLn.jpg	0.5x0.5		0	318
826	products/saleor/static/placeholders/mugs/4_cFFb5Ao.jpg	0.5x0.5		0	319
827	products/saleor/static/placeholders/mugs/4_cBnUd2F.jpg	0.5x0.5		1	319
828	products/saleor/static/placeholders/mugs/3_TE4KHSh.jpg	0.5x0.5		0	320
829	products/saleor/static/placeholders/mugs/3_GpiaBDb.jpg	0.5x0.5		1	320
830	products/saleor/static/placeholders/mugs/3_2WsHLcm.jpg	0.5x0.5		2	320
831	products/saleor/static/placeholders/mugs/box_01_g4zPqaT.jpg	0.5x0.5		3	320
832	products/saleor/static/placeholders/candy/1_WEYZMC1.jpg	0.5x0.5		0	321
833	products/saleor/static/placeholders/candy/1_1qTekqB.jpg	0.5x0.5		1	321
834	products/saleor/static/placeholders/candy/1_x9FBfyh.jpg	0.5x0.5		2	321
835	products/saleor/static/placeholders/candy/1_yxPa693.jpg	0.5x0.5		0	322
836	products/saleor/static/placeholders/candy/1_n6rxa0S.jpg	0.5x0.5		0	323
837	products/saleor/static/placeholders/candy/1_bYxCbVF.jpg	0.5x0.5		0	324
838	products/saleor/static/placeholders/candy/1_FSFl21U.jpg	0.5x0.5		0	325
839	products/saleor/static/placeholders/candy/2_zQn3hxd.jpg	0.5x0.5		0	326
840	products/saleor/static/placeholders/candy/2_z6AnsqM.jpg	0.5x0.5		0	327
841	products/saleor/static/placeholders/candy/2_HfdV9Um.jpg	0.5x0.5		1	327
842	products/saleor/static/placeholders/candy/1_ihNvctW.jpg	0.5x0.5		0	328
843	products/saleor/static/placeholders/candy/2_UV78z0i.jpg	0.5x0.5		1	328
844	products/saleor/static/placeholders/candy/2_kYUo7xG.jpg	0.5x0.5		0	329
845	products/saleor/static/placeholders/candy/2_8ZcuD4U.jpg	0.5x0.5		0	330
846	products/saleor/static/placeholders/candy/2_ldFJMkd.jpg	0.5x0.5		1	330
847	products/saleor/static/placeholders/candy/2_Mv84ii9.jpg	0.5x0.5		2	330
848	products/saleor/static/placeholders/candy/1_JcmxsRh.jpg	0.5x0.5		3	330
849	products/saleor/static/placeholders/t-shirts/5_n46Pt4q.jpg	0.5x0.5		0	331
850	products/saleor/static/placeholders/t-shirts/5_VoXcx3o.jpg	0.5x0.5		0	332
851	products/saleor/static/placeholders/t-shirts/6_dSoY629.jpg	0.5x0.5		1	332
852	products/saleor/static/placeholders/t-shirts/5_aBiXMvz.jpg	0.5x0.5		2	332
853	products/saleor/static/placeholders/t-shirts/5_4LE7Kfb.jpg	0.5x0.5		0	333
854	products/saleor/static/placeholders/t-shirts/5_jrMkhR2.jpg	0.5x0.5		1	333
855	products/saleor/static/placeholders/t-shirts/6_fzmYp7D.jpg	0.5x0.5		2	333
856	products/saleor/static/placeholders/t-shirts/6_OS3fD8t.jpg	0.5x0.5		3	333
857	products/saleor/static/placeholders/t-shirts/5_ppRJn44.jpg	0.5x0.5		0	334
858	products/saleor/static/placeholders/t-shirts/6_p6jW0Za.jpg	0.5x0.5		1	334
859	products/saleor/static/placeholders/t-shirts/6_2vPZ8J9.jpg	0.5x0.5		0	335
860	products/saleor/static/placeholders/t-shirts/6_Vrsha8B.jpg	0.5x0.5		0	336
861	products/saleor/static/placeholders/t-shirts/5_wZj6CWK.jpg	0.5x0.5		1	336
862	products/saleor/static/placeholders/t-shirts/6_9d1b4xH.jpg	0.5x0.5		2	336
863	products/saleor/static/placeholders/t-shirts/6_2jnas3a.jpg	0.5x0.5		0	337
864	products/saleor/static/placeholders/t-shirts/6_cA2uqRZ.jpg	0.5x0.5		0	338
865	products/saleor/static/placeholders/t-shirts/6_fNLvW3j.jpg	0.5x0.5		1	338
866	products/saleor/static/placeholders/t-shirts/6_dDWDRcI.jpg	0.5x0.5		0	339
867	products/saleor/static/placeholders/t-shirts/5_K8gFdEU.jpg	0.5x0.5		1	339
868	products/saleor/static/placeholders/t-shirts/5_SKaEbE8.jpg	0.5x0.5		0	340
869	products/saleor/static/placeholders/t-shirts/6_ZTL6xB2.jpg	0.5x0.5		1	340
870	products/saleor/static/placeholders/t-shirts/5_mAqn3UO.jpg	0.5x0.5		2	340
871	products/saleor/static/placeholders/t-shirts/5_UEJSFMn.jpg	0.5x0.5		3	340
872	products/saleor/static/placeholders/books/book_02_pbg9BiO.jpg	0.5x0.5		0	341
873	products/saleor/static/placeholders/books/book_03_qQLmmOR.jpg	0.5x0.5		1	341
874	products/saleor/static/placeholders/books/book_02_CU0w2yu.jpg	0.5x0.5		2	341
875	products/saleor/static/placeholders/books/book_02_sjsiGMe.jpg	0.5x0.5		3	341
876	products/saleor/static/placeholders/books/book_02_HJbYsbh.jpg	0.5x0.5		0	342
877	products/saleor/static/placeholders/books/book_03_8glDAoY.jpg	0.5x0.5		1	342
878	products/saleor/static/placeholders/books/book_04_ATDxpLU.jpg	0.5x0.5		2	342
879	products/saleor/static/placeholders/books/book_03_MhMTebA.jpg	0.5x0.5		0	343
880	products/saleor/static/placeholders/books/book_03_FtkMPAw.jpg	0.5x0.5		1	343
881	products/saleor/static/placeholders/books/book_05_droAGur.jpg	0.5x0.5		0	344
882	products/saleor/static/placeholders/books/book_02_fvLyaW7.jpg	0.5x0.5		1	344
883	products/saleor/static/placeholders/books/book_02_mwDjBBF.jpg	0.5x0.5		0	345
884	products/saleor/static/placeholders/books/book_05_9gJ1bl8.jpg	0.5x0.5		1	345
885	products/saleor/static/placeholders/books/book_01_lGfs3WP.jpg	0.5x0.5		0	346
886	products/saleor/static/placeholders/books/book_02_voRSPjR.jpg	0.5x0.5		0	347
887	products/saleor/static/placeholders/books/book_03_NguqOHP.jpg	0.5x0.5		0	348
888	products/saleor/static/placeholders/books/book_01_F6XSJxK.jpg	0.5x0.5		0	349
889	products/saleor/static/placeholders/books/book_03_TWINovH.jpg	0.5x0.5		1	349
890	products/saleor/static/placeholders/books/book_03_x4ymzYJ.jpg	0.5x0.5		0	350
891	products/saleor/static/placeholders/books/book_04_IjwRhlh.jpg	0.5x0.5		1	350
892	products/saleor/static/placeholders/books/book_04_wDxNTeF.jpg	0.5x0.5		0	351
893	products/saleor/static/placeholders/books/book_01_srFSP7Y.jpg	0.5x0.5		1	351
894	products/saleor/static/placeholders/books/book_02_uBFjvs0.jpg	0.5x0.5		0	352
895	products/saleor/static/placeholders/books/book_03_Jna8PK1.jpg	0.5x0.5		0	353
896	products/saleor/static/placeholders/books/book_05_6PUknuC.jpg	0.5x0.5		0	354
897	products/saleor/static/placeholders/books/book_03_djPDOm7.jpg	0.5x0.5		1	354
898	products/saleor/static/placeholders/books/book_04_MZGLm6z.jpg	0.5x0.5		2	354
899	products/saleor/static/placeholders/books/book_01_09m7tZF.jpg	0.5x0.5		3	354
900	products/saleor/static/placeholders/books/book_01_Z9jFxui.jpg	0.5x0.5		0	355
901	products/saleor/static/placeholders/books/book_02_zSs0dnZ.jpg	0.5x0.5		0	356
902	products/saleor/static/placeholders/books/book_02_DJ3lFcb.jpg	0.5x0.5		0	357
903	products/saleor/static/placeholders/books/book_03_QM6XIci.jpg	0.5x0.5		0	358
904	products/saleor/static/placeholders/books/book_04_kbUrGSi.jpg	0.5x0.5		1	358
905	products/saleor/static/placeholders/books/book_01_SfpHPlM.jpg	0.5x0.5		2	358
906	products/saleor/static/placeholders/books/book_01_IXdN1IZ.jpg	0.5x0.5		3	358
907	products/saleor/static/placeholders/books/book_02_SWNlGZy.jpg	0.5x0.5		0	359
908	products/saleor/static/placeholders/books/book_03_PR55k7o.jpg	0.5x0.5		1	359
909	products/saleor/static/placeholders/books/book_03_EJiWNZ6.jpg	0.5x0.5		2	359
910	products/saleor/static/placeholders/books/book_02_ZB8HRNH.jpg	0.5x0.5		3	359
911	products/saleor/static/placeholders/books/book_05_KMYN2vB.jpg	0.5x0.5		0	360
912	products/saleor/static/placeholders/coffee/coffee_02.jpg	0.5x0.5		0	361
913	products/saleor/static/placeholders/coffee/8.jpg	0.5x0.5		0	362
914	products/saleor/static/placeholders/coffee/coffee_02_7xLbzeY.jpg	0.5x0.5		1	362
915	products/saleor/static/placeholders/coffee/coffee_02_LJuDLCt.jpg	0.5x0.5		2	362
916	products/saleor/static/placeholders/coffee/coffee_04.jpg	0.5x0.5		3	362
917	products/saleor/static/placeholders/coffee/coffee_02_PKPmtcn.jpg	0.5x0.5		0	363
918	products/saleor/static/placeholders/coffee/coffee_04_Ya5SeJh.jpg	0.5x0.5		0	364
919	products/saleor/static/placeholders/coffee/coffee_01.jpg	0.5x0.5		1	364
920	products/saleor/static/placeholders/coffee/8_9S9IVLQ.jpg	0.5x0.5		2	364
921	products/saleor/static/placeholders/coffee/coffee_02_UEewPec.jpg	0.5x0.5		0	365
922	products/saleor/static/placeholders/coffee/8_ky7Zpc8.jpg	0.5x0.5		1	365
923	products/saleor/static/placeholders/coffee/coffee_01_N4OP03k.jpg	0.5x0.5		0	366
924	products/saleor/static/placeholders/coffee/coffee_03.jpg	0.5x0.5		1	366
925	products/saleor/static/placeholders/coffee/coffee_02_7em532t.jpg	0.5x0.5		2	366
926	products/saleor/static/placeholders/coffee/coffee_03_cwwH8gk.jpg	0.5x0.5		3	366
927	products/saleor/static/placeholders/coffee/coffee_02_teMqREF.jpg	0.5x0.5		0	367
928	products/saleor/static/placeholders/coffee/coffee_01_pKUkvPl.jpg	0.5x0.5		1	367
929	products/saleor/static/placeholders/coffee/8_qorVU4g.jpg	0.5x0.5		0	368
930	products/saleor/static/placeholders/coffee/coffee_03_a6tKF7S.jpg	0.5x0.5		1	368
931	products/saleor/static/placeholders/coffee/coffee_02_mE04xgn.jpg	0.5x0.5		2	368
932	products/saleor/static/placeholders/coffee/coffee_02_2He2Kba.jpg	0.5x0.5		3	368
933	products/saleor/static/placeholders/coffee/coffee_02_vxV8wNp.jpg	0.5x0.5		0	369
934	products/saleor/static/placeholders/coffee/coffee_03_pQIvZkh.jpg	0.5x0.5		1	369
935	products/saleor/static/placeholders/coffee/coffee_04_jey1UHS.jpg	0.5x0.5		2	369
936	products/saleor/static/placeholders/coffee/coffee_01_11xuDn0.jpg	0.5x0.5		0	370
937	products/saleor/static/placeholders/mugs/7.jpg	0.5x0.5		0	371
938	products/saleor/static/placeholders/mugs/box_01.jpg	0.5x0.5		1	371
939	products/saleor/static/placeholders/mugs/3.jpg	0.5x0.5		0	372
940	products/saleor/static/placeholders/mugs/7_byf4rz1.jpg	0.5x0.5		1	372
941	products/saleor/static/placeholders/mugs/4.jpg	0.5x0.5		2	372
942	products/saleor/static/placeholders/mugs/box_01_3lBkqeI.jpg	0.5x0.5		0	373
943	products/saleor/static/placeholders/mugs/box_01_CwaRrrG.jpg	0.5x0.5		1	373
944	products/saleor/static/placeholders/mugs/box_01_VlGbBdO.jpg	0.5x0.5		2	373
945	products/saleor/static/placeholders/mugs/7_Nh3Csnz.jpg	0.5x0.5		0	374
946	products/saleor/static/placeholders/mugs/4_fFY7ush.jpg	0.5x0.5		0	375
947	products/saleor/static/placeholders/mugs/4_s6CAcdv.jpg	0.5x0.5		0	376
948	products/saleor/static/placeholders/mugs/4_7uWLKya.jpg	0.5x0.5		1	376
949	products/saleor/static/placeholders/mugs/3_uGMpmgi.jpg	0.5x0.5		2	376
950	products/saleor/static/placeholders/mugs/box_01_iO9CqrS.jpg	0.5x0.5		0	377
951	products/saleor/static/placeholders/mugs/box_01_e7rWObb.jpg	0.5x0.5		1	377
952	products/saleor/static/placeholders/mugs/box_01_e7BBOel.jpg	0.5x0.5		0	378
953	products/saleor/static/placeholders/mugs/4_VsWjjtE.jpg	0.5x0.5		0	379
954	products/saleor/static/placeholders/mugs/7_xNOYoq9.jpg	0.5x0.5		1	379
955	products/saleor/static/placeholders/mugs/3_BQC1snL.jpg	0.5x0.5		2	379
956	products/saleor/static/placeholders/mugs/4_kX8avk7.jpg	0.5x0.5		0	380
957	products/saleor/static/placeholders/mugs/box_01_fCcDIqV.jpg	0.5x0.5		1	380
958	products/saleor/static/placeholders/candy/2.jpg	0.5x0.5		0	381
959	products/saleor/static/placeholders/candy/2_JByjSXP.jpg	0.5x0.5		0	382
960	products/saleor/static/placeholders/candy/2_nNCIDpA.jpg	0.5x0.5		0	383
961	products/saleor/static/placeholders/candy/2_tbDkGdh.jpg	0.5x0.5		1	383
962	products/saleor/static/placeholders/candy/1.jpg	0.5x0.5		2	383
963	products/saleor/static/placeholders/candy/2_Rx0vV7D.jpg	0.5x0.5		3	383
964	products/saleor/static/placeholders/candy/1_8Ulix9C.jpg	0.5x0.5		0	384
965	products/saleor/static/placeholders/candy/1_9UOMsVO.jpg	0.5x0.5		0	385
966	products/saleor/static/placeholders/candy/2_6PoPVo4.jpg	0.5x0.5		1	385
967	products/saleor/static/placeholders/candy/2_Ajm2cUN.jpg	0.5x0.5		2	385
968	products/saleor/static/placeholders/candy/1_heWDp8i.jpg	0.5x0.5		0	386
969	products/saleor/static/placeholders/candy/1_X0qH1w8.jpg	0.5x0.5		1	386
970	products/saleor/static/placeholders/candy/1_O3yg0OM.jpg	0.5x0.5		2	386
971	products/saleor/static/placeholders/candy/1_iju3d1G.jpg	0.5x0.5		0	387
972	products/saleor/static/placeholders/candy/2_zeVe7iD.jpg	0.5x0.5		1	387
973	products/saleor/static/placeholders/candy/2_ECD4dlU.jpg	0.5x0.5		2	387
974	products/saleor/static/placeholders/candy/1_cA1YmUT.jpg	0.5x0.5		0	388
975	products/saleor/static/placeholders/candy/1_8DJjMGJ.jpg	0.5x0.5		0	389
976	products/saleor/static/placeholders/candy/2_YAytLjJ.jpg	0.5x0.5		1	389
977	products/saleor/static/placeholders/candy/1_iZyUqMI.jpg	0.5x0.5		0	390
978	products/saleor/static/placeholders/candy/2_WZodxHJ.jpg	0.5x0.5		1	390
979	products/saleor/static/placeholders/candy/2_q2dykZb.jpg	0.5x0.5		2	390
980	products/saleor/static/placeholders/candy/2_9tWLVeQ.jpg	0.5x0.5		3	390
981	products/saleor/static/placeholders/t-shirts/5.jpg	0.5x0.5		0	391
982	products/saleor/static/placeholders/t-shirts/5_Q3Xs6cE.jpg	0.5x0.5		1	391
983	products/saleor/static/placeholders/t-shirts/6.jpg	0.5x0.5		2	391
984	products/saleor/static/placeholders/t-shirts/6_LXdCdxJ.jpg	0.5x0.5		3	391
985	products/saleor/static/placeholders/t-shirts/6_ZT10JXg.jpg	0.5x0.5		0	392
986	products/saleor/static/placeholders/t-shirts/5_FcKFxme.jpg	0.5x0.5		1	392
987	products/saleor/static/placeholders/t-shirts/6_v1DS4Q8.jpg	0.5x0.5		2	392
988	products/saleor/static/placeholders/t-shirts/6_IdqlIcR.jpg	0.5x0.5		0	393
989	products/saleor/static/placeholders/t-shirts/6_Bu0zOiB.jpg	0.5x0.5		0	394
990	products/saleor/static/placeholders/t-shirts/6_yOnTmKN.jpg	0.5x0.5		1	394
991	products/saleor/static/placeholders/t-shirts/6_1rKxTqV.jpg	0.5x0.5		2	394
992	products/saleor/static/placeholders/t-shirts/5_yUCAtB4.jpg	0.5x0.5		3	394
993	products/saleor/static/placeholders/t-shirts/5_MuXhp55.jpg	0.5x0.5		0	395
994	products/saleor/static/placeholders/t-shirts/6_cCCPK3H.jpg	0.5x0.5		0	396
995	products/saleor/static/placeholders/t-shirts/6_teO9ojp.jpg	0.5x0.5		1	396
996	products/saleor/static/placeholders/t-shirts/5_K0Pcfg9.jpg	0.5x0.5		0	397
997	products/saleor/static/placeholders/t-shirts/5_S7SKlzw.jpg	0.5x0.5		0	398
998	products/saleor/static/placeholders/t-shirts/6_h7hmAdl.jpg	0.5x0.5		0	399
999	products/saleor/static/placeholders/t-shirts/6_qPKqsIC.jpg	0.5x0.5		0	400
1000	products/saleor/static/placeholders/t-shirts/6_WXUr5QQ.jpg	0.5x0.5		1	400
1001	products/saleor/static/placeholders/t-shirts/5_VzKQ18l.jpg	0.5x0.5		2	400
1002	products/saleor/static/placeholders/t-shirts/6_wEuxdz5.jpg	0.5x0.5		3	400
1003	products/saleor/static/placeholders/books/book_03.jpg	0.5x0.5		0	401
1004	products/saleor/static/placeholders/books/book_04.jpg	0.5x0.5		0	402
1005	products/saleor/static/placeholders/books/book_03_XxX4buz.jpg	0.5x0.5		0	403
1006	products/saleor/static/placeholders/books/book_04_MH6fOKj.jpg	0.5x0.5		1	403
1007	products/saleor/static/placeholders/books/book_04_DXSmqAR.jpg	0.5x0.5		2	403
1008	products/saleor/static/placeholders/books/book_04_cofqGUu.jpg	0.5x0.5		0	404
1009	products/saleor/static/placeholders/books/book_02.jpg	0.5x0.5		1	404
1010	products/saleor/static/placeholders/books/book_01.jpg	0.5x0.5		2	404
1011	products/saleor/static/placeholders/books/book_03_kTXN8RP.jpg	0.5x0.5		3	404
1012	products/saleor/static/placeholders/books/book_03_HnBm753.jpg	0.5x0.5		0	405
1013	products/saleor/static/placeholders/books/book_01_asXwNvq.jpg	0.5x0.5		0	406
1014	products/saleor/static/placeholders/books/book_03_X8VajC5.jpg	0.5x0.5		1	406
1015	products/saleor/static/placeholders/books/book_02_HZgPY4H.jpg	0.5x0.5		2	406
1016	products/saleor/static/placeholders/books/book_04_CicmQh5.jpg	0.5x0.5		3	406
1017	products/saleor/static/placeholders/books/book_02_YUOEYBf.jpg	0.5x0.5		0	407
1018	products/saleor/static/placeholders/books/book_03_Ba4UpQJ.jpg	0.5x0.5		1	407
1019	products/saleor/static/placeholders/books/book_02_rSjxvpt.jpg	0.5x0.5		2	407
1020	products/saleor/static/placeholders/books/book_02_xi25vZr.jpg	0.5x0.5		0	408
1021	products/saleor/static/placeholders/books/book_05.jpg	0.5x0.5		1	408
1022	products/saleor/static/placeholders/books/book_03_EzkyJ6I.jpg	0.5x0.5		0	409
1023	products/saleor/static/placeholders/books/book_03_AVB0gnm.jpg	0.5x0.5		0	410
1024	products/saleor/static/placeholders/books/book_03_TPQTMqF.jpg	0.5x0.5		1	410
1025	products/saleor/static/placeholders/books/book_03_NkQRnzA.jpg	0.5x0.5		2	410
1026	products/saleor/static/placeholders/books/book_05_fuXPFTZ.jpg	0.5x0.5		0	411
1027	products/saleor/static/placeholders/books/book_01_cy1EURJ.jpg	0.5x0.5		1	411
1028	products/saleor/static/placeholders/books/book_03_JMY8Cjy.jpg	0.5x0.5		2	411
1029	products/saleor/static/placeholders/books/book_05_edMeYlE.jpg	0.5x0.5		0	412
1030	products/saleor/static/placeholders/books/book_05_qX0Gaaw.jpg	0.5x0.5		1	412
1031	products/saleor/static/placeholders/books/book_05_eaDWTYy.jpg	0.5x0.5		0	413
1032	products/saleor/static/placeholders/books/book_02_GbBGwTh.jpg	0.5x0.5		1	413
1033	products/saleor/static/placeholders/books/book_03_5vnJiXA.jpg	0.5x0.5		0	414
1034	products/saleor/static/placeholders/books/book_01_EcHAdDF.jpg	0.5x0.5		1	414
1035	products/saleor/static/placeholders/books/book_01_Sjp5bbz.jpg	0.5x0.5		2	414
1036	products/saleor/static/placeholders/books/book_02_K2swNRg.jpg	0.5x0.5		0	415
1037	products/saleor/static/placeholders/books/book_05_O6E0492.jpg	0.5x0.5		1	415
1038	products/saleor/static/placeholders/books/book_02_n3Rjlq1.jpg	0.5x0.5		2	415
1039	products/saleor/static/placeholders/books/book_05_MYMnVIJ.jpg	0.5x0.5		3	415
1040	products/saleor/static/placeholders/books/book_02_Su5Xa1O.jpg	0.5x0.5		0	416
1041	products/saleor/static/placeholders/books/book_01_Ir9M7XE.jpg	0.5x0.5		1	416
1042	products/saleor/static/placeholders/books/book_01_eKsabOf.jpg	0.5x0.5		2	416
1043	products/saleor/static/placeholders/books/book_02_o9Wvgdj.jpg	0.5x0.5		0	417
1044	products/saleor/static/placeholders/books/book_03_uiWLGeo.jpg	0.5x0.5		0	418
1045	products/saleor/static/placeholders/books/book_01_gGJARc1.jpg	0.5x0.5		1	418
1046	products/saleor/static/placeholders/books/book_02_UySDsnt.jpg	0.5x0.5		2	418
1047	products/saleor/static/placeholders/books/book_04_Wfp1Bzi.jpg	0.5x0.5		3	418
1048	products/saleor/static/placeholders/books/book_03_1MWuK88.jpg	0.5x0.5		0	419
1049	products/saleor/static/placeholders/books/book_04_Fm5hn2n.jpg	0.5x0.5		1	419
1050	products/saleor/static/placeholders/books/book_02_CPsf0hJ.jpg	0.5x0.5		2	419
1051	products/saleor/static/placeholders/books/book_05_7d9Q4hl.jpg	0.5x0.5		3	419
1052	products/saleor/static/placeholders/books/book_04_QZSsMem.jpg	0.5x0.5		0	420
1053	products/saleor/static/placeholders/books/book_04_HEhKmN8.jpg	0.5x0.5		1	420
1054	products/saleor/static/placeholders/books/book_04_wrBsaJy.jpg	0.5x0.5		2	420
1055	products/saleor/static/placeholders/coffee/coffee_02_fRbJu3O.jpg	0.5x0.5		0	421
1056	products/saleor/static/placeholders/coffee/coffee_01_DlsuaqF.jpg	0.5x0.5		1	421
1057	products/saleor/static/placeholders/coffee/coffee_01_Rkj163e.jpg	0.5x0.5		2	421
1058	products/saleor/static/placeholders/coffee/coffee_04_qvcx38F.jpg	0.5x0.5		3	421
1059	products/saleor/static/placeholders/coffee/8_Yd0Kuw8.jpg	0.5x0.5		0	422
1060	products/saleor/static/placeholders/coffee/coffee_04_1H1B6LM.jpg	0.5x0.5		1	422
1061	products/saleor/static/placeholders/coffee/coffee_01_KxBm9TT.jpg	0.5x0.5		2	422
1062	products/saleor/static/placeholders/coffee/coffee_01_vY5jqix.jpg	0.5x0.5		0	423
1063	products/saleor/static/placeholders/coffee/coffee_04_JHate1a.jpg	0.5x0.5		1	423
1064	products/saleor/static/placeholders/coffee/coffee_01_tzoiKcY.jpg	0.5x0.5		2	423
1065	products/saleor/static/placeholders/coffee/8_H8NKQSL.jpg	0.5x0.5		3	423
1066	products/saleor/static/placeholders/coffee/coffee_01_HIwdM3z.jpg	0.5x0.5		0	424
1067	products/saleor/static/placeholders/coffee/coffee_02_wcrIe8Q.jpg	0.5x0.5		1	424
1068	products/saleor/static/placeholders/coffee/coffee_01_k7nXu2h.jpg	0.5x0.5		2	424
1069	products/saleor/static/placeholders/coffee/8_eH9mLCO.jpg	0.5x0.5		3	424
1070	products/saleor/static/placeholders/coffee/coffee_02_NXRXfNj.jpg	0.5x0.5		0	425
1071	products/saleor/static/placeholders/coffee/coffee_02_oEhhzMq.jpg	0.5x0.5		0	426
1072	products/saleor/static/placeholders/coffee/coffee_03_zrN94zL.jpg	0.5x0.5		0	427
1073	products/saleor/static/placeholders/coffee/coffee_04_yiPpmrC.jpg	0.5x0.5		1	427
1074	products/saleor/static/placeholders/coffee/coffee_01_fGM9knh.jpg	0.5x0.5		0	428
1075	products/saleor/static/placeholders/coffee/coffee_04_rCriwAQ.jpg	0.5x0.5		0	429
1076	products/saleor/static/placeholders/coffee/8_jgYpAWI.jpg	0.5x0.5		0	430
1077	products/saleor/static/placeholders/mugs/7_PKl9feK.jpg	0.5x0.5		0	431
1078	products/saleor/static/placeholders/mugs/4_hKio8RW.jpg	0.5x0.5		1	431
1079	products/saleor/static/placeholders/mugs/box_01_TVYlSiM.jpg	0.5x0.5		0	432
1080	products/saleor/static/placeholders/mugs/4_uk9EhdJ.jpg	0.5x0.5		1	432
1081	products/saleor/static/placeholders/mugs/box_01_NyvFw4v.jpg	0.5x0.5		2	432
1082	products/saleor/static/placeholders/mugs/box_01_xS8dUxn.jpg	0.5x0.5		3	432
1083	products/saleor/static/placeholders/mugs/3_RCIXPyv.jpg	0.5x0.5		0	433
1084	products/saleor/static/placeholders/mugs/7_ScWW78H.jpg	0.5x0.5		1	433
1085	products/saleor/static/placeholders/mugs/3_eMnWcbl.jpg	0.5x0.5		2	433
1086	products/saleor/static/placeholders/mugs/3_mL9tzZA.jpg	0.5x0.5		0	434
1087	products/saleor/static/placeholders/mugs/7_XTU02em.jpg	0.5x0.5		1	434
1088	products/saleor/static/placeholders/mugs/3_Xbmypmp.jpg	0.5x0.5		2	434
1089	products/saleor/static/placeholders/mugs/4_LEV8617.jpg	0.5x0.5		0	435
1090	products/saleor/static/placeholders/mugs/3_D6HIET4.jpg	0.5x0.5		1	435
1091	products/saleor/static/placeholders/mugs/7_SKJDJGe.jpg	0.5x0.5		2	435
1092	products/saleor/static/placeholders/mugs/4_zaTJwDi.jpg	0.5x0.5		3	435
1093	products/saleor/static/placeholders/mugs/4_l6vu1Xr.jpg	0.5x0.5		0	436
1094	products/saleor/static/placeholders/mugs/7_SpSL9QB.jpg	0.5x0.5		0	437
1095	products/saleor/static/placeholders/mugs/box_01_1yUL6c5.jpg	0.5x0.5		0	438
1096	products/saleor/static/placeholders/mugs/7_ha6MltC.jpg	0.5x0.5		1	438
1097	products/saleor/static/placeholders/mugs/7_Ory9BgV.jpg	0.5x0.5		2	438
1098	products/saleor/static/placeholders/mugs/7_CmaFvRG.jpg	0.5x0.5		0	439
1099	products/saleor/static/placeholders/mugs/box_01_XRdfcXF.jpg	0.5x0.5		1	439
1100	products/saleor/static/placeholders/mugs/7_XhADGtx.jpg	0.5x0.5		2	439
1101	products/saleor/static/placeholders/mugs/4_x7ibbiH.jpg	0.5x0.5		3	439
1102	products/saleor/static/placeholders/mugs/3_OwJ2yjq.jpg	0.5x0.5		0	440
1103	products/saleor/static/placeholders/mugs/4_0bcmcBC.jpg	0.5x0.5		1	440
1104	products/saleor/static/placeholders/mugs/box_01_qnCZnlw.jpg	0.5x0.5		2	440
1105	products/saleor/static/placeholders/candy/2_XU5B6Me.jpg	0.5x0.5		0	441
1106	products/saleor/static/placeholders/candy/1_WLxTBex.jpg	0.5x0.5		1	441
1107	products/saleor/static/placeholders/candy/1_ywilcVQ.jpg	0.5x0.5		0	442
1108	products/saleor/static/placeholders/candy/1_I4EY8qm.jpg	0.5x0.5		0	443
1109	products/saleor/static/placeholders/candy/2_2YUDkqc.jpg	0.5x0.5		1	443
1110	products/saleor/static/placeholders/candy/2_gX0nVs0.jpg	0.5x0.5		2	443
1111	products/saleor/static/placeholders/candy/2_oLhqMzg.jpg	0.5x0.5		0	444
1112	products/saleor/static/placeholders/candy/1_iVVYDiE.jpg	0.5x0.5		1	444
1113	products/saleor/static/placeholders/candy/2_DA2AURP.jpg	0.5x0.5		0	445
1114	products/saleor/static/placeholders/candy/1_t19fnxC.jpg	0.5x0.5		1	445
1115	products/saleor/static/placeholders/candy/2_HH47PAp.jpg	0.5x0.5		0	446
1116	products/saleor/static/placeholders/candy/2_rJbrrWv.jpg	0.5x0.5		1	446
1117	products/saleor/static/placeholders/candy/1_9RQIFlw.jpg	0.5x0.5		0	447
1118	products/saleor/static/placeholders/candy/2_IGB40aa.jpg	0.5x0.5		1	447
1119	products/saleor/static/placeholders/candy/2_RAXjw2R.jpg	0.5x0.5		0	448
1120	products/saleor/static/placeholders/candy/2_vNn8eJ3.jpg	0.5x0.5		1	448
1121	products/saleor/static/placeholders/candy/2_IyRSbIQ.jpg	0.5x0.5		2	448
1122	products/saleor/static/placeholders/candy/1_uK4kN9f.jpg	0.5x0.5		0	449
1123	products/saleor/static/placeholders/candy/2_NvBj6KW.jpg	0.5x0.5		1	449
1124	products/saleor/static/placeholders/candy/1_lyIPfKS.jpg	0.5x0.5		2	449
1125	products/saleor/static/placeholders/candy/1_mdbV6VB.jpg	0.5x0.5		3	449
1126	products/saleor/static/placeholders/candy/2_11im6zr.jpg	0.5x0.5		0	450
1127	products/saleor/static/placeholders/candy/2_HmKeJcD.jpg	0.5x0.5		1	450
1128	products/saleor/static/placeholders/candy/1_os1PGkE.jpg	0.5x0.5		2	450
1129	products/saleor/static/placeholders/t-shirts/5_Mf38u0z.jpg	0.5x0.5		0	451
1130	products/saleor/static/placeholders/t-shirts/5_F6IUIZP.jpg	0.5x0.5		0	452
1131	products/saleor/static/placeholders/t-shirts/6_RuDTP0i.jpg	0.5x0.5		1	452
1132	products/saleor/static/placeholders/t-shirts/6_u09PODn.jpg	0.5x0.5		2	452
1133	products/saleor/static/placeholders/t-shirts/5_KM11tTd.jpg	0.5x0.5		3	452
1134	products/saleor/static/placeholders/t-shirts/5_DQn6uvR.jpg	0.5x0.5		0	453
1135	products/saleor/static/placeholders/t-shirts/6_TjgLnKe.jpg	0.5x0.5		1	453
1136	products/saleor/static/placeholders/t-shirts/5_GJNVDZZ.jpg	0.5x0.5		2	453
1137	products/saleor/static/placeholders/t-shirts/5_01tTfk2.jpg	0.5x0.5		3	453
1138	products/saleor/static/placeholders/t-shirts/5_2rAfQe5.jpg	0.5x0.5		0	454
1139	products/saleor/static/placeholders/t-shirts/5_48bthRC.jpg	0.5x0.5		0	455
1140	products/saleor/static/placeholders/t-shirts/6_IrWKif5.jpg	0.5x0.5		1	455
1141	products/saleor/static/placeholders/t-shirts/6_aPz5zLD.jpg	0.5x0.5		0	456
1142	products/saleor/static/placeholders/t-shirts/6_6gd0d3a.jpg	0.5x0.5		1	456
1143	products/saleor/static/placeholders/t-shirts/5_C0EfFKE.jpg	0.5x0.5		2	456
1144	products/saleor/static/placeholders/t-shirts/6_CyrtPeo.jpg	0.5x0.5		3	456
1145	products/saleor/static/placeholders/t-shirts/5_IWV26AI.jpg	0.5x0.5		0	457
1146	products/saleor/static/placeholders/t-shirts/6_EK8S3h2.jpg	0.5x0.5		1	457
1147	products/saleor/static/placeholders/t-shirts/5_ItSVfzX.jpg	0.5x0.5		2	457
1148	products/saleor/static/placeholders/t-shirts/5_gF7gWLG.jpg	0.5x0.5		0	458
1149	products/saleor/static/placeholders/t-shirts/5_6lsGpDB.jpg	0.5x0.5		0	459
1150	products/saleor/static/placeholders/t-shirts/6_XXRzy6K.jpg	0.5x0.5		1	459
1151	products/saleor/static/placeholders/t-shirts/6_80YcYrR.jpg	0.5x0.5		2	459
1152	products/saleor/static/placeholders/t-shirts/6_7fDuPPF.jpg	0.5x0.5		3	459
1153	products/saleor/static/placeholders/t-shirts/6_3FqMQZt.jpg	0.5x0.5		0	460
1154	products/saleor/static/placeholders/t-shirts/5_ftSAdlk.jpg	0.5x0.5		1	460
1155	products/saleor/static/placeholders/books/book_05_PMXHy9v.jpg	0.5x0.5		0	461
1156	products/saleor/static/placeholders/books/book_03_tnw692M.jpg	0.5x0.5		1	461
1157	products/saleor/static/placeholders/books/book_03_EXmpOkg.jpg	0.5x0.5		2	461
1158	products/saleor/static/placeholders/books/book_04_vFjaIpA.jpg	0.5x0.5		0	462
1159	products/saleor/static/placeholders/books/book_05_HQiBAmU.jpg	0.5x0.5		1	462
1160	products/saleor/static/placeholders/books/book_01_P5ztRLt.jpg	0.5x0.5		2	462
1161	products/saleor/static/placeholders/books/book_02_Yth6FUv.jpg	0.5x0.5		3	462
1162	products/saleor/static/placeholders/books/book_01_jkCnCBe.jpg	0.5x0.5		0	463
1163	products/saleor/static/placeholders/books/book_04_8qRV383.jpg	0.5x0.5		0	464
1164	products/saleor/static/placeholders/books/book_04_HmUKFL3.jpg	0.5x0.5		0	465
1165	products/saleor/static/placeholders/books/book_01_4UcApuA.jpg	0.5x0.5		1	465
1166	products/saleor/static/placeholders/books/book_04_SeRjzFe.jpg	0.5x0.5		2	465
1167	products/saleor/static/placeholders/books/book_04_uugnoCA.jpg	0.5x0.5		3	465
1168	products/saleor/static/placeholders/books/book_05_wFhY7eH.jpg	0.5x0.5		0	466
1169	products/saleor/static/placeholders/books/book_01_DByuQ4z.jpg	0.5x0.5		1	466
1170	products/saleor/static/placeholders/books/book_03_fhOGxas.jpg	0.5x0.5		2	466
1171	products/saleor/static/placeholders/books/book_03_uWRNVTA.jpg	0.5x0.5		3	466
1172	products/saleor/static/placeholders/books/book_01_emLeHQT.jpg	0.5x0.5		0	467
1173	products/saleor/static/placeholders/books/book_01_Wi0P8K7.jpg	0.5x0.5		0	468
1174	products/saleor/static/placeholders/books/book_01_E0bNbk7.jpg	0.5x0.5		1	468
1175	products/saleor/static/placeholders/books/book_02_5P9ForE.jpg	0.5x0.5		2	468
1176	products/saleor/static/placeholders/books/book_01_4wg0sKw.jpg	0.5x0.5		3	468
1177	products/saleor/static/placeholders/books/book_05_PlNtLag.jpg	0.5x0.5		0	469
1178	products/saleor/static/placeholders/books/book_03_uLa0bq6.jpg	0.5x0.5		1	469
1179	products/saleor/static/placeholders/books/book_02_plo56lD.jpg	0.5x0.5		2	469
1180	products/saleor/static/placeholders/books/book_03_oNP0cwa.jpg	0.5x0.5		3	469
1181	products/saleor/static/placeholders/books/book_02_A3jj8L8.jpg	0.5x0.5		0	470
1182	products/saleor/static/placeholders/books/book_02_z8OriOe.jpg	0.5x0.5		1	470
1183	products/saleor/static/placeholders/books/book_02_By9HEnD.jpg	0.5x0.5		2	470
1184	products/saleor/static/placeholders/books/book_03_wsQaYiL.jpg	0.5x0.5		3	470
1185	products/saleor/static/placeholders/books/book_01_y9Aj1Zw.jpg	0.5x0.5		0	471
1186	products/saleor/static/placeholders/books/book_02_4vU6MiV.jpg	0.5x0.5		1	471
1187	products/saleor/static/placeholders/books/book_05_vGrrLE0.jpg	0.5x0.5		2	471
1188	products/saleor/static/placeholders/books/book_04_p2hCU8O.jpg	0.5x0.5		3	471
1189	products/saleor/static/placeholders/books/book_02_LgYeX43.jpg	0.5x0.5		0	472
1190	products/saleor/static/placeholders/books/book_01_jJCN4mf.jpg	0.5x0.5		0	473
1191	products/saleor/static/placeholders/books/book_05_pU2KerH.jpg	0.5x0.5		0	474
1192	products/saleor/static/placeholders/books/book_04_F5ONgLF.jpg	0.5x0.5		1	474
1193	products/saleor/static/placeholders/books/book_04_gdQtU7v.jpg	0.5x0.5		2	474
1194	products/saleor/static/placeholders/books/book_03_JDSctmr.jpg	0.5x0.5		0	475
1195	products/saleor/static/placeholders/books/book_02_7c3bEQR.jpg	0.5x0.5		1	475
1196	products/saleor/static/placeholders/books/book_01_3kfsIU0.jpg	0.5x0.5		2	475
1197	products/saleor/static/placeholders/books/book_02_cb6u2WI.jpg	0.5x0.5		0	476
1198	products/saleor/static/placeholders/books/book_04_NCwsfQc.jpg	0.5x0.5		1	476
1199	products/saleor/static/placeholders/books/book_02_HAWCvYN.jpg	0.5x0.5		0	477
1200	products/saleor/static/placeholders/books/book_01_o9B4oe3.jpg	0.5x0.5		1	477
1201	products/saleor/static/placeholders/books/book_02_6vU5p3p.jpg	0.5x0.5		0	478
1202	products/saleor/static/placeholders/books/book_03_IGv8QAf.jpg	0.5x0.5		1	478
1203	products/saleor/static/placeholders/books/book_01_uzZtOfS.jpg	0.5x0.5		2	478
1204	products/saleor/static/placeholders/books/book_03_dEIyOOZ.jpg	0.5x0.5		3	478
1205	products/saleor/static/placeholders/books/book_01_fP42SVD.jpg	0.5x0.5		0	479
1206	products/saleor/static/placeholders/books/book_02_VSRsYs7.jpg	0.5x0.5		1	479
1207	products/saleor/static/placeholders/books/book_01_0k2Hfli.jpg	0.5x0.5		2	479
1208	products/saleor/static/placeholders/books/book_04_k5ha2aL.jpg	0.5x0.5		0	480
1209	products/saleor/static/placeholders/books/book_02_uH5Mnqs.jpg	0.5x0.5		1	480
1210	products/saleor/static/placeholders/books/book_02_ZssmwPF.jpg	0.5x0.5		2	480
1211	products/saleor/static/placeholders/coffee/coffee_03_efzAwUk.jpg	0.5x0.5		0	481
1212	products/saleor/static/placeholders/coffee/coffee_01_Mz0v9LD.jpg	0.5x0.5		1	481
1213	products/saleor/static/placeholders/coffee/8_Vxd4tOh.jpg	0.5x0.5		2	481
1214	products/saleor/static/placeholders/coffee/coffee_01_XMai8qp.jpg	0.5x0.5		0	482
1215	products/saleor/static/placeholders/coffee/coffee_04_96g0EjR.jpg	0.5x0.5		1	482
1216	products/saleor/static/placeholders/coffee/coffee_02_50eJQKm.jpg	0.5x0.5		2	482
1217	products/saleor/static/placeholders/coffee/coffee_03_PYSSUyX.jpg	0.5x0.5		3	482
1218	products/saleor/static/placeholders/coffee/coffee_04_SgVwFgV.jpg	0.5x0.5		0	483
1219	products/saleor/static/placeholders/coffee/coffee_03_2p7L9kN.jpg	0.5x0.5		1	483
1220	products/saleor/static/placeholders/coffee/coffee_01_lgRJyyV.jpg	0.5x0.5		2	483
1221	products/saleor/static/placeholders/coffee/coffee_01_uVYXCsa.jpg	0.5x0.5		0	484
1222	products/saleor/static/placeholders/coffee/coffee_01_PEqBqTj.jpg	0.5x0.5		1	484
1223	products/saleor/static/placeholders/coffee/coffee_03_T0EuLWu.jpg	0.5x0.5		2	484
1224	products/saleor/static/placeholders/coffee/coffee_01_QGtdwRX.jpg	0.5x0.5		0	485
1225	products/saleor/static/placeholders/coffee/8_jAzUQJx.jpg	0.5x0.5		0	486
1226	products/saleor/static/placeholders/coffee/coffee_02_MycZ4Br.jpg	0.5x0.5		1	486
1227	products/saleor/static/placeholders/coffee/8_BGX2mX2.jpg	0.5x0.5		2	486
1228	products/saleor/static/placeholders/coffee/8_lGvpMKE.jpg	0.5x0.5		0	487
1229	products/saleor/static/placeholders/coffee/8_LXe5PfD.jpg	0.5x0.5		1	487
1230	products/saleor/static/placeholders/coffee/coffee_03_fFOkwSq.jpg	0.5x0.5		0	488
1231	products/saleor/static/placeholders/coffee/coffee_02_4xYfL7Y.jpg	0.5x0.5		1	488
1232	products/saleor/static/placeholders/coffee/coffee_01_W6BHPNA.jpg	0.5x0.5		2	488
1233	products/saleor/static/placeholders/coffee/coffee_02_Iyp6DTK.jpg	0.5x0.5		0	489
1234	products/saleor/static/placeholders/coffee/coffee_03_LKhAjHp.jpg	0.5x0.5		1	489
1235	products/saleor/static/placeholders/coffee/coffee_03_ZUpnabb.jpg	0.5x0.5		2	489
1236	products/saleor/static/placeholders/coffee/coffee_01_5E5EjfL.jpg	0.5x0.5		3	489
1237	products/saleor/static/placeholders/coffee/coffee_04_I6jO3Tr.jpg	0.5x0.5		0	490
1238	products/saleor/static/placeholders/coffee/coffee_02_567CFzc.jpg	0.5x0.5		1	490
1239	products/saleor/static/placeholders/coffee/coffee_03_A0Npa16.jpg	0.5x0.5		2	490
1240	products/saleor/static/placeholders/coffee/coffee_04_LerwRbk.jpg	0.5x0.5		3	490
1241	products/saleor/static/placeholders/mugs/3_XvuJfiz.jpg	0.5x0.5		0	491
1242	products/saleor/static/placeholders/mugs/box_01_AESongg.jpg	0.5x0.5		0	492
1243	products/saleor/static/placeholders/mugs/3_tsFccCc.jpg	0.5x0.5		1	492
1244	products/saleor/static/placeholders/mugs/7_9lPTS7y.jpg	0.5x0.5		0	493
1245	products/saleor/static/placeholders/mugs/4_scNPGYo.jpg	0.5x0.5		1	493
1246	products/saleor/static/placeholders/mugs/4_AYmdDo0.jpg	0.5x0.5		2	493
1247	products/saleor/static/placeholders/mugs/7_VAucmkx.jpg	0.5x0.5		3	493
1248	products/saleor/static/placeholders/mugs/box_01_AjAzFnN.jpg	0.5x0.5		0	494
1249	products/saleor/static/placeholders/mugs/4_shVxuLl.jpg	0.5x0.5		1	494
1250	products/saleor/static/placeholders/mugs/7_jaG2eYp.jpg	0.5x0.5		0	495
1251	products/saleor/static/placeholders/mugs/box_01_6kGmPbg.jpg	0.5x0.5		1	495
1252	products/saleor/static/placeholders/mugs/4_MxdtKj7.jpg	0.5x0.5		2	495
1253	products/saleor/static/placeholders/mugs/4_M10T8tX.jpg	0.5x0.5		0	496
1254	products/saleor/static/placeholders/mugs/box_01_9ILoZPj.jpg	0.5x0.5		1	496
1255	products/saleor/static/placeholders/mugs/7_KxhdqyA.jpg	0.5x0.5		2	496
1256	products/saleor/static/placeholders/mugs/box_01_4u4L8Ky.jpg	0.5x0.5		3	496
1257	products/saleor/static/placeholders/mugs/7_B71NSuP.jpg	0.5x0.5		0	497
1258	products/saleor/static/placeholders/mugs/7_DrJ1fmO.jpg	0.5x0.5		1	497
1259	products/saleor/static/placeholders/mugs/4_IvJLHli.jpg	0.5x0.5		2	497
1260	products/saleor/static/placeholders/mugs/box_01_TkQZXVK.jpg	0.5x0.5		3	497
1261	products/saleor/static/placeholders/mugs/4_oYtWPem.jpg	0.5x0.5		0	498
1262	products/saleor/static/placeholders/mugs/7_3q3d1bJ.jpg	0.5x0.5		1	498
1263	products/saleor/static/placeholders/mugs/3_r0nSwH7.jpg	0.5x0.5		2	498
1264	products/saleor/static/placeholders/mugs/7_Gmr5mfM.jpg	0.5x0.5		3	498
1265	products/saleor/static/placeholders/mugs/7_jDICXIF.jpg	0.5x0.5		0	499
1266	products/saleor/static/placeholders/mugs/box_01_5OH1Ghc.jpg	0.5x0.5		1	499
1267	products/saleor/static/placeholders/mugs/3_PxJXvme.jpg	0.5x0.5		2	499
1268	products/saleor/static/placeholders/mugs/3_seo3YVO.jpg	0.5x0.5		0	500
1269	products/saleor/static/placeholders/mugs/box_01_bqGw3Xr.jpg	0.5x0.5		1	500
1270	products/saleor/static/placeholders/mugs/box_01_uRjrfxB.jpg	0.5x0.5		2	500
1271	products/saleor/static/placeholders/candy/2_FLDwNhd.jpg	0.5x0.5		0	501
1272	products/saleor/static/placeholders/candy/2_9NBJYtQ.jpg	0.5x0.5		1	501
1273	products/saleor/static/placeholders/candy/2_XnSXMCM.jpg	0.5x0.5		2	501
1274	products/saleor/static/placeholders/candy/2_Z3rizPt.jpg	0.5x0.5		0	502
1275	products/saleor/static/placeholders/candy/1_TWJEN6I.jpg	0.5x0.5		1	502
1276	products/saleor/static/placeholders/candy/1_4F3wLSF.jpg	0.5x0.5		2	502
1277	products/saleor/static/placeholders/candy/1_6psbOEK.jpg	0.5x0.5		3	502
1278	products/saleor/static/placeholders/candy/1_iQL6mvj.jpg	0.5x0.5		0	503
1279	products/saleor/static/placeholders/candy/2_5LHalBT.jpg	0.5x0.5		1	503
1280	products/saleor/static/placeholders/candy/2_mGGjRpd.jpg	0.5x0.5		2	503
1281	products/saleor/static/placeholders/candy/2_u3NcaKw.jpg	0.5x0.5		0	504
1282	products/saleor/static/placeholders/candy/1_3eAm2n6.jpg	0.5x0.5		1	504
1283	products/saleor/static/placeholders/candy/1_tAPKvxU.jpg	0.5x0.5		2	504
1284	products/saleor/static/placeholders/candy/2_M8sEk2q.jpg	0.5x0.5		0	505
1285	products/saleor/static/placeholders/candy/1_Us1xoLe.jpg	0.5x0.5		1	505
1286	products/saleor/static/placeholders/candy/1_wmpu0HU.jpg	0.5x0.5		2	505
1287	products/saleor/static/placeholders/candy/1_e1pb4nx.jpg	0.5x0.5		3	505
1288	products/saleor/static/placeholders/candy/1_qv8WsZN.jpg	0.5x0.5		0	506
1289	products/saleor/static/placeholders/candy/1_n6tpVoJ.jpg	0.5x0.5		1	506
1290	products/saleor/static/placeholders/candy/1_kX67F0u.jpg	0.5x0.5		2	506
1291	products/saleor/static/placeholders/candy/1_VjATFsc.jpg	0.5x0.5		3	506
1292	products/saleor/static/placeholders/candy/1_0fYN0oB.jpg	0.5x0.5		0	507
1293	products/saleor/static/placeholders/candy/2_ATcAUM0.jpg	0.5x0.5		1	507
1294	products/saleor/static/placeholders/candy/2_VgOHoLB.jpg	0.5x0.5		0	508
1295	products/saleor/static/placeholders/candy/1_RIoSiO3.jpg	0.5x0.5		0	509
1296	products/saleor/static/placeholders/candy/1_11SGwnx.jpg	0.5x0.5		0	510
1297	products/saleor/static/placeholders/candy/2_05NKreG.jpg	0.5x0.5		1	510
1298	products/saleor/static/placeholders/candy/1_ES6ZmXi.jpg	0.5x0.5		2	510
1299	products/saleor/static/placeholders/t-shirts/6_2dZBsve.jpg	0.5x0.5		0	511
1300	products/saleor/static/placeholders/t-shirts/6_3Djr8EU.jpg	0.5x0.5		1	511
1301	products/saleor/static/placeholders/t-shirts/5_HzIvsdj.jpg	0.5x0.5		2	511
1302	products/saleor/static/placeholders/t-shirts/5_2pTG5lX.jpg	0.5x0.5		0	512
1303	products/saleor/static/placeholders/t-shirts/5_EnXMlo8.jpg	0.5x0.5		1	512
1304	products/saleor/static/placeholders/t-shirts/6_TbYTMvT.jpg	0.5x0.5		2	512
1305	products/saleor/static/placeholders/t-shirts/5_miwRZ1x.jpg	0.5x0.5		3	512
1306	products/saleor/static/placeholders/t-shirts/6_uTDQnut.jpg	0.5x0.5		0	513
1307	products/saleor/static/placeholders/t-shirts/5_bQ09NPA.jpg	0.5x0.5		1	513
1308	products/saleor/static/placeholders/t-shirts/5_YHjADhE.jpg	0.5x0.5		0	514
1309	products/saleor/static/placeholders/t-shirts/6_kxgbVFq.jpg	0.5x0.5		0	515
1310	products/saleor/static/placeholders/t-shirts/6_Fh4cRd5.jpg	0.5x0.5		0	516
1311	products/saleor/static/placeholders/t-shirts/6_RY1vdoy.jpg	0.5x0.5		1	516
1312	products/saleor/static/placeholders/t-shirts/5_eVPzVZp.jpg	0.5x0.5		2	516
1313	products/saleor/static/placeholders/t-shirts/6_Ppu6rjb.jpg	0.5x0.5		0	517
1314	products/saleor/static/placeholders/t-shirts/5_n221Ons.jpg	0.5x0.5		1	517
1315	products/saleor/static/placeholders/t-shirts/6_02Tzq1v.jpg	0.5x0.5		2	517
1316	products/saleor/static/placeholders/t-shirts/6_xycvgKk.jpg	0.5x0.5		0	518
1317	products/saleor/static/placeholders/t-shirts/6_laKL9vL.jpg	0.5x0.5		0	519
1318	products/saleor/static/placeholders/t-shirts/6_MtIkmUI.jpg	0.5x0.5		0	520
1319	products/saleor/static/placeholders/t-shirts/5_bimeUW6.jpg	0.5x0.5		1	520
1320	products/saleor/static/placeholders/t-shirts/6_WGPTVk7.jpg	0.5x0.5		2	520
1321	products/saleor/static/placeholders/t-shirts/5_R1yiDJ1.jpg	0.5x0.5		3	520
1322	products/saleor/static/placeholders/books/book_05_EIoHXNX.jpg	0.5x0.5		0	521
1323	products/saleor/static/placeholders/books/book_02_PIBLXcC.jpg	0.5x0.5		1	521
1324	products/saleor/static/placeholders/books/book_02_xO0uRqn.jpg	0.5x0.5		2	521
1325	products/saleor/static/placeholders/books/book_02_0Jupl5B.jpg	0.5x0.5		3	521
1326	products/saleor/static/placeholders/books/book_05_txKtKa5.jpg	0.5x0.5		0	522
1327	products/saleor/static/placeholders/books/book_03_2fnAxoL.jpg	0.5x0.5		0	523
1328	products/saleor/static/placeholders/books/book_01_x5GOGwv.jpg	0.5x0.5		1	523
1329	products/saleor/static/placeholders/books/book_03_HxPCKOs.jpg	0.5x0.5		0	524
1330	products/saleor/static/placeholders/books/book_02_Ndy4mMO.jpg	0.5x0.5		1	524
1331	products/saleor/static/placeholders/books/book_03_asde1ph.jpg	0.5x0.5		2	524
1332	products/saleor/static/placeholders/books/book_05_bapMA3b.jpg	0.5x0.5		3	524
1333	products/saleor/static/placeholders/books/book_03_f15zxnV.jpg	0.5x0.5		0	525
1334	products/saleor/static/placeholders/books/book_03_OG8e1yc.jpg	0.5x0.5		1	525
1335	products/saleor/static/placeholders/books/book_05_Cdmzh6s.jpg	0.5x0.5		2	525
1336	products/saleor/static/placeholders/books/book_01_poHOhIm.jpg	0.5x0.5		0	526
1337	products/saleor/static/placeholders/books/book_04_QyLXgwF.jpg	0.5x0.5		1	526
1338	products/saleor/static/placeholders/books/book_04_4lAkyvx.jpg	0.5x0.5		2	526
1339	products/saleor/static/placeholders/books/book_05_gbYXmI6.jpg	0.5x0.5		3	526
1340	products/saleor/static/placeholders/books/book_01_zOyc7Id.jpg	0.5x0.5		0	527
1341	products/saleor/static/placeholders/books/book_02_XKpoTUJ.jpg	0.5x0.5		1	527
1342	products/saleor/static/placeholders/books/book_04_AMOM9SP.jpg	0.5x0.5		2	527
1343	products/saleor/static/placeholders/books/book_03_FH14jxq.jpg	0.5x0.5		3	527
1344	products/saleor/static/placeholders/books/book_04_lJJHHAY.jpg	0.5x0.5		0	528
1345	products/saleor/static/placeholders/books/book_05_dkHO1Go.jpg	0.5x0.5		1	528
1346	products/saleor/static/placeholders/books/book_05_faVx353.jpg	0.5x0.5		2	528
1347	products/saleor/static/placeholders/books/book_02_4HbtQ4J.jpg	0.5x0.5		0	529
1348	products/saleor/static/placeholders/books/book_01_2RJnCHk.jpg	0.5x0.5		1	529
1349	products/saleor/static/placeholders/books/book_04_eZLOOM0.jpg	0.5x0.5		2	529
1350	products/saleor/static/placeholders/books/book_04_u5wfDSC.jpg	0.5x0.5		0	530
1351	products/saleor/static/placeholders/books/book_04_LD9YLnn.jpg	0.5x0.5		1	530
1352	products/saleor/static/placeholders/books/book_04_w13kfWI.jpg	0.5x0.5		2	530
1353	products/saleor/static/placeholders/books/book_02_LWMm5Y5.jpg	0.5x0.5		3	530
1354	products/saleor/static/placeholders/books/book_04_6Kt66WT.jpg	0.5x0.5		0	531
1355	products/saleor/static/placeholders/books/book_05_OA8XO1r.jpg	0.5x0.5		1	531
1356	products/saleor/static/placeholders/books/book_02_ul8Wvc9.jpg	0.5x0.5		2	531
1357	products/saleor/static/placeholders/books/book_04_bjJmWHe.jpg	0.5x0.5		0	532
1358	products/saleor/static/placeholders/books/book_03_PWlM5GO.jpg	0.5x0.5		1	532
1359	products/saleor/static/placeholders/books/book_01_AsX6PWB.jpg	0.5x0.5		0	533
1360	products/saleor/static/placeholders/books/book_05_nv9Cw3o.jpg	0.5x0.5		1	533
1361	products/saleor/static/placeholders/books/book_03_Gih1utI.jpg	0.5x0.5		2	533
1362	products/saleor/static/placeholders/books/book_05_B1g1FWL.jpg	0.5x0.5		3	533
1363	products/saleor/static/placeholders/books/book_01_mqPxnF5.jpg	0.5x0.5		0	534
1364	products/saleor/static/placeholders/books/book_04_nwpPJtv.jpg	0.5x0.5		1	534
1365	products/saleor/static/placeholders/books/book_05_Y4zj4IO.jpg	0.5x0.5		0	535
1366	products/saleor/static/placeholders/books/book_03_hoNs8ns.jpg	0.5x0.5		1	535
1367	products/saleor/static/placeholders/books/book_01_pA2inn3.jpg	0.5x0.5		2	535
1368	products/saleor/static/placeholders/books/book_05_VMwncSx.jpg	0.5x0.5		3	535
1369	products/saleor/static/placeholders/books/book_03_uoVR3o4.jpg	0.5x0.5		0	536
1370	products/saleor/static/placeholders/books/book_05_6DCv0nd.jpg	0.5x0.5		0	537
1371	products/saleor/static/placeholders/books/book_02_ylHYqgH.jpg	0.5x0.5		0	538
1372	products/saleor/static/placeholders/books/book_05_iDJgsIV.jpg	0.5x0.5		1	538
1373	products/saleor/static/placeholders/books/book_02_90Vd8OJ.jpg	0.5x0.5		2	538
1374	products/saleor/static/placeholders/books/book_01_7eRQgsX.jpg	0.5x0.5		0	539
1375	products/saleor/static/placeholders/books/book_02_hZQZgV8.jpg	0.5x0.5		1	539
1376	products/saleor/static/placeholders/books/book_02_3LiE19R.jpg	0.5x0.5		2	539
1377	products/saleor/static/placeholders/books/book_01_3GXWDwW.jpg	0.5x0.5		3	539
1378	products/saleor/static/placeholders/books/book_03_wVBADYS.jpg	0.5x0.5		0	540
1379	products/saleor/static/placeholders/books/book_01_CH7xeQG.jpg	0.5x0.5		1	540
1380	products/saleor/static/placeholders/books/book_04_ra3gnEw.jpg	0.5x0.5		2	540
1381	products/saleor/static/placeholders/books/book_02_binaFqv.jpg	0.5x0.5		3	540
\.


--
-- Data for Name: product_productvariant; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_productvariant (id, sku, name, price_override, product_id, attributes) FROM stdin;
1	1-1337		165.45	1	"3"=>"7"
2	1-1338		157.39	1	"3"=>"6"
3	1-1339		154.99	1	"3"=>"5"
4	1-1340		116.24	1	"3"=>"4"
5	2-1337		176.22	2	"3"=>"7"
6	2-1338		125.70	2	"3"=>"6"
7	2-1339		113.28	2	"3"=>"5"
8	2-1340		104.65	2	"3"=>"4"
9	3-1337		67.31	3	"3"=>"7"
10	3-1338		63.27	3	"3"=>"6"
11	3-1339		58.98	3	"3"=>"5"
12	3-1340		29.05	3	"3"=>"4"
13	4-1337		96.83	4	"3"=>"7"
14	4-1338		94.85	4	"3"=>"6"
15	4-1339		84.94	4	"3"=>"5"
16	4-1340		81.07	4	"3"=>"4"
17	5-1337		143.23	5	"3"=>"7"
18	5-1338		120.18	5	"3"=>"6"
19	5-1339		95.88	5	"3"=>"5"
20	5-1340		83.88	5	"3"=>"4"
21	6-1337		54.04	6	"3"=>"7"
22	6-1338		31.93	6	"3"=>"6"
23	6-1339		15.74	6	"3"=>"5"
24	6-1340		14.32	6	"3"=>"4"
25	7-1337		126.00	7	"3"=>"7"
26	7-1338		111.69	7	"3"=>"6"
27	7-1339		101.04	7	"3"=>"5"
28	7-1340		55.57	7	"3"=>"4"
29	8-1337		103.91	8	"3"=>"7"
30	8-1338		86.04	8	"3"=>"6"
31	8-1339		65.97	8	"3"=>"5"
32	8-1340		61.61	8	"3"=>"4"
33	9-1337		71.92	9	"3"=>"7"
34	9-1338		53.67	9	"3"=>"6"
35	9-1339		49.54	9	"3"=>"5"
36	9-1340		48.64	9	"3"=>"4"
37	10-1337		143.19	10	"3"=>"7"
38	10-1338		111.46	10	"3"=>"6"
39	10-1339		96.69	10	"3"=>"5"
40	10-1340		61.54	10	"3"=>"4"
41	11-1337		\N	11	
42	12-1337		\N	12	
43	13-1337		\N	13	
44	14-1337		\N	14	
45	15-1337		\N	15	
46	16-1337		\N	16	
47	17-1337		\N	17	
48	18-1337		\N	18	
49	19-1337		\N	19	
50	20-1337		\N	20	
51	21-1337		113.33	21	"5"=>"12"
52	21-1338		57.70	21	"5"=>"11"
53	21-1339		48.39	21	"5"=>"10"
54	22-1337		68.02	22	"5"=>"12"
55	22-1338		67.68	22	"5"=>"11"
56	22-1339		13.25	22	"5"=>"10"
57	23-1337		107.37	23	"5"=>"12"
58	23-1338		103.90	23	"5"=>"11"
59	23-1339		44.02	23	"5"=>"10"
60	24-1337		191.26	24	"5"=>"12"
61	24-1338		138.53	24	"5"=>"11"
62	24-1339		127.54	24	"5"=>"10"
63	25-1337		182.46	25	"5"=>"12"
64	25-1338		162.13	25	"5"=>"11"
65	25-1339		101.30	25	"5"=>"10"
66	26-1337		33.16	26	"5"=>"12"
67	26-1338		31.73	26	"5"=>"11"
68	26-1339		24.92	26	"5"=>"10"
69	27-1337		174.17	27	"5"=>"12"
70	27-1338		137.62	27	"5"=>"11"
71	27-1339		107.17	27	"5"=>"10"
72	28-1337		155.08	28	"5"=>"12"
73	28-1338		135.99	28	"5"=>"11"
74	28-1339		100.25	28	"5"=>"10"
75	29-1337		99.31	29	"5"=>"12"
76	29-1338		84.86	29	"5"=>"11"
77	29-1339		73.66	29	"5"=>"10"
78	30-1337		114.91	30	"5"=>"12"
79	30-1338		106.61	30	"5"=>"11"
80	30-1339		60.63	30	"5"=>"10"
81	31-1337		\N	31	"8"=>"23"
82	31-1338		\N	31	"8"=>"22"
83	31-1339		\N	31	"8"=>"21"
84	31-1340		\N	31	"8"=>"20"
85	31-1341		\N	31	"8"=>"19"
86	31-1342		\N	31	"8"=>"18"
87	32-1337		\N	32	"8"=>"23"
88	32-1338		\N	32	"8"=>"22"
89	32-1339		\N	32	"8"=>"21"
90	32-1340		\N	32	"8"=>"20"
91	32-1341		\N	32	"8"=>"19"
92	32-1342		\N	32	"8"=>"18"
93	33-1337		\N	33	"8"=>"23"
94	33-1338		\N	33	"8"=>"22"
95	33-1339		\N	33	"8"=>"21"
96	33-1340		\N	33	"8"=>"20"
97	33-1341		\N	33	"8"=>"19"
98	33-1342		\N	33	"8"=>"18"
99	34-1337		\N	34	"8"=>"23"
100	34-1338		\N	34	"8"=>"22"
101	34-1339		\N	34	"8"=>"21"
102	34-1340		\N	34	"8"=>"20"
103	34-1341		\N	34	"8"=>"19"
104	34-1342		\N	34	"8"=>"18"
105	35-1337		\N	35	"8"=>"23"
106	35-1338		\N	35	"8"=>"22"
107	35-1339		\N	35	"8"=>"21"
108	35-1340		\N	35	"8"=>"20"
109	35-1341		\N	35	"8"=>"19"
110	35-1342		\N	35	"8"=>"18"
111	36-1337		\N	36	"8"=>"23"
112	36-1338		\N	36	"8"=>"22"
113	36-1339		\N	36	"8"=>"21"
114	36-1340		\N	36	"8"=>"20"
115	36-1341		\N	36	"8"=>"19"
116	36-1342		\N	36	"8"=>"18"
117	37-1337		\N	37	"8"=>"23"
118	37-1338		\N	37	"8"=>"22"
119	37-1339		\N	37	"8"=>"21"
120	37-1340		\N	37	"8"=>"20"
121	37-1341		\N	37	"8"=>"19"
122	37-1342		\N	37	"8"=>"18"
123	38-1337		\N	38	"8"=>"23"
124	38-1338		\N	38	"8"=>"22"
125	38-1339		\N	38	"8"=>"21"
126	38-1340		\N	38	"8"=>"20"
127	38-1341		\N	38	"8"=>"19"
128	38-1342		\N	38	"8"=>"18"
129	39-1337		\N	39	"8"=>"23"
130	39-1338		\N	39	"8"=>"22"
131	39-1339		\N	39	"8"=>"21"
132	39-1340		\N	39	"8"=>"20"
133	39-1341		\N	39	"8"=>"19"
134	39-1342		\N	39	"8"=>"18"
135	40-1337		\N	40	"8"=>"23"
136	40-1338		\N	40	"8"=>"22"
137	40-1339		\N	40	"8"=>"21"
138	40-1340		\N	40	"8"=>"20"
139	40-1341		\N	40	"8"=>"19"
140	40-1342		\N	40	"8"=>"18"
141	41-1337		122.95	41	"12"=>"31"
142	41-1338		68.67	41	"12"=>"30"
143	42-1337		120.65	42	"12"=>"31"
144	42-1338		79.75	42	"12"=>"30"
145	43-1337		135.12	43	"12"=>"31"
146	43-1338		134.74	43	"12"=>"30"
147	44-1337		169.20	44	"12"=>"31"
148	44-1338		137.88	44	"12"=>"30"
149	45-1337		113.54	45	"12"=>"31"
150	45-1338		67.51	45	"12"=>"30"
151	46-1337		129.49	46	"12"=>"31"
152	46-1338		113.45	46	"12"=>"30"
153	47-1337		109.19	47	"12"=>"31"
154	47-1338		55.59	47	"12"=>"30"
155	48-1337		113.86	48	"12"=>"31"
156	48-1338		85.74	48	"12"=>"30"
157	49-1337		147.28	49	"12"=>"31"
158	49-1338		96.08	49	"12"=>"30"
159	50-1337		164.88	50	"12"=>"31"
160	50-1338		91.52	50	"12"=>"30"
161	51-1337		\N	51	
162	52-1337		\N	52	
163	53-1337		\N	53	
164	54-1337		\N	54	
165	55-1337		\N	55	
166	56-1337		\N	56	
167	57-1337		\N	57	
168	58-1337		\N	58	
169	59-1337		\N	59	
170	60-1337		\N	60	
171	61-1337		82.98	61	"3"=>"7"
172	61-1338		75.10	61	"3"=>"6"
173	61-1339		74.94	61	"3"=>"5"
174	61-1340		70.61	61	"3"=>"4"
175	62-1337		158.45	62	"3"=>"7"
176	62-1338		131.53	62	"3"=>"6"
177	62-1339		126.11	62	"3"=>"5"
178	62-1340		110.86	62	"3"=>"4"
179	63-1337		172.92	63	"3"=>"7"
180	63-1338		159.82	63	"3"=>"6"
181	63-1339		95.02	63	"3"=>"5"
182	63-1340		81.09	63	"3"=>"4"
183	64-1337		114.37	64	"3"=>"7"
184	64-1338		73.02	64	"3"=>"6"
185	64-1339		32.97	64	"3"=>"5"
186	64-1340		30.56	64	"3"=>"4"
187	65-1337		123.55	65	"3"=>"7"
188	65-1338		92.02	65	"3"=>"6"
189	65-1339		73.18	65	"3"=>"5"
190	65-1340		32.62	65	"3"=>"4"
191	66-1337		119.38	66	"3"=>"7"
192	66-1338		99.91	66	"3"=>"6"
193	66-1339		82.96	66	"3"=>"5"
194	66-1340		43.28	66	"3"=>"4"
195	67-1337		183.97	67	"3"=>"7"
196	67-1338		179.56	67	"3"=>"6"
197	67-1339		143.61	67	"3"=>"5"
198	67-1340		101.67	67	"3"=>"4"
199	68-1337		128.18	68	"3"=>"7"
200	68-1338		88.21	68	"3"=>"6"
201	68-1339		87.37	68	"3"=>"5"
202	68-1340		66.90	68	"3"=>"4"
203	69-1337		101.85	69	"3"=>"7"
204	69-1338		73.90	69	"3"=>"6"
205	69-1339		58.85	69	"3"=>"5"
206	69-1340		48.80	69	"3"=>"4"
207	70-1337		147.51	70	"3"=>"7"
208	70-1338		116.17	70	"3"=>"6"
209	70-1339		102.77	70	"3"=>"5"
210	70-1340		99.52	70	"3"=>"4"
211	71-1337		\N	71	
212	72-1337		\N	72	
213	73-1337		\N	73	
214	74-1337		\N	74	
215	75-1337		\N	75	
216	76-1337		\N	76	
217	77-1337		\N	77	
218	78-1337		\N	78	
219	79-1337		\N	79	
220	80-1337		\N	80	
221	81-1337		100.55	81	"5"=>"12"
222	81-1338		99.61	81	"5"=>"11"
223	81-1339		83.82	81	"5"=>"10"
224	82-1337		102.11	82	"5"=>"12"
225	82-1338		47.85	82	"5"=>"11"
226	82-1339		27.51	82	"5"=>"10"
227	83-1337		93.80	83	"5"=>"12"
228	83-1338		84.50	83	"5"=>"11"
229	83-1339		77.31	83	"5"=>"10"
230	84-1337		111.92	84	"5"=>"12"
231	84-1338		111.85	84	"5"=>"11"
232	84-1339		56.21	84	"5"=>"10"
233	85-1337		87.06	85	"5"=>"12"
234	85-1338		74.28	85	"5"=>"11"
235	85-1339		63.39	85	"5"=>"10"
236	86-1337		127.29	86	"5"=>"12"
237	86-1338		88.59	86	"5"=>"11"
238	86-1339		79.53	86	"5"=>"10"
239	87-1337		147.01	87	"5"=>"12"
240	87-1338		84.31	87	"5"=>"11"
241	87-1339		74.24	87	"5"=>"10"
242	88-1337		117.26	88	"5"=>"12"
243	88-1338		59.90	88	"5"=>"11"
244	88-1339		45.62	88	"5"=>"10"
245	89-1337		53.83	89	"5"=>"12"
246	89-1338		43.54	89	"5"=>"11"
247	89-1339		3.18	89	"5"=>"10"
248	90-1337		149.03	90	"5"=>"12"
249	90-1338		109.59	90	"5"=>"11"
250	90-1339		105.50	90	"5"=>"10"
251	91-1337		\N	91	"8"=>"23"
252	91-1338		\N	91	"8"=>"22"
253	91-1339		\N	91	"8"=>"21"
254	91-1340		\N	91	"8"=>"20"
255	91-1341		\N	91	"8"=>"19"
256	91-1342		\N	91	"8"=>"18"
257	92-1337		\N	92	"8"=>"23"
258	92-1338		\N	92	"8"=>"22"
259	92-1339		\N	92	"8"=>"21"
260	92-1340		\N	92	"8"=>"20"
261	92-1341		\N	92	"8"=>"19"
262	92-1342		\N	92	"8"=>"18"
263	93-1337		\N	93	"8"=>"23"
264	93-1338		\N	93	"8"=>"22"
265	93-1339		\N	93	"8"=>"21"
266	93-1340		\N	93	"8"=>"20"
267	93-1341		\N	93	"8"=>"19"
268	93-1342		\N	93	"8"=>"18"
269	94-1337		\N	94	"8"=>"23"
270	94-1338		\N	94	"8"=>"22"
271	94-1339		\N	94	"8"=>"21"
272	94-1340		\N	94	"8"=>"20"
273	94-1341		\N	94	"8"=>"19"
274	94-1342		\N	94	"8"=>"18"
275	95-1337		\N	95	"8"=>"23"
276	95-1338		\N	95	"8"=>"22"
277	95-1339		\N	95	"8"=>"21"
278	95-1340		\N	95	"8"=>"20"
279	95-1341		\N	95	"8"=>"19"
280	95-1342		\N	95	"8"=>"18"
281	96-1337		\N	96	"8"=>"23"
282	96-1338		\N	96	"8"=>"22"
283	96-1339		\N	96	"8"=>"21"
284	96-1340		\N	96	"8"=>"20"
285	96-1341		\N	96	"8"=>"19"
286	96-1342		\N	96	"8"=>"18"
287	97-1337		\N	97	"8"=>"23"
288	97-1338		\N	97	"8"=>"22"
289	97-1339		\N	97	"8"=>"21"
290	97-1340		\N	97	"8"=>"20"
291	97-1341		\N	97	"8"=>"19"
292	97-1342		\N	97	"8"=>"18"
293	98-1337		\N	98	"8"=>"23"
294	98-1338		\N	98	"8"=>"22"
295	98-1339		\N	98	"8"=>"21"
296	98-1340		\N	98	"8"=>"20"
297	98-1341		\N	98	"8"=>"19"
298	98-1342		\N	98	"8"=>"18"
299	99-1337		\N	99	"8"=>"23"
300	99-1338		\N	99	"8"=>"22"
301	99-1339		\N	99	"8"=>"21"
302	99-1340		\N	99	"8"=>"20"
303	99-1341		\N	99	"8"=>"19"
304	99-1342		\N	99	"8"=>"18"
305	100-1337		\N	100	"8"=>"23"
306	100-1338		\N	100	"8"=>"22"
307	100-1339		\N	100	"8"=>"21"
308	100-1340		\N	100	"8"=>"20"
309	100-1341		\N	100	"8"=>"19"
310	100-1342		\N	100	"8"=>"18"
311	101-1337		126.04	101	"12"=>"31"
312	101-1338		110.28	101	"12"=>"30"
313	102-1337		107.64	102	"12"=>"31"
314	102-1338		43.87	102	"12"=>"30"
315	103-1337		142.06	103	"12"=>"31"
316	103-1338		111.36	103	"12"=>"30"
317	104-1337		134.45	104	"12"=>"31"
318	104-1338		104.05	104	"12"=>"30"
319	105-1337		133.22	105	"12"=>"31"
320	105-1338		84.00	105	"12"=>"30"
321	106-1337		77.93	106	"12"=>"31"
322	106-1338		63.55	106	"12"=>"30"
323	107-1337		147.04	107	"12"=>"31"
324	107-1338		123.88	107	"12"=>"30"
325	108-1337		163.87	108	"12"=>"31"
326	108-1338		75.13	108	"12"=>"30"
327	109-1337		65.99	109	"12"=>"31"
328	109-1338		7.40	109	"12"=>"30"
329	110-1337		176.28	110	"12"=>"31"
330	110-1338		105.25	110	"12"=>"30"
331	111-1337		\N	111	
332	112-1337		\N	112	
333	113-1337		\N	113	
334	114-1337		\N	114	
335	115-1337		\N	115	
336	116-1337		\N	116	
337	117-1337		\N	117	
338	118-1337		\N	118	
339	119-1337		\N	119	
340	120-1337		\N	120	
341	121-1337		160.77	121	"3"=>"7"
342	121-1338		157.33	121	"3"=>"6"
343	121-1339		152.42	121	"3"=>"5"
344	121-1340		105.55	121	"3"=>"4"
345	122-1337		100.23	122	"3"=>"7"
346	122-1338		60.61	122	"3"=>"6"
347	122-1339		57.92	122	"3"=>"5"
348	122-1340		54.52	122	"3"=>"4"
349	123-1337		166.63	123	"3"=>"7"
350	123-1338		162.90	123	"3"=>"6"
351	123-1339		153.62	123	"3"=>"5"
352	123-1340		135.48	123	"3"=>"4"
353	124-1337		108.94	124	"3"=>"7"
354	124-1338		95.43	124	"3"=>"6"
355	124-1339		63.95	124	"3"=>"5"
356	124-1340		56.70	124	"3"=>"4"
357	125-1337		170.99	125	"3"=>"7"
358	125-1338		170.13	125	"3"=>"6"
359	125-1339		141.08	125	"3"=>"5"
360	125-1340		103.75	125	"3"=>"4"
361	126-1337		120.50	126	"3"=>"7"
362	126-1338		116.32	126	"3"=>"6"
363	126-1339		51.18	126	"3"=>"5"
364	126-1340		34.20	126	"3"=>"4"
365	127-1337		138.16	127	"3"=>"7"
366	127-1338		115.01	127	"3"=>"6"
367	127-1339		79.13	127	"3"=>"5"
368	127-1340		66.58	127	"3"=>"4"
369	128-1337		172.42	128	"3"=>"7"
370	128-1338		158.15	128	"3"=>"6"
371	128-1339		141.79	128	"3"=>"5"
372	128-1340		101.13	128	"3"=>"4"
373	129-1337		189.75	129	"3"=>"7"
374	129-1338		189.52	129	"3"=>"6"
375	129-1339		147.74	129	"3"=>"5"
376	129-1340		108.31	129	"3"=>"4"
377	130-1337		136.63	130	"3"=>"7"
378	130-1338		134.15	130	"3"=>"6"
379	130-1339		72.89	130	"3"=>"5"
380	130-1340		46.85	130	"3"=>"4"
381	131-1337		\N	131	
382	132-1337		\N	132	
383	133-1337		\N	133	
384	134-1337		\N	134	
385	135-1337		\N	135	
386	136-1337		\N	136	
387	137-1337		\N	137	
388	138-1337		\N	138	
389	139-1337		\N	139	
390	140-1337		\N	140	
391	141-1337		114.98	141	"5"=>"12"
392	141-1338		86.26	141	"5"=>"11"
393	141-1339		82.22	141	"5"=>"10"
394	142-1337		101.21	142	"5"=>"12"
395	142-1338		84.49	142	"5"=>"11"
396	142-1339		31.08	142	"5"=>"10"
397	143-1337		111.88	143	"5"=>"12"
398	143-1338		48.54	143	"5"=>"11"
399	143-1339		39.60	143	"5"=>"10"
400	144-1337		69.39	144	"5"=>"12"
401	144-1338		55.82	144	"5"=>"11"
402	144-1339		32.01	144	"5"=>"10"
403	145-1337		177.07	145	"5"=>"12"
404	145-1338		154.00	145	"5"=>"11"
405	145-1339		107.21	145	"5"=>"10"
406	146-1337		142.43	146	"5"=>"12"
407	146-1338		139.78	146	"5"=>"11"
408	146-1339		108.35	146	"5"=>"10"
409	147-1337		149.73	147	"5"=>"12"
410	147-1338		136.42	147	"5"=>"11"
411	147-1339		117.82	147	"5"=>"10"
412	148-1337		79.13	148	"5"=>"12"
413	148-1338		52.61	148	"5"=>"11"
414	148-1339		16.57	148	"5"=>"10"
415	149-1337		78.67	149	"5"=>"12"
416	149-1338		57.49	149	"5"=>"11"
417	149-1339		54.51	149	"5"=>"10"
418	150-1337		142.14	150	"5"=>"12"
419	150-1338		128.60	150	"5"=>"11"
420	150-1339		76.37	150	"5"=>"10"
421	151-1337		\N	151	"8"=>"23"
422	151-1338		\N	151	"8"=>"22"
423	151-1339		\N	151	"8"=>"21"
424	151-1340		\N	151	"8"=>"20"
425	151-1341		\N	151	"8"=>"19"
426	151-1342		\N	151	"8"=>"18"
427	152-1337		\N	152	"8"=>"23"
428	152-1338		\N	152	"8"=>"22"
429	152-1339		\N	152	"8"=>"21"
430	152-1340		\N	152	"8"=>"20"
431	152-1341		\N	152	"8"=>"19"
432	152-1342		\N	152	"8"=>"18"
433	153-1337		\N	153	"8"=>"23"
434	153-1338		\N	153	"8"=>"22"
435	153-1339		\N	153	"8"=>"21"
436	153-1340		\N	153	"8"=>"20"
437	153-1341		\N	153	"8"=>"19"
438	153-1342		\N	153	"8"=>"18"
439	154-1337		\N	154	"8"=>"23"
440	154-1338		\N	154	"8"=>"22"
441	154-1339		\N	154	"8"=>"21"
442	154-1340		\N	154	"8"=>"20"
443	154-1341		\N	154	"8"=>"19"
444	154-1342		\N	154	"8"=>"18"
445	155-1337		\N	155	"8"=>"23"
446	155-1338		\N	155	"8"=>"22"
447	155-1339		\N	155	"8"=>"21"
448	155-1340		\N	155	"8"=>"20"
449	155-1341		\N	155	"8"=>"19"
450	155-1342		\N	155	"8"=>"18"
451	156-1337		\N	156	"8"=>"23"
452	156-1338		\N	156	"8"=>"22"
453	156-1339		\N	156	"8"=>"21"
454	156-1340		\N	156	"8"=>"20"
455	156-1341		\N	156	"8"=>"19"
456	156-1342		\N	156	"8"=>"18"
457	157-1337		\N	157	"8"=>"23"
458	157-1338		\N	157	"8"=>"22"
459	157-1339		\N	157	"8"=>"21"
460	157-1340		\N	157	"8"=>"20"
461	157-1341		\N	157	"8"=>"19"
462	157-1342		\N	157	"8"=>"18"
463	158-1337		\N	158	"8"=>"23"
464	158-1338		\N	158	"8"=>"22"
465	158-1339		\N	158	"8"=>"21"
466	158-1340		\N	158	"8"=>"20"
467	158-1341		\N	158	"8"=>"19"
468	158-1342		\N	158	"8"=>"18"
469	159-1337		\N	159	"8"=>"23"
470	159-1338		\N	159	"8"=>"22"
471	159-1339		\N	159	"8"=>"21"
472	159-1340		\N	159	"8"=>"20"
473	159-1341		\N	159	"8"=>"19"
474	159-1342		\N	159	"8"=>"18"
475	160-1337		\N	160	"8"=>"23"
476	160-1338		\N	160	"8"=>"22"
477	160-1339		\N	160	"8"=>"21"
478	160-1340		\N	160	"8"=>"20"
479	160-1341		\N	160	"8"=>"19"
480	160-1342		\N	160	"8"=>"18"
481	161-1337		109.23	161	"12"=>"31"
482	161-1338		101.28	161	"12"=>"30"
483	162-1337		75.94	162	"12"=>"31"
484	162-1338		49.28	162	"12"=>"30"
485	163-1337		170.59	163	"12"=>"31"
486	163-1338		131.48	163	"12"=>"30"
487	164-1337		138.05	164	"12"=>"31"
488	164-1338		107.71	164	"12"=>"30"
489	165-1337		109.57	165	"12"=>"31"
490	165-1338		88.05	165	"12"=>"30"
491	166-1337		192.87	166	"12"=>"31"
492	166-1338		145.88	166	"12"=>"30"
493	167-1337		84.10	167	"12"=>"31"
494	167-1338		78.44	167	"12"=>"30"
495	168-1337		108.81	168	"12"=>"31"
496	168-1338		103.56	168	"12"=>"30"
497	169-1337		90.97	169	"12"=>"31"
498	169-1338		45.72	169	"12"=>"30"
499	170-1337		161.92	170	"12"=>"31"
500	170-1338		116.34	170	"12"=>"30"
501	171-1337		\N	171	
502	172-1337		\N	172	
503	173-1337		\N	173	
504	174-1337		\N	174	
505	175-1337		\N	175	
506	176-1337		\N	176	
507	177-1337		\N	177	
508	178-1337		\N	178	
509	179-1337		\N	179	
510	180-1337		\N	180	
511	181-1337		169.34	181	"3"=>"7"
512	181-1338		86.13	181	"3"=>"6"
513	181-1339		82.14	181	"3"=>"5"
514	181-1340		74.36	181	"3"=>"4"
515	182-1337		82.72	182	"3"=>"7"
516	182-1338		57.86	182	"3"=>"6"
517	182-1339		48.61	182	"3"=>"5"
518	182-1340		23.33	182	"3"=>"4"
519	183-1337		109.79	183	"3"=>"7"
520	183-1338		82.64	183	"3"=>"6"
521	183-1339		73.09	183	"3"=>"5"
522	183-1340		72.93	183	"3"=>"4"
523	184-1337		137.64	184	"3"=>"7"
524	184-1338		86.76	184	"3"=>"6"
525	184-1339		67.82	184	"3"=>"5"
526	184-1340		64.29	184	"3"=>"4"
527	185-1337		119.64	185	"3"=>"7"
528	185-1338		104.20	185	"3"=>"6"
529	185-1339		102.69	185	"3"=>"5"
530	185-1340		59.67	185	"3"=>"4"
531	186-1337		159.78	186	"3"=>"7"
532	186-1338		147.57	186	"3"=>"6"
533	186-1339		110.47	186	"3"=>"5"
534	186-1340		92.70	186	"3"=>"4"
535	187-1337		125.56	187	"3"=>"7"
536	187-1338		122.77	187	"3"=>"6"
537	187-1339		85.54	187	"3"=>"5"
538	187-1340		49.58	187	"3"=>"4"
539	188-1337		112.63	188	"3"=>"7"
540	188-1338		74.65	188	"3"=>"6"
541	188-1339		70.72	188	"3"=>"5"
542	188-1340		35.41	188	"3"=>"4"
543	189-1337		126.53	189	"3"=>"7"
544	189-1338		116.42	189	"3"=>"6"
545	189-1339		114.40	189	"3"=>"5"
546	189-1340		103.37	189	"3"=>"4"
547	190-1337		114.35	190	"3"=>"7"
548	190-1338		112.59	190	"3"=>"6"
549	190-1339		110.14	190	"3"=>"5"
550	190-1340		81.23	190	"3"=>"4"
551	191-1337		\N	191	
552	192-1337		\N	192	
553	193-1337		\N	193	
554	194-1337		\N	194	
555	195-1337		\N	195	
556	196-1337		\N	196	
557	197-1337		\N	197	
558	198-1337		\N	198	
559	199-1337		\N	199	
560	200-1337		\N	200	
561	201-1337		109.25	201	"5"=>"12"
562	201-1338		101.08	201	"5"=>"11"
563	201-1339		47.15	201	"5"=>"10"
564	202-1337		143.50	202	"5"=>"12"
565	202-1338		127.04	202	"5"=>"11"
566	202-1339		92.19	202	"5"=>"10"
567	203-1337		141.50	203	"5"=>"12"
568	203-1338		130.24	203	"5"=>"11"
569	203-1339		103.58	203	"5"=>"10"
570	204-1337		39.39	204	"5"=>"12"
571	204-1338		25.12	204	"5"=>"11"
572	204-1339		22.91	204	"5"=>"10"
573	205-1337		98.59	205	"5"=>"12"
574	205-1338		89.31	205	"5"=>"11"
575	205-1339		25.23	205	"5"=>"10"
576	206-1337		81.31	206	"5"=>"12"
577	206-1338		40.59	206	"5"=>"11"
578	206-1339		39.38	206	"5"=>"10"
579	207-1337		151.12	207	"5"=>"12"
580	207-1338		114.47	207	"5"=>"11"
581	207-1339		113.65	207	"5"=>"10"
582	208-1337		142.62	208	"5"=>"12"
583	208-1338		129.88	208	"5"=>"11"
584	208-1339		123.80	208	"5"=>"10"
585	209-1337		176.38	209	"5"=>"12"
586	209-1338		110.10	209	"5"=>"11"
587	209-1339		101.98	209	"5"=>"10"
588	210-1337		103.96	210	"5"=>"12"
589	210-1338		90.14	210	"5"=>"11"
590	210-1339		74.70	210	"5"=>"10"
591	211-1337		\N	211	"8"=>"23"
592	211-1338		\N	211	"8"=>"22"
593	211-1339		\N	211	"8"=>"21"
594	211-1340		\N	211	"8"=>"20"
595	211-1341		\N	211	"8"=>"19"
596	211-1342		\N	211	"8"=>"18"
597	212-1337		\N	212	"8"=>"23"
598	212-1338		\N	212	"8"=>"22"
599	212-1339		\N	212	"8"=>"21"
600	212-1340		\N	212	"8"=>"20"
601	212-1341		\N	212	"8"=>"19"
602	212-1342		\N	212	"8"=>"18"
603	213-1337		\N	213	"8"=>"23"
604	213-1338		\N	213	"8"=>"22"
605	213-1339		\N	213	"8"=>"21"
606	213-1340		\N	213	"8"=>"20"
607	213-1341		\N	213	"8"=>"19"
608	213-1342		\N	213	"8"=>"18"
609	214-1337		\N	214	"8"=>"23"
610	214-1338		\N	214	"8"=>"22"
611	214-1339		\N	214	"8"=>"21"
612	214-1340		\N	214	"8"=>"20"
613	214-1341		\N	214	"8"=>"19"
614	214-1342		\N	214	"8"=>"18"
615	215-1337		\N	215	"8"=>"23"
616	215-1338		\N	215	"8"=>"22"
617	215-1339		\N	215	"8"=>"21"
618	215-1340		\N	215	"8"=>"20"
619	215-1341		\N	215	"8"=>"19"
620	215-1342		\N	215	"8"=>"18"
621	216-1337		\N	216	"8"=>"23"
622	216-1338		\N	216	"8"=>"22"
623	216-1339		\N	216	"8"=>"21"
624	216-1340		\N	216	"8"=>"20"
625	216-1341		\N	216	"8"=>"19"
626	216-1342		\N	216	"8"=>"18"
627	217-1337		\N	217	"8"=>"23"
628	217-1338		\N	217	"8"=>"22"
629	217-1339		\N	217	"8"=>"21"
630	217-1340		\N	217	"8"=>"20"
631	217-1341		\N	217	"8"=>"19"
632	217-1342		\N	217	"8"=>"18"
633	218-1337		\N	218	"8"=>"23"
634	218-1338		\N	218	"8"=>"22"
635	218-1339		\N	218	"8"=>"21"
636	218-1340		\N	218	"8"=>"20"
637	218-1341		\N	218	"8"=>"19"
638	218-1342		\N	218	"8"=>"18"
639	219-1337		\N	219	"8"=>"23"
640	219-1338		\N	219	"8"=>"22"
641	219-1339		\N	219	"8"=>"21"
642	219-1340		\N	219	"8"=>"20"
643	219-1341		\N	219	"8"=>"19"
644	219-1342		\N	219	"8"=>"18"
645	220-1337		\N	220	"8"=>"23"
646	220-1338		\N	220	"8"=>"22"
647	220-1339		\N	220	"8"=>"21"
648	220-1340		\N	220	"8"=>"20"
649	220-1341		\N	220	"8"=>"19"
650	220-1342		\N	220	"8"=>"18"
651	221-1337		46.16	221	"12"=>"31"
652	221-1338		35.51	221	"12"=>"30"
653	222-1337		127.57	222	"12"=>"31"
654	222-1338		115.95	222	"12"=>"30"
655	223-1337		109.47	223	"12"=>"31"
656	223-1338		98.03	223	"12"=>"30"
657	224-1337		106.26	224	"12"=>"31"
658	224-1338		75.49	224	"12"=>"30"
659	225-1337		98.15	225	"12"=>"31"
660	225-1338		77.24	225	"12"=>"30"
661	226-1337		123.30	226	"12"=>"31"
662	226-1338		95.60	226	"12"=>"30"
663	227-1337		131.06	227	"12"=>"31"
664	227-1338		88.58	227	"12"=>"30"
665	228-1337		174.70	228	"12"=>"31"
666	228-1338		83.88	228	"12"=>"30"
667	229-1337		85.48	229	"12"=>"31"
668	229-1338		40.35	229	"12"=>"30"
669	230-1337		124.21	230	"12"=>"31"
670	230-1338		89.72	230	"12"=>"30"
671	231-1337		\N	231	
672	232-1337		\N	232	
673	233-1337		\N	233	
674	234-1337		\N	234	
675	235-1337		\N	235	
676	236-1337		\N	236	
677	237-1337		\N	237	
678	238-1337		\N	238	
679	239-1337		\N	239	
680	240-1337		\N	240	
681	241-1337		154.48	241	"3"=>"7"
682	241-1338		137.30	241	"3"=>"6"
683	241-1339		135.15	241	"3"=>"5"
684	241-1340		102.47	241	"3"=>"4"
685	242-1337		98.23	242	"3"=>"7"
686	242-1338		65.07	242	"3"=>"6"
687	242-1339		58.60	242	"3"=>"5"
688	242-1340		50.77	242	"3"=>"4"
689	243-1337		170.89	243	"3"=>"7"
690	243-1338		150.82	243	"3"=>"6"
691	243-1339		125.89	243	"3"=>"5"
692	243-1340		125.52	243	"3"=>"4"
693	244-1337		131.96	244	"3"=>"7"
694	244-1338		120.70	244	"3"=>"6"
695	244-1339		119.16	244	"3"=>"5"
696	244-1340		59.82	244	"3"=>"4"
697	245-1337		90.90	245	"3"=>"7"
698	245-1338		78.92	245	"3"=>"6"
699	245-1339		76.39	245	"3"=>"5"
700	245-1340		64.96	245	"3"=>"4"
701	246-1337		86.07	246	"3"=>"7"
702	246-1338		54.82	246	"3"=>"6"
703	246-1339		15.62	246	"3"=>"5"
704	246-1340		15.50	246	"3"=>"4"
705	247-1337		114.31	247	"3"=>"7"
706	247-1338		55.84	247	"3"=>"6"
707	247-1339		43.33	247	"3"=>"5"
708	247-1340		32.67	247	"3"=>"4"
709	248-1337		89.99	248	"3"=>"7"
710	248-1338		89.56	248	"3"=>"6"
711	248-1339		7.63	248	"3"=>"5"
712	248-1340		6.76	248	"3"=>"4"
713	249-1337		114.47	249	"3"=>"7"
714	249-1338		113.42	249	"3"=>"6"
715	249-1339		104.86	249	"3"=>"5"
716	249-1340		104.24	249	"3"=>"4"
717	250-1337		153.75	250	"3"=>"7"
718	250-1338		142.09	250	"3"=>"6"
719	250-1339		95.16	250	"3"=>"5"
720	250-1340		81.39	250	"3"=>"4"
721	251-1337		\N	251	
722	252-1337		\N	252	
723	253-1337		\N	253	
724	254-1337		\N	254	
725	255-1337		\N	255	
726	256-1337		\N	256	
727	257-1337		\N	257	
728	258-1337		\N	258	
729	259-1337		\N	259	
730	260-1337		\N	260	
731	261-1337		177.47	261	"5"=>"12"
732	261-1338		175.38	261	"5"=>"11"
733	261-1339		159.71	261	"5"=>"10"
734	262-1337		170.80	262	"5"=>"12"
735	262-1338		170.07	262	"5"=>"11"
736	262-1339		168.46	262	"5"=>"10"
737	263-1337		111.96	263	"5"=>"12"
738	263-1338		101.60	263	"5"=>"11"
739	263-1339		93.50	263	"5"=>"10"
740	264-1337		154.71	264	"5"=>"12"
741	264-1338		120.98	264	"5"=>"11"
742	264-1339		67.12	264	"5"=>"10"
743	265-1337		179.95	265	"5"=>"12"
744	265-1338		165.44	265	"5"=>"11"
745	265-1339		158.57	265	"5"=>"10"
746	266-1337		120.14	266	"5"=>"12"
747	266-1338		82.27	266	"5"=>"11"
748	266-1339		77.35	266	"5"=>"10"
749	267-1337		106.79	267	"5"=>"12"
750	267-1338		95.56	267	"5"=>"11"
751	267-1339		88.86	267	"5"=>"10"
752	268-1337		127.16	268	"5"=>"12"
753	268-1338		117.35	268	"5"=>"11"
754	268-1339		54.10	268	"5"=>"10"
755	269-1337		77.15	269	"5"=>"12"
756	269-1338		68.25	269	"5"=>"11"
757	269-1339		55.76	269	"5"=>"10"
758	270-1337		127.94	270	"5"=>"12"
759	270-1338		105.90	270	"5"=>"11"
760	270-1339		104.09	270	"5"=>"10"
761	271-1337		\N	271	"8"=>"23"
762	271-1338		\N	271	"8"=>"22"
763	271-1339		\N	271	"8"=>"21"
764	271-1340		\N	271	"8"=>"20"
765	271-1341		\N	271	"8"=>"19"
766	271-1342		\N	271	"8"=>"18"
767	272-1337		\N	272	"8"=>"23"
768	272-1338		\N	272	"8"=>"22"
769	272-1339		\N	272	"8"=>"21"
770	272-1340		\N	272	"8"=>"20"
771	272-1341		\N	272	"8"=>"19"
772	272-1342		\N	272	"8"=>"18"
773	273-1337		\N	273	"8"=>"23"
774	273-1338		\N	273	"8"=>"22"
775	273-1339		\N	273	"8"=>"21"
776	273-1340		\N	273	"8"=>"20"
777	273-1341		\N	273	"8"=>"19"
778	273-1342		\N	273	"8"=>"18"
779	274-1337		\N	274	"8"=>"23"
780	274-1338		\N	274	"8"=>"22"
781	274-1339		\N	274	"8"=>"21"
782	274-1340		\N	274	"8"=>"20"
783	274-1341		\N	274	"8"=>"19"
784	274-1342		\N	274	"8"=>"18"
785	275-1337		\N	275	"8"=>"23"
786	275-1338		\N	275	"8"=>"22"
787	275-1339		\N	275	"8"=>"21"
788	275-1340		\N	275	"8"=>"20"
789	275-1341		\N	275	"8"=>"19"
790	275-1342		\N	275	"8"=>"18"
791	276-1337		\N	276	"8"=>"23"
792	276-1338		\N	276	"8"=>"22"
793	276-1339		\N	276	"8"=>"21"
794	276-1340		\N	276	"8"=>"20"
795	276-1341		\N	276	"8"=>"19"
796	276-1342		\N	276	"8"=>"18"
797	277-1337		\N	277	"8"=>"23"
798	277-1338		\N	277	"8"=>"22"
799	277-1339		\N	277	"8"=>"21"
800	277-1340		\N	277	"8"=>"20"
801	277-1341		\N	277	"8"=>"19"
802	277-1342		\N	277	"8"=>"18"
803	278-1337		\N	278	"8"=>"23"
804	278-1338		\N	278	"8"=>"22"
805	278-1339		\N	278	"8"=>"21"
806	278-1340		\N	278	"8"=>"20"
807	278-1341		\N	278	"8"=>"19"
808	278-1342		\N	278	"8"=>"18"
809	279-1337		\N	279	"8"=>"23"
810	279-1338		\N	279	"8"=>"22"
811	279-1339		\N	279	"8"=>"21"
812	279-1340		\N	279	"8"=>"20"
813	279-1341		\N	279	"8"=>"19"
814	279-1342		\N	279	"8"=>"18"
815	280-1337		\N	280	"8"=>"23"
816	280-1338		\N	280	"8"=>"22"
817	280-1339		\N	280	"8"=>"21"
818	280-1340		\N	280	"8"=>"20"
819	280-1341		\N	280	"8"=>"19"
820	280-1342		\N	280	"8"=>"18"
821	281-1337		175.38	281	"12"=>"31"
822	281-1338		101.54	281	"12"=>"30"
823	282-1337		90.31	282	"12"=>"31"
824	282-1338		18.79	282	"12"=>"30"
825	283-1337		95.63	283	"12"=>"31"
826	283-1338		72.55	283	"12"=>"30"
827	284-1337		160.91	284	"12"=>"31"
828	284-1338		131.68	284	"12"=>"30"
829	285-1337		118.42	285	"12"=>"31"
830	285-1338		113.88	285	"12"=>"30"
831	286-1337		101.32	286	"12"=>"31"
832	286-1338		80.25	286	"12"=>"30"
833	287-1337		156.36	287	"12"=>"31"
834	287-1338		108.96	287	"12"=>"30"
835	288-1337		127.09	288	"12"=>"31"
836	288-1338		81.67	288	"12"=>"30"
837	289-1337		99.24	289	"12"=>"31"
838	289-1338		27.75	289	"12"=>"30"
839	290-1337		127.30	290	"12"=>"31"
840	290-1338		96.27	290	"12"=>"30"
841	291-1337		\N	291	
842	292-1337		\N	292	
843	293-1337		\N	293	
844	294-1337		\N	294	
845	295-1337		\N	295	
846	296-1337		\N	296	
847	297-1337		\N	297	
848	298-1337		\N	298	
849	299-1337		\N	299	
850	300-1337		\N	300	
851	301-1337		155.59	301	"3"=>"7"
852	301-1338		146.63	301	"3"=>"6"
853	301-1339		142.24	301	"3"=>"5"
854	301-1340		115.46	301	"3"=>"4"
855	302-1337		69.24	302	"3"=>"7"
856	302-1338		61.26	302	"3"=>"6"
857	302-1339		55.37	302	"3"=>"5"
858	302-1340		47.00	302	"3"=>"4"
859	303-1337		105.48	303	"3"=>"7"
860	303-1338		83.46	303	"3"=>"6"
861	303-1339		71.90	303	"3"=>"5"
862	303-1340		64.40	303	"3"=>"4"
863	304-1337		149.68	304	"3"=>"7"
864	304-1338		124.96	304	"3"=>"6"
865	304-1339		109.35	304	"3"=>"5"
866	304-1340		106.53	304	"3"=>"4"
867	305-1337		144.77	305	"3"=>"7"
868	305-1338		143.77	305	"3"=>"6"
869	305-1339		127.78	305	"3"=>"5"
870	305-1340		121.39	305	"3"=>"4"
871	306-1337		181.72	306	"3"=>"7"
872	306-1338		145.99	306	"3"=>"6"
873	306-1339		98.29	306	"3"=>"5"
874	306-1340		86.76	306	"3"=>"4"
875	307-1337		131.78	307	"3"=>"7"
876	307-1338		80.66	307	"3"=>"6"
877	307-1339		65.09	307	"3"=>"5"
878	307-1340		60.77	307	"3"=>"4"
879	308-1337		127.00	308	"3"=>"7"
880	308-1338		118.17	308	"3"=>"6"
881	308-1339		113.84	308	"3"=>"5"
882	308-1340		90.40	308	"3"=>"4"
883	309-1337		158.26	309	"3"=>"7"
884	309-1338		151.27	309	"3"=>"6"
885	309-1339		146.03	309	"3"=>"5"
886	309-1340		128.21	309	"3"=>"4"
887	310-1337		99.47	310	"3"=>"7"
888	310-1338		71.44	310	"3"=>"6"
889	310-1339		60.71	310	"3"=>"5"
890	310-1340		55.36	310	"3"=>"4"
891	311-1337		\N	311	
892	312-1337		\N	312	
893	313-1337		\N	313	
894	314-1337		\N	314	
895	315-1337		\N	315	
896	316-1337		\N	316	
897	317-1337		\N	317	
898	318-1337		\N	318	
899	319-1337		\N	319	
900	320-1337		\N	320	
901	321-1337		192.23	321	"5"=>"12"
902	321-1338		160.63	321	"5"=>"11"
903	321-1339		150.49	321	"5"=>"10"
904	322-1337		100.29	322	"5"=>"12"
905	322-1338		45.36	322	"5"=>"11"
906	322-1339		17.29	322	"5"=>"10"
907	323-1337		135.00	323	"5"=>"12"
908	323-1338		100.77	323	"5"=>"11"
909	323-1339		91.28	323	"5"=>"10"
910	324-1337		142.00	324	"5"=>"12"
911	324-1338		105.82	324	"5"=>"11"
912	324-1339		76.73	324	"5"=>"10"
913	325-1337		89.83	325	"5"=>"12"
914	325-1338		78.26	325	"5"=>"11"
915	325-1339		46.07	325	"5"=>"10"
916	326-1337		100.82	326	"5"=>"12"
917	326-1338		89.50	326	"5"=>"11"
918	326-1339		51.99	326	"5"=>"10"
919	327-1337		59.25	327	"5"=>"12"
920	327-1338		30.25	327	"5"=>"11"
921	327-1339		23.06	327	"5"=>"10"
922	328-1337		136.82	328	"5"=>"12"
923	328-1338		129.38	328	"5"=>"11"
924	328-1339		122.21	328	"5"=>"10"
925	329-1337		165.08	329	"5"=>"12"
926	329-1338		151.08	329	"5"=>"11"
927	329-1339		144.33	329	"5"=>"10"
928	330-1337		124.56	330	"5"=>"12"
929	330-1338		122.56	330	"5"=>"11"
930	330-1339		88.00	330	"5"=>"10"
931	331-1337		\N	331	"8"=>"23"
932	331-1338		\N	331	"8"=>"22"
933	331-1339		\N	331	"8"=>"21"
934	331-1340		\N	331	"8"=>"20"
935	331-1341		\N	331	"8"=>"19"
936	331-1342		\N	331	"8"=>"18"
937	332-1337		\N	332	"8"=>"23"
938	332-1338		\N	332	"8"=>"22"
939	332-1339		\N	332	"8"=>"21"
940	332-1340		\N	332	"8"=>"20"
941	332-1341		\N	332	"8"=>"19"
942	332-1342		\N	332	"8"=>"18"
943	333-1337		\N	333	"8"=>"23"
944	333-1338		\N	333	"8"=>"22"
945	333-1339		\N	333	"8"=>"21"
946	333-1340		\N	333	"8"=>"20"
947	333-1341		\N	333	"8"=>"19"
948	333-1342		\N	333	"8"=>"18"
949	334-1337		\N	334	"8"=>"23"
950	334-1338		\N	334	"8"=>"22"
951	334-1339		\N	334	"8"=>"21"
952	334-1340		\N	334	"8"=>"20"
953	334-1341		\N	334	"8"=>"19"
954	334-1342		\N	334	"8"=>"18"
955	335-1337		\N	335	"8"=>"23"
956	335-1338		\N	335	"8"=>"22"
957	335-1339		\N	335	"8"=>"21"
958	335-1340		\N	335	"8"=>"20"
959	335-1341		\N	335	"8"=>"19"
960	335-1342		\N	335	"8"=>"18"
961	336-1337		\N	336	"8"=>"23"
962	336-1338		\N	336	"8"=>"22"
963	336-1339		\N	336	"8"=>"21"
964	336-1340		\N	336	"8"=>"20"
965	336-1341		\N	336	"8"=>"19"
966	336-1342		\N	336	"8"=>"18"
967	337-1337		\N	337	"8"=>"23"
968	337-1338		\N	337	"8"=>"22"
969	337-1339		\N	337	"8"=>"21"
970	337-1340		\N	337	"8"=>"20"
971	337-1341		\N	337	"8"=>"19"
972	337-1342		\N	337	"8"=>"18"
973	338-1337		\N	338	"8"=>"23"
974	338-1338		\N	338	"8"=>"22"
975	338-1339		\N	338	"8"=>"21"
976	338-1340		\N	338	"8"=>"20"
977	338-1341		\N	338	"8"=>"19"
978	338-1342		\N	338	"8"=>"18"
979	339-1337		\N	339	"8"=>"23"
980	339-1338		\N	339	"8"=>"22"
981	339-1339		\N	339	"8"=>"21"
982	339-1340		\N	339	"8"=>"20"
983	339-1341		\N	339	"8"=>"19"
984	339-1342		\N	339	"8"=>"18"
985	340-1337		\N	340	"8"=>"23"
986	340-1338		\N	340	"8"=>"22"
987	340-1339		\N	340	"8"=>"21"
988	340-1340		\N	340	"8"=>"20"
989	340-1341		\N	340	"8"=>"19"
990	340-1342		\N	340	"8"=>"18"
991	341-1337		124.31	341	"12"=>"31"
992	341-1338		88.66	341	"12"=>"30"
993	342-1337		94.16	342	"12"=>"31"
994	342-1338		58.27	342	"12"=>"30"
995	343-1337		132.25	343	"12"=>"31"
996	343-1338		77.32	343	"12"=>"30"
997	344-1337		98.44	344	"12"=>"31"
998	344-1338		82.05	344	"12"=>"30"
999	345-1337		153.71	345	"12"=>"31"
1000	345-1338		77.96	345	"12"=>"30"
1001	346-1337		109.58	346	"12"=>"31"
1002	346-1338		34.81	346	"12"=>"30"
1003	347-1337		113.33	347	"12"=>"31"
1004	347-1338		68.41	347	"12"=>"30"
1005	348-1337		61.06	348	"12"=>"31"
1006	348-1338		46.02	348	"12"=>"30"
1007	349-1337		138.76	349	"12"=>"31"
1008	349-1338		105.93	349	"12"=>"30"
1009	350-1337		138.83	350	"12"=>"31"
1010	350-1338		71.51	350	"12"=>"30"
1011	351-1337		\N	351	
1012	352-1337		\N	352	
1013	353-1337		\N	353	
1014	354-1337		\N	354	
1015	355-1337		\N	355	
1016	356-1337		\N	356	
1017	357-1337		\N	357	
1018	358-1337		\N	358	
1019	359-1337		\N	359	
1020	360-1337		\N	360	
1021	361-1337		123.46	361	"3"=>"7"
1022	361-1338		114.60	361	"3"=>"6"
1023	361-1339		94.41	361	"3"=>"5"
1024	361-1340		92.36	361	"3"=>"4"
1025	362-1337		163.25	362	"3"=>"7"
1026	362-1338		145.68	362	"3"=>"6"
1027	362-1339		135.27	362	"3"=>"5"
1028	362-1340		86.43	362	"3"=>"4"
1029	363-1337		166.33	363	"3"=>"7"
1030	363-1338		139.44	363	"3"=>"6"
1031	363-1339		109.74	363	"3"=>"5"
1032	363-1340		89.67	363	"3"=>"4"
1033	364-1337		138.96	364	"3"=>"7"
1034	364-1338		125.68	364	"3"=>"6"
1035	364-1339		113.88	364	"3"=>"5"
1036	364-1340		112.92	364	"3"=>"4"
1037	365-1337		60.92	365	"3"=>"7"
1038	365-1338		49.43	365	"3"=>"6"
1039	365-1339		33.82	365	"3"=>"5"
1040	365-1340		30.14	365	"3"=>"4"
1041	366-1337		108.16	366	"3"=>"7"
1042	366-1338		105.20	366	"3"=>"6"
1043	366-1339		44.06	366	"3"=>"5"
1044	366-1340		35.47	366	"3"=>"4"
1045	367-1337		136.67	367	"3"=>"7"
1046	367-1338		134.68	367	"3"=>"6"
1047	367-1339		85.03	367	"3"=>"5"
1048	367-1340		61.02	367	"3"=>"4"
1049	368-1337		140.64	368	"3"=>"7"
1050	368-1338		101.34	368	"3"=>"6"
1051	368-1339		89.30	368	"3"=>"5"
1052	368-1340		75.59	368	"3"=>"4"
1053	369-1337		148.30	369	"3"=>"7"
1054	369-1338		121.79	369	"3"=>"6"
1055	369-1339		89.44	369	"3"=>"5"
1056	369-1340		81.25	369	"3"=>"4"
1057	370-1337		162.08	370	"3"=>"7"
1058	370-1338		107.38	370	"3"=>"6"
1059	370-1339		103.28	370	"3"=>"5"
1060	370-1340		91.51	370	"3"=>"4"
1061	371-1337		\N	371	
1062	372-1337		\N	372	
1063	373-1337		\N	373	
1064	374-1337		\N	374	
1065	375-1337		\N	375	
1066	376-1337		\N	376	
1067	377-1337		\N	377	
1068	378-1337		\N	378	
1069	379-1337		\N	379	
1070	380-1337		\N	380	
1071	381-1337		128.61	381	"5"=>"12"
1072	381-1338		64.39	381	"5"=>"11"
1073	381-1339		54.98	381	"5"=>"10"
1074	382-1337		135.96	382	"5"=>"12"
1075	382-1338		104.41	382	"5"=>"11"
1076	382-1339		56.42	382	"5"=>"10"
1077	383-1337		129.36	383	"5"=>"12"
1078	383-1338		113.03	383	"5"=>"11"
1079	383-1339		96.53	383	"5"=>"10"
1080	384-1337		172.75	384	"5"=>"12"
1081	384-1338		131.95	384	"5"=>"11"
1082	384-1339		104.75	384	"5"=>"10"
1083	385-1337		80.04	385	"5"=>"12"
1084	385-1338		47.78	385	"5"=>"11"
1085	385-1339		45.09	385	"5"=>"10"
1086	386-1337		131.41	386	"5"=>"12"
1087	386-1338		118.98	386	"5"=>"11"
1088	386-1339		61.50	386	"5"=>"10"
1089	387-1337		115.22	387	"5"=>"12"
1090	387-1338		79.37	387	"5"=>"11"
1091	387-1339		30.26	387	"5"=>"10"
1092	388-1337		174.60	388	"5"=>"12"
1093	388-1338		114.29	388	"5"=>"11"
1094	388-1339		98.02	388	"5"=>"10"
1095	389-1337		84.84	389	"5"=>"12"
1096	389-1338		83.02	389	"5"=>"11"
1097	389-1339		62.12	389	"5"=>"10"
1098	390-1337		171.66	390	"5"=>"12"
1099	390-1338		109.16	390	"5"=>"11"
1100	390-1339		102.25	390	"5"=>"10"
1101	391-1337		\N	391	"8"=>"23"
1102	391-1338		\N	391	"8"=>"22"
1103	391-1339		\N	391	"8"=>"21"
1104	391-1340		\N	391	"8"=>"20"
1105	391-1341		\N	391	"8"=>"19"
1106	391-1342		\N	391	"8"=>"18"
1107	392-1337		\N	392	"8"=>"23"
1108	392-1338		\N	392	"8"=>"22"
1109	392-1339		\N	392	"8"=>"21"
1110	392-1340		\N	392	"8"=>"20"
1111	392-1341		\N	392	"8"=>"19"
1112	392-1342		\N	392	"8"=>"18"
1113	393-1337		\N	393	"8"=>"23"
1114	393-1338		\N	393	"8"=>"22"
1115	393-1339		\N	393	"8"=>"21"
1116	393-1340		\N	393	"8"=>"20"
1117	393-1341		\N	393	"8"=>"19"
1118	393-1342		\N	393	"8"=>"18"
1119	394-1337		\N	394	"8"=>"23"
1120	394-1338		\N	394	"8"=>"22"
1121	394-1339		\N	394	"8"=>"21"
1122	394-1340		\N	394	"8"=>"20"
1123	394-1341		\N	394	"8"=>"19"
1124	394-1342		\N	394	"8"=>"18"
1125	395-1337		\N	395	"8"=>"23"
1126	395-1338		\N	395	"8"=>"22"
1127	395-1339		\N	395	"8"=>"21"
1128	395-1340		\N	395	"8"=>"20"
1129	395-1341		\N	395	"8"=>"19"
1130	395-1342		\N	395	"8"=>"18"
1131	396-1337		\N	396	"8"=>"23"
1132	396-1338		\N	396	"8"=>"22"
1133	396-1339		\N	396	"8"=>"21"
1134	396-1340		\N	396	"8"=>"20"
1135	396-1341		\N	396	"8"=>"19"
1136	396-1342		\N	396	"8"=>"18"
1137	397-1337		\N	397	"8"=>"23"
1138	397-1338		\N	397	"8"=>"22"
1139	397-1339		\N	397	"8"=>"21"
1140	397-1340		\N	397	"8"=>"20"
1141	397-1341		\N	397	"8"=>"19"
1142	397-1342		\N	397	"8"=>"18"
1143	398-1337		\N	398	"8"=>"23"
1144	398-1338		\N	398	"8"=>"22"
1145	398-1339		\N	398	"8"=>"21"
1146	398-1340		\N	398	"8"=>"20"
1147	398-1341		\N	398	"8"=>"19"
1148	398-1342		\N	398	"8"=>"18"
1149	399-1337		\N	399	"8"=>"23"
1150	399-1338		\N	399	"8"=>"22"
1151	399-1339		\N	399	"8"=>"21"
1152	399-1340		\N	399	"8"=>"20"
1153	399-1341		\N	399	"8"=>"19"
1154	399-1342		\N	399	"8"=>"18"
1155	400-1337		\N	400	"8"=>"23"
1156	400-1338		\N	400	"8"=>"22"
1157	400-1339		\N	400	"8"=>"21"
1158	400-1340		\N	400	"8"=>"20"
1159	400-1341		\N	400	"8"=>"19"
1160	400-1342		\N	400	"8"=>"18"
1161	401-1337		163.09	401	"12"=>"31"
1162	401-1338		105.72	401	"12"=>"30"
1163	402-1337		85.95	402	"12"=>"31"
1164	402-1338		64.55	402	"12"=>"30"
1165	403-1337		76.26	403	"12"=>"31"
1166	403-1338		11.75	403	"12"=>"30"
1167	404-1337		156.62	404	"12"=>"31"
1168	404-1338		120.54	404	"12"=>"30"
1169	405-1337		106.33	405	"12"=>"31"
1170	405-1338		94.37	405	"12"=>"30"
1171	406-1337		124.35	406	"12"=>"31"
1172	406-1338		100.30	406	"12"=>"30"
1173	407-1337		46.01	407	"12"=>"31"
1174	407-1338		33.67	407	"12"=>"30"
1175	408-1337		75.85	408	"12"=>"31"
1176	408-1338		68.01	408	"12"=>"30"
1177	409-1337		77.98	409	"12"=>"31"
1178	409-1338		41.98	409	"12"=>"30"
1179	410-1337		161.52	410	"12"=>"31"
1180	410-1338		161.06	410	"12"=>"30"
1181	411-1337		\N	411	
1182	412-1337		\N	412	
1183	413-1337		\N	413	
1184	414-1337		\N	414	
1185	415-1337		\N	415	
1186	416-1337		\N	416	
1187	417-1337		\N	417	
1188	418-1337		\N	418	
1189	419-1337		\N	419	
1190	420-1337		\N	420	
1191	421-1337		108.06	421	"3"=>"7"
1192	421-1338		95.51	421	"3"=>"6"
1193	421-1339		76.10	421	"3"=>"5"
1194	421-1340		68.72	421	"3"=>"4"
1195	422-1337		116.48	422	"3"=>"7"
1196	422-1338		101.83	422	"3"=>"6"
1197	422-1339		94.97	422	"3"=>"5"
1198	422-1340		80.33	422	"3"=>"4"
1199	423-1337		132.63	423	"3"=>"7"
1200	423-1338		115.25	423	"3"=>"6"
1201	423-1339		105.44	423	"3"=>"5"
1202	423-1340		104.50	423	"3"=>"4"
1203	424-1337		143.29	424	"3"=>"7"
1204	424-1338		140.90	424	"3"=>"6"
1205	424-1339		139.15	424	"3"=>"5"
1206	424-1340		137.76	424	"3"=>"4"
1207	425-1337		158.44	425	"3"=>"7"
1208	425-1338		155.78	425	"3"=>"6"
1209	425-1339		108.82	425	"3"=>"5"
1210	425-1340		94.21	425	"3"=>"4"
1211	426-1337		91.41	426	"3"=>"7"
1212	426-1338		74.26	426	"3"=>"6"
1213	426-1339		71.68	426	"3"=>"5"
1214	426-1340		19.68	426	"3"=>"4"
1215	427-1337		158.98	427	"3"=>"7"
1216	427-1338		154.84	427	"3"=>"6"
1217	427-1339		114.27	427	"3"=>"5"
1218	427-1340		112.97	427	"3"=>"4"
1219	428-1337		148.35	428	"3"=>"7"
1220	428-1338		137.67	428	"3"=>"6"
1221	428-1339		93.49	428	"3"=>"5"
1222	428-1340		88.80	428	"3"=>"4"
1223	429-1337		134.79	429	"3"=>"7"
1224	429-1338		130.76	429	"3"=>"6"
1225	429-1339		101.67	429	"3"=>"5"
1226	429-1340		64.03	429	"3"=>"4"
1227	430-1337		106.41	430	"3"=>"7"
1228	430-1338		106.38	430	"3"=>"6"
1229	430-1339		82.71	430	"3"=>"5"
1230	430-1340		79.80	430	"3"=>"4"
1231	431-1337		\N	431	
1232	432-1337		\N	432	
1233	433-1337		\N	433	
1234	434-1337		\N	434	
1235	435-1337		\N	435	
1236	436-1337		\N	436	
1237	437-1337		\N	437	
1238	438-1337		\N	438	
1239	439-1337		\N	439	
1240	440-1337		\N	440	
1241	441-1337		105.51	441	"5"=>"12"
1242	441-1338		92.68	441	"5"=>"11"
1243	441-1339		33.77	441	"5"=>"10"
1244	442-1337		145.20	442	"5"=>"12"
1245	442-1338		143.53	442	"5"=>"11"
1246	442-1339		139.49	442	"5"=>"10"
1247	443-1337		50.58	443	"5"=>"12"
1248	443-1338		45.87	443	"5"=>"11"
1249	443-1339		18.58	443	"5"=>"10"
1250	444-1337		107.88	444	"5"=>"12"
1251	444-1338		81.55	444	"5"=>"11"
1252	444-1339		56.69	444	"5"=>"10"
1253	445-1337		77.51	445	"5"=>"12"
1254	445-1338		60.32	445	"5"=>"11"
1255	445-1339		45.84	445	"5"=>"10"
1256	446-1337		131.22	446	"5"=>"12"
1257	446-1338		109.80	446	"5"=>"11"
1258	446-1339		49.40	446	"5"=>"10"
1259	447-1337		179.61	447	"5"=>"12"
1260	447-1338		165.53	447	"5"=>"11"
1261	447-1339		147.58	447	"5"=>"10"
1262	448-1337		69.50	448	"5"=>"12"
1263	448-1338		17.22	448	"5"=>"11"
1264	448-1339		17.12	448	"5"=>"10"
1265	449-1337		145.53	449	"5"=>"12"
1266	449-1338		113.69	449	"5"=>"11"
1267	449-1339		54.38	449	"5"=>"10"
1268	450-1337		129.25	450	"5"=>"12"
1269	450-1338		128.11	450	"5"=>"11"
1270	450-1339		119.81	450	"5"=>"10"
1271	451-1337		\N	451	"8"=>"23"
1272	451-1338		\N	451	"8"=>"22"
1273	451-1339		\N	451	"8"=>"21"
1274	451-1340		\N	451	"8"=>"20"
1275	451-1341		\N	451	"8"=>"19"
1276	451-1342		\N	451	"8"=>"18"
1277	452-1337		\N	452	"8"=>"23"
1278	452-1338		\N	452	"8"=>"22"
1279	452-1339		\N	452	"8"=>"21"
1280	452-1340		\N	452	"8"=>"20"
1281	452-1341		\N	452	"8"=>"19"
1282	452-1342		\N	452	"8"=>"18"
1283	453-1337		\N	453	"8"=>"23"
1284	453-1338		\N	453	"8"=>"22"
1285	453-1339		\N	453	"8"=>"21"
1286	453-1340		\N	453	"8"=>"20"
1287	453-1341		\N	453	"8"=>"19"
1288	453-1342		\N	453	"8"=>"18"
1289	454-1337		\N	454	"8"=>"23"
1290	454-1338		\N	454	"8"=>"22"
1291	454-1339		\N	454	"8"=>"21"
1292	454-1340		\N	454	"8"=>"20"
1293	454-1341		\N	454	"8"=>"19"
1294	454-1342		\N	454	"8"=>"18"
1295	455-1337		\N	455	"8"=>"23"
1296	455-1338		\N	455	"8"=>"22"
1297	455-1339		\N	455	"8"=>"21"
1298	455-1340		\N	455	"8"=>"20"
1299	455-1341		\N	455	"8"=>"19"
1300	455-1342		\N	455	"8"=>"18"
1301	456-1337		\N	456	"8"=>"23"
1302	456-1338		\N	456	"8"=>"22"
1303	456-1339		\N	456	"8"=>"21"
1304	456-1340		\N	456	"8"=>"20"
1305	456-1341		\N	456	"8"=>"19"
1306	456-1342		\N	456	"8"=>"18"
1307	457-1337		\N	457	"8"=>"23"
1308	457-1338		\N	457	"8"=>"22"
1309	457-1339		\N	457	"8"=>"21"
1310	457-1340		\N	457	"8"=>"20"
1311	457-1341		\N	457	"8"=>"19"
1312	457-1342		\N	457	"8"=>"18"
1313	458-1337		\N	458	"8"=>"23"
1314	458-1338		\N	458	"8"=>"22"
1315	458-1339		\N	458	"8"=>"21"
1316	458-1340		\N	458	"8"=>"20"
1317	458-1341		\N	458	"8"=>"19"
1318	458-1342		\N	458	"8"=>"18"
1319	459-1337		\N	459	"8"=>"23"
1320	459-1338		\N	459	"8"=>"22"
1321	459-1339		\N	459	"8"=>"21"
1322	459-1340		\N	459	"8"=>"20"
1323	459-1341		\N	459	"8"=>"19"
1324	459-1342		\N	459	"8"=>"18"
1325	460-1337		\N	460	"8"=>"23"
1326	460-1338		\N	460	"8"=>"22"
1327	460-1339		\N	460	"8"=>"21"
1328	460-1340		\N	460	"8"=>"20"
1329	460-1341		\N	460	"8"=>"19"
1330	460-1342		\N	460	"8"=>"18"
1331	461-1337		84.21	461	"12"=>"31"
1332	461-1338		73.80	461	"12"=>"30"
1333	462-1337		181.42	462	"12"=>"31"
1334	462-1338		173.38	462	"12"=>"30"
1335	463-1337		100.94	463	"12"=>"31"
1336	463-1338		89.46	463	"12"=>"30"
1337	464-1337		89.70	464	"12"=>"31"
1338	464-1338		79.42	464	"12"=>"30"
1339	465-1337		61.17	465	"12"=>"31"
1340	465-1338		60.07	465	"12"=>"30"
1341	466-1337		133.38	466	"12"=>"31"
1342	466-1338		94.52	466	"12"=>"30"
1343	467-1337		153.16	467	"12"=>"31"
1344	467-1338		92.78	467	"12"=>"30"
1345	468-1337		129.15	468	"12"=>"31"
1346	468-1338		71.15	468	"12"=>"30"
1347	469-1337		159.56	469	"12"=>"31"
1348	469-1338		114.58	469	"12"=>"30"
1349	470-1337		169.16	470	"12"=>"31"
1350	470-1338		125.30	470	"12"=>"30"
1351	471-1337		\N	471	
1352	472-1337		\N	472	
1353	473-1337		\N	473	
1354	474-1337		\N	474	
1355	475-1337		\N	475	
1356	476-1337		\N	476	
1357	477-1337		\N	477	
1358	478-1337		\N	478	
1359	479-1337		\N	479	
1360	480-1337		\N	480	
1361	481-1337		135.96	481	"3"=>"7"
1362	481-1338		118.42	481	"3"=>"6"
1363	481-1339		106.84	481	"3"=>"5"
1364	481-1340		98.48	481	"3"=>"4"
1365	482-1337		68.01	482	"3"=>"7"
1366	482-1338		60.08	482	"3"=>"6"
1367	482-1339		48.80	482	"3"=>"5"
1368	482-1340		31.21	482	"3"=>"4"
1369	483-1337		120.10	483	"3"=>"7"
1370	483-1338		105.96	483	"3"=>"6"
1371	483-1339		68.65	483	"3"=>"5"
1372	483-1340		51.28	483	"3"=>"4"
1373	484-1337		149.62	484	"3"=>"7"
1374	484-1338		116.59	484	"3"=>"6"
1375	484-1339		73.49	484	"3"=>"5"
1376	484-1340		69.91	484	"3"=>"4"
1377	485-1337		169.91	485	"3"=>"7"
1378	485-1338		166.53	485	"3"=>"6"
1379	485-1339		125.51	485	"3"=>"5"
1380	485-1340		113.54	485	"3"=>"4"
1381	486-1337		115.43	486	"3"=>"7"
1382	486-1338		109.35	486	"3"=>"6"
1383	486-1339		108.54	486	"3"=>"5"
1384	486-1340		33.94	486	"3"=>"4"
1385	487-1337		137.74	487	"3"=>"7"
1386	487-1338		135.69	487	"3"=>"6"
1387	487-1339		84.35	487	"3"=>"5"
1388	487-1340		51.23	487	"3"=>"4"
1389	488-1337		152.90	488	"3"=>"7"
1390	488-1338		139.02	488	"3"=>"6"
1391	488-1339		123.32	488	"3"=>"5"
1392	488-1340		89.40	488	"3"=>"4"
1393	489-1337		125.63	489	"3"=>"7"
1394	489-1338		100.35	489	"3"=>"6"
1395	489-1339		80.20	489	"3"=>"5"
1396	489-1340		75.68	489	"3"=>"4"
1397	490-1337		126.75	490	"3"=>"7"
1398	490-1338		87.32	490	"3"=>"6"
1399	490-1339		79.77	490	"3"=>"5"
1400	490-1340		43.26	490	"3"=>"4"
1401	491-1337		\N	491	
1402	492-1337		\N	492	
1403	493-1337		\N	493	
1404	494-1337		\N	494	
1405	495-1337		\N	495	
1406	496-1337		\N	496	
1407	497-1337		\N	497	
1408	498-1337		\N	498	
1409	499-1337		\N	499	
1410	500-1337		\N	500	
1411	501-1337		195.34	501	"5"=>"12"
1412	501-1338		164.98	501	"5"=>"11"
1413	501-1339		139.67	501	"5"=>"10"
1414	502-1337		117.86	502	"5"=>"12"
1415	502-1338		95.30	502	"5"=>"11"
1416	502-1339		30.12	502	"5"=>"10"
1417	503-1337		136.86	503	"5"=>"12"
1418	503-1338		80.86	503	"5"=>"11"
1419	503-1339		73.60	503	"5"=>"10"
1420	504-1337		152.12	504	"5"=>"12"
1421	504-1338		132.25	504	"5"=>"11"
1422	504-1339		102.95	504	"5"=>"10"
1423	505-1337		147.30	505	"5"=>"12"
1424	505-1338		137.58	505	"5"=>"11"
1425	505-1339		118.98	505	"5"=>"10"
1426	506-1337		125.64	506	"5"=>"12"
1427	506-1338		106.98	506	"5"=>"11"
1428	506-1339		67.85	506	"5"=>"10"
1429	507-1337		120.60	507	"5"=>"12"
1430	507-1338		102.29	507	"5"=>"11"
1431	507-1339		93.88	507	"5"=>"10"
1432	508-1337		171.32	508	"5"=>"12"
1433	508-1338		119.37	508	"5"=>"11"
1434	508-1339		82.51	508	"5"=>"10"
1435	509-1337		151.84	509	"5"=>"12"
1436	509-1338		128.86	509	"5"=>"11"
1437	509-1339		94.33	509	"5"=>"10"
1438	510-1337		142.51	510	"5"=>"12"
1439	510-1338		88.81	510	"5"=>"11"
1440	510-1339		84.92	510	"5"=>"10"
1441	511-1337		\N	511	"8"=>"23"
1442	511-1338		\N	511	"8"=>"22"
1443	511-1339		\N	511	"8"=>"21"
1444	511-1340		\N	511	"8"=>"20"
1445	511-1341		\N	511	"8"=>"19"
1446	511-1342		\N	511	"8"=>"18"
1447	512-1337		\N	512	"8"=>"23"
1448	512-1338		\N	512	"8"=>"22"
1449	512-1339		\N	512	"8"=>"21"
1450	512-1340		\N	512	"8"=>"20"
1451	512-1341		\N	512	"8"=>"19"
1452	512-1342		\N	512	"8"=>"18"
1453	513-1337		\N	513	"8"=>"23"
1454	513-1338		\N	513	"8"=>"22"
1455	513-1339		\N	513	"8"=>"21"
1456	513-1340		\N	513	"8"=>"20"
1457	513-1341		\N	513	"8"=>"19"
1458	513-1342		\N	513	"8"=>"18"
1459	514-1337		\N	514	"8"=>"23"
1460	514-1338		\N	514	"8"=>"22"
1461	514-1339		\N	514	"8"=>"21"
1462	514-1340		\N	514	"8"=>"20"
1463	514-1341		\N	514	"8"=>"19"
1464	514-1342		\N	514	"8"=>"18"
1465	515-1337		\N	515	"8"=>"23"
1466	515-1338		\N	515	"8"=>"22"
1467	515-1339		\N	515	"8"=>"21"
1468	515-1340		\N	515	"8"=>"20"
1469	515-1341		\N	515	"8"=>"19"
1470	515-1342		\N	515	"8"=>"18"
1471	516-1337		\N	516	"8"=>"23"
1472	516-1338		\N	516	"8"=>"22"
1473	516-1339		\N	516	"8"=>"21"
1474	516-1340		\N	516	"8"=>"20"
1475	516-1341		\N	516	"8"=>"19"
1476	516-1342		\N	516	"8"=>"18"
1477	517-1337		\N	517	"8"=>"23"
1478	517-1338		\N	517	"8"=>"22"
1479	517-1339		\N	517	"8"=>"21"
1480	517-1340		\N	517	"8"=>"20"
1481	517-1341		\N	517	"8"=>"19"
1482	517-1342		\N	517	"8"=>"18"
1483	518-1337		\N	518	"8"=>"23"
1484	518-1338		\N	518	"8"=>"22"
1485	518-1339		\N	518	"8"=>"21"
1486	518-1340		\N	518	"8"=>"20"
1487	518-1341		\N	518	"8"=>"19"
1488	518-1342		\N	518	"8"=>"18"
1489	519-1337		\N	519	"8"=>"23"
1490	519-1338		\N	519	"8"=>"22"
1491	519-1339		\N	519	"8"=>"21"
1492	519-1340		\N	519	"8"=>"20"
1493	519-1341		\N	519	"8"=>"19"
1494	519-1342		\N	519	"8"=>"18"
1495	520-1337		\N	520	"8"=>"23"
1496	520-1338		\N	520	"8"=>"22"
1497	520-1339		\N	520	"8"=>"21"
1498	520-1340		\N	520	"8"=>"20"
1499	520-1341		\N	520	"8"=>"19"
1500	520-1342		\N	520	"8"=>"18"
1501	521-1337		95.95	521	"12"=>"31"
1502	521-1338		79.03	521	"12"=>"30"
1503	522-1337		60.36	522	"12"=>"31"
1504	522-1338		39.26	522	"12"=>"30"
1505	523-1337		84.99	523	"12"=>"31"
1506	523-1338		49.82	523	"12"=>"30"
1507	524-1337		134.97	524	"12"=>"31"
1508	524-1338		66.17	524	"12"=>"30"
1509	525-1337		128.12	525	"12"=>"31"
1510	525-1338		62.10	525	"12"=>"30"
1511	526-1337		140.63	526	"12"=>"31"
1512	526-1338		127.37	526	"12"=>"30"
1513	527-1337		105.09	527	"12"=>"31"
1514	527-1338		42.24	527	"12"=>"30"
1515	528-1337		123.94	528	"12"=>"31"
1516	528-1338		86.70	528	"12"=>"30"
1517	529-1337		165.38	529	"12"=>"31"
1518	529-1338		98.26	529	"12"=>"30"
1519	530-1337		128.52	530	"12"=>"31"
1520	530-1338		61.24	530	"12"=>"30"
1521	531-1337		\N	531	
1522	532-1337		\N	532	
1523	533-1337		\N	533	
1524	534-1337		\N	534	
1525	535-1337		\N	535	
1526	536-1337		\N	536	
1527	537-1337		\N	537	
1528	538-1337		\N	538	
1529	539-1337		\N	539	
1530	540-1337		\N	540	
\.


--
-- Data for Name: product_stock; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY product_stock (id, quantity, cost_price, variant_id, quantity_allocated, location_id) FROM stdin;
1	23	\N	1	0	1
2	30	\N	2	0	1
3	48	\N	3	0	1
4	29	\N	4	0	1
5	14	\N	5	0	1
6	41	\N	6	0	1
7	6	\N	7	0	1
8	8	\N	8	0	1
9	32	\N	9	0	1
10	9	\N	10	0	1
11	9	\N	11	0	1
12	34	\N	12	0	1
13	8	\N	13	0	1
14	25	\N	14	0	1
15	50	\N	15	0	1
16	47	\N	16	0	1
17	20	\N	17	0	1
18	33	\N	18	0	1
19	24	\N	19	0	1
20	8	\N	20	0	1
21	2	\N	21	0	1
22	45	\N	22	0	1
23	46	\N	23	0	1
24	46	\N	24	0	1
25	17	\N	25	0	1
26	44	\N	26	0	1
27	41	\N	27	0	1
28	50	\N	28	0	1
29	5	\N	29	0	1
30	36	\N	30	0	1
31	16	\N	31	0	1
32	28	\N	32	0	1
33	7	\N	33	0	1
34	38	\N	34	0	1
35	27	\N	35	0	1
36	33	\N	36	0	1
37	29	\N	37	0	1
38	18	\N	38	0	1
39	31	\N	39	0	1
40	45	\N	40	0	1
41	26	\N	41	0	1
42	23	\N	42	0	1
43	47	\N	43	0	1
44	5	\N	44	0	1
45	11	\N	45	0	1
46	48	\N	46	0	1
47	39	\N	47	0	1
48	24	\N	48	0	1
49	17	\N	49	0	1
50	24	\N	50	0	1
51	42	\N	51	0	1
52	34	\N	52	0	1
53	31	\N	53	0	1
54	29	\N	54	0	1
55	36	\N	55	0	1
56	6	\N	56	0	1
57	31	\N	57	0	1
58	31	\N	58	0	1
59	2	\N	59	0	1
60	44	\N	60	0	1
61	16	\N	61	0	1
62	22	\N	62	0	1
63	40	\N	63	0	1
64	25	\N	64	0	1
65	32	\N	65	0	1
66	1	\N	66	0	1
67	33	\N	67	0	1
68	24	\N	68	0	1
69	14	\N	69	0	1
70	47	\N	70	0	1
71	30	\N	71	0	1
72	28	\N	72	0	1
73	45	\N	73	0	1
74	35	\N	74	0	1
75	32	\N	75	0	1
76	27	\N	76	0	1
77	4	\N	77	0	1
78	23	\N	78	0	1
79	49	\N	79	0	1
80	8	\N	80	0	1
81	13	\N	81	0	1
82	3	\N	82	0	1
83	22	\N	83	0	1
84	26	\N	84	0	1
85	30	\N	85	0	1
86	25	\N	86	0	1
87	10	\N	87	0	1
88	39	\N	88	0	1
89	18	\N	89	0	1
90	11	\N	90	0	1
91	48	\N	91	0	1
92	1	\N	92	0	1
93	19	\N	93	0	1
94	45	\N	94	0	1
95	33	\N	95	0	1
96	15	\N	96	0	1
97	22	\N	97	0	1
98	32	\N	98	0	1
99	30	\N	99	0	1
100	16	\N	100	0	1
101	39	\N	101	0	1
102	29	\N	102	0	1
103	21	\N	103	0	1
104	11	\N	104	0	1
105	18	\N	105	0	1
106	4	\N	106	0	1
107	41	\N	107	0	1
108	5	\N	108	0	1
109	8	\N	109	0	1
110	13	\N	110	0	1
111	4	\N	111	0	1
112	20	\N	112	0	1
113	10	\N	113	0	1
114	44	\N	114	0	1
115	15	\N	115	0	1
116	19	\N	116	0	1
117	14	\N	117	0	1
118	46	\N	118	0	1
119	34	\N	119	0	1
120	20	\N	120	0	1
121	38	\N	121	0	1
122	41	\N	122	0	1
123	19	\N	123	0	1
124	31	\N	124	0	1
125	43	\N	125	0	1
126	10	\N	126	0	1
127	18	\N	127	0	1
128	42	\N	128	0	1
129	5	\N	129	0	1
130	42	\N	130	0	1
131	1	\N	131	0	1
132	4	\N	132	0	1
133	9	\N	133	0	1
134	22	\N	134	0	1
135	36	\N	135	0	1
136	22	\N	136	0	1
137	33	\N	137	0	1
138	20	\N	138	0	1
139	30	\N	139	0	1
140	49	\N	140	0	1
141	38	\N	141	0	1
142	5	\N	142	0	1
143	28	\N	143	0	1
144	48	\N	144	0	1
145	5	\N	145	0	1
146	37	\N	146	0	1
147	35	\N	147	0	1
148	40	\N	148	0	1
149	33	\N	149	0	1
150	50	\N	150	0	1
151	27	\N	151	0	1
152	42	\N	152	0	1
153	16	\N	153	0	1
154	1	\N	154	0	1
155	45	\N	155	0	1
156	37	\N	156	0	1
157	1	\N	157	0	1
158	3	\N	158	0	1
159	25	\N	159	0	1
160	35	\N	160	0	1
161	19	\N	161	0	1
162	20	\N	162	0	1
163	27	\N	163	0	1
164	40	\N	164	0	1
165	49	\N	165	0	1
166	40	\N	166	0	1
167	27	\N	167	0	1
168	31	\N	168	0	1
169	28	\N	169	0	1
170	48	\N	170	0	1
171	7	\N	171	0	1
172	18	\N	172	0	1
173	29	\N	173	0	1
174	8	\N	174	0	1
175	14	\N	175	0	1
176	46	\N	176	0	1
177	1	\N	177	0	1
178	11	\N	178	0	1
179	49	\N	179	0	1
180	10	\N	180	0	1
181	50	\N	181	0	1
182	41	\N	182	0	1
183	10	\N	183	0	1
184	12	\N	184	0	1
185	1	\N	185	0	1
186	2	\N	186	0	1
187	49	\N	187	0	1
188	23	\N	188	0	1
189	43	\N	189	0	1
190	16	\N	190	0	1
191	19	\N	191	0	1
192	7	\N	192	0	1
193	41	\N	193	0	1
194	26	\N	194	0	1
195	2	\N	195	0	1
196	24	\N	196	0	1
197	19	\N	197	0	1
198	7	\N	198	0	1
199	29	\N	199	0	1
200	36	\N	200	0	1
201	36	\N	201	0	1
202	3	\N	202	0	1
203	48	\N	203	0	1
204	50	\N	204	0	1
205	20	\N	205	0	1
206	35	\N	206	0	1
207	29	\N	207	0	1
208	46	\N	208	0	1
209	7	\N	209	0	1
210	18	\N	210	0	1
211	27	\N	211	0	1
212	5	\N	212	0	1
213	25	\N	213	0	1
214	42	\N	214	0	1
215	5	\N	215	0	1
216	8	\N	216	0	1
217	25	\N	217	0	1
218	24	\N	218	0	1
219	3	\N	219	0	1
220	43	\N	220	0	1
221	22	\N	221	0	1
222	4	\N	222	0	1
223	26	\N	223	0	1
224	24	\N	224	0	1
225	12	\N	225	0	1
226	47	\N	226	0	1
227	29	\N	227	0	1
228	14	\N	228	0	1
229	7	\N	229	0	1
230	23	\N	230	0	1
231	31	\N	231	0	1
232	15	\N	232	0	1
233	1	\N	233	0	1
234	29	\N	234	0	1
235	48	\N	235	0	1
236	43	\N	236	0	1
237	46	\N	237	0	1
238	39	\N	238	0	1
239	11	\N	239	0	1
240	19	\N	240	0	1
241	12	\N	241	0	1
242	28	\N	242	0	1
243	22	\N	243	0	1
244	16	\N	244	0	1
245	23	\N	245	0	1
246	4	\N	246	0	1
247	30	\N	247	0	1
248	37	\N	248	0	1
249	37	\N	249	0	1
250	39	\N	250	0	1
251	3	\N	251	0	1
252	18	\N	252	0	1
253	28	\N	253	0	1
254	45	\N	254	0	1
255	28	\N	255	0	1
256	3	\N	256	0	1
257	42	\N	257	0	1
258	40	\N	258	0	1
259	32	\N	259	0	1
260	44	\N	260	0	1
261	32	\N	261	0	1
262	21	\N	262	0	1
263	48	\N	263	0	1
264	5	\N	264	0	1
265	8	\N	265	0	1
266	45	\N	266	0	1
267	47	\N	267	0	1
268	30	\N	268	0	1
269	33	\N	269	0	1
270	4	\N	270	0	1
271	39	\N	271	0	1
272	28	\N	272	0	1
273	7	\N	273	0	1
274	50	\N	274	0	1
275	10	\N	275	0	1
276	49	\N	276	0	1
277	15	\N	277	0	1
278	45	\N	278	0	1
279	24	\N	279	0	1
280	48	\N	280	0	1
281	21	\N	281	0	1
282	7	\N	282	0	1
283	43	\N	283	0	1
284	20	\N	284	0	1
285	13	\N	285	0	1
286	15	\N	286	0	1
287	32	\N	287	0	1
288	37	\N	288	0	1
289	46	\N	289	0	1
290	46	\N	290	0	1
291	42	\N	291	0	1
292	5	\N	292	0	1
293	34	\N	293	0	1
294	49	\N	294	0	1
295	33	\N	295	0	1
296	46	\N	296	0	1
297	14	\N	297	0	1
298	20	\N	298	0	1
299	43	\N	299	0	1
300	47	\N	300	0	1
301	44	\N	301	0	1
302	38	\N	302	0	1
303	49	\N	303	0	1
304	41	\N	304	0	1
305	7	\N	305	0	1
306	11	\N	306	0	1
307	49	\N	307	0	1
308	6	\N	308	0	1
309	37	\N	309	0	1
310	21	\N	310	0	1
311	27	\N	311	0	1
312	4	\N	312	0	1
313	47	\N	313	0	1
314	16	\N	314	0	1
315	24	\N	315	0	1
316	16	\N	316	0	1
317	9	\N	317	0	1
318	33	\N	318	0	1
319	35	\N	319	0	1
320	7	\N	320	0	1
321	43	\N	321	0	1
322	23	\N	322	0	1
323	6	\N	323	0	1
324	8	\N	324	0	1
325	38	\N	325	0	1
326	49	\N	326	0	1
327	11	\N	327	0	1
328	47	\N	328	0	1
329	48	\N	329	0	1
330	16	\N	330	0	1
331	43	\N	331	0	1
332	24	\N	332	0	1
333	16	\N	333	0	1
334	41	\N	334	0	1
335	1	\N	335	0	1
336	24	\N	336	0	1
337	17	\N	337	0	1
338	41	\N	338	0	1
339	14	\N	339	0	1
340	6	\N	340	0	1
341	36	\N	341	0	1
342	1	\N	342	0	1
343	42	\N	343	0	1
344	10	\N	344	0	1
345	46	\N	345	0	1
346	7	\N	346	0	1
347	20	\N	347	0	1
348	29	\N	348	0	1
349	41	\N	349	0	1
350	27	\N	350	0	1
351	9	\N	351	0	1
352	15	\N	352	0	1
353	49	\N	353	0	1
354	9	\N	354	0	1
355	33	\N	355	0	1
356	48	\N	356	0	1
357	37	\N	357	0	1
358	26	\N	358	0	1
359	28	\N	359	0	1
360	45	\N	360	0	1
361	29	\N	361	0	1
362	18	\N	362	0	1
363	48	\N	363	0	1
364	24	\N	364	0	1
365	31	\N	365	0	1
366	45	\N	366	0	1
367	26	\N	367	0	1
368	19	\N	368	0	1
369	35	\N	369	0	1
370	2	\N	370	0	1
371	46	\N	371	0	1
372	14	\N	372	0	1
373	25	\N	373	0	1
374	6	\N	374	0	1
375	49	\N	375	0	1
376	25	\N	376	0	1
377	31	\N	377	0	1
378	44	\N	378	0	1
379	11	\N	379	0	1
380	17	\N	380	0	1
381	32	\N	381	0	1
382	32	\N	382	0	1
383	4	\N	383	0	1
384	43	\N	384	0	1
385	22	\N	385	0	1
386	33	\N	386	0	1
387	5	\N	387	0	1
388	16	\N	388	0	1
389	45	\N	389	0	1
390	6	\N	390	0	1
391	18	\N	391	0	1
392	2	\N	392	0	1
393	24	\N	393	0	1
394	36	\N	394	0	1
395	7	\N	395	0	1
396	12	\N	396	0	1
397	34	\N	397	0	1
398	41	\N	398	0	1
399	24	\N	399	0	1
400	8	\N	400	0	1
401	25	\N	401	0	1
402	29	\N	402	0	1
403	10	\N	403	0	1
404	50	\N	404	0	1
405	21	\N	405	0	1
406	47	\N	406	0	1
407	26	\N	407	0	1
408	11	\N	408	0	1
409	49	\N	409	0	1
410	24	\N	410	0	1
411	29	\N	411	0	1
412	50	\N	412	0	1
413	17	\N	413	0	1
414	23	\N	414	0	1
415	20	\N	415	0	1
416	47	\N	416	0	1
417	11	\N	417	0	1
418	50	\N	418	0	1
419	17	\N	419	0	1
420	20	\N	420	0	1
421	31	\N	421	0	1
422	20	\N	422	0	1
423	45	\N	423	0	1
424	44	\N	424	0	1
425	48	\N	425	0	1
426	39	\N	426	0	1
427	4	\N	427	0	1
428	15	\N	428	0	1
429	44	\N	429	0	1
430	45	\N	430	0	1
431	28	\N	431	0	1
432	24	\N	432	0	1
433	33	\N	433	0	1
434	25	\N	434	0	1
435	32	\N	435	0	1
436	34	\N	436	0	1
437	42	\N	437	0	1
438	43	\N	438	0	1
439	33	\N	439	0	1
440	17	\N	440	0	1
441	22	\N	441	0	1
442	5	\N	442	0	1
443	7	\N	443	0	1
444	19	\N	444	0	1
445	49	\N	445	0	1
446	44	\N	446	0	1
447	4	\N	447	0	1
448	47	\N	448	0	1
449	31	\N	449	0	1
450	50	\N	450	0	1
451	26	\N	451	0	1
452	36	\N	452	0	1
453	8	\N	453	0	1
454	24	\N	454	0	1
455	37	\N	455	0	1
456	34	\N	456	0	1
457	49	\N	457	0	1
458	20	\N	458	0	1
459	35	\N	459	0	1
460	49	\N	460	0	1
461	42	\N	461	0	1
462	41	\N	462	0	1
463	29	\N	463	0	1
464	18	\N	464	0	1
465	8	\N	465	0	1
466	7	\N	466	0	1
467	18	\N	467	0	1
468	49	\N	468	0	1
469	25	\N	469	0	1
470	22	\N	470	0	1
471	24	\N	471	0	1
472	47	\N	472	0	1
473	3	\N	473	0	1
474	44	\N	474	0	1
475	27	\N	475	0	1
476	23	\N	476	0	1
477	24	\N	477	0	1
478	21	\N	478	0	1
479	30	\N	479	0	1
480	30	\N	480	0	1
481	7	\N	481	0	1
482	41	\N	482	0	1
483	38	\N	483	0	1
484	44	\N	484	0	1
485	27	\N	485	0	1
486	5	\N	486	0	1
487	46	\N	487	0	1
488	37	\N	488	0	1
489	19	\N	489	0	1
490	18	\N	490	0	1
491	12	\N	491	0	1
492	8	\N	492	0	1
493	48	\N	493	0	1
494	31	\N	494	0	1
495	16	\N	495	0	1
496	46	\N	496	0	1
497	26	\N	497	0	1
498	5	\N	498	0	1
499	36	\N	499	0	1
500	13	\N	500	0	1
501	38	\N	501	0	1
502	34	\N	502	0	1
503	13	\N	503	0	1
504	27	\N	504	0	1
505	5	\N	505	0	1
506	21	\N	506	0	1
507	14	\N	507	0	1
508	2	\N	508	0	1
509	50	\N	509	0	1
510	17	\N	510	0	1
511	18	\N	511	0	1
512	49	\N	512	0	1
513	25	\N	513	0	1
514	31	\N	514	0	1
515	39	\N	515	0	1
516	31	\N	516	0	1
517	49	\N	517	0	1
518	11	\N	518	0	1
519	29	\N	519	0	1
520	13	\N	520	0	1
521	25	\N	521	0	1
522	24	\N	522	0	1
523	31	\N	523	0	1
524	30	\N	524	0	1
525	21	\N	525	0	1
526	22	\N	526	0	1
527	18	\N	527	0	1
528	13	\N	528	0	1
529	13	\N	529	0	1
530	43	\N	530	0	1
531	42	\N	531	0	1
532	17	\N	532	0	1
533	24	\N	533	0	1
534	49	\N	534	0	1
535	14	\N	535	0	1
536	41	\N	536	0	1
537	27	\N	537	0	1
538	27	\N	538	0	1
539	41	\N	539	0	1
540	3	\N	540	0	1
541	49	\N	541	0	1
542	29	\N	542	0	1
543	34	\N	543	0	1
544	3	\N	544	0	1
545	6	\N	545	0	1
546	38	\N	546	0	1
547	45	\N	547	0	1
548	42	\N	548	0	1
549	38	\N	549	0	1
550	13	\N	550	0	1
551	23	\N	551	0	1
552	50	\N	552	0	1
553	32	\N	553	0	1
554	42	\N	554	0	1
555	42	\N	555	0	1
556	50	\N	556	0	1
557	7	\N	557	0	1
558	16	\N	558	0	1
559	41	\N	559	0	1
560	6	\N	560	0	1
561	12	\N	561	0	1
562	49	\N	562	0	1
563	36	\N	563	0	1
564	14	\N	564	0	1
565	48	\N	565	0	1
566	9	\N	566	0	1
567	5	\N	567	0	1
568	28	\N	568	0	1
569	21	\N	569	0	1
570	41	\N	570	0	1
571	27	\N	571	0	1
572	43	\N	572	0	1
573	34	\N	573	0	1
574	41	\N	574	0	1
575	37	\N	575	0	1
576	40	\N	576	0	1
577	18	\N	577	0	1
578	26	\N	578	0	1
579	8	\N	579	0	1
580	45	\N	580	0	1
581	7	\N	581	0	1
582	34	\N	582	0	1
583	42	\N	583	0	1
584	40	\N	584	0	1
585	15	\N	585	0	1
586	20	\N	586	0	1
587	29	\N	587	0	1
588	36	\N	588	0	1
589	22	\N	589	0	1
590	1	\N	590	0	1
591	29	\N	591	0	1
592	14	\N	592	0	1
593	16	\N	593	0	1
594	34	\N	594	0	1
595	8	\N	595	0	1
596	5	\N	596	0	1
597	6	\N	597	0	1
598	17	\N	598	0	1
599	36	\N	599	0	1
600	7	\N	600	0	1
601	6	\N	601	0	1
602	29	\N	602	0	1
603	42	\N	603	0	1
604	42	\N	604	0	1
605	18	\N	605	0	1
606	3	\N	606	0	1
607	21	\N	607	0	1
608	28	\N	608	0	1
609	41	\N	609	0	1
610	19	\N	610	0	1
611	8	\N	611	0	1
612	33	\N	612	0	1
613	24	\N	613	0	1
614	43	\N	614	0	1
615	6	\N	615	0	1
616	49	\N	616	0	1
617	38	\N	617	0	1
618	9	\N	618	0	1
619	3	\N	619	0	1
620	27	\N	620	0	1
621	48	\N	621	0	1
622	44	\N	622	0	1
623	5	\N	623	0	1
624	33	\N	624	0	1
625	48	\N	625	0	1
626	48	\N	626	0	1
627	23	\N	627	0	1
628	3	\N	628	0	1
629	44	\N	629	0	1
630	12	\N	630	0	1
631	6	\N	631	0	1
632	37	\N	632	0	1
633	49	\N	633	0	1
634	33	\N	634	0	1
635	11	\N	635	0	1
636	7	\N	636	0	1
637	2	\N	637	0	1
638	14	\N	638	0	1
639	4	\N	639	0	1
640	16	\N	640	0	1
641	26	\N	641	0	1
642	12	\N	642	0	1
643	49	\N	643	0	1
644	11	\N	644	0	1
645	20	\N	645	0	1
646	25	\N	646	0	1
647	28	\N	647	0	1
648	17	\N	648	0	1
649	14	\N	649	0	1
650	46	\N	650	0	1
651	5	\N	651	0	1
652	50	\N	652	0	1
653	33	\N	653	0	1
654	29	\N	654	0	1
655	30	\N	655	0	1
656	16	\N	656	0	1
657	13	\N	657	0	1
658	36	\N	658	0	1
659	39	\N	659	0	1
660	48	\N	660	0	1
661	49	\N	661	0	1
662	32	\N	662	0	1
663	4	\N	663	0	1
664	34	\N	664	0	1
665	37	\N	665	0	1
666	24	\N	666	0	1
667	39	\N	667	0	1
668	38	\N	668	0	1
669	20	\N	669	0	1
670	50	\N	670	0	1
671	2	\N	671	0	1
672	18	\N	672	0	1
673	32	\N	673	0	1
674	32	\N	674	0	1
675	8	\N	675	0	1
676	45	\N	676	0	1
677	46	\N	677	0	1
678	36	\N	678	0	1
679	33	\N	679	0	1
680	28	\N	680	0	1
681	34	\N	681	0	1
682	11	\N	682	0	1
683	37	\N	683	0	1
684	16	\N	684	0	1
685	44	\N	685	0	1
686	21	\N	686	0	1
687	45	\N	687	0	1
688	4	\N	688	0	1
689	24	\N	689	0	1
690	49	\N	690	0	1
691	42	\N	691	0	1
692	2	\N	692	0	1
693	9	\N	693	0	1
694	23	\N	694	0	1
695	15	\N	695	0	1
696	25	\N	696	0	1
697	24	\N	697	0	1
698	6	\N	698	0	1
699	32	\N	699	0	1
700	8	\N	700	0	1
701	14	\N	701	0	1
702	44	\N	702	0	1
703	24	\N	703	0	1
704	36	\N	704	0	1
705	16	\N	705	0	1
706	7	\N	706	0	1
707	47	\N	707	0	1
708	7	\N	708	0	1
709	15	\N	709	0	1
710	50	\N	710	0	1
711	3	\N	711	0	1
712	36	\N	712	0	1
713	14	\N	713	0	1
714	23	\N	714	0	1
715	17	\N	715	0	1
716	34	\N	716	0	1
717	46	\N	717	0	1
718	10	\N	718	0	1
719	22	\N	719	0	1
720	48	\N	720	0	1
721	14	\N	721	0	1
722	25	\N	722	0	1
723	39	\N	723	0	1
724	40	\N	724	0	1
725	17	\N	725	0	1
726	15	\N	726	0	1
727	30	\N	727	0	1
728	39	\N	728	0	1
729	38	\N	729	0	1
730	21	\N	730	0	1
731	46	\N	731	0	1
732	17	\N	732	0	1
733	11	\N	733	0	1
734	28	\N	734	0	1
735	26	\N	735	0	1
736	38	\N	736	0	1
737	46	\N	737	0	1
738	40	\N	738	0	1
739	40	\N	739	0	1
740	46	\N	740	0	1
741	11	\N	741	0	1
742	20	\N	742	0	1
743	25	\N	743	0	1
744	29	\N	744	0	1
745	24	\N	745	0	1
746	10	\N	746	0	1
747	49	\N	747	0	1
748	21	\N	748	0	1
749	38	\N	749	0	1
750	43	\N	750	0	1
751	26	\N	751	0	1
752	27	\N	752	0	1
753	20	\N	753	0	1
754	27	\N	754	0	1
755	25	\N	755	0	1
756	4	\N	756	0	1
757	41	\N	757	0	1
758	34	\N	758	0	1
759	48	\N	759	0	1
760	6	\N	760	0	1
761	47	\N	761	0	1
762	38	\N	762	0	1
763	5	\N	763	0	1
764	18	\N	764	0	1
765	16	\N	765	0	1
766	40	\N	766	0	1
767	41	\N	767	0	1
768	3	\N	768	0	1
769	18	\N	769	0	1
770	13	\N	770	0	1
771	24	\N	771	0	1
772	16	\N	772	0	1
773	45	\N	773	0	1
774	44	\N	774	0	1
775	41	\N	775	0	1
776	29	\N	776	0	1
777	23	\N	777	0	1
778	35	\N	778	0	1
779	15	\N	779	0	1
780	47	\N	780	0	1
781	37	\N	781	0	1
782	1	\N	782	0	1
783	1	\N	783	0	1
784	17	\N	784	0	1
785	6	\N	785	0	1
786	16	\N	786	0	1
787	40	\N	787	0	1
788	43	\N	788	0	1
789	1	\N	789	0	1
790	4	\N	790	0	1
791	6	\N	791	0	1
792	21	\N	792	0	1
793	11	\N	793	0	1
794	49	\N	794	0	1
795	40	\N	795	0	1
796	25	\N	796	0	1
797	40	\N	797	0	1
798	8	\N	798	0	1
799	3	\N	799	0	1
800	24	\N	800	0	1
801	2	\N	801	0	1
802	36	\N	802	0	1
803	13	\N	803	0	1
804	23	\N	804	0	1
805	17	\N	805	0	1
806	34	\N	806	0	1
807	40	\N	807	0	1
808	34	\N	808	0	1
809	2	\N	809	0	1
810	37	\N	810	0	1
811	13	\N	811	0	1
812	36	\N	812	0	1
813	23	\N	813	0	1
814	18	\N	814	0	1
815	31	\N	815	0	1
816	11	\N	816	0	1
817	5	\N	817	0	1
818	50	\N	818	0	1
819	30	\N	819	0	1
820	27	\N	820	0	1
821	14	\N	821	0	1
822	33	\N	822	0	1
823	31	\N	823	0	1
824	23	\N	824	0	1
825	35	\N	825	0	1
826	42	\N	826	0	1
827	3	\N	827	0	1
828	33	\N	828	0	1
829	46	\N	829	0	1
830	40	\N	830	0	1
831	25	\N	831	0	1
832	34	\N	832	0	1
833	41	\N	833	0	1
834	28	\N	834	0	1
835	27	\N	835	0	1
836	21	\N	836	0	1
837	27	\N	837	0	1
838	29	\N	838	0	1
839	26	\N	839	0	1
840	22	\N	840	0	1
841	9	\N	841	0	1
842	37	\N	842	0	1
843	42	\N	843	0	1
844	17	\N	844	0	1
845	15	\N	845	0	1
846	27	\N	846	0	1
847	31	\N	847	0	1
848	35	\N	848	0	1
849	37	\N	849	0	1
850	37	\N	850	0	1
851	16	\N	851	0	1
852	22	\N	852	0	1
853	39	\N	853	0	1
854	50	\N	854	0	1
855	40	\N	855	0	1
856	16	\N	856	0	1
857	7	\N	857	0	1
858	16	\N	858	0	1
859	4	\N	859	0	1
860	32	\N	860	0	1
861	34	\N	861	0	1
862	41	\N	862	0	1
863	35	\N	863	0	1
864	24	\N	864	0	1
865	37	\N	865	0	1
866	44	\N	866	0	1
867	21	\N	867	0	1
868	27	\N	868	0	1
869	27	\N	869	0	1
870	23	\N	870	0	1
871	28	\N	871	0	1
872	25	\N	872	0	1
873	24	\N	873	0	1
874	22	\N	874	0	1
875	3	\N	875	0	1
876	26	\N	876	0	1
877	33	\N	877	0	1
878	8	\N	878	0	1
879	39	\N	879	0	1
880	12	\N	880	0	1
881	43	\N	881	0	1
882	46	\N	882	0	1
883	9	\N	883	0	1
884	20	\N	884	0	1
885	37	\N	885	0	1
886	42	\N	886	0	1
887	17	\N	887	0	1
888	20	\N	888	0	1
889	33	\N	889	0	1
890	26	\N	890	0	1
891	49	\N	891	0	1
892	2	\N	892	0	1
893	27	\N	893	0	1
894	47	\N	894	0	1
895	30	\N	895	0	1
896	38	\N	896	0	1
897	12	\N	897	0	1
898	19	\N	898	0	1
899	46	\N	899	0	1
900	12	\N	900	0	1
901	24	\N	901	0	1
902	39	\N	902	0	1
903	26	\N	903	0	1
904	8	\N	904	0	1
905	44	\N	905	0	1
906	27	\N	906	0	1
907	45	\N	907	0	1
908	37	\N	908	0	1
909	44	\N	909	0	1
910	10	\N	910	0	1
911	22	\N	911	0	1
912	41	\N	912	0	1
913	27	\N	913	0	1
914	25	\N	914	0	1
915	44	\N	915	0	1
916	31	\N	916	0	1
917	38	\N	917	0	1
918	19	\N	918	0	1
919	10	\N	919	0	1
920	39	\N	920	0	1
921	50	\N	921	0	1
922	24	\N	922	0	1
923	45	\N	923	0	1
924	26	\N	924	0	1
925	44	\N	925	0	1
926	3	\N	926	0	1
927	7	\N	927	0	1
928	14	\N	928	0	1
929	30	\N	929	0	1
930	1	\N	930	0	1
931	15	\N	931	0	1
932	20	\N	932	0	1
933	18	\N	933	0	1
934	14	\N	934	0	1
935	40	\N	935	0	1
936	33	\N	936	0	1
937	1	\N	937	0	1
938	14	\N	938	0	1
939	38	\N	939	0	1
940	39	\N	940	0	1
941	36	\N	941	0	1
942	8	\N	942	0	1
943	40	\N	943	0	1
944	44	\N	944	0	1
945	38	\N	945	0	1
946	38	\N	946	0	1
947	34	\N	947	0	1
948	26	\N	948	0	1
949	11	\N	949	0	1
950	38	\N	950	0	1
951	47	\N	951	0	1
952	33	\N	952	0	1
953	3	\N	953	0	1
954	16	\N	954	0	1
955	50	\N	955	0	1
956	8	\N	956	0	1
957	38	\N	957	0	1
958	18	\N	958	0	1
959	22	\N	959	0	1
960	30	\N	960	0	1
961	14	\N	961	0	1
962	44	\N	962	0	1
963	24	\N	963	0	1
964	19	\N	964	0	1
965	47	\N	965	0	1
966	35	\N	966	0	1
967	25	\N	967	0	1
968	5	\N	968	0	1
969	28	\N	969	0	1
970	29	\N	970	0	1
971	44	\N	971	0	1
972	17	\N	972	0	1
973	30	\N	973	0	1
974	13	\N	974	0	1
975	41	\N	975	0	1
976	23	\N	976	0	1
977	32	\N	977	0	1
978	40	\N	978	0	1
979	35	\N	979	0	1
980	28	\N	980	0	1
981	49	\N	981	0	1
982	28	\N	982	0	1
983	36	\N	983	0	1
984	20	\N	984	0	1
985	43	\N	985	0	1
986	18	\N	986	0	1
987	45	\N	987	0	1
988	36	\N	988	0	1
989	38	\N	989	0	1
990	40	\N	990	0	1
991	1	\N	991	0	1
992	29	\N	992	0	1
993	32	\N	993	0	1
994	15	\N	994	0	1
995	13	\N	995	0	1
996	15	\N	996	0	1
997	19	\N	997	0	1
998	38	\N	998	0	1
999	45	\N	999	0	1
1000	25	\N	1000	0	1
1001	50	\N	1001	0	1
1002	29	\N	1002	0	1
1003	7	\N	1003	0	1
1004	4	\N	1004	0	1
1005	14	\N	1005	0	1
1006	43	\N	1006	0	1
1007	26	\N	1007	0	1
1008	29	\N	1008	0	1
1009	25	\N	1009	0	1
1010	38	\N	1010	0	1
1011	42	\N	1011	0	1
1012	14	\N	1012	0	1
1013	40	\N	1013	0	1
1014	14	\N	1014	0	1
1015	43	\N	1015	0	1
1016	4	\N	1016	0	1
1017	6	\N	1017	0	1
1018	35	\N	1018	0	1
1019	31	\N	1019	0	1
1020	19	\N	1020	0	1
1021	42	\N	1021	0	1
1022	47	\N	1022	0	1
1023	16	\N	1023	0	1
1024	30	\N	1024	0	1
1025	7	\N	1025	0	1
1026	18	\N	1026	0	1
1027	34	\N	1027	0	1
1028	41	\N	1028	0	1
1029	31	\N	1029	0	1
1030	28	\N	1030	0	1
1031	8	\N	1031	0	1
1032	32	\N	1032	0	1
1033	11	\N	1033	0	1
1034	23	\N	1034	0	1
1035	17	\N	1035	0	1
1036	34	\N	1036	0	1
1037	47	\N	1037	0	1
1038	34	\N	1038	0	1
1039	20	\N	1039	0	1
1040	50	\N	1040	0	1
1041	38	\N	1041	0	1
1042	35	\N	1042	0	1
1043	27	\N	1043	0	1
1044	2	\N	1044	0	1
1045	7	\N	1045	0	1
1046	10	\N	1046	0	1
1047	1	\N	1047	0	1
1048	20	\N	1048	0	1
1049	35	\N	1049	0	1
1050	36	\N	1050	0	1
1051	39	\N	1051	0	1
1052	26	\N	1052	0	1
1053	4	\N	1053	0	1
1054	31	\N	1054	0	1
1055	20	\N	1055	0	1
1056	23	\N	1056	0	1
1057	47	\N	1057	0	1
1058	5	\N	1058	0	1
1059	22	\N	1059	0	1
1060	8	\N	1060	0	1
1061	29	\N	1061	0	1
1062	21	\N	1062	0	1
1063	1	\N	1063	0	1
1064	19	\N	1064	0	1
1065	27	\N	1065	0	1
1066	40	\N	1066	0	1
1067	8	\N	1067	0	1
1068	22	\N	1068	0	1
1069	43	\N	1069	0	1
1070	33	\N	1070	0	1
1071	24	\N	1071	0	1
1072	40	\N	1072	0	1
1073	28	\N	1073	0	1
1074	47	\N	1074	0	1
1075	1	\N	1075	0	1
1076	45	\N	1076	0	1
1077	7	\N	1077	0	1
1078	45	\N	1078	0	1
1079	47	\N	1079	0	1
1080	40	\N	1080	0	1
1081	9	\N	1081	0	1
1082	12	\N	1082	0	1
1083	15	\N	1083	0	1
1084	49	\N	1084	0	1
1085	37	\N	1085	0	1
1086	40	\N	1086	0	1
1087	2	\N	1087	0	1
1088	2	\N	1088	0	1
1089	42	\N	1089	0	1
1090	46	\N	1090	0	1
1091	27	\N	1091	0	1
1092	9	\N	1092	0	1
1093	31	\N	1093	0	1
1094	18	\N	1094	0	1
1095	22	\N	1095	0	1
1096	48	\N	1096	0	1
1097	2	\N	1097	0	1
1098	45	\N	1098	0	1
1099	46	\N	1099	0	1
1100	22	\N	1100	0	1
1101	37	\N	1101	0	1
1102	45	\N	1102	0	1
1103	14	\N	1103	0	1
1104	24	\N	1104	0	1
1105	9	\N	1105	0	1
1106	43	\N	1106	0	1
1107	21	\N	1107	0	1
1108	39	\N	1108	0	1
1109	26	\N	1109	0	1
1110	2	\N	1110	0	1
1111	31	\N	1111	0	1
1112	15	\N	1112	0	1
1113	34	\N	1113	0	1
1114	16	\N	1114	0	1
1115	22	\N	1115	0	1
1116	47	\N	1116	0	1
1117	15	\N	1117	0	1
1118	10	\N	1118	0	1
1119	41	\N	1119	0	1
1120	43	\N	1120	0	1
1121	3	\N	1121	0	1
1122	48	\N	1122	0	1
1123	16	\N	1123	0	1
1124	18	\N	1124	0	1
1125	26	\N	1125	0	1
1126	44	\N	1126	0	1
1127	27	\N	1127	0	1
1128	31	\N	1128	0	1
1129	16	\N	1129	0	1
1130	14	\N	1130	0	1
1131	48	\N	1131	0	1
1132	48	\N	1132	0	1
1133	45	\N	1133	0	1
1134	29	\N	1134	0	1
1135	10	\N	1135	0	1
1136	23	\N	1136	0	1
1137	43	\N	1137	0	1
1138	13	\N	1138	0	1
1139	33	\N	1139	0	1
1140	37	\N	1140	0	1
1141	49	\N	1141	0	1
1142	43	\N	1142	0	1
1143	7	\N	1143	0	1
1144	35	\N	1144	0	1
1145	46	\N	1145	0	1
1146	29	\N	1146	0	1
1147	46	\N	1147	0	1
1148	50	\N	1148	0	1
1149	50	\N	1149	0	1
1150	10	\N	1150	0	1
1151	36	\N	1151	0	1
1152	5	\N	1152	0	1
1153	11	\N	1153	0	1
1154	31	\N	1154	0	1
1155	2	\N	1155	0	1
1156	49	\N	1156	0	1
1157	33	\N	1157	0	1
1158	30	\N	1158	0	1
1159	20	\N	1159	0	1
1160	1	\N	1160	0	1
1161	26	\N	1161	0	1
1162	48	\N	1162	0	1
1163	6	\N	1163	0	1
1164	9	\N	1164	0	1
1165	36	\N	1165	0	1
1166	48	\N	1166	0	1
1167	25	\N	1167	0	1
1168	42	\N	1168	0	1
1169	5	\N	1169	0	1
1170	15	\N	1170	0	1
1171	33	\N	1171	0	1
1172	31	\N	1172	0	1
1173	35	\N	1173	0	1
1174	44	\N	1174	0	1
1175	7	\N	1175	0	1
1176	4	\N	1176	0	1
1177	24	\N	1177	0	1
1178	34	\N	1178	0	1
1179	20	\N	1179	0	1
1180	50	\N	1180	0	1
1181	41	\N	1181	0	1
1182	32	\N	1182	0	1
1183	25	\N	1183	0	1
1184	10	\N	1184	0	1
1185	38	\N	1185	0	1
1186	34	\N	1186	0	1
1187	12	\N	1187	0	1
1188	32	\N	1188	0	1
1189	34	\N	1189	0	1
1190	19	\N	1190	0	1
1191	4	\N	1191	0	1
1192	32	\N	1192	0	1
1193	2	\N	1193	0	1
1194	13	\N	1194	0	1
1195	13	\N	1195	0	1
1196	40	\N	1196	0	1
1197	1	\N	1197	0	1
1198	24	\N	1198	0	1
1199	34	\N	1199	0	1
1200	22	\N	1200	0	1
1201	30	\N	1201	0	1
1202	25	\N	1202	0	1
1203	36	\N	1203	0	1
1204	1	\N	1204	0	1
1205	44	\N	1205	0	1
1206	9	\N	1206	0	1
1207	23	\N	1207	0	1
1208	36	\N	1208	0	1
1209	3	\N	1209	0	1
1210	25	\N	1210	0	1
1211	45	\N	1211	0	1
1212	15	\N	1212	0	1
1213	30	\N	1213	0	1
1214	8	\N	1214	0	1
1215	3	\N	1215	0	1
1216	19	\N	1216	0	1
1217	16	\N	1217	0	1
1218	24	\N	1218	0	1
1219	18	\N	1219	0	1
1220	24	\N	1220	0	1
1221	32	\N	1221	0	1
1222	5	\N	1222	0	1
1223	11	\N	1223	0	1
1224	46	\N	1224	0	1
1225	6	\N	1225	0	1
1226	48	\N	1226	0	1
1227	26	\N	1227	0	1
1228	44	\N	1228	0	1
1229	32	\N	1229	0	1
1230	34	\N	1230	0	1
1231	7	\N	1231	0	1
1232	28	\N	1232	0	1
1233	35	\N	1233	0	1
1234	37	\N	1234	0	1
1235	40	\N	1235	0	1
1236	41	\N	1236	0	1
1237	26	\N	1237	0	1
1238	16	\N	1238	0	1
1239	15	\N	1239	0	1
1240	21	\N	1240	0	1
1241	12	\N	1241	0	1
1242	2	\N	1242	0	1
1243	39	\N	1243	0	1
1244	5	\N	1244	0	1
1245	31	\N	1245	0	1
1246	13	\N	1246	0	1
1247	45	\N	1247	0	1
1248	18	\N	1248	0	1
1249	15	\N	1249	0	1
1250	50	\N	1250	0	1
1251	8	\N	1251	0	1
1252	8	\N	1252	0	1
1253	43	\N	1253	0	1
1254	8	\N	1254	0	1
1255	27	\N	1255	0	1
1256	29	\N	1256	0	1
1257	1	\N	1257	0	1
1258	42	\N	1258	0	1
1259	49	\N	1259	0	1
1260	29	\N	1260	0	1
1261	6	\N	1261	0	1
1262	11	\N	1262	0	1
1263	31	\N	1263	0	1
1264	11	\N	1264	0	1
1265	46	\N	1265	0	1
1266	35	\N	1266	0	1
1267	50	\N	1267	0	1
1268	34	\N	1268	0	1
1269	34	\N	1269	0	1
1270	5	\N	1270	0	1
1271	42	\N	1271	0	1
1272	30	\N	1272	0	1
1273	37	\N	1273	0	1
1274	39	\N	1274	0	1
1275	6	\N	1275	0	1
1276	40	\N	1276	0	1
1277	17	\N	1277	0	1
1278	13	\N	1278	0	1
1279	21	\N	1279	0	1
1280	49	\N	1280	0	1
1281	23	\N	1281	0	1
1282	40	\N	1282	0	1
1283	45	\N	1283	0	1
1284	32	\N	1284	0	1
1285	33	\N	1285	0	1
1286	3	\N	1286	0	1
1287	2	\N	1287	0	1
1288	22	\N	1288	0	1
1289	21	\N	1289	0	1
1290	38	\N	1290	0	1
1291	35	\N	1291	0	1
1292	5	\N	1292	0	1
1293	32	\N	1293	0	1
1294	17	\N	1294	0	1
1295	28	\N	1295	0	1
1296	40	\N	1296	0	1
1297	37	\N	1297	0	1
1298	31	\N	1298	0	1
1299	23	\N	1299	0	1
1300	26	\N	1300	0	1
1301	27	\N	1301	0	1
1302	18	\N	1302	0	1
1303	32	\N	1303	0	1
1304	28	\N	1304	0	1
1305	9	\N	1305	0	1
1306	44	\N	1306	0	1
1307	36	\N	1307	0	1
1308	23	\N	1308	0	1
1309	44	\N	1309	0	1
1310	26	\N	1310	0	1
1311	39	\N	1311	0	1
1312	24	\N	1312	0	1
1313	35	\N	1313	0	1
1314	38	\N	1314	0	1
1315	21	\N	1315	0	1
1316	10	\N	1316	0	1
1317	27	\N	1317	0	1
1318	13	\N	1318	0	1
1319	6	\N	1319	0	1
1320	4	\N	1320	0	1
1321	19	\N	1321	0	1
1322	43	\N	1322	0	1
1323	27	\N	1323	0	1
1324	18	\N	1324	0	1
1325	12	\N	1325	0	1
1326	39	\N	1326	0	1
1327	45	\N	1327	0	1
1328	35	\N	1328	0	1
1329	41	\N	1329	0	1
1330	22	\N	1330	0	1
1331	50	\N	1331	0	1
1332	38	\N	1332	0	1
1333	50	\N	1333	0	1
1334	14	\N	1334	0	1
1335	27	\N	1335	0	1
1336	4	\N	1336	0	1
1337	32	\N	1337	0	1
1338	1	\N	1338	0	1
1339	19	\N	1339	0	1
1340	31	\N	1340	0	1
1341	3	\N	1341	0	1
1342	41	\N	1342	0	1
1343	22	\N	1343	0	1
1344	16	\N	1344	0	1
1345	19	\N	1345	0	1
1346	5	\N	1346	0	1
1347	47	\N	1347	0	1
1348	15	\N	1348	0	1
1349	27	\N	1349	0	1
1350	13	\N	1350	0	1
1351	38	\N	1351	0	1
1352	14	\N	1352	0	1
1353	35	\N	1353	0	1
1354	44	\N	1354	0	1
1355	8	\N	1355	0	1
1356	41	\N	1356	0	1
1357	22	\N	1357	0	1
1358	22	\N	1358	0	1
1359	44	\N	1359	0	1
1360	28	\N	1360	0	1
1361	40	\N	1361	0	1
1362	39	\N	1362	0	1
1363	20	\N	1363	0	1
1364	37	\N	1364	0	1
1365	7	\N	1365	0	1
1366	23	\N	1366	0	1
1367	21	\N	1367	0	1
1368	6	\N	1368	0	1
1369	8	\N	1369	0	1
1370	3	\N	1370	0	1
1371	7	\N	1371	0	1
1372	44	\N	1372	0	1
1373	1	\N	1373	0	1
1374	44	\N	1374	0	1
1375	11	\N	1375	0	1
1376	46	\N	1376	0	1
1377	8	\N	1377	0	1
1378	38	\N	1378	0	1
1379	7	\N	1379	0	1
1380	27	\N	1380	0	1
1381	2	\N	1381	0	1
1382	22	\N	1382	0	1
1383	46	\N	1383	0	1
1384	35	\N	1384	0	1
1385	40	\N	1385	0	1
1386	43	\N	1386	0	1
1387	48	\N	1387	0	1
1388	1	\N	1388	0	1
1389	25	\N	1389	0	1
1390	15	\N	1390	0	1
1391	48	\N	1391	0	1
1392	47	\N	1392	0	1
1393	41	\N	1393	0	1
1394	25	\N	1394	0	1
1395	13	\N	1395	0	1
1396	46	\N	1396	0	1
1397	6	\N	1397	0	1
1398	47	\N	1398	0	1
1399	9	\N	1399	0	1
1400	28	\N	1400	0	1
1401	19	\N	1401	0	1
1402	18	\N	1402	0	1
1403	4	\N	1403	0	1
1404	33	\N	1404	0	1
1405	3	\N	1405	0	1
1406	46	\N	1406	0	1
1407	44	\N	1407	0	1
1408	31	\N	1408	0	1
1409	9	\N	1409	0	1
1410	19	\N	1410	0	1
1411	41	\N	1411	0	1
1412	12	\N	1412	0	1
1413	49	\N	1413	0	1
1414	31	\N	1414	0	1
1415	25	\N	1415	0	1
1416	38	\N	1416	0	1
1417	50	\N	1417	0	1
1418	16	\N	1418	0	1
1419	32	\N	1419	0	1
1420	6	\N	1420	0	1
1421	18	\N	1421	0	1
1422	11	\N	1422	0	1
1423	12	\N	1423	0	1
1424	32	\N	1424	0	1
1425	3	\N	1425	0	1
1426	41	\N	1426	0	1
1427	36	\N	1427	0	1
1428	8	\N	1428	0	1
1429	25	\N	1429	0	1
1430	45	\N	1430	0	1
1431	9	\N	1431	0	1
1432	35	\N	1432	0	1
1433	10	\N	1433	0	1
1434	12	\N	1434	0	1
1435	29	\N	1435	0	1
1436	6	\N	1436	0	1
1437	26	\N	1437	0	1
1438	39	\N	1438	0	1
1439	1	\N	1439	0	1
1440	2	\N	1440	0	1
1441	26	\N	1441	0	1
1442	13	\N	1442	0	1
1443	41	\N	1443	0	1
1444	39	\N	1444	0	1
1445	45	\N	1445	0	1
1446	1	\N	1446	0	1
1447	33	\N	1447	0	1
1448	6	\N	1448	0	1
1449	13	\N	1449	0	1
1450	18	\N	1450	0	1
1451	28	\N	1451	0	1
1452	1	\N	1452	0	1
1453	1	\N	1453	0	1
1454	41	\N	1454	0	1
1455	40	\N	1455	0	1
1456	46	\N	1456	0	1
1457	33	\N	1457	0	1
1458	4	\N	1458	0	1
1459	19	\N	1459	0	1
1460	40	\N	1460	0	1
1461	16	\N	1461	0	1
1462	41	\N	1462	0	1
1463	44	\N	1463	0	1
1464	7	\N	1464	0	1
1465	10	\N	1465	0	1
1466	22	\N	1466	0	1
1467	45	\N	1467	0	1
1468	10	\N	1468	0	1
1469	16	\N	1469	0	1
1470	21	\N	1470	0	1
1471	24	\N	1471	0	1
1472	40	\N	1472	0	1
1473	2	\N	1473	0	1
1474	9	\N	1474	0	1
1475	4	\N	1475	0	1
1476	24	\N	1476	0	1
1477	7	\N	1477	0	1
1478	39	\N	1478	0	1
1479	40	\N	1479	0	1
1480	30	\N	1480	0	1
1481	30	\N	1481	0	1
1482	30	\N	1482	0	1
1483	27	\N	1483	0	1
1484	28	\N	1484	0	1
1485	14	\N	1485	0	1
1486	16	\N	1486	0	1
1487	33	\N	1487	0	1
1488	47	\N	1488	0	1
1489	15	\N	1489	0	1
1490	39	\N	1490	0	1
1491	10	\N	1491	0	1
1492	7	\N	1492	0	1
1493	42	\N	1493	0	1
1494	15	\N	1494	0	1
1495	10	\N	1495	0	1
1496	22	\N	1496	0	1
1497	19	\N	1497	0	1
1498	25	\N	1498	0	1
1499	4	\N	1499	0	1
1500	25	\N	1500	0	1
1501	9	\N	1501	0	1
1502	31	\N	1502	0	1
1503	25	\N	1503	0	1
1504	23	\N	1504	0	1
1505	23	\N	1505	0	1
1506	33	\N	1506	0	1
1507	42	\N	1507	0	1
1508	44	\N	1508	0	1
1509	1	\N	1509	0	1
1510	34	\N	1510	0	1
1511	28	\N	1511	0	1
1512	50	\N	1512	0	1
1513	4	\N	1513	0	1
1514	34	\N	1514	0	1
1515	5	\N	1515	0	1
1516	23	\N	1516	0	1
1517	50	\N	1517	0	1
1518	17	\N	1518	0	1
1519	10	\N	1519	0	1
1520	13	\N	1520	0	1
1521	45	\N	1521	0	1
1522	10	\N	1522	0	1
1523	42	\N	1523	0	1
1524	38	\N	1524	0	1
1525	2	\N	1525	0	1
1526	25	\N	1526	0	1
1527	24	\N	1527	0	1
1528	2	\N	1528	0	1
1529	38	\N	1529	0	1
1530	46	\N	1530	0	1
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
19	UPC	
20	DHL	
21	UPC	
22	DHL	
\.


--
-- Data for Name: shipping_shippingmethodcountry; Type: TABLE DATA; Schema: public; Owner: aa
--

COPY shipping_shippingmethodcountry (id, country_code, price, shipping_method_id) FROM stdin;
1		44.50	1
2		55.88	2
3	DE	34.66	1
4		75.82	3
5		44.29	4
6	PL	77.88	3
7	DE	8.83	2
8		39.31	5
9		98.45	6
10		13.66	7
11		17.12	8
12		43.91	9
13		99.70	10
14		47.21	11
15		74.20	12
16		89.25	13
17		32.28	14
18		75.22	15
19		65.36	16
20		93.60	17
21		83.65	18
22		39.72	19
23		50.40	20
24		54.76	21
25		55.50	22
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

SELECT pg_catalog.setval('auth_permission_id_seq', 175, true);


--
-- Name: cart_cartline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('cart_cartline_id_seq', 8, true);


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

SELECT pg_catalog.setval('django_content_type_id_seq', 47, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('django_migrations_id_seq', 224, true);


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

SELECT pg_catalog.setval('order_deliverygroup_id_seq', 54, true);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_order_id_seq', 54, true);


--
-- Name: order_ordereditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('order_ordereditem_id_seq', 100, true);


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

SELECT pg_catalog.setval('order_payment_id_seq', 40, true);


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

SELECT pg_catalog.setval('product_productimage_id_seq', 1381, true);


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

SELECT pg_catalog.setval('shipping_shippingmethod_id_seq', 22, true);


--
-- Name: shipping_shippingmethodcountry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('shipping_shippingmethodcountry_id_seq', 25, true);


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

SELECT pg_catalog.setval('userprofile_address_id_seq', 226, true);


--
-- Name: userprofile_user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_addresses_id_seq', 187, true);


--
-- Name: userprofile_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_groups_id_seq', 1, false);


--
-- Name: userprofile_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: aa
--

SELECT pg_catalog.setval('userprofile_user_id_seq', 183, true);


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
-- Name: account_address userprofile_address_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_address
    ADD CONSTRAINT userprofile_address_pkey PRIMARY KEY (id);


--
-- Name: account_user_addresses userprofile_user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_addresses
    ADD CONSTRAINT userprofile_user_addresses_pkey PRIMARY KEY (id);


--
-- Name: account_user_addresses userprofile_user_addresses_user_id_address_id_6cb87bcc_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_addresses
    ADD CONSTRAINT userprofile_user_addresses_user_id_address_id_6cb87bcc_uniq UNIQUE (user_id, address_id);


--
-- Name: account_user userprofile_user_email_key; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user
    ADD CONSTRAINT userprofile_user_email_key UNIQUE (email);


--
-- Name: account_user_groups userprofile_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_groups
    ADD CONSTRAINT userprofile_user_groups_pkey PRIMARY KEY (id);


--
-- Name: account_user_groups userprofile_user_groups_user_id_group_id_90ce1781_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_groups
    ADD CONSTRAINT userprofile_user_groups_user_id_group_id_90ce1781_uniq UNIQUE (user_id, group_id);


--
-- Name: account_user userprofile_user_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user
    ADD CONSTRAINT userprofile_user_pkey PRIMARY KEY (id);


--
-- Name: account_user_user_permissions userprofile_user_user_pe_user_id_permission_id_706d65c8_uniq; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_user_permissions
    ADD CONSTRAINT userprofile_user_user_pe_user_id_permission_id_706d65c8_uniq UNIQUE (user_id, permission_id);


--
-- Name: account_user_user_permissions userprofile_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_user_permissions
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
-- Name: product_pro_name_5bb6fa_gin; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX product_pro_name_5bb6fa_gin ON product_product USING gin (name, description);


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

CREATE INDEX userprofile_user_addresses_address_id_ad7646b4 ON account_user_addresses USING btree (address_id);


--
-- Name: userprofile_user_addresses_user_id_bb5aa55e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_addresses_user_id_bb5aa55e ON account_user_addresses USING btree (user_id);


--
-- Name: userprofile_user_default_billing_address_id_0489abf1; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_default_billing_address_id_0489abf1 ON account_user USING btree (default_billing_address_id);


--
-- Name: userprofile_user_default_shipping_address_id_aae7a203; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_default_shipping_address_id_aae7a203 ON account_user USING btree (default_shipping_address_id);


--
-- Name: userprofile_user_email_b0fb0137_like; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_email_b0fb0137_like ON account_user USING btree (email varchar_pattern_ops);


--
-- Name: userprofile_user_groups_group_id_c7eec74e; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_groups_group_id_c7eec74e ON account_user_groups USING btree (group_id);


--
-- Name: userprofile_user_groups_user_id_5e712a24; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_groups_user_id_5e712a24 ON account_user_groups USING btree (user_id);


--
-- Name: userprofile_user_user_permissions_permission_id_1caa8a71; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_user_permissions_permission_id_1caa8a71 ON account_user_user_permissions USING btree (permission_id);


--
-- Name: userprofile_user_user_permissions_user_id_6d654469; Type: INDEX; Schema: public; Owner: aa
--

CREATE INDEX userprofile_user_user_permissions_user_id_6d654469 ON account_user_user_permissions USING btree (user_id);


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
-- Name: cart_cart cart_cart_user_id_9b4220b9_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY cart_cart
    ADD CONSTRAINT cart_cart_user_id_9b4220b9_fk_account_user_id FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT impersonate_imperson_impersonating_id_afd114fc_fk_userprofi FOREIGN KEY (impersonating_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: impersonate_impersonationlog impersonate_imperson_impersonator_id_1ecfe8ce_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY impersonate_impersonationlog
    ADD CONSTRAINT impersonate_imperson_impersonator_id_1ecfe8ce_fk_userprofi FOREIGN KEY (impersonator_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_deliverygroup order_deliverygroup_order_id_9fdf192e_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_deliverygroup
    ADD CONSTRAINT order_deliverygroup_order_id_9fdf192e_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_billing_address_id_8fe537cf_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_billing_address_id_8fe537cf_fk_userprofi FOREIGN KEY (billing_address_id) REFERENCES account_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_shipping_address_id_57e64931_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_shipping_address_id_57e64931_fk_userprofi FOREIGN KEY (shipping_address_id) REFERENCES account_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_user_id_7cf9bc2b_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_user_id_7cf9bc2b_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT order_orderhistoryentry_user_id_1070bf50_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote order_ordernote_order_id_7d97583d_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_order_id_7d97583d_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote order_ordernote_user_id_48d7a672_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_user_id_48d7a672_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


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
    ADD CONSTRAINT social_auth_usersoci_user_id_17d28448_fk_userprofi FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_addresses userprofile_user_add_address_id_ad7646b4_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_addresses
    ADD CONSTRAINT userprofile_user_add_address_id_ad7646b4_fk_userprofi FOREIGN KEY (address_id) REFERENCES account_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_addresses userprofile_user_add_user_id_bb5aa55e_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_addresses
    ADD CONSTRAINT userprofile_user_add_user_id_bb5aa55e_fk_userprofi FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user userprofile_user_default_billing_addr_0489abf1_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user
    ADD CONSTRAINT userprofile_user_default_billing_addr_0489abf1_fk_userprofi FOREIGN KEY (default_billing_address_id) REFERENCES account_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user userprofile_user_default_shipping_add_aae7a203_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user
    ADD CONSTRAINT userprofile_user_default_shipping_add_aae7a203_fk_userprofi FOREIGN KEY (default_shipping_address_id) REFERENCES account_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_groups
    ADD CONSTRAINT userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups userprofile_user_groups_user_id_5e712a24_fk_userprofile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_groups
    ADD CONSTRAINT userprofile_user_groups_user_id_5e712a24_fk_userprofile_user_id FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions userprofile_user_use_permission_id_1caa8a71_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_user_permissions
    ADD CONSTRAINT userprofile_user_use_permission_id_1caa8a71_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions userprofile_user_use_user_id_6d654469_fk_userprofi; Type: FK CONSTRAINT; Schema: public; Owner: aa
--

ALTER TABLE ONLY account_user_user_permissions
    ADD CONSTRAINT userprofile_user_use_user_id_6d654469_fk_userprofi FOREIGN KEY (user_id) REFERENCES account_user(id) DEFERRABLE INITIALLY DEFERRED;


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

