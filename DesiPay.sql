-- Google Pay (India) - RDBMS Project

-- Create database
CREATE DATABASE DesiPay;

USE DesiPay;
-- Users Table (Customers)
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone BIGINT(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    upi_id VARCHAR(50) UNIQUE NOT NULL,
    kyc ENUM('Pending', 'Verified', 'Rejected') DEFAULT 'Pending'
);
ALTER TABLE Users AUTO_INCREMENT = 1;


-- Banks Table
CREATE TABLE Banks (
    bank_id INT PRIMARY KEY AUTO_INCREMENT,
    bank_name VARCHAR(100) NOT NULL,
    ifsc_code VARCHAR(11) UNIQUE NOT NULL
);

-- User Bank Accounts
CREATE TABLE UserBankAccounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    bank_id INT,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type ENUM('Savings', 'Current') DEFAULT 'Savings',
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (bank_id) REFERENCES Banks(bank_id)
);

-- Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT NOW(),
    transaction_status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

CREATE TABLE BillPayments (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    bill_type ENUM('Electricity', 'Water', 'Mobile Recharge', 'Internet', 'Gas', 'Other') NOT NULL,
    bill_amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT NOW(),
    status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE CashbackRewards (
    reward_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    transaction_id INT,
    reward_amount DECIMAL(8,2) NOT NULL,
    reward_type ENUM('Cashback', 'Discount', 'Voucher') NOT NULL,
    status ENUM('Pending', 'Credited', 'Expired') DEFAULT 'Pending',
    credited_date DATETIME DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id) 
);



CREATE TABLE SupportTickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    issue_type ENUM('Transaction Issue', 'KYC Issue', 'Account Issue', 'Other') NOT NULL,
    issue_description TEXT NOT NULL,
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') DEFAULT 'Open',
    created_at DATETIME DEFAULT NOW(),
    resolved_at DATETIME DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) 
);

select transaction_id from Transactions;
INSERT INTO Users (name, phone, email, upi_id, kyc) VALUES
('Rajat Pandit',987654321,'rajat@gmail.com','rajat@upi','Verified'),
('Priya Mehta', 87654321, 'priya@gmail.com', 'priya@upi', 'Verified'),
('Amit Kumar', 76543210, 'amit@gmail.com', 'amit@upi', 'Pending'),
('Sneha Gupta', 65432187, 'sneha@gmail.com', 'sneha@upi', 'Verified'),
('Arjun Nair', 91234789, 'arjun@gmail.com', 'arjun@upi', 'Verified'),
('Kavita Rao', 82367891, 'kavita@gmail.com', 'kavita@upi', 'Verified'),
('Ravi Verma', 75678912, 'ravi@gmail.com', 'ravi@upi', 'Pending'),
('Sanya Kapoor', 56789123, 'sanya@gmail.com', 'sanya@upi', 'Verified'),
('Vikas Joshi', 55891234, 'vikas@gmail.com', 'vikas@upi', 'Verified'),
('Pooja Iyer', 46712345, 'pooja@gmail.com', 'pooja@upi', 'Pending'),
('Neha Singh', 96543222, 'neha@gmail.com', 'neha@upi', 'Verified'),
('Rohan Das', 65432111, 'rohan@gmail.com', 'rohan@upi', 'Verified'),
('Meera Patil', 54321022, 'meera@gmail.com', 'meera@upi', 'Pending'),
('Anil Reddy', 43210999, 'anil@gmail.com', 'anil@upi', 'Verified'),
('Sujata Ghosh', 123456777, 'sujata@gmail.com', 'sujata@upi', 'Verified'),
('Kiran Yadav', 34567888, 'kiran@gmail.com', 'kiran@upi', 'Verified'),
('Deepak Choudhary', 75678999, 'deepak@gmail.com', 'deepak@upi', 'Pending'),
('Akash Malhotra', 66789000, 'akash@gmail.com', 'akash@upi', 'Verified'),
('Rita Saxena', 55891111, 'rita@gmail.com', 'rita@upi', 'Verified'),
('Manoj Pillai', 78912222, 'manoj@gmail.com', 'manoj@upi', 'Pending');

select user_id from Users;

-- Banks
INSERT INTO Banks (bank_name, ifsc_code) VALUES
('State Bank of India', 'SBIN0001234'),
('HDFC Bank', 'HDFC0005678'),
('ICICI Bank', 'ICIC0009123'),
('Axis Bank', 'AXIS0004567');

