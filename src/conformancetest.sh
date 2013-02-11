#!/bin/bash

runpeaq() {
	MODE=$1
	CODFILE=$2
	REFFILE=${CODFILE/cod/ref}
	OUTPUT=`LANG=LC_ALL ./peaq --gst-disable-segtrap --gst-debug-level=2 --gst-plugin-load=.libs/libgstpeaq.so \
		${MODE} "${REFFILE}" "$CODFILE"`
	DI=`echo "$OUTPUT" | grep "Distortion Index:" | cut -d " " -f3`
	DI_DELTA=`echo $DI - $3 | bc`
	ODG=`echo "$OUTPUT" | grep "Objective Difference Grade:" | cut -d " " -f4`
	ODG_DELTA=`echo $ODG - $4 | bc`
	echo `basename $CODFILE` "DI: " $DI "(should be $3, diff: $DI_DELTA)" "ODG: " $ODG "(should be $4, diff: $ODG_DELTA)"
}

DATADIR="../BS.1387-ConformanceDatabase"
if [ ! -d $DATADIR ]; then
	echo "Reference data not found, conformance test NOT run."
	exit 0
fi

runpeaq --basic "${DATADIR}/acodsna.wav" 1.304  -0.676
runpeaq --basic "${DATADIR}/bcodtri.wav" 1.949  -0.304
runpeaq --basic "${DATADIR}/ccodsax.wav" 0.048  -1.829
runpeaq --basic "${DATADIR}/ecodsmg.wav" 1.731  -0.412
runpeaq --basic "${DATADIR}/fcodsb1.wav" 0.677  -1.195
runpeaq --basic "${DATADIR}/fcodtr1.wav" 1.419  -0.598
runpeaq --basic "${DATADIR}/fcodtr2.wav" -0.045 -1.927
runpeaq --basic "${DATADIR}/fcodtr3.wav" -0.715 -2.601
runpeaq --basic "${DATADIR}/gcodcla.wav" 1.781  -0.386
runpeaq --basic "${DATADIR}/icodsna.wav" -3.029 -3.786
runpeaq --basic "${DATADIR}/kcodsme.wav" 3.093  0.038
runpeaq --basic "${DATADIR}/lcodhrp.wav" 1.041  -0.876
runpeaq --basic "${DATADIR}/lcodpip.wav" 1.973  -0.293
runpeaq --basic "${DATADIR}/mcodcla.wav" -0.436 -2.331
runpeaq --basic "${DATADIR}/ncodsfe.wav" 3.135  0.045
runpeaq --basic "${DATADIR}/scodclv.wav" 1.689  -0.435

runpeaq --advanced "${DATADIR}/acodsna.wav" 1.632 -0.467
runpeaq --advanced "${DATADIR}/bcodtri.wav" 2.000 -0.281
runpeaq --advanced "${DATADIR}/ccodsax.wav" 0.567 -1.300
runpeaq --advanced "${DATADIR}/ecodsmg.wav" 1.594 -0.489
runpeaq --advanced "${DATADIR}/fcodsb1.wav" 1.039 -0.877
runpeaq --advanced "${DATADIR}/fcodtr1.wav" 1.555 -0.512
runpeaq --advanced "${DATADIR}/fcodtr2.wav" 0.162 -1.711
runpeaq --advanced "${DATADIR}/fcodtr3.wav" -0.783 -2.662
runpeaq --advanced "${DATADIR}/gcodcla.wav" 1.457 -0.573
runpeaq --advanced "${DATADIR}/icodsna.wav" -2.510 -3.664
runpeaq --advanced "${DATADIR}/kcodsme.wav" 2.765 -0.029
runpeaq --advanced "${DATADIR}/lcodhrp.wav" 1.538 -0.523
runpeaq --advanced "${DATADIR}/lcodpip.wav" 2.149 -0.219
runpeaq --advanced "${DATADIR}/mcodcla.wav" 0.430 -1.435
runpeaq --advanced "${DATADIR}/ncodsfe.wav" 3.163 0.050
runpeaq --advanced "${DATADIR}/scodclv.wav" 1.972 -0.293
