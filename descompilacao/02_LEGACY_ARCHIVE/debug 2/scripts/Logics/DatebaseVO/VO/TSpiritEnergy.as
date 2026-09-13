package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSpiritEnergy extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FEnergyLv:int;
      
      protected var FEnergyLy:int;
      
      protected var FUserLv:int;
      
      protected var FMaxExp:int;
      
      protected var FExpAll:int;
      
      protected var FGoldCost:int;
      
      protected var FGoldExp:int;
      
      protected var FItemId:int;
      
      protected var FItemCost:int;
      
      protected var FItemExp:int;
      
      protected var FBreakthroughgoldCost:int;
      
      protected var FGradePromoteItemId:int;
      
      protected var FAttribute:String;
      
      protected var FNeedTransLv:uint;
      
      protected var FAttributeVec:Vector.<Object>;
      
      public function TSpiritEnergy()
      {
         super();
         this.FAttributeVec = new Vector.<Object>();
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
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FEnergyLv);
         param1.writeUnsignedInt(this.FEnergyLy);
         param1.writeUnsignedInt(this.FUserLv);
         param1.writeUnsignedInt(this.FMaxExp);
         param1.writeUnsignedInt(this.FExpAll);
         param1.writeUnsignedInt(this.FGoldCost);
         param1.writeUnsignedInt(this.FItemId);
         param1.writeUnsignedInt(this.FItemCost);
         param1.writeUnsignedInt(this.FBreakthroughgoldCost);
         param1.writeUnsignedInt(this.FGradePromoteItemId);
         TUtilityString.FlushUTF(param1,this.FAttribute);
         param1.writeUnsignedInt(this.FNeedTransLv);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FEnergyLv = param1.readUnsignedInt();
         this.FEnergyLy = param1.readUnsignedInt();
         this.FUserLv = param1.readUnsignedInt();
         this.FMaxExp = param1.readUnsignedInt();
         this.FExpAll = param1.readUnsignedInt();
         this.FGoldCost = param1.readUnsignedInt();
         this.FItemId = param1.readUnsignedInt();
         this.FItemCost = param1.readUnsignedInt();
         this.FBreakthroughgoldCost = param1.readUnsignedInt();
         this.FGradePromoteItemId = param1.readUnsignedInt();
         this.FAttribute = TUtilityString.FetchUTF(param1);
         this.FNeedTransLv = param1.readUnsignedInt();
         _loc4_ = Json.decode(this.FAttribute);
         _loc2_ = _loc4_.length;
         this.FAttributeVec.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.FAttributeVec.push(Object(_loc4_[_loc3_]));
            _loc3_++;
         }
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get EnergyLv() : int
      {
         return this.FEnergyLv;
      }
      
      public function get EnergyLy() : int
      {
         return this.FEnergyLy;
      }
      
      public function get UserLv() : int
      {
         return this.FUserLv;
      }
      
      public function get MaxExp() : int
      {
         return this.FMaxExp;
      }
      
      public function get ExpAll() : int
      {
         return this.FExpAll;
      }
      
      public function get GoldCost() : int
      {
         return this.FGoldCost;
      }
      
      public function get ItemId() : int
      {
         return this.FItemId;
      }
      
      public function get ItemCost() : int
      {
         return this.FItemCost;
      }
      
      public function get BreakthroughgoldCost() : int
      {
         return this.FBreakthroughgoldCost;
      }
      
      public function get GradePromoteItemId() : int
      {
         return this.FGradePromoteItemId;
      }
      
      public function get NeedTransLv() : uint
      {
         return this.FNeedTransLv;
      }
      
      public function get Attribute() : String
      {
         return this.FAttribute;
      }
      
      public function get AttributeVec() : Vector.<Object>
      {
         return this.FAttributeVec;
      }
   }
}

