all: default bipartite bristol university

default:
	pdftoppm ./default.pdf ./default -png
	montage ./default-* -geometry +50+50 -background LightGray ./default.png
	rm ./default-*

bipartite:
	pdftoppm ./bipartite.pdf ./bipartite -png
	montage ./bipartite-* -geometry +50+50 -background LightGray ./bipartite.png
	rm ./bipartite-*

bristol:
	pdftoppm ./bristol.pdf ./bristol -png
	montage ./bristol-* -geometry +50+50 -background LightGray ./bristol.png
	rm ./bristol-*

university:
	pdftoppm ./university.pdf ./university -png
	montage ./university-* -geometry +50+50 -background LightGray ./university.png
	rm ./university-*
