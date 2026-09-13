package Logics.Streamization.Kingwar
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Kingwar.TPVPKingBet;
   import Logics.Kingwar.TPVPKingPlayer;
   import Logics.Kingwar.TPVPKingPlayers;
   import Logics.Kingwar.TPVPKingReport;
   import Logics.Kingwar.TPVPKingReports;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerKingwar extends TUnstreamizer
   {
      
      public function TUnstreamizerKingwar()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TPVPKingPlayers = null;
         var _loc7_:TPVPKingPlayer = null;
         _loc5_ = param1.readShort();
         _loc6_ = param2 as TPVPKingPlayers;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TPVPKingPlayer();
            this.UnstreamizationPVPKingPlayer(param1,_loc7_,null);
            _loc6_.Add(_loc7_);
            _loc4_++;
         }
      }
      
      public function UnstreamizationPVPKingPlayer(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPVPKingPlayer = null;
         _loc4_ = param2 as TPVPKingPlayer;
         _loc4_.AgentId = param1.readUnsignedInt();
         _loc4_.ServerId = param1.readUnsignedInt();
         _loc4_.Uid = param1.readDouble();
         _loc4_.Name = TUtilityString.FetchUTF(param1);
         _loc4_.Group = param1.readUnsignedInt();
         _loc4_.Pos = param1.readUnsignedInt() - 1;
         _loc4_.Rank = param1.readUnsignedInt();
         this.Unstreamize_Report(param1,_loc4_.PVPKingReports,null);
      }
      
      protected function Unstreamize_Report(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TPVPKingReport = null;
         var _loc7_:TPVPKingReports = null;
         _loc5_ = param1.readShort();
         _loc7_ = param2 as TPVPKingReports;
         _loc7_.Clear();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TPVPKingReport();
            _loc6_.ReportID = TUtilityString.FetchUTF(param1);
            _loc6_.FightType = param1.readUnsignedInt();
            _loc6_.Ack_Agent_Id = param1.readUnsignedInt();
            _loc6_.Ack_Server_Id = param1.readUnsignedInt();
            _loc6_.Ack_UserID = param1.readDouble();
            _loc6_.Ack_Name = TUtilityString.FetchUTF(param1);
            _loc6_.Def_Agent_Id = param1.readUnsignedInt();
            _loc6_.Def_Server_Id = param1.readUnsignedInt();
            _loc6_.Def_UserID = param1.readDouble();
            _loc6_.Def_Name = TUtilityString.FetchUTF(param1);
            _loc6_.IsWin = param1.readUnsignedInt();
            _loc7_.Add(_loc6_);
            _loc4_++;
         }
      }
      
      public function UnstreamizationPVPKingBet(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TPVPKingBet = null;
         var _loc7_:Vector.<TPVPKingBet> = null;
         _loc5_ = param1.readShort();
         _loc7_ = param2 as Vector.<TPVPKingBet>;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TPVPKingBet();
            _loc6_.AgentId = param1.readUnsignedInt();
            _loc6_.ServerId = param1.readUnsignedInt();
            _loc6_.Uid = param1.readDouble();
            _loc6_.Type = param1.readUnsignedInt();
            _loc6_.BetNum = param1.readUnsignedInt();
            _loc7_.push(_loc6_);
            _loc4_++;
         }
      }
   }
}

