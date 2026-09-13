package Logics.Kingwar
{
   public class TPVPKingPlayer
   {
      
      public var AgentId:int;
      
      public var ServerId:int;
      
      public var Uid:Number;
      
      public var Name:String;
      
      public var Group:int;
      
      public var Pos:int;
      
      public var Rank:int;
      
      public var PVPKingReports:TPVPKingReports;
      
      public function TPVPKingPlayer()
      {
         super();
         this.PVPKingReports = new TPVPKingReports();
      }
      
      public function Clone() : TPVPKingPlayer
      {
         var _loc1_:TPVPKingPlayer = null;
         _loc1_ = new TPVPKingPlayer();
         _loc1_.AgentId = this.AgentId;
         _loc1_.ServerId = this.ServerId;
         _loc1_.Uid = this.Uid;
         _loc1_.Name = this.Name;
         _loc1_.Group = this.Group;
         _loc1_.Pos = this.Pos;
         _loc1_.AgentId = this.AgentId;
         _loc1_.Rank = this.Rank;
         _loc1_.PVPKingReports = this.PVPKingReports;
         return _loc1_;
      }
   }
}

