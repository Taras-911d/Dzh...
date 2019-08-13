/*0. Придумав діаграму таблиць в майбутній базі даних інтернет магазину медичних препаратів.
  1. Створив базу даних.
  2. Створив таблиці.
  3. Створив зв'язки між таблицями. Силочна цілісність.
  4. Ввів обмеження (не вимагалось, але добавив).
  5. Заповнив таблиці. 
  6. Вибрав всі дані з кожної таблиці.
  7. Видалив таблиці.*/


--1.
--Створив базу даних з іменем DzhusInternetShopDB з параметрами бази та журналу по замовчуванні, а потім відкорегував у властивостях розмір та крок.
CREATE DATABASE DzhusInternetShopDB
COLLATE Cyrillic_General_CI_AS
GO

--Вивів інфу про базу даних DzhusInternetShopDB.
EXECUTE sp_helpdb DzhusInternetShopDB;  

--Підключився до бази даних DzhusInternetShopDB.
USE DzhusInternetShopDB;
GO


--2.
--Створив таблиці.

/*1) Customers (ID,FName,MName,LName,[Address],City,Phone,DateInSystem)
  2) Employees (ID,FName,MName,LName,Post,Salary,PriorSalary)
  3) EmployeesInfo (ID,MaritalStatus,BirthDate,[Address],Phone) 
  4) Products (ID,Name) 
  5) Stocks (MedicamentID, Qty)
  6) Orders (ID,CustomerID,EmployeeID,OrderDate)
  7) OrderDetails (OrderID,LineItem,MedicamentID,Qty,Price,TotalPrice) */
  
CREATE TABLE Customers  --1) покупці
(
	ID int NOT NULL IDENTITY,           --ID              / цілий тип даних зі знаком                 / не можна допускати пустих значень і поставив автозаповнення,яке починаться з 1.
	FName nvarchar(20) NULL,            --прізвище        / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	MName nvarchar(20) NULL,            --по-батькові     / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	LName nvarchar(20) NULL,            --ім'я            / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	[Address] nvarchar(50) NULL,        --адреса          / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	City nvarchar(20) NULL,             --місто           / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	Phone char(12) NULL,                --моб.тел.        / текстовий тип даних з фіксованою довжиною / можна допускати пустих значень
	DateInSystem date DEFAULT GETDATE() --дата реєст.кліє./ тип даних дати ( без годин )              / якщо нічого не впишимо, то присвоїться автоматом дату по факту
)  
GO

CREATE TABLE Employees   --2) співробітники
(
	ID int NOT NULL IDENTITY,            --ID             / цілий тип даних зі знаком                 / не можна допускати пустих значень і поставив автозаповнення,яке починаться з 1.
	FName nvarchar(20) NOT NULL,         --прізвище       / текстовий тип даних перемінної довжини    / не можна допускати пустих значень
	MName nvarchar(20) NULL,             --по-батькові    / текстовий тип даних перемінної довжини    / можна допускати пусті значення
	LName nvarchar(20) NOT NULL,         --ім'я           / текстовий тип даних перемінної довжини    / не можна допускати пустих значень
	Post  nvarchar(25) NOT NULL,         --посада         / текстовий тип даних перемінної довжини    / не можна допускати пустих значень
	Salary money NOT NULL,               --зарплата       / валютний тип даних                        / не можна допускати пустих значень
	PriorSalary money NULL               --премія         / валютний тип даних                        / не можна допускати пустих значень
)  
GO

CREATE TABLE EmployeesInfo--3) додаткова інфа про співробітників
(                                      
	ID int NOT NULL,                     --ID             / цілий тип даних зі знаком                 / не можна допускати пустих значень
	MaritalStatus varchar(25) NOT NULL,  --сімейний стан  / текстовий тип даних перемінної довжини    / не можна допускати пустих значень
	BirthDate date NOT NULL,             --день народж.   / тип даних дати ( без годин )              / не можна допускати пустих значень
	[Address] nvarchar(50) NOT NULL,     --[адреса]       / текстовий тип даних перемінної довжини    / не можна допускати пустих значень  
	Phone char(12) NOT NULL              --моб.тел.       / текстовий тип даних з фіксованою довжиною / не можна допускати пустих значень
)
GO	

CREATE TABLE Medicaments  --4) медикаменти  
(
	ID int NOT NULL IDENTITY,--ID        --ID             / цілий тип даних зі знаком                 / не можна допускати пустих значень і поставив автозаповнення,яке починаться з 1.
	Name nvarchar(100) NOT NULL           --назва ліків    / текстовий тип даних перемінної довжини    / не можна допускати пустих значень
)
GO


CREATE TABLE Stocks       --5) запаси медикаментів на складі
(
	MedicamentID int NOT NULL,           --ID             / цілий тип даних зі знаком                 / не можна допускати пустих значень
	Qty int DEFAULT 0                    --запас          / цілий тип даних зі знаком                 / якщо нічого не впишимо, то присвоїться автоматом 0
)
GO

