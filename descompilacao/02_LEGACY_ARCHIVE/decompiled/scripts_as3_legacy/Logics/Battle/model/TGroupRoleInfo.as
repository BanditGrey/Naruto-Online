package Logics.Battle.model
{
   import Debugging.*;
   import flash.utils.*;
   
   public class TGroupRoleInfo
   {
      
      protected var FMountsId:int;
      
      protected var FMountsLevel:int;
      
      protected var FCamp:int;
      
      protected var FRoleBattleInfos:Vector.<TRoleBattleInfo>;
      
      public var SoulFormationID:int;
      
      public var EmblemId:int;
      
      public var RingId:int;
      
      public var UserId:String;
      
      public function TGroupRoleInfo(param1:int)
      {
         super();
         this.FCamp = param1;
         this.FRoleBattleInfos = new Vector.<TRoleBattleInfo>();
      }
      
      public function get MountsId() : int
      {
         return this.FMountsId;
      }
      
      public function set MountsId(param1:int) : void
      {
         this.FMountsId = param1;
      }
      
      public function get MountsLevel() : int
      {
         return this.FMountsLevel;
      }
      
      public function set MountsLevel(param1:int) : void
      {
         this.FMountsLevel = param1;
      }
      
      public function get Camp() : int
      {
         return this.FCamp;
      }
      
      public function set Camp(param1:int) : void
      {
         this.FCamp = param1;
      }
      
      public function get RoleBattleInfos() : Vector.<TRoleBattleInfo>
      {
         return this.FRoleBattleInfos;
      }
      
      public function get RoleCount() : int
      {
         return this.FRoleBattleInfos.length;
      }
      
      public function GetSkillById(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FRoleBattleInfos.length)
         {
            if(this.FRoleBattleInfos[_loc2_].RoleId == param1)
            {
               return this.FRoleBattleInfos[_loc2_].SkillId;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function SetDataByObj(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TRoleBattleInfo = null;
         this.FMountsId = param1.MountsId;
         this.FMountsLevel = param1.MountsLevel;
         this.FCamp = param1.Camp;
         _loc2_ = int(param1.RoleCount);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new TRoleBattleInfo(this.FCamp);
            _loc4_.SetDataByObj(param1.RoleBattleInfo["Role" + _loc3_]);
            this.FRoleBattleInfos.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function toString() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc2_ = "{";
         _loc1_ = 0;
         while(_loc1_ < this.FRoleBattleInfos.length)
         {
            _loc2_ += "\n\t" + " \"Role" + _loc1_ + "\":" + this.FRoleBattleInfos[_loc1_].toString();
            if(_loc1_ != this.FRoleBattleInfos.length - 1)
            {
               _loc2_ += ",";
            }
            _loc1_++;
         }
         _loc2_ += "}";
         return " { \"MountsId\":" + this.FMountsId + ", \"MountsLevel\":" + this.FMountsLevel + ",\"SoulMationID\":" + this.SoulFormationID + ", \"Camp\":" + this.FCamp + ", \"RoleCount\":" + this.FRoleBattleInfos.length + ", \"RoleBattleInfo\":" + _loc2_ + "}";
      }
   }
}

