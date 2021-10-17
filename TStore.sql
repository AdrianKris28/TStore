CREATE DATABASE Tstore;
USE Tstore;

Drop database Tstore;

DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS vendor;
DROP TABLE IF EXISTS clothes_category;
DROP TABLE IF EXISTS clothes;
DROP TABLE IF EXISTS salesTrannsaction;
DROP TABLE IF EXISTS purchaseTransaction;
DROP TABLE IF EXISTS purchaseBasket;
DROP TABLE IF EXISTS salesBasket;

CREATE TABLE staff(
	staffID VARCHAR(255) CHECK(staffID LIKE 'ST[0-9][0-9][0-9]' AND LEN(staffID)=5) PRIMARY KEY,
	staffName VARCHAR(255) NOT NULL,
	staffAddress VARCHAR(255) NOT NULL,
	staffPhone VARCHAR(255) CHECK(staffPhone LIKE'08%') NOT NULL,
	staffGender VARCHAR(255) NOT NULL,
	staffEmail VARCHAR(255) NOT NULL,
	staffSalary INT CHECK(staffSalary >= 3000000) NOT NULL
);

CREATE TABLE customer(
	customerID VARCHAR(255) CHECK(customerID LIKE 'CU[0-9][0-9][0-9]' AND LEN(customerID)=5)PRIMARY KEY,
	customerName VARCHAR(255) NOT NULL,
	customerAddress VARCHAR(255) NOT NULL,
	customerPhone VARCHAR(255) CHECK(customerPhone LIKE'08%') NOT NULL, 
	customerGender VARCHAR(255) NOT NULL,
	customerEmail VARCHAR(255) NOT NULL
);

CREATE TABLE vendor(
	vendorID VARCHAR(255) CHECK(vendorID LIKE 'VE[0-9][0-9][0-9]' AND LEN(vendorID)=5) PRIMARY KEY,
	vendorName VARCHAR(255) NOT NULL,
	vendorAddress VARCHAR(255) NOT NULL,
	vendorPhone VARCHAR(255) CHECK (vendorPhone LIKE '08%') NOT NULL, 
	vendorEmail VARCHAR(255) NOT NULL
);

CREATE TABLE salesTransaction(
	salesID VARCHAR(255) CHECK(salesID LIKE 'SA[0-9][0-9][0-9]'AND LEN(salesID)=5) PRIMARY KEY,
	salesDate datetime CHECK(DATEDIFF(HH, salesDate, GETDATE()) > 1) NOT NULL, 
	staffID VARCHAR(255) FOREIGN KEY(staffID) REFERENCES staff(staffID) ON DELETE SET NULL,
	customerID VARCHAR(255) FOREIGN KEY(customerID) REFERENCES customer(customerID) ON DELETE SET NULL
);


CREATE TABLE purchaseTransaction(
	transactionID VARCHAR(255) CHECK(transactionID LIKE 'PU[0-9][0-9][0-9]'AND LEN(transactionID)=5) PRIMARY KEY,
	transactionDate datetime CHECK(DATEDIFF(HH, transactionDate, GETDATE()) > 1) NOT NULL,
	staffID VARCHAR(255) FOREIGN KEY(staffID) REFERENCES staff(staffID),
	vendorID VARCHAR(255) FOREIGN KEY(vendorID) REFERENCES vendor(vendorID)
);

CREATE TABLE clothes_category(
	categoryID VARCHAR(255) CHECK(categoryID LIKE 'CA[0-9][0-9][0-9]' AND LEN(categoryID)=5) PRIMARY KEY,
	categoryName VARCHAR(255) NOT NULL
);

CREATE TABLE clothes(
	clothesID VARCHAR(255) CHECK(clothesID LIKE 'CL[0-9][0-9][0-9]' AND LEN(clothesID) = 5) PRIMARY KEY,
	clothesBrand VARCHAR(255) CHECK(LEN(clothesBrand)>=5) NOT NULL,
	clothesCategory VARCHAR(255) FOREIGN KEY(clothesCategory) REFERENCES clothes_category(categoryID) ON DELETE SET NULL,
	clothesPrice INT CHECK(clothesPrice >= 20000) NOT NULL,
	clothesStock INT NOT NULL,
);

