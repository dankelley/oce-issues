all: README.html
README.html: README.md
	pandoc $< > $@
README.md: README.Rmd
	R -e 'library(knitr); knit("README.Rmd")'

clean:
	-rm README.html
	-rm README.md

