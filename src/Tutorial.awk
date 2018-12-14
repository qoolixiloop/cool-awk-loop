#!/usr/bin/awk -f

# AWK Tutorial Script
# =============================================================================
# Called with: ./scriptname.awk arg1='hi from Shell' arg2 inputfile.txt
# Interpreter/shebang: #!/usr/bin/awk -f
# -----------------------------------------------------------------------------
# Author: Roland Benz
# Date: 13. Dec. 2018
# -----------------------------------------------------------------------------
# Content:
# I) begin of USER DEFINED FUNCTION block
#   I.1) User defined function `myfunc()`
# II) begin of BEGIN block
#   II.1) Print some header message 
#   II.2) Call an external command without control over output
#   II.3) Call an external command with control over output
#   II.4) Print the command line arguments `-v arg=`
#   II.5) Print the command line arguments `arg`
#   II.6) Make a calculation
#   II.7) Make another caluculation
#   II.8) Make a substring with `substr`
#   II.9) Split a string into an associative array
#   II.10) Check if Regex does match a string or vice versa
#   II.11) Make an associative array
#   II.12) Print if key is in associative array
#   II.13) Make a multi dimensional array 
#   II.14) Call user defined function `myfunc()` 
#   II.15) Print `key: value` pair
#   II.16) Sort an array's values `asort`
#   II.17) Sort array's keys with `asorti`
#   II.18) Print awk's internal variables
#   II.19) Print file with shell command `cat`
#   II.20) Print file with `getline`
#   II.21) Add file to process and print it
#   II.22) Read whole file, substitute lines, and print to another file with `>>` 
#   II.23) Counter variable to see what happens in READ FILE block 
# III) begin of READ FILE block 1
#   III.1) Own counter to count loops, loops go over all READ FILE blocks
#   III.2) Skip line X in each read input file
#   III.3) Skip a line X, all files are seen as only one big file
#   III.4) Skip input file X
#   III.5) Print awk's internal variables
#   III.6) Apply a filter with `if` (put the regex on right hand side)
#   III.7) Sum up field X
#   III.8) Get a string and make a substitution on the string with `gsub`
#   III.9) Get a string and make a substitution on the string with `gensub`
#   III.10) Make a change to a line and write to another file with `>>`
#   III.11) Print file with `cat`
# IV) begin of READ FILE block 2
#   IV.1) Infos to show, that same loop, same variable values from prev. block
#   IV.2) Build a memory of previous fields by filling associative array
#   IV.3) Build a memory of previous lines by assigning to variables
# V) begin of END block
#   V.1) Print associative array from FILE block 2 
#   V.2) Print some footer message
# -----------------------------------------------------------------------------


# I) begin of USER DEFINEND FUNCTION block
# I.1) User defined function
function myfunc(g_1, g_2,    l_1, l_2){  #global-args <spaces> local-args
  print "-----I.1-------\n"
  printf("g_1=%s, g_2=%s, l_1=%s, l_2=%s", g_1, g_2, l_1,l_2)
  return 1234
}
# I) end of USER DEFINEND FUNCTION block



