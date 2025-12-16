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
           01  InputRecord       pic x(200).

           WORKING-STORAGE SECTION.
           01  FileStatus        pic XX.
           01  ws-delim          pic X      value ",".
           01  ws-len            PIC 9(4)   value 0.
           01  ws-start          pic 9(4)   value 1.
           01  ws-index          pic S9(5)  value 0.
           01  ws-count          pic 9(5)   value 0.
           01  ws-char           pic X      value space.
           01  ws-str-len        pic 9(4)   value 0.
           01  ws-table.
               05 ws-item occurs 50 times.
                  10 ws-text     pic X(40).
           PROCEDURE DIVISION.
      *> cobol-lint CL002 main-proc
           main-proc.
               perform init-file
               perform allocate-table
               perform read-chars
               perform close-file
               stop run
           .


           allocate-table.
               move function length(function trim (InputRecord)) 
               to ws-len

               move 1 
               to ws-start

               move 0 
               to ws-count
               
               perform varying ws-index from 1 by 1 until ws-index > ws-len
                   move inputrecord(ws-index:1) 
                   to ws-char
                   if ws-char = ws-delim
                       add 1 to ws-count
                       compute ws-str-len = ws-index - ws-start
                       if ws-str-len > 0
                           move spaces 
                               to ws-text(ws-count)
                           move inputrecord(ws-start:ws-str-len)
                               to ws-text(ws-count)
                       end-if
                       compute ws-start = ws-index + 1
                   else
                       if ws-index = ws-len
                           add 1 to ws-count
                           compute ws-str-len = ws-index - ws-start + 1
                           move spaces 
                               to ws-text(ws-count)
                           move inputrecord(ws-start:ws-str-len)
                               to ws-text(ws-count)
                       end-if
                   end-if
               end-perform
           .

           init-file.
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

           read-chars.

               display "forward loop: "
               perform varying ws-index from 1 by 1 until ws-index > ws-count
                   display "item " ws-index ": " ws-text(ws-index)
               end-perform

      *>     note:  reverse loop
               display "reverse loop"
               perform varying ws-index from ws-count by -1 until ws-index = 0
                   display "test " ws-index ": " ws-text(ws-index)
               end-perform
           .

           close-file.
               close InputFile
      *>     DISPLAY "Done reading file."
           .

