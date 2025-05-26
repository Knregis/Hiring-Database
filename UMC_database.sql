
/****** Object:  Database UMC  4/21/2024 2:55 PM   ******/
USE master
GO

-- Check if the database exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'UMC')
BEGIN
    -- Check if there are any active connections to the database
    DECLARE @sql NVARCHAR(MAX)
    SET @sql = 'ALTER DATABASE UMC SET SINGLE_USER WITH ROLLBACK IMMEDIATE'

    BEGIN TRY
        EXEC (@sql)
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE()
        RETURN
    END CATCH

    -- Drop the database
    DROP DATABASE UMC
END

/****** Object:  Database UMC    ******/
CREATE DATABASE UMC
GO

USE UMC
GO




--DROP TABLE Candidates
--  Candidates Table
CREATE TABLE Candidate (
    CandidateID INT NOT NULL IDENTITY(1,1),
    CandidName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    CandidProfile NVARCHAR(MAX) NULL,
    CONSTRAINT PK_Candidates PRIMARY KEY (CandidateID),
    CONSTRAINT UQ_Candidates_Email UNIQUE (Email)
)
GO

--DROP TABLE JobPositions
--  JobPositions Table
CREATE TABLE JobPosition (
    JobID INT PRIMARY KEY,
    PositionTitle VARCHAR(255),
    JobDescription TEXT,
    JobType VARCHAR(50),
    JobMedium VARCHAR(50),
    JobCategory VARCHAR(50),
    JobPlatform VARCHAR(50),
    NumberOfPositions INT,
    JobStartDate DATE
);
GO

--DROP TABLE Applications
--  Applications Table
CREATE TABLE Application (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT,
    JobID INT,
    ApplicationDate DATE,
    ApplicationStatus VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (JobID) REFERENCES JobPosition(JobID)
);
GO


--  Interviewers Table
CREATE TABLE Interviewer (
    InterviewerID INT PRIMARY KEY,
    Interviewer_FName VARCHAR(255),
    Interviewer_LName VARCHAR(255),
    Department VARCHAR(255),
    Title VARCHAR(255)
	Job
);

--DROP TABLE Interviews
--  Interviews Table
CREATE TABLE Interview (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT,
    InterviewType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    InterviewStatus VARCHAR(50),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);


--  InterviewAssignments Table
CREATE TABLE InterviewAssignment (
    InterviewID INT,
    InterviewerID INT,
	Score INT,
    PRIMARY KEY (InterviewID, InterviewerID),
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID),
    FOREIGN KEY (InterviewerID) REFERENCES Interviewer(InterviewerID)
);

--  Documents Table
CREATE TABLE Document (
    DocumentID INT PRIMARY KEY,
    CandidateID INT,
    DocumentType VARCHAR(50),
    DocumentURL VARCHAR(255),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);


--  Evaluation Table
CREATE TABLE Evaluations (
    EvaluationID INT PRIMARY KEY,
    ApplicationID INT,
    InterviewerID INT,
    EvaluationDate DATE,
    Score INT,
    Comments TEXT,
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID),
    FOREIGN KEY (InterviewerID) REFERENCES Candidate(CandidateID)
);

--  Reimbursement Table
CREATE TABLE Reimbursements (
    ReimbursementID INT PRIMARY KEY,
    ApplicationID INT,
    Amount DECIMAL(10, 2),
    Stat VARCHAR(50),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

--  Onboarding Table
CREATE TABLE Onboardings (
    OnboardingID INT PRIMARY KEY,
    EmployeeID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Candidate(CandidateID)
);

--  Status Table
CREATE TABLE Statuse (
    StatusID INT PRIMARY KEY,
    StatusDescription VARCHAR(255),
	CandidateID INT,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

--  Regions Table
CREATE TABLE Region (
    RegionID INT PRIMARY KEY,
	CandidateID INT,
    RegionName VARCHAR(255) NOT NULL,
	FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

--  States Table
CREATE TABLE State (
    StateID INT PRIMARY KEY,
    RegionID INT,
    Name VARCHAR(255) NOT NULL,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

--  Location Table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    Address VARCHAR(255),
    City VARCHAR(100),
    StateID INT,
    ZipCode VARCHAR(10),
    FOREIGN KEY (StateID) REFERENCES State(StateID)
);
GO

--DROP TABLE Departments
--  Departments Table
CREATE TABLE Department (
	DepartmentID INT NOT NULL IDENTITY(1,1),
	DepartmentName NVARCHAR(255) NOT NULL,
	LocationID INT,
	CONSTRAINT PK_Departments PRIMARY KEY (DepartmentID),
	FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
GO


--  Job Histories Table
CREATE TABLE JobHistories (
    HistoryID INT PRIMARY KEY,
    CandidateID INT,
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
GO


--  Education Table
CREATE TABLE Educations (
    EducationID INT PRIMARY KEY,
    CandidateID INT,
    Degree VARCHAR(100),
    Major VARCHAR(100),
    UniversityName VARCHAR(255),
    GraduationYear INT,
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

--  Background Check Table
CREATE TABLE BackgroundChecks (
    CheckID INT PRIMARY KEY,
    CandidateID INT,
    CheckType VARCHAR(50),
    CheckDate DATE,
    Result VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);



-- 19 JobLevel Table
CREATE TABLE JobLevels (
	JobID INT,
	JobTitle VARCHAR(100),
	EntryLevel VARCHAR(50),
	AssociateLevel VARCHAR(50),
	JuniorLevel VARCHAR(50),
	SeniorLevel VARCHAR(50),
	FOREIGN KEY (JobID) REFERENCES JobPosition(JobID)

);

-- 20 DrugTest Table
CREATE TABLE DrugTests (
    CandidateID INT,
	TestType VARCHAR(50),
	TestDate DATE,
	Result VARCHAR(50),
	FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)

);

/****** _________________________________________________________  ******/

/*SET IDENTITY_INSERT Statuses  ON 
INSERT Statuses (StatusDescription, CandidateID) VALUES 
(5, 'Davison', 'Michelle'),
(12, 'Mayteh', 'Kendall'),
(17, 'Onandonga', 'Bruce'),
(44, 'Antavius', 'Anthony'),
(76, 'Bradlee', 'Danny'),
(94, 'Suscipe', 'Reynaldo'),
(101, 'O''Sullivan', 'Geraldine'),
(123, 'Bucket', 'Charles')
SET IDENTITY_INSERT ContactUpdates OFF
GO*/


/****** _________________________________________________________  ******/

USE UMC
GO

ALTER DATABASE UMC SET  READ_WRITE 
GO