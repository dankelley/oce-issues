cp ~/data/archive/sleiwex/2008/moorings/m04/adp/rdi_3737/raw/adp_rdi_3737.000 .
split -b 100k adp_rdi_3737.000
mv xab fake.000
rm -rf x*
rm adp_rdi_3737.000


