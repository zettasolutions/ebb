using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;

namespace eBulletinBoard
{
    public partial class frmMain : Form
    {
        private int counter { get; set; }
        private Process process { get; set; }
        private WebClient webClient {get;set;}
        private int WS_Id { get; set; }
        private string ServerURL { get { return ConfigurationManager.AppSettings["ServerURL"].ToString(); } }
        private string DashBoardPage { get { return ConfigurationManager.AppSettings["DashBoardPage"].ToString(); } }
        private string currentRequest{get;set;}
        private bool isDebug { get; set; }
        private bool isClose { get; set; }

        public frmMain()
        {
            InitializeComponent();    
        }
        private void frmMain_Load(object sender, EventArgs e)
        {
            
            process = new Process();
            webClient = new WebClient();
            webClient.OpenReadCompleted += new OpenReadCompletedEventHandler(OpenReadCompleted);
            this.ProcessRequest("ebb_register", "p_ws_name=" + System.Environment.MachineName + "&p_macadd=" + Util.GetMacAddress(),true);
        }


        private void ProcessRequest(string procedure,string parameters, bool Async) {
            string p="";
            if (parameters != "") p = "?" + parameters;
            currentRequest = this.ServerURL + procedure + p;
            if (Async == true){
                webClient.OpenReadAsync(new Uri(currentRequest));

            }
            else{
                webClient.OpenRead(currentRequest);
            }
        }

        public void GetSignalData()
        {
          this.ProcessRequest("ebb_getjob", "p_ws_id=" + WS_Id,true);

        }

        void OpenReadCompleted(object sender, OpenReadCompletedEventArgs e)
        {
            if (this.isClose==true ) return;
            if (e.Error == null)
            {

                StreamReader reader = new StreamReader(e.Result);
                string text = reader.ReadToEnd();

                MessageData m = JsonConvert.DeserializeObject<MessageData>(text);

                if (this.isDebug == true)
                {
                    if (m.Code != "")
                    {
                        counter++;
                        textBox1.AppendText("\r\n Counter:" + counter + " " + text);
                    }
                }


                if (m != null)
                {
                    switch (m.Code.ToUpper())
                    {
                        case "ALERT":
                            new frmBrowser(ServerURL + DashBoardPage).Show();
                            break;

                        case "DEBUG":
                            if (m.Msg.ToUpper() == "TRUE")
                            {
                                this.WindowState = FormWindowState.Normal;
                                this.Visible = true;
                                isDebug = true;
                            }
                            else
                            {
                                this.WindowState = FormWindowState.Minimized;
                                this.Visible = false;
                                isDebug = false;
                            }

                            this.ProcessRequest("ebb_wsresponse", "p_ws_id=" + WS_Id + "&p_job_id=" + m.Job_Id, true);
                            
                            break;

                        case "WSID": WS_Id = Convert.ToInt32(m.Msg);
                            break;

                        case "CLOSEAPP":
                            this.isClose = true;
                            this.ProcessRequest("ebb_wsresponse", "p_ws_id=" + WS_Id + "&p_job_id=" + m.Job_Id, true);
                            System.Threading.Thread.Sleep(1000);
                            this.Close();
                            break;

                        case "JOBCOMPLETED":
                            break;

                        default:
                            break;
                    }
                }
            }
           else {
               this.ProcessRequest("ebb_wsresponse", "p_ws_id=" + WS_Id + "&p_ws_response=" + e.Error.ToString() + "&p_ws_url=" + currentRequest, true);
           }
            tmrMessage.Enabled = true;
        }


        private void tmrMessage_Tick(object sender, EventArgs e)
        {
           // showHide();

            GetSignalData();
            tmrMessage.Enabled = false;
        }

        private void showHide() {
            if (this.isDebug == true)
            {
                this.WindowState = FormWindowState.Normal;
                this.Show();
                isDebug = true;
            }
            else
            {
                this.WindowState = FormWindowState.Minimized;
                this.Visible = false;
                isDebug = false;
            }
        }

    }
}