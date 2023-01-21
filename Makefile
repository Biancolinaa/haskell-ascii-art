# Use "> file.txt" to write the output into a file

build:
	cabal build haskell-ascii-art

run-cat-roll:
	cabal run haskell-ascii-art -- cat_roll.jpg cat_roll.txt

run-cat:
	cabal run haskell-ascii-art -- cat.jpg cat.txt

run-cat-sad:
	cabal run haskell-ascii-art -- cat_sad.jpg cat_sad.txt