#!/bin/bash
#
# Created:  Wed 13 Feb 2013 05:31:38 AM CET
# Modified: Wed 13 Feb 2013 06:44:10 AM CET
# Author:   Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
# source.sh -- genereer een LaTeX-document met alle java broncode
# gevonden in de source/ directory

# Directory met broncodebestanden
src=source

# Gewenste niveau van hoofding voor packages
# Typisch section of subsection
sectionlvl=section

# Output
out=source.tex

if [[ ! -d ${src} ]]; then
cat << EOF
Directory ./${src} niet gevonden. Maak een link aan naar je Java broncode,
met 
  ln /path/to/java/src/ ./${src}
en vergeet niet deze directory te negeren in je versiebeheersysteem.
EOF
fi

if [[ -f ${out} ]]; then
  rm ${out}
  echo "% Java Broncode, gegenereerd door ${0}" > ${out}
  echo "% Waarschuwing: manuele wijzigingen worden overschreven!" >> ${out}
fi 


# Alle bestanden en directories in de source directory oplijsten
files=$(find ${src}/ -mindepth 1 -printf '%p\t%d\n' | sort -n -k2 | cut -f 1)

for f in ${files}; do
  # Genereer klasse- of packagenaam uit directory/filenaam
  name=$(echo ${f##${src}/} | sed 's/\.java$//' | sed 's/\//./g')

  # Java-bestand => \codefragment 
  if [[ "${f}" =~ \.java$ ]]; then
    echo "\\codefragment{${f}}{${name}}" >> ${out}
  # Directory is een package => hoofding invoegen
  elif [[ -d "${f}" ]]; then
    echo -e "\n\\${sectionlvl}{Package ${name}}" >> ${out}
  fi
  # Andere bestanden (vb. .properties) worden genegeerd!
done
