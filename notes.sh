#!/bin/bash

#TODO: Update the script so that you can input certain years/modules
#TODO: Update the following usage function accordingly
usage() {
cat << EOF
USAGE:
EOF
}
# Takes the name of the output file as an argument and 
# merges all md files in the directory into 1 pdf file
makepdf() {
    pandoc *.md --pdf-engine=xelatex -o "${1}.pdf" &&
    echo -e "\e[92m┃ ┗━━ Created ${1}.pdf"
}


makenotes(){
    # Iterate through all subdirectories of CS-Y3 and compile pdf
    for module in $NOTES_DIR/CS-Y3/*/; do
        cd "$module"
        #Check if the current directory is empty
		if [ -z "$(ls -A $DIR)" ]; then
		    echo -e "\e[31m┣━━ ${module} is Empty\e[39m"
		else
            echo -e "\e[92m┣━┓\e[39mCompiling module: ${module}" &&
            title=$(head -1 Intro.md)
            makepdf "$module"$(basename "$module") 
            cd - &>/dev/null
		fi
    done
}

main(){
    echo "┏━■ Compiling CS-Y3..."
    makenotes 
    echo "┗━━ DONE!"
}

main
