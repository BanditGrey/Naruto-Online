package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TMewMagic extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FLevel:uint;
      
      protected var FType:uint;
      
      protected var FNeedBlock:uint;
      
      protected var FNeedExp:int;
      
      protected var FExpAll:uint;
      
      protected var FNeedSilver:uint;
      
      protected var FSilverExp:uint;
      
      protected var FNeedGold:uint;
      
      protected var FGoldExp:uint;
      
      protected var FNeedItem:uint;
      
      protected var FItemExp:uint;
      
      protected var FPower:uint;
      
      protected var FAgile:uint;
      
      protected var FIntelligence:uint;
      
      protected var FLife:uint;
      
      protected var FNeedTransLv:uint;
      
      protected var FNextid:uint;
      
      protected var FAtrributes:Vector.<uint>;
      
      public function TMewMagic()
      {
         super();
         this.FAtrributes = new Vector.<uint>();
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
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FNeedBlock);
         param1.writeInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FExpAll);
         param1.writeUnsignedInt(this.FNeedSilver);
         param1.writeUnsignedInt(this.FSilverExp);
         param1.writeUnsignedInt(this.FNeedGold);
         param1.writeUnsignedInt(this.FGoldExp);
         param1.writeUnsignedInt(this.FNeedItem);
         param1.writeUnsignedInt(this.FItemExp);
         param1.writeUnsignedInt(this.FPower);
         param1.writeUnsignedInt(this.FAgile);
         param1.writeUnsignedInt(this.FIntelligence);
         param1.writeUnsignedInt(this.FLife);
         param1.writeUnsignedInt(this.FNeedTransLv);
         param1.writeUnsignedInt(this.FNextid);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FLevel = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FNeedBlock = param1.readUnsignedInt();
         this.FNeedExp = param1.readInt();
         this.FExpAll = param1.readUnsignedInt();
         this.FNeedSilver = param1.readUnsignedInt();
         this.FSilverExp = param1.readUnsignedInt();
         this.FNeedGold = param1.readUnsignedInt();
         this.FGoldExp = param1.readUnsignedInt();
         this.FNeedItem = param1.readUnsignedInt();
         this.FItemExp = param1.readUnsignedInt();
         this.FPower = param1.readUnsignedInt();
         this.FAgile = param1.readUnsignedInt();
         this.FIntelligence = param1.readUnsignedInt();
         this.FLife = param1.readUnsignedInt();
         this.FNeedTransLv = param1.readUnsignedInt();
         this.FNextid = param1.readUnsignedInt();
         this.FAtrributes.push(this.FPower);
         this.FAtrributes.push(this.FAgile);
         this.FAtrributes.push(this.FIntelligence);
         this.FAtrributes.push(this.FLife);
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get NeedBlock() : uint
      {
         return this.FNeedBlock;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function get NeedSilver() : uint
      {
         return this.FNeedSilver;
      }
      
      public function get SilverExp() : uint
      {
         return this.FSilverExp;
      }
      
      public function get NeedGold() : uint
      {
         return this.FNeedGold;
      }
      
      public function get GoldExp() : uint
      {
         return this.FGoldExp;
      }
      
      public function get NeedItem() : uint
      {
         return this.FNeedItem;
      }
      
      public function get ItemExp() : uint
      {
         return this.FItemExp;
      }
      
      public function get Power() : uint
      {
         return this.FPower;
      }
      
      public function get Agile() : uint
      {
         return this.FAgile;
      }
      
      public function get Intelligence() : uint
      {
         return this.FIntelligence;
      }
      
      public function get Life() : uint
      {
         return this.FLife;
      }
      
      public function get NeedTransLv() : uint
      {
         return this.FNeedTransLv;
      }
      
      public function get Nextid() : uint
      {
         return this.FNextid;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Atrributes() : Vector.<uint>
      {
         return this.FAtrributes;
      }
      
      public function get ExpAll() : uint
      {
         return this.FExpAll;
      }
      
      public function set ExpAll(param1:uint) : void
      {
         this.FExpAll = param1;
      }
   }
}

