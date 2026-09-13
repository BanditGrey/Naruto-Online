package Components.Controls.Support
{
   import Components.Controls.Managers.*;
   import Components.Controls.Skin.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   
   public class UIComponent extends Sprite
   {
      
      public static var stage:Stage;
      
      public static var isCtrlKeyDown:Boolean = false;
      
      public static var isAltKeyDown:Boolean = false;
      
      protected var _compoWidth:Number = 10;
      
      protected var _compoHeight:Number = 10;
      
      protected var styleSet:Object = new Object();
      
      protected var isStyleUserSet:Object = new Object();
      
      protected var skin:Object;
      
      public function UIComponent()
      {
         super();
         ComponentsManager.allRefs.push(this);
         if(SkinManager.isUseDefaultSkin == true)
         {
            this.setDefaultSkin();
         }
         if(stage == null)
         {
            this.addEventListener(Event.ADDED_TO_STAGE,this.addToStageInit);
         }
      }
      
      protected static function initStageLis() : void
      {
         UIComponent.stage.addEventListener(KeyboardEvent.KEY_DOWN,checkKeyDown);
         UIComponent.stage.addEventListener(KeyboardEvent.KEY_UP,checkKeyUp);
      }
      
      protected static function checkKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.CONTROL)
         {
            isCtrlKeyDown = param1.ctrlKey;
         }
         isCtrlKeyDown = false;
      }
      
      protected static function checkKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.CONTROL)
         {
            isCtrlKeyDown = param1.ctrlKey;
         }
      }
      
      public function get compoWidth() : Number
      {
         return this._compoWidth;
      }
      
      public function set compoWidth(param1:Number) : void
      {
         this._compoWidth = param1;
      }
      
      public function get compoHeight() : Number
      {
         return this._compoHeight;
      }
      
      public function set compoHeight(param1:Number) : void
      {
         this._compoHeight = param1;
      }
      
      public function set toolTip(param1:String) : void
      {
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._compoWidth = param1;
         this._compoHeight = param2;
         if(this.skin != null && this.skin is ActionDrawSkin)
         {
            try
            {
               ActionDrawSkin(this.skin).reDraw();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function updateSkin() : void
      {
         try
         {
            this.skin.updateSkin();
         }
         catch(e:Error)
         {
         }
      }
      
      public function setDefaultSkin() : void
      {
      }
      
      public function setSkin(param1:Class) : void
      {
      }
      
      public function setStyle(param1:String, param2:Object) : void
      {
         this.styleSet[param1] = param2;
         this.isStyleUserSet[param1] = true;
      }
      
      public function getStyleValue(param1:String) : Object
      {
         return this.styleSet[param1];
      }
      
      protected function findStyleUserSet(param1:String) : Boolean
      {
         var a:Boolean = false;
         var styleName:String = param1;
         try
         {
            a = Boolean(this.isStyleUserSet[styleName]);
         }
         catch(e:Error)
         {
            return false;
         }
         return a;
      }
      
      private function addToStageInit(param1:Event) : void
      {
         UIComponent.stage = this.stage;
         initStageLis();
      }
   }
}

