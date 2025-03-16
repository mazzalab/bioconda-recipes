#!/bin/bash
set -e

JAR_NAME=mitoscape.jar

if [ "$1" == "--help" ]; then
  echo "MitoScape: A tool for mitochondrial DNA analysis using Apache Spark."
  echo "Usage: mitoscape [options]"
  echo ""
  echo "Options:"
  echo "  --threads <number>       Number of threads to use."
  echo "  --prob <classification>  Classification probability."
  echo "  --ld <file>              Path to mitomap.ld file."
  echo "  --numt <file>            Path to NUMTs_hg38.txt file."
  echo "  --classifier <folder>    Path to MTClassifierModel.RF folder."
  echo "  --prefix <string>        Prefix for BAM filenames."
  echo "  --out <file>             Output prefix for BAM file."
  exit 0
fi

if [ -x "$JAVA_HOME/bin/java" ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=$(which java)
fi

$JAVA -Xmx16G -jar "$(dirname $(readlink -f "$0"))/$JAR_NAME" "$@"
