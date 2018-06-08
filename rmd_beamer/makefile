RFILE = beamer_test

all: knit_pdf

knit_pdf: $(RFILE).Rmd
	echo "rmarkdown::render('$(RFILE).Rmd',output_file='$(RFILE).pdf')" | R --no-save -q

open: $(RFILE).pdf
	xdg-open $(RFILE).pdf &

clean:
	rm -rf *.pdf
