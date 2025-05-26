
/****** Object:  Scripts UMC    ******/

-- VIEW of Acceptances
USE UMC;
GO
CREATE VIEW Acceptance
AS
SELECT TOP 100 PERCENT CandidName, StatusID, StatusDescription 
FROM UMC.dbo.Candidates  
WHERE StatusDescription = 'Accepted'
ORDER BY CandidName ASC
UNION
SELECT StatusID, StatusDescription 
FROM UMC.dbo.Statuses 
WHERE StatusDescription = 'Accepted'
GO
SELECT CandidName, StatusID, StatusDescription 
FROM Acceptance;
GO

/* VIEW of updatable reimbursments 
for all null rows*/
USE UMC;
GO
CREATE VIEW CashBack
AS 
SELECT Amount, Stat
FROM UMC.dbo.Reimbursement
UPDATE CashBack
SET Amount = 20.00 , Stat = 'Paid'
WHERE Amount is NULL or Stat = 'Waiting'
GO

-- Altered VIEW of Acceptances
USE UMC;
GO
CREATE VIEW CashBack
AS