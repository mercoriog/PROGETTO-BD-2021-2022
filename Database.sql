--CREAZIONE TABELLE  

--creazione tabella contatto 
CREATE TABLE CONTATTO( 
 Cod_Contatto  SERIAL        NOT NULL, 
 Nome          VARCHAR(100)  NOT NULL, 
 Cognome       VARCHAR(100)  NOT NULL, 
 Foto          VARCHAR(1000) NOT NULL);

--creazione tabella indirizzo 
CREATE TABLE INDIRIZZO(
 Cod_Indirizzo SERIAL       NOT NULL,
 Via           VARCHAR(100) NOT NULL, 
 Cap           INTEGER      NOT NULL,
 Nazione       VARCHAR(100) NOT NULL,
 Citta         VARCHAR(100) NOT NULL);

--creazione tabella possiede 
CREATE TABLE POSSIEDE( 
 Cod_Indirizzo  SERIAL NOT NULL,
 Cod_Contatto   SERIAL NOT NULL); 

--creazione tabella gruppo 
CREATE TABLE GRUPPO( 
 Nome           VARCHAR(100)  NOT NULL, 
 Descrizione    VARCHAR(1000) NOT NULL,
 Categoria      VARCHAR(100)  NOT NULL); 

--creazione tabella afferenza 
CREATE TABLE AFFERENZA( 
Cod_Contatto    SERIAL          NOT NULL, 
Nome_Gruppo     VARCHAR(100)    NOT NULL);

--creazione tabella email 
CREATE TABLE EMAIL( 
Cod_Email       SERIAL          NOT NULL, 
Indirizzo       VARCHAR(100)    NOT NULL, 
Dominio         VARCHAR(100)    NOT NULL, 
Cod_Contatto    SERIAL          NOT NULL); 

--creazione tabella fornitore 
CREATE TABLE FORNITORE( 
Nome              VARCHAR(100)   NOT NULL, 
Categoria         VARCHAR(100)   NOT NULL, 
Casa_Produttrice  VARCHAR(100)   NOT NULL); 

--creazione tabella account 
CREATE TABLE ACCOUNT( 
Nickname          VARCHAR(100)   NOT NULL, 
Frase_benvenuto   VARCHAR(100), 
Nome              VARCHAR(100)   NOT NULL, 
Cognome           VARCHAR(100)   NOT NULL, 
Nome_Fornitore    VARCHAR(100)   NOT NULL, 
Cod_Email         SERIAL         NOT NULL);

--creazione tabella telefono_mobile 
CREATE TABLE TELEFONO_MOBILE( 
CodN_Mobile      SERIAL             NOT NULL, 
Prefisso_Naz     VARCHAR(5)         NOT NULL, 
Numero           DOUBLE PRECISION   NOT NULL, 
Cod_Contatto     SERIAL             NOT NULL);

--creazione tabella telefono_fisso 
CREATE TABLE TELEFONO_FISSO( 
CodN_Fisso        SERIAL            NOT NULL, 
Prefisso_Naz      VARCHAR(5)        NOT NULL,
Prefisso_C        INTEGER           NOT NULL, 
Numero            DOUBLE PRECISION  NOT NULL, 
Cod_Contatto      SERIAL            NOT NULL);

--creazione tabella reindirizzamento 
CREATE TABLE REINDIRIZZAMENTO( 
CodN_Fisso      SERIAL      NOT NULL, 
CodN_Mobile     SERIAL      NOT NULL);

--PRIMARY KEY 
--vincolo chiave primaria tabella CONTATTO 
ALTER TABLE CONTATTO
  ADD CONSTRAINT PK_CONTATTO PRIMARY KEY(Cod_Contatto); 


--vincolo chiave primaria tabella INDIRIZZO 
ALTER TABLE INDIRIZZO
  ADD CONSTRAINT PK_INDIRIZZO PRIMARY KEY(Cod_Indirizzo); 


--vincolo chiave primaria tabella GRUPPO 
ALTER TABLE GRUPPO
  ADD CONSTRAINT PK_GRUPPO PRIMARY KEY(Nome); 


--vincolo chiave primaria tabella EMAIL 
ALTER TABLE EMAIL
  ADD CONSTRAINT PK_EMAIL PRIMARY KEY(Cod_Email); 


--vincolo chiave primaria tabella FORNITORE 
ALTER TABLE FORNITORE 
  ADD CONSTRAINT PK_FORNITORE PRIMARY KEY(Nome); 
 

--vincolo chiave primaria tabella ACCOUNT 
ALTER TABLE ACCOUNT
  ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY(Nickname); 


--vincolo chiave primaria tabella TELEFONO_MOBILE 
ALTER TABLE TELEFONO_MOBILE
  ADD CONSTRAINT PK_TELEFONOM PRIMARY KEY(CodN_Mobile); 

--vincolo chiave primaria tabella TELEFONO_FISSO 
ALTER TABLE TELEFONO_FISSO
  ADD CONSTRAINT PK_TELEFONOF PRIMARY KEY(CodN_Fisso); 


--FOREIGN KEY 

