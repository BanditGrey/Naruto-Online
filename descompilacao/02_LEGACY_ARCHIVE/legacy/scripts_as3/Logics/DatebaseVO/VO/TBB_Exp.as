package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TBB_Exp extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FLv1:int;
      
      protected var FLv2:int;
      
      protected var FLv3:int;
      
      protected var FLv4:int;
      
      protected var FLv5:int;
      
      protected var FLv6:int;
      
      protected var FLv7:int;
      
      protected var FLv8:int;
      
      protected var FLv9:int;
      
      protected var FLv10:int;
      
      protected var FLv11:int;
      
      protected var FLv12:int;
      
      protected var FLv13:int;
      
      protected var FLv14:int;
      
      protected var FLv15:int;
      
      protected var FLv16:int;
      
      protected var FLv17:int;
      
      protected var FLv18:int;
      
      protected var FLv19:int;
      
      protected var FLv20:int;
      
      protected var FLv21:int;
      
      protected var FLv22:int;
      
      protected var FLv23:int;
      
      protected var FLv24:int;
      
      protected var FLv25:int;
      
      protected var FLv26:int;
      
      protected var FLv27:int;
      
      protected var FLv28:int;
      
      protected var FLv29:int;
      
      protected var FLv30:int;
      
      protected var FLv31:int;
      
      protected var FLv32:int;
      
      protected var FLv33:int;
      
      protected var FLv34:int;
      
      protected var FLv35:int;
      
      protected var FLv36:int;
      
      protected var FLv37:int;
      
      protected var FLv38:int;
      
      protected var FLv39:int;
      
      protected var FLv40:int;
      
      protected var FPRE_EXP:int;
      
      protected var FLvArr:Array;
      
      public function TBB_Exp()
      {
         super();
         this.FLvArr = new Array();
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
         param1.writeUnsignedInt(this.FLv1);
         param1.writeUnsignedInt(this.FLv2);
         param1.writeUnsignedInt(this.FLv3);
         param1.writeUnsignedInt(this.FLv4);
         param1.writeUnsignedInt(this.FLv5);
         param1.writeUnsignedInt(this.FLv6);
         param1.writeUnsignedInt(this.FLv7);
         param1.writeUnsignedInt(this.FLv8);
         param1.writeUnsignedInt(this.FLv9);
         param1.writeUnsignedInt(this.FLv10);
         param1.writeUnsignedInt(this.FLv11);
         param1.writeUnsignedInt(this.FLv12);
         param1.writeUnsignedInt(this.FLv13);
         param1.writeUnsignedInt(this.FLv14);
         param1.writeUnsignedInt(this.FLv15);
         param1.writeUnsignedInt(this.FLv16);
         param1.writeUnsignedInt(this.FLv17);
         param1.writeUnsignedInt(this.FLv18);
         param1.writeUnsignedInt(this.FLv19);
         param1.writeUnsignedInt(this.FLv20);
         param1.writeUnsignedInt(this.FLv21);
         param1.writeUnsignedInt(this.FLv22);
         param1.writeUnsignedInt(this.FLv23);
         param1.writeUnsignedInt(this.FLv24);
         param1.writeUnsignedInt(this.FLv25);
         param1.writeUnsignedInt(this.FLv26);
         param1.writeUnsignedInt(this.FLv27);
         param1.writeUnsignedInt(this.FLv28);
         param1.writeUnsignedInt(this.FLv29);
         param1.writeUnsignedInt(this.FLv30);
         param1.writeUnsignedInt(this.FLv31);
         param1.writeUnsignedInt(this.FLv32);
         param1.writeUnsignedInt(this.FLv33);
         param1.writeUnsignedInt(this.FLv34);
         param1.writeUnsignedInt(this.FLv35);
         param1.writeUnsignedInt(this.FLv36);
         param1.writeUnsignedInt(this.FLv37);
         param1.writeUnsignedInt(this.FLv38);
         param1.writeUnsignedInt(this.FLv39);
         param1.writeUnsignedInt(this.FLv40);
         param1.writeUnsignedInt(this.FPRE_EXP);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FLv1 = param1.readUnsignedInt();
         this.FLv2 = param1.readUnsignedInt();
         this.FLv3 = param1.readUnsignedInt();
         this.FLv4 = param1.readUnsignedInt();
         this.FLv5 = param1.readUnsignedInt();
         this.FLv6 = param1.readUnsignedInt();
         this.FLv7 = param1.readUnsignedInt();
         this.FLv8 = param1.readUnsignedInt();
         this.FLv9 = param1.readUnsignedInt();
         this.FLv10 = param1.readUnsignedInt();
         this.FLv11 = param1.readUnsignedInt();
         this.FLv12 = param1.readUnsignedInt();
         this.FLv13 = param1.readUnsignedInt();
         this.FLv14 = param1.readUnsignedInt();
         this.FLv15 = param1.readUnsignedInt();
         this.FLv16 = param1.readUnsignedInt();
         this.FLv17 = param1.readUnsignedInt();
         this.FLv18 = param1.readUnsignedInt();
         this.FLv19 = param1.readUnsignedInt();
         this.FLv20 = param1.readUnsignedInt();
         this.FLv21 = param1.readUnsignedInt();
         this.FLv22 = param1.readUnsignedInt();
         this.FLv23 = param1.readUnsignedInt();
         this.FLv24 = param1.readUnsignedInt();
         this.FLv25 = param1.readUnsignedInt();
         this.FLv26 = param1.readUnsignedInt();
         this.FLv27 = param1.readUnsignedInt();
         this.FLv28 = param1.readUnsignedInt();
         this.FLv29 = param1.readUnsignedInt();
         this.FLv30 = param1.readUnsignedInt();
         this.FLv31 = param1.readUnsignedInt();
         this.FLv32 = param1.readUnsignedInt();
         this.FLv33 = param1.readUnsignedInt();
         this.FLv34 = param1.readUnsignedInt();
         this.FLv35 = param1.readUnsignedInt();
         this.FLv36 = param1.readUnsignedInt();
         this.FLv37 = param1.readUnsignedInt();
         this.FLv38 = param1.readUnsignedInt();
         this.FLv39 = param1.readUnsignedInt();
         this.FLv40 = param1.readUnsignedInt();
         this.FPRE_EXP = param1.readUnsignedInt();
         this.FLvArr[0] = this.FLv1;
         this.FLvArr[1] = this.FLv2;
         this.FLvArr[2] = this.FLv3;
         this.FLvArr[3] = this.FLv4;
         this.FLvArr[4] = this.FLv5;
         this.FLvArr[5] = this.FLv6;
         this.FLvArr[6] = this.FLv7;
         this.FLvArr[7] = this.FLv8;
         this.FLvArr[8] = this.FLv9;
         this.FLvArr[9] = this.FLv10;
         this.FLvArr[10] = this.FLv11;
         this.FLvArr[11] = this.FLv12;
         this.FLvArr[12] = this.FLv13;
         this.FLvArr[13] = this.FLv14;
         this.FLvArr[14] = this.FLv15;
         this.FLvArr[15] = this.FLv16;
         this.FLvArr[16] = this.FLv17;
         this.FLvArr[17] = this.FLv18;
         this.FLvArr[18] = this.FLv19;
         this.FLvArr[19] = this.FLv20;
         this.FLvArr[20] = this.FLv21;
         this.FLvArr[21] = this.FLv22;
         this.FLvArr[22] = this.FLv23;
         this.FLvArr[23] = this.FLv24;
         this.FLvArr[24] = this.FLv25;
         this.FLvArr[25] = this.FLv26;
         this.FLvArr[26] = this.FLv27;
         this.FLvArr[27] = this.FLv28;
         this.FLvArr[28] = this.FLv29;
         this.FLvArr[29] = this.FLv30;
         this.FLvArr[30] = this.FLv31;
         this.FLvArr[31] = this.FLv32;
         this.FLvArr[32] = this.FLv33;
         this.FLvArr[33] = this.FLv34;
         this.FLvArr[34] = this.FLv35;
         this.FLvArr[35] = this.FLv36;
         this.FLvArr[36] = this.FLv37;
         this.FLvArr[37] = this.FLv38;
         this.FLvArr[38] = this.FLv39;
         this.FLvArr[39] = this.FLv40;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Lv1() : int
      {
         return this.FLv1;
      }
      
      public function get Lv2() : int
      {
         return this.FLv2;
      }
      
      public function get Lv3() : int
      {
         return this.FLv3;
      }
      
      public function get Lv4() : int
      {
         return this.FLv4;
      }
      
      public function get Lv5() : int
      {
         return this.FLv5;
      }
      
      public function get Lv6() : int
      {
         return this.FLv6;
      }
      
      public function get Lv7() : int
      {
         return this.FLv7;
      }
      
      public function get Lv8() : int
      {
         return this.FLv8;
      }
      
      public function get Lv9() : int
      {
         return this.FLv9;
      }
      
      public function get Lv10() : int
      {
         return this.FLv10;
      }
      
      public function get Lv11() : int
      {
         return this.FLv11;
      }
      
      public function get Lv12() : int
      {
         return this.FLv12;
      }
      
      public function get Lv13() : int
      {
         return this.FLv13;
      }
      
      public function get Lv14() : int
      {
         return this.FLv14;
      }
      
      public function get Lv15() : int
      {
         return this.FLv15;
      }
      
      public function get Lv16() : int
      {
         return this.FLv16;
      }
      
      public function get Lv17() : int
      {
         return this.FLv17;
      }
      
      public function get Lv18() : int
      {
         return this.FLv18;
      }
      
      public function get Lv19() : int
      {
         return this.FLv19;
      }
      
      public function get Lv20() : int
      {
         return this.FLv20;
      }
      
      public function get Lv21() : int
      {
         return this.FLv21;
      }
      
      public function get Lv22() : int
      {
         return this.FLv22;
      }
      
      public function get Lv23() : int
      {
         return this.FLv23;
      }
      
      public function get Lv24() : int
      {
         return this.FLv24;
      }
      
      public function get Lv25() : int
      {
         return this.FLv25;
      }
      
      public function get Lv26() : int
      {
         return this.FLv26;
      }
      
      public function get Lv27() : int
      {
         return this.FLv27;
      }
      
      public function get Lv28() : int
      {
         return this.FLv28;
      }
      
      public function get Lv29() : int
      {
         return this.FLv29;
      }
      
      public function get Lv30() : int
      {
         return this.FLv30;
      }
      
      public function get Lv31() : int
      {
         return this.FLv31;
      }
      
      public function get Lv32() : int
      {
         return this.FLv32;
      }
      
      public function get Lv33() : int
      {
         return this.FLv33;
      }
      
      public function get Lv34() : int
      {
         return this.FLv34;
      }
      
      public function get Lv35() : int
      {
         return this.FLv35;
      }
      
      public function get Lv36() : int
      {
         return this.FLv36;
      }
      
      public function get Lv37() : int
      {
         return this.FLv37;
      }
      
      public function get Lv38() : int
      {
         return this.FLv38;
      }
      
      public function get Lv39() : int
      {
         return this.FLv39;
      }
      
      public function get Lv40() : int
      {
         return this.FLv40;
      }
      
      public function get PRE_EXP() : int
      {
         return this.FPRE_EXP;
      }
      
      public function get LvArr() : Array
      {
         return this.FLvArr;
      }
   }
}

