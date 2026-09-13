package Processors.Game.Lobby.Exercise.CreationAncestor
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.CreationAncestor.TCreationAncestor;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerCreationAncestor;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorCreationAncestor extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const GET_BOX_REQ:int = 1;
      
      public static const GET_SERVER_BOX_REQ:int = 2;
      
      public static const PLAY_GAME_REQ:int = 3;
      
      public static const AUTO_GAME_REQ:int = 4;
      
      public static const ACTIVE_GAME_REQ:int = 5;
      
      public static const EXCHANGE_ITEM_REQ:int = 6;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUICreationAncestor1,TUICreationAncestor2]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FCreationAncestor:TCreationAncestor;
      
      protected var FUnstreamizerCreationAncestor:TUnstreamizerCreationAncestor;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBuyBoxDate:Object;
      
      protected var FIsOpen:Boolean;
      
      protected var FWindowType:int;
      
      protected var FUITab:TUITab;
      
      public function TProcessorCreationAncestor(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCreationAncestor = SLogicsCore.CreationAncestor;
         this.FUnstreamizerCreationAncestor = new TUnstreamizerCreationAncestor();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUITab = new TUITab(this);
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FBuyBoxDate = new Object();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            this.FUITab.SetTabByIndex(this.FTabList[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ProcessorOnChangePage;
         this.FUITab.Init();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = ProcessorOnShowItemDesc;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         super.UpdateUI();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            if(_loc1_ == this.FChangeTabIndex)
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
      
      protected function ProcessorOnChangePage(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
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
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         FProcessorWindowDesc.BaseActivity = this.FCreationAncestor;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnLoadRank(param1:int) : void
      {
         ProcessorLoadActiveRankNew(param1);
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         this.FChangeTabIndex = 0;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         if(this.FUIWindowVect[0])
         {
            this.FUIWindowVect[0].Unmount();
         }
         TweenUtil.removeAllTween();
         this.FChangeTabIndex = 0;
         this.FUITab.SwithTagManual(0);
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerCreationAncestor.Unstreamize(_loc2_,this.FCreationAncestor,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FCreationAncestor,_loc2_);
      }
      
      override public function ProcessorLoadRankRet(param1:TPacket = null) : void
      {
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         if(this.FIsOpen)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Vector.<uint> = null;
         var _loc24_:Vector.<uint> = null;
         var _loc25_:String = null;
         this.FBeClicked = false;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_ = new Vector.<uint>();
         _loc24_ = new Vector.<uint>();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc10_ = _loc2_.readUnsignedInt();
         _loc2_.readShort();
         if(_loc10_ == GET_BOX_REQ)
         {
            _loc5_ = _loc2_.readUnsignedInt() - 1;
            this.FCreationAncestor.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
            _loc20_ = this.FCreationAncestor.BoxList[_loc5_].Count;
            this.FCreationAncestor.Score += _loc20_;
            this.FCreationAncestor.ServerBox.CurPrice = Math.max(0,this.FCreationAncestor.ServerBox.CurPrice - _loc20_);
            _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            _loc6_ = 0;
            while(_loc6_ < this.FCreationAncestor.BoxList[_loc5_].Inventories.Count)
            {
               _loc9_ = this.FCreationAncestor.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
               _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               _loc6_++;
            }
            ProcessorEffectText(_loc4_);
            this.FCreationAncestor.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCreationAncestor.CheckStatus());
            this.UpdateUI();
         }
         else if(_loc10_ == GET_SERVER_BOX_REQ)
         {
            this.FCreationAncestor.ServerBox.Status = TBaseActivity.STATUS_GETED;
            _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            _loc6_ = 0;
            while(_loc6_ < this.FCreationAncestor.ServerBox.Inventories.Count)
            {
               _loc9_ = this.FCreationAncestor.ServerBox.Inventories.GetInventoryByIndex(_loc6_);
               _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               _loc6_++;
            }
            ProcessorEffectText(_loc4_);
            this.FCreationAncestor.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCreationAncestor.CheckStatus());
            this.UpdateUI();
         }
         else if(_loc10_ == PLAY_GAME_REQ || _loc10_ == AUTO_GAME_REQ)
         {
            this.FCreationAncestor.MapIndex = _loc2_.readUnsignedInt() - 1;
            this.FCreationAncestor.FreeCount = _loc2_.readUnsignedInt();
            this.FCreationAncestor.ShopExchangePoint = _loc2_.readUnsignedInt();
            _loc18_ = int(_loc2_.readUnsignedInt());
            _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            _loc5_ = 0;
            while(_loc5_ < _loc18_)
            {
               _loc16_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc14_ = _loc2_.readUnsignedInt();
               _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc14_ + "\n";
               _loc5_++;
            }
            ProcessorEffectText(_loc4_);
            this.FCreationAncestor.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCreationAncestor.CheckStatus());
            this.UpdateUI();
         }
         else if(_loc10_ == ACTIVE_GAME_REQ)
         {
            this.FCreationAncestor.MaxStep = _loc2_.readUnsignedInt();
            _loc4_ = this.FCreationAncestor.DescListNew[2];
            ProcessorEffectText(_loc4_);
            this.FCreationAncestor.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCreationAncestor.CheckStatus());
            this.UpdateUI();
         }
         else if(_loc10_ == EXCHANGE_ITEM_REQ)
         {
            _loc5_ = _loc2_.readUnsignedInt() - 1;
            --this.FCreationAncestor.ShopExchangeItems[_loc5_].LimitCount;
            this.FCreationAncestor.ShopExchangePoint -= this.FCreationAncestor.ShopExchangeItems[_loc5_].Price;
            _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            _loc6_ = 0;
            while(_loc6_ < this.FCreationAncestor.ShopExchangeItems[_loc5_].Inventories.Count)
            {
               _loc9_ = this.FCreationAncestor.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
               _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               _loc6_++;
            }
            ProcessorEffectText(_loc4_);
            this.FCreationAncestor.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCreationAncestor.CheckStatus());
            this.UpdateUI();
         }
      }
   }
}

