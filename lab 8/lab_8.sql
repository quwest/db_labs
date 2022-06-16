DELIMITER $$
CREATE TRIGGER triger_1 AFTER INSERT ON books_for_pc
FOR EACH ROW
BEGIN
IF (SELECT COUNT(books_for_pc.Theme) FROM books_for_pc WHERE NEW.Theme=books_for_pc.Theme) NOT BETWEEN 5 AND 10
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Кількість тем може бути в діапазоні від 5 до 10';
END IF;
END;
$$
DELIMITER ;




DELIMITER $$
CREATE TRIGGER triger_2 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	IF (NEW.Is_new=True AND YEAR(NEW.Date_book)!=YEAR(CURRENT_DATE)) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Новинкою може бути тільки книга видана в поточному році.';
	END IF;
END
$$
DELIMITER ;




DELIMITER $$
CREATE TRIGGER triger_3 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	IF (NEW.Pages_count<100 AND NEW.Price)>10 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $';
	ELSEIF( NEW.Pages_count<200 AND NEW.Price)>20 THEN SET @error2='Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $';
	ELSEIF(NEW.Pages_count<300 AND NEW.Price)>30 THEN SET @error3='Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $';
END IF;
END;
$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER triger_4 BEFORE INSERT ON books_for_pc
FOR EACH ROW
IF((NEW.Publisher=9 AND NEW.Tirage<5000) OR (NEW.Publisher=5 AND NEW.Tirage<10000))
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.';
END IF
$$
DELIMITER ;




DELIMITER $$
CREATE TRIGGER triger_5 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	SET @number=0;
	SELECT COUNT(*) INTO @number FROM books_for_pc WHERE code_book=NEW.Code AND(
		Is_new!=NEW.Is_new OR
		Name!=NEW.Name OR
		Price!=NEW.Price OR
		Publisher!=NEW.Publisher OR
		Pages_count!=NEW.Pages_count OR
		Format!=NEW.Format OR
		Date_book!=NEW.Date_book OR
		Tirage!=NEW.Tirage OR
		Theme!=NEW.Theme OR
		Category!=NEW.Category);
  IF @number!=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Книги з однаковим кодом повинні мати однакові дані';
  END IF;
END



DELIMITER $$
CREATE TRIGGER triger_6 BEFORE DELETE ON books_for_pc
FOR EACH ROW
BEGIN
	IF ((CURRENT_USER != 'dbo') AND (COLUMNS_UPDATED() & 1)!=0)
	THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Якщо користувач не "dbo", то видалення забороняється';
	END IF;
END
$$
DELIMITER ;






DELIMITER $$
CREATE TRIGGER triger_7 BEFORE UPDATE ON books_for_pc
FOR EACH ROW
BEGIN
	IF ((CURRENT_USER != 'dbo') AND OLD.Price!=NEW.Price) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Користувач "dbo" не має права змінювати ціну книги';
	END IF;
END
$$
DELIMITER ;




DELIMITER $$
CREATE TRIGGER triger_8 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	IF (NEW.Publisher=6 or New.Publisher=8) AND (NEW.Category=2) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Видавництва ДМК і Еком підручники не видають';
	END IF;
END
$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER triger_9 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	SET @new_books_count=0;
	SELECT COUNT(*) INTO @new_books_count FROM books_for_pc WHERE books_for_pc.Publisher=NEW.Publisher AND books_for_pc.Is_new=True AND
    YEAR(CURRENT_DATE())=YEAR(books_for_pc.Date_book) AND MONTH(books_for_pc.Date_book);
    IF (NEW.Is_new=True AND @new_books_count>10) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року';
    END IF;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER triger_10 BEFORE INSERT ON books_for_pc
FOR EACH ROW
BEGIN
	IF (NEW.Publisher=9) AND (NEW.Format=4) THEN SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT='Видавництво BHV не випускає книги формату 60х88 / 16';
    END IF;
END
$$
DELIMITER ;