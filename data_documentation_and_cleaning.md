# Data Documentation and Cleaning

Below I document each csv file in the dataset with the number of observations in each file, each column name, a description of the column, and the cleaning steps performed on the column.


## dailyActivity.csv (940 records)

**Id**
* Integer, user ID* *no cleaning performed*

**ActivityDate**
* Date the activity data happened
* *Was formatted at mm/dd/yyyy, reformatted as mm-dd-yyyy*

**TotalSteps**
* Integer, number of steps taken that day
* *no cleaning performed*

**TotalDistance**
* Decimal, total kilometers tracked
* *no cleaning performed*

**TrackerDistance**
* Decimal, total kilometers tracked by activity tracker
* *no cleaning performed*

**LoggedActivitiesDistance**
* Decimal, total kilometers from logged activities
* *no cleaning performed*

**VeryActiveDistance**
* Decimal, total kilometers traveled during very active activity
* *no cleaning performed*

**ModeratelyActiveDistance**
* Decimal, total kilometers traveled during moderate activity
* *no cleaning performed*

**LightActiveDistance**
* Decimal, total kilometers traveled during light activity
* *no cleaning performed*

**SedentaryActiveDistance**
* Decimal, total kilometers traveled during sedentary activity
* *no cleaning performed*

**VeryActiveMinutes**
* Integer, total minutes spent in very active activity
* *no cleaning performed*

**FairlyActiveMinutes**
* Integer, total minutes spent in moderate activity
* *no cleaning performed*

**LightlyActiveMinutes**
* Integer, total minutes spent in light activity
* *no cleaning performed*

**SedentaryMinutes**
* Integer, total minutes spent in sedentary activity
* *no cleaning performed*

**Calories**
* Integer, total estimated energy expenditure during activities. Measured in kilocalories.
* *no cleaning performed*


## dailyCalories.csv (940 records)
*subset of dailyActivity.csv*
*contains the columns Id, ActivityDay, Calories*
*Will not be need for this analysis*


## dailyIntensities.csv (940 records)
*subset of dailyActivity.csv*
*contains the columns Id, ActivityDay, SedentaryMinutes, LightlyActiveMinutes, FairlyActiveMinutes, VeryActiveMinutes, SedentaryActiveDistance, LightActiveDistance, ModeratelyActiveDistance, VeryActiveDistance*
*Will not be need for this analysis*

## dailySteps.csv (940 records)
*subset of dailyActivity.csv*
*contains the columns Id, ActivityDay, StepTotal*
*Will not be need for this analysis*

## heartrateSeconds.csv (2,483,658 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**Time**
* Datetime, time at which the heart rate value was recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Value**
* Integer, variable sampling of heart rate taken every 5 to 15 seconds on average
* *no cleaning performed*


## hourlyCalories.csv (22099 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration for which the calories burned was calculated
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Calories**
* Integer, total estimated energy expenditure during activities. Measured in kilocalories.
* *no cleaning performed*


## hourlyIntensities.csv (22,099 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration for which the calories burned was calculated
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**TotalIntensity**
* Integer, sum of intensity values for each minute of the hour. Intensity values are a spectrum from 0 (sedintary) to 3 (very active)
* *no cleaning performed*

**AverageIntensity**
* Decimal, average intensity for that hour (TotalIntensity/60)
* *no cleaning performed*


## hourlySteps.csv (22,099 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration for which the number of steps taken was recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**StepTotal**
* Integer, number of steps
* *no cleaning performed*

## minuteCaloriesNarrow.csv (1,325,580 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityMinute**
* Datetime, represents the minute duration during which the calories were burned
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Calories**
* Integer, total estimated energy expenditure. Measured in kilocalories.
* *no cleaning performed*

## minuteCaloriesWide.csv (21,645 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration during which the by-minute calories were burned
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Calories00 - Calories59**
* Decimal, total estimated energy expenditure during that minute. Measured in kilocalories.
* *no cleaning performed*

## minuteIntensitiesNarrow.csv (1,325,580 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityMinute**
* Datetime, represents the minute duration during which the intensity was calculated
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Intensity**
* Integer, intensity values are a spectrum from 0 (sedintary) to 3 (very active)

## minuteIntensitiesWide.csv (21,645 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration during which the intensity was calculated
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Intensity00-Intensity59**
* Integer, measured intensity during that minute. Intensity values are a spectrum from 0 (sedintary) to 3 (very active)
* *no cleaning performed*

## minuteMETsNarrow.csv (1,325,580 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityMinute**
* Datetime, represents the minute duration during which METS was calculated
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

## minuteSleep.csv (188,521 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**date**
* Datetime, time at which a sleep state was recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**value**
* Integer, a number representing a particular sleep state. 1 = asleep, 2 = restless, 3 = awake
* *no cleaning performed*

**logId**
* Integer, a unique log ID in Bellabeat's system
* *no cleaning performed*

## minuteStepsNarrow.csv (1,325,580 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityMinute**
* Datetime, represents the minute duration during which steps were recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Steps**
* Integer, how many steps were taken
* *no cleaning performed*

## minuteStepsWide.csv (21,645 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**ActivityHour**
* Datetime, represents the hour duration during which steps were recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**Steps00-Steps59**
* Integer, recorded steps during that minute.
* *no cleaning performed*

## sleepDay.csv (413 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**SleepDay**
* Datetime, date for which data is summarized.
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, but the time segment for all records is 0:00AM. Reformatted as mm-dd-yyyy*

**TotalSleepRecords**
* Integer, number of recorded sleep periods for that day. Includes naps > 60min
* *no cleaning performed*

**TotalMinutesAsleep**
* Integer, Total number of minutes classified as being "asleep"
* *no cleaning performed*

**TotalTimeInBed**
* Integer, Total minutes spent in bed, including asleep, restless, and awake, that occurred during a defined sleep record
* *no cleaning performed*

## weightLogInfo.csv (67 records)

**Id**
* Integer, user ID
* *no cleaning performed*

**Date**
* Datetime, date and time weight was recorded
* *Was formatted at mm/dd/yyyy h:mm:ss AM/PM, reformatted as mm-dd-yyyy hh:mm:ss*

**WeightKg**
* Decimal, weight recorded (kilograms)
* *no cleaning performed*

**WeightPounds**
* Decimal, weight recorded (pounds)
* *no cleaning performed*

**Fat**
* Integer, body fat percentage
* *no cleaning performed*

**BMI**
* Decimal, body mass index
* *no cleaning performed*

**IsManualReport**
* Boolean, TRUE = data entered manually by user, FALSE = data synced from device
* *no cleaning performed*

**LogId**
* Integer, a unique log ID in Bellabeat's system
* *no cleaning performed*
