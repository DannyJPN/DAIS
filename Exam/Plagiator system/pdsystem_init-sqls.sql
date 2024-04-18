-- Plagiarism Detection System
-- 12.03.2015
-- CREATE TABLE SQL script

BEGIN TRY
BEGIN TRANSACTION

INSERT INTO DocType VALUES(1, 'article');

INSERT INTO Document VALUES (
  1, 'Organization and Maintenance of Large Ordered Indexes',
  'Organization and maintenance of an index for a dynamic random access file is considered. It is assumed that the index must be kept on some pseudo random access backup store like a disc or a drum. ...',
  1972, 'Springer-Verlag', 0, 1);
  
INSERT INTO Term VALUES (1, 'Organization');
INSERT INTO Term VALUES (2, 'and');
INSERT INTO Term VALUES (3, 'maintenance');
INSERT INTO Term VALUES (4, 'of');
INSERT INTO Term VALUES (5, 'an');
INSERT INTO Term VALUES (6, 'index');
INSERT INTO Term VALUES (7, 'for');
INSERT INTO Term VALUES (8, 'a');
INSERT INTO Term VALUES (9, 'dynamic');
INSERT INTO Term VALUES (10, 'random');
INSERT INTO Term VALUES (11, 'access');
INSERT INTO Term VALUES (12, 'file');
INSERT INTO Term VALUES (13, 'is');
INSERT INTO Term VALUES (14, 'considered');
INSERT INTO Term VALUES (15, 'It');
INSERT INTO Term VALUES (16, 'assumed');
INSERT INTO Term VALUES (17, 'that');
INSERT INTO Term VALUES (18, 'the');
INSERT INTO Term VALUES (19, 'must');
INSERT INTO Term VALUES (20, 'be');
INSERT INTO Term VALUES (21, 'kept');
INSERT INTO Term VALUES (22, 'on');
INSERT INTO Term VALUES (23, 'some');
INSERT INTO Term VALUES (24, 'pseudo');
INSERT INTO Term VALUES (25, 'backup');
INSERT INTO Term VALUES (26, 'store');
INSERT INTO Term VALUES (27, 'like');
INSERT INTO Term VALUES (28, 'disc');
INSERT INTO Term VALUES (29, 'or');
INSERT INTO Term VALUES (30, 'drum');

INSERT INTO DocTerm VALUES(1, 1, 1);
INSERT INTO DocTerm VALUES(1, 2, 1);
INSERT INTO DocTerm VALUES(1, 3, 1);
INSERT INTO DocTerm VALUES(1, 4, 1);
INSERT INTO DocTerm VALUES(1, 5, 1);
INSERT INTO DocTerm VALUES(1, 6, 2);
INSERT INTO DocTerm VALUES(1, 7, 1);
INSERT INTO DocTerm VALUES(1, 8, 3);
INSERT INTO DocTerm VALUES(1, 9, 1);
INSERT INTO DocTerm VALUES(1, 10, 2);
INSERT INTO DocTerm VALUES(1, 11, 2);
INSERT INTO DocTerm VALUES(1, 12, 1);
INSERT INTO DocTerm VALUES(1, 13, 2);
INSERT INTO DocTerm VALUES(1, 14, 1);
INSERT INTO DocTerm VALUES(1, 15, 1);
INSERT INTO DocTerm VALUES(1, 16, 1);
INSERT INTO DocTerm VALUES(1, 17, 1);
INSERT INTO DocTerm VALUES(1, 18, 1);
INSERT INTO DocTerm VALUES(1, 19, 1);
INSERT INTO DocTerm VALUES(1, 20, 1);
INSERT INTO DocTerm VALUES(1, 21, 1);
INSERT INTO DocTerm VALUES(1, 22, 1);
INSERT INTO DocTerm VALUES(1, 23, 1);
INSERT INTO DocTerm VALUES(1, 24, 1);
INSERT INTO DocTerm VALUES(1, 25, 1);
INSERT INTO DocTerm VALUES(1, 26, 1);
INSERT INTO DocTerm VALUES(1, 27, 1);
INSERT INTO DocTerm VALUES(1, 28, 1);
INSERT INTO DocTerm VALUES(1, 29, 1);
INSERT INTO DocTerm VALUES(1, 30, 1);
  
