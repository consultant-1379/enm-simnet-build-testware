package com.ericsson.simnet.core_automation;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

class create_Ports
{
  String lineAddPort;
  String lineConfigPort;
  String lineAddDD;
  String lineConfigDD;
  String DD_Name;
  String Port_Name;
  int[] createAddress = new int[3];
  
  public void buildPort(String lineAddPort, String lineConfigPort, String Port_Name)
  {
    try
    {
      PrintWriter out = new PrintWriter(new BufferedWriter(
        new FileWriter("mml_ports.mml", true)));
      out.println(".select configuration");
      out.println(lineAddPort);
      out.println(lineConfigPort);
      
      out.println(".config save");
      out.close();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
  }
  
  public void buildDD(String lineAddDD, String lineConfigDD, String Default_Destination_Name, String host_Name)
  {
    try
    {
      PrintWriter out = new PrintWriter(new BufferedWriter(
        new FileWriter("mml_ports.mml", true)));
      out.println(".select configuration");
      out.println(lineAddDD);
      out.println(".config external servers " + this.DD_Name + " " + host_Name);
      out.println(lineConfigDD);
      out.println(".config save");
      out.close();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
  }
  
  public String[] select_ports(String protocol, String Node_Name, String createDefaultDestination, String host_Name)
  {
    this.createAddress[0] = 192;
    this.createAddress[1] = 168;
    this.createAddress[2] = 100;
    if (protocol == "SGSN")
    {
      this.Port_Name = "SGSN";
      this.DD_Name = ("SGSN" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " netsimwpp " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 4001");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      
      this.lineAddDD = (".config add external " + this.DD_Name + " netsimwpp");
      this.lineConfigDD = 
        (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
      buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
    }
    else if (protocol == "NETCONF_PROT")
    {
      this.Port_Name = "NETCONF_PROT";
      this.DD_Name = ("NETCONF_PROT" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " netconf_prot " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 2 %unique 1 %simname_%nename authpass privpass 2 2");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      
      this.lineAddDD = (".config add external " + this.DD_Name + " netconf_prot");
      this.lineConfigDD = 
        (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
      buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
    }
    else if (protocol == "NETCONF_PROT_TLS")
    {
      this.Port_Name = "NETCONF_PROT_TLS";
      this.DD_Name = ("NETCONF_PROT_TLS" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " netconf_prot " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 2 %unique 2 %simname_%nename authpass privpass 2 2");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      
      this.lineAddDD = (".config add external " + this.DD_Name + " netconf_prot");
      this.lineConfigDD = 
        (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
      buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
    }
    else if (protocol == "IIOP_PROT")
    {
      this.Port_Name = "IIOP_PROT";
      this.DD_Name = ("IIOP_PROT" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " iiop_prot " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " nehttpd " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 56834 56836 no_value");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
    }
    else if (protocol == "STN_PROT")
    {
      this.Port_Name = "STN_PROT";
      this.DD_Name = ("STN_PROT" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " snmp_ssh_prot " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 2 %unique %simname_%nename authpass privpass 2 2");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      
      this.lineAddDD = (".config add external " + this.DD_Name + " snmp_ssh_prot");
      this.lineConfigDD = 
        (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
      buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
    }
    else if (protocol == "SGSN_PROT")
    {
      this.Port_Name = "SGSN_PROT";
      this.DD_Name = ("SGSN_PROT" + createDefaultDestination);
      this.lineAddPort = 
        (".config add port " + this.Port_Name + " sgsn_prot " + host_Name);
      this.lineConfigPort = 
      
        (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 2 %unique 4001 %simname_%nename authpass privpass 2 2");
      buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      
      this.lineAddDD = (".config add external " + this.DD_Name + " sgsn_prot");
      this.lineConfigDD = 
        (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
      buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
    }
    else if (protocol != "SGSN_SSH_PROT")
    {
      if (protocol == "APGTCP")
      {
        this.Port_Name = "APGTCP";
        this.DD_Name = ("APGTCP" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " apgtcp " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 5000 5022 23");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " apgtcp");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 50000 50010");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "APG_APGTCP")
      {
        this.Port_Name = "APG_APGTCP";
        this.DD_Name = ("APG_APGTCP" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " apg_apgtcp " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 5000 5022 5023");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " apg_apgtcp");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 50000 50010");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "MSC_S_CP")
      {
        this.Port_Name = "MSC_S_CP";
        this.DD_Name = ("MSC_S_CP" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " msc-s_cp_prot " + host_Name);
        this.lineConfigPort = (".config port address force_no_valu " + this.Port_Name);
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
      }
      else if (protocol == "NETCONF_PROT_SSH")
      {
        this.Port_Name = "NETCONF_PROT_SSH";
        this.DD_Name = ("NETCONF_PROT_SSH" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " netconf_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 community 3 %unique 3 %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " netconf_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "SNMP_SSH_PROT")
      {
        this.Port_Name = "SNMP_SSH_PROT";
        this.DD_Name = ("SNMP_SSH_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " snmp_ssh_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1|2 %unique %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " snmp_ssh_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "SNMP_SSH_FTP_PROT")
      {
        this.Port_Name = "SNMP_SSH_FTP_PROT";
        this.DD_Name = ("SNMP_SSH_FTP_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " snmp_ssh_ftp_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1 %unique %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = 
          (".config add external " + this.DD_Name + " snmp_ssh_ftp_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "SNMP")
      {
        this.Port_Name = "SNMP";
        this.DD_Name = ("SNMP" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " snmp " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1 %unique %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " snmp");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "TSP_PROT")
      {
        this.Port_Name = "TSP_PROT";
        this.DD_Name = ("TSP_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " tsp_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1 %unique 7423 %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " tsp_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "TSP_SSH_PROT")
      {
        this.Port_Name = "TSP_SSH_PROT";
        this.DD_Name = ("TSP_SSH_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " tsp_ssh_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1 %unique 7423 %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " tsp_ssh_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "HTTP_HTTPS_PORT")
      {
        this.Port_Name = "HTTP_HTTPS_PORT";
        this.DD_Name = ("HTTP_HTTPS_PORT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " http_https_port " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1 %unique 7423 %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " http_https_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "SNMP_TELNET_PROT")
      {
        this.Port_Name = "SNMP_TELNET_PROT";
        this.DD_Name = ("SNMP_TELNET_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " snmp_telnet_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1|2|3 %unique no_value %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = (".config add external " + this.DD_Name + " snmp_telnet_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "SNMP_SSH_TELNET_PROT")
      {
        this.Port_Name = "SNMP_SSH_TELNET_PROT";
        this.DD_Name = ("SNMP_SSH_TELNET_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " snmp_ssh_telnet_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 1161 public 1|2|3 %unique no_value %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = 
          (".config add external " + this.DD_Name + " snmp_ssh_telnet_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "APG_NETCONF_HTTP")
      {
        this.Port_Name = "APG_NETCONF_HTTP";
        this.DD_Name = ("APG_NETCONF_HTTP" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " apgtcp_netconf_https_http_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 161 public 1 %unique 3 5001 5000 52023 %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = 
          (".config add external " + this.DD_Name + " apgtcp_netconf_https_http_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "LANSWITCH_PROT")
      {
        this.Port_Name = "LANSWITCH_PROT";
        this.DD_Name = ("LANSWITCH_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " https_http_snmp_ssh " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 161 public 1|2|3 %unique no_value %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = 
          (".config add external " + this.DD_Name + " https_http_snmp_ssh");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 1");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
      else if (protocol == "MLPT_PROT")
      {
        this.Port_Name = "MLPT_PROT";
        this.DD_Name = ("MLPT_PROT" + createDefaultDestination);
        this.lineAddPort = 
          (".config add port " + this.Port_Name + " xrpc_snmp_ssh_http_prot " + host_Name);
        this.lineConfigPort = 
        
          (".config port address " + this.Port_Name + " " + this.createAddress[0] + "." + this.createAddress[1] + "." + this.createAddress[2] + ".0 161 public 1|2|3 %unique no_value %simname_%nename authpass privpass 2 2");
        buildPort(this.lineAddPort, this.lineConfigPort, this.Port_Name);
        
        this.lineAddDD = 
          (".config add external " + this.DD_Name + " xrpc_snmp_ssh_http_prot");
        this.lineConfigDD = 
          (".config external address " + this.DD_Name + " " + createDefaultDestination + " 162 2");
        buildDD(this.lineAddDD, this.lineConfigDD, this.DD_Name, host_Name);
      }
    }
    return new String[] { this.Port_Name, this.DD_Name };
  }
}
