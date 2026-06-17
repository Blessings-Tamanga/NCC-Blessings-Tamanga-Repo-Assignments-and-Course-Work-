CREATE DATABASE Bloomfield_Garden_Centre_DB;
USE Bloomfield_Garden_Centre_DB;


-- CUSTOMER


CREATE TABLE Customer (
    Customer_Id VARCHAR(8) PRIMARY KEY,
    Customer_Firstname VARCHAR(50) NOT NULL,
    Customer_Lastname VARCHAR(50) NOT NULL,
    Customer_Email VARCHAR(100) UNIQUE NOT NULL,
    Customer_Gender VARCHAR(15),
    Customer_Phonenumber VARCHAR(15) NOT NULL,
    Customer_Address VARCHAR(100) NOT NULL,
    Customer_Status VARCHAR(15) DEFAULT 'Active',
    Customer_Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK (Customer_Gender IN ('Male','Female')),
    CHECK (Customer_Status IN ('Active','Inactive'))
);




-- EMPLOYEE ROLE


CREATE TABLE Employee_Role (
    Role_Id VARCHAR(8) PRIMARY KEY,
    Role_Name VARCHAR(50) UNIQUE NOT NULL,
    Role_Description TEXT NOT NULL,
    Role_Time_Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- EMPLOYEE QUALIFICATION


CREATE TABLE Employee_Qualification (
    Qualification_Id VARCHAR(8) PRIMARY KEY,
    Qualification_Name VARCHAR(100) UNIQUE NOT NULL
);


-- EMPLOYEE


CREATE TABLE Employee (
    Employee_Id VARCHAR(8) PRIMARY KEY,
    Employee_Firstname VARCHAR(50) NOT NULL,
    Employee_Lastname VARCHAR(50) NOT NULL,
    Employee_Email VARCHAR(100) UNIQUE NOT NULL,
    Employee_Phonenumber VARCHAR(15) NOT NULL,
    Employee_Working_Hours INT NOT NULL,
    Employee_Status VARCHAR(15) DEFAULT 'Active',

    Role_Id VARCHAR(8) NOT NULL,
    Qualification_Id VARCHAR(8) NOT NULL,

    FOREIGN KEY (Role_Id)
        REFERENCES Employee_Role(Role_Id),

    FOREIGN KEY (Qualification_Id)
        REFERENCES Employee_Qualification(Qualification_Id),

    CHECK (Employee_Status IN ('Active','Inactive'))
);


-- SUPPLIER


CREATE TABLE Supplier (
    Supplier_Id VARCHAR(8) PRIMARY KEY,
    Supplier_Name VARCHAR(50) NOT NULL,
    Supplier_Email VARCHAR(100) UNIQUE NOT NULL,
    Supplier_Phonenumber VARCHAR(15) UNIQUE NOT NULL,
    Supplier_Location VARCHAR(50) NOT NULL
);


-- PRODUCT CATEGORY


CREATE TABLE Product_Category (
    Category_Id VARCHAR(8) PRIMARY KEY,
    Category_Name VARCHAR(50) UNIQUE NOT NULL
);


-- PRODUCT


CREATE TABLE Product (
    Product_Id VARCHAR(8) PRIMARY KEY,
    Product_Name VARCHAR(50) NOT NULL,
    Product_Description TEXT NOT NULL,
    Product_Price DECIMAL(10,2) NOT NULL,
    Product_Stock_Quantity INT NOT NULL,
    Product_Date_Added DATE NOT NULL,

    Category_Id VARCHAR(8) NOT NULL,
    Supplier_Id VARCHAR(8) NOT NULL,

    FOREIGN KEY (Category_Id)
        REFERENCES Product_Category(Category_Id),

    FOREIGN KEY (Supplier_Id)
        REFERENCES Supplier(Supplier_Id)
);


-- TRAINING


CREATE TABLE Training (
    Training_Id VARCHAR(8) PRIMARY KEY,
    Training_Name VARCHAR(50) NOT NULL,
    Training_Description TEXT NOT NULL,
    Training_Duration VARCHAR(15) NOT NULL,
    Training_Level VARCHAR(15) NOT NULL
);


-- EMPLOYEE TRAINING


CREATE TABLE Employee_Training (
    Training_Id VARCHAR(8),
    Employee_Id VARCHAR(8),

    Completion_Date DATE NOT NULL,
    Expiry_Date DATE NOT NULL,

    PRIMARY KEY (Training_Id, Employee_Id),

    FOREIGN KEY (Training_Id)
        REFERENCES Training(Training_Id),

    FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id)
);


