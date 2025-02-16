SELECT SCHEMA_NAME AS name
FROM information_schema.SCHEMATA
LIMIT 0, 1000;
create database sb_vs_fms;
drop database if exists sb_vs_fms;
create database sb;
drop database sb;

-- Creating a Crowdfunding Platform Management Database

create database sb_vs_crowdfund2;
use sb_vs_crowdfund2;

-- DDL Operations - Creating tables for Crowdfunding Platform Management Database

-- Table: Campaigns
CREATE TABLE Campaigns (
    CampaignID BINARY(6) PRIMARY KEY,
    CampaignName VARCHAR(255) NOT NULL,
    Organizer VARCHAR(255) NOT NULL,
    TargetAmount DECIMAL(15, 2) NOT NULL, 
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status ENUM('Active', 'Completed', 'Cancelled') NOT NULL
);

-- Table: Backers
CREATE TABLE Backers (
    BackerID BINARY(6) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber CHAR(10), -- CHAR for fixed-length phone numbers
    Address TEXT
);

-- Table: PaymentMethods
CREATE TABLE PaymentMethods (
    PaymentMethodID BINARY(6) PRIMARY KEY,
    MethodName VARCHAR(255) NOT NULL,
    ProcessingFeePercentage DECIMAL(5, 2) NOT NULL 
);

-- Table: Organizations
CREATE TABLE Organizations (
    OrganizationID BINARY(6) PRIMARY KEY,
    OrganizationName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber CHAR(15), -- CHAR for fixed-length phone numbers
    Address TEXT,
    TaxID CHAR(10) NOT NULL UNIQUE -- Fixed-length TaxID with CHAR
);

-- Table: Individuals
CREATE TABLE Individuals (
    IndividualID BINARY(6) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber CHAR(10), -- CHAR for fixed-length phone numbers
    Address TEXT,
    IsAnonymous BOOLEAN NOT NULL DEFAULT FALSE
);

-- Table: Contributions
CREATE TABLE Contributions (
    ContributionID BINARY(6),
    CampaignID BINARY(6) NOT NULL,
    BackerID BINARY(6),
    PaymentMethodID BINARY(6),
    OrganizationID BINARY(6),
    IndividualID BINARY(6),
    ContributionAmount DECIMAL(15, 2) NOT NULL, 
    ContributionDate DATE NOT NULL,
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID),
    FOREIGN KEY (BackerID) REFERENCES Backers(BackerID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID),
    FOREIGN KEY (OrganizationID) REFERENCES Organizations(OrganizationID),
    FOREIGN KEY (IndividualID) REFERENCES Individuals(IndividualID)
);

-- Table: Rewards
CREATE TABLE Rewards (
    RewardID BINARY(6) PRIMARY KEY,
    CampaignID BINARY(6) NOT NULL,
    RewardDescription TEXT NOT NULL,
    MinimumContribution DECIMAL(15, 2) NOT NULL, 
    FOREIGN KEY (CampaignID) REFERENCES Campaigns(CampaignID)
);

-- Table: RewardClaims
CREATE TABLE RewardClaims (
    ClaimID BINARY(6) PRIMARY KEY,
    RewardID BINARY(6) NOT NULL,
    BackerID BINARY(6) NOT NULL,
    ClaimDate DATE NOT NULL,
    DeliveryStatus ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    FOREIGN KEY (RewardID) REFERENCES Rewards(RewardID),
    FOREIGN KEY (BackerID) REFERENCES Backers(BackerID)
);

-- Inputing dummy data

