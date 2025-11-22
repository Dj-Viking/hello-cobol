      $set sourceformat(free)
           IDENTIFICATION DIVISION.
           PROGRAM-ID. table.
           ENVIRONMENT DIVISION.
           DATA DIVISION.
               WORKING-STORAGE SECTION.
               01 ws-index                 pic 9(5)    value 0.
               01 ws-len                   pic s9(5)   value 0.
               01  states-table.
                   05  filler              pic s9(5)   value 00001.
                   05  filler              pic x(7)    value "00000,0002".
                   05  filler              pic s9(5)   value 00001.
                   05  filler              pic x(7)    value "00001,0003".
               01  rdf-states-table redefines states-table.
                   05  state-group  occurs 5 times.
                       10  state-code      pic s9(5).
                       10  state-name      pic x(7).
           PROCEDURE DIVISION.
      *> cobol-lint CL002 main-program
           main-program.
               perform proc
               stop run.
           proc.
               compute state-code(1) = state-code(1) + 1
               move "blah" to state-name(1)

      *>         kind of a weird way to check how many fields are currently
      *>         on the table
               perform varying ws-index 
               from 1 by 1 
               until ws-index = 5
                   if state-name(ws-index) is not zeros
                       compute ws-len = ws-len + 1;
                   end-if
               end-perform

               display "the length: " ws-len
               display "============="
      *>         display "len: " function length(states-table)
      *>         display "name: [" state-name(1)"],["state-code(1) "]"
      *>         display state-code(1)

               perform varying ws-index 
               from 1 by 1 
               until ws-index = ws-len
                   if ws-index = 1
                       compute state-code(ws-index) = 
                           state-code(ws-index) + 1
                   end-if
                   display "=========="
                   display "name: " state-name(ws-index)
                   display "code: " state-code(ws-index)
                   display "=========="
               end-perform
*> 
      *>         end-perform
           .
      *>         perform varying ws-index
      *>             from 1 by 1
      *>             until ws-index = function length(states-table) 
*> 
      *>                 display "blah"
      *>                 display 'state-code(1) : ' state-code(ws-index).
      *>                 display 'state-name(1) : ' state-name(ws-index).

