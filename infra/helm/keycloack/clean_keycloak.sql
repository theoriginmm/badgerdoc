--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
35c524ca-05b6-456c-8adc-a5f87be9d4a7	91361fa4-165c-4f4f-b094-d9dd57aeedba
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
8e231125-c7ba-40a2-907f-14bbb95bd550	\N	auth-cookie	master	4d6814b7-cce8-4207-96d9-27ac309e072a	2	10	f	\N	\N
8a9d02c9-a84b-4baf-9730-4514d1cb4032	\N	auth-spnego	master	4d6814b7-cce8-4207-96d9-27ac309e072a	3	20	f	\N	\N
c52f70eb-9d32-42bc-b0a0-779731f9cd9c	\N	identity-provider-redirector	master	4d6814b7-cce8-4207-96d9-27ac309e072a	2	25	f	\N	\N
38e5802d-4f7a-4822-bc56-e5846708a4f2	\N	\N	master	4d6814b7-cce8-4207-96d9-27ac309e072a	2	30	t	97360599-39ec-4b26-af85-9f216ca45557	\N
6e5b811b-65aa-455c-a5ba-02a65cef3096	\N	auth-username-password-form	master	97360599-39ec-4b26-af85-9f216ca45557	0	10	f	\N	\N
04fb4956-ed86-4443-be24-d005ad1d3293	\N	\N	master	97360599-39ec-4b26-af85-9f216ca45557	1	20	t	76862345-7d8f-4bd8-b276-3e2e8fa0053a	\N
7b59f76a-67fa-44c8-87c7-1705117d003c	\N	conditional-user-configured	master	76862345-7d8f-4bd8-b276-3e2e8fa0053a	0	10	f	\N	\N
8f11760b-3ef6-4e18-a5cb-855ad1db8215	\N	auth-otp-form	master	76862345-7d8f-4bd8-b276-3e2e8fa0053a	0	20	f	\N	\N
1afd4951-79e4-40aa-85fd-5dcc5ee33563	\N	direct-grant-validate-username	master	78c2df8f-884f-4b75-b0d5-a6bb315bddf5	0	10	f	\N	\N
2766d9a9-5f77-4529-811d-ded01281d054	\N	direct-grant-validate-password	master	78c2df8f-884f-4b75-b0d5-a6bb315bddf5	0	20	f	\N	\N
b25d6442-5375-4111-881c-5849f48a05a3	\N	\N	master	78c2df8f-884f-4b75-b0d5-a6bb315bddf5	1	30	t	648ccb93-c34f-4ba6-8a11-7ea23185eb6f	\N
ac439411-8f9c-4703-b0ee-df7d0226ffee	\N	conditional-user-configured	master	648ccb93-c34f-4ba6-8a11-7ea23185eb6f	0	10	f	\N	\N
586e85cb-2a74-46f6-b976-94d691cd073b	\N	direct-grant-validate-otp	master	648ccb93-c34f-4ba6-8a11-7ea23185eb6f	0	20	f	\N	\N
cb269647-3c94-4080-a4d9-c3d873b0ce48	\N	registration-page-form	master	7a700a4e-725c-4248-9571-73ec05c5e75d	0	10	t	28602996-10b0-4d9b-a983-b0a8d2dfb73c	\N
efc8c3cf-eaca-40bb-a911-4f62ec63535e	\N	registration-user-creation	master	28602996-10b0-4d9b-a983-b0a8d2dfb73c	0	20	f	\N	\N
98853996-575a-4e3e-abe5-6a2d32842821	\N	registration-profile-action	master	28602996-10b0-4d9b-a983-b0a8d2dfb73c	0	40	f	\N	\N
7bbf86e3-4a8d-4eb7-b399-5ff39aefc8fc	\N	registration-password-action	master	28602996-10b0-4d9b-a983-b0a8d2dfb73c	0	50	f	\N	\N
42bde6c9-30cc-4aeb-a58c-b4c841824d82	\N	registration-recaptcha-action	master	28602996-10b0-4d9b-a983-b0a8d2dfb73c	3	60	f	\N	\N
af7d668a-15c2-4882-b56d-0fe69849d6b7	\N	reset-credentials-choose-user	master	5596137b-0b93-4603-9aed-2fe26232c2ec	0	10	f	\N	\N
5e353c0b-db62-4968-b9e5-d4aa43fd0abd	\N	reset-credential-email	master	5596137b-0b93-4603-9aed-2fe26232c2ec	0	20	f	\N	\N
d8f99083-c0dd-419c-9ac0-79a0e90535b0	\N	reset-password	master	5596137b-0b93-4603-9aed-2fe26232c2ec	0	30	f	\N	\N
b4cee2a4-123a-42b3-b6ba-76d7745d25e9	\N	\N	master	5596137b-0b93-4603-9aed-2fe26232c2ec	1	40	t	bcc09430-8685-441e-8d23-c4e4a2ed2859	\N
cb2be38c-d86b-44e6-8532-b2616d84878f	\N	conditional-user-configured	master	bcc09430-8685-441e-8d23-c4e4a2ed2859	0	10	f	\N	\N
493cb209-c1e7-48bb-b150-1e8fc19111eb	\N	reset-otp	master	bcc09430-8685-441e-8d23-c4e4a2ed2859	0	20	f	\N	\N
55663d85-8fd9-4573-967a-0b3485015c69	\N	client-secret	master	25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	2	10	f	\N	\N
92970504-e54c-4060-9289-4591a5816a2f	\N	client-jwt	master	25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	2	20	f	\N	\N
dffeb0b9-768b-4d14-b70e-39633183edad	\N	client-secret-jwt	master	25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	2	30	f	\N	\N
a7983b6e-1dee-43f7-96a8-8093cfb5e261	\N	client-x509	master	25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	2	40	f	\N	\N
120844bc-5fb7-4d98-8a3f-a1367afd6d3f	\N	idp-review-profile	master	b5ac78f3-30d1-4e6c-b9eb-337e0947eb1c	0	10	f	\N	4b3c722e-112a-4287-918e-ec2491ec910e
c017a683-1ce3-41f9-a4d6-56146dee286d	\N	\N	master	b5ac78f3-30d1-4e6c-b9eb-337e0947eb1c	0	20	t	a16876e3-a66a-4758-9613-85efdf77aee0	\N
5273cd13-390f-415e-b9f2-eb3283891025	\N	idp-create-user-if-unique	master	a16876e3-a66a-4758-9613-85efdf77aee0	2	10	f	\N	9ecf097a-1584-4359-a14f-6205e9344eec
4ef116fc-1113-49e9-9c44-8808988a082d	\N	\N	master	a16876e3-a66a-4758-9613-85efdf77aee0	2	20	t	8bfcdcb8-de4c-4c16-8536-e8baa3932ccc	\N
c8df86ba-712b-4bad-a22c-9016ffa7468b	\N	idp-confirm-link	master	8bfcdcb8-de4c-4c16-8536-e8baa3932ccc	0	10	f	\N	\N
3fc6be2b-8b44-4009-81f6-c488f176b9e6	\N	\N	master	8bfcdcb8-de4c-4c16-8536-e8baa3932ccc	0	20	t	d9fb68f0-d731-40f1-a7d1-f15a3841bbb8	\N
5d2d626f-26d5-49d4-8d34-c94f2d43dd74	\N	idp-email-verification	master	d9fb68f0-d731-40f1-a7d1-f15a3841bbb8	2	10	f	\N	\N
1232b119-676c-4bb5-95c4-06209a6a4270	\N	\N	master	d9fb68f0-d731-40f1-a7d1-f15a3841bbb8	2	20	t	4fe6bb0a-adc6-4616-9bae-462330768d96	\N
836e034b-9354-41f7-abf6-3c7c4bdd2cce	\N	idp-username-password-form	master	4fe6bb0a-adc6-4616-9bae-462330768d96	0	10	f	\N	\N
0bde11bf-4f02-4f2f-8cce-428947348a48	\N	\N	master	4fe6bb0a-adc6-4616-9bae-462330768d96	1	20	t	80f886ff-a6f7-4978-8800-762c891e07ed	\N
9a3cd38f-273a-4b66-89f4-fcf8c543e541	\N	conditional-user-configured	master	80f886ff-a6f7-4978-8800-762c891e07ed	0	10	f	\N	\N
9d472d78-8c20-441e-b367-b358e696574d	\N	auth-otp-form	master	80f886ff-a6f7-4978-8800-762c891e07ed	0	20	f	\N	\N
5de8d35a-39d9-4320-9c60-b61ad8ec3ec0	\N	http-basic-authenticator	master	db278829-7622-4017-bd8f-a54d7f0d5358	0	10	f	\N	\N
de5647ba-61fb-4ccf-8252-dc818e385ce7	\N	docker-http-basic-authenticator	master	49ec3cd3-050b-45e4-88bb-24ad6b4a4eb2	0	10	f	\N	\N
1a9547f2-5ce0-4af9-a815-da13ce751992	\N	no-cookie-redirect	master	6da9588a-d9cf-4882-b77b-4762a2decb37	0	10	f	\N	\N
f526e880-fa07-4d9e-93e5-7d3b34b44a19	\N	\N	master	6da9588a-d9cf-4882-b77b-4762a2decb37	0	20	t	6d5e717f-2f25-4aad-962c-36439f87a1ba	\N
0f7466b7-3ece-4e97-9fe6-7f805778b96f	\N	basic-auth	master	6d5e717f-2f25-4aad-962c-36439f87a1ba	0	10	f	\N	\N
11ca5d07-1c7d-4dc4-a598-83a2e759da04	\N	basic-auth-otp	master	6d5e717f-2f25-4aad-962c-36439f87a1ba	3	20	f	\N	\N
19312a2b-8541-4e75-9ef1-8da5df119ab6	\N	auth-spnego	master	6d5e717f-2f25-4aad-962c-36439f87a1ba	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
4d6814b7-cce8-4207-96d9-27ac309e072a	browser	browser based authentication	master	basic-flow	t	t
97360599-39ec-4b26-af85-9f216ca45557	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
76862345-7d8f-4bd8-b276-3e2e8fa0053a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
78c2df8f-884f-4b75-b0d5-a6bb315bddf5	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
648ccb93-c34f-4ba6-8a11-7ea23185eb6f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
7a700a4e-725c-4248-9571-73ec05c5e75d	registration	registration flow	master	basic-flow	t	t
28602996-10b0-4d9b-a983-b0a8d2dfb73c	registration form	registration form	master	form-flow	f	t
5596137b-0b93-4603-9aed-2fe26232c2ec	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
bcc09430-8685-441e-8d23-c4e4a2ed2859	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	clients	Base authentication for clients	master	client-flow	t	t
b5ac78f3-30d1-4e6c-b9eb-337e0947eb1c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
a16876e3-a66a-4758-9613-85efdf77aee0	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
8bfcdcb8-de4c-4c16-8536-e8baa3932ccc	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
d9fb68f0-d731-40f1-a7d1-f15a3841bbb8	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
4fe6bb0a-adc6-4616-9bae-462330768d96	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
80f886ff-a6f7-4978-8800-762c891e07ed	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
db278829-7622-4017-bd8f-a54d7f0d5358	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
49ec3cd3-050b-45e4-88bb-24ad6b4a4eb2	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
6da9588a-d9cf-4882-b77b-4762a2decb37	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
6d5e717f-2f25-4aad-962c-36439f87a1ba	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
4b3c722e-112a-4287-918e-ec2491ec910e	review profile config	master
9ecf097a-1584-4359-a14f-6205e9344eec	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
4b3c722e-112a-4287-918e-ec2491ec910e	missing	update.profile.on.first.login
9ecf097a-1584-4359-a14f-6205e9344eec	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
61fb0d41-9851-4ec5-bd7d-04552647b871	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4ad82c3f-04b6-4d59-826a-e5441fa906dc	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b1fae7fb-0d86-403d-85f1-398a0af8acd4	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	t	t	teststset	0	t	\N	\N	f	\N	f	master	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
05555d1d-ae31-4af1-aa65-aedd0620af0a	t	t	BadgerDoc	0	f	58f14c39-3afa-4bfe-9bf9-86250f854a0a	\N	f	\N	f	master	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	t	t	f
c121f7e1-3149-4772-9e37-059206f16a79	t	f	master-realm	0	f	149ea871-ced4-4672-a9be-3fe3502afb3e	\N	f	\N	f	master	openid-connect	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	t	f
30fa1ffa-2370-4a2e-a12c-f7477f915628	t	t	pipelines	0	f	086e88d5-0f8a-48aa-9116-0f13cb753b28	\N	f	\N	f	master	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	d2ec2be2-b977-4fcf-b242-97586929ffab	f	f	t	f
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-jwt	\N	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	S256	pkce.code.challenge.method
4ad82c3f-04b6-4d59-826a-e5441fa906dc	S256	pkce.code.challenge.method
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	true	backchannel.logout.session.required
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	false	backchannel.logout.revoke.offline.tokens
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.assertion.signature
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	id.token.as.detached.signature
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.multivalued.roles
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.force.post.binding
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.encrypt
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	oauth2.device.authorization.grant.enabled
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	backchannel.logout.revoke.offline.tokens
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.server.signature
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.server.signature.keyinfo.ext
05555d1d-ae31-4af1-aa65-aedd0620af0a	true	use.refresh.tokens
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	exclude.session.state.from.auth.response
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	oidc.ciba.grant.enabled
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.artifact.binding
05555d1d-ae31-4af1-aa65-aedd0620af0a	true	backchannel.logout.session.required
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	client_credentials.use_refresh_token
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml_force_name_id_format
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.client.signature
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	tls.client.certificate.bound.access.tokens
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	require.pushed.authorization.requests
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.authnstatement
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	display.on.consent.screen
05555d1d-ae31-4af1-aa65-aedd0620af0a	false	saml.onetimeuse.condition
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.artifact.binding
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.server.signature
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.server.signature.keyinfo.ext
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.assertion.signature
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.client.signature
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.encrypt
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.authnstatement
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.onetimeuse.condition
c121f7e1-3149-4772-9e37-059206f16a79	false	saml_force_name_id_format
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.multivalued.roles
c121f7e1-3149-4772-9e37-059206f16a79	false	saml.force.post.binding
c121f7e1-3149-4772-9e37-059206f16a79	false	exclude.session.state.from.auth.response
c121f7e1-3149-4772-9e37-059206f16a79	false	oauth2.device.authorization.grant.enabled
c121f7e1-3149-4772-9e37-059206f16a79	false	oidc.ciba.grant.enabled
c121f7e1-3149-4772-9e37-059206f16a79	true	use.refresh.tokens
c121f7e1-3149-4772-9e37-059206f16a79	false	id.token.as.detached.signature
c121f7e1-3149-4772-9e37-059206f16a79	false	tls.client.certificate.bound.access.tokens
c121f7e1-3149-4772-9e37-059206f16a79	false	require.pushed.authorization.requests
c121f7e1-3149-4772-9e37-059206f16a79	false	client_credentials.use_refresh_token
c121f7e1-3149-4772-9e37-059206f16a79	false	display.on.consent.screen
c121f7e1-3149-4772-9e37-059206f16a79	false	backchannel.logout.session.required
c121f7e1-3149-4772-9e37-059206f16a79	false	backchannel.logout.revoke.offline.tokens
30fa1ffa-2370-4a2e-a12c-f7477f915628	true	backchannel.logout.session.required
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	backchannel.logout.revoke.offline.tokens
30fa1ffa-2370-4a2e-a12c-f7477f915628	MIICoTCCAYkCBgF/MK6RWDANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAlwaXBlbGluZXMwHhcNMjIwMjI1MTEzODQxWhcNMzIwMjI1MTE0MDIxWjAUMRIwEAYDVQQDDAlwaXBlbGluZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCNlS+DfHNIHmshLWfytiq5Od3wBVvX9IXZNB5/HfhCugi49yCbul+Z/ZwPn3GapwBg5URS1e/aJ7/ZMzt0W94GAi9HJFwX4GxdWQqJk5rNDv9XYu0y6vmUfznUDnkgLg6K/RvGrwjfs3EXctEjOIMNiCg8H2QoAZWLB0pXrQKpSEQlBOEcDM2El/ZrV8W2BUYOkU16IaSiW42ZIpk8hfebmDFpktCXRN7vWFpz94jo1zxIptV5TGbfEY5mDoJ3CuJY7LYe6mJCMlmVrSQNHFRD5VR0LI22EaUW86/mappVUz1ycXFNzGo+I0ilDQ9m+ubr/a8Nvi6lqO87JmvJuUkJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHFVXYBjDor+H81rIKIQg9e2wlWdba5OqcbYg/D9DmPB4UGReeeeMQmUjPkE0/3uQKEAyIyfZoERAmBEV0m4v4QdLYrdWkYZt+qxEdR+dMBtrW2tM7CF2dn5JMs7Lh3/fIBv7FqRYB2Fn/5GEWfwsNrtEnIbn73LjboR0MxMhW+jjsVuIUkiVMyH+nF52ZwzaJIjufbfR03xIMnJSgjf/afyrAiKQEI4XmSicxFo2rChFGxSNOO1GapJNaxC0/fprvylSTpHz3xhei1cvQrUJsrezyatY0wtx9IZhLnFIvEaYcwdJ4ehdByjOlCf+LTUsnGuuygWxXrjFKFZQ/7rQMU=	jwt.credential.certificate
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.artifact.binding
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.server.signature
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.server.signature.keyinfo.ext
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.assertion.signature
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.client.signature
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.encrypt
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.authnstatement
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.onetimeuse.condition
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml_force_name_id_format
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.multivalued.roles
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	saml.force.post.binding
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	exclude.session.state.from.auth.response
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	oauth2.device.authorization.grant.enabled
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	oidc.ciba.grant.enabled
30fa1ffa-2370-4a2e-a12c-f7477f915628	true	use.refresh.tokens
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	id.token.as.detached.signature
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	tls.client.certificate.bound.access.tokens
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	require.pushed.authorization.requests
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	client_credentials.use_refresh_token
30fa1ffa-2370-4a2e-a12c-f7477f915628	false	display.on.consent.screen
30fa1ffa-2370-4a2e-a12c-f7477f915628	HS256	token.endpoint.auth.signing.alg
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
d9eb452d-6796-4b6d-a30c-735640838b1b	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
1efeb38a-b04e-4c99-8c7a-f030f5cf8e71	role_list	master	SAML role list	saml
562295a8-a71d-48d6-864a-afde6eaa1c57	profile	master	OpenID Connect built-in scope: profile	openid-connect
3418d9c3-1714-40a3-acff-a954be89f636	email	master	OpenID Connect built-in scope: email	openid-connect
50ad4be1-ff47-4eec-bf13-57e20a52947f	address	master	OpenID Connect built-in scope: address	openid-connect
9a79fbda-0d54-401b-b04c-19aa2e376f87	phone	master	OpenID Connect built-in scope: phone	openid-connect
d1a81543-75f8-400a-abe5-e922ec87ad43	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
d1a68d5e-34c1-492c-ba0e-278f31343166	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3c2accb2-199d-4bc7-b604-aa6709e31974	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
d9eb452d-6796-4b6d-a30c-735640838b1b	true	display.on.consent.screen
d9eb452d-6796-4b6d-a30c-735640838b1b	${offlineAccessScopeConsentText}	consent.screen.text
1efeb38a-b04e-4c99-8c7a-f030f5cf8e71	true	display.on.consent.screen
1efeb38a-b04e-4c99-8c7a-f030f5cf8e71	${samlRoleListScopeConsentText}	consent.screen.text
562295a8-a71d-48d6-864a-afde6eaa1c57	true	display.on.consent.screen
562295a8-a71d-48d6-864a-afde6eaa1c57	${profileScopeConsentText}	consent.screen.text
562295a8-a71d-48d6-864a-afde6eaa1c57	true	include.in.token.scope
3418d9c3-1714-40a3-acff-a954be89f636	true	display.on.consent.screen
3418d9c3-1714-40a3-acff-a954be89f636	${emailScopeConsentText}	consent.screen.text
3418d9c3-1714-40a3-acff-a954be89f636	true	include.in.token.scope
50ad4be1-ff47-4eec-bf13-57e20a52947f	true	display.on.consent.screen
50ad4be1-ff47-4eec-bf13-57e20a52947f	${addressScopeConsentText}	consent.screen.text
50ad4be1-ff47-4eec-bf13-57e20a52947f	true	include.in.token.scope
9a79fbda-0d54-401b-b04c-19aa2e376f87	true	display.on.consent.screen
9a79fbda-0d54-401b-b04c-19aa2e376f87	${phoneScopeConsentText}	consent.screen.text
9a79fbda-0d54-401b-b04c-19aa2e376f87	true	include.in.token.scope
d1a81543-75f8-400a-abe5-e922ec87ad43	true	display.on.consent.screen
d1a81543-75f8-400a-abe5-e922ec87ad43	${rolesScopeConsentText}	consent.screen.text
d1a81543-75f8-400a-abe5-e922ec87ad43	false	include.in.token.scope
d1a68d5e-34c1-492c-ba0e-278f31343166	false	display.on.consent.screen
d1a68d5e-34c1-492c-ba0e-278f31343166		consent.screen.text
d1a68d5e-34c1-492c-ba0e-278f31343166	false	include.in.token.scope
3c2accb2-199d-4bc7-b604-aa6709e31974	false	display.on.consent.screen
3c2accb2-199d-4bc7-b604-aa6709e31974	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
61fb0d41-9851-4ec5-bd7d-04552647b871	562295a8-a71d-48d6-864a-afde6eaa1c57	t
61fb0d41-9851-4ec5-bd7d-04552647b871	3418d9c3-1714-40a3-acff-a954be89f636	t
61fb0d41-9851-4ec5-bd7d-04552647b871	d1a81543-75f8-400a-abe5-e922ec87ad43	t
61fb0d41-9851-4ec5-bd7d-04552647b871	d1a68d5e-34c1-492c-ba0e-278f31343166	t
61fb0d41-9851-4ec5-bd7d-04552647b871	3c2accb2-199d-4bc7-b604-aa6709e31974	f
61fb0d41-9851-4ec5-bd7d-04552647b871	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
61fb0d41-9851-4ec5-bd7d-04552647b871	d9eb452d-6796-4b6d-a30c-735640838b1b	f
61fb0d41-9851-4ec5-bd7d-04552647b871	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	562295a8-a71d-48d6-864a-afde6eaa1c57	t
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	3418d9c3-1714-40a3-acff-a954be89f636	t
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	d1a81543-75f8-400a-abe5-e922ec87ad43	t
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	d1a68d5e-34c1-492c-ba0e-278f31343166	t
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	3c2accb2-199d-4bc7-b604-aa6709e31974	f
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	d9eb452d-6796-4b6d-a30c-735640838b1b	f
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
b1fae7fb-0d86-403d-85f1-398a0af8acd4	562295a8-a71d-48d6-864a-afde6eaa1c57	t
b1fae7fb-0d86-403d-85f1-398a0af8acd4	3418d9c3-1714-40a3-acff-a954be89f636	t
b1fae7fb-0d86-403d-85f1-398a0af8acd4	d1a81543-75f8-400a-abe5-e922ec87ad43	t
b1fae7fb-0d86-403d-85f1-398a0af8acd4	d1a68d5e-34c1-492c-ba0e-278f31343166	t
b1fae7fb-0d86-403d-85f1-398a0af8acd4	3c2accb2-199d-4bc7-b604-aa6709e31974	f
b1fae7fb-0d86-403d-85f1-398a0af8acd4	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
b1fae7fb-0d86-403d-85f1-398a0af8acd4	d9eb452d-6796-4b6d-a30c-735640838b1b	f
b1fae7fb-0d86-403d-85f1-398a0af8acd4	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	562295a8-a71d-48d6-864a-afde6eaa1c57	t
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	3418d9c3-1714-40a3-acff-a954be89f636	t
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	d1a81543-75f8-400a-abe5-e922ec87ad43	t
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	d1a68d5e-34c1-492c-ba0e-278f31343166	t
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	3c2accb2-199d-4bc7-b604-aa6709e31974	f
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	d9eb452d-6796-4b6d-a30c-735640838b1b	f
e0af2cc2-218e-4ead-8d8c-bbc998ab667c	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
c121f7e1-3149-4772-9e37-059206f16a79	562295a8-a71d-48d6-864a-afde6eaa1c57	t
c121f7e1-3149-4772-9e37-059206f16a79	3418d9c3-1714-40a3-acff-a954be89f636	t
c121f7e1-3149-4772-9e37-059206f16a79	d1a81543-75f8-400a-abe5-e922ec87ad43	t
c121f7e1-3149-4772-9e37-059206f16a79	d1a68d5e-34c1-492c-ba0e-278f31343166	t
c121f7e1-3149-4772-9e37-059206f16a79	3c2accb2-199d-4bc7-b604-aa6709e31974	f
c121f7e1-3149-4772-9e37-059206f16a79	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
c121f7e1-3149-4772-9e37-059206f16a79	d9eb452d-6796-4b6d-a30c-735640838b1b	f
c121f7e1-3149-4772-9e37-059206f16a79	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
4ad82c3f-04b6-4d59-826a-e5441fa906dc	562295a8-a71d-48d6-864a-afde6eaa1c57	t
4ad82c3f-04b6-4d59-826a-e5441fa906dc	3418d9c3-1714-40a3-acff-a954be89f636	t
4ad82c3f-04b6-4d59-826a-e5441fa906dc	d1a81543-75f8-400a-abe5-e922ec87ad43	t
4ad82c3f-04b6-4d59-826a-e5441fa906dc	d1a68d5e-34c1-492c-ba0e-278f31343166	t
4ad82c3f-04b6-4d59-826a-e5441fa906dc	3c2accb2-199d-4bc7-b604-aa6709e31974	f
4ad82c3f-04b6-4d59-826a-e5441fa906dc	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
4ad82c3f-04b6-4d59-826a-e5441fa906dc	d9eb452d-6796-4b6d-a30c-735640838b1b	f
4ad82c3f-04b6-4d59-826a-e5441fa906dc	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	562295a8-a71d-48d6-864a-afde6eaa1c57	t
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	3418d9c3-1714-40a3-acff-a954be89f636	t
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	d1a81543-75f8-400a-abe5-e922ec87ad43	t
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	d1a68d5e-34c1-492c-ba0e-278f31343166	t
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	3c2accb2-199d-4bc7-b604-aa6709e31974	f
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	d9eb452d-6796-4b6d-a30c-735640838b1b	f
9aeef1a0-55dd-49de-b88e-f392cfdc1c19	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
30fa1ffa-2370-4a2e-a12c-f7477f915628	562295a8-a71d-48d6-864a-afde6eaa1c57	t
30fa1ffa-2370-4a2e-a12c-f7477f915628	3418d9c3-1714-40a3-acff-a954be89f636	t
30fa1ffa-2370-4a2e-a12c-f7477f915628	d1a81543-75f8-400a-abe5-e922ec87ad43	t
30fa1ffa-2370-4a2e-a12c-f7477f915628	d1a68d5e-34c1-492c-ba0e-278f31343166	t
30fa1ffa-2370-4a2e-a12c-f7477f915628	3c2accb2-199d-4bc7-b604-aa6709e31974	f
30fa1ffa-2370-4a2e-a12c-f7477f915628	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
30fa1ffa-2370-4a2e-a12c-f7477f915628	d9eb452d-6796-4b6d-a30c-735640838b1b	f
30fa1ffa-2370-4a2e-a12c-f7477f915628	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
05555d1d-ae31-4af1-aa65-aedd0620af0a	d1a68d5e-34c1-492c-ba0e-278f31343166	t
05555d1d-ae31-4af1-aa65-aedd0620af0a	562295a8-a71d-48d6-864a-afde6eaa1c57	t
05555d1d-ae31-4af1-aa65-aedd0620af0a	d1a81543-75f8-400a-abe5-e922ec87ad43	t
05555d1d-ae31-4af1-aa65-aedd0620af0a	3418d9c3-1714-40a3-acff-a954be89f636	t
05555d1d-ae31-4af1-aa65-aedd0620af0a	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
05555d1d-ae31-4af1-aa65-aedd0620af0a	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
05555d1d-ae31-4af1-aa65-aedd0620af0a	d9eb452d-6796-4b6d-a30c-735640838b1b	f
05555d1d-ae31-4af1-aa65-aedd0620af0a	3c2accb2-199d-4bc7-b604-aa6709e31974	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
d9eb452d-6796-4b6d-a30c-735640838b1b	6a268d78-5e0d-429e-b815-aca2322c3552
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
78293ef2-dd5e-4e29-8e44-4b562d1d29dc	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
b8922949-5cf1-4b6a-8527-e7f489a76bab	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
681e8895-cc4c-4ae1-b11f-4b036a3c46d7	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ee4df1b0-d4b8-4ab0-b2b3-fb5cae84ef0b	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
44bb3da8-7ec4-43ac-8456-cb5b494b3d60	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
4c2af8bb-5016-4ed6-932f-6b8ca9d55b76	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
c67f58e0-d62e-4211-ba2b-1a19ecf11508	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
116a94be-fbdd-484c-b257-3a1bceacc1cb	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
93947453-dd70-4ff4-99c0-926a3c7e7e3a	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
853ba9e2-d23c-451e-8ff6-3661dfb83e97	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
f3801c95-42d4-4ff5-886d-f98c744062d1	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
8d48b3a7-0eab-424c-b118-a1a0fa9d93e4	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
6d4a5ca6-b3ac-4b42-9337-4b4fd2f300dd	ee4df1b0-d4b8-4ab0-b2b3-fb5cae84ef0b	max-clients	200
1f89a492-3263-406c-9d83-a4fc85fb484f	78293ef2-dd5e-4e29-8e44-4b562d1d29dc	host-sending-registration-request-must-match	true
23bfa683-ed1e-4a69-962a-5df00b5c3fcf	78293ef2-dd5e-4e29-8e44-4b562d1d29dc	client-uris-must-match	true
2f74bd4c-944d-4972-89e6-ed354990f3e1	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	saml-role-list-mapper
66ee3567-70a7-4559-b085-38a1ad06475d	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6065c4c1-abd5-4ed9-88ae-b8a2769a7001	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1e1d01f5-430e-4b2e-9d10-c965f0b19b3f	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	oidc-full-name-mapper
6c2f4197-82de-49e7-8fae-57e033e77fd3	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	saml-user-attribute-mapper
18bc3ea2-491e-4211-8e69-d3c129c12622	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	saml-user-property-mapper
ce39cb1b-1f0e-473a-b2e5-6391d79466ae	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b6f56d3a-5a58-436e-91cb-f2058c6a1dca	44bb3da8-7ec4-43ac-8456-cb5b494b3d60	allowed-protocol-mapper-types	oidc-address-mapper
f3bc7507-b3eb-4c42-9369-09416259db65	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	oidc-full-name-mapper
22f64fbe-e7cb-406a-915f-1e2155425026	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bae637bd-6656-4745-9e5d-1d1f6485ddcc	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	saml-user-property-mapper
f6ccb25b-ff41-4397-b669-a8d66a9c86b0	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1216240d-a39c-48ac-b608-9e2e032391d5	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	saml-role-list-mapper
fe65a98c-abf4-4472-acc9-a18eea701392	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8024504e-6924-45a8-a681-42313f6086f3	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	saml-user-attribute-mapper
61cedeee-1ccd-4993-b70c-19942348d211	c67f58e0-d62e-4211-ba2b-1a19ecf11508	allowed-protocol-mapper-types	oidc-address-mapper
2569fb30-9e87-4b64-a331-2712254d10ca	4c2af8bb-5016-4ed6-932f-6b8ca9d55b76	allow-default-scopes	true
76721579-42f1-4d01-b5c5-99997a948f4d	116a94be-fbdd-484c-b257-3a1bceacc1cb	allow-default-scopes	true
6d535c69-6c43-40fc-9e48-0dadc6f5f3e1	853ba9e2-d23c-451e-8ff6-3661dfb83e97	keyUse	enc
b47a83c3-c916-40a1-b287-102a6d2d96b9	853ba9e2-d23c-451e-8ff6-3661dfb83e97	certificate	MIICmzCCAYMCBgF9LOPvATANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMTE3MDc1MjU1WhcNMzExMTE3MDc1NDM1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCmM/T+CkHa8SdJYqgaVBoW/I7Az+S5Hglq4kAjOxoWYD8G/M1bMYRfyLsRBOYqv5YHyaYR016kQB5HCjHlRRzLEPSpRy9Cls7gOblG/rfW0RCfOPQxxRrukqLBehre4tPA5bC4Bd4ps616uXcHxWyz7ZRqFnztR9gN8t6ktbC28oxfOy3ds57mVoU5j83NhfbrTymrwpJCHI9V/4+kd80TP0DvGJUpX+DSUHr47qa67J0T0J7uSwN8jvJvO1DOafwyE7SlvmDjIJ1VuwPyYDqNmn9I0sKgIT3UecebnG0JZdda/5pdNs0L3WrqH/OZ2pXnlYnfijNvBxYZClKouGAjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADscS9YSYQc9ABxTNR1G2V2oUIGHqgesAZa49WHZgIa3fU4TxcQw1Q2Ye7Y7mH7uYIUD06ME9rjqRhz2NQhHVRgShKJmc8TCWxibtD9pFsyLL5yKremq6D/mJEOtHi8Oa7jPMIC25y3TAkuqTng3Nhqm/UMfTTjiej+EquHxlnVal/b6shJSsOvnrGTGBQ3oxg5AseMuWB8r/pAARKT6Ppi6XnUTcUp92mfBHfwU5KSBp5XsNlRd6rIBfpQ1J+lFa7bdrKweUdlqlWxvrtGZ0OMs1OkT0dEcvdQriIEyZRa6MbJU6N67f0NBa86GMUH2fNjDZxRKnniGZ15L84swQ0Q=
e3102b02-34d4-48c9-b44b-9dff1d2a295b	853ba9e2-d23c-451e-8ff6-3661dfb83e97	privateKey	MIIEpAIBAAKCAQEApjP0/gpB2vEnSWKoGlQaFvyOwM/kuR4JauJAIzsaFmA/BvzNWzGEX8i7EQTmKr+WB8mmEdNepEAeRwox5UUcyxD0qUcvQpbO4Dm5Rv631tEQnzj0McUa7pKiwXoa3uLTwOWwuAXeKbOterl3B8Vss+2UahZ87UfYDfLepLWwtvKMXzst3bOe5laFOY/NzYX2608pq8KSQhyPVf+PpHfNEz9A7xiVKV/g0lB6+O6muuydE9Ce7ksDfI7ybztQzmn8MhO0pb5g4yCdVbsD8mA6jZp/SNLCoCE91HnHm5xtCWXXWv+aXTbNC91q6h/zmdqV55WJ34ozbwcWGQpSqLhgIwIDAQABAoIBAA9+vJKKpkUhQoZm+kEqIhyOg0iamTphAIPEgDJIqk/3vSiLnSGpZiv/7ODTUhoeLoCfXio/SI2LpMb+vlQfs2WDOSwnBNLyeGsTNqDV0pHmf+Q4TRvuwmoHpcDf/21UPGW5hFZDxcihhcTxUZWZ5F6KAdI6Mn90uUHjqLo2bjlAEONk1HRUHTP3tcgoLFYkZc42ivb1Z7es2QSnJ4h4jk2gUzjDGabEAXyD9cxRNg+S9QF1TfOvRTVQv0KMISoyJayHJfHoEP8EaDKAkAY9T5qtkrH11ATwSTAtJYBasoOpF4Q0S7mNKqEMMjaFhwo28rNH1hnc9SgFeAwZMnwEVSECgYEA69uvPWN+6nU5tvdGO68RsGRmCeHt1jxpQNIIw/gYYW8uSN5xXVxWl6o4mXIePrNc/U+sqcE4m8vWldvu/bk6DB6GsbYd0kKkpkWRJfI+I0BYCBjteRLE9r5LjtFGS3XRealr+4jKPNyj7rh48qFOrPUZpMNov5Qqibj/QirshBkCgYEAtGV5rY8MKq0SrT+blmEgOq+fFP/dVlTH+bvZdXY8cdWQY4f3emzaA3/aHAFd7HrSuKLxntLa5NvLMR1A8LD+q6twwIZLNsMeD77Dx8K83ugmq9TJTMnD7eg+6TQ/YsFu3AFb+26SxGGNUCuhPXuwfa1ppzJK467XhIQxAAQsLZsCgYBfos6l58g4rZvfctjJrq1PhwZRD4lvC0PqgsAHJnxMVdbAuWHiZ2S9TspwffOBnR0hocLzemPH2JmEXo/D1e2RqHcZbC0fauJ0gVTfvCAyDw8jCWiRZWj0XCkrGfSU+Isd9/LPJaJLl3PpgmeYiovqWeAyDQJWXG/7NEZcwCbzUQKBgQCUaJc97d04jsI6vYWmpaj6HtllUUoqZ/1Muvof5HG9xNDQ0V8L3NlO37P0Ljuy/Si2tXbKDvX+KcR0V3jBixs46AYOnWzrVII6udofUVpIl/yYiKpC/gqugs6e1FkBSdmGLagapdEgtpCnT/2Ks2NzQWMWJg3uWjz7zDTzqnsd2QKBgQCsSTdWltvvg0gvHupYZvdfvgdTIyrVbTCWVTSqmDgqy/KW3Qsmq87AiH/HCvsL9e26S7uwtrKgYru8EAJ0izaXIkFseCEb1GU6QCqIFq95Cmr4EHReyl/Q5hk/6fXKtPRZVMdwMSCoRgqmohgSMW9zcrJFF1iDzF9JwpnLa+bosg==
8994800f-d5b3-4f2c-97a3-4c7e58ad381d	853ba9e2-d23c-451e-8ff6-3661dfb83e97	priority	100
b68cfd5a-7f59-4098-afed-7ed446c0e3e6	8d48b3a7-0eab-424c-b118-a1a0fa9d93e4	priority	100
c2a5cdcb-692a-4fab-8c8c-b0a8c7630a39	8d48b3a7-0eab-424c-b118-a1a0fa9d93e4	kid	b817c6ac-81d7-458f-aa94-3cf7d44e0919
f0aa26d9-b763-4a9b-acff-3a22a1fd11be	8d48b3a7-0eab-424c-b118-a1a0fa9d93e4	secret	MiuJ7YDlE4lg71ldh-KQ9Q
23beac35-05fe-449a-9bf6-313d3f4f3ce7	93947453-dd70-4ff4-99c0-926a3c7e7e3a	keyUse	sig
032ed785-e8a0-4474-a577-e640fe4abb35	93947453-dd70-4ff4-99c0-926a3c7e7e3a	certificate	MIICmzCCAYMCBgF9LOPuiDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMTE3MDc1MjU1WhcNMzExMTE3MDc1NDM1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCaho6rXx42Zt30EDYDRsRXAtPwZsBxwvjpCrOWVSgibprpNMwgLWXlI8gXoNb0IbyoxZ3BhXj0yXLnPJ29PY5nllF9tXsQLNBZOArLVAO29iExMWV8RpJipNv1Nx/E/MZHd2OBJiwa0gdC2pCnuN57LcH/dFqxujkJAhgaqAswpwP0D4e8wGr7QJatgX0+fOjKX4daLYl0OPdJncpRZrsMgM4W7Cq04cIUASszndm5EXL6NbKyNTN21bYcvdju+0L9NFyGVlFxT8Rfu8mlO47c4NArza3oj9tlLlLREDwd7rHRBVYtkHCWkjrpwrgmD/3ScO2W3nZmUuuwAtgeKeYvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHxWXKubq9Mdq836imhM+D23gqWY4+cCN3zxBbWV1208XZ6OnikQS9VVvxkRXZTV2hnBPD+bOnyemnGyAc96HpqcQ18eUFd+uHOwLnNKsiDHpHU9SDJmtuASdQSrXbPRMP8JQ34biPq6Sxeg9Kt6bHPMAPgyj6Cd8/CEIbxq4Ouh0D8Ga8K04v2/1Usv2Y+JRuxaI+nvzExTTNDU3RwbA+aEIWD41ZF0mtrimzrdHcPxij0teeoWODIg+ottUcQNSW6W8IV4P1B0Fp1rpyG92A+mWZ/ltYZvfzAOYaslZBuOUNcdX09KKdmgvQkVcmnj9ESV0qxlFwlrF9hfDWarHyE=
f18311a0-381c-4a6d-a2a7-780a426db0bd	93947453-dd70-4ff4-99c0-926a3c7e7e3a	privateKey	MIIEpAIBAAKCAQEAmoaOq18eNmbd9BA2A0bEVwLT8GbAccL46QqzllUoIm6a6TTMIC1l5SPIF6DW9CG8qMWdwYV49Mly5zydvT2OZ5ZRfbV7ECzQWTgKy1QDtvYhMTFlfEaSYqTb9TcfxPzGR3djgSYsGtIHQtqQp7jeey3B/3Rasbo5CQIYGqgLMKcD9A+HvMBq+0CWrYF9Pnzoyl+HWi2JdDj3SZ3KUWa7DIDOFuwqtOHCFAErM53ZuRFy+jWysjUzdtW2HL3Y7vtC/TRchlZRcU/EX7vJpTuO3ODQK82t6I/bZS5S0RA8He6x0QVWLZBwlpI66cK4Jg/90nDtlt52ZlLrsALYHinmLwIDAQABAoIBAQCVkJG8y5cJnu1L0vkEmNVnRqRutnWkZsvXfHUwmAH9ucKU4HaG2ooajFSakiIcMB9T19qGujLF88oUiPZAeblBCByeKS8RC98py/WeshXaXEbqP150ODZt5hXENfO5DdS4zZTxJ0pfN1Sx361NucEVxsdUA4HZLl8QGgfMnUQfdLG4Yw3jClx6dvcQwPst/igeKRyNKuPOp+SI5HmFzF4hxCDgl2QuSJfRTXacVzFIa8K/PmrQ3tVF6SnxPGSFPyf95SQX89CjTyuZLkUudG0c3aNXUeL77O8T3lDx98oCXjLqT7O1O027bMPqhnMh0QZjOhBbCfZLxrr3HdKy7+PBAoGBAOxdGv7l5IuFMzttZCR+kpiQj+CeK008jSG++JYND7N+mCD/RjJq4yx1oPf0sp/vfqA0jbecbb0FAs3NQSlr59g5IHt5uzh1QkgRfMeA1g852A9MlyiTvWKIVq/vAejSUPmBfVYfGjDZ3tb4kHg0O/wGa47CW7cbSbCTG3tPYR5PAoGBAKdc80IUfOW7wHw8XX/R5bIvNVI5fqQ4fuhI1IioUno60NF1rijKw6I/ODn0OMxpdTRJusdzUj9l4VsmeniQCTSkaJbxwJdmaWZ2dXtEtEtdVWyAKG5HpU/gWAGb7ogjj3XjXtwS8AD4WemNftucVYeZ85tSVhDowuSN/pjcWaIhAoGBAJ/ziddBP95i736h0okX1qDEA3mfz/HeritODu+MOzney5hY5+oqhz2JBLuHrnGpIunLZrQAegrWH0WiRxx+11BtqFumz1mvkIEwxF5GA5YeMOZ5kDl3cUwCs5cviP1DhmSyil0DgzfX2INlhm6x+n3c4mCjimlpX/7MLmbOGwzlAoGAYZSFVJrjc4LzqLv9e+Aiv7Bcs3NITnGONNr56C/T3uZaCDZH9Aq84+VeYBPv5eb66iCu4Ulww/wf1+hocdDxPRs6y/9qXhvdClu5BcU6JdLmUpuqdxoY3aidR1rmScQKCh8mmMQF4Vrr+YuBUoQlLinp6j6oZbWApIfR0MhxDmECgYBUSeilWAS684ZYs7BQLsDerqBR/+7njrzKkq8uLnITLzYiHDeA3v9CYGeTC0zoiOBPxCCjGNei+lkwn0hzbTr9p30WRrp+TJC8Xw3r1ZjXxhTLt7tcn8KfqaGbp9hdqw6fu86CkQ+AUK8ijFYtLE40cxKqENbVizlgByAbeS4/3g==
e74cddd1-79b6-486b-91a4-af088831c907	93947453-dd70-4ff4-99c0-926a3c7e7e3a	priority	100
d8d6c107-ab1c-428c-8e12-a87663074120	f3801c95-42d4-4ff5-886d-f98c744062d1	secret	LG6BemUDSZTZ2Yj9lKrJfrJ2GVZwzx-QZE_si1SkaiVG-55v3zo11dhguT64WhamyhGOpvc6nHBWm0DIT9e5zw
f779bcb9-9ffd-4b65-a15e-a9a1aee2c116	f3801c95-42d4-4ff5-886d-f98c744062d1	kid	396de5a8-1755-4684-b5e5-d85494d7bfc2
a5969047-3e63-4280-8b08-7b0129f63aff	f3801c95-42d4-4ff5-886d-f98c744062d1	priority	100
4c4ed470-a3dd-4229-91ec-59b50578f628	f3801c95-42d4-4ff5-886d-f98c744062d1	algorithm	HS256
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
98949ea8-26f7-4af5-8977-3b18884d51bb	5babfdd6-3023-4f72-84d5-87685180ad58
98949ea8-26f7-4af5-8977-3b18884d51bb	af1dd63a-0ff5-4cbe-8aa0-bb5affe2926d
98949ea8-26f7-4af5-8977-3b18884d51bb	5593f538-f559-41ca-b88c-82d356edd5b8
98949ea8-26f7-4af5-8977-3b18884d51bb	134942b6-8e1e-45e3-b1a5-342467b53683
98949ea8-26f7-4af5-8977-3b18884d51bb	6b1dd6d8-707a-4a2a-b417-f53d384b6842
98949ea8-26f7-4af5-8977-3b18884d51bb	e9dae306-38a2-498b-adff-812e88ed959c
98949ea8-26f7-4af5-8977-3b18884d51bb	ce0c5bbf-072f-4e5d-9698-3bee93db9228
98949ea8-26f7-4af5-8977-3b18884d51bb	880aa46b-bf4d-490d-ae10-8338c8b38639
98949ea8-26f7-4af5-8977-3b18884d51bb	cc9d5b38-7695-459a-b7c7-5dc6738bffd9
98949ea8-26f7-4af5-8977-3b18884d51bb	cc92ffbf-2ccd-4bca-9fd9-c8eb6cebe5ec
98949ea8-26f7-4af5-8977-3b18884d51bb	74c53358-1b7a-485c-b9cb-2a010a3307f7
98949ea8-26f7-4af5-8977-3b18884d51bb	26f77f6b-46d7-42ff-938d-45d64af44a78
98949ea8-26f7-4af5-8977-3b18884d51bb	05c2e0f0-6cc6-49c1-acc2-1d80720d60c1
98949ea8-26f7-4af5-8977-3b18884d51bb	c742840b-2711-4d8c-a5ea-ba81c3309a9d
98949ea8-26f7-4af5-8977-3b18884d51bb	8e53e79b-09fc-4f9a-b184-b0de11fca5bf
98949ea8-26f7-4af5-8977-3b18884d51bb	fa2e9cd0-6772-4d57-8e2c-e70d43a0cd4d
98949ea8-26f7-4af5-8977-3b18884d51bb	da8960ea-1066-4e0b-8f64-6a6ec109a234
98949ea8-26f7-4af5-8977-3b18884d51bb	17540908-a733-4606-a4ae-2cd73ee845db
6b1dd6d8-707a-4a2a-b417-f53d384b6842	fa2e9cd0-6772-4d57-8e2c-e70d43a0cd4d
134942b6-8e1e-45e3-b1a5-342467b53683	17540908-a733-4606-a4ae-2cd73ee845db
134942b6-8e1e-45e3-b1a5-342467b53683	8e53e79b-09fc-4f9a-b184-b0de11fca5bf
3e7a2036-3eee-4b45-8546-a944e704b9ef	21453db4-6b78-41db-900a-5d96ee3b32ef
3e7a2036-3eee-4b45-8546-a944e704b9ef	4f2af37d-c30e-495d-a6df-9d5f46d17f27
4f2af37d-c30e-495d-a6df-9d5f46d17f27	22fe30bf-da21-4fee-bf72-53da30735b0a
c03c919c-e339-47af-82be-4ce51041001c	0e94f18a-d5fc-4615-85f7-1f8c8c4fce97
98949ea8-26f7-4af5-8977-3b18884d51bb	3b14a4d1-4df2-4933-a00d-8c0b7ded4386
3e7a2036-3eee-4b45-8546-a944e704b9ef	6a268d78-5e0d-429e-b815-aca2322c3552
3e7a2036-3eee-4b45-8546-a944e704b9ef	9baf5574-7f8a-4a0e-bf4f-8bb52401011a
98949ea8-26f7-4af5-8977-3b18884d51bb	462d29bb-a55e-4e72-80e2-b82f7cd44e11
98949ea8-26f7-4af5-8977-3b18884d51bb	8ba1a1d3-7198-4e1e-91a1-4894523ea0c2
98949ea8-26f7-4af5-8977-3b18884d51bb	29c0c7eb-eb07-4045-89f1-ebc93f26e367
98949ea8-26f7-4af5-8977-3b18884d51bb	e15f891a-4771-4652-a882-46dfa07e095d
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
eccad215-26f1-4f7e-947f-d641e414a7e6	\N	password	f5416954-cede-47b0-9869-316b29b9d4f6	1637135675638	\N	{"value":"xeoKw/pxirKLScy52rqlsKvSs0DrLAJGVZbtpIscYM6RiPtCMmjf/wJjJq6Jn+tQER8FYAZs2T+vjxe+QuZ5hw==","salt":"T7TGRJYy1pd8cO98k6MjPA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
75b18684-942f-4260-9a0a-9815f314483a	\N	password	02336646-f5d0-4670-b111-c140a3ad58b5	1638362442191	\N	{"value":"fVFoLYkR7LiwqGvBHeb2qy6KhAKU6UKP9jjwzS0xjMRNR7LC356v/AKWgq9RzQAjJZ6F3wnqS636gqR+mSDrrQ==","salt":"43Tg4YyYCxphvx93GyRprw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6a6c3e32-11f3-4810-ad32-59bac0a9aef3	\N	password	04bd4aaf-6e7b-4696-81ce-369b75e5711c	1645543955293	\N	{"value":"EctNNsxMupJSa+GrSvGiagm/1R9rslHxtZCXTT4fvI4hSB1HaT+RKNlbfttUmzAxdkgVyQ6jUQti8Jsk/Ve6Yw==","salt":"UCJUpKzbWT468ZHEZ0KgTA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
cac54d7f-dd16-4033-85af-4d11441925b6	\N	password	45526cca-291a-405e-8234-6088454e18c4	1645544590241	\N	{"value":"Bo049lqFvaXcH6KQm2T7sWAgbEMcGWXj4+/o4V/bjhl1/k4Jq3ToPqc0YYpCOvnbhCfTo4pZ9bNyf3P4cWXDAQ==","salt":"qz6Czz4GEJYbLQV5aJYfuQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1939c4b3-5741-4356-a32b-0773bd67f10d	\N	password	a1e11707-2ebc-492e-8b4b-15b5ff3d8008	1645544704490	\N	{"value":"ksjovqv8oHU7xc7MvRz5+ytShsWj8v7y6psZn6D7e5w7xsNC/QiFtsewU6PpfewwEgFIj2NLAycfklC6Z4QBPg==","salt":"XxGFPCwj3NKlBz69fGuEOg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
c1aa3793-caad-48b7-8ff8-e0f19969195e	\N	password	254df759-8b82-4d5d-9587-20c96831a342	1646910571269	\N	{"value":"f1rV9pSWDXfLVfUnA9xI8OtsZmN2ANg3zXR+LVmQ8OSiaHbHbRpovL0xK3p9+4MZS9oanQXwQmN0RJiKCbj4qA==","salt":"YQ0NEhVacbptJ3MmvHVfEw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-11-17 07:54:30.268778	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	7135670040
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-11-17 07:54:30.277143	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	7135670040
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-11-17 07:54:30.303715	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	7135670040
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-11-17 07:54:30.306651	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	7135670040
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-11-17 07:54:30.375006	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	7135670040
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-11-17 07:54:30.377284	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	7135670040
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-11-17 07:54:30.43038	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	7135670040
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-11-17 07:54:30.433227	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	7135670040
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-11-17 07:54:30.437072	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	7135670040
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-11-17 07:54:30.503419	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	7135670040
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-11-17 07:54:30.539194	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7135670040
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-11-17 07:54:30.541152	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7135670040
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-11-17 07:54:30.552727	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	7135670040
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-11-17 07:54:30.568491	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	7135670040
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-11-17 07:54:30.570051	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7135670040
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-11-17 07:54:30.57173	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	7135670040
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-11-17 07:54:30.573239	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	7135670040
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-11-17 07:54:30.612634	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	7135670040
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-11-17 07:54:30.644755	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	7135670040
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-11-17 07:54:30.647884	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	7135670040
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-11-17 07:54:31.442756	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	7135670040
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-11-17 07:54:30.649453	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	7135670040
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-11-17 07:54:30.651105	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	7135670040
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-11-17 07:54:30.711772	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	7135670040
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-11-17 07:54:30.715581	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	7135670040
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-11-17 07:54:30.716983	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	7135670040
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-11-17 07:54:30.857882	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	7135670040
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-11-17 07:54:30.917997	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	7135670040
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-11-17 07:54:30.920209	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	7135670040
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-11-17 07:54:30.972478	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	7135670040
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-11-17 07:54:30.9816	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	7135670040
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-11-17 07:54:30.993826	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	7135670040
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-11-17 07:54:30.996345	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	7135670040
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-11-17 07:54:30.999388	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7135670040
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-11-17 07:54:31.000884	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	7135670040
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-11-17 07:54:31.018583	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	7135670040
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-11-17 07:54:31.021827	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	7135670040
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-11-17 07:54:31.027184	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7135670040
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-11-17 07:54:31.029608	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	7135670040
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-11-17 07:54:31.03199	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	7135670040
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-11-17 07:54:31.033382	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	7135670040
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-11-17 07:54:31.034677	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	7135670040
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-11-17 07:54:31.037176	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	7135670040
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-11-17 07:54:31.436826	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	7135670040
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-11-17 07:54:31.43998	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	7135670040
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-11-17 07:54:31.445477	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	7135670040
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-11-17 07:54:31.446842	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	7135670040
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-11-17 07:54:31.490274	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	7135670040
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-11-17 07:54:31.493074	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	7135670040
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-11-17 07:54:31.530228	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	7135670040
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-11-17 07:54:31.625205	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	7135670040
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-11-17 07:54:31.628081	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7135670040
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-11-17 07:54:31.630169	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	7135670040
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-11-17 07:54:31.63224	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	7135670040
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-11-17 07:54:31.637665	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	7135670040
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-11-17 07:54:31.641746	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	7135670040
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-11-17 07:54:31.66554	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	7135670040
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-11-17 07:54:31.788428	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	7135670040
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-11-17 07:54:31.80701	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	7135670040
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-11-17 07:54:31.810665	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	7135670040
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-11-17 07:54:31.815212	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	7135670040
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-11-17 07:54:31.81964	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	7135670040
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-11-17 07:54:31.822113	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	7135670040
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-11-17 07:54:31.824103	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	7135670040
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-11-17 07:54:31.825885	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	7135670040
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-11-17 07:54:31.842003	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	7135670040
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-11-17 07:54:31.852357	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	7135670040
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-11-17 07:54:31.85528	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	7135670040
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-11-17 07:54:31.867705	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	7135670040
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-11-17 07:54:31.871137	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	7135670040
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-11-17 07:54:31.873746	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	7135670040
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-11-17 07:54:31.877353	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7135670040
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-11-17 07:54:31.880653	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7135670040
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-11-17 07:54:31.88195	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	7135670040
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-11-17 07:54:31.890437	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	7135670040
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-11-17 07:54:31.902539	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	7135670040
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-11-17 07:54:31.905196	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	7135670040
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-11-17 07:54:31.906555	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	7135670040
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-11-17 07:54:31.91807	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	7135670040
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-11-17 07:54:31.919706	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	7135670040
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-11-17 07:54:31.931432	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	7135670040
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-11-17 07:54:31.933011	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7135670040
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-11-17 07:54:31.935821	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7135670040
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-11-17 07:54:31.937168	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	7135670040
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-11-17 07:54:31.951398	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	7135670040
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-11-17 07:54:31.955895	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	7135670040
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-11-17 07:54:31.961831	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	7135670040
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-11-17 07:54:31.969882	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	7135670040
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:31.973793	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	7135670040
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:31.977512	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	7135670040
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:31.988376	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7135670040
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:31.993573	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	7135670040
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:31.994937	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	7135670040
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:32.000958	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	7135670040
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:32.002423	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	7135670040
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-11-17 07:54:32.005439	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	7135670040
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.03604	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	7135670040
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.037467	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7135670040
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.041654	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7135670040
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.054079	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7135670040
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.055503	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	7135670040
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.066165	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	7135670040
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-11-17 07:54:32.068753	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	7135670040
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-11-17 07:54:32.071977	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	7135670040
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	d9eb452d-6796-4b6d-a30c-735640838b1b	f
master	1efeb38a-b04e-4c99-8c7a-f030f5cf8e71	t
master	562295a8-a71d-48d6-864a-afde6eaa1c57	t
master	3418d9c3-1714-40a3-acff-a954be89f636	t
master	50ad4be1-ff47-4eec-bf13-57e20a52947f	f
master	9a79fbda-0d54-401b-b04c-19aa2e376f87	f
master	d1a81543-75f8-400a-abe5-e922ec87ad43	t
master	d1a68d5e-34c1-492c-ba0e-278f31343166	t
master	3c2accb2-199d-4bc7-b604-aa6709e31974	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
91a70fc8-c6b6-4b2a-a3d3-e5c6e3d773f6	new	 	master
21b86e7c-c846-434f-b226-cf284c0556a8	new1	 	master
a6728d51-0572-4fd5-abe2-0732d4dbc4a7	new2	 	master
5a4a60cb-2d66-4204-a78a-4696591d2fd6	test	 	master
ce629612-3d25-477f-bac1-e70c94f46671	test00042	 	master
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
3e7a2036-3eee-4b45-8546-a944e704b9ef	master	f	${role_default-roles}	default-roles-master	master	\N	\N
98949ea8-26f7-4af5-8977-3b18884d51bb	master	f	${role_admin}	admin	master	\N	\N
5babfdd6-3023-4f72-84d5-87685180ad58	master	f	${role_create-realm}	create-realm	master	\N	\N
af1dd63a-0ff5-4cbe-8aa0-bb5affe2926d	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_create-client}	create-client	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
5593f538-f559-41ca-b88c-82d356edd5b8	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-realm}	view-realm	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
134942b6-8e1e-45e3-b1a5-342467b53683	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-users}	view-users	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
6b1dd6d8-707a-4a2a-b417-f53d384b6842	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-clients}	view-clients	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
e9dae306-38a2-498b-adff-812e88ed959c	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-events}	view-events	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
ce0c5bbf-072f-4e5d-9698-3bee93db9228	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-identity-providers}	view-identity-providers	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
880aa46b-bf4d-490d-ae10-8338c8b38639	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_view-authorization}	view-authorization	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
cc9d5b38-7695-459a-b7c7-5dc6738bffd9	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-realm}	manage-realm	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
cc92ffbf-2ccd-4bca-9fd9-c8eb6cebe5ec	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-users}	manage-users	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
74c53358-1b7a-485c-b9cb-2a010a3307f7	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-clients}	manage-clients	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
26f77f6b-46d7-42ff-938d-45d64af44a78	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-events}	manage-events	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
05c2e0f0-6cc6-49c1-acc2-1d80720d60c1	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-identity-providers}	manage-identity-providers	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
c742840b-2711-4d8c-a5ea-ba81c3309a9d	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_manage-authorization}	manage-authorization	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
8e53e79b-09fc-4f9a-b184-b0de11fca5bf	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_query-users}	query-users	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
fa2e9cd0-6772-4d57-8e2c-e70d43a0cd4d	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_query-clients}	query-clients	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
da8960ea-1066-4e0b-8f64-6a6ec109a234	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_query-realms}	query-realms	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
17540908-a733-4606-a4ae-2cd73ee845db	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_query-groups}	query-groups	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
21453db4-6b78-41db-900a-5d96ee3b32ef	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_view-profile}	view-profile	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
4f2af37d-c30e-495d-a6df-9d5f46d17f27	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_manage-account}	manage-account	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
22fe30bf-da21-4fee-bf72-53da30735b0a	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_manage-account-links}	manage-account-links	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
409dc5f8-e36f-4016-9d0d-768535ec54e0	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_view-applications}	view-applications	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
0e94f18a-d5fc-4615-85f7-1f8c8c4fce97	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_view-consent}	view-consent	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
c03c919c-e339-47af-82be-4ce51041001c	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_manage-consent}	manage-consent	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
ba96f868-8d23-40a5-ace4-a73c43434a60	61fb0d41-9851-4ec5-bd7d-04552647b871	t	${role_delete-account}	delete-account	master	61fb0d41-9851-4ec5-bd7d-04552647b871	\N
0d45f405-231f-4655-8c36-256c7e3cb8bf	e0af2cc2-218e-4ead-8d8c-bbc998ab667c	t	${role_read-token}	read-token	master	e0af2cc2-218e-4ead-8d8c-bbc998ab667c	\N
3b14a4d1-4df2-4933-a00d-8c0b7ded4386	c121f7e1-3149-4772-9e37-059206f16a79	t	${role_impersonation}	impersonation	master	c121f7e1-3149-4772-9e37-059206f16a79	\N
6a268d78-5e0d-429e-b815-aca2322c3552	master	f	${role_offline-access}	offline_access	master	\N	\N
9baf5574-7f8a-4a0e-bf4f-8bb52401011a	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
db8229ee-296f-4d9a-b140-56869f919cd6	master	f	\N	role-annotator	master	\N	\N
462d29bb-a55e-4e72-80e2-b82f7cd44e11	master	f	\N	annotator	master	\N	\N
8ba1a1d3-7198-4e1e-91a1-4894523ea0c2	master	f	\N	engineer	master	\N	\N
29c0c7eb-eb07-4045-89f1-ebc93f26e367	master	f	\N	manager	master	\N	\N
e15f891a-4771-4652-a882-46dfa07e095d	master	f	\N	presenter	master	\N	\N
13e6b8a3-e0ee-4904-8948-5a9edd0d7ad0	master	f	Viewer (e.g. Presales)	viewer	master	\N	\N
2197198b-e5a9-4bf8-bb25-d296a8f3e047	master	f	\N	simple_flow	master	\N	\N
0ac1330f-2fda-4a64-813b-232c8d04e884	30fa1ffa-2370-4a2e-a12c-f7477f915628	t	\N	uma_protection	master	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
hy11l	15.0.2	1637135673
o76d1	16.1.0	1667987172
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
91361fa4-165c-4f4f-b094-d9dd57aeedba	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
35c524ca-05b6-456c-8adc-a5f87be9d4a7	defaultResourceType	urn:pipelines:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
c9194951-9265-41f9-8eaa-5d5ad9b5e097	audience resolve	openid-connect	oidc-audience-resolve-mapper	9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	\N
0c204c71-ab76-424f-95bc-55ce34c219ac	locale	openid-connect	oidc-usermodel-attribute-mapper	4ad82c3f-04b6-4d59-826a-e5441fa906dc	\N
e12826d3-5f82-477b-a8ed-f698f10ad031	role list	saml	saml-role-list-mapper	\N	1efeb38a-b04e-4c99-8c7a-f030f5cf8e71
977fbe3f-a442-461f-9b22-7c3f5fac092c	full name	openid-connect	oidc-full-name-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
aa257080-1dc1-4256-86c1-16620412048f	family name	openid-connect	oidc-usermodel-property-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
a10fa38b-fcc9-46a1-8df0-976fac5b285a	given name	openid-connect	oidc-usermodel-property-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
a678bb24-0a44-42ef-801e-2f0a05909ea6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
0b762279-6359-478c-a12b-5cfe3688c8e0	username	openid-connect	oidc-usermodel-property-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
4871f6a0-d529-45e7-b86c-2041d52d75a0	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
e3b670e3-ea06-4c42-8386-5feca3538a8b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
7629e49e-0370-46ac-96bb-ab217f983db3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
fd344b25-db84-4c49-bbdd-2559bd5bd74f	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
67118c68-b16b-4ce9-8a8d-60e6d23baa78	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	562295a8-a71d-48d6-864a-afde6eaa1c57
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	email	openid-connect	oidc-usermodel-property-mapper	\N	3418d9c3-1714-40a3-acff-a954be89f636
5eec645d-54ef-4d90-82cf-3f903a0130c0	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3418d9c3-1714-40a3-acff-a954be89f636
c1eadf18-6ff3-4901-8b66-265b39771cb7	address	openid-connect	oidc-address-mapper	\N	50ad4be1-ff47-4eec-bf13-57e20a52947f
a8514b59-e507-4720-9833-5c6b5544eb99	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9a79fbda-0d54-401b-b04c-19aa2e376f87
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9a79fbda-0d54-401b-b04c-19aa2e376f87
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	d1a81543-75f8-400a-abe5-e922ec87ad43
e7809fb0-2602-469f-a1e0-09c69a01b746	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	d1a81543-75f8-400a-abe5-e922ec87ad43
f7fa5f41-889e-4b0b-be64-85b7fe8e4a97	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d1a68d5e-34c1-492c-ba0e-278f31343166
5cff87a0-6c73-4963-942f-210e0a90f6f8	upn	openid-connect	oidc-usermodel-property-mapper	\N	3c2accb2-199d-4bc7-b604-aa6709e31974
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3c2accb2-199d-4bc7-b604-aa6709e31974
72e252a4-c256-4dc6-bafe-e78b3b0196c9	tenants	openid-connect	oidc-usermodel-attribute-mapper	b1fae7fb-0d86-403d-85f1-398a0af8acd4	\N
412f4e70-a88a-47d8-97fb-935309a670b3	tenants	openid-connect	oidc-usermodel-attribute-mapper	05555d1d-ae31-4af1-aa65-aedd0620af0a	\N
64b7b24c-e00a-4741-98e0-baeb4c0c271d	user_id	openid-connect	oidc-usermodel-property-mapper	05555d1d-ae31-4af1-aa65-aedd0620af0a	\N
7fd25bfa-1678-4071-8e52-c6a305348754	user_id	openid-connect	oidc-usermodel-property-mapper	b1fae7fb-0d86-403d-85f1-398a0af8acd4	\N
b589340e-cab0-4dc6-bd8d-c40dffbb0013	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0c204c71-ab76-424f-95bc-55ce34c219ac	true	userinfo.token.claim
0c204c71-ab76-424f-95bc-55ce34c219ac	locale	user.attribute
0c204c71-ab76-424f-95bc-55ce34c219ac	true	id.token.claim
0c204c71-ab76-424f-95bc-55ce34c219ac	true	access.token.claim
0c204c71-ab76-424f-95bc-55ce34c219ac	locale	claim.name
0c204c71-ab76-424f-95bc-55ce34c219ac	String	jsonType.label
e12826d3-5f82-477b-a8ed-f698f10ad031	false	single
e12826d3-5f82-477b-a8ed-f698f10ad031	Basic	attribute.nameformat
e12826d3-5f82-477b-a8ed-f698f10ad031	Role	attribute.name
977fbe3f-a442-461f-9b22-7c3f5fac092c	true	userinfo.token.claim
977fbe3f-a442-461f-9b22-7c3f5fac092c	true	id.token.claim
977fbe3f-a442-461f-9b22-7c3f5fac092c	true	access.token.claim
aa257080-1dc1-4256-86c1-16620412048f	true	userinfo.token.claim
aa257080-1dc1-4256-86c1-16620412048f	lastName	user.attribute
aa257080-1dc1-4256-86c1-16620412048f	true	id.token.claim
aa257080-1dc1-4256-86c1-16620412048f	true	access.token.claim
aa257080-1dc1-4256-86c1-16620412048f	family_name	claim.name
aa257080-1dc1-4256-86c1-16620412048f	String	jsonType.label
a10fa38b-fcc9-46a1-8df0-976fac5b285a	true	userinfo.token.claim
a10fa38b-fcc9-46a1-8df0-976fac5b285a	firstName	user.attribute
a10fa38b-fcc9-46a1-8df0-976fac5b285a	true	id.token.claim
a10fa38b-fcc9-46a1-8df0-976fac5b285a	true	access.token.claim
a10fa38b-fcc9-46a1-8df0-976fac5b285a	given_name	claim.name
a10fa38b-fcc9-46a1-8df0-976fac5b285a	String	jsonType.label
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	true	userinfo.token.claim
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	middleName	user.attribute
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	true	id.token.claim
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	true	access.token.claim
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	middle_name	claim.name
f75d7cc3-bd13-429d-98cf-cc089e6ae7e3	String	jsonType.label
a678bb24-0a44-42ef-801e-2f0a05909ea6	true	userinfo.token.claim
a678bb24-0a44-42ef-801e-2f0a05909ea6	nickname	user.attribute
a678bb24-0a44-42ef-801e-2f0a05909ea6	true	id.token.claim
a678bb24-0a44-42ef-801e-2f0a05909ea6	true	access.token.claim
a678bb24-0a44-42ef-801e-2f0a05909ea6	nickname	claim.name
a678bb24-0a44-42ef-801e-2f0a05909ea6	String	jsonType.label
0b762279-6359-478c-a12b-5cfe3688c8e0	true	userinfo.token.claim
0b762279-6359-478c-a12b-5cfe3688c8e0	username	user.attribute
0b762279-6359-478c-a12b-5cfe3688c8e0	true	id.token.claim
0b762279-6359-478c-a12b-5cfe3688c8e0	true	access.token.claim
0b762279-6359-478c-a12b-5cfe3688c8e0	preferred_username	claim.name
0b762279-6359-478c-a12b-5cfe3688c8e0	String	jsonType.label
4871f6a0-d529-45e7-b86c-2041d52d75a0	true	userinfo.token.claim
4871f6a0-d529-45e7-b86c-2041d52d75a0	profile	user.attribute
4871f6a0-d529-45e7-b86c-2041d52d75a0	true	id.token.claim
4871f6a0-d529-45e7-b86c-2041d52d75a0	true	access.token.claim
4871f6a0-d529-45e7-b86c-2041d52d75a0	profile	claim.name
4871f6a0-d529-45e7-b86c-2041d52d75a0	String	jsonType.label
e3b670e3-ea06-4c42-8386-5feca3538a8b	true	userinfo.token.claim
e3b670e3-ea06-4c42-8386-5feca3538a8b	picture	user.attribute
e3b670e3-ea06-4c42-8386-5feca3538a8b	true	id.token.claim
e3b670e3-ea06-4c42-8386-5feca3538a8b	true	access.token.claim
e3b670e3-ea06-4c42-8386-5feca3538a8b	picture	claim.name
e3b670e3-ea06-4c42-8386-5feca3538a8b	String	jsonType.label
7629e49e-0370-46ac-96bb-ab217f983db3	true	userinfo.token.claim
7629e49e-0370-46ac-96bb-ab217f983db3	website	user.attribute
7629e49e-0370-46ac-96bb-ab217f983db3	true	id.token.claim
7629e49e-0370-46ac-96bb-ab217f983db3	true	access.token.claim
7629e49e-0370-46ac-96bb-ab217f983db3	website	claim.name
7629e49e-0370-46ac-96bb-ab217f983db3	String	jsonType.label
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	true	userinfo.token.claim
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	gender	user.attribute
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	true	id.token.claim
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	true	access.token.claim
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	gender	claim.name
be26ea21-7698-4cd4-ac1d-bdeadd4b2bce	String	jsonType.label
fd344b25-db84-4c49-bbdd-2559bd5bd74f	true	userinfo.token.claim
fd344b25-db84-4c49-bbdd-2559bd5bd74f	birthdate	user.attribute
fd344b25-db84-4c49-bbdd-2559bd5bd74f	true	id.token.claim
fd344b25-db84-4c49-bbdd-2559bd5bd74f	true	access.token.claim
fd344b25-db84-4c49-bbdd-2559bd5bd74f	birthdate	claim.name
fd344b25-db84-4c49-bbdd-2559bd5bd74f	String	jsonType.label
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	true	userinfo.token.claim
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	zoneinfo	user.attribute
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	true	id.token.claim
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	true	access.token.claim
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	zoneinfo	claim.name
f5c6f2be-adeb-41fa-b7ee-10a0ffc85b3c	String	jsonType.label
67118c68-b16b-4ce9-8a8d-60e6d23baa78	true	userinfo.token.claim
67118c68-b16b-4ce9-8a8d-60e6d23baa78	locale	user.attribute
67118c68-b16b-4ce9-8a8d-60e6d23baa78	true	id.token.claim
67118c68-b16b-4ce9-8a8d-60e6d23baa78	true	access.token.claim
67118c68-b16b-4ce9-8a8d-60e6d23baa78	locale	claim.name
67118c68-b16b-4ce9-8a8d-60e6d23baa78	String	jsonType.label
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	true	userinfo.token.claim
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	updatedAt	user.attribute
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	true	id.token.claim
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	true	access.token.claim
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	updated_at	claim.name
a960a2c8-b2f7-4f39-83b4-3cd8906b967b	String	jsonType.label
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	true	userinfo.token.claim
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	email	user.attribute
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	true	id.token.claim
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	true	access.token.claim
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	email	claim.name
329b29c7-99ae-46c6-ac2c-fc6cdaa26828	String	jsonType.label
5eec645d-54ef-4d90-82cf-3f903a0130c0	true	userinfo.token.claim
5eec645d-54ef-4d90-82cf-3f903a0130c0	emailVerified	user.attribute
5eec645d-54ef-4d90-82cf-3f903a0130c0	true	id.token.claim
5eec645d-54ef-4d90-82cf-3f903a0130c0	true	access.token.claim
5eec645d-54ef-4d90-82cf-3f903a0130c0	email_verified	claim.name
5eec645d-54ef-4d90-82cf-3f903a0130c0	boolean	jsonType.label
c1eadf18-6ff3-4901-8b66-265b39771cb7	formatted	user.attribute.formatted
c1eadf18-6ff3-4901-8b66-265b39771cb7	country	user.attribute.country
c1eadf18-6ff3-4901-8b66-265b39771cb7	postal_code	user.attribute.postal_code
c1eadf18-6ff3-4901-8b66-265b39771cb7	true	userinfo.token.claim
c1eadf18-6ff3-4901-8b66-265b39771cb7	street	user.attribute.street
c1eadf18-6ff3-4901-8b66-265b39771cb7	true	id.token.claim
c1eadf18-6ff3-4901-8b66-265b39771cb7	region	user.attribute.region
c1eadf18-6ff3-4901-8b66-265b39771cb7	true	access.token.claim
c1eadf18-6ff3-4901-8b66-265b39771cb7	locality	user.attribute.locality
a8514b59-e507-4720-9833-5c6b5544eb99	true	userinfo.token.claim
a8514b59-e507-4720-9833-5c6b5544eb99	phoneNumber	user.attribute
a8514b59-e507-4720-9833-5c6b5544eb99	true	id.token.claim
a8514b59-e507-4720-9833-5c6b5544eb99	true	access.token.claim
a8514b59-e507-4720-9833-5c6b5544eb99	phone_number	claim.name
a8514b59-e507-4720-9833-5c6b5544eb99	String	jsonType.label
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	true	userinfo.token.claim
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	phoneNumberVerified	user.attribute
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	true	id.token.claim
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	true	access.token.claim
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	phone_number_verified	claim.name
b76cbf85-2af6-4d5c-ba17-fec56ba60b5a	boolean	jsonType.label
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	true	multivalued
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	foo	user.attribute
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	true	access.token.claim
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	realm_access.roles	claim.name
61bbb5c1-7fa7-4598-9707-bfc7b9cb15ae	String	jsonType.label
e7809fb0-2602-469f-a1e0-09c69a01b746	true	multivalued
e7809fb0-2602-469f-a1e0-09c69a01b746	foo	user.attribute
e7809fb0-2602-469f-a1e0-09c69a01b746	true	access.token.claim
e7809fb0-2602-469f-a1e0-09c69a01b746	resource_access.${client_id}.roles	claim.name
e7809fb0-2602-469f-a1e0-09c69a01b746	String	jsonType.label
5cff87a0-6c73-4963-942f-210e0a90f6f8	true	userinfo.token.claim
5cff87a0-6c73-4963-942f-210e0a90f6f8	username	user.attribute
5cff87a0-6c73-4963-942f-210e0a90f6f8	true	id.token.claim
5cff87a0-6c73-4963-942f-210e0a90f6f8	true	access.token.claim
5cff87a0-6c73-4963-942f-210e0a90f6f8	upn	claim.name
5cff87a0-6c73-4963-942f-210e0a90f6f8	String	jsonType.label
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	true	multivalued
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	foo	user.attribute
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	true	id.token.claim
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	true	access.token.claim
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	groups	claim.name
34a62626-0ba7-4d0e-9b8e-0cf3a9ba9c4f	String	jsonType.label
72e252a4-c256-4dc6-bafe-e78b3b0196c9	true	aggregate.attrs
72e252a4-c256-4dc6-bafe-e78b3b0196c9	true	userinfo.token.claim
72e252a4-c256-4dc6-bafe-e78b3b0196c9	true	multivalued
72e252a4-c256-4dc6-bafe-e78b3b0196c9	tenants	user.attribute
72e252a4-c256-4dc6-bafe-e78b3b0196c9	true	id.token.claim
72e252a4-c256-4dc6-bafe-e78b3b0196c9	true	access.token.claim
72e252a4-c256-4dc6-bafe-e78b3b0196c9	tenants	claim.name
72e252a4-c256-4dc6-bafe-e78b3b0196c9	String	jsonType.label
412f4e70-a88a-47d8-97fb-935309a670b3	true	aggregate.attrs
412f4e70-a88a-47d8-97fb-935309a670b3	true	userinfo.token.claim
412f4e70-a88a-47d8-97fb-935309a670b3	true	multivalued
412f4e70-a88a-47d8-97fb-935309a670b3	tenants	user.attribute
412f4e70-a88a-47d8-97fb-935309a670b3	true	id.token.claim
412f4e70-a88a-47d8-97fb-935309a670b3	true	access.token.claim
412f4e70-a88a-47d8-97fb-935309a670b3	tenants	claim.name
412f4e70-a88a-47d8-97fb-935309a670b3	String	jsonType.label
64b7b24c-e00a-4741-98e0-baeb4c0c271d	true	userinfo.token.claim
64b7b24c-e00a-4741-98e0-baeb4c0c271d	id	user.attribute
64b7b24c-e00a-4741-98e0-baeb4c0c271d	false	id.token.claim
64b7b24c-e00a-4741-98e0-baeb4c0c271d	true	access.token.claim
64b7b24c-e00a-4741-98e0-baeb4c0c271d	user_id	claim.name
64b7b24c-e00a-4741-98e0-baeb4c0c271d	String	jsonType.label
7fd25bfa-1678-4071-8e52-c6a305348754	true	userinfo.token.claim
7fd25bfa-1678-4071-8e52-c6a305348754	id	user.attribute
7fd25bfa-1678-4071-8e52-c6a305348754	false	id.token.claim
7fd25bfa-1678-4071-8e52-c6a305348754	true	access.token.claim
7fd25bfa-1678-4071-8e52-c6a305348754	user_id	claim.name
7fd25bfa-1678-4071-8e52-c6a305348754	String	jsonType.label
b589340e-cab0-4dc6-bd8d-c40dffbb0013	clientId	user.session.note
b589340e-cab0-4dc6-bd8d-c40dffbb0013	true	id.token.claim
b589340e-cab0-4dc6-bd8d-c40dffbb0013	true	access.token.claim
b589340e-cab0-4dc6-bd8d-c40dffbb0013	clientId	claim.name
b589340e-cab0-4dc6-bd8d-c40dffbb0013	String	jsonType.label
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	clientHost	user.session.note
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	true	id.token.claim
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	true	access.token.claim
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	clientHost	claim.name
bfe4cbf3-6c4d-4d43-b1da-0bc685afbffa	String	jsonType.label
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	clientAddress	user.session.note
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	true	id.token.claim
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	true	access.token.claim
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	clientAddress	claim.name
b5dc69da-c9b3-4f63-9ef5-4eba4bc9a715	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	360000	360000	86400	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	NONE	2592000	2592000	f	f	c121f7e1-3149-4772-9e37-059206f16a79	360000	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	4d6814b7-cce8-4207-96d9-27ac309e072a	7a700a4e-725c-4248-9571-73ec05c5e75d	78c2df8f-884f-4b75-b0d5-a6bb315bddf5	5596137b-0b93-4603-9aed-2fe26232c2ec	25908ed3-0c2e-4c15-bfa4-c7d4c876ee6c	2592000	f	360000	t	f	49ec3cd3-050b-45e4-88bb-24ad6b4a4eb2	0	f	0	0	3e7a2036-3eee-4b45-8546-a944e704b9ef
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
parRequestUriLifespan	master	360000
oauth2DeviceCodeLifespan	master	600
oauth2DevicePollingInterval	master	600
clientSessionIdleTimeout	master	0
clientSessionMaxLifespan	master	0
clientOfflineSessionIdleTimeout	master	0
clientOfflineSessionMaxLifespan	master	0
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
cibaBackchannelTokenDeliveryMode	master	poll
cibaExpiresIn	master	120
cibaInterval	master	5
cibaAuthRequestedUserHint	master	login_hint
actionTokenGeneratedByAdminLifespan	master	43200
actionTokenGeneratedByUserLifespan	master	1800
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
webAuthnPolicyRpEntityName	master	keycloak
webAuthnPolicySignatureAlgorithms	master	ES256
webAuthnPolicyRpId	master	
webAuthnPolicyAttestationConveyancePreference	master	not specified
webAuthnPolicyAuthenticatorAttachment	master	not specified
webAuthnPolicyRequireResidentKey	master	not specified
webAuthnPolicyUserVerificationRequirement	master	not specified
webAuthnPolicyCreateTimeout	master	0
webAuthnPolicyAvoidSameAuthenticatorRegister	master	false
webAuthnPolicyRpEntityNamePasswordless	master	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	master	ES256
webAuthnPolicyRpIdPasswordless	master	
webAuthnPolicyAttestationConveyancePreferencePasswordless	master	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	master	not specified
webAuthnPolicyRequireResidentKeyPasswordless	master	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	master	not specified
webAuthnPolicyCreateTimeoutPasswordless	master	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	master	false
client-policies.profiles	master	{"profiles":[]}
client-policies.policies	master	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
61fb0d41-9851-4ec5-bd7d-04552647b871	/realms/master/account/*
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	/realms/master/account/*
4ad82c3f-04b6-4d59-826a-e5441fa906dc	/admin/master/console/*
05555d1d-ae31-4af1-aa65-aedd0620af0a	*
c121f7e1-3149-4772-9e37-059206f16a79	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
66d0f7a3-297f-4344-995e-20bdb62c704e	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
be890c94-a75f-4473-a198-b6cd90367cc8	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
21ff52ec-21a7-4068-ac45-f5b82e52f3de	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
1f9f122c-d6f4-47b0-b4b3-10266c405595	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
765252bb-e7e3-4f94-84ca-939587e316f0	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
07ae4c1c-424c-4318-9010-2abcf5db70c5	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
bb0fe12f-0044-4537-a379-8b8445ae34aa	delete_account	Delete Account	master	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
30fa1ffa-2370-4a2e-a12c-f7477f915628	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
91361fa4-165c-4f4f-b094-d9dd57aeedba	Default Policy	A policy that grants access only for users within this realm	js	0	0	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
35c524ca-05b6-456c-8adc-a5f87be9d4a7	Default Permission	A permission that applies to the default resource type	resource	1	0	30fa1ffa-2370-4a2e-a12c-f7477f915628	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
df56e03c-1b10-4b1e-8a58-c546e6c6e2bb	Default Resource	urn:pipelines:resources:default	\N	30fa1ffa-2370-4a2e-a12c-f7477f915628	30fa1ffa-2370-4a2e-a12c-f7477f915628	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
df56e03c-1b10-4b1e-8a58-c546e6c6e2bb	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
9f19a90c-3b8b-4bcc-9ee2-97e21bab9521	4f2af37d-c30e-495d-a6df-9d5f46d17f27
b1fae7fb-0d86-403d-85f1-398a0af8acd4	db8229ee-296f-4d9a-b140-56869f919cd6
b1fae7fb-0d86-403d-85f1-398a0af8acd4	98949ea8-26f7-4af5-8977-3b18884d51bb
b1fae7fb-0d86-403d-85f1-398a0af8acd4	2197198b-e5a9-4bf8-bb25-d296a8f3e047
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
tenants	test	5700519e-2320-4610-b329-3f592565b700	bba4ab46-4e78-4029-8378-c3a0fbd57609
tenants	test	f5416954-cede-47b0-9869-316b29b9d4f6	b2faeee6-a0fa-4970-a97e-80176c57756d
tenants	test	ca993bc3-f128-4d1d-81ba-e2b117004e20	57bea189-fada-4afd-abd3-b412a0e16ba7
tenants	test	45526cca-291a-405e-8234-6088454e18c4	c4db981a-622a-4961-b623-62618a340522
tenants	test	a1e11707-2ebc-492e-8b4b-15b5ff3d8008	71b72507-bb06-4b0d-b27b-a649e1e7ff94
tenants	test	04bd4aaf-6e7b-4696-81ce-369b75e5711c	4b2ce790-1d02-4e98-97d0-607211444f5e
tenants	test	254df759-8b82-4d5d-9587-20c96831a342	cc7dde19-321c-44be-a454-2be248f4c2f5
tenants	test	02336646-f5d0-4670-b111-c140a3ad58b5	45443313-ddde-49d4-b8ea-a61d664c62af
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
f5416954-cede-47b0-9869-316b29b9d4f6	\N	9ce0193e-4172-444e-a6fd-752de2305424	f	t	\N	\N	\N	master	user	1637135675567	\N	0
ca993bc3-f128-4d1d-81ba-e2b117004e20	\N	81628224-32f9-4ca4-aa74-63364751e45e	f	t	\N	\N	\N	master	qweqweqweqwe	1637137091101	\N	0
5700519e-2320-4610-b329-3f592565b700	\N	b9e46fd5-034d-4965-8014-dc4f4e0d931e	f	t	\N	\N	\N	master	some_user	1638182905777	\N	0
02336646-f5d0-4670-b111-c140a3ad58b5	\N	880123e3-293f-47e6-9498-333a38723cfa	f	t	\N	\N	\N	master	admin	1638362379072	\N	0
04bd4aaf-6e7b-4696-81ce-369b75e5711c	\N	fec1eb2c-ab0b-4774-b84c-0cb1fa634b67	f	t	\N	\N	\N	master	viewer	1645543917765	\N	0
45526cca-291a-405e-8234-6088454e18c4	\N	36396592-b871-4d11-92f6-27ee486518be	f	t	\N	\N	\N	master	annotator	1645544502633	\N	0
a1e11707-2ebc-492e-8b4b-15b5ff3d8008	\N	fac868f6-857e-4eac-a9bc-9d483579a4a9	f	t	\N	\N	\N	master	engineer	1645544643436	\N	0
d27e0c7d-6c84-4adb-9069-27f986639979	\N	fddc62c8-7b97-4c5d-bd65-0e1c66c6826c	f	t	\N	\N	\N	master	some_user_1	1645781693065	\N	0
3855eb45-2c11-4b15-8989-257b3a51649c	\N	579bd16c-7314-4fab-87e5-ad8bff30c44b	f	t	\N	\N	\N	master	service-account-pipelines	1646132797521	30fa1ffa-2370-4a2e-a12c-f7477f915628	0
254df759-8b82-4d5d-9587-20c96831a342	\N	3c882b5e-7e78-4403-9cb0-7a7db865d417	t	t	\N	\N	\N	master	skill_hunter	1646910556485	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
3e7a2036-3eee-4b45-8546-a944e704b9ef	f5416954-cede-47b0-9869-316b29b9d4f6
98949ea8-26f7-4af5-8977-3b18884d51bb	f5416954-cede-47b0-9869-316b29b9d4f6
3e7a2036-3eee-4b45-8546-a944e704b9ef	ca993bc3-f128-4d1d-81ba-e2b117004e20
3e7a2036-3eee-4b45-8546-a944e704b9ef	5700519e-2320-4610-b329-3f592565b700
db8229ee-296f-4d9a-b140-56869f919cd6	f5416954-cede-47b0-9869-316b29b9d4f6
3e7a2036-3eee-4b45-8546-a944e704b9ef	02336646-f5d0-4670-b111-c140a3ad58b5
98949ea8-26f7-4af5-8977-3b18884d51bb	02336646-f5d0-4670-b111-c140a3ad58b5
db8229ee-296f-4d9a-b140-56869f919cd6	02336646-f5d0-4670-b111-c140a3ad58b5
3e7a2036-3eee-4b45-8546-a944e704b9ef	04bd4aaf-6e7b-4696-81ce-369b75e5711c
462d29bb-a55e-4e72-80e2-b82f7cd44e11	04bd4aaf-6e7b-4696-81ce-369b75e5711c
13e6b8a3-e0ee-4904-8948-5a9edd0d7ad0	04bd4aaf-6e7b-4696-81ce-369b75e5711c
3e7a2036-3eee-4b45-8546-a944e704b9ef	45526cca-291a-405e-8234-6088454e18c4
462d29bb-a55e-4e72-80e2-b82f7cd44e11	45526cca-291a-405e-8234-6088454e18c4
3e7a2036-3eee-4b45-8546-a944e704b9ef	a1e11707-2ebc-492e-8b4b-15b5ff3d8008
8ba1a1d3-7198-4e1e-91a1-4894523ea0c2	a1e11707-2ebc-492e-8b4b-15b5ff3d8008
3e7a2036-3eee-4b45-8546-a944e704b9ef	d27e0c7d-6c84-4adb-9069-27f986639979
2197198b-e5a9-4bf8-bb25-d296a8f3e047	d27e0c7d-6c84-4adb-9069-27f986639979
3e7a2036-3eee-4b45-8546-a944e704b9ef	3855eb45-2c11-4b15-8989-257b3a51649c
0ac1330f-2fda-4a64-813b-232c8d04e884	3855eb45-2c11-4b15-8989-257b3a51649c
3e7a2036-3eee-4b45-8546-a944e704b9ef	254df759-8b82-4d5d-9587-20c96831a342
2197198b-e5a9-4bf8-bb25-d296a8f3e047	254df759-8b82-4d5d-9587-20c96831a342
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
4ad82c3f-04b6-4d59-826a-e5441fa906dc	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

