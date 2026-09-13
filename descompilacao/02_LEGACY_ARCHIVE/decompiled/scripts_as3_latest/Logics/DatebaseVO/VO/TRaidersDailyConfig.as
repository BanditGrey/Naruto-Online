package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TRaidersDailyConfig extends TDatebaseVO
   {
      
      protected var FLevel:int;
      
      protected var FNextHard:uint;
      
      protected var FHeroVect:Vector.<int>;
      
      protected var FEnemyArmy:Vector.<uint>;
      
      protected var FRaiderAwards:Vector.<uint>;
      
      protected var FName:String;
      
      protected var FPicPath:int;
      
      protected var FHeros:String;
      
      protected var FEnemyId:String;
      
      protected var FRaiderAward:String;
      
      public function TRaidersDailyConfig()
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
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FNextHard);
         TUtilityString.FlushUTF(param1,this.FHeros);
         TUtilityString.FlushUTF(param1,this.FEnemyId);
         TUtilityString.FlushUTF(param1,this.FRaiderAward);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FPicPath);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         this.FLevel = param1.readUnsignedInt();
         this.FNextHard = param1.readUnsignedInt();
         this.FHeros = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FHeros);
         _loc4_ = _loc3_.hero;
         this.FHeroVect = Vector.<int>(_loc4_);
         this.FEnemyId = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FEnemyId);
         _loc4_ = _loc3_.army;
         this.FEnemyArmy = Vector.<uint>(_loc4_);
         this.FRaiderAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FRaiderAward);
         _loc4_ = _loc3_.award;
         this.FRaiderAwards = Vector.<uint>(_loc4_);
         this.FName = TUtilityString.FetchUTF(param1);
         this.FPicPath = param1.readUnsignedInt();
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get NextHard() : uint
      {
         return this.FNextHard;
      }
      
      public function get HeroVect() : Vector.<int>
      {
         return this.FHeroVect;
      }
      
      public function get EnemyArmy() : Vector.<uint>
      {
         return this.FEnemyArmy;
      }
      
      public function get RaiderAwards() : Vector.<uint>
      {
         return this.FRaiderAwards;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get PicPath() : int
      {
         return this.FPicPath;
      }
      
      public function get EnemyId() : String
      {
         return this.FEnemyId;
      }
      
      public function get RaiderAward() : String
      {
         return this.FRaiderAward;
      }
      
      public function get Heros() : String
      {
         return this.FHeros;
      }
   }
}

