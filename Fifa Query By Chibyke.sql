/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *

  FROM FIFAdata.dbo.fifarawdata

  -- Get Full name from Player Url in place of LongName.
  SELECT  ID,Name, 
  PlayerUrl,
	SUBSTRING(PlayerUrl, CHARINDEX('/', PlayerUrl, 30)+1,
  CHARINDEX('/', PlayerUrl, CHARINDEX('/', PlayerUrl, 30) + 1) - CHARINDEX('/', PlayerUrl, 30) - 1) AS FullName
  FROM FIFAdata.dbo.fifarawdata


  ALTER TABLE FIFAdata.dbo.fifarawdata
 ADD Players_Fullname NVARCHAR (255);


  UPDATE FIFAdata.dbo.fifarawdata
  SET Players_Fullname = SUBSTRING(PlayerUrl, CHARINDEX('/', PlayerUrl, 30) + 1, 
			   CHARINDEX('/', PlayerUrl, CHARINDEX('/', PlayerUrl, 30) + 1) - CHARINDEX('/', PlayerUrl, 30) - 1)

--Removing Special Cahracter '-' from the Players_Fullname
SELECT  ID,Name, Players_Fullname, REPLACE (Players_Fullname,'-',  ' ')
  FROM FIFAdata.dbo.fifarawdata

  UPDATE FIFAdata.dbo.fifarawdata
  SET Players_Fullname = REPLACE (Players_Fullname,'-',  ' ')
  
  -- To Capitalize the words in the Players_Fullnmae Column 
 
SELECT Players_FullName,
    CONCAT(
        UPPER(LEFT(Players_FullName, 1)),
        LOWER(SUBSTRING(Players_FullName, 2, CHARINDEX(' ', Players_FullName + ' ', 2) - 2)),
        ' ',
        UPPER(LEFT(SUBSTRING(Players_FullName, CHARINDEX(' ', Players_FullName + ' ', 2) + 1, LEN(Players_FullName)), 1)),
        LOWER(SUBSTRING(SUBSTRING(Players_FullName, CHARINDEX(' ', Players_FullName + ' ', 2) + 1, LEN(Players_FullName)), 2, LEN(Players_FullName)))
    )
  FROM FIFAdata.dbo.fifarawdata
  UPDATE FIFAdata.dbo.fifarawdata
  SET Players_Fullname =  CONCAT(
        UPPER(LEFT(Players_FullName, 1)),
        LOWER(SUBSTRING(Players_FullName, 2, CHARINDEX(' ', Players_FullName + ' ', 2) - 2)),
        ' ',
        UPPER(LEFT(SUBSTRING(Players_FullName, CHARINDEX(' ', Players_FullName + ' ', 2) + 1, LEN(Players_FullName)), 1)),
        LOWER(SUBSTRING(SUBSTRING(Players_FullName, CHARINDEX(' ', Players_FullName + ' ', 2) + 1, LEN(Players_FullName)), 2, LEN(Players_FullName)))
    )
	SELECT Players_FullName
 FROM FIFAdata.dbo.fifarawdata


 --Standardise Joined_date Column 


 	SELECT Players_FullName, Joined, CONVERT (date, Joined)
 FROM FIFAdata.dbo.fifarawdata

 UPDATE FIFAdata.dbo.fifarawdata
 SET Joined= CONVERT (date, Joined)

 --Now the club cloumn
 SELECT Players_FullName, Joined, Club, playerUrl, MASTER.dbo.udfGetCharacters(Club,'A-Z ')
 FROM FIFAdata.dbo.fifarawdata
 



 UPDATE FIFAdata.dbo.fifarawdata
