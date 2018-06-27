Different header and footer for RTF document and for table

see
https://tinyurl.com/yb9ee36q
https://github.com/rogerjdeangelis/utl_different_header_and_footer_for_rtf_document_and_for_table

see
https://tinyurl.com/y8lf4evm
https://github.com/rogerjdeangelis/utl_proc_report_different_titles_headers_footnotes_and_number_of_obs_per_page


Problem print 35 lines per page with the title appearing only on the first page


INPUT
=====

 SASHELP.IRIS total obs=150

   SPECIES    SEPALLENGTH    SEPALWIDTH    PETALLENGTH    PETALWIDTH

   Setosa          50            33             14             2
   Setosa          46            34             14             3
   Setosa          46            36             10             2
   Setosa          51            33             17             5
   Setosa          55            35             13             2
   Setosa          48            31             16             2
   Setosa          52            34             14             2
   Setosa          49            36             14             1



PROCESS
=======

data _null_;

  retain page 1 title "Table No Table#description#Population";

  set sashelp.iris(obs=69);
  if mod(_n_,35)=0 then page=page+1;

  call symputx("page",page);

  if page>1 then title=" ";
  call symputx("title",title);

  if page ne lag(page) then do;

     rc=dosubl('
       proc report data=sashelp.iris(firstobs=%eval((&page-1)*35+1) obs=%eval(&page*35))
            nowd missing split="#";
          cols ("&title." _all_);
       run;quit;
     ');

  end;

run;quit;


OUTPUT
======

FIRST PAGE

                    Table No Table
                     description
                      Population
                Sepal      Sepal      Petal      Petal
Iris           Length      Width     Length      Width
Species          (mm)       (mm)       (mm)       (mm)
Setosa             50         33         14          2
Setosa             46         34         14          3
Setosa             46         36         10          2
Setosa             51         33         17          5
Setosa             55         35         13          2
Setosa             48         31         16          2
Setosa             52         34         14          2
...


SECOND PAGE

                Sepal      Sepal      Petal      Petal
Iris           Length      Width     Length      Width
Species          (mm)       (mm)       (mm)       (mm)
Setosa             51         34         15          2
Setosa             50         35         13          3
Setosa             49         31         15          1
Setosa             54         37         15          2
Setosa             54         39         13          4
Setosa             51         35         14          3
Setosa             48         34         16          2
Setosa             48         30         14          1

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

Just use sashelp.iris


*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

see process


