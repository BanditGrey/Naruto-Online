package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import flash.utils.*;
   
   use namespace ResourcesSpace;
   
   public class TNewGuide extends TDatebaseVO
   {
      
      protected var FGuideMessage:String;
      
      protected var FIfKeyNode:Boolean;
      
      protected var FSendIndex:uint;
      
      protected var FTriggerIndex:int;
      
      protected var FCompleteIndex:int;
      
      protected var FAutoTrigger:Boolean;
      
      protected var FArrowX:int;
      
      protected var FArrowY:int;
      
      protected var FNextTaskID:uint;
      
      protected var FRelationLayer:int;
      
      protected var FRelationModule:int;
      
      protected var FTelesportCode:int;
      
      protected var FTelesportTargetID:int;
      
      protected var FSpecialHandleID:int;
      
      public function TNewGuide()
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
         param1.writeUnsignedInt(_loc3_);
         TUtilityString.FlushUTF(param1,this.FGuideMessage);
         param1.writeBoolean(this.FIfKeyNode);
         param1.writeUnsignedInt(this.FSendIndex);
         param1.writeUnsignedInt(this.FTriggerIndex);
         param1.writeUnsignedInt(this.FCompleteIndex);
         param1.writeBoolean(this.FAutoTrigger);
         param1.writeUnsignedInt(this.FArrowX);
         param1.writeUnsignedInt(this.FArrowY);
         param1.writeUnsignedInt(this.FNextTaskID);
         param1.writeUnsignedInt(this.FRelationLayer);
         param1.writeUnsignedInt(this.FRelationModule);
         param1.writeUnsignedInt(this.FTelesportCode);
         param1.writeUnsignedInt(this.FTelesportTargetID);
         param1.writeUnsignedInt(this.FSpecialHandleID);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         param1.readInt();
         this.FGuideMessage = TUtilityString.FetchUTF(param1);
         this.FIfKeyNode = param1.readBoolean();
         this.FSendIndex = param1.readUnsignedInt();
         this.FTriggerIndex = param1.readInt();
         this.FCompleteIndex = param1.readInt();
         this.FAutoTrigger = param1.readBoolean();
         this.FArrowX = param1.readInt();
         this.FArrowY = param1.readInt();
         this.FNextTaskID = param1.readUnsignedInt();
         this.FRelationLayer = param1.readInt();
         this.FRelationModule = param1.readInt();
         this.FTelesportCode = param1.readInt();
         this.FTelesportTargetID = param1.readInt();
         this.FSpecialHandleID = param1.readInt();
      }
      
      public function get GuideMessage() : String
      {
         return this.FGuideMessage;
      }
      
      public function get IfKeyNode() : Boolean
      {
         return this.FIfKeyNode;
      }
      
      public function get SendIndex() : uint
      {
         return this.FSendIndex;
      }
      
      public function get TriggerIndex() : int
      {
         return this.FTriggerIndex;
      }
      
      public function get CompleteIndex() : int
      {
         return this.FCompleteIndex;
      }
      
      public function get AutoTrigger() : Boolean
      {
         return this.FAutoTrigger;
      }
      
      public function get ArrowX() : int
      {
         return this.FArrowX;
      }
      
      public function get ArrowY() : int
      {
         return this.FArrowY;
      }
      
      public function get NextTaskID() : uint
      {
         return this.FNextTaskID;
      }
      
      public function get RelationLayer() : int
      {
         return this.FRelationLayer;
      }
      
      public function get RelationModule() : int
      {
         return this.FRelationModule;
      }
      
      public function get TelesportTargetID() : int
      {
         return this.FTelesportTargetID;
      }
      
      public function get TelesportCode() : int
      {
         return this.FTelesportCode;
      }
      
      public function get SpecialHandleID() : int
      {
         return this.FSpecialHandleID;
      }
   }
}

