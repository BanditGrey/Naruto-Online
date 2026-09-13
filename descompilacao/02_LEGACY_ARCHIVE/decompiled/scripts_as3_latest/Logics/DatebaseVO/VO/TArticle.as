package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TArticle extends TDatebaseVO
   {
      
      public static const EXPANDINDEX_Usable:uint = 0;
      
      public static const EXPANDINDEX_IsCanSell:uint = 1;
      
      public static const EXPANDINDEX_IsCanDiscard:uint = 2;
      
      public static const EXPANDINDEX_IsCanReveal:uint = 3;
      
      protected var FName:String;
      
      protected var FMajorType:int;
      
      protected var FMinorType:int;
      
      protected var FLevel:int;
      
      protected var FQuality:int;
      
      protected var FCardType:int;
      
      protected var FSort:int;
      
      protected var FOverlayNumber:int;
      
      protected var FBindMode:int;
      
      protected var FObtain:int;
      
      protected var FFunctionDesc:String;
      
      protected var FPicture:int;
      
      protected var FExpands:Vector.<Boolean>;
      
      protected var FCostPrice:int;
      
      protected var FSellPrice:int;
      
      protected var FItemFunction:int;
      
      protected var FFunctionValue:int;
      
      protected var FIsExchage:int;
      
      protected var FGoldNumberA:int;
      
      protected var FExpand:String;
      
      public function TArticle()
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
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FMajorType);
         param1.writeUnsignedInt(this.FMinorType);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FCardType);
         param1.writeUnsignedInt(this.FSort);
         param1.writeUnsignedInt(this.FOverlayNumber);
         param1.writeUnsignedInt(this.FBindMode);
         param1.writeUnsignedInt(this.FObtain);
         TUtilityString.FlushUTF(param1,this.FFunctionDesc);
         param1.writeUnsignedInt(this.FPicture);
         TUtilityString.FlushUTF(param1,this.FExpand);
         param1.writeUnsignedInt(this.FCostPrice);
         param1.writeUnsignedInt(this.FSellPrice);
         param1.writeUnsignedInt(this.FItemFunction);
         param1.writeUnsignedInt(this.FFunctionValue);
         param1.writeUnsignedInt(this.FIsExchage);
         param1.writeUnsignedInt(this.FGoldNumberA);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FMajorType = param1.readUnsignedInt();
         this.FMinorType = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FCardType = param1.readUnsignedInt();
         this.FSort = param1.readUnsignedInt();
         this.FOverlayNumber = param1.readUnsignedInt();
         this.FBindMode = param1.readUnsignedInt();
         this.FObtain = param1.readUnsignedInt();
         this.FFunctionDesc = TUtilityString.FetchUTF(param1);
         this.FPicture = param1.readUnsignedInt();
         _loc4_ = TUtilityString.FetchUTF(param1);
         _loc5_ = _loc4_.split("_");
         _loc3_ = int(_loc5_.length);
         this.FExpands = new Vector.<Boolean>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            switch(_loc5_[_loc2_])
            {
               case "0":
                  this.FExpands[_loc2_] = false;
                  break;
               case "1":
                  this.FExpands[_loc2_] = true;
            }
            _loc2_++;
         }
         this.FCostPrice = param1.readUnsignedInt();
         this.FSellPrice = param1.readUnsignedInt();
         this.FItemFunction = param1.readUnsignedInt();
         this.FFunctionValue = param1.readUnsignedInt();
         this.FIsExchage = param1.readUnsignedInt();
         this.FGoldNumberA = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get MajorType() : int
      {
         return this.FMajorType;
      }
      
      public function get MinorType() : int
      {
         return this.FMinorType;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get CardType() : int
      {
         return this.FCardType;
      }
      
      public function get Sort() : int
      {
         return this.FSort;
      }
      
      public function get OverlayNumber() : int
      {
         return this.FOverlayNumber;
      }
      
      public function get BindMode() : int
      {
         return this.FBindMode;
      }
      
      public function get Obtain() : int
      {
         return this.FObtain;
      }
      
      public function get FunctionDesc() : String
      {
         return this.FFunctionDesc;
      }
      
      public function get Picture() : int
      {
         return this.FPicture;
      }
      
      public function get ExpandUsable() : Boolean
      {
         return this.FExpands[EXPANDINDEX_Usable];
      }
      
      public function get ExpandIsCanSell() : Boolean
      {
         return this.FExpands[EXPANDINDEX_IsCanSell];
      }
      
      public function get ExpandIsCanDiscard() : Boolean
      {
         return this.FExpands[EXPANDINDEX_IsCanDiscard];
      }
      
      public function get ExpandIsCanReveal() : Boolean
      {
         return this.FExpands[EXPANDINDEX_IsCanReveal];
      }
      
      public function get CostPrice() : int
      {
         return this.FCostPrice;
      }
      
      public function get SellPrice() : int
      {
         return this.FSellPrice;
      }
      
      public function get ItemFunction() : int
      {
         return this.FItemFunction;
      }
      
      public function get FunctionValue() : int
      {
         return this.FFunctionValue;
      }
      
      public function get Expand() : String
      {
         return this.FExpand;
      }
      
      public function get IsExchage() : int
      {
         return this.FIsExchage;
      }
      
      public function get GoldNumberA() : int
      {
         return this.FGoldNumberA;
      }
   }
}

