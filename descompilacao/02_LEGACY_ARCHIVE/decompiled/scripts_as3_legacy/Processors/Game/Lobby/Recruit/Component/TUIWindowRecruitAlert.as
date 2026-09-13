package Processors.Game.Lobby.Recruit.Component
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TDrawNinjaArchive;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIWindowRecruitAlert
   {
      
      protected static const PaddingH:uint = 17;
      
      protected static const PaddingV:uint = 9;
      
      protected static const ColN:uint = 5;
      
      protected static const Width:uint = 114;
      
      protected static const Height:uint = 140;
      
      protected var FBTN_Recruit:MovieClip;
      
      protected var FBTN_OK:MovieClip;
      
      protected var FResource:MovieClip;
      
      protected var FBitmaps:Array;
      
      protected var FDrawNinjaArchives:Vector.<TDrawNinjaArchive>;
      
      protected var FType:int;
      
      protected var FNumber:int;
      
      public var OnDrawNinjaReq:Function;
      
      public function TUIWindowRecruitAlert()
      {
         super();
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
         this.FBTN_Recruit = this.FResource["BTN_Recruit"];
         TGameUtil.setButtonMode(this.FBTN_Recruit,true);
         this.FBTN_Recruit.addEventListener(MouseEvent.CLICK,this.OnClickBTNRecruit);
         this.FBTN_OK = this.FResource["BTN_OK"];
         TGameUtil.setButtonMode(this.FBTN_OK,true);
         this.FBTN_OK.addEventListener(MouseEvent.CLICK,this.OnClickButtonOk);
      }
      
      public function UpdateUI(param1:Vector.<TDrawNinjaArchive>, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TUIRecruitNinjaImage = null;
         this.FDrawNinjaArchives = param1;
         this.FType = param2;
         this.FNumber = param3;
         if(this.FBitmaps == null)
         {
            this.FBitmaps = new Array();
         }
         _loc4_ = 0;
         while(_loc4_ < this.FBitmaps.length)
         {
            this.FResource.removeChild(this.FBitmaps[_loc4_].BmpEffect);
            _loc4_++;
         }
         this.FResource.pos.removeChildren();
         _loc4_ = 0;
         while(_loc4_ < this.FDrawNinjaArchives.length)
         {
            if(_loc4_ > this.FBitmaps.length - 1)
            {
               _loc5_ = new TUIRecruitNinjaImage();
               this.FBitmaps.push(_loc5_);
            }
            this.FResource.pos.addChild(this.FBitmaps[_loc4_]);
            this.FBitmaps[_loc4_].Updata(this.FDrawNinjaArchives[_loc4_]);
            this.FResource.addChild(this.FBitmaps[_loc4_].BmpEffect);
            _loc4_++;
         }
         if(_loc4_ < this.FBitmaps.length)
         {
            this.FBitmaps.splice(_loc4_);
         }
      }
      
      protected function UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIRecruitNinjaImage = null;
         var _loc3_:Point = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBitmaps.length)
         {
            _loc2_ = this.FBitmaps[_loc1_];
            _loc2_.x = (Width + PaddingH) * (_loc1_ % ColN);
            _loc2_.y = (Height + PaddingV) * int(_loc1_ / ColN);
            _loc3_ = _loc2_.localToGlobal(new Point());
            _loc2_.BmpEffect.x = _loc3_.x - 33;
            _loc2_.BmpEffect.y = _loc3_.y - 29;
            _loc1_++;
         }
         this.FResource.pos.x = (this.FResource.width - this.FResource.pos.width) / 2;
         this.FResource.pos.y = (this.FResource.height - this.FResource.pos.height) / 2;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this.FResource.visible)
         {
            return;
         }
         if(!this.FDrawNinjaArchives)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FBitmaps.length)
         {
            this.FBitmaps[_loc1_].LogicsPerform();
            _loc1_++;
         }
         this.UILocation();
      }
      
      public function set Visible(param1:Boolean) : void
      {
         this.FResource.visible = param1;
      }
      
      protected function OnClickBTNRecruit(param1:MouseEvent) : void
      {
         if(this.OnDrawNinjaReq != null)
         {
            this.OnDrawNinjaReq(this.FType,this.FNumber);
         }
      }
      
      protected function OnClickButtonOk(param1:MouseEvent) : void
      {
         this.FResource.visible = false;
      }
   }
}

import Foundation.Resources.SResourcesCore;
import Foundation.Resources.Textures.TAnimationFrame;
import Foundation.Resources.Textures.TAnimationSequence;
import Foundation.Timing.STimingCore;
import Foundation.Utilities.TGameUtil;
import Foundation.Utilities.TUtilityReflection;
import Logics.DatebaseVO.VO.TDrawNinjaArchive;
import Resources.Constants.CONST_MODULES;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;

class TUIRecruitNinjaImage extends Sprite
{
   
   protected var FBitmap:Bitmap;
   
   protected var FResource:MovieClip;
   
   protected var FDrawNinjaArchive:TDrawNinjaArchive;
   
   protected var AnimationSequence:TAnimationSequence;
   
   protected var FBmpEffect:Bitmap;
   
   protected var FPlayAnimation:Boolean;
   
   public function TUIRecruitNinjaImage()
   {
      super();
      this.UIDispatch();
   }
   
   protected function UIDispatch() : void
   {
      this.FResource = TUtilityReflection.CreateDisplayObjectInstance("MC_RecruitNinja") as MovieClip;
      addChild(this.FResource);
      this.FBitmap = new Bitmap();
      this.FResource.mc_head.addChild(this.FBitmap);
      this.AnimationSequence = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(13610042,0);
      this.FBmpEffect = new Bitmap();
   }
   
   public function Updata(param1:TDrawNinjaArchive) : void
   {
      this.FDrawNinjaArchive = param1;
      this.FResource.MC_Assess.gotoAndStop(this.FDrawNinjaArchive.Assess);
      if(this.FDrawNinjaArchive.Assess == "SSR")
      {
         this.FPlayAnimation = true;
      }
      else
      {
         this.FPlayAnimation = false;
      }
   }
   
   public function LogicsPerform() : void
   {
      var _loc1_:TAnimationFrame = null;
      TGameUtil.ShowImageByID(TGameUtil.Type_MiddlePic,this.FBitmap,CONST_MODULES.MODULE_DrawNinaja,this.FDrawNinjaArchive.Identifier);
      _loc1_ = this.AnimationSequence.GetAnimationFrameByTick(STimingCore.TickCount);
      if(this.FPlayAnimation)
      {
         if(_loc1_)
         {
            if(this.FBmpEffect.bitmapData != _loc1_.Surface)
            {
               this.FBmpEffect.bitmapData = _loc1_.Surface;
            }
         }
      }
      else
      {
         this.FBmpEffect.bitmapData = null;
      }
   }
   
   public function get BmpEffect() : Bitmap
   {
      return this.FBmpEffect;
   }
}
