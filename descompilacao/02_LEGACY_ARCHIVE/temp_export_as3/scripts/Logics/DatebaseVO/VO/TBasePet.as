package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBasePet extends TDatebaseVO
   {
      
      protected var FNextId:uint;
      
      protected var FReviceCount:int;
      
      protected var FStar:int;
      
      protected var FCanRevive:int;
      
      protected var FLevelLimit:int;
      
      protected var FNormalExp:int;
      
      protected var FGoldExp:int;
      
      protected var FNeedExp:int;
      
      protected var FPower:int;
      
      protected var FAgile:int;
      
      protected var FIntelligence:int;
      
      protected var FLife:int;
      
      protected var FImagesVect:Vector.<uint>;
      
      protected var FAddRate:Number;
      
      protected var FNeedTransLv:uint;
      
      protected var FImages:String;
      
      protected var FName:String;
      
      protected var FItemArr:Array;
      
      protected var FItem:String;
      
      protected var FSpecialArr:Array;
      
      protected var FSpecial:String;
      
      public function TBasePet()
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
         param1.writeUnsignedInt(this.FNextId);
         param1.writeUnsignedInt(this.FReviceCount);
         param1.writeUnsignedInt(this.FStar);
         param1.writeUnsignedInt(this.FCanRevive);
         param1.writeUnsignedInt(this.FLevelLimit);
         param1.writeUnsignedInt(this.FNormalExp);
         param1.writeUnsignedInt(this.FGoldExp);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FPower);
         param1.writeUnsignedInt(this.FAgile);
         param1.writeUnsignedInt(this.FIntelligence);
         param1.writeUnsignedInt(this.FLife);
         TUtilityString.FlushUTF(param1,this.FImages);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeFloat(this.FAddRate);
         param1.writeUnsignedInt(this.FNeedTransLv);
         TUtilityString.FlushUTF(param1,this.FItem);
         TUtilityString.FlushUTF(param1,this.FSpecial);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.FNextId = param1.readUnsignedInt();
         this.FReviceCount = param1.readUnsignedInt();
         this.FStar = param1.readUnsignedInt();
         this.FCanRevive = param1.readUnsignedInt();
         this.FLevelLimit = param1.readUnsignedInt();
         this.FNormalExp = param1.readUnsignedInt();
         this.FGoldExp = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FPower = param1.readUnsignedInt();
         this.FAgile = param1.readUnsignedInt();
         this.FIntelligence = param1.readUnsignedInt();
         this.FLife = param1.readUnsignedInt();
         this.FImages = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FImages);
         _loc5_ = _loc4_.images as Array;
         _loc7_ = _loc5_.length;
         this.FImagesVect = new Vector.<uint>(_loc7_);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            this.FImagesVect[_loc6_] = _loc5_[_loc6_];
            _loc6_++;
         }
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAddRate = param1.readFloat();
         this.FNeedTransLv = param1.readUnsignedInt();
         this.FItem = TUtilityString.FetchUTF(param1);
         this.FItemArr = Json.decode(this.FItem);
         this.FSpecial = TUtilityString.FetchUTF(param1);
         this.FSpecialArr = Json.decode(this.FSpecial);
      }
      
      public function get ReviceCount() : int
      {
         return this.FReviceCount;
      }
      
      public function get Star() : int
      {
         return this.FStar;
      }
      
      public function get CanRevive() : int
      {
         return this.FCanRevive;
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
      
      public function get ImagesVect() : Vector.<uint>
      {
         return this.FImagesVect;
      }
      
      public function get AddRate() : Number
      {
         return this.FAddRate;
      }
      
      public function get NextId() : uint
      {
         return this.FNextId;
      }
      
      public function get Images() : String
      {
         return this.FImages;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get NeedTransLv() : uint
      {
         return this.FNeedTransLv;
      }
      
      public function get ItemArr() : Array
      {
         return this.FItemArr;
      }
      
      public function get Item() : String
      {
         return this.FItem;
      }
      
      public function get SpecialArr() : Array
      {
         return this.FSpecialArr;
      }
      
      public function get Special() : String
      {
         return this.FSpecial;
      }
   }
}

