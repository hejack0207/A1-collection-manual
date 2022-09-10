all: rfcs

rfcs: rfcs.tsv
	./migt.zsh

rfcs.json: rfcnums.tsv rfcs.yml
	./genjson.zsh

rfcs.tsv: rfcnums.tsv rfcs.yml
	./gentsv.zsh

rfcnums.tsv: rfcs
	./rfcnums.zsh

rfcs.yml: rfc-index.txt
	./titles.zsh
