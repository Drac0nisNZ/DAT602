using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using MySql.Data.MySqlClient;

namespace Sapo_players
{
    class clsPlayerDAO : DatabaseAccessObject
    {



        public List<Player> GetAllPlayers()
        {
            List<Player> lcPlayers = new List<Player>();

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "call GetAllPlayers()");
            lcPlayers = (from aResult in
                                    System.Data.DataTableExtensions.AsEnumerable(aDataSet.Tables[0])
                         select
                            new Player
                            {
                                Name = Convert.ToString(aResult["Name"]),
                                Strength = Convert.ToInt32(aResult["Strength"]),
                                TileID = Convert.ToInt32(aResult["TileID"]),
                            }).ToList();
            foreach(Player player in lcPlayers)
            {
                if(player.Name == Player.CurrentPlayer.Name)
                {
                    Player.CurrentPlayer = player;
                }
            }
            return lcPlayers;
        }

        public List<Tile> GetAllTiles(PlayerGameBoard theForm)
        {
            List<Tile> lcTiles = new List<Tile>();

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "call GetAllTiles()");
            lcTiles = (from aResult in
                                    System.Data.DataTableExtensions.AsEnumerable(aDataSet.Tables[0])
                       select
                          new Tile
                          {
                              Id = Convert.ToInt32(aResult["id"]),
                              Row = Convert.ToInt32(aResult["Row"]),
                              Col = Convert.ToInt32(aResult["col"]),
                              jewel = Convert.ToInt32(aResult["jewel"]),
                              thorn = Convert.ToInt32(aResult["thorn"]),
                              tile_form = theForm
                          }).ToList();
            return lcTiles;
        }

        public void Update(String pPlayerName, int pTile, int pStrength)
        {
            List<MySqlParameter> p = new List<MySqlParameter>();

            var aP = new MySqlParameter("@PlayerName", MySqlDbType.VarChar, 255);
            aP.Value = pPlayerName;
            p.Add(aP);

            var bP = new MySqlParameter("@Tile", MySqlDbType.Int32);
            bP.Value = pTile;
            p.Add(bP);

            var cP = new MySqlParameter("@Strength", MySqlDbType.Int32);
            cP.Value = pStrength;
            p.Add(cP);

            var aDataSet = MySqlHelper.ExecuteDataset(mySqlConnection, "CALL UpdatePlayer(@PlayerName, @Tile,@Strength)", p.ToArray());




        }


    }
}