-- User Bank Accounts
INSERT INTO UserBankAccounts (user_id, bank_id, account_number, account_type, balance) VALUES
(1, 1, '123456789012', 'Savings', 50000.00),
(2, 2, '987654321098', 'Savings', 75000.00),
(3, 3, '456789123456', 'Current', 30000.00),
(4, 4, '321654987321', 'Savings', 60000.00),
(5, 1, '111122223333', 'Savings', 40000.00),
(6, 2, '444455556666', 'Current', 85000.00),
(7, 3, '777788889999', 'Savings', 25000.00),
(8, 4, '000011112222', 'Current', 15000.00),
(9, 1, '333344445555', 'Savings', 30000.00),
(10, 2, '666677778888', 'Current', 50000.00),
(11, 3, '222233334444', 'Savings', 52000.00),
(12, 4, '555566667777', 'Current', 46000.00),
(13, 1, '888899990000', 'Savings', 70000.00),
(14, 2, '111100009999', 'Current', 32000.00),
(15, 3, '444433332222', 'Savings', 28000.00),
(16, 4, '777766665555', 'Current', 38000.00),
(17, 1, '999988887777', 'Savings', 47000.00),
(18, 2, '333322221111', 'Current', 56000.00),
(19, 3, '666655554444', 'Savings', 62000.00),
(20, 4, '222211110000', 'Current', 59000.00);
-- Transactions
INSERT INTO Transactions (sender_id, receiver_id, amount, transaction_status) VALUES
(1, 2, 500.00, 'Completed'),
(3, 4, 1000.00, 'Completed'),
(5, 6, 200.00, 'Failed'),
(7, 8, 1500.00, 'Completed'),
(9, 10, 250.00, 'Pending'),
(11, 12, 800.00, 'Completed'),
(13, 14, 1200.00, 'Completed'),
(15, 16, 300.00, 'Pending'),
(17, 18, 700.00, 'Completed'),
(19, 20, 450.00, 'Failed'),
(2, 3, 950.00, 'Completed'),
(4, 5, 1300.00, 'Pending'),
(6, 7, 1800.00, 'Completed'),
(8, 9, 600.00, 'Failed'),
(10, 11, 400.00, 'Completed'),
(12, 13, 900.00, 'Pending'),
(14, 15, 750.00, 'Completed'),
(16, 17, 500.00, 'Completed'),
(18, 19, 1100.00, 'Failed'),
(20, 1, 1350.00, 'Completed');

INSERT INTO BillPayments (user_id, bill_type, bill_amount, status) VALUES
(1, 'Electricity', 1200.00, 'Paid'),
(2, 'Mobile Recharge', 299.00, 'Paid'),
(3, 'Water', 450.00, 'Pending'),
(4, 'Gas', 600.00, 'Failed'),
(5, 'Internet', 999.00, 'Paid'),
(6, 'Electricity', 1450.00, 'Paid'),
(7, 'Mobile Recharge', 349.00, 'Pending'),
(8, 'Water', 500.00, 'Failed'),
(9, 'Gas', 750.00, 'Paid'),
(10, 'Internet', 1100.00, 'Paid'),
(11, 'Electricity', 1350.00, 'Pending'),
(12, 'Mobile Recharge', 249.00, 'Paid'),
(13, 'Water', 400.00, 'Paid'),
(14, 'Gas', 650.00, 'Failed'),
(15, 'Internet', 899.00, 'Paid'),
(16, 'Electricity', 1550.00, 'Paid'),
(17, 'Mobile Recharge', 199.00, 'Failed'),
(18, 'Water', 550.00, 'Paid'),
(19, 'Gas', 800.00, 'Pending'),
(20, 'Internet', 1200.00, 'Paid');

INSERT INTO CashbackRewards (user_id, transaction_id, reward_amount, reward_type, status) VALUES
(1, 1, 50.00, 'Cashback', 'Credited'),
(2, 2, 100.00, 'Discount', 'Pending'),
(3, 3, 25.00, 'Voucher', 'Expired'),
(4, 4, 75.00, 'Cashback', 'Credited'),
(5, 5, 30.00, 'Discount', 'Pending'),
(6, 6, 120.00, 'Cashback', 'Credited'),
(7, 7, 15.00, 'Voucher', 'Expired'),
(8, 8, 90.00, 'Discount', 'Pending'),
(9, 9, 200.00, 'Cashback', 'Credited'),
(10, 10, 40.00, 'Discount', 'Pending'),
(11, 11, 60.00, 'Voucher', 'Expired'),
(12, 12, 110.00, 'Cashback', 'Credited'),
(13, 13, 55.00, 'Discount', 'Pending'),
(14, 14, 35.00, 'Voucher', 'Expired'),
(15, 15, 180.00, 'Cashback', 'Credited'),
(16, 16, 95.00, 'Discount', 'Pending'),
(17, 17, 50.00, 'Voucher', 'Expired'),
(18, 18, 85.00, 'Cashback', 'Credited'),
(19, 19, 70.00, 'Discount', 'Pending'),
(20, 20, 130.00, 'Cashback', 'Credited');


INSERT INTO SupportTickets (user_id, issue_type, issue_description, status, resolved_at) VALUES
(1, 'Transaction Issue', 'Payment of ₹500 failed but amount deducted.', 'Resolved', '2025-02-20 10:30:00'),
(2, 'KYC Issue', 'KYC verification is stuck at pending status.', 'Open', NULL),
(3, 'Account Issue', 'Unable to update registered phone number.', 'In Progress', NULL),
(4, 'Transaction Issue', 'UPI transaction to Flipkart was declined.', 'Closed', '2025-02-18 15:00:00'),
(5, 'Other', 'Facing app crash on login.', 'Open', NULL),
(6, 'Transaction Issue', 'Transaction shows pending for over 24 hours.', 'Resolved', '2025-02-19 14:45:00'),
(7, 'KYC Issue', 'Aadhar verification failed.', 'In Progress', NULL),
(8, 'Account Issue', 'Forgot UPI PIN and cannot reset.', 'Resolved', '2025-02-17 12:10:00'),
(9, 'Transaction Issue', 'Refund not received for a failed transaction.', 'Open', NULL),
(10, 'Other', 'Facing slow app response on Android.', 'Closed', '2025-02-16 09:50:00'),
(11, 'Transaction Issue', 'Unable to scan QR code for payment.', 'Resolved', '2025-02-15 18:20:00'),
(12, 'KYC Issue', 'KYC rejected due to document mismatch.', 'Open', NULL),
(13, 'Account Issue', 'Bank account not linking to Google Pay.', 'In Progress', NULL),
(14, 'Transaction Issue', 'Duplicate payment processed.', 'Closed', '2025-02-14 11:00:00'),
(15, 'Other', 'Error 404 encountered during login.', 'Resolved', '2025-02-13 13:30:00'),
(16, 'Transaction Issue', 'UPI payment stuck in processing.', 'Open', NULL),
(17, 'KYC Issue', 'Unable to upload PAN card for verification.', 'In Progress', NULL),
(18, 'Account Issue', 'Profile details not updating.', 'Resolved', '2025-02-12 16:40:00'),
(19, 'Transaction Issue', 'Payment auto-debited without authorization.', 'Closed', '2025-02-11 10:15:00'),
(20, 'Other', 'Frequent logout issue on iOS.', 'Open', NULL);


-- JOIN Queries
-- Inner Join (List transactions with user details)
SELECT T.transaction_id, U1.name AS sender, U2.name AS receiver, T.amount, T.transaction_status 
FROM Transactions T
INNER JOIN Users U1 ON T.sender_id = U1.user_id
INNER JOIN Users U2 ON T.receiver_id = U2.user_id;

-- Left Join (Users with or without transactions)
SELECT U.name, T.amount, T.transaction_status 
FROM Users U
LEFT JOIN Transactions T ON U.user_id = T.sender_id where transaction_status='Completed';

SELECT 
    t.transaction_id, 
    u1.name AS sender_name, 
    u2.name AS receiver_name, 
    t.amount, 
    t.transaction_status, 
    t.transaction_date
FROM Transactions t
JOIN Users u1 ON t.sender_id = u1.user_id
JOIN Users u2 ON t.receiver_id = u2.user_id;

SELECT 
    st.ticket_id, 
    u.name AS user_name, 
    u.phone, 
    st.issue_type, 
    st.issue_description, 
    st.status, 
    st.created_at
FROM SupportTickets st
JOIN Users u ON st.user_id = u.user_id
WHERE st.status = 'Open';

