package Processors.Game.Lobby.PopTips
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TPopTips;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_POPTIPS;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorPopTips extends TProcessorGame
   {
      
      protected static const RESOURCESSTATE_Request:int = 0;
      
      protected static const RESOURCESSTATE_Wait:int = 1;
      
      protected static const RESOURCESSTATE_Dispatch:int = 2;
      
      protected static const INIT_SCENE_WIDTH:int = 400;
      
      protected var FScene:MovieClip;
      
      protected var FIdVect:Vector.<uint>;
      
      protected var FPopTipsVect:Vector.<TPopTips>;
      
      protected var FCurPopTipsIndex:int;
      
      protected var FPopTips:TBins;
      
      protected var FPopTipBitmap:Bitmap;
      
      protected var FOpenPlantWindowByIndex:Function;
      
      public function TProcessorPopTips(param1:TUIComponent)
      {
         super(param1);
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitPopTips();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitPopTips() : void
      {
         this.FIdVect = new Vector.<uint>();
         this.FPopTipsVect = new Vector.<TPopTips>();
         this.FPopTips = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PopTips);
         this.FPopTipBitmap = new Bitmap();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_PopTip) as MovieClip;
         addChild(this.FScene);
         this.FScene.y = 470;
         this.FScene.visible = false;
         this.FScene.mc_image.addChild(this.FPopTipBitmap);
         TGameUtil.setButtonMode(this.FScene.btn_left,true);
         this.FScene.btn_left.addEventListener(MouseEvent.MOUSE_UP,this.OnLeft);
         TGameUtil.setButtonMode(this.FScene.btn_right,true);
         this.FScene.btn_right.addEventListener(MouseEvent.MOUSE_UP,this.OnRight);
         this.FScene.btn_close.addEventListener(MouseEvent.MOUSE_UP,this.OnClose);
         this.FScene.btn_goto.addEventListener(MouseEvent.MOUSE_UP,this.OnGoto);
         this.FScene.btn_goto.buttonMode = true;
         this.FScene.tf_desc.mouseEnabled = false;
         this.FScene.btn_goto.tf_btnInfo.mouseEnabled = false;
         this.FCurPopTipsIndex = -1;
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FScene != null && this.FScene.visible)
         {
            if(this.FCurPopTipsIndex >= 0)
            {
               TGameUtil.ShowImageByID(TGameUtil.Type_SmallIcon,this.FPopTipBitmap,CONST_MODULES.MODULE_PopTips,this.FPopTipsVect[this.FCurPopTipsIndex].Image);
            }
         }
      }
      
      protected function GotoTip(param1:uint) : void
      {
         if(this.FCurPopTipsIndex == param1)
         {
            return;
         }
         this.FCurPopTipsIndex = param1;
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:TPopTips = null;
         _loc1_ = this.FPopTipsVect[this.FCurPopTipsIndex];
         this.FScene.tf_desc.htmlText = _loc1_.Tips;
         this.FScene.btn_goto.tf_btnInfo.text = _loc1_.OpenButton;
      }
      
      protected function CheckBtn() : void
      {
         this.FScene.btn_left.visible = Boolean(this.FPopTipsVect.length > 1);
         this.FScene.btn_right.visible = Boolean(this.FPopTipsVect.length > 1);
      }
      
      protected function OnLeft(param1:MouseEvent) : void
      {
         --this.FCurPopTipsIndex;
         if(this.FCurPopTipsIndex < 0)
         {
            this.FCurPopTipsIndex = this.FPopTipsVect.length - 1;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent) : void
      {
         ++this.FCurPopTipsIndex;
         if(this.FCurPopTipsIndex > this.FPopTipsVect.length - 1)
         {
            this.FCurPopTipsIndex = 0;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnClose(param1:MouseEvent = null) : void
      {
         var EndTween:Function = null;
         var e:MouseEvent = param1;
         EndTween = function():void
         {
            FScene.visible = false;
            FScene.btn_effect.stop();
         };
         this.FIdVect.length = 0;
         this.FPopTipsVect.length = 0;
         this.FCurPopTipsIndex = -1;
         TweenUtil.to(this.FScene,500,{
            "x":CONST_COMMON.STAGE_Width,
            "onComplete":EndTween
         });
         this.FScene.mouseEnabled = false;
      }
      
      protected function OnGoto(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.FCurPopTipsIndex < 0)
         {
            return;
         }
         _loc2_ = uint(this.FPopTipsVect[this.FCurPopTipsIndex].Panel);
         if(this.FOpenPlantWindowByIndex != null)
         {
            this.FOpenPlantWindowByIndex(this,_loc2_);
         }
         this.OnClose();
      }
      
      public function get OpenPlantWindowByIndex() : Function
      {
         return this.FOpenPlantWindowByIndex;
      }
      
      public function set OpenPlantWindowByIndex(param1:Function) : void
      {
         this.FOpenPlantWindowByIndex = param1;
      }
      
      public function Hide() : void
      {
         this.OnClose();
      }
      
      public function AddPopTips(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TPopTips = null;
         var _loc4_:uint = 0;
         _loc2_ = this.FIdVect.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.GotoTip(_loc2_);
            return;
         }
         _loc3_ = this.FPopTips.GetDatebaseByIdentifier(param1) as TPopTips;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = uint(SLogicsCore.Character.GetMainLevel());
         if(_loc4_ < _loc3_.DownLevel || _loc4_ > _loc3_.UpLevel)
         {
            return;
         }
         this.FIdVect.push(param1);
         this.FPopTipsVect.push(_loc3_);
         this.GotoTip(this.FPopTipsVect.length - 1);
         if(this.FScene.visible == false && this.FIdVect.length == 1)
         {
            this.FScene.x = FUICore.StageWidth;
            this.FScene.visible = true;
            TweenUtil.to(this.FScene,500,{"x":FUICore.StageWidth - INIT_SCENE_WIDTH});
            this.FScene.btn_effect.play();
         }
         this.FScene.mouseEnabled = true;
      }
      
      public function CheckPopTipsByPanelId(param1:uint) : void
      {
         var _loc2_:* = 0;
         var _loc3_:TPopTips = null;
         _loc2_ = 0;
         while(_loc2_ < this.FPopTipsVect.length)
         {
            _loc3_ = this.FPopTipsVect[_loc2_];
            if(_loc3_.Panel == param1)
            {
               this.FPopTipsVect.splice(_loc2_,1);
               this.FIdVect.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
         if(this.FPopTipsVect.length <= 0)
         {
            this.OnClose();
         }
         else
         {
            this.GotoTip(this.FPopTipsVect.length - 1);
         }
      }
      
      public function OnCheckLevelUp() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc4_:Vector.<uint> = null;
         _loc2_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_POPTIPS.CONFIG_LevelSpree) as TConfigValue;
         _loc4_ = _loc3_.Value as Vector.<uint>;
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            if(_loc2_ == _loc4_[_loc1_])
            {
               return;
            }
            _loc1_++;
         }
         this.OnCheckAddFriends();
      }
      
      public function OnCheckAddFriends() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc4_:Vector.<uint> = null;
         _loc2_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_POPTIPS.CONFIG_AddFriend) as TConfigValue;
         _loc4_ = _loc3_.Value as Vector.<uint>;
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            if(_loc2_ == _loc4_[_loc1_])
            {
               this.AddPopTips(CONST_POPTIPS.CONFIG_AddFriend);
               return;
            }
            _loc1_++;
         }
      }
   }
}

