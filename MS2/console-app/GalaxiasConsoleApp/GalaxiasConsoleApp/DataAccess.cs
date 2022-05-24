using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GalaxiasConsoleApp;

public class DataAccess
{
    private static string _connectionString = "Server=localhost;Port=3306;Database=Galaxias;Uid=root;password=password;";
        private static MySqlConnection _mySqlConnection = null;
        
        public static MySqlConnection MySqlConnection
        {
            get
            {
                if(_mySqlConnection == null)
                {
                    _mySqlConnection = new MySqlConnection(_connectionString);
                }

                return _mySqlConnection;
            }
        }

        public static MySqlConnection Conn = new MySqlConnection("Server=localhost;Port=3306;Database=Galaxias;Uid=root;password=password;");

        public string CheckPilotName(string pPilotName)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotName = new MySqlParameter("@PilotName", MySqlDbType.VarChar, 30);
            pilotName.Value = pPilotName;
            parameterList.Add(pilotName);

            var checkPilotNameDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "CheckPilotName(@PilotName)", parameterList.ToArray());
            return (checkPilotNameDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string PilotRegistration(string pPilotName, string pPilotPassword, string pEmail)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var PilotName = new MySqlParameter("PilotName", MySqlDbType.VarChar, 30);
            var PilotPassword = new MySqlParameter("PilotPassword", MySqlDbType.VarChar, 20);
            var Email = new MySqlParameter("Email", MySqlDbType.VarChar, 50);
            PilotName.Value = pPilotName;
            PilotPassword.Value = pPilotPassword;
            Email.Value = pEmail;
            parameterList.Add(PilotName);
            parameterList.Add(PilotPassword);
            parameterList.Add(Email);

            var pilotRegistrationDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call pilotRegistration(@PilotName, @PilotPassword, @Email)", parameterList.ToArray());
            return (pilotRegistrationDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string PilotLogin(string pPilotName, string pPilotPassword)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotName = new MySqlParameter("PilotName", MySqlDbType.VarChar, 30);
            var pilotPassword = new MySqlParameter("PilotPassword", MySqlDbType.VarChar, 20);
            pilotName.Value = pPilotName;
            pilotPassword.Value = pPilotPassword;
            parameterList.Add(pilotName);
            parameterList.Add(pilotPassword);

            var pilotLoginDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call pilotLogin(@PilotName, @PilotPassword)", parameterList.ToArray());
            return (pilotLoginDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string PilotLogout(string pPilotID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            pilotID.Value = pPilotID;
            parameterList.Add(pilotID);

            var pilotLogoutDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call pilotLogout(@PilotID)", parameterList.ToArray());
            return (pilotLogoutDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string PilotDelete(string pPilotName, string pPilotPassword)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotName = new MySqlParameter("PilotName", MySqlDbType.VarChar, 30);
            var pilotPassword = new MySqlParameter("PilotPassword", MySqlDbType.VarChar, 20);
            pilotName.Value = pPilotName;
            pilotPassword.Value = pPilotPassword;
            parameterList.Add(pilotName);
            parameterList.Add(pilotPassword);

            var pilotDeleteDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call pilotDelete(@PilotName, @PilotPassword)", parameterList.ToArray());
            return (pilotDeleteDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string NewGalaxy(int pPilotID, string pGalaxyName)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            var galaxyName = new MySqlParameter("GalaxyName", MySqlDbType.VarChar, 50);
            pilotID.Value = pPilotID;
            galaxyName.Value = pGalaxyName;
            parameterList.Add(pilotID);
            parameterList.Add(galaxyName);

            var newGalaxyDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call newGalaxy(@PilotID, @GalaxyName)", parameterList.ToArray());
            return (newGalaxyDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string JoinGalaxy(int pPilotID, int pGalaxyID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            var galaxyID = new MySqlParameter("GalaxyID", MySqlDbType.Int16);
            pilotID.Value = pPilotID;
            galaxyID.Value = pGalaxyID;
            parameterList.Add(pilotID);
            parameterList.Add(galaxyID);

            var joinGalaxyDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call joinGalaxy(@PilotID, @GalaxyID)", parameterList.ToArray());
            return (joinGalaxyDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string PilotMove(int pExploreID, int pPilotID, int pxPosition, int pyPosition)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var exploreID = new MySqlParameter("exploreID", MySqlDbType.Int16);
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            var xPosition = new MySqlParameter("xPosition", MySqlDbType.Int16);
            var yPosition = new MySqlParameter("yPosition", MySqlDbType.Int16);
            exploreID.Value = pExploreID;
            pilotID.Value = pPilotID;
            xPosition.Value = pxPosition;
            yPosition.Value = pyPosition;
            parameterList.Add(exploreID);
            parameterList.Add(pilotID);
            parameterList.Add(xPosition);
            parameterList.Add(yPosition);

            var pilotMoveDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call pilotMove(@ExploreID, @PilotID, @xPosition, @yPosition)", parameterList.ToArray());
            return (pilotMoveDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        // public string UserChat(int pPilotID, int pGalaxyID, string pMessage)
        // {
        //     List<MySqlParameter> parameterList = new List<MySqlParameter>();
        //     var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
        //     var questID = new MySqlParameter("GalaxyID", MySqlDbType.Int16);
        //     var message = new MySqlParameter("Message", MySqlDbType.VarChar, 255);
        //     pilotID.Value = pPilotID;
        //     questID.Value = pGalaxyID;
        //     message.Value = pMessage;
        //     parameterList.Add(pilotID);
        //     parameterList.Add(questID);
        //     parameterList.Add(message);
        //
        //     var userChatDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call userChat(@UserID, @QuestID, @Message)", parameterList.ToArray());
        //     return (userChatDataSet.Tables[0].Rows[0])["message"].ToString();
        // }

        public string LeaveGalaxy(int pPilotID, int pGalaxyID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            var galaxyID = new MySqlParameter("GalaxyID", MySqlDbType.Int16);
            pilotID.Value = pPilotID;
            galaxyID.Value = pGalaxyID;
            parameterList.Add(pilotID);
            parameterList.Add(galaxyID);

            var leaveGalaxyDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call leaveGalaxy(@PilotID, @GalaxyID)", parameterList.ToArray());
            return (leaveGalaxyDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string AdminAdd(string pPilotName, string pPilotPassword, string pEmail, bool pAdmin)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotName = new MySqlParameter("PilotName", MySqlDbType.VarChar, 30);
            var pilotPassword = new MySqlParameter("PilotPassword", MySqlDbType.VarChar, 20);
            var email = new MySqlParameter("Email", MySqlDbType.VarChar, 50);
            var admin = new MySqlParameter("Administrator", MySqlDbType.Bit);
            pilotName.Value = pPilotName;
            pilotPassword.Value = pPilotPassword;
            email.Value = pEmail;
            admin.Value = pAdmin;
            parameterList.Add(pilotName);
            parameterList.Add(pilotPassword);
            parameterList.Add(email);
            parameterList.Add(admin);

            var adminAddDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call adminAdd(@PilotName, @PilotPassword, @Email, @Admin)", parameterList.ToArray());
            return (adminAddDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string AdminModify(int pPilotID, string pPilotName, string pPilotPassword, string pEmail, int pLoginAttempts, bool pPilotLocked, bool pAdmin, int pTotalScore)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            var pilotName = new MySqlParameter("PilotName", MySqlDbType.VarChar, 30);
            var pilotPassword = new MySqlParameter("PilotPassword", MySqlDbType.VarChar, 20);
            var email = new MySqlParameter("Email", MySqlDbType.VarChar, 50);
            var logAttempts = new MySqlParameter("LoginAttempts", MySqlDbType.Int16);
            var pilotLocked = new MySqlParameter("PilotLocked", MySqlDbType.Bit);
            var admin = new MySqlParameter("Administrator", MySqlDbType.Bit);
            var totalScore = new MySqlParameter("TotalScore", MySqlDbType.Int16);
            pilotID.Value = pPilotID;
            pilotName.Value = pPilotName;
            pilotPassword.Value = pPilotPassword;
            email.Value = pEmail;
            logAttempts.Value = pLoginAttempts;
            pilotLocked.Value = pPilotLocked;
            admin.Value = pAdmin;
            totalScore.Value = pTotalScore;
            parameterList.Add(pilotID);
            parameterList.Add(pilotName);
            parameterList.Add(pilotPassword);
            parameterList.Add(email);
            parameterList.Add(logAttempts);
            parameterList.Add(pilotLocked);
            parameterList.Add(admin);
            parameterList.Add(totalScore);

            var adminModifyDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call administratorModify(@PilotID, @PilotName, @PilotPassword, @Email, @LoginAttempts, @PilotLocked, @Administrator, @TotalScore)", parameterList.ToArray());
            return (adminModifyDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string AdminDelete(int pPilotID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var pilotID = new MySqlParameter("PilotID", MySqlDbType.Int16);
            pilotID.Value = pPilotID;
            parameterList.Add(pilotID);

            var adminDeleteDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call adminDelete(@PilotID)", parameterList.ToArray());
            return (adminDeleteDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public string AdminKill(int pGalaxyID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var galaxyID = new MySqlParameter("GalaxyID", MySqlDbType.Int16);
            galaxyID.Value = pGalaxyID;
            parameterList.Add(galaxyID);

            var adminKillDataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call administratorKill(@GalaxyID)", parameterList.ToArray());
            return (adminKillDataSet.Tables[0].Rows[0])["message"].ToString();
        }

        public List<Pilot> GetAllPilots()
        {
            List<Pilot> pilots;

            var dataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call getAllPilots()");
            pilots = (from result in dataSet.Tables[0].AsEnumerable()
                     select
                        new Pilot
                        {
                            PilotName = result.Field<string>("PilotName")
                        }).ToList();
            return pilots;
        }

        public List<Inventory> GetPilotInventory(int pExplorePlayID)
        {
            List<MySqlParameter> parameterList = new List<MySqlParameter>();
            var explorePlayID = new MySqlParameter("@ExplorePlayID", MySqlDbType.Int16);
            explorePlayID.Value = pExplorePlayID;
            parameterList.Add(explorePlayID);

            List<Inventory> items;

            var dataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call getPilotInventory(@ExploreID)", parameterList.ToArray());
            items = (from result in dataSet.Tables[0].AsEnumerable()
                     select
                        new Inventory
                        {
                            Item = result.Field<string>("Item"),
                            Quantity = result.Field<int>("Quantity")
                        }).ToList();
            return items;
        }

        public List<Pilot> GetHighScores()
        {
            List<Pilot> pilots;

            var dataSet = MySqlHelper.ExecuteDataset(DataAccess.MySqlConnection, "call getHighScores()");
            pilots = (from result in dataSet.Tables[0].AsEnumerable()
                     select
                        new Pilot
                        {
                            PilotName = result.Field<string>("PilotName"),
                            TotalScore = result.Field<int>("TotalScore")
                        }).ToList();
            return pilots;
        }

}