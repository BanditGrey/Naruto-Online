package Processors.Game.Lobby.DailyActivity
{
   import Foundation.Common.*;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Common.Effects.Display.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.HelpTips.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   public class TProcessorDailyActivity extends TProcessorLobbyWindows
   {
      
      public static const SIZE_WindowDailyActivity_Width:uint = 807;
      
      public static const SIZE_WindowDailyActivity_Height:uint = 569;
      
      public static const MAX_COUNT:uint = 6;
      
      public static const ID_Database_Start:uint = 70200001;
      
      public static const BtnStatus_BeforeOpen:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_NotOpen;
      
      public static const BtnStatus_Join:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_SignUp;
      
      public static const BtnStatus_Open:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Battle;
      
      public static const BtnStatus_EndOpen:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_End;
      
      public static const BtnStatus_Added:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_Added;
      
      public static const BtnStatus_EndJoin:uint = CONST_ORGANIZATION.STATUS_ORGACTIVITY_EndJoin;
      
      public static const TYPE_ORGACTIVITY_MUYEGUARD:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEGUARD;
      
      public static const TYPE_ORGACTIVITY_PETBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_PETBATTLE;
      
      public static const TYPE_ORGACTIVITY_MUYEBATTLE:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_MUYEBATTLE;
      
      public static const TYPE_ORGACTIVITY_YUZHIBO:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_YUZHIBO;
      
      public static const TYPE_ORGACTIVITY_RIXIANG:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_RIXIANG;
      
      public static const TYPE_ORGACTIVITY_QIANSHOU:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_QIANSHOU;
      
      public static const TYPE_ORGACTIVITY_TRAITORATTACK:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_TRAITORATTACK;
      
      public static const TYPE_ORGACTIVITY_AnimalSeal:uint = CONST_ORGANIZATION.TYPE_ORGACTIVITY_AnimalSeal;
      
      public static const FilterColor:uint = 16776960;
      
      public static const FilterGlowWidth:int = 4;
      
      public static const FilterGlowStrength:int = 20;
      
      public static const ButtonStateVect:Vector.<String> = STRING_COMMON.STRING_ButtonStateVect;
      
      protected var FScene:MovieClip;
      
      protected var FBoundsDailyActivity:TBounds;
      
      protected var FSelectTabIndex:uint;
      
      protected var FCurBtnStatus:uint;
      
      protected var FBtn_AutoJoin:MovieClip;
      
      protected var FMC_HelpTip:MovieClip;
      
      protected var FMC_AutoJoin:MovieClip;
      
      protected var FTF_AutoJoining:TextField;
      
      protected var FTF_VipConfig:TextField;
      
      protected var FDailyActivityBins:TBins;
      
      protected var FCharacter:TCharacter;
      
      protected var FActivityStatusVect:Vector.<uint>;
      
      protected var FIsPetBattleCanJoin:Boolean;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FHelpHint:THint;
      
      protected var FAutoJoinHelpHint:THint;
      
      protected var FSystemLanguage_1:TSystemLanguage;
      
      protected var FSystemLanguage_2:TSystemLanguage;
      
      protected var FConfigValue_1:TConfigValue;
      
      protected var FConfigValue_2:TConfigValue;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FAutoHangUpStatusVec:Vector.<uint>;
      
      protected var FAutoSignVec:Vector.<MovieClip>;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FOnEnterFightPet:Function;
      
      protected var FOnEnterOrganizationWar:Function;
      
      protected var FOnJoinOrganizationWar:Function;
      
      protected var FOnEnterCityDefend:Function;
      
      protected var FOnEnterTraitorAttack:Function;
      
      protected var FOnShortcutEffect:Function;
      
      protected var FOnTraitorAttackEnd:Function;
      
      protected var FOnAutoHangUpStatusReq:Function;
      
      public function TProcessorDailyActivity(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBoundsDailyActivity = new TBounds();
         this.FBoundsDailyActivity.Width = SIZE_WindowDailyActivity_Width;
         this.FBoundsDailyActivity.Height = SIZE_WindowDailyActivity_Height;
         ComponentBoundsCenter(this,this.FBoundsDailyActivity);
         this.FCurBtnStatus = BtnStatus_BeforeOpen;
         this.FCharacter = SLogicsCore.Character;
         this.FActivityStatusVect = Vector.<uint>([BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen,BtnStatus_BeforeOpen]);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FAutoSignVec = new Vector.<MovieClip>();
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         this.FUIWindowRecharge.Visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DailyActivity.RESOURCE_DailyActivity);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         var _loc5_:TVipConfig = null;
         var _loc6_:TBins = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DailyActivity.RESOURCE_ClassName_MC_DailyActivity) as MovieClip;
         addChild(this.FScene);
         if(this.FScene.mc_lock != null)
         {
            this.FScene.mc_lock.visible = false;
         }
         this.FDailyActivityBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyActivity);
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = new TEffectBaseGlowTwo();
            _loc2_.SetParameters(this.FScene["mc_tab_" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FSelectTabIndex = 0;
         this.UpdataUI();
         this.FTF_AutoJoining = this.FScene["tf_autojoining"];
         this.FTF_AutoJoining.visible = false;
         this.FScene["mc_joinConfig"]["tf_vipConfig"].visible = false;
         this.FBtn_AutoJoin = this.FScene["mc_joinConfig"]["mc_autoJoin"]["Btn_AutoJoin"];
         this.FMC_HelpTip = this.FScene["mc_joinConfig"]["mc_autoJoin"]["MC_HelpTip"];
         this.FMC_AutoJoin = this.FScene["mc_joinConfig"]["mc_autoJoin"];
         this.FTF_VipConfig = this.FScene["mc_joinConfig"]["tf_vipConfig"];
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig) as TBins;
         _loc3_ = uint(_loc6_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = _loc6_.GetDatebaseByIndex(_loc1_) as TVipConfig;
            if(Boolean(_loc5_.AutoJoinActivity))
            {
               break;
            }
            _loc1_++;
         }
         this.FTF_VipConfig.text = TUtilityString.Format(STRING_DAILYACTIVITY.STRING_VipOpen,_loc5_.Identifier);
         _loc3_ = MAX_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            this.FAutoSignVec[_loc1_] = this.FScene["MC_AutoSign_" + _loc1_] as MovieClip;
            this.FAutoSignVec[_loc1_].visible = false;
            _loc1_++;
         }
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
         this.FSystemLanguage_1 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.AutoJoinActivity_1) as TSystemLanguage;
         this.FSystemLanguage_2 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.AutoJoinActivity_2) as TSystemLanguage;
         this.FConfigValue_1 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.FIGHTPET_AutoJoinCost) as TConfigValue;
         this.FConfigValue_2 = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TraitorAttack_AutoJoinCost) as TConfigValue;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TSystemLanguage = null;
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnCloseWindow);
         this.FScene.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintHelpMove);
         this.FScene.btn_help.addEventListener(MouseEvent.ROLL_OUT,this.OnHintHelpOut);
         this.FScene.btn_join.addEventListener(MouseEvent.CLICK,this.OnFunctionBtnClick);
         TGameUtil.setButtonMode(this.FScene.btn_join,true);
         this.FScene.btn_join.mc_btnInfo.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ < this.FDailyActivityBins.Count)
            {
               this.FScene["mc_tab_" + _loc1_].visible = true;
               this.FScene["mc_tab_" + _loc1_].gotoAndStop(_loc1_ + 1);
               TGameUtil.setButtonMode(this.FScene["mc_tab_" + _loc1_].mc_btn,true);
               this.FScene["mc_tab_" + _loc1_].addEventListener(MouseEvent.CLICK,this.OnTabBtnClick);
            }
            else
            {
               this.FScene["mc_tab_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FHelpHint = new THint();
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_DAILYACTIVITION) as TSystemLanguage;
         this.FHelpHint.Content = _loc2_.Desc;
         this.FAutoJoinHelpHint = new THint();
         FOverlayerHelpTips = new TOverlayerHelpTips(FParent);
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FBtn_AutoJoin.addEventListener(MouseEvent.CLICK,this.SelectOnClick,false,0,true);
         this.FMC_HelpTip.addEventListener(MouseEvent.MOUSE_MOVE,this.HelpTipOnMove,false,0,true);
         this.FMC_HelpTip.addEventListener(MouseEvent.MOUSE_OUT,this.OnHintHelpOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.UpdateTabEffect();
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TDailyActivity = null;
         if(this.FScene == null)
         {
            return;
         }
         if(this.FSelectTabIndex > this.FDailyActivityBins.Count)
         {
            this.FSelectTabIndex = 0;
         }
         this.FScene.mc_select.x = this.FScene["mc_tab_" + this.FSelectTabIndex].x;
         this.FScene.mc_select.y = this.FScene["mc_tab_" + this.FSelectTabIndex].y;
         _loc2_ = this.FDailyActivityBins.GetDatebaseByIdentifier(ID_Database_Start + this.FSelectTabIndex) as TDailyActivity;
         this.FScene.mc_baseInfo.tf_name.text = _loc2_.ActivityName;
         this.FScene.mc_baseInfo.tf_timeDesc.text = _loc2_.ActivityTimeVect[0];
         this.FScene.mc_baseInfo.tf_time.text = _loc2_.ActivityTimeVect[1];
         this.FScene.tf_desc.text = _loc2_.ActivityDescription;
         this.FScene.tf_awardDesc.text = _loc2_.ActivityRewards;
         this.FScene.mc_bg.gotoAndStop(this.FSelectTabIndex + 1);
         if(this.FSelectTabIndex < TYPE_ORGACTIVITY_PETBATTLE)
         {
            this.FScene.mc_bg.mc_family.gotoAndStop(this.FSelectTabIndex + 1);
         }
         this.FIsPetBattleCanJoin = true;
         if(_loc2_.ActivityType == TYPE_ORGACTIVITY_PETBATTLE)
         {
            this.FCurBtnStatus = this.FActivityStatusVect[TYPE_ORGACTIVITY_YUZHIBO + this.FSelectTabIndex];
            if(this.FActivityStatusVect[TYPE_ORGACTIVITY_YUZHIBO + this.FCharacter.Country - 1] == BtnStatus_Open)
            {
               this.FIsPetBattleCanJoin = false;
            }
         }
         else
         {
            this.FCurBtnStatus = this.FActivityStatusVect[_loc2_.ActivityType];
         }
         this.FScene.btn_join.mc_btnInfo.tf_btnInfo.text = ButtonStateVect[this.FCurBtnStatus];
         TGameUtil.setButtonMode(this.FScene.btn_join,this.CheckStatusIsBtn());
         this.FScene.mc_tabPage.visible = false;
      }
      
      protected function CheckTabEffect() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            if(_loc1_ == 0)
            {
               _loc2_ = _loc1_ + TYPE_ORGACTIVITY_YUZHIBO;
            }
            else if(_loc1_ == 3)
            {
               _loc2_ = TYPE_ORGACTIVITY_MUYEBATTLE;
            }
            else if(_loc1_ == 4)
            {
               _loc2_ = TYPE_ORGACTIVITY_MUYEGUARD;
            }
            else if(_loc1_ == 5)
            {
               _loc2_ = TYPE_ORGACTIVITY_TRAITORATTACK;
            }
            if(this.FActivityStatusVect[_loc2_] == BtnStatus_Open || this.FActivityStatusVect[_loc2_] == BtnStatus_Join)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         if(this.FGlowsFilter == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function CheckStatusIsBtn() : Boolean
      {
         if(!this.FIsPetBattleCanJoin && this.FCharacter.Country - 1 != this.FSelectTabIndex)
         {
            return false;
         }
         if(this.FCurBtnStatus == BtnStatus_Open || this.FCurBtnStatus == BtnStatus_Join)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateAutoJoin() : Boolean
      {
         var _loc1_:TVipConfig = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,SLogicsCore.Character.VipLevel) as TVipConfig;
         if(this.FSelectTabIndex != 0 && this.FSelectTabIndex != 1 && this.FSelectTabIndex != 2 && this.FSelectTabIndex != 5)
         {
            this.FTF_VipConfig.visible = false;
            this.FMC_AutoJoin.visible = false;
         }
         else if(Boolean(_loc1_.AutoJoinActivity))
         {
            this.FTF_VipConfig.visible = false;
            this.FMC_AutoJoin.visible = true;
         }
         else
         {
            this.FMC_AutoJoin.visible = false;
            this.FTF_VipConfig.visible = true;
         }
         return this.FTF_VipConfig.visible;
      }
      
      protected function OnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnFunctionBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:TDailyActivity = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = this.FDailyActivityBins.GetDatebaseByIdentifier(ID_Database_Start + this.FSelectTabIndex) as TDailyActivity;
         switch(_loc2_.ActivityType)
         {
            case TYPE_ORGACTIVITY_PETBATTLE:
               if(this.FOnEnterFightPet != null)
               {
                  this.FOnEnterFightPet(this,this.FSelectTabIndex + 1);
               }
               break;
            case TYPE_ORGACTIVITY_MUYEBATTLE:
               if(this.FActivityStatusVect[TYPE_ORGACTIVITY_MUYEBATTLE] == BtnStatus_Join)
               {
                  if(this.FOnJoinOrganizationWar != null)
                  {
                     this.FOnJoinOrganizationWar(this,CONST_ORGANIZATIONALWAR.CommandID_SignUp,0,null);
                  }
               }
               else if(this.FOnEnterOrganizationWar != null)
               {
                  this.FOnEnterOrganizationWar(this);
               }
               break;
            case TYPE_ORGACTIVITY_MUYEGUARD:
               if(this.FOnEnterCityDefend != null)
               {
                  this.FOnEnterCityDefend(this);
               }
               break;
            case TYPE_ORGACTIVITY_TRAITORATTACK:
               if(this.FOnEnterTraitorAttack != null)
               {
                  this.FOnEnterTraitorAttack(this);
               }
         }
         ProcessorClose();
      }
      
      protected function OnTabBtnClick(param1:MouseEvent) : void
      {
         this.FSelectTabIndex = int(String(param1.target.parent.name).slice(7));
         this.UpdataUI();
         if(!this.UpdateAutoJoin())
         {
            this.UpdateActivityUI();
         }
      }
      
      protected function GetDailyActivity() : int
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityStatusVect.length)
         {
            if(this.FActivityStatusVect[_loc1_] == BtnStatus_Open || this.FActivityStatusVect[_loc1_] == BtnStatus_Join)
            {
               if(_loc1_ == TYPE_ORGACTIVITY_TRAITORATTACK)
               {
                  return 5;
               }
               if(_loc1_ >= TYPE_ORGACTIVITY_YUZHIBO)
               {
                  if(this.FActivityStatusVect[TYPE_ORGACTIVITY_YUZHIBO + this.FCharacter.Country - 1] == BtnStatus_Open)
                  {
                     return this.FCharacter.Country - 1;
                  }
                  return _loc1_ - TYPE_ORGACTIVITY_YUZHIBO;
               }
               if(_loc1_ == TYPE_ORGACTIVITY_MUYEGUARD)
               {
                  return 4;
               }
               if(_loc1_ == TYPE_ORGACTIVITY_MUYEBATTLE)
               {
                  return 3;
               }
            }
            _loc1_++;
         }
         return -1;
      }
      
      protected function OnHintHelpMove(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Context = this.FHelpHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function OnHintHelpOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function HelpTipOnMove(param1:MouseEvent) : void
      {
         if(this.FAutoJoinHelpHint.Content == null)
         {
            return;
         }
         FOverlayerHelpTips.Context = this.FAutoJoinHelpHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function SelectOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.FBtn_AutoJoin.currentFrame == 2)
         {
            EffectGenerateText(STRING_DAILYACTIVITY.STRING_NoCancel);
            return;
         }
         if(this.FSelectTabIndex == 0 || this.FSelectTabIndex == 1 || this.FSelectTabIndex == 2)
         {
            _loc2_ = this.FConfigValue_1.Value as uint;
         }
         else if(this.FSelectTabIndex == 5)
         {
            _loc2_ = this.FConfigValue_2.Value as uint;
         }
         if(_loc2_ > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.FUIWindowRecharge.Visible = false;
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyActive_AutoJoin).DescribeString,_loc2_);
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Automate_OperateReq);
         _loc3_ = _loc2_.Data;
         if(this.FSelectTabIndex == this.FCharacter.Country - 1)
         {
            _loc4_ = CONST_AUTOHANGUP.INDEX_PetBattle + 1;
         }
         else
         {
            _loc4_ = CONST_AUTOHANGUP.INDEX_TraitorAttack + 1;
         }
         _loc3_.writeByte(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function UpdateActivityUI() : void
      {
         if(this.FAutoHangUpStatusVec == null)
         {
            return;
         }
         this.CheckAutoSignShow();
         this.CheckPetBattle();
         this.CheckTraitorAttack();
         this.CheckOtherDailyActivity();
      }
      
      protected function CheckCountry(param1:int) : Boolean
      {
         if(param1 == 0 || param1 == 1 || param1 == 2)
         {
            return true;
         }
         return false;
      }
      
      protected function CheckAutoSignShow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = MAX_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FAutoSignVec[_loc1_].visible = false;
            if(this.FAutoHangUpStatusVec[CONST_AUTOHANGUP.INDEX_PetBattle] == 1)
            {
               this.FAutoSignVec[_loc1_].visible = this.CheckCountry(_loc1_);
            }
            if(this.FAutoHangUpStatusVec[CONST_AUTOHANGUP.INDEX_TraitorAttack] == 1)
            {
               if(_loc1_ == 5)
               {
                  this.FAutoSignVec[_loc1_].visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function CheckPetBattle() : void
      {
         var _loc1_:TAutoActivityGain = null;
         if(this.FSelectTabIndex == 0 || this.FSelectTabIndex == 1 || this.FSelectTabIndex == 2)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AutoActivityGain,this.FCharacter.GetMainLevel()) as TAutoActivityGain;
            this.FAutoJoinHelpHint.Content = TUtilityString.Format(this.FSystemLanguage_1.Desc,this.FConfigValue_1.Value,_loc1_.MonsterCoin,_loc1_.MonsterExp);
            if(this.FAutoHangUpStatusVec[CONST_AUTOHANGUP.INDEX_PetBattle] == 1)
            {
               this.FMC_AutoJoin.filters = [TGameUtil.GaryColorFilters];
               this.FBtn_AutoJoin.gotoAndStop(2);
               this.FBtn_AutoJoin.mouseEnabled = false;
               this.FBtn_AutoJoin.mouseChildren = false;
               if(this.FActivityStatusVect[TYPE_ORGACTIVITY_YUZHIBO + this.FSelectTabIndex] == BtnStatus_Open)
               {
                  this.FMC_AutoJoin.visible = true;
                  this.FScene.btn_join.visible = false;
                  this.FTF_AutoJoining.visible = true;
               }
               else
               {
                  this.FScene.btn_join.visible = true;
                  this.FTF_AutoJoining.visible = false;
                  if(this.FSelectTabIndex == this.FCharacter.Country - 1)
                  {
                     this.FMC_AutoJoin.visible = true;
                  }
                  else
                  {
                     this.FMC_AutoJoin.visible = false;
                  }
               }
            }
            else
            {
               this.FScene.btn_join.visible = true;
               this.FTF_AutoJoining.visible = false;
               this.FBtn_AutoJoin.gotoAndStop(1);
               if(this.FActivityStatusVect[TYPE_ORGACTIVITY_PETBATTLE] == BtnStatus_Open)
               {
                  this.FMC_AutoJoin.filters = [TGameUtil.GaryColorFilters];
                  this.FBtn_AutoJoin.mouseEnabled = false;
                  this.FBtn_AutoJoin.mouseChildren = false;
               }
               else
               {
                  this.FMC_AutoJoin.filters = [];
                  this.FBtn_AutoJoin.mouseEnabled = true;
                  this.FBtn_AutoJoin.mouseChildren = true;
                  if(this.FSelectTabIndex == this.FCharacter.Country - 1)
                  {
                     this.FMC_AutoJoin.visible = true;
                  }
                  else
                  {
                     this.FMC_AutoJoin.visible = false;
                  }
               }
            }
         }
      }
      
      protected function CheckTraitorAttack() : void
      {
         var _loc1_:TAutoActivityGain = null;
         if(this.FSelectTabIndex == 5)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_AutoActivityGain,this.FCharacter.GetMainLevel()) as TAutoActivityGain;
            this.FAutoJoinHelpHint.Content = TUtilityString.Format(this.FSystemLanguage_2.Desc,this.FConfigValue_2.Value,_loc1_.TraitorCoin,_loc1_.TraitorExp);
            this.FMC_AutoJoin.visible = true;
            if(this.FAutoHangUpStatusVec[CONST_AUTOHANGUP.INDEX_TraitorAttack] == 1)
            {
               this.FMC_AutoJoin.filters = [TGameUtil.GaryColorFilters];
               this.FBtn_AutoJoin.gotoAndStop(2);
               this.FBtn_AutoJoin.mouseEnabled = false;
               this.FBtn_AutoJoin.mouseChildren = false;
               if(this.FActivityStatusVect[TYPE_ORGACTIVITY_TRAITORATTACK] == BtnStatus_Open)
               {
                  this.FScene.btn_join.visible = false;
                  this.FTF_AutoJoining.visible = true;
               }
               else
               {
                  this.FScene.btn_join.visible = true;
                  this.FTF_AutoJoining.visible = false;
               }
            }
            else
            {
               this.FBtn_AutoJoin.gotoAndStop(1);
               this.FScene.btn_join.visible = true;
               this.FTF_AutoJoining.visible = false;
               if(this.FActivityStatusVect[TYPE_ORGACTIVITY_TRAITORATTACK] == BtnStatus_Open)
               {
                  this.FMC_AutoJoin.filters = [TGameUtil.GaryColorFilters];
                  this.FBtn_AutoJoin.mouseEnabled = false;
                  this.FBtn_AutoJoin.mouseChildren = false;
               }
               else
               {
                  this.FMC_AutoJoin.filters = [];
                  this.FBtn_AutoJoin.mouseEnabled = true;
                  this.FBtn_AutoJoin.mouseChildren = true;
               }
            }
         }
      }
      
      protected function CheckOtherDailyActivity() : void
      {
         if(this.FSelectTabIndex != 0 && this.FSelectTabIndex != 1 && this.FSelectTabIndex != 2 && this.FSelectTabIndex != 5)
         {
            this.FMC_AutoJoin.visible = false;
            this.FScene.btn_join.visible = true;
            this.FTF_AutoJoining.visible = false;
            this.FTF_VipConfig.visible = false;
         }
      }
      
      public function set OnEnterFightPet(param1:Function) : void
      {
         this.FOnEnterFightPet = param1;
      }
      
      public function get OnEnterFightPet() : Function
      {
         return this.FOnEnterFightPet;
      }
      
      public function set OnEnterOrganizationWar(param1:Function) : void
      {
         this.FOnEnterOrganizationWar = param1;
      }
      
      public function get OnEnterOrganizationWar() : Function
      {
         return this.FOnEnterOrganizationWar;
      }
      
      public function set OnJoinOrganizationWar(param1:Function) : void
      {
         this.FOnJoinOrganizationWar = param1;
      }
      
      public function get OnJoinOrganizationWar() : Function
      {
         return this.FOnJoinOrganizationWar;
      }
      
      public function set OnEnterCityDefend(param1:Function) : void
      {
         this.FOnEnterCityDefend = param1;
      }
      
      public function get OnEnterCityDefend() : Function
      {
         return this.FOnEnterCityDefend;
      }
      
      public function set OnEnterTraitorAttack(param1:Function) : void
      {
         this.FOnEnterTraitorAttack = param1;
      }
      
      public function get OnEnterTraitorAttack() : Function
      {
         return this.FOnEnterTraitorAttack;
      }
      
      public function set OnShortcutEffect(param1:Function) : void
      {
         this.FOnShortcutEffect = param1;
      }
      
      public function get OnShortcutEffect() : Function
      {
         return this.FOnShortcutEffect;
      }
      
      public function set OnTraitorAttackEnd(param1:Function) : void
      {
         this.FOnTraitorAttackEnd = param1;
      }
      
      public function get OnTraitorAttackEnd() : Function
      {
         return this.FOnTraitorAttackEnd;
      }
      
      public function set OnAutoHangUpStatusReq(param1:Function) : void
      {
         this.FOnAutoHangUpStatusReq = param1;
      }
      
      public function get OnAutoHangUpStatusReq() : Function
      {
         return this.FOnAutoHangUpStatusReq;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FScene.mc_left_falling.play();
         this.FScene.mc_right_falling.play();
         this.FSelectTabIndex = Math.max(this.GetDailyActivity(),0);
         this.UpdataUI();
         this.CheckTabEffect();
         if(this.FOnAutoHangUpStatusReq != null)
         {
            this.FOnAutoHangUpStatusReq(this);
         }
      }
      
      override public function Unmount() : void
      {
      }
      
      public function SetActivityStatus(param1:uint, param2:uint) : void
      {
         if(param1 == TYPE_ORGACTIVITY_AnimalSeal)
         {
            return;
         }
         this.FActivityStatusVect[param1] = param2;
         if(param1 == TYPE_ORGACTIVITY_PETBATTLE)
         {
            this.FActivityStatusVect[TYPE_ORGACTIVITY_YUZHIBO] = param2;
            this.FActivityStatusVect[TYPE_ORGACTIVITY_RIXIANG] = param2;
            this.FActivityStatusVect[TYPE_ORGACTIVITY_QIANSHOU] = param2;
         }
         if(Visible)
         {
            this.UpdataUI();
            this.CheckTabEffect();
            if(!this.UpdateAutoJoin())
            {
               this.UpdateActivityUI();
            }
         }
         if(this.FOnShortcutEffect != null)
         {
            this.FOnShortcutEffect(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_DailyActivity,this.GetDailyActivity() >= 0);
         }
         if(param1 == TYPE_ORGACTIVITY_TRAITORATTACK && param2 == BtnStatus_EndOpen)
         {
            this.FOnTraitorAttackEnd(this);
         }
      }
      
      public function UpdateAutoHangUpStatus(param1:Vector.<uint>) : void
      {
         this.FAutoHangUpStatusVec = param1;
         if(Visible)
         {
            if(!this.UpdateAutoJoin())
            {
               this.UpdateActivityUI();
            }
         }
      }
      
      public function EnterActivity(param1:uint) : void
      {
         switch(param1)
         {
            case TYPE_ORGACTIVITY_YUZHIBO:
            case TYPE_ORGACTIVITY_RIXIANG:
            case TYPE_ORGACTIVITY_QIANSHOU:
               if(this.FOnEnterFightPet != null)
               {
                  this.FOnEnterFightPet(this,param1 - TYPE_ORGACTIVITY_YUZHIBO + 1);
               }
               break;
            case TYPE_ORGACTIVITY_MUYEBATTLE:
               if(this.FOnEnterOrganizationWar != null)
               {
                  this.FOnEnterOrganizationWar(this);
               }
               break;
            case TYPE_ORGACTIVITY_MUYEGUARD:
               if(this.FOnEnterCityDefend != null)
               {
                  this.FOnEnterCityDefend(this);
               }
               break;
            case TYPE_ORGACTIVITY_TRAITORATTACK:
               if(this.FOnEnterTraitorAttack != null)
               {
                  this.FOnEnterTraitorAttack(this);
               }
         }
      }
   }
}

