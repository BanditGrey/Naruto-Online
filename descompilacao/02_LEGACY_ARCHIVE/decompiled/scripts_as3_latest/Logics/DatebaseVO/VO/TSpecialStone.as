package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSpecialStone extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FNextId:int;
      
      protected var FPid:int;
      
      protected var FStar:int;
      
      protected var FLevelLimit:int;
      
      protected var FNormalExp:int;
      
      protected var FGoldExp:int;
      
      protected var FNeedExp:int;
      
      protected var FPower:int;
      
      protected var FAgile:int;
      
      protected var FIntelligence:int;
      
      protected var FLife:int;
      
      protected var FHurtrate:int;
      
      protected var FDamagerate:int;
      
      protected var FAvoidrate:int;
      
      protected var FCostmoney:int;
      
      protected var FCostgold:int;
      
      protected var FCostitem:String;
      
      protected var FNormalType:String;
      
      protected var FGoldType:String;
      
      protected var FCostItemArr:Array;
      
      public function TSpecialStone()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc4_ = String(_loc2_.name());
            _loc3_ = _loc2_;
            if(_loc4_ == "id")
            {
               Coerce(uint(_loc3_));
            }
            else
            {
               _loc4_ = "F" + _loc4_;
               if(hasOwnProperty(_loc4_))
               {
                  this[_loc4_] = _loc3_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc4_.slice(1,2)) < 0)
                  {
                     _loc4_ = "F" + _loc4_.slice(1,2).toLocaleUpperCase() + _loc4_.slice(2);
                  }
                  if(hasOwnProperty(_loc4_.slice(1)))
                  {
                     if(this[_loc4_] is Boolean)
                     {
                        this[_loc4_] = Boolean(int(_loc3_));
                     }
                     else
                     {
                        this[_loc4_] = _loc3_;
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
         param1.writeUnsignedInt(this.FPid);
         param1.writeUnsignedInt(this.FNextId);
         param1.writeUnsignedInt(this.FStar);
         param1.writeUnsignedInt(this.FLevelLimit);
         param1.writeUnsignedInt(this.FNormalExp);
         param1.writeUnsignedInt(this.FGoldExp);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FPower);
         param1.writeUnsignedInt(this.FAgile);
         param1.writeUnsignedInt(this.FIntelligence);
         param1.writeUnsignedInt(this.FLife);
         param1.writeUnsignedInt(this.FHurtrate);
         param1.writeUnsignedInt(this.FDamagerate);
         param1.writeUnsignedInt(this.FAvoidrate);
         param1.writeUnsignedInt(this.FCostmoney);
         param1.writeUnsignedInt(this.FCostgold);
         TUtilityString.FlushUTF(param1,this.FCostitem);
         TUtilityString.FlushUTF(param1,this.FNormalType);
         TUtilityString.FlushUTF(param1,this.FGoldType);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FPid = param1.readUnsignedInt();
         this.FNextId = param1.readUnsignedInt();
         this.FStar = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
         this.FNormalExp = param1.readUnsignedInt();
         this.FGoldExp = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FPower = param1.readUnsignedInt();
         this.FAgile = param1.readUnsignedInt();
         this.FIntelligence = param1.readUnsignedInt();
         this.FLife = param1.readUnsignedInt();
         this.FHurtrate = param1.readUnsignedInt();
         this.FDamagerate = param1.readUnsignedInt();
         this.FAvoidrate = param1.readUnsignedInt();
         this.FCostmoney = param1.readUnsignedInt();
         this.FCostgold = param1.readUnsignedInt();
         this.FCostitem = TUtilityString.FetchUTF(param1);
         this.FCostItemArr = Json.decode(this.FCostitem);
         this.FNormalType = TUtilityString.FetchUTF(param1);
         this.FGoldType = TUtilityString.FetchUTF(param1);
      }
      
      public function get AttrList() : Array
      {
         return [this.FPower,this.FAgile,this.FIntelligence,this.FLife,this.FHurtrate,this.FDamagerate,this.FAvoidrate];
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get NextId() : int
      {
         return this.FNextId;
      }
      
      public function get Pid() : int
      {
         return this.FPid;
      }
      
      public function get Star() : int
      {
         return this.FStar;
      }
      
      public function get LevelLimit() : int
      {
         return this.FLevelLimit;
      }
      
      public function get NormalExp() : int
      {
         return this.FNormalExp;
      }
      
      public function get GoldExp() : int
      {
         return this.FGoldExp;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function get Power() : int
      {
         return this.FPower;
      }
      
      public function get Agile() : int
      {
         return this.FAgile;
      }
      
      public function get Intelligence() : int
      {
         return this.FIntelligence;
      }
      
      public function get Life() : int
      {
         return this.FLife;
      }
      
      public function get Hurtrate() : int
      {
         return this.FHurtrate;
      }
      
      public function get Damagerate() : int
      {
         return this.FDamagerate;
      }
      
      public function get Avoidrate() : int
      {
         return this.FAvoidrate;
      }
      
      public function get Costmoney() : int
      {
         return this.FCostmoney;
      }
      
      public function get Costgold() : int
      {
         return this.FCostgold;
      }
      
      public function get Costitem() : String
      {
         return this.FCostitem;
      }
      
      public function get NormalType() : String
      {
         return this.FNormalType;
      }
      
      public function get GoldType() : String
      {
         return this.FGoldType;
      }
      
      public function get CostItemArr() : Array
      {
         return this.FCostItemArr;
      }
   }
}

