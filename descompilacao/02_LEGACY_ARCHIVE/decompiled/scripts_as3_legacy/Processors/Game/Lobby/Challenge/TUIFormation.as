package Processors.Game.Lobby.Challenge
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Challenge.TChallenge;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TMilitary;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.NinjaHostel.THeroBaseData;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Challenge.Compoents.TDeploymentTip;
   import Processors.Game.Lobby.Challenge.Compoents.THeroDeployment;
   import Processors.Game.Lobby.Challenge.Compoents.THeroList;
   import Processors.Game.Lobby.Challenge.Compoents.THeroSkill;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_HEROS;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TUIFormation extends TUIBaseWindow
   {
      
      protected static const TAB_COUNT:int = 3;
      
      protected static const MAX_COUNT:int = 6;
      
      protected static const FOUR:Number = 4;
      
      protected var FChallenge:TChallenge;
      
      protected var FCharacter:TCharacter;
      
      protected var FHeros:THeros;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FSceneCheck:MovieClip;
      
      protected var FSelectHero:THero;
      
      protected var FShowHeroCoordinate:TCoordinate;
      
      protected var FSelectHeroBitmap:Bitmap;
      
      protected var FSelectHeroDO:MovieClip;
      
      protected var FMC_SaiXuanJiNeng:MovieClip;
      
      protected var Fbtn_showlist:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FFourMvVector:Vector.<MovieClip>;
      
      protected var Ftask:MovieClip;
      
      protected var FHeroList:THeroList;
      
      protected var FHeroDeployment:THeroDeployment;
      
      protected var FHeroSkill:THeroSkill;
      
      protected var FHeroInfoTip:TDeploymentTip;
      
      protected var FProcessorWindowOneKeySwap:TProcessorWindowOneKeySwap;
      
      protected var FHelpTips:THint;
      
      protected var FRoleModel:TBins;
      
      protected var FMilitary:TBins;
      
      protected var FCurSkillindex:int;
      
      protected var FLimitSkillCount:int;
      
      protected var FTaskIndex:int;
      
      protected var FSkillOnClick:Function;
      
      protected var FOnTakeBackHero:Function;
      
      protected var FOneKeySwap:Function;
      
      public function TUIFormation(param1:TUIComponent)
      {
         super(param1);
         this.FChallenge = SLogicsCore.Challenge;
         this.FCharacter = SLogicsCore.Character;
         this.FHeros = new THeros();
         this.FUIPage = new TUIPage(this);
         this.FUITab = new TUITab(this);
         this.FHelpTips = new THint();
         this.FFourMvVector = new Vector.<MovieClip>(FOUR);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FMilitary = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["BTN_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FHeroList = new THeroList(this,FMC_Scene.mc_playHead);
         this.FHeroList.ShowHeroInfoTip = this.ShowHeroInfoTip;
         this.FHeroList.HideHeroInfoTip = this.HideHeroInfoTip;
         this.FHeroList.SetSelectHero = this.SetListSelectHero;
         this.FHeroList.TakeBackHero = this.TakeBackHero;
         this.FHeroList.visible = false;
         this.FHeroDeployment = new THeroDeployment(this);
         this.FHeroDeployment.SetScene(FMC_Scene);
         this.FHeroDeployment.SetSelectHero = this.SetDeploymentSelectHero;
         this.FHeroDeployment.SetSelectHeroBitmapVisible = this.SetSelectHeroBitmapVisible;
         this.FHeroDeployment.OnEffectText = this.EffectGenerateText;
         this.FHeroSkill = new THeroSkill(this,FMC_Scene);
         this.FHeroSkill.SkillOnClick = this.ProcessorSkillOnClick;
         this.FHeroSkill.HintOnOver = this.ProcessorOnHelpOver;
         this.FHeroSkill.HintOnOut = this.ProcessorOnHelpOut;
         this.FHeroInfoTip = new TDeploymentTip(this.Parent);
         this.FHeroInfoTip.Visible = false;
         this.FSelectHeroBitmap = new Bitmap();
         addChild(this.FSelectHeroBitmap);
         this.FSelectHeroDO = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
         addChild(this.FSelectHeroDO);
         this.FSelectHeroDO.visible = false;
         this.FSelectHeroDO.mouseEnabled = false;
         this.FSceneCheck = TUtilityReflection.CreateDisplayObjectInstance("MC_ChallengeFormationCheck") as MovieClip;
         addChild(this.FSceneCheck);
         this.FSceneCheck.visible = false;
         this.FMC_SaiXuanJiNeng = FMC_Scene["MC_SaiXuanJiNeng"];
         this.Fbtn_showlist = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"];
         TGameUtil.setButtonMode(this.Fbtn_showlist,true);
         this.FTF_Name = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["TF_Name"];
         _loc2_ = 0;
         while(_loc2_ < FOUR)
         {
            this.FFourMvVector[_loc2_] = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"]["mc_" + _loc2_];
            this.FFourMvVector[_loc2_].buttonMode = true;
            _loc2_++;
         }
         this.FMC_SaiXuanJiNeng.visible = false;
         this.Ftask = this.FMC_SaiXuanJiNeng["task"];
         this.Ftask.gotoAndStop(1);
         this.FTaskIndex = 1;
         this.FLimitSkillCount = this.FCharacter.GetConfigValueById(91000005);
         this.FProcessorWindowOneKeySwap = new TProcessorWindowOneKeySwap(this);
         this.FProcessorWindowOneKeySwap.Init();
         this.FProcessorWindowOneKeySwap.OnClose = this.ProcessorOnWindowExchangeClose;
         this.FProcessorWindowOneKeySwap.ExchangeOnClick = this.ProcessorOnOneKeySwap;
         this.FProcessorWindowOneKeySwap.OnEffectText = this.EffectGenerateText;
         this.FProcessorWindowOneKeySwap.x = 285;
         this.FProcessorWindowOneKeySwap.y = 143;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(FMC_Scene.btn_left,true);
         FMC_Scene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         TGameUtil.setButtonMode(FMC_Scene.btn_right,true);
         FMC_Scene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         TGameUtil.setButtonMode(FMC_Scene.BTN_OneKeySwap,true);
         FMC_Scene.BTN_OneKeySwap.addEventListener(MouseEvent.CLICK,this.OnOneKeySwap);
         var _loc1_:int = 0;
         while(_loc1_ < FOUR)
         {
            this.FFourMvVector[_loc1_].addEventListener(MouseEvent.CLICK,this.SaiXuanJiNengClick);
            this.FFourMvVector[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.SaiXuanJiNengOver);
            this.FFourMvVector[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.SaiXuanJiNengOut);
            _loc1_++;
         }
         this.Fbtn_showlist.addEventListener(MouseEvent.CLICK,this.SaiXuanshowlistClick);
         this.Ftask.addEventListener(MouseEvent.CLICK,this.taskClick);
         this.addEventListener(MouseEvent.CLICK,this.OnHideComboBoxList);
         addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
      }
      
      protected function CheckMouseIcon() : void
      {
         var _loc1_:TRoleModel = null;
         var _loc2_:TCoordinate = null;
         if(this.FSelectHero != null)
         {
            _loc1_ = this.FRoleModel.GetDatebaseByIdentifier(this.FSelectHero.Identifier) as TRoleModel;
            _loc2_ = TGameUtil.ShowImageByID(TGameUtil.Type_Model,this.FSelectHeroBitmap,CONST_MODULES.MODULE_Challenge,_loc1_.Model,TActive.TYPE_ACTIVE_FIGHT_IDLE);
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
      
      protected function GetPageHeroInfo() : THeros
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:THeros = null;
         var _loc5_:THero = null;
         _loc2_ = (this.FCurPage - 1) * MAX_COUNT;
         _loc3_ = Math.min(_loc2_ + MAX_COUNT,this.FHeros.Count);
         _loc4_ = new THeros();
         _loc1_ = _loc2_;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FHeros.GetHeroByIndex(_loc1_);
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
         while(_loc1_ < this.FCharacter.Heros.Count)
         {
            _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
            if(_loc3_.FightPosition > 0)
            {
               _loc2_.Add(_loc3_);
            }
            _loc1_++;
         }
         return _loc2_;
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
         this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible = param1;
         this.FTF_Name.text = STRING_HEROS.STRING_NewSkillTitel[this.FCurSkillindex];
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.UpdateWindow();
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function PrcoessorOnGetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170102) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
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
         if(this.FCurPage > this.FTotalPage)
         {
            this.FCurPage = this.FTotalPage;
         }
         this.FHeroList.SetHerosData(this.GetPageHeroInfo());
         this.CheckBtn();
      }
      
      protected function CheckBtn() : void
      {
         FMC_Scene.btn_left.visible = Boolean(this.FCurPage != 1);
         FMC_Scene.btn_right.visible = Boolean(this.FCurPage != this.FTotalPage);
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
      
      protected function SetListSelectHero(param1:THero = null) : void
      {
         this.FSelectHero = param1;
         this.FHeroDeployment.SetListSelectHero(param1);
      }
      
      protected function SetDeploymentSelectHero(param1:THero = null) : void
      {
         this.FSelectHero = param1;
      }
      
      protected function SetSelectHeroBitmapVisible(param1:Boolean) : void
      {
         this.FSelectHeroBitmap.visible = param1;
      }
      
      protected function EffectGenerateText(param1:String) : void
      {
         if(FOnShowFlowText != null)
         {
            FOnShowFlowText(param1);
         }
      }
      
      protected function TakeBackHero(param1:THero) : void
      {
         if(this.FOnTakeBackHero != null)
         {
            this.FOnTakeBackHero(param1);
         }
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
      
      protected function SaiXuanJiNengOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      protected function SaiXuanJiNengOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      protected function SaiXuanshowlistClick(param1:MouseEvent) : void
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
      
      protected function taskClick(param1:MouseEvent) : void
      {
         this.FTaskIndex = this.FTaskIndex == 1 ? 2 : 1;
         this.Ftask.gotoAndStop(this.FTaskIndex);
         this.UpdateForLittleSkill();
      }
      
      protected function OnHideComboBoxList(param1:MouseEvent) : void
      {
         if(!this.FMC_SaiXuanJiNeng.hitTestPoint(param1.stageX,param1.stageY))
         {
            this.SetVisibelByValue(false);
         }
      }
      
      protected function OnMouseUp(param1:MouseEvent) : void
      {
         this.SetListSelectHero();
      }
      
      protected function OnOneKeySwap(param1:MouseEvent) : void
      {
         this.FProcessorWindowOneKeySwap.Visible = true;
         this.FProcessorWindowOneKeySwap.Update();
      }
      
      protected function ProcessorOnWindowExchangeClose(param1:Object) : void
      {
         this.FProcessorWindowOneKeySwap.Visible = false;
      }
      
      protected function ProcessorOnOneKeySwap(param1:Object, param2:Object, param3:Object) : void
      {
         if(this.FOneKeySwap != null)
         {
            this.FOneKeySwap(param1,param2,param3);
         }
      }
      
      protected function ProcessorOnHelpOver(param1:Object, param2:Object) : void
      {
         var _loc3_:THint = null;
         if(OnHelpOver != null)
         {
            _loc3_ = param2 as THint;
            _loc3_.Content = _loc3_.Caption;
            OnHelpOver(this,param2);
         }
      }
      
      protected function ProcessorOnHelpOut(param1:Object) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
         }
      }
      
      protected function ProcessorSkillOnClick(param1:Object, param2:Object) : void
      {
         if(this.FSkillOnClick != null)
         {
            this.FSkillOnClick(param1,param2);
         }
      }
      
      public function get SkillOnClick() : Function
      {
         return this.FSkillOnClick;
      }
      
      public function set SkillOnClick(param1:Function) : void
      {
         this.FSkillOnClick = param1;
      }
      
      public function get OnTakeBackHero() : Function
      {
         return this.FOnTakeBackHero;
      }
      
      public function set OnTakeBackHero(param1:Function) : void
      {
         this.FOnTakeBackHero = param1;
      }
      
      public function get OneKeySwap() : Function
      {
         return this.FOneKeySwap;
      }
      
      public function set OneKeySwap(param1:Function) : void
      {
         this.FOneKeySwap = param1;
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
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
            if(this.FProcessorWindowOneKeySwap != null)
            {
               this.FProcessorWindowOneKeySwap.UpdataBitmap();
            }
         }
      }
      
      public function UpdateWindow() : void
      {
         this.FSelectHero = null;
         this.SetHerosByType();
         this.FCurPage = 1;
         this.FTotalPage = Math.max((this.FHeros.Count - 1) / MAX_COUNT + 1,1);
         this.OnLeft();
         this.ResetHeroList();
         this.ResetDeployment();
         this.UpdateForLittleSkill();
      }
      
      public function SetHerosByType() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:THeroBaseData = null;
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         this.FHeros.Clear();
         _loc1_ = 0;
         while(_loc1_ < SLogicsCore.NinjaHostelData.HostelHeroCount)
         {
            _loc4_ = SLogicsCore.NinjaHostelData.GetHerBaseByIndex(_loc1_);
            _loc2_ = this.FChallenge.TotalList.indexOf(_loc4_.OrigionId);
            if(!(_loc2_ == -1 || _loc4_.StandPositionWithProfession != this.FChangeTabIndex + 1))
            {
               _loc3_ = SLogicsCore.PoolCharacter.AcquireHero();
               _loc3_.Identifier = _loc4_.Identifier;
               _loc3_.Level = _loc4_.HeroLevel;
               _loc3_.Quality = _loc4_.Quality;
               _loc3_.OrigionId = _loc4_.OrigionId;
               _loc3_.Name = _loc4_.Name;
               _loc3_.Profession = _loc4_.Profession;
               _loc3_.IsRecommand = true;
               _loc3_.IsInHostel = true;
               _loc3_.Mounted = false;
               _loc3_.IsMain = false;
               this.FHeros.Add(_loc3_);
               _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_HeroInfo_Req);
               _loc6_ = _loc5_.Data;
               _loc6_.writeUnsignedInt(_loc3_.Identifier);
               SNetworkCore.Transceiver.PacketTransmit(_loc5_);
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ < this.FCharacter.Heros.Count)
         {
            _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
            if(_loc3_.StandPositionWithProfession == this.FChangeTabIndex + 1)
            {
               _loc3_.IsRecommand = this.FChallenge.TotalList.indexOf(_loc3_.OrigionId) == -1 ? false : true;
               _loc3_.IsInHostel = false;
               this.FHeros.Add(_loc3_);
            }
            _loc1_++;
         }
         this.FHeros.SortByRecommand();
      }
      
      override public function Unmount() : void
      {
      }
      
      public function UserUpdateFightingPower() : void
      {
         var _loc1_:UInt64 = null;
         if(!Visible || !FMC_Scene)
         {
            return;
         }
         _loc1_ = this.FCharacter.GetFightingPowerPVE();
         FMC_Scene.tf_battleValue.text = _loc1_.ToString();
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
         var _loc1_:uint = 0;
         var _loc2_:TMilitary = null;
         var _loc3_:uint = 0;
         _loc1_ = this.FCharacter.MilitaryRank;
         _loc2_ = this.FMilitary.GetDatebaseByIdentifier(_loc1_) as TMilitary;
         _loc3_ = uint(_loc2_.FightHeroNum);
         this.FHeroDeployment.SetDeploymentData(_loc3_,this.GetDeploymentHeroInfo());
         this.UserUpdateFightingPower();
      }
      
      public function ResetSkill() : void
      {
         if(!Visible || !FMC_Scene)
         {
            return;
         }
         if(this.FHeroSkill)
         {
            this.FHeroSkill.SetSkillData(this.FCharacter.MainHero.Skills);
         }
      }
   }
}