# II) begin of BEGIN block
BEGIN{
  
  # II.1) Print some header message 
  print "=====II.1==========================================================\n"
  print "start the awk script\n"
  print "===================================================================\n"
  
  # II.2) Call an external command without control over output
  print "\n-----II.2-------"                
  system("date");                       # `system("shell command")`
  
  # II.3) Call an external command with control over output
  print "\n-----II.3-------"
  cmd="date"                            # variable assignment
  cmd | getline out                     # `cmd |` calls cmd as a shell command
  printf("date=%s\n", out)              # `getline out` assigns to variable out

  # II.4) Print the command line arguments `-v arg=`
  print "\n-----II.4-------"
  printf("arg1=%s\n", arg1)         

  # II.5) Print the command line arguments `arg`
  print "\n-----II.5-------"
  printf("ARGC=%d\n", ARGC)
  for (i = 0; i < ARGC; i++){
    printf "\tARGV[%d] = %s\n", i, ARGV[i]
  }
  
  # II.6) Make a calculation
  print "\n-----II.6-------"
  res = ((2*2+8)/4)^(4-1)                   # `^` to the power of
  mod = res%7                               # `%` modulo
  printf("res=%f, mod=%f\n", res, mod)
  
  # II.7) Make another caluculation
  print "\n-----II.7-------"
  pi=3.14159265359                           # variable assignment
  res = sin(pi/4)                            # sinus
  printf("res=%f\n", res)

  # II.8) Make a substring with `substr`
  print "\n-----II.8-------"
  string="this is a string to cut..."
  substring=substr(string,18,6)              #substr(string, from, length)
  printf("substring=%s\n",substring)

  # II.9) Split a string into an associative array
  print "\n-----II.9-------"
  string="this;   is;;  a;string;;  to;;;; split"
  regex=";+[ ]*"                             # regex as delimiter
  split(string, dict, regex, seps)           # splits string into assoc. array
  for (key in dict){                         # iterate through assoc. array keys
    printf("key=%s\nvalue=%s\n", key, dict[key]) #same as Python dict / Java hash map
  }

  # II.10) Check if Regex does match a string or vice versa
  print "\n-----II.10-------"
  string="This is a test string: trying to match a regex"
  regex="test.*:"
  printf("string=%s\nregex=%s\n", string, regex)
  match(string, regex)                  # tests regex on string 
  print "string matched at position: "  # overwrite awk's internal vars
  printf("RSTART=%s\n", RSTART)         # RSTART: match from (no match 0)
  printf("RLENTH=%s\n", RLENGTH)        # RLENGTH: match length (no match -1)
  
  # II.11) Make an associative array
  print "\n-----II.11-------"
  dict["name"]="King Kong"
  dict["size"]=19.76
  printf("name=%s, size=%d\n", dict["name"], dict["size"])

  # II.12) Print if key is in associative array
  print "\n-----II.12-------"
  key="size"
  if (key in dict){                          # checks if key exists
    printf("size=%d\n", dict[key])
  }
  
  # II.13) Make a multi-dimensional array
  print "\n-----II.13-------"
  mat[1][1]=99                       #indexed with separator \034 as 1\0341
  printf("mat_1_1=%d\n", mat[1][1]) 

  # II.14) Call user defined function `myfunc()`
  print "\n-----II.14-------"
  out=myfunc("hi","there","my","func")      
  printf("\nout=%d\n",out)

  # II.15) Print `key: value` pair
  print "\n-----II.15-------"
  arr_source[4]="ra"             
  arr_source[1]="bu"
  arr_source[2]="ko"
  arr_source["hi"]="ni"
  arr_source["ho"]="43"
  arr_source["ha"]="..."
  for (key in arr_source){
    printf("arr_source:: %s : %s\n", key, arr_source[key])
  }

  # II.16) Sort an array's values with `asort`
  print "\n-----II.16-------"
  asort(arr_source, arr_dest)        # reads arr_source and sorts into arr_dest
  for (key in arr_dest){
    printf("arr_dest:: %s : %s\n", key, arr_dest[key])
  }

  # II.17) Sort array's key with `asorti`
  print "\n-----II.17-------"
  asorti(arr_source,arr_dest)        # reads arr_source and sorts into arr_dest
  for (key in arr_dest){
    printf("array_index_i=%s\n", arr_dest[key])
  }
  
  # II.18) Print awk's internal variables
  print "\n-----II.18-------"
  printf("FILENAME=%s\n", FILENAME)         # current file read
  printf("ARGV[ARGC-1]=%s\n", ARGV[ARGC-1]) # contains all files to be read
  printf("ARGC=%s\n", ARGC)                 # size of ARGV
  printf("ARGIND=%s\n", ARGIND)             # iterator of ARGV
  printf("FNR=%s\n", FNR)                   # line number of file
  printf("FS=%s\n", FS)                     # field separator
  printf("NF=%s\n", NF)                     # number of fields in current line
  printf("NR=%s\n", NR)                     # line number over all files
  printf("OFS=%s\n", OFS)                   # output field separator
  printf("ORS=%s\n", ORS)                   # output record separator
  printf("RS=%s\n", RS)                     # input record separator
  printf("RT=%s\n", RT)                     # record terminator
  printf("RSTART=%s\n", RSTART)             # written by match()
  printf("RLENTH=%s\n", RLENGTH)            # written by match()
  printf("SUBSEP=%s\n", SUBSEP)             # array index separator `\034`
  printf("SYMTAB[\"out\"]=%s\n", SYMTAB["out"]) # all global variables
  printf("FUNCTAB[1]=%s\n", FUNCTAB[1])         # all user defined functions
  printf("PROCINFO[\"pid\"]=%s\n", PROCINFO["pid"])   # process id
  printf("PROCINFO[\"ppid\"]=%s\n", PROCINFO["ppid"]) # process parent id
  printf("PROCINFO[\"strftime\"]=%s\n", PROCINFO["strftime"]) # time format
  printf("PROCINFO[\"FS\"]=%s\n", PROCINFO["FS"])             # field separator

  # II.19) Print file with shell command `cat`
  print "\n-----II.19-------"
  file = "./file_in_1.txt"
  print "file: " file
  system("cat " file)

  # II.20) Print file with `getline`
  print "\n-----II.20-------"
  while ((getline<file) > 0) {      # boilerplate code to read lines from file
    print;                          # per default `print` prints line
  } 
  close(file)                       # always close file to be able to read again
  
  # II.21) Add file to `ARGV` to process and print it
  print "\n-----II.21-------"
  file_new = "file_in_2.txt"        # assign new file to read
  print "file: " file_new
  {ARGV[ARGC] = file_new ; ARGC++}  # add new file to awk's internal variable 
  while ((getline<file_new) > 0) {print}
  close(file)                       #always close to be able to read again
  
  # II.22) Read whole file, substitute lines, and print to another file with `>>`
  print "\n-----II.22-------"
  file_in = "./file_in_1.txt"                # assign file to read from
  file_out = "./file_out_1.txt"              # assign file to write to
  while ((getline line < file_in) > 0) {     # read line from file
   regex="l.{3}4"                            # regex to be applied
   replacement="repl"                        # matched part to be replace with
   target_string=line                        # string to be substituted
   gsub(regex, replacement, target_string)   # substitution of matched part
   printf "print: " target_string "\nto file: " file_out "\n"
   printf ("%s\n",target_string) >> file_out # boilerplate code to append
  }
  
  # II.23) Counter variable to see what happens in READ FILE block 
  print "\n-----II.23-------"
  counterx = "x"               # string variable
  counter = "100"              # integer variable
  print counterx "\n" counter
}
# II) end of BEGIN block


