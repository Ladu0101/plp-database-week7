--Question 1: Achieving First Normal Form (1NF)

CREATE DATABASE normaliztion_assignment;
USE normalization_assignment;

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);
INSERT INTO ProductDetail_1NF
    (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

SELECT * FROM productdetail_1nf
ORDER BY OrderID, Product;

Explanation: Every row now contains one product only. 
Order 101 appears twice because it contains two products. 
Order 102 appears three times because it contains three products. 
This table satisfies the 1NF requirement.

  
--Question 2: Achieving Second Normal Form (2NF)

The given OrderDetails table uses a composite primary key: (OrderID, Product). A composite key is a primary key made from more than one column.
CustomerName depends only on OrderID. It does not depend on the complete combination of OrderID and Product. This is a partial dependency, which violates 2NF.
The solution is to store order/customer information in an Orders table, and product/quantity information in an OrderItems table.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
  );
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
ORDER BY Orders.OrderID, OrderItems.Product;



