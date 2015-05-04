using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBulletinBoard
{
    public class Process
    {
        public void RunProcess(string data)
        {
            string arguments = "";
            string processFile = "";
            int argStart = data.Trim().IndexOf(" ");
            System.Diagnostics.Process p = new System.Diagnostics.Process();

            if (data.ToLower().Contains("http"))
            {
                new frmBrowser(data).Show();
            }
            else
            {
                if (argStart > -1)
                {
                    processFile = data.Substring(0, argStart);
                    arguments = data.Substring(argStart + 1);

                    p.StartInfo.RedirectStandardInput = true;
                    p.StartInfo.RedirectStandardOutput = true;
                    p.StartInfo.RedirectStandardError = true;
                    p.StartInfo.UseShellExecute = false;
                    p.StartInfo.CreateNoWindow = true;
                    p.EnableRaisingEvents = true;
                    p.OutputDataReceived += new System.Diagnostics.DataReceivedEventHandler(Process_OutputDataReceived);
                    p.ErrorDataReceived += new System.Diagnostics.DataReceivedEventHandler(Process_ErrorDataReceived);
                    p.Exited += new EventHandler(Process_Exited);

                    p.StartInfo.FileName = processFile;
                    p.StartInfo.Arguments = arguments;
                }
                else
                {
                    p.StartInfo.FileName = data.Trim();
                }
                p.Start();
            }
        }
        void Process_OutputDataReceived(object sender, System.Diagnostics.DataReceivedEventArgs e)
        {
            if (e.Data != null)
            {
                if (e.Data.Trim() != "")
                {
                }
            }
        }

        void Process_ErrorDataReceived(object sender, System.Diagnostics.DataReceivedEventArgs e)
        {
            if (e.Data != null)
            {
                if (e.Data.Trim() != "")
                {
                }
            }
        }
        void Process_Exited(object sender, EventArgs e) { }

    }
}
