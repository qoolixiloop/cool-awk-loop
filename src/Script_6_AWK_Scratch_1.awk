#!/usr/bin/awk -f

# Keep a memory of previous lines 
# Call: ./scriptname.awk arg1='hi from Shell' arg2 inputfile.txt
# Interpreter awk -f
# Author: Roland Benz
# Date: 11. Dec. 2018


function myfunc(g_1, g_2,    l_1, l_2){
  printf("g_1=%s, g_2=%s, l_1=%s, l_2=%s", g_1, g_2, l_1,l_2)
  return 1234
  print "-----13-------\n"
}


# begin of BEGIN block
BEGIN{
  
  # print some startinfo 
  print "===============================================================\n"
  print "start the awk script\n"
  print "===============================================================\n"
  
  # call an external command (no control over output)
  system("date"); echo
  print "-----27-------\n"
  
  # call an external command (with control over output)
  cmd="date"
  cmd | getline out
  printf("date=%s\n", out)
  print "-----33-------\n"

  #print the input arguments `arg=`
  printf("arg1=%s\n", arg1)
  print "-----37-------\n"

  # print the input arguments `arg`
  printf("ARGC=%d\n", ARGC)
  for (i = 0; i < ARGC; i++){
    printf "\tARGV[%d] = %s\n", i, ARGV[i]
  }
  print "-----44-------\n"
  
  # make a calculation
  res = ((2*2+8)/4)^3
  mod = res%7
  printf("res=%f, mod=%f\n", res, mod)
  print "-----50-------\n"
  
  # make another caluculation
  pi=3.14159265359
  res = sin(pi/4)
  printf("res=%f\n", res)
  print "-----56-------\n"

  # make a substring
  string="this is a string to cut..."
  substring=substr(string,18,6)
  printf("substring=%s\n",substring)
  print "-----62-------\n"

  # split a string into an array
  string="this;   is;;  a;string;;  to;;;; split"
  regex=";+[ ]*"
  split(string, dict, regex, seps)
  for (key in dict){
    printf("array_element_i=%s\n", dict[key])
  }
  print "-----71-------\n"

  # check if regex matches string
  string="This is a test string: trying to match a regex"
  regex="test.*:"
  printf("string=%s\nregex=%s\n", string, regex)
  match(string, regex)
  print "string matched at position: "
  printf("RSTART=%s\n", RSTART)
  printf("RLENTH=%s\n", RLENGTH)
  print "-----81-------\n"
  
  # make an associative array (hash table, dict)
  dict["name"]="Roland"
  dict["size"]=183
  printf("name=%s, size=%d\n", dict["name"], dict["size"])
  print "-----87-------\n"

  # print if key is in dict
  key="size"
  if (key in dict){
    printf("size=%d\n", dict[key])
  }
  print "-----94-------\n"
  
  # make a matrix
  mat[1][1]=99
  printf("mat_1_1=%d\n", mat[1][1]) 
  print "-----99-------\n"

  #call user defined function 
  out=myfunc("hi","there","my","func")
  printf("\nout=%d\n",out)
  print "-----104-------\n"

  # print key: value
  arr_source[4]="ra"
  arr_source[1]="bu"
  arr_source[2]="ko"
  arr_source["hi"]="ni"
  arr_source["ho"]="43"
  arr_source["ha"]="..."
  for (key in arr_source){
    printf("arr_source:: %s : %s\n", key, arr_source[key])
  }
  print "-----116-------\n"

  # sort an array's values
  asort(arr_source, arr_dest)
  for (key in arr_dest){
    printf("arr_dest:: %s : %s\n", key, arr_dest[key])
  }
  print "-----123-------\n"

  #sort array's key
  asorti(arr_source,arr_dest)
  for (key in arr_dest){
    printf("array_index_i=%s\n", arr_dest[key])
  }
  print "-----130-------\n"
  
  #print system variables
  printf("FILENAME=%s\n", FILENAME)
  printf("ARGV[ARGC-1]=%s\n", ARGV[ARGC-1])
  printf("ARGC=%s\n", ARGC)
  printf("FNR=%s\n", FNR)
  printf("FS=%s\n", FS)
  printf("NF=%s\n", NF)
  printf("NR=%s\n", NR)
  printf("OFS=%s\n", OFS)
  printf("ORS=%s\n", ORS)
  printf("RS=%s\n", RS)
  printf("RT=%s\n", RT)
  printf("RSTART=%s\n", RSTART)
  printf("RLENTH=%s\n", RLENGTH)
  printf("SUBSEP=%s\n", SUBSEP)
  printf("SYMTAB=%s\n", SYMTAB[0])
  printf("PROCINFO=%s\n", PROCINFO[0])
  print "-----149-------\n"

  # print file
  file = "./file_in_1.txt"
  print "file: " file
  system("cat " file)
  print "-----155-------\n"
  while ((getline<file) > 0) {print;}
  close(file) #always close to be able to read again
  print "-----158-------\n"
  
  # add file to process and print it
  file_new = "file_in_2.txt"
  print "file: " file_new
  {ARGV[ARGC] = file_new ; ARGC++}
  while ((getline<file_new) > 0) {print}
  close(file) #always close to be able to read again
  print "-----166-------\n"
  
  # read whole file, substitute lines, and print to another file
  file_in = "./file_in_1.txt"
  file_out = "./file_out_1.txt"
  while ((getline line < file_in) > 0) {
   regex="l.{3}4"
   replacement="repl"
   target_string=line
   gsub(regex, replacement, target_string)
   printf "print: " target_string "\nto file: " file_out "\n"
   printf ("%s\n",target_string) >> file_out
  }
  print "-----179-------\n"
  
  # counter
  counterx = "x"
  counter = "100"
  print counterx "\n" counter
  print "-----185-------\n"
}
# end of BEGIN block