-- SESSION TYPE


CREATE TABLE Session_Type (
    Session_Type_Id VARCHAR(8) PRIMARY KEY,
    Session_Name VARCHAR(50) UNIQUE NOT NULL,
    Session_Description TEXT NOT NULL
);


-- SESSION


CREATE TABLE Session (
    Session_Id VARCHAR(8) PRIMARY KEY,
    Session_Title VARCHAR(50) NOT NULL,
    Session_Description TEXT NOT NULL,
    Session_Date DATE NOT NULL,
    Session_Time TIME NOT NULL,
    Session_Location VARCHAR(50) NOT NULL,
    Session_Max_Attendance INT NOT NULL,
    Status VARCHAR(15) NOT NULL,

    Session_Type_Id VARCHAR(8) NOT NULL,

    FOREIGN KEY (Session_Type_Id)
        REFERENCES Session_Type(Session_Type_Id),

    CHECK (Status IN ('Scheduled','Completed','Cancelled'))
);


-- EQUIPMENT


CREATE TABLE Equipment (
    Equipment_Id VARCHAR(8) PRIMARY KEY,
    Equipment_Name VARCHAR(50) NOT NULL,
    Equipment_Quantity INT NOT NULL,
    Equipment_Description TEXT NOT NULL,
    Equipment_Status VARCHAR(15) NOT NULL,
    Equipment_Cost DECIMAL(10,2) NOT NULL,
    Equipment_Purchase_Date DATE NOT NULL,

    CHECK (Equipment_Status IN ('Available','Unavailable'))
);


-- SESSION EMPLOYEE


CREATE TABLE Session_Employee (
    Session_Id VARCHAR(8),
    Employee_Id VARCHAR(8),

    PRIMARY KEY (Session_Id, Employee_Id),

    FOREIGN KEY (Session_Id)
        REFERENCES Session(Session_Id),

    FOREIGN KEY (Employee_Id)
        REFERENCES Employee(Employee_Id)
);


-- SESSION EQUIPMENT


CREATE TABLE Session_Equipment (
    Session_Id VARCHAR(8),
    Equipment_Id VARCHAR(8),

    PRIMARY KEY (Session_Id, Equipment_Id),

    FOREIGN KEY (Session_Id)
        REFERENCES Session(Session_Id),

    FOREIGN KEY (Equipment_Id)
        REFERENCES Equipment(Equipment_Id)
);


-- SESSION ATTENDANCE

CREATE TABLE Session_Attendance (
    Session_Attendance_Id INT AUTO_INCREMENT PRIMARY KEY,

    Session_Id VARCHAR(8) NOT NULL,
    Customer_Id VARCHAR(8) NOT NULL,

    Attendance_Date DATE NOT NULL,
    Attendance_Status VARCHAR(15) NOT NULL,

    FOREIGN KEY (Session_Id)
        REFERENCES Session(Session_Id),

    FOREIGN KEY (Customer_Id)
        REFERENCES Customer(Customer_Id),

    CHECK (Attendance_Status IN ('Present','Absent','Late'))
);


-- SALE TRANSACTION

CREATE TABLE Sale_Transaction (
    Transaction_Id INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_Date DATE NOT NULL, -- THIS IS THE NEW COLUMN
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    Customer_Id VARCHAR(8) NOT NULL,
    Employee_Id VARCHAR(8) NOT NULL,
    Product_Id VARCHAR(8) NOT NULL,

    FOREIGN KEY (Customer_Id) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Employee_Id) REFERENCES Employee(Employee_Id),
    FOREIGN KEY (Product_Id) REFERENCES Product(Product_Id)
);


DESC Customer;
DESC Employee_Role;
DESC Employee_Qualification;
DESC Employee;
DESC Supplier;
DESC Product_Category;
DESC Product;
DESC Training;
DESC Employee_Training;
DESC Session_Type;
DESC Session;
DESC Equipment;
DESC Session_Employee;
DESC Session_Equipment;
DESC Session_Attendance;
DESC Sale_Transaction;




-- Inserting sample data into Customer table