INSERT INTO Campaigns (CampaignID, CampaignName, Organizer, TargetAmount, StartDate, EndDate, Status) VALUES
('CAM01A', 'Education for All', 'Amit Verma', 500000.00, '2024-01-01', '2024-03-31', 'Active'),
('CAM02B', 'Medical Aid for Children', 'Riya Sharma', 750000.00, '2024-02-15', '2024-04-30', 'Active'),
('CAM03C', 'Green Earth Initiative', 'Neha Gupta', 400000.00, '2024-03-10', '2024-06-15', 'Completed'),
('CAM04D', 'Support Local Artists', 'Rahul Khanna', 300000.00, '2024-04-05', '2024-07-20', 'Active'),
('CAM05E', 'Disaster Relief Fund', 'Priya Sinha', 1000000.00, '2024-05-01', '2024-08-10', 'Completed'),
('CAM06F', 'Women Empowerment Drive', 'Sakshi Mehta', 450000.00, '2024-06-20', '2024-09-30', 'Active'),
('CAM07G', 'Animal Shelter Support', 'Kunal Malhotra', 600000.00, '2024-07-15', '2024-10-15', 'Cancelled'),
('CAM08H', 'Tech Education for Kids', 'Nitin Joshi', 500000.00, '2024-08-10', '2024-11-10', 'Active'),
('CAM09I', 'Flood Relief Initiative', 'Divya Rao', 850000.00, '2024-09-01', '2024-12-01', 'Completed'),
('CAM10J', 'Startup Seed Funding', 'Vikas Singh', 700000.00, '2024-10-05', '2025-01-15', 'Active'),
('CAM11K', 'Mental Health Awareness', 'Ananya Patel', 550000.00, '2024-11-10', '2025-02-20', 'Active'),
('CAM12L', 'Wildlife Conservation', 'Rohit Jain', 650000.00, '2024-12-05', '2025-03-30', 'Active'),
('CAM13M', 'Senior Citizen Support', 'Meera Kapoor', 400000.00, '2025-01-01', '2025-04-15', 'Active'),
('CAM14N', 'Clean Water Initiative', 'Manish Thakur', 900000.00, '2025-02-10', '2025-05-25', 'Completed'),
('CAM15O', 'Scholarship Fund', 'Swati Mishra', 600000.00, '2025-03-05', '2025-06-20', 'Active'),
('CAM16P', 'Food for Homeless', 'Aditya Rao', 750000.00, '2025-04-15', '2025-07-30', 'Active'),
('CAM17Q', 'Youth Skill Development', 'Tarun Sehgal', 500000.00, '2025-05-20', '2025-08-10', 'Cancelled'),
('CAM18R', 'Solar Energy for Villages', 'Reena Das', 800000.00, '2025-06-01', '2025-09-15', 'Active'),
('CAM19S', 'Library for Rural Schools', 'Shalini Bhat', 550000.00, '2025-07-10', '2025-10-30', 'Active'),
('CAM20T', 'Cancer Treatment Fund', 'Dev Mehta', 950000.00, '2025-08-15', '2025-12-01', 'Completed');

INSERT INTO Backers (BackerID, Name, Email, PhoneNumber, Address) VALUES
('BAC01A', 'Rajesh Nair', 'rajesh.nair@example.com', '9876543210', 'Mumbai, Maharashtra'),
('BAC02B', 'Sanya Mehta', 'sanya.mehta@example.com', '9823456789', 'Pune, Maharashtra'),
('BAC03C', 'Anil Kapoor', 'anil.kapoor@example.com', '9832123456', 'Delhi, India'),
('BAC04D', 'Priya Rajan', 'priya.rajan@example.com', '9812345678', 'Chennai, Tamil Nadu'),
('BAC05E', 'Vikram Sharma', 'vikram.sharma@example.com', '9879876543', 'Kolkata, West Bengal'),
('BAC06F', 'Ritu Arora', 'ritu.arora@example.com', '9865234789', 'Bangalore, Karnataka'),
('BAC07G', 'Gaurav Malhotra', 'gaurav.malhotra@example.com', '9811198765', 'Hyderabad, Telangana'),
('BAC08H', 'Neeta Chawla', 'neeta.chawla@example.com', '9854321987', 'Ahmedabad, Gujarat'),
('BAC09I', 'Kunal Sen', 'kunal.sen@example.com', '9810987654', 'Lucknow, Uttar Pradesh'),
('BAC10J', 'Megha Verma', 'megha.verma@example.com', '9823412345', 'Jaipur, Rajasthan'),
('BAC11K', 'Suresh Pillai', 'suresh.pillai@example.com', '9867543210', 'Bhopal, Madhya Pradesh'),
('BAC12L', 'Ananya Joshi', 'ananya.joshi@example.com', '9856432178', 'Patna, Bihar'),
('BAC13M', 'Ramesh Yadav', 'ramesh.yadav@example.com', '9843216547', 'Surat, Gujarat'),
('BAC14N', 'Divya Shetty', 'divya.shetty@example.com', '9876123450', 'Indore, Madhya Pradesh'),
('BAC15O', 'Nikhil Tiwari', 'nikhil.tiwari@example.com', '9812346578', 'Nagpur, Maharashtra'),
('BAC16P', 'Rekha Sinha', 'rekha.sinha@example.com', '9827654321', 'Chandigarh, India'),
('BAC17Q', 'Ajay Saxena', 'ajay.saxena@example.com', '9876542109', 'Noida, Uttar Pradesh'),
('BAC18R', 'Sweta Das', 'sweta.das@example.com', '9812345698', 'Kochi, Kerala'),
('BAC19S', 'Alok Reddy', 'alok.reddy@example.com', '9834567891', 'Visakhapatnam, Andhra Pradesh'),
('BAC20T', 'Ishita Ghosh', 'ishita.ghosh@example.com', '9878901234', 'Bhubaneswar, Odisha');

