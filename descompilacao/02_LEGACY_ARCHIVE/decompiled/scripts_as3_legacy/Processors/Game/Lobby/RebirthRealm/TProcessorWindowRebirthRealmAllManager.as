package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.DatebaseVO.VO.TRebirth_battle;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Windows.Information.TUIWindowInformation;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.RebirthRealm.TurntableTip;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Overlayers.Taboo.TOverTabooStringTip;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_REBIRTHREALM;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_REBIRTHREALM;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowRebirthRealmAllManager extends TProcessorLobbyWindows
   {
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var initilization:int = 0;
      
      protected var FCurIndex:int;
      
      protected var CurAutoFireIndex:int;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData;
      
      protected var FTongYongQuanPinDaoJiShi:TongYongQuanPinDaoJiShi;
      
      protected var FREBIRTH_LVUP:int;
      
      protected var FHuiYeZhiLiLevel:int;
      
      protected var FUIWindowInfor:TUIWindowInformation;
      
      protected var FAutoBtnStringTip:TOverTabooStringTip;
      
      protected var FTurntableTip:TurntableTip;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var tempArr:Array = new Array();
      
      protected var FProcessorWindowRebirthRealmMainManager:TProcessorWindowRebirthRealmMainManager = null;
      
      protected var AttrArr:Array = new Array();
      
      public function TProcessorWindowRebirthRealmAllManager(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FRebirthRealmBaseData = SLogicsCore.RebirthRealmBaseData;
         this.FProcessorWindowRebirthRealmMainManager = new TProcessorWindowRebirthRealmMainManager(this,this.FRebirthRealmBaseData);
         this.FProcessorWindowRebirthRealmMainManager.OnClose = ProcessorClose;
         this.FProcessorWindowRebirthRealmMainManager.MC_GotoDestinyCoronaFun = this.MC_GotoDestinyCoronaFunClick;
         this.FProcessorWindowRebirthRealmMainManager.MC_GotoSixRebirthFun = this.MC_GotoSixRebirthFunClick;
         this.FProcessorWindowRebirthRealmMainManager.MC_GotoRebirthRealmFun = this.MC_GotoRebirthRealmFunClick;
         this.FProcessorWindowRebirthRealmMainManager.OnEffectText = this.ForEffect;
         this.FProcessorWindowRebirthRealmMainManager.CloseFun = this.CloseFunClick;
         this.FProcessorWindowRebirthRealmMainManager.BeginFun = this.BeginFunF;
         this.FProcessorWindowRebirthRealmMainManager.Challenge_BtnFun = this.Challenge_BtnFunF;
         this.FProcessorWindowRebirthRealmMainManager.Chanllge_Btn = this.Chanllge_BtnF;
         this.FProcessorWindowRebirthRealmMainManager.EndFun = this.EndFunF;
         this.FProcessorWindowRebirthRealmMainManager.UIComponentsHintOnOver = this.UIComponentsHintOnOverF;
         this.FProcessorWindowRebirthRealmMainManager.UIComponentsHintOnOut = this.UIComponentsHintOnOutF;
         this.FProcessorWindowRebirthRealmMainManager.UpgradeBtn = this.UpgradeBtnF;
         this.FProcessorWindowRebirthRealmMainManager.TurntableTipMove = this.TurntableTipMoveF;
         this.FProcessorWindowRebirthRealmMainManager.TurntableTipOut = this.TurntableTipOutF;
         this.FProcessorWindowRebirthRealmMainManager.AutoBtnClickBack = this.AutoBtnClickBack;
         this.FProcessorWindowRebirthRealmMainManager.BtnOverFunc = this.AutoBtnOverFunc;
         this.FProcessorWindowRebirthRealmMainManager.BtnOutFunc = this.AutoBtnOutFunc;
         this.FProcessorWindowRebirthRealmMainManager.BtnMoveFunc = this.AutoBtnMoveFunc;
         this.FTongYongQuanPinDaoJiShi = new TongYongQuanPinDaoJiShi(param1);
         this.FTongYongQuanPinDaoJiShi.BackFun = this.BackFun;
         SetUIModuleID(CONST_MODULES.MODULE_RebirthRealm);
      }
      
      public function TurntableTipMoveF() : void
      {
         if(this.FTurntableTip != null)
         {
            this.FTurntableTip.Context = this.GetAttrStr();
            this.FTurntableTip.Render(FUICore.MouseCoordinate);
            this.FTurntableTip.Show();
         }
      }
      
      public function TurntableTipOutF() : void
      {
         if(this.FTurntableTip != null)
         {
            this.FTurntableTip.Hide();
         }
      }
      
      public function GetAttrStr() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:String = "";
         this.Valuation_haveProperty(0,0);
         _loc1_ = 0;
         while(_loc1_ < this.FRebirthRealmBaseData.AddAttributeVec2_Obj.length)
         {
            _loc3_ = Object(this.FRebirthRealmBaseData.AddAttributeVec2_Obj[_loc1_]);
            _loc6_ = "0";
            _loc2_ = 0;
            while(_loc2_ < this.AttrArr.length)
            {
               _loc4_ = Object(this.AttrArr[_loc2_]);
               if(_loc4_.type == _loc3_.type)
               {
                  _loc6_ = this.getString(_loc4_.num);
               }
               _loc2_++;
            }
            _loc5_ += STRINGS_BASEATTRIBUTENAMES[BASEATTRIBUTENAMES.indexOf(_loc3_.type)] + "+" + _loc6_ + "\n";
            _loc1_++;
         }
         return _loc5_;
      }
      
      public function getString(param1:Number) : String
      {
         var _loc2_:String = "";
         if(param1 < 1)
         {
            _loc2_ = _loc2_ + Number(param1 * 100).toFixed(1) + "%";
         }
         else
         {
            _loc2_ += int(param1);
         }
         return _loc2_;
      }
      
      public function Valuation_haveProperty(param1:int, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         this.AttrArr.length = 0;
         if(param1 != 0 && param2 != 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FRebirthRealmBaseData.AddAttributeVec1_Obj.length)
            {
               _loc4_ = Object(this.FRebirthRealmBaseData.AddAttributeVec1_Obj[_loc3_]);
               if(_loc4_.type == param1)
               {
                  _loc5_ = Number(_loc4_.num);
                  _loc5_ = _loc5_ + param2;
                  _loc4_.num = _loc5_;
                  _loc6_++;
               }
               this.AttrArr.push(this.FRebirthRealmBaseData.AddAttributeVec1_Obj[_loc3_]);
               _loc3_++;
            }
            if(!_loc6_)
            {
               this.AttrArr.push({
                  "type":param1,
                  "num":param2
               });
               this.FRebirthRealmBaseData.AddAttributeVec1_Obj.push({
                  "type":param1,
                  "num":param2
               });
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < this.FRebirthRealmBaseData.AddAttributeVec1_Obj.length)
            {
               this.AttrArr.push(this.FRebirthRealmBaseData.AddAttributeVec1_Obj[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.initilization)
         {
            this.FProcessorWindowRebirthRealmMainManager.UpdatePerform();
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_REBIRTHREALM.RebirthRealm_Resource);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.initilization = 1;
         FOverlayerAppliance = new TOverlayerAppliance(FParent,CONST_MODULES.MODULE_RebirthRealm);
         FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         this.FTurntableTip = new TurntableTip(this);
         this.FTurntableTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTurntableTip);
         this.FAutoBtnStringTip = new TOverTabooStringTip(this);
         this.FAutoBtnStringTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FAutoBtnStringTip);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.BLOODSOUL_REBIRTH_LVUP) as TConfigValue;
         this.FREBIRTH_LVUP = _loc1_.Value as int;
         this.FRebirthRealmBaseData.SixSamsaraStuffId = this.FREBIRTH_LVUP;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60410003) as TConfigValue;
         this.FTongYongQuanPinDaoJiShi.DaoJiTime = _loc1_.Value as int;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60410004) as TConfigValue;
         this.FHuiYeZhiLiLevel = _loc1_.Value as int;
         this.FUIWindowInfor = new TUIWindowInformation(this.Parent);
         this.FUIWindowInfor.OnOK = this.AutoFireBtnBack;
         this.FUIWindowInfor.x = (FUICore.StageWidth - this.FUIWindowInfor.WindowWidth) / 2;
         this.FUIWindowInfor.y = (FUICore.StageHeight - this.FUIWindowInfor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowInformation(this.FUIWindowInfor);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FCurIndex = 0;
         this.FProcessorWindowRebirthRealmMainManager.ClosePanel();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            param1.position = 0;
            this.FCurIndex = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRebirthRealmMainManager.Load();
            this.FTongYongQuanPinDaoJiShi.Load();
            return;
         }
         this.FProcessorWindowRebirthRealmMainManager.visible = true;
         this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(this.FCurIndex);
         this.AutoBtnStateRet();
      }
      
      public function CloseFunClick() : void
      {
         this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(0);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthRealm_AttributeInitili_Ret,this.RebirthRealm_AttributeInitili_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthRealm_Combat_Ret,this.RebirthRealm_Combat_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthRealm_turntable_Ret,this.RebirthRealm_turntable_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthRealm_Upgrade_Ret,this.RebirthRealm_Upgrade_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthMirror_AutoFightRet,this.PACKETID_SC_RebirthMirror_AutoFightRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RebirthMirror_HistoryInfo_Ret,this.PACKETID_SC_RebirthMirror_HistoryInfo_Ret);
      }
      
      public function RebirthRealm_AttributeInitili_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FRebirthRealmBaseData.initilizationData();
         this.FRebirthRealmBaseData.TodayChallengeTimes = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.todayChallengeType = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.AssisttodayChallengeType = this.FRebirthRealmBaseData.todayChallengeType;
         this.FRebirthRealmBaseData.CurCustomId = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.TurntableTurnTimes = _loc3_.readUnsignedInt();
         this.upDtaeTimes();
         this.FRebirthRealmBaseData.SixSamsaraId = _loc3_.readUnsignedInt();
         _loc4_ = _loc3_.readShort();
         this.FRebirthRealmBaseData.AddAttributeVec1_Obj.length = 0;
         this.FRebirthRealmBaseData.AddAttributeVec2_Obj.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FRebirthRealmBaseData.AddAttributeVec1_Obj.push({
               "type":_loc3_.readUnsignedInt(),
               "num":_loc3_.readFloat()
            });
            _loc5_++;
         }
         _loc4_ = _loc3_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this.FRebirthRealmBaseData.AddAttributeVec2_Obj.push({
               "type":_loc3_.readUnsignedInt(),
               "num":_loc3_.readFloat()
            });
            _loc5_++;
         }
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_RebirthRealm,this.FRebirthRealmBaseData.TodayChallengeTimes == 0);
         }
         if(this.initilization)
         {
            this.FProcessorWindowRebirthRealmMainManager.SixRebirthPanelUpdateManual();
            this.FProcessorWindowRebirthRealmMainManager.CustomPanelUpdateManual();
            this.FProcessorWindowRebirthRealmMainManager.DestinyCoronaPanelUpdateManual();
            this.FProcessorWindowRebirthRealmMainManager.RebirthRealmPanelUpdateManual();
         }
      }
      
      public function upDtaeTimes() : void
      {
         if(this.FRebirthRealmBaseData.TurntableTurnTimes)
         {
            this.FRebirthRealmBaseData.TurntableIsCanMove = true;
         }
         else
         {
            this.FRebirthRealmBaseData.TurntableIsCanMove = false;
         }
      }
      
      public function RebirthRealm_Combat_Ret(param1:TPacket) : void
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
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_RebirthRealm,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         this.FRebirthRealmBaseData.CurCustomId = _loc3_.readUnsignedInt();
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         this.FRebirthRealmBaseData.TurntableTurnTimes = _loc3_.readUnsignedInt();
         if(this.FRebirthRealmBaseData.todayChallengeType != this.FRebirthRealmBaseData.AssisttodayChallengeType)
         {
            ++this.FRebirthRealmBaseData.TodayChallengeTimes;
         }
         this.FRebirthRealmBaseData.todayChallengeType = this.FRebirthRealmBaseData.AssisttodayChallengeType;
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_RebirthRealm,this.FRebirthRealmBaseData.TodayChallengeTimes == 0);
         }
         this.FProcessorWindowRebirthRealmMainManager.ChangeWaitStatus();
         this.upDtaeTimes();
      }
      
      public function FilghtReadOver() : void
      {
      }
      
      public function RebirthRealm_turntable_Ret(param1:TPacket) : void
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
         this.FRebirthRealmBaseData.AttribType = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.AttribNum = _loc3_.readFloat();
         this.FRebirthRealmBaseData.TurntableTurnTimes = _loc3_.readUnsignedInt();
         this.upDtaeTimes();
         var _loc4_:int = this.getIndex(this.FRebirthRealmBaseData.AttribType);
         this.PointerTurntableStart(_loc4_);
      }
      
      public function getIndex(param1:int) : int
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FRebirthRealmBaseData.AddAttributeVec2_Obj.length)
         {
            _loc3_ = this.FRebirthRealmBaseData.AddAttributeVec2_Obj[_loc2_];
            if(_loc3_.type == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function RebirthRealm_Upgrade_Ret(param1:TPacket) : void
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
         this.FRebirthRealmBaseData.SixSamsaraId = _loc3_.readUnsignedInt();
         this.FProcessorWindowRebirthRealmMainManager.SixRebirthPanelUpdateManual();
         EffectGenerateText(STRING_TONGLING.TONGLING_53);
      }
      
      protected function AutoBtnOverFunc(param1:int) : void
      {
         var _loc2_:TNightPowerPrivilege = null;
         if(this.FAutoBtnStringTip)
         {
            _loc2_ = SLogicsCore.KaguyaData.NPowerPrivilege.GetDatebaseByIdentifier(this.FHuiYeZhiLiLevel) as TNightPowerPrivilege;
            this.FAutoBtnStringTip.Context = TUtilityString.Format(STRING_TONGLING.TONGLING_100,STRING_TONGLING.TONGLING_99[param1],_loc2_.Needlevel);
            this.FAutoBtnStringTip.Render(FUICore.MouseCoordinate);
            this.FAutoBtnStringTip.Show();
         }
      }
      
      protected function AutoBtnOutFunc() : void
      {
         if(this.FAutoBtnStringTip)
         {
            this.FAutoBtnStringTip.Hide();
         }
      }
      
      protected function AutoBtnMoveFunc() : void
      {
         if(this.FAutoBtnStringTip)
         {
            this.FAutoBtnStringTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function AutoBtnClickBack(param1:int) : void
      {
         var _loc2_:TPacket = null;
         this.CurAutoFireIndex = param1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthMirror_AutoFightReq);
         _loc2_.Data.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_SC_RebirthMirror_AutoFightRet(param1:TPacket) : void
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
         this.FRebirthRealmBaseData.TurntableTurnTimes = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoFireGetRewardCount = _loc3_.readUnsignedInt();
         this.FRebirthRealmBaseData.CurCustomId = _loc3_.readUnsignedInt();
         this.FTongYongQuanPinDaoJiShi.SetBegin();
         ++this.FRebirthRealmBaseData.TodayChallengeTimes;
         this.FProcessorWindowRebirthRealmMainManager.UpdateAutoBtnState();
         this.upDtaeTimes();
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_RebirthRealm,this.FRebirthRealmBaseData.TodayChallengeTimes == 0);
         }
      }
      
      protected function AutoBtnStateRet() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthMirror_HistoryInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BackFun() : void
      {
         var _loc1_:TArticle = null;
         var _loc2_:TRebirth_battle = null;
         if(this.CurAutoFireIndex <= 3)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FRebirthRealmBaseData.SixSamsaraStuffId) as TArticle;
         }
         else
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,14111299) as TArticle;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Rebirth_battle,this.FRebirthRealmBaseData.AutoBtnIsCanClcik[this.CurAutoFireIndex - 1]) as TRebirth_battle;
         this.FUIWindowInfor.Text = TUtilityString.Format(STRING_REBIRTHREALM.AutoFireTip,_loc2_.SStage,_loc1_.Name,this.FRebirthRealmBaseData.AutoFireGetRewardCount);
         this.FUIWindowInfor.visible = true;
      }
      
      protected function AutoFireBtnBack(param1:Object) : void
      {
         this.AutoBtnStateRet();
      }
      
      protected function PACKETID_SC_RebirthMirror_HistoryInfo_Ret(param1:TPacket) : void
      {
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[0] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[1] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[2] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[3] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[4] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[5] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[6] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[7] = param1.Data.readUnsignedInt();
         this.FRebirthRealmBaseData.AutoBtnIsCanClcik[8] = param1.Data.readUnsignedInt();
         this.FProcessorWindowRebirthRealmMainManager.UpdateAutoBtnState();
      }
      
      public function MC_GotoDestinyCoronaFunClick() : void
      {
         this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(3);
      }
      
      public function MC_GotoSixRebirthFunClick() : void
      {
         this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(1);
      }
      
      public function MC_GotoRebirthRealmFunClick(param1:int) : void
      {
         this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(4,param1);
      }
      
      public function PointerTurntableStart(param1:int) : void
      {
         this.FProcessorWindowRebirthRealmMainManager.PointerTurntableStart(param1);
      }
      
      public function BeginFunF() : void
      {
         if(!this.FRebirthRealmBaseData.IsPassCustom)
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_52);
            return;
         }
         if(!this.FRebirthRealmBaseData.TurntableIsCanMove)
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_51);
            return;
         }
         this.C_S_turntable_Message();
      }
      
      public function EndFunF() : void
      {
         this.Valuation_haveProperty(this.FRebirthRealmBaseData.AttribType,this.FRebirthRealmBaseData.AttribNum);
      }
      
      public function Challenge_BtnFunF(param1:int) : void
      {
         if(this.FRebirthRealmBaseData.IsPassCustom)
         {
            EffectGenerateText(STRING_REBIRTHREALM.Throuded);
            return;
         }
         if(this.FRebirthRealmBaseData.todayChallengeType == 0)
         {
            this.FRebirthRealmBaseData.AssisttodayChallengeType = param1;
            this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(2);
         }
         else if(this.FRebirthRealmBaseData.todayChallengeType == param1)
         {
            this.FRebirthRealmBaseData.AssisttodayChallengeType = param1;
            this.FProcessorWindowRebirthRealmMainManager.OpenPanelByIndex(2);
         }
         else
         {
            EffectGenerateText(STRING_REBIRTHREALM.NotComeIn);
         }
      }
      
      protected function UpgradeBtnF() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(!this.GetFalseOrFalse())
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_54);
            return;
         }
         var _loc3_:int = this.FRebirthRealmBaseData.todayChallengeType;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthRealm_Upgrade_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GetFalseOrFalse() : Boolean
      {
         return SLogicsCore.Character.Appliances.GetAllCountByTempletID(this.FRebirthRealmBaseData.SixSamsaraStuffId) >= this.FRebirthRealmBaseData.SixSamsaraStuffNum;
      }
      
      public function Chanllge_BtnF() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = this.FRebirthRealmBaseData.AssisttodayChallengeType;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthRealm_Combat_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function C_S_turntable_Message() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = this.FRebirthRealmBaseData.TodayChallengeTimes;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthRealm_turntable_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
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
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      protected function UIComponentsHintOnOverF(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOutF(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
   }
}

