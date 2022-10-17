%macro StoreRuntimeInformation(Table=);
	%IF NOT %SYMEXIST(JOB_NAME) %THEN %DO;
		%PUT WARNING: The macro variable JOB_NAME does not exist. Initializing the variable and giving it a default value.;
		%LET JOB_NAME = Unknown JOB;
	%END;

	%IF NOT %SYMEXIST(TARGET_TABLE) %THEN %DO;
		%PUT WARNING: The macro variable TARGET_TABLE does not exist. Initializing the variable and giving it a default value.;
		%LET TARGET_TABLE = Unknown table;
	%END;

	%IF NOT %SYMEXIST(START_DTTM) %THEN %DO;
		%PUT WARNING: The macro variable START_DTTM does not exist. Initializing the variable and giving it a default value.;
		%LET START_DTTM = %SYSFUNC(DATETIME(), DATETIME.);
	%END;

	%LET END_DTTM = %SYSFUNC(DATETIME(), DATETIME.);
	
	%LET returncode=0;
 	%macro SetReturnCode;
		%if &SYSERR NE 0 %THEN %DO;
			%let returncode = &SYSERR;
		%end;
		%if &SYSRC NE 0 %THEN %DO;
			%let returncode = &SYSRC;
		%end;
		%if &SYSCC NE 0 %THEN %DO;
			%let returncode = &SYSCC;
		%end;
	%mend;	
	%SetReturnCode;

	DATA WORK.JOB_STATUS;
		ATTRIB USER_ID LENGTH = $32;
		ATTRIB TARGET_TABLE LENGTH = $32;
		ATTRIB JOB_NAME LENGTH = $80;
		ATTRIB JOB_RC LENGTH = 8.;
		ATTRIB ROWS_AFFECTED LENGTH = 8.;
		ATTRIB START_DTTM LENGTH = 8. FORMAT=DATETIME20.;
		ATTRIB END_DTTM LENGTH=8. FORMAT=DATETIME20.;
	
		USER_ID = "&SYSUSERID";
		TARGET_TABLE = "&TARGET_TABLE";
		JOB_NAME = "&JOB_NAME";
		JOB_RC = &returncode;
		ROWS_AFFECTED = &SQLOBS;
		START_DTTM = "&START_DTTM"dt;
		END_DTTM = "&END_DTTM"dt;
	RUN;

	PROC SQL;
		INSERT INTO &Table
		(
			USER_ID,
			TARGET_TABLE,
			JOB_NAME,
			JOB_RC,
			ROWS_AFFECTED,
			START_DTTM,
			END_DTTM
		) 
		SELECT
			USER_ID,
			TARGET_TABLE,
			JOB_NAME,
			JOB_RC,
			ROWS_AFFECTED,
			START_DTTM,
			END_DTTM
		FROM
			WORK.JOB_STATUS;
	QUIT;

	%SYMDEL JOB_NAME TARGET_TABLE START_DTTM END_DTTM /nowarn;
%mend;

%StoreRuntimeInformation
	(
		Table=&output_table
	);