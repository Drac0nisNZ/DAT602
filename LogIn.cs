using System;
using System.Windows.Forms;

namespace Sapo_players
{
    public partial class LogIn : Form
    {
        public LogIn()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string lc_name = txtName.Text;
            string lc_pass = txtPassword.Text;
            clsLoginDAO dbaccess = new clsLoginDAO();

            // ✅ Call the Login method and store the result
            LoginState result = dbaccess.Login(lc_name, lc_pass);

            // ✅ Compare the result to enum values
            if (result == LoginState.Success)
            {
                MessageBox.Show("Login successful!");
                this.Hide();
                AdminForm admin = new AdminForm(this);
                admin.Show();
            }
            else if (result == LoginState.Locked_out)
            {
                MessageBox.Show("Account locked out. Too many failed attempts.");
            }
            else
            {
                MessageBox.Show("Invalid login. Try again.");
            }
        }

        private void LogIn_Load(object sender, EventArgs e)
        {
        }
    }
}
