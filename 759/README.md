# Argo profiles quality flags

## Quality flags

From http://www.argo.ucsd.edu/Argo_date_guide.html

	The qc flags are:
	0 No QC tests have been performed
	1 Observation good
	2 Observation probably good (implies some uncertainty)
	3 Observation thought to be bad but may be recoverable
	4 Observation thought to be bad and irrecoverable

This list appears to be incomplete, with the full list of flags from http://www.cmar.csiro.au/argo/dmqc/user_doc/QC_flags.html being:

	| n | Meaning                         | Real-time comment                            | Delayed-mode comment                                                                    |
	|---+---------------------------------+----------------------------------------------+-----------------------------------------------------------------------------------------|
	| 0 | no QC performed                 | .                                            | .                                                                                       |
	| 1 | good data                       | All realtime QC tests passed                 | Adjusted value is statistically consistent and a statistical error estimate is supplied |
	| 2 | probably good                   | n/a                                          | .                                                                                       |
	| 3 | bad but potentially correctable | not to be used without scientific correction | An adjustment has been made but the value may still be bad                              |
	| 4 | bad                             | .                                            | .                                                                                       |
	| 5 | value changed                   | .                                            | .                                                                                       |
	| 6 | .                               | .                                            | .                                                                                       |
	| 7 | .                               | .                                            | .                                                                                       |
	| 8 | interpolated                    | .                                            | .                                                                                       |
	| 9 | missing value                   | .                                            | .                                                                                       |


See also http://www.argodatamgt.org/content/download/12096/80327/file/argo-dm-user-manual.pdf for table 2a:

### Reference table 2a: profile quality flag

N is defined as the percentage of levels with good data where:

* QC flag values of 1, 2, 5, or 8 are GOOD data

* QC flag values of 9 (missing) are NOT USED in the computation

**Note:** *I don't understand why there are so many more QC flags here, given that the above table only defines 0 to 4*

All other QC flag values are BAD data. The computation should be taken from `PARAM_ADJUSTED_QC` if available and from `PARAM_QC` otherwise.

    | n   | Meaning                                         |
    |-----+-------------------------------------------------|
    | ' ' | No QC performed                                 |
    | A   | N = 100%; All profile levels contain good data. |
    | B   | 75% <= N < 100%                                 |
    | C   | 50% <= N < 75%                                  |
    | D   | 25% <= N < 50%                                  |
    | E   | 0% < N < 25%                                    |
    | F   | N = 0%; No profile levels have good data.       |


## Data fields

Things that will be relevant to read, which currently aren't:

* `DATA_MODE`:

        char DATA_MODE[N_PROF]   
            long_name: Delayed mode or real time data
            conventions: R : real time; D : delayed mode; A : real time with adjustment

* `POSITION_QC`:

        char POSITION_QC[N_PROF]   
            long_name: Quality on position (latitude and longitude)
            conventions: Argo reference table 2

* "global" quality flags for profiles:

        char PROFILE_PRES_QC[N_PROF]   
            long_name: Global quality flag of PRES profile
            conventions: Argo reference table 2a
            _FillValue:  
        char PROFILE_PSAL_QC[N_PROF]   
            long_name: Global quality flag of PSAL profile
            conventions: Argo reference table 2a
            _FillValue:  
        char PROFILE_TEMP_QC[N_PROF]   
            long_name: Global quality flag of TEMP profile
            conventions: Argo reference table 2a

* Pressure fields:

        char PRES_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float PRES_ADJUSTED[N_LEVELS,N_PROF]   
            long_name: SEA PRESSURE
            standard_name: sea_water_pressure
            _FillValue: 99999
            units: decibar
            valid_min: 0
            valid_max: 12000
            C_format: %7.1f
            FORTRAN_format: F7.1
            resolution: 0.100000001490116
        char PRES_ADJUSTED_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float PRES_ADJUSTED_ERROR[N_LEVELS,N_PROF]   
            long_name: SEA PRESSURE
            _FillValue: 99999
            units: decibar
            C_format: %7.1f
            FORTRAN_format: F7.1
            resolution: 0.100000001490116

* salinity fields:

        char PSAL_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float PSAL_ADJUSTED[N_LEVELS,N_PROF]   
            long_name: PRACTICAL SALINITY
            standard_name: sea_water_salinity
            _FillValue: 99999
            units: psu
            valid_min: 0
            valid_max: 42
            C_format: %9.3f
            FORTRAN_format: F9.3
            resolution: 0.00100000004749745
        char PSAL_ADJUSTED_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float PSAL_ADJUSTED_ERROR[N_LEVELS,N_PROF]   
            long_name: PRACTICAL SALINITY
            _FillValue: 99999
            units: psu
            C_format: %9.3f
            FORTRAN_format: F9.3
            resolution: 0.00100000004749745

* temperature fields

		float TEMP[N_LEVELS,N_PROF]   
            long_name: SEA TEMPERATURE IN SITU ITS-90 SCALE
            standard_name: sea_water_temperature
            _FillValue: 99999
            units: degree_Celsius
            valid_min: -2
            valid_max: 40
            C_format: %9.3f
            FORTRAN_format: F9.3
            resolution: 0.00100000004749745
        char TEMP_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float TEMP_ADJUSTED[N_LEVELS,N_PROF]   
            long_name: SEA TEMPERATURE IN SITU ITS-90 SCALE
            standard_name: sea_water_temperature
            _FillValue: 99999
            units: degree_Celsius
            valid_min: -2
            valid_max: 40
            C_format: %9.3f
            FORTRAN_format: F9.3
            resolution: 0.00100000004749745
        char TEMP_ADJUSTED_QC[N_LEVELS,N_PROF]   
            long_name: quality flag
            conventions: Argo reference table 2
            _FillValue:  
        float TEMP_ADJUSTED_ERROR[N_LEVELS,N_PROF]   
            long_name: SEA TEMPERATURE IN SITU ITS-90 SCALE
            _FillValue: 99999
            units: degree_Celsius
            C_format: %9.3f
            FORTRAN_format: F9.3
            resolution: 0.00100000004749745

## Notes

The QC flags are stored in an odd format ... rather than being numeric matrices that match the dimensions of the field, they are read as character vectors, where each element corresponds to a profile. To be used this will have to be converted to a matrix, where each character corresponds to a matrix element in `[N_LEVELS, N_PROF]`:

	> Tqc[1:3]
	[1] "111111111111111111111111111111111111111111111111111111111111111111111"
	[2] "111111111111111111111111111111111111111111111111111111111111111111111"
	[3] "111111111111111111111111111111111111111111111111111111111111111111111"
	...
	[103] "111111111111111111111111111111111111111111                           "
	[104] "33333333333333333333333333333333333333333                            "
	[105] "33333333333333333333333333333333333333443                            "
	[106] "333333333333333333333333333333333333333433                           "

