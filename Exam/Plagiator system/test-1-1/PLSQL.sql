-- A1
DECLARE
  v_idDocPrev INT;
  v_counter INT;
BEGIN
  v_idDocPrev := -1;

  FOR v_rec IN (
    SELECT
      Document.idDoc, Document.title, Term.term, DocTerm.Frequency
    FROM
      Document
      JOIN DocTerm ON Document.idDoc = DocTerm.idDoc
      JOIN Term ON DocTerm.idTerm = Term.idTerm
    ORDER BY
      Document.idDoc, frequency DESC
  ) LOOP
    IF v_rec.idDoc != v_idDocPrev THEN
      dbms_output.put_line(v_rec.title);
      v_idDocPrev := v_rec.idDoc;
      v_counter := 0;
    END IF;
    
    IF v_counter < 3 THEN
      dbms_output.put_line('  ' || v_rec.term || ' ... ' || to_char(v_rec.frequency) || 'x');
      v_counter := v_counter + 1;
    END IF;      
  END LOOP;
END;

-- A2
DECLARE
  v_idDoc INT;
  v_term1 VARCHAR(50);
  v_term2 VARCHAR(50);
  v_term3 VARCHAR(50);
  v_term4 VARCHAR(50);
  v_count INT;

  v_idTerm1 INT;
  v_idTerm2 INT;
  v_idTerm3 INT;
  v_idTerm4 INT;
  v_recCnt INT;
BEGIN
  v_idDoc := 1;
  v_term1 := 'bylo';
  v_term2 := 'nebylo';
  v_term3 := 'slunko';
  v_term4 := 'svitilo';
  v_count := 5;
---------------------------------
  
  SELECT MIN(idTerm) INTO v_idTerm1 FROM Term WHERE term = v_term1;
  IF v_idTerm1 IS NULL THEN
    SELECT MAX(idTerm) + 1 INTO v_idTerm1 FROM Term;
    INSERT INTO Term(idTerm, term) VALUES (v_idTerm1, v_term1);
  END IF;

  SELECT MIN(idTerm) INTO v_idTerm2 FROM Term WHERE term = v_term2;
  IF v_idTerm2 IS NULL THEN
    SELECT MAX(idTerm) + 1 INTO v_idTerm2 FROM Term;
    INSERT INTO Term(idTerm, term) VALUES (v_idTerm2, v_term2);
  END IF;

  SELECT MIN(idTerm) INTO v_idTerm3 FROM Term WHERE term = v_term3;
  IF v_idTerm3 IS NULL THEN
    SELECT MAX(idTerm) + 1 INTO v_idTerm3 FROM Term;
    INSERT INTO Term(idTerm, term) VALUES (v_idTerm3, v_term3);
  END IF;

  SELECT MIN(idTerm) INTO v_idTerm4 FROM Term WHERE term = v_term4;
  IF v_idTerm4 IS NULL THEN
    SELECT MAX(idTerm) + 1 INTO v_idTerm4 FROM Term;
    INSERT INTO Term(idTerm, term) VALUES (v_idTerm4, v_term4);
  END IF;

  SELECT COUNT(*) INTO v_recCnt
  FROM DocNgram
  WHERE idDoc = v_idDoc AND idTerm1 = v_idTerm1 AND idTerm2 = v_idTerm2 AND idTerm3 = v_idTerm3 AND idTerm4 = v_idTerm4;
  
  IF v_recCnt > 0 THEN
    UPDATE DocNgram
    SET frequency = frequency + v_count
    WHERE idDoc = v_idDoc AND idTerm1 = v_idTerm1 AND idTerm2 = v_idTerm2 AND idTerm3 = v_idTerm3 AND idTerm4 = v_idTerm4;
  ELSE
    INSERT INTO DocNgram (idDoc, idTerm1, idTerm2, idTerm3, idTerm4, frequency)
    VALUES (v_idDoc, v_idTerm1, v_idTerm2, v_idTerm3, v_idTerm4, v_count);
  END IF;
END;

-- B1
DECLARE
  v_idDocPrev INT;
  v_counter INT;
BEGIN
  v_idDocPrev := -1;

  FOR v_rec IN (
  	SELECT
      Document.idDoc, Document.title, t1.term AS term1, t2.term AS term2, t3.term AS term3, t4.term AS term4, frequency
    FROM
      Document
      JOIN DocNgram ON Document.idDoc = DocNgram.idDoc
      JOIN Term t1 ON DocNgram.idTerm1 = t1.idTerm
      JOIN Term t2 ON DocNgram.idTerm2 = t2.idTerm
      JOIN Term t3 ON DocNgram.idTerm3 = t3.idTerm
      JOIN Term t4 ON DocNgram.idTerm4 = t4.idTerm
    ORDER BY
      Document.idDoc, frequency DESC
  ) LOOP
    IF v_rec.idDoc != v_idDocPrev THEN
      dbms_output.put_line(v_rec.title);
      v_idDocPrev := v_rec.idDoc;
      v_counter := 0;
    END IF;
    IF v_counter < 3 THEN
      dbms_output.put_line('  [' || v_rec.term1 || ', ' || v_rec.term2 || ', ' || v_rec.term3 || ', ' || v_rec.term4 || '] ... ' || to_char(v_rec.frequency) || 'x');
      v_counter := v_counter + 1;
    END IF;   
  END LOOP;
END;

-- B2
DECLARE
  v_idDoc INT;
  v_term VARCHAR(50);
  v_count INT;
  
  v_idTerm INT;
  v_recCnt INT;
