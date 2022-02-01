/*
-- The following SQL queries are written for Google's BigQuery
-- All tables included in the dataset reference an ID number unique to each user. Since this is a 10 digit number I have create a table called userNames that maps each ID number to an easier to read user name. User names are in the format User01. Most queries will include a join to the userNames table.

--SQL skills used: join, aggregate functions, subquery, analytic functions (OVER), navigation functions (FIRST_VALUE, LAST_VALUE), statistical aggregate functions (CORR)
*/

--Activity level seems to be quantified using two measures: intensity and METs
--Is there a correlation between them?
SELECT
    DISTINCT(i.Intensity),
    COUNT(m.METs) as METsCount,
    MIN(m.METs) as METsMin,
    MAX(m.METs) as METsMax,
    AVG(m.METs) as METsAvg
FROM `bellabeat.minuteIntensitiesNarrow` i
INNER JOIN `bellabeat.minuteMETsNarrow` m
    ON i.Id = m.Id
    AND i.ActivityMinute = m.ActivityMinute
GROUP BY i.Intensity
ORDER BY i.Intensity ASC
--Results -> sql_results/intensity_vs_METs.csv
--There is a correlation. For consistency and simplicity I'll use intensity in my analysis


-- Summary of group as a whole - Daily Activity


-- Get a count of users in dataset, a count of how many users had had automatically tracked activity vs. manually tracked activity, and an average of how many days they had any activity/automatically tracked activity/manually tracked activity
SELECT
  COUNT(User) AS NumUsers,
  COUNTIF(TrackCount > 0) NumUsersWithAtumaticActivity,
  COUNTIF(LogCount > 0) NumUsersWithManualActivity,
  ROUND(AVG(ActiveDays),1) AS AvgDaysUsed,
  ROUND(AVG(TrackCount),1) AS AvgDaysWithAtumaticActivity,
  ROUND(AVG(LogCount),1) AS AvgDaysWithManualActivity
FROM (
  SELECT
    DISTINCT(u.userName) AS User,
    COUNT(u.userName) AS ActiveDays,
    COUNTIF(d.TrackerDistance > 0) AS TrackCount,
    COUNTIF(d.LoggedActivitiesDistance > 0) AS LogCount,
  FROM `bellabeat.dailyActivity` d
  INNER JOIN `bellabeat.userNames` u
  ON d.Id = u.Id
  GROUP BY u.userName
)
--Results -> sql_results/manual_vs_automatic.csv


--Summary of each user's activity - Table: dailtyActivity


-- For those that manually tracked, what did their usage look like?
SELECT
  User,
  ActiveDays,
  TrackCount,
  ROUND(TrackDistance,1) AS TrackDistance,
  LogCount,
  ROUND(LogDistance,1) AS LogDistance
FROM (
  SELECT
    DISTINCT(u.userName) AS User,
    COUNT(u.userName) AS ActiveDays,
    COUNTIF(d.TrackerDistance > 0) AS TrackCount,
    SUM(d.TrackerDistance) AS TrackDistance,
    COUNTIF(d.LoggedActivitiesDistance > 0) AS LogCount,
    SUM(d.LoggedActivitiesDistance) AS LogDistance
  FROM `bellabeat.dailyActivity` d
  INNER JOIN `bellabeat.userNames` u
  ON d.Id = u.Id
  GROUP BY u.userName
)
WHERE LogCount > 0
--Results -> sql_results/manual_tracking.csv


--Get min, max, and average for a number of metrics for each user, create view for later use
DROP VIEW bellabeat.summary_dailyActivity
CREATE VIEW bellabeat.summary_dailyActivity(User, TrackedDays, TotalSteps, TotalDistance, TotalCalories, TotalVeryActiveMin, PercentVeryActive, TotalModeratelyActiveMin, PercentModeratelyActive, TotalLightActiveMin, PercentLightActive, TotalSedentaryMin, PercentSedentary) AS
  SELECT
    User,
    TrackedDays,
    TotalSteps,
    TotalDistance AS TotalDistance,
    TotalCalories,
    TotalVeryActiveMin,
    TotalVeryActiveMin / (TotalVeryActiveMin + TotalModeratelyActiveMin + TotalLightActiveMin + TotalSedentaryMin) * 100 AS PercentVeryActive,
    TotalModeratelyActiveMin,
    TotalModeratelyActiveMin / (TotalVeryActiveMin + TotalModeratelyActiveMin + TotalLightActiveMin + TotalSedentaryMin) * 100 AS PercentModeratelyActive,
    TotalLightActiveMin,
    TotalLightActiveMin / (TotalVeryActiveMin + TotalModeratelyActiveMin + TotalLightActiveMin + TotalSedentaryMin) * 100 AS PercentLightActive,
    TotalSedentaryMin,
    TotalSedentaryMin / (TotalVeryActiveMin + TotalModeratelyActiveMin + TotalLightActiveMin + TotalSedentaryMin) * 100 AS PercentSedentary,
  FROM
    (SELECT
      DISTINCT(u.userName) AS User,
      COUNT(u.userName) as TrackedDays,
      SUM(d.TotalSteps) as TotalSteps,
      SUM(d.TotalDistance) as TotalDistance,
      SUM(d.Calories) AS TotalCalories,
      SUM(d.VeryActiveMinutes) as TotalVeryActiveMin,
      SUM(d.FairlyActiveMinutes) as TotalModeratelyActiveMin,
      SUM(d.LightlyActiveMinutes) as TotalLightActiveMin,
      SUM(d.SedentaryMinutes) as TotalSedentaryMin
    FROM `bellabeat.dailyActivity` d
    INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
    GROUP BY u.userName)
  ORDER BY User