CREATE TABLE salesBasket(
	salesID VARCHAR(255) FOREIGN KEY(salesID) REFERENCES salesTransaction(salesID) ON DELETE CASCADE,
	clothesID VARCHAR(255) FOREIGN KEY(clothesID) REFERENCES clothes(clothesID) ON DELETE CASCADE,
	quantity INT NOT NULL,
	PRIMARY KEY(salesID, clothesID),
);


CREATE TABLE purchaseBasket(
	transactionID VARCHAR(255) FOREIGN KEY(transactionID) REFERENCES purchaseTransaction(transactionID) ON DELETE CASCADE,
	clothesID VARCHAR(255)FOREIGN KEY(clothesID) REFERENCES clothes(clothesID) ON DELETE CASCADE,
	quantity INT NOT NULL,
	PRIMARY KEY(transactionID, clothesID),
);



INSERT INTO staff VALUES 
	('ST001', 'Herman', 'JL Syahdan 67', '081212120001', 'Male', 'Herman@Tstore.com', 6000000),
	('ST002', 'Kevin', 'JL Jeruk 12', '081212120002', 'Male', 'Kevin@Tstore.com', 3000000),
	('ST003', 'Valencia', 'JL Kijang 32', '081212120003', 'Female', 'Valencia@Tstore.com', 4000000),
	('ST004', 'Kelvin', 'JL Syahdan 53', '081212120004', 'Male', 'Kelvin@Tstore.com', 12000000),
	('ST005', 'Veri', 'JL Syahdan 23', '081212120005', 'Female', 'Veri@Tstore.com', 16000000),
	('ST006', 'Stepen', 'JL Syahdan 63', '081212120006', 'Male', 'Stepen@Tstore.com', 7000000),
	('ST007', 'Stefani', 'JL Jeruk 25', '081212120007', 'Female', 'Stefani@Tstore.com', 8000000),
	('ST008', 'Veloncia', 'JL Kijang 23', '081212120008', 'Female', 'Veloncia@Tstore.com', 7000000),
	('ST009', 'Velyn', 'JL Keluarga 41', '081212120009', 'Female', 'Velyn@Tstore.com', 10000000),
	('ST010', 'Timoty', 'JL Merdeka 11', '081212120010', 'Male', 'Timoty@Tstore.com', 5000000)

INSERT INTO customer VALUES
	('CU001', 'Harmin', 'JL Bandung 12', '082245980001', 'Male', 'Harmin@Gmail.com'),
	('CU002', 'Calvin', 'JL Surabaya 12', '082245980002', 'Male', 'Calvin@Gmail.com'),
	('CU003', 'Harlini', 'JL Surabaya 19', '082245980003', 'Female', 'Harlini@Gmail.com'), 
	('CU004', 'Valentia', 'JL Bandung 13', '082245980004', 'Female', 'Valentia@Gmail.com'),
	('CU005', 'Adi', 'JL Medan 12', '082245980005', 'Male', 'Adi@Gmail.com'),
	('CU006', 'Rosi', 'JL Medan 16', '082245980006', 'Female', 'Rosi@Gmail.com'),
	('CU007', 'Clara', 'JL Bandung 64', '082245980007', 'Female', 'Clara@Gmail.com'),
	('CU008', 'Martin', 'JL Medan 19', '082245980008', 'Male', 'Martin@Gmail.com'),
	('CU009', 'Marco', 'JL Bandung 11', '082245980009', 'Male', 'Marco@Gmail.com'),
	('CU010', 'Miani', 'JL Bandung 12', '082245980010', 'Female', 'Miani@Gmail.com')

