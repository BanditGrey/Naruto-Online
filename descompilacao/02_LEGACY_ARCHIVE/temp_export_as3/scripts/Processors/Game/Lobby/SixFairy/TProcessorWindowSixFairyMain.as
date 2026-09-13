package Processors.Game.Lobby.SixFairy
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.BloodSoul.TCustomDropoutTip;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.SixFary.TSixFaryPracticeTip;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SIXFAIRYMAIN;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_SIXFAIRYMAN;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowSixFairyMain extends TProcessorLobbyWindows
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected var FProcessorWindowSixFairy:TProcessorWindowSixFairy = null;
      
      protected var FSixFaryAllDataBase:SixFaryAllDataBase = null;
      
      protected var FBatchCount:int;
      
      protected var FUnitPrice:int;
      
      protected var FAllCount:int;
      
      protected var FGOLDBREAKTHROUGH_PRICE:Vector.<uint>;
      
      protected var FBLOODSOUL_BreakthroughMaterial_PRICE:Vector.<uint>;
      
      protected var initilization:int = 0;
      
      protected var FtempArr:Array;
      
      protected var FCurIndex:int;
      
      protected var FUIWindowConfirmationSell:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationStrong:TUIWindowConfirmation;
      
      protected var FSixFaryPracticeTip:TSixFaryPracticeTip;
      
      protected var FCustomDropoutTip:TCustomDropoutTip;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var nimei:int = 1;
      
      protected var type:int;
      
      protected var FIswin:Boolean = true;
      
      public function TProcessorWindowSixFairyMain(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FSixFaryAllDataBase = new SixFaryAllDataBase();
         this.FtempArr = new Array();
         this.FProcessorWindowSixFairy = new TProcessorWindowSixFairy(this,this.FSixFaryAllDataBase);
         this.FProcessorWindowSixFairy.UIComponentsHintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowSixFairy.UIComponentsHintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowSixFairy.UIComponentsOnOver = this.UIComponentsOnOver;
         this.FProcessorWindowSixFairy.UIComponentsOnOut = this.UIComponentsOnOut;
         this.FProcessorWindowSixFairy.OnClose = ProcessorClose;
         this.FProcessorWindowSixFairy.OnEffectText = this.ForEffect;
         this.FProcessorWindowSixFairy.BreakThroughFun = this.BreakThroughFunF;
         this.FProcessorWindowSixFairy.GoldPracticehFun = this.GoldPracticehFunF;
         this.FProcessorWindowSixFairy.GetAwardFun = this.GetAwardFunF;
         this.FProcessorWindowSixFairy.SixFairyManChangeStatue = this.SixFairyManChangeStatue;
         this.FProcessorWindowSixFairy.Btn_enterFun = this.FBtn_enterFunF;
         this.FProcessorWindowSixFairy.ExcelOne = this.ExcelOneFunFun;
         this.FUIWindowConfirmationSell = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationSell.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationSell.x = (STAGE_Width - this.FUIWindowConfirmationSell.WindowWidth) / 2;
         this.FUIWindowConfirmationSell.y = (STAGE_Height - this.FUIWindowConfirmationSell.WindowHeight) / 2;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FUIWindowConfirmationStrong = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmationStrong.OnOK = this.WindowConfirmationSellOnOK;
         this.FUIWindowConfirmationStrong.x = (STAGE_Width - this.FUIWindowConfirmationStrong.WindowWidth) / 2;
         this.FUIWindowConfirmationStrong.y = (STAGE_Height - this.FUIWindowConfirmationStrong.WindowHeight) / 2;
         SetUIModuleID(CONST_MODULES.MODULE_SixFairy);
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.initilization)
         {
            this.FProcessorWindowSixFairy.UpdateLogic();
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SIXFAIRYMAIN.SixFairyMain_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_SPIRIT_ADVGOLD) as TConfigValue;
         this.FBatchCount = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_SPIRIT_GOLD_PRICE) as TConfigValue;
         this.FUnitPrice = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_SPIRIT_ATTACK_COUNT) as TConfigValue;
         this.FAllCount = _loc1_.Value as int;
         this.FSixFaryAllDataBase.BatchCount = this.FAllCount;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_GOLDBREAKTHROUGH_PRICE) as TConfigValue;
         this.FGOLDBREAKTHROUGH_PRICE = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_BreakthroughMaterial_PRICE) as TConfigValue;
         this.FBLOODSOUL_BreakthroughMaterial_PRICE = _loc1_.Value as Vector.<uint>;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_SixFairy);
         FOverlayerAppliance.Visible = false;
         this.FSixFaryPracticeTip = new TSixFaryPracticeTip(this);
         this.FSixFaryPracticeTip.Visible = false;
         this.FCustomDropoutTip = new TCustomDropoutTip(this);
         this.FCustomDropoutTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FSixFaryPracticeTip);
         TUtilityUIOverlayer.ResourcesDispatch(this.FCustomDropoutTip);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationSell);
         this.FUIWindowConfirmationSell.SetCheckBox(true);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationStrong);
         this.FUIWindowConfirmationStrong.SetCheckBox(true);
         this.initilization = 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FSixFaryAllDataBase.initilizationData();
         this.FSixFaryAllDataBase.UpdateManual();
         super.ResourcesPerform_UILocations();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FCurIndex = 0;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.CustomsInitiliRequest();
         this.AttributeInitiliRequest();
         if(param1 != null)
         {
            this.FCurIndex = param1.readShort();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowSixFairy.Load();
            return;
         }
         this.FProcessorWindowSixFairy.visible = true;
         this.FProcessorWindowSixFairy.OpenPanelByIndex(this.FCurIndex);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_AttributeInitili_Ret,this.SixFairyMan_AttributeInitili_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_Practice_Ret,this.SixFairyMan_Practice_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_Breakthrough_Ret,this.SixFairyMan_Breakthrough_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_ZeroReset_Ret,this.SixFairyMan_ZeroReset_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_GetReward_Ret,this.SixFairyMan_GetReward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_ChangeStatue_Ret,this.PACKETID_SC_SixFairyMan_ChangeStatue_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_CustomsInitili_Ret,this.SixFairyMan_CustomsInitili_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SixFairyMan_Combat_Ret,this.SixFairyMan_Combat_Ret);
      }
      
      public function SixFairyMan_AttributeInitili_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FSixFaryAllDataBase.CurPetId = _loc3_.readUnsignedInt();
         this.FSixFaryAllDataBase.currExp = _loc3_.readUnsignedInt();
         this.FSixFaryAllDataBase.goldTimes = _loc3_.readUnsignedInt();
      }
      
      public function SixFairyMan_Practice_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc11_:String = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            SLogicsCore.Character.MaxTempValue = 0;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         var _loc6_:int = int(_loc3_.readUnsignedInt());
         this.FSixFaryAllDataBase.CurPetId = _loc3_.readUnsignedInt();
         var _loc7_:int = int(_loc3_.readUnsignedInt());
         var _loc8_:int = int(_loc3_.readUnsignedInt());
         var _loc9_:int = int(_loc3_.readUnsignedInt());
         this.FSixFaryAllDataBase.addExp = _loc7_;
         this.FSixFaryAllDataBase.currExp = _loc8_;
         var _loc10_:int = this.FSixFaryAllDataBase.PracticeTimes;
         this.FSixFaryAllDataBase.PracticeTimes = _loc10_ + _loc9_;
         if(_loc5_ > 0 && _loc6_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_SIXFAIRYMAN.PracticeTip1,_loc9_,_loc5_,_loc6_,_loc7_);
         }
         else if(_loc5_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_SIXFAIRYMAN.PracticeTip3,_loc9_,_loc5_,_loc7_);
         }
         else if(_loc6_ > 0)
         {
            _loc11_ = TUtilityString.Format(STRING_SIXFAIRYMAN.PracticeTip4,_loc9_,_loc6_,_loc7_);
         }
         else
         {
            _loc11_ = TUtilityString.Format(STRING_SIXFAIRYMAN.PracticeTip2,_loc7_);
         }
         this.FProcessorWindowSixFairy.UpdateManual(1);
         SLogicsCore.Character.MaxTempValue = 0;
         EffectGenerateText(_loc11_);
      }
      
      public function SixFairyMan_Breakthrough_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc5_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         _loc5_ = int(_loc3_.readUnsignedInt());
         var _loc6_:int = this.FSixFaryAllDataBase.CurPetId;
         if(_loc5_)
         {
            _loc6_++;
            this.FSixFaryAllDataBase.CurPetId = _loc6_;
         }
         else
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_46);
         }
         this.FProcessorWindowSixFairy.UpdateManual(1);
      }
      
      public function SixFairyMan_ZeroReset_Ret(param1:TPacket) : void
      {
         ProcessorClose();
         this.FProcessorWindowSixFairy.ScrollBarClear();
         this.FSixFaryAllDataBase.DataReset();
      }
      
      public function SixFairyMan_GetReward_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc9_:ItemUint = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FSixFaryAllDataBase.GetRewardBtnState = 1;
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SixFairy,false);
         }
         var _loc5_:int = _loc3_.readShort();
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_.push({
               "awardType":_loc3_.readShort(),
               "awardSubType":_loc3_.readUnsignedInt(),
               "awardNum":_loc3_.readUnsignedInt()
            });
            _loc4_++;
         }
         if(!_loc7_.length)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc7_.length)
         {
            if(_loc6_.length != 0)
            {
               if(_loc7_[_loc4_].awardSubType == _loc6_[_loc6_.length - 1].awardSubType)
               {
                  _loc10_ = int(_loc7_[_loc4_].awardNum);
                  _loc11_ = int(_loc6_[_loc6_.length - 1].awardNum);
                  _loc6_[_loc6_.length - 1].awardNum = _loc10_ + _loc11_;
               }
               else
               {
                  _loc6_.push(_loc7_[_loc4_]);
               }
            }
            else
            {
               _loc6_.push(_loc7_[_loc4_]);
            }
            _loc4_++;
         }
         var _loc8_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc8_ = TUtilityString.Format(STRING_TONGLING.TONGLING_37,STRING_COMMON.GetItemNameByType(_loc6_[_loc4_].awardType,_loc6_[_loc4_].awardSubType),_loc6_[_loc4_].awardNum);
            EffectGenerateText(_loc8_);
            _loc9_ = new ItemUint();
            _loc9_.SetString(_loc8_,"0",0);
            this.FProcessorWindowSixFairy.AddItem(_loc9_);
            _loc4_++;
         }
         this.FProcessorWindowSixFairy.setGetRewardBtnState();
      }
      
      public function PACKETID_SC_SixFairyMan_ChangeStatue_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         this.FSixFaryAllDataBase.StageStatue = _loc4_;
         this.FSixFaryAllDataBase.NextCustomsLayer = 5;
         this.FSixFaryAllDataBase.UpdateManual();
         this.FProcessorWindowSixFairy.OpenPanelByIndex(0);
      }
      
      public function SixFairyMan_CustomsInitili_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc5_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FSixFaryAllDataBase.CurCustomsId = _loc3_.readUnsignedInt();
         this.FSixFaryAllDataBase.GetRewardBtnState = _loc3_.readUnsignedInt();
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_SixFairy,!Boolean(this.FSixFaryAllDataBase.GetRewardBtnState));
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         this.FSixFaryAllDataBase.ThisDayCanChallengeCount = _loc4_;
         _loc4_ = _loc3_.readShort();
         this.FtempArr.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FtempArr.push({
               "awardType":_loc3_.readShort(),
               "awardSubType":_loc3_.readUnsignedInt(),
               "awardNum":_loc3_.readUnsignedInt()
            });
            _loc5_++;
         }
         this.FSixFaryAllDataBase.StageStatue = _loc3_.readUnsignedInt();
         this.LoadRewardOnce();
      }
      
      public function LoadRewardOnce() : void
      {
         var _loc2_:ItemUint = null;
         var _loc3_:int = 0;
         var _loc1_:String = "";
         this.FProcessorWindowSixFairy.ScrollBarClear();
         _loc3_ = 0;
         while(_loc3_ < this.FtempArr.length)
         {
            _loc1_ = TUtilityString.Format(STRING_TONGLING.TONGLING_37,STRING_COMMON.GetItemNameByType(this.FtempArr[_loc3_].awardType,this.FtempArr[_loc3_].awardSubType),this.FtempArr[_loc3_].awardNum);
            _loc2_ = new ItemUint();
            _loc2_.SetString(_loc1_,"0",0);
            this.FProcessorWindowSixFairy.AddItem(_loc2_);
            _loc3_++;
         }
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function SixFairyMan_Combat_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FIswin = true;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_SixFairy,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         this.FSixFaryAllDataBase.CurCustomsId = _loc4_;
         if(!_loc5_)
         {
            ++this.FSixFaryAllDataBase.ThisDayCanChallengeCount;
         }
      }
      
      public function FilghtReadOver() : void
      {
         this.FIswin = true;
         this.FProcessorWindowSixFairy.JudgeCanPlayerEffectByCondition();
      }
      
      public function SixFairyManChangeStatue(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_ChangeStatue_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function AttributeInitiliRequest() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_AttributeInitili_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function CustomsInitiliRequest() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_CustomsInitili_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BreakThroughFunF(param1:int) : void
      {
         this.type = param1;
         if(this.type == 7)
         {
            this.WindowConfirmationSellOnOK(this.type);
         }
         else if(this.FUIWindowConfirmationStrong.IsSelected)
         {
            this.WindowConfirmationSellOnOK(this.type);
         }
         else
         {
            if(this.FSixFaryAllDataBase.CurPetPosition - 1 >= this.FGOLDBREAKTHROUGH_PRICE.length && this.FSixFaryAllDataBase.CurReinCarnationLevel == 2)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_47);
               return;
            }
            this.FUIWindowConfirmationStrong.Visible = true;
            this.FUIWindowConfirmationStrong.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mandatorybreakthrough).DescribeString,this.FGOLDBREAKTHROUGH_PRICE[this.FSixFaryAllDataBase.CurPetPosition - 1],this.FBLOODSOUL_BreakthroughMaterial_PRICE[this.FSixFaryAllDataBase.CurPetPosition - 1],this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(1).Name);
         }
      }
      
      public function GoldPracticehFunF(param1:int) : void
      {
         this.type = param1;
         var _loc2_:TInventory = this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(0);
         var _loc3_:int = this.getInventoryById(_loc2_);
         if(this.type == 1)
         {
            if(this.FUIWindowConfirmation.IsSelected)
            {
               this.WindowConfirmationSellOnOK(this.type);
            }
            else if(_loc3_ >= 1)
            {
               this.WindowConfirmationSellOnOK(this.type);
            }
            else
            {
               this.FUIWindowConfirmation.Visible = true;
               this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_GoldPractice).DescribeString,this.FUnitPrice);
            }
         }
         else if(this.FUIWindowConfirmationSell.IsSelected)
         {
            this.WindowConfirmationSellOnOK(this.type);
         }
         else if(_loc3_ >= this.FBatchCount)
         {
            this.WindowConfirmationSellOnOK(this.type);
         }
         else
         {
            this.FUIWindowConfirmationSell.Visible = true;
            this.FUIWindowConfirmationSell.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_BatchCultivation).DescribeString,(this.FBatchCount - _loc3_) * this.FUnitPrice,_loc3_,_loc2_.Name,this.FBatchCount);
         }
      }
      
      protected function getInventoryById(param1:TInventory) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         return _loc2_.GetAllCountByTempletID(param1.IDTemplate);
      }
      
      protected function WindowConfirmationSellOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         if(this.type == 7 || this.type == 8)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_Breakthrough_Req);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.type - 7);
         }
         else
         {
            SLogicsCore.Character.MaxTempValue = 1;
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_Practice_Req);
            _loc3_ = _loc2_.Data;
            _loc4_ = 1;
            _loc3_.writeUnsignedInt(this.type);
            _loc4_ = this.type == 1 ? 1 : this.FBatchCount;
            _loc3_.writeUnsignedInt(_loc4_);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function GetAwardFunF() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_GetReward_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function ExcelOneFunFun() : void
      {
         this.LoadRewardOnce();
      }
      
      public function FBtn_enterFunF(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(!this.FIswin)
         {
            return;
         }
         this.FIswin = false;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_Combat_Req);
         _loc4_ = _loc3_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:Object) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Vector.<TFixedAward> = null;
         var _loc6_:int = 0;
         var _loc3_:int = param1 as int;
         _loc4_ = this.FSixFaryAllDataBase.CurCustomsReward;
         _loc5_ = _loc4_[_loc3_] as Vector.<TFixedAward>;
         var _loc7_:String = "";
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = _loc7_ + STRING_COMMON.GetItemNameByType(_loc5_[_loc6_].Type,_loc5_[_loc6_].Code) + " *" + _loc5_[_loc6_].Amount + "\n";
            _loc6_++;
         }
         this.FCustomDropoutTip.Context = this.FSixFaryAllDataBase.CurCustomsNameVec[_loc3_] + "&" + _loc7_;
         this.FCustomDropoutTip.Render(FUICore.MouseCoordinate);
         this.FCustomDropoutTip.Show();
      }
      
      protected function UIComponentsOnOut(param1:Object, param2:Object) : void
      {
         this.FCustomDropoutTip.Hide();
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         var _loc5_:String = null;
         _loc3_ = param2 as TInventory;
         var _loc6_:int = param1 as int;
         if(this.FSixFaryAllDataBase.CurPetPosition == 0)
         {
            return;
         }
         if(_loc6_ == 0 || _loc6_ == 1)
         {
            _loc4_ = FOverlayerAppliance;
         }
         else
         {
            _loc4_ = this.FSixFaryPracticeTip;
         }
         if(_loc6_ == 0)
         {
            _loc4_.Context = this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(0);
         }
         else if(_loc6_ == 1)
         {
            _loc4_.Context = this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(1);
         }
         else if(_loc6_ == 2)
         {
            _loc4_.Context = TUtilityString.Format(STRING_TONGLING.TONGLING_50,this.FUnitPrice,STRING_INHERITPRACTICE.INHERIT_GOLD,1,this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(0).Name,1);
         }
         else if(_loc6_ == 4)
         {
            if(this.FSixFaryAllDataBase.CurPetPosition - 1 >= this.FGOLDBREAKTHROUGH_PRICE.length)
            {
               _loc5_ = STRING_TONGLING.TONGLING_47;
            }
            else
            {
               _loc5_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_SixFairy_breakthrough).DescribeString,this.FGOLDBREAKTHROUGH_PRICE[this.FSixFaryAllDataBase.CurPetPosition - 1],this.FBLOODSOUL_BreakthroughMaterial_PRICE[this.FSixFaryAllDataBase.CurPetPosition - 1],this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(1).Name);
            }
            _loc4_.Context = _loc5_;
         }
         else if(_loc6_ == 5)
         {
            if(this.FSixFaryAllDataBase.CurPetPosition - 1 >= this.FBLOODSOUL_BreakthroughMaterial_PRICE.length)
            {
               _loc5_ = STRING_TONGLING.TONGLING_47;
            }
            else
            {
               _loc5_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_OrdinaryBreakthrough).DescribeString,this.FBLOODSOUL_BreakthroughMaterial_PRICE[this.FSixFaryAllDataBase.CurPetPosition - 1],this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(1).Name);
            }
            _loc4_.Context = _loc5_;
         }
         else
         {
            _loc4_.Context = TUtilityString.Format(STRING_TONGLING.TONGLING_50,this.FUnitPrice * this.FBatchCount,STRING_INHERITPRACTICE.INHERIT_GOLD,this.FBatchCount,this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(0).Name,this.FBatchCount);
         }
         if(_loc4_ != null)
         {
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut1(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         var _loc5_:int = param1 as int;
         if(_loc5_ == 0 || _loc5_ == 1)
         {
            _loc4_ = FOverlayerAppliance;
         }
         else
         {
            _loc4_ = this.FSixFaryPracticeTip;
         }
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
   }
}