# III) begin of READ FILE block 1
{
  # III.1) Own counter to count loops, loops go over all READ FILE blocks
  print "\n---III.1-------------------------------------------------------"
  counterx=counterx+1           # new variable starts with 1
  counter=counter+1             # old variable goes on with 101
  printf("counterx=%d\n", counterx)
  printf("counter=%d\n", counter)
  printf("line=%s\n", $0)
  print "-----III.1-------------------------------------------------------\n"

  # III.2) Skip line X in each read input file
  print "\n-----III.2-------"
  print "skip line if FNR is 1; FNR= " FNR
  if (FNR == 1){print ">>>>>>>>>>skipped FNR==1" ;next}

  # III.3) Skip a line X, all files are seen as only one big file
  print "\n-----III.3-------"
  print "skip line if NR is 6; NR= " NR
  if (NR == 6){print ">>>>>>>>>>>skipped NR==6" ;next}
  
  # III.4) Skip input file X
  print "\n-----III.4-------"
  print "skip file if FNR is 4 in ARGV[2]; FNR= " FNR
  print "ARGV[ARGIND]= " ARGV[ARGIND]
  print "ARGV[2]= " ARGV[2]
  if ( (FNR == 4) && (ARGV[2] == FILENAME) ) {
    print ">>>>>>>>>>>>>skipped FILE 2 after FNR==3" ;nextfile
  }
  
  # III.5) Print awk's internal variables
  print "\n-----III.5-------"
  printf("FILENAME=%s\n", FILENAME)         # current file read
  printf("ARGV[ARGC-1]=%s\n", ARGV[ARGC-1]) # contains all files to be read
  printf("ARGC=%s\n", ARGC)                 # size of ARGV
  printf("ARGIND=%s\n", ARGIND)             # iterator of ARGV
  printf("FNR=%s\n", FNR)                   # line number of file
  printf("FS=%s\n", FS)                     # field separator
  printf("NF=%s\n", NF)                     # number of fields in current line
  printf("NR=%s\n", NR)                     # line number over all files
  printf("OFS=%s\n", OFS)                   # output field separator
  printf("ORS=%s\n", ORS)                   # output record separator
  printf("RS=%s\n", RS)                     # input record separator
  printf("RT=%s\n", RT)                     # record terminator
  printf("RSTART=%s\n", RSTART)             # written by match()
  printf("RLENTH=%s\n", RLENGTH)            # written by match()
  printf("SUBSEP=%s\n", SUBSEP)             # array index separator `\034`
  printf("SYMTAB[\"out\"]=%s\n", SYMTAB["out"]) # all global variables
  printf("FUNCTAB[1]=%s\n", FUNCTAB[1])         # all user defined functions
  printf("PROCINFO[\"pid\"]=%s\n", PROCINFO["pid"])   # process id
  printf("PROCINFO[\"ppid\"]=%s\n", PROCINFO["ppid"]) # process parent id
  printf("PROCINFO[\"strftime\"]=%s\n", PROCINFO["strftime"]) # time format
  printf("PROCINFO[\"FS\"]=%s\n", PROCINFO["FS"])             # field separator
  
  # III.6) Apply a filter with `if` (put the regex on right hand side)
  print "\n-----III.6-------"
  printf ("prev_line_2=%s\n", prev_line_2)
  if(prev_line_2 !~ /l...2/ ) {              # `!~` if no match, `~` if match 
    printf("$0=%s\nP1=%s\nP2=%s\nP3=%s\n", $0, prev_line_1, prev_line_2, prev_line_3)
  } 
  
  # III.7) Sum up field X
  print "\n-----III.7-------"
  sum_col_4 += $4
  printf("sum_col_4=%d\n", sum_col_4)

  # III.8) Get a string and make a substitution on the string with `gsub`
  print "\n-----III.8-------"
  regex="l.{3}2"
  replacement="repl"
  target_string=$0
  gsub(regex, replacement, target_string)                 # target_string written
  print "$0: " $0
  printf("target_string=%s\n", target_string)

  # III.9) Get a string and make a substitution on the string with `gensub`
  print "\n-----III.9-------"
  regex="l.{3}2"                   # `.{3}` three arbitrary symbols
  replacement="repl"
  option="g"                       # replace global, i.e. all matches in string
  target_string=$0
  result = gensub(regex, replacement, option, target_string) # target_string read
  print "$0: " $0
  printf("target_string=%s\nresult=%s\n", target_string, result)

  # III.10) Make a change to a line and write to another file with `>>`
  print "\n-----III.10-------"
  file_out= "./out_1_"FILENAME                     # assign file to write to
  printf ("write %s to %s \n", result, file_out)
  printf ("%s\n",result) >> file_out               # append line to file

  # III.11) Print file with `cat`
  print "\n-----III.11-------"
  file = "./file_in_1.txt"                         # assign file to read from 
  print "file: " file
  system("cat " file)                              # `cat` shell command
  
}
# end of READ FILE block 1


# IV) begin of READ FILE block 2
{ 
  #IV.1) Infos to show, that same loop, same variable values from prev. block
  print "\n-----IV.1-------"
  printf("NR=%s\n", NR)                 
  printf("counter=%d\n", counter)       
  
  # IV.2) Build a memory of previous fields by filling associative array
  print "\n-----IV.2-------"
  { lines[$2]+=$4  }     # field 2 as key, field 4 as value
  { for (line in lines) print line, lines[line] }
  
  # IV.3) Build a memory of previous lines by assigning to variables
  print "\n-----IV.3-------"
  prev_line_3 = prev_line_2
  prev_line_2 = prev_line_1
  prev_line_1 = $0 
  printf("$0=%s\nP1=%s\nP2=%s\nP3=%s\n", $0, prev_line_1, prev_line_2, prev_line_3)

}
# IV) end of READ FILE block 2


# V) begin of END block
END{
 
  # V.1) Print associative array from FILE block 2 
  print "\n-----V.1-------"
  { for (line in lines) print line, lines[line] }
  
  # V.2) Print some footer message
  print "\n-----V.2-------"
  print "end script" 

}
# V)end of END block

