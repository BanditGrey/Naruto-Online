package Processors.Game.Lobby.Exercise.WorldCup
{
   import Foundation.Network.TPacket;
   import Logics.SLogicsCore;
   
   public class TProcessorActivityLevelManager
   {
      
      public static const ACTIVITY_LEVEL:Array = [{
         "IDS":[2,3,4,5,11,12,13,14,16,17,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,1000,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026],
         "Level":30
      }];
      
      private static var _activityLevels:Array = [];
      
      private static var _callback:Function = null;
      
      public function TProcessorActivityLevelManager()
      {
         super();
      }
      
      public static function verifyActivityLevel(param1:uint, param2:TPacket, param3:Boolean = true, param4:Function = null) : Boolean
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         if(param4 != null)
         {
            _callback = param4;
         }
         for each(_loc5_ in ACTIVITY_LEVEL)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.IDS.length)
            {
               if(param1 == _loc5_.IDS[_loc6_] && SLogicsCore.Character.MainHero.Level < _loc5_.Level)
               {
                  if(param3)
                  {
                     _activityLevels.push({
                        "ActivityID":param1,
                        "Packet":param2
                     });
                  }
                  return false;
               }
               _loc6_++;
            }
         }
         return true;
      }
      
      public static function levelChange() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < _activityLevels.length)
         {
            if(verifyActivityLevel(_activityLevels[_loc1_].ActivityID,_activityLevels[_loc1_].Packet,false))
            {
               _loc2_ = _activityLevels.splice(_loc1_,1)[0];
               if(_callback != null)
               {
                  _callback(_loc2_.Packet);
               }
            }
            _loc1_++;
         }
      }
   }
}