INSERT INTO vendor VALUES
	('VE001', 'WoW Clothes', 'JL Klinkklank 23', '08526486970001', 'Shop@WClothes.com'),
	('VE002', 'Happy Clothes', 'JL Medan 54', '08526486970002', 'Shop@HClothes.com'),
	('VE003', 'Saad Clothes', 'JL Klinkklank 22', '08526486970003', 'Shop@SClothes.com'),
	('VE004', 'Crazy Clothes', 'JL Medan 64', '08526486970004', 'Shop@CClothes.com'),
	('VE005', 'Superb Clothes', 'JL Bandung 33', '08526486970005', 'Shop@SbClothes.com'),
	('VE006', 'Godly Clothes', 'JL Klinkklank 234', '08526486970006', 'Shop@GClothes.com'),
	('VE007', 'Legendary Clothes', 'JL Bandung 45', '08526486970007', 'Shop@LClothes.com'),
	('VE008', 'Elementary Clothes', 'JL Kijang 63', '08526486970003', 'Shop@EClothes.com'),
	('VE009', 'Never Clothes', 'JL Kijang 11', '08526486970009', 'Shop@NClothes.com'),
	('VE010', 'Palling Clothes', 'JL Klinkklank 68', '08526486970010', 'Shop@PClothes.com')

INSERT INTO clothes_category VALUES
	('CA001', 'Short'),
	('CA002', 'Shirt'),
	('CA003', 'Sweater'),
	('CA004', 'Hoodie'),
	('CA005', 'Jeans'),
	('CA006', 'Jas'),
	('CA007', 'T-shirt'),
	('CA008', 'Celana kain'),
	('CA009', 'Socks'),
	('CA010', 'Underwear')

INSERT INTO clothes VALUES
	('CL001', 'Shining Bright', 'CA007', 45000, 50),
	('CL002', 'Shopataleen', 'CA007', 68000, 23),
	('CL003', 'RSCHE', 'CA001', 51000, 45),
	('CL004', 'Minimal', 'CA010', 20000, 39),
	('CL005', 'Shopataleen', 'CA008', 70000, 23),
	('CL006', 'Miroir Store' ,'CA006', 140000, 20),
	('CL007', 'Adorable Projects', 'CA009', 30200, 50),
	('CL008', 'Bad Influence', 'CA004', 98500, 30),
	('CL009', 'Minimal', 'CA003', 70000,60),
	('CL010', 'Miroir Store', 'CA004', 67000, 45),
	('CL011', 'Bad Influence', 'CA005', 90000, 67),
	('CL012', 'RSCHE' , 'CA002', 25000, 78),
	('CL013', 'Screamous', 'CA005', 68900, 98),
	('CL014', 'Minimal', 'CA009', 24000, 90),
	('CL015', 'Shining Bright', 'CA008', 47000,23)

INSERT INTO salesTransaction VALUES
	('SA001', '2020-10-21 12:17:00.000', 'ST001', 'CU001'),
	('SA002', '2020-08-19 21:19:00.000', 'ST003', 'CU010'),
	('SA003', '2020-06-17 17:39:00.000', 'ST004', 'CU008'),
	('SA004', '2020-10-10 15:58:00.000', 'ST010', 'CU005'),
	('SA005', '2020-08-28 14:47:00.000', 'ST009', 'CU003'),
	('SA006', '2020-05-15 12:01:00.000', 'ST008', 'CU002'),
	('SA007', '2020-10-17 19:07:00.000', 'ST007', 'CU004'),
	('SA008', '2020-05-10 20:18:00.000', 'ST005', 'CU001'),
	('SA009', '2020-06-01 18:19:00.000', 'ST006', 'CU006'),
	('SA010', '2020-09-02 15:29:00.000', 'ST001', 'CU010'),
	('SA011', '2020-10-21 12:51:00.000', 'ST003', 'CU009'),
	('SA012', '2020-02-28 15:49:00.000', 'ST004', 'CU004'),
	('SA013', '2020-09-15 11:29:00.000', 'ST008', 'CU008'),
	('SA014', '2020-10-20 17:31:00.000', 'ST007', 'CU002'),
	('SA015', '2020-10-18 19:52:00.000', 'ST010', 'CU007')

