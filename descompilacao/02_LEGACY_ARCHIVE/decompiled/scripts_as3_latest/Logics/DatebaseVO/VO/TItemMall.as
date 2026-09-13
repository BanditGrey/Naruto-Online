package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TItemMall extends TDatebaseVO
   {
      
      protected var FItemid:String;
      
      protected var FQuantity:int;
      
      protected var FNeedid:String;
      
      protected var FTpye:int;
      
      protected var FHeroid:int;
      
      protected var FDaybuy:int;
      
      protected var FMaxbuy:int;
      
      protected var FMaterials:Vector.<uint>;
      
      protected var FQuantitys:Vector.<uint>;
      
      public function TItemMall()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc4_:String = null;
         this.FItemid = TUtilityString.FetchUTF(param1);
         this.FQuantity = this.FItemid.split("_")[1];
         this.FItemid = this.FItemid.split("_")[0];
         this.FNeedid = TUtilityString.FetchUTF(param1);
         this.FTpye = param1.readUnsignedInt();
         this.FHeroid = param1.readUnsignedInt();
         this.FDaybuy = param1.readUnsignedInt();
         this.FMaxbuy = param1.readUnsignedInt();
         var _loc2_:Array = this.FNeedid.split("|");
         this.FMaterials = new Vector.<uint>();
         this.FQuantitys = new Vector.<uint>();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            this.FMaterials.push(_loc4_.split("_")[0]);
            this.FQuantitys.push(_loc4_.split("_")[1]);
            _loc3_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FItemid);
         TUtilityString.FlushUTF(param1,this.FNeedid);
         param1.writeUnsignedInt(this.FTpye);
         param1.writeUnsignedInt(this.FHeroid);
         param1.writeUnsignedInt(this.FDaybuy);
         param1.writeUnsignedInt(this.FMaxbuy);
      }
      
      public function get Itemid() : String
      {
         return this.FItemid;
      }
      
      public function get Quantity() : int
      {
         return this.FQuantity;
      }
      
      public function get Needid() : String
      {
         return this.FNeedid;
      }
      
      public function get Tpye() : int
      {
         return this.FTpye;
      }
      
      public function get Heroid() : int
      {
         return this.FHeroid;
      }
      
      public function get Daybuy() : int
      {
         return this.FDaybuy;
      }
      
      public function get Maxbuy() : int
      {
         return this.FMaxbuy;
      }
      
      public function get Materials() : Vector.<uint>
      {
         return this.FMaterials;
      }
      
      public function get Quantitys() : Vector.<uint>
      {
         return this.FQuantitys;
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
   }
}

