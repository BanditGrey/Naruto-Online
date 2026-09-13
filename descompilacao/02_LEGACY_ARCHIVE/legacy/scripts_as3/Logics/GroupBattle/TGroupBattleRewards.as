package Logics.GroupBattle
{
   import Foundation.Utilities.TUtilityString;
   import Logics.Items.TItem;
   import Logics.Items.TItems;
   import flash.utils.ByteArray;
   
   public class TGroupBattleRewards
   {
      
      protected var FUserName:String;
      
      protected var FUserLevel:uint;
      
      protected var FModelId:uint;
      
      protected var FKillNum:uint;
      
      protected var FFriendBuff:uint;
      
      protected var FGuildBuff:uint;
      
      protected var FNormalItems:TItems;
      
      protected var FScore:uint;
      
      protected var FExtraScore:uint;
      
      protected var FPoint:uint;
      
      public function TGroupBattleRewards()
      {
         super();
         this.FNormalItems = new TItems();
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set UserLevel(param1:uint) : void
      {
         this.FUserLevel = param1;
      }
      
      public function get UserLevel() : uint
      {
         return this.FUserLevel;
      }
      
      public function set ModelId(param1:uint) : void
      {
         this.FModelId = param1;
      }
      
      public function get ModelId() : uint
      {
         return this.FModelId;
      }
      
      public function get KillNum() : uint
      {
         return this.FKillNum;
      }
      
      public function get FriendBuff() : uint
      {
         return this.FFriendBuff;
      }
      
      public function get GuildBuff() : uint
      {
         return this.FGuildBuff;
      }
      
      public function get NormalRewards() : TItems
      {
         return this.FNormalItems;
      }
      
      public function set Score(param1:uint) : void
      {
         this.FScore = param1;
      }
      
      public function get Score() : uint
      {
         return this.FScore;
      }
      
      public function set ExtraScore(param1:uint) : void
      {
         this.FExtraScore = param1;
      }
      
      public function get ExtraScore() : uint
      {
         return this.FExtraScore;
      }
      
      public function set Point(param1:uint) : void
      {
         this.FPoint = param1;
      }
      
      public function get Point() : uint
      {
         return this.FPoint;
      }
      
      public function SetData(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TItem = null;
         this.FUserName = TUtilityString.FetchUTF(param1);
         this.FUserLevel = param1.readUnsignedInt();
         this.FModelId = param1.readUnsignedInt();
         this.FKillNum = param1.readUnsignedInt();
         this.FFriendBuff = param1.readUnsignedByte();
         this.FGuildBuff = param1.readUnsignedByte();
         _loc3_ = uint(param1.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TItem();
            _loc4_.Type = param1.readUnsignedShort();
            _loc4_.ID = param1.readUnsignedInt();
            _loc4_.Count = param1.readUnsignedInt();
            this.FNormalItems.Add(_loc4_);
            _loc2_++;
         }
         _loc3_ = uint(param1.readShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TItem();
            _loc4_.Type = param1.readUnsignedShort();
            _loc4_.ID = param1.readUnsignedInt();
            _loc4_.Count = param1.readUnsignedInt();
            this.FNormalItems.Add(_loc4_);
            _loc2_++;
         }
      }
   }
}

