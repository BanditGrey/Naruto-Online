package Processors.Game.Lobby.Exercise.BlackMarket
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.BlackMarket.TBlackMarket;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBlackMarket;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BlackMarket.Compoents.TUIBlackMarketGift;
   import Processors.Game.Lobby.Exercise.BlackMarket.Compoents.TUIBlackMarketShop;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.utils.ByteArray;
   
   public class TProcessorBlackMarket extends TProcessorBaseActivity
   {
      
      public static const TAB_TYPE_SHOP:int = 0;
      
      public static const TAB_TYPE_GIFT:int = 1;
      
      public static const TYPE_BUY_ITEM:int = 1;
      
      public static const TYPE_FREE_FRESH:int = 2;
      
      public static const TYPE_BUY_FRESH:int = 3;
      
      public static const TYPE_GET_GIFT:int = 4;
      
      protected var FBlackMarket:TBlackMarket;
      
      protected var FBeClicked:Boolean;
      
      protected var FUIBlackMarketShop:TUIBlackMarketShop;
      
      protected var FUIBlackMarketGift:TUIBlackMarketGift;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowConfirmationRefresh:TUIWindowConfirmation;
      
      protected var FUnstreamizerBlackMarket:TUnstreamizerBlackMarket;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FChangeTabIndex:int;
      
      protected var FBuyBoxDate:Object;
      
      public function TProcessorBlackMarket(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FBlackMarket = SLogicsCore.BlackMarket;
         this.FUnstreamizerBlackMarket = new TUnstreamizerBlackMarket();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUITab = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FUIWindowConfirmationRefresh = new TUIWindowConfirmation(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FTabVect.push(FMC_Scene["Tab_Shop"]);
         this.FTabVect.push(FMC_Scene["Tab_Gift"]);
         _loc2_ = int(this.FTabVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUITab.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FUIBlackMarketShop = new TUIBlackMarketShop(this.Parent);
         this.FUIBlackMarketShop.Perform_UIDispatch(FMC_Scene["MC_Shop"]);
         this.FUIBlackMarketShop.OnItemOver = UIComponentsHintOnOver;
         this.FUIBlackMarketShop.OnItemOut = UIComponentsHintOnOut;
         this.FUIBlackMarketShop.OnBuyBox = this.ProcessorOnBuyBoxUp;
         this.FUIBlackMarketShop.OnGetBox = this.ProcessorOnGetBoxUp;
         this.FUIBlackMarketShop.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FUIBlackMarketShop.OnLoadLog = this.ProcessorOnLoadLog;
         this.FUIBlackMarketShop.OnShowTip = ProcessorOnShowTip;
         this.FUIBlackMarketShop.OnHideTip = ProcessorOnHideTip;
         this.FUIBlackMarketShop.Visible = true;
         this.FUIBlackMarketGift = new TUIBlackMarketGift(this.Parent);
         this.FUIBlackMarketGift.Perform_UIDispatch(FMC_Scene["MC_Gift"]);
         this.FUIBlackMarketGift.OnItemOver = UIComponentsHintOnOver;
         this.FUIBlackMarketGift.OnItemOut = UIComponentsHintOnOut;
         this.FUIBlackMarketGift.OnGetBox = this.ProcessorOnGetBoxUp;
         this.FUIBlackMarketGift.Visible = false;
         this.FUIWindowConfirmationRefresh.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmationRefresh.OnCancel = WindowCofirmationOnCancel;
         this.FUIWindowConfirmationRefresh.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationRefresh.WindowWidth) / 2;
         this.FUIWindowConfirmationRefresh.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationRefresh.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationRefresh);
         this.FUIWindowConfirmationRefresh.SetCheckBox(false);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
               switch(this.FChangeTabIndex)
               {
                  case TAB_TYPE_SHOP:
                     this.FUIBlackMarketShop.LogicsPerform();
                     break;
                  case TAB_TYPE_GIFT:
                     this.FUIBlackMarketGift.LogicsPerform();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         this.UpdateText();
         if(this.FBlackMarket.IsGetReward())
         {
            FMC_Scene.MC_Tip.visible = true;
         }
         else
         {
            FMC_Scene.MC_Tip.visible = false;
         }
         switch(this.FChangeTabIndex)
         {
            case TAB_TYPE_SHOP:
               this.FUIBlackMarketShop.UpdateUI();
               this.FUIBlackMarketShop.SetVisible(true);
               this.FUIBlackMarketGift.SetVisible(false);
               break;
            case TAB_TYPE_GIFT:
               this.FUIBlackMarketGift.UpdateUI();
               this.FUIBlackMarketShop.SetVisible(false);
               this.FUIBlackMarketGift.SetVisible(true);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         _loc1_ = this.FBlackMarket.ActivityDesc.split("%n%").join("\n");
         FMC_Scene.TF_Desc.htmlText = _loc1_;
         FMC_Scene.TF_Score.text = this.FBlackMarket.Score.toString();
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBlackMarket.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBlackMarket.EndTime) - 1) * 1000)));
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0) : void
      {
         this.FBuyBoxDate.BoxType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.ConfirmType = param6;
         if(param1 == TYPE_FREE_FRESH)
         {
            if(param5 == "")
            {
               this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
               return;
            }
         }
         else if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
            return;
         }
         if(param6 == 0)
         {
            if(!FUIWindowConfirmation.IsSelected)
            {
               if(param5 != "")
               {
                  FUIWindowConfirmation.Text = param5;
               }
               else
               {
                  FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param2);
               }
               FUIWindowConfirmation.SetCheckBox(true);
               FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
         else if(param6 == 1)
         {
            if(!this.FUIWindowConfirmationRefresh.IsSelected)
            {
               if(param5 != "")
               {
                  this.FUIWindowConfirmationRefresh.Text = param5;
               }
               else
               {
                  this.FUIWindowConfirmationRefresh.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,param2);
               }
               this.FUIWindowConfirmationRefresh.SetCheckBox(false);
               this.FUIWindowConfirmationRefresh.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:int = 0;
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
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function ProcessorOnLoadLog() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_OrangeEquipment_LoadLogReq);
         _loc1_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FUIWindowConfirmationRefresh.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerBlackMarket.Unstreamize(_loc2_,this.FBlackMarket,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TLotteryNews = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:TBins = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         this.FBlackMarket.LogList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc10_ = new TLotteryNews();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc7_ = int(_loc2_.readUnsignedShort());
            _loc6_ = 0;
            while(_loc6_ < _loc7_ / 4)
            {
               _loc12_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc13_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
               _loc14_.push(_loc13_);
               _loc15_.push(_loc2_.readUnsignedInt());
               _loc10_.GetTime = _loc2_.readUnsignedInt();
               _loc6_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc15_[0];
            _loc10_.Inventory = _loc8_;
            _loc10_.Inventories = _loc9_;
            this.FBlackMarket.LogList.push(_loc10_);
            _loc4_++;
         }
         FProcessorWindowLog.BaseActivity = this.FBlackMarket;
         FProcessorWindowLog.UpdateUI();
         FProcessorWindowLog.Visible = true;
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
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:uint = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case TYPE_BUY_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FBlackMarket.SpecialItem = _loc2_.readInt();
               this.FBlackMarket.Score += this.FBlackMarket.SaleItem[_loc5_].CurPrice;
               this.FBlackMarket.SaleItem[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FBlackMarket.SaleItem[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FBlackMarket.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FBlackMarket.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_FREE_FRESH:
               this.FBlackMarket.FreshTime = _loc2_.readUnsignedInt();
               _loc19_ = int(_loc2_.readUnsignedInt());
               _loc5_ = 0;
               while(_loc5_ < _loc19_)
               {
                  _loc16_ = new TBaseBox();
                  _loc16_.Level = _loc2_.readUnsignedInt();
                  _loc16_.Status = _loc2_.readInt();
                  _loc16_.Price = _loc2_.readUnsignedInt();
                  _loc16_.CurPrice = _loc2_.readUnsignedInt();
                  _loc13_.length = 0;
                  _loc14_.length = 0;
                  _loc8_ = new TInventories();
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc18_);
                  _loc13_.push(_loc12_);
                  _loc14_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc14_[0];
                  _loc16_.Inventories = _loc8_;
                  this.FBlackMarket.SaleItem[_loc5_] = _loc16_;
                  _loc5_++;
               }
               this.FBlackMarket.SpecialItem = _loc2_.readInt();
               this.FUIBlackMarketShop.PlayMovie();
               ProcessorCheckEffect(FActivityID,this.FBlackMarket.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_BUY_FRESH:
               this.FBlackMarket.Score += this.FBlackMarket.FreshCost;
               this.FBlackMarket.FreshTime = _loc2_.readUnsignedInt();
               _loc19_ = int(_loc2_.readUnsignedInt());
               _loc5_ = 0;
               while(_loc5_ < _loc19_)
               {
                  _loc16_ = new TBaseBox();
                  _loc16_.Level = _loc2_.readUnsignedInt();
                  _loc16_.Status = _loc2_.readInt();
                  _loc16_.Price = _loc2_.readUnsignedInt();
                  _loc16_.CurPrice = _loc2_.readUnsignedInt();
                  _loc13_.length = 0;
                  _loc14_.length = 0;
                  _loc8_ = new TInventories();
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc18_);
                  _loc13_.push(_loc12_);
                  _loc14_.push(_loc2_.readUnsignedInt());
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc13_);
                  _loc8_.GetInventoryByIndex(0).Quantity = _loc14_[0];
                  _loc16_.Inventories = _loc8_;
                  this.FBlackMarket.SaleItem[_loc5_] = _loc16_;
                  _loc5_++;
               }
               this.FBlackMarket.SpecialItem = _loc2_.readInt();
               this.FUIBlackMarketShop.PlayMovie();
               this.UpdateUI();
               this.FBlackMarket.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FBlackMarket.CheckStatus());
               break;
            case TYPE_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FBlackMarket.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FBlackMarket.GiftList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.UpdateUI();
               ProcessorCheckEffect(FActivityID,this.FBlackMarket.CheckStatus());
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,3,0,3,1,3,0]);
         var _loc5_:Vector.<int> = Vector.<int>([100022,0,11210009,0,100023,11110071,0]);
         var _loc6_:Vector.<int> = Vector.<int>([1,0,2,0,1,0,0]);
         var _loc7_:Vector.<int> = Vector.<int>([1,0,-1,0,-1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"<font color=\"#ffffff\">%who%购买了</font>");
         TUtilityString.FlushUTF(_loc3_,"活动说明");
         TUtilityString.FlushUTF(_loc3_,"您黑市商店中出现了稀有道具，再次刷新道具将会消失，您是否要确定刷新");
         TUtilityString.FlushUTF(_loc3_,"确认花费%0金币进行刷新?");
         _loc3_.writeInt(1000);
         _loc3_.writeInt(STimingCore.GetServerTick() + 3);
         _loc3_.writeInt(50);
         _loc3_.writeInt(1);
         _loc3_.writeShort(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc3_.writeInt(_loc4_[_loc1_]);
            _loc3_.writeInt(_loc5_[_loc1_]);
            _loc3_.writeInt(_loc6_[_loc1_]);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeInt(_loc7_[_loc1_]);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            TUtilityString.FlushUTF(_loc3_,"描述4");
            _loc3_.writeUnsignedInt((_loc1_ + 1) * 10);
            _loc3_.writeInt(1);
            _loc3_.writeShort(5);
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            TUtilityString.FlushUTF(_loc3_,"描述" + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

