package Processors.Game.Lobby.Prerogative
{
   import Components.Standard.TUITab;
   import Externals.SExternalCore;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.Prerogative.TPrerogativeOne;
   import Logics.Prerogative.TPrerogativeOnes;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive1;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive2;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive3;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive4;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive5;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive6;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIBaiduActive7;
   import Processors.Game.Lobby.Prerogative.Compnent.TUIVIPWelfare;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PREROGATIVE;
   import Resources.Strings.STRING_PREROGATIVE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowPrerogative extends TProcessorWindowTemplate
   {
      
      protected var FMC_Activety0:MovieClip;
      
      protected var FMC_VIPWelfares:Vector.<TUIVIPWelfare>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FUITab:TUITab;
      
      protected var FCurrentPrerogatives:TPrerogativeOnes;
      
      protected var FShowActivities:TPrerogativeOnes;
      
      protected var FTabIndex:int;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIBaiduActive1,TUIBaiduActive2,TUIBaiduActive3,TUIBaiduActive4,TUIBaiduActive5,TUIBaiduActive6,TUIBaiduActive7]);
      
      protected var FActivities:Vector.<MovieClip>;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TProcessorWindowPrerogative(param1:TUIComponent)
      {
         super(param1);
         this.FMC_VIPWelfares = new Vector.<TUIVIPWelfare>();
         this.FUITab = new TUITab(this);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(7);
         this.FActivities = new Vector.<MovieClip>();
         this.FCurrentPrerogatives = new TPrerogativeOnes();
         this.FShowActivities = new TPrerogativeOnes();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIVIPWelfare = null;
         var _loc5_:Class = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_Prerogative") as Sprite;
         UIDispatch();
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = FMainUI["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            this.FUITab.SetTabCaptionByIndex(STRING_PREROGATIVE.STRING_ComingSoon,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc1_ = 0;
         while(_loc1_ < CONST_PREROGATIVE.CAPACITY_Tabs)
         {
            _loc5_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc5_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMainUI["MC_Activety" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetWelfare = this.ProcessorGetWelfareOnClick;
            this.FUIWindowVect[_loc1_].OnRecharge = this.ProcessorRechargeOnClick;
            this.FUIWindowVect[_loc1_].OnInventoryOver = this.ProcessorOnInventoryOver;
            this.FUIWindowVect[_loc1_].OnInventoryOut = this.ProcessorOnInventoryOut;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         FHelpTips.Content = "";
      }
      
      override protected function LogicsPerform() : void
      {
         if(!Visible)
         {
            return;
         }
         if(this.FUIWindowVect.length > 0 && this.FUIWindowVect[this.FTabIndex] != null)
         {
            this.FUIWindowVect[this.FTabIndex].LogicsPerform();
            this.FUIWindowVect[this.FTabIndex].UpdateSlot();
         }
         super.LogicsPerform();
      }
      
      protected function UpdateSlot() : void
      {
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ >= this.FCurrentPrerogatives.Count)
            {
               this.FUITab.SetTabEnabledByIndex(_loc1_,false);
            }
            else
            {
               this.FUITab.SetTabCaptionByIndex(STRING_PREROGATIVE.STRING_TabNames[_loc1_],_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function FilterTabNames() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TPrerogativeOnes = null;
         var _loc4_:TPrerogativeOne = null;
         var _loc5_:TPrerogativeOne = null;
         _loc3_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes;
         this.FCurrentPrerogatives.Clear();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetPrerogativeOneByIndex(_loc1_);
            _loc5_ = this.FCurrentPrerogatives.GetPrerogativeOneByType(_loc4_.Type);
            if(_loc5_ == null)
            {
               this.FCurrentPrerogatives.Add(_loc4_);
            }
            _loc1_++;
         }
         this.FCurrentPrerogatives.Sort();
      }
      
      protected function FilterShowActivity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TPrerogativeOnes = null;
         var _loc4_:TPrerogativeOne = null;
         var _loc5_:TPrerogativeOne = null;
         _loc3_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes;
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetPrerogativeOneByIndex(_loc1_);
            _loc5_ = this.FCurrentPrerogatives.GetPrerogativeOneByType(this.FTabIndex + 1);
            if(_loc5_ != null)
            {
               this.FShowActivities.Add(_loc5_);
            }
            SLogicsCore.PlatformPrerogative.ShowActivities = this.FShowActivities;
            _loc1_++;
         }
      }
      
      protected function ProcessorOnInventoryOver(param1:Object) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(param1);
         }
      }
      
      protected function ProcessorOnInventoryOut(param1:Object) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(param1);
         }
      }
      
      protected function ProcessorGetWelfareOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:TPrerogativeOne = null;
         switch(this.FTabIndex)
         {
            case 0:
               _loc5_ = param2 as TPrerogativeOne;
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Reward_Req);
               _loc4_ = _loc3_.Data;
               _loc4_.writeUnsignedInt(_loc5_.Type);
               _loc4_.writeUnsignedInt(_loc5_.Member);
               SNetworkCore.Transceiver.PacketTransmit(_loc3_);
               break;
            case 1:
               this.ProcessorGetWelfare2OnClick(param1,param2);
         }
      }
      
      protected function ProcessorGetWelfare2OnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:TPrerogativeOne = null;
         _loc5_ = param2 as TPrerogativeOne;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Reward2_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(_loc5_.Type);
         _loc4_.writeUnsignedInt(_loc5_.PrivilegeLevel);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ProcessorRechargeOnClick(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TUIVIPWelfare = null;
         var _loc4_:TPlatformPrerogative = null;
         _loc2_ = (param1 as TUIVIPWelfare).Tag;
         _loc4_ = SLogicsCore.PlatformPrerogative;
         if(_loc2_ == 0)
         {
            SExternalCore.NavigateToUrl(_loc4_.BecomeMemberURL);
         }
         else if(_loc2_ == 1)
         {
            SExternalCore.NavigateToUrl(_loc4_.YearMemberURL);
         }
         SExternalCore.TotalClicks(1);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         switch(this.FTabIndex)
         {
            case 0:
               this.PacketPerform_CS_Data_Req();
               break;
            case 1:
               this.PacketPerform_CS_Data2_Req();
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TPrerogativeOne = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_PREROGATIVE.CAPACITY_Tabs)
         {
            _loc3_ = this.FCurrentPrerogatives.GetPrerogativeOneByType(_loc1_ + 1);
            if(_loc1_ == this.FTabIndex)
            {
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function PacketPerform_CS_Data_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PacketPerform_CS_Data2_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data2_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function Update() : void
      {
         this.FilterTabNames();
         this.FilterShowActivity();
         this.UpdateTabs();
         this.UpdateUI();
      }
      
      public function ResetTab() : void
      {
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
      }
   }
}

