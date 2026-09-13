package Processors.Game.Lobby.SevenKing
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSevenHeroArmy;
   import Logics.DatebaseVO.VO.TSevenHeroDailyAward;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.SLogicsCore;
   import Logics.SevenKing.TSevenKingData;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SEVENHEROS;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowSevenHeros extends TUIComponent
   {
      
      public static const CONST_SEVENHERO_BASEID:uint = 82000003;
      
      public static const CONST_MAXHERO:uint = 7;
      
      public static const CONST_HEROS:uint = 10;
      
      public static const CONST_HERO:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FSevenKingData:TSevenKingData;
      
      protected var FActive:Vector.<TActive>;
      
      protected var FSelectKingIndex:uint;
      
      protected var FRespectCount:uint;
      
      protected var FIsPassAll:Boolean;
      
      protected var FSevenHeroArmy:TSevenHeroArmy;
      
      protected var FHint:THint;
      
      protected var FSign:int;
      
      protected var FType:uint;
      
      protected var FMC_BackgroundEffect:MovieClip;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FPageIndex:uint;
      
      protected var FSelectHeroFight:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowSevenHeros(param1:TUIComponent, param2:MovieClip, param3:TSevenKingData)
      {
         var _loc4_:uint = 0;
         var _loc5_:TActive = null;
         var _loc6_:TSevenHeroArmy = null;
         var _loc7_:MovieClip = null;
         super(param1);
         this.FScene = param2;
         this.FSevenKingData = param3;
         this.FActive = new Vector.<TActive>(CONST_HEROS);
         _loc4_ = 0;
         while(_loc4_ < CONST_HEROS)
         {
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroArmy,CONST_SEVENHERO_BASEID + 3 * _loc4_) as TSevenHeroArmy;
            _loc5_ = TPoolRole.GetActive(this,_loc6_.Model,CONST_MODULES.MODULE_SevenKing,true);
            this.FScene["mc_hero_" + _loc4_].addChild(_loc5_);
            this.FActive[_loc4_] = _loc5_;
            _loc5_.filters = [TGameUtil.GaryColorFilters];
            _loc7_ = this.FScene["mc_hero_" + _loc4_];
            _loc7_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHeroMove);
            _loc7_.addEventListener(MouseEvent.ROLL_OUT,this.OnHeroOut);
            _loc7_ = this.FScene["mc_btn_" + _loc4_].btn_Respect;
            TGameUtil.setButtonMode(_loc7_,true);
            _loc7_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnMove);
            _loc7_.addEventListener(MouseEvent.ROLL_OUT,this.OnBtnOut);
            _loc7_.addEventListener(MouseEvent.CLICK,this.OnBtnClick);
            _loc7_ = this.FScene["mc_btn_" + _loc4_].btn_OneKey;
            TGameUtil.setButtonMode(_loc7_,true);
            _loc7_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBtnOneKeyMove);
            _loc7_.addEventListener(MouseEvent.ROLL_OUT,this.OnBtnOneKeyOut);
            _loc7_.addEventListener(MouseEvent.CLICK,this.OnBtnClick);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < CONST_HERO)
         {
            this.FScene.mc_generalBox["Friend_" + _loc4_].mc_head.gotoAndStop(11);
            TGameUtil.setButtonMode(this.FScene.mc_generalBox["Friend_" + _loc4_],true);
            this.FScene.mc_generalBox["Friend_" + _loc4_].addEventListener(MouseEvent.CLICK,this.OnFightHero);
            this.FScene.mc_generalBox["Friend_" + _loc4_].addEventListener(MouseEvent.MOUSE_MOVE,this.OnFightHeroOver);
            this.FScene.mc_generalBox["Friend_" + _loc4_].addEventListener(MouseEvent.MOUSE_OUT,this.OnFightHeroOut);
            _loc4_++;
         }
         this.FMC_BackgroundEffect = this.FScene["MC_BackgroundEffect"];
         this.FHint = new THint();
         this.FSign = -1;
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FScene.MC_BG.gotoAndStop(1);
         TGameUtil.setButtonMode(this.FScene.Btn_Back,true);
         TGameUtil.setButtonMode(this.FScene.Btn_Upground,true);
         this.FScene.Btn_Back.visible = false;
         this.FScene.Btn_Upground.visible = true;
         this.FScene.Btn_Back.addEventListener(MouseEvent.CLICK,this.OnBackClick);
         this.FScene.Btn_Upground.addEventListener(MouseEvent.CLICK,this.OnUpgroundClick);
         this.FPageIndex = 0;
         if(!SLogicsCore.Character.GetConfigValueById(91000012))
         {
            this.FScene.Btn_Upground.visible = false;
         }
      }
      
      protected function UpdateBtnOneKey() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:MovieClip = null;
         var _loc5_:TConfigValue = null;
         var _loc6_:TVipConfig = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TBins = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig) as TBins;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVEN_HERO_BATCH_WORSHIP_COUTN) as TConfigValue;
         _loc7_ = uint(SLogicsCore.Character.VipLevel);
         _loc2_ = uint(_loc9_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = _loc9_.GetDatebaseByIndex(_loc1_) as TVipConfig;
            if(Boolean(_loc6_.SevenHeroOneKey))
            {
               _loc8_ = uint(_loc6_.Identifier);
               break;
            }
            _loc1_++;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,_loc7_) as TVipConfig;
         _loc3_ = _loc7_ >= _loc8_ ? true : false;
         if(_loc3_)
         {
            _loc1_ = 0;
            while(_loc1_ < CONST_HEROS)
            {
               _loc4_ = this.FScene["mc_btn_" + _loc1_].btn_OneKey;
               _loc11_ = this.FSevenKingData.RespectInfo[_loc1_ + 1];
               _loc10_ = _loc6_.SevenHeroCount - _loc11_ - (_loc5_.Value as uint);
               if(_loc10_ < 0)
               {
                  _loc4_.mouseEnabled = false;
                  _loc4_.filters = [TGameUtil.GaryColorFilters];
                  if(_loc4_.hasEventListener(MouseEvent.CLICK))
                  {
                     _loc4_.removeEventListener(MouseEvent.CLICK,this.OnBtnClick);
                  }
               }
               else
               {
                  _loc4_.mouseEnabled = true;
                  _loc4_.filters = [];
                  TGameUtil.setButtonMode(_loc4_,_loc3_);
                  if(!_loc4_.hasEventListener(MouseEvent.CLICK))
                  {
                     _loc4_.addEventListener(MouseEvent.CLICK,this.OnBtnClick);
                  }
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < CONST_HEROS)
            {
               _loc11_ = this.FSevenKingData.RespectInfo[_loc1_ + 1];
               _loc4_ = this.FScene["mc_btn_" + _loc1_].btn_OneKey;
               _loc4_.filters = [TGameUtil.GaryColorFilters];
               if(_loc4_.hasEventListener(MouseEvent.CLICK))
               {
                  _loc4_.removeEventListener(MouseEvent.CLICK,this.OnBtnClick);
               }
               _loc1_++;
            }
         }
         _loc2_ = CONST_HEROS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc11_ = this.FSevenKingData.RespectInfo[_loc1_ + 1];
            _loc10_ = _loc6_.SevenHeroCount - _loc11_;
            if(_loc10_ <= 0)
            {
               this.FScene["mc_btn_" + _loc1_].btn_Respect.filters = [TGameUtil.GaryColorFilters];
            }
            else
            {
               this.FScene["mc_btn_" + _loc1_].btn_Respect.filters = [];
            }
            _loc1_++;
         }
      }
      
      protected function GetRespectCost(param1:uint, param2:uint, param3:Array) : uint
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc5_ = param1;
         while(_loc5_ > 0)
         {
            _loc6_ += parseInt(param3[param2]);
            param2++;
            _loc5_--;
         }
         return _loc6_;
      }
      
      protected function OnHeroMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TSevenHeroDailyAward = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBins = null;
         var _loc7_:uint = 0;
         _loc5_ = param1.currentTarget as MovieClip;
         _loc7_ = parseInt(_loc5_.name.split("_")[2]) + 1;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SevenHeroDailyAward) as TBins;
         _loc3_ = uint(_loc6_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc6_.GetDatebaseByIndex(_loc2_) as TSevenHeroDailyAward;
            if(_loc4_.Identifier % 100 == _loc7_)
            {
               if(this.FUIComponentsOnOver != null)
               {
                  this.FUIComponentsOnOver(this,_loc4_);
               }
            }
            _loc2_++;
         }
      }
      
      protected function OnHeroOut(param1:MouseEvent) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this);
         }
      }
      
      protected function OnBtnMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:TBins = null;
         var _loc6_:TSevenHeroDailyAward = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:TVipConfig = null;
         var _loc10_:int = 0;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,SLogicsCore.Character.VipLevel) as TVipConfig;
         if(param1 != null)
         {
            _loc2_ = param1.currentTarget as MovieClip;
            _loc3_ = parseInt(_loc2_.parent.name.split("_")[2]);
            this.FSign = _loc3_;
         }
         else
         {
            _loc3_ = uint(this.FSign);
         }
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SevenHeroDailyAward) as TBins;
         _loc6_ = _loc5_.GetDatebaseByIndex(_loc3_) as TSevenHeroDailyAward;
         _loc7_ = this.FSevenKingData.RespectInfo[_loc3_ + 1];
         _loc8_ = _loc6_.RewardVect[_loc7_] as Object;
         if(_loc7_ == 0)
         {
            _loc4_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_TodayFree,STRING_COMMON.STRING_KingSouls[_loc3_],_loc8_["amount"]);
         }
         else
         {
            _loc10_ = _loc9_.SevenHeroCount - _loc7_;
            if(_loc10_ > 0)
            {
               _loc4_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_TotalRespectCounts,_loc10_,_loc6_.CostVect[_loc7_],_loc8_["amount"],STRING_COMMON.STRING_KingSouls[_loc3_]);
            }
            else
            {
               _loc4_ = STRING_SEVENHEROS.FORMAT_CountOut;
            }
         }
         this.FHint.Caption = _loc4_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function OnBtnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function OnBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:TPacket = null;
         var _loc4_:uint = 0;
         var _loc5_:TSevenHeroDailyAward = null;
         var _loc6_:TConfigValue = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:TVipConfig = null;
         var _loc10_:uint = 0;
         _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,SLogicsCore.Character.VipLevel) as TVipConfig;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVEN_HERO_BATCH_WORSHIP_COUTN) as TConfigValue;
         this.FSelectKingIndex = int(String(param1.currentTarget.parent.name).slice(7));
         this.FType = 82100001 + this.FSelectKingIndex;
         switch(param1.currentTarget.name)
         {
            case "btn_Respect":
               this.FRespectCount = 1;
               break;
            case "btn_OneKey":
               this.FRespectCount = _loc6_.Value as int;
               break;
            default:
               this.FRespectCount = 1;
         }
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroDailyAward,this.FType) as TSevenHeroDailyAward;
         _loc4_ = this.FSevenKingData.RespectInfo[this.FSelectKingIndex + 1];
         if(_loc4_ == 0)
         {
            if(this.FRespectCount == 1)
            {
               this.WindowConfirmationOnOK(null);
               return;
            }
         }
         _loc10_ = _loc9_.SevenHeroCount - _loc4_;
         if(_loc10_ == 0)
         {
            return;
         }
         _loc8_ = _loc5_.RewardVect[_loc4_] as Object;
         _loc7_ = this.GetRespectCost(this.FRespectCount,_loc4_,_loc5_.CostVect);
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < _loc7_)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            if(this.FRespectCount == 1)
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_SevenStar_Practice).DescribeString,_loc7_);
            }
            else
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_SevenStar_Practice_All).DescribeString,_loc7_,this.FRespectCount);
            }
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK(null);
         }
      }
      
      protected function OnFightHero(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(7)));
         if(_loc2_ + 1 != this.FSevenHeroArmy.SortNumber)
         {
            return;
         }
         if(this.FSelectHeroFight != null)
         {
            this.FSelectHeroFight(this,this.FSevenHeroArmy);
         }
      }
      
      protected function OnFightHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
      }
      
      protected function OnFightHeroOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(1);
      }
      
      protected function OnBtnOneKeyMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:TBins = null;
         var _loc6_:TSevenHeroDailyAward = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:TConfigValue = null;
         var _loc10_:TVipConfig = null;
         var _loc11_:int = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig) as TBins;
         _loc12_ = uint(SLogicsCore.Character.VipLevel);
         _loc7_ = uint(_loc5_.Count);
         _loc11_ = 0;
         while(_loc11_ < _loc7_)
         {
            _loc10_ = _loc5_.GetDatebaseByIndex(_loc11_) as TVipConfig;
            if(Boolean(_loc10_.SevenHeroOneKey))
            {
               _loc13_ = uint(_loc10_.Identifier);
               break;
            }
            _loc11_++;
         }
         if(_loc12_ < _loc13_)
         {
            _loc4_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_VipLimitedOpen,_loc13_);
         }
         else
         {
            _loc2_ = param1.currentTarget as MovieClip;
            _loc3_ = parseInt(_loc2_.parent.name.split("_")[2]);
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVEN_HERO_BATCH_WORSHIP_COUTN) as TConfigValue;
            _loc4_ = TUtilityString.Format(STRING_SEVENHEROS.FORMAT_OneKeyRespect,STRING_COMMON.STRING_KingHeros[_loc3_],_loc9_.Value);
         }
         this.FHint.Caption = _loc4_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function OnBtnOneKeyOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SevenKing_RespectReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FType);
         _loc3_.writeUnsignedInt(this.FRespectCount);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnBackClick(param1:MouseEvent) : void
      {
         this.FScene.Btn_Back.visible = false;
         this.FScene.Btn_Upground.visible = true;
         this.FPageIndex = 0;
         this.UpdataUI();
      }
      
      protected function OnUpgroundClick(param1:MouseEvent) : void
      {
         if(param1)
         {
            if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
            {
               return;
            }
         }
         this.FScene.Btn_Back.visible = true;
         this.FScene.Btn_Upground.visible = false;
         this.FPageIndex = 1;
         this.UpdataUI();
      }
      
      public function get SelectKingIndex() : uint
      {
         return this.FSelectKingIndex;
      }
      
      public function get RespectCount() : uint
      {
         return this.FRespectCount;
      }
      
      public function get SelectHeroFight() : Function
      {
         return this.FSelectHeroFight;
      }
      
      public function set SelectHeroFight(param1:Function) : void
      {
         this.FSelectHeroFight = param1;
      }
      
      public function get UIComponentsOnOver() : Function
      {
         return this.FUIComponentsOnOver;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function get UIComponentsOnOut() : Function
      {
         return this.FUIComponentsOnOut;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function UpdataUI(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TActive = null;
         var _loc6_:TSevenHeroArmy = null;
         this.FScene.MC_BG.gotoAndStop(this.FPageIndex + 1);
         _loc2_ = 0;
         while(_loc2_ < CONST_HEROS)
         {
            if(this.FPageIndex == 0 && _loc2_ < CONST_MAXHERO || this.FPageIndex == 1 && _loc2_ >= CONST_MAXHERO)
            {
               this.FScene["mc_hero_" + _loc2_].visible = true;
            }
            else
            {
               this.FScene["mc_hero_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(this.FSevenKingData.CurProgressFlag <= 0)
         {
            this.FSevenKingData.CurProgressFlag = 82000001;
         }
         this.FSevenHeroArmy = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroArmy,this.FSevenKingData.CurProgressFlag) as TSevenHeroArmy;
         this.FIsPassAll = Boolean(this.FSevenHeroArmy == null);
         if(this.FIsPassAll)
         {
            _loc3_ = CONST_HEROS;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.FActive[_loc2_].filters = [];
               _loc2_++;
            }
            this.FScene.mc_generalBox.visible = false;
         }
         else
         {
            _loc3_ = Math.ceil(this.FSevenKingData.CurProgressFlag % 100 / 3);
            _loc2_ = 0;
            while(_loc2_ < CONST_HEROS)
            {
               if(_loc2_ < _loc3_)
               {
                  this.FActive[_loc2_].filters = [];
               }
               else
               {
                  this.FActive[_loc2_].filters = [TGameUtil.GaryColorFilters];
               }
               _loc2_++;
            }
            _loc4_ = (this.FSevenKingData.CurProgressFlag % 100 - 1) % 3;
            _loc2_ = 0;
            while(_loc2_ < CONST_HERO)
            {
               if(_loc2_ == _loc4_)
               {
                  this.FScene.mc_generalBox["Friend_" + _loc2_].filters = [];
                  this.FScene.mc_generalBox["Friend_" + _loc2_].MC_KO.visible = true;
                  this.FScene.mc_generalBox["Friend_" + _loc2_].mouseEnabled = true;
               }
               else
               {
                  this.FScene.mc_generalBox["Friend_" + _loc2_].filters = [TGameUtil.GaryColorFilters];
                  this.FScene.mc_generalBox["Friend_" + _loc2_].MC_KO.visible = false;
                  this.FScene.mc_generalBox["Friend_" + _loc2_].mouseEnabled = false;
               }
               _loc2_++;
            }
            if(_loc3_ <= CONST_MAXHERO && this.FPageIndex == 0 || _loc3_ > CONST_MAXHERO && this.FPageIndex == 1)
            {
               this.FScene.mc_generalBox.visible = true;
            }
            else
            {
               this.FScene.mc_generalBox.visible = false;
            }
         }
         if(!this.FIsPassAll)
         {
            this.FScene.mc_generalBox.Friend_2.mc_head.gotoAndStop(this.FSevenHeroArmy.ServenHero - 82100001 + 1);
         }
         _loc2_ = 0;
         while(_loc2_ < CONST_HEROS)
         {
            if(!this.FIsPassAll)
            {
               if(_loc2_ < this.FSevenHeroArmy.ServenHero - 82100001)
               {
                  if(this.FPageIndex == 0 && _loc2_ < CONST_MAXHERO || this.FPageIndex == 1 && _loc2_ >= CONST_MAXHERO)
                  {
                     this.FScene["mc_btn_" + _loc2_].visible = true;
                  }
                  else
                  {
                     this.FScene["mc_btn_" + _loc2_].visible = false;
                  }
               }
               else
               {
                  this.FScene["mc_btn_" + _loc2_].visible = false;
               }
               if(_loc2_ == this.FSevenHeroArmy.ServenHero - 82100001)
               {
                  this.FScene["mc_btn_" + _loc2_].visible = false;
                  this.FScene.mc_generalBox.x = this.FScene["mc_hero_" + _loc2_].x;
                  this.FScene.mc_generalBox.y = this.FScene["mc_hero_" + _loc2_].y;
               }
            }
            else if(this.FPageIndex == 0 && _loc2_ < CONST_MAXHERO || this.FPageIndex == 1 && _loc2_ >= CONST_MAXHERO)
            {
               this.FScene["mc_btn_" + _loc2_].visible = true;
            }
            else
            {
               this.FScene["mc_btn_" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(!this.FIsPassAll)
         {
            _loc2_ = 0;
            while(_loc2_ < CONST_HERO)
            {
               this.FScene.mc_generalBox["mc_pass_" + _loc2_].visible = Boolean(this.FSevenHeroArmy.SortNumber - 1 > _loc2_);
               _loc2_++;
            }
         }
         TGameUtil.setButtonMode(this.FScene.Btn_Upground,SLogicsCore.Character.GetMainLevel() > CONST_COMMON.Ninja_One_Reincarnation_Footstone);
         this.UpdateBtnOneKey();
      }
      
      public function UpdataHeroActive() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_HEROS)
         {
            this.FActive[_loc1_].UpdateActive();
            _loc1_++;
         }
      }
      
      public function UpdateEffect(param1:Boolean = false) : void
      {
         if(!param1)
         {
            this.FMC_BackgroundEffect.gotoAndStop(1);
         }
         else
         {
            this.FMC_BackgroundEffect.play();
         }
      }
      
      public function CheckPage() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = Math.ceil(this.FSevenKingData.CurProgressFlag % 100 / 3);
         if(CONST_MAXHERO < _loc1_)
         {
            this.OnUpgroundClick(null);
         }
      }
   }
}

