USE ecommerce_analysis;
-- ============================================
-- E-COMMERCE SQL ANALYSIS
-- Author: Yash Sachin Hole
-- Database: MySQL
-- ============================================
-- ============================================
-- 1. CUSTOMER ANALYSIS
-- ============================================

-- View all customers
SELECT *
FROM customers;

-- Customers from Maharashtra
SELECT customer_name, city, state
FROM customers
WHERE state = 'Maharashtra';

-- Number of customers from Maharashtra
SELECT COUNT(customer_id) AS total_customers
FROM customers
WHERE state = 'Maharashtra';

-- Customers by state
SELECT
    state,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;
-- ============================================
-- 2. ORDER ANALYSIS
-- ============================================

-- Total orders
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Orders by status
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status;

-- Orders by payment method
SELECT
    payment_method,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Completed orders
SELECT COUNT(order_id) AS completed_orders
FROM orders
WHERE order_status = 'Completed';
-- ============================================
-- 3. REVENUE ANALYSIS
-- ============================================

-- Total revenue including all order statuses
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;

-- Revenue from completed orders
SELECT
    SUM(oi.quantity * oi.unit_price) AS completed_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';

-- Average Order Value
SELECT
    SUM(oi.quantity * oi.unit_price) /
    COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';
-- ============================================
-- 4. CUSTOMER SPENDING ANALYSIS
-- ============================================

-- Customers ranked by spending
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spending,
    RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending;
-- ============================================
-- 5. PRODUCT ANALYSIS
-- ============================================

-- Products with highest quantity sold
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;

-- Products generating the highest revenue
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;
-- ============================================
-- 6. CATEGORY ANALYSIS
-- ============================================

SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;
-- ============================================
-- 7. MONTHLY REVENUE ANALYSIS
-- ============================================

SELECT
    MONTHNAME(o.order_date) AS month_name,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    MONTH(o.order_date),
    MONTHNAME(o.order_date)
ORDER BY MONTH(o.order_date);
-- ============================================
-- 8. REPEAT CUSTOMER ANALYSIS
-- ============================================

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
-- ============================================
-- 9. SUBQUERY ANALYSIS
-- ============================================

-- Average product price
SELECT
    AVG(price) AS average_price
FROM products;

-- Products priced above average
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;
-- ============================================
-- 10. CTE ANALYSIS
-- ============================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spending
FROM customer_spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_spending
)
ORDER BY total_spending DESC;
-- ============================================
-- 11. TOP 3 CUSTOMERS
-- ============================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
),
customer_ranking AS (
    SELECT
        customer_name,
        total_spending,
        RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
    FROM customer_spending
)
SELECT
    customer_name,
    total_spending,
    spending_rank
FROM customer_ranking
WHERE spending_rank <= 3
ORDER BY spending_rank;