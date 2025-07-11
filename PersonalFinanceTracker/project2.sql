CREATE DATABASE PersonalFinance_DB;
USE PersonalFinance_DB;
# user table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE
);
#category table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100),
    Type ENUM('Income', 'Expense') NOT NULL
); 
# income
CREATE TABLE Income (
    IncomeID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    CategoryID INT,
    Amount DECIMAL(10,2),
    IncomeDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
#expense
CREATE TABLE Expenses (
    ExpenseID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    CategoryID INT,
    Amount DECIMAL(10,2),
    ExpenseDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Users (Name, Email) VALUES
('Kartikee Parab', 'kartikee@gmail.com'),
('Swati Shah', 'swati@gmail.com'),
('Hardik Joshi', 'hardik@gmail.com'),
('Neha Sharma', 'neha@gmail.com'),
('Aman Verma', 'aman@gmail.com'),
('Riya Mehra', 'riya@gmail.com'),
('Rahul Kapoor', 'rahul@gmail.com'),
('Vivek Singh', 'vivek@gmail.com'),
('Ishita Rao', 'ishita@gmail.com'),
('Anjali Desai', 'anjali@gmail.com');

INSERT INTO Categories (CategoryName, Type) VALUES
('Salary', 'Income'),
('Freelancing', 'Income'),
('Bonus', 'Income'),
('Rent', 'Expense'),
('Groceries', 'Expense'),
('Transport', 'Expense'),
('Internet', 'Expense'),
('Dining Out', 'Expense'),
('Utilities', 'Expense'),
('Shopping', 'Expense');


INSERT INTO Income (UserID, CategoryID, Amount, IncomeDate) VALUES
(1, 1, 50000, '2024-06-01'),
(2, 1, 45000, '2024-06-03'),
(3, 2, 20000, '2024-06-05'),
(4, 1, 40000, '2024-06-06'),
(5, 3, 5000,  '2024-06-07'),
(6, 1, 47000, '2024-06-08'),
(7, 2, 15000, '2024-06-10'),
(8, 3, 6000,  '2024-06-12'),
(9, 1, 48000, '2024-06-14'),
(10,2, 18000, '2024-06-15');

INSERT INTO Expenses (UserID, CategoryID, Amount, ExpenseDate) VALUES
(1, 4, 15000, '2024-06-02'),   
(1, 5, 4000,  '2024-06-04'),   
(2, 6, 2500,  '2024-06-05'),   
(3, 7, 1200,  '2024-06-06'),   
(4, 8, 1800,  '2024-06-07'),   
(5, 9, 2200,  '2024-06-08'),   
(6, 10,3000,  '2024-06-09'),   
(7, 5, 3700,  '2024-06-10'),
(8, 4, 13000, '2024-06-11'),
(9, 6, 2800,  '2024-06-12');

#Show Each User’s Income, Expense, and Balance
SELECT 
    Users.Name,
    SUM(Income.Amount) AS TotalIncome,
    SUM(Expenses.Amount) AS TotalExpense,
    (SUM(Income.Amount) - SUM(Expenses.Amount)) AS Balance
FROM Users
LEFT JOIN Income ON Users.UserID = Income.UserID
LEFT JOIN Expenses ON Users.UserID = Expenses.UserID
GROUP BY Users.UserID;

#Monthly Total Expenses
CREATE  VIEW MonthlyExpenseView AS
SELECT 
    DATE_FORMAT(ExpenseDate, '%Y-%m') AS Month,
    SUM(Amount) AS TotalExpense
FROM Expenses
GROUP BY Month
ORDER BY Month;

SELECT * FROM MonthlyExpenseView;

#Top Spending Categories
CREATE  VIEW ExpenseByCategoryView AS
SELECT 
    Categories.CategoryName,
    SUM(Expenses.Amount) AS TotalSpent
FROM Expenses
JOIN Categories ON Expenses.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName
ORDER BY TotalSpent DESC;

SELECT * FROM ExpenseByCategoryView;

CREATE VIEW UserBalanceView AS
SELECT 
    Users.Name,
    SUM(Income.Amount) AS TotalIncome,
    SUM(Expenses.Amount) AS TotalExpense,
    (SUM(Income.Amount) - SUM(Expenses.Amount)) AS Balance
FROM Users
LEFT JOIN Income ON Users.UserID = Income.UserID
LEFT JOIN Expenses ON Users.UserID = Expenses.UserID
GROUP BY Users.UserID;

SELECT * FROM UserBalanceView;

#  spending pattern for each user by category.
CREATE VIEW UserCategoryExpensesView AS
SELECT 
    Users.Name AS UserName,
    Categories.CategoryName,
    SUM(Expenses.Amount) AS TotalSpent
FROM Expenses
JOIN Users ON Expenses.UserID = Users.UserID
JOIN Categories ON Expenses.CategoryID = Categories.CategoryID
GROUP BY Users.Name, Categories.CategoryName
ORDER BY Users.Name;

SELECT * FROM UserCategoryExpensesView;

#Create TransactionHistoryView (For importing full transaction list )

CREATE VIEW TransactionHistoryView AS
SELECT 
    Users.Name AS UserName,
    'Income' AS Type,
    Categories.CategoryName,
    Income.Amount,
    Income.IncomeDate AS Date
FROM Income
JOIN Users ON Income.UserID = Users.UserID
JOIN Categories ON Income.CategoryID = Categories.CategoryID

UNION ALL

SELECT 
    Users.Name AS UserName,
    'Expense' AS Type,
    Categories.CategoryName,
    Expenses.Amount,
    Expenses.ExpenseDate AS Date
FROM Expenses
JOIN Users ON Expenses.UserID = Users.UserID
JOIN Categories ON Expenses.CategoryID = Categories.CategoryID;

SELECT * FROM TransactionHistoryView;