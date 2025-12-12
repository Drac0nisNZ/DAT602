using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MySql.Data.MySqlClient;


namespace Sapo_players
{
    class DatabaseAccessObject
    {
        private static string connectionString
        {
            get { return "Server=localhost;Port=3306;Database=sapodb;Uid=sapo;password=53211;"; }

        }

        private static MySqlConnection _mySqlConnection = null;
        protected  MySqlConnection mySqlConnection
        {
            get
            {
                if (_mySqlConnection == null)
                {
                    _mySqlConnection = new MySqlConnection(connectionString);
                }

                return _mySqlConnection;

            }
        }

    }

}

