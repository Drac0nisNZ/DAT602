using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Sapo_players
{
    public partial class AdminForm : Form
    {
        private LogIn _theLoginForm;
        public AdminForm(LogIn pLoginForm)
        {
            _theLoginForm = pLoginForm;
            InitializeComponent();
        }

        private void AdminForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            _theLoginForm.Show();
        }
    }
}
