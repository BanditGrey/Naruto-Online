package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TBaseEquip extends TDatebaseVO
   {
      
      protected var FDressProfessions:Vector.<int>;
      
      protected var FMainType:int;
      
      protected var FMainValue:int;
      
      protected var FMainAdditionalType:int;
      
      protected var FMaxAdditionalCount:int;
      
      protected var FHoleCount:int;
      
      protected var FSuitId:int;
      
      protected var FSuitId1r:int;
      
      protected var FSuitId2r:int;
      
      protected var FSuitId3r:int;
      
      protected var FSuitId4r:int;
      
      protected var FSuitId5r:int;
      
      protected var FSuitId6r:int;
      
      protected var FSuitId7r:int;
      
      protected var FSuitId8r:int;
      
      protected var FSuitId9r:int;
      
      protected var FEightsuitId:int;
      
      protected var FEightsuitId1r:int;
      
      protected var FEightsuitId2r:int;
      
      protected var FSkillRevise:int;
      
      protected var FEdgeColor:Boolean;
      
      protected var FDigHoleNum:int;
      
      protected var FEnchantCoefficient:Number;
      
      protected var FDisplay:uint;
      
      protected var FDressProfession:String;
      
      public function TBaseEquip()
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
         TUtilityString.FlushUTF(param1,this.FDressProfession);
         param1.writeUnsignedInt(this.FMainType);
         param1.writeUnsignedInt(this.FMainValue);
         param1.writeUnsignedInt(this.FMainAdditionalType);
         param1.writeUnsignedInt(this.FMaxAdditionalCount);
         param1.writeUnsignedInt(this.FHoleCount);
         param1.writeUnsignedInt(this.FSuitId);
         param1.writeUnsignedInt(this.FSuitId1r);
         param1.writeUnsignedInt(this.FSuitId2r);
         param1.writeUnsignedInt(this.FSuitId3r);
         param1.writeUnsignedInt(this.FSuitId4r);
         param1.writeUnsignedInt(this.FSuitId5r);
         param1.writeUnsignedInt(this.FSuitId6r);
         param1.writeUnsignedInt(this.FSuitId7r);
         param1.writeUnsignedInt(this.FSuitId8r);
         param1.writeUnsignedInt(this.FSuitId9r);
         param1.writeUnsignedInt(this.FEightsuitId);
         param1.writeUnsignedInt(this.FEightsuitId1r);
         param1.writeUnsignedInt(this.FEightsuitId2r);
         param1.writeUnsignedInt(this.FSkillRevise);
         param1.writeBoolean(this.FEdgeColor);
         param1.writeUnsignedInt(this.FDigHoleNum);
         param1.writeFloat(this.FEnchantCoefficient);
         param1.writeUnsignedInt(this.FDisplay);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         this.FDressProfession = TUtilityString.FetchUTF(param1);
         _loc4_ = this.FDressProfession.split("_");
         _loc3_ = int(_loc4_.length);
         this.FDressProfessions = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FDressProfessions[_loc2_] = _loc4_[_loc2_];
            _loc2_++;
         }
         this.FMainType = param1.readUnsignedInt();
         this.FMainValue = param1.readUnsignedInt();
         this.FMainAdditionalType = param1.readUnsignedInt();
         this.FMaxAdditionalCount = param1.readUnsignedInt();
         this.FHoleCount = param1.readUnsignedInt();
         this.FSuitId = param1.readUnsignedInt();
         this.FSuitId1r = param1.readUnsignedInt();
         this.FSuitId2r = param1.readUnsignedInt();
         this.FSuitId3r = param1.readUnsignedInt();
         this.FSuitId4r = param1.readUnsignedInt();
         this.FSuitId5r = param1.readUnsignedInt();
         this.FSuitId6r = param1.readUnsignedInt();
         this.FSuitId7r = param1.readUnsignedInt();
         this.FSuitId8r = param1.readUnsignedInt();
         this.FSuitId9r = param1.readUnsignedInt();
         this.FEightsuitId = param1.readUnsignedInt();
         this.FEightsuitId1r = param1.readUnsignedInt();
         this.FEightsuitId2r = param1.readUnsignedInt();
         this.FSkillRevise = param1.readUnsignedInt();
         this.FEdgeColor = param1.readBoolean();
         this.FDigHoleNum = param1.readUnsignedInt();
         this.FEnchantCoefficient = this.SetValueByFloat(param1.readFloat());
         this.FDisplay = param1.readUnsignedInt();
      }
      
      protected function SetValueByFloat(param1:Number) : Number
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         _loc2_ = param1.toFixed(2);
         return parseFloat(_loc2_);
      }
      
      public function get DressProfession() : String
      {
         return this.FDressProfession;
      }
      
      public function get DressProfessions() : Vector.<int>
      {
         return this.FDressProfessions;
      }
      
      public function get MainType() : int
      {
         return this.FMainType;
      }
      
      public function get MainValue() : int
      {
         return this.FMainValue;
      }
      
      public function get MainAdditionalType() : int
      {
         return this.FMainAdditionalType;
      }
      
      public function get MaxAdditionalCount() : int
      {
         return this.FMaxAdditionalCount;
      }
      
      public function get HoleCount() : int
      {
         return this.FHoleCount;
      }
      
      public function get SuitId() : int
      {
         return this.SuitIdArr[this.SuitIdArr.length - 1];
      }
      
      public function get SuitId1r() : int
      {
         return this.FSuitId1r;
      }
      
      public function get SuitId2r() : int
      {
         return this.FSuitId2r;
      }
      
      public function get SuitId3r() : int
      {
         return this.FSuitId3r;
      }
      
      public function get SuitId4r() : int
      {
         return this.FSuitId4r;
      }
      
      public function get SuitId5r() : int
      {
         return this.FSuitId5r;
      }
      
      public function get SuitId6r() : int
      {
         return this.FSuitId6r;
      }
      
      public function get SuitId7r() : int
      {
         return this.FSuitId7r;
      }
      
      public function get SuitId8r() : int
      {
         return this.FSuitId8r;
      }
      
      public function get SuitId9r() : int
      {
         return this.FSuitId9r;
      }
      
      public function get SuitIdArr() : Array
      {
         var _loc1_:Array = [];
         if(this.FSuitId != 0)
         {
            _loc1_.push(this.FSuitId);
         }
         if(this.FSuitId1r != 0)
         {
            _loc1_.push(this.FSuitId1r);
         }
         if(this.FSuitId2r != 0)
         {
            _loc1_.push(this.FSuitId2r);
         }
         if(this.FSuitId3r != 0)
         {
            _loc1_.push(this.FSuitId3r);
         }
         if(this.FSuitId4r != 0)
         {
            _loc1_.push(this.FSuitId4r);
         }
         if(this.FSuitId5r != 0)
         {
            _loc1_.push(this.FSuitId5r);
         }
         if(this.FSuitId6r != 0)
         {
            _loc1_.push(this.FSuitId6r);
         }
         if(this.FSuitId7r != 0)
         {
            _loc1_.push(this.FSuitId7r);
         }
         if(this.FSuitId8r != 0)
         {
            _loc1_.push(this.FSuitId8r);
         }
         if(this.FSuitId9r != 0)
         {
            _loc1_.push(this.FSuitId9r);
         }
         return _loc1_;
      }
      
      public function get EightsuitId() : int
      {
         return this.EightsuitIdArr[this.EightsuitIdArr.length - 1];
      }
      
      public function get EightsuitId1r() : int
      {
         return this.FEightsuitId1r;
      }
      
      public function get EightsuitId2r() : int
      {
         return this.FEightsuitId2r;
      }
      
      public function get EightsuitIdArr() : Array
      {
         var _loc1_:Array = [];
         if(this.FEightsuitId != 0)
         {
            _loc1_.push(this.FEightsuitId);
         }
         if(this.FEightsuitId1r != 0)
         {
            _loc1_.push(this.FEightsuitId1r);
         }
         if(this.FEightsuitId2r != 0)
         {
            _loc1_.push(this.FEightsuitId2r);
         }
         return _loc1_;
      }
      
      public function get SkillRevise() : int
      {
         return this.FSkillRevise;
      }
      
      public function get EdgeColor() : Boolean
      {
         return this.FEdgeColor;
      }
      
      public function get DigHoleNum() : int
      {
         return this.FDigHoleNum;
      }
      
      public function get EnchantCoefficient() : Number
      {
         return this.FEnchantCoefficient;
      }
      
      public function get Display() : uint
      {
         return this.FDisplay;
      }
   }
}