INSERT INTO Customer (
    Customer_Id,
    Customer_Firstname,
    Customer_Lastname,
    Customer_Email,
    Customer_Gender,
    Customer_Phonenumber,
    Customer_Address,
    Customer_Status
)
VALUES
('C001','John','Banda','john@gmail.com','Male','0991243675','Area 23','Active'),
('C002','Sarah','Phiri','sarah@gmail.com','Female','0880213436','Area 21','Active'),
('C003','John','Kaliyeka','jk@gmail.com','Male','0999302267','Area 22','Inactive'),
('C004','Doreen','Jaliwa','doreen@gmail.com','Female','0880213425','Area 49','Active'),
('C005','Grace','Mbewe','grace@gmail.com','Female','0991283675','Area 15','Active'),
('C006','Blessings','Tamanga','blessings@gmail.com','Male','0991112223','Area 25','Active'),
('C007','Chikondi','Phiri','chikondi@gmail.com','Female','0981234567','Area 18','Active'),
('C008','Chimwemwe','Banda','chimwemwe@gmail.com','Male','0891234567','Area 43','Active'),
('C009','Chisomo','Kachali','chisomo@gmail.com','Female','0992345678','Area 47','Active'),
('C010','Wallace','Tambala','wallace@gmail.com','Male','0982345678','Area 30','Inactive');


-- -- Inserting sample data into Employee Role table

INSERT INTO Employee_Role
(Role_Id, Role_Name, Role_Description)
VALUES
('R001','Workshop Facilitator','Workshop hosting and farm work'),
('R002','Customer Care','Customer care and advising'),
('R003','Plant Specialist','Plant preparation'),
('R004','Field Worker','Physical work structuring'),
('R005','Finance Officer','Finance handling'),
('R006','Store Keeper','Stock management'),
('R007','Sales Assistant','Product sales and support'),
('R008','Marketing Officer','Marketing and promotions');


--Inserting sample data into Employee Qualification table
INSERT INTO Employee_Qualification
(Qualification_Id, Qualification_Name)
VALUES
('Q001','Bachelor Degree in Cropping Systems'),
('Q002','Certificate in Sales Management'),
('Q003','Diploma in Organic Chemistry'),
('Q004','Certificate in Land Labouring'),
('Q005','Master Degree in Agricultural Economics'),
('Q006','Diploma in Horticulture'),
('Q007','Certificate in Agricultural Extension'),
('Q008','Bachelor Degree in Agribusiness');


--Inserting sample data into Supplier table
INSERT INTO Supplier
(
Supplier_Id,
Supplier_Name,
Supplier_Email,
Supplier_Phonenumber,
Supplier_Location
)
VALUES
('SUP001','AgriSupplies Ltd','info@agrisupplies.mw','0997788112','Lilongwe'),
('SUP002','Ferticore Ltd','sales@ferticore.mw','0997654321','Blantyre'),
('SUP003','UlimiWathu Ltd','sales@ulimiwathu.mw','0991234567','Mzuzu'),
('SUP004','MbewuZathu Ltd','sales@mbewuzathu.mw','0981234567','Lilongwe'),
('SUP005','Agricom Ltd','info@agricom.mw','0891234567','Blantyre'),
('SUP006','Green Harvest Ltd','sales@greenharvest.mw','0992345678','Zomba');


--Inserting sample data into product category table
INSERT INTO Product_Category
(Category_Id, Category_Name)
VALUES
('PC001','Plant'),
('PC002','Accessory'),
('PC003','Crop Yield'),
('PC004','Seeds'),
('PC005','Fertilizers'),
('PC006','Irrigation Equipment'),
('PC007','Gardening Tools'),
('PC008','Pesticides');


--training
INSERT INTO Training
(
Training_Id,
Training_Name,
Training_Description,
Training_Duration,
Training_Level
)
VALUES
('T001','Organic Farming Basics','Introduction to organic farming','3 Days','Beginner'),
('T002','Pest Management','Natural pest control techniques','2 Days','Intermediate'),
('T003','Soil Health','Understanding soil composition','1 Day','Beginner'),
('T004','Advanced Irrigation','Water management systems','2 Days','Advanced'),
('T005','Customer Service Skills','Effective communication','3 Days','Advanced'),
('T006','Greenhouse Management','Greenhouse operation skills','2 Days','Intermediate'),
('T007','Seed Propagation','Plant propagation techniques','3 Days','Beginner'),
('T008','Agribusiness','Farm business management','5 Days','Advanced');


--Inserting sample data into Session Type table

