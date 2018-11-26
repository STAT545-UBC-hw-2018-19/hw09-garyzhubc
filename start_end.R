require(stringr)
words <- readLines("words.txt")
start_end <- table(paste0(str_sub(tolower(words),0,1), str_sub(tolower(words),-1)))
write.table(start_end, "start_end.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)
