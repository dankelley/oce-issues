POSSIBLE TEXT FOR THE DOCS:

The tick marks are set automatically based on examination of the time range on
the axis. The scheme was devised by constructing test cases with a typical plot
size and font size, and over a wide range of time scales. In some categories,
both small tick marks are interspersed between large ones.

The user may set the format of axis numbers with the \code{tformat} argument.
If this is not supplied, the format is set based on the time span of the axis:

\itemize{

\item If this time span is less than a minute, the time axis labels are in
seconds (fractional seconds, if the interval is less than 2 seconds), with
leading zeros on small integers. (Fractional seconds are enabled with a trick:
the usual R format \code{"%S"} is supplemented with a new format e.g.
\code{"%.2S"}, meaning to use two digits after the decimal.)

\item If the time span exceeds a minute but is less than 1.5 days, the label
format is \code{HH:MM:SS}.

\item If the time span exceeds 1.5 days but is less than 1 year, the format is
\code{"%b %d"} (e.g. Jul 15) and, again, the tick marks are set up for several
subcategories.

\item If the time span exceeds a year, the format is \code{"%Y"}, i.e. the year
is displayed with 4 digits.

}

It should be noted that this scheme differs from the R approach in several
ways. First, R writes day names for some time ranges, in a convention that is
seldom seen in the literature. Second, R will write nn:mm for both HH:MM and
MM:SS, an ambiguity that might confuse readers. Third, the use of both large
and small tick marks is not something that R does. 

Bear in mind that \code{tformat} may be set to alter the number format, but
that the tick mark scheme cannot (presently) be controlled.



FROM THE CODE:

grep "\(Time range is\)\|\(tformat <-\)" oce.R
        oceDebug(debug, "Time range is under 2 sec\n")
            tformat <- "%.1S" # NOTE: this .1 is interpreted at BOOKMARK 1B
        oceDebug(debug, "Time range is between 2 sec and 1 min\n")
            tformat <- "%S"
        oceDebug(debug, "Time range is between 1 min and 3 min\n")
            tformat <- "%M:%S"
        oceDebug(debug, "Time range is between 3 min and 30 min\n")
            tformat <- "%M:%S"
        oceDebug(debug, "Time range is between 30 min and 1 hour\n")
            tformat <- "%M:%S"
        oceDebug(debug, "Time range is between 1 and 2 hours\n")
            tformat <- "%H:%M:%S"
        oceDebug(debug, "Time range is between 2 and 6 hours\n")
            tformat <- "%H:%M:%S"
        oceDebug(debug, "Time range is between 6 hours and 1.5 days\n")
            tformat <- "%H:%M:%S"
        oceDebug(debug, "Time range is between 1.5 and 5 days\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 4 days and 2 weeks\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 2 weeks and 1 month (defined as 31 days)\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 1 and 2 months (defined as 31 days)\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 2 and 4 months (defined as 31 days)\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 4 months and 1 year\n")
            tformat <- "%b %d"
        oceDebug(debug, "Time range is between 1 and 3 years\n")
            tformat <- "%Y %b"
        oceDebug(debug, "Time range is longer than 3 years\n")
            tformat <- "%Y"