INSERT INTO Session_Type
(Session_Type_Id, Session_Name, Session_Description)
VALUES
('ST01','Workshop','Hands-on practical training'),
('ST02','Seminar','Lecture based session'),
('ST03','Field Training','Outdoor practical demonstration'),
('ST04','Demonstration','Practical demonstration'),
('ST05','Exhibition','Agricultural exhibition');



--Inserting sample data into Employee table

INSERT INTO Employee
(
    Employee_Id,
    Employee_Firstname,
    Employee_Lastname,
    Employee_Email,
    Employee_Phonenumber,
    Employee_Working_Hours,
    Employee_Status,
    Qualification_Id,
    Role_Id
)
VALUES
('E001','Peter','Zuze','peter@greenfield.com','0999201829',7,'Active','Q001','R001'),
('E002','Mary','Banda','mary@greenfield.com','0889254262',16,'Active','Q002','R002'),
('E003','James','Lawi','james@greenfield.com','0893242634',12,'Active','Q003','R003'),
('E004','Patrick','Phiri','patrick@greenfield.com','0981245346',16,'Active','Q004','R004'),
('E005','Joana','Linde','joana@greenfield.com','0885424256',4,'Active','Q005','R005'),
('E006','Exton','Tamanga','exton@gmail.com','0991234111',8,'Active','Q006','R006'),
('E007','Tapiwah','Sendema','tapiwah@greenfield.com','0981111222',8,'Active','Q007','R007'),
('E008','Owen','Ndalama','owen@greenfield.com','0891223344',10,'Active','Q008','R008'),
('E009','Daudeni','Mbendera','daudent@gmail.com','0992223333',8,'Active','Q006','R007'),
('E010','Bornface','Takhoza','bornface@greenfield.com','0982334455',8,'Active','Q007','R006');


-- Inserting sample data into Product table

INSERT INTO Product
(
    Product_Id,
    Product_Name,
    Product_Description,
    Product_Price,
    Product_Stock_Quantity,
    Product_Date_Added,
    Category_Id,
    Supplier_Id
)
VALUES
('P001','Rose Plant','Hybrid tea rose',10000.00,5,'2026-04-20','PC001','SUP001'),
('P002','Watering Can','10L galvanized steel',15000.00,2,'2026-05-21','PC002','SUP001'),
('P003','Tomato Seed','Organic heirloom',1000.00,10,'2026-06-22','PC004','SUP001'),
('P004','Fertilizer','NPK 23-21-0+4S',150000.00,15,'2026-01-23','PC005','SUP002'),
('P005','Garden Gloves','Heavy-duty leather',10000.00,20,'2026-12-27','PC002','SUP001'),
('P006','Maize Seed','Hybrid maize seed',5000.00,50,'2026-03-10','PC004','SUP004'),
('P007','Drip Pipe','Irrigation pipe',25000.00,25,'2026-04-15','PC006','SUP005'),
('P008','Wheelbarrow','Steel wheelbarrow',75000.00,10,'2026-05-01','PC007','SUP003'),
('P009','Insecticide','Crop protection chemical',35000.00,15,'2026-05-20','PC008','SUP006'),
('P010','Cabbage Seed','High-yield cabbage seed',4000.00,40,'2026-06-01','PC004','SUP004');


--Inserting sample data into Session table
INSERT INTO Session
(
    Session_Id,
    Session_Title,
    Session_Description,
    Session_Date,
    Session_Time,
    Session_Location,
    Session_Max_Attendance,
    Status,
    Session_Type_Id
)
VALUES
('S001','Organic Gardening','Intro to chemical-free gardening','2026-06-15','09:00:00','Main Hall',20,'Scheduled','ST01'),
('S002','DIY Home Garden','Building backyard vegetable plots','2026-06-20','10:00:00','Garden Plot A',15,'Scheduled','ST01'),
('S003','Sustainable Farming','Long-term soil health practices','2026-07-10','08:00:00','Conference Room',30,'Scheduled','ST03'),
('S004','Greenhouse Farming','Greenhouse techniques','2026-07-20','09:00:00','Main Hall',25,'Scheduled','ST04'),
('S005','Seed Propagation','Plant propagation workshop','2026-08-10','10:00:00','Garden Plot B',20,'Scheduled','ST01'),
('S006','Modern Irrigation','Irrigation methods','2026-08-25','08:00:00','Conference Room',30,'Scheduled','ST03'),
('S007','Agribusiness Expo','Agribusiness opportunities','2026-09-05','09:00:00','Exhibition Ground',50,'Scheduled','ST05'),
('S008','Crop Protection','Pest and disease control','2026-09-15','10:00:00','Main Hall',25,'Scheduled','ST02');


