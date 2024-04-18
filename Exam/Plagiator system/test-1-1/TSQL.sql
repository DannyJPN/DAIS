-- A1
BEGIN
	DECLARE c CURSOR FOR
	SELECT
		Document.idDoc, Document.title, Term.term, DocTerm.Frequency
	FROM
		Document
		JOIN DocTerm ON Document.idDoc = DocTerm.idDoc
		JOIN Term ON DocTerm.idTerm = Term.idTerm
	ORDER BY
		Document.idDoc, frequency DESC;
	
	DECLARE @idDoc INT;
	DECLARE @idDocPrev INT;
	DECLARE @cnt INT;
	DECLARE @title VARCHAR(50);
	DECLARE @term VARCHAR(50);
	DECLARE @frequency INT;
	
	OPEN c;
	
	SET @idDocPrev = -1;

	FETCH FROM c INTO @idDoc, @title, @term, @frequency
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @idDoc != @idDocPrev
		BEGIN
			PRINT @title;
			SET @cnt = 0;
		END;
		
		IF @cnt < 3
		BEGIN
			PRINT '  [' + @term + '] ... ' + CAST(@frequency AS VARCHAR) + 'x'
			SET @cnt += 1;
		END;
		
		SET @idDocPrev = @idDoc;
		FETCH FROM c INTO @idDoc, @title, @term, @frequency
	END; 
	
	CLOSE c;
	DEALLOCATE c;
END;

GO;

-- A2 
BEGIN
	DECLARE @idDoc INT;
	DECLARE @term1 VARCHAR(50);
	DECLARE @term2 VARCHAR(50);
	DECLARE @term3 VARCHAR(50);
	DECLARE @term4 VARCHAR(50);
	DECLARE @count INT;
	
	SET @idDoc = 1;
	SET @term1 = 'bylo';
	SET @term2 = 'nebylo';
	SET @term3 = 'slunko';
	SET @term4 = 'svitilo';
	SET @count = 5;
---------------------------------
	DECLARE @idTerm1 INT;
	DECLARE @idTerm2 INT;
	DECLARE @idTerm3 INT;
	DECLARE @idTerm4 INT;
	
	SET @idTerm1 = (SELECT idTerm FROM Term WHERE term = @term1);
	IF @idTerm1 IS NULL
	BEGIN
		SET @idTerm1 = (SELECT MAX(idTerm) + 1 FROM Term);
		INSERT INTO Term(idTerm, term)
		VALUES (@idTerm1, @term1);
	END;	
	SET @idTerm2 = (SELECT idTerm FROM Term WHERE term = @term2);
	IF @idTerm2 IS NULL
	BEGIN
		SET @idTerm2 = (SELECT MAX(idTerm) + 1 FROM Term);
		INSERT INTO Term(idTerm, term)
		VALUES (@idTerm2, @term2);
	END;	
	SET @idTerm3 = (SELECT idTerm FROM Term WHERE term = @term3);
	IF @idTerm3 IS NULL
	BEGIN
		SET @idTerm3 = (SELECT MAX(idTerm) + 1 FROM Term);
		INSERT INTO Term(idTerm, term)
		VALUES (@idTerm3, @term3);
	END;	
	SET @idTerm4 = (SELECT idTerm FROM Term WHERE term = @term4);
	IF @idTerm4 IS NULL
	BEGIN
		SET @idTerm4 = (SELECT MAX(idTerm) + 1 FROM Term);
		INSERT INTO Term(idTerm, term)
		VALUES (@idTerm4, @term4);
	END;	
	
	IF EXISTS(SELECT * FROM DocNgram WHERE idDoc = @idDoc AND idTerm1 = @idTerm1 AND idTerm2 = @idTerm2 AND idTerm3 = @idTerm3 AND idTerm4 = @idTerm4)
	BEGIN
		UPDATE DocNgram
		SET frequency += @count
		WHERE idDoc = @idDoc AND idTerm1 = @idTerm1 AND idTerm2 = @idTerm2 AND idTerm3 = @idTerm3 AND idTerm4 = @idTerm4
	END
	ELSE BEGIN
		INSERT INTO DocNgram(idDoc, idTerm1, idTerm2, idTerm3, idTerm4, frequency)
		VALUES (@idDoc, @idTerm1, @idTerm2, @idTerm3, @idTerm4, @count);
	END;		