--vincoli chiave esterna tabella POSSIEDE 
ALTER TABLE POSSIEDE
  ADD CONSTRAINT FK_POSSIEDE_INDIRIZZO FOREIGN KEY(Cod_Indirizzo) 
        REFERENCES INDIRIZZO(Cod_Indirizzo) ON DELETE CASCADE; 


ALTER TABLE POSSIEDE
  ADD CONSTRAINT FK_POSSIEDE_CONTATTO FOREIGN KEY(Cod_Contatto) 
        REFERENCES CONTATTO(Cod_Contatto) ON DELETE CASCADE;
  

--vincoli chiave esterna tabella AFFERENZA 
ALTER TABLE AFFERENZA
  ADD CONSTRAINT FK_AFFERENZA_CONTATTO FOREIGN KEY(Cod_Contatto) 
       REFERENCES CONTATTO(Cod_Contatto) ON DELETE CASCADE;


ALTER TABLE AFFERENZA 
  ADD CONSTRAINT FK_AFFERENZA_GRUPPO FOREIGN KEY(Nome_Gruppo) 
       REFERENCES GRUPPO(Nome) ON DELETE CASCADE;


--vincolo chiave esterna tabella EMAIL 
 ALTER TABLE EMAIL
   ADD CONSTRAINT FK_EMAIL_CONTATTO FOREIGN KEY(Cod_Contatto) 
    REFERENCES CONTATTO(Cod_Contatto) ON DELETE CASCADE;


--vincoli chiave esterna tabella ACCOUNT
ALTER TABLE ACCOUNT 
  ADD CONSTRAINT FK_ACCOUNT_NOME_F FOREIGN KEY(Nome_Fornitore)
    REFERENCES FORNITORE(Nome) ON DELETE CASCADE;


ALTER TABLE ACCOUNT
  ADD CONSTRAINT FK_ACCOUNT_EMAIL FOREIGN KEY(Cod_Email)
    REFERENCES EMAIL(Cod_Email) ON DELETE CASCADE; 

 
--vincolo chiave esterna TELEFONO_FISSO 
 ALTER TABLE TELEFONO_FISSO
    ADD CONSTRAINT FK_TELEFONOF FOREIGN KEY(Cod_Contatto) 
     REFERENCES CONTATTO(Cod_Contatto) ON DELETE CASCADE; 
  

--vincolo chiave esterna tabella TELEFONO_MOBILE 
ALTER TABLE TELEFONO_MOBILE
  ADD CONSTRAINT FK_TELEFONOM FOREIGN KEY(Cod_Contatto) 
     REFERENCES CONTATTO(Cod_Contatto) ON DELETE CASCADE;


--vincoli chiave esterna tabella REINDIRIZZAMENTO 
ALTER TABLE REINDIRIZZAMENTO
  ADD CONSTRAINT FK_REINDIRIZZAMENTO_TF FOREIGN KEY(CodN_Fisso) 
    REFERENCES TELEFONO_FISSO(CodN_Fisso) ON DELETE CASCADE;


ALTER TABLE REINDIRIZZAMENTO
  ADD CONSTRAINT FK_REINDIRIZZAMENTO_TM FOREIGN KEY(CodN_Mobile) 
    REFERENCES TELEFONO_MOBILE(CodN_Mobile) ON DELETE CASCADE;
    

--VINCOLI UNIQUE 
--vincolo unique tabella EMAIL 
ALTER TABLE EMAIL
  ADD CONSTRAINT U_EMAIL UNIQUE(Cod_Email,Cod_Contatto);


--vincolo unique tabella ACCOUNT 
ALTER TABLE ACCOUNT
  ADD CONSTRAINT U_ACCOUNT UNIQUE(Nome_Fornitore,Cod_Email); 


--VINCOLI DI CONTROLLO 
--vincolo dominio corretto email
ALTER TABLE EMAIL
    ADD CONSTRAINT DOMINIO_CORRETTO
        CHECK (Dominio LIKE '@_%._%');


--vincolo inidirizzo corretto email
ALTER TABLE EMAIL
    ADD CONSTRAINT INDIRIZZO_CORRETTO
        CHECK (Indirizzo LIKE '_____%');


--vincolo prefisso nazionale corretto telefono_mobile 
ALTER TABLE TELEFONO_MOBILE
ADD CONSTRAINT PREFISSO_NAZ_CORRETTO_TM
CHECK (Prefisso_Naz LIKE '+%');


--vincolo prefisso nazionale corretto telefono_fisso 
ALTER TABLE TELEFONO_FISSO
    ADD CONSTRAINT PREFISSO_NAZ_CORRETTO_TF
        CHECK (Prefisso_Naz LIKE '+%');


--INIZIALIZZAZIONE SEQUENZE 
--SEQUENZA SERIAL Cod_Contatto
ALTER SEQUENCE public.contatto_cod_contatto_seq RESTART WITH 1;

--SEQUENZA SERIAL Cod_Indirizzo
ALTER SEQUENCE public.indirizzo_cod_indirizzo_seq RESTART WITH 1;

--SEQUENZA SERIAL Cod_Email
ALTER SEQUENCE public.email_cod_email_seq RESTART WITH 1;

