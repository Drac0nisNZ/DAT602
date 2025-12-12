using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;

namespace Sapo_players
{
    internal class clsLoginDAO : DatabaseAccessObject
    {
        public LoginState Login(string pPlayerName, string pPassword)
        {
            LoginState result = LoginState.Fail;

            // Build MySQL parameter list
            var parameters = new List<MySqlParameter>()
            {
                new MySqlParameter("@PlayerName", MySqlDbType.VarChar) { Value = pPlayerName },
                new MySqlParameter("@Password", MySqlDbType.VarChar) { Value = pPassword }
            };

            // Execute stored procedure
            DataSet ds = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL Login(@PlayerName, @Password)", parameters.ToArray());

            // Validate result
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                string message = Convert.ToString(row["Message"]);

                switch (message)
                {
                    case "Logged In":
                        result = LoginState.Success;
                        break;

                    case "Locked Out":
                        result = LoginState.Locked_out;
                        break;

                    default:
                        result = LoginState.Fail;
                        break;
                }
            }

            return result;
        }
    }
}
