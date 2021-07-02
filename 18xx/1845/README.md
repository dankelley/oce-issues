See https://github.com/dankelley/oce/issues/1845.

The `create_data.sh` shellscript creates two test files:
1. `adp_12.0000` (the first 100k bytes, which starts with 7F7F)
2. `adp_2.0000` (the second 50k bytes, which does not start with 7F7F)

