Create database OnlineBookstore;

Use OnlineBookstore;

-- create Table
Drop Table IF EXISTS Books ;
CREATE TABLE Books (
book_ID serial primary KEY ,
Title VARCHAR (100),
Author VARCHAR (100),
Genre VARCHAR (50),
Published_year INT ,
Price NUMERIC (10,2),
Stock INT 
);

select*from Books;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
customer_id serial PRIMARY KEY ,
Name VARCHAR (100),
Email VARCHAR (100),
Country VARCHAR(150)
);

select*from customers;

DROP TABLE IF EXISTS orders ;
CREATE TABLE orders (
order_id serial PRIMARY KEY ,
customer_ID INT REFERENCES customers(customer_id),
book_ID INT  REFERENCES books(book_ID),
order_date DATE ,
quantity INT ,
Total_Amount Numeric(10,2)
);

select*from orders;

-- 1) Retrieve all books in the "fiction: genre :

SELECT*FROM Books
WHERE Genre ="Fiction";

-- 2) Find books published after the year 1950 :

SELECT *FROM Books
WHERE published_year >1950 ;

-- 3) List all customer from the canda :

SELECT * FROM customers
WHERE country ='canda';

-- 4)  show orders placed in november 2023 ;

SELECT * FROM orders
WHERE order_date BETWEEN "2023-11-01" AND "2023-11-30";

-- 5)  Retrieve the total stock of books available :

SELECT SUM(Stock)  AS total_stock FROM books;

-- 6) Find the datails of the most expensive book :

SELECT *FROM Books 
ORDER BY price DESC 
LIMIT 1;

-- 7) show all customers who ordered more than 1 quantity   of a book:

SELECT *FROM orders 
WHERE quantity >1;

-- 8) retrive all orders where the total amount exceeds $20:

SELECT *FROM Orders
WHERE total_amount >20;

-- 9) List all geners available in the books table :

SELECT DISTINCT genre FROM books;

-- 10) Find the book with the lowest stock :

SELECT *FROM books 
ORDER BY stock ASC 
LIMIT 1 ;

-- 11 ) calculate the books total revenue generated from all orders :

SELECT SUM(total_amount) AS Revenue FROM orders ;

-- Advance 

-- 1) Retrieve the total number of books sold for each genre:

SELECT * FROM ORDERS;

SELECT 
    b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM
    Orders o
        JOIN
    Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT 
    AVG(price) AS Average_Price
FROM
    Books
WHERE
    Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT 
    o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id , c.name
HAVING COUNT(Order_id) >= 2;

-- 4) Find the most frequently ordered book:
SELECT 
    o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM
    orders o
        JOIN
    books b ON o.book_id = b.book_id
GROUP BY o.book_id , b.title
ORDER BY ORDER_COUNT DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT 
    *
FROM
    books
WHERE
    genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT 
    b.author, SUM(o.quantity) AS Total_Books_Sold
FROM
    orders o
        JOIN
    books b ON o.book_id = b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT
    c.city, total_amount
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT 
    c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id , c.name
ORDER BY Total_spent DESC
LIMIT 1;












