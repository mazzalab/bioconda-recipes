#!/bin/bash
set -eu

# Set variables
OUTDIR=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM
MDATA=$OUTDIR/data
[ -d "$MDATA" ] || mkdir -p "$MDATA"
[ -d "${PREFIX}/bin" ] || mkdir -p "${PREFIX}/bin"

# Set MitoScape executable
cp $SRC_DIR/MitoScape-$PKG_VERSION.jar $OUTDIR/mitoscape.jar
cp $RECIPE_DIR/mitoscape.sh $OUTDIR/mitoscape
ln -s $OUTDIR/mitoscape $PREFIX/bin/mitoscape
chmod +x $PREFIX/bin/mitoscape

# Get and set mitoscape data in place
wget -qO- https://github.com/larryns/MitoScape/raw/refs/heads/master/src/universal/MTClassifierModel.RF.tar | tar xvf - -C $MDATA
wget https://github.com/larryns/MitoScape/raw/refs/heads/master/src/universal/NUMTs_hg38.txt -O $MDATA/NUMTs_hg38.txt
wget https://github.com/larryns/MitoScape/raw/refs/heads/master/src/universal/mitomap.ld -O $MDATA/mitomap.ld

# set MITOSCAPE_DATA variable on env activation
mkdir -p ${PREFIX}/etc/conda/activate.d ${PREFIX}/etc/conda/deactivate.d
cat <<EOF >> ${PREFIX}/etc/conda/activate.d/mitoscape.sh
export MITOSCAPE_DATA=${MDATA}
EOF
cat <<EOF >> ${PREFIX}/etc/conda/deactivate.d/mitoscape.sh
unset MITOSCAPE_DATA
EOF