INSERT INTO purchaseTransaction VALUES
	('PU001', '2020-10-12 12:21:00.000', 'ST001', 'VE001'),
	('PU002', '2020-10-19 17:47:00.000', 'ST005', 'VE003'),
	('PU003', '2020-10-14 19:49:00.000', 'ST006', 'VE010'),
	('PU004', '2020-07-12 10:31:00.000', 'ST004', 'VE004'),
	('PU005', '2020-06-01 13:33:00.000', 'ST005', 'VE001'),
	('PU006', '2020-04-19 15:26:00.000', 'ST006', 'VE002'),
	('PU007', '2020-10-14 17:50:00.000', 'ST007', 'VE008'),
	('PU008', '2020-04-03 19:43:00.000', 'ST008', 'VE009'),
	('PU009', '2020-04-07 15:57:00.000', 'ST009', 'VE007'),
	('PU010', '2020-10-12 08:59:00.000', 'ST010', 'VE010'),
	('PU011', '2020-10-06 14:00:00.000', 'ST003', 'VE005'),
	('PU012', '2020-09-09 09:30:00.000', 'ST002', 'VE004'),
	('PU013', '2020-10-20 16:35:00.000', 'ST004', 'VE006'),
	('PU014', '2020-08-13 11:51:00.000', 'ST010', 'VE006'),
	('PU015', '2020-10-15 10:06:00.000', 'ST002', 'VE003')

INSERT INTO salesBasket VALUES
	('SA001', 'CL015', 2),
	('SA002', 'CL011', 5),
	('SA003', 'CL009', 2),
	('SA004', 'CL007', 3),
	('SA005', 'CL005', 1),
	('SA002', 'CL002', 3),
	('SA005', 'CL004', 2),
	('SA004', 'CL008', 1),
	('SA007', 'CL011', 4),
	('SA009', 'CL001', 1),
	('SA010', 'CL002', 1),
	('SA014', 'CL009', 5),
	('SA001', 'CL010', 3),
	('SA007', 'CL013', 4),
	('SA004', 'CL003', 4),
	('SA008', 'CL012', 1),
	('SA015', 'CL006', 2),
	('SA012', 'CL003', 3),
	('SA014', 'CL008', 1),
	('SA013', 'CL006', 7),
	('SA011', 'CL008', 2),
	('SA010', 'CL003', 4),
	('SA004', 'CL011', 2),
	('SA007', 'CL003', 5),
	('SA009', 'CL005', 1),
	('SA006', 'CL006', 1),
	('SA005', 'CL008', 7),
	('SA002', 'CL013', 2),
	('SA004', 'CL014', 6),
	('SA007', 'CL002', 4),
	('SA014', 'CL001', 3)

INSERT INTO purchaseBasket VALUES
	('PU001', 'CL013', 18),
	('PU001', 'CL012', 10),
	('PU001', 'CL001', 5),
	('PU001', 'CL003', 25),
	('PU002', 'CL001', 13),
	('PU002', 'CL005', 17),
	('PU003', 'CL006', 14),
	('PU003', 'CL008', 30),
	('PU003', 'CL009', 25),
	('PU004', 'CL010', 17),
	('PU005', 'CL015', 26),
	('PU005', 'CL014', 28),
	('PU006', 'CL008', 8),
	('PU006', 'CL005', 31),
	('PU006', 'CL003', 67),
	('PU007', 'CL002', 45),
	('PU007', 'CL004', 51),
	('PU007', 'CL007', 39),
	('PU008', 'CL007', 41),
	('PU008', 'CL012', 28),
	('PU009', 'CL011', 37),
	('PU009', 'CL013', 24),
	('PU010', 'CL014', 6),
	('PU011', 'CL014', 29),
	('PU011', 'CL006', 25),
	('PU012', 'CL001', 13),
	('PU012', 'CL006', 14),
	('PU012', 'CL003', 11),
	('PU013', 'CL002', 28),
	('PU013', 'CL015', 12),
	('PU013', 'CL005', 23)


