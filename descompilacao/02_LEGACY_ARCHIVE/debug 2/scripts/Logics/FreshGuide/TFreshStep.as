package Logics.FreshGuide
{
   import Foundation.Common.TCoordinate;
   import Foundation.Common.TEntity;
   import flash.display.DisplayObjectContainer;
   
   public class TFreshStep extends TEntity
   {
      
      protected var FRelationDisplayObject:DisplayObjectContainer;
      
      protected var FArrowPosition:TCoordinate;
      
      protected var FMessage:String;
      
      protected var FTriggerCode:int;
      
      protected var FIfAlreadyTrigger:Boolean;
      
      protected var FIfAutoTrigger:Boolean;
      
      protected var FCompleteCode:int;
      
      protected var FIfKeyNode:Boolean;
      
      protected var FKeyNodeCompleteProgress:int;
      
      protected var FNextTaskIdentifier:uint;
      
      protected var FRelationLayer:int;
      
      protected var FRelationModule:int;
      
      protected var FTelesportCode:int;
      
      protected var FTelesportTargetID:int;
      
      protected var FSpecialHandleID:int;
      
      public function TFreshStep(param1:uint)
      {
         super(param1);
         this.FArrowPosition = new TCoordinate();
      }
      
      public function get IfKeyNode() : Boolean
      {
         return this.FIfKeyNode;
      }
      
      public function set IfKeyNode(param1:Boolean) : void
      {
         this.FIfKeyNode = param1;
      }
      
      public function get ArrowPosition() : TCoordinate
      {
         return this.FArrowPosition;
      }
      
      public function set ArrowPosition(param1:TCoordinate) : void
      {
         this.FArrowPosition = param1;
      }
      
      public function get Message() : String
      {
         return this.FMessage;
      }
      
      public function set Message(param1:String) : void
      {
         this.FMessage = param1;
      }
      
      public function get TriggerCode() : int
      {
         return this.FTriggerCode;
      }
      
      public function set TriggerCode(param1:int) : void
      {
         this.FTriggerCode = param1;
      }
      
      public function get CompleteCode() : int
      {
         return this.FCompleteCode;
      }
      
      public function set CompleteCode(param1:int) : void
      {
         this.FCompleteCode = param1;
      }
      
      public function get KeyNodeCompleteProgress() : int
      {
         return this.FKeyNodeCompleteProgress;
      }
      
      public function set KeyNodeCompleteProgress(param1:int) : void
      {
         this.FKeyNodeCompleteProgress = param1;
      }
      
      public function get IfAlreadyTrigger() : Boolean
      {
         return this.FIfAlreadyTrigger;
      }
      
      public function set IfAlreadyTrigger(param1:Boolean) : void
      {
         this.FIfAlreadyTrigger = param1;
      }
      
      public function get IfAutoTrigger() : Boolean
      {
         return this.FIfAutoTrigger;
      }
      
      public function set IfAutoTrigger(param1:Boolean) : void
      {
         this.FIfAutoTrigger = param1;
      }
      
      public function get RelationDisplayObject() : DisplayObjectContainer
      {
         return this.FRelationDisplayObject;
      }
      
      public function set RelationDisplayObject(param1:DisplayObjectContainer) : void
      {
         this.FRelationDisplayObject = param1;
      }
      
      public function get NextTaskIdentifier() : uint
      {
         return this.FNextTaskIdentifier;
      }
      
      public function set NextTaskIdentifier(param1:uint) : void
      {
         this.FNextTaskIdentifier = param1;
      }
      
      public function get RelationLayer() : int
      {
         return this.FRelationLayer;
      }
      
      public function set RelationLayer(param1:int) : void
      {
         this.FRelationLayer = param1;
      }
      
      public function get RelationModule() : int
      {
         return this.FRelationModule;
      }
      
      public function set RelationModule(param1:int) : void
      {
         this.FRelationModule = param1;
      }
      
      public function get TelesportCode() : int
      {
         return this.FTelesportCode;
      }
      
      public function set TelesportCode(param1:int) : void
      {
         this.FTelesportCode = param1;
      }
      
      public function get TelesportTargetID() : int
      {
         return this.FTelesportTargetID;
      }
      
      public function set TelesportTargetID(param1:int) : void
      {
         this.FTelesportTargetID = param1;
      }
      
      public function get SpecialHandleID() : int
      {
         return this.FSpecialHandleID;
      }
      
      public function set SpecialHandleID(param1:int) : void
      {
         this.FSpecialHandleID = param1;
      }
   }
}

