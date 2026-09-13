package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TEquipGenerate extends TDatebaseVO
   {
      
      protected static const SYMBOLA:String = "|";
      
      protected static const SYMBOLB:String = "_";
      
      protected var FOpenLevel:int;
      
      protected var FCost:int;
      
      protected var FDatum:String;
      
      protected var FMaterials:Vector.<uint>;
      
      protected var FQuantitys:Vector.<uint>;
      
      protected var FIsEpic:uint;
      
      public function TEquipGenerate()
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
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FOpenLevel);
         param1.writeUnsignedInt(this.FCost);
         TUtilityString.FlushUTF(param1,this.FDatum);
         param1.writeUnsignedInt(this.FIsEpic);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FOpenLevel = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FDatum = TUtilityString.FetchUTF(param1);
         _loc5_ = this.FDatum.split(SYMBOLA);
         _loc3_ = _loc5_.length;
         this.FMaterials = new Vector.<uint>(_loc3_);
         this.FQuantitys = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_[_loc2_];
            this.FMaterials[_loc2_] = _loc4_.split(SYMBOLB)[0];
            this.FQuantitys[_loc2_] = _loc4_.split(SYMBOLB)[1];
            _loc2_++;
         }
         this.FIsEpic = param1.readUnsignedInt();
      }
      
      public function get OpenLevel() : int
      {
         return this.FOpenLevel;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function get Materials() : Vector.<uint>
      {
         return this.FMaterials;
      }
      
      public function get Quantitys() : Vector.<uint>
      {
         return this.FQuantitys;
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

