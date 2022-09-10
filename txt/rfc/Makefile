all: rfcs

rfcs: rfcs.json mig.zsh
	./mig.zsh

rfcs.json: rfcnums.tsv rfcs.yml genjson.zsh
	./genjson.zsh

rfcnums.tsv: rfcnums.zsh
	./rfcnums.zsh

rfcs.yml: rfc-index.txt titles.awk titles.zsh
	./titles.zsh
