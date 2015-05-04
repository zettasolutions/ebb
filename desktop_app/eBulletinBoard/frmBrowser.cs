using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace eBulletinBoard
{
    public partial class frmBrowser : Form
    {
        public frmBrowser()
        {
            InitializeComponent();
        }        
        public frmBrowser(string url)
        {
            InitializeComponent();
            wb.Navigate(url);
           
        }

        private void wb_Navigated(object sender, WebBrowserNavigatedEventArgs e)
        {
            tmr.Enabled = true;
        }

        private void tmr_Tick(object sender, EventArgs e)
        {
            this.ControlBox = true;
            tmr.Enabled = false; 
        }
    }
}
