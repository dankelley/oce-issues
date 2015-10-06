# Argo profiles quality flags

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

