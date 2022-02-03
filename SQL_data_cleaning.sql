/*
-- The following SQL queries are written for Google's BigQuery
-- This file checks each table for duplicates.
-- For each table I write a query to get the names of the columns. I then manually copy and paste them into a new query that returns a list of duplicate rows.
-- Two tables were found to have duplicates, but only one of the tables is useful for my analysis. I remove the duplicates in this table (sleepDay).
*/

-- This query just gets the column names from the table. I can copy and paste those into the next query rather than typing them in.
SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'dailyActivity'

SELECT Id, ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes,
COUNT(*) AS cnt
FROM `bellabeat.dailyActivity`
GROUP BY Id, ActivityDate, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes,
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'heartrateSeconds'

SELECT Id, Time, Value,
COUNT(*) AS cnt
FROM `bellabeat.heartrateSeconds`
GROUP BY Id, Time, Value
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'hourlyCalories'

SELECT Id, ActivityHour, Calories,
COUNT(*) AS cnt
FROM `bellabeat.hourlyCalories`
GROUP BY Id, ActivityHour, Calories
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'hourlyIntensities'

SELECT Id, ActivityHour, TotalIntensity, AverageIntensity,
COUNT(*) AS cnt
FROM `bellabeat.hourlyIntensities`
GROUP BY Id, ActivityHour, TotalIntensity, AverageIntensity
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'hourlySteps'

SELECT Id, ActivityHour, StepTotal,
COUNT(*) AS cnt
FROM `bellabeat.hourlySteps`
GROUP BY Id, ActivityHour, StepTotal
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteCaloriesNarrow'

SELECT Id, ActivityMinute, Calories,
COUNT(*) AS cnt
FROM `bellabeat.minuteCaloriesNarrow`
GROUP BY Id, ActivityMinute, Calories
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteCaloriesWide'

SELECT Id, ActivityHour, Calories00, Calories01, Calories02, Calories03, Calories04, Calories05, Calories06, Calories07, Calories08, Calories09, Calories10, Calories11, Calories12, Calories13, Calories14, Calories15, Calories16, Calories17, Calories18, Calories19, Calories20, Calories21, Calories22, Calories23, Calories24, Calories25, Calories26, Calories27, Calories28, Calories29, Calories30, Calories31, Calories32, Calories33, Calories34, Calories35, Calories36, Calories37, Calories38, Calories39, Calories40, Calories41, Calories42, Calories43, Calories44, Calories45, Calories46, Calories47, Calories48, Calories49, Calories50, Calories51, Calories52, Calories53, Calories54, Calories55, Calories56, Calories57, Calories58, Calories59,
COUNT(*) AS cnt
FROM `bellabeat.minuteCaloriesWide`
GROUP BY Id, ActivityHour, Calories00, Calories01, Calories02, Calories03, Calories04, Calories05, Calories06, Calories07, Calories08, Calories09, Calories10, Calories11, Calories12, Calories13, Calories14, Calories15, Calories16, Calories17, Calories18, Calories19, Calories20, Calories21, Calories22, Calories23, Calories24, Calories25, Calories26, Calories27, Calories28, Calories29, Calories30, Calories31, Calories32, Calories33, Calories34, Calories35, Calories36, Calories37, Calories38, Calories39, Calories40, Calories41, Calories42, Calories43, Calories44, Calories45, Calories46, Calories47, Calories48, Calories49, Calories50, Calories51, Calories52, Calories53, Calories54, Calories55, Calories56, Calories57, Calories58, Calories59
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteIntensitiesNarrow'

SELECT Id, ActivityMinute, Intensity,
COUNT(*) AS cnt
FROM `bellabeat.minuteIntensitiesNarrow`
GROUP BY Id, ActivityMinute, Intensity
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteIntensitiesWide'

SELECT Id, ActivityHour, Intensity00, Intensity01, Intensity02, Intensity03, Intensity04, Intensity05, Intensity06, Intensity07, Intensity08, Intensity09, Intensity10, Intensity11, Intensity12, Intensity13, Intensity14, Intensity15, Intensity16, Intensity17, Intensity18, Intensity19, Intensity20, Intensity21, Intensity22, Intensity23, Intensity24, Intensity25, Intensity26, Intensity27, Intensity28, Intensity29, Intensity30, Intensity31, Intensity32, Intensity33, Intensity34, Intensity35, Intensity36, Intensity37, Intensity38, Intensity39, Intensity40, Intensity41, Intensity42, Intensity43, Intensity44, Intensity45, Intensity46, Intensity47, Intensity48, Intensity49, Intensity50, Intensity51, Intensity52, Intensity53, Intensity54, Intensity55, Intensity56, Intensity57, Intensity58, Intensity59,
COUNT(*) AS cnt
FROM `bellabeat.minuteIntensitiesWide`
GROUP BY Id, ActivityHour, Intensity00, Intensity01, Intensity02, Intensity03, Intensity04, Intensity05, Intensity06, Intensity07, Intensity08, Intensity09, Intensity10, Intensity11, Intensity12, Intensity13, Intensity14, Intensity15, Intensity16, Intensity17, Intensity18, Intensity19, Intensity20, Intensity21, Intensity22, Intensity23, Intensity24, Intensity25, Intensity26, Intensity27, Intensity28, Intensity29, Intensity30, Intensity31, Intensity32, Intensity33, Intensity34, Intensity35, Intensity36, Intensity37, Intensity38, Intensity39, Intensity40, Intensity41, Intensity42, Intensity43, Intensity44, Intensity45, Intensity46, Intensity47, Intensity48, Intensity49, Intensity50, Intensity51, Intensity52, Intensity53, Intensity54, Intensity55, Intensity56, Intensity57, Intensity58, Intensity59
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteMETsNarrow'

