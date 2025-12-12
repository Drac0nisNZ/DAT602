using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MySql.Data.MySqlClient;

namespace Sapo_players

{ 
    class DataAccess
    {
        private static string connectionString
        {
            get { return "Server=localhost;Port=3306;Database=sapodb;Uid=sapo;password=53211;"; }

        }

        private static MySqlConnection _mySqlConnection = null;
        public static MySqlConnection mySqlConnection
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
        public string AddPlayerName(string pPlayerName)
        {

            List<MySqlParameter> p = new List<MySqlParameter>();
            var aP = new MySqlParameter("@PlayerName", MySqlDbType.VarChar, 50);
            aP.Value = pPlayerName;
            p.Add(aP);


            var aDataSet = MySqlHelper.ExecuteDataset(DataAccess.mySqlConnection, "AddPlayerName(@PlayerName)", p.ToArray());

            // expecting one table with one row
            return (aDataSet.Tables[0].Rows[0])["MESSAGE"].ToString();
        }

        public List<Player> GetAllPlayers()
        {
            List<Player> lcPlayers = new List<Player>();

            var aDataSet = MySqlHelper.ExecuteDataset(DataAccess.mySqlConnection, "call GetAllPlayers()");
            lcPlayers = (from aResult in
                                    System.Data.DataTableExtensions.AsEnumerable(aDataSet.Tables[0])
                         select
                            new Player
                            {
                                PlayerName = aResult["PlayerName"].ToString(),
                                Health = Convert.ToInt32(aResult["Health"]),
                                row = Convert.ToInt32(aResult["row"]),
                                Col = Convert.ToInt32(aResult["Col"])
                            }).ToList();
            return lcPlayers;
        }
    }

}
