      $set sourceformat(free)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. readfile.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputFile 
      *> this is running in dist folder in this project so 
      *> need to use relative path to the file one level up from dist
               ASSIGN TO "../example.txt",
               ORGANIZATION IS LINE SEQUENTIAL,
               file status is FileStatus.

       DATA DIVISION.
       FILE SECTION.
      *> The FD must be defined and not prematurely ended with a period
       FD  InputFile                               
      *> File description entry a x amount of characters file with null terminating character I'm assuming
           record contains 4 characters.
      *> Record layout for the file
       01  InputLine         PIC X(5).

       WORKING-STORAGE SECTION.
      *> End-of-file flag
       01  EOF-FLAG          PIC X VALUE "N".
       01  FileStatus        pic XX.

       PROCEDURE DIVISION.
      *> cobol-lint CL002 main-program
       MAIN-PROGRAM.
           PERFORM INIT-FILE
           PERFORM READ-FILE-LOOP
           PERFORM CLOSE-FILE
           STOP RUN.

       INIT-FILE.
           OPEN INPUT InputFile
           if FileStatus not = "00"
               display "error opening file. status=" FileStatus
               stop run
           end-if
      *>     DISPLAY "Opening file example.txt"
           .

       READ-FILE-LOOP.
           PERFORM UNTIL EOF-FLAG = "Y"
               READ InputFile
                   AT END
                       MOVE "Y" TO EOF-FLAG
                   NOT AT END
                       DISPLAY InputLine
               END-READ
           END-PERFORM
           .

       CLOSE-FILE.
           CLOSE InputFile
      *>     DISPLAY "Done reading file."
           .