END;

GO;

-- B1
BEGIN
	DECLARE c CURSOR FOR
	SELECT
		Document.idDoc, Document.title, t1.term, t2.term, t3.term, t4.term, frequency
	FROM
		Document
		JOIN DocNgram ON Document.idDoc = DocNgram.idDoc
		JOIN Term t1 ON DocNgram.idTerm1 = t1.idTerm
		JOIN Term t2 ON DocNgram.idTerm2 = t2.idTerm
		JOIN Term t3 ON DocNgram.idTerm3 = t3.idTerm
		JOIN Term t4 ON DocNgram.idTerm4 = t4.idTerm
	ORDER BY
		Document.idDoc, frequency DESC;
		
	OPEN c;
	
	DECLARE @idDoc INT;
	DECLARE @idDocPrev INT;
	DECLARE @cnt INT;
	DECLARE @title VARCHAR(50);
	DECLARE @term1 VARCHAR(50);
	DECLARE @term2 VARCHAR(50);
	DECLARE @term3 VARCHAR(50);
	DECLARE @term4 VARCHAR(50);
	DECLARE @frequency INT;
	
	SET @idDocPrev = -1;

	FETCH FROM c INTO @idDoc, @title, @term1, @term2, @term3, @term4, @frequency
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @idDoc != @idDocPrev
		BEGIN
			PRINT @title;
			SET @cnt = 0;
		END;
		
		IF @cnt < 3
		BEGIN
			PRINT '  [' + @term1 + ', ' + @term2 + ', ' + @term3 + ', ' + @term4 + '] ... ' + CAST(@frequency AS VARCHAR) + 'x'
			SET @cnt += 1;
		END;
		
		SET @idDocPrev = @idDoc;
		FETCH FROM c INTO @idDoc, @title, @term1, @term2, @term3, @term4, @frequency
	END; 
	
	CLOSE c;
	DEALLOCATE c;
END;

GO;

-- B2
BEGIN
	DECLARE @idDoc INT;
	DECLARE @term VARCHAR(50);
	DECLARE @count INT;
	
	SET @idDoc = 1;
	SET @term = 'pokus';
	SET @count = 5;
---------------------------------
	DECLARE @idTerm INT;
	
	SET @idTerm = (SELECT idTerm FROM Term WHERE term = @term);
	IF @idTerm IS NULL
	BEGIN
		SET @idTerm = (SELECT MAX(idTerm) + 1 FROM Term);
		INSERT INTO Term(idTerm, term)
		VALUES (@idTerm, @term);
	END;	
	
	IF EXISTS(SELECT * FROM DocTerm WHERE idDoc = @idDoc AND idTerm = @idTerm)
	BEGIN
		UPDATE DocTerm
		SET frequency += @count
		WHERE idDoc = @idDoc AND idTerm = @idTerm;
	END
	ELSE BEGIN
		INSERT INTO DocTerm (idDoc, idTerm, frequency)
		VALUES (@idDoc, @idTerm, @count);
	END;		
END;

GO;

-- C1
BEGIN
	DECLARE c CURSOR FOR
	SELECT
		Term.idTerm, Term.term, Document.title, DocTerm.Frequency
	FROM
		Document
		JOIN DocTerm ON Document.idDoc = DocTerm.idDoc
		JOIN Term ON DocTerm.idTerm = Term.idTerm
	ORDER BY
		Term.idTerm, frequency DESC;
	
	DECLARE @idTerm INT;
	DECLARE @idTermPrev INT;
	DECLARE @cnt INT;
	DECLARE @term VARCHAR(50);
	DECLARE @title VARCHAR(50);
	DECLARE @frequency INT;
	
	OPEN c;
	
	SET @idTermPrev = -1;

	FETCH FROM c INTO @idTerm, @term, @title, @frequency
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @idTerm != @idTermPrev
		BEGIN
			PRINT '[' + @term + ']';
			SET @cnt = 0;
		END;
		
		IF @cnt < 3
		BEGIN
			PRINT '  ' + @title + ' ... ' + CAST(@frequency AS VARCHAR) + 'x'
			SET @cnt += 1;
		END;
		
		SET @idTermPrev = @idTerm;
		FETCH FROM c INTO @idTerm, @term, @title, @frequency
	END; 
	
	CLOSE c;
	DEALLOCATE c;
