For the docs:

Labels such as 01 or 01.1, etc., indicate seconds. The leading zero
distinguishes them from conventional decimal numbers. Another sign, of course,
is that the numbers are modulo 60, so that 00 comes after 59. (An exception is
the leap second.)

Q: should 01:02 indicate HH:MM or MM:SS? Either alternative seems sensible, and
that's the problem, really: how can a user guess when they see the string?

IDEA: maybe create full labels in a single format, and then remove common
leading text. That would be easy to explain and code. Would it always be
obvious to viewers? And won't it use a lot of space?
