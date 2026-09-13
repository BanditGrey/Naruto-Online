package Utilities.Group
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class TitieGroup extends Sprite
   {
      
      private var _vGap:Number;
      
      private var _hNumber:Number;
      
      private var _hGap:Number;
      
      private var _vNumber:Number;
      
      private var _childrenList:HashMap = new HashMap();
      
      private var _backGroud:DisplayObject;
      
      private var l:int;
      
      public function TitieGroup(param1:Number = 5, param2:Number = 5, param3:Number = 5, param4:Number = Infinity)
      {
         this._vGap = param1;
         this._vNumber = param2;
         this._hGap = param3;
         this._hNumber = param4;
         super();
      }
      
      public function get backGroud() : DisplayObject
      {
         return this._backGroud;
      }
      
      public function dispose() : void
      {
         this.removeAll();
         if(this._childrenList)
         {
            this._childrenList.dispose();
         }
         this._childrenList = null;
         this._backGroud = null;
      }
      
      public function removeAll() : void
      {
         var _loc2_:DisplayObject = null;
         if(!this._childrenList)
         {
            return;
         }
         var _loc1_:Array = this._childrenList.getItems;
         for each(_loc2_ in _loc1_)
         {
            try
            {
               Object(_loc2_).dispose();
            }
            catch(e:*)
            {
            }
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      public function get childrenList() : HashMap
      {
         return this._childrenList;
      }
      
      public function get vNumber() : Number
      {
         return this._vNumber;
      }
      
      public function set vNumber(param1:Number) : void
      {
         if(this._vNumber == param1)
         {
            return;
         }
         this._vNumber = param1;
         this.updateView();
      }
      
      public function get hGap() : Number
      {
         return this._hGap;
      }
      
      public function set hGap(param1:Number) : void
      {
         this._hGap = param1;
         if(this._hGap == param1)
         {
            return;
         }
         this._hGap = param1;
         this.updateView();
      }
      
      public function get hNumber() : Number
      {
         return this._hNumber;
      }
      
      public function set hNumber(param1:Number) : void
      {
         this._hNumber = param1;
         if(this._hNumber == param1)
         {
            return;
         }
         this._hNumber = param1;
         this.updateView();
      }
      
      public function get vGap() : Number
      {
         return this._vGap;
      }
      
      public function set vGap(param1:Number) : void
      {
         this._vGap = param1;
         if(this._vGap == param1)
         {
            return;
         }
         this._vGap = param1;
         this.updateView();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = super.addChild(param1);
         this._childrenList.addItem(_loc2_.name,_loc2_);
         this.updateView();
         return _loc2_;
      }
      
      public function addChildBackGround(param1:DisplayObject) : DisplayObject
      {
         this._backGroud = super.addChildAt(param1,0);
         return this._backGroud;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = super.removeChild(param1);
         try
         {
            Object(_loc2_).dispose();
         }
         catch(e:Error)
         {
         }
         this._childrenList.removeItem(_loc2_.name);
         this.updateView();
         return _loc2_;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:DisplayObject = super.addChildAt(param1,param2);
         this._childrenList.addItem(_loc3_.name,_loc3_);
         this.updateView();
         return _loc3_;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = super.removeChildAt(param1);
         this._childrenList.removeItem(_loc2_.name);
         this.updateView();
         return _loc2_;
      }
      
      public function set aotoDispose(param1:Boolean) : void
      {
         if(param1)
         {
            this.addEventListener(Event.REMOVED_FROM_STAGE,this.OnClearThisHandler);
         }
      }
      
      private function OnClearThisHandler(param1:Event) : void
      {
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.OnClearThisHandler);
         this.dispose();
      }
      
      public function get lie() : int
      {
         return this.l;
      }
      
      public function updateView() : void
      {
         var _loc8_:DisplayObject = null;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:DisplayObject = null;
         var _loc14_:Number = NaN;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_.push(this.getChildAt(_loc2_));
            _loc2_++;
         }
         var _loc3_:int = int(_loc1_.length);
         if(_loc3_ < 2)
         {
            return;
         }
         var _loc4_:int = Math.ceil(_loc1_.length / this._vNumber);
         this.l = Math.max(this._vNumber,_loc4_);
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         while(_loc7_ < this.l)
         {
            _loc9_ = Math.min(this._vNumber,_loc1_.length);
            _loc10_ = _loc8_ ? _loc8_.height + _loc8_.y + this._vGap : 0;
            _loc11_ = 0;
            _loc12_ = 0;
            while(_loc12_ < _loc9_)
            {
               _loc8_ = _loc13_ = _loc1_.shift();
               _loc14_ = _loc12_ == 0 ? _loc11_ : _loc11_ + this._hGap;
               _loc13_.x = _loc14_;
               _loc13_.y = _loc10_;
               _loc5_ = _loc11_ = _loc13_.width + _loc13_.x;
               _loc12_++;
            }
            _loc6_ += int(_loc8_.height + _loc8_.y + this._vGap);
            _loc7_++;
         }
      }
   }
}

