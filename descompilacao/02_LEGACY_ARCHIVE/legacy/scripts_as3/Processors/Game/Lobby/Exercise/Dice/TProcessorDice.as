package Processors.Game.Lobby.Exercise.Dice
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.Dice.TDice;
   import Logics.Exercise.Dice.TDiceLog;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDice;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.Dice.Compoents.TUIBar;
   import Processors.Game.Lobby.Exercise.Dice.Compoents.TUIRank;
   import Processors.Game.Lobby.Exercise.Dice.Compoents.TUITable;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_DICE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_DICE;
   import Resources.Strings.STRING_Ramen;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorDice extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH:uint = 839;
      
      protected static const SIZE_HEIGHT:uint = 483;
      
      public static const INIT_X:int = 0;
      
      public static const INIT_Y:int = 0;
      
      public static const NOT_BEGIN:int = TDice.NOT_BEGIN;
      
      public static const NEED_GET_REWARD:int = TDice.NEED_GET_REWARD;
      
      public static const WAIT_FOR_SELECT:int = TDice.WAIT_FOR_SELECT;
      
      public static const GET_RESULT:int = TDice.GET_RESULT;
      
      public static const WAIT_FOR_WRONG:int = TDice.WAIT_FOR_WRONG;
      
      public static const BEGIN_GAME_AGAIN:int = TDice.BEGIN_GAME_AGAIN;
      
      public static const CHOICE_NONE:int = TDice.CHOICE_NONE;
      
      public static const CHOICE_SMALL:int = TDice.CHOICE_SMALL;
      
      public static const CHOICE_BIG:int = TDice.CHOICE_BIG;
      
      public static const RESULT_LOSE:int = TDice.RESULT_LOSE;
      
      public static const RESULT_WIN:int = TDice.RESULT_WIN;
      
      public static const RESULT_NONE:int = TDice.RESULT_NONE;
      
      public static const TYPE_BUY:int = TDice.TYPE_BUY;
      
      public static const TYPE_NO_BUY:int = TDice.TYPE_NO_BUY;
      
      public static const GOLD_FOR_WRONG:int = 0;
      
      public static const GOLD_FOR_LIFE:int = 1;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const TYPE_NORMAL_START:int = 0;
      
      public static const TYPE_WIN_START:int = 1;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Log:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FEndTime:int;
      
      protected var FUIBar:TUIBar;
      
      protected var FUIRank:TUIRank;
      
      protected var FUITable:TUITable;
      
      protected var FBounds:TBounds;
      
      protected var FDelayTimeID:int;
      
      protected var FEndTimeID:int;
      
      protected var FTimeID:int;
      
      protected var FDice:TDice;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerDice:TUnstreamizerDice;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationStartWin:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationBuyWrong:TUIWindowConfirmationBuyWrong;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FProcessorWindowDiceLog:TProcessorWindowDiceLog;
      
      protected var FHelpTips:THint;
      
      protected var FStartType:int;
      
      protected var FIsMoviePlay:Boolean;
      
      protected var FOnOpenActivity:Function;
      
      protected var FCheckEffect:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      public function TProcessorDice(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FDice = SLogicsCore.Dice;
         this.FUnstreamizerDice = new TUnstreamizerDice();
         this.FHelpTips = new THint();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FInitialized = false;
         this.FBounds = new TBounds();
         this.FBounds.Width = SIZE_WIDTH;
         this.FBounds.Height = SIZE_HEIGHT;
         ComponentBoundsCenter(this,this.FBounds);
         this.FUIWindowConfirmationBuyWrong = new TUIWindowConfirmationBuyWrong(this.Parent);
         this.FUIWindowConfirmationBuyWrong.OnOK = this.WindowConfirmationBuyWrongOnOK;
         this.FUIWindowConfirmationBuyWrong.OnCancel = this.WindowCofirmationBuyWrongOnCancel;
         this.FUIWindowConfirmationBuyWrong.Visible = false;
         this.FProcessorWindowDiceLog = new TProcessorWindowDiceLog(this.Parent);
         this.FProcessorWindowDiceLog.OnCloseUp = this.ProcessorOnCloseLog;
         this.FProcessorWindowDiceLog.Visible = false;
         this.FIsMoviePlay = true;
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_DICE.RESOURCESID_SWF_DICE);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DICE.RESOURCE_ClassName_Dice) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_EffectLeft = this.FMC_Scene[CONST_DICE.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Scene[CONST_DICE.RESOURCE_Link_MC_EffectRight];
         this.FBTN_Close = this.FMC_Scene[CONST_DICE.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = this.FMC_Scene[CONST_DICE.RESOURCE_Link_BTN_Help];
         this.FBTN_Log = this.FMC_Scene[CONST_DICE.RESOURCE_Link_BTN_Log];
         this.FTF_Time = this.FMC_Scene[CONST_DICE.RESOURCE_Link_TF_Time];
         this.FUIBar = new TUIBar(this);
         this.FUIBar.Perform_UIDispatch(this.FMC_Scene["MC_AccumBar"]);
         this.FUIBar.OnGetReward = this.PerformPacket_CS_GetRewardReq;
         this.FUIBar.OnItemOver = UIComponentsHintOnOver;
         this.FUIBar.OnItemOut = UIComponentsHintOnOut;
         this.FUIRank = new TUIRank(this);
         this.FUIRank.Perform_UIDispatch(this.FMC_Scene["MC_Rank"]);
         this.FUIRank.OnNameUp = this.ProcessorOnShowHeroInfo;
         this.FUITable = new TUITable(this);
         this.FUITable.Perform_UIDispatch(this.FMC_Scene["MC_Table"]);
         this.FUITable.OnStart = this.ProcessorOnStart;
         this.FUITable.OnChoice = this.PerformPacket_CS_ChoiceReq;
         this.FUITable.OnLose = this.ProcessorOnConfirmLose;
         this.FUITable.OnContiue = this.PerformPacket_CS_StartReq;
         this.FUITable.OnResultMovieEnd = this.ProcessorOnResultMovieEnd;
         this.FUITable.OnShowGotoRecharge = this.ProcessorOnShowGotoRecharge;
         this.FUITable.TipOnOver = ProcessorTipOnOver;
         this.FUITable.TipOnOut = ProcessorTipOnOut;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationBuyLifeOnOK;
         this.FUIWindowConfirmation.OnCancel = this.WindowCofirmationOnCancel;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowConfirmationStartWin = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationStartWin.OnOK = this.WindowConfirmationStartWinOnOK;
         this.FUIWindowConfirmationStartWin.Visible = false;
         this.FUIWindowConfirmationStartWin.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationStartWin.WindowWidth) / 2;
         this.FUIWindowConfirmationStartWin.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationStartWin.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationStartWin);
         this.FUIWindowConfirmationStartWin.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         this.FUIWindowRecharge.OnCancel = this.WindowRechargeOnClose;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         FOverlayerHelpTips.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         this.FInitialized = true;
         if(this.FMC_Scene.MC_End)
         {
            this.FMC_Scene.MC_End.visible = false;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(this.FBTN_Log,true);
         this.FBTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenLog);
         this.FMC_Scene.BTN_SelectWin.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectWinUp);
         this.FMC_Scene.BTN_SelectMovie.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectMovieUp);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
            if(this.visible)
            {
               this.FTF_Time.text = TUtilityString.Format(STRING_DICE.FORMAT_TIME,TGameUtil.fomatTime(this.FDice.EndTime - STimingCore.GetServerTick()));
               if(this.FMC_Scene.MC_End)
               {
                  if(this.FDice.WinCount >= 100)
                  {
                     this.FMC_Scene.MC_End.visible = true;
                  }
                  else
                  {
                     this.FMC_Scene.MC_End.visible = false;
                  }
               }
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         if(!this.FDice)
         {
            return;
         }
         this.FDice.CheckStatus();
         this.FUIRank.UpdateUI();
         this.FUIBar.UpdateUI();
         this.FUITable.UpdateUI();
         this.UpdateBtn();
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FStartType == TYPE_NORMAL_START)
         {
            this.FMC_Scene.BTN_SelectWin.gotoAndStop(2);
         }
         else
         {
            this.FMC_Scene.BTN_SelectWin.gotoAndStop(1);
         }
         if(this.FIsMoviePlay)
         {
            this.FMC_Scene.BTN_SelectMovie.gotoAndStop(2);
         }
         else
         {
            this.FMC_Scene.BTN_SelectMovie.gotoAndStop(1);
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_OpenActivityRet,this.PerformPacket_SC_OpenActiveRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_StartRet,this.PerformPacket_SC_StartRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_ChoiceRet,this.PerformPacket_SC_ChoiceRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_BuyWrongRet,this.PerformPacket_SC_BuyWrongRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Dice_GetRewardRet,this.PerformPacket_SC_GetRewardRet);
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FEndTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FEndTimeID = setTimeout(this.ProcessorCloseActivity,_loc1_);
         clearTimeout(this.FDelayTimeID);
      }
      
      protected function ProcessorCloseActivity() : void
      {
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_Dice,false);
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         clearTimeout(this.FEndTimeID);
         this.FEndTimeID = 0;
      }
      
      protected function SetInterval() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         _loc3_ = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = _loc3_ - STimingCore.GetServerTime() * 1000;
         this.FTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc2_);
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_Dice,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         if(this.FDelayTimeID != 0)
         {
            clearTimeout(this.FDelayTimeID);
            this.FDelayTimeID = 0;
         }
         this.FDelayTimeID = setTimeout(this.ProcessorDelayCloseActivity,10 * 1000);
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dice_LoadInfoReq);
         if(!this.FDice.LoadLog)
         {
            _loc1_.Data.writeUnsignedInt(1);
         }
         else
         {
            _loc1_.Data.writeUnsignedInt(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FUnstreamizerDice.Unstreamize(_loc2_,this.FDice,null);
         this.Visible = true;
         if(FIsResourcesLoadCompleted)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnStart() : void
      {
         if(this.FDice.Life > 0)
         {
            --this.FDice.Life;
            this.FUITable.UpdateTxt();
            this.PerformPacket_CS_StartReq();
         }
         else if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenOnce,this.FDice.DiceGold);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationBuyLifeOnOK();
         }
      }
      
      protected function WindowConfirmationBuyLifeOnOK(param1:Object = null) : void
      {
         if(!this.FDice.CheckMoney(GOLD_FOR_LIFE))
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.PerformPacket_CS_StartReq();
      }
      
      protected function WindowCofirmationOnCancel(param1:Object = null) : void
      {
         this.FUITable.UpdateUI();
      }
      
      protected function PerformPacket_CS_StartReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dice_StartReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_StartRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FUITable.UpdateBtn();
         }
         else
         {
            this.FDice.FirstNumber.length = 0;
            _loc4_ = int(_loc2_.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.FDice.FirstNumber.push(_loc2_.readUnsignedInt());
               _loc5_++;
            }
            this.FDice.Life = _loc2_.readUnsignedInt();
            if(this.FIsMoviePlay)
            {
               this.FUITable.PlayCupMovie();
            }
            else
            {
               this.FUITable.StopCupMovie();
            }
         }
      }
      
      protected function PerformPacket_CS_ChoiceReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(this.FDice.ChoiceType == CHOICE_NONE)
         {
            return;
         }
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dice_ChoiceReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(this.FDice.ChoiceType);
         _loc2_.writeInt(this.FStartType);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_ChoiceRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            this.FDice.SecondNumber.length = 0;
            _loc4_ = int(_loc2_.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.FDice.SecondNumber.push(_loc2_.readUnsignedInt());
               _loc5_++;
            }
            this.FDice.CurResult = _loc2_.readInt();
            if(this.FIsMoviePlay)
            {
               this.FUITable.PlayResultMovie();
            }
            else
            {
               this.FUITable.StopResultMovie();
            }
         }
      }
      
      protected function ProcessorOnResultMovieEnd() : void
      {
         this.FUIBar.UpdateUI();
      }
      
      protected function ProcessorOnConfirmLose() : void
      {
         if(!this.visible)
         {
            return;
         }
         if(!this.FDice.IsSelected)
         {
            if(this.FDice.CanBeWrong > 0)
            {
               this.FUIWindowConfirmationBuyWrong.Text = TUtilityString.Format(STRING_DICE.FORMAT_FREE_WRONG);
            }
            else
            {
               this.FUIWindowConfirmationBuyWrong.Text = TUtilityString.Format(STRING_DICE.FORMAT_BUY_WRONG,this.FDice.WrongGold);
            }
            this.FUIWindowConfirmationBuyWrong.Visible = true;
         }
         else
         {
            this.WindowConfirmationBuyWrongOnOK();
         }
      }
      
      protected function WindowConfirmationBuyWrongOnOK(param1:Object = null) : void
      {
         if(!this.FDice.CheckMoney(GOLD_FOR_WRONG))
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.FDice.IsBuy = TYPE_BUY;
         this.PerformPacket_CS_BuyWrongReq();
      }
      
      protected function WindowCofirmationBuyWrongOnCancel(param1:Object = null) : void
      {
         this.FDice.IsBuy = TYPE_NO_BUY;
         this.PerformPacket_CS_BuyWrongReq();
      }
      
      protected function WindowRechargeOnClose(param1:Object = null) : void
      {
         if(this.visible)
         {
            if(this.FDice.Status == WAIT_FOR_WRONG)
            {
               this.FUIWindowConfirmationBuyWrong.Visible = true;
            }
            else if(this.FDice.Status == NOT_BEGIN)
            {
               this.FUITable.UpdateBtn();
            }
         }
      }
      
      protected function PerformPacket_CS_BuyWrongReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dice_BuyWrongReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(this.FDice.IsBuy);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_BuyWrongRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            if(this.FDice.IsBuy == TYPE_NO_BUY)
            {
               this.FDice.WinCount = 0;
            }
            else if(this.FDice.CanBeWrong > 0)
            {
               --this.FDice.CanBeWrong;
            }
            this.FDice.BeginAgain();
            this.FDice.ChangeBoxStatus();
            this.FUIBar.UpdateUI();
            this.FUITable.UpdateUI();
         }
      }
      
      protected function PerformPacket_CS_GetRewardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dice_GetRewardReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_GetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:TDiceLog = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:TInventory = null;
         var _loc12_:TInventories = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
         }
         else
         {
            _loc8_ = STRING_DICE.FORMAT_GET;
            this.ProcessorEffectText(_loc8_);
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc9_ = new TDiceLog();
               _loc9_.GetTime = _loc2_.readUnsignedInt();
               _loc12_ = new TInventories();
               _loc10_.length = 0;
               _loc10_.push(_loc2_.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc12_,_loc10_);
               _loc9_.Inventories = _loc12_;
               this.FDice.DiceLogList.push(_loc9_);
               _loc4_++;
            }
            this.FDice.GetBox();
            this.FUIBar.UpdateUI();
            this.FDice.CheckStatus();
            this.FUITable.UpdateUI();
         }
      }
      
      protected function ProcessorEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      protected function ProcessorOnOpenLog(param1:MouseEvent) : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowDiceLog.Visible = true;
            this.FProcessorWindowDiceLog.UpdateUI();
         }
      }
      
      protected function ProcessorOnSelectWinUp(param1:MouseEvent) : void
      {
         if(this.FStartType == TYPE_NORMAL_START)
         {
            if(!this.FUIWindowConfirmationStartWin.IsSelected)
            {
               this.FUIWindowConfirmationStartWin.Text = this.FDice.DescListNew[0];
               this.FUIWindowConfirmationStartWin.SetCheckBox(true);
               this.FUIWindowConfirmationStartWin.Visible = true;
            }
            else
            {
               this.WindowConfirmationBuyLifeOnOK();
            }
         }
         else
         {
            this.FStartType = TYPE_NORMAL_START;
            this.FMC_Scene.BTN_SelectWin.gotoAndStop(2);
         }
      }
      
      protected function ProcessorOnSelectMovieUp(param1:MouseEvent) : void
      {
         if(this.FIsMoviePlay)
         {
            this.FIsMoviePlay = false;
            this.FMC_Scene.BTN_SelectMovie.gotoAndStop(1);
         }
         else
         {
            this.FIsMoviePlay = true;
            this.FMC_Scene.BTN_SelectMovie.gotoAndStop(2);
         }
      }
      
      protected function WindowConfirmationStartWinOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FDice.WinPrice)
         {
            this.FStartType = TYPE_WIN_START;
            this.FMC_Scene.BTN_SelectWin.gotoAndStop(1);
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnCloseLog() : void
      {
         this.FProcessorWindowDiceLog.Visible = false;
      }
      
      protected function ProcessorOnShowGotoRecharge() : void
      {
         this.FUIWindowRecharge.Visible = true;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_DICE) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function ProcessorOnShowHeroInfo(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(this,param1,param2);
         }
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      public function get CheckEffect() : Function
      {
         return this.FCheckEffect;
      }
      
      public function set CheckEffect(param1:Function) : void
      {
         this.FCheckEffect = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIWindowConfirmationBuyWrong.Load();
            this.FProcessorWindowDiceLog.Load();
            return;
         }
         this.FMC_EffectLeft.play();
         this.FMC_EffectRight.play();
         this.PerformPacket_CS_LoadInfoReq();
         this.SetInterval();
      }
      
      override public function Unmount() : void
      {
         this.FUIWindowConfirmationBuyWrong.Visible = false;
         this.FProcessorWindowDiceLog.Visible = false;
         this.FMC_EffectLeft.stop();
         this.FMC_EffectRight.stop();
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         super.Unmount();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(1);
         _loc2_.writeUnsignedInt(1371571200);
         _loc2_.writeUnsignedInt(1371571200);
         _loc2_.writeUnsignedInt(RESULT_NONE);
         _loc2_.writeUnsignedInt(29);
         _loc2_.writeShort(0);
         _loc2_.writeShort(0);
         _loc2_.writeUnsignedInt(2);
         _loc2_.writeUnsignedInt(201);
         _loc2_.writeUnsignedInt(2);
         _loc2_.writeUnsignedInt(201);
         var _loc5_:Vector.<int> = Vector.<int>([-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]);
         var _loc6_:Vector.<int> = Vector.<int>([1,1,2,3,2,3,1,4,4,1,1,1,2,3,2,3,1,4,4,1,1,1,2,3,2,3,1,4,4,1]);
         _loc2_.writeShort(_loc5_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_.length)
         {
            _loc2_.writeUnsignedInt(_loc1_ + 1);
            _loc2_.writeUnsignedInt(_loc6_[_loc1_]);
            _loc2_.writeUnsignedInt(_loc1_ + 1);
            _loc2_.writeByte(_loc5_[_loc1_]);
            _loc2_.writeUnsignedInt(14100046);
            _loc1_++;
         }
         _loc2_.writeShort(12);
         var _loc7_:Vector.<String> = Vector.<String>(["a","b","c","c","a","b","c","c","a","b","c","c"]);
         var _loc8_:Vector.<int> = Vector.<int>([111,11,1,1,111,11,1,1,111,11,1,1]);
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_.writeUnsignedInt(0);
            _loc2_.writeUnsignedInt(0);
            TUtilityString.FlushUTF(_loc2_,_loc7_[_loc1_]);
            _loc2_.writeUnsignedInt(_loc8_[_loc1_]);
            _loc1_++;
         }
         _loc2_.writeShort(12);
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_.writeUnsignedInt(1371571200 + 100 * _loc1_);
            _loc2_.writeUnsignedInt(14100046);
            _loc1_++;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
   }
}

