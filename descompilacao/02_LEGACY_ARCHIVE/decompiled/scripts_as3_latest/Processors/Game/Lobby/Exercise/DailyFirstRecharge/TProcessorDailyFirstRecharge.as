package Processors.Game.Lobby.Exercise.DailyFirstRecharge
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
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DailyFirstRecharge.TDailyFirstRecharge;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDailyFirstRecharge;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorDailyFirstRecharge extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_GET_BOX:int = 1;
      
      public static const ACTIVITY_1_GET_GIFT:int = 2;
      
      protected var TAB_COUNT:int = 3;
      
      protected var SHOW_BOX_COUNT:int = 4;
      
      protected var BOX_COUNT:int = 3;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FDailyFirstRecharge:TDailyFirstRecharge;
      
      protected var FUnstreamizerDailyFirstRecharge:TUnstreamizerDailyFirstRecharge;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      public function TProcessorDailyFirstRecharge(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FDailyFirstRecharge = SLogicsCore.DailyFirstRecharge;
         this.FUnstreamizerDailyFirstRecharge = new TUnstreamizerDailyFirstRecharge();
         this.FBuyBoxDate = new Object();
         this.FUITab = new TUITab(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = FMC_Scene["BTN_Tab" + _loc1_];
            this.FUITab.SetTabByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.PrcoessorOnGiftOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            TGameUtil.setButtonMode(_loc4_.BTN_Get,true);
            _loc4_.BTN_Get.addEventListener(MouseEvent.CLICK,this.PrcoessorOnGetGiftUp);
            _loc1_++;
         }
         this.FShowItem = new TUIShowItem(this,this.SHOW_BOX_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene["MC_ShowItems"]);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.PrcoessorOnGetBoxUp);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FDailyFirstRecharge.BoxList[this.FChangeTabIndex];
         this.FShowItem.UpdateUI(_loc1_.Inventories);
         FMC_Scene.TF_Gold.text = _loc1_.CurPrice.toString();
         FMC_Scene.TF_GiftPrice.text = TUtilityString.Format(this.FDailyFirstRecharge.DescListNew[2],_loc1_.Price);
         if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else if(_loc1_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
         else
         {
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         if(this.FDailyFirstRecharge.IsBoxGot)
         {
            FMC_Scene.MC_Over.visible = true;
         }
         else
         {
            FMC_Scene.MC_Over.visible = false;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < this.BOX_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = this.FDailyFirstRecharge.GiftList[_loc1_];
            _loc2_.TF_Name.text = this.FDailyFirstRecharge.DescListNew[3 + _loc1_];
            _loc2_.TF_Count.text = _loc3_.LimitCount.toString();
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.BTN_Get.visible = true;
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.BTN_Get.visible = true;
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            else
            {
               _loc2_.BTN_Get.visible = false;
               _loc2_.MC_Got.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            if(_loc3_.LimitCount <= 0)
            {
               _loc2_.MC_End.visible = true;
            }
            else
            {
               _loc2_.MC_End.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FMC_Scene.TF_Desc.text = this.FDailyFirstRecharge.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDailyFirstRecharge.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDailyFirstRecharge.EndTime) - 1) * 1000)));
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1 as int;
         if(_loc2_ != this.FChangeTabIndex)
         {
            this.FChangeTabIndex = _loc2_;
            this.UpdateUI();
         }
      }
      
      protected function PrcoessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FDailyFirstRecharge)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_BOX,this.FChangeTabIndex + 1);
         }
      }
      
      protected function PrcoessorOnGetGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FDailyFirstRecharge)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function PrcoessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FDailyFirstRecharge) && _loc2_ < this.FDailyFirstRecharge.GiftList.length)
         {
            ProcessorOnNewBoxOver(this.FDailyFirstRecharge.GiftList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
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
         if(this.FBeClicked || this.FIsPlaying)
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
         FProcessorWindowDesc.BaseActivity = this.FDailyFirstRecharge;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
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
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
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
         this.FUnstreamizerDailyFirstRecharge.Unstreamize(_loc2_,this.FDailyFirstRecharge,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(Boolean(this.FDailyFirstRecharge) && this.FDailyFirstRecharge.BoxList.length > 1)
         {
            _loc4_ = 0;
            while(_loc4_ < this.FDailyFirstRecharge.BoxList.length)
            {
               this.FDailyFirstRecharge.BoxList[_loc4_].Status = _loc2_.readInt();
               _loc4_++;
            }
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
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
         ProcessorUnstreamActivityLog(this.FDailyFirstRecharge,_loc2_);
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
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         var _loc24_:TDessertHouseTask = null;
         var _loc25_:int = 0;
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
            case ACTIVITY_1_GET_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FDailyFirstRecharge.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc6_ = 0;
               while(_loc6_ < this.FDailyFirstRecharge.BoxList.length)
               {
                  if(_loc5_ != _loc6_)
                  {
                     this.FDailyFirstRecharge.BoxList[_loc6_].Status = TBaseActivity.STATUS_CANNOTGET;
                  }
                  _loc6_++;
               }
               this.FDailyFirstRecharge.GiftList[_loc5_].Status = TBaseActivity.STATUS_CANGET;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               ProcessorCheckEffect(FActivityID,this.FDailyFirstRecharge.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FDailyFirstRecharge.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc6_ = 0;
               while(_loc6_ < this.FDailyFirstRecharge.GiftList.length)
               {
                  if(_loc5_ != _loc6_)
                  {
                     this.FDailyFirstRecharge.GiftList[_loc6_].Status = TBaseActivity.STATUS_CANNOTGET;
                  }
                  _loc6_++;
               }
               --this.FDailyFirstRecharge.GiftList[_loc5_].LimitCount;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               ProcessorCheckEffect(FActivityID,this.FDailyFirstRecharge.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:String = null;
         this.FIsPlaying = true;
         this.FMovieType = param1;
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

