package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBloodSoul_battle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.BloodSoul.TBloodSoulRewardTip;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TongLingAnimal.LittleTipOneAgain;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowBloodSoulPurgatoryMain extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowBloodSoulPurgatory:TProcessorWindowBloodSoulPurgatory = null;
      
      protected var FWindowBloodSoulChange:TWindowBloodSoulChange;
      
      protected var FChangeCountFream:TChangeCountFream;
      
      protected var FBloodSoulCount:int;
      
      protected var FGoldPuergatoryArr:Vector.<uint>;
      
      protected var FStuffIdArr:Vector.<Object>;
      
      protected var FSILVER_NUM:int;
      
      protected var FTabIndex:int;
      
      protected var BLOODSOUL_More_High:int;
      
      protected var FSilver_Price:int;
      
      protected var FOverLayerBlood:LittleTipOneAgain;
      
      protected var FBloodSoulReweard:TBloodSoulRewardTip;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FDistant:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var FInitilization:int;
      
      protected var FCurCustomId:int;
      
      protected var FWinOrLoser:int;
      
      public function TProcessorWindowBloodSoulPurgatoryMain(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowBloodSoulPurgatory = new TProcessorWindowBloodSoulPurgatory(this);
         this.FProcessorWindowBloodSoulPurgatory.OnClose = ProcessorClose;
         this.FProcessorWindowBloodSoulPurgatory.BloodSoulBtnFun = this.BloodSoulBtnFunF;
         this.FProcessorWindowBloodSoulPurgatory.ShortcutGetStuffBtnFun = this.ShortcutGetStuffBtnFunF;
         this.FProcessorWindowBloodSoulPurgatory.BloodSoulChangeBtnFun = this.BloodSoulChangeBtnFunF;
         this.FProcessorWindowBloodSoulPurgatory.BloodSoulCloseBtnFun = this.BloodSoulCloseBtnFunF;
         this.FProcessorWindowBloodSoulPurgatory.CustomsTabFun = this.CustomsTabFunF;
         this.FProcessorWindowBloodSoulPurgatory.AlonePopFrameFun = this.AlonePopFrameFunF;
         this.FProcessorWindowBloodSoulPurgatory.CBloodSoulBtnFun = this.CBloodSoulBtnFunf;
         this.FProcessorWindowBloodSoulPurgatory.ChallengeBtnFun = this.ChallengeBtnFunF;
         this.FProcessorWindowBloodSoulPurgatory.BtnOverBackFunc = this.BtnOverBackFuncF;
         this.FProcessorWindowBloodSoulPurgatory.BtnMoveBackFunc = this.BtnMoveBackFuncF;
         this.FProcessorWindowBloodSoulPurgatory.BtnOutBackFunc = this.BtnOutBackFuncF;
         this.FProcessorWindowBloodSoulPurgatory.UIComponentsHintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowBloodSoulPurgatory.UIComponentsHintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowBloodSoulPurgatory.UIComponentsLittleOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowBloodSoulPurgatory.UIComponentsLittleOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowBloodSoulPurgatory.Distant = this.FDistantF;
         this.FProcessorWindowBloodSoulPurgatory.OnEffectText = this.ForEffect;
         this.FProcessorWindowBloodSoulPurgatory.GoToBloodPurgatoryPanel = this.GoToBloodPurgatoryPanelF;
         this.FWindowBloodSoulChange = new TWindowBloodSoulChange(this);
         this.FWindowBloodSoulChange.visible = false;
         this.FWindowBloodSoulChange.SlotsOnMove = this.UIHintOnOver;
         this.FWindowBloodSoulChange.SlotsOnOut = this.UIHintOnOut;
         this.FWindowBloodSoulChange.OnChangeBackFun = this.ChangeCountFreamSetVisibel;
         this.FChangeCountFream = new TChangeCountFream(this);
         this.FChangeCountFream.SureBtnBackFun = this.ChangeCountFreamBack;
         this.FChangeCountFream.CancelBtnBackFun = this.ChangeCountFreamCancelBack;
         this.FOverLayerBlood = new LittleTipOneAgain(param1);
         this.FOverLayerBlood.visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_BloodSoulPurgatory);
         FOverlayerAppliance.Visible = false;
         this.FBloodSoulReweard = new TBloodSoulRewardTip(this);
         this.FBloodSoulReweard.visible = false;
      }
      
      protected function ChangeCountFreamCancelBack() : void
      {
         this.FWindowBloodSoulChange.Reset();
      }
      
      protected function ChangeCountFreamBack(param1:uint, param2:uint, param3:uint) : void
      {
         this.FWindowBloodSoulChange.C_S_(param1,param2,param3);
      }
      
      protected function ChangeCountFreamSetVisibel(param1:Object) : void
      {
         this.FChangeCountFream.SetValue(param1["fr_itemid"],param1["fr_itemcnt"],param1["to_itemid"],param1["to_itemcnt"]);
         this.FChangeCountFream.visible = true;
         SetUIModuleID(CONST_MODULES.MODULE_BloodSoulPurgatory);
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(this.FInitilization == 1)
         {
            this.FProcessorWindowBloodSoulPurgatory.LogicUpdate();
            if(this.FWindowBloodSoulChange != null && this.FWindowBloodSoulChange.visible == true)
            {
               this.FWindowBloodSoulChange.UpdataBitmap();
            }
         }
      }
      
      public function FDistantF(param1:Vector.<DataStructureForBloodSoul>) : void
      {
         if(this.FDistant != null)
         {
            this.FDistant(param1);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODPURGATORY.BooldPurgatory_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BloodSoulCount) as TConfigValue;
         this.FBloodSoulCount = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_GOLD_PRICE) as TConfigValue;
         this.FGoldPuergatoryArr = _loc1_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_ITEM_ID) as TConfigValue;
         this.FStuffIdArr = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_SILVER_NUM) as TConfigValue;
         this.FSILVER_NUM = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_SILVER_PRICE) as TConfigValue;
         this.FSilver_Price = _loc1_.Value as int;
         this.BLOODSOUL_More_High = CONST_BLOODPURGATORY.MAX_BLOODSOUL_LEVEL;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FBloodSoulReweard);
         this.FInitilization = 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverLayerBlood);
         this.FWindowBloodSoulChange.Init();
         this.FWindowBloodSoulChange.x = (FUICore.StageWidth - TWindowBloodSoulChange.WindowWidth) / 2;
         this.FWindowBloodSoulChange.y = (FUICore.StageHeight - TWindowBloodSoulChange.WindowHeight) / 2;
         this.FOverLayerBlood.GoldPuergatoryArr = this.FGoldPuergatoryArr;
         this.FOverLayerBlood.Silver_Price = this.FSilver_Price;
         this.FOverLayerBlood.BloodSoulCount = this.FBloodSoulCount;
         this.FProcessorWindowBloodSoulPurgatory.FreeSilverCount(this.FSILVER_NUM);
         this.FProcessorWindowBloodSoulPurgatory.FStuffIdArrF(this.FStuffIdArr);
         this.FProcessorWindowBloodSoulPurgatory.FMore_High(this.BLOODSOUL_More_High);
         super.ResourcesPerform_UILocations();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FTabIndex = 0;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            param1.position = 0;
            this.FTabIndex = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBloodSoulPurgatory.Load();
            this.FChangeCountFream.Load();
            return;
         }
         this.FProcessorWindowBloodSoulPurgatory.visible = true;
         if(this.FTabIndex == 2)
         {
            if(this.GetBoo())
            {
               this.FTabIndex = 0;
            }
         }
         if(this.FTabIndex != 2)
         {
            this.CustomsInitiRet();
         }
         switch(this.FTabIndex)
         {
            case 0:
               break;
            case 1:
               this.BloodSoulPurgatoryRet();
         }
         this.FProcessorWindowBloodSoulPurgatory.setVisibelByIndex(this.FTabIndex);
      }
      
      protected function GetBoo() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:TBloodSoul_battle = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Battle,this.FCurCustomId) as TBloodSoul_battle;
         if(!_loc2_)
         {
            return true;
         }
         _loc1_ = uint(_loc2_.StageClear);
         if(_loc1_ == 1)
         {
            return true;
         }
         return false;
      }
      
      public function BtnOverBackFuncF(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.FOverLayerBlood.Silver_Price = param4;
         this.FOverLayerBlood.Context = {
            "type":param1,
            "goldTimes":param2,
            "BloodType":param3
         };
         this.FOverLayerBlood.Render(FUICore.MouseCoordinate);
         this.FOverLayerBlood.Show();
      }
      
      public function BtnMoveBackFuncF(param1:int, param2:int) : void
      {
         this.FOverLayerBlood.Render(FUICore.MouseCoordinate);
      }
      
      public function BtnOutBackFuncF(param1:int, param2:int) : void
      {
         this.FOverLayerBlood.Hide();
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
      
      public function set Distant(param1:Function) : void
      {
         this.FDistant = param1;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_Initili_Ret,this.BloodSoulPurgatory_Initili_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_Practice_Ret,this.BloodSoulPurgatory_Practice_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_zero_Ret,this.BloodSoulPurgatory_zero_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_GetReward_Ret,this.BloodSoulPurgatory_GetReward_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_Blood_Ret,this.BloodSoulPurgatory_Blood_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_Customs_Ret,this.BloodSoulPurgatory_Customs_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_BloodSoulPurgatory_Combat_Ret,this.BloodSoulPurgatory_Combat_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_ExchangeItemRet_Ret,this.BloodSoulPurgatory_ExchangeItem_Ret);
      }
      
      public function BloodSoulBtnFunF() : void
      {
         this.FProcessorWindowBloodSoulPurgatory.setVisibelByIndex(1);
         this.BloodSoulPurgatoryRet();
      }
      
      public function BloodSoulChangeBtnFunF() : void
      {
         this.FWindowBloodSoulChange.SetCustomId(this.FCurCustomId);
         this.FWindowBloodSoulChange.Visible = true;
      }
      
      public function BloodSoulCloseBtnFunF(param1:int) : void
      {
         this.FProcessorWindowBloodSoulPurgatory.setVisibelByIndex(0);
         this.FProcessorWindowBloodSoulPurgatory.IsExcel = 1;
         this.FProcessorWindowBloodSoulPurgatory.CustomBack(this.FCurCustomId);
      }
      
      public function GoToBloodPurgatoryPanelF(param1:String) : void
      {
         this.CustomsTabFunF(int(param1));
      }
      
      public function CustomsTabFunF(param1:int) : void
      {
         this.FProcessorWindowBloodSoulPurgatory.SetIsWin(false);
         this.FProcessorWindowBloodSoulPurgatory.IsExcel = 0;
         this.FProcessorWindowBloodSoulPurgatory.CustomBack(this.FCurCustomId);
         this.FProcessorWindowBloodSoulPurgatory.setInstance(param1);
         this.FProcessorWindowBloodSoulPurgatory.setVisibelByIndex(2);
      }
      
      public function CBloodSoulBtnFunf() : void
      {
         this.FProcessorWindowBloodSoulPurgatory.setVisibelByIndex(1);
         this.BloodSoulPurgatoryRet();
      }
      
      public function ChallengeBtnFunF() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Combat_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BloodSoulPurgatory_Initili_Ret(param1:TPacket) : void
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
         this.FProcessorWindowBloodSoulPurgatory.BloodSoulPurgatory_Initili_Ret(_loc3_);
      }
      
      public function BloodSoulPurgatory_Practice_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            SLogicsCore.Character.MaxTempValue = 0;
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowBloodSoulPurgatory.BloodSoulPurgatory_Practice_Ret(_loc3_);
         SLogicsCore.Character.MaxTempValue = 0;
      }
      
      public function BloodSoulPurgatory_zero_Ret(param1:TPacket) : void
      {
         this.FProcessorWindowBloodSoulPurgatory.ZeroReset();
      }
      
      public function BloodSoulPurgatory_GetReward_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:String = "";
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowBloodSoulPurgatory.SetGetStuffBtn(false);
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Laboratory,false);
         }
         _loc5_ = _loc3_.readShort();
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
                  _loc9_ = int(_loc7_[_loc4_].awardNum);
                  _loc10_ = int(_loc6_[_loc6_.length - 1].awardNum);
                  _loc6_[_loc6_.length - 1].awardNum = _loc9_ + _loc10_;
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
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc8_ = TUtilityString.Format(STRING_TONGLING.TONGLING_37,STRING_COMMON.GetItemNameByType(_loc6_[_loc4_].awardType,_loc6_[_loc4_].awardSubType),_loc6_[_loc4_].awardNum);
            EffectGenerateText(_loc8_);
            _loc4_++;
         }
      }
      
      public function BloodSoulPurgatory_Blood_Ret(param1:TPacket) : void
      {
      }
      
      public function BloodSoulPurgatory_Customs_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FCurCustomId = _loc3_.readUnsignedInt();
         _loc4_ = int(_loc3_.readUnsignedInt());
         if(_loc4_)
         {
            this.FProcessorWindowBloodSoulPurgatory.SetGetStuffBtn(false);
         }
         else
         {
            this.FProcessorWindowBloodSoulPurgatory.SetGetStuffBtn(true);
         }
         this.FProcessorWindowBloodSoulPurgatory.IsExcel = 0;
         this.FProcessorWindowBloodSoulPurgatory.CustomBack(this.FCurCustomId);
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Laboratory,!Boolean(_loc4_));
         }
      }
      
      public function BloodSoulPurgatory_Combat_Ret(param1:TPacket) : void
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
         this.FCurCustomId = _loc3_.readUnsignedInt();
         this.FWinOrLoser = _loc3_.readUnsignedInt();
         this.FProcessorWindowBloodSoulPurgatory.SetIsWin(Boolean(this.FWinOrLoser));
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_BloodSoul,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      public function BloodSoulPurgatory_ExchangeItem_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            this.FWindowBloodSoulChange.Reset();
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FWindowBloodSoulChange.ChgBloodSoulSucceed();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_EXCHANGE);
      }
      
      public function FilghtReadOver() : void
      {
         this.FProcessorWindowBloodSoulPurgatory.IsExcel = 1;
         this.FProcessorWindowBloodSoulPurgatory.CustomBack(this.FCurCustomId);
      }
      
      public function ShortcutGetStuffBtnFunF() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_GetReward_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function AlonePopFrameFunF(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Practice_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         _loc4_.writeUnsignedInt(param2);
         if(param2 == 3)
         {
            _loc4_.writeUnsignedInt(this.FBloodSoulCount);
         }
         else
         {
            _loc4_.writeUnsignedInt(1);
         }
         SLogicsCore.Character.MaxTempValue = 1;
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function CustomsInitiRet() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Customs_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BloodSoulPurgatoryRet() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Initili_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function UIHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(FOverlayerAppliance != null)
         {
            FOverlayerAppliance.Context = _loc3_;
            FOverlayerAppliance.Render(FUICore.MouseCoordinate);
            FOverlayerAppliance.Show();
         }
      }
      
      protected function UIHintOnOut(param1:Object, param2:TInventory) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param2 as TInventory;
         if(FOverlayerAppliance != null)
         {
            FOverlayerAppliance.Hide();
         }
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:int) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:String = "";
         _loc3_ = param1 as TInventory;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = _loc4_ + _loc3_.Name + " *" + param2;
         this.FBloodSoulReweard.Context = _loc4_;
         this.FBloodSoulReweard.Render(FUICore.MouseCoordinate);
         this.FBloodSoulReweard.Show();
      }
      
      protected function UIComponentsHintOnOut1(param1:Object, param2:int) : void
      {
         var _loc3_:TInventory = null;
         _loc3_ = param1 as TInventory;
         if(_loc3_ == null)
         {
            return;
         }
         if(this.FBloodSoulReweard != null)
         {
            this.FBloodSoulReweard.Hide();
         }
      }
   }
}

