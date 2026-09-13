package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TMall extends TDatebaseVO
   {
      
      protected var FModel:int;
      
      protected var FName:String;
      
      protected var FMajorType:int;
      
      protected var FItemid:int;
      
      protected var FType:String;
      
      protected var FIntegration:int;
      
      protected var FLevel:int;
      
      protected var FIsvip:int;
      
      protected var FDisplay:int;
      
      protected var FAmount:int;
      
      protected var FGold:int;
      
      protected var FDiscount:int;
      
      protected var FHotprice:int;
      
      protected var FPage:int;
      
      protected var FVip:int;
      
      protected var FIshot:int;
      
      protected var FIsnew:int;
      
      protected var FTimes:int;
      
      public function TMall()
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
         param1.writeUnsignedInt(this.FModel);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FMajorType);
         param1.writeUnsignedInt(this.FItemid);
         TUtilityString.FlushUTF(param1,this.FType);
         param1.writeUnsignedInt(this.FIntegration);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FIsvip);
         param1.writeUnsignedInt(this.FDisplay);
         param1.writeUnsignedInt(this.FAmount);
         param1.writeUnsignedInt(this.FGold);
         param1.writeUnsignedInt(this.FDiscount);
         param1.writeUnsignedInt(this.FHotprice);
         param1.writeUnsignedInt(this.FPage);
         param1.writeUnsignedInt(this.FVip);
         param1.writeUnsignedInt(this.FIshot);
         param1.writeUnsignedInt(this.FIsnew);
         param1.writeUnsignedInt(this.FTimes);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FModel = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FMajorType = param1.readUnsignedInt();
         this.FItemid = param1.readUnsignedInt();
         this.FType = TUtilityString.FetchUTF(param1);
         this.FIntegration = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FIsvip = param1.readUnsignedInt();
         this.FDisplay = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
         this.FGold = param1.readUnsignedInt();
         this.FDiscount = param1.readUnsignedInt();
         this.FHotprice = param1.readUnsignedInt();
         this.FPage = param1.readUnsignedInt();
         this.FVip = param1.readUnsignedInt();
         this.FIshot = param1.readUnsignedInt();
         this.FIsnew = param1.readUnsignedInt();
         this.FTimes = param1.readUnsignedInt();
      }
      
      public function get Model() : int
      {
         return this.FModel;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Itemid() : int
      {
         return this.FItemid;
      }
      
      public function get Type() : String
      {
         return this.FType;
      }
      
      public function get Integration() : int
      {
         return this.FIntegration;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Isvip() : int
      {
         return this.FIsvip;
      }
      
      public function get Display() : int
      {
         return this.FDisplay;
      }
      
      public function get Amount() : int
      {
         return this.FAmount;
      }
      
      public function get Gold() : int
      {
         return this.FGold;
      }
      
      public function get Discount() : int
      {
         return this.FDiscount;
      }
      
      public function get Hotprice() : int
      {
         return this.FHotprice;
      }
      
      public function get Page() : int
      {
         return this.FPage;
      }
      
      public function get Vip() : int
      {
         return this.FVip;
      }
      
      public function get Ishot() : int
      {
         return this.FIshot;
      }
      
      public function get Times() : int
      {
         return this.FTimes;
      }
      
      public function get MajorType() : int
      {
         return this.FMajorType;
      }
      
      public function set MajorType(param1:int) : void
      {
         this.FMajorType = param1;
      }
      
      public function get Isnew() : int
      {
         return this.FIsnew;
      }
      
      public function set Isnew(param1:int) : void
      {
         this.FIsnew = param1;
      }
   }
}

