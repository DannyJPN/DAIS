CREATE OR REPLACE PROCEDURE PrintDayAnalysis(rok_od INT, rok_do INT)
AS
BEGIN
  FOR i IN rok_od..rok_do 
  LOOP
    FOR rec IN (
      SELECT to_char(N.Den, 'YYYY') AS year,to_char(N.Den, 'Dy') AS day, SUM(cena) AS suma FROM Nakup n 
        WHERE extract(year FROM n.Den)=i
          GROUP BY to_char(N.Den, 'YYYY'), to_char(N.Den, 'Dy')
          ORDER BY sum(cena) DESC)
    LOOP
      DBMS_OUTPUT.PUT_LINE(i || ': ' || rec.day || ': ' || rec.suma);
      EXIT;
    END LOOP;
  END LOOP;
END;

execute PrintDayAnalysis(2011, 2014);

-- 2012: So: 14175
-- 2013: Pá: 8508
-- 2014: Út: 8016