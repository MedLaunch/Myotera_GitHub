# Default Python File
FILE := "medium_article_vis.py"

# Typing `make` will auto select defaults^
# To specify => make FILE="script.py" DATA="acc_ud1.json" <- note: command line paramters need to implement in script file for this work.
# FILE and DATA are optional arguments.

# Runs Program
myo:
	python3 $(FILE) $(DATA)

# Interactive Mode
imode:
	python3 -i $(FILE) $(DATA)

# Run in Debug Mode; pauses execution at point in pdb where an error is thrown.
debug:
	python3 -m pdb -c continue $(FILE) $(DATA)

# Run autopep8 style filter (req. autopep8 to be installed)
style:
	autopep8 --in-place $(FILE)

# Removes Things...modify as needed.
clean:
	#rm -rf output/*
	#rm -rf __pycache__


