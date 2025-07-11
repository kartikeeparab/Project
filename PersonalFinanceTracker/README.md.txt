# 💰 Personal Finance Tracker (SQL Project)

This is a mini project to build a personal finance tracker using **MySQL**. It helps users track their **income and expenses** with clear category mapping and summary insights using SQL queries.

## 🧾 Project Details

- 📂 **Tools Used:** MySQL Workbench, GitHub
- 📊 **Tables:**
  - `Users` – stores user info
  - `Categories` – income & expense types
  - `Income` – user income records
  - `Expenses` – user expense records

## 🧠 SQL Features

- Table relationships using foreign keys
- Data types: `ENUM`, `DATE`, `DECIMAL`
- Aggregations using `SUM`, `GROUP BY`
- Reusable SQL Views:
  - MonthlyExpenseView
  - UserBalanceView
  - TransactionHistoryView
  - ExpenseByCategoryView
  - UserCategoryExpensesView