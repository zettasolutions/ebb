using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBulletinBoard
{
    public class Util
    {

        public static string GetMacAddress()
        {
            string macAddresses = "";
            foreach (System.Net.NetworkInformation.NetworkInterface nic in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces())
            {

                //if (nic.NetworkInterfaceType != System.Net.NetworkInformation.NetworkInterfaceType.Ethernet) continue;
                if (nic.OperationalStatus == System.Net.NetworkInformation.OperationalStatus.Up)
                {
                    macAddresses += nic.GetPhysicalAddress().ToString();
                    if (macAddresses != "") break;
                }
            }
            return macAddresses;
        }

        public static string GetAllMacAddress()
        {

            string macAddresses = "";

            foreach (System.Net.NetworkInformation.NetworkInterface nic in System.Net.NetworkInformation.NetworkInterface.GetAllNetworkInterfaces())
            {
                string macAddress = nic.GetPhysicalAddress().ToString();
                if (macAddress != "" && macAddress.Contains("000E0") == false)
                {
                    if (macAddresses != "") macAddresses += ",";
                    macAddresses += string.Format("'{0}'", macAddress);
                }
            }
            return macAddresses;
        }
    }
}
