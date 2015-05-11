using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using System.Configuration;
namespace eBulletinBoard
{
    public partial class frmBrowser : Form
    {
        public string url { get; set; }
        
        private Boolean isLocalDebug { get { return Convert.ToBoolean(ConfigurationManager.AppSettings["isLocalDebug"].ToString()); } }
        private frmMain frmMain {get;set;}

        public void Show(bool isShow){
            this.Visible = isShow;
        }


        public frmBrowser()
        {
            InitializeComponent();
        }

        public frmBrowser(frmMain mainForm, string url)
        {
            this.frmMain = mainForm;
            InitializeComponent();
            wb.Navigate(url);
            if (isLocalDebug == false) this.TopMost = true;
        }
        


        private void wb_Navigated(object sender, WebBrowserNavigatedEventArgs e)
        {
           // tmr.Enabled = true;
        }

        private void tmr_Tick(object sender, EventArgs e)
        {
            //this.ControlBox = true;
           // tmr.Enabled = false; 
        }

        private void frmBrowser_Load(object sender, EventArgs e)
        {
            if (isLocalDebug == false) this.TopMost = true;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            frmMain.isReading = false;
            this.Close();
        }
    }
}