END;

GO; 

-- C2
BEGIN
	DECLARE @orgName VARCHAR(50);
	DECLARE @fName VARCHAR(50);
	DECLARE @lName VARCHAR(50);
	
	SET @orgName = ' Boeing';
	SET @fName = 'Jan';
	SET @lName = 'Novak';
	
---------------------------------

	DECLARE @idOrg INT;
	DECLARE @idAuthor INT;
	
	IF NOT EXISTS(SELECT * FROM Organization WHERE name = @orgName)
	BEGIN
		PRINT 'Organizace neexistuje.';
		RETURN;
	END
	ELSE BEGIN
		SELECT @idOrg = idOrg
		FROM Organization
		WHERE name = @orgName;
	END;
		
	IF NOT EXISTS(SELECT * FROM Author WHERE fname = @fName AND lname = @lName)
	BEGIN
		SET @idAuthor = (SELECT MAX(idAuthor) + 1 FROM Author);
		INSERT INTO Author(idAuthor, fname, lname)
		VALUES (@idAuthor, @fName, @lName);
	END
	ELSE BEGIN
		SELECT @idAuthor = idAuthor
		FROM Author
		WHERE fname = @fName AND lname = @lName;
	END;
	
	IF NOT EXISTS(SELECT * FROM AuthorOrg WHERE idAuthor = @idAuthor AND idOrg = @idOrg AND "to" IS NULL)
	BEGIN
		INSERT INTO AuthorOrg(idAuthor, idOrg, "from")
		VALUES (@idAuthor, @idOrg, GETDATE());
	END;
END;

GO;

-- D1
ALTER TABLE Document
ADD totalTerms INT NOT NULL DEFAULT 0;

GO;

CREATE TRIGGER tgUpdateTotalTerms ON DocTerm AFTER INSERT, UPDATE, DELETE AS
BEGIN
	DECLARE @idDoc INT;
	DECLARE @frequency INT;
	
	DECLARE c1 CURSOR FOR
	SELECT idDoc, frequency
	FROM deleted;
	
	DECLARE c2 CURSOR FOR
	SELECT idDoc, frequency
	FROM inserted;
	
	OPEN c1;
	FETCH FROM c1 INTO @idDoc, @frequency;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE Document
		SET totalTerms -= @frequency
		WHERE idDoc = @idDoc
		
		FETCH FROM c1 INTO @idDoc, @frequency;
	END;	
	CLOSE c1;
	DEALLOCATE c1;
			
	OPEN c2;
	FETCH FROM c2 INTO @idDoc, @frequency;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE Document
		SET totalTerms += @frequency
		WHERE idDoc = @idDoc
		
		FETCH FROM c2 INTO @idDoc, @frequency;
	END;	
	CLOSE c2;
	DEALLOCATE c2;
END;

GO;

-- D2
BEGIN
	DECLARE @docTitle VARCHAR(50);
	DECLARE @fName VARCHAR(50);
	DECLARE @lName VARCHAR(50);
	SET @docTitle = 'Test';
	SET @fName = 'Jan';
	SET @lName = 'Novak';

---------------------------------

	DECLARE @idDoc INT;
	DECLARE @docCnt INT;
	DECLARE @idAuthor INT;
	
	SELECT @docCnt = COUNT(*)
	FROM Document
	WHERE title = @docTitle;
	
	IF @docCnt <= 0
	BEGIN
		PRINT 'Dokument neexistuje.';
		RETURN;
	END;
	
	IF @docCnt > 1
	BEGIN
		PRINT 'Nejednoznacny titul.';
		RETURN;
	END;
	
	SELECT @idDoc = idDoc
	FROM Document
	WHERE title = @docTitle;
	
	IF NOT EXISTS(SELECT * FROM Author WHERE fname = @fName AND lname = @lName)
	BEGIN
		SET @idAuthor = (SELECT MAX(idAuthor) + 1 FROM Author);
		INSERT INTO Author(idAuthor, fname, lname)
		VALUES (@idAuthor, @fName, @lName);
	END
	ELSE BEGIN
		SELECT @idAuthor = idAuthor
		FROM Author
		WHERE fname = @fName AND lname = @lName;
	END;
	
	INSERT INTO DocAuthor(idDoc, idAuthor)
	VALUES (@idDoc, @idAuthor);
END;

GO;


