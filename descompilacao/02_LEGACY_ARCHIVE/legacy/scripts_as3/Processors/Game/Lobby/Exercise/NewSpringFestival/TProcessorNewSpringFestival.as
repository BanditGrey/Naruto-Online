package Processors.Game.Lobby.Exercise.NewSpringFestival
{
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.data.NewSpring2018Data;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.items.TNewSpringLanternItem;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.panels.TNewSpringPanel_1;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.panels.TNewSpringPanel_2;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.panels.TNewSpringPanel_3;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.panels.TNewSpringRewardsPreview;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.panels.TNewSpringShop2018;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.stream.TUnstreamizerNewSpring2018;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorNewSpringFestival extends TProcessorBaseActivity
   {
      
      public static const COMPLETE_TASK:int = 0;
      
      public static const GET_BOX:int = 1;
      
      public static const OPEN_BAG:int = 2;
      
      public static const EXCHANGE_SHOPITEM:int = 3;
      
      public static const EXCHANGE_BAG:int = 4;
      
      public static const REFRESH_DISCOUNT:int = 5;
      
      public static const BUY_LANTERN:int = 6;
      
      public static const REFRESH_LANTERN:int = 7;
      
      private var _mainTab:TUITab;
      
      private const TAB_COUNT:int = 3;
      
      public var tabConfig1:TBins;
      
      public var tabConfig2:TBins;
      
      private var _panelDescs:Array;
      
      private var _tUnstreamizerNewSpring2018:TUnstreamizerNewSpring2018;
      
      private var _newSpring2018Data:NewSpring2018Data;
      
      private var _newSpringPanel_1:TNewSpringPanel_1;
      
      private var _newSpringPanel_2:TNewSpringPanel_2;
      
      private var _newSpringPanel_3:TNewSpringPanel_3;
      
      private var _tNewSpringShop2018:TNewSpringShop2018;
      
      private var _tNewSpringRewardsPreview:TNewSpringRewardsPreview;
      
      public var ComponentsHintOnOver:Function;
      
      public var ComponentsHintOnOut:Function;
      
      private var FBoxList:Object;
      
      private var SenderObj:Object;
      
      public function TProcessorNewSpringFestival(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         this.ActivityID = param3;
         this._newSpring2018Data = new NewSpring2018Data();
         this._tUnstreamizerNewSpring2018 = new TUnstreamizerNewSpring2018();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.tabConfig1 = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config1);
         this.tabConfig2 = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config2);
         this._panelDescs = [SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityDesc).GetDatebaseByIdentifier(10112)["Desc"],SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityDesc).GetDatebaseByIdentifier(10113)["Desc"],SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityDesc).GetDatebaseByIdentifier(10114)["Desc"]];
         this._mainTab = new TUITab(this);
         var _loc2_:int = 0;
         while(_loc2_ < this.TAB_COUNT)
         {
            _loc1_ = FMC_Scene["TF_tab_" + _loc2_];
            this._mainTab.SetTabByIndex(_loc1_,_loc2_);
            this._mainTab.SetTabCaptionByIndex(null,_loc2_);
            _loc2_++;
         }
         this._mainTab.OnSwitch = this.onTabSwitch;
         this._mainTab.Init();
         this.onTabSwitch(0);
         this.initPanels();
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_ = int(this.FBoxList[_loc4_.name]);
         if(this._newSpring2018Data.giftBoxRewards.length == 0)
         {
            return;
         }
         _loc3_ = this._newSpring2018Data.giftBoxRewards[_loc2_].Inventories;
         if(!_loc3_)
         {
            return;
         }
         ProcessorOnNewBoxOver(_loc3_);
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         ProcessorOnNewBoxOut();
      }
      
      private function initPanels() : void
      {
         var _loc2_:MovieClip = null;
         this._newSpringPanel_1 = new TNewSpringPanel_1(this);
         this._newSpringPanel_1.Perform_UIDispatch(FMC_Scene["mc_tab_0"]);
         this._newSpringPanel_2 = new TNewSpringPanel_2(this);
         this._newSpringPanel_2.Perform_UIDispatch(FMC_Scene["mc_tab_1"]);
         this._newSpringPanel_3 = new TNewSpringPanel_3(this);
         this._newSpringPanel_3.Perform_UIDispatch(FMC_Scene["mc_tab_2"]);
         this._tNewSpringShop2018 = new TNewSpringShop2018(this);
         this._tNewSpringShop2018.initUI();
         this._tNewSpringShop2018.Visible = false;
         this._tNewSpringShop2018.OnOverlay = UIComponentsHintOnOver;
         this._tNewSpringShop2018.OnOut = UIComponentsHintOnOut;
         this._tNewSpringShop2018.OnExchange = this.ProcessorOnExchangeItem;
         this._tNewSpringRewardsPreview = new TNewSpringRewardsPreview(this);
         this._tNewSpringRewardsPreview.initUI();
         this._tNewSpringRewardsPreview.Visible = false;
         this._tNewSpringRewardsPreview.OnOverlay = UIComponentsHintOnOver;
         this._tNewSpringRewardsPreview.OnOut = UIComponentsHintOnOut;
         this.FBoxList = new Object();
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = FMC_Scene["mc_tab_0"]["mc_giftBox_" + _loc1_];
            this.FBoxList[_loc2_.name] = _loc1_;
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._newSpringPanel_3.lanternItems.length)
         {
            (this._newSpringPanel_3.lanternItems[_loc1_] as TNewSpringLanternItem).FShowItem.OnOverlay = UIComponentsHintOnOver;
            (this._newSpringPanel_3.lanternItems[_loc1_] as TNewSpringLanternItem).FShowItem.OnOut = UIComponentsHintOnOut;
            _loc1_++;
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(param1);
         PerformPacket_CS_AllReq(EXCHANGE_SHOPITEM,_loc2_);
      }
      
      private function updateActiveInfo() : void
      {
         var _loc1_:String = this.tabConfig2.GetDatebaseByIdentifier(60001)["endTime"] + "23:59";
         var _loc2_:RegExp = /-/g;
         _loc1_ = _loc1_.replace(_loc2_,"/");
         var _loc3_:Date = new Date();
         _loc3_.time = Date.parse(_loc1_);
         var _loc4_:uint = Math.round(_loc3_.getTime() / 1000);
         var _loc5_:String = TGameUtil.FomatDayAndTime(_loc4_ - STimingCore.GetServerTick());
         (FMC_Scene["TF_Value_0"] as TextField).text = this.tabConfig2.GetDatebaseByIdentifier(60001)["endTime"];
         (FMC_Scene["TF_Value_2"] as TextField).text = _loc5_;
      }
      
      public function showBuyConfimBox(param1:Object) : void
      {
         this.SenderObj = param1;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.SenderObj["const"]);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:Vector.<int> = this.SenderObj["data"];
         var _loc3_:int = int(this.SenderObj["const"]);
         var _loc4_:int = int(this.SenderObj["type"]);
         if(this._newSpring2018Data.IsCreditGoldEnough(_loc3_))
         {
            PerformPacket_CS_AllReq(_loc4_,_loc2_);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      private function onTabSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         var _loc3_:int = 0;
         while(_loc3_ < this.TAB_COUNT)
         {
            (FMC_Scene["mc_tab_" + String(_loc3_)] as MovieClip).visible = _loc2_ == _loc3_;
            _loc3_++;
         }
         (FMC_Scene["TF_Value_1"] as TextField).text = this._panelDescs[_loc2_];
      }
      
      private function onCloseHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene["Btn_Close"].addEventListener(MouseEvent.CLICK,this.onCloseHandler);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FMC_Scene == null || this.Visible == false)
         {
            return;
         }
         var _loc1_:String = TGameUtil.FomatDayAndTime(this.newSpring2018Data.endTime - TMarriedModel.CurrentServerTime);
         (FMC_Scene["TF_Value_2"] as TextField).text = _loc1_;
         if(Boolean(this._newSpringPanel_2) && this._newSpringPanel_2.Visible)
         {
            this._newSpringPanel_2.LogicsPerform();
         }
         if(Boolean(this._newSpringPanel_3) && this._newSpringPanel_3.Visible)
         {
            this._newSpringPanel_3.LogicsPerform();
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.updateActiveInfo();
         this._newSpringPanel_1.UpdateUI();
         this._newSpringPanel_2.UpdateUI();
         this._newSpringPanel_3.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         super.ProcessorAllRet(param1);
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case COMPLETE_TASK:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this._newSpring2018Data.taskPoint = _loc2_.readUnsignedInt();
               _loc8_ = 0;
               while(_loc8_ < this._newSpring2018Data.taskInfo.length)
               {
                  if(_loc5_ == this._newSpring2018Data.taskInfo[_loc8_].taskId)
                  {
                     this._newSpring2018Data.taskInfo[_loc8_].status = -1;
                  }
                  _loc8_++;
               }
               this._newSpringPanel_1.UpdateUI();
               break;
            case GET_BOX:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this._newSpring2018Data.taskPoint = _loc2_.readUnsignedInt();
               if(_loc5_ == 0)
               {
                  this._newSpring2018Data.boxFlag1 = 1;
               }
               else
               {
                  this._newSpring2018Data.boxFlag2 = 1;
               }
               _loc6_ = this._tUnstreamizerNewSpring2018.getCompleteRewards(_loc2_);
               ProcessorEffectText(_loc6_);
               this._newSpringPanel_1.UpdateUI();
               break;
            case OPEN_BAG:
               _loc5_ = int(_loc2_.readUnsignedInt());
               if(_loc5_ == 0)
               {
                  this._newSpring2018Data.openNomalBagTimes = _loc2_.readUnsignedInt();
               }
               else
               {
                  this._newSpring2018Data.openSuperBagTimes = _loc2_.readUnsignedInt();
               }
               this._newSpring2018Data.shopPoint = _loc2_.readUnsignedInt();
               _loc6_ = this._tUnstreamizerNewSpring2018.getCompleteRewards(_loc2_);
               this._newSpringPanel_2.UpdateUI();
               ProcessorEffectText(_loc6_);
               break;
            case EXCHANGE_SHOPITEM:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this._newSpring2018Data.shopBuyTimes[_loc5_ - 1] = _loc2_.readUnsignedInt();
               this._newSpring2018Data.shopPoint = _loc2_.readUnsignedInt();
               this._tNewSpringShop2018.UpdateUI(this._newSpring2018Data);
               _loc6_ = this._tUnstreamizerNewSpring2018.getCompleteRewards(_loc2_);
               ProcessorEffectText(_loc6_);
               break;
            case EXCHANGE_BAG:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc7_ = int(_loc2_.readUnsignedInt());
               if(_loc5_ == 0)
               {
                  this._newSpring2018Data.openNomalBagTimes = _loc7_;
               }
               else
               {
                  this._newSpring2018Data.openSuperBagTimes = _loc7_;
               }
               this._newSpring2018Data.consumePoint = _loc2_.readUnsignedInt();
               this._newSpringPanel_2.UpdateUI();
               this._newSpringPanel_3.UpdateUI();
               EffectGenerateTextByErrorCode(1386);
               break;
            case REFRESH_DISCOUNT:
               this._newSpring2018Data.sale = _loc2_.readUnsignedInt();
               this._newSpring2018Data.consumePoint = _loc2_.readUnsignedInt();
               this._newSpringPanel_3.showEffect();
               this._newSpringPanel_3.UpdateUI();
               EffectGenerateTextByErrorCode(1387);
               break;
            case REFRESH_LANTERN:
               _loc5_ = int(_loc2_.readUnsignedInt());
               this._tUnstreamizerNewSpring2018.ProcessorRefreshLanternRet(_loc2_,_loc5_,this._newSpring2018Data);
               this._newSpring2018Data.consumePoint = _loc2_.readUnsignedInt();
               this._newSpringPanel_3.restLanternItem(_loc5_);
               this._newSpringPanel_3.UpdateUI();
               EffectGenerateTextByErrorCode(1387);
               break;
            case BUY_LANTERN:
               this._tUnstreamizerNewSpring2018.ProcessorRefreshAllLanternRet(_loc2_,this._newSpring2018Data);
               this._newSpring2018Data.consumePoint = _loc2_.readUnsignedInt();
               _loc6_ = this._tUnstreamizerNewSpring2018.getCompleteRewards(_loc2_);
               this._newSpring2018Data.sale = 9;
               ProcessorEffectText(_loc6_);
               this._newSpringPanel_3.restLanternItem();
               this._newSpringPanel_3.UpdateUI();
         }
      }
      
      public function Packet_CS_AllReq(param1:int, param2:Vector.<int> = null, param3:String = "") : void
      {
         super.PerformPacket_CS_AllReq(param1,param2,param3);
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this._tUnstreamizerNewSpring2018.Unstreamize(_loc2_,this._newSpring2018Data,null);
         this.UpdateUI();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      public function get newSpring2018Data() : NewSpring2018Data
      {
         return this._newSpring2018Data;
      }
      
      public function set newSpring2018Data(param1:NewSpring2018Data) : void
      {
         this._newSpring2018Data = param1;
      }
      
      public function get tNewSpringShop2018() : TNewSpringShop2018
      {
         return this._tNewSpringShop2018;
      }
      
      public function set tNewSpringShop2018(param1:TNewSpringShop2018) : void
      {
         this._tNewSpringShop2018 = param1;
      }
      
      public function get tNewSpringRewardsPreview() : TNewSpringRewardsPreview
      {
         return this._tNewSpringRewardsPreview;
      }
      
      public function set tNewSpringRewardsPreview(param1:TNewSpringRewardsPreview) : void
      {
         this._tNewSpringRewardsPreview = param1;
      }
   }
}