--SET Club = REPLACE(Club, 'Ã¼ ', 'u'),
   SET Club = REPLACE(Club, 'È™', 's')
   UPDATE FIFAdata.dbo.fifarawdata
  SET Club = REPLACE(Club, 'Ã©', 'e')
  UPDATE FIFAdata.dbo.fifarawdata
  SET Club = REPLACE(Club, 'Ã¼', 'u')
  UPDATE FIFAdata.dbo.fifarawdata
  SET Club = REPLACE(Club, 'Ã±', 'n')
  UPDATE FIFAdata.dbo.fifarawdata
  SET Club = REPLACE(Club, 'Ã¶', 'o')
  UPDATE FIFAdata.dbo.fifarawdata
  SET Club = REPLACE(Club, 'Ã³', 'o')
   UPDATE FIFAdata.dbo.fifarawdata
   SET Club = REPLACE(Club, 'Ä™', 'e')
   UPDATE FIFAdata.dbo.fifarawdata
   SET Club = REPLACE(Club, 'Ä™', 'e')
   UPDATE FIFAdata.dbo.fifarawdata
   SET Club = REPLACE(Club, 'Ã¢', 'a')
    UPDATE FIFAdata.dbo.fifarawdata
   SET Club = REPLACE(Club, 'Ãª', 'e')
    UPDATE FIFAdata.dbo.fifarawdata
   SET Club =REPLACE(Club, 'Ã', 'i')

   -- The Wages Column 
    SELECT  Wage, EarnedWages 
 FROM FIFAdata.dbo.fifarawdata

 ALTER TABLE FIFAdata.dbo.fifarawdata
 ADD EarnedWages NVARCHAR (255)

 UPDATE FIFAdata.dbo.fifarawdata
 SET EarnedWages = REPLACE (Wage,'â‚¬', '') 

   SELECT  Wage, REPLACE (Wage,'â‚¬', ''), REPLACE (EarnedWages,'K', '000') 
 FROM FIFAdata.dbo.fifarawdata

  UPDATE FIFAdata.dbo.fifarawdata
 SET EarnedWages = REPLACE (EarnedWages,'K', '000')

 -- The Value Clause Column

  SELECT  
 Wage, EarnedWages, Value
 FROM FIFAdata.dbo.fifarawdata
 
 ALTER TABLE FIFAdata.dbo.fifarawdata
 ADD Worth_Value NVARCHAR (255);

 UPDATE FIFAdata.dbo.fifarawdata
 SET Worth_Value = REPLACE (Value, 'â‚¬', '')

 UPDATE FIFAdata.dbo.fifarawdata
 SET Worth_Value = CASE 
                   WHEN Worth_Value LIKE '%k' THEN CAST(REPLACE(Worth_Value, 'k', '') AS DECIMAL(15,0)) * 1000 
                   WHEN Worth_Value LIKE '%m' THEN CAST(REPLACE(Worth_Value, 'm', '') AS DECIMAL(15,0)) * 1000000 
                   ELSE CAST(Worth_Value AS DECIMAL(15,0)) 
                 END
 FROM FIFAdata.dbo.fifarawdata

  SELECT  Value, Worth_Value
 FROM FIFAdata.dbo.fifarawdata
 
UPDATE FIFAdata.dbo.fifarawdata
SET Value = Worth_Value, Worth_Value= Value

SELECT  Value
 FROM FIFAdata.dbo.fifarawdata
 
 -- The Release Clause

 SELECT  Value, [Release Clause], Release_Clause
 FROM FIFAdata.dbo.fifarawdata

  ALTER TABLE FIFAdata.dbo.fifarawdata
  ADD Release_Clause NVARCHAR (255); 
  UPDATE FIFAdata.dbo.fifarawdata
	 SET Release_Clause =	REPLACE ([Release Clause], 'â‚¬', '')


  UPDATE FIFAdata.dbo.fifarawdata
  SET Release_Clause =  CASE 
                   WHEN Release_Clause LIKE '%k' THEN CAST(REPLACE(Release_Clause, 'k', '') AS DECIMAL(15,0)) * 1000 
                   WHEN Release_Clause LIKE '%m' THEN CAST(REPLACE(Release_Clause, 'm', '') AS DECIMAL(15,0)) * 1000000 
                   ELSE CAST(Release_Clause AS DECIMAL(15,0)) 
                 END
 SELECT *
 FROM FIFAdata.dbo.fifarawdata

 -- Loan date column----------------------------------------------------------------------------
  

 ALTER TABLE FIFAdata.dbo.fifarawdata
 ADD Loan_end_date DATE 

UPDATE FIFAdata.dbo.fifarawdata
SET Loan_end_date = CONVERT (DATE, Loan_end_date)

UPDATE FIFAdata.dbo.fifarawdata
SET Loan_end_date = CASE WHEN Contract = 'Free' THEN 'Not_Apllicable'
							ELSE Loan_end_date
							END
							WHERE Contract = 'Free';
				SELECT Loan_end_date, Contract 
FROM FIFAdata.dbo.fifarawdata
WHERE TRY_CONVERT(DATE, Loan_end_date) IS NULL
-----------------------------------------------------------------------------------------------

