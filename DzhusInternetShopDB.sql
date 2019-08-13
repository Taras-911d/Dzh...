/*0. �������� ������� ������� � �������� ��� ����� �������� �������� �������� ���������.
  1. ������� ���� �����.
  2. ������� �������.
  3. ������� ��'���� �� ���������. ������� ��������.
  4. ��� ��������� (�� ����������, ��� �������).
  5. �������� �������. 
  6. ������ �� ��� � ����� �������.
  7. ������� �������.*/


--1.
--������� ���� ����� � ������ DzhusInternetShopDB � ����������� ���� �� ������� �� �����������, � ���� ����������� � ������������ ����� �� ����.
CREATE DATABASE DzhusInternetShopDB
COLLATE Cyrillic_General_CI_AS
GO

--���� ���� ��� ���� ����� DzhusInternetShopDB.
EXECUTE sp_helpdb DzhusInternetShopDB;  

--ϳ��������� �� ���� ����� DzhusInternetShopDB.
USE DzhusInternetShopDB;
GO


--2.
--������� �������.

/*1) Customers (ID,FName,MName,LName,[Address],City,Phone,DateInSystem)
  2) Employees (ID,FName,MName,LName,Post,Salary,PriorSalary)
  3) EmployeesInfo (ID,MaritalStatus,BirthDate,[Address],Phone) 
  4) Products (ID,Name) 
  5) Stocks (MedicamentID, Qty)
  6) Orders (ID,CustomerID,EmployeeID,OrderDate)
  7) OrderDetails (OrderID,LineItem,MedicamentID,Qty,Price,TotalPrice) */
  
CREATE TABLE Customers  --1) �������
(
	ID int NOT NULL IDENTITY,           --ID              / ����� ��� ����� � ������                 / �� ����� ��������� ������ ������� � �������� ��������������,��� ���������� � 1.
	FName nvarchar(20) NULL,            --�������        / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	MName nvarchar(20) NULL,            --��-�������     / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	LName nvarchar(20) NULL,            --��'�            / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	[Address] nvarchar(50) NULL,        --������          / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	City nvarchar(20) NULL,             --����           / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	Phone char(12) NULL,                --���.���.        / ��������� ��� ����� � ���������� �������� / ����� ��������� ������ �������
	DateInSystem date DEFAULT GETDATE() --���� ����.�볺./ ��� ����� ���� ( ��� ����� )              / ���� ����� �� �������, �� ���������� ��������� ���� �� �����
)  
GO

CREATE TABLE Employees   --2) �����������
(
	ID int NOT NULL IDENTITY,            --ID             / ����� ��� ����� � ������                 / �� ����� ��������� ������ ������� � �������� ��������������,��� ���������� � 1.
	FName nvarchar(20) NOT NULL,         --�������       / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������
	MName nvarchar(20) NULL,             --��-�������    / ��������� ��� ����� �������� �������    / ����� ��������� ���� ��������
	LName nvarchar(20) NOT NULL,         --��'�           / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������
	Post  nvarchar(25) NOT NULL,         --������         / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������
	Salary money NOT NULL,               --��������       / �������� ��� �����                        / �� ����� ��������� ������ �������
	PriorSalary money NULL               --�����         / �������� ��� �����                        / �� ����� ��������� ������ �������
)  
GO

CREATE TABLE EmployeesInfo--3) ��������� ���� ��� �����������
(                                      
	ID int NOT NULL,                     --ID             / ����� ��� ����� � ������                 / �� ����� ��������� ������ �������
	MaritalStatus varchar(25) NOT NULL,  --������� ����  / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������
	BirthDate date NOT NULL,             --���� ������.   / ��� ����� ���� ( ��� ����� )              / �� ����� ��������� ������ �������
	[Address] nvarchar(50) NOT NULL,     --[������]       / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������  
	Phone char(12) NOT NULL              --���.���.       / ��������� ��� ����� � ���������� �������� / �� ����� ��������� ������ �������
)
GO	

CREATE TABLE Medicaments  --4) �����������  
(
	ID int NOT NULL IDENTITY,--ID        --ID             / ����� ��� ����� � ������                 / �� ����� ��������� ������ ������� � �������� ��������������,��� ���������� � 1.
	Name nvarchar(100) NOT NULL           --����� ���    / ��������� ��� ����� �������� �������    / �� ����� ��������� ������ �������
)
GO


