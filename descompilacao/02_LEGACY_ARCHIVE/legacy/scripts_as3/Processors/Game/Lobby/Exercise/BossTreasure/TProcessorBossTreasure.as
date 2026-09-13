package Processors.Game.Lobby.Exercise.BossTreasure
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.BossTreasure.TBossTreasure;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBossTreasure;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorBossTreasure extends TProcessorBaseActivity
   {
      
      protected static const EQUIP_COUNT:int = 8;
      
      protected static const ACCESSORY_COUNT:int = 8;
      
      protected static const ITEM_COUNT:int = 4;
      
      protected static const GIFT_COUNT:int = 5;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      public static const ACTIVITY_1_BUY_EQUIP:int = 1;
      
      public static const ACTIVITY_1_BUY_ACCESSORY:int = 2;
      
      public static const ACTIVITY_1_BUY_ITEM:int = 3;
      
      public static const ACTIVITY_1_GET_GIFT:int = 4;
      
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
      
      protected var FBossTreasure:TBossTreasure;
      
      protected var FUnstreamizerBossTreasure:TUnstreamizerBossTreasure;
      
      protected var FEquipList:Vector.<TUIShowItem>;
      
      protected var FAccessoryList:Vector.<TUIShowItem>;
      
      protected var FItemList:Vector.<TUIShowItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TProcessorBossTreasure(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FBossTreasure = SLogicsCore.BossTreasure;
         this.FUnstreamizerBossTreasure = new TUnstreamizerBossTreasure();
         this.FBuyBoxDate = new Object();
         this.FEquipList = new Vector.<TUIShowItem>(EQUIP_COUNT);
         this.FAccessoryList = new Vector.<TUIShowItem>(ACCESSORY_COUNT);
         this.FItemList = new Vector.<TUIShowItem>(ITEM_COUNT);
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
         while(_loc1_ < EQUIP_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene.MC_Equips["MC_Slot" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FEquipList[_loc1_] = _loc5_;
            TGameUtil.setButtonMode(FMC_Scene.MC_Equips["MC_Slot" + _loc1_].BTN_Buy,true);
            FMC_Scene.MC_Equips["MC_Slot" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.PrcoessorOnEquipUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ACCESSORY_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene.MC_Accessories["MC_Slot" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FAccessoryList[_loc1_] = _loc5_;
            TGameUtil.setButtonMode(FMC_Scene.MC_Accessories["MC_Slot" + _loc1_].BTN_Buy,true);
            FMC_Scene.MC_Accessories["MC_Slot" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.PrcoessorOnAccessoryUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Slot" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FItemList[_loc1_] = _loc5_;
            TGameUtil.setButtonMode(FMC_Scene["MC_Slot" + _loc1_].BTN_Buy,true);
            FMC_Scene["MC_Slot" + _loc1_].MC_Slot0.BTN_Buy.addEventListener(MouseEvent.CLICK,this.PrcoessorOnItemUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc4_.MC_Box.buttonMode = true;
            _loc4_.MC_Box.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc4_.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc4_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc4_.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ShowItems.Btn_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ShowItems.Btn_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = ITEM_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FMC_Mask = FMC_Scene.MC_AccumBar.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
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
            if(this.FEquipList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FEquipList.length)
               {
                  this.FEquipList[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
            if(this.FAccessoryList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FAccessoryList.length)
               {
                  this.FAccessoryList[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
            if(this.FItemList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FItemList.length)
               {
                  this.FItemList[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateEquips();
         this.UpdateAccessories();
         this.UpdateItems();
         this.UpdateGifts();
         this.UpdateText();
      }
      
      protected function UpdateEquips() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < EQUIP_COUNT)
         {
            _loc6_ = FMC_Scene.MC_Equips["MC_Slot" + _loc1_];
            _loc5_ = this.FBossTreasure.Equiplist[_loc1_];
            this.FEquipList[_loc1_].UpdateUI(_loc5_.Inventories);
            _loc7_ = _loc5_.Inventories.GetInventoryByIndex(0);
            if(_loc7_.LimitCount > 0)
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateAccessories() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < ACCESSORY_COUNT)
         {
            _loc6_ = FMC_Scene.MC_Accessories["MC_Slot" + _loc1_];
            _loc5_ = this.FBossTreasure.Accessorylist[_loc1_];
            this.FAccessoryList[_loc1_].UpdateUI(_loc5_.Inventories);
            _loc7_ = _loc5_.Inventories.GetInventoryByIndex(0);
            if(_loc7_.LimitCount > 0)
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         this.FUIPage.TotalQuantity = this.FBossTreasure.Itemlist.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc6_ = FMC_Scene["MC_Slot" + _loc1_];
            _loc3_ = _loc1_ + this.FCurPage * ITEM_COUNT;
            if(_loc3_ < this.FBossTreasure.Itemlist.length)
            {
               _loc6_.visible = true;
               _loc5_ = this.FBossTreasure.Itemlist[_loc3_];
               this.FItemList[_loc1_].UpdateUI(_loc5_.Inventories);
               _loc7_ = _loc5_.Inventories.GetInventoryByIndex(0);
               if(_loc7_.LimitCount > 0)
               {
                  TGameUtil.setButtonMode(_loc6_.MC_Slot0.BTN_Buy,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc6_.MC_Slot0.BTN_Buy,false);
               }
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGifts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc3_ = this.FBossTreasure.Giftlist[_loc1_];
            _loc4_.TF_Desc.text = TUtilityString.Format(this.FBossTreasure.DescListNew[7],_loc3_.Price);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc4_.MC_Click.visible = false;
               _loc4_.MC_Got.visible = false;
               _loc4_.MC_Box.gotoAndStop(1);
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc4_.MC_Click.visible = true;
               _loc4_.MC_Got.visible = false;
               _loc4_.MC_Box.gotoAndPlay(1);
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc4_.MC_Click.visible = false;
               _loc4_.MC_Got.visible = true;
               _loc4_.MC_Box.gotoAndStop(1);
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
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FBossTreasure.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FBossTreasure.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Gold.text = this.FBossTreasure.TotalConsumeGold.toString();
         _loc3_ = Number(this.FBossTreasure.CurConsumeGold / this.FBossTreasure.Discount[this.FBossTreasure.Discount.length - 1]) * this.FBarMaxWidth;
         _loc4_ = Math.min(_loc3_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc4_;
         _loc1_ = 0;
         while(_loc1_ < this.FBossTreasure.Discount.length)
         {
            _loc5_ = FMC_Scene.MC_AccumBar["MC_Box" + _loc1_];
            _loc5_.TF_Desc.text = this.FBossTreasure.DescListNew[2 + _loc1_];
            _loc5_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_PAY_LIMIT,this.FBossTreasure.Discount[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItems();
      }
      
      protected function PrcoessorOnEquipUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FBossTreasure) && _loc2_ < this.FBossTreasure.Equiplist.length)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_BUY_EQUIP,_loc2_ + 1);
         }
      }
      
      protected function PrcoessorOnAccessoryUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FBossTreasure) && _loc2_ < this.FBossTreasure.Accessorylist.length)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_BUY_ACCESSORY,_loc2_ + 1);
         }
      }
      
      protected function PrcoessorOnItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
         if(Boolean(this.FBossTreasure) && Boolean(_loc2_ < this.FBossTreasure.Itemlist.length) && this.FBossTreasure.Itemlist[_loc2_].Inventories.GetInventoryByIndex(0).LimitCount > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_BUY_ITEM,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FBossTreasure) && Boolean(_loc2_ < this.FBossTreasure.Giftlist.length) && this.FBossTreasure.Giftlist[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FBossTreasure)
         {
            _loc3_ = this.FBossTreasure.Giftlist[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         ProcessorOnShowItemDesc(param1,param2);
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
         FProcessorWindowDesc.BaseActivity = this.FBossTreasure;
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
         this.FUnstreamizerBossTreasure.Unstreamize(_loc2_,this.FBossTreasure,null);
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
         if(this.FBossTreasure)
         {
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
         ProcessorUnstreamActivityLog(this.FBossTreasure,_loc2_);
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
            case ACTIVITY_1_BUY_EQUIP:
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.PerformPacket_CS_LoadInfoReq();
               break;
            case ACTIVITY_1_BUY_ACCESSORY:
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.PerformPacket_CS_LoadInfoReq();
               break;
            case ACTIVITY_1_BUY_ITEM:
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.PerformPacket_CS_LoadInfoReq();
               break;
            case ACTIVITY_1_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FBossTreasure.Giftlist[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FBossTreasure.Giftlist[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FBossTreasure.Giftlist[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FBossTreasure.CheckStatus());
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

