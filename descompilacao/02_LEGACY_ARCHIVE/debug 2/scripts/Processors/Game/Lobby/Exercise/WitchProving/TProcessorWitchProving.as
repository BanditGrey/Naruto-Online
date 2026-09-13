package Processors.Game.Lobby.Exercise.WitchProving
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WitchProving.TWitchProving;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerWitchProving;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWitchProving extends TProcessorBaseActivity
   {
      
      public static const SHOW_ITEM_COUNT:int = 9;
      
      public static const FIRE_COUNT:int = 3;
      
      public static const BAR_COUNT:int = 5;
      
      public static const ACTIVITY_1_BUY_PET:int = 1;
      
      public static const ACTIVITY_1_FIRE:int = 2;
      
      public static const ACTIVITY_1_GET_BOX:int = 3;
      
      public static const ACTIVITY_1_LOTTERY:int = 4;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 5;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 6;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FWitchProving:TWitchProving;
      
      protected var FUnstreamizerWitchProving:TUnstreamizerWitchProving;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TprocessorWitchProvingShop;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxHeight:Number;
      
      public function TProcessorWitchProving(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FWitchProving = SLogicsCore.WitchProving;
         this.FUnstreamizerWitchProving = new TUnstreamizerWitchProving();
         this.FBuyBoxDate = new Object();
         this.FProcessorFebActiveShop = new TprocessorWitchProvingShop(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         _loc1_ = 0;
         while(_loc1_ < FIRE_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Fire" + _loc1_];
            TGameUtil.setButtonMode(_loc4_,true);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnFireUp,false,0,true);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFireOver,false,0,true);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyPetUp,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetPetRewardUp,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_PetDesc,true);
         FMC_Scene.BTN_PetDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowPetDesc,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         FMC_Scene.BTN_Lottery.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp,false,0,true);
         FMC_Scene.MC_RechargeGift.buttonMode = true;
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeGiftUp,false,0,true);
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeGiftOver,false,0,true);
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut,false,0,true);
         this.FMC_Mask = FMC_Scene.MC_Bar["MC_Mask"];
         this.FBarMaxHeight = this.FMC_Mask.height;
         this.FMC_Mask.height = 0;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
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
         this.UpdatePet();
         this.UpdateBar();
         this.UpdateLottery();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FWitchProving);
         }
      }
      
      protected function UpdatePet() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = this.FWitchProving.Pet;
         FMC_Scene.TF_PetPrice.text = TUtilityString.Format(this.FWitchProving.DescListNew[2],_loc2_.Price);
         FMC_Scene.BTN_Buy.visible = _loc2_.Status == TBaseActivity.STATUS_GETED ? false : true;
         FMC_Scene.MC_GotPet.visible = _loc2_.Status == TBaseActivity.STATUS_GETED ? true : false;
         _loc3_ = this.FWitchProving.PetReward;
         FMC_Scene.TF_Count.text = "*" + this.FWitchProving.PetReward.Inventories.GetInventoryByIndex(0).Quantity.toString();
         if(_loc3_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_GotBox.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Click.visible = false;
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_GotBox.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Click.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else
         {
            FMC_Scene.MC_GotBox.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Click.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Vector.<int> = null;
         _loc4_ = this.FWitchProving.CurLevel;
         _loc9_ = this.FWitchProving.BarGift.MaxVect;
         _loc1_ = 0;
         while(_loc1_ < BAR_COUNT)
         {
            FMC_Scene["MC_Info" + _loc1_].TF_Desc.text = TUtilityString.Format(this.FWitchProving.DescListNew[3],_loc9_[_loc1_]);
            FMC_Scene["MC_Box" + _loc1_].TF_Count.text = "*" + this.FWitchProving.BarGift.ExchangeVect[_loc1_].toString();
            if(_loc4_ >= _loc1_)
            {
               FMC_Scene["MC_Box" + _loc1_].gotoAndStop(1);
            }
            else
            {
               FMC_Scene["MC_Box" + _loc1_].gotoAndStop(2);
            }
            _loc1_++;
         }
         _loc8_ = this.FWitchProving.BarGift.ExchangeVect.length - 1;
         _loc7_ = this.FWitchProving.BarGift.ExchangeVect[_loc8_];
         _loc5_ = Number(this.FWitchProving.Score / _loc7_) * this.FBarMaxHeight;
         _loc6_ = Math.min(_loc5_,this.FBarMaxHeight);
         this.FMC_Mask.height = _loc6_;
         _loc1_ = 0;
         while(_loc1_ < FIRE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Fire" + _loc1_];
            if(this.FWitchProving.ShopExchangePoint >= this.FWitchProving.Fires[_loc1_])
            {
               TGameUtil.setButtonMode(_loc2_,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc2_,false);
            }
            _loc2_.TF_Name.text = this.FWitchProving.DescListNew[6 + _loc1_];
            _loc1_++;
         }
         if(this.FWitchProving.NextNeedNum == 0)
         {
            FMC_Scene.TF_NextNeed.text = "";
         }
         else
         {
            FMC_Scene.TF_NextNeed.text = TUtilityString.Format(this.FWitchProving.DescListNew[4],this.FWitchProving.NextNeedNum);
         }
      }
      
      protected function UpdateLottery() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         this.FShowItem.UpdateUI(this.FWitchProving.ShowItems);
         if(this.FWitchProving.LotteryCount > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,false);
         }
         FMC_Scene.TF_LotteryCount.text = TUtilityString.Format(this.FWitchProving.DescListNew[10],this.FWitchProving.LotteryCount);
         FMC_Scene.TF_RechargeGiftTip.text = this.FWitchProving.DescListNew[11];
         _loc2_ = this.FWitchProving.RechargeGift;
         FMC_Scene.TF_RechargeNeed.text = TUtilityString.Format(this.FWitchProving.DescListNew[12],this.FWitchProving.TotalRechargeGold % _loc2_.Price,_loc2_.Price);
         FMC_Scene.MC_RechargeGift.MC_Click.visible = _loc2_.Count > 0 ? true : false;
         FMC_Scene.MC_RechargeGift.TF_Count.text = "*" + _loc2_.Count.toString();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FWitchProving.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FWitchProving.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FWitchProving.DescListNew[1];
         FMC_Scene.TF_Point.text = this.FWitchProving.ShopExchangePoint.toString();
         FMC_Scene.TF_Score.text = this.FWitchProving.Score.toString();
         FMC_Scene.TF_ReturnGold.text = TUtilityString.Format(this.FWitchProving.DescListNew[5],this.FWitchProving.ReturnGold);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBuyPetUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || this.FIsPlaying)
         {
            return;
         }
         if(this.FWitchProving)
         {
            _loc2_ = this.FWitchProving.Pet;
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_PET,_loc2_.Price,0);
         }
      }
      
      protected function ProcessorOnGetPetRewardUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode || this.FIsPlaying)
         {
            return;
         }
         if(this.FWitchProving)
         {
            _loc2_ = this.FWitchProving.Pet;
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_BOX);
         }
      }
      
      protected function ProcessorOnFireUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FWitchProving) && this.FWitchProving.ShopExchangePoint >= this.FWitchProving.Fires[_loc2_])
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FIRE,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnFireOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FWitchProving)
         {
            _loc3_ = TUtilityString.Format(this.FWitchProving.DescListNew[9],this.FWitchProving.Fires[_loc2_]);
            ProcessorOnShowHtmlText(_loc3_);
         }
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FWitchProving))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_LOTTERY);
         }
      }
      
      protected function ProcessorOnRechargeGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(!this.FIsPlaying) && Boolean(this.FWitchProving) && this.FWitchProving.RechargeGift.Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX);
         }
      }
      
      protected function ProcessorOnRechargeGiftOver(param1:MouseEvent) : void
      {
         if(this.FWitchProving)
         {
            ProcessorOnNewBoxOver(this.FWitchProving.RechargeGift.Inventories);
         }
      }
      
      protected function ProcessorOnShowPetDesc(param1:MouseEvent) : void
      {
         ProcessorOnShowItemDesc(this.FWitchProving.Pet.Identify,TBaseBox.TYPE_IS_PET);
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FWitchProving)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FWitchProving);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FWitchProving;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorLoadActiveRankNew(0);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveShop.Load();
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
         this.FUnstreamizerWitchProving.Unstreamize(_loc2_,this.FWitchProving,null);
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
         if(this.FWitchProving)
         {
            if(this.FIsOpen)
            {
               this.FWitchProving.LotteryCount = _loc2_.readUnsignedInt();
               this.FWitchProving.RechargeGift.Count = _loc2_.readUnsignedInt();
               this.FWitchProving.TotalRechargeGold = _loc2_.readUnsignedInt();
               this.UpdateUI();
            }
            this.FWitchProving.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
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
         ProcessorUnstreamActivityLog(this.FWitchProving,_loc2_);
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
            case ACTIVITY_1_BUY_PET:
               this.FWitchProving.Pet.Status = TBaseActivity.STATUS_GETED;
               this.FWitchProving.PetReward.Status = TBaseActivity.STATUS_CANGET;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_BOX:
               this.FWitchProving.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWitchProving.PetReward.Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FIRE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FWitchProving.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FWitchProving.ReturnGold = _loc2_.readUnsignedInt();
               this.FWitchProving.Score += _loc17_;
               _loc4_ = TUtilityString.Format(this.FWitchProving.DescListNew[13],_loc17_);
               ProcessorEffectText(_loc4_);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_LOTTERY:
               --this.FWitchProving.LotteryCount;
               _loc16_ = int(_loc2_.readUnsignedInt());
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc16_)
               {
                  _loc10_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc4_ += STRING_COMMON.GetItemNameByType(_loc10_,_loc11_) + "*" + _loc12_ + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               this.FWitchProving.ShopExchangePoint = _loc2_.readUnsignedInt();
               --this.FWitchProving.RechargeGift.Count;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWitchProving.RechargeGift.Inventories.Count)
               {
                  _loc9_ = this.FWitchProving.RechargeGift.Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FWitchProving.ShopExchangeItems[_loc5_].LimitCount;
               this.FWitchProving.ShopExchangePoint = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FWitchProving.ShopExchangeItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FWitchProving.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FWitchProving.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FWitchProving.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         this.FIsPlaying = false;
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(11);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"价格:%0金币");
         TUtilityString.FlushUTF(_loc3_,"返还%0金币");
         TUtilityString.FlushUTF(_loc3_,"达到下档还需要点亮%0个南瓜灯");
         TUtilityString.FlushUTF(_loc3_,"%0金币");
         TUtilityString.FlushUTF(_loc3_,"绿色火把");
         TUtilityString.FlushUTF(_loc3_,"蓝色火把");
         TUtilityString.FlushUTF(_loc3_,"红色火把");
         TUtilityString.FlushUTF(_loc3_,"点燃当前火把需要消耗%0个魔法药剂");
         TUtilityString.FlushUTF(_loc3_,"可抽奖次数:%0次");
         TUtilityString.FlushUTF(_loc3_,"充值999金币可获得1次免费抽奖机会");
         TUtilityString.FlushUTF(_loc3_,"每充值%0/%1金币可激活");
         TUtilityString.FlushUTF(_loc3_,"获得%0个南瓜灯");
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