CREATE TABLE Stocks       --5) ������ ����������� �� �����
(
	MedicamentID int NOT NULL,           --ID             / ����� ��� ����� � ������                 / �� ����� ��������� ������ �������
	Qty int DEFAULT 0                    --�����          / ����� ��� ����� � ������                 / ���� ����� �� �������, �� ���������� ��������� 0
)
GO

CREATE TABLE Orders       --6) ���� ��� ��� ����������
(
	ID int NOT NULL IDENTITY,            --ID             / ����� ��� ����� � ������                 / �� ����� ��������� ������ ������� � �������� ��������������,��� ���������� � 1.
	CustomerID int NULL,         --�볺��, ������ ������� / ����� ��� ����� � ������                 / ����� ��������� ���� ��������
	EmployeeID int NULL,       --���������,������ ������� / ����� ��� ����� � ������                 / ����� ��������� ���� ��������
	OrderDate date DEFAULT GETDATE()    --���� ���������� / ��� ����� ���� ( ��� ����� )              / ���� ����� �� �������, �� ���������� ��������� ���� �� �����
)  
GO

CREATE TABLE OrderDetails --7) ��������� ���� ��� ����������
(
	OrderID int NOT NULL,             --ID ���� ��������**/ ����� ��� ����� � ������                 / �� ����� ��������� ������ �������
	LineItem int NOT NULL,            --ID ��������       / ����� ��� ����� � ������                 / �� ����� ��������� ������ �������
	MedicamentID int NULL,            --���� ��������     / ����� ��� ����� � ������                 / ����� ��������� ���� ��������
	Qty int NOT NULL,                 --� ������� ����  / ����� ��� ����� � ������                 / �� ����� ��������� ������ �������
	Price money NOT NULL              --���� ��������     / �������� ��� �����                        / �� ����� ��������� ������ �������
)  
GO


--3. ������� ��'���� �� ���������. ������� ��������.

/*1) Customers: ID(PK)
  2) Employees: ID(PK)
  3) EmployeesInfo: ID(UQ,FK)
  4) Medicaments: ID(PK) 
  5) Stocks: MedicamentID(UQ,FK)
  6) Orders: ID(PK), CustomerID(FK), EmployeeID(FK)
  7) OrderDetails: OrderID,LineItem(PK), OrderID(FK), MedicamentID(FK) */

--1) ������� Customers
ALTER TABLE Customers                 --�������� ALTER TABLE ����� ������� Customers, ADD - ��������
	ADD CONSTRAINT PK_Customers       -- PK_Customers   -�� �����,��� ���� ����� ���� ����������
	PRIMARY KEY(ID)                   -- �� ��� ������� ID ������ ������, ��������� �� ( ��������� ���� )
GO

--2) ������� Employees
ALTER TABLE Employees 
    ADD CONSTRAINT PK_Employees 
	PRIMARY KEY(ID) 
GO

--3) ������� EmployeesInfo
ALTER TABLE EmployeesInfo  
	ADD CONSTRAINT UQ_EmployeesInfo 
	UNIQUE(ID)                         -- ������� ����������, �� ����� ������� �������           
GO

ALTER TABLE EmployeesInfo 
	ADD CONSTRAINT FK_EmployeesInfo_Employees 
	FOREIGN KEY (ID)                   -- ������� ����
	REFERENCES Employees(ID)           
	ON DELETE CASCADE
GO

--4) ������� Medicaments
ALTER TABLE Medicaments 
	ADD CONSTRAINT PK_Medicaments
	PRIMARY KEY (ID) 
GO

--5) ������� Stocks
ALTER TABLE Stocks  
	ADD CONSTRAINT UQ_Stocks
	UNIQUE(MedicamentID)
GO

ALTER TABLE Stocks 
	ADD CONSTRAINT FK_Stocks_Products 
	FOREIGN KEY (MedicamentID) 
	REFERENCES Medicaments(ID) 
	ON DELETE CASCADE                  -- ��� �������� ���������� �� ��������;
GO

--6) ������� Orders
ALTER TABLE Orders 
	ADD CONSTRAINT PK_Orders 
	PRIMARY KEY (ID) 
GO

ALTER TABLE Orders 
	ADD CONSTRAINT FK_Orders_Customers 
	FOREIGN KEY(CustomerID) 
	REFERENCES Customers(ID) 
	ON DELETE SET NULL                 -- � ��������� ������� ���� NULL
GO

