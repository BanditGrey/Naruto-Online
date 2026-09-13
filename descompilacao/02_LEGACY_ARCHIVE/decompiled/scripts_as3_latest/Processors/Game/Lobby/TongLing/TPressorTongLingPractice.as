package Processors.Game.Lobby.TongLing
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_Additional;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingData;
   import Logics.TongLing.TTongLingDatas;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TPressorTongLingPractice extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 5;
      
      protected var FScene:MovieClip;
      
      protected var FDataObj:Object;
      
      protected var FStatus:TBB_Status;
      
      protected var FAdditional:TBB_Additional;
      
      protected var FSelectIndex:uint;
      
      protected var FPicBmp:Bitmap;
      
      protected var FTongLingDatas:TTongLingDatas;
      
      protected var FTongLingData:TTongLingData;
      
      protected var FIsFull:Boolean;
      
      protected var FIsCanCancel:Boolean;
      
      protected var FHasLost:Boolean;
      
      protected var FGold_0:uint;
      
      protected var FGold_1:uint;
      
      protected var FGold_2:uint;
      
      protected var FGold_3:uint;
      
      protected var FWashSaveVect:Vector.<Number>;
      
      protected var FWashCost:uint;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FOnGotoDevour:Function;
      
      public function TPressorTongLingPractice(param1:TUIComponent)
      {
         super(param1);
         this.FSelectIndex = 0;
         this.FTongLingDatas = SLogicsCore.TongLingDatas;
         this.FWashSaveVect = new Vector.<Number>(MAX_COUNT);
      }
      
      protected function UpdataModel() : void
      {
         if(this.FDataObj == null)
         {
            this.FScene["Pic"].visible = false;
            this.FScene["mc_tip"].visible = false;
            this.FScene["mc_name"].text = "";
         }
         else
         {
            this.FScene["Pic"].visible = true;
            this.FScene["mc_tip"].visible = Boolean(this.FDataObj.Position != 0);
            if(this.FDataObj.Position == 1)
            {
               this.FScene["mc_tip"].gotoAndStop(2);
            }
            else if(this.FDataObj.Position > 1)
            {
               this.FScene["mc_tip"].gotoAndStop(1);
            }
            this.FScene["mc_name"].text = this.FStatus.Name;
            this.FScene["MC_Pinzhi"].gotoAndStop(this.FStatus.Rarity);
         }
      }
      
      protected function UpdataValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         if(this.FDataObj == null)
         {
            this.FScene["tf_value0"].text = "0/0";
            this.FScene["tf_value1"].text = "0/0";
            this.FScene["tf_value2"].text = "0/0";
            this.FScene["tf_value3"].text = "0/0";
            this.FScene["tf_value4"].text = "0/0";
            this.FScene["tf_value5"].text = "0/0";
            this.FScene["tf_add0"].text = "0";
            this.FScene["tf_add1"].text = "0";
            this.FScene["tf_add2"].text = "0";
            this.FScene["tf_add3"].text = "0";
            this.FScene["tf_add4"].text = "0";
            this.FScene["tf_add5"].text = "0";
            this.FScene["mc_line0"].scaleX = 0;
            this.FScene["mc_line1"].scaleX = 0;
            this.FScene["mc_line2"].scaleX = 0;
            this.FScene["mc_line3"].scaleX = 0;
            this.FScene["mc_line4"].scaleX = 0;
            this.FScene["mc_line5"].scaleX = 0;
            this.FScene["mc_line6"].scaleX = 0;
            this.FScene["mc_line7"].scaleX = 0;
            this.FScene["mc_line8"].scaleX = 0;
            this.FScene["mc_line9"].scaleX = 0;
            this.FScene["mc_line10"].scaleX = 0;
            this.FScene["mc_line11"].scaleX = 0;
         }
         else
         {
            this.FIsFull = false;
            this.FIsCanCancel = true;
            this.FHasLost = false;
            _loc2_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP));
            _loc3_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack));
            _loc4_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack));
            _loc5_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense));
            _loc6_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense));
            _loc7_ = int(this.FTongLingData.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed));
            _loc8_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.HpRate;
            _loc9_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.NearattackRate;
            _loc10_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.StrategyattackRate;
            _loc11_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.NeardefenseRate;
            _loc12_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.StrategydefenseRate;
            _loc13_ = this.FAdditional.Additional[this.FDataObj.Level - 1] * this.FAdditional.SpeedRate;
            _loc14_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP));
            _loc15_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack));
            _loc16_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack));
            _loc17_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense));
            _loc18_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense));
            _loc19_ = int(this.FTongLingData.GetWashingAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed));
            this.FScene["tf_value0"].text = _loc2_ + "/" + _loc8_;
            this.FScene["tf_value1"].text = _loc3_ + "/" + _loc9_;
            this.FScene["tf_value2"].text = _loc4_ + "/" + _loc10_;
            this.FScene["tf_value3"].text = _loc5_ + "/" + _loc11_;
            this.FScene["tf_value4"].text = _loc6_ + "/" + _loc12_;
            this.FScene["tf_value5"].text = _loc7_ + "/" + _loc13_;
            this.FScene["mc_line0"].scaleX = Math.min(Math.max(_loc2_ / _loc8_,0),1);
            this.FScene["mc_line1"].scaleX = Math.min(Math.max(_loc3_ / _loc9_,0),1);
            this.FScene["mc_line2"].scaleX = Math.min(Math.max(_loc4_ / _loc10_,0),1);
            this.FScene["mc_line3"].scaleX = Math.min(Math.max(_loc5_ / _loc11_,0),1);
            this.FScene["mc_line4"].scaleX = Math.min(Math.max(_loc6_ / _loc12_,0),1);
            this.FScene["mc_line5"].scaleX = Math.min(Math.max(_loc7_ / _loc13_,0),1);
            this.FScene["mc_line6"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["mc_line7"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["mc_line8"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["mc_line9"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["mc_line10"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["mc_line11"].scaleX = this.FWashSaveVect[this.FSelectIndex];
            this.FScene["MC_Line"].x = this.FScene["mc_line6"].width + this.FScene["mc_line6"].x;
            this.FScene["tf_add0"].text = "0";
            this.FScene["tf_add1"].text = "0";
            this.FScene["tf_add2"].text = "0";
            this.FScene["tf_add3"].text = "0";
            this.FScene["tf_add4"].text = "0";
            this.FScene["tf_add5"].text = "0";
            if(this.FTongLingData.WashingCount > 0)
            {
               _loc1_ = _loc14_ - _loc2_;
               this.FScene["tf_add0"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add0"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc1_ = _loc15_ - _loc3_;
               this.FScene["tf_add1"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add1"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc1_ = _loc16_ - _loc4_;
               this.FScene["tf_add2"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add2"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc1_ = _loc17_ - _loc5_;
               this.FScene["tf_add3"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add3"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc1_ = _loc18_ - _loc6_;
               this.FScene["tf_add4"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add4"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc1_ = _loc19_ - _loc7_;
               this.FScene["tf_add5"].text = (_loc1_ >= 0 ? "+" : "") + _loc1_;
               this.FScene["tf_add5"].textColor = _loc1_ >= 0 ? "0x68FF02" : "0xFF0000";
            }
            if(_loc2_ >= _loc8_ && _loc3_ >= _loc9_ && _loc4_ >= _loc10_ && _loc5_ >= _loc11_ && _loc6_ >= _loc12_ && _loc7_ >= _loc13_)
            {
               this.FIsFull = true;
            }
            if(_loc14_ >= _loc2_ && _loc15_ >= _loc3_ && _loc16_ >= _loc4_ && _loc17_ >= _loc5_ && _loc18_ >= _loc6_ && _loc19_ >= _loc7_)
            {
               this.FIsCanCancel = false;
            }
            if((_loc14_ - _loc2_) / 5 + (_loc15_ - _loc3_) + (_loc16_ - _loc4_) + (_loc17_ - _loc5_) + (_loc18_ - _loc6_) + (_loc19_ - _loc7_) < 0)
            {
               this.FHasLost = true;
            }
         }
      }
      
      protected function UpdataSelect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(this.FDataObj != null)
         {
            _loc2_ = uint(int(this.FWashCost * (this.FDataObj.Level / 5 + this.FStatus.Rarity)));
            this.FScene["tf_select0"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_62,_loc2_);
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FScene["btn_select" + _loc1_].gotoAndStop(this.FSelectIndex == _loc1_ ? 1 : 2);
            _loc1_++;
         }
      }
      
      protected function ResetButton() : void
      {
         if(this.FDataObj == null || Boolean(this.FDataObj) && Boolean(this.FDataObj.isPeiYang))
         {
            this.FScene["tf_levelFull"].visible = false;
            this.FScene["btn_save"].visible = false;
            this.FScene["btn_cancel"].visible = false;
            this.FScene["btn_practice"].visible = false;
         }
         else if(this.FIsFull)
         {
            this.FScene["tf_levelFull"].visible = true;
            this.FScene["btn_save"].visible = false;
            this.FScene["btn_cancel"].visible = false;
            this.FScene["btn_practice"].visible = false;
         }
         else
         {
            this.FScene["tf_levelFull"].visible = false;
            if(this.FTongLingData.WashingAttributeList.length > 0)
            {
               this.FScene["btn_save"].visible = true;
               this.FScene["btn_cancel"].visible = this.FIsCanCancel ? true : false;
               this.FScene["btn_practice"].visible = false;
            }
            else
            {
               this.FScene["btn_save"].visible = false;
               this.FScene["btn_cancel"].visible = false;
               this.FScene["btn_practice"].visible = true;
            }
         }
      }
      
      protected function GotoDevour(param1:MouseEvent) : void
      {
         if(this.FOnGotoDevour != null)
         {
            this.FOnGotoDevour(this);
         }
      }
      
      protected function OnSaveWash(param1:MouseEvent) : void
      {
         if(this.FHasLost && !this.FPopWindow.IsSelected)
         {
            this.FPopWindow.Visible = true;
         }
         else
         {
            this.SureSaveWash(this);
         }
      }
      
      protected function CancelSaveWash(param1:Object) : void
      {
         this.FPopWindow.IsSelected = false;
      }
      
      protected function SureSaveWash(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WashBeastConfirm_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier1);
         _loc3_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FScene["btn_save"].visible = false;
         this.FScene["btn_cancel"].visible = false;
      }
      
      protected function OnCancelWash(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WashBeastConfirm_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier1);
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FScene["btn_save"].visible = false;
         this.FScene["btn_cancel"].visible = false;
      }
      
      protected function OnWash(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WashBeast_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier1);
         _loc3_.writeUnsignedInt(this.FSelectIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FScene["btn_practice"].visible = false;
      }
      
      protected function OnSelected(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         this.FSelectIndex = _loc2_;
         this.UpdataSelect();
         this.UpdataValue();
      }
      
      public function get OnGotoDevour() : Function
      {
         return this.FOnGotoDevour;
      }
      
      public function set OnGotoDevour(param1:Function) : void
      {
         this.FOnGotoDevour = param1;
      }
      
      public function seRoot(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc4_:TSystemLanguage = null;
         this.FScene = param1;
         this.FPicBmp = new Bitmap();
         this.FScene["Pic"]["Pic"].addChild(this.FPicBmp);
         TGameUtil.setButtonMode(this.FScene["btn_save"],true);
         TGameUtil.setButtonMode(this.FScene["btn_cancel"],true);
         this.FScene["btn_save"].addEventListener(MouseEvent.CLICK,this.OnSaveWash);
         this.FScene["btn_cancel"].addEventListener(MouseEvent.CLICK,this.OnCancelWash);
         this.FScene["btn_practice"].addEventListener(MouseEvent.CLICK,this.OnWash);
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            this.FScene["btn_select" + _loc2_].addEventListener(MouseEvent.CLICK,this.OnSelected);
            _loc2_++;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSave_0) as TConfigValue;
         this.FWashSaveVect[0] = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSave_1) as TConfigValue;
         this.FWashSaveVect[1] = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSave_2) as TConfigValue;
         this.FWashSaveVect[2] = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSave_3) as TConfigValue;
         this.FWashSaveVect[3] = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSave_4) as TConfigValue;
         this.FWashSaveVect[4] = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_WashSilverCost) as TConfigValue;
         this.FWashCost = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldCost_0) as TConfigValue;
         this.FGold_0 = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldCost_1) as TConfigValue;
         this.FGold_1 = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldCost_2) as TConfigValue;
         this.FGold_2 = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldCost_3) as TConfigValue;
         this.FGold_3 = _loc3_.Value as uint;
         this.FScene["tf_select1"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_82,this.FGold_0);
         this.FScene["tf_select2"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_83,this.FGold_1);
         this.FScene["tf_select3"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_84,this.FGold_2);
         this.FScene["tf_select4"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_85,this.FGold_3);
         this.FPopWindow = new TUIWindowConfirmation(this.Parent);
         this.FPopWindow.OnOK = this.SureSaveWash;
         this.FPopWindow.OnCancel = this.CancelSaveWash;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         this.FPopWindow.SetCheckBox(true);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ConsumerConfirm_TongLingTip) as TSystemLanguage;
         this.FPopWindow.Text = _loc4_.Desc;
         this.Updata();
      }
      
      public function Updata() : void
      {
         this.UpdataModel();
         this.UpdataValue();
         this.UpdataSelect();
         this.ResetButton();
      }
      
      public function SetMsg(param1:Object) : void
      {
         this.FSelectIndex = 0;
         this.FDataObj = param1;
         if(this.FDataObj != null)
         {
            this.FStatus = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FDataObj.Id) as TBB_Status;
            this.FAdditional = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Additional,this.FDataObj.Id) as TBB_Additional;
            this.FTongLingData = this.FTongLingDatas.GetTongLingDataById64(this.FDataObj.Identifier0,this.FDataObj.Identifier1);
         }
         else
         {
            this.FStatus = null;
            this.FAdditional = null;
            this.FTongLingData = null;
         }
         this.Updata();
      }
      
      public function UpdatePet() : void
      {
         if(this.FDataObj == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FPicBmp,CONST_MODULES.MODULE_TongLing,this.FStatus.SmPic,2);
      }
   }
}