# begin of FILE block 1
{
  # counter
  counterx=counterx+1
  counter=counter+1
  print "-----195-------------------------------------------------------\n"
  printf("counterx=%d\n", counterx)
  printf("counter=%d\n", counter)
  printf("line=%s\n", $0)
  print "-----198-------------------------------------------------------\n"

  # skip a line in each file
  print "skip line if FNR is 1; FNR= " FNR
  if (FNR == 1){print ">>>>>>>>>>skipped FNR==1" ;next}
  print "-----203-------\n"

  # skip a line, but this time all files are seen as only one big file
  print "skip line if NR is 6; NR= " NR
  if (NR == 6){print ">>>>>>>>>>>skipped NR==6" ;next}
  print "-----208-------\n"
  
  # skip file
  print "skip file if FNR is 4 in ARGV[2]; FNR= " FNR
  print "ARGV[ARGIND]= " ARGV[ARGIND]
  print "ARGV[2]= " ARGV[2]
  if ( (FNR == 4) && (ARGV[2] == FILENAME) ) {
    print ">>>>>>>>>>>>>skipped FILE 2 after FNR==3" ;nextfile
  }
  print "-----217-------\n"
  
  # print system variables
  printf("FILENAME=%s\n", FILENAME)
  printf("ARGV[ARGC-1]=%s\n", ARGV[ARGC-1])
  printf("ARGC=%s\n", ARGC)
  printf("ARGIND=%s\n", ARGIND)
  printf("FNR=%s\n", FNR)
  printf("FS=%s\n", FS)
  printf("NF=%s\n", NF)
  printf("NR=%s\n", NR)
  printf("OFS=%s\n", OFS)
  printf("ORS=%s\n", ORS)
  printf("RS=%s\n", RS)
  printf("RT=%s\n", RT)
  printf("RSTART=%s\n", RSTART)
  printf("RLENTH=%s\n", RLENGTH)
  printf("SUBSEP=%s\n", SUBSEP)
  printf("SYMTAB[\"out\"]=%s\n", SYMTAB["out"])
  printf("FUNCTAB[0]=%s\n", FUNCTAB[0])
  printf("PROCINFO[\"pid\"]=%s\n", PROCINFO["pid"])
  printf("PROCINFO[\"ppid\"]=%s\n", PROCINFO["ppid"])
  printf("PROCINFO[\"strftime\"]=%s\n", PROCINFO["strftime"])
  printf("PROCINFO[\"FS\"]=%s\n", PROCINFO["FS"])
  print "-----241-------\n"
  
  # apply a filter with `if`
  # put the regex on right hand side
  printf ("prev_line_2=%s\n", prev_line_2)
  if(prev_line_2 !~ /l...2/ ) {
    printf("$0=%s\nP1=%s\nP2=%s\nP3=%s\n", $0, prev_line_1, prev_line_2, prev_line_3)
  } 
  print "-----249-------\n"
  
  # sum up column e
  sum_col_4 += $4
  printf("sum_col_4=%d\n", sum_col_4)
  print "-----254-------\n"

  # get a string and make a substitution on the string
  regex="l.{3}2"
  replacement="repl"
  target_string=$0
  gsub(regex, replacement, target_string)
  print "$0: " $0
  printf("target_string=%s\n", target_string)
  print "-----263-------\n"

  # get a string and make a substitution on the string
  regex="l.{3}2"
  replacement="repl"
  option="g"
  target_string=$0
  result = gensub(regex, replacement, option, target_string)
  print "$0: " $0
  printf("target_string=%s\nresult=%s\n", target_string, result)
  print "-----273-------\n"

  # make a change to a line and write to another file
  file_out= "./out_1_"FILENAME
  printf ("write %s to %s \n", result, file_out)
  printf ("%s\n",result) >> file_out
  print "-----278-------\n"

  # print file
  file = "./file_in_1.txt"
  print "file: " file
  system("cat " file)
  print "-----284-------\n"
  

}
# end of FILE block 1


# begin of FILE block 2
{ 
  # print some infos
  printf("NR=%s\n", NR)
  printf("counter=%d\n", counter)
  print "-----297-------\n"
  

  # build a memory of previous field
  # fill associative array (= dict = hash table)
  { lines[$2]+=$4  }
  { for (line in lines) print line, lines[line] }
  print "-----303-------\n"
  

  # build a memory of previous lines
  prev_line_3 = prev_line_2
  prev_line_2 = prev_line_1
  prev_line_1 = $0 
  printf("$0=%s\nP1=%s\nP2=%s\nP3=%s\n", $0, prev_line_1, prev_line_2, prev_line_3)
  print "-----313-------\n"

}
# end of FILE block 2

# begin of END block
END{
 
  # print associative array from FILE block 2 
  { for (line in lines) print line, lines[line] }
  print "-----323-------\n"
  
  # print some bye bye message
  print "\n\nend script" 
  print "-----327-------\n"
}
# end of END block