--Inserting sample data into Equipment table
INSERT INTO Equipment
(
    Equipment_Id,
    Equipment_Name,
    Equipment_Quantity,
    Equipment_Description,
    Equipment_Status,
    Equipment_Cost,
    Equipment_Purchase_Date
)
VALUES
('EQ01','Shovel',16,'Steel spade with wooden handle','Available',25000.00,'2025-01-10'),
('EQ02','Projector',10,'Epson 1080p HD classroom projector','Available',450000.00,'2025-03-10'),
('EQ03','Hoe',15,'Traditional forked jembe','Available',1500.00,'2025-03-15'),
('EQ04','Microphone',20,'Portable handheld microphone','Available',85000.00,'2025-03-15'),
('EQ05','Speaker',20,'JBL portable speaker','Available',12000.00,'2025-03-15'),
('EQ06','Sprayer',12,'Knapsack sprayer','Available',45000.00,'2025-04-10'),
('EQ07','Garden Fork',15,'Steel garden fork','Available',12000.00,'2025-04-15'),
('EQ08','Water Pump',5,'Irrigation water pump','Available',350000.00,'2025-05-01'),
('EQ09','Generator',3,'Backup power generator','Available',950000.00,'2025-06-01'),
('EQ10','Wheelbarrow',10,'Steel wheelbarrow','Available',75000.00,'2025-06-15');


--Inserting sample data into employee training table
INSERT INTO Employee_Training
(Training_Id, Employee_Id, Completion_Date, Expiry_Date)
VALUES
('T001','E001','2025-06-15','2027-06-15'),
('T001','E003','2025-06-15','2027-06-15'),
('T002','E001','2025-08-20','2027-08-20'),
('T002','E004','2025-08-20','2027-08-20'),
('T003','E002','2025-09-10','2027-09-10'),
('T003','E005','2025-09-10','2027-09-10'),
('T004','E001','2026-01-15','2028-01-15'),
('T005','E006','2026-02-10','2028-02-10'),
('T006','E007','2026-03-15','2028-03-15'),
('T007','E008','2026-04-20','2028-04-20'),
('T008','E009','2026-05-10','2028-05-10'),
('T006','E010','2026-06-01','2028-06-01');


--Inserting sample data into Session_Employee table
INSERT INTO Session_Employee
(Session_Id, Employee_Id)
VALUES
('S001','E001'),
('S001','E002'),
('S002','E003'),
('S002','E001'),
('S003','E004');


--Inserting sample data into Session_Equipment table
INSERT INTO Session_Equipment
(Session_Id, Equipment_Id)
VALUES
('S001','EQ01'),
('S001','EQ02'),
('S002','EQ03'),
('S002','EQ04'),
('S003','EQ02'),
('S003','EQ05');


--Inserting sample data into Session_Attendance table
INSERT INTO Session_Attendance
(
    Session_Id,
    Customer_Id,
    Attendance_Date,
    Attendance_Status
)
VALUES
('S001','C001','2026-06-15','Present'),
('S002','C002','2026-06-20','Present'),
('S002','C003','2026-06-20','Absent'),
('S001','C004','2026-06-15','Present'),
('S003','C005','2026-07-10','Present'),
('S004','C006','2026-07-20','Present'),
('S005','C007','2026-08-10','Present'),
('S006','C008','2026-08-25','Present'),
('S007','C009','2026-09-05','Late'),
('S008','C010','2026-09-15','Present');


--Inserting sample data into Sale_Transaction table
INSERT INTO Sale_Transaction 
(Transaction_Date, Quantity, Unit_Price, Customer_Id, Employee_Id, Product_Id)
VALUES
('2026-05-15', 1, 10000.00, 'C001', 'E001', 'P001'),
('2026-05-18', 1, 15000.00, 'C002', 'E001', 'P002'),
('2026-05-20', 2, 1000.00, 'C003', 'E003', 'P003'),
('2026-04-10', 1, 150000.00, 'C004', 'E005', 'P004'),
('2026-05-25', 1, 10000.00, 'C005', 'E002', 'P005'),
('2026-03-12', 2, 5000.00, 'C006', 'E006', 'P006'),
('2026-05-30', 1, 25000.00, 'C007', 'E007', 'P007'),
('2026-02-14', 1, 75000.00, 'C008', 'E008', 'P008'),
('2026-05-05', 2, 35000.00, 'C009', 'E009', 'P009'),
('2026-01-20', 3, 4000.00, 'C010', 'E010', 'P010');