--SEQUENZA SERIAL CodN_mobile 
ALTER SEQUENCE public.telefono_mobile_codn_mobile_seq RESTART WITH 1;

--SEQUENZA SERIAL CodN_fisso 
ALTER SEQUENCE public.telefono_fisso_codn_fisso_seq RESTART WITH 1;


--PROCEDURE 
--procedura ricerca contatto per NOME
create or replace procedure ricercaNome (nomePersona varchar(100))
language PLPGSQL
as $$
DECLARE comando_ricerca text;
begin 
	
	comando_ricerca := E'create or replace view vista_ricerca as select *
            		from CONTATTO 
            		where nome =\'' || nomePersona || E'\'';
					
	EXECUTE comando_ricerca;
end;
$$;

--procedura ricerca contatto per EMAIL 
create or replace procedure ricercaEmail (indirizzo varchar(100), dominio varchar(100))
language PLPGSQL
as $$
DECLARE comando_ricerca text;
begin 
	
	comando_ricerca := E'create or replace view vista_ricerca_email as 
			select c.nome, c.cognome, c.foto
            		from email as e join contatto as c on e.cod_contatto=c.cod_contatto
            		where e.Indirizzo = \'' || indirizzo|| E'\'
                        and e.Dominio = \'' || dominio|| E'\'';		
		
	EXECUTE comando_ricerca;
end;
$$;

--procedura ricerca contatto per ACCOUNT 
create or replace procedure RicercaPerAccount (Nickname varchar(100))
language PLPGSQL
as $$
DECLARE comando_ricerca text;
begin 
	
	comando_ricerca := E'create or replace view vista_ricerca_per_account as select c.nome,c.cognome,c.foto
            		from ACCOUNT as a join EMAIL as e on a.cod_email=e.cod_email join contatto as c on e.cod_contatto=c.cod_contatto
            		where a.Nickname= \'' || Nickname  || E'\'';
					
	EXECUTE comando_ricerca;
end;
$$;

--procedura ricerca contatto per telefono_fisso 
create or replace procedure ricercaPerTelefonoFisso(prefissoN varchar(5) ,prefissoC integer, numero double precision)
language PLPGSQL
as $$
DECLARE comando_ricerca text;
begin 
	
	comando_ricerca := E'create or replace view vista_ricerca_per_fisso as select c.nome,c.cognome,c.foto
            		from TELEFONO_FISSO as t join CONTATTO as c on t.Cod_contatto=c.Cod_contatto
            		where t.Prefisso_Naz=\'' || prefissoN 
					|| E'\'and t.Prefisso_C=\'' || prefissoC
					|| E'\'and t.Numero=\'' || numero|| E'\'';
					
	EXECUTE comando_ricerca;
end;
$$;

--procedura ricerca contatto per telefono_mobile 
create or replace procedure ricercaPerTelefonoMobile(prefissoN varchar(5), numero double precision)
language PLPGSQL
as $$
DECLARE comando_ricerca text;
begin 
	
	comando_ricerca := E'create or replace view vista_ricerca_per_mobile as select c.nome,c.cognome,c.foto
            		from TELEFONO_MOBILE as t join CONTATTO as c on t.Cod_contatto=c.Cod_contatto
            		where t.Prefisso_Naz=\'' || prefissoN|| E'\'and t.Numero=\'' || numero|| E'\'';
					
	EXECUTE comando_ricerca;
end;
$$;