CREATE TABLE Orders       --6) інфа про самі замовлення
(
	ID int NOT NULL IDENTITY,            --ID             / цілий тип даних зі знаком                 / не можна допускати пустих значень і поставив автозаповнення,яке починаться з 1.
	CustomerID int NULL,         --клієнт, котрий замовив / цілий тип даних зі знаком                 / можна допускати пусті значення
	EmployeeID int NULL,       --працівник,котрий оформив / цілий тип даних зі знаком                 / можна допускати пусті значення
	OrderDate date DEFAULT GETDATE()    --дата замовлення / тип даних дати ( без годин )              / якщо нічого не впишимо, то присвоїться автоматом дату по факту
)  
GO

CREATE TABLE OrderDetails --7) детальніша інфа про замовлення
(
	OrderID int NOT NULL,             --ID інфи продукту**/ цілий тип даних зі знаком                 / не можна допускати пустих значень
	LineItem int NOT NULL,            --ID продукту       / цілий тип даних зі знаком                 / не можна допускати пустих значень
	MedicamentID int NULL,            --який препарат     / цілий тип даних зі знаком                 / можна допускати пусті значення
	Qty int NOT NULL,                 --в кількість штук  / цілий тип даних зі знаком                 / не можна допускати пустих значень
	Price money NOT NULL              --ціна продукту     / валютний тип даних                        / не можна допускати пустих значень
)  
GO


--3. Створив зв'язки між таблицями. Силочна цілісність.

/*1) Customers: ID(PK)
  2) Employees: ID(PK)
  3) EmployeesInfo: ID(UQ,FK)
  4) Medicaments: ID(PK) 
  5) Stocks: MedicamentID(UQ,FK)
  6) Orders: ID(PK), CustomerID(FK), EmployeeID(FK)
  7) OrderDetails: OrderID,LineItem(PK), OrderID(FK), MedicamentID(FK) */

--1) таблиця Customers
ALTER TABLE Customers                 --оператор ALTER TABLE змінює таблицю Customers, ADD - добавляє
	ADD CONSTRAINT PK_Customers       -- PK_Customers   -це назва,щоб потім можна було звернутися
	PRIMARY KEY(ID)                   -- всі дані стовбця ID будуть різними, контролює це ( первинний ключ )
GO

--2) таблиця Employees
ALTER TABLE Employees 
    ADD CONSTRAINT PK_Employees 
	PRIMARY KEY(ID) 
GO

--3) таблиця EmployeesInfo
ALTER TABLE EmployeesInfo  
	ADD CONSTRAINT UQ_EmployeesInfo 
	UNIQUE(ID)                         -- гарантує унікальність, не вийде однакові вписати           
GO

ALTER TABLE EmployeesInfo 
	ADD CONSTRAINT FK_EmployeesInfo_Employees 
	FOREIGN KEY (ID)                   -- зовнішній ключ
	REFERENCES Employees(ID)           
	ON DELETE CASCADE
GO

--4) таблиця Medicaments
ALTER TABLE Medicaments 
	ADD CONSTRAINT PK_Medicaments
	PRIMARY KEY (ID) 
GO

--5) таблиця Stocks
ALTER TABLE Stocks  
	ADD CONSTRAINT UQ_Stocks
	UNIQUE(MedicamentID)
GO

ALTER TABLE Stocks 
	ADD CONSTRAINT FK_Stocks_Products 
	FOREIGN KEY (MedicamentID) 
	REFERENCES Medicaments(ID) 
	ON DELETE CASCADE                  -- при видаленні видаляться всі поєднання;
GO

--6) таблиця Orders
ALTER TABLE Orders 
	ADD CONSTRAINT PK_Orders 
	PRIMARY KEY (ID) 
GO

ALTER TABLE Orders 
	ADD CONSTRAINT FK_Orders_Customers 
	FOREIGN KEY(CustomerID) 
	REFERENCES Customers(ID) 
	ON DELETE SET NULL                 -- у видалених ячейках буде NULL
GO

ALTER TABLE Orders 
	ADD CONSTRAINT FK_Orders_Employees 
	FOREIGN KEY(EmployeeID) 
	REFERENCES Employees(ID)
	ON DELETE SET NULL  
GO

--7) таблиця OrderDetails
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



--4. Ввів обмеження.

/*1) Обмеження на правильність введення номеру мобільного телефону.
  2) Обмеження на від'ємне значення товару в запасах.*/

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