ALTER TABLE Orders 
	ADD CONSTRAINT FK_Orders_Employees 
	FOREIGN KEY(EmployeeID) 
	REFERENCES Employees(ID)
	ON DELETE SET NULL  
GO

--7) ������� OrderDetails
ALTER TABLE OrderDetails 
	ADD CONSTRAINT PK_OrderDetails 
	PRIMARY KEY	(OrderID,LineItem) 
GO

ALTER TABLE OrderDetails
	ADD CONSTRAINT FK_OrderDetails_Orders 
	FOREIGN KEY(OrderID) 
	REFERENCES Orders(ID) 
	ON DELETE CASCADE
GO

ALTER TABLE OrderDetails 
	ADD CONSTRAINT FK_OrderDetails_Products 
	FOREIGN KEY(MedicamentID) 
	REFERENCES Medicaments(ID) 
		ON DELETE SET NULL 
GO



--4. ��� ���������.

/*1) ��������� �� ����������� �������� ������ ��������� ��������.
  2) ��������� �� ��'���� �������� ������ � �������.*/

--1)
ALTER TABLE Customers
ADD CONSTRAINT CN_Customers_Phone
CHECK (Phone LIKE '([0][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')	 
GO

ALTER TABLE EmployeesInfo
ADD CONSTRAINT CN_EmployeesInfo_Phone
CHECK (Phone LIKE '([0][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')	 
GO

--2)
ALTER TABLE Stocks
ADD CONSTRAINT CN_Stocks_Qty
CHECK (Qty >= 0)	 
GO



-- 5. �������� �������. 
INSERT Customers                                              --�������� ������� INSERT
(FName, MName, LName, [Address], City, Phone, DateInSystem)   --������ ������� ������ �����
VALUES                                                        --������� ����� � INSERT �����
('³����','³��������','����������','��������� 21�, 100','�����','(063)4569385',GETDATE()),
('�����','��������','����','����������� 70','���','(093)1416433',GETDATE()),
('������','������������','��������','����������� 7�, 22','���','(068)0989367',GETDATE()),
('����','��������','��������','������� 15','�����','(098)4569111',GETDATE()),
('�������','��������','ĳ���','������ 10','����','(068)2229325',GETDATE()),
('����','��������','�����','����� 54, 17','�������','(063)1119311',GETDATE()),
('³����','��������','�������','˳���� 11','������','(068)4569344',GETDATE()),
('�����','��������','������','������������ 77, 99','�����','(050)4569255',GETDATE()),
('����','���������','����','����� 20','�������','(050)4539333',GETDATE()),
('�������','���������','�����','������ 1','���','(063)9999380',GETDATE()),
('�����','��������','��������','������ 23','�������','(067)9995558',GETDATE());
GO

INSERT Employees
(FName, MName, LName, Post, Salary, PriorSalary)
VALUES
('�������', '�������������', '������', '��������', 30000, 3000),
('�����', '���������', '������', '�������', 7000, 1500),
('����', '���������', '�����', '���������', 5000, 500),
('������', '��������', '������������', '���������', 5000, 500),
('�����', '���������', '�����', '�������', 7000, 1500),
('���', '��������', '�����', '���������', 7000, 1500);
GO

INSERT EmployeesInfo
(ID, MaritalStatus, BirthDate, [Address], Phone)
VALUES
(1, '�� ���������', '08/15/1970', '����������� 16','(067)4564489'),
(2, '���������', '09/09/1985', '�������� 15','(050)0564585'),
(3, '�� ���������', '12/11/1990', '���� 16','(068)4560409'),
(4, '�� ���������', '01/11/1988', '���������� 11','(066)4664466'),
(5, '������', '08/08/1990', '�������� 10','(093)4334493'),
(6, '������', '01/10/1994', '��������� 7','(063)4114141');
GO

INSERT Medicaments
(Name)
VALUES
('����'),
('�������� � ��������������'),
('������ ���� 5%'),
('ͳ���������� 1%'),
('�������� ������'),
('Գ������ ������� ����� ������'),
('����������� ������ ��� ������ ���������� ������ ����'),
('��������� ����� 20%'),
('��������� ���� "���������"'),
('����������� ������� 0,2%');
GO

INSERT Stocks
(MedicamentID, Qty)
VALUES
(1, 20),
(2, 10),
(3, 7),
(4, 8),
(5, 9),
(6, 5),
(7, 12),
(8, 54),
(9, 8),
(10, 7);
GO

