package Components.ScrollBar
{
   import Foundation.Utilities.TGameUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TScrollNobar
   {
      
      protected var FScene:MovieClip;
      
      protected var FScrolVisible:Boolean;
      
      protected var FMinScrollDistance:Number;
      
      protected var FItemStamp:Number;
      
      protected var FSingleItemStamp:Number;
      
      protected var FInitListPosY:Number;
      
      protected var FItems:Vector.<DisplayObject>;
      
      protected var FMaxHeight:int;
      
      protected var FAddItemAutoDown:Boolean;
      
      protected var FIsNoToUp:Boolean;
      
      protected var FColNum:int;
      
      protected var FPadding:int;
      
      public function TScrollNobar(param1:MovieClip, param2:Number, param3:Boolean = true, param4:Number = 0, param5:Number = 0, param6:int = 1, param7:int = 0)
      {
         super();
         this.FScene = param1;
         this.FMinScrollDistance = param2;
         this.FAddItemAutoDown = param3;
         this.FItemStamp = param4;
         this.FSingleItemStamp = param5;
         this.FColNum = param6;
         this.FPadding = param7;
         this.InitScroll();
      }
      
      protected function set ScrolVisible(param1:Boolean) : void
      {
         this.FScrolVisible = param1;
         this.FScene.btn_up.visible = param1;
         this.FScene.btn_down.visible = param1;
      }
      
      protected function get ScrolVisible() : Boolean
      {
         return this.FScrolVisible;
      }
      
      protected function InitScroll() : void
      {
         this.ScrolVisible = false;
         this.FItems = new Vector.<DisplayObject>();
         this.FMaxHeight = 0;
         this.FInitListPosY = this.FScene.mc_list.y;
         TGameUtil.setMovieClipButton(this.FScene.btn_up,true);
         this.FScene.btn_up.addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         TGameUtil.setMovieClipButton(this.FScene.btn_down,true);
         this.FScene.btn_down.addEventListener(MouseEvent.MOUSE_UP,this.OnMouseDown);
      }
      
      protected function CheckBtn() : void
      {
         TGameUtil.setMovieClipButton(this.FScene.btn_up,this.FScene.mc_list.y < this.FInitListPosY);
         TGameUtil.setMovieClipButton(this.FScene.btn_down,this.FScene.mc_list.y > -(this.FScene.mc_list.height - this.FMinScrollDistance));
      }
      
      protected function OnMouseUp(param1:MouseEvent = null) : void
      {
         if(param1)
         {
            if(!this.FScene.btn_up.buttonMode)
            {
               return;
            }
         }
         this.FScene.mc_list.y += this.FSingleItemStamp;
         if(this.FScene.mc_list.y > this.FInitListPosY)
         {
            this.FScene.mc_list.y = this.FInitListPosY;
         }
         this.CheckBtn();
      }
      
      protected function OnMouseDown(param1:MouseEvent = null) : void
      {
         if(param1)
         {
            if(!this.FScene.btn_down.buttonMode)
            {
               return;
            }
         }
         if(this.FScene.mc_list.height > this.FMinScrollDistance)
         {
            this.FScene.mc_list.y -= this.FSingleItemStamp;
            if(this.FScene.mc_list.y < -(this.FScene.mc_list.height - this.FMinScrollDistance))
            {
               this.FScene.mc_list.y = -(this.FScene.mc_list.height - this.FMinScrollDistance);
            }
         }
         else
         {
            this.FScene.mc_list.y = this.FInitListPosY;
         }
         this.CheckBtn();
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FScene.visible = param1;
      }
      
      public function get Visible() : Boolean
      {
         return this.FScene.visible;
      }
      
      public function get Count() : int
      {
         return this.FItems ? int(this.FItems.length) : 0;
      }
      
      public function get Items() : Vector.<DisplayObject>
      {
         return this.FItems;
      }
      
      public function set MaxHeight(param1:uint) : void
      {
         this.FMaxHeight = param1;
         if(this.FMaxHeight <= this.FMinScrollDistance)
         {
            this.ScrolVisible = false;
         }
      }
      
      public function AgainRefresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            _loc2_ = this.FItems[_loc1_];
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc1_++;
         }
         this.ScrolVisible = false;
         this.FMaxHeight = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            this.AddItem(this.FItems[_loc1_],true,true);
            _loc1_++;
         }
      }
      
      public function AddItem(param1:DisplayObject, param2:Boolean = true, param3:Boolean = false) : void
      {
         param1.x = (param1.width + this.FPadding) * (this.Count % this.FColNum);
         param1.y = this.FMaxHeight;
         this.FScene.mc_list.addChild(param1);
         if(!param3)
         {
            this.FItems.push(param1);
         }
         if(this.FColNum > 1)
         {
            this.FMaxHeight = (param1.height + this.FItemStamp) * int(this.Count / this.FColNum);
         }
         else
         {
            this.FMaxHeight += param1.height + this.FItemStamp;
         }
         if(this.FSingleItemStamp <= 0)
         {
            this.FSingleItemStamp = param1.height + this.FItemStamp;
         }
         if(this.FMaxHeight + param1.height + this.FItemStamp > this.FMinScrollDistance)
         {
            this.ScrolVisible = true;
         }
         if(this.FAddItemAutoDown)
         {
            if(param2)
            {
               this.OnMouseDown();
            }
            else if(this.FScene.mc_list.height > this.FMinScrollDistance)
            {
               this.FScene.mc_list.y = -(this.FScene.mc_list.height - this.FMinScrollDistance);
            }
            else
            {
               this.FScene.mc_list.y = 0;
            }
         }
         this.CheckBtn();
      }
      
      public function AddItems(param1:Vector.<DisplayObject>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this.AddItem(_loc3_);
            _loc2_++;
         }
      }
      
      public function DelItem(param1:int) : DisplayObject
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         if(param1 > this.FItems.length)
         {
            return null;
         }
         _loc3_ = this.FItems[param1];
         if(_loc3_ != null)
         {
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            this.FItems.splice(param1,1);
         }
         this.FMaxHeight = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FItems.length)
         {
            _loc4_ = this.FItems[_loc2_];
            _loc4_.y = this.FMaxHeight + this.FItemStamp;
            this.FMaxHeight += _loc4_.height + this.FItemStamp;
            _loc2_++;
         }
         if(this.FMaxHeight < this.FMinScrollDistance)
         {
            this.ScrolVisible = false;
         }
         return _loc3_;
      }
      
      public function Clear() : void
      {
         var _loc1_:DisplayObject = null;
         while(this.FItems.length)
         {
            _loc1_ = this.FItems.pop();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
         this.ScrolVisible = false;
         this.FMaxHeight = 0;
         if(!this.FIsNoToUp)
         {
            this.ScrollToUp();
         }
      }
      
      public function ScrollToDown() : void
      {
         if(this.FScene == null)
         {
            return;
         }
         if(this.FScene.mc_list.height > this.FMinScrollDistance)
         {
            this.FScene.mc_list.y = -(this.FScene.mc_list.height - this.FMinScrollDistance);
         }
         else
         {
            this.FScene.mc_list.y = 0;
         }
         this.CheckBtn();
      }
      
      public function ScrollToUp() : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.mc_list.y = this.FInitListPosY;
         this.CheckBtn();
      }
      
      public function RemoveAllEvent() : void
      {
         this.FScene.btn_up.removeEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         this.FScene.btn_down.removeEventListener(MouseEvent.MOUSE_UP,this.OnMouseDown);
      }
      
      public function ScrollToElement(param1:int, param2:int = 4) : void
      {
         if(this.FScene.mc_list.height > this.FMinScrollDistance)
         {
            if(param1 > param2)
            {
               this.FScene.mc_list.y = -this.FSingleItemStamp * (param1 - param2);
            }
            else
            {
               this.FScene.mc_list.y = 0;
            }
         }
         else
         {
            this.FScene.mc_list.y = 0;
         }
         this.CheckBtn();
      }
      
      public function SetScrollVisble(param1:Boolean) : void
      {
         this.ScrolVisible = param1;
      }
      
      public function set IsNoToUp(param1:Boolean) : void
      {
         this.FIsNoToUp = param1;
      }
   }
}