--procedura creazione CONTATTO 
create or replace procedure creaContatto (
Nome_c VARCHAR(100), Cognome_c VARCHAR(100), Foto_c VARCHAR(1000), 
Ind_email VARCHAR(100), Dom_email VARCHAR(100), 
Via_c VARCHAR(100), CAP_c INTEGER, Nazione_c VARCHAR(100), Citta_c VARCHAR(100),
Pre_naz_fisso VARCHAR(5),Pre_C_fisso INTEGER, Num_fisso DOUBLE PRECISION,
Pre_naz_mobile VARCHAR(5), Numero_mobile DOUBLE PRECISION
)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
DECLARE c_contatto INTEGER;
DECLARE c_indirizzo INTEGER;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO CONTATTO(Nome, Cognome, Foto) VALUES(' || api || Nome_c || sep || Cognome_c || sep || Foto_c || api || ')';			
	EXECUTE comando;
	
	SELECT MAX(Cod_Contatto) INTO c_contatto FROM CONTATTO WHERE Nome = Nome_c AND Cognome = Cognome_c AND Foto = Foto_c;
	
	comando := E'INSERT INTO EMAIL(Indirizzo, Dominio, Cod_Contatto) VALUES(' || api || Ind_email || sep || Dom_email || sep || c_contatto || api || ')';
	EXECUTE comando;	
	
	comando := E'INSERT INTO TELEFONO_FISSO(Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto) VALUES(' || api || Pre_naz_fisso || sep || Pre_C_fisso || sep || Num_fisso || sep || c_contatto || api || ')';
	EXECUTE comando;

	comando := E'INSERT INTO TELEFONO_MOBILE(Prefisso_Naz, Numero, Cod_Contatto) VALUES(' || api || Pre_naz_mobile || sep || Numero_mobile || sep || c_contatto || api || ')';
	EXECUTE comando;

	comando := E'INSERT INTO INDIRIZZO(Via, Cap, Nazione, Citta) VALUES(' || api || Via_c || sep || CAP_c || sep || Nazione_c || sep || Citta_c || api || ')';			
	EXECUTE comando;
	
	SELECT MAX(Cod_Indirizzo) INTO c_indirizzo FROM INDIRIZZO WHERE Via = Via_c AND CAP = CAP_c AND Nazione = Nazione_c AND Citta = Citta_C;

	comando := E'INSERT INTO POSSIEDE(Cod_Indirizzo, Cod_Contatto) VALUES(' || api || c_indirizzo || sep || c_contatto || api || ')';			
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati contatto in un gruppo 
create or replace procedure aggiungiGruppoContatto (c_contatto INTEGER, Nome_g VARCHAR(100))
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO AFFERENZA(Cod_Contatto, Nome_Gruppo) VALUES(' || api || c_contatto || sep || Nome_g || api || ')';
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati tabella EMAIL 
create or replace procedure aggiungiEmail (Ind_email VARCHAR(100), Dom_email VARCHAR(100), c_contatto INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api	text;
DECLARE sep	text;
begin
	api := E'\'';
	sep := E'\',\'';

	comando := E'INSERT INTO EMAIL(Indirizzo, Dominio, Cod_Contatto) VALUES(' || api 
			|| Ind_email || sep || Dom_email || sep || c_contatto || api || ')';
	EXECUTE comando;	
	
end;
$$;

--procedura inserimento dati tabella ACCOUNT
create or replace procedure aggiungiAccount (
	Nickname VARCHAR(100), Frase VARCHAR(100), Nome VARCHAR(100), Cognome VARCHAR(100), Nome_Fornitore VARCHAR(100), c_email INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO ACCOUNT(Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email) VALUES(' || api 
			|| Nickname || sep || Frase || sep || Nome || sep || Cognome || sep ||Nome_Fornitore || sep || c_email ||  api || ')';
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati tabella TELEFONO_FISSO 
create or replace procedure aggiungiFisso (Pre_naz_fisso VARCHAR(5),Pre_C_fisso INTEGER, Num_fisso DOUBLE PRECISION, c_contatto INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO TELEFONO_FISSO(Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto) VALUES(' || api || Pre_naz_fisso || sep || Pre_C_fisso || sep || Num_fisso || sep || c_contatto || api || ')';
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati tabella INDIRIZZO 
create or replace procedure aggiungiIndirizzo (Via_c VARCHAR(100), CAP_c INTEGER, Nazione_c VARCHAR(100), Citta_c VARCHAR(100), c_Contatto INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
DECLARE c_indirizzo INTEGER;
begin
	
	api := E'\'';
	sep := E'\',\'';

	comando := E'INSERT INTO INDIRIZZO(Via, CAP, Nazione, Citta) VALUES(' || api || Via_c || sep || CAP_c || sep || Nazione_c || sep || Citta_c || api || ')';			
	EXECUTE comando;
	
	SELECT MAX(Cod_Indirizzo) INTO c_indirizzo FROM INDIRIZZO WHERE Via = Via_c AND CAP = CAP_c AND Nazione = Nazione_c AND Citta = Citta_C;

	comando := E'INSERT INTO POSSIEDE(Cod_Indirizzo, Cod_Contatto) VALUES(' || api || c_indirizzo || sep || c_contatto || api || ')';			
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati tabella TELEFONO_MOBILE 
create or replace procedure aggiungiMobile (Pre_naz_mobile VARCHAR(5), Numero_mobile DOUBLE PRECISION, c_contatto INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO TELEFONO_MOBILE(Prefisso_Naz, Numero, Cod_Contatto) VALUES(' || api || Pre_naz_mobile || sep || Numero_mobile || sep || c_contatto || api || ')';
	EXECUTE comando;
	
end;
$$;

--procedura inserimento dati tabella reindirizzamento 
create or replace procedure aggiungiReindirizzamento (c_fisso INTEGER, c_mobile INTEGER)
language PLPGSQL
as $$
DECLARE comando text;
DECLARE api text;
DECLARE sep text;
begin
	
	api := E'\'';
	sep := E'\',\'';
	
	comando := E'INSERT INTO REINDIRIZZAMENTO(CodN_Fisso, CodN_Mobile) VALUES(' || api || c_fisso || sep || c_mobile || api || ')';
	EXECUTE comando;
	
end;
$$;


--procedura modifica contatto
create or replace procedure modificaContatto (c_contatto INTEGER, nome varchar(100), cognome varchar(100))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update CONTATTO set Nome = \'' || nome || E'\', Cognome = \'' || cognome
            		|| E'\' where Cod_Contatto =\'' || c_contatto || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica indirizzo 
create or replace procedure modificaIndirizzo (c_indirizzo integer, via varchar(100), cap integer, nazione varchar(100), citta varchar(100))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update INDIRIZZO set Via = \'' || via || E'\', CAP = \'' || cap
            			|| E'\', Nazione = \'' || nazione || E'\', Citta = \'' || citta 
						|| E'\' where Cod_Indirizzo =\'' || c_indirizzo || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica email 
create or replace procedure modificaEmail (c_email integer, Indirizzo varchar(100), Dominio varchar(100))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update Email set Indirizzo = \'' || indirizzo || E'\', Dominio = \'' 
				|| dominio|| E'\' where Cod_Email = \'' ||c_email || E'\'';		
		
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica account 
create or replace procedure modificaAccount (Nickname varchar(100), frase_ben VARCHAR(300))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update ACCOUNT set Frase_Benvenuto =\'' || frase_ben || E'\' where Nickname = \'' || Nickname || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica foto_contatto 
create or replace procedure modificaFotoContatto (c_contatto integer, foto_path varchar(100))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update CONTATTO set Foto =\'' || foto_path || E'\' where Cod_Contatto =\'' || c_contatto || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica telefono_fisso 
create or replace procedure modificaTelefonoFisso(c_fisso integer, prefissoN varchar(5), prefissoC integer, numero double precision)
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update TELEFONO_FISSO set Prefisso_Naz = \'' || prefissoN || E'\', Prefisso_C = \'' || prefissoC || E'\', Numero =\'' || numero || E'\' where CodN_Fisso = \'' || c_fisso || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura modifica telefono_mobile 
create or replace procedure modificaTelefonoMobile(c_mobile integer, prefissoN varchar(5), numero double precision)
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'update TELEFONO_MOBILE set Prefisso_Naz = \'' || prefissoN || E'\', Numero = \'' || numero || E'\' where CodN_Mobile = \'' || c_mobile || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura elimina contatto
create or replace procedure eliminaContatto (c_contatto INTEGER)
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
DECLARE comando text;
DECLARE Codici_ind_cursor refcursor;
DECLARE curr_ind INTEGER;
begin 
	
	ALTER TABLE INDIRIZZO DISABLE TRIGGER INDIRIZZO_PRINCIPALE_OBBLIGATORIO;
	ALTER TABLE TELEFONO_FISSO DISABLE TRIGGER TELEFONO_FISSO_OBBLIGATORIO;
	ALTER TABLE TELEFONO_MOBILE DISABLE TRIGGER TELEFONO_MOBILE_OBBLIGATORIO;
	
	comando:= E'SELECT Cod_Indirizzo FROM POSSIEDE WHERE Cod_Contatto = \'' || c_contatto || E'\'';
	open Codici_ind_cursor FOR EXECUTE comando;
	LOOP
		FETCH Codici_ind_cursor INTO curr_ind;
        EXIT WHEN NOT FOUND;
		comando_eliminazione := E'delete from INDIRIZZO where Cod_Indirizzo = \'' || curr_ind || E'\'';		
		EXECUTE comando_eliminazione;
	END LOOP;
	
	comando_eliminazione := E'delete from CONTATTO where Cod_Contatto = \'' || c_contatto || E'\'';		
	EXECUTE comando_eliminazione;
	
	ALTER TABLE INDIRIZZO ENABLE TRIGGER INDIRIZZO_PRINCIPALE_OBBLIGATORIO;
	ALTER TABLE TELEFONO_FISSO ENABLE TRIGGER TELEFONO_FISSO_OBBLIGATORIO;
	ALTER TABLE TELEFONO_MOBILE ENABLE TRIGGER TELEFONO_MOBILE_OBBLIGATORIO;
end;
$$;

--procedura elimina indirizzo 
create or replace procedure eliminaIndirizzo (c_indirizzo INTEGER)
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
begin 
	
	comando_eliminazione := E'delete from INDIRIZZO where Cod_Indirizzo = \'' || c_indirizzo || E'\'';		
		
	EXECUTE comando_eliminazione;
end;
$$;

--procedura elimina email 
create or replace procedure eliminaEmail (c_email INTEGER)
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
begin 
	
	comando_eliminazione := E'delete from email where Cod_Email = \'' || c_email || E'\'';		
		
	EXECUTE comando_eliminazione;
end;
$$;

--procedura elimina account 
create or replace procedure eliminaAccount (Nickname varchar(100))
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
begin 
	
	comando_eliminazione := E'delete from ACCOUNT where Nickname= \'' || Nickname  || E'\'';
					
	EXECUTE comando_eliminazione;
end;
$$;

--procedura elimina afferenza 
create or replace procedure eliminaAfferenza (c_contatto INTEGER, nome_gruppo VARCHAR(100))
language PLPGSQL
as $$
DECLARE comando_modifica text;
begin 
	
	comando_modifica := E'delete from AFFERENZA where Cod_Contatto = \'' || c_contatto 
            		|| E'\' and Nome_Gruppo =\'' || nome_gruppo || E'\'';
					
	EXECUTE comando_modifica;
end;
$$;

--procedura elimina telefono_fisso
create or replace procedure eliminaTelefonoFisso(c_fisso INTEGER)
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
begin 
	
	comando_eliminazione := E'delete from TELEFONO_FISSO where CodN_Fisso=\'' || c_fisso || E'\'';
					
	EXECUTE comando_eliminazione;
end;
$$;

--procedura elimina telefono_mobile 
create or replace procedure eliminaTelefonoMobile(c_mobile INTEGER)
language PLPGSQL
as $$
DECLARE comando_eliminazione text;
begin 
	
	comando_eliminazione := E'delete from TELEFONO_MOBILE where CodN_Mobile=\'' || c_mobile || E'\'';
					
	EXECUTE comando_eliminazione;
end;
$$;

--TRIGGER 

--DEFINIZIONE FUNZIONE TRIGGER ELIMINA INDIRIZZO
create or replace function trigger_function_EliminaIndirizzo()
	returns trigger
language PLPGSQL
AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM POSSIEDE WHERE Cod_Indirizzo <> OLD.Cod_Indirizzo 
				 AND Cod_Contatto = OLD.Cod_Contatto) THEN
		RAISE EXCEPTION E'L\'eliminazione dell\'indirizzo viola il vincolo relazionale tra CONTATTO e INDIRIZZO che prevede almeno un indirizzo per ogni contatto'
		USING HINT = 'Assegna prima un indirizzo alternativo allo stesso contatto';
	END IF;
	
	RETURN OLD;
END;
$$;

--trigger INDIRIZZO_PRINCIPALE_OBBLIGATORIO
create or replace TRIGGER INDIRIZZO_PRINCIPALE_OBBLIGATORIO
BEFORE DELETE ON INDIRIZZO
FOR EACH ROW
EXECUTE PROCEDURE trigger_function_eliminaindirizzo();


--DEFINIZIONE FUNZIONE TRIGGER ELIMINA MOBILE
create or replace function trigger_function_EliminaMobile()
	returns trigger
language PLPGSQL
AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM TELEFONO_MOBILE WHERE CodN_Mobile <> OLD.CodN_Mobile 
				 AND Cod_Contatto = OLD.Cod_Contatto) THEN
		RAISE EXCEPTION E'L\'eliminazione del telefono mobile viola il vincolo relazionale tra CONTATTO e TELEFONO_MOBILE che prevede almeno un telefono mobile per ogni contatto'
		USING HINT = 'Assegna prima un telefono mobile alternativo allo stesso contatto';
	END IF;
	
	RETURN OLD;
END;
$$;

--trigger TELEFONO_MOBILE_OBBLIGATORIO
create or replace TRIGGER TELEFONO_MOBILE_OBBLIGATORIO
BEFORE DELETE ON TELEFONO_MOBILE
FOR EACH ROW
EXECUTE PROCEDURE trigger_function_EliminaMobile();


--DEFINIZIONE FUNZIONE TRIGGER ELIMINA FISSO
create or replace function trigger_function_EliminaFisso()
	returns trigger
language PLPGSQL
AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM TELEFONO_FISSO WHERE CodN_Fisso <> OLD.CodN_Fisso 
				 AND Cod_Contatto = OLD.Cod_Contatto) THEN
		RAISE EXCEPTION E'L\'eliminazione del telefono fisso viola il vincolo relazionale tra CONTATTO e TELEFONO_FISSO che prevede almeno un telefono fisso per ogni contatto'
		USING HINT = 'Assegna prima un telefono fisso alternativo allo stesso contatto';
	END IF;
	
	RETURN OLD;
END;
$$;

--trigger TELEFONO_FISSO_OBBLIGATORIO
create or replace TRIGGER TELEFONO_FISSO_OBBLIGATORIO
BEFORE DELETE ON TELEFONO_FISSO
FOR EACH ROW
EXECUTE PROCEDURE trigger_function_EliminaFisso();


--POPOLAZIONE 

--inserimento dati tabella conatti 
INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Michele','Rossi','.\MicheleRossi.png'); 

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Antonio','Pascale',',\AntonioPascale.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Mirko','Furlan','.\MirkoFurlan.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Antonio','Ferrari','.\AntonioFerrari');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Erika','Riva','.\ErikaRiva.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Antonella','Bianchi','.\AntonellaBianchi.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Pasquale','Zanino',',.\PasqualeZanino');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Marika','Sala','.\MarikaSala.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Giuseppina','Neri','.\GiuseppinaNeri.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Marco','Ricci','.\MarcoRicci.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Francesca','Fabbri','.\FrancescaFabbri');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Santino','De rosa','.\SantinoDeRosa,png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Francesco','Casadei','.\FrancescoCasadei.png'); 

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Franco','Poggi','.\FrancoPoggi.png');

INSERT INTO CONTATTO(Nome,Cognome,Foto)
VALUES('Carlo','Bosio','.\CarloBosio.png');

--inserimento dati tabella INDIRIZZO 
INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Frosinone','82037','Italia','Telese Terme');
 
INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Corso Trieste','82037','Italia','Telese Terme'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Appia Nuova','00183','Italia','Roma'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('San Gregorio Armeno','80138','Italia','Napoli');

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Toledo','80134','Italia','Napoli'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Aldini','20157','Italia','Milano'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Bertolozzi','20134','Italia','Milano'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Corso Della Republica','47121','Italia','ForlÃƒÂ¬'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Pesaro','65121','Italia','Pescara'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Delle Caserme','65127','Italia','Pescara'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Balbi','16126','Italia','Genova'); 

INSERT INTO INDIRIZZO(Via,Cap,Nazione,Citta)
VALUES('Via Velia','84122','Italia','Salerno'); 

--inserimento dati nella tabella POSSIEDE 
INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('1','1');

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('2','3'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('4','2'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('3','4'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('5','5'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('6','8');  

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('8','7'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('7','6'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('9','9'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('9','10'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('9','13');

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('10','11'); 

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('11','12');

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('12','14');

INSERT INTO POSSIEDE(Cod_Indirizzo,Cod_Contatto) 
VALUES('12','15');

--inserimento dati tabella EMAIL 
INSERT INTO EMAIL (  Indirizzo, Dominio, Cod_Contatto )
VALUES ('michelerossi', '@hotmail.com', 1 );

INSERT INTO EMAIL (  Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'michelerossibusiness', '@gmail.com', 1 );

INSERT INTO EMAIL (  Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'antoniopascale', '@libero.it', 2 );

INSERT INTO EMAIL (  Indirizzo, Dominio, Cod_Contatto )
VALUES ('mirko02', '@gmail.com', 3 );	

INSERT INTO EMAIL (  Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'antonio_f', '@hotmail.it', 4 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'rivaerika', '@gmail.com', 5 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ('rivaerikabusiness', '@gmail.com', 5 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ('antobianchi04', '@hotmail.it', 6 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'zunisqualo', '@icloud.com', 7 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ( 'marikasala', '@gmail.com', 8 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ('marco16', '@gmail.com', 10 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ('santinobighignas', '@icloud.com', 12 );

INSERT INTO EMAIL ( Indirizzo, Dominio, Cod_Contatto )
VALUES ('casadeifrancesco', '@hotmail.it', 13 );
INSERT INTO EMAIL (Indirizzo, Dominio, Cod_Contatto )
VALUES ('poggifranco', '@gmail.com', 14 );

INSERT INTO EMAIL (Indirizzo, Dominio, Cod_Contatto )
VALUES ('poggifrancobusiness', '@gmail.com', 14 );

INSERT INTO EMAIL (Indirizzo, Dominio, Cod_Contatto )
VALUES ('poggifrancogaming', '@gmail.com', 14 );

--inserimento dati tabella FORNITORE
INSERT INTO FORNITORE(Nome,Categoria,Casa_Produttrice) 
VALUES('WHATSAPP','Messagging','Meta');

INSERT INTO FORNITORE(Nome,Categoria,Casa_Produttrice) 
VALUES('TELEGRAM','Messagging','Telegram LLC');

INSERT INTO FORNITORE(Nome,Categoria,Casa_Produttrice) 
VALUES('TEAMS','Workplace','Microsoft Corporation'); 

INSERT INTO FORNITORE(Nome,Categoria,Casa_Produttrice) 
VALUES('INSTAGRAM','Social Network','Meta');

INSERT INTO FORNITORE(Nome,Categoria,Casa_Produttrice) 
VALUES('MESSENGER','Messagging','Meta');

--inserimento dati tabella ACCOUNT 
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'michele_rossi', 'Solo nel dizionario SUCCESSO viene prima di SUDORE' , 'Michele', 'Rossi', 'WHATSAPP', 1);
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'rossi_michele', 'Michele Rossi - Studio: Via Frosinone, Telese Terme' , 'Michele', 'Rossi', 'TEAMS', 1);

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antopasc', 'Antonio Pascale - 27 anni - Terzino San Gregorio', 'Antonio', 'Pascale', 'TELEGRAM', 3 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antonio_pascale', 'Football player presso FC San Gregorio.', 'Antonio', 'Pascale', 'WHATSAPP', 3 );
	
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antoniof_90', 'Roma, 32 yo.', 'Antonio', 'Ferrari', 'INSTAGRAM', 5);
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antonio_ferrari_1990', 0 , 'Antonio', 'Ferrari', 'MESSENGER', 5);
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antonio_ferrari', 'Preoccupati piÃƒÂ¹ della tua coscienza che della tua reputazione. - Charlie Chaplin', 'Antonio', 'Ferrari', 'WHATSAPP', 5);

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'erika_riva', 'Napoli, Consulente finanziaria', 'Erika', 'Riva', 'INSTAGRAM', 6 );	

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'antobianchi64', 'CiÃƒÂ² che non ti uccide ti fortifica', 'Antonio', 'Bianchi', 'MESSENGER', 8 );

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'pasquale_zuni_', 'Commercialista Zuni.', 'Pasquale', 'Zuni', 'TELEGRAM', 9 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'zuni_pasquale', 'Per consulenze email: zunisqualo@icloud.com', 'Pasquale', 'Zuni', 'TEAMS', 9 );	

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'marika_sala86', 0, 'Marika', 'Sala', 'MESSENGER', 10 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'marika_sala', 'Disponibile', 'Marika', 'Sala', 'WHATSAPP', 10 );

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'francy_fabbri', 'La donna ÃƒÂ¨ un miracolo di divina contraddizione. - Jules Michelet', 'Francesca', 'Fabbri', 'WHATSAPP', 11 );
	
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'santino_de_rosa_88', 'I soldi fanno gli uomini onesti.', 'Santino', 'De Rosa', 'WHATSAPP', 12 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'santy_dr', 'Genova, imprenditore, 34 yo.', 'Santino', 'De Rosa', 'INSTAGRAM', 12 );

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'francesco_casadei', 'Sei tutti i limiti che superi - Negramaro.', 'Francesco', 'Casadei', 'WHATSAPP', 13 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'francy_csd92', 'Pescara, 1992', 'Francesco', 'Casadei', 'INSTAGRAM', 13 );

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'franco_poggi', 'Qui Franco Poggi, rispondo appena posso.', 'Franco', 'Poggi', 'WHATSAPP', 14 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'franco_poggi84', 'Salerno, 1984', 'Franco', 'Poggi', 'INSTAGRAM', 14 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'franco_poggi_work', 'Franco Poggi, docente di Diritto', 'Franco', 'Poggi', 'TEAMS', 14 );

INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'carlo_bosio', 'Sto dormendo', 'Carlo', 'Bosio', 'WHATSAPP', 15 );
INSERT INTO ACCOUNT ( Nickname, Frase_Benvenuto, Nome, Cognome, Nome_Fornitore, Cod_Email )
	VALUES ( 'carlo_bosio_tg', 'Solo comunicazioni importanti', 'Carlo', 'Bosio', 'TELEGRAM', 15 );

--inserimento dati tabella TELEFONO_FISSO 
INSERT INTO TELEFONO_FISSO (Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 0824, 579422, 1);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 081, 6210315, 2);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ( '+39', 0824, 835679, 3);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 06, 58315227, 4);
INSERT INTO TELEFONO_FISSO (  Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 081, 6895233, 5);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 02, 77643218, 6);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ( '+39', 0543, 542876, 7);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 02, 54938872, 8);
INSERT INTO TELEFONO_FISSO (Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 085, 6798243, 9);
INSERT INTO TELEFONO_FISSO (Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 085, 3162758, 9);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 085, 7882670, 10);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 085, 6681713, 11);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 010, 5461879, 12);
INSERT INTO TELEFONO_FISSO (  Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 085, 777615, 13);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 089, 6315478, 14);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 089, 7080911, 15);
INSERT INTO TELEFONO_FISSO ( Prefisso_Naz, Prefisso_C, Numero, Cod_Contatto )
	VALUES ('+39', 089, 5914328, 15);

