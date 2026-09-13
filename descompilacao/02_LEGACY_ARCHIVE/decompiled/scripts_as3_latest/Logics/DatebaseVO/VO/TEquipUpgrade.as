package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TEquipUpgrade extends TDatebaseVO
   {
      
      protected static const SYMBOLA:String = "|";
      
      protected static const SYMBOLB:String = "_";
      
      protected static const COUNT:uint = 2;
      
      protected var FGotEquipId:int;
      
      protected var FDatum:String;
      
      protected var FMaterials:Vector.<uint>;
      
      protected var FQuantitys:Vector.<uint>;
      
      protected var FIsEpic:uint;
      
      public function TEquipUpgrade()
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
         param1.writeUnsignedInt(this.FGotEquipId);
         TUtilityString.FlushUTF(param1,this.FDatum);
         param1.writeUnsignedInt(this.FIsEpic);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         this.FGotEquipId = param1.readUnsignedInt();
         this.FDatum = TUtilityString.FetchUTF(param1);
         this.FMaterials = new Vector.<uint>();
         this.FQuantitys = new Vector.<uint>();
         _loc3_ = this.FDatum.split(SYMBOLA);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            this.FMaterials[_loc2_] = String(_loc3_[_loc2_]).split(SYMBOLB)[0];
            this.FQuantitys[_loc2_] = String(_loc3_[_loc2_]).split(SYMBOLB)[1];
            _loc2_++;
         }
         this.FIsEpic = param1.readUnsignedInt();
      }
      
      public function get Materials() : Vector.<uint>
      {
         return this.FMaterials;
      }
      
      public function get Quantitys() : Vector.<uint>
      {
         return this.FQuantitys;
      }
      
      public function get GotEquipId() : int
      {
         return this.FGotEquipId;
      }
      
      public function get Datum() : String
      {
         return this.FDatum;
      }
      
      public function get IsEpic() : uint
      {
         return this.FIsEpic;
      }
   }
}

