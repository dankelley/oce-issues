* `1219a.R`
- uses data in Kelley's possession.
- creates a list
- DISCUSSION:
    - ask RC: do you think the 'blanking' is 2.8m or 0.28m? (I had to modify the matlab test)
    - ask RC and CR: thoughts on best object structure? (maybe mimic matlab)
- ISSUE: what is the range of admixture of data types? 
    - Arrays were ok for the old 'adp'.  Maybe we can set up an array for each
      type in a dataset, using indexing vectors keyed to time. Or maybe
      just use lists of lists, yielding high flexibility but demanding more
      user knowledge.
    - Is there a limit of 4 'data set's? (p48 offset 55:56)
    - I think there is some limit of 16 types in a repeat, but is that true and
      will it always hold?
    - The trial dataset seems to have only one "version" for types 21 and 22.
      We could start with that, but should know whether others are popular.

* `1219b.R` create an oce object

* `1219c.R` based on `1219b.R`: extract what seem to be velocity profiles.

* `1219d.R` based on `1219c.R`: rely on oce to create an oce object, i.e. this
   is the first stage in transferring the code into oce.
   NOTE: this requires the "ad2cp" branch of oce.

