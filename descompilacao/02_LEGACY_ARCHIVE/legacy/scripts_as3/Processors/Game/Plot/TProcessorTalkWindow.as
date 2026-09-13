package Processors.Game.Plot
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TProcessorTalkWindow extends TProcessorLobbyWindow
   {
      
      public static const TYPE_HERO:int = 1;
      
      public static const TYPE_ENEMY:int = 2;
      
      public static const TYPE_NPC:int = 3;
      
      protected var FScene:MovieClip;
      
      protected var FPrinterEffect:TPrinterEffect;
      
      protected var FLeftBitmap:Bitmap;
      
      protected var FRightBitmap:Bitmap;
      
      protected var FTalkIndex:int;
      
      protected var FTalkBins:TBins;
      
      protected var FRoleModelBins:TBins;
      
      protected var FNPC:TBins;
      
      protected var FBaseHero:TBins;
      
      protected var FEnemy:TBins;
      
      protected var FTalkVect:Vector.<Object>;
      
      protected var FPlayerName:String;
      
      protected var FBackSprite:Sprite;
      
      protected var FReleaseResourceIDs:Vector.<uint>;
      
      protected var FPlotSkipTalkLevelLimit:uint;
      
      protected var FOnEndTalk:Function;
      
      public function TProcessorTalkWindow(param1:TUIComponent)
      {
         super(param1);
         this.InitTalkWindow();
         this.FReleaseResourceIDs = new Vector.<uint>();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FPrinterEffect != null)
         {
            this.FPrinterEffect.CheckTimingByFrame();
         }
      }
      
      protected function InitTalkWindow() : void
      {
         var _loc1_:TConfigValue = null;
         this.FPlayerName = SLogicsCore.Character.NickName;
         this.FBackSprite = new Sprite();
         this.FBackSprite.graphics.beginFill(0);
         this.FBackSprite.graphics.drawRect(0,0,1250,650);
         this.FBackSprite.graphics.endFill();
         addChild(this.FBackSprite);
         this.FBackSprite.alpha = 0;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_PLOT.RESOURCE_ClassName_PlotDialogt) as MovieClip;
         addChild(this.FScene);
         this.FScene.visible = false;
         this.FPrinterEffect = new TPrinterEffect(this);
         this.FPrinterEffect.SetTextContains(this.FScene.TalkContent);
         this.FLeftBitmap = new Bitmap();
         this.FScene.LeftResource.addChild(this.FLeftBitmap);
         this.FRightBitmap = new Bitmap();
         this.FScene.RightResource.addChild(this.FRightBitmap);
         this.FTalkVect = new Vector.<Object>();
         this.FTalkBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TaskDramaDialogue);
         this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FNPC = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NPC);
         this.FBaseHero = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FEnemy = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         addEventListener(MouseEvent.MOUSE_UP,this.OnChgStatus);
         if(this.FScene.btn_skip != null)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Plot_SkipTalkLevelLimit) as TConfigValue;
            this.FPlotSkipTalkLevelLimit = _loc1_.Value as uint;
            this.FScene.btn_skip.addEventListener(MouseEvent.MOUSE_UP,this.OnSkipTalk);
         }
      }
      
      protected function NextTalk(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TNPC = null;
         var _loc8_:TBaseHero = null;
         var _loc9_:THero = null;
         var _loc10_:TEnemy = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         if(this.FTalkIndex >= this.FTalkVect.length)
         {
            this.FScene.visible = false;
            this.FPrinterEffect.Clear();
            if(this.FOnEndTalk != null)
            {
               this.FOnEndTalk(this);
            }
            return;
         }
         _loc3_ = this.FTalkVect[this.FTalkIndex];
         _loc6_ = int(_loc3_.direction);
         if(_loc3_.leftIcon >= 0)
         {
            if(_loc3_.leftIcon > 0)
            {
               _loc4_ = int((this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.leftIcon) as TRoleModel).RoleHead);
            }
            else
            {
               _loc9_ = SLogicsCore.Character.GetMainHero();
               _loc4_ = int(_loc9_.LargeID);
            }
            _loc5_ = _loc4_ > 22100000 ? TYPE_NPC : (_loc4_ > 12101000 ? TYPE_ENEMY : TYPE_HERO);
            TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FLeftBitmap,CONST_MODULES.MODULE_Plot,_loc4_);
            _loc2_ = this.FReleaseResourceIDs.indexOf(_loc4_);
            if(_loc2_ < 0)
            {
               this.FReleaseResourceIDs.push(_loc4_);
            }
            this.FLeftBitmap.filters = _loc6_ == 1 ? [] : [TGameUtil.darkFilters];
            this.FScene.LeftName.visible = Boolean(_loc6_ == 1);
            if(_loc3_.leftIcon == 0)
            {
               _loc11_ = _loc9_.Name;
            }
            else if(_loc5_ == TYPE_NPC)
            {
               _loc7_ = this.FNPC.GetDatebaseByIdentifier(_loc4_) as TNPC;
               _loc11_ = _loc7_.Name;
            }
            else if(_loc5_ == TYPE_ENEMY)
            {
               _loc10_ = this.FEnemy.GetDatebaseByIdentifier(_loc4_) as TEnemy;
               _loc11_ = _loc10_.Name;
            }
            else if(_loc5_ == TYPE_HERO)
            {
               _loc8_ = this.FBaseHero.GetDatebaseByIdentifier(_loc4_) as TBaseHero;
               _loc11_ = _loc8_.Name;
            }
            else
            {
               _loc11_ = "";
            }
            this.FScene.LeftName.text = _loc11_;
         }
         else
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_None,this.FLeftBitmap,CONST_MODULES.MODULE_Plot);
            this.FScene.LeftName.text = "";
         }
         if(_loc3_.rightIcon >= 0)
         {
            if(_loc3_.rightIcon > 0)
            {
               _loc4_ = int((this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.rightIcon) as TRoleModel).RoleHead);
            }
            else
            {
               _loc9_ = SLogicsCore.Character.GetMainHero();
               _loc4_ = int(_loc9_.LargeID);
            }
            _loc5_ = _loc4_ > 22100000 ? TYPE_NPC : (_loc4_ > 12101000 ? TYPE_ENEMY : TYPE_HERO);
            TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FRightBitmap,CONST_MODULES.MODULE_Plot,_loc4_);
            _loc2_ = this.FReleaseResourceIDs.indexOf(_loc4_);
            if(_loc2_ < 0)
            {
               this.FReleaseResourceIDs.push(_loc4_);
            }
            this.FRightBitmap.filters = _loc6_ == 2 ? [] : [TGameUtil.darkFilters];
            this.FScene.RightName.visible = Boolean(_loc6_ == 2);
            if(_loc3_.rightIcon == 0)
            {
               _loc11_ = _loc9_.Name;
            }
            else if(_loc5_ == TYPE_NPC)
            {
               _loc7_ = this.FNPC.GetDatebaseByIdentifier(_loc4_) as TNPC;
               _loc11_ = _loc7_.Name;
            }
            else if(_loc5_ == TYPE_ENEMY)
            {
               _loc10_ = this.FEnemy.GetDatebaseByIdentifier(_loc4_) as TEnemy;
               _loc11_ = _loc10_.Name;
            }
            else if(_loc5_ == TYPE_HERO)
            {
               _loc8_ = this.FBaseHero.GetDatebaseByIdentifier(_loc4_) as TBaseHero;
               _loc11_ = _loc8_.Name;
            }
            else
            {
               _loc11_ = "";
            }
            this.FScene.RightName.text = _loc11_;
         }
         else
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_None,this.FRightBitmap,CONST_MODULES.MODULE_Plot);
            this.FScene.RightName.text = "";
         }
         this.FScene.mc_bg.gotoAndStop(_loc6_);
         _loc12_ = this.GetTalkStr(_loc3_.info);
         _loc12_ = _loc12_.split("#playername#").join(this.FPlayerName);
         this.FPrinterEffect.SetTextInfo(_loc12_);
         ++this.FTalkIndex;
      }
      
      protected function GetTalkStr(param1:uint) : String
      {
         var _loc2_:TTaskDramaDialogue = null;
         _loc2_ = this.FTalkBins.GetDatebaseByIdentifier(param1) as TTaskDramaDialogue;
         return _loc2_ ? _loc2_.Conversations : "";
      }
      
      protected function OnChgStatus(param1:MouseEvent) : void
      {
         if(this.FScene.visible == false)
         {
            return;
         }
         if(this.FPrinterEffect.IsPrinterEnd)
         {
            this.NextTalk(this);
         }
         else
         {
            this.FPrinterEffect.OnShowAllText();
         }
      }
      
      protected function OnSkipTalk(param1:MouseEvent) : void
      {
         this.FScene.visible = false;
         this.FPrinterEffect.Clear();
         this.FPrinterEffect.OnShowAllText();
         if(this.FOnEndTalk != null)
         {
            this.FOnEndTalk(this);
         }
      }
      
      public function get OnEndTalk() : Function
      {
         return this.FOnEndTalk;
      }
      
      public function set OnEndTalk(param1:Function) : void
      {
         this.FOnEndTalk = param1;
      }
      
      public function SetTalkInfo(param1:Vector.<Object>) : void
      {
         this.FTalkVect = param1;
         this.FTalkIndex = 0;
         this.FScene.visible = true;
         if(this.FScene.btn_skip)
         {
            this.FScene.btn_skip.visible = Boolean(SLogicsCore.Character.GetMainLevel() >= this.FPlotSkipTalkLevelLimit);
         }
         this.NextTalk();
      }
      
      override public function Dispose() : void
      {
         this.FReleaseResourceIDs.length = 0;
         if(this.FLeftBitmap.bitmapData != null)
         {
            this.FLeftBitmap.bitmapData.dispose();
            this.FLeftBitmap.bitmapData = null;
         }
         if(this.FRightBitmap.bitmapData != null)
         {
            this.FRightBitmap.bitmapData.dispose();
            this.FRightBitmap.bitmapData = null;
         }
      }
   }
}

