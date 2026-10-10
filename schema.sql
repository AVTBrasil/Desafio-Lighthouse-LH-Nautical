CREATE TABLE purchase_orders (
    id BIGINT,
    po_number VARCHAR,
    supplier_id BIGINT,
    buyer_id BIGINT,
    destination_location_id BIGINT,
    status VARCHAR,
    currency VARCHAR,
    subtotal NUMERIC,
    total NUMERIC,
    placed_at TIMESTAMP,
    expected_delivery_at VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE locations (
    id BIGINT,
    name VARCHAR,
    location_type VARCHAR,
    postal_code VARCHAR,
    street VARCHAR,
    number BIGINT,
    complement VARCHAR,
    district VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE returns (
    id BIGINT,
    return_number VARCHAR,
    order_id BIGINT,
    customer_id BIGINT,
    received_at_location_id BIGINT,
    status VARCHAR,
    reason VARCHAR,
    total_refund_amount NUMERIC,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE return_items (
    id BIGINT,
    return_id BIGINT,
    order_item_id BIGINT,
    quantity NUMERIC,
    action VARCHAR,
    exchange_variant_id VARCHAR,
    unit_refund_amount NUMERIC
);

CREATE TABLE payments (
    id BIGINT,
    order_id BIGINT,
    method VARCHAR,
    installments BIGINT,
    amount NUMERIC,
    status VARCHAR,
    paid_at VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE addresses (
    id BIGINT,
    customer_id BIGINT,
    address_type VARCHAR,
    postal_code VARCHAR,
    street VARCHAR,
    number BIGINT,
    complement VARCHAR,
    district VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    is_primary VARCHAR
);

CREATE TABLE customers (
    id BIGINT,
    person_type VARCHAR,
    legal_name VARCHAR,
    trade_name VARCHAR,
    tax_id BIGINT,
    state_registration VARCHAR,
    email VARCHAR,
    phone VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE orders (
    id BIGINT,
    order_number VARCHAR,
    channel VARCHAR,
    customer_id BIGINT,
    salesperson_id VARCHAR,
    location_id BIGINT,
    status VARCHAR,
    subtotal NUMERIC,
    discount_amount NUMERIC,
    total NUMERIC,
    placed_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE order_items (
    id BIGINT,
    order_id BIGINT,
    product_variant_id BIGINT,
    quantity BIGINT,
    unit_price NUMERIC,
    icms_rate NUMERIC,
    ipi_rate NUMERIC,
    line_total NUMERIC
);

CREATE TABLE brands (
    id BIGINT,
    name VARCHAR,
    country VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE fiscal_invoices (
    id BIGINT,
    order_id BIGINT,
    nfe_number VARCHAR,
    nfe_access_key BIGINT,
    series BIGINT,
    issued_at TIMESTAMP,
    status VARCHAR,
    total_amount NUMERIC,
    xml_storage_uri VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE product_suppliers (
    product_variant_id BIGINT,
    supplier_id BIGINT,
    supplier_sku VARCHAR,
    last_quoted_cost NUMERIC,
    lead_time_days BIGINT,
    is_preferred VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE goods_receipts (
    id BIGINT,
    purchase_order_id BIGINT,
    received_by_employee_id BIGINT,
    received_at TIMESTAMP,
    notes VARCHAR,
    created_at TIMESTAMP
);

CREATE TABLE goods_receipt_items (
    id BIGINT,
    goods_receipt_id BIGINT,
    purchase_order_item_id BIGINT,
    quantity_received NUMERIC
);

CREATE TABLE categories (
    id BIGINT,
    name VARCHAR,
    slug VARCHAR,
    parent_category_id VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE stock_levels (
    product_variant_id BIGINT,
    location_id BIGINT,
    quantity_on_hand NUMERIC,
    reorder_point VARCHAR,
    updated_at TIMESTAMP
);

CREATE TABLE product_variants (
    id BIGINT,
    product_id BIGINT,
    sku VARCHAR,
    barcode_ean VARCHAR,
    sale_price NUMERIC,
    cost_price NUMERIC,
    weight_kg NUMERIC,
    icms_rate NUMERIC,
    ipi_rate NUMERIC,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE employees (
    id BIGINT,
    full_name VARCHAR,
    cpf BIGINT,
    email VARCHAR,
    role VARCHAR,
    primary_location_id BIGINT,
    hire_date VARCHAR,
    termination_date VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE products (
    id BIGINT,
    name VARCHAR,
    description VARCHAR,
    brand_id BIGINT,
    category_id BIGINT,
    ncm_code BIGINT,
    unit_of_measure VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE purchase_order_items (
    id BIGINT,
    purchase_order_id BIGINT,
    product_variant_id BIGINT,
    quantity_ordered BIGINT,
    unit_cost NUMERIC,
    line_total NUMERIC
);

CREATE TABLE variant_attribute_values (
    product_variant_id BIGINT,
    attribute_id BIGINT,
    value VARCHAR
);

CREATE TABLE stock_movements (
    id BIGINT,
    product_variant_id BIGINT,
    location_id BIGINT,
    movement_type VARCHAR,
    quantity NUMERIC,
    reference_table VARCHAR,
    reference_id VARCHAR,
    employee_id VARCHAR,
    notes VARCHAR,
    occurred_at TIMESTAMP,
    created_at TIMESTAMP
);

CREATE TABLE attributes (
    id BIGINT,
    name VARCHAR,
    data_type VARCHAR
);

CREATE TABLE suppliers (
    id BIGINT,
    legal_name VARCHAR,
    trade_name VARCHAR,
    country VARCHAR,
    tax_id VARCHAR,
    tax_id_type VARCHAR,
    email VARCHAR,
    phone BIGINT,
    contact_name VARCHAR,
    is_active VARCHAR,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);