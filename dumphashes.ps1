cd dumps
..\esedbtool\esedbexport.exe -m tables ntds.dit

..\dsusers\dsusers.exe ntds.dit.export\datatable.4 ntds.dit.export\link_table.7 hashwork --syshive SYS --passwordhashes --lmoutfile lm-out.txt --ntoutfile nt-out.txt --pwdformat ophc