--inserimento dati tabella TELEFONO_MOBILE 
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3770525402', 1);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3548276980', 2);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3236694528', 2);
INSERT INTO TELEFONO_MOBILE (  Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3815109871', 3);
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3206090480', 4);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3296871941', 5);
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ( '+39', '3935436793', 5);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3297781997', 6);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3491154692', 6);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3810071942', 7);
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3294470813', 8);
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3993482560', 8);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3206620301', 9);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3402047510', 10);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3775499618', 11);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3294638770', 12);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3776142321', 13);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3201947163', 13);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3201117690', 14);
INSERT INTO TELEFONO_MOBILE (Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ( '+39', '3849266144', 14);
INSERT INTO TELEFONO_MOBILE ( Prefisso_Naz, Numero, Cod_Contatto )
	VALUES ('+39', '3206677819', 15);

--inserimento dati tabella REINDIRIZZAMENTO 
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (1,1);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (2,3);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (3,4);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (4,5);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (5,7);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (6,8);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (7,10);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (8,11);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (9,13);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (10,13);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (11,14);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (12,15);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (13,16);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (14,18);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (15,19);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (16,21);
INSERT INTO REINDIRIZZAMENTO ( CodN_Fisso, CodN_Mobile)
	VALUES (17,21);


--inserimento dati tabella GRUPPO 
INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Calcetto','Persone che partecipano al calcetto','SPORT'); 

INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Tennis','Contatti per una partita a tennis','SPORT'); 

INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Azienda','Persone che lavorano in azienda','LAVORO');  

INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Lavoro','Contatti di lavoro','LAVORO'); 

INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Amici','Contiene tutti i contatti amici','Amici'); 

INSERT INTO GRUPPO(Nome,Descrizione,Categoria) 
 VALUES('Famiglia','Contatti della famiglia','FAMIGLIA');  

--inserimento dati tabella AFFERENZA 
INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(2,'Amici');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(4,'Amici');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(5,'Amici');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(7,'Amici');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(12,'Amici');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(1,'Azienda');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(3,'Azienda'); 

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(7,'Azienda');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(15,'Azienda');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(2,'Calcetto');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(4,'Calcetto');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(12,'Calcetto');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(15,'Calcetto'); 

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(9,'Famiglia');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(10,'Famiglia');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(13,'Famiglia');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(6,'Lavoro');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(8,'Lavoro');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(14,'Lavoro');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(3,'Tennis');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(6,'Tennis');

INSERT INTO AFFERENZA(Cod_Contatto,Nome_Gruppo)
 VALUES(8,'Tennis');