--SELECT * Results -> sql_results/daily_activity.csv

--Query view to calculate Pearson coefficient of correlation of calories and the various activity metrics
SELECT
  CORR(TotalCalories, TotalSteps) AS r_TotalSteps,
  CORR(TotalCalories, TotalDistance) AS r_TotalDistance,
  CORR(TotalCalories, TotalVeryActiveMin) AS r_TotalVeryActiveMin,
  CORR(TotalCalories, PercentVeryActive) AS r_PercentVeryActive,
  CORR(TotalCalories, TotalModeratelyActiveMin) AS r_TotalModeratelyActiveMin,
  CORR(TotalCalories, PercentModeratelyActive) AS r_PercentModeratelyActive,
  CORR(TotalCalories, TotalLightActiveMin) AS r_TotalLightActiveMin,
  CORR(TotalCalories, PercentLightActive) AS r_PercentLightActive,
  CORR(TotalCalories, TotalSedentaryMin) AS r_TotalSedentaryMin,
  CORR(TotalCalories, PercentSedentary) AS r_PercentSedentary
FROM `bellabeat.summary_dailyActivity`
--Results -> sql_results/correlation_daily_activity.csv


--Summary of whole group's calories burned - Table: hourlyCalories


--as a group, how many calories were burned each day of the week
SELECT
  EXTRACT(DAYOFWEEK FROM ActivityHour) AS DayOfWeek,
  SUM(Calories) AS SumCalories,
  AVG(Calories) AS AvgCalories
FROM `bellabeat.hourlyCalories`
GROUP BY DayOfWeek
ORDER BY DayOfWeek ASC
--Results -> sql_results/group_calories_by_day.csv

--as a group, how many calories were burned each hour of the day
SELECT
  EXTRACT(HOUR FROM ActivityHour) AS HourOfDay,
  SUM(Calories) AS SumCalories,
  AVG(Calories) AS AvgCalories
FROM `bellabeat.hourlyCalories`
GROUP BY HourOfDay
ORDER BY HourOfDay ASC
--Results -> sql_results/group_calories_by_hour.csv


--Summary of each user's intensity - Table: hourlyIntensities


--what are the max and sum of hourly intensities for each day of the week for each user
SELECT
  u.userName,
  EXTRACT(DAYOFWEEK FROM d.ActivityHour) AS DayOfWeek,
  MAX(d.TotalIntensity) AS MaxIntensity,
  SUM(d.TotalIntensity) AS SumIntensity,
  ROUND(AVG(d.TotalIntensity),1) AS AvgIntensity
FROM `bellabeat.hourlyIntensities` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
GROUP BY u.userName, DayOfWeek
ORDER BY u.userName, DayOfWeek ASC
--Results -> sql_results/intensity_by_day.csv

--what are the max and sum of hourly intensities for each hour of the day for each user
SELECT
  u.userName,
  EXTRACT(HOUR FROM d.ActivityHour) AS HourOfDay,
  MAX(d.TotalIntensity) AS MaxIntensity,
  SUM(d.TotalIntensity) AS SumIntensity,
  ROUND(AVG(d.TotalIntensity),1) AS AvgIntensity
FROM `bellabeat.hourlyIntensities` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
GROUP BY u.userName, HourOfDay
ORDER BY u.userName, HourOfDay ASC
--Results -> sql_results/insensity_by_hour.csv


--Summary of whole group's intensity - Table: minuteIntensitiesNarrow
--Since "Very Active" intensity strongly correlated with calories burned, let's get an idea of what times of the day and week are popular times of high intensity


--as a group, how many times was a "very active" minute recorded for each day of the week
SELECT
  EXTRACT(DAYOFWEEK FROM ActivityMinute) AS DayOfWeek,
  COUNTIF(Intensity=3) AS VeryActiveMinutes
FROM `bellabeat.minuteIntensitiesNarrow`
GROUP BY DayOfWeek
ORDER BY DayOfWeek ASC
--Results -> sql_results/group_very_active_by_day.csv

--as a group, how many times was a "very active" minute recorded for each hour of the day
SELECT
  EXTRACT(HOUR FROM ActivityMinute) AS HourOfDay,
  COUNTIF(Intensity=3) AS VeryActiveMinutes
FROM `bellabeat.minuteIntensitiesNarrow`
GROUP BY HourOfDay
ORDER BY HourOfDay ASC
--Results -> sql_results/group_very_active_by_hour.csv


--Summary of each user's steps - Table: hourlySteps


