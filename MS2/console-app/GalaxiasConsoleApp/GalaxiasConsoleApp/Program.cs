﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GalaxiasConsoleApp

{
    class Program
    {
        static void Main(string[] args)
        {
            bool startGalaxias = true;
            while (startGalaxias)
            {
                startGalaxias = Galaxias();
            }
        }

        private static bool Galaxias()
        {
            Console.Clear();
            Console.WriteLine("=================================================");
            Console.WriteLine("     galaxias\t\ttest console");
            Console.WriteLine("=================================================");
            Console.WriteLine("\nChoose an option:");
            // Console.WriteLine("-------------------------------------------------");
            Console.WriteLine("\t1  - pilot registration");
            Console.WriteLine("\t2  - pilot login");
            Console.WriteLine("\t3  - pilot logout");
            Console.WriteLine("\t4  - pilot Delete");
            Console.WriteLine("\t5  - new galaxy");
            Console.WriteLine("\t6  - join galaxy");
            Console.WriteLine("\t7  - pilot Move");
            // Console.WriteLine("\t8  - User Chat");
            Console.WriteLine("\t9  - leave galaxy");
            Console.WriteLine("\t10 - admin adds pilot");
            Console.WriteLine("\t11 - admin modifies pilot");
            Console.WriteLine("\t12 - admin deletes pilot");
            Console.WriteLine("\t13 - admin kills galaxy");
            Console.WriteLine("\t14 - high scores");
            Console.WriteLine("\t15 - pilot List");
            Console.WriteLine("\t16 - pilot Inventory");
            Console.WriteLine("-------------------------------------------------");
            Console.Write("\r\nSelect an option: ");


            switch (Console.ReadLine())
            {
                default:
                    return true;
                case "1":
                    PilotRegistration();
                    return true;
                case "2":
                    PilotLogin();
                    return true;
                case "3":
                    PilotLogout();
                    return true;
                case "4":
                    PilotDelete();
                    return true;
                case "5":
                    NewGalaxy();
                    return true;
                case "6":
                    JoinGalaxy();
                    return true;
                case "7":
                    PilotMove();
                    return true;
                // case "8":
                //     UserChat();
                //     return true;
                case "9":
                    LeaveGalaxy();
                    return true;
                case "10":
                    AdminAdd();
                    return true;
                case "11":
                    AdminModify();
                    return true;
                case "12":
                    AdminDelete();
                    return true;
                case "13":
                    AdminKill();
                    return true;
                case "14":
                    GetHighScores();
                    return true;
                case "15":
                    GetAllPilots();
                    return true;
                case "16":
                    GetPilotInventory();
                    return true;
            }
        }

        private static void PilotRegistration()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\n pilot registration");
            Console.WriteLine("=================================================");
            Console.WriteLine("registration = " + dataAccess.PilotRegistration("phill", "1234", "phill@phill.com"));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void PilotLogin()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\npilot login");
            Console.WriteLine("=================================================");
            Console.WriteLine("login = " + dataAccess.PilotLogin("phill", "1234"));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void PilotLogout()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\npilot logout");
            Console.WriteLine("=================================================");
            Console.WriteLine("logout = " + dataAccess.PilotLogout("7"));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void PilotDelete()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\npilot delete");
            Console.WriteLine("=================================================");
            Console.WriteLine("delete = " + dataAccess.PilotDelete("GuaWaZi", "1234"));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void NewGalaxy()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nnew galaxy");
            Console.WriteLine("=================================================");
            Console.WriteLine("new galaxy = " + dataAccess.NewGalaxy(7, "0000005"));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void JoinGalaxy()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\njoin galaxy");
            Console.WriteLine("=================================================");
            Console.WriteLine("join galaxy = " + dataAccess.JoinGalaxy(10, 2));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void PilotMove()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\npilot move");
            Console.WriteLine("=================================================");
            Console.WriteLine("pilot move = " + dataAccess.PilotMove(2, 3, 1, 2));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        // private static void PilotChat()
        // {
        //     DataAccess dataAccess = new DataAccess();
        //
        //     Console.WriteLine("\nTesting User Chat");
        //     Console.WriteLine("=================================================");
        //     Console.WriteLine("Chat = " + dataAccess.UserChat(1, 1, "I love WizardQuest!"));
        //     Console.WriteLine("-------------------------------------------------");
        //     Pause();
        // }

        private static void LeaveGalaxy()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nleave galaxy");
            Console.WriteLine("=================================================");
            Console.WriteLine("leave galaxy = " + dataAccess.LeaveGalaxy(1, 1));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void AdminAdd()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nadmin add pilot");
            Console.WriteLine("=================================================");
            Console.WriteLine("admin add pilot = " + dataAccess.AdminAdd("Jono", "1234", "jono@jono.com", false));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void AdminModify()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nadmin modify pilot");
            Console.WriteLine("=================================================");
            Console.WriteLine("admin modify pilot = " + dataAccess.AdminModify(3, "Sally", "1234", "sally@emailaddress.com", 0, false, true, 1000));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void AdminDelete()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nadmin delete pilot");
            Console.WriteLine("=================================================");
            Console.WriteLine("admin delete pilot = " + dataAccess.AdminDelete(10));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void AdminKill()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nadmin kill galaxy");
            Console.WriteLine("=================================================");
            Console.WriteLine("admin kill galaxy = " + dataAccess.AdminKill(1));
            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void GetAllPilots()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nget all pilots");
            Console.WriteLine("=================================================");
            Console.WriteLine("\tname");
            Console.WriteLine("-------------------------------------------------");

            foreach (var pilot in dataAccess.GetAllPilots())
            {
                Console.WriteLine("\t" + pilot.PilotName);
            }

            Console.WriteLine("-------------------------------------------------");
            Pause();
        }
        private static void GetHighScores()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nget high scores");
            Console.WriteLine("=================================================");
            Console.WriteLine("\tpilot \t\t total score");
            Console.WriteLine("-------------------------------------------------");

            foreach (var score in dataAccess.GetHighScores())
            {
                Console.WriteLine("\t" + score.PilotName + " \t\t\t " + score.TotalScore);
            }

            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void GetPilotInventory()
        {
            DataAccess dataAccess = new DataAccess();

            Console.WriteLine("\nTesting Get User Inventory");
            Console.WriteLine("=================================================");
            Console.WriteLine("\tItem \t\t\tQuantity");
            Console.WriteLine("-------------------------------------------------");

            foreach (var item in dataAccess.GetPilotInventory(2))
            {
                Console.WriteLine("\t" + item.Item + " \t\t    " + item.Quantity);
            }

            Console.WriteLine("-------------------------------------------------");
            Pause();
        }

        private static void Pause()
        {
            Console.WriteLine("\npress any key to exit the process...");
            Console.ReadKey();
        }
    }
}