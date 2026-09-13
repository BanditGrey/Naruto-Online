package Processors.Game.Lobby.Pet
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TPetMonster;
   import Logics.DatebaseVO.VO.TPetMonsterExp;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Logics.Streamization.Pet.TUnstreamizerPet;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Pet.TOverlayerPet;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EFFECT;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PET;
   import Resources.Constants.CONST_POPTIPS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_PET;
   import Resources.Strings.STRING_SOULFORMATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TProcessorPet extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Pet:uint = 620;
      
      protected static const SIZE_HIGHT_Pet:uint = 550;
      
      protected static const STAGENUMBERS:uint = 5;
      
      protected static const SOUL_LIMIT:uint = 72;
      
      protected static const TEMPNUMBER:uint = 18300000;
      
      protected static const CAPACITY_ParallelOutputRows:uint = 0;
      
      protected static const COLOR_CRIT:uint = 65280;
      
      protected static const COLOR_BIGCRIT:uint = 16711680;
      
      protected var FHelpTips:THint;
      
      protected var FProcessorWindowTrainPetSoul:TProcessorWindowTrainPetSoul;
      
      protected var FProcessorWindowChangeBody:TProcessorWindowChangeBody;
      
      protected var FProcessorWindowPetLevel:TProcessorWindowPetLevel;
      
      protected var FProcessorWindowSoulFormation:TProcessorWindowSoulFormation;
      
      protected var FProcessorWindowSummonPet:TProcessorWindowSummonPet;
      
      protected var FBoundsPet:TBounds;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FPet:TPet;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FPetBin:TBins;
      
      protected var FPetMonster:TBins;
      
      protected var FPetMonsterExp:TBins;
      
      protected var FImageBin:TBins;
      
      protected var FRoleModle:TBins;
      
      protected var FStringID:uint;
      
      protected var FOverlayerPet:TOverlayerPet;
      
      protected var FlightTemp:uint;
      
      protected var FSoulID:uint;
      
      protected var FStageIndex:uint;
      
      protected var FStages:Array;
      
      protected var FBackGround:Sprite;
      
      protected var FBT_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FMC_Left:MovieClip;
      
      protected var FMC_Right:MovieClip;
      
      protected var FMCTab:TUITab;
      
      protected var FBoo:Boolean;
      
      protected var FHint:THint;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnstreamizerPet:TUnstreamizerPet;
      
      protected var FEffectTextParameters:TEffectTextParameters;
      
      protected var FInitialization:Boolean;
      
      protected var Flayer:Sprite;
      
      protected var FTabIndex:uint;
      
      protected var FCanSeeLevel:int;
      
      protected var FCanClickLevel:int;
      
      protected var FRelaxOrNot:Function;
      
      protected var FChangeBody:Function;
      
      protected var FUpStar:Function;
      
      protected var FUnLuck:Function;
      
      protected var FOnDailytaskUpdate:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public var GotoAddSoul:Function;
      
      public function TProcessorPet(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FHelpTips = new THint();
         this.Flayer = new Sprite();
         addChild(this.Flayer);
         this.FUnstreamizerPet = new TUnstreamizerPet();
         this.FHint = new THint();
         this.FStages = new Array();
         this.FMCTab = new TUITab(this);
         this.FEffectTextParameters = new TEffectTextParameters();
         this.FEffectTextParameters.Font.Color = CONST_EFFECT.COLOR_EffectText;
         this.FProcessorWindowPetLevel = new TProcessorWindowPetLevel(this);
         this.FProcessorWindowPetLevel.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowPetLevel.HintOnOverPet = this.UIComponentsHintOnOverPet;
         this.FProcessorWindowPetLevel.HintOnOutPet = this.UIComponentsHintOnOutPet;
         this.FProcessorWindowPetLevel.HintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowPetLevel.OnEffectText = ProcessorsOnEffectText;
         this.FProcessorWindowPetLevel.TrainPet = this.TrainPet;
         this.FProcessorWindowPetLevel.UpStar = this.UpStars;
         this.FStages[0] = this.FProcessorWindowPetLevel;
         this.FProcessorWindowChangeBody = new TProcessorWindowChangeBody(this);
         this.FProcessorWindowChangeBody.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowChangeBody.HintOnOut = this.UIComponentsHintOnOut1;
         this.FStages[1] = this.FProcessorWindowChangeBody;
         this.FProcessorWindowTrainPetSoul = new TProcessorWindowTrainPetSoul(this);
         this.FProcessorWindowTrainPetSoul.HintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowTrainPetSoul.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowTrainPetSoul.OnClickTrainSoul = this.ProcessorTrainSoul;
         this.FProcessorWindowTrainPetSoul.OnEffectText = ProcessorsOnEffectText;
         this.FStages[2] = this.FProcessorWindowTrainPetSoul;
         this.FProcessorWindowSoulFormation = new TProcessorWindowSoulFormation(this);
         this.FProcessorWindowSoulFormation.OnGetBox = this.ProcessorOnGetBoxClick;
         this.FProcessorWindowSoulFormation.OnBuyBox = ProcessorOnBuyBoxClick;
         this.FProcessorWindowSoulFormation.OnShowHtmlTip = ProcessorOnShowHtmlText;
         this.FProcessorWindowSoulFormation.OnHideHtmlTip = ProcessorOnHideHtmlText;
         this.FProcessorWindowSoulFormation.GotoAddSoul = this.ProcessorOnGotoAddSoul;
         this.FStages[3] = this.FProcessorWindowSoulFormation;
         this.FProcessorWindowSummonPet = new TProcessorWindowSummonPet(this);
         this.FProcessorWindowSummonPet.HintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowSummonPet.HintOnOut = this.UIComponentsHintOnOut1;
         this.FStages[4] = this.FProcessorWindowSummonPet;
         this.FProcessorWindowPetLevel.X = 314;
         this.FProcessorWindowPetLevel.Y = 100;
         this.FProcessorWindowChangeBody.X = 314;
         this.FProcessorWindowChangeBody.Y = 100;
         this.FProcessorWindowTrainPetSoul.X = 314;
         this.FProcessorWindowTrainPetSoul.Y = 100;
         this.FProcessorWindowSoulFormation.X = 314;
         this.FProcessorWindowSoulFormation.Y = 100;
         this.FProcessorWindowSummonPet.X = 314;
         this.FProcessorWindowSummonPet.Y = 100;
         this.FBoundsPet = new TBounds();
         this.FBoundsPet.Width = SIZE_WIDTH_Pet;
         this.FBoundsPet.Height = SIZE_HIGHT_Pet;
         this.FPet = SLogicsCore.Character.Pet;
         this.FCharacter = SLogicsCore.Character;
         SetUIModuleID(CONST_MODULES.MODULE_Pet);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PET.RESOURCESID_PET);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         this.FBackGround = TUtilityReflection.CreateDisplayObjectInstance(CONST_PET.RESOURCE_ClassName_Pet) as Sprite;
         this.Flayer.addChild(this.FBackGround);
         _loc1_ = 0;
         while(_loc1_ < STAGENUMBERS)
         {
            _loc2_ = this.FBackGround[CONST_PET.RESOURCE_Link_MC_Tabs + _loc1_];
            this.FMCTab.SetTabByIndex(_loc2_,_loc1_);
            _loc1_++;
         }
         this.FMCTab.OnSwitch = this.ItemTabOnSwitch;
         this.FMCTab.Init();
         this.FMCTab.SetTabEnabledByIndex(2,false);
         this.FMCTab.SetTabHideByIndex(4);
         this.FBtn_Help = this.FBackGround[CONST_PET.RESOURCE_Link_Btn_Help];
         this.FBT_Close = this.FBackGround[CONST_PET.RESOURCE_Link_BT_Close];
         this.FMC_Left = this.FBackGround[CONST_PET.RESOURCE_Link_MC_Left];
         this.FMC_Right = this.FBackGround[CONST_PET.RESOURCE_Link_MC_Right];
         this.FBackGround.x = (CONST_COMMON.STAGE_Width - this.FBoundsPet.Width) / 2;
         this.FBackGround.y = (CONST_COMMON.STAGE_Height - this.FBoundsPet.Height) / 2;
         this.FOverlayerPet = new TOverlayerPet(this);
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerPet.Visible = false;
         FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerPet);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         this.FInitialization = true;
         this.GetConfigValue();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBT_Close.addEventListener(MouseEvent.CLICK,this.CloseOnCloseWindow);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBackGround["MC_Tab_3"].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnShowTip);
         this.FBackGround["MC_Tab_3"].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FMCTab.OnOver = this.UITabOnOver;
         this.FMCTab.OnOut = this.UITabOnOut;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FSystemLanguageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         this.FPetMonster = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PetMonster);
         this.FPetBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BasePet);
         this.FPetMonsterExp = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PetMonsterExp);
         this.FImageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PetImage);
         this.FRoleModle = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FProcessorWindowPetLevel.PetBin = this.FPetBin;
         this.FProcessorWindowPetLevel.ImageBin = this.FImageBin;
         this.FProcessorWindowChangeBody.ImageBin = this.FImageBin;
         this.FProcessorWindowChangeBody.BasePetBin = this.FPetBin;
         this.FProcessorWindowChangeBody.RoleModel = this.FRoleModle;
         this.FProcessorWindowTrainPetSoul.PetMonsterBin = this.FPetMonster;
         this.FProcessorWindowTrainPetSoul.PetMonsterExpBin = this.FPetMonsterExp;
         this.FProcessorWindowPetLevel.RoleModle = this.FRoleModle;
         this.FProcessorWindowSummonPet.BasePetBin = this.FPetBin;
         this.FProcessorWindowSummonPet.ImageBin = this.FImageBin;
         this.FProcessorWindowSummonPet.RoleModle = this.FRoleModle;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_PetInfoResponse,this.PerformPacket_SC_PetInfoResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_PetTrainResponse,this.PerformPacket_SC_PetTrainResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ChangePetResponse,this.PerformPacket_SC_ChangePetResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_UnLuckResponse,this.PerformPacket_SC_UnLuckResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_TrainSoulResponse,this.PerformPacket_SC_TrainSoulResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RelaxOrNotResponse,this.PerformPacket_SC_RelaxOrNotResponse);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SoulFormationCommandRet,this.ProcessorOnCommonRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Pet_Item_Unlock_Ret,this.PerformPacket_SC_PetItemUnlockRet);
      }
      
      protected function UITabOnOver(param1:Object, param2:uint, param3:Boolean) : void
      {
         var _loc4_:TUITab = null;
         var _loc5_:MovieClip = null;
         if(!param3 && param2 == 2)
         {
            _loc4_ = param1 as TUITab;
            _loc5_ = _loc4_.GetTabByIndex(param2);
            if(_loc5_.currentFrame != TUITab.RENDERINGSTATE_Disabled)
            {
               return;
            }
            this.FHint.Caption = STRING_PET.STRING_SoulLimit;
            this.UIComponentsHintOnOver1(this,this.FHint);
         }
      }
      
      protected function UITabOnOut(param1:Object, param2:uint, param3:Boolean) : void
      {
         if(!param3 && param2 == 2)
         {
            this.UIComponentsHintOnOut1(this);
         }
      }
      
      protected function PerformPacket_SC_PetInfoResponse(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerPet.Unstreamize(_loc2_,this.FPet,null);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PlayAnimation();
         this.FSoulID = this.FlightTemp = this.FPet.SoulID;
         this.FProcessorWindowPetLevel.Init();
         this.FProcessorWindowChangeBody.UpdateBox();
         this.FProcessorWindowTrainPetSoul.UpdateSoul();
         this.FProcessorWindowTrainPetSoul.BatchBT();
         this.FProcessorWindowTrainPetSoul.SetLayer();
         this.FProcessorWindowSoulFormation.UpdateUI();
         this.FProcessorWindowPetLevel.Visible = Boolean(this.FTabIndex == 0);
         this.FProcessorWindowChangeBody.Visible = Boolean(this.FTabIndex == 1);
         this.FProcessorWindowTrainPetSoul.Visible = Boolean(this.FTabIndex == 2);
         this.FProcessorWindowSoulFormation.Visible = Boolean(this.FTabIndex == 3);
         this.FProcessorWindowSummonPet.Visible = Boolean(this.FTabIndex == 4);
         if(this.FCharacter.MainHero.Level >= SOUL_LIMIT)
         {
            this.FMCTab.GetTabByIndex(2).gotoAndStop(TUITab.RENDERINGSTATE_UnSelect);
         }
         this.FMCTab.TabIndex = this.FTabIndex;
         TutorialNextStep(900);
         this.UpdateTab();
      }
      
      protected function PerformPacket_SC_PetTrainResponse(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         this.FProcessorWindowPetLevel.SetBtDisable(true);
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            SLogicsCore.Character.MaxTempValue = 0;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FPet.PetID = _loc3_.readUnsignedInt();
         _loc4_ = int(_loc3_.readUnsignedInt());
         this.FPet.CurrentExp = _loc4_;
         this.FPet.SmallCritCount = _loc3_.readUnsignedByte();
         this.FPet.BigCritCount = _loc3_.readUnsignedByte();
         _loc5_ = int(_loc3_.readUnsignedInt());
         this.FPet.GainExp = _loc5_;
         this.FloatingWord();
         this.FProcessorWindowPetLevel.Update();
         if(this.FCharacter.MainHero.Level >= 72 && this.FPet.ReviceCount >= 2)
         {
            this.FProcessorWindowTrainPetSoul.UpdateSoul();
         }
         SLogicsCore.Character.MaxTempValue = 0;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function FloatingWord() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         switch(this.FPet.TrainTimes)
         {
            case 1:
               if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 0)
               {
                  EffectGenerateText(TUtilityString.Format(STRING_PET.FORMAT_NoCrit,this.FPet.GainExp));
               }
               if(this.FPet.SmallCritCount == 1 && this.FPet.BigCritCount == 0)
               {
                  _loc1_ = TUtilityString.Format(STRING_PET.FORMAT_OneSmallCrit,this.FPet.GainExp);
                  _loc2_ = 0;
                  this.SetColour(_loc1_,_loc2_);
               }
               if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 1)
               {
                  this.FStringID = CONST_SYSTEMLANGUAGE.PET_STRING_04;
                  this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
                  _loc1_ = this.FSystemLanguage.Desc;
                  _loc2_ = 1;
                  this.SetColour(_loc1_,_loc2_);
               }
               break;
            case 50:
            case 200:
            case 500:
            case 1000:
               if(this.FPet.SmallCritCount >= 1 && this.FPet.BigCritCount >= 1)
               {
                  _loc1_ = TUtilityString.Format(STRING_PET.FORMAT_GoodRP,this.FPet.SmallCritCount,this.FPet.BigCritCount,this.FPet.GainExp);
                  EffectGenerateText(_loc1_);
               }
               if(this.FPet.SmallCritCount != 0 && this.FPet.BigCritCount == 0)
               {
                  _loc1_ = TUtilityString.Format(STRING_PET.FORMAT_SeveralSmallCrit,this.FPet.SmallCritCount,this.FPet.GainExp);
                  _loc2_ = 0;
                  this.SetColour(_loc1_,_loc2_);
               }
               if(this.FPet.BigCritCount != 0 && this.FPet.SmallCritCount == 0)
               {
                  _loc1_ = TUtilityString.Format(STRING_PET.FORMAT_SeveralBigCrit,this.FPet.BigCritCount,this.FPet.GainExp);
                  _loc2_ = 1;
                  this.SetColour(_loc1_,_loc2_);
               }
               if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 0)
               {
                  EffectGenerateText(TUtilityString.Format(STRING_PET.FORMAT_NoRP,this.FPet.GainExp));
               }
         }
      }
      
      protected function SoulFloatingWord(param1:int, param2:int, param3:String, param4:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(this.FPet.TrainTimes == 1)
         {
            if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 0)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_01;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               EffectGenerateText(TUtilityString.Format(this.FSystemLanguage.Desc,param3,param4));
            }
            if(this.FPet.SmallCritCount == 1 && this.FPet.BigCritCount == 0)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_03;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               _loc5_ = TUtilityString.Format(this.FSystemLanguage.Desc,param1,param3,param4);
               _loc6_ = 0;
               this.SetColour(_loc5_,_loc6_);
            }
            if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 1)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_04;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               _loc5_ = TUtilityString.Format(this.FSystemLanguage.Desc,param2,param3);
               _loc6_ = 1;
               this.SetColour(_loc5_,_loc6_);
            }
         }
         else
         {
            if(this.FPet.SmallCritCount >= 1 && this.FPet.BigCritCount >= 1)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_05;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               _loc5_ = TUtilityString.Format(this.FSystemLanguage.Desc,param1,param2,param4);
               this.SetColour(_loc5_,1);
            }
            if(this.FPet.SmallCritCount != 0 && this.FPet.BigCritCount == 0)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_06;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               _loc5_ = TUtilityString.Format(this.FSystemLanguage.Desc,param1,param4);
               this.SetColour(_loc5_,0);
            }
            if(this.FPet.BigCritCount != 0 && this.FPet.SmallCritCount == 0)
            {
               this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_07;
               this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
               _loc5_ = TUtilityString.Format(this.FSystemLanguage.Desc,param2,param4);
               this.SetColour(_loc5_,1);
            }
            if(this.FPet.SmallCritCount == 0 && this.FPet.BigCritCount == 0)
            {
               _loc7_ = STRING_PET.FORMAT_UpgradeSuccess;
               _loc7_ = _loc7_.split("%name%").join(param3);
               _loc7_ = _loc7_.split("%exp%").join(param4);
               EffectGenerateText(_loc7_);
            }
         }
      }
      
      protected function SetColour(param1:String, param2:uint) : void
      {
         EffectGenerateText(param1);
      }
      
      protected function PerformPacket_SC_ChangePetResponse(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         this.FProcessorWindowChangeBody.SetChangBtNormal();
         this.FProcessorWindowSummonPet.SetChangBtNormal();
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FStringID = CONST_SYSTEMLANGUAGE.PET_STRING_09;
         this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
         EffectGenerateText(this.FSystemLanguage.Desc);
         this.FProcessorWindowPetLevel.ChangeBody();
         if(this.FTabIndex == 4)
         {
            this.FProcessorWindowSummonPet.OnChangeBody();
         }
         if(this.FChangeBody != null)
         {
            this.FChangeBody(this);
         }
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this);
         }
      }
      
      protected function PerformPacket_SC_RelaxOrNotResponse(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         this.FProcessorWindowPetLevel.SetBtDisable(true);
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         if(this.FPet.RelexBoo == true)
         {
            this.FStringID = CONST_SYSTEMLANGUAGE.PET_STRING_10;
            this.FProcessorWindowPetLevel.PetRelax = STRING_PET.STRING_Used;
         }
         else
         {
            this.FStringID = CONST_SYSTEMLANGUAGE.PET_STRING_11;
            this.FProcessorWindowPetLevel.PetRelax = STRING_PET.STRING_UnUse;
         }
         if(this.FRelaxOrNot != null)
         {
            this.FRelaxOrNot(this);
         }
         this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
         EffectGenerateText(this.FSystemLanguage.Desc);
      }
      
      protected function PerformPacket_SC_UnLuckResponse(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         this.FProcessorWindowPetLevel.SetBtDisable(true);
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FPet.PetID = _loc3_.readUnsignedInt();
         this.FProcessorWindowPetLevel.UnLuckUpdate();
         this.FProcessorWindowChangeBody.UpdateUnLuck();
         this.FProcessorWindowTrainPetSoul.SetLayer();
         if(this.FUnLuck != null)
         {
            this.FUnLuck(this);
         }
      }
      
      protected function PerformPacket_SC_TrainSoulResponse(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TPetMonsterExp = null;
         var _loc7_:TPetMonsterExp = null;
         var _loc8_:TPetMonster = null;
         var _loc9_:TPetMonster = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TPetMonster = null;
         this.FProcessorWindowTrainPetSoul.SetBtDisable(true);
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            SLogicsCore.Character.MaxTempValue = 0;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FPet.SoulID = _loc3_.readUnsignedInt();
         _loc4_ = int(_loc3_.readUnsignedInt());
         this.FPet.CurrentSoulExp = _loc4_;
         this.FPet.SmallCritCount = _loc3_.readUnsignedShort();
         this.FPet.BigCritCount = _loc3_.readUnsignedShort();
         _loc5_ = int(_loc3_.readUnsignedInt());
         this.FPet.GainExp = _loc5_;
         _loc6_ = this.FPetMonsterExp.GetDatebaseByIdentifier(this.FPet.SoulID) as TPetMonsterExp;
         _loc10_ = uint(_loc6_.MonsterId);
         _loc8_ = this.FPetMonster.GetDatebaseByIdentifier(_loc10_) as TPetMonster;
         if(this.FSoulID != this.FPet.SoulID)
         {
            _loc7_ = this.FPetMonsterExp.GetDatebaseByIdentifier(this.FSoulID) as TPetMonsterExp;
            _loc10_ = uint(_loc7_.MonsterId);
            _loc9_ = this.FPetMonster.GetDatebaseByIdentifier(_loc10_) as TPetMonster;
            this.FStringID = CONST_SYSTEMLANGUAGE.PETSOUL_FORMAT_02;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(this.FStringID) as TSystemLanguage;
            EffectGenerateText(TUtilityString.Format(this.FSystemLanguage.Desc,_loc9_.Name));
            this.FSoulID = this.FPet.SoulID;
         }
         if(this.FPet.BigCritCount != 0)
         {
            _loc11_ = Math.floor((this.FPet.SoulID - 18300000) / 1000);
            if(_loc11_ == 1)
            {
               _loc11_ = 6;
            }
            else
            {
               _loc11_--;
            }
            _loc11_ = 18300000 + _loc11_ * 1000;
            _loc12_ = this.FPetMonster.GetDatebaseByIdentifier(_loc11_) as TPetMonster;
            this.SoulFloatingWord(this.FPet.SmallCritCount,this.FPet.BigCritCount,_loc12_.Name,this.FPet.GainExp);
         }
         else
         {
            this.SoulFloatingWord(this.FPet.SmallCritCount,this.FPet.BigCritCount,_loc8_.Name,this.FPet.GainExp);
         }
         if(this.FPet.SoulID > this.FlightTemp)
         {
            this.FlightTemp = this.FPet.SoulID;
            this.FProcessorWindowTrainPetSoul.LighBoo = true;
         }
         else if(Math.floor((this.FPet.SoulID - TEMPNUMBER) / 1000) == 1 && this.FPet.SoulID < this.FlightTemp)
         {
            this.FlightTemp = this.FPet.SoulID;
            this.FProcessorWindowTrainPetSoul.LighBoo = true;
         }
         this.FProcessorWindowTrainPetSoul.UpdateSoul();
         SLogicsCore.Character.MaxTempValue = 0;
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_SummonPet);
         }
      }
      
      protected function UpdateTab() : void
      {
         if(this.FCharacter.MainHero.Level >= this.FCanSeeLevel)
         {
            this.FBackGround["MC_Tab_3"].visible = true;
         }
         else
         {
            this.FBackGround["MC_Tab_3"].visible = false;
         }
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SoulFormationCommandReq);
         _loc3_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc3_.Data.writeShort(0);
         }
         else
         {
            _loc6_ = int(param2.length);
            _loc3_.Data.writeShort(_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_.Data.writeUnsignedInt(param2[_loc5_]);
               _loc5_++;
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ItemTabOnSwitch(param1:int) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < STAGENUMBERS)
         {
            this.FStages[_loc2_].Visible = false;
            _loc2_++;
         }
         if(param1 == 1)
         {
            this.FStages[param1].Visible = true;
            this.FProcessorWindowChangeBody.UpdateBox();
         }
         if(param1 == 3)
         {
            if(this.FCharacter.MainHero.Level >= this.FCanClickLevel)
            {
               this.FTabIndex = param1;
               this.FStages[param1].Visible = true;
               this.FProcessorWindowSoulFormation.UpdateUI();
               return;
            }
            this.FMCTab.SwithTagManual(this.FTabIndex);
            return;
         }
         if(param1 == 4)
         {
            this.FProcessorWindowSummonPet.UpdateBox();
         }
         this.FTabIndex = param1;
         this.FStages[param1].Visible = true;
      }
      
      protected function CloseOnCloseWindow(param1:MouseEvent) : void
      {
         ProcessorClose();
         TutorialNextStep(902);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_SummonPet) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function ProcessorOnShowTip(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FCharacter.MainHero.Level >= this.FCanClickLevel)
         {
            return;
         }
         _loc2_ = TUtilityString.Format(STRING_PET.FORMAT_UnlockLevel,STRING_COMMON.GetLevelStrByLevelLineFeed(this.FCanClickLevel));
         ProcessorOnShowHtmlText(_loc2_);
      }
      
      protected function ProcessorTrainSoul(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(param1 == 0)
         {
            return;
         }
         SLogicsCore.Character.MaxTempValue = 1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TrainSoulRequest);
         _loc3_ = _loc2_.Data;
         _loc3_.writeShort(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function TrainPet(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         SLogicsCore.Character.MaxTempValue = 1;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_PetTrainRequest);
         _loc4_ = _loc3_.Data;
         _loc4_.writeShort(param2);
         _loc4_.writeByte(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:THint) : void
      {
         this.FOverlayerPet.Context = param2;
         this.FOverlayerPet.Render(FUICore.MouseCoordinate);
         this.FOverlayerPet.Visible = true;
      }
      
      protected function UIComponentsHintOnOverPet(param1:Object, param2:THint) : void
      {
         this.FOverlayerPet.Context = param2;
         this.FOverlayerPet.Render(FUICore.MouseCoordinate);
         this.FOverlayerPet.Visible = true;
      }
      
      protected function UIComponentsHintOnOutPet(param1:Object) : void
      {
         this.FOverlayerPet.Visible = false;
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         this.FOverlayerPet.Visible = false;
      }
      
      protected function UpStars(param1:Object) : void
      {
         if(this.FUpStar != null)
         {
            this.FUpStar(this);
         }
      }
      
      protected function PlayAnimation() : void
      {
         this.FMC_Left.gotoAndPlay(1);
         this.FMC_Right.gotoAndPlay(1);
      }
      
      protected function CharacterLoadPet() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_PetInfoRequest);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         if(param1 != null)
         {
            this.FTabIndex = param1.readUnsignedInt();
         }
      }
      
      protected function GetConfigValue() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BasePetOpenZhuan) as TConfigValue;
         _loc1_ = uint(_loc2_.Value as int);
         if(this.FProcessorWindowTrainPetSoul)
         {
            this.FProcessorWindowTrainPetSoul.SetOpenLevel = _loc1_;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000019) as TConfigValue;
         this.FCanSeeLevel = _loc2_.Value as int;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000020) as TConfigValue;
         this.FCanClickLevel = _loc2_.Value as int;
      }
      
      override protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(FIsClicked)
         {
            return;
         }
         FIsClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         this.PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnGotoAddSoul() : void
      {
         this.CloseOnCloseWindow(null);
         if(this.GotoAddSoul != null)
         {
            this.GotoAddSoul();
         }
      }
      
      public function get RelaxOrNot() : Function
      {
         return this.FRelaxOrNot;
      }
      
      public function set RelaxOrNot(param1:Function) : void
      {
         this.FRelaxOrNot = param1;
      }
      
      public function get ChangeBody() : Function
      {
         return this.FChangeBody;
      }
      
      public function set ChangeBody(param1:Function) : void
      {
         this.FChangeBody = param1;
      }
      
      public function get UpStar() : Function
      {
         return this.FUpStar;
      }
      
      public function set UpStar(param1:Function) : void
      {
         this.FUpStar = param1;
      }
      
      public function get UnLuck() : Function
      {
         return this.FUnLuck;
      }
      
      public function set UnLuck(param1:Function) : void
      {
         this.FUnLuck = param1;
      }
      
      public function get ProcessorWindowPetLevel() : TProcessorWindowPetLevel
      {
         return this.FProcessorWindowPetLevel;
      }
      
      public function get OnDailytaskUpdate() : Function
      {
         return this.FOnDailytaskUpdate;
      }
      
      public function set OnDailytaskUpdate(param1:Function) : void
      {
         this.FOnDailytaskUpdate = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPetLevel.Load();
            this.FProcessorWindowChangeBody.Load();
            this.FProcessorWindowTrainPetSoul.Load();
            this.FProcessorWindowSoulFormation.Load();
            this.FProcessorWindowSummonPet.Load();
            return;
         }
         this.CharacterLoadPet();
      }
      
      override public function Unmount() : void
      {
         this.FMCTab.Reset();
         this.FTabIndex = 0;
         super.Unmount();
      }
      
      protected function ProcessorOnCommonRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         FIsClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case TProcessorWindowSoulFormation.REQ_OF_ACTIVE:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FPet.ActiveSoulFormation(_loc5_);
               _loc10_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_001).DescribeString;
               EffectGenerateText(_loc10_);
               this.FProcessorWindowSoulFormation.UpdateUI();
               break;
            case TProcessorWindowSoulFormation.REQ_OF_OPEN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FPet.OpenSoulFormation(_loc5_);
               _loc10_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_003).DescribeString;
               EffectGenerateText(_loc10_);
               this.FProcessorWindowSoulFormation.UpdateUI();
               break;
            case TProcessorWindowSoulFormation.REQ_OF_CANCEL:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this.FPet.CurSoulFormationID = 0;
               this.FPet.ActiveSoulFormation(_loc5_);
               this.FProcessorWindowSoulFormation.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_PetItemUnlockRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
      }
   }
}

