### Week 2 Quiz

These are the scripts I wrote to answer the questions for the Week 2 Quiz.
The scripts are in the R/ directory, but should be run from Week2Quiz/
directory.

R/github.R answers question 1 by retrieving the creation time of *jtleek*'s
datasharing repo using the github API.

R/acs_sqldf_q2.R and R/acs_sqldf_q3.R answer questions 2 and 3 respectively.
These questions required that data be loaded into a data.frame and then
queried using the sqldf function.

R/html_nchar_4.R answers question 4 by retrieving 
http://biostat.jhsph.edu/~jleek/contact.html and counting the number
of characters in lines 10, 20, 30, and 100 of the resulting html.

R/fixed_width_5.R answers question 5 by loading in a fixed width format
file and summing the fourth column of the nine columns of data.

