CREATE OR ALTER PROCEDURE PrintDayAnalysis(@rok_od INT, @rok_do INT)
AS
BEGIN
  DECLARE @year INT
  DECLARE @day VARCHAR(20)
  DECLARE @sum INT
  DECLARE list CURSOR FOR 
    SELECT * FROM 
      (SELECT YEAR(n.Den) AS year, DATENAME(weekday, N.Den) AS day, SUM(cena) AS suma FROM test.Nakup n 
        WHERE YEAR(n.Den) BETWEEN @rok_od AND @rok_do
          GROUP BY YEAR(n.Den), DATENAME(weekday, N.Den)) AS YearDaySum
       WHERE suma IN (
         SELECT MAX(suma) FROM 
           (SELECT YEAR(n.Den) AS year, DATENAME(weekday, N.Den) AS day, SUM(cena) AS suma FROM test.Nakup n 
             WHERE YEAR(n.Den) BETWEEN @rok_od AND @rok_do
               GROUP BY YEAR(n.Den), DATENAME(weekday, N.Den)) AS YearDaySum
         GROUP BY year)
       ORDER BY year;
  OPEN list
  FETCH NEXT FROM list INTO @year, @day, @sum
  WHILE @@FETCH_STATUS = 0
  BEGIN
    print cast (@year as char(4)) + ': ' + @day + ': ' + cast(@sum as VARCHAR(10))
    FETCH NEXT FROM list INTO @year, @day, @sum
  END
  CLOSE list
  DEALLOCATE list
END

execute PrintDayAnalysis 2011, 2014

-- 2012: Saturday: 14175
-- 2013: Friday: 8508
-- 2014: Tuesday: 8016