INSERT Orders
(CustomerID, EmployeeID, OrderDate)
VALUES
(1,3, GETDATE()),
(2,6, GETDATE()),
(3,4, GETDATE()),
(3,NULL, GETDATE()),
(2,3, GETDATE()),
(4,6, GETDATE()),
(1,3, GETDATE()),
(5,3, GETDATE()),
(6,3, GETDATE()),
(1,4, GETDATE()),
(2,NULL, GETDATE()),
(7,3, GETDATE()),
(6,4, GETDATE()),
(3,NULL, GETDATE()),
(5,6, GETDATE()),
(8,3, GETDATE()),
(5,4, GETDATE()),
(7,4, GETDATE()),
(7,3, GETDATE()),
(9,3, GETDATE()),
(8,4, GETDATE()),
(10,NULL, GETDATE()),
(11,3, GETDATE()),
(10,4, GETDATE());
GO

INSERT OrderDetails
(OrderID, LineItem, MedicamentID, Qty, Price)
VALUES
(1,1,1,1,295),
(2,1,2,1,445),
(2,2,6,1,450),
(3,1,4,1,422),
(3,2,9,4,218),
(4,1,7,1,450),
(5,1,9,1,220),
(6,1,8,1,550),
(7,1,8,2,550),
(7,2,9,1,222),
(7,3,5,1,289),
(8,1,3,1,518),
(8,2,9,1,222),
(9,1,6,1,451),
(10,1,10,1,600),
(11,1,7,3,452),
(12,1,7,2,452),
(13,1,9,1,222),
(13,2,8,1,550),
(13,3,7,1,455),
(14,1,9,2,222),
(15,1,3,1,520),
(16,1,4,2,420),
(17,1,10,2,600),
(18,1,10,1,600),
(19,1,7,3,453),
(19,2,8,2,550),
(20,1,5,2,300),
(21,1,4,1,422),
(21,2,5,1,305),
(22,1,1,1,305),
(22,2,2,1,450),
(23,1,1,3,300),
(23,2,2,1,450),
(23,3,3,1,525),
(23,4,4,2,420),
(24,1,6,4,450);
GO


--6. 

--������ �� ��� � ����� �������.
SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Stocks
SELECT * FROM EmployeesInfo
SELECT * FROM Orders
SELECT * FROM Medicaments
SELECT * FROM OrderDetails



--7. 

--������� ��'���� �� ���������.   ( �������� �������� ������, � ���� ������ )
ALTER TABLE Customers                 
DROP CONSTRAINT PK_Customers;
GO
 --1) ������� Customers
ALTER TABLE Customers                 
DROP CONSTRAINT PK_Customers;
GO

--2) ������� Employees
ALTER TABLE Employees 
DROP CONSTRAINT PK_Employees 
GO

--3) ������� EmployeesInfo
ALTER TABLE EmployeesInfo  
DROP CONSTRAINT UQ_EmployeesInfo                             
GO

ALTER TABLE EmployeesInfo 
DROP CONSTRAINT FK_EmployeesInfo_Employees 
GO

--4) ������� Medicaments
ALTER TABLE Medicaments 
DROP CONSTRAINT PK_Medicaments 
GO

--5) ������� Stocks
ALTER TABLE Stocks  
DROP CONSTRAINT UQ_Stocks
GO

ALTER TABLE Stocks 
DROP CONSTRAINT FK_Stocks_Products                
GO

--6) ������� Orders
ALTER TABLE Orders 
DROP CONSTRAINT PK_Orders 
GO

ALTER TABLE Orders 
DROP CONSTRAINT FK_Orders_Customers                
GO

ALTER TABLE Orders 
DROP CONSTRAINT FK_Orders_Employees 
GO

--7) ������� OrderDetails
ALTER TABLE OrderDetails 
DROP CONSTRAINT PK_OrderDetails 
GO

ALTER TABLE OrderDetails
DROP CONSTRAINT FK_OrderDetails_Orders 
GO

ALTER TABLE OrderDetails 
DROP CONSTRAINT FK_OrderDetails_Products 
GO

--8.
--������� �����ֲ-----------
DROP TABLE Customers
GO

DROP TABLE Employees
GO

DROP TABLE EmployeesInfo
GO

DROP TABLE Medicaments
GO

DROP TABLE Stocks
GO

DROP TABLE Orders
GO

DROP TABLE OrderDetails
GO