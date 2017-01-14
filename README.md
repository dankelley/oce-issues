The repository holds test code relating to issues for the oce R package.  See
[the oce site](https://github.com/dankelley/oce/issues) to learn more about the
issues.

The directory structure used here is simple. At the top level are
subdirectories with names starting with two digits followed by the letter "x"
repeated twice. These subdirectories contain subdirectories that are named by
the sequence number of the issue being tackled.  Thus, for example, `11xx/1166`
is a directory with code and data that addresses issue [number
1166](https://github.com/dankelley/oce/issues/1166).  The code is usually in a
file named with the issue number followed by a lower-case letter, with the
letter indicating the sequence of the test. Each of these subdirectories
usually also contains a `Makefile` to help with the testing. The default target
runs all the `.R` files. Often there is also a target to view the resultant PNG
files (since many tests involve plotting).

At the second level there is usually a ``Makefile`` that descends into the
individual issue subdirectories.

There has been a fair bit of renaming and reordering of the subdirectories over
the years, and so some of what is written above may not apply to issues
addressed before late 2016. Since the main audience of this repository is the
developers and the issue reporters, and since the interest in an issue tends to
dwindle after it has been addressed, it is fairly likely that there are errors
in some of the oldest issues. For example, names of functions may have changed
over the years.

-- DK