INSERT INTO PaymentMethods (PaymentMethodID, MethodName, ProcessingFeePercentage) VALUES
('PAY01A', 'Credit Card', 2.50),
('PAY02B', 'Debit Card', 1.75),
('PAY03C', 'UPI', 1.00),
('PAY04D', 'Net Banking', 1.50),
('PAY05E', 'Credit Card', 2.50),
('PAY06F', 'Debit Card', 1.75),
('PAY07G', 'UPI', 1.00),
('PAY08H', 'Net Banking', 1.50),
('PAY09I', 'Credit Card', 2.50),
('PAY10J', 'Debit Card', 1.75),
('PAY11K', 'UPI', 1.00),
('PAY12L', 'Net Banking', 1.50),
('PAY13M', 'Credit Card', 2.50),
('PAY14N', 'Debit Card', 1.75),
('PAY15O', 'UPI', 1.00),
('PAY16P', 'Net Banking', 1.50),
('PAY17Q', 'Credit Card', 2.50),
('PAY18R', 'Debit Card', 1.75),
('PAY19S', 'UPI', 1.00),
('PAY20T', 'Net Banking', 1.50);

INSERT INTO Organizations (OrganizationID, OrganizationName, ContactPerson, Email, PhoneNumber, Address, TaxID) VALUES
('ORG01A', 'Paws Rescue India', 'Ramesh Kumar', 'contact@pawsrescue.org', '9823456789', 'Mumbai, Maharashtra', 'TAX0012345'),
('ORG02B', 'TeachForIndia', 'Ananya Roy', 'info@teachforindia.org', '9876543210', 'Pune, Maharashtra', 'TAX0023456'),
('ORG03C', 'Helping Hands', 'Manoj Tiwari', 'help@helpinghands.org', '9865231470', 'Delhi', 'TAX0034567'),
('ORG04D', 'Aarogya Foundation', 'Sunita Mehta', 'support@aarogya.org', '9765321478', 'Bangalore, Karnataka', 'TAX0045678'),
('ORG05E', 'Startup India', 'Vikas Sharma', 'hello@startupindia.org', '9012567890', 'Chennai, Tamil Nadu', 'TAX0056789'),
('ORG06F', 'EdTech Foundation', 'Pooja Reddy', 'contact@edtech.org', '9769876543', 'Hyderabad, Telangana', 'TAX0067890'),
('ORG07G', 'Go Green India', 'Amit Singh', 'support@gogreen.org', '9654123789', 'Kolkata, West Bengal', 'TAX0078901'),
('ORG08H', 'MindCare India', 'Priya Iyer', 'info@mindcare.org', '9872143650', 'Jaipur, Rajasthan', 'TAX0089012'),
('ORG09I', 'Sustainable Future', 'Sandeep Sen', 'hello@sustainable.org', '9998887776', 'Lucknow, Uttar Pradesh', 'TAX0090123'),
('ORG10J', 'HealthCare NGO', 'Meera Patel', 'contact@healthcare.org', '9876542310', 'Bangalore, Karnataka', 'TAX0101234'),
('ORG11K', 'Youth Sports Academy', 'Rahul Gupta', 'info@youthsports.org', '9021345678', 'Indore, Madhya Pradesh', 'TAX0112345'),
('ORG12L', 'Green Earth', 'Tina Kapoor', 'hello@greenearth.org', '9756432109', 'Patna, Bihar', 'TAX0123456'),
('ORG13M', 'Handicrafts India', 'Rakesh Rao', 'support@handicrafts.org', '9988776655', 'Goa', 'TAX0134567'),
('ORG14N', 'Peace Foundation', 'Deepak Nair', 'info@peacefoundation.org', '9321564789', 'Noida, Uttar Pradesh', 'TAX0145678'),
('ORG15O', 'Red Cross India', 'Sonia Das', 'help@redcross.org', '9090909090', 'Thiruvananthapuram, Kerala', 'TAX0156789'),
('ORG16P', 'Smile Foundation', 'Ravi Pillai', 'hello@smile.org', '9123456789', 'Guwahati, Assam', 'TAX0167890'),
('ORG17Q', 'HungerFree India', 'Rohit Chopra', 'support@hungerfree.org', '9988774422', 'Chandigarh', 'TAX0178901'),
('ORG18R', 'Wildlife Conservation', 'Kiran Bhatt', 'contact@wildlife.org', '9723456789', 'Shimla, Himachal Pradesh', 'TAX0189012'),
('ORG19S', 'WaterAid India', 'Rajeev Sen', 'info@wateraid.org', '9912345678', 'Amritsar, Punjab', 'TAX0190123'),
('ORG20T', 'Hearing Aid Initiative', 'Ashish Pillai', 'hello@hearingaid.org', '9812345678', 'Kochi, Kerala', 'TAX0201234');