INSERT INTO DocNgram VALUES(1, 1, 2, 3, 4, 1);
INSERT INTO DocNgram VALUES(1, 2, 3, 4, 5, 1);
INSERT INTO DocNgram VALUES(1, 3, 4, 5, 6, 1);
INSERT INTO DocNgram VALUES(1, 4, 5, 6, 7, 1);
INSERT INTO DocNgram VALUES(1, 5, 6, 7, 8, 1);
INSERT INTO DocNgram VALUES(1, 6, 7, 8, 9, 1);
INSERT INTO DocNgram VALUES(1, 7, 8, 9, 10, 1);
INSERT INTO DocNgram VALUES(1, 8, 9, 10, 11, 1);
INSERT INTO DocNgram VALUES(1, 9, 10, 11, 12, 1);
INSERT INTO DocNgram VALUES(1, 10, 11, 12, 13, 1);
INSERT INTO DocNgram VALUES(1, 11, 12, 13, 14, 1);
INSERT INTO DocNgram VALUES(1, 12, 13, 14, 15, 1);
INSERT INTO DocNgram VALUES(1, 13, 14, 15, 13, 1);
INSERT INTO DocNgram VALUES(1, 14, 15, 13, 16, 1);
INSERT INTO DocNgram VALUES(1, 15, 13, 16, 17, 1);
INSERT INTO DocNgram VALUES(1, 13, 16, 17, 18, 1);
INSERT INTO DocNgram VALUES(1, 16, 17, 18, 6, 1);
INSERT INTO DocNgram VALUES(1, 17, 18, 6, 19, 1);
INSERT INTO DocNgram VALUES(1, 18, 6, 19, 20, 1);
INSERT INTO DocNgram VALUES(1, 6, 19, 20, 21, 1);
INSERT INTO DocNgram VALUES(1, 19, 20, 21, 22, 1);
INSERT INTO DocNgram VALUES(1, 20, 21, 22, 23, 1);
INSERT INTO DocNgram VALUES(1, 21, 22, 23, 24, 1);
INSERT INTO DocNgram VALUES(1, 22, 23, 24, 10, 1);
INSERT INTO DocNgram VALUES(1, 23, 24, 10, 11, 1);
INSERT INTO DocNgram VALUES(1, 24, 10, 11, 25, 1);
INSERT INTO DocNgram VALUES(1, 10, 11, 25, 26, 1);
INSERT INTO DocNgram VALUES(1, 11, 25, 26, 27, 1);
INSERT INTO DocNgram VALUES(1, 25, 26, 27, 8, 1);
INSERT INTO DocNgram VALUES(1, 26, 27, 8, 28, 1);
INSERT INTO DocNgram VALUES(1, 27, 8, 28, 29, 1);
INSERT INTO DocNgram VALUES(1, 8, 28, 29, 8, 1);
INSERT INTO DocNgram VALUES(1, 28, 29, 8, 30, 1);

INSERT INTO Author VALUES(1, 'Rudolf', 'Bayer');
INSERT INTO Author VALUES(2, 'Edward', 'McCreight');

INSERT INTO DocAuthor VALUES (1, 1);
INSERT INTO DocAuthor VALUES (1, 2);

INSERT INTO Country VALUES (1, 'Germany', 'DE');
INSERT INTO Country VALUES (2, 'USA', 'US');

INSERT INTO Organization VALUES (1, 'Technical University of Munich', 'Munich', 1);
INSERT INTO Organization VALUES (2, 'Boeing', 'Chicago', 2);

INSERT INTO AuthorOrg VALUES (1, 1, convert(datetime, '01.01.1970', 104), NULL);
INSERT INTO AuthorOrg VALUES (2, 2, convert(datetime, '01.01.1969', 104), NULL);

COMMIT;
END TRY

BEGIN CATCH
  ROLLBACK;
END CATCH

