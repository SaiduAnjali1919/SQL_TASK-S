CREATE DATABASE EcommerceDB;
USE EcommerceDB;
SHOW DATABASES;

CREATE TABLE Customers
(
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address TEXT,
    date_joined DATE
);

DESC Customers; 

CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    shipping_address TEXT,
    payment_status VARCHAR(20),

    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

DESC Orders;

CREATE TABLE Categories
(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    description TEXT
);

CREATE TABLE Products
(
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    stock_quantity INT,
    category_id INT,

    FOREIGN KEY (category_id)
    REFERENCES Categories(category_id)
); 

CREATE TABLE Order_Items
(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);

SHOW TABLES;

INSERT INTO Customers
VALUES
(1,'Anjali','Saidu','anjali@gmail.com','9876543210','Kakinada','2025-01-10'),

(2,'Varshini','Reddy','varshini@gmail.com','9876543211','Hyderabad','2025-02-15'),

(3,'Sravya','Kumar','sravya@gmail.com','9876543212','Eluru','2025-03-12'),

(4,'Monika','Rao','monika@gmail.com','9876543213','Vijayawada','2025-04-08'),

(5,'Lavanya','Naidu','lavanya@gmail.com','9876543214','Rajahmundry','2025-05-20');

SELECT * FROM Customers;

INSERT INTO Categories
VALUES
(1,'Electronics','Electronic Devices'),

(2,'Books','Educational Books'),

(3,'Clothing','Fashion Items');

INSERT INTO Products
VALUES

(101,'Laptop','Dell Laptop',55000,10,1),

(102,'Mobile','Samsung Phone',25000,20,1),

(103,'SQL Book','Database Book',700,50,2),

(104,'T-Shirt','Cotton Shirt',500,100,3),

(105,'Headphones','Bluetooth Headphones',2000,15,1);

INSERT INTO Orders
VALUES

(1001,1,'2025-06-01',55700,'Kakinada','Paid'),

(1002,2,'2025-06-03',25000,'Hyderabad','Paid'),

(1003,3,'2025-06-10',1200,'Eluru','Pending'),

(1004,1,'2025-06-15',2500,'Kakinada','Paid');

INSERT INTO Order_Items
VALUES

(1,1001,101,1,55000),

(2,1001,103,1,700),

(3,1002,102,1,25000),

(4,1003,103,2,700),

(5,1004,105,1,2000),

(6,1004,104,1,500);

SELECT * FROM Customers;

SELECT * FROM Categories;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT * FROM Order_Items; 

SELECT *
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id; 

SELECT
    Customers.first_name,
    Customers.last_name,
    Orders.order_id,
    Orders.order_date,
    Orders.total_amount,
    Orders.payment_status
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE Customers.first_name = 'Anjali';

SELECT
    Customers.first_name,
    Customers.address,
    Orders.order_id,
    Orders.order_date,
    Orders.total_amount
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE Customers.address = 'Kakinada';

SELECT
    Products.product_id,
    Products.name,
    Categories.category_name
FROM Products
INNER JOIN Categories
ON Products.category_id = Categories.category_id;

SELECT
    Customers.first_name,
    Products.name,
    Products.description,
    Order_Items.quantity
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
INNER JOIN Products
ON Order_Items.product_id = Products.product_id
WHERE Customers.first_name = 'Anjali';

SELECT
    Orders.order_id,
    Order_Items.product_id,
    Order_Items.quantity,
    Orders.total_amount
FROM Orders
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id;

SELECT
    Products.name,
    SUM(Order_Items.quantity) AS Total_Items_Ordered
FROM Products
INNER JOIN Order_Items
ON Products.product_id = Order_Items.product_id
GROUP BY Products.name;

SELECT
    Customers.first_name,
    Customers.last_name,
    Orders.order_id,
    Orders.total_amount
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
ORDER BY Orders.total_amount DESC
LIMIT 1;

SELECT
    Customers.first_name,
    Customers.last_name,
    Products.name
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
INNER JOIN Products
ON Order_Items.product_id = Products.product_id
WHERE Products.name = 'SQL Book';

SELECT
    Products.name,
    SUM(Order_Items.quantity * Order_Items.item_price) AS Total_Revenue
FROM Products
INNER JOIN Order_Items
ON Products.product_id = Order_Items.product_id
GROUP BY Products.name;

SELECT
    Categories.category_name,
    Products.name,
    SUM(Order_Items.quantity) AS Total_Sold
FROM Categories
INNER JOIN Products
ON Categories.category_id = Products.category_id
INNER JOIN Order_Items
ON Products.product_id = Order_Items.product_id
GROUP BY Categories.category_name, Products.name
ORDER BY Categories.category_name, Total_Sold DESC;

SELECT
    Orders.order_id,
    Products.name,
    Order_Items.quantity
FROM Orders
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
INNER JOIN Products
ON Order_Items.product_id = Products.product_id;

SELECT
    Customers.first_name,
    AVG(Order_Items.quantity) AS Average_Items
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
GROUP BY Customers.first_name;

SELECT
    Customers.first_name,
    Customers.last_name
FROM Customers
LEFT JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE Orders.order_id IS NULL;

SELECT
    Customers.first_name,
    Orders.order_id,
    SUM(Order_Items.quantity) AS Total_Items
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
GROUP BY Customers.first_name, Orders.order_id
HAVING SUM(Order_Items.quantity) > 5;

SELECT
    Categories.category_name,
    SUM(Order_Items.quantity) AS Total_Products_Sold
FROM Categories
INNER JOIN Products
ON Categories.category_id = Products.category_id
INNER JOIN Order_Items
ON Products.product_id = Order_Items.product_id
GROUP BY Categories.category_name;

SELECT
    Orders.order_id,
    Orders.order_date,
    Products.name,
    Order_Items.quantity
FROM Orders
INNER JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
INNER JOIN Products
ON Order_Items.product_id = Products.product_id
WHERE Orders.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT DISTINCT
    Products.product_id,
    Products.name,
    Products.stock_quantity
FROM Products
INNER JOIN Order_Items
ON Products.product_id = Order_Items.product_id
WHERE Products.stock_quantity = 0;

SELECT DISTINCT
    Products.product_id,
    Products.name
FROM Products
LEFT JOIN Order_Items
ON Products.product_id = Order_Items.product_id
LEFT JOIN Orders
ON Order_Items.order_id = Orders.order_id
WHERE Orders.order_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
   OR Orders.order_date IS NULL;
   
SELECT
    Customers.first_name,
    Customers.last_name,
    Orders.order_id,
    Orders.total_amount
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE Orders.total_amount > 20000;

SELECT
    Customers.customer_id,
    Customers.first_name,
    Customers.last_name,
    Customers.email,
    Customers.phone_number,
    SUM(Orders.total_amount) AS Total_Sales
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id
GROUP BY
    Customers.customer_id,
    Customers.first_name,
    Customers.last_name,
    Customers.email,
    Customers.phone_number;