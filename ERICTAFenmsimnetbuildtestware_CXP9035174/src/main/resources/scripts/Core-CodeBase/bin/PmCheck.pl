#!/usr/bin/perl

########################################################################
## Version2    : 20.05
## Revision    : CXP 903 5174-1-12
## Description : Skipping Pm Check If Pm support is not availble in Mib.
## Date        : Feb 2020
## Who         : zyamkan
#########################################################################
##########################################################################################################################
# Created by  : zchianu
# Created on  : 10.01.2020
# Purpose     : Check simulations for PM file location and PM MOs
###########################################################################################################################

####################
# Env
####################
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Cwd;
use v5.10;
#use General;
################################
# Usage
################################
local @helpinfo=qq(
ERROR : need to pass 1 parameter to ${0}

Usage : ${0} <simulation name> 

Example1 : ${0} LTE17B-V1x2-FT-vSD-SNMP-LTE01 

Example2 : ${0} LTE17B-V1x5-FT-vSD-TLS-LTE01 

); # end helpinfo

################################
# Vars
################################
local $netsimserver=`hostname`;
local $username=`/usr/bin/whoami`;
$username=~s/^\s+//;$username=~s/\s+$//;
local $NETSIM_INSTALL_PIPE="/netsim/inst/netsim_pipe";
local @netsim_output=();
local $dir=cwd;
local $currentdir=$dir."/";
local $scriptpath="$currentdir";
local $MMLSCRIPT="$scriptpath".${0}.".mml";
local $SIMNAME=$ARGV[0];
local $SIMNUMBER=substr($SIMNAME, -2);
local $NODECOUNT=1;
local @MMLCmds=();
local $NODENAME;
local $NETSIMMMLSCRIPT;
local @netsim_output=();
my $filename = 'Result.log';
################################
# MAIN
################################
print "\n############### Checking $SIMNAME ##############\n";
###Storing node details of simulation###
my $shell_out = <<`SHELL`;
echo netsim | sudo -S -H -u netsim bash -c 'printf ".open '$SIMNAME' \n .show simnes" | /netsim/inst/netsim_shell | grep -v ">>" | grep -v "OK" | grep -v "NE"' >  NodeData.txt
SHELL
###Storing the nodes in an array###
system ("cut -f1 -d ' ' NodeData.txt > NodeData1.txt");
open(FILE, "<", "NodeData1.txt") or die("Can't open file");
@Nodes = <FILE>;
close(FILE);
##################################################
# Finding number of PMGroups from the MIB file
##################################################
@MMLCmds=(".open ".$SIMNAME,
            ".select ".$Nodes[1],
            ".start ",
            "e installation:get_neinfo(pm_mib) ."
          );# end @MMLCmds
$NETSIMMMLSCRIPT=&makeMMLscript("write",$MMLSCRIPT,@MMLCmds);
# execute mml script
@netsim_output=`sudo su -l netsim -c $NETSIM_INSTALL_PIPE < $NETSIMMMLSCRIPT`;
$netsim_output[7] =~ s/"|{|}|ok|,//g;
chomp ($netsim_output[7]);
my $MibFile= "/netsim/inst/zzzuserinstallation/ecim_pm_mibs/$netsim_output[7]";
open FILE, $MibFile or die "can't open $file: $!\n";
while(<FILE>)
{
    next unless /slot name=\"pmGroupId\"/;

    $NumOfPmGroup++;
}
close FILE;
unlink "$NETSIMMMLSCRIPT";
if ($NumOfPmGroup != "")
{
     print "\nNumOfPmGroup=$NumOfPmGroup\n";
}
else
{
     $NumOfPmGroup=0;
     print "\nNumOfPmGroup=$NumOfPmGroup\n";

     open (FH2 , '>>' ,$filename) or die "Could not open file '$filename' $!";
     print FH2 "***********************************************************\n";
     print FH2 "This Node version doesn't have PM support in mib file\n";
     print FH2 "So, we are exiting from Pm unit test cehcking\n";
     print FH2 "***********************************************************\n";
     system (" cat $scriptpath/Result.log");
     close FH2;
     exit 1;
}
@MMLCmds=();
@netsim_output=();
##################################################
###Fetching Namespace from the env file###
$NameSpacefile="NameSpaceData.env";
$NameSpace=&getENVfilevalue($NameSpacefile,"$SIMNAME");
##################################################
 # ############################################## #
