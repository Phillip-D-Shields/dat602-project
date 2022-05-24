using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GalaxiasConsoleApp;

public class Pilot
{
    public static Pilot CurrentPilot { get; set; }
    public string PilotName;
    public int TotalScore;
}