SELECT Id, ActivityMinute, METs,
COUNT(*) AS cnt
FROM `bellabeat.minuteMETsNarrow`
GROUP BY Id, ActivityMinute, METs
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteSleep'

SELECT Id, date, value, logId,
COUNT(*) AS cnt
FROM `bellabeat.minuteSleep`
GROUP BY Id, date, value, logId
HAVING cnt > 1
--543 duplicates were found. Since I don't plan on using this table in my analysis I won't do anything about it now.

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteStepsNarrow'

SELECT Id, ActivityMinute, Steps,
COUNT(*) AS cnt
FROM `bellabeat.minuteStepsNarrow`
GROUP BY Id, ActivityMinute, Steps
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'minuteStepsWide'

SELECT Id, ActivityHour, Steps00, Steps01, Steps02, Steps03, Steps04, Steps05, Steps06, Steps07, Steps08, Steps09, Steps10, Steps11, Steps12, Steps13, Steps14, Steps15, Steps16, Steps17, Steps18, Steps19, Steps20, Steps21, Steps22, Steps23, Steps24, Steps25, Steps26, Steps27, Steps28, Steps29, Steps30, Steps31, Steps32, Steps33, Steps34, Steps35, Steps36, Steps37, Steps38, Steps39, Steps40, Steps41, Steps42, Steps43, Steps44, Steps45, Steps46, Steps47, Steps48, Steps49, Steps50, Steps51, Steps52, Steps53, Steps54, Steps55, Steps56, Steps57, Steps58, Steps59,
COUNT(*) AS cnt
FROM `bellabeat.minuteStepsWide`
GROUP BY Id, ActivityHour, Steps00, Steps01, Steps02, Steps03, Steps04, Steps05, Steps06, Steps07, Steps08, Steps09, Steps10, Steps11, Steps12, Steps13, Steps14, Steps15, Steps16, Steps17, Steps18, Steps19, Steps20, Steps21, Steps22, Steps23, Steps24, Steps25, Steps26, Steps27, Steps28, Steps29, Steps30, Steps31, Steps32, Steps33, Steps34, Steps35, Steps36, Steps37, Steps38, Steps39, Steps40, Steps41, Steps42, Steps43, Steps44, Steps45, Steps46, Steps47, Steps48, Steps49, Steps50, Steps51, Steps52, Steps53, Steps54, Steps55, Steps56, Steps57, Steps58, Steps59
HAVING cnt > 1
--No Duplicate rows found

SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'sleepDay'

SELECT Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed,
COUNT(*) AS cnt
FROM `bellabeat.sleepDay`
GROUP BY Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed
HAVING cnt > 1
--3 duplicate rows found. I will be using this table so I must remove these duplicates

--  Row Id          SleepDay    TotalSleepRecords   TotalMinutesAsleep  TotalTimeInBed  cnt
--  1	  4388161847  2016-05-05  1                   471                 495             2
--  2	  4702921684  2016-05-07  1                   520                 543             2
--  3	  8378563200  2016-04-25  1                   388                 402             2

--The tricky part is how to delete only one instance of each of those rows. A basic delete function would delete both instances. Some databases support something like
/*
  DELETE FROM `bellabeat.sleepDay`
  WHERE Id=4388161847 AND SleepDay=2016-05-05 AND TotalSleepRecords=1 AND TotalMinutesAsleep=471 AND TotalTimeInBed=495
  LIMIT 1
*/
--But BigQuery doesn't support this

--The easiest solution I could find was select only unique rows, and replace the existing table with those.
--First I'll create a new table of distinct rows
CREATE OR REPLACE TABLE `bellabeat.sleepDay2`
AS
SELECT
DISTINCT Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed
FROM `bellabeat.sleepDay`

--I have confirmed that the new table contains no duplicates, and is 3 rows shorther than the original - just what I'd expect.
--Now I'll drop the original table and rename the new table to match the original.
DROP TABLE `bellabeat.sleepDay`

ALTER TABLE `bellabeat.sleepDay2`
RENAME TO sleepDay


SELECT column_name
FROM `bellabeat.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'weightLogInfo'

SELECT Id, Date, WeightKg, WeightPounds, Fat, BMI, IsManualReport, LogId,
COUNT(*) AS cnt
FROM `bellabeat.weightLogInfo`
GROUP BY Id, Date, WeightKg, WeightPounds, Fat, BMI, IsManualReport, LogId
HAVING cnt > 1
--No Duplicate rows found
