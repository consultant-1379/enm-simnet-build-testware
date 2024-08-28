package com.ericsson.simnet.core_automation;

public class Get_Protocol
{
  public String getProtocol(String neType)
  {
    if ((neType.toLowerCase().contains("wcdma r")) || 
      (neType.toLowerCase().contains("lte erbs")) || 
      (neType.toLowerCase().contains("mgw")) || 
      (neType.toLowerCase().contains("rbs"))) {
      return "IIOP_PROT";
      
    }
    if (neType.toLowerCase().contains("hlr")) {
        return "APG_NETCONF_HTTP";
      }
    if ((neType.toLowerCase().contains("msc")) || 
      ((neType.toLowerCase().contains("bsc")) && 
      (neType.toLowerCase().contains("apg43l"))) || 
      (neType.toLowerCase().contains("hlr"))) {
      return "APG_APGTCP";
    }
    if ((neType.toLowerCase().contains("ml-tn")) || 
      (neType.toLowerCase().contains("ml-cn")) || 
      (neType.toLowerCase().contains("ml 6691")) ||
      (neType.toLowerCase().contains("ml 6692")) ||
      (neType.toLowerCase().contains("ml 6693")) ||
      (neType.toLowerCase().contains("ml 6651"
      		+ ""
      		+ ""
      		+ ""
      		+ ""
      		+ ""
      		+ "")) ||
      (neType.toLowerCase().contains("ml-lh")) || 
      (neType.toLowerCase().contains("prbs"))) {
      return "SNMP_TELNET_PROT";
    }
    if ((neType.toLowerCase().contains("juniper mx")) || 
      (neType.toLowerCase().contains("cisco asr900")) || 
      (neType.toLowerCase().contains("cisco asr9000"))
       (neType.toLowerCase().contains("lanswitch"))) {
      return "SNMP_SSH_TELNET_PROT";
    }
    if ((neType.toLowerCase().contains("h2s")) || 
      (neType.toLowerCase().contains("esapv")) || (
      (neType.toLowerCase().contains("prbs")) && 
      (neType.toLowerCase().contains("ecim")))) {
      return "NETCONF_PROT";
    }
    if ((neType.toLowerCase().contains("epg-ssr")) || 
      (neType.toLowerCase().contains("epg-evr")) || 
      ((neType.toLowerCase().contains("fronthaul")) && 
      (neType.toLowerCase().contains("17b"))) || 
      (neType.toLowerCase().contains("esapc")) ||
      (neType.toLowerCase().contains("cudb")) ||
      (neType.toLowerCase().contains("dua-s")) || 
      (neType.toLowerCase().contains("bbsc")) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("hss-fe"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("mtas"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("cscf"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("sbg"))) || 
      (neType.toLowerCase().contains("eme")) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("wcg"))) || 
      (neType.toLowerCase().contains("bsp")) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("mrsv"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("mrfv"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("upg"))) || 
      ((neType.toLowerCase().contains("wcdma")) && 
      (neType.toLowerCase().contains("dsc"))) || 
      ((neType.toLowerCase().contains("lte")) && 
      (neType.toLowerCase().contains("bsc"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("mrfv"))) || 
      ((neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("wmg"))) || (
      (neType.toLowerCase().contains("core")) && 
      (neType.toLowerCase().contains("ipworks")))) {
      return "NETCONF_PROT_SSH";
    }
    if ((neType.toLowerCase().contains("lte prbs")) || 
      (neType.toLowerCase().contains("tcu04")) || 
      (neType.toLowerCase().contains("spitfire")) || 
      (neType.toLowerCase().contains("r6675")) || 
      (neType.toLowerCase().contains("r6672")) || 
      (neType.toLowerCase().contains("r6274")) || 
      (neType.toLowerCase().contains("r6371")) || 
      (neType.toLowerCase().contains("r6471-1")) || 
      (neType.toLowerCase().contains("r6471-2")) || (
      
      (neType.toLowerCase().contains("c608 ")) && 
      (neType.toLowerCase().contains("ecim")))) {
      return "NETCONF_PROT_TLS";
    }
    if (neType.toLowerCase().contains("sgsn"))
    {
      if ((neType.toLowerCase().contains("sgsn")) && 
        (neType.toLowerCase().contains("cs"))) {
        return "SGSN_PROT";
      }
      return "SGSN";
    }
    if (neType.toLowerCase().contains("stn")) {
      return "STN_PROT";
    }
    if ((neType.toLowerCase().contains("sasn")) || 
      (neType.toLowerCase().contains("epg-juniper")) || 
      (neType.toLowerCase().contains("siu02")) || 
      (neType.toLowerCase().contains("tcu02"))) {
      return "SNMP_SSH_PROT";
    }
    if ((neType.toLowerCase().contains("router 8801")) || 
      (neType.toLowerCase().contains("fronthaul")) || 
      (neType.toLowerCase().contains("esc")) || 
      (neType.toLowerCase().contains("ssr")) || 
      (neType.toLowerCase().contains("vbng"))) {
      return "LANSWITCH_PROT";
    }
    if (neType.toLowerCase().contains("sapc")) {
      return "TSP_PROT";
    }
    if ((neType.toLowerCase().contains("ccn")) || 
      (neType.toLowerCase().contains("mtas")) || 
      (neType.toLowerCase().contains("cscf")) || 
      (neType.toLowerCase().contains("sapc")) || 
      (neType.toLowerCase().contains("hss-fe-tsp")) || 
      (neType.toLowerCase().contains("vpn"))) {
      return "TSP_SSH_PROT";
    }
    if (neType.toLowerCase().contains("ecm")) {
      return "HTTP_HTTPS_PORT";
    }
    if ((neType.toLowerCase().contains("ml-pt")) || 
      (neType.toLowerCase().contains("ml 6352")) || 
      (neType.toLowerCase().contains("ml 6351")) || 
      (neType.toLowerCase().contains("ml 6391"))
      (neType.toLowerCase().contains("ml-switch"))) {
      return "MLPT_PORT";
    }
    return "NO_PROT";
  }
}

