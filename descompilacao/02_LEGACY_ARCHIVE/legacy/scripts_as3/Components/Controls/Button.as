package Components.Controls
{
   import Components.Controls.Conversion.*;
   import Components.Controls.Managers.*;
   import Components.Controls.ModeStyles.*;
   import Components.Controls.Skin.*;
   import Components.Controls.Support.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class Button extends BaseButton
   {
      
      protected var txt:TextField;
      
      protected var txtDrop:TextField;
      
      protected var tf:TextFormat;
      
      protected var iconClassSet:Object;
      
      protected var iconBD:Bitmap;
      
      protected var iconOverClassSet:Object;
      
      protected var iconDownClassSet:Object;
      
      protected var _mode:String = "justLabel";
      
      protected var mouseState:String = "mouseOut";
      
      protected var _isOutSkinHide:Boolean = false;
      
      public function Button()
      {
         super();
         _compoWidth = 69;
         _compoHeight = 20;
         new ButtonStyle(styleSet);
         this.txt = new TextField();
         this.txtDrop = new TextField();
         this.txtDrop.textColor = 16777215;
         this.txtDrop.alpha = DefaultStyle.buttonTextDropAlpha;
         this.txtDrop.selectable = false;
         this.txtDrop.mouseEnabled = false;
         this.addChild(this.txtDrop);
         this.addChild(this.txt);
         this.tf = new TextFormat();
         this.tf.align = TextFormatAlign.CENTER;
         this.tf.size = DefaultStyle.fontSize;
         this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
         this.tf.font = DefaultStyle.font;
         this.txt.height = DefaultStyle.fontSize + 8;
         this.txt.selectable = false;
         this.txt.mouseEnabled = false;
         this.txt.setTextFormat(this.tf);
         this.txtDrop.height = this.txt.height;
         this.txt.filters = DefaultStyle.buttonTextFilters;
         this.label = "按钮";
         this.setSize(_compoWidth,_compoHeight);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.showOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.showOut);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.showDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.showUp);
      }
      
      override public function setDefaultSkin() : void
      {
         this.setSkin(ButtonSkin);
      }
      
      override public function setSkin(param1:Class) : void
      {
         skin = new param1();
         if(skin is ActionDrawSkin)
         {
            ActionDrawSkin(skin).init(this,styleSet);
         }
      }
      
      public function set label(param1:String) : void
      {
         this.txt.text = param1;
         this.txt.setTextFormat(this.tf);
         var _loc2_:Object = this.tf.color;
         this.txtDrop.text = this.txt.text;
         this.tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonTextDropColor);
         this.txtDrop.setTextFormat(this.tf);
         this.tf.color = _loc2_;
      }
      
      public function get label() : String
      {
         return this.txt.text;
      }
      
      public function set icon(param1:Object) : void
      {
         var _loc2_:Object = null;
         if(this._mode == ButtonMode.JUST_LABEL)
         {
            this._mode = ButtonMode.ICON_LABEL;
         }
         if(!(param1 is String))
         {
            this.iconClassSet = new param1();
            if(this.iconClassSet is BitmapData)
            {
               this.setBitmap(this.iconClassSet);
               this.iconBD.y = Math.round((_compoHeight - this.iconBD.height) / 2);
               this.iconBD.x = this.iconBD.y + 9;
               this.addChild(this.iconBD);
               if(this._mode == ButtonMode.ICON_LABEL)
               {
                  this.tf.align = TextFormatAlign.LEFT;
                  this.txt.x = this.iconBD.x * 2 + this.iconBD.width - 9;
                  this.txt.width = _compoWidth - this.txt.x;
                  this.txt.setTextFormat(this.tf);
                  this.txtDrop.width = this.txt.width;
                  this.txtDrop.x = this.txt.x;
                  this.txtDrop.y = this.txt.y + 1;
                  _loc2_ = this.tf.color;
                  this.txtDrop.text = this.txt.text;
                  this.tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonTextDropColor);
                  this.txtDrop.setTextFormat(this.tf);
                  this.tf.color = _loc2_;
               }
            }
         }
      }
      
      public function get textField() : TextField
      {
         return this.txt;
      }
      
      public function set mode(param1:String) : void
      {
         this._mode = param1;
         if(this._mode == ButtonMode.JUST_ICON)
         {
            this.removeChild(this.txt);
            this.removeChild(this.txtDrop);
            this.txt = null;
            this.txtDrop = null;
            this.setSize(_compoWidth,_compoHeight);
         }
      }
      
      public function set isOutSkinHide(param1:Boolean) : void
      {
         this._isOutSkinHide = param1;
         if(this._isOutSkinHide == true)
         {
            if(skin is ActionDrawSkin)
            {
               ActionDrawSkin(skin).hideOutState();
            }
         }
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         if(this._mode == ButtonMode.JUST_ICON)
         {
            this.iconBD.x = int((_compoWidth - this.iconBD.width) / 2) + 1;
         }
         else
         {
            this.txt.x = Number(styleSet[ButtonStyle.TEXT_BattlefieldDING]);
            this.txt.width = _compoWidth - this.txt.x * 2;
            this.txt.height = this.txt.textHeight + 5;
            this.txt.y = int((_compoHeight - this.txt.height) / 2);
            this.txtDrop.width = this.txt.width;
            this.txtDrop.x = this.txt.x;
            this.txtDrop.y = this.txt.y;
         }
      }
      
      public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
      {
         this.txt.setTextFormat(param1,param2,param3);
      }
      
      override public function setStyle(param1:String, param2:Object) : void
      {
         super.setStyle(param1,param2);
         switch(param1)
         {
            case ButtonStyle.TEXT_COLOR:
               if(this.mouseState == MouseEvent.MOUSE_OUT)
               {
                  this.showOut();
               }
               break;
            case ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH:
               if(skin is ActionDrawSkin)
               {
                  ActionDrawSkin(skin).reDraw();
               }
               break;
            case ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT:
               if(skin is ActionDrawSkin)
               {
                  ActionDrawSkin(skin).reDraw();
               }
               break;
            case ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH:
               if(skin is ActionDrawSkin)
               {
                  ActionDrawSkin(skin).reDraw();
               }
               break;
            case ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT:
               if(skin is ActionDrawSkin)
               {
                  ActionDrawSkin(skin).reDraw();
               }
               break;
            case ButtonStyle.ICON_OVER:
               this.iconOverClassSet = new param2();
               break;
            case ButtonStyle.ICON_DOWN:
               this.iconDownClassSet = new param2();
               break;
            case ButtonStyle.TEXT_ALIGN:
               this.tf.align = String(param2);
               this.txt.setTextFormat(this.tf);
            case ButtonStyle.TEXT_BattlefieldDING:
               this.txt.x = Number(param2);
               this.txt.width = _compoWidth - this.txt.x * 2;
         }
      }
      
      override public function updateSkin() : void
      {
         super.updateSkin();
         if(findStyleUserSet(ButtonStyle.TEXT_COLOR) == false)
         {
            styleSet[ButtonStyle.TEXT_COLOR] = DefaultStyle.buttonOutTextColor;
         }
         if(findStyleUserSet(ButtonStyle.TEXT_OVER_COLOR) == false)
         {
            styleSet[ButtonStyle.TEXT_OVER_COLOR] = DefaultStyle.buttonOverTextColor;
         }
         if(findStyleUserSet(ButtonStyle.TEXT_DOWN_COLOR) == false)
         {
            styleSet[ButtonStyle.TEXT_DOWN_COLOR] = DefaultStyle.buttonDownTextColor;
         }
         this.initTextColor();
      }
      
      protected function showOver(param1:MouseEvent = null) : void
      {
         this.mouseState = MouseEvent.MOUSE_OVER;
         if(this.iconOverClassSet != null)
         {
            this.setBitmap(this.iconOverClassSet);
         }
         if(this._mode == ButtonMode.JUST_LABEL || this._mode == ButtonMode.ICON_LABEL)
         {
            this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_OVER_COLOR]);
            this.txt.setTextFormat(this.tf);
         }
      }
      
      protected function showUp(param1:MouseEvent = null) : void
      {
         this.mouseState = MouseEvent.MOUSE_OVER;
         if(this.iconOverClassSet != null)
         {
            this.setBitmap(this.iconOverClassSet);
         }
         if(this._mode == ButtonMode.JUST_LABEL || this._mode == ButtonMode.ICON_LABEL)
         {
            this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_OVER_COLOR]);
            this.txt.setTextFormat(this.tf);
         }
      }
      
      protected function showOut(param1:MouseEvent = null) : void
      {
         this.mouseState = MouseEvent.MOUSE_OUT;
         if(this.iconClassSet != null)
         {
            this.setBitmap(this.iconClassSet);
         }
         if(this._mode == ButtonMode.JUST_LABEL || this._mode == ButtonMode.ICON_LABEL)
         {
            this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
            this.txt.setTextFormat(this.tf);
         }
      }
      
      protected function initTextColor() : void
      {
         this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
         if(this.txt != null)
         {
            this.txt.setTextFormat(this.tf);
         }
      }
      
      protected function showDown(param1:MouseEvent = null) : void
      {
         this.mouseState = MouseEvent.MOUSE_DOWN;
         if(this.iconDownClassSet != null)
         {
            this.setBitmap(this.iconDownClassSet);
         }
         if(this._mode == ButtonMode.JUST_LABEL || this._mode == ButtonMode.ICON_LABEL)
         {
            this.tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_DOWN_COLOR]);
            this.txt.setTextFormat(this.tf);
         }
      }
      
      protected function setBitmap(param1:Object) : void
      {
         if(this.iconBD == null)
         {
            this.iconBD = new Bitmap();
         }
         this.iconBD.bitmapData = param1 as BitmapData;
      }
   }
}

