      $set sourceformat(free)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. readfile.
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile 
               ASSIGN TO "../example.txt",
               ORGANIZATION IS LINE SEQUENTIAL,
               file status is FileStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  InputFile
           record contains 12 characters.
       01  InputRecord       PIC X(200).

       WORKING-STORAGE SECTION.
       01  FileStatus        pic XX.
       01  ws-delim          pic X      value ",".
       01  ws-len            PIC 9(4)   value 0.
       01  ws-start          pic 9(4)   value 1.
       01  ws-end            pic 9(4)   value 0.
       01  ws-count          pic 9(4)   value 0.
       01  ws-char           pic X.
       01  ws-field-len      pic 9(4)   value 0.
       01  ws-table.
           05 ws-item occurs 50 times.
              10 ws-text     pic X(40).
       PROCEDURE DIVISION.
      *> cobol-lint CL002 main-program
       MAIN-PROGRAM.
           PERFORM INIT-FILE
           PERFORM READ-CHARS
           PERFORM CLOSE-FILE
           STOP RUN.

       INIT-FILE.
           OPEN INPUT InputFile
           if FileStatus not = "00"
               display "error opening file. status=" FileStatus
               stop run
           end-if
           read InputFile
               at end
                   display "no data in file."
                   close InputFile
                   stop run
      *>     DISPLAY "Opening file example.txt"
           end-read
           .

       READ-CHARS.
           move function length(function trim (InputRecord)) to ws-len
           move 1 to ws-start
           move 0 to ws-count
           
           PERFORM VARYING WS-End FROM 1 BY 1 UNTIL WS-End > WS-Len
               MOVE InputRecord(WS-End:1) TO WS-Char
               IF WS-Char = WS-Delim
                   ADD 1 TO WS-Count
                   COMPUTE WS-Field-Len = WS-End - WS-Start
                   IF WS-Field-Len > 0
                       MOVE SPACES TO WS-Text(WS-Count)
                       MOVE InputRecord(WS-Start:WS-Field-Len)
                           TO WS-Text(WS-Count)
                   END-IF
                   COMPUTE WS-Start = WS-End + 1
               ELSE
                   IF WS-End = WS-Len
                       ADD 1 TO WS-Count
                       COMPUTE WS-Field-Len = WS-End - WS-Start + 1
                       MOVE SPACES TO WS-Text(WS-Count)
                       MOVE InputRecord(WS-Start:WS-Field-Len)
                           TO WS-Text(WS-Count)
                   END-IF
               END-IF
           END-PERFORM

           display "split results:"
           perform varying ws-end from 1 by 1 until ws-end > ws-count
               display "item " ws-end ": " ws-text(ws-end)
           end-perform
           .

       CLOSE-FILE.
           CLOSE InputFile
      *>     DISPLAY "Done reading file."
           .

