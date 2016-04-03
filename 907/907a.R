library(oce)
if (1 == length(list.files(pattern="data_for_section_error.RData"))) {
    load("data_for_section_error.RData") # private data
    section <- as.section(ctd)  # ctd is a list of ctd objects
    section <- sectionGrid(section,p=seq(1,300,1),method="boxcar")
    plot(section,which=c(1),ztype="image",zbreaks=seq(6,10,.2),ytype="pressure",xtype="time")
} else {
    warning("907a.R requires private data to work")
}
