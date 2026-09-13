package Processors.Game.Lobby.TacticalDeployment
{
   import Components.Standard.TUITab;
   import Foundation.Common.*;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.GeneralStar.*;
   import Logics.Skills.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.*;
   
   public class TProcessorWindowTacticalDeployment extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:int = 6;
      
      protected static const INIT_WIDTH:Number = 205;
      
      protected static const FOUR:Number = 4;
      
      protected static const TAB_THREE:Number = 3;
      
      public static const FORMAT_Caption01:String = STRING_DEPLOYMENT.FORMAT_Caption01;
      
      public static const FORMAT_Caption02:String = STRING_DEPLOYMENT.FORMAT_Caption02;
      
      public static const FORMAT_Caption04:String = STRING_DEPLOYMENT.FORMAT_Caption04;
      
      protected static var MoveTimesCount:uint = 70;
      
      protected static const TAB_COUNT:int = 2;
      
      protected var FHelpTips:THint;
      
      protected var FScene:MovieClip;
      
      protected var FSceneCheck:MovieClip;
      
      protected var FMC_SaiXuanJiNeng:MovieClip;
      
      protected var Fbtn_showlist:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FFourMvVector:Vector.<MovieClip>;
      
      protected var Ftask:MovieClip;
      
      protected var FNiMeiA:Boolean;
      
      protected var FLimitSkillCount:int;
      
      protected var FTaskIndex:int;
      
      protected var FMaxHeroCount:uint;
      
      protected var FMaxPointCount:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FHeros:THeros;
      
      protected var FCurPageHeros:THeros;
      
      protected var FUIHeroTab:TUITab;
      
      protected var FHeroTabIndex:int;
      
      protected var FCurPage:int;
      
      protected var FTotlePage:int;
      
      protected var FSelectHeroBitmap:Bitmap;
      
      protected var FSelectHeroDO:MovieClip;
      
      protected var FSelectHero:THero;
      
      protected var FShowHeroCoordinate:TCoordinate;
      
      protected var FHint:THint;
      
      protected var FRoleModel:TBins;
      
      protected var FHeroList:THeroList;
      
      protected var FHeroDeployment:THeroDeployment;
      
      protected var FHeroSkill:THeroSkill;
      
      protected var FHeroInfoTip:TDeploymentTip;
      
      protected var FIsAutoSet:Boolean;
      
      protected var FAutoHeroId:uint;
      
      protected var FAutoPos:uint;
      
      protected var FAutoHeroModelId:uint;
      
      protected var StartHeroPoint:TCoordinate;
      
      protected var EndPosPoint:TCoordinate;
      
      protected var MoveTimesIndex:uint;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FAutoEndFun:Function;
      
      protected var FSkillOnClick:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnEnterMilitary:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FAboratoryBtnMove:Function;
      
      protected var FAboratoryBtnOut:Function;
      
      protected var FAboratoryBtnClick:Function;
      
      protected var FMagicBtnMove:Function;
      
      protected var FMagicBtnOut:Function;
      
      protected var FMagicBtnClick:Function;
      
      protected var FMysticBtnClick:Function;
      
      public var AwakenBtnClick:Function;
      
      public var TabooBtnClick:Function;
      
      public var AutoChangeForm:Function;
      
      protected var FCurSkillindex:int;
      
      public function TProcessorWindowTacticalDeployment(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FFourMvVector = new Vector.<MovieClip>(FOUR);
         this.FCurPageHeros = new THeros();
         this.FUIHeroTab = new TUITab(this);
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         this.CheckMouseIcon();
         if(this.FHeroList != null)
         {
            this.FHeroList.UpdataHeroList();
         }
         if(this.FHeroDeployment != null)
         {
            this.FHeroDeployment.UpdataUI();
         }
         if(this.FHeroSkill != null)
         {
            this.FHeroSkill.UpdataUI();
         }
         if(this.FHeroInfoTip != null && this.FHeroInfoTip.visible == true)
         {
            this.FHeroInfoTip.UpdataBitmap();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DEPLOYMENT.RESOURCESID_TacticalDeployment);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DEPLOYMENT.RESOURCE_ClassName_TacticalDeployment) as MovieClip;
         addChild(this.FScene);
         _loc1_ = 0;
         while(_loc1_ < TAB_THREE)
         {
            this.FUIHeroTab.SetTabByIndex(this.FScene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUIHeroTab.OnSwitch = this.OnHeroChangeTabOnSwitch;
         this.FUIHeroTab.Init();
         this.FHeroList = new THeroList(this,this.FScene.mc_playHead);
         this.FHeroList.ShowHeroInfoTip = this.ShowHeroInfoTip;
         this.FHeroList.HideHeroInfoTip = this.HideHeroInfoTip;
         this.FHeroList.SetSelectHero = this.SetListSelectHero;
         this.FHeroList.OnEffectText = EffectGenerateText;
         this.FHeroList.visible = false;
         this.FHeroDeployment = new THeroDeployment(this);
         this.FHeroDeployment.SetScene(this.FScene);
         this.FHeroDeployment.SetSelectHero = this.SetDeploymentSelectHero;
         this.FHeroDeployment.SetSelectHeroBitmapVisible = this.SetSelectHeroBitmapVisible;
         this.FHeroDeployment.OnEffectText = EffectGenerateText;
         this.FHeroDeployment.OnEnterMilitary = this.EnterMilitary;
         this.FHeroDeployment.DragEnableCallBack = this.SetDragEnableCallBack;
         this.FHeroDeployment.ResetDeployment = this.ResetDeployment;
         this.FHeroDeployment.AutoChangeForm = this.AutoChangeForm;
         this.FHeroSkill = new THeroSkill(this,this.FScene);
         this.FHeroSkill.SkillOnClick = this.FSkillOnClick;
         this.FHeroSkill.HintOnOver = this.HintOnOver;
         this.FHeroSkill.HintOnOut = this.HintOnOut;
         this.FHeroInfoTip = new TDeploymentTip(this.Parent);
         this.FHeroInfoTip.Visible = false;
         this.FSelectHeroBitmap = new Bitmap();
         addChild(this.FSelectHeroBitmap);
         this.FSelectHeroDO = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
         addChild(this.FSelectHeroDO);
         this.FSelectHeroDO.visible = false;
         this.FSelectHeroDO.mouseEnabled = false;
         this.FHint = new THint();
         this.FScene.tf_battleValue.text = "";
         this.FSceneCheck = TUtilityReflection.CreateDisplayObjectInstance(CONST_DEPLOYMENT.RESOURCE_ClassName_TacticalDeploymentCheck) as MovieClip;
         addChild(this.FSceneCheck);
         this.FSceneCheck.visible = false;
         this.FIsAutoSet = false;
         this.FMC_SaiXuanJiNeng = this.FScene["MC_SaiXuanJiNeng"];
         if(this.FMC_SaiXuanJiNeng)
         {
            this.Fbtn_showlist = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"];
            this.FTF_Name = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["TF_Name"];
            _loc1_ = 0;
            while(_loc1_ < FOUR)
            {
               this.FFourMvVector[_loc1_] = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"]["mc_" + _loc1_];
               this.FFourMvVector[_loc1_].buttonMode = true;
               _loc1_++;
            }
            this.FMC_SaiXuanJiNeng.visible = false;
            this.Ftask = this.FMC_SaiXuanJiNeng["task"];
            this.Ftask.gotoAndStop(1);
            this.FTaskIndex = 1;
            TGameUtil.setButtonMode(this.Fbtn_showlist,true);
         }
         if(this.FCharacter.GetConfigValueById(91000003))
         {
            if(this.FMC_SaiXuanJiNeng)
            {
               this.FMC_SaiXuanJiNeng.visible = true;
            }
            this.FNiMeiA = true;
         }
         this.FLimitSkillCount = SLogicsCore.Character.GetConfigValueById(91000005);
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FScene["MC_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(this.FScene.btn_left,true);
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         TGameUtil.setButtonMode(this.FScene.btn_right,true);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         this.FScene.MC_LogoFront.addEventListener(MouseEvent.MOUSE_MOVE,this.LogoOnMove,false,0,true);
         this.FScene.MC_LogoFront.addEventListener(MouseEvent.MOUSE_OUT,this.LogoOnOut,false,0,true);
         this.FScene.MC_LogoMiddle.addEventListener(MouseEvent.MOUSE_MOVE,this.LogoOnMove,false,0,true);
         this.FScene.MC_LogoMiddle.addEventListener(MouseEvent.MOUSE_OUT,this.LogoOnOut,false,0,true);
         this.FScene.MC_LogoAfter.addEventListener(MouseEvent.MOUSE_MOVE,this.LogoOnMove,false,0,true);
         this.FScene.MC_LogoAfter.addEventListener(MouseEvent.MOUSE_OUT,this.LogoOnOut,false,0,true);
         this.FScene.MC_Aboratory_Btn.addEventListener(MouseEvent.MOUSE_MOVE,this.OnAboratoryBtnMove,false,0,true);
         this.FScene.MC_Aboratory_Btn.addEventListener(MouseEvent.CLICK,this.OnAboratoryBtnClick,false,0,true);
         this.FScene.MC_Aboratory_Btn.addEventListener(MouseEvent.MOUSE_OUT,this.OnAboratoryBtnOut,false,0,true);
         this.FScene.MC_Magic_Btn.addEventListener(MouseEvent.CLICK,this.OnMagicBtnClick,false,0,true);
         this.FScene.MC_Magic_Btn.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMagicBtnMove,false,0,true);
         this.FScene.MC_Magic_Btn.addEventListener(MouseEvent.MOUSE_OUT,this.OnMagicBtnOut,false,0,true);
         this.FScene.MC_NijiaMystic_Btn.addEventListener(MouseEvent.CLICK,this.OnMysticBtnClick,false,0,true);
         TGameUtil.setButtonMode(this.FScene.MC_Aboratory_Btn,true);
         TGameUtil.setButtonMode(this.FScene.MC_Magic_Btn,true);
         TGameUtil.setButtonMode(this.FScene.MC_NijiaMystic_Btn,true);
         if(this.FScene.MC_Awaken_Btn)
         {
            TGameUtil.setButtonMode(this.FScene.MC_Awaken_Btn,true);
            this.FScene.MC_Awaken_Btn.addEventListener(MouseEvent.CLICK,this.OnAwakenBtnClick,false,0,true);
         }
         if(this.FScene.MC_Taboo_Btn)
         {
            TGameUtil.setButtonMode(this.FScene.MC_Taboo_Btn,true);
            this.FScene.MC_Taboo_Btn.addEventListener(MouseEvent.CLICK,this.OnTabooBtnClick,false,0,true);
         }
         if(this.FMC_SaiXuanJiNeng)
         {
            _loc1_ = 0;
            while(_loc1_ < FOUR)
            {
               this.FFourMvVector[_loc1_].addEventListener(MouseEvent.CLICK,this.SaiXuanJiNengClick);
               this.FFourMvVector[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.SaiXuanJiNengOver);
               this.FFourMvVector[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.SaiXuanJiNengOut);
               _loc1_++;
            }
            this.Fbtn_showlist.addEventListener(MouseEvent.CLICK,this.SaiXuanshowlistClick);
            this.Ftask.addEventListener(MouseEvent.CLICK,this.taskClick);
         }
         this.addEventListener(MouseEvent.CLICK,this.OnHideComboBoxList);
         super.ResourcesPerform_UILocations();
      }
      
      protected function SaiXuanJiNengOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function SaiXuanJiNengOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      protected function SaiXuanJiNengClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FFourMvVector[0]:
               this.FCurSkillindex = 0;
               break;
            case this.FFourMvVector[1]:
               this.FCurSkillindex = 1;
               break;
            case this.FFourMvVector[2]:
               this.FCurSkillindex = 2;
               break;
            case this.FFourMvVector[3]:
               this.FCurSkillindex = 3;
         }
         this.UpdateForLittleSkill();
      }
      
      protected function UpdateForLittleSkill() : void
      {
         this.FCharacter.MainHero.SetCopySkillsByIndex(this.FCurSkillindex,this.FTaskIndex == 1 ? 0 : 1);
         this.ResetSkill();
         this.SetVisibelByValue(false);
         if(this.FHeroSkill)
         {
            this.FHeroSkill.RestCurPage();
         }
      }
      
      public function SetVisibelByValue(param1:Boolean) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible = param1;
            this.FTF_Name.text = STRING_HEROS.STRING_NewSkillTitel[this.FCurSkillindex];
         }
      }
      
      protected function SaiXuanshowlistClick(param1:MouseEvent) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            if(this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible)
            {
               this.SetVisibelByValue(false);
            }
            else
            {
               this.SetVisibelByValue(true);
            }
         }
      }
      
      protected function taskClick(param1:MouseEvent) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            if(this.FTaskIndex == 1)
            {
               this.FTaskIndex = 2;
            }
            else
            {
               this.FTaskIndex = 1;
            }
            this.Ftask.gotoAndStop(this.FTaskIndex);
            this.UpdateForLittleSkill();
         }
      }
      
      protected function OnHideComboBoxList(param1:MouseEvent) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            if(!this.FMC_SaiXuanJiNeng.hitTestPoint(param1.stageX,param1.stageY))
            {
               this.SetVisibelByValue(false);
            }
         }
      }
      
      public function OnAboratoryBtnMove(param1:MouseEvent) : void
      {
         if(this.FAboratoryBtnMove != null)
         {
            this.FAboratoryBtnMove();
         }
      }
      
      public function OnAboratoryBtnOut(param1:MouseEvent) : void
      {
         if(this.FAboratoryBtnOut != null)
         {
            this.FAboratoryBtnOut();
         }
      }
      
      public function OnAboratoryBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ChatChannel_01) as TSystemLanguage;
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            EffectGenerateText(_loc2_.Desc);
            return;
         }
         if(this.FAboratoryBtnClick != null)
         {
            this.FAboratoryBtnClick();
         }
      }
      
      public function OnMagicBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ChatChannel_01) as TSystemLanguage;
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            EffectGenerateText(_loc2_.Desc);
            return;
         }
         if(this.FMagicBtnClick != null)
         {
            this.FMagicBtnClick();
         }
      }
      
      public function OnMagicBtnOut(param1:MouseEvent) : void
      {
         if(this.FMagicBtnOut != null)
         {
            this.FMagicBtnOut();
         }
      }
      
      public function OnMagicBtnMove(param1:MouseEvent) : void
      {
         if(this.FMagicBtnMove != null)
         {
            this.FMagicBtnMove();
         }
      }
      
      public function OnMysticBtnClick(param1:MouseEvent) : void
      {
         if(this.FMysticBtnClick != null)
         {
            this.FMysticBtnClick();
         }
      }
      
      public function OnAwakenBtnClick(param1:MouseEvent) : void
      {
         if(this.AwakenBtnClick != null)
         {
            this.AwakenBtnClick();
         }
      }
      
      public function OnTabooBtnClick(param1:MouseEvent) : void
      {
         if(this.TabooBtnClick != null)
         {
            this.TabooBtnClick();
         }
      }
      
      protected function CheckBtn() : void
      {
         this.FScene.btn_left.visible = Boolean(this.FCurPage != 1);
         this.FScene.btn_right.visible = Boolean(this.FCurPage != this.FTotlePage);
      }
      
      protected function UpdataUI() : void
      {
         this.ResetHeroList();
         this.ResetDeployment();
         this.UpdateForLittleSkill();
      }
      
      protected function GetPageHeroInfo() : THeros
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THeros = null;
         var _loc5_:THero = null;
         _loc2_ = (this.FCurPage - 1) * MAX_COUNT;
         _loc3_ = Math.min(_loc2_ + MAX_COUNT,this.FCurPageHeros.Count);
         _loc4_ = new THeros();
         _loc1_ = _loc2_;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FCurPageHeros.GetHeroByIndex(_loc1_);
            _loc4_.Add(_loc5_);
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function GetDeploymentHeroInfo() : THeros
      {
         var _loc1_:int = 0;
         var _loc2_:THeros = null;
         var _loc3_:THero = null;
         _loc2_ = new THeros();
         _loc1_ = 0;
         while(_loc1_ < this.FHeros.Count)
         {
            _loc3_ = this.FHeros.GetHeroByIndex(_loc1_);
            if(_loc3_.FightPosition > 0)
            {
               _loc2_.Add(_loc3_);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function UpdateWindow() : void
      {
         this.FSelectHero = null;
         this.SetHerosByType();
         this.FCurPage = 1;
         this.FTotlePage = Math.max((this.FCurPageHeros.Count - 1) / MAX_COUNT + 1,1);
         this.OnLeft();
         this.ResetHeroList();
         this.ResetDeployment();
         this.UpdateForLittleSkill();
      }
      
      protected function GetMainHeroSkillInfo() : TSkills
      {
         var _loc1_:THero = null;
         _loc1_ = SLogicsCore.Character.MainHero;
         if(this.FNiMeiA)
         {
            return _loc1_.SkillsCopy;
         }
         return _loc1_.Skills;
      }
      
      protected function SetListSelectHero(param1:THero = null) : void
      {
         this.FSelectHero = param1;
         this.FHeroDeployment.SetListSelectHero(param1);
      }
      
      protected function SetDeploymentSelectHero(param1:THero = null) : void
      {
         this.FSelectHero = param1;
      }
      
      protected function CheckMouseIcon() : void
      {
         var _loc1_:TRoleModel = null;
         var _loc2_:TCoordinate = null;
         if(this.FIsAutoSet)
         {
            this.UpdateAutoSetMove();
            return;
         }
         if(this.FSelectHero != null)
         {
            _loc1_ = this.FRoleModel.GetDatebaseByIdentifier(this.FSelectHero.Identifier) as TRoleModel;
            _loc2_ = TGameUtil.ShowImageByID(TGameUtil.Type_Model,this.FSelectHeroBitmap,CONST_MODULES.MODULE_TacticalDeployment,_loc1_.Model,TActive.TYPE_ACTIVE_FIGHT_IDLE);
            if(_loc2_ != null)
            {
               this.FShowHeroCoordinate = _loc2_;
            }
            if(this.FSelectHeroBitmap.bitmapData == null)
            {
               this.FSelectHeroDO.visible = true;
               this.FSelectHeroDO.x = mouseX;
               this.FSelectHeroDO.y = mouseY;
               this.FSelectHeroDO.alpha = 0.7;
            }
            else
            {
               this.FSelectHeroDO.visible = false;
               this.FSelectHeroBitmap.x = mouseX;
               this.FSelectHeroBitmap.y = mouseY;
               this.FSelectHeroBitmap.alpha = 0.7;
               if(this.FShowHeroCoordinate != null)
               {
                  this.FSelectHeroBitmap.x -= this.FShowHeroCoordinate.X;
                  this.FSelectHeroBitmap.y -= this.FShowHeroCoordinate.Y;
               }
            }
         }
         else
         {
            if(this.FSelectHeroBitmap != null && this.FSelectHeroBitmap.bitmapData != null)
            {
               this.FSelectHeroBitmap.bitmapData = null;
            }
            if(this.FSelectHeroDO != null)
            {
               this.FSelectHeroDO.visible = false;
            }
         }
         this.OnMouseCheck();
      }
      
      protected function UpdateAutoSetMove() : void
      {
         var _loc1_:TCoordinate = null;
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_Model,this.FSelectHeroBitmap,CONST_MODULES.MODULE_TacticalDeployment,this.FAutoHeroModelId,TActive.TYPE_ACTIVE_FIGHT_IDLE);
         if(_loc1_ != null)
         {
            this.FShowHeroCoordinate = _loc1_;
         }
         if(this.FSelectHeroBitmap.bitmapData == null)
         {
            this.FSelectHeroDO.visible = true;
            this.FSelectHeroDO.x = this.StartHeroPoint.X + this.MoveTimesIndex * (this.EndPosPoint.X - this.StartHeroPoint.X) / MoveTimesCount;
            this.FSelectHeroDO.y = this.StartHeroPoint.Y + this.MoveTimesIndex * (this.EndPosPoint.Y - this.StartHeroPoint.Y) / MoveTimesCount;
            this.FSelectHeroDO.alpha = 0.7;
         }
         else
         {
            this.FSelectHeroDO.visible = false;
            this.FSelectHeroBitmap.x = this.StartHeroPoint.X + this.MoveTimesIndex * (this.EndPosPoint.X - this.StartHeroPoint.X) / MoveTimesCount;
            this.FSelectHeroBitmap.y = this.StartHeroPoint.Y + this.MoveTimesIndex * (this.EndPosPoint.Y - this.StartHeroPoint.Y) / MoveTimesCount;
            this.FSelectHeroBitmap.alpha = 0.7;
            if(this.FShowHeroCoordinate != null)
            {
               this.FSelectHeroBitmap.x -= this.FShowHeroCoordinate.X;
               this.FSelectHeroBitmap.y -= this.FShowHeroCoordinate.Y;
            }
         }
         ++this.MoveTimesIndex;
         if(this.MoveTimesIndex > MoveTimesCount)
         {
            this.FIsAutoSet = false;
            mouseEnabled = true;
            mouseChildren = true;
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TacticalDeployment_ChangePositionReq);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.FAutoHeroId);
            _loc3_.writeByte(this.FAutoPos);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            if(this.FAutoEndFun != null)
            {
               this.FAutoEndFun(this);
            }
         }
      }
      
      protected function SetSelectHeroBitmapVisible(param1:Boolean) : void
      {
         this.FSelectHeroBitmap.visible = param1;
      }
      
      protected function ShowHeroInfoTip(param1:Object, param2:THero) : void
      {
         this.FHeroInfoTip.Visible = true;
         this.FHeroInfoTip.SetHeroData(param2);
      }
      
      protected function HideHeroInfoTip(param1:Object) : void
      {
         this.FHeroInfoTip.Visible = false;
      }
      
      protected function SetDragEnableCallBack(param1:Boolean) : void
      {
         this.FHeroList.DragEnable = param1;
      }
      
      protected function LogoOnMove(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Vector.<TAdditionRate> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:TStarPointDesc = null;
         var _loc8_:int = 0;
         _loc6_ = "";
         _loc2_ = param1.currentTarget as Sprite;
         if(_loc2_.name == "MC_LogoFront")
         {
            _loc3_ = this.FCharacter.EsotericPoints.GetRatesByIndex(0);
         }
         else if(_loc2_.name == "MC_LogoMiddle")
         {
            _loc3_ = this.FCharacter.EsotericPoints.GetRatesByIndex(1);
         }
         else if(_loc2_.name == "MC_LogoAfter")
         {
            _loc3_ = this.FCharacter.EsotericPoints.GetRatesByIndex(2);
         }
         _loc5_ = int(_loc3_.length);
         if(_loc5_ <= 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(_loc3_[_loc4_].Key == 0)
            {
               _loc6_ = TUtilityString.Format(FORMAT_Caption01,_loc3_[_loc4_].Value);
            }
            else if(_loc3_[_loc4_].Key == 101)
            {
               _loc8_ = 17500000 + _loc3_[_loc4_].Key;
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc8_) as TStarPointDesc;
               _loc6_ += TUtilityString.Format(FORMAT_Caption04,_loc7_.Desc,_loc3_[_loc4_].Value);
            }
            else
            {
               _loc8_ = 17500000 + _loc3_[_loc4_].Key;
               _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc8_) as TStarPointDesc;
               _loc6_ += TUtilityString.Format(FORMAT_Caption02,_loc7_.Desc,_loc3_[_loc4_].Value);
            }
            _loc4_++;
         }
         this.FHint.Caption = _loc6_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(param1,this.FHint);
         }
      }
      
      protected function LogoOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnMouseCheck() : void
      {
         if(this.FSceneCheck)
         {
            this.FSceneCheck.visible = Boolean(this.FSelectHero != null);
         }
         if(this.FSelectHero == null)
         {
            return;
         }
         this.FSceneCheck.x = mouseX + 15;
         this.FSceneCheck.y = mouseY + 7;
         this.FSceneCheck.gotoAndStop(this.FHeroDeployment.GetCheckFrame());
      }
      
      protected function UpdateTab() : void
      {
         this.ResetSkill();
         if(this.FHeroSkill)
         {
            this.FHeroSkill.RestCurPage();
         }
      }
      
      protected function OnHeroChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FHeroTabIndex)
         {
            return;
         }
         this.FHeroTabIndex = _loc2_;
         this.UpdateWindow();
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TacticalDeployment) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      protected function OnLeft(param1:MouseEvent = null) : void
      {
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.FHeroList.SetHerosData(this.GetPageHeroInfo());
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent = null) : void
      {
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.FHeroList.SetHerosData(this.GetPageHeroInfo());
         this.CheckBtn();
      }
      
      protected function OnMouseUp(param1:MouseEvent) : void
      {
         this.SetListSelectHero();
      }
      
      protected function EnterMilitary(param1:Object) : void
      {
         if(this.FOnEnterMilitary != null)
         {
            this.FOnEnterMilitary(param1);
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.UpdateTab();
      }
      
      public function set MaxPointCount(param1:uint) : void
      {
         this.FMaxPointCount = param1;
      }
      
      public function set MaxHeroCount(param1:uint) : void
      {
         this.FMaxHeroCount = param1;
      }
      
      public function get SkillOnClick() : Function
      {
         return this.FSkillOnClick;
      }
      
      public function set SkillOnClick(param1:Function) : void
      {
         this.FSkillOnClick = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get OnEnterMilitary() : Function
      {
         return this.FOnEnterMilitary;
      }
      
      public function set OnEnterMilitary(param1:Function) : void
      {
         this.FOnEnterMilitary = param1;
      }
      
      public function set AboratoryBtnMove(param1:Function) : void
      {
         this.FAboratoryBtnMove = param1;
      }
      
      public function set AboratoryBtnOut(param1:Function) : void
      {
         this.FAboratoryBtnOut = param1;
      }
      
      public function set AboratoryBtnClick(param1:Function) : void
      {
         this.FAboratoryBtnClick = param1;
      }
      
      public function set MagicBtnMove(param1:Function) : void
      {
         this.FMagicBtnMove = param1;
      }
      
      public function set MagicBtnOut(param1:Function) : void
      {
         this.FMagicBtnOut = param1;
      }
      
      public function set MagicBtnClick(param1:Function) : void
      {
         this.FMagicBtnClick = param1;
      }
      
      public function set MysticBtnClick(param1:Function) : void
      {
         this.FMysticBtnClick = param1;
      }
      
      public function SetupDeploymentData() : void
      {
         this.FHeros = this.FCharacter.Heros;
         this.SetHerosByType();
         this.FCurPage = 1;
         this.FTotlePage = Math.max((this.FCurPageHeros.Count - 1) / MAX_COUNT + 1,1);
         this.OnLeft();
         this.UpdataUI();
         if(Boolean(this.FScene) && Boolean(this.FScene.tf_count))
         {
            this.FScene.tf_count.text = this.FCurPageHeros.Count + "/" + this.FMaxHeroCount;
         }
         this.UserUpdateFightingPower();
         this.FScene.mc_left_falling.gotoAndPlay(1);
         this.FScene.mc_right_falling.gotoAndPlay(1);
      }
      
      public function SetHerosByType() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         this.FCurPageHeros.Clear();
         _loc1_ = 1;
         while(_loc1_ < this.FCharacter.Heros.Count)
         {
            _loc2_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
            if(_loc2_.StandPositionWithProfession == this.FHeroTabIndex + 1)
            {
               this.FCurPageHeros.Add(_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function UserUpdateFightingPower() : void
      {
         var _loc1_:UInt64 = null;
         if(!Visible)
         {
            return;
         }
         _loc1_ = this.FCharacter.GetFightingPowerPVE();
         this.FScene.tf_battleValue.text = _loc1_.ToString();
      }
      
      public function ResetHeroList() : void
      {
         if(this.FHeroList != null)
         {
            this.FHeroList.SetHerosData(this.GetPageHeroInfo());
         }
      }
      
      public function ResetDeployment() : void
      {
         this.FHeroDeployment.SetDeploymentData(this.FMaxPointCount,this.GetDeploymentHeroInfo());
         this.UserUpdateFightingPower();
      }
      
      public function ResetFormData() : void
      {
         this.FHeroDeployment.SetFormData(SLogicsCore.AutoChangeFormData);
      }
      
      public function ResetSkill() : void
      {
         if(this.FHeroSkill)
         {
            this.FHeroSkill.SetSkillData(this.GetMainHeroSkillInfo(),this.FChangeTabIndex);
         }
      }
      
      public function AutoSetDeployment(param1:uint, param2:uint, param3:Function = null) : void
      {
         var _loc4_:TRoleModel = null;
         this.StartHeroPoint = this.FHeroList.GetHeroPoint(param1);
         this.EndPosPoint = this.FHeroDeployment.GetPosPoint(param2);
         if(this.StartHeroPoint == null && this.EndPosPoint == null)
         {
            return;
         }
         _loc4_ = this.FRoleModel.GetDatebaseByIdentifier(param1) as TRoleModel;
         this.StartHeroPoint.X -= this.x;
         this.StartHeroPoint.Y -= this.y;
         this.EndPosPoint.X -= this.x - 60;
         this.EndPosPoint.Y -= this.y - 20;
         this.MoveTimesIndex = 0;
         this.FAutoHeroId = param1;
         this.FAutoPos = param2;
         this.FAutoHeroModelId = _loc4_.Model;
         this.FIsAutoSet = true;
         mouseEnabled = false;
         mouseChildren = false;
         this.FAutoEndFun = param3;
      }
   }
}