-- 5. Заповнив таблиці. 
INSERT Customers                                              --оператор вставки INSERT
(FName, MName, LName, [Address], City, Phone, DateInSystem)   --вказав порядок запису даних
VALUES                                                        --ключове слово з INSERT разом
('Віктор','Вікторович','Прокопенко','Василенка 21а, 100','Луцьк','(063)4569385',GETDATE()),
('Антон','Олегович','Крук','Глибочицька 70','Київ','(093)1416433',GETDATE()),
('Оксана','Володимирівна','Десятова','Глибочицька 7а, 22','Київ','(068)0989367',GETDATE()),
('Анна','Дмитрівна','Шевченко','Вишнева 15','Харків','(098)4569111',GETDATE()),
('Анатолій','Петрович','Дідух','Дружби 10','Суми','(068)2229325',GETDATE()),
('Іван','Іванович','Тихий','Крива 54, 17','Полтава','(063)1119311',GETDATE()),
('Віктор','Олегович','Соловей','Лісова 11','Херсон','(068)4569344',GETDATE()),
('Ольга','Алексїївна','Ковтун','Дорогожицька 77, 99','Одеса','(050)4569255',GETDATE()),
('Аліна','Михайлівна','Мала','Науки 20','Миколаїв','(050)4539333',GETDATE()),
('Михайло','Андрійович','Савка','Медова 1','Київ','(063)9999380',GETDATE()),
('Артем','Іванович','Краватка','Артема 23','Житомир','(067)9995558',GETDATE());
GO

INSERT Employees
(FName, MName, LName, Post, Salary, PriorSalary)
VALUES
('Анатолій', 'Володимирович', 'Хитрий', 'Директор', 30000, 3000),
('Андрій', 'Антонович', 'Ступка', 'Провізор', 7000, 1500),
('Олег', 'Артемович', 'Суслік', 'Кладовщик', 5000, 500),
('Максим', 'Іванович', 'Рудьковський', 'Фармацевт', 5000, 500),
('Ірина', 'Михайлівна', 'Макар', 'Провізор', 7000, 1500),
('Юлія', 'Борисівна', 'Гаран', 'Фармацевт', 7000, 1500);
GO

INSERT EmployeesInfo
(ID, MaritalStatus, BirthDate, [Address], Phone)
VALUES
(1, 'Не одружений', '08/15/1970', 'Житомирська 16','(067)4564489'),
(2, 'Одружений', '09/09/1985', 'Малинова 15','(050)0564585'),
(3, 'Не одружений', '12/11/1990', 'Миру 16','(068)4560409'),
(4, 'Не одружений', '01/11/1988', 'Антоновича 11','(066)4664466'),
(5, 'Заміжня', '08/08/1990', 'Макогона 10','(093)4334493'),
(6, 'Заміжня', '01/10/1994', 'Петрівська 7','(063)4114141');
GO

INSERT Medicaments
(Name)
VALUES
('Бинт'),
('Серветки з хлоргексидином'),
('Розчин йоду 5%'),
('Нітрогліцерин 1%'),
('Рукавиці медичні'),
('Фіксатор шийного відділу хребта'),
('Портативний апарат для штучної вентиляції легенів АМБУ'),
('Сульфаціл натрію 20%'),
('мінеральна вода "Лужанська"'),
('Буторфанолу тартрат 0,2%');
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

--Вибрав всі дані з кожної таблиці.
SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Stocks
SELECT * FROM EmployeesInfo
SELECT * FROM Orders
SELECT * FROM Medicaments
SELECT * FROM OrderDetails



--7. 

--ВИДАЛИВ ЗВ'ЯЗКИ між таблицями.   ( Спочатку видаляти похідні, а потім основні )
ALTER TABLE Customers                 
DROP CONSTRAINT PK_Customers;
GO
 --1) таблиця Customers
ALTER TABLE Customers                 
DROP CONSTRAINT PK_Customers;
GO

--2) таблиця Employees
ALTER TABLE Employees 
DROP CONSTRAINT PK_Employees 
GO

--3) таблиця EmployeesInfo
ALTER TABLE EmployeesInfo  
DROP CONSTRAINT UQ_EmployeesInfo                             
GO

ALTER TABLE EmployeesInfo 
DROP CONSTRAINT FK_EmployeesInfo_Employees 
GO

--4) таблиця Medicaments
ALTER TABLE Medicaments 
DROP CONSTRAINT PK_Medicaments 
GO

--5) таблиця Stocks
ALTER TABLE Stocks  
DROP CONSTRAINT UQ_Stocks
GO

ALTER TABLE Stocks 
DROP CONSTRAINT FK_Stocks_Products                
GO

--6) таблиця Orders
ALTER TABLE Orders 
DROP CONSTRAINT PK_Orders 
GO

ALTER TABLE Orders 
DROP CONSTRAINT FK_Orders_Customers                
GO

ALTER TABLE Orders 
DROP CONSTRAINT FK_Orders_Employees 
GO

--7) таблиця OrderDetails
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
--ВИДАЛИВ ТАБЛИЦІ-----------
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