# verify PM Group
##################################################

foreach $node (@Nodes)
{
    chomp($node);
	@MMLCmds=(".open ".$SIMNAME,
              ".select ".$node,
              ".start ",
              "e length(csmo:get_mo_ids_by_type(null, \"$NameSpace:PmGroup\"))."
              );# end @MMLCmds

$NETSIMMMLSCRIPT=&makeMMLscript("write",$MMLSCRIPT,@MMLCmds);

# execute mml script
@netsim_output=`sudo su -l netsim -c $NETSIM_INSTALL_PIPE < $NETSIMMMLSCRIPT`;

#####Storing the output in file Result.log###

open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";

     if (int($netsim_output[-1]) eq $NumOfPmGroup) {
        say $fh "INFO :PASSED on $node PMGroup MO count is $netsim_output[-1]";
        }
     else {
        say $fh "INFO :FAILED on $node, Check if all the PMGroups are loaded or not, MO count is $netsim_output[-1], It should be $NumOfPmGroup";
        }

unlink "$NETSIMMMLSCRIPT";
@MMLCmds=();
@netsim_output=();
	
}
#####Exit case when logs have failures####
system (" cat $scriptpath/Result.log");

open(FILE,"$scriptpath/Result.log");
if (grep{/FAILED/} <FILE>){
   print "\n---------There are FAILURES-----------\n";
   exit 9;
}else{
   print "\n---------PASSED----------------------\n";
}
close FILE;

print "\n########### End checking for $SIMNAME ##########\n";
print "\n";

###############Functions#################
 sub makeMOscript{
     local ($fileaction,$moscriptname,@cmds)=@_;
     $moscriptname=~s/\.\///;
     print "";
     if($fileaction eq "write"){
       if(-e "$moscriptname"){
         unlink "$moscriptname";
       }#end if
    print "moscriptname : $moscriptname\n";
       open FH1, ">$moscriptname" or die $!;
     }# end write
     if($fileaction eq "append"){
        open FH1, ">>$moscriptname" or die $!;
     }# end append
     foreach $_(@cmds){print FH1 "$_\n";}
     close(FH1);
     system("chmod 744 $moscriptname");
     return($moscriptname);
 }# end makeMOscript
 
 sub makeMMLscript{
         local ($fileaction,$mmlscriptname,@cmds)=@_;
 
         $mmlscriptname=~s/\.\///;
         if($fileaction eq "write"){
                 if(-e "$mmlscriptname"){
                         unlink "$mmlscriptname";
                 }#end if
                 open FH, ">$mmlscriptname" or die $!;
         }# end write
 
         if($fileaction eq "append"){
                 open FH, ">>$mmlscriptname" or die $!;
         }# end append
 
         print FH "#!/bin/sh\n";
         foreach $_(@cmds){
                 print FH "$_\n";
         }
         close(FH);
         system("chmod 744 $mmlscriptname");
 
         return($mmlscriptname);
 }# end makeMMLscript
 
 
sub getENVfilevalue {
    local ( $env_file_name, $env_file_constant ) = @_;
    local @envfiledata    = ();
    local $env_file_value = "ERROR";
    local $dir            = cwd, $currentdir = $dir . "/";
    local $scriptpath     = "$currentdir";
    local $envdir;

    # navigate to dat directory
     $scriptpath =~ s/lib.*//;
    $scriptpath =~ s/bin.*//;
    $envdir = $scriptpath . "bin/dat/$env_file_name";
    if ( !-e "$envdir" ) {
        print "ERROR : $envdir does not exist\n";
        return ($env_file_value);
    }

    open FH, "$envdir" or die $!;
    @envfiledata = <FH>;
    close(FH);
    foreach $element (@envfiledata) {
        if ( $element =~ /\#/ )      { next; }    # end if
        if ( !( $element =~ /\=/ ) ) { next; }    # end if

        $tempelement = $element;
        $tempelement =~ s/=.*//;
        $tempelement =~ s/\n//;
        $env_file_constant =~ s/\n//;


        if ( "$env_file_constant" =~ "$tempelement" ) {
            $env_file_value = $element;
            $env_file_value =~ s/^\s+//;
            $env_file_value =~ s/^.*=//;
            $env_file_value =~ s/\s+$//;
        }    # end if

    }    # end foreach
    return ($env_file_value);
}    # end getENVfilevalue

