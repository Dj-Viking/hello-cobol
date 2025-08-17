	      IDENTIFICATION DIVISION.
	      PROGRAM-ID. math.
	      ENVIRONMENT DIVISION.
	      DATA DIVISION.
	      WORKING-STORAGE SECTION.
          01 WS-VAR.
		     *> single digit (01)
             05 WS-A    PIC 9(01) VALUE 2.
             05 WS-B    PIC 9(01) VALUE 2.
	      PROCEDURE DIVISION.
		     ADD 0 WS-A TO WS-B.
		     DISPLAY "Add result -> " WS-B. *> should display 4
		     STOP RUN.