INSERT INTO Individuals (IndividualID, Name, Email, PhoneNumber, Address, IsAnonymous) VALUES
('IND01A', 'Rahul Sharma', 'rahul.sharma@email.com', '9876543210', 'Mumbai, Maharashtra', FALSE),
('IND02B', 'Anjali Patel', 'anjali.patel@email.com', '9123456789', 'Pune, Maharashtra', FALSE),
('IND03C', 'Vikram Singh', 'vikram.singh@email.com', '9865321470', 'Delhi', TRUE),
('IND04D', 'Neha Verma', 'neha.verma@email.com', '9321654789', 'Bangalore, Karnataka', FALSE),
('IND05E', 'Rohan Das', 'rohan.das@email.com', '9012345678', 'Chennai, Tamil Nadu', TRUE),
('IND06F', 'Sneha Iyer', 'sneha.iyer@email.com', '9765432109', 'Hyderabad, Telangana', FALSE),
('IND07G', 'Karan Gupta', 'karan.gupta@email.com', '9998887776', 'Kolkata, West Bengal', FALSE),
('IND08H', 'Meera Jain', 'meera.jain@email.com', '9898989898', 'Jaipur, Rajasthan', FALSE),
('IND09I', 'Amit Tiwari', 'amit.tiwari@email.com', '9812765432', 'Lucknow, Uttar Pradesh', TRUE),
('IND10J', 'Priya Reddy', 'priya.reddy@email.com', '9876123456', 'Bangalore, Karnataka', FALSE),
('IND11K', 'Tarun Mehta', 'tarun.mehta@email.com', '9123123123', 'Indore, Madhya Pradesh', TRUE),
('IND12L', 'Ritika Sen', 'ritika.sen@email.com', '9856321470', 'Patna, Bihar', FALSE),
('IND13M', 'Shashank Rao', 'shashank.rao@email.com', '9988776655', 'Goa', TRUE),
('IND14N', 'Tina Kapoor', 'tina.kapoor@email.com', '9875412369', 'Noida, Uttar Pradesh', FALSE),
('IND15O', 'Vivek Nair', 'vivek.nair@email.com', '9090909090', 'Thiruvananthapuram, Kerala', TRUE),
('IND16P', 'Asha Sen', 'asha.sen@email.com', '9312345678', 'Guwahati, Assam', FALSE),
('IND17Q', 'Yash Chopra', 'yash.chopra@email.com', '9823421567', 'Chandigarh', TRUE),
('IND18R', 'Deepak Bhatt', 'deepak.bhatt@email.com', '9988774422', 'Shimla, Himachal Pradesh', FALSE),
('IND19S', 'Simran Kaur', 'simran.kaur@email.com', '9723456789', 'Amritsar, Punjab', FALSE),
('IND20T', 'Rajeev Pillai', 'rajeev.pillai@email.com', '9912345678', 'Kochi, Kerala', TRUE);

