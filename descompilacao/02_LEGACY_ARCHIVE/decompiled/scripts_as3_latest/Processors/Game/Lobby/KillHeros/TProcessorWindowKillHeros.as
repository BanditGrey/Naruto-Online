package Processors.Game.Lobby.KillHeros
{
   import Components.Slots.*;
   import Externals.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Agent.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.KillHero.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Vip.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Lobby.Campaign.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowKillHeros extends TProcessorLobbyWindow
   {
      
      protected static const MAX_ICON_COUNT:int = 4;
      
      protected static const MAX_CAMP_COUNT:int = 5;
      
      protected static const POS_MIDDLE_X:int = 408;
      
      protected static const POS_MIDDLE_Y:int = 280;
      
      protected static const POS_LEFT_X:int = 334;
      
      protected static const POS_LEFT_Y:int = 290;
      
      protected static const POS_RIGHT_X:int = 496;
      
      protected static const POS_RIGHT_Y:int = 290;
      
      protected static const KILLHERO_CITYSTART_ID:int = 15120000;
      
      protected static const HINTTYPE_None:int = -1;
      
      protected static const HINTTYPE_Reset:int = 0;
      
      protected static const HINTTYPE_AllReset:int = 1;
      
      protected var FChangeCumPopFream:TUIWindowConfirmation;
      
      protected var FHelpTips:THint;
      
      protected var FRoles:Vector.<TActive>;
      
      protected var FScene:MovieClip;
      
      protected var FCurPage:int;
      
      protected var FTotlePage:int;
      
      protected var FMaxPage:int;
      
      protected var FCurKillHeroId:int;
      
      protected var FRewardCurPage:int;
      
      protected var FRewardTotlePage:int;
      
      protected var FKillHeroInfo:TKillHero;
      
      protected var FCurKillHeroInfo:TSingleKillHero;
      
      protected var FBackgroundBitmap:Bitmap;
      
      protected var FRoleModel:TBins;
      
      protected var FRaidersDailyConfigBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FHintType:int;
      
      protected var FHintBtnReset:THint;
      
      protected var FCostResetGold:uint;
      
      protected var Killhero_BackgroundId:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FIsInBattle:Boolean;
      
      protected var FCurChangeCustomsIndex:int;
      
      protected var FNiMeiDe:Vector.<TSingleKillHero>;
      
      protected var PassCount1:int;
      
      protected var FNimeiVector:Vector.<uint>;
      
      protected var TitleName:String;
      
      protected var FMC_GoTo_Fire:MovieClip;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      private var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FMC_GoTo_Fire_Tip:String;
      
      public function TProcessorWindowKillHeros(param1:TUIComponent)
      {
         super(param1);
         this.FHelpTips = new THint();
         this.FRoles = new Vector.<TActive>();
         this.FUISlots = new Vector.<TUISlot>(MAX_ICON_COUNT);
         this.FIDTemplates = new Vector.<uint>(MAX_ICON_COUNT);
         this.FNimeiVector = new Vector.<uint>(MAX_CAMP_COUNT);
         this.FNiMeiDe = new Vector.<TSingleKillHero>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FHintBtnReset = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.FHintType = -1;
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         this.FChangeCumPopFream = new TUIWindowConfirmation(this.Parent);
         this.FChangeCumPopFream.OnOK = this.WindowConfirmationOnOK;
         this.FChangeCumPopFream.x = (FUICore.StageWidth - this.FChangeCumPopFream.WindowWidth) / 2;
         this.FChangeCumPopFream.y = (FUICore.StageHeight - this.FChangeCumPopFream.WindowHeight) / 2;
         this.FIsInBattle = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_KILLHERO.RESOURCESID_KillHero);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         TUtilityUIWindow.SetupWindowConfirmation(this.FChangeCumPopFream);
         this.FChangeCumPopFream.SetCheckBox(false);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_KILLHERO.RESOURCE_ClassName_KillHero) as MovieClip;
         addChild(this.FScene);
         this.FMC_GoTo_Fire = this.FScene["MC_GoTo_Fire"];
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this.Parent);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Bitmap = null;
         var _loc5_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KILL_RESET_GOLD) as TConfigValue;
         this.FCostResetGold = _loc1_.Value as uint;
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FScene.tf_openTip.visible = false;
         this.FScene.mc_showIcon.btn_bestShow.addEventListener(MouseEvent.CLICK,this.OnBestClick);
         this.FScene.mc_showIcon.btn_firstShow.addEventListener(MouseEvent.CLICK,this.OnFirstClick);
         TGameUtil.setButtonMode(this.FScene.mc_showIcon.btn_left,true);
         this.FScene.mc_showIcon.btn_left.addEventListener(MouseEvent.CLICK,this.OnRewardLeftClick);
         TGameUtil.setButtonMode(this.FScene.mc_showIcon.btn_right,true);
         this.FScene.mc_showIcon.btn_right.addEventListener(MouseEvent.CLICK,this.OnRewardRightClick);
         TGameUtil.setButtonMode(this.FScene.btn_enter,true);
         this.FScene.btn_enter.addEventListener(MouseEvent.CLICK,this.OnFight);
         TGameUtil.setButtonMode(this.FScene.btn_reset,true);
         this.FScene.btn_reset.addEventListener(MouseEvent.CLICK,this.OnReset);
         TGameUtil.setButtonMode(this.FScene.btn_left,true);
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         TGameUtil.setButtonMode(this.FScene.btn_right,true);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         this.FScene.btn_myBag.addEventListener(MouseEvent.CLICK,this.OnSeeTreasure);
         TGameUtil.setMovieClipButton(this.FScene.btn_allreset,true);
         this.FScene.btn_allreset.addEventListener(MouseEvent.CLICK,this.OnAllReset);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.MOUSE_OVER,this.GoTo_FireBtnOver);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.MOUSE_OUT,this.GoTo_FireBtnOut);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.MOUSE_DOWN,this.GoTo_FireBtnDown);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.MOUSE_UP,this.GoTo_FireBtnUp);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.MOUSE_MOVE,this.GoTo_FireBtnMove);
         this.FMC_GoTo_Fire.addEventListener(MouseEvent.CLICK,this.GoTo_FireBtnClick);
         this.FScene.btn_reset.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_ResetOnMove,false,0,true);
         this.FScene.btn_reset.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_ResetOnOut,false,0,true);
         this.FScene.btn_allreset.addEventListener(MouseEvent.MOUSE_MOVE,this.Btn_ResetOnMove,false,0,true);
         this.FScene.btn_allreset.addEventListener(MouseEvent.MOUSE_OUT,this.Btn_ResetOnOut,false,0,true);
         this.FBackgroundBitmap = new Bitmap();
         this.FScene.mc_bg.addChild(this.FBackgroundBitmap);
         this.FScene.mc_bg["bitmap"] = this.FBackgroundBitmap;
         _loc2_ = 0;
         while(_loc2_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FScene.mc_list.list["mc_camp_" + _loc2_];
            _loc3_.tf_count.text = String(_loc2_ + 1);
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnSelectHero);
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.OnRollHero);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.OnRollHero);
            _loc3_.mc_highlight.visible = false;
            _loc4_ = new Bitmap();
            _loc3_.mc_icon.addChild(_loc4_);
            _loc3_.mc_icon["bitmap"] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < MAX_ICON_COUNT)
         {
            this.FUISlots[_loc2_] = this.GetSlot();
            this.FUISlots[_loc2_].Resource = this.FScene.mc_showIcon["mc_slot_" + _loc2_];
            this.FUISlots[_loc2_].Init();
            _loc2_++;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70109016) as TSystemLanguage;
         this.FMC_GoTo_Fire_Tip = _loc5_.Desc;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc1_.OnOverlay = this.FSlotsOnMove;
         _loc1_.OnOut = this.FSlotsOnOut;
         _loc1_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         return _loc1_;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_KillHeros);
         }
      }
      
      protected function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:TSingleKillHero = null;
         var _loc5_:TRaidersDailyConfig = null;
         var _loc6_:TRoleModel = null;
         if(this.FKillHeroInfo == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackgroundBitmap,CONST_MODULES.MODULE_KillHeros,this.Killhero_BackgroundId);
         _loc1_ = 0;
         while(_loc1_ < MAX_ICON_COUNT)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc2_ = this.FScene.mc_list.list["mc_camp_" + _loc1_];
            _loc3_ = (this.FCurPage - 1) * MAX_CAMP_COUNT + _loc1_;
            _loc4_ = this.FKillHeroInfo.KillHeroInfo[_loc3_];
            _loc5_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(_loc4_.KillHeroId) as TRaidersDailyConfig;
            _loc6_ = this.FRoleModel.GetDatebaseByIdentifier(_loc5_.HeroVect[0]) as TRoleModel;
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,_loc2_.mc_icon["bitmap"],CONST_MODULES.MODULE_KillHeros,_loc6_.RoleHead);
            _loc1_++;
         }
      }
      
      protected function UpdataRewardSlot() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = Math.min(this.FInventories.Count,MAX_ICON_COUNT);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUISlots[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_ + this.FRewardCurPage);
            _loc1_++;
         }
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:TActive = null;
         var _loc6_:TSingleKillHero = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:TRaidersDailyConfig = null;
         var _loc10_:TEnemy = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TRoleModel = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:TVipConfig = null;
         if(this.FRaidersDailyConfigBins == null)
         {
            this.FRaidersDailyConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RaidersDailyConfig);
         }
         if(this.FRoleModel == null)
         {
            this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         }
         if(this.FEnemyBins == null)
         {
            this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         }
         if(this.FCurKillHeroInfo == null)
         {
            return;
         }
         _loc9_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(this.FCurKillHeroInfo.KillHeroId) as TRaidersDailyConfig;
         this.Killhero_BackgroundId = int(_loc9_.PicPath.toString() + "0");
         this.FScene.mc_showIcon.tf_bestName.text = this.FCurKillHeroInfo.BestName;
         this.FScene.mc_showIcon.tf_firstName.text = this.FCurKillHeroInfo.FirstName;
         this.FScene.mc_showIcon.btn_bestShow.visible = Boolean(this.FCurKillHeroInfo.BestName.length > 0);
         this.FScene.mc_showIcon.btn_firstShow.visible = Boolean(this.FCurKillHeroInfo.FirstName.length > 0);
         this.TitleName = _loc9_.Name;
         this.FScene.tf_Name.text = this.TitleName;
         _loc4_ = int(this.FRoles.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc5_ = this.FRoles.pop();
            _loc5_.mouseEnabled = true;
            TPoolRole.SaveActive(_loc5_);
            _loc1_++;
         }
         _loc4_ = int(_loc9_.HeroVect.length);
         this.FScene.mc_name_0.visible = false;
         this.FScene.mc_name_1.visible = false;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc10_ = this.FEnemyBins.GetDatebaseByIdentifier(_loc9_.HeroVect[_loc1_]) as TEnemy;
            _loc12_ = this.FRoleModel.GetDatebaseByIdentifier(_loc10_.Identifier) as TRoleModel;
            _loc5_ = TPoolRole.GetActive(this,_loc12_.Model,CONST_MODULES.MODULE_KillHeros,true);
            _loc5_.mouseEnabled = false;
            if(_loc4_ == 2)
            {
               if(_loc1_ == 0)
               {
                  _loc5_.x = POS_LEFT_X;
                  _loc5_.y = POS_LEFT_Y;
               }
               else if(_loc1_ == 1)
               {
                  _loc5_.x = POS_RIGHT_X;
                  _loc5_.y = POS_RIGHT_Y;
               }
            }
            else
            {
               _loc5_.x = POS_MIDDLE_X;
               _loc5_.y = POS_MIDDLE_Y;
            }
            this.FScene["mc_name_" + _loc1_].visible = true;
            _loc8_ = _loc10_.Name;
            this.FScene["mc_name_" + _loc1_].tf_Name.text = _loc8_;
            this.FRoles.push(_loc5_);
            _loc1_++;
         }
         if(!this.FCurKillHeroInfo.IsTodayPass)
         {
            this.FScene.btn_enter.visible = true;
            this.FScene.btn_reset.visible = false;
         }
         else if(this.FCurKillHeroInfo.ResetCount < this.FVipData.DailyChaReset)
         {
            this.FScene.btn_enter.visible = false;
            this.FScene.btn_reset.visible = true;
            TGameUtil.setButtonMode(this.FScene.btn_reset,true);
         }
         else
         {
            this.FScene.btn_enter.visible = false;
            this.FScene.btn_reset.visible = Boolean(this.FVipData.VipLevel < this.FVipData.VipOpenLevel_DailyChaReset);
            TGameUtil.setButtonMode(this.FScene.btn_reset,false);
         }
         _loc13_ = 0;
         this.PassCount1 = 0;
         this.FNiMeiDe.length = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FScene.mc_list.list["mc_camp_" + _loc1_];
            _loc7_ = (this.FCurPage - 1) * MAX_CAMP_COUNT + _loc1_;
            _loc6_ = this.FKillHeroInfo.KillHeroInfo[_loc7_];
            this.FNimeiVector[_loc1_] = 0;
            if(_loc7_ <= this.FKillHeroInfo.NewKillHeroIndex)
            {
               _loc3_.mc_lock.visible = false;
               _loc3_.buttonMode = true;
               _loc3_.mc_pass.visible = _loc6_.IsPassed;
               if(_loc3_.mc_pass.visible)
               {
                  _loc13_++;
               }
               if(_loc6_.KillHeroId == this.FCurKillHeroId)
               {
                  this.FCurChangeCustomsIndex = _loc1_;
                  _loc3_.mc_select.visible = true;
               }
               else
               {
                  _loc3_.mc_select.visible = false;
               }
               if(_loc6_.KillHeroId >= this.FCurKillHeroId)
               {
                  if(!_loc6_.IsTodayPass)
                  {
                     ++this.PassCount1;
                     if(this.PassCount1 * 3 <= this.FCharacter.CreditMilitaryOrders)
                     {
                        this.FNiMeiDe.push(_loc6_);
                        this.FNimeiVector[_loc1_] = _loc6_.HeroIds[0];
                     }
                     else
                     {
                        --this.PassCount1;
                     }
                  }
               }
               if(_loc6_.IsTodayPass)
               {
                  _loc3_.mc_icon.filters = [TGameUtil.rBlackFilters];
               }
               else
               {
                  _loc3_.mc_icon.filters = [];
               }
            }
            else
            {
               _loc3_.mc_lock.visible = true;
               _loc3_.buttonMode = false;
               _loc3_.mc_pass.visible = false;
               _loc3_.mc_select.visible = false;
               _loc3_.mc_icon.filters = [TGameUtil.rBlackFilters];
            }
            _loc1_++;
         }
         _loc15_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,this.FVipData.VipLevel) as TVipConfig;
         if(_loc13_ >= MAX_CAMP_COUNT && this.PassCount1 > 0)
         {
            this.FMC_GoTo_Fire.visible = true;
            this.FMC_GoTo_Fire.buttonMode = true;
            if(_loc15_.ContinuousChallenge)
            {
               this.FMC_GoTo_Fire.gotoAndStop(1);
            }
            else
            {
               this.FMC_GoTo_Fire.gotoAndStop(4);
            }
         }
         else
         {
            this.FMC_GoTo_Fire.visible = false;
            this.FMC_GoTo_Fire.buttonMode = false;
         }
         this.FIDTemplates = _loc9_.RaiderAwards;
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         this.FRewardCurPage = 0;
         this.FRewardTotlePage = this.FInventories.Count - MAX_ICON_COUNT + 1;
         this.CheckRewardBtn();
         this.UpdataRewardSlot();
         _loc11_ = this.GetCanResetKillHeroIds();
         this.FScene.btn_allreset.visible = Boolean(_loc11_.length > 0);
         TGameUtil.setButtonMode(this.FScene.btn_allreset,this.FVipData.VipLevel >= this.FVipData.VipOpenLevel_DailyChaReset);
      }
      
      public function NimeiDeReflash(param1:Vector.<uint>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this.FNiMeiDe.length)
            {
               if(this.FNiMeiDe[_loc2_].KillHeroId == param1[_loc3_])
               {
                  ++this.FNiMeiDe[_loc2_].EnterCount;
                  break;
               }
               _loc2_++;
            }
            _loc3_++;
         }
         this.UpdataUI();
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_KillHeros_AutoFire);
         _loc3_ = _loc2_.Data;
         _loc3_.writeInt(KILLHERO_CITYSTART_ID + this.FCurPage);
         _loc3_.writeInt(this.FCurKillHeroId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function GoTo_FireBtnOver(param1:MouseEvent) : void
      {
         if(this.FMC_GoTo_Fire.currentFrame == 4)
         {
            return;
         }
         this.FMC_GoTo_Fire.gotoAndStop(2);
      }
      
      protected function GoTo_FireBtnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
         if(this.FMC_GoTo_Fire.currentFrame == 4)
         {
            return;
         }
         this.FMC_GoTo_Fire.gotoAndStop(1);
      }
      
      protected function GoTo_FireBtnDown(param1:MouseEvent) : void
      {
         if(this.FMC_GoTo_Fire.currentFrame == 4)
         {
            return;
         }
         this.FMC_GoTo_Fire.gotoAndStop(3);
      }
      
      protected function GoTo_FireBtnUp(param1:MouseEvent) : void
      {
         if(this.FMC_GoTo_Fire.currentFrame == 4)
         {
            return;
         }
         this.FMC_GoTo_Fire.gotoAndStop(2);
      }
      
      protected function GoTo_FireBtnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintBtnReset.Caption = this.FMC_GoTo_Fire_Tip;
            this.FHintOnMove(param1,this.FHintBtnReset);
         }
      }
      
      protected function GoTo_FireBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSystemLanguage = null;
         var _loc4_:TEnemy = null;
         if(this.FMC_GoTo_Fire.currentFrame == 4)
         {
            return;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70109015) as TSystemLanguage;
         var _loc5_:String = "";
         _loc2_ = 0;
         while(_loc2_ < MAX_CAMP_COUNT)
         {
            if(this.FNimeiVector[_loc2_] != 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Enemy,this.FNimeiVector[_loc2_]) as TEnemy;
               _loc5_ += TUtilityString.Format(STRING_KILLHERO.KILLHERO_0,_loc2_ + 1,_loc4_.Name);
            }
            _loc2_++;
         }
         this.FChangeCumPopFream.Text = TUtilityString.Format(_loc3_.Desc,this.TitleName,_loc5_,this.PassCount1 * 3);
         this.FChangeCumPopFream.Visible = true;
      }
      
      protected function CheckRewardBtn() : void
      {
         this.FScene.mc_showIcon.btn_left.visible = Boolean(this.FRewardCurPage != 0);
         this.FScene.mc_showIcon.btn_right.visible = Boolean(this.FRewardCurPage != this.FRewardTotlePage - 1);
      }
      
      protected function CheckBtn() : void
      {
         var _loc1_:String = null;
         var _loc2_:TSingleKillHero = null;
         var _loc3_:TRaidersDailyConfig = null;
         var _loc4_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.btn_left.visible = Boolean(this.FCurPage != 1);
         this.FScene.btn_right.visible = Boolean(this.FCurPage != this.FTotlePage);
         this.FScene.tf_openTip.visible = Boolean(this.FCurPage == this.FTotlePage);
         if(this.FCurPage >= this.FMaxPage)
         {
            this.FScene.tf_openTip.visible = false;
         }
         else
         {
            _loc4_ = (this.FCurPage + 1) * MAX_CAMP_COUNT - 1;
            this.FScene.tf_openTip.visible = Boolean(this.FCurPage == this.FTotlePage);
            if(this.FCurPage == this.FTotlePage)
            {
               _loc2_ = this.FKillHeroInfo.KillHeroInfo[_loc4_];
               _loc3_ = this.FRaidersDailyConfigBins.GetDatebaseByIdentifier(_loc2_.KillHeroId) as TRaidersDailyConfig;
               if(_loc3_.Level < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
               {
                  _loc1_ = STRING_KILLHERO.KILLHERO_OPENTIP;
                  _loc1_ = _loc1_.split("%level%").join(_loc3_.Level);
                  this.FScene.tf_openTip.text = _loc1_;
               }
               else
               {
                  _loc1_ = STRING_KILLHERO.KILLHERO_OPENTIPCopy;
                  _loc1_ = _loc1_.split("%level%").join(STRING_COMMON.GetLevelStrByLevelLineFeed(_loc3_.Level));
                  this.FScene.tf_openTip.text = _loc1_;
               }
            }
         }
      }
      
      protected function GetCanResetKillHeroIds() : Vector.<uint>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleKillHero = null;
         var _loc4_:Vector.<uint> = null;
         _loc4_ = new Vector.<uint>();
         _loc2_ = int(this.FCurKillHeroId / 10) * 10 + 1;
         _loc1_ = 0;
         while(_loc1_ < MAX_CAMP_COUNT)
         {
            _loc3_ = this.FKillHeroInfo.KillHeroInfo[(this.FCurPage - 1) * MAX_CAMP_COUNT + _loc1_];
            if(_loc3_.IsTodayPass && _loc3_.ResetCount < this.FVipData.DailyChaReset)
            {
               _loc4_.push(_loc3_.KillHeroId);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function Btn_ResetOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Vector.<uint> = null;
         _loc2_ = "";
         if(param1.currentTarget.name == "btn_reset")
         {
            if(this.FHintType != HINTTYPE_Reset)
            {
               this.FHintType = HINTTYPE_Reset;
               if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
               {
                  _loc2_ = STRING_KILLHERO.KILLHERO_RESET_TIP;
                  _loc2_ = _loc2_.split("%count%").join(this.FCostResetGold);
                  this.FHintBtnReset.Caption = _loc2_;
               }
               else
               {
                  _loc2_ = STRING_COMMON.COMMON_OPENVIPTIP;
                  _loc2_ = _loc2_.split("%count%").join(this.FVipData.VipOpenLevel_DailyChaReset);
                  this.FHintBtnReset.Caption = _loc2_;
               }
            }
         }
         else if(param1.currentTarget.name == "btn_allreset")
         {
            if(this.FHintType != HINTTYPE_AllReset)
            {
               this.FHintType = HINTTYPE_AllReset;
               if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.buttonMode))
               {
                  _loc3_ = this.GetCanResetKillHeroIds();
                  _loc2_ = STRING_KILLHERO.KILLHERO_RESETALL_TIP;
                  _loc2_ = _loc2_.split("%count%").join(this.FCostResetGold * _loc3_.length);
                  this.FHintBtnReset.Caption = _loc2_;
               }
               else
               {
                  _loc2_ = STRING_COMMON.COMMON_OPENVIPTIP;
                  _loc2_ = _loc2_.split("%count%").join(this.FVipData.VipOpenLevel_DailyChaReset);
                  this.FHintBtnReset.Caption = _loc2_;
               }
            }
         }
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBtnReset);
         }
      }
      
      protected function Btn_ResetOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
         this.FHintType = -1;
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
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_KillHeros) as TSystemLanguage;
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
      
      protected function OnBestClick(param1:MouseEvent) : void
      {
         if(this.FCurKillHeroInfo == null)
         {
            return;
         }
         SExternalCore.NavigateToFightReport(this.FCurKillHeroInfo.BestId);
      }
      
      protected function OnFirstClick(param1:MouseEvent) : void
      {
         if(this.FCurKillHeroInfo == null)
         {
            return;
         }
         SExternalCore.NavigateToFightReport(this.FCurKillHeroInfo.FirstId);
      }
      
      protected function OnFight(param1:MouseEvent) : void
      {
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.StartFight();
         }
      }
      
      protected function StartFight() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(SLogicsCore.Character.CreditMilitaryOrders + SLogicsCore.Character.CreditMilitaryOrdersBuff < this.FKillHeroInfo.NeedMilitaryOrder)
         {
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_InsufficientMobility);
            }
            EffectGenerateText(STRING_COMMON.NOTENOUGH_Military);
            return;
         }
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Hurdle);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(KILLHERO_CITYSTART_ID + this.FCurPage);
         _loc2_.writeInt(this.FCurKillHeroId);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         ProcessorWindowClose();
         TutorialNextStep(1200);
         this.FIsInBattle = true;
      }
      
      protected function OnReset(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FUIWindowConfirmation.OnOK = this.ConfirmOnOk;
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_KillHero_Reset).DescribeString,this.FCostResetGold);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.ConfirmOnOk();
         }
      }
      
      protected function ConfirmOnOk(param1:Object = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostResetGold)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_KillHeros_ResetReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(HINTTYPE_Reset);
         _loc3_.writeInt(this.FCurKillHeroId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnRewardLeftClick(param1:MouseEvent) : void
      {
         --this.FRewardCurPage;
         if(this.FRewardCurPage < 0)
         {
            this.FRewardCurPage = 0;
         }
         this.CheckRewardBtn();
         this.UpdataRewardSlot();
      }
      
      protected function OnRewardRightClick(param1:MouseEvent) : void
      {
         ++this.FRewardCurPage;
         if(this.FRewardCurPage > this.FRewardTotlePage - 1)
         {
            this.FRewardCurPage = this.FRewardTotlePage - 1;
         }
         this.CheckRewardBtn();
         this.UpdataRewardSlot();
      }
      
      protected function OnLeft(param1:MouseEvent) : void
      {
         this.FScene.mc_list.play();
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.FCurKillHeroInfo = this.FKillHeroInfo.KillHeroInfo[(this.FCurPage - 1) * MAX_CAMP_COUNT - 1 + MAX_CAMP_COUNT];
         this.FCurKillHeroId = this.FCurKillHeroInfo.KillHeroId;
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FScene.mc_list.play();
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         _loc2_ = Math.min(this.FCurPage * MAX_CAMP_COUNT - 1,this.FKillHeroInfo.NewKillHeroIndex);
         this.FCurKillHeroInfo = this.FKillHeroInfo.KillHeroInfo[_loc2_];
         this.FCurKillHeroId = this.FCurKillHeroInfo.KillHeroId;
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnSeeTreasure(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Function,CONST_SHORTCUTS.TYPE_Function_Treasure);
         }
      }
      
      protected function OnAllReset(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<uint> = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = this.GetCanResetKillHeroIds();
         this.FUIWindowConfirmation.OnOK = this.ConfirmAllOnOk;
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_KillHero_Reset_All).DescribeString,this.FCostResetGold * _loc2_.length);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.ConfirmAllOnOk();
         }
      }
      
      protected function ConfirmAllOnOk(param1:Object = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:Vector.<uint> = null;
         _loc4_ = this.GetCanResetKillHeroIds();
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostResetGold * _loc4_.length)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_KillHeros_ResetReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(HINTTYPE_AllReset);
         _loc3_.writeInt(KILLHERO_CITYSTART_ID + this.FCurPage);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnRollHero(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            _loc2_.mc_highlight.visible = true;
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            _loc2_.mc_highlight.visible = false;
         }
      }
      
      protected function OnSelectHero(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         _loc3_ = (this.FCurPage - 1) * MAX_CAMP_COUNT + _loc2_;
         if(_loc3_ > this.FKillHeroInfo.NewKillHeroIndex)
         {
            return;
         }
         this.FCurKillHeroInfo = this.FKillHeroInfo.KillHeroInfo[_loc3_];
         this.FCurKillHeroId = this.FCurKillHeroInfo.KillHeroId;
         this.UpdataUI();
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_KillHero);
         this.FUIWindowBattleSkip.IsClickSkip = true;
         this.StartFight();
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_KillHero);
         this.FUIWindowBattleSkip.IsClickSkip = false;
         this.StartFight();
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
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
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get IsInBattle() : Boolean
      {
         return this.FIsInBattle;
      }
      
      public function set IsInBattle(param1:Boolean) : void
      {
         this.FIsInBattle = param1;
      }
      
      public function SetKillHeroData(param1:TKillHero, param2:Boolean = false, param3:uint = 0) : void
      {
         var _loc4_:int = 0;
         this.FKillHeroInfo = param1;
         _loc4_ = this.FKillHeroInfo.NewKillHeroIndex;
         this.FMaxPage = this.FKillHeroInfo.KillHeroInfo.length / MAX_CAMP_COUNT;
         this.FTotlePage = int(_loc4_ / MAX_CAMP_COUNT) + 1;
         if(!param2)
         {
            this.FCurPage = this.FTotlePage;
         }
         if(param3 != 0)
         {
            this.FCurKillHeroInfo = this.FKillHeroInfo.GetSingleKillHeroById(param3);
            this.FCurKillHeroId = param3;
            this.FCurPage = int(this.FKillHeroInfo.GetIndexById(param3) / MAX_CAMP_COUNT) + 1;
         }
         else if(!param2)
         {
            this.FCurKillHeroInfo = this.FKillHeroInfo.KillHeroInfo[_loc4_];
            this.FCurKillHeroId = this.FCurKillHeroInfo.KillHeroId;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function Updata() : void
      {
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function UpdataRole() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         _loc2_ = int(this.FRoles.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRoles[_loc1_];
            _loc3_.UpdateActive();
            _loc1_++;
         }
         this.UpdataBitmap();
      }
      
      public function ReloadRole() : void
      {
         this.UpdataUI();
      }
      
      public function ResetKillHeroData(param1:Vector.<uint>) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.FKillHeroInfo.ResetHero(param1[_loc2_]);
            _loc2_++;
         }
         this.SetKillHeroData(this.FKillHeroInfo,true);
         this.FHintType = HINTTYPE_None;
      }
      
      public function Releasing() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         _loc2_ = int(this.FRoles.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRoles.pop();
            _loc3_.mouseEnabled = true;
            TPoolRole.SaveActive(_loc3_);
            _loc1_++;
         }
      }
   }
}

