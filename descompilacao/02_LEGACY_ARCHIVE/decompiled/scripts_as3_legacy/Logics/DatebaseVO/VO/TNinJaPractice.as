package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TNinJaPractice extends TDatebaseVO
   {
      
      protected var FLv:int;
      
      protected var FCost:int;
      
      protected var FTotalCost:int;
      
      protected var FAddNearAttack:int;
      
      protected var FAddNearDefense:int;
      
      protected var FAddStrategyAttack:int;
      
      protected var FAddStrategyDefense:int;
      
      protected var FAddMaxHp:int;
      
      protected var FAddSpeed:int;
      
      protected var FNeedTransLv:int;
      
      protected var FNeedLv:int;
      
      protected var FShowLv:int;
      
      public function TNinJaPractice()
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
                     this[_loc3_] = _loc4_;
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FLv);
         param1.writeUnsignedInt(this.FCost);
         param1.writeUnsignedInt(this.FTotalCost);
         param1.writeUnsignedInt(this.FAddNearAttack);
         param1.writeUnsignedInt(this.FAddNearDefense);
         param1.writeUnsignedInt(this.FAddStrategyAttack);
         param1.writeUnsignedInt(this.FAddStrategyDefense);
         param1.writeUnsignedInt(this.FAddMaxHp);
         param1.writeUnsignedInt(this.FAddSpeed);
         param1.writeUnsignedInt(this.FNeedTransLv);
         param1.writeUnsignedInt(this.FNeedLv);
         param1.writeUnsignedInt(this.FShowLv);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLv = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FTotalCost = param1.readUnsignedInt();
         this.FAddNearAttack = param1.readUnsignedInt();
         this.FAddNearDefense = param1.readUnsignedInt();
         this.FAddStrategyAttack = param1.readUnsignedInt();
         this.FAddStrategyDefense = param1.readUnsignedInt();
         this.FAddMaxHp = param1.readUnsignedInt();
         this.FAddSpeed = param1.readUnsignedInt();
         this.FNeedTransLv = param1.readUnsignedInt();
         this.FNeedLv = param1.readUnsignedInt();
         this.FShowLv = param1.readUnsignedInt();
      }
      
      public function get Lv() : int
      {
         return this.FLv;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function get TotalCost() : int
      {
         return this.FTotalCost;
      }
      
      public function get AddNearAttack() : int
      {
         return this.FAddNearAttack;
      }
      
      public function get AddNearDefense() : int
      {
         return this.FAddNearDefense;
      }
      
      public function get AddStrategyAttack() : int
      {
         return this.FAddStrategyAttack;
      }
      
      public function get AddStrategyDefense() : int
      {
         return this.FAddStrategyDefense;
      }
      
      public function get AddSpeed() : int
      {
         return this.FAddSpeed;
      }
      
      public function get AddMaxHp() : int
      {
         return this.FAddMaxHp;
      }
      
      public function get NeedTransLv() : int
      {
         return this.FNeedTransLv;
      }
      
      public function get NeedLv() : int
      {
         return this.FNeedLv;
      }
      
      public function get ShowLv() : int
      {
         return this.FShowLv;
      }
   }
}

