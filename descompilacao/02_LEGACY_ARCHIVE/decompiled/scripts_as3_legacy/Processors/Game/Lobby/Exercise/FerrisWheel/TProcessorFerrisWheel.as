package Processors.Game.Lobby.Exercise.FerrisWheel
{
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FerrisWheel.TFerrisWheel;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerFerrisWheel;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUINews;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorFerrisWheel extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 10;
      
      protected static const TAB_COUNT:int = 2;
      
      protected static const TAB_TYPE_GOLD:int = 0;
      
      protected static const TAB_TYPE_FREE:int = 1;
      
      protected static const REQ_TYPE_GOLD:int = 1;
      
      protected static const REQ_TYPE_FREE:int = 2;
      
      protected static const ROTATION_COUNT:int = 2;
      
      protected static const RANDOM_COUNT:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FFerrisWheel:TFerrisWheel;
      
      protected var FUnstreamizerFerrisWheel:TUnstreamizerFerrisWheel;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FUINews:TUINews;
      
      protected var FFlowText:String;
      
      protected var FIsPlaying:Boolean;
      
      protected var FItemList:Vector.<MovieClip>;
      
      public function TProcessorFerrisWheel(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FFerrisWheel = SLogicsCore.FerrisWheel;
         this.FUnstreamizerFerrisWheel = new TUnstreamizerFerrisWheel();
         this.FBuyBoxDate = new Object();
         this.FUITab = new TUITab(this);
         this.FItemList = new Vector.<MovieClip>(SHOW_ITEM_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         _loc1_ = 0;
         while(_loc1_ < SHOW_ITEM_COUNT)
         {
            this.FItemList[_loc1_] = FMC_Scene.MC_ShowItem["MC_Slot" + _loc1_];
            _loc1_++;
         }
         this.FUINews = new TUINews(this);
         this.FUINews.Perform_UIDispatch(FMC_Scene["MC_List"]);
         this.FUINews.OnOverlay = UIComponentsHintOnOver;
         this.FUINews.OnOut = UIComponentsHintOnOut;
         FMC_Scene.MC_Tip.visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Start,true);
         FMC_Scene.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateItems();
         this.UpdateBtn();
         this.UpdateNews();
         this.UpdateText();
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         if(this.FChangeTabIndex == TAB_TYPE_GOLD)
         {
            _loc4_ = this.FFerrisWheel.GoldItems;
         }
         else
         {
            _loc4_ = this.FFerrisWheel.FreeItems;
         }
         _loc1_ = 0;
         while(_loc1_ < SHOW_ITEM_COUNT)
         {
            _loc2_ = this.FItemList[_loc1_];
            _loc3_ = _loc4_.GetInventoryByIndex(_loc1_);
            _loc2_.MC_Icon.gotoAndStop(_loc3_.NewType);
            _loc2_.TF_Subscript.text = _loc3_.Quantity.toString();
            if(_loc3_.ShowFire != 0)
            {
               _loc2_.MC_Fire.visible = true;
            }
            else
            {
               _loc2_.MC_Fire.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FChangeTabIndex == TAB_TYPE_GOLD)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Start,true);
         }
         else if(this.FFerrisWheel.FreeCounts > 0 || this.FFerrisWheel.FreeOtherCounts > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Start,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Start,false);
         }
         if(this.FFerrisWheel.FreeCounts > 0)
         {
            FMC_Scene.MC_Tip.visible = true;
         }
         else
         {
            FMC_Scene.MC_Tip.visible = false;
         }
      }
      
      protected function UpdateNews() : void
      {
         this.FUINews.NewsDate = this.FFerrisWheel.NewsList;
         this.FUINews.UpdateUI();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         FMC_Scene.TF_Desc.text = this.FFerrisWheel.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FFerrisWheel.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FFerrisWheel.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Total.text = this.FFerrisWheel.TodayCounts + "/" + this.FFerrisWheel.MaxCounts;
         FMC_Scene.TF_CountDesc.text = this.FFerrisWheel.DescListNew[5 + this.FChangeTabIndex];
         if(this.FChangeTabIndex == TAB_TYPE_GOLD)
         {
            FMC_Scene.MC_GoldDesc.visible = true;
            FMC_Scene.TF_FreeDesc.visible = false;
            FMC_Scene.TF_RemainCount.text = this.FFerrisWheel.GoldCounts.toString();
            FMC_Scene.MC_GoldDesc.TF_Gold.text = this.FFerrisWheel.RechargeGold.toString();
            FMC_Scene.MC_GoldDesc.TF_Desc1.text = TUtilityString.Format(this.FFerrisWheel.DescListNew[2],this.FFerrisWheel.GoldAddCounts);
         }
         else
         {
            FMC_Scene.MC_GoldDesc.visible = false;
            FMC_Scene.TF_FreeDesc.visible = true;
            FMC_Scene.TF_RemainCount.text = this.FFerrisWheel.FreeCounts + "+" + this.FFerrisWheel.FreeOtherCounts;
            _loc1_ = this.FFerrisWheel.DescListNew[3].split("%n").join("\n");
            FMC_Scene.TF_FreeDesc.text = TUtilityString.Format(_loc1_,this.FFerrisWheel.FreeOtherCounts);
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         TweenUtil.removeAllTween();
         this.UpdateUI();
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FIsPlaying)
         {
            return;
         }
         if(this.FChangeTabIndex == TAB_TYPE_GOLD)
         {
            if(this.FFerrisWheel.GoldCounts <= 0 || this.FFerrisWheel.TodayCounts >= this.FFerrisWheel.MaxCounts)
            {
               ProcessorEffectText(this.FFerrisWheel.DescListNew[4]);
               return;
            }
         }
         if(this.FChangeTabIndex == TAB_TYPE_GOLD)
         {
            if(this.FFerrisWheel.GoldCounts > 0 && this.FFerrisWheel.TodayCounts < this.FFerrisWheel.MaxCounts)
            {
               FMC_Scene.MC_Hand.rotation = 0;
               TweenUtil.removeAllTween();
               this.ProcessorOnGetBoxUp(REQ_TYPE_GOLD);
            }
         }
         else if(this.FFerrisWheel.FreeCounts > 0 || this.FFerrisWheel.FreeOtherCounts > 0)
         {
            FMC_Scene.MC_Hand.rotation = 0;
            TweenUtil.removeAllTween();
            this.ProcessorOnGetBoxUp(REQ_TYPE_FREE);
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
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FFerrisWheel;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(0);
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.Unmount();
         if(Boolean(FMC_Scene) && Boolean(FMC_Scene.MC_Hand))
         {
            FMC_Scene.MC_Hand.rotation = 0;
         }
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerFerrisWheel.Unstreamize(_loc2_,this.FFerrisWheel,null);
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
         ProcessorUnstreamActivityLog(this.FFerrisWheel,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         this.FFerrisWheel.GoldCounts = _loc2_.readUnsignedInt();
         this.FFerrisWheel.GoldAddCounts = _loc2_.readUnsignedInt();
         if(Boolean(this.FFerrisWheel) && this.FIsOpen)
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
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
            case REQ_TYPE_GOLD:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FFerrisWheel.FreeOtherCounts = _loc2_.readUnsignedInt();
               --this.FFerrisWheel.GoldCounts;
               ++this.FFerrisWheel.TodayCounts;
               this.FFlowText = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc9_ = this.FFerrisWheel.GoldItems.GetInventoryByIndex(_loc5_);
               this.FFlowText += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               ProcessorCheckEffect(FActivityID,this.FFerrisWheel.CheckStatus());
               this.PlayMovie(_loc5_);
               break;
            case REQ_TYPE_FREE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FFerrisWheel.FreeOtherCounts = _loc2_.readUnsignedInt();
               this.FFerrisWheel.FreeCounts = 0;
               ++this.FFerrisWheel.TodayCounts;
               this.FFlowText = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc9_ = this.FFerrisWheel.FreeItems.GetInventoryByIndex(_loc5_);
               this.FFlowText += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               ProcessorCheckEffect(FActivityID,this.FFerrisWheel.CheckStatus());
               this.PlayMovie(_loc5_);
         }
      }
      
      public function PlayMovie(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 360 / SHOW_ITEM_COUNT * param1 + (ROTATION_COUNT + int(Math.random() * RANDOM_COUNT)) * 360;
         TweenUtil.to(FMC_Scene.MC_Hand,3000,{
            "rotation":_loc2_,
            "ease":Expo.easeOut,
            "onComplete":this.MovieEnd
         });
         this.FIsPlaying = true;
      }
      
      public function MovieEnd() : void
      {
         this.FIsPlaying = false;
         this.UpdateBtn();
         this.UpdateText();
         ProcessorEffectText(this.FFlowText);
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(3);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"每日最多可获得%0/25次");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(30);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(20);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeShort(16);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(16);
         _loc1_ = 0;
         while(_loc1_ < 16)
         {
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100003);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"AAA");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100003);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1371571200);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

