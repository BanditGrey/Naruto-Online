package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TPopTips extends TDatebaseVO
   {
      
      protected var FImage:uint;
      
      protected var FTitle:String;
      
      protected var FTips:String;
      
      protected var FPanel:int;
      
      protected var FOpenButton:String;
      
      protected var FDownLevel:int;
      
      protected var FUpLevel:int;
      
      public function TPopTips()
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
                     else if(this[_loc3_] is String)
                     {
                        this[_loc3_] = _loc4_;
                        this[_loc3_] = String(this[_loc3_]).split("&lt;").join("<");
                        this[_loc3_] = String(this[_loc3_]).split("&gt;").join(">");
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
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FTitle);
         TUtilityString.FlushUTF(param1,this.FTips);
         param1.writeUnsignedInt(this.FPanel);
         TUtilityString.FlushUTF(param1,this.FOpenButton);
         param1.writeUnsignedInt(this.FDownLevel);
         param1.writeUnsignedInt(this.FUpLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FImage = param1.readUnsignedInt();
         this.FTitle = TUtilityString.FetchUTF(param1);
         this.FTips = TUtilityString.FetchUTF(param1);
         this.FPanel = param1.readUnsignedInt();
         this.FOpenButton = TUtilityString.FetchUTF(param1);
         this.FDownLevel = param1.readUnsignedInt();
         this.FUpLevel = param1.readUnsignedInt();
      }
      
      public function get Image() : uint
      {
         return this.FImage;
      }
      
      public function get Title() : String
      {
         return this.FTitle;
      }
      
      public function get Tips() : String
      {
         return this.FTips;
      }
      
      public function get Panel() : int
      {
         return this.FPanel;
      }
      
      public function get OpenButton() : String
      {
         return this.FOpenButton;
      }
      
      public function get DownLevel() : int
      {
         return this.FDownLevel;
      }
      
      public function get UpLevel() : int
      {
         return this.FUpLevel;
      }
   }
}