--cleaaning weight. converting it all to kg
SELECT weight
 FROM FIFAdata.dbo.fifarawdata
  WHERE weight LIKE '%lbs'

  --1 lbs = 0.453592 kg. 

  SELECT weight,CASE WHEN weight LIKE '%lbs%' THEN  CAST (REPLACE (weight, 'lbs', '') AS FLOAT) * 0.453592 
				ELSE CAST (REPLACE(Weight, 'kg', '') AS FLOAT)
				END
  FROM FIFAdata.dbo.fifarawdata
   WHERE weight LIKE '%lbs'

   ALTER TABLE FIFAdata.dbo.fifarawdata 
   ADD  Weight_in_kg NVARCHAR (255);
 UPDATE FIFAdata.dbo.fifarawdata 
 SET Weight_in_kg =CASE WHEN Height LIKE '%cm' THEN CAST(REPLACE(Height, 'cm', '') AS FLOAT) / 30.48
        ELSE CAST(SUBSTRING(Height, 1, CHARINDEX('''', Height) - 1) AS FLOAT) + 
             CAST(SUBSTRING(Height, CHARINDEX('''', Height) + 1, LEN(Height) - CHARINDEX('''', Height) - 2) AS FLOAT) / 12
    END

		SELECT weight, Weight_in_kg
 FROM FIFAdata.dbo.fifarawdata
  WHERE weight LIKE '%lbs'

 -- CleanIng the Heigt column. To reflect in Feet and Inches.
 
SELECT weight, Height,	
					CASE WHEN Height LIKE '%cm' THEN CAST(REPLACE(Height, 'cm', '') AS FLOAT) / 30.48
					ELSE CAST(SUBSTRING(Height, 1, CHARINDEX('''', Height) - 1) AS FLOAT) + 
					CAST(SUBSTRING(Height, CHARINDEX('''', Height) + 1, LEN(Height) - CHARINDEX('''', Height) - 2) AS FLOAT) / 12
				    END
FROM FIFAdata.dbo.fifarawdata
WHERE Height LIKE '%"'

ALTER TABLE FIFAdata.dbo.fifarawdata
ADD Height_ft_inches NVARCHAR (255);

UPDATE FIFAdata.dbo.fifarawdata 
 SET Height_ft_inches = CASE WHEN Height LIKE '%cm' THEN CAST(REPLACE(Height, 'cm', '') AS FLOAT) / 30.48
					ELSE CAST(SUBSTRING(Height, 1, CHARINDEX('''', Height) - 1) AS FLOAT) + 
					CAST(SUBSTRING(Height, CHARINDEX('''', Height) + 1, LEN(Height) - CHARINDEX('''', Height) - 2) AS FLOAT) / 12
				    END

SELECT weight, Height,Height_ft_inches
FROM FIFAdata.dbo.fifarawdata
--WHERE Height LIKE '%cm'

SELECT Height, Height_ft_inches, CONCAT(FLOOR(Height_ft_inches), '\', FLOOR((Height_ft_inches - FLOOR(Height_ft_inches)) * 12), '"')
FROM FIFAdata.dbo.fifarawdata
--WHERE Height LIKE '%"'

UPDATE FIFAdata.dbo.fifarawdata
SET Height_ft_inches =
CONCAT(FLOOR(Height_ft_inches), '\', FLOOR((Height_ft_inches - FLOOR(Height_ft_inches)) * 12), '"')

---------Weakfoot cleaning 

SELECT [W/F], REPLACE ([W/F],'â˜…', '' )
--MASTER.dbo.udfGetCharacters([W/F],'0-9')
FROM FIFAdata.dbo.fifarawdata
WHERE [W/F] LIKE '%â˜…'

ALTER TABLE FIFAdata.dbo.fifarawdata
ADD Weakfoot INTEGER;

UPDATE FIFAdata.dbo.fifarawdata
SET Weakfoot =  REPLACE ([W/F],'â˜…', '' )

SELECT Weakfoot
FROM FIFAdata.dbo.fifarawdata
--WHERE Weakfoot LIKE '%â˜…'



-------------- Skill Moves Cleaning  5â˜…
SELECT SM, REPLACE (SM, 'â˜…' , '')
FROM FIFAdata.dbo.fifarawdata

ALTER TABLE FIFAdata.dbo.fifarawdata
ADD Skill_moves INTEGER;

UPDATE FIFAdata.dbo.fifarawdata
SET Skill_moves =  REPLACE (SM,'â˜…', '' )

SELECT SM, Skill_moves
FROM FIFAdata.dbo.fifarawdata
--WHERE Skill_moves LIKE '%â˜…'

-----------Injury rating Cleaning 

SELECT IR, REPLACE (IR, 'â˜…' , '')
FROM FIFAdata.dbo.fifarawdata

ALTER TABLE FIFAdata.dbo.fifarawdata
ADD Injury_rating INTEGER;

UPDATE FIFAdata.dbo.fifarawdata
SET Injury_rating =  REPLACE (IR,'â˜…', '' )

SELECT IR, Injury_rating
FROM FIFAdata.dbo.fifarawdata
--WHERE Injury_rating LIKE '%â˜…'


---- The hits column, RPLACE null values with zero 
SELECT Hits, COALESCE(Hits, 0)
FROM FIFAdata.dbo.fifarawdata


UPDATE FIFAdata.dbo.fifarawdata
SET Hits = COALESCE(Hits, 0)

-- deleting some columns
SELECT *
FROM FIFAdata.dbo.fifarawdata

ALTER TABLE FIFAdata.dbo.fifarawdata 
  DROP COLUMN  photoUrl, playerUrl, [W/F], SM, IR, Name, Fullname, Loan_end_date

  ALTER TABLE FIFAdata.dbo.fifarawdata 
  DROP COLUMN Wage, [Release Clause]



  SELECT *
  --REPLACE (Worth_Value,'â‚¬', '')
  FROM FIFAdata.dbo.fifarawdata 
  --WHERE Worth_Value LIKE '%K'
 UPDATE FIFAdata.dbo.fifarawdata
 SET Worth_Value = REPLACE (Worth_Value,'â‚¬', '')