INSERT INTO Contributions (ContributionID, CampaignID, BackerID, PaymentMethodID, OrganizationID, IndividualID, ContributionAmount, ContributionDate) VALUES
('CON01A', 'CAM01A', 'BAC01A', 'PAY01A', 'ORG01A', NULL, 5000.00, '2024-01-05'),
('CON02B', 'CAM02B', 'BAC02B', 'PAY02B', NULL, 'IND02B', 2500.00, '2024-01-10'),
('CON03C', 'CAM03C', 'BAC03C', 'PAY03C', 'ORG03C', NULL, 8000.00, '2024-02-15'),
('CON04D', 'CAM04D', NULL, 'PAY01A', NULL, 'IND04D', 3000.00, '2024-03-20'),
('CON05E', 'CAM05E', 'BAC05E', 'PAY02B', 'ORG05E', NULL, 10000.00, '2024-04-10'),
('CON06F', 'CAM06F', NULL, 'PAY03C', NULL, 'IND06F', 500.00, '2024-05-18'),
('CON07G', 'CAM07G', 'BAC07G', 'PAY01A', NULL, 'IND07G', 1200.00, '2024-06-25'),
('CON08H', 'CAM08H', 'BAC08H', 'PAY02B', 'ORG08H', NULL, 7500.00, '2024-07-07'),
('CON09I', 'CAM09I', NULL, 'PAY03C', NULL, 'IND09I', 1100.00, '2024-08-30'),
('CON10J', 'CAM10J', 'BAC10J', 'PAY01A', 'ORG10J', NULL, 9500.00, '2024-09-12'),
('CON11K', 'CAM11K', NULL, 'PAY02B', NULL, 'IND11K', 6700.00, '2024-10-14'),
('CON12L', 'CAM12L', 'BAC12L', 'PAY03C', 'ORG12L', NULL, 8900.00, '2024-11-21'),
('CON13M', 'CAM13M', NULL, 'PAY01A', NULL, 'IND13M', 4500.00, '2024-12-05'),
('CON14N', 'CAM14N', 'BAC14N', 'PAY02B', 'ORG14N', NULL, 2000.00, '2025-01-10'),
('CON15O', 'CAM15O', 'BAC15O', 'PAY03C', NULL, 'IND15O', 3000.00, '2025-02-18'),
('CON16P', 'CAM16P', 'BAC16P', 'PAY01A', 'ORG16P', NULL, 12500.00, '2025-03-01'),
('CON17Q', 'CAM17Q', NULL, 'PAY02B', NULL, 'IND17Q', 2300.00, '2025-03-15'),
('CON18R', 'CAM18R', 'BAC18R', 'PAY03C', 'ORG18R', NULL, 9200.00, '2025-04-08'),
('CON19S', 'CAM19S', 'BAC19S', 'PAY01A', NULL, 'IND19S', 5100.00, '2025-05-12'),
('CON20T', 'CAM20T', NULL, 'PAY02B', 'ORG20T', NULL, 7000.00, '2025-06-22');

INSERT INTO Rewards (RewardID, CampaignID, RewardDescription, MinimumContribution) VALUES
('RWD01A', 'CAM01A', 'Discount Coupons for Local Stores', 300.00),
('RWD02B', 'CAM02B', 'T-shirt with campaign logo', 500.00),
('RWD03C', 'CAM03C', 'Special Event Invitation', 1000.00),
('RWD04D', 'CAM04D', 'Discount Coupons for Local Stores', 250.00),
('RWD05E', 'CAM05E', 'Coffee Mug with Thank You Note', 550.00),
('RWD06F', 'CAM06F', 'Discount Coupons for Local Stores', 1200.00),
('RWD07G', 'CAM07G', 'T-shirt with campaign logo', 350.00),
('RWD08H', 'CAM08H', 'Discount Coupons for Local Stores', 200.00),
('RWD09I', 'CAM09I', 'Coffee Mug with Thank You Note', 1100.00),
('RWD10J', 'CAM10J', 'Special Event Invitation', 600.00),
('RWD11K', 'CAM11K', 'T-shirt with campaign logo', 400.00),
('RWD12L', 'CAM12L', 'Discount Coupons for Local Stores', 150.00),
('RWD13M', 'CAM13M', 'Coffee Mug with Thank You Note', 700.00),
('RWD14N', 'CAM14N', 'Discount Coupons for Local Stores', 1300.00),
('RWD15O', 'CAM15O', 'Coffee Mug with Thank You Note', 450.00),
('RWD16P', 'CAM16P', 'Discount Coupons for Local Stores', 300.00),
('RWD17Q', 'CAM17Q', 'Coffee Mug with Thank You Note', 750.00),
('RWD18R', 'CAM18R', 'T-shirt with campaign logo', 1400.00),
('RWD19S', 'CAM19S', 'Special Event Invitation', 350.00),
('RWD20T', 'CAM20T', 'Coffee Mug with Thank You Note', 500.00);

