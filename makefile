commit:
	git add .
	git commit -am"$(message) `date`" | : 

push: commit
	git push origin master
stats:
	echo 3 7 15 6.5 234 0.001 | ./classes/stats.d Min Max Average

.PHONY: stats