BEGIN
  v_idDoc := 1;
  v_term := 'pokus';
  v_count := 5;
---------------------------------

  SELECT MIN(idTerm) INTO v_idTerm FROM Term WHERE term = v_term;
  IF v_idTerm IS NULL THEN
    SELECT MAX(idTerm) + 1 INTO v_idTerm FROM Term;
    INSERT INTO Term(idTerm, term) VALUES (v_idTerm, v_term);
  END IF;

  SELECT COUNT(*) INTO v_recCnt FROM DocTerm WHERE idDoc = v_idDoc AND idTerm = v_idTerm;
  IF v_recCnt > 0 THEN
    UPDATE DocTerm
    SET frequency = frequency + v_count
    WHERE idDoc = v_idDoc AND idTerm = v_idTerm;
  ELSE
    INSERT INTO DocTerm (idDoc, idTerm, frequency)
    VALUES (v_idDoc, v_idTerm, v_count);
  END IF;
END;

-- C1
DECLARE
  v_idTermPrev INT;
  v_counter INT;
BEGIN
  v_idTermPrev := -1;

  FOR v_rec IN (
    SELECT
      Term.idTerm, Term.term, Document.title, DocTerm.Frequency
    FROM
      Document
      JOIN DocTerm ON Document.idDoc = DocTerm.idDoc
      JOIN Term ON DocTerm.idTerm = Term.idTerm
    ORDER BY
      Term.idTerm, frequency DESC
  ) LOOP
    IF v_rec.idTerm != v_idTermPrev THEN
      dbms_output.put_line('[' || v_rec.term || ']');
      v_counter := 0;
    END IF;
    
    IF v_counter < 3 THEN
      dbms_output.put_line('  ' || v_rec.title || ' ... ' || v_rec.frequency || 'x');
      v_counter := v_counter + 1;
    END IF;
  END LOOP;
END;

-- C2
DECLARE
  v_orgName VARCHAR(50);
  v_fName VARCHAR(50);
  v_lName VARCHAR(50);
  
  v_idOrg INT;
  v_idAuthor INT;
  v_recCnt INT;
BEGIN
  v_orgName := 'Boeing';
  v_fName := 'Jan';
  v_lName := 'Novak';
  
  SELECT MIN(idOrg) INTO v_idOrg FROM Organization WHERE name = v_orgName;
  IF v_idOrg IS NULL THEN
    dbms_output.put_line('Oragnizace neexistuje.');
    RETURN;
  END IF;
  
  SELECT MIN(idAuthor) INTO v_idAuthor FROM Author WHERE fname = v_fName AND lname = v_lName;
  IF v_idAuthor IS NULL THEN
    SELECT MAX(idAuthor) + 1 INTO v_idAuthor FROM Author;
    INSERT INTO Author(idAuthor, fname, lname) VALUES (v_idAuthor, v_fName, v_lName);
  END IF;

  SELECT COUNT(*) INTO v_recCnt FROM AuthorOrg WHERE idAuthor = v_idAuthor AND idOrg = v_idOrg AND "to" IS NULL;
  IF v_recCnt = 0 THEN
    INSERT INTO AuthorOrg(idAuthor, idOrg, "from")
    VALUES (v_idAuthor, v_idOrg, CURRENT_TIMESTAMP);
  END IF;  
END;

-- D1
ALTER TABLE Document
ADD totalTerms INT DEFAULT 0 NOT NULL;

\
CREATE OR REPLACE TRIGGER tgUpdateTotalTerms AFTER INSERT OR UPDATE OR DELETE ON DocTerm FOR EACH ROW  
BEGIN
  IF INSERTING OR UPDATING THEN
    UPDATE Document
    SET totalTerms = totalTerms + :new.frequency
    WHERE idDoc = :new.idDoc;
  END IF;
  
  IF DELETING OR UPDATING THEN
    UPDATE Document
    SET totalTerms = totalTerms - :old.frequency
    WHERE idDoc = :old.idDoc;
  END IF;
END;

-- D2

DECLARE
  v_docTitle VARCHAR(50);
  v_fName VARCHAR(50);
  v_lName VARCHAR(50);
  
  v_docCnt INT; 
  v_idDoc INT;
  v_idAuthor INT;
BEGIN
  v_docTitle := 'Test';
  v_fName := 'Jan';
  v_lName := 'Novak';

---------------------------------
  
  SELECT COUNT(*) INTO v_docCnt
  FROM Document
  WHERE title = v_docTitle;
  
  IF v_docCnt <= 0 THEN
    dbms_output.put_line('Dokument neexistuje');
    RETURN;
  END IF;
  
  IF v_docCnt > 1 THEN
    dbms_output.put_line('Nejednoznacny titul.');
    RETURN;
  END IF;
  
  SELECT idDoc INTO v_idDoc
  FROM Document
  WHERE title = v_docTitle;
  
  SELECT MIN(idAuthor) INTO v_idAuthor
  FROM Author
  WHERE fname = v_fName AND lname = v_lName;
  
  IF v_idAuthor IS NULL THEN
    SELECT MAX(idAuthor) + 1 INTO v_idAuthor FROM Author;
    INSERT INTO Author(idAuthor, fname, lname) VALUES (v_idAuthor, v_fName, v_lName);
  END IF;
  
  INSERT INTO DocAuthor(idDoc, idAuthor)
  VALUES (v_idDoc, v_idAuthor);
END;