--Displaying all records to test the tables and data if created
SELECT * FROM Customer;
SELECT * FROM Employee_Role;
SELECT * FROM Employee_Qualification;
SELECT * FROM Employee;
SELECT * FROM Supplier;
SELECT * FROM Product_Category;
SELECT * FROM Product;
SELECT * FROM Training;
SELECT * FROM Employee_Training;
SELECT * FROM Session_Type;
SELECT * FROM Session;
SELECT * FROM Equipment;
SELECT * FROM Session_Employee;
SELECT * FROM Session_Equipment;
SELECT * FROM Session_Attendance;
SELECT * FROM Sale_Transaction;



--Creating roles
CREATE ROLE admin;
CREATE ROLE sales;

---creating users and assigning roles
CREATE USER 'admin_user'@'localhost'
IDENTIFIED BY 'Admin123!';

CREATE USER 'sales_user'@'localhost'
IDENTIFIED BY 'Sales123!';





--Task 5

-- Task 5a  Update price using a subquery
UPDATE Product
SET Product_Price = Product_Price * 1.10
WHERE Category_Id IN (
    SELECT Category_Id 
    FROM Product_Category 
    WHERE Category_Name = 'Gardening Tools'
);

-- Verify the update
SELECT Product_Name, Category_Id, Product_Price 
FROM Product 
WHERE Category_Id = 'PC007';


-- Task 5b Using NOT EXISTS (Anti-Join)
SELECT 
    p1.Product_Name, 
    pc.Category_Name AS Type, 
    p1.Product_Price, 
    p1.Product_Description
FROM Product p1
JOIN Product_Category pc ON p1.Category_Id = pc.Category_Id
WHERE pc.Category_Name IN ('Plant', 'Gardening Tools', 'Accessory')
  AND NOT EXISTS (
      SELECT 1 
      FROM Product p2 
      WHERE p2.Category_Id = p1.Category_Id 
        AND p2.Product_Price > p1.Product_Price
  );

  -- Task 5c: Total sales for May 2026, 
SELECT 
    pc.Category_Name,
    SUM(st.Quantity) AS Total_Quantity_Sold,
    SUM(st.Quantity * st.Unit_Price) AS Total_Revenue
FROM Sale_Transaction st
JOIN Product p ON st.Product_Id = p.Product_Id
JOIN Product_Category pc ON p.Category_Id = pc.Category_Id
WHERE st.Transaction_Date >= '2026-05-01' AND st.Transaction_Date <= '2026-05-31'
GROUP BY pc.Category_Name
ORDER BY Total_Revenue DESC;

-- Task 5d: Upcoming workshops/events within the next month with participant counts
SELECT 
    s.Session_Title, 
    s.Session_Date, 
    s.Session_Time, 
    COUNT(sa.Session_Attendance_Id) AS Registered_Participants
FROM Session s
LEFT JOIN Session_Attendance sa ON s.Session_Id = sa.Session_Id
WHERE s.Session_Date BETWEEN '2026-06-01' AND '2026-07-01' 
GROUP BY s.Session_Id, s.Session_Title, s.Session_Date, s.Session_Time
ORDER BY s.Session_Date ASC, s.Session_Time ASC;

-- Task 5e: Rank employees by total revenue generated up to a specific date
SELECT 
    e.Employee_Id,
    e.Employee_Firstname, 
    e.Employee_Lastname,
    SUM(st.Quantity * st.Unit_Price) AS Total_Revenue_Generated,
    RANK() OVER (ORDER BY SUM(st.Quantity * st.Unit_Price) DESC) AS Revenue_Rank
FROM Employee e
JOIN Sale_Transaction st ON e.Employee_Id = st.Employee_Id
WHERE st.Transaction_Date <= '2026-06-01' -- Specific date chosen to capture all sample data
GROUP BY e.Employee_Id, e.Employee_Firstname, e.Employee_Lastname
ORDER BY Revenue_Rank ASC;