--1.	Display Transaction Count (obtained from the total transaction), StaffName, and VendorName for each purchase which made by staff whose salary is between 5000000 and 10000000, to a vendor whose name contains character ‘o’.
Select * From vendor
Select * From purchaseBasket
Select * From purchaseTransaction

SELECT COUNT(purchaseTransaction.transactionID) AS 'Transaction Count', 
		staff.staffName,
		vendor.vendorName
FROM vendor
JOIN purchaseTransaction
ON vendor.vendorID = purchaseTransaction.vendorID
JOIN staff
ON staff.staffID = purchaseTransaction.staffID
WHERE staff.staffSalary BETWEEN 5000000 AND 10000000
AND vendor.vendorName LIKE '%o%'
GROUP BY staff.staffName, vendor.vendorName


--2.	Display SalesId, SalesDate, CustomerName, and CustomerAddress for every sale that happens on 15th day of the month, where the sum of the clothes’ price is more than 150000.
Select x.salesID, x.salesDate, x.customerName, x.customerAddress
From(
SELECT salesTransaction.salesID, salesTransaction.salesDate,customer.customerName, customer.customerAddress, SUM(clothes.clothesPrice*salesBasket.quantity) AS 'jumlaharga'
						From salesTransaction
						JOIN salesBasket
						On salesTransaction.salesID = salesBasket.salesID
						JOIN customer
						ON customer.customerID = salesTransaction.customerID
						JOIN clothes
						ON clothes.clothesID = salesBasket.clothesID
						GROUP BY  salesTransaction.salesID, salesTransaction.salesDate,customer.customerName, customer.customerAddress, salesBasket.salesID
						) AS x
WHERE DATEPART(DAY, x.salesDate) = 15 
AND x.jumlaharga > 150000


--3.	Display Month (obtained from month name of one month before current date), Transaction Count (obtained from the total of sales), and Cloth Sold Count (obtained from sum quantity) for each sale which is managed by female staff and the sold cloth price is more than 70000.
Select * From staff
Select * From salesBasket

Select table1.Month, SUM(table1.[Transaction Count]) AS 'Transaction Count', SUM(table1.[Cloth Sold Count]) AS 'Cloth Sold Count'
From(
SELECT  DATENAME(MONTH, DATEADD(MM, -1, salesTransaction.salesDate)) AS 'Month', COUNT(salesBasket.salesID) AS 'Transaction Count',
		SUM(salesBasket.quantity) AS 'Cloth Sold Count'
FROM salesTransaction
JOIN (SELECT salesBasket.salesID , SUM(clothes.clothesPrice) AS 'totalprice'
		FROM salesBasket, clothes
		WHERE salesBasket.clothesID = clothes.clothesID
		GROUP BY salesBasket.salesID) AS totalsum
		ON totalsum.salesID = salesTransaction.salesID
JOIN staff
ON salesTransaction.staffID = staff.staffID
JOIN salesBasket
ON salesTransaction.salesID = salesBasket.salesID
Where staff.staffGender = 'Female' AND totalsum.totalprice > 70000
GROUP BY salesTransaction.salesDate,salesBasket.salesID
) AS table1
GROUP BY table1.Month


--4.	Display Brand Last Name (obtained from the last word from the ClothBrand) and Maximum Cloth(s) Sold (obtained from maximum quantity) for each sale which the sum of the quantity is more than 5 and less than 10.
Select RIGHT(clothes.clothesBrand, CHARINDEX(' ', REVERSE(' ' + clothes.clothesBrand)) -1) AS 'Brand Last Name', salesBasket.quantity AS 'Maximum Cloth(s) Sold'
From clothes
JOIN salesBasket
ON salesBasket.clothesID = clothes.clothesID
JOIN (SELECT MAX(salesBasket.quantity) AS 'x', salesBasket.salesID
FROM salesBasket
JOIN (SELECT salesTransaction.salesID, SUM(salesBasket.quantity) AS 'jmlbaju'
			FROM salesBasket,salesTransaction
			WHERE salesBasket.salesID = salesTransaction.salesID
			GROUP BY salesTransaction.salesID) AS table1
			ON table1.salesID = salesBasket.salesID
WHERE table1.jmlbaju > 5 AND table1.jmlbaju < 10
GROUP BY salesBasket.salesID
)AS table2
ON table2.salesID = salesBasket.salesID
WHERE salesBasket.quantity = table2.x
	