INSERT INTO RewardClaims (ClaimID, RewardID, BackerID, ClaimDate, DeliveryStatus) VALUES
('RCM01A', 'RWD01A', 'BAC01A', '2024-01-06', 'Shipped'),
('RCM02B', 'RWD02B', 'BAC02B', '2024-01-11', 'Delivered'),
('RCM03C', 'RWD03C', 'BAC03C', '2024-02-16', 'Pending'),
('RCM04D', 'RWD04D', 'BAC04D', '2024-03-21', 'Cancelled'),
('RCM05E', 'RWD05E', 'BAC05E', '2024-04-11', 'Shipped'),
('RCM06F', 'RWD06F', 'BAC06F', '2024-05-19', 'Delivered'),
('RCM07G', 'RWD07G', 'BAC07G', '2024-06-26', 'Pending'),
('RCM08H', 'RWD08H', 'BAC08H', '2024-07-08', 'Shipped'),
('RCM09I', 'RWD09I', 'BAC09I', '2024-08-31', 'Delivered'),
('RCM10J', 'RWD10J', 'BAC10J', '2024-09-13', 'Pending'),
('RCM11K', 'RWD11K', 'BAC11K', '2024-10-15', 'Shipped'),
('RCM12L', 'RWD12L', 'BAC12L', '2024-11-22', 'Delivered'),
('RCM13M', 'RWD13M', 'BAC13M', '2024-12-06', 'Pending'),
('RCM14N', 'RWD14N', 'BAC14N', '2025-01-11', 'Cancelled'),
('RCM15O', 'RWD15O', 'BAC15O', '2025-02-19', 'Shipped'),
('RCM16P', 'RWD16P', 'BAC16P', '2025-03-02', 'Delivered'),
('RCM17Q', 'RWD17Q', 'BAC17Q', '2025-03-16', 'Pending'),
('RCM18R', 'RWD18R', 'BAC18R', '2025-04-09', 'Shipped'),
('RCM19S', 'RWD19S', 'BAC19S', '2025-05-13', 'Delivered'),
('RCM20T', 'RWD20T', 'BAC20T', '2025-06-23', 'Pending');

-- Running DDL (Data Definition Language) operations

-- Adding a column to store the CreatedAt timestamp in the Campaigns table:
ALTER TABLE Campaigns ADD COLUMN CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Removing the TaxID column from the Organizations table:
ALTER TABLE Organizations DROP COLUMN TaxID;

-- Modify Data Types by increasing TargetAmount precision in Campaigns table:
ALTER TABLE Campaigns MODIFY COLUMN TargetAmount DECIMAL(18,2);

-- Adding a NOT NULL constraint to Email in Individuals:
ALTER TABLE Individuals MODIFY COLUMN Email VARCHAR(255) NOT NULL;

-- Rename Individuals table to IndividualDonors:
RENAME TABLE Individuals TO IndividualDonors;

-- Rename column RewardDescription to RewardDetails in the Rewards table:
ALTER TABLE Rewards CHANGE RewardDescription RewardDetails TEXT NOT NULL;

-- Running queries:

SHOW TABLES;

-- Insert Data Testing
-- 1. Insert a new campaign into the Campaigns table.
INSERT INTO Campaigns (CampaignID, CampaignName, Organizer, TargetAmount, StartDate, EndDate, Status) 
VALUES ('CAM21U', 'Help Underprivileged Students', 'Pooja Sharma', 650000.00, '2025-09-01', '2025-12-31', 'Active');

-- 2. Insert a new reward for an existing campaign.
INSERT INTO Rewards (RewardID, CampaignID, RewardDetails, MinimumContribution) 
VALUES ('RWD21U', 'CAM01A', 'Coffee Mug with Thank You Note', 450.00);

-- 3. Insert a new backer into the Backers table.
INSERT INTO Backers (BackerID, Name, Email, PhoneNumber, Address) 
VALUES ('BKR21U', 'Rajesh Kumar', 'rajesh.k@example.com', '9876543210', 'Delhi, India');

