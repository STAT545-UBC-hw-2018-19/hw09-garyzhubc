all: report.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html start_end.tsv start_end.png

report.html: report.rmd histogram.tsv histogram.png start_end.png start_end.tsv
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf
	
start_end.png: start_end.tsv
	Rscript -e 'library(ggplot2); library(tidyverse); ggplot(top_n(read.delim("start_end.tsv"),50)) + geom_point(aes(reorder(Var1, -Freq), Freq)) + theme(text = element_text(size=10), axis.text.x = element_text(angle=90, hjust=1)); ggsave("start_end.png")' 
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<

start_end.tsv: start_end.R words.txt
	Rscript start_end.R

words.txt: /usr/share/dict/words
	cp $< $@

# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