--5.	Display ClothBrand, ClothPrice, and Stock for each purchase where the cloth price is between average price minus 35000 and the average price. The average price is obtained from average cloth price which is purchased from vendor with the first name ‘Saad’.
Select clothes.clothesBrand, clothes.clothesPrice, clothes.clothesStock
From clothes, (Select AVG(clothes.clothesPrice) AS 'avege' From clothes
		JOIN purchaseBasket
		ON purchaseBasket.clothesID = clothes.clothesID
		JOIN purchaseTransaction
		ON purchaseTransaction.transactionID = purchaseBasket.transactionID
		JOIN vendor
		ON vendor.vendorID = purchaseTransaction.vendorID
		Where vendor.vendorName Like 'Saad%') AS ratarata
Where clothes.clothesPrice Between ratarata.avege - 35000 AND ratarata.avege

--6.	Display Sales Date (obtained SalesDate with format ‘mm/dd/yyyy’), ClothBrand, Quantity for each sale where the quantity is more than total sales happened in May. Sort the result by Quantity in ascending order.
SELECT CONVERT(VARCHAR, CAST(salesTransaction.salesDate AS datetime), 101) AS 'Sales Date',
		clothes.clothesBrand, salesBasket.quantity
FROM clothes, salesBasket, salesTransaction,
(SELECT COUNT(salesTransaction.salesID) AS 'totalinmay'
		FROM salesTransaction
		WHERE DATENAME(MONTH, salesTransaction.salesDate) = 'May') AS table1
WHERE salesBasket.salesID = salesTransaction.salesID AND clothes.clothesID = salesBasket.clothesID
AND salesBasket.quantity > table1.totalinmay
ORDER BY salesBasket.quantity ASC

--7.	Display PurchaseId, Staff Name (obtained from lowercase the StaffName), Staff Salary (obtained from adding ‘IDR ’ in front of StaffSalary), Purchase Date (obtained from the PurchaseDate with format ‘Mon dd, yyyy’) and Total Quantity (obtained from the sum of purchased clothes’ quantity) for every purchase where the Quantity is more than MinQuantity (obtained from the minimum quantity from each purchase that happened on the 4th  month).
SELECT purchaseTransaction.transactionID, 
		LOWER(staff.staffName) AS 'Staff Name',
		'IDR ' + CAST(staff.staffSalary AS VARCHAR) AS 'Staff Salary',
		CONVERT(VARCHAR,  CAST(purchaseTransaction.transactionDate AS Datetime), 107) AS 'Purchase Date',
		SUM(purchaseBasket.quantity) AS 'Total Quantity'
FROM purchaseTransaction
JOIN staff
ON staff.staffID = purchaseTransaction.staffID
JOIN purchaseBasket
ON purchaseBasket.transactionID = purchaseTransaction.transactionID
JOIN (SELECT purchaseBasket.transactionID,MIN(purchaseBasket.quantity) AS 'x' FROM purchaseBasket
							WHERE 
							purchaseBasket.transactionID IN(
							SELECT purchaseTransaction.transactionID FROM purchaseTransaction
							WHERE DATEPART(MM, purchaseTransaction.transactionDate) = 4
							)
							GROUP BY purchaseBasket.transactionID
							) AS minimal
ON purchaseTransaction.transactionID = minimal.transactionID
WHERE purchaseBasket.quantity > minimal.x
GROUP BY purchaseTransaction.transactionID, staff.staffName, staff.staffSalary, purchaseTransaction.transactionDate

Select * From purchaseTransaction
Select * From purchaseBasket

