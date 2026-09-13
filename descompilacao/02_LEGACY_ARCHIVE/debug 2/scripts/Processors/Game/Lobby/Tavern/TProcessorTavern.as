package Processors.Game.Lobby.Tavern
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Characters.*;
   import Logics.Streamization.Tavern.*;
   import Logics.Tavern.*;
   import Processors.Game.Common.Effects.Texts.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.Tavern.TavernEffect.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Rendering.Overlayers.Tavern.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.utils.*;
   
   public class TProcessorTavern extends TProcessorLobbyPlate
   {
      
      protected static const SIZE_WIDTH_Recruit:uint = 394;
      
      protected static const SIZE_HEIGHT_Recruit:uint = 379;
      
      protected static const SIZE_WIDTH_ChangeCard:uint = 301;
      
      protected static const SIZE_HEIGHT_ChangeCard:uint = 176;
      
      protected static const SIZE_WIDTH_ChangeSoul:uint = 677;
      
      protected static const SIZE_HEIGHT_ChangeSoul:uint = 486;
      
      protected static const EffectSingle_DelayTicks:int = 1000;
      
      protected static const EffectMulti_DelayTicks:int = 500;
      
      protected static const FLOATING:uint = 1;
      
      protected static const MoraMode_Normal:uint = 0;
      
      protected static const MoraMode_Advance:uint = 1;
      
      protected static const MoraMode_Ten:uint = 2;
      
      protected static const MoraMode_TenWin:uint = 3;
      
      protected static const MoraMode_Violent:uint = 4;
      
      protected var FScene:MovieClip;
      
      protected var FProcessorWindowTavern:TProcessorWindowTavern;
      
      protected var FProcessorWindowTavernHeroList:TProcessorWindowTavernHeroList;
      
      protected var FProcessorWindowTavernMora:TProcessorWindowTavernMora;
      
      protected var FOverlayerKey:TOverlayerKey;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FIsInit:Boolean;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowChangeCard:TProcessorWindowChangeCard;
      
      protected var FProcessorWindowChangeSoul:TProcessorWindowChangeSoul;
      
      protected var FBoundsRecruit:TBounds;
      
      protected var FBoundsChangeCard:TBounds;
      
      protected var FBoundsChangeSoul:TBounds;
      
      protected var FMountPointWindow:TUIComponent;
      
      protected var FEffRoutines:TRegistryRoutine;
      
      protected var FEffState:int;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FEffectCount:uint;
      
      protected var FTavernEffectStructVect:Vector.<TTavernEffectStruct>;
      
      protected var FTempTotleSouls:int;
      
      protected var FTempMoraType:int;
      
      protected var FTempMoraSoulType:int;
      
      protected var FIsTip:Boolean;
      
      protected var FMoras:TMoras;
      
      protected var UnstreamizerTavern:TUnstreamizerTavern;
      
      protected var FTavernWarriorBins:TBins;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FHeros:THeros;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FOnEffectSoul:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      private var _Parameter:int = 0;
      
      public function TProcessorTavern(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FIsInit = false;
         this.FMountPointWindow = param2.MountPointWindow;
         this.FTavernEffectStructVect = new Vector.<TTavernEffectStruct>();
         this.FMoras = new TMoras();
         this.UnstreamizerTavern = new TUnstreamizerTavern();
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
         this.FHeros = SLogicsCore.Character.Heros;
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.FMountPointWindow);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.BarrierDeactuate = this.OnBarrierDeactuate;
         this.FProcessorWindowRecruit.OnEffectText = this.ProcessorOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = this.UIComponentsHintOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowRecruit.OnRecruitCLick = this.ProcessorOnRecruitClick;
         SetUIModuleID(CONST_MODULES.MODULE_Tavern);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowTavern != null && Visible == true)
         {
            this.FProcessorWindowTavern.UpdataEffect();
         }
         if(this.FProcessorWindowTavernHeroList != null && this.FProcessorWindowTavernHeroList.Visible == true)
         {
            this.FProcessorWindowTavernHeroList.UpdataTavernHeroHeadBitmap();
         }
         if(this.FProcessorWindowTavernMora != null && this.FProcessorWindowTavernMora.Visible == true)
         {
            this.FProcessorWindowTavernMora.UpdataTavernHeroHeadBitmap();
         }
         if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         if(this.FProcessorWindowChangeCard != null && this.FProcessorWindowChangeCard.Visible == true)
         {
            this.FProcessorWindowChangeCard.UpdataBitmap();
         }
         if(this.FProcessorWindowChangeSoul != null && this.FProcessorWindowChangeSoul.Visible == true)
         {
            this.FProcessorWindowChangeSoul.UpdataBitmap();
         }
         if(this.FTavernEffectStructVect.length > 0)
         {
            this.LogicsPerform_Effect();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TAVERN.RESOURCESID_TAVERN);
         this.FProcessorWindowRecruit.Load();
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingPrimary)
         {
            return;
         }
         this.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.InitTavern();
         this.FProcessorWindowChangeCard = new TProcessorWindowChangeCard(this.FMountPointWindow);
         this.FProcessorWindowChangeCard.Visible = false;
         this.FProcessorWindowChangeCard.BarrierDeactuate = this.OnBarrierDeactuate;
         this.FProcessorWindowChangeCard.SlotsOnMove = this.UIComponentsApplianceOnOver;
         this.FProcessorWindowChangeCard.SlotsOnOut = this.UIComponentsApplianceOnOut;
         this.FProcessorWindowChangeSoul = new TProcessorWindowChangeSoul(this.FMountPointWindow);
         this.FProcessorWindowChangeSoul.Visible = false;
         this.FProcessorWindowChangeSoul.BarrierDeactuate = this.OnBarrierDeactuate;
         this.FProcessorWindowChangeSoul.Init();
         this.FBoundsRecruit = new TBounds();
         this.FBoundsRecruit.Width = SIZE_WIDTH_Recruit;
         this.FBoundsRecruit.Height = SIZE_HEIGHT_Recruit;
         this.FBoundsChangeCard = new TBounds();
         this.FBoundsChangeCard.Width = SIZE_WIDTH_ChangeCard;
         this.FBoundsChangeCard.Height = SIZE_HEIGHT_ChangeCard;
         this.FBoundsChangeSoul = new TBounds();
         this.FBoundsChangeSoul.Width = SIZE_WIDTH_ChangeSoul;
         this.FBoundsChangeSoul.Height = SIZE_HEIGHT_ChangeSoul;
         ComponentBoundsCenter(this.FProcessorWindowRecruit,this.FBoundsRecruit);
         ComponentBoundsCenter(this.FProcessorWindowChangeCard,this.FBoundsChangeCard);
         ComponentBoundsCenter(this.FProcessorWindowChangeSoul,this.FBoundsChangeSoul);
         this.FOverlayerKey = new TOverlayerKey(this);
         this.FOverlayerKey.Visible = false;
         this.FOverlayerHint = new TOverlayerHint(this.FMountPointWindow);
         this.FOverlayerHint.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Tavern);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerKey);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FTavernWarriorBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_Warrior);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function InitTavern() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_Tavern) as MovieClip;
         addChild(this.FScene);
         this.FProcessorWindowTavern = new TProcessorWindowTavern(this,this.FScene.mc_publicBox);
         this.FProcessorWindowTavern.HintOnMove = this.UIComponentsHintOnOver;
         this.FProcessorWindowTavern.HintOnOut = this.UIComponentsHintOnOut;
         this.FProcessorWindowTavern.OnHelpTipsOver = this.UIHelpTipsHintOnOver;
         this.FProcessorWindowTavern.OnHelpTipsOut = this.UIHelpTipsHintOnOut;
         this.FProcessorWindowTavern.OnEnterCity = this.OnCloseTavern;
         this.FProcessorWindowTavern.EffectGenerateText = EffectGenerateText;
         this.FProcessorWindowTavern.OnShortcutHyperlinks = this.ProcessorOnShortcutHyperlinks;
         this.FProcessorWindowTavernHeroList = new TProcessorWindowTavernHeroList(this,this.FScene.mc_generalBox);
         this.FProcessorWindowTavernHeroList.Visible = false;
         this.FProcessorWindowTavernHeroList.OnOverlay = this.UIComponentsApplianceOnOver;
         this.FProcessorWindowTavernHeroList.OnOut = this.UIComponentsApplianceOnOut;
         this.FProcessorWindowTavernHeroList.SetRecruitData = this.SetRecruitData;
         this.FProcessorWindowTavernHeroList.SetChangeCardData = this.SetChangeCardData;
         this.FProcessorWindowTavernHeroList.EnterMora = this.OnEnterMora;
         this.FProcessorWindowTavernHeroList.HintOnMove = this.UIComponentsOnOver;
         this.FProcessorWindowTavernHeroList.HintOnOut = this.UIComponentsOnOut;
         this.FProcessorWindowTavernHeroList.EffectGenerateText = EffectGenerateText;
         this.FProcessorWindowTavernHeroList.EnableWindowTavern = this.EnableWindowTavern;
         this.FProcessorWindowTavernHeroList.TutorialNextStep = TutorialNextStep;
         this.FProcessorWindowTavernMora = new TProcessorWindowTavernMora(this,this.FScene.mc_moraBox);
         this.FProcessorWindowTavernMora.Visible = false;
         this.FProcessorWindowTavernMora.TurnBackHeroList = this.TurnBackHeroList;
         this.FProcessorWindowTavernHeroList.EffectGenerateText = EffectGenerateText;
         if(this.FScene["BTN_Chg"])
         {
            this.FScene["BTN_Chg"].addEventListener(MouseEvent.CLICK,this.OnOpenChgSoul);
         }
         this.FEffRoutines = new TRegistryRoutine();
         this.EffRegisterRoutines();
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = FUICore.StageHeight;
         if(Boolean(this.FScene) && Boolean(this.FScene.mc_publicBox))
         {
            this.FScene.mc_publicBox.mc_moraLog.y = _loc1_;
         }
      }
      
      protected function EffRegisterRoutines() : void
      {
         this.FEffRoutines.Register(FLOATING,this.LoginPerform_FloatingWord);
      }
      
      protected function LoginPerform_FloatingWord() : void
      {
         var _loc1_:TCoordinate = null;
         var _loc2_:TTavernEffectStruct = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc4_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
         if(_loc4_ < EffectMulti_DelayTicks)
         {
            return;
         }
         this.FEffDelayReferenceTick = STimingCore.TickCount;
         _loc2_ = this.FTavernEffectStructVect.shift();
         if(this.FTavernEffectStructVect.length == 0)
         {
            if(this.FIsTip)
            {
               this.SetMoraLog();
               this.EnableWindowTavern(true);
            }
         }
         if(_loc2_.IsWin == false)
         {
            if(_loc2_.HeroId != 0)
            {
               this.FProcessorWindowTavernHeroList.ShowOneKeyHeroById(_loc2_.HeroId);
            }
            EffectGenerateText(TUtilityString.Format(STRING_TAVERN.ResultMoney,_loc2_.ReturnMoney));
         }
         else
         {
            _loc3_ = this.FProcessorWindowTavern.GetHeroSoulByIndex(_loc2_.AwardSoulType - 3);
            this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc2_.AwardSoulType - 3,_loc2_.AwardSoulValue + _loc3_);
            EffectGenerateText(TUtilityString.Format(STRING_TAVERN.ResultSouls,_loc2_.AwardSoulValue));
            if(this.FOnEffectSoul != null)
            {
               if(_loc2_.HeroId != 0)
               {
                  this.FProcessorWindowTavernHeroList.ShowOneKeyHeroById(_loc2_.HeroId);
                  _loc1_ = this.FProcessorWindowTavernHeroList.GetCoordinateByHeroId(_loc2_.HeroId);
                  this.FEffectCoordinateParameters.CoordinateDestination.Assign(_loc1_);
                  this.FOnEffectSoul(this,_loc2_.AwardSoulType - 3,_loc2_.AwardSoulValue,this.FEffectCoordinateParameters);
               }
               else
               {
                  this.FOnEffectSoul(this,_loc2_.AwardSoulType - 3,_loc2_.AwardSoulValue);
               }
            }
         }
         TPoolTavernEffectStruct.SaveTavernEffectStruct(_loc2_);
      }
      
      protected function SetMoraLog() : void
      {
         var _loc1_:TReportList = null;
         _loc1_ = new TReportList();
         _loc1_.Time = STimingCore.GetServerTick();
         _loc1_.MoraType = this.FTempMoraType;
         _loc1_.SoulType = this.FTempMoraSoulType;
         _loc1_.SoulCount = this.FTempTotleSouls;
         this.FMoras.ReportLists.push(_loc1_);
         this.FProcessorWindowTavern.ResetMoraLog(this.FMoras.ReportLists);
      }
      
      protected function EnterTavern() : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FProcessorWindowTavern.UpdataPublicUI();
         this.FProcessorWindowTavernHeroList.CheckTavernHeroList();
         if(this.FMoras.Count <= 0)
         {
            if(this._Parameter != 0)
            {
               this.FProcessorWindowTavernHeroList.SetFCurPage = this._Parameter;
               this.FProcessorWindowTavernHeroList.UpdataUI();
               this.FProcessorWindowTavernHeroList.CheckBtn();
            }
            this.FProcessorWindowTavernHeroList.Visible = true;
            this.FProcessorWindowTavernMora.Visible = false;
         }
         else
         {
            this.FProcessorWindowTavernHeroList.Visible = false;
            this.FProcessorWindowTavernMora.Visible = true;
         }
         SLogicsCore.Character.RoleSencePosition = CONST_COMMON.SCENEPOSITION_Tavern;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernMoraRet,this.PacketPerform_SC_TavernMora);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernNormalMoraRet,this.PacketPerform_SC_TavernNormalMora);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernRecruitRet,this.PacketPerform_SC_TavernRecruit);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernChangeCardRet,this.PacketPerform_SC_ChangeCard);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Common_TavernChangeSoul_Ret,this.PacketPerform_SC_ChangeSoul);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernOneKeyViolentRet,this.PacketPerform_SC_OneKeyViolentRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TavernReportListRet,this.PacketPerform_SC_ReportListRet);
      }
      
      public function set FParameter(param1:int) : void
      {
         this._Parameter = param1;
      }
      
      public function get FParameter() : int
      {
         return this._Parameter;
      }
      
      protected function PacketPerform_SC_Enter_Tavern(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = param1.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.UnstreamizerTavern.Unstreamize(param1,this.FMoras,null);
         if(this.FMoras.Count > 0)
         {
            this.FProcessorWindowTavernHeroList.Visible = false;
            this.FProcessorWindowTavernMora.Visible = true;
            this.FProcessorWindowTavernMora.SetMoraData(this.FMoras);
            this.FIsTip = false;
         }
         this.FIsInit = true;
      }
      
      protected function PacketPerform_SC_TavernMora(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:TMora = null;
         _loc3_ = param1.Data;
         _loc4_ = _loc3_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            this.EnableWindowTavern(true);
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         this.UnstreamizerTavern.Unstreamize(_loc3_,this.FMoras,null);
         this.FTempMoraType = this.FMoras.MoraType;
         if(this.FMoras.MoraType == MoraMode_Normal || this.FMoras.MoraType == MoraMode_Advance)
         {
            this.FProcessorWindowTavernHeroList.ShowChooseMoraHero(this.FMoras);
            this.FIsTip = false;
         }
         else if(this.FMoras.MoraType == MoraMode_Ten || this.FMoras.MoraType == MoraMode_TenWin)
         {
            this.FTempTotleSouls = 0;
            _loc2_ = 0;
            while(_loc2_ < this.FMoras.Count)
            {
               _loc5_ = this.FMoras.GetMoraByIndex(_loc2_);
               this.MakeEffectStruct(_loc5_);
               if(_loc5_.IsMoraWin)
               {
                  this.FTempMoraSoulType = this.FTavernEffectStructVect[this.FTavernEffectStructVect.length - 1].AwardSoulType;
                  this.FTempTotleSouls += this.FTavernEffectStructVect[this.FTavernEffectStructVect.length - 1].AwardSoulValue;
               }
               _loc2_++;
            }
            this.FEffState = FLOATING;
            this.FEffectCount = this.FMoras.Count;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            this.FMoras.Clear();
            this.FIsTip = true;
         }
      }
      
      protected function PacketPerform_SC_TavernNormalMora(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:TMora = null;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = Boolean(_loc2_.readUnsignedByte());
         _loc7_ = _loc2_.readUnsignedInt();
         this.FProcessorWindowTavernMora.SetMoraResult(_loc4_,_loc5_);
         _loc6_ = this.FMoras.GetMoraByHeroId(_loc4_);
         _loc6_.IsMoraWin = _loc5_;
         _loc6_.ReturnMoney = _loc7_;
         this.MakeEffectStruct(_loc6_,false);
         this.FEffState = FLOATING;
         this.FEffectCount = 1;
         this.FEffDelayReferenceTick = STimingCore.TickCount;
      }
      
      protected function PacketPerform_SC_TavernRecruit(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:uint = 0;
         var _loc7_:TTavernWarrior = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:THero = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         _loc3_ = param1.Data;
         _loc4_ = _loc3_.readUnsignedInt();
         if(_loc4_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc4_);
            return;
         }
         _loc6_ = _loc3_.readUnsignedInt();
         _loc9_ = _loc3_.readUnsignedInt();
         _loc10_ = _loc3_.readUnsignedInt();
         _loc12_ = _loc3_.readUnsignedInt();
         _loc13_ = _loc3_.readUnsignedInt();
         _loc14_ = _loc3_.readUnsignedInt();
         _loc5_ = new Vector.<uint>(1);
         _loc5_[0] = _loc6_;
         this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,this.FHeros,_loc5_);
         _loc11_ = this.FHeros.GetHeroByIdentifier(_loc6_);
         if(_loc11_ != null)
         {
            _loc11_.PotentialLv = _loc9_;
            _loc11_.PotentialExp = _loc10_;
            _loc11_.ExpIsInherited = 0;
            _loc11_.Level = _loc12_;
            _loc11_.Experience.High = _loc13_;
            _loc11_.Experience.Low = _loc14_;
         }
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this,_loc6_);
         }
         if(this.FTavernWarriorBins == null)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FTavernWarriorBins.Count)
         {
            _loc7_ = this.FTavernWarriorBins.GetDatebaseByIndex(_loc2_) as TTavernWarrior;
            if(_loc7_.AwardId == _loc6_)
            {
               break;
            }
            _loc2_++;
         }
         if(_loc7_ != null)
         {
            if(_loc7_.Awardsouls.Type < 7)
            {
               this.FProcessorWindowTavernHeroList.ResetTavern();
               _loc8_ = this.FProcessorWindowTavern.GetHeroSoulByIndex(_loc7_.Awardsouls.Type - 3);
               this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc7_.Awardsouls.Type - 3,_loc8_ - _loc7_.RecruitSoul);
            }
            EffectGenerateText(STRING_TAVERN.RecruitOk);
         }
      }
      
      protected function PacketPerform_SC_ChangeCard(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TExchangeExpCard = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = this.FProcessorWindowChangeCard.GetBuyCount();
         _loc4_ = this.FProcessorWindowChangeCard.GetExchangeExpCard();
         _loc5_ = this.FProcessorWindowTavern.GetHeroSoulByIndex(_loc4_.Quality - 3);
         this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc4_.Quality - 3,_loc5_ - _loc4_.Value * _loc6_);
         EffectGenerateText(STRING_TAVERN.BuySuccessful);
      }
      
      protected function PacketPerform_SC_ChangeSoul(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = _loc2_.readUnsignedInt();
         EffectGenerateText(STRING_TAVERN.ChangeSuccessful);
         this.FProcessorWindowChangeSoul.ChgSoulSucceed(_loc4_,_loc5_,_loc6_,_loc7_);
         this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc4_ - 3,SLogicsCore.Character.GetHeroSoulByIndex(_loc4_ - 3));
         this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc6_ - 3,SLogicsCore.Character.GetHeroSoulByIndex(_loc6_ - 3));
      }
      
      protected function PacketPerform_SC_OneKeyViolentRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TReportList = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            this.EnableWindowTavern(true);
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         EffectGenerateText(TUtilityString.Format(STRING_TAVERN.STRING_ViolentSuccess,_loc5_,STRING_TAVERN.ColorDescription[_loc4_]));
         this.FProcessorWindowTavern.SetHeroSoulByIndex(_loc4_ - 3,SLogicsCore.Character.GetHeroSoulByIndex(_loc4_ - 3));
         this.EnableWindowTavern(true);
         _loc6_ = new TReportList();
         _loc6_.Time = STimingCore.GetServerTick();
         _loc6_.MoraType = MoraMode_Violent;
         _loc6_.SoulType = _loc4_;
         _loc6_.SoulCount = _loc5_;
         this.FMoras.ReportLists.push(_loc6_);
         this.FProcessorWindowTavern.ResetMoraLog(this.FMoras.ReportLists);
      }
      
      protected function PacketPerform_SC_ReportListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.UnstreamizerTavern.UnstreamizeReportList(_loc2_,this.FMoras.ReportLists,null);
         this.FProcessorWindowTavern.ResetMoraLog(this.FMoras.ReportLists);
      }
      
      protected function MakeEffectStruct(param1:TMora, param2:Boolean = true) : void
      {
         var _loc3_:TTavernWarrior = null;
         var _loc4_:TTavernEffectStruct = null;
         _loc4_ = TPoolTavernEffectStruct.GetTavernEffectStruct();
         _loc3_ = this.FTavernWarriorBins.GetDatebaseByIdentifier(param1.TavernHeroId) as TTavernWarrior;
         if(param2)
         {
            _loc4_.HeroId = param1.TavernHeroId;
         }
         _loc4_.AwardSoulType = _loc3_.Awardsouls.Type;
         _loc4_.AwardSoulValue = _loc3_.Awardsouls.Value;
         _loc4_.IsWin = param1.IsMoraWin;
         _loc4_.ReturnMoney = param1.ReturnMoney;
         this.FTavernEffectStructVect.push(_loc4_);
      }
      
      protected function EnableWindowTavern(param1:Boolean) : void
      {
         this.FProcessorWindowTavernHeroList.EnableBtn(param1);
         this.FProcessorWindowTavern.EnableBtn(param1);
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint.Context = param2;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Visible = true;
      }
      
      protected function UIComponentsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHint.Visible = false;
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:TPayConfig) : void
      {
         this.FOverlayerKey.Context = param2;
         this.FOverlayerKey.Render(FUICore.MouseCoordinate);
         this.FOverlayerKey.Show();
      }
      
      protected function UIComponentsOnOut(param1:Object) : void
      {
         this.FOverlayerKey.Hide();
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Context = _loc3_;
            this.FOverlayerAppliance.Render(FUICore.MouseCoordinate);
            this.FOverlayerAppliance.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(this.FOverlayerAppliance != null)
         {
            this.FOverlayerAppliance.Hide();
         }
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnCloseTavern(param1:Object) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(param1);
         }
      }
      
      protected function SetRecruitData(param1:TTavernWarrior, param2:Boolean) : void
      {
         BarrierActuate(this.FProcessorWindowRecruit);
         this.FProcessorWindowRecruit.SetRecruitData(param1,param2);
      }
      
      protected function SetChangeCardData(param1:TExchangeExpCard, param2:Boolean) : void
      {
         BarrierActuate(this.FProcessorWindowChangeCard);
         this.FProcessorWindowChangeCard.SetChangeCardData(param1,param2);
      }
      
      protected function OnBarrierDeactuate(param1:Object) : void
      {
         BarrierDeactuate(param1);
      }
      
      protected function ProcessorOnRecruitClick(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernRecruitReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnEnterMora(param1:TMoras) : void
      {
         this.FProcessorWindowTavernMora.SetMoraData(param1);
         this.FProcessorWindowTavernMora.Visible = true;
         this.FProcessorWindowTavernHeroList.Visible = false;
         this.EnableWindowTavern(true);
      }
      
      protected function TurnBackHeroList() : void
      {
         this.FProcessorWindowTavernHeroList.EnableBtn(true);
         this.FProcessorWindowTavernHeroList.Visible = true;
         this.FProcessorWindowTavernMora.Visible = false;
         this.FMoras.Clear();
      }
      
      protected function LogicsPerform_Effect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:int = 0;
         if(this.FEffectCount == 1)
         {
            _loc3_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc3_ < EffectSingle_DelayTicks)
            {
               return;
            }
         }
         do
         {
            _loc1_ = this.FEffState;
            _loc2_ = this.FEffRoutines.GetRoutineByIndentifier(this.FEffState);
            if(_loc2_ != null)
            {
               _loc2_();
            }
            else
            {
               this.FEffectCount = 0;
            }
         }
         while(_loc1_ != this.FEffState);
      }
      
      protected function ProcessorOnEffectText(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2,param3,param4);
      }
      
      protected function ProcessorOnShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(param1,param2,param3,param4,param5);
         }
      }
      
      protected function OnOpenChgSoul(param1:MouseEvent) : void
      {
         this.FProcessorWindowChangeSoul.Visible = true;
         BarrierActuate(this.FProcessorWindowChangeSoul);
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnReturnMainScene() : Function
      {
         return this.FOnReturnMainScene;
      }
      
      public function set OnEffectSoul(param1:Function) : void
      {
         this.FOnEffectSoul = param1;
      }
      
      public function get OnEffectSoul() : Function
      {
         return this.FOnEffectSoul;
      }
      
      public function set OnUpdateHerosBaseAttributeReq(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      public function get OnUpdateHerosBaseAttributeReq() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_Hidden;
      }
      
      override public function ShortcutModesSetup(param1:TLobbyShortcutModes) : void
      {
         var _loc2_:TLobbyShortcutAvatarModes = null;
         var _loc3_:TLobbyShortcutActivityModes = null;
         var _loc4_:TLobbyShortcutActiveSpecialModes = null;
         var _loc5_:TLobbyShortcutFunctionModes = null;
         var _loc6_:TLobbyShortcutMapModes = null;
         var _loc7_:TLobbyShortcutQuestGuideModes = null;
         var _loc8_:TLobbyShortcutConstantlyModes = null;
         if(param1 is TLobbyShortcutAvatarModes)
         {
            _loc2_ = param1 as TLobbyShortcutAvatarModes;
            _loc2_.ShortcutModeAvatar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutActivityModes)
         {
            _loc3_ = param1 as TLobbyShortcutActivityModes;
            _loc3_.SetAllShortcutHide();
         }
         if(param1 is TLobbyShortcutActiveSpecialModes)
         {
            _loc4_ = param1 as TLobbyShortcutActiveSpecialModes;
            _loc4_.ShortcutModeCDK = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutFunctionModes)
         {
            _loc5_ = param1 as TLobbyShortcutFunctionModes;
            _loc5_.ShortcutModeHero = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeStar = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTacticalDeployment = TLobbyShortcutMode.SHORTCUTMODE_Show;
            _loc5_.ShortcutModeInheritPractice = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeBackpack = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTreasure = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeSummonPet = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeMail = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeOrganiZation = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc5_.ShortcutModeReturn = TLobbyShortcutMode.SHORTCUTMODE_Show;
         }
         if(param1 is TLobbyShortcutMapModes)
         {
            _loc6_ = param1 as TLobbyShortcutMapModes;
            _loc6_.ShortcutModeMap = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc6_.ShortcutModeReturnHome = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutQuestGuideModes)
         {
            _loc7_ = param1 as TLobbyShortcutQuestGuideModes;
            _loc7_.ShortcutMode = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
         if(param1 is TLobbyShortcutConstantlyModes)
         {
            _loc8_ = param1 as TLobbyShortcutConstantlyModes;
            _loc8_.ShortcutModeStrengthen = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeArena = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeBigDipper = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeMentorship = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
            _loc8_.ShortcutModeTongLing = TLobbyShortcutMode.SHORTCUTMODE_Hidden;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         var _loc2_:TPacket = null;
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         if(param1 != null)
         {
            this.PacketPerform_SC_Enter_Tavern(param1);
         }
         if(this.FIsInit == false)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Tavern);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernReportListReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         else
         {
            this.EnterTavern();
         }
         TutorialNextStep(1401);
         this.ProcessorResize();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FIsInit)
         {
            TutorialNextStep(1402);
         }
      }
   }
}

