package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TOrganizationBase extends TDatebaseVO
   {
      
      protected var FOrgLevel:uint;
      
      protected var FOrgMaxNumber:uint;
      
      protected var FGetMoreSiv:uint;
      
      protected var FGetMoreExp:uint;
      
      protected var FCampUpgradeMoney:uint;
      
      protected var FMuyebattleUpgradeMoney:uint;
      
      protected var FMuyebattleUpgradeAddition:uint;
      
      protected var FMuyeguardUpgradeMoney:uint;
      
      protected var FMuyeguardUpgradeAddition:uint;
      
      protected var FOrgMinSumBossNumber:uint;
      
      protected var FMuyebattleUpgradeAdditionVect:Vector.<uint>;
      
      protected var FMuyeguardUpgradeAdditionVect:Vector.<uint>;
      
      public function TOrganizationBase()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FOrgLevel);
         param1.writeUnsignedInt(this.FOrgMaxNumber);
         param1.writeUnsignedInt(this.FGetMoreSiv);
         param1.writeUnsignedInt(this.FGetMoreExp);
         param1.writeUnsignedInt(this.FCampUpgradeMoney);
         param1.writeUnsignedInt(this.FMuyebattleUpgradeMoney);
         param1.writeUnsignedInt(this.FMuyebattleUpgradeAddition);
         param1.writeUnsignedInt(this.FMuyeguardUpgradeMoney);
         param1.writeUnsignedInt(this.FMuyeguardUpgradeAddition);
         param1.writeUnsignedInt(this.FOrgMinSumBossNumber);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FOrgLevel = param1.readUnsignedInt();
         this.FOrgMaxNumber = param1.readUnsignedInt();
         this.FGetMoreSiv = param1.readUnsignedInt();
         this.FGetMoreExp = param1.readUnsignedInt();
         this.FCampUpgradeMoney = param1.readUnsignedInt();
         this.FMuyebattleUpgradeMoney = param1.readUnsignedInt();
         this.FMuyebattleUpgradeAddition = param1.readUnsignedInt();
         this.FMuyeguardUpgradeMoney = param1.readUnsignedInt();
         this.FMuyeguardUpgradeAddition = param1.readUnsignedInt();
         this.FOrgMinSumBossNumber = param1.readUnsignedInt();
      }
      
      public function get OrgLevel() : uint
      {
         return this.FOrgLevel;
      }
      
      public function get OrgMaxNumber() : uint
      {
         return this.FOrgMaxNumber;
      }
      
      public function get GetMoreSiv() : uint
      {
         return this.FGetMoreSiv;
      }
      
      public function get GetMoreExp() : uint
      {
         return this.FGetMoreExp;
      }
      
      public function get CampUpgradeMoney() : uint
      {
         return this.FCampUpgradeMoney;
      }
      
      public function get MuyebattleUpgradeMoney() : uint
      {
         return this.FMuyebattleUpgradeMoney;
      }
      
      public function get MuyebattleUpgradeAddition() : uint
      {
         return this.FMuyebattleUpgradeAddition;
      }
      
      public function get MuyeguardUpgradeMoney() : uint
      {
         return this.FMuyeguardUpgradeMoney;
      }
      
      public function get MuyeguardUpgradeAddition() : uint
      {
         return this.FMuyeguardUpgradeAddition;
      }
      
      public function get OrgMinSumBossNumber() : uint
      {
         return this.FOrgMinSumBossNumber;
      }
      
      public function get MuyebattleUpgradeAdditionVect() : Vector.<uint>
      {
         return this.FMuyebattleUpgradeAdditionVect;
      }
      
      public function get MuyeguardUpgradeAdditionVect() : Vector.<uint>
      {
         return this.FMuyeguardUpgradeAdditionVect;
      }
   }
}

