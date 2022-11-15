-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

SET source_schema=tpcds.tiny;

SET target_schema=arctic.tpcds_tiny;

CREATE DATABASE IF NOT EXISTS ${target_schema};

USE ${target_schema};

--
-- Name: catalog_sales; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS catalog_sales PARTITIONED BY (cs_sold_date_sk)
AS SELECT * FROM ${source_schema}.catalog_sales;

--
-- Name: catalog_returns; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS catalog_returns PARTITIONED BY (cr_returned_date_sk)
AS SELECT * FROM ${source_schema}.catalog_returns;

--
-- Name: inventory; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS inventory PARTITIONED BY (inv_date_sk)
AS SELECT * FROM ${source_schema}.inventory;

--
-- Name: store_sales; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS store_sales PARTITIONED BY (ss_sold_date_sk)
AS SELECT * FROM ${source_schema}.store_sales;

--
-- Name: store_returns; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS store_returns PARTITIONED BY (sr_returned_date_sk)
AS SELECT * FROM ${source_schema}.store_returns;

--
-- Name: web_sales; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS web_sales PARTITIONED BY (ws_sold_date_sk)
AS SELECT * FROM ${source_schema}.web_sales;

--
-- Name: web_returns; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS web_returns PARTITIONED BY (wr_returned_date_sk)
AS SELECT * FROM ${source_schema}.web_returns;

--
-- Name: call_center; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS call_center AS SELECT * FROM ${source_schema}.call_center;

--
-- Name: catalog_page; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS catalog_page AS SELECT * FROM ${source_schema}.catalog_page;

--
-- Name: customer; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS customer AS SELECT * FROM ${source_schema}.customer;

--
-- Name: customer_address; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS customer_address AS SELECT * FROM ${source_schema}.customer_address;

--
-- Name: customer_demographics; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS customer_demographics AS SELECT * FROM ${source_schema}.customer_demographics;

--
-- Name: date_dim; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS date_dim AS SELECT * FROM ${source_schema}.date_dim;

--
-- Name: household_demographics; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS household_demographics AS SELECT * FROM ${source_schema}.household_demographics;

--
-- Name: income_band; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS income_band AS SELECT * FROM ${source_schema}.income_band;

--
-- Name: item; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS item AS SELECT * FROM ${source_schema}.item;

--
-- Name: promotion; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS promotion AS SELECT * FROM ${source_schema}.promotion;

--
-- Name: reason; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS reason AS SELECT * FROM ${source_schema}.reason;

--
-- Name: ship_mode; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS ship_mode AS SELECT * FROM ${source_schema}.ship_mode;

--
-- Name: store; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS store AS SELECT * FROM ${source_schema}.store;

--
-- Name: time_dim; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS time_dim AS SELECT * FROM ${source_schema}.time_dim;

--
-- Name: warehouse; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS warehouse AS SELECT * FROM ${source_schema}.warehouse;

--
-- Name: web_page; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS web_page AS SELECT * FROM ${source_schema}.web_page;

--
-- Name: web_site; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS web_site AS SELECT * FROM ${source_schema}.web_site;
