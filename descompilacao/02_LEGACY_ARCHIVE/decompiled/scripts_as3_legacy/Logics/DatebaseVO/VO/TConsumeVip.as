package Logics.DatebaseVO.VO
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TConsumeVip extends TDatebaseVO
   {
      
      protected var FConsumeCount:int;
      
      protected var FDailyAward:String;
      
      protected var FVipPack:String;
      
      protected var FDailyItem:String;
      
      protected var FPrice:int;
      
      protected var FDaybuy:int;
      
      protected var FTpye:int;
      
      protected var FHeroid:int;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FQuantitys:Vector.<uint>;
      
      protected var FDailyItemId:int;
      
      protected var FQuantity:int;
      
      public function TConsumeVip()
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
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc4_:String = null;
         this.FConsumeCount = param1.readUnsignedInt();
         this.FDailyAward = TUtilityString.FetchUTF(param1);
         this.FVipPack = TUtilityString.FetchUTF(param1);
         this.FDailyItem = TUtilityString.FetchUTF(param1);
         this.FDaybuy = param1.readUnsignedInt();
         this.FPrice = param1.readUnsignedInt();
         this.FTpye = param1.readUnsignedInt();
         this.FHeroid = param1.readUnsignedInt();
         var _loc2_:Array = this.FVipPack.split("|");
         this.FIDTemplates = new Vector.<uint>();
         this.FQuantitys = new Vector.<uint>();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            this.FIDTemplates.push(_loc4_.split("_")[0]);
            this.FQuantitys.push(_loc4_.split("_")[1]);
            _loc3_++;
         }
         this.FDailyItemId = this.FDailyItem.split("_")[0];
         this.FQuantity = this.FDailyItem.split("_")[1];
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FConsumeCount);
         TUtilityString.FlushUTF(param1,this.FDailyAward);
         TUtilityString.FlushUTF(param1,this.FVipPack);
         TUtilityString.FlushUTF(param1,this.FDailyItem);
         param1.writeUnsignedInt(this.FDaybuy);
         param1.writeUnsignedInt(this.FPrice);
         param1.writeUnsignedInt(this.FTpye);
         param1.writeUnsignedInt(this.FHeroid);
      }
      
      public function get NextConsumeVip() : TConsumeVip
      {
         var _loc1_:TConsumeVip = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConsumeVip,Identifier + 1) as TConsumeVip;
         if(_loc1_)
         {
            return _loc1_;
         }
         return this;
      }
      
      public function get ConsumeCount() : int
      {
         return this.FConsumeCount;
      }
      
      public function get DailyAward() : String
      {
         return this.FDailyAward;
      }
      
      public function get VipPack() : String
      {
         return this.FVipPack;
      }
      
      public function get DailyItem() : String
      {
         return this.FDailyItem;
      }
      
      public function get Daybuy() : int
      {
         return this.FDaybuy;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function get Tpye() : int
      {
         return this.FTpye;
      }
      
      public function get Heroid() : int
      {
         return this.FHeroid;
      }
      
      public function get IDTemplates() : Vector.<uint>
      {
         return this.FIDTemplates;
      }
      
      public function get Quantitys() : Vector.<uint>
      {
         return this.FQuantitys;
      }
      
      public function get DailyItemId() : int
      {
         return this.FDailyItemId;
      }
      
      public function get Quantity() : int
      {
         return this.FQuantity;
      }
   }
}

