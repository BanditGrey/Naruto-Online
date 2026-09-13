package Processors.Game.Lobby.Exercise.OneWorthThousand
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.OneWorthThousand.TOneWorthThousand;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerOneWorthThousand;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorOneWorthThousand extends TProcessorBaseActivity
   {
      
      public static const MAX_COUNT:int = 4;
      
      public static const BOX_COUNT:int = 3;
      
      public static const SALE_COUNT:int = 2;
      
      public static const SHOW_BOX_COUNT:int = 4;
      
      public static const LOG_COUNT:int = 20;
      
      public static const TYPE_BUY_BOX:int = 1;
      
      public static const TYPE_GET_GIFT:int = 2;
      
      public static const TYPE_BUY_SALE:int = 3;
      
      public static const TYPE_REFRESH_ALL:int = 5;
      
      public static const TYPE_REFRESH_ONE:int = 4;
      
      protected var FOneWorthThousand:TOneWorthThousand;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerOneWorthThousand:TUnstreamizerOneWorthThousand;
      
      protected var FOpenBoxVect:Vector.<TUIShowItem>;
      
      protected var FGiftVect:Vector.<MovieClip>;
      
      protected var FShowItems:Vector.<TUIShowItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCurPage0:int;
      
      protected var FIsCD:Boolean;
      
      protected var FCost:int;
      
      protected var FType:int;
      
      protected var FUIPage_Lucky:TUIPage;
      
      protected var FTotalPage_Lucky:int;
      
      protected var FCurPage_Lucky:int;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      public function TProcessorOneWorthThousand(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FOneWorthThousand = SLogicsCore.OneWorthThousand;
         this.FUnstreamizerOneWorthThousand = new TUnstreamizerOneWorthThousand();
         this.FOpenBoxVect = new Vector.<TUIShowItem>(MAX_COUNT * BOX_COUNT);
         this.FShowItems = new Vector.<TUIShowItem>(SHOW_BOX_COUNT);
         this.FGiftVect = new Vector.<MovieClip>(SALE_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            TGameUtil.setButtonMode(FMC_Scene["MC_Box" + _loc1_]["BTN_Refresh"],true);
            FMC_Scene["MC_Box" + _loc1_]["BTN_Refresh"].addEventListener(MouseEvent.CLICK,this.ProcessorOnRefreshOneUp);
            FMC_Scene["MC_Box" + _loc1_]["MC_Title"].gotoAndStop(_loc1_ + 1);
            _loc2_ = 0;
            while(_loc2_ < BOX_COUNT)
            {
               _loc3_ = FMC_Scene["MC_Box" + _loc1_]["MC_OBX" + _loc2_];
               _loc4_ = new TUIShowItem(this,1);
               _loc4_.Perform_UIDispatch(_loc3_);
               _loc4_.OnOverlay = UIComponentsHintOnOver;
               _loc4_.OnOut = UIComponentsHintOnOut;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
               TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
               _loc3_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
               _loc3_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
               this.FOpenBoxVect[_loc1_ * BOX_COUNT + _loc2_] = _loc4_;
               _loc2_++;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SALE_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc3_.MC_Icon.buttonMode = true;
            _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc3_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleOver);
            _loc3_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSaleOut);
            TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
            _loc3_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSaleUp);
            _loc3_.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleTipOver);
            _loc3_.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSaleTipOut);
            this.FGiftVect[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SHOW_BOX_COUNT)
         {
            _loc3_ = FMC_Scene.MC_ShowItem["MC_Item" + _loc1_];
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(_loc3_);
            _loc4_.OnOverlay = UIComponentsHintOnOver;
            _loc4_.OnOut = UIComponentsHintOnOut;
            this.FShowItems[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_PageRight;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = SHOW_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage0 = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FUIPage_Lucky = new TUIPage(this);
         this.FUIPage_Lucky.ButtonPrevious.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageLeft;
         this.FUIPage_Lucky.ButtonNext.Substrate = FMC_Scene.MC_Lucky.MC_ChangePage.MC_PageRight;
         this.FUIPage_Lucky.LabelPage = FMC_Scene.MC_Lucky.MC_ChangePage.TF_Page;
         this.FUIPage_Lucky.TotalQuantity = this.FTotalPage_Lucky;
         this.FUIPage_Lucky.PageSize = LOG_COUNT;
         this.FUIPage_Lucky.PageIndex = 0;
         this.FCurPage_Lucky = 0;
         this.FUIPage_Lucky.OnChangePage = this.ProcessorPageOnChange_Lucky;
         FMC_Scene.MC_Lucky.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lucky,true);
         FMC_Scene.BTN_Lucky.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyUp);
         FMC_Scene.MC_Lucky.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnLuckyClose);
         if(this.FEffectGlow == null)
         {
            this.FEffectGlow = new TEffectBaseGlow();
            this.FEffectGlow.SetParameters(FMC_Scene.BTN_RefreshAll,15911245,1);
            this.FEffectGlow.Run();
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_RefreshAll,true);
         FMC_Scene.BTN_RefreshAll.addEventListener(MouseEvent.CLICK,this.ProcessorOnRefreshAllUp);
         FMC_Scene.MC_freeGift0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_freeGift0.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
         FMC_Scene.MC_freeGift0.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(Boolean(FTF_Time) && Boolean(this.FOneWorthThousand))
            {
               _loc5_ = this.FOneWorthThousand.NextTime - STimingCore.GetServerTick();
               FTF_Time.text = TGameUtil.fomatTime(_loc5_);
               if(_loc5_ <= 0 && this.FIsCD || _loc5_ > 0 && !this.FIsCD)
               {
                  this.FIsCD = _loc5_ <= 0 ? false : true;
                  this.UpdateBtn();
                  ProcessorCheckEffect(FActivityID,!this.FIsCD);
               }
            }
            if(this.FOpenBoxVect)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FOpenBoxVect.length)
               {
                  if(this.FOpenBoxVect[_loc1_])
                  {
                     this.FOpenBoxVect[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
            if(this.FShowItems)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FShowItems.length)
               {
                  if(this.FShowItems[_loc1_])
                  {
                     this.FShowItems[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
         }
         if(Boolean(this.FEffectGlow) && this.FEffectGlow.IsRunOver)
         {
            this.FEffectGlow.Run();
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateGift();
         this.UpdateShowItem();
         this.UpdateLucky();
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FIsCD)
         {
            FMC_Scene.BTN_RefreshAll.visible = false;
            this.FEffectGlow.Stop();
         }
         else
         {
            FMC_Scene.BTN_RefreshAll.visible = true;
            this.FEffectGlow.Run();
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOneWorthThousand.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FOneWorthThousand.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FOneWorthThousand.DescListNew[2];
         FMC_Scene.TF_Count.text = this.FOneWorthThousand.TotalMoney;
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FOneWorthThousand.Gift;
         if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_freeGift0.MC_GetBox.visible = true;
            FMC_Scene.MC_freeGift0.MC_Got.visible = false;
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_freeGift0.MC_GetBox.visible = false;
            FMC_Scene.MC_freeGift0.MC_Got.visible = false;
         }
         else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_freeGift0.MC_GetBox.visible = false;
            FMC_Scene.MC_freeGift0.MC_Got.visible = true;
         }
         _loc1_ = 0;
         while(_loc1_ < SALE_COUNT)
         {
            _loc2_ = this.FOneWorthThousand.SaleList[_loc1_];
            _loc3_ = this.FGiftVect[_loc1_];
            _loc3_.TF_Desc0.text = _loc2_.DescListNew[0];
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Bought.visible = false;
               _loc3_.BTN_Buy.visible = true;
               if(_loc2_.BuyCount == 0)
               {
                  _loc3_.MC_Tag.visible = true;
                  _loc3_.TF_Desc1.text = "";
                  TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               }
               else
               {
                  _loc3_.MC_Tag.visible = false;
                  _loc3_.TF_Desc1.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_1,_loc2_.BuyCount);
                  TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
               }
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Bought.visible = false;
               _loc3_.BTN_Buy.visible = true;
               _loc3_.MC_Tag.visible = false;
               TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               _loc3_.TF_Desc1.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_0,_loc2_.Count);
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Bought.visible = true;
               _loc3_.BTN_Buy.visible = false;
               _loc3_.MC_Tag.visible = false;
               _loc3_.TF_Desc1.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_1,_loc2_.BuyCount);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = int(this.FOpenBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = MAX_COUNT * BOX_COUNT * this.FCurPage + _loc1_;
            _loc6_ = _loc1_ / BOX_COUNT;
            _loc7_ = _loc1_ % BOX_COUNT;
            _loc3_ = FMC_Scene["MC_Box" + _loc6_]["MC_OBX" + _loc7_];
            if(_loc5_ < this.FOneWorthThousand.BoxList.length)
            {
               _loc4_ = this.FOneWorthThousand.BoxList[_loc5_];
               this.FOpenBoxVect[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc3_.MC_HotOrNew.visible = _loc4_.IsHot == 1 ? true : false;
               if(_loc5_ % BOX_COUNT == 0)
               {
                  FMC_Scene["MC_Box" + _loc6_]["MC_Title"]["TF_Desc"].text = TUtilityString.Format(this.FOneWorthThousand.DescListNew[3],_loc4_.Price);
                  FMC_Scene["MC_Box" + _loc6_]["TF_RefreshPrice"].text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,_loc4_.Min);
               }
               _loc3_.TF_Desc0.text = TUtilityString.Format(this.FOneWorthThousand.DescListNew[4],_loc4_.Max);
               _loc3_.TF_Desc1.text = TUtilityString.Format(this.FOneWorthThousand.DescListNew[5],_loc4_.Discount);
               _loc3_.MC_Price.TF_Price.text = _loc4_.CurPrice.toString();
               _loc3_.MC_Price.visible = _loc4_.CurPrice != 0 ? true : false;
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_Bg.gotoAndStop(1);
                  _loc3_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_3,_loc4_.Count,_loc4_.LimitCount);
                  _loc3_.MC_Tag.visible = false;
                  _loc3_.MC_Got.visible = false;
                  _loc3_.MC_Bounght.visible = false;
                  if(_loc4_.CurPrice == 0)
                  {
                     _loc3_.BTN_Get.visible = true;
                     _loc3_.BTN_Buy.visible = false;
                  }
                  else
                  {
                     _loc3_.BTN_Get.visible = false;
                     _loc3_.BTN_Buy.visible = true;
                  }
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
                  TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
               }
               else
               {
                  _loc3_.MC_Bg.gotoAndStop(2);
                  if(_loc4_.BuyCount == 0)
                  {
                     _loc3_.MC_Tag.visible = true;
                     _loc3_.TF_Limit.text = "";
                  }
                  else
                  {
                     _loc3_.MC_Tag.visible = false;
                     _loc3_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_4,_loc4_.BuyCount,_loc4_.LimitCount);
                  }
                  if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc3_.MC_Got.visible = false;
                     _loc3_.MC_Bounght.visible = false;
                     if(_loc4_.CurPrice == 0)
                     {
                        _loc3_.BTN_Get.visible = true;
                        _loc3_.BTN_Buy.visible = false;
                     }
                     else
                     {
                        _loc3_.BTN_Get.visible = false;
                        _loc3_.BTN_Buy.visible = true;
                     }
                     if(_loc4_.BuyCount == 0)
                     {
                        TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
                        TGameUtil.setButtonMode(_loc3_.BTN_Buy,false);
                     }
                     else
                     {
                        TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
                        TGameUtil.setButtonMode(_loc3_.BTN_Buy,true);
                     }
                  }
                  else
                  {
                     _loc3_.BTN_Get.visible = false;
                     _loc3_.BTN_Buy.visible = false;
                     if(_loc4_.CurPrice == 0)
                     {
                        _loc3_.MC_Got.visible = true;
                        _loc3_.MC_Bounght.visible = false;
                     }
                     else
                     {
                        _loc3_.MC_Got.visible = false;
                        _loc3_.MC_Bounght.visible = true;
                     }
                  }
               }
            }
            else
            {
               _loc3_.visible = false;
               FMC_Scene["MC_Box" + _loc6_]["MC_Title"]["TF_Desc"].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateShowItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FUIPage.TotalQuantity = this.FOneWorthThousand.ShowItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < SHOW_BOX_COUNT)
         {
            _loc5_ = SHOW_BOX_COUNT * this.FCurPage0 + _loc1_;
            _loc3_ = FMC_Scene.MC_ShowItem["MC_Item" + _loc1_];
            if(_loc5_ < this.FOneWorthThousand.ShowItems.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FOneWorthThousand.ShowItems[_loc5_];
               _loc3_.MC_Title.gotoAndStop(_loc4_.Level);
               this.FShowItems[_loc1_].UpdateUI(_loc4_.Inventories);
               _loc3_.TF_Desc0.text = TUtilityString.Format(this.FOneWorthThousand.DescListNew[4],_loc4_.Price);
               _loc3_.MC_Price.TF_Price.text = _loc4_.CurPrice.toString();
               _loc3_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_1,_loc4_.BuyCount);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLucky() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TLotteryNews = null;
         var _loc8_:TSystemLanguage = null;
         this.FUIPage_Lucky.TotalQuantity = this.FOneWorthThousand.LuckyList.length;
         this.FUIPage_Lucky.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage_Lucky * LOG_COUNT;
            if(_loc3_ < this.FOneWorthThousand.LuckyList.length)
            {
               _loc7_ = this.FOneWorthThousand.LuckyList[_loc3_];
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc7_.SoureID) as TSystemLanguage;
               if(_loc8_ == null)
               {
                  throw new Error("SystemLanguage表未配置 " + _loc7_.SoureID);
               }
               _loc4_ = _loc8_.Desc;
               if(_loc7_.GetTime > 0)
               {
                  _loc6_ = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc7_.GetTime) * 1000));
                  _loc4_ = _loc4_.split("%when%").join(_loc6_);
               }
               if(Boolean(_loc7_.PlayerNick) && _loc7_.PlayerNick != "")
               {
                  _loc4_ = _loc4_.split("%who%").join(_loc7_.PlayerNick);
               }
               if(Boolean(_loc7_.Inventories) && _loc7_.Inventories.Count > 0)
               {
                  _loc5_ = _loc7_.Inventories.GetInventoryByIndex(0).Name + "*" + _loc7_.Inventories.GetInventoryByIndex(0).Quantity;
                  _loc4_ = _loc4_.split("%what%").join(_loc5_);
               }
               FMC_Scene.MC_Lucky["TF_Log" + _loc1_].text = _loc4_;
            }
            else
            {
               FMC_Scene.MC_Lucky["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdateShowItem();
      }
      
      protected function ProcessorPageOnChange_Lucky(param1:Object, param2:int) : void
      {
         this.FCurPage_Lucky = param2;
         this.UpdateLucky();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnRefreshOneUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         FIndex = int(String(param1.currentTarget.parent.name).slice(6));
         this.FType = TYPE_REFRESH_ONE;
         this.FCost = this.FOneWorthThousand.BoxList[FIndex * BOX_COUNT].Min;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnRefreshAllUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         PerformPacket_CS_AllReq(TYPE_REFRESH_ALL);
      }
      
      protected function ProcessorOnLuckyUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = true;
      }
      
      protected function ProcessorOnLuckyClose(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Lucky.visible = false;
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         _loc6_ = int(String(param1.currentTarget.parent.name).slice(6)) + int(String(param1.currentTarget.parent.parent.name).slice(6)) * BOX_COUNT;
         FIndex = MAX_COUNT * BOX_COUNT * this.FCurPage + _loc6_;
         if(this.FOneWorthThousand.BoxList[FIndex].CurPrice == 0)
         {
            this.FBeClicked = true;
            _loc4_ = new Vector.<int>();
            _loc4_.push(FIndex + 1);
            PerformPacket_CS_AllReq(TYPE_BUY_BOX,_loc4_);
         }
         else
         {
            this.FType = TYPE_BUY_BOX;
            this.FCost = this.FOneWorthThousand.BoxList[FIndex].CurPrice;
            if(!FUIWindowConfirmation.IsSelected)
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
               FUIWindowConfirmation.SetCheckBox(true);
               FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:Vector.<int> = null;
         if(this.FOneWorthThousand.IsCreditGoldEnough(this.FCost))
         {
            this.FBeClicked = true;
            _loc2_ = new Vector.<int>();
            _loc2_.push(FIndex + 1);
            PerformPacket_CS_AllReq(this.FType,_loc2_);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnSaleUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = int(String(param1.currentTarget.parent.name).slice(7));
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FType = TYPE_BUY_SALE;
         this.FCost = this.FOneWorthThousand.SaleList[FIndex].CurPrice;
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(this.FBeClicked)
         {
            return;
         }
         if(Boolean(this.FOneWorthThousand) && Boolean(this.FOneWorthThousand.Gift) && this.FOneWorthThousand.Gift.Status == TBaseActivity.STATUS_CANGET)
         {
            this.FBeClicked = true;
            PerformPacket_CS_AllReq(TYPE_GET_GIFT,null);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6)) + int(String(param1.currentTarget.parent.parent.name).slice(6)) * BOX_COUNT;
         FIndex = MAX_COUNT * BOX_COUNT * this.FCurPage + _loc3_;
         if(FIndex < this.FOneWorthThousand.BoxList.length)
         {
            _loc4_ = this.FOneWorthThousand.BoxList[FIndex].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc4_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6)) + int(String(param1.currentTarget.parent.parent.name).slice(6)) * BOX_COUNT;
         FIndex = MAX_COUNT * BOX_COUNT * this.FCurPage + _loc3_;
         if(FIndex < this.FOneWorthThousand.BoxList.length)
         {
            _loc4_ = this.FOneWorthThousand.BoxList[FIndex].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc4_);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6)) + int(String(param1.currentTarget.parent.parent.name).slice(6)) * BOX_COUNT;
         FIndex = MAX_COUNT * BOX_COUNT * this.FCurPage + _loc3_;
         if(FIndex < this.FOneWorthThousand.BoxList.length)
         {
            if(this.FOneWorthThousand.BoxList[FIndex].PicType == 0)
            {
               ProcessorOnShowTip(this.FOneWorthThousand.BoxList[FIndex].DescListNew[3]);
            }
            else
            {
               _loc4_ = this.FOneWorthThousand.BoxList[FIndex].Inventories.GetInventoryByIndex(0);
               UIComponentsHintOnOver(this,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
         UIComponentsHintOnOut(this,null);
      }
      
      protected function ProcessorOnSaleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FOneWorthThousand.SaleList.length)
         {
            _loc3_ = this.FOneWorthThousand.SaleList[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnSaleOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FOneWorthThousand.SaleList.length)
         {
            _loc3_ = this.FOneWorthThousand.SaleList[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc3_);
         }
      }
      
      protected function ProcessorOnSaleTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(_loc2_ < this.FOneWorthThousand.SaleList.length)
         {
            _loc4_ = this.FOneWorthThousand.SaleList[_loc2_];
            _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,_loc4_.CurPrice) + "     ";
            ProcessorOnShowHtmlText(_loc3_);
         }
      }
      
      protected function ProcessorOnSaleTipOut(param1:MouseEvent) : void
      {
         ProcessorOnHideHtmlText();
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         if(Boolean(this.FOneWorthThousand.Gift) && Boolean(this.FOneWorthThousand.Gift.Inventories) && this.FOneWorthThousand.Gift.Inventories.Count > 0)
         {
            _loc3_ = this.FOneWorthThousand.Gift.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         if(Boolean(this.FOneWorthThousand.Gift) && Boolean(this.FOneWorthThousand.Gift.Inventories) && this.FOneWorthThousand.Gift.Inventories.Count > 0)
         {
            _loc3_ = this.FOneWorthThousand.Gift.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc3_);
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
         this.FUnstreamizerOneWorthThousand.Unstreamize(_loc2_,this.FOneWorthThousand,null);
         ProcessorCheckEffect(FActivityID,this.FOneWorthThousand.CheckStatus());
         if(FIsResourcesLoadCompleted && this.visible)
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
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
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
            case TYPE_BUY_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FOneWorthThousand.BoxList[_loc5_].BuyCount = Math.max(0,this.FOneWorthThousand.BoxList[_loc5_].BuyCount - 1);
               --this.FOneWorthThousand.BoxList[_loc5_].LimitCount;
               this.FOneWorthThousand.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FOneWorthThousand.BoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FOneWorthThousand.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_BUY_SALE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FOneWorthThousand.SaleList[_loc5_].BuyCount = Math.max(0,this.FOneWorthThousand.SaleList[_loc5_].BuyCount - 1);
               this.FOneWorthThousand.SaleList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FOneWorthThousand.SaleList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FOneWorthThousand.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_GET_GIFT:
               this.FOneWorthThousand.Gift.Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FOneWorthThousand.Gift.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FOneWorthThousand.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_REFRESH_ALL:
            case TYPE_REFRESH_ONE:
               this.FOneWorthThousand.NextTime = _loc2_.readUnsignedInt();
               this.FUnstreamizerOneWorthThousand.UnstreamizeItems(_loc2_,this.FOneWorthThousand,null);
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
               ProcessorCheckEffect(FActivityID,this.FOneWorthThousand.CheckStatus());
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FOneWorthThousand)
         {
            this.FOneWorthThousand.TotalMoney = _loc2_.readUnsignedInt();
            _loc3_ = SALE_COUNT;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc4_ < this.FOneWorthThousand.SaleList.length && this.FOneWorthThousand.SaleList[_loc4_].Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  this.FOneWorthThousand.SaleList[_loc4_].Status = TBaseActivity.STATUS_CANGET;
               }
               _loc4_++;
            }
            if(Boolean(this.FOneWorthThousand.Gift) && this.FOneWorthThousand.Gift.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.FOneWorthThousand.Gift.Status = TBaseActivity.STATUS_CANGET;
            }
            if(Boolean(this.FOneWorthThousand.Gift) && this.FOneWorthThousand.SaleList.length > 0)
            {
               this.FOneWorthThousand.CheckStatus();
            }
            if(FIsResourcesLoadCompleted && this.visible)
            {
               this.UpdateUI();
            }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([0,0,0,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         _loc3_.writeUnsignedInt(5000);
         _loc3_.writeShort(15);
         _loc1_ = 0;
         while(_loc1_ < 15)
         {
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeShort(4);
            TUtilityString.FlushUTF(_loc3_,"价值");
            TUtilityString.FlushUTF(_loc3_,"9折");
            TUtilityString.FlushUTF(_loc3_,"累计%0");
            TUtilityString.FlushUTF(_loc3_,"活动4");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(14100001);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc3_.writeShort(1);
            TUtilityString.FlushUTF(_loc3_,"9折");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

