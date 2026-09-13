package Processors.Game.Lobby.TacticalDeployment
{
   import Components.Standard.TUIBarrier;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityString;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Skills.*;
   import Logics.Streamization.TacticalDeployment.TUnstreamizerTacticalDeployment;
   import Logics.Unlocks.TUnlock;
   import Logics.Unlocks.TUnlocks;
   import Processors.Game.Lobby.BloodSoulPurgatory.DataStructureForBloodSoul;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.TacticalDeployment.MagicDeploymentLittleTip;
   import Rendering.Overlayers.TacticalDeployment.TacticalDeploymentLittleTip;
   import Rendering.Texts.TPainterText;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SHORTCUTS;
   import Utilities.UI.Overlayers.*;
   import flash.utils.*;
   
   public class TProcessorTacticalDeployment extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_TacticalDeployment:int = 835;
      
      protected static const SIZE_HEIGHT_TacticalDeployment:int = 532;
      
      protected var FProcessorWindowTacticalDeployment:TProcessorWindowTacticalDeployment;
      
      protected var FBoundsTacticalDeployment:TBounds;
      
      protected var FSystemLanguage:TBins;
      
      protected var FMilitary:TBins;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnlocks:TUnlocks;
      
      protected var FHasChanged:Boolean;
      
      protected var FDeploymentLittleTip:TacticalDeploymentLittleTip;
      
      protected var FMagicLittleTip:MagicDeploymentLittleTip;
      
      protected var FAutoChangeFormData:Vector.<TAutoChangeFormInfo>;
      
      protected var FUnstreamizerTacticalDeployment:TUnstreamizerTacticalDeployment;
      
      protected var FBarrier:TUIBarrier;
      
      protected var FPainterText:TPainterText;
      
      protected var FOnChangePosition:Function;
      
      protected var FOnChangeSkill:Function;
      
      protected var FOnEnterMilitary:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnNoticeChallenge:Function;
      
      public function TProcessorTacticalDeployment(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FCharacter = SLogicsCore.Character;
         this.FProcessorWindowTacticalDeployment = new TProcessorWindowTacticalDeployment(this);
         this.FProcessorWindowTacticalDeployment.OnClose = this.ProcessorWindowOnClose;
         this.FProcessorWindowTacticalDeployment.SkillOnClick = this.ProcessorSkillOnClick;
         this.FProcessorWindowTacticalDeployment.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowTacticalDeployment.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowTacticalDeployment.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowTacticalDeployment.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowTacticalDeployment.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowTacticalDeployment.OnEnterMilitary = this.ProcessorsOnEnterMilitary;
         this.FProcessorWindowTacticalDeployment.Visible = false;
         this.FProcessorWindowTacticalDeployment.AboratoryBtnClick = this.OnAboratoryBtnClick;
         this.FProcessorWindowTacticalDeployment.AboratoryBtnMove = this.OnAboratoryBtnMove;
         this.FProcessorWindowTacticalDeployment.AboratoryBtnOut = this.OnAboratoryBtnOut;
         this.FProcessorWindowTacticalDeployment.MagicBtnClick = this.OnMagicBtnClick;
         this.FProcessorWindowTacticalDeployment.MagicBtnMove = this.OnMagicBtnMove;
         this.FProcessorWindowTacticalDeployment.MagicBtnOut = this.OnMagicBtnOut;
         this.FProcessorWindowTacticalDeployment.MysticBtnClick = this.OnMysticBtnClick;
         this.FProcessorWindowTacticalDeployment.AwakenBtnClick = this.OnAwakenBtnClick;
         this.FProcessorWindowTacticalDeployment.TabooBtnClick = this.OnTabooBtnClick;
         this.FProcessorWindowTacticalDeployment.AutoChangeForm = this.AutoChangeForm;
         this.FBoundsTacticalDeployment = new TBounds();
         this.FBoundsTacticalDeployment.Width = SIZE_WIDTH_TacticalDeployment;
         this.FBoundsTacticalDeployment.Height = SIZE_HEIGHT_TacticalDeployment;
         ComponentBoundsCenter(this.FProcessorWindowTacticalDeployment,this.FBoundsTacticalDeployment);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         this.FDeploymentLittleTip = new TacticalDeploymentLittleTip(this);
         this.FMagicLittleTip = new MagicDeploymentLittleTip(this);
         this.FUnlocks = SLogicsCore.Unlocks;
         this.FAutoChangeFormData = SLogicsCore.AutoChangeFormData;
         this.FUnstreamizerTacticalDeployment = new TUnstreamizerTacticalDeployment();
         this.ConstructBarrier();
         this.FHasChanged = false;
         SetUIModuleID(CONST_MODULES.MODULE_TacticalDeployment);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DEPLOYMENT.RESOURCESID_TacticalDeployment);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         if(this.FSystemLanguage == null)
         {
            this.FSystemLanguage = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         }
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FMilitary = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         this.FDeploymentLittleTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FDeploymentLittleTip);
         this.FMagicLittleTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FMagicLittleTip);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TacticalDeploymentChangePositonRet,this.PerformPacket_SC_TD_ChangePositionRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TacticalDeploymentChangeSkillRet,this.PerformPacket_SC_TD_ChangeSkillRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TacticalDeployment_AutoChangeForm,this.PerformPacket_SC_TD_AutoChangeForm);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TacticalDeployment_AutoChangeFormInfo,this.PerformPacket_SC_TD_AutoChangeFormInfo);
      }
      
      protected function PerformPacket_SC_TD_ChangePositionRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:THero = null;
         var _loc7_:THero = null;
         var _loc8_:THeros = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:TSystemLanguage = null;
         var _loc13_:Boolean = false;
         if(this.FSystemLanguage == null)
         {
            this.FSystemLanguage = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         }
         _loc5_ = param1.Data;
         _loc2_ = int(_loc5_.readUnsignedByte());
         if(_loc2_ != 0)
         {
            return;
         }
         _loc9_ = _loc5_.readUnsignedInt();
         _loc11_ = int(_loc5_.readUnsignedByte());
         _loc8_ = this.FCharacter.Heros;
         _loc6_ = _loc8_.GetHeroByIdentifier(_loc9_);
         if(_loc6_ == null)
         {
            return;
         }
         _loc10_ = _loc6_.FightPosition;
         _loc4_ = _loc8_.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc8_.GetHeroByIndex(_loc3_);
            if(_loc7_.FightPosition > 0 && _loc7_.FightPosition == _loc11_)
            {
               _loc7_.FightPosition = _loc10_;
               _loc7_.Mounted = false;
               _loc12_ = this.FSystemLanguage.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_04) as TSystemLanguage;
               _loc13_ = true;
               break;
            }
            _loc3_++;
         }
         if(!_loc13_)
         {
            if(_loc10_ == 0 || _loc11_ != 0)
            {
               _loc6_.Mounted = true;
               _loc12_ = this.FSystemLanguage.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_01) as TSystemLanguage;
            }
            else
            {
               _loc6_.Mounted = false;
               _loc12_ = this.FSystemLanguage.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_06) as TSystemLanguage;
            }
         }
         _loc6_.FightPosition = _loc11_;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTacticalDeployment.ResetDeployment();
            this.FHasChanged = true;
         }
         this.CheckHeroMounted();
         EffectGenerateText(_loc12_.Desc);
         TutorialNextStep(602);
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
         if(this.FOnNoticeChallenge != null)
         {
            this.FOnNoticeChallenge(this);
         }
      }
      
      protected function PerformPacket_SC_TD_ChangeSkillRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:THero = null;
         var _loc7_:TSkills = null;
         var _loc8_:TSkill = null;
         var _loc9_:uint = 0;
         var _loc10_:TSystemLanguage = null;
         _loc5_ = param1.Data;
         _loc4_ = int(_loc5_.readUnsignedByte());
         if(_loc4_ != 0)
         {
            return;
         }
         _loc9_ = _loc5_.readUnsignedInt();
         _loc6_ = this.FCharacter.GetMainHero();
         _loc7_ = _loc6_.Skills;
         _loc3_ = _loc7_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = _loc7_.GetSkillByIndex(_loc2_);
            if(_loc8_.Mounted)
            {
               _loc8_.Mounted = !_loc8_.Mounted;
               break;
            }
            _loc2_++;
         }
         _loc8_ = _loc7_.GetSkillByIdentifier(_loc9_);
         if(_loc8_.Mounted)
         {
            _loc8_.Mounted = false;
         }
         else
         {
            _loc8_.Mounted = true;
         }
         this.FProcessorWindowTacticalDeployment.ResetSkill();
         if(this.FOnChangeSkill != null)
         {
            this.FOnChangeSkill(this);
         }
         if(this.FSystemLanguage == null)
         {
            this.FSystemLanguage = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         }
         _loc10_ = this.FSystemLanguage.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_03) as TSystemLanguage;
         EffectGenerateText(_loc10_.Desc);
         TutorialNextStep(603);
      }
      
      protected function PerformPacket_SC_TD_AutoChangeForm(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         if(_loc4_ == 4)
         {
            this.AutoChangeForm(5,0);
         }
         if(_loc4_ == 1)
         {
            this.ShowBarrier(false);
            this.CharacterLoadInventories();
         }
         if(_loc4_ == 1 || _loc4_ == 2)
         {
         }
      }
      
      protected function PerformPacket_SC_TD_AutoChangeFormInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TAutoChangeFormInfo = null;
         _loc2_ = param1.Data;
         var _loc5_:int = _loc2_.readShort();
         this.FAutoChangeFormData.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = new TAutoChangeFormInfo();
            _loc7_.FormId = _loc2_.readUnsignedInt();
            _loc6_ = _loc2_.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               this.FUnstreamizerTacticalDeployment.Unstreamize(_loc2_,_loc7_,null);
               _loc4_++;
            }
            this.FAutoChangeFormData.push(_loc7_);
            _loc3_++;
         }
         this.FProcessorWindowTacticalDeployment.ResetFormData();
      }
      
      protected function AutoChangeForm(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(param1 == 1)
         {
            this.ShowBarrier();
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TacticalDeployment_AutoChangeForm);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function CharacterLoadInventories() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_LoadBag);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_TacticalDeployment);
         }
      }
      
      protected function CheckHeroMounted() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         _loc2_ = uint(this.FCharacter.Heros.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FCharacter.Heros.GetHeroByIndex(_loc1_);
            _loc3_.Mounted = Boolean(_loc3_.FightPosition != 0);
            _loc1_++;
         }
      }
      
      protected function ProcessorWindowOnClose(param1:Object) : void
      {
         ProcessorClose();
         TutorialNextStep(601);
      }
      
      protected function ProcessorSkillOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:TSkill = null;
         _loc5_ = param2 as TSkill;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TacticalDeployment_ChangeSkillReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(_loc5_.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorsOnEnterMilitary(param1:Object) : void
      {
         if(this.FOnEnterMilitary != null)
         {
            this.FOnEnterMilitary(param1);
         }
      }
      
      protected function VerificationLocaltionOperatingByPosition(param1:uint, param2:uint) : TUnlock
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUnlock = null;
         _loc4_ = this.FUnlocks.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FUnlocks.GetUnlockByIndex(_loc3_);
            if(param1 == _loc5_.Position && param2 == _loc5_.Localtion)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
      
      protected function InquiryConditionLocaltionOperatingByPosition(param1:TUnlock, param2:uint, param3:uint) : String
      {
         var _loc4_:Vector.<String> = null;
         var _loc5_:String = null;
         _loc5_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_LevelWarning,param1.UnlockValue);
         switch(param2)
         {
            case CONST_SHORTCUTS.POSITION_Function:
               _loc4_ = STRING_SHORTCUTS.STRING_FUNCTION_NAMES;
               break;
            case CONST_SHORTCUTS.POSITION_Activity:
               _loc4_ = STRING_SHORTCUTS.STRING_ACTIVITY_NAMES;
               break;
            case CONST_SHORTCUTS.POSITION_Constantly:
               _loc4_ = STRING_SHORTCUTS.STRING_CONSTANTLY_NAMES;
               break;
            case CONST_SHORTCUTS.POSITION_Additional:
               _loc4_ = STRING_SHORTCUTS.STRING_ADDITIONAL_NAMES;
               break;
            case CONST_SHORTCUTS.POSITION_Active_Special:
               _loc4_ = STRING_SHORTCUTS.STRING_ACTIVESPECIAL_NAMES;
         }
         if(param1.UnlockCondition == 3)
         {
            _loc5_ = TUtilityString.Format(STRING_SHORTCUTS.STRING_UnOperatingWarning,_loc4_[param3]);
         }
         else
         {
            _loc5_ += TUtilityString.Format(STRING_SHORTCUTS.STRING_OperatingWarning,_loc4_[param3]);
         }
         return _loc5_;
      }
      
      protected function ShowBarrier(param1:Boolean = true) : void
      {
         if(this.FBarrier)
         {
            this.FBarrier.Visible = param1;
         }
      }
      
      protected function ConstructBarrier() : void
      {
         this.FBarrier = new TUIBarrier(this);
         this.FBarrier.Width = CONST_COMMON.STAGE_Width;
         this.FBarrier.Height = CONST_COMMON.STAGE_Height;
         this.FBarrier.Color = 2147483648;
         this.FBarrier.Visible = false;
         this.FBarrier.Init();
      }
      
      public function get OnChangePosition() : Function
      {
         return this.FOnChangePosition;
      }
      
      public function set OnChangePosition(param1:Function) : void
      {
         this.FOnChangePosition = param1;
      }
      
      public function get OnChangeSkill() : Function
      {
         return this.FOnChangeSkill;
      }
      
      public function set OnChangeSkill(param1:Function) : void
      {
         this.FOnChangeSkill = param1;
      }
      
      public function get OnEnterMilitary() : Function
      {
         return this.FOnEnterMilitary;
      }
      
      public function set OnEnterMilitary(param1:Function) : void
      {
         this.FOnEnterMilitary = param1;
      }
      
      public function get ProcessorWindowTacticalDeployment() : TProcessorWindowTacticalDeployment
      {
         return this.FProcessorWindowTacticalDeployment;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnNoticeChallenge() : Function
      {
         return this.FOnNoticeChallenge;
      }
      
      public function set OnNoticeChallenge(param1:Function) : void
      {
         this.FOnNoticeChallenge = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TMilitary = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowTacticalDeployment.Load();
            return;
         }
         _loc2_ = this.FCharacter.MilitaryRank;
         _loc3_ = this.FMilitary.GetDatebaseByIdentifier(_loc2_) as TMilitary;
         _loc4_ = uint(_loc3_.FightHeroNum);
         _loc5_ = _loc3_.MaxHeroNum + this.FCharacter.BuyHeroSlot;
         this.FProcessorWindowTacticalDeployment.MaxPointCount = _loc4_;
         this.FProcessorWindowTacticalDeployment.MaxHeroCount = _loc5_;
         this.FProcessorWindowTacticalDeployment.Visible = true;
         this.FProcessorWindowTacticalDeployment.SetupDeploymentData();
         TutorialNextStep(600);
         this.AutoChangeForm(5,0);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FProcessorWindowTacticalDeployment.Visible = false;
         this.FProcessorWindowTacticalDeployment.SetVisibelByValue(false);
         if(this.FHasChanged)
         {
            if(this.FOnChangePosition != null)
            {
               this.FOnChangePosition(this);
            }
            this.FHasChanged = false;
         }
      }
      
      public function UserUpdateFightingPower() : void
      {
         this.FProcessorWindowTacticalDeployment.UserUpdateFightingPower();
      }
      
      public function ProcessorChangeSkillReq(param1:Object, param2:Object) : void
      {
         this.ProcessorSkillOnClick(param1,param2);
      }
      
      public function AutoSetDeployment(param1:uint, param2:uint, param3:Function) : void
      {
         this.FProcessorWindowTacticalDeployment.AutoSetDeployment(param1,param2,param3);
      }
      
      public function FMC_Aboratory_Btn(param1:Vector.<DataStructureForBloodSoul>) : void
      {
         this.FDeploymentLittleTip.UpdataValue(param1);
      }
      
      public function OnAboratoryBtnMove() : void
      {
         this.FDeploymentLittleTip.Context = {"id":777};
         this.FDeploymentLittleTip.Render(FUICore.MouseCoordinate);
         this.FDeploymentLittleTip.Show();
      }
      
      public function OnMagicBtnMove() : void
      {
         this.FMagicLittleTip.Context = {"id":1212};
         this.FMagicLittleTip.Render(FUICore.MouseCoordinate);
         this.FMagicLittleTip.Show();
      }
      
      public function OnAboratoryBtnOut() : void
      {
         this.FDeploymentLittleTip.Hide();
      }
      
      public function OnMagicBtnOut() : void
      {
         this.FMagicLittleTip.Hide();
      }
      
      public function OnAboratoryBtnClick() : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_CityDefend || SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_FightPet || SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_OrganizationWar || SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_TraitorAttack)
            {
               EffectGenerateText(STRING_COMMON.STRING_FourActivity_String);
               return;
            }
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Laboratory);
         }
      }
      
      public function OnMagicBtnClick() : void
      {
         var _loc1_:TUnlock = null;
         var _loc2_:String = null;
         _loc1_ = this.VerificationLocaltionOperatingByPosition(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Moutain);
         if(_loc1_ != null && _loc1_.State != TUnlock.UNLOCKSTATE_Unlocked)
         {
            _loc2_ = this.InquiryConditionLocaltionOperatingByPosition(_loc1_,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic);
            EffectGenerateText(_loc2_);
            return;
         }
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Magic);
         }
      }
      
      public function OnMysticBtnClick() : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NijiaMystic);
         }
      }
      
      public function OnAwakenBtnClick() : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Awaken);
         }
      }
      
      public function OnTabooBtnClick() : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Taboo);
         }
      }
   }
}

