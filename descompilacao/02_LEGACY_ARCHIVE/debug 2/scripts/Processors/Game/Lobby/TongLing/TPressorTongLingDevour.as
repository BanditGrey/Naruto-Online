package Processors.Game.Lobby.TongLing
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_Additional;
   import Logics.DatebaseVO.VO.TBB_Exp;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingData;
   import Logics.TongLing.TTongLingDatas;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.TongLingUint;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TPressorTongLingDevour extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 2;
      
      protected var FScene:MovieClip;
      
      protected var FTongLingUint0:TongLingUint;
      
      protected var FTongLingUint1:TongLingUint;
      
      protected var FDataObj0:Object;
      
      protected var FDataObj1:Object;
      
      protected var FTongLingDatas:TTongLingDatas;
      
      protected var FSelectIndex:uint;
      
      protected var FTotleExp:uint;
      
      protected var FSilverCoinDevourCost:Number;
      
      protected var FGoldDevourCost:Number;
      
      protected var FSilverCoinWashCost:Number;
      
      protected var FGoldWashCost:Number;
      
      protected var FSilverCoinExp:Number;
      
      protected var FGoldExp:Number;
      
      protected var FCurCostGold:int;
      
      protected var FCurCostSilver:int;
      
      protected var FHasWaste:Boolean;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FOnGotoPractice:Function;
      
      protected var FOnUint_Move:Function;
      
      protected var FOnUint_Out:Function;
      
      protected var FOnUint_Over:Function;
      
      protected var FExteShow:Function;
      
      public function TPressorTongLingDevour(param1:TUIComponent)
      {
         super(param1);
         this.FSelectIndex = 0;
         this.FTongLingDatas = SLogicsCore.TongLingDatas;
      }
      
      protected function Updata() : void
      {
         var _loc1_:TTongLingData = null;
         var _loc2_:TBB_Status = null;
         var _loc3_:TBB_Additional = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:uint = 0;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         var _loc30_:uint = 0;
         var _loc31_:uint = 0;
         var _loc32_:uint = 0;
         var _loc33_:uint = 0;
         var _loc34_:uint = 0;
         var _loc35_:Number = NaN;
         this.FScene["tf_left_value0"].text = "0/0";
         this.FScene["tf_left_value1"].text = "0/0";
         this.FScene["tf_left_value2"].text = "0/0";
         this.FScene["tf_left_value3"].text = "0/0";
         this.FScene["tf_left_value4"].text = "0/0";
         this.FScene["tf_left_value5"].text = "0/0";
         this.FScene["tf_right_value0"].text = "0/0";
         this.FScene["tf_right_value1"].text = "0/0";
         this.FScene["tf_right_value2"].text = "0/0";
         this.FScene["tf_right_value3"].text = "0/0";
         this.FScene["tf_right_value4"].text = "0/0";
         this.FScene["tf_right_value5"].text = "0/0";
         this.FScene["tf_add0"].text = "";
         this.FScene["tf_add1"].text = "";
         this.FScene["tf_add2"].text = "";
         this.FScene["tf_add3"].text = "";
         this.FScene["tf_add4"].text = "";
         this.FScene["tf_add5"].text = "";
         this.FScene["mc_left_line0"].scaleX = 0;
         this.FScene["mc_left_line1"].scaleX = 0;
         this.FScene["mc_left_line2"].scaleX = 0;
         this.FScene["mc_left_line3"].scaleX = 0;
         this.FScene["mc_left_line4"].scaleX = 0;
         this.FScene["mc_left_line5"].scaleX = 0;
         this.FScene["mc_left_Addline0"].scaleX = 0;
         this.FScene["mc_left_Addline1"].scaleX = 0;
         this.FScene["mc_left_Addline2"].scaleX = 0;
         this.FScene["mc_left_Addline3"].scaleX = 0;
         this.FScene["mc_left_Addline4"].scaleX = 0;
         this.FScene["mc_left_Addline5"].scaleX = 0;
         this.FScene["mc_right_line0"].scaleX = 0;
         this.FScene["mc_right_line1"].scaleX = 0;
         this.FScene["mc_right_line2"].scaleX = 0;
         this.FScene["mc_right_line3"].scaleX = 0;
         this.FScene["mc_right_line4"].scaleX = 0;
         this.FScene["mc_right_line5"].scaleX = 0;
         this.FScene["tf_exp"].text = 0;
         if(this.FDataObj0 != null)
         {
            _loc1_ = this.FTongLingDatas.GetTongLingDataById64(this.FDataObj0.Identifier0,this.FDataObj0.Identifier1);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FDataObj0.Id) as TBB_Status;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Additional,this.FDataObj0.Id) as TBB_Additional;
            _loc5_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP);
            _loc6_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack);
            _loc7_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack);
            _loc8_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense);
            _loc9_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense);
            _loc10_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed);
            _loc11_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.HpRate;
            _loc12_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.NearattackRate;
            _loc13_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.StrategyattackRate;
            _loc14_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.NeardefenseRate;
            _loc15_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.StrategydefenseRate;
            _loc16_ = _loc3_.Additional[this.FDataObj0.Level - 1] * _loc3_.SpeedRate;
            this.FScene["tf_left_value0"].text = _loc5_ + "/" + _loc11_;
            this.FScene["tf_left_value1"].text = _loc6_ + "/" + _loc12_;
            this.FScene["tf_left_value2"].text = _loc7_ + "/" + _loc13_;
            this.FScene["tf_left_value3"].text = _loc8_ + "/" + _loc14_;
            this.FScene["tf_left_value4"].text = _loc9_ + "/" + _loc15_;
            this.FScene["tf_left_value5"].text = _loc10_ + "/" + _loc16_;
            this.FScene["mc_left_line0"].scaleX = _loc5_ / _loc11_;
            this.FScene["mc_left_line1"].scaleX = _loc6_ / _loc12_;
            this.FScene["mc_left_line2"].scaleX = _loc7_ / _loc13_;
            this.FScene["mc_left_line3"].scaleX = _loc8_ / _loc14_;
            this.FScene["mc_left_line4"].scaleX = _loc9_ / _loc15_;
            this.FScene["mc_left_line5"].scaleX = _loc10_ / _loc16_;
            if(_loc5_ >= _loc11_ && _loc6_ >= _loc12_ && _loc7_ >= _loc13_ && _loc8_ >= _loc14_ && _loc9_ >= _loc15_ && _loc10_ >= _loc16_)
            {
               if(this.FExteShow != null)
               {
                  this.FExteShow(STRING_TONGLING.TONGLING_81);
               }
               this.SetMsg(null,0);
               return;
            }
         }
         if(this.FDataObj1 != null)
         {
            _loc1_ = this.FTongLingDatas.GetTongLingDataById64(this.FDataObj1.Identifier0,this.FDataObj1.Identifier1);
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FDataObj1.Id) as TBB_Status;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Additional,this.FDataObj1.Id) as TBB_Additional;
            _loc17_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP);
            _loc18_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack);
            _loc19_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack);
            _loc20_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense);
            _loc21_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense);
            _loc22_ = _loc1_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed);
            _loc23_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.HpRate;
            _loc24_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.NearattackRate;
            _loc25_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.StrategyattackRate;
            _loc26_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.NeardefenseRate;
            _loc27_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.StrategydefenseRate;
            _loc28_ = _loc3_.Additional[this.FDataObj1.Level - 1] * _loc3_.SpeedRate;
            this.FScene["tf_right_value0"].text = _loc17_ + "/" + _loc23_;
            this.FScene["tf_right_value1"].text = _loc18_ + "/" + _loc24_;
            this.FScene["tf_right_value2"].text = _loc19_ + "/" + _loc25_;
            this.FScene["tf_right_value3"].text = _loc20_ + "/" + _loc26_;
            this.FScene["tf_right_value4"].text = _loc21_ + "/" + _loc27_;
            this.FScene["tf_right_value5"].text = _loc22_ + "/" + _loc28_;
            this.FScene["mc_right_line0"].scaleX = _loc17_ > _loc23_ ? 1 : _loc17_ / _loc23_;
            this.FScene["mc_right_line1"].scaleX = _loc18_ > _loc24_ ? 1 : _loc18_ / _loc24_;
            this.FScene["mc_right_line2"].scaleX = _loc19_ > _loc25_ ? 1 : _loc19_ / _loc25_;
            this.FScene["mc_right_line3"].scaleX = _loc20_ > _loc26_ ? 1 : _loc20_ / _loc26_;
            this.FScene["mc_right_line4"].scaleX = _loc21_ > _loc27_ ? 1 : _loc21_ / _loc27_;
            this.FScene["mc_right_line5"].scaleX = _loc22_ > _loc28_ ? 1 : _loc22_ / _loc28_;
            if(this.FDataObj0 != null)
            {
               _loc35_ = this.FSelectIndex == 0 ? this.FSilverCoinWashCost : this.FGoldWashCost;
               _loc29_ = _loc17_ - _loc5_ > 0 ? uint(int((_loc17_ - _loc5_) * _loc35_)) : 0;
               this.FScene["tf_add0"].text = (_loc29_ >= 0 ? "+" : "") + _loc29_;
               this.FScene["tf_add0"].textColor = _loc29_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc30_ = _loc18_ - _loc6_ > 0 ? uint(int((_loc18_ - _loc6_) * _loc35_)) : 0;
               this.FScene["tf_add1"].text = (_loc30_ >= 0 ? "+" : "") + _loc30_;
               this.FScene["tf_add1"].textColor = _loc30_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc31_ = _loc19_ - _loc7_ > 0 ? uint(int((_loc19_ - _loc7_) * _loc35_)) : 0;
               this.FScene["tf_add2"].text = (_loc31_ >= 0 ? "+" : "") + _loc31_;
               this.FScene["tf_add2"].textColor = _loc31_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc32_ = _loc20_ - _loc8_ > 0 ? uint(int((_loc20_ - _loc8_) * _loc35_)) : 0;
               this.FScene["tf_add3"].text = (_loc32_ >= 0 ? "+" : "") + _loc32_;
               this.FScene["tf_add3"].textColor = _loc32_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc33_ = _loc21_ - _loc9_ > 0 ? uint(int((_loc21_ - _loc9_) * _loc35_)) : 0;
               this.FScene["tf_add4"].text = (_loc33_ >= 0 ? "+" : "") + _loc33_;
               this.FScene["tf_add4"].textColor = _loc33_ >= 0 ? "0x68FF02" : "0xFF0000";
               _loc34_ = _loc22_ - _loc10_ > 0 ? uint(int((_loc22_ - _loc10_) * _loc35_)) : 0;
               this.FScene["tf_add5"].text = (_loc34_ >= 0 ? "+" : "") + _loc32_;
               this.FScene["tf_add5"].textColor = _loc34_ >= 0 ? "0x68FF02" : "0xFF0000";
               this.FScene["mc_left_Addline0"].scaleX = Math.min(Math.max((_loc5_ + _loc29_) / _loc11_,0),1);
               this.FScene["mc_left_Addline1"].scaleX = Math.min(Math.max((_loc6_ + _loc30_) / _loc12_,0),1);
               this.FScene["mc_left_Addline2"].scaleX = Math.min(Math.max((_loc7_ + _loc31_) / _loc13_,0),1);
               this.FScene["mc_left_Addline3"].scaleX = Math.min(Math.max((_loc8_ + _loc32_) / _loc14_,0),1);
               this.FScene["mc_left_Addline4"].scaleX = Math.min(Math.max((_loc9_ + _loc33_) / _loc15_,0),1);
               this.FScene["mc_left_Addline5"].scaleX = Math.min(Math.max((_loc10_ + _loc34_) / _loc16_,0),1);
               _loc35_ = this.FSelectIndex == 0 ? this.FSilverCoinDevourCost : this.FGoldDevourCost;
               this.FScene["tf_exp"].text = int(this.FTotleExp * _loc35_);
               if(_loc5_ + _loc29_ > _loc11_ || _loc6_ + _loc30_ > _loc12_ || _loc7_ + _loc31_ > _loc13_ || _loc8_ + _loc32_ > _loc14_ || _loc9_ + _loc33_ > _loc15_ || _loc10_ + _loc34_ > _loc16_)
               {
                  this.FHasWaste = true;
               }
               else
               {
                  this.FHasWaste = false;
               }
            }
         }
      }
      
      protected function UpdataSelect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(this.FDataObj1 != null)
         {
            _loc2_ = int(this.FTotleExp * this.FSilverCoinDevourCost) * this.FSilverCoinExp;
            _loc2_ = Math.max(_loc2_ - _loc2_ % 100,this.FSilverCoinExp);
            this.FCurCostSilver = _loc2_;
            this.FScene["tf_select0"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_63,_loc2_);
            _loc2_ = int(this.FTotleExp * this.FGoldDevourCost) * this.FGoldExp;
            _loc2_ = Math.max(_loc2_ - _loc2_ % 10,10);
            this.FCurCostGold = _loc2_;
            this.FScene["tf_select1"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_64,_loc2_);
         }
         else
         {
            this.FScene["tf_select0"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_63,0);
            this.FScene["tf_select1"].text = TUtilityString.Format(STRING_TONGLING.TONGLING_64,0);
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FScene["btn_select" + _loc1_].gotoAndStop(this.FSelectIndex == _loc1_ ? 1 : 2);
            _loc1_++;
         }
      }
      
      protected function OnDevour(param1:MouseEvent) : void
      {
         var _loc2_:TBB_Status = null;
         var _loc3_:TBB_Status = null;
         var _loc4_:String = null;
         var _loc5_:TBB_Exp = null;
         if(this.FDataObj0 == null)
         {
            if(this.FExteShow != null)
            {
               this.FExteShow(STRING_TONGLING.TONGLING_67);
            }
            return;
         }
         if(this.FDataObj1 == null)
         {
            if(this.FExteShow != null)
            {
               this.FExteShow(STRING_TONGLING.TONGLING_68);
            }
            return;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Exp,this.FDataObj0.Id) as TBB_Exp;
         if(!_loc5_.LvArr[this.FDataObj0.Level] || _loc5_.LvArr[this.FDataObj0.Level] == 0)
         {
            this.FExteShow(STRING_FETEBLOODMAINMANAGE.DOntTipManLevel);
            return;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FDataObj0.Id) as TBB_Status;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FDataObj1.Id) as TBB_Status;
         _loc4_ = TUtilityString.Format(STRING_TONGLING.TONGLING_73,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc2_.Rarity],_loc2_.Name,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc3_.Rarity],_loc3_.Name,this.FSelectIndex == 0 ? this.FCurCostSilver : this.FCurCostGold,this.FSelectIndex == 0 ? STRING_COMMON.ITEMNAME_Coin : STRING_COMMON.ITEMNAME_Gold);
         this.FPopWindow.SetHtml = _loc4_;
         this.FPopWindow.Visible = true;
      }
      
      protected function OnCancelDevour(param1:Object) : void
      {
         this.FHasWaste = true;
      }
      
      protected function OnSureDevour(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FHasWaste)
         {
            this.FPopWindow.SetHtml = STRING_TONGLING.TONGLING_80;
            this.FPopWindow.Visible = true;
            this.FHasWaste = false;
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DevourBeast_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FDataObj0.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj0.Identifier1);
         _loc3_.writeUnsignedInt(this.FDataObj1.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj1.Identifier1);
         _loc3_.writeUnsignedInt(this.FSelectIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnUint_Click(param1:Object) : void
      {
         if(this.FTongLingUint0.Content == param1)
         {
            this.FDataObj0 = null;
            this.FTongLingUint0.Content = null;
         }
         if(this.FTongLingUint1.Content == param1)
         {
            this.FDataObj1 = null;
            this.FTongLingUint1.Content = null;
            this.FTotleExp = 0;
         }
         if(this.FOnUint_Out != null)
         {
            this.FOnUint_Out(param1,false);
         }
         if(param1.num == 0)
         {
            this.FTongLingUint0.IconHighLight = false;
         }
         else if(param1.num == 1)
         {
            this.FTongLingUint1.IconHighLight = false;
         }
         this.Updata();
         this.UpdataSelect();
      }
      
      protected function OnUintMove(param1:Object) : void
      {
         param1.self = 1;
         if(this.FOnUint_Move != null)
         {
            this.FOnUint_Move(param1);
         }
      }
      
      protected function OnUintOut(param1:Object) : void
      {
         param1.self = 0;
         if(this.FOnUint_Out != null)
         {
            this.FOnUint_Out(param1,false);
         }
         if(param1.num == 0)
         {
            this.FTongLingUint0.IconHighLight = false;
         }
         else if(param1.num == 1)
         {
            this.FTongLingUint1.IconHighLight = false;
         }
      }
      
      protected function OnUintOver(param1:Object) : void
      {
         if(param1.num == 0)
         {
            this.FTongLingUint0.IconHighLight = true;
         }
         else if(param1.num == 1)
         {
            this.FTongLingUint1.IconHighLight = true;
         }
      }
      
      protected function OnSelected(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(10));
         this.FSelectIndex = _loc2_;
         this.Updata();
         this.UpdataSelect();
      }
      
      public function get OnGotoPractice() : Function
      {
         return this.FOnGotoPractice;
      }
      
      public function set OnGotoPractice(param1:Function) : void
      {
         this.FOnGotoPractice = param1;
      }
      
      public function get OnUint_Move() : Function
      {
         return this.FOnUint_Move;
      }
      
      public function set OnUint_Move(param1:Function) : void
      {
         this.FOnUint_Move = param1;
      }
      
      public function get OnUint_Out() : Function
      {
         return this.FOnUint_Out;
      }
      
      public function set OnUint_Out(param1:Function) : void
      {
         this.FOnUint_Out = param1;
      }
      
      public function get OnUint_Over() : Function
      {
         return this.FOnUint_Over;
      }
      
      public function set OnUint_Over(param1:Function) : void
      {
         this.FOnUint_Over = param1;
      }
      
      public function get ExteShow() : Function
      {
         return this.FExteShow;
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
      
      public function seRoot(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TConfigValue = null;
         this.FScene = param1;
         this.FScene["btn_devour"].addEventListener(MouseEvent.CLICK,this.OnDevour);
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            this.FScene["btn_select" + _loc2_].addEventListener(MouseEvent.CLICK,this.OnSelected);
            _loc2_++;
         }
         this.FTongLingUint0 = new TongLingUint(this.FScene[CONST_TONGLINGANIMAL.TONGLING_MC_Slot_ + 0]);
         this.FTongLingUint1 = new TongLingUint(this.FScene[CONST_TONGLINGANIMAL.TONGLING_MC_Slot_ + 1]);
         this.FTongLingUint0.Back_Click = this.OnUint_Click;
         this.FTongLingUint1.Back_Click = this.OnUint_Click;
         this.FTongLingUint0.Back_Down = this.OnUint_Click;
         this.FTongLingUint1.Back_Down = this.OnUint_Click;
         this.FTongLingUint0.Back_Move = this.OnUintMove;
         this.FTongLingUint1.Back_Move = this.OnUintMove;
         this.FTongLingUint0.Back_Out = this.OnUintOut;
         this.FTongLingUint1.Back_Out = this.OnUintOut;
         this.FTongLingUint0.Back_Over = this.OnUintOver;
         this.FTongLingUint1.Back_Over = this.OnUintOver;
         this.FTongLingUint0.Lock = false;
         this.FTongLingUint1.Lock = false;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_SilverCoinDevourCost) as TConfigValue;
         this.FSilverCoinDevourCost = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldDevourCost) as TConfigValue;
         this.FGoldDevourCost = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_SilverCoinWashCost) as TConfigValue;
         this.FSilverCoinWashCost = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldWashCost) as TConfigValue;
         this.FGoldWashCost = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_SilverCoinExp) as TConfigValue;
         this.FSilverCoinExp = _loc3_.Value as Number;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_GoldExp) as TConfigValue;
         this.FGoldExp = _loc3_.Value as Number;
         this.FPopWindow = new TUIWindowConfirmation(this.Parent);
         this.FPopWindow.OnOK = this.OnSureDevour;
         this.FPopWindow.OnCancel = this.OnCancelDevour;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
      }
      
      public function SetMsg(param1:Object, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:TBB_Exp = null;
         if(param2 == 0)
         {
            this.FDataObj0 = param1;
            this.FTongLingUint0.Content = param1;
            if(this.FTongLingUint1.Content == param1)
            {
               this.FDataObj1 = null;
               this.FTongLingUint1.Content = null;
            }
         }
         else if(param2 == 1)
         {
            this.FDataObj1 = param1;
            this.FTongLingUint1.Content = param1;
            if(this.FTongLingUint0.Content == param1)
            {
               this.FDataObj0 = null;
               this.FTongLingUint0.Content = null;
            }
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Exp,this.FDataObj1.Id) as TBB_Exp;
            this.FTotleExp = this.FDataObj1.CurExp + _loc4_.PRE_EXP;
            _loc3_ = int(this.FDataObj1.Level - 1);
            while(_loc3_ >= 1)
            {
               this.FTotleExp += _loc4_.LvArr[_loc3_];
               _loc3_--;
            }
         }
         this.Updata();
         this.UpdataSelect();
      }
      
      public function Reset() : void
      {
         this.FDataObj0 = null;
         this.FDataObj1 = null;
         this.FTongLingUint0.Content = null;
         this.FTongLingUint1.Content = null;
         this.Updata();
         this.UpdataSelect();
      }
      
      public function UpdatePet() : void
      {
         if(this.FTongLingUint0 != null)
         {
            this.FTongLingUint0.Update();
         }
         if(this.FTongLingUint1 != null)
         {
            this.FTongLingUint1.Update();
         }
      }
   }
}

