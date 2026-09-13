package Processors.Game.Lobby.Emblem.Component
{
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Emblem.TEmblemData;
   import Processors.Game.Lobby.Emblem.TProcessorEmblem;
   import Resources.Constants.CONST_EMBLEM;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class TUIEmblemBox extends Sprite
   {
      
      protected const HttpFiledirURI:String = "https://upload.plaync100.net/image/";
      
      public var MC_Bitmap:MovieClip;
      
      public var TF_Name:TextField;
      
      public var MC_lock:MovieClip;
      
      public var Btn_Add:MovieClip;
      
      protected var FProcessorEmblem:TProcessorEmblem;
      
      protected var FLoader:Loader;
      
      protected var ImageUrl:String;
      
      protected var IconImage:Bitmap;
      
      protected var _cacheList:Object = {};
      
      public var EmblemData:TEmblemData;
      
      public var Unlock:int;
      
      public var Type:int;
      
      public var OnCompleteCallback:Function;
      
      public var OnLockClick:Function;
      
      public var OnLockOver:Function;
      
      public var OnLockOut:Function;
      
      public var OnAddClick:Function;
      
      public var OnBoxClick:Function;
      
      public var OnBoxOver:Function;
      
      public var OnBoxOut:Function;
      
      public function TUIEmblemBox(param1:TProcessorEmblem)
      {
         super();
         this.FProcessorEmblem = param1;
         this.IconImage = new Bitmap();
         this.MC_Bitmap.addChild(this.IconImage);
         addEventListener(MouseEvent.CLICK,this.onBoxClick);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onBoxOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onBoxOut);
         this.Btn_Add.addEventListener(MouseEvent.CLICK,this.onAddbtnClick);
         this.Btn_Add.visible = false;
         this.Btn_Add.buttonMode = true;
         this.MC_lock.addEventListener(MouseEvent.CLICK,this.onLockClick);
         this.MC_lock.addEventListener(MouseEvent.MOUSE_MOVE,this.onLockOver);
         this.MC_lock.addEventListener(MouseEvent.MOUSE_OUT,this.onLockOut);
         this.MC_lock.visible = false;
         buttonMode = true;
      }
      
      public function SetEmblemInfo(param1:TEmblemData) : void
      {
         this.EmblemData = param1;
         this.ImageUrl = this.getImageURI();
         this.Type = this.EmblemData.Type;
         this.Unlock = this.EmblemData.Unlock;
         this.MC_lock.visible = this.Unlock != CONST_EMBLEM.UNLOCK;
         this.TF_Name.text = this.EmblemData.Name;
         this.Btn_Add.visible = !this.MC_lock.visible && this.TF_Name.text == "";
         if(this.MC_Bitmap.numChildren > 0)
         {
            this.IconImage = this.MC_Bitmap.getChildAt(0) as Bitmap;
            this.IconImage.bitmapData = null;
         }
         if(this.Unlock == CONST_EMBLEM.UNLOCK)
         {
            if(this.Type == 2 && this.TF_Name.text != "")
            {
               this.loadByUrl();
            }
         }
         if(this.EmblemData.EmblemConfig.Imageid > 0)
         {
            this.IconImage.bitmapData = TUtilityReflection.CreateInstance("Icon_emblem_" + this.EmblemData.EmblemConfig.Imageid);
            this.adjustPosCenter(this.IconImage);
         }
      }
      
      protected function loadByUrl() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:LoaderContext = null;
         this.dispose();
         if(this._cacheList[this.ImageUrl] is BitmapData)
         {
            _loc1_ = new Bitmap(this._cacheList[this.ImageUrl],"auto",true);
            this.MC_Bitmap.addChild(_loc1_);
            this.adjustPosCenter(_loc1_);
         }
         else if(this._cacheList[this.ImageUrl] is Class)
         {
            _loc2_ = new this._cacheList[this.ImageUrl]();
            this.MC_Bitmap.addChild(_loc2_);
         }
         else
         {
            if(this.FLoader == null)
            {
               this.FLoader = new Loader();
               this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
               this.FLoader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR,this.onError);
               this.FLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            }
            _loc3_ = new LoaderContext(true);
            this.FLoader.load(new URLRequest(this.ImageUrl),_loc3_);
         }
      }
      
      protected function onComplete(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.FLoader)
         {
            _loc2_ = this.FLoader.content;
            if(_loc2_ is Bitmap)
            {
               if(!this._cacheList[this.ImageUrl])
               {
                  this._cacheList[this.ImageUrl] = Bitmap(_loc2_).bitmapData.clone();
               }
               this.MC_Bitmap.addChild(_loc2_);
               this.adjustPosCenter(_loc2_);
            }
            else if(_loc2_ is Class)
            {
               if(!this._cacheList[this.ImageUrl])
               {
                  this._cacheList[this.ImageUrl] = _loc2_ as Class;
               }
               this.MC_Bitmap.addChild(this.FLoader.content);
            }
            if(this.OnCompleteCallback != null)
            {
               this.OnCompleteCallback();
               this.OnCompleteCallback = null;
            }
         }
      }
      
      protected function onError(param1:ErrorEvent) : void
      {
      }
      
      protected function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      protected function onLockClick(param1:MouseEvent) : void
      {
         if(this.OnLockClick != null)
         {
            this.OnLockClick(this);
         }
      }
      
      protected function onLockOver(param1:MouseEvent) : void
      {
         if(this.OnLockOver != null)
         {
            this.OnLockOver(this);
         }
      }
      
      protected function onLockOut(param1:MouseEvent) : void
      {
         if(this.OnLockOut != null)
         {
            this.OnLockOut(this);
         }
      }
      
      protected function onBoxClick(param1:MouseEvent) : void
      {
         if(this.OnBoxClick != null)
         {
            this.OnBoxClick(this);
         }
      }
      
      protected function onBoxOver(param1:MouseEvent) : void
      {
         if(this.OnBoxOver != null)
         {
            this.OnBoxOver(this);
         }
      }
      
      protected function onBoxOut(param1:MouseEvent) : void
      {
         if(this.OnBoxOut != null)
         {
            this.OnBoxOut(this);
         }
      }
      
      protected function onAddbtnClick(param1:MouseEvent) : void
      {
         if(this.OnAddClick != null)
         {
            this.OnAddClick(this);
         }
      }
      
      protected function adjustPosCenter(param1:DisplayObject) : void
      {
         param1.x = -param1.width >> 1;
         param1.y = -param1.height >> 1;
      }
      
      protected function getImageURI() : String
      {
         return this.HttpFiledirURI + this.FProcessorEmblem.UserId + "_" + this.EmblemData.EmblemId + ".png";
      }
      
      protected function dispose() : void
      {
         if(this.MC_Bitmap)
         {
            this.MC_Bitmap.removeChildren();
         }
      }
   }
}