--what are the max and sum of hourly steps for each day of the week for each user
SELECT
  u.userName,
  EXTRACT(DAYOFWEEK FROM d.ActivityHour) AS DayOfWeek,
  MAX(d.StepTotal) AS MaxSteps,
  SUM(d.StepTotal) AS SumSteps,
  ROUND(AVG(d.StepTotal),1) AS AvgSteps
FROM `bellabeat.hourlySteps` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
GROUP BY u.userName, DayOfWeek
ORDER BY u.userName, DayOfWeek ASC
--Results -> sql_results/steps_by_day.csv

--what are the max and sum of hourly steps for each hour of the day for each user
SELECT
  u.userName,
  EXTRACT(HOUR FROM d.ActivityHour) AS HourOfDay,
  MAX(d.StepTotal) AS MaxSteps,
  SUM(d.StepTotal) AS SumSteps,
  ROUND(AVG(d.StepTotal),1) AS AvgSteps
FROM `bellabeat.hourlySteps` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
GROUP BY u.userName, HourOfDay
ORDER BY u.userName, HourOfDay ASC
--Results -> sql_results/steps_by_hour.csv


--Summary of whole group's steps - Table: hourlySteps


--as a group, how many steps were taken each day of the week
SELECT
  EXTRACT(DAYOFWEEK FROM ActivityHour) AS DayOfWeek,
  SUM(StepTotal) AS SumSteps,
  AVG(StepTotal) AS AvgSteps
FROM `bellabeat.hourlySteps`
GROUP BY DayOfWeek
ORDER BY DayOfWeek ASC
--Results -> sql_results/group_steps_by_day.csv

--as a group, how many steps were taken each hour of the day
SELECT
  EXTRACT(HOUR FROM ActivityHour) AS HourOfDay,
  SUM(StepTotal) AS SumSteps,
  AVG(StepTotal) AS AvgSteps
FROM `bellabeat.hourlySteps`
GROUP BY HourOfDay
ORDER BY HourOfDay ASC
--Results -> sql_results/group_steps_by_hour.csv


--Summary of each user's sleep - Table: sleepDay


--who used the sleep tracking feature, how many days did they use it, how long were they in bed, asleep in bed, and awake in bed
SELECT
  u.userName,
  COUNT(u.userName) AS numDaysTracked,
  ROUND(SUM(d.TotalMinutesAsleep)/60,1) AS TotalHrsAsleep,
  ROUND(AVG(d.TotalMinutesAsleep)/60,1) AS AvgDailySleep,
  ROUND(MIN(d.TotalMinutesAsleep)/60,1) AS MinDailySleep,
  ROUND(MAX(d.TotalMinutesAsleep)/60,1) AS MaxDailySleep,
  ROUND(SUM(d.TotalTimeInBed)/60,1) AS SumTimeInBed,
  ROUND(AVG(d.TotalTimeInBed)/60,1) AS AvgTimeInBed,
  ROUND(MIN(d.TotalTimeInBed)/60,1) AS MinTimeInBed,
  ROUND(MAX(d.TotalTimeInBed)/60,1) AS MaxTimeInBed,
  ROUND((SUM(d.TotalTimeInBed) - SUM(d.TotalMinutesAsleep))/60,1) AS TotalTimeAwakeInBed,
  ROUND(((SUM(d.TotalTimeInBed) - SUM(d.TotalMinutesAsleep)) / COUNT(u.userName))/60,1) AS AvgTimeAwakeInBed,
FROM `bellabeat.sleepDay` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
GROUP BY u.userName
ORDER BY u.userName ASC
--Results -> sql_results/sleep_tracking.csv

--get all sleep records
SELECT
  u.userName,
  d.SleepDay,
  d.TotalSleepRecords,
  d.TotalMinutesAsleep,
  d.TotalTimeInBed
FROM `bellabeat.sleepDay` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
ORDER BY u.userName ASC
--Results -> sql_results/all_sleep_tracking.csv


--Summary of each user's weight - Table: weightLogInfo


--who used the weight tracking feature, how many days did they use it, and what was their weight change
SELECT
    u.userName AS User,
    w.DaysTracked AS DaysTracked,
    ROUND((w.EndingWeight - w.StartingWeight), 1) AS WeightChange
FROM (
  SELECT
    DISTINCT(Id),
    COUNT(Id)
      OVER (PARTITION BY Id ORDER BY Id, Date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS DaysTracked,
    FIRST_VALUE(WeightPounds)
      OVER (PARTITION BY Id ORDER BY Id, Date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS StartingWeight,
    LAST_VALUE(WeightPounds)
      OVER (PARTITION BY Id ORDER BY Id, Date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS EndingWeight,
  FROM
    `bellabeat.weightLogInfo`) w
INNER JOIN
  `bellabeat.userNames` u
ON
  w.Id = u.Id
--Results -> sql_results/weight_tracking.csv

--get all weight records
SELECT
  u.userName,
  FORMAT_DATE("%F", d.Date)AS Date,
  d.WeightPounds,
  d.BMI
FROM `bellabeat.weightLogInfo` d
INNER JOIN `bellabeat.userNames` u ON d.Id = u.Id
ORDER BY u.userName, Date ASC
--Results -> sql_results/all_weight_tracking.csv
