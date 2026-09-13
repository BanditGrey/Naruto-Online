package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBB_AttriBute extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FLv1:String;
      
      protected var FLv2:String;
      
      protected var FLv3:String;
      
      protected var FLv4:String;
      
      protected var FLv5:String;
      
      protected var FLv6:String;
      
      protected var FLv7:String;
      
      protected var FLv8:String;
      
      protected var FLv9:String;
      
      protected var FLv10:String;
      
      protected var FLv11:String;
      
      protected var FLv12:String;
      
      protected var FLv13:String;
      
      protected var FLv14:String;
      
      protected var FLv15:String;
      
      protected var FLv16:String;
      
      protected var FLv17:String;
      
      protected var FLv18:String;
      
      protected var FLv19:String;
      
      protected var FLv20:String;
      
      protected var FLv21:String;
      
      protected var FLv22:String;
      
      protected var FLv23:String;
      
      protected var FLv24:String;
      
      protected var FLv25:String;
      
      protected var FLv26:String;
      
      protected var FLv27:String;
      
      protected var FLv28:String;
      
      protected var FLv29:String;
      
      protected var FLv30:String;
      
      protected var FLv31:String;
      
      protected var FLv32:String;
      
      protected var FLv33:String;
      
      protected var FLv34:String;
      
      protected var FLv35:String;
      
      protected var FLv36:String;
      
      protected var FLv37:String;
      
      protected var FLv38:String;
      
      protected var FLv39:String;
      
      protected var FLv40:String;
      
      protected var FLv1AddValues:Vector.<int>;
      
      protected var FLv20AddValues:Vector.<int>;
      
      protected var FLv40AddValues:Vector.<int>;
      
      protected var FLvArr:Array;
      
      public function TBB_AttriBute()
      {
         super();
         this.FLvArr = new Array();
         this.FLv1AddValues = new Vector.<int>();
         this.FLv20AddValues = new Vector.<int>();
         this.FLv40AddValues = new Vector.<int>();
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FLv1);
         TUtilityString.FlushUTF(param1,this.FLv2);
         TUtilityString.FlushUTF(param1,this.FLv3);
         TUtilityString.FlushUTF(param1,this.FLv4);
         TUtilityString.FlushUTF(param1,this.FLv5);
         TUtilityString.FlushUTF(param1,this.FLv6);
         TUtilityString.FlushUTF(param1,this.FLv7);
         TUtilityString.FlushUTF(param1,this.FLv8);
         TUtilityString.FlushUTF(param1,this.FLv9);
         TUtilityString.FlushUTF(param1,this.FLv10);
         TUtilityString.FlushUTF(param1,this.FLv11);
         TUtilityString.FlushUTF(param1,this.FLv12);
         TUtilityString.FlushUTF(param1,this.FLv13);
         TUtilityString.FlushUTF(param1,this.FLv14);
         TUtilityString.FlushUTF(param1,this.FLv15);
         TUtilityString.FlushUTF(param1,this.FLv16);
         TUtilityString.FlushUTF(param1,this.FLv17);
         TUtilityString.FlushUTF(param1,this.FLv18);
         TUtilityString.FlushUTF(param1,this.FLv19);
         TUtilityString.FlushUTF(param1,this.FLv20);
         TUtilityString.FlushUTF(param1,this.FLv21);
         TUtilityString.FlushUTF(param1,this.FLv22);
         TUtilityString.FlushUTF(param1,this.FLv23);
         TUtilityString.FlushUTF(param1,this.FLv24);
         TUtilityString.FlushUTF(param1,this.FLv25);
         TUtilityString.FlushUTF(param1,this.FLv26);
         TUtilityString.FlushUTF(param1,this.FLv27);
         TUtilityString.FlushUTF(param1,this.FLv28);
         TUtilityString.FlushUTF(param1,this.FLv29);
         TUtilityString.FlushUTF(param1,this.FLv30);
         TUtilityString.FlushUTF(param1,this.FLv31);
         TUtilityString.FlushUTF(param1,this.FLv32);
         TUtilityString.FlushUTF(param1,this.FLv33);
         TUtilityString.FlushUTF(param1,this.FLv34);
         TUtilityString.FlushUTF(param1,this.FLv35);
         TUtilityString.FlushUTF(param1,this.FLv36);
         TUtilityString.FlushUTF(param1,this.FLv37);
         TUtilityString.FlushUTF(param1,this.FLv38);
         TUtilityString.FlushUTF(param1,this.FLv39);
         TUtilityString.FlushUTF(param1,this.FLv40);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FLv1 = TUtilityString.FetchUTF(param1);
         this.FLvArr[0] = this.FLv1;
         this.FLv2 = TUtilityString.FetchUTF(param1);
         this.FLvArr[1] = this.FLv2;
         this.FLv3 = TUtilityString.FetchUTF(param1);
         this.FLvArr[2] = this.FLv3;
         this.FLv4 = TUtilityString.FetchUTF(param1);
         this.FLvArr[3] = this.FLv4;
         this.FLv5 = TUtilityString.FetchUTF(param1);
         this.FLvArr[4] = this.FLv5;
         this.FLv6 = TUtilityString.FetchUTF(param1);
         this.FLvArr[5] = this.FLv6;
         this.FLv7 = TUtilityString.FetchUTF(param1);
         this.FLvArr[6] = this.FLv7;
         this.FLv8 = TUtilityString.FetchUTF(param1);
         this.FLvArr[7] = this.FLv8;
         this.FLv9 = TUtilityString.FetchUTF(param1);
         this.FLvArr[8] = this.FLv9;
         this.FLv10 = TUtilityString.FetchUTF(param1);
         this.FLvArr[9] = this.FLv10;
         this.FLv11 = TUtilityString.FetchUTF(param1);
         this.FLvArr[10] = this.FLv11;
         this.FLv12 = TUtilityString.FetchUTF(param1);
         this.FLvArr[11] = this.FLv12;
         this.FLv13 = TUtilityString.FetchUTF(param1);
         this.FLvArr[12] = this.FLv13;
         this.FLv14 = TUtilityString.FetchUTF(param1);
         this.FLvArr[13] = this.FLv14;
         this.FLv15 = TUtilityString.FetchUTF(param1);
         this.FLvArr[14] = this.FLv15;
         this.FLv16 = TUtilityString.FetchUTF(param1);
         this.FLvArr[15] = this.FLv16;
         this.FLv17 = TUtilityString.FetchUTF(param1);
         this.FLvArr[16] = this.FLv17;
         this.FLv18 = TUtilityString.FetchUTF(param1);
         this.FLvArr[17] = this.FLv18;
         this.FLv19 = TUtilityString.FetchUTF(param1);
         this.FLvArr[18] = this.FLv19;
         this.FLv20 = TUtilityString.FetchUTF(param1);
         this.FLvArr[19] = this.FLv20;
         this.FLv21 = TUtilityString.FetchUTF(param1);
         this.FLvArr[20] = this.FLv21;
         this.FLv22 = TUtilityString.FetchUTF(param1);
         this.FLvArr[21] = this.FLv22;
         this.FLv23 = TUtilityString.FetchUTF(param1);
         this.FLvArr[22] = this.FLv23;
         this.FLv24 = TUtilityString.FetchUTF(param1);
         this.FLvArr[23] = this.FLv24;
         this.FLv25 = TUtilityString.FetchUTF(param1);
         this.FLvArr[24] = this.FLv25;
         this.FLv26 = TUtilityString.FetchUTF(param1);
         this.FLvArr[25] = this.FLv26;
         this.FLv27 = TUtilityString.FetchUTF(param1);
         this.FLvArr[26] = this.FLv27;
         this.FLv28 = TUtilityString.FetchUTF(param1);
         this.FLvArr[27] = this.FLv28;
         this.FLv29 = TUtilityString.FetchUTF(param1);
         this.FLvArr[28] = this.FLv29;
         this.FLv30 = TUtilityString.FetchUTF(param1);
         this.FLvArr[29] = this.FLv30;
         this.FLv31 = TUtilityString.FetchUTF(param1);
         this.FLvArr[30] = this.FLv31;
         this.FLv32 = TUtilityString.FetchUTF(param1);
         this.FLvArr[31] = this.FLv32;
         this.FLv33 = TUtilityString.FetchUTF(param1);
         this.FLvArr[32] = this.FLv33;
         this.FLv34 = TUtilityString.FetchUTF(param1);
         this.FLvArr[33] = this.FLv34;
         this.FLv35 = TUtilityString.FetchUTF(param1);
         this.FLvArr[34] = this.FLv35;
         this.FLv36 = TUtilityString.FetchUTF(param1);
         this.FLvArr[35] = this.FLv36;
         this.FLv37 = TUtilityString.FetchUTF(param1);
         this.FLvArr[36] = this.FLv37;
         this.FLv38 = TUtilityString.FetchUTF(param1);
         this.FLvArr[37] = this.FLv38;
         this.FLv39 = TUtilityString.FetchUTF(param1);
         this.FLvArr[38] = this.FLv39;
         this.FLv40 = TUtilityString.FetchUTF(param1);
         this.FLvArr[39] = this.FLv40;
         _loc2_ = Json.decode(this.FLv1) as Array;
         _loc4_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FLv1AddValues[_loc3_] = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc2_ = Json.decode(this.FLv20) as Array;
         _loc4_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FLv20AddValues[_loc3_] = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc2_ = Json.decode(this.FLv40) as Array;
         _loc4_ = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FLv40AddValues[_loc3_] = _loc2_[_loc3_];
            _loc3_++;
         }
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Lv1() : String
      {
         return this.FLv1;
      }
      
      public function get Lv2() : String
      {
         return this.FLv2;
      }
      
      public function get Lv3() : String
      {
         return this.FLv3;
      }
      
      public function get Lv4() : String
      {
         return this.FLv4;
      }
      
      public function get Lv5() : String
      {
         return this.FLv5;
      }
      
      public function get Lv6() : String
      {
         return this.FLv6;
      }
      
      public function get Lv7() : String
      {
         return this.FLv7;
      }
      
      public function get Lv8() : String
      {
         return this.FLv8;
      }
      
      public function get Lv9() : String
      {
         return this.FLv9;
      }
      
      public function get Lv10() : String
      {
         return this.FLv10;
      }
      
      public function get Lv11() : String
      {
         return this.FLv11;
      }
      
      public function get Lv12() : String
      {
         return this.FLv12;
      }
      
      public function get Lv13() : String
      {
         return this.FLv13;
      }
      
      public function get Lv14() : String
      {
         return this.FLv14;
      }
      
      public function get Lv15() : String
      {
         return this.FLv15;
      }
      
      public function get Lv16() : String
      {
         return this.FLv16;
      }
      
      public function get Lv17() : String
      {
         return this.FLv17;
      }
      
      public function get Lv18() : String
      {
         return this.FLv18;
      }
      
      public function get Lv19() : String
      {
         return this.FLv19;
      }
      
      public function get Lv20() : String
      {
         return this.FLv20;
      }
      
      public function get Lv21() : String
      {
         return this.FLv21;
      }
      
      public function get Lv22() : String
      {
         return this.FLv22;
      }
      
      public function get Lv23() : String
      {
         return this.FLv23;
      }
      
      public function get Lv24() : String
      {
         return this.FLv24;
      }
      
      public function get Lv25() : String
      {
         return this.FLv25;
      }
      
      public function get Lv26() : String
      {
         return this.FLv26;
      }
      
      public function get Lv27() : String
      {
         return this.FLv27;
      }
      
      public function get Lv28() : String
      {
         return this.FLv28;
      }
      
      public function get Lv29() : String
      {
         return this.FLv29;
      }
      
      public function get Lv30() : String
      {
         return this.FLv30;
      }
      
      public function get Lv31() : String
      {
         return this.FLv31;
      }
      
      public function get Lv32() : String
      {
         return this.FLv32;
      }
      
      public function get Lv33() : String
      {
         return this.FLv33;
      }
      
      public function get Lv34() : String
      {
         return this.FLv34;
      }
      
      public function get Lv35() : String
      {
         return this.FLv35;
      }
      
      public function get Lv36() : String
      {
         return this.FLv36;
      }
      
      public function get Lv37() : String
      {
         return this.FLv37;
      }
      
      public function get Lv38() : String
      {
         return this.FLv38;
      }
      
      public function get Lv39() : String
      {
         return this.FLv39;
      }
      
      public function get Lv40() : String
      {
         return this.FLv40;
      }
      
      public function get LvArr() : Array
      {
         return this.FLvArr;
      }
      
      public function get Lv1AddValues() : Vector.<int>
      {
         return this.FLv1AddValues;
      }
      
      public function get Lv20AddValues() : Vector.<int>
      {
         return this.FLv20AddValues;
      }
      
      public function get Lv40AddValues() : Vector.<int>
      {
         return this.FLv40AddValues;
      }
   }
}

