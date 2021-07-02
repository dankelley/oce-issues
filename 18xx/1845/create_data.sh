cp ~/data/archive/sleiwex/2008/moorings/m04/adp/rdi_3737/raw/adp_rdi_3737.000 .
split -b 100k adp_rdi_3737.000
mv xab adp_2.000

split -b 200k adp_rdi_3737.000
mv xaa adp_12.000

rm -f x* adp_rdi_3737.000

