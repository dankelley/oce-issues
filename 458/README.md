* 458a.R -- forward (file 1 5 7) has seg fault
* 458bR -- reverse (file 7 5 1) does not have seg fault

I put in tons of debugging lines.  They are likely to change but fow now here
are some notes.  (I am trying to see where things change).

# Same at

458a.out (bad case) LINE 52716

  buf[5720000] ok
  byte match at i=5720673; bytes_to_check=1428; limit_test 2185
  check byte at i+c=5720673 (max_lres: 0)
  check_sum is now 127

458b.out (good case) LINE 23400

  buf[5720000] ok
  byte match at i=5720673; bytes_to_check=1428; limit_test 2185
  check byte at i+c=5720673 (max_lres: 0)
  check_sum is now 127

# Same at

458a.out (bad case) LINE 54846
 check byte at i+c=5721737 (max_lres: 0)
 check_sum is now 62199

458b.out (good case) LINE 25530
 check byte at i+c=5721737 (max_lres: 0)
 check_sum is now 62199


# Check at 

HERE HERE HERE -- mixed up above and below, look at line numbers

458a.out (bad case) LINE 54846

458b.out (good case) LINE 25530


# Different at
 
458a.out (bad case) LINE 53500
 check byte at i+c=5721062 (max_lres: 0)
 check_sum is now 31299

458b.out (good case) LINE 27030
 check byte at i+c=5721062 (max_lres: 0)
 check_sum is now 30796

# Different at

458a.out (bad case) LINE 54172
 check byte at i+c=5721400 (max_lres: 0)
 check_sum is now 60623

458b.out (good case) LINE 27706

 check byte at i+c=5721400 (max_lres: 0)
 check_sum is now 60120