-- Update Data Testing
-- 4. Update the target amount for a specific campaign.
UPDATE Campaigns 
SET TargetAmount = 800000.00 
WHERE CampaignID = 'CAM01A';

-- 5. Change the status of a completed campaign to Cancelled.
UPDATE Campaigns 
SET Status = 'Cancelled' 
WHERE CampaignID = 'CAM09I';

-- Delete Data Testing
-- 6. Delete a backer who has not made any contributions.
DELETE FROM Backers 
WHERE BackerID = 'BKR21U';

-- 7. Remove a campaign that was mistakenly created.
DELETE FROM Campaigns 
WHERE CampaignID = 'CAM21U';

-- 8. Delete a reward associated with a specific campaign.
DELETE FROM Rewards 
WHERE RewardID = 'RWD21U';

-- Campaign Performance
-- 9. Find the total number of active campaigns.
SELECT COUNT(*) AS ActiveCampaigns 
FROM Campaigns 
WHERE Status = 'Active';

-- 10. Get the campaigns with the highest target amount.
SELECT CampaignName, TargetAmount 
FROM Campaigns 
ORDER BY TargetAmount DESC 
LIMIT 5;

-- 11. Find campaigns that have ended but were not completed.
SELECT CampaignName, Status 
FROM Campaigns 
WHERE EndDate < CURDATE() AND Status <> 'Completed';

-- Reward Insights
-- 12. Count how many times each reward type has been offered.
SELECT RewardDetails, COUNT(*) AS RewardCount 
FROM Rewards 
GROUP BY RewardDetails;

-- 13. Find campaigns that offer the most expensive rewards.
SELECT CampaignName, RewardDetails, MinimumContribution 
FROM Rewards 
JOIN Campaigns ON Rewards.CampaignID = Campaigns.CampaignID 
ORDER BY MinimumContribution DESC 
LIMIT 5;

-- Contribution Insights
-- 14. Find the total amount contributed across all campaigns.
SELECT SUM(ContributionAmount) AS TotalContributions 
FROM Contributions;

-- 15. List the top 5 campaigns with the highest total contributions.
SELECT Campaigns.CampaignName, SUM(Contributions.ContributionAmount) AS TotalAmountRaised 
FROM Contributions 
JOIN Campaigns ON Contributions.CampaignID = Campaigns.CampaignID 
GROUP BY Campaigns.CampaignName 
ORDER BY TotalAmountRaised DESC 
LIMIT 5;

-- 16. Find the number of unique backers contributing to each campaign.
SELECT Campaigns.CampaignName, COUNT(DISTINCT Backers.BackerID) AS UniqueBackers 
FROM Contributions 
JOIN Campaigns ON Contributions.CampaignID = Campaigns.CampaignID 
JOIN Backers ON Contributions.BackerID = Backers.BackerID 
GROUP BY Campaigns.CampaignName;

-- Payment Insights
-- 17. Count how many contributions were made using each payment method.
SELECT PaymentMethods.MethodName, COUNT(*) AS ContributionCount 
FROM Contributions 
JOIN PaymentMethods ON Contributions.PaymentMethodID = PaymentMethods.PaymentMethodID 
GROUP BY PaymentMethods.MethodName;

-- 18. Find the total amount raised through UPI payments.
SELECT SUM(ContributionAmount) AS UPI_Total 
FROM Contributions 
JOIN PaymentMethods ON Contributions.PaymentMethodID = PaymentMethods.PaymentMethodID 
WHERE PaymentMethods.MethodName = 'UPI';

-- Time-Based Analysis
-- 19. Get the total contributions received per month.
SELECT DATE_FORMAT(ContributionDate, '%Y-%m') AS Month, SUM(ContributionAmount) AS TotalRaised 
FROM Contributions 
GROUP BY Month 
ORDER BY Month;

-- 20. Find the campaigns that received the highest number of contributions in the last 3 months.
SELECT Campaigns.CampaignName, COUNT(Contributions.ContributionID) AS ContributionCount 
FROM Contributions 
JOIN Campaigns ON Contributions.CampaignID = Campaigns.CampaignID 
WHERE ContributionDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) 
GROUP BY Campaigns.CampaignName 
ORDER BY ContributionCount DESC 
LIMIT 5;



























