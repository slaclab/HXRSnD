#!/bin/bash
# This script sets up the evironment for the HXRSnD

# Setup the conda path
unset LD_LIBRARY_PATH
unset PYTHONPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/reg/common/package/epicsca/3.14.12/lib/rhel6-x86_64
export PATH=/reg/g/pcds/pyps/conda/py36/bin:$PATH

# Source the EPICS env first before the conda env
source /reg/g/pcds/setup/epicsenv-cur.sh
# This must happen here before the source activate conda-env otherwise some
# shared libraries do not load properly.

# These have to be included otherwise there you get the following error then a
# seg fault:
#       QXcbConnection: Could not connect to display
# This needs to point to the conda env being used
export QT_XKB_CONFIG_ROOT='/reg/g/pcds/pyps/conda/py36/envs/pcds-0.2.0/lib'
# This ensures the terminal doesn't totally screw up
export QT_QPA_PLATFORM='offscreen'

# Activate the snd_opr conda environment
source activate pcds-0.2.0

# resolve $FILE until the file is no longer a symlink
FILE="${BASH_SOURCE[0]}"
while [ -h "$FILE" ]; do 
  SCRIPTPATH="$( cd -P "$( dirname "$FILE" )" && pwd )"
  FILE="$(readlink "$FILE")"
  # if $FILE was a relative symlink, we need to resolve it relative to the path
  # where the symlink file was located
  [[ $FILE != /* ]] && FILE="$SCRIPTPATH/$FILE"
done
SCRIPTPATH="$( cd -P "$( dirname "$FILE" )" && pwd )"

# Get the directory of snd project
SNDPATH=$(readlink --canonicalize $SCRIPTPATH/..)

# Add required modules to the python path
PYTHONPATH=$SNDPATH/pcds-devices:$PYTHONPATH # pcds-devices
PYTHONPATH=$SNDPATH/pswalker:$PYTHONPATH     # pswalker
PYTHONPATH=$SNDPATH/HXRSnD:$PYTHONPATH       # HXRSnD
PYTHONPATH=$SNDPATH/pydm:$PYTHONPATH         # PyDM
PYTHONPATH=$SNDPATH/lightpath:$PYTHONPATH    # lightpath
PYTHONPATH=$SNDPATH/happi:$PYTHONPATH        # happi
PYTHONPATH=$SNDPATH/psbeam:$PYTHONPATH       # psbeam

export PYTHONPATH