--8.	Display Vendor Id (obtained from the last 3 character of VendorId), VendorName, Clothes Bought (obtained from sum of quantity and ended with ‘ piece(s)’), and Vendor Phone (obtained by replacing 2 first digits with ‘+62’) for every purchase where the Clothes Bought is less than 100 and quantity is more than the average quantity of all transactions.
SELECT RIGHT(total.vendorID, 3) AS 'Vendor Id',
		total.vendorName,
		CAST(total.[Clothes Bought] AS VARCHAR(200)) + ' piece(s)' AS 'Clothes Bought',
		REPLACE(total.vendorPhone, LEFT(total.vendorPhone, 2), '+62') AS 'Vendor Phone'
		FROM (Select vendor.vendorID, vendor.vendorName, SUM(purchaseBasket.quantity) AS 'Clothes Bought', vendor.vendorPhone
		From vendor
		JOIN purchaseTransaction
		ON purchaseTransaction.vendorID = vendor.vendorID
		JOIN purchaseBasket
		ON purchaseBasket.transactionID = purchaseTransaction.transactionID
		GROUP BY vendor.vendorID, vendor.vendorName, vendor.vendorPhone) AS total,
		(SELECT AVG(purchaseBasket.quantity) AS 'x' FROM purchaseBasket) AS ratata
		WHERE total.[Clothes Bought] > ratata.x AND total.[Clothes Bought] < 100



--9.	Create a view named ‘StoreSalesView’ to display SalesId, CustomerName, CustomerPhone, Cloth Average Price (obtained from average of ClothPrice starts with ‘IDR ’), and Sales Quantity (obtained from the sum of quantity ended with ‘ piece(s)’) for every sales which Cloth Average Price is more than 100000 and the Sales Quantity is more than 4.
CREATE VIEW StoreSalesView AS
SELECT salesBasket.salesID, customer.customerName, customer.customerPhone,
	'IDR ' + CAST(table1.x AS VARCHAR) AS 'Cloth Average Price' ,
	CAST(SUM(salesBasket.quantity) AS VARCHAR) + ' piece(s)' AS 'Sales Quantity'
FROM salesBasket
JOIN salesTransaction
ON salesBasket.salesID = salesTransaction.salesID
JOIN clothes
ON clothes.clothesID = salesBasket.clothesID
JOIN (SELECT salesBasket.salesID, AVG(clothes.clothesPrice) AS 'x'
		FROM salesBasket
		JOIN clothes
		ON clothes.clothesID = salesBasket.clothesID
		GROUP BY salesBasket.salesID) AS table1
ON salesBasket.salesID = table1.salesID
JOIN customer
ON customer.customerID = salesTransaction.customerID
WHERE table1.x > 100000 AND salesBasket.quantity > 4
GROUP BY salesBasket.salesID, customer.customerName, customer.customerPhone, table1.x



--10.	Create a view named ‘StorePurchaseView’ to display the Purchase Month (obtained from the month name of purchase date), Minimum Purchase Quantity (obtained from the minimum of quantity), and Purchased Cloth Count (obtained from the total of clothes purchased) for every purchase where the Minimum Purchase Quantity is more than 10 and the Purchase Cloth Count is more than 1.
CREATE VIEW StorePurchaseView AS
SELECT DATENAME(MONTH, purchaseTransaction.transactionDate) AS 'Purchase Month',
	 MIN(purchaseBasket.quantity) AS 'Minimum Purchase Quantity',
	SUM(purchaseBasket.quantity) AS 'Purchased Cloth Count'
FROM purchaseTransaction
JOIN purchaseBasket
ON purchaseBasket.transactionID = purchaseTransaction.transactionID
JOIN (SELECT purchaseBasket.transactionID, MIN(purchaseBasket.quantity) AS 'minimal'
							FROM purchaseBasket
							GROUP BY purchaseBasket.transactionID
							) AS table1
ON purchaseTransaction.transactionID = table1.transactionID
WHERE table1.minimal > 10 AND purchaseBasket.quantity > 1
GROUP BY purchaseTransaction.transactionDate


SELECT * FROM StorePurchaseView
SELECT * FROM StoreSalesView