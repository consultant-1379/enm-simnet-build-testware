#!/bin/bash
add1="/netsim/inst/";
add2=$add1."/netsim_shell";
call_mmlfunction()
{
echo ".send /netsim/enm-simnet-build-testware/ERICTAFenmsimnetbuildtestware_CXP9035174/src/main/resources/scripts/Core-CodeBase/bin/mml_save_sim.mml"
}
(
call_mmlfunction
) | $add2
