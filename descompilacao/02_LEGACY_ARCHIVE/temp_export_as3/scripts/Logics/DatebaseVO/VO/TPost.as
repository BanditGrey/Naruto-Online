package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TPost extends TDatebaseVO
   {
      
      protected var FChannel:uint;
      
      protected var FShow:String;
      
      protected var FTemplateTaskFront:String;
      
      protected var FTextColor:uint;
      
      protected var FTextSize:uint;
      
      protected var FEvent:String;
      
      protected var FDelay:String;
      
      protected var FShowChannels:Array;
      
      protected var FTime:Array;
      
      public function TPost()
      {
         super();
         this.FShowChannels = new Array();
         this.FTime = new Array();
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
         param1.writeUnsignedInt(Identifier);
         param1.writeUnsignedInt(this.FChannel);
         TUtilityString.FlushUTF(param1,this.FShow);
         TUtilityString.FlushUTF(param1,this.FTemplateTaskFront);
         TUtilityString.FlushUTF(param1,this.FTextColor.toString());
         param1.writeUnsignedInt(this.FTextSize);
         TUtilityString.FlushUTF(param1,this.FEvent);
         TUtilityString.FlushUTF(param1,this.FDelay);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         this.FChannel = param1.readUnsignedInt();
         this.FShow = TUtilityString.FetchUTF(param1);
         this.FShowChannels = this.FShow.split(",");
         this.FTemplateTaskFront = TUtilityString.FetchUTF(param1);
         this.FTextColor = parseInt(TUtilityString.FetchUTF(param1));
         this.FTextSize = param1.readUnsignedInt();
         this.FEvent = TUtilityString.FetchUTF(param1);
         this.FDelay = TUtilityString.FetchUTF(param1);
         this.FTime = Json.decode(this.FDelay) as Array;
      }
      
      public function get Channel() : uint
      {
         return this.FChannel;
      }
      
      public function set Channel(param1:uint) : void
      {
         this.FChannel = param1;
      }
      
      public function get Show() : String
      {
         return this.FShow;
      }
      
      public function get ShowChannels() : Array
      {
         return this.FShowChannels;
      }
      
      public function get TemplateTaskFront() : String
      {
         return this.FTemplateTaskFront;
      }
      
      public function get TextColor() : uint
      {
         return this.FTextColor;
      }
      
      public function get TextSize() : uint
      {
         return this.FTextSize;
      }
      
      public function get Event() : String
      {
         return this.FEvent;
      }
      
      public function get Time() : Array
      {
         return this.FTime;
      }
      
      public function get Delay() : String
      {
         return this.FDelay;
      }
      
      public function TestInit() : void
      {
         this.FChannel = 1;
         this.FShow = "1,6";
         this.FTemplateTaskFront = "测试数据$OutLineUnderline$外链接出去！";
         this.FTextColor = 13421670;
         this.FTextSize = 12;
         this.FEvent = "";
         this.FDelay = "";
         this.FShowChannels = ["1","6"];
         this.FTime = [];
      }
   }
}

