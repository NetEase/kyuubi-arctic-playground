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

SET source_schema=tpch.tiny;
SET target_schema=arctic.tpch_tiny;

CREATE DATABASE IF NOT EXISTS ${target_schema};

USE ${target_schema};

--
-- Name: customer; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS customer AS SELECT * FROM ${source_schema}.customer;

--
-- Name: orders; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS orders AS SELECT * FROM ${source_schema}.orders;

--
-- Name: lineitem; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS lineitem AS SELECT * FROM ${source_schema}.lineitem;

--
-- Name: part; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS part AS SELECT * FROM ${source_schema}.part;

--
-- Name: partsupp; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS partsupp AS SELECT * FROM ${source_schema}.partsupp;

--
-- Name: supplier; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS supplier AS SELECT * FROM ${source_schema}.supplier;

--
-- Name: nation; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS nation AS SELECT * FROM ${source_schema}.nation;

--
-- Name: region; Type: TABLE; Tablespace:
--
CREATE TABLE IF NOT EXISTS region AS SELECT * FROM ${source_schema}.region;
