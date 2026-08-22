# Data Dictionary

## Project: Banking Transaction Analytics & Anomaly Detection System

This document defines every table and column used in the banking analytics warehouse.

---

# 1. Customers Table

**Purpose:** Stores demographic and profile information for every banking customer.

| Column        | Data Type | Description                                       | Example      |
| ------------- | --------- | ------------------------------------------------- | ------------ |
| customer_id   | VARCHAR   | Unique identifier for each customer (Primary Key) | CUST00001    |
| name          | VARCHAR   | Customer full name                                | Mohit Sharma |
| gender        | VARCHAR   | Customer gender                                   | Male         |
| age           | INT       | Customer age in years                             | 27           |
| occupation    | VARCHAR   | Profession of customer                            | Engineer     |
| annual_income | INT       | Estimated yearly income (₹)                       | 850000       |
| city          | VARCHAR   | Customer residence city                           | Chennai      |
| join_date     | DATE      | Date customer joined the bank                     | 2023-04-15   |

**Primary Key:** `customer_id`

---

# 2. Accounts Table

**Purpose:** Stores banking account information linked to customers.

| Column       | Data Type | Description                             | Example    |
| ------------ | --------- | --------------------------------------- | ---------- |
| account_id   | VARCHAR   | Unique account number (Primary Key)     | ACC000125  |
| customer_id  | VARCHAR   | Links account to customer (Foreign Key) | CUST00001  |
| account_type | VARCHAR   | Savings, Current or Credit              | Savings    |
| balance      | DECIMAL   | Current account balance                 | 54230.75   |
| credit_limit | DECIMAL   | Credit limit for credit accounts        | 150000     |
| status       | VARCHAR   | Active or Inactive                      | Active     |
| opened_date  | DATE      | Date account was opened                 | 2022-08-01 |

**Primary Key:** `account_id`

**Foreign Key:** `customer_id → customers.customer_id`

---

# 3. Transactions Table (Fact Table)

**Purpose:** Stores every financial transaction performed by customers.

| Column               | Data Type | Description                                | Example             |
| -------------------- | --------- | ------------------------------------------ | ------------------- |
| transaction_id       | VARCHAR   | Unique transaction ID                      | TXN0004521          |
| account_id           | VARCHAR   | Account used for transaction               | ACC000125           |
| merchant_id          | VARCHAR   | Merchant receiving payment                 | MER015              |
| branch_id            | VARCHAR   | Branch processing transaction              | BR007               |
| transaction_datetime | DATETIME  | Date & time of transaction                 | 2025-03-14 18:42:10 |
| transaction_type     | VARCHAR   | Debit or Credit                            | Debit               |
| amount               | DECIMAL   | Transaction value (₹)                      | 1250.50             |
| payment_method       | VARCHAR   | UPI, Debit Card, Credit Card, NEFT, IMPS   | UPI                 |
| channel              | VARCHAR   | Mobile Banking, ATM, POS, Internet Banking | Mobile Banking      |
| opening_balance      | DECIMAL   | Balance before transaction                 | 45200.80            |
| closing_balance      | DECIMAL   | Balance after transaction                  | 43950.30            |
| status               | VARCHAR   | Success or Failed                          | Success             |
| reference_no         | VARCHAR   | Bank reference number                      | REF9845621478       |

**Primary Key:** `transaction_id`

**Foreign Keys:**

* `account_id → accounts.account_id`
* `merchant_id → merchants.merchant_id`
* `branch_id → branches.branch_id`

---

# 4. Merchants Table

**Purpose:** Stores merchant and business category information.

| Column        | Data Type | Description               | Example   |
| ------------- | --------- | ------------------------- | --------- |
| merchant_id   | VARCHAR   | Merchant ID (Primary Key) | MER015    |
| merchant_name | VARCHAR   | Business name             | Amazon    |
| category      | VARCHAR   | Merchant category         | Shopping  |
| mcc_code      | VARCHAR   | Merchant Category Code    | 5311      |
| city          | VARCHAR   | Merchant operating city   | Bengaluru |

**Primary Key:** `merchant_id`

---

# 5. Branches Table

**Purpose:** Stores geographical information about bank branches.

| Column      | Data Type | Description             | Example        |
| ----------- | --------- | ----------------------- | -------------- |
| branch_id   | VARCHAR   | Branch ID (Primary Key) | BR007          |
| branch_name | VARCHAR   | Branch name             | Chennai Branch |
| city        | VARCHAR   | Branch city             | Chennai        |
| region      | VARCHAR   | Region of India         | South          |

**Primary Key:** `branch_id`

---

# Relationship Summary

| Parent Table | Child Table  | Relationship                            |
| ------------ | ------------ | --------------------------------------- |
| Customers    | Accounts     | One customer can own multiple accounts  |
| Accounts     | Transactions | One account can have many transactions  |
| Merchants    | Transactions | One merchant receives many transactions |
| Branches     | Transactions | One branch processes many transactions  |

The `transactions` table is the **Fact Table**, while Customers, Accounts, Merchants, and Branches are **Dimension Tables** used for analytical reporting.
