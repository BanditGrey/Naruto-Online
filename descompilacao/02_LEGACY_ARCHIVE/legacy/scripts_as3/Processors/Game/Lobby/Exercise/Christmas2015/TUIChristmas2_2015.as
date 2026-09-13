package Processors.Game.Lobby.Exercise.Christmas2015
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2015.TChristmas2_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIChristmas2_2015 extends TUIBaseWindow
   {
      
      protected static const SALE_COUNT:int = 12;
      
      protected static const GIFT_COUNT:int = 2;
      
      protected static const TITLE_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_TYPE_WATER_COIN:int = 1;
      
      public static const MOVIE_TYPE_WATER_GOLD:int = 2;
      
      protected var FChristmas2_2015:TChristmas2_2015;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FSaleItems:Vector.<TUIShowItem>;
      
      protected var FUIPage0:TUIPage;
      
      protected var FTotalPage0:int;
      
      protected var FCurPage0:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FTF_CDTime:TextField;
      
      protected var FIsCD:Boolean;
      
      public function TUIChristmas2_2015(param1:TUIComponent)
      {
         super(param1);
         this.FSaleItems = new Vector.<TUIShowItem>(SALE_COUNT);
         this.FUIPage0 = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SALE_COUNT)
         {
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Sale["MC_Box" + _loc2_]);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            this.FSaleItems[_loc2_] = _loc4_;
            FMC_Scene.MC_Sale["MC_Box" + _loc2_].MC_Lock.mouseChildren = false;
            FMC_Scene.MC_Sale["MC_Box" + _loc2_].MC_Lock.mouseEnabled = false;
            TGameUtil.setButtonMode(FMC_Scene.MC_Sale["MC_Box" + _loc2_].BTN_Buy,true);
            FMC_Scene.MC_Sale["MC_Box" + _loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Item" + _loc2_].gotoAndStop(_loc2_ + 1);
            FMC_Scene["MC_Item" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            FMC_Scene["MC_Item" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene["MC_Item" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TITLE_COUNT)
         {
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnTitleUp);
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTitleOver);
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideTitleTip);
            _loc2_++;
         }
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_WaterGold,true);
         FMC_Scene.BTN_WaterGold.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterGoldUp);
         FMC_Scene.BTN_WaterGold.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnWaterGoldOver);
         FMC_Scene.BTN_WaterGold.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_WaterCoin,true);
         FMC_Scene.BTN_WaterCoin.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterCoinUp);
         FMC_Scene.BTN_WaterCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnWaterCoinOver);
         FMC_Scene.BTN_WaterCoin.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         this.FUIPage0.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage0.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage0.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage0.TotalQuantity = this.FTotalPage0;
         this.FUIPage0.PageSize = SALE_COUNT;
         this.FUIPage0.PageIndex = 0;
         this.FUIPage0.OnChangePage = this.ProcessorPageOnChange0;
         this.FCurPage0 = 0;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FTF_CDTime = FMC_Scene.BTN_WaterCoin.TF_Time;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas2_2015.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas2_2015.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas2_2015.DescListNew[1];
         FMC_Scene.TF_Level.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[2],this.FChristmas2_2015.TreeLevel);
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[3],this.FChristmas2_2015.Min);
         FMC_Scene.TF_ConsumeGold.text = this.FChristmas2_2015.TotalConsumeGold.toString();
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FChristmas2_2015.IsEnd == 1)
         {
            FMC_Scene.MC_MaxLevel.visible = true;
            FMC_Scene.TF_Desc2.text = this.FChristmas2_2015.DescListNew[7];
            TGameUtil.setButtonMode(FMC_Scene.BTN_WaterGold,false);
            TGameUtil.setButtonMode(FMC_Scene.BTN_WaterCoin,false);
         }
         else
         {
            FMC_Scene.MC_MaxLevel.visible = false;
            FMC_Scene.TF_Desc2.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[6],this.FChristmas2_2015.TreeLevel,this.FChristmas2_2015.TreeLevel + 1,this.FChristmas2_2015.GiftCount[0]);
         }
         FMC_Scene.MC_Tree.gotoAndStop(this.FChristmas2_2015.TreeLevel);
         FMC_Scene.MC_Bar.TF_Count.text = this.FChristmas2_2015.TreeExp + "/" + this.FChristmas2_2015.TreeExpMax;
         _loc1_ = Number(this.FChristmas2_2015.TreeExp / this.FChristmas2_2015.TreeExpMax) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc2_;
         FMC_Scene.BTN_WaterGold.TF_Time.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[10],this.FChristmas2_2015.WaterList[1].Time);
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Item" + _loc1_];
            _loc2_.TF_Count.text = "*" + this.FChristmas2_2015.GiftList[_loc1_];
            if(this.FChristmas2_2015.GiftList[_loc1_] > 0)
            {
               _loc2_.MC_Click.visible = true;
            }
            else
            {
               _loc2_.MC_Click.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TITLE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Title" + _loc1_];
            _loc3_ = this.FChristmas2_2015.TitleList[_loc1_];
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[5],_loc3_.Level);
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Click.visible = true;
               _loc2_.MC_Got.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = false;
            }
            else
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSale() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         this.FUIPage0.TotalQuantity = this.FChristmas2_2015.ShopExchangeItems.length;
         this.FUIPage0.Update();
         _loc1_ = 0;
         while(_loc1_ < SALE_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage0 * SALE_COUNT;
            _loc6_ = FMC_Scene.MC_Sale["MC_Box" + _loc1_];
            if(_loc3_ < this.FChristmas2_2015.ShopExchangeItems.length)
            {
               _loc6_.visible = true;
               _loc5_ = this.FChristmas2_2015.ShopExchangeItems[_loc3_];
               this.FSaleItems[_loc1_].UpdateUI(_loc5_.Inventories);
               _loc6_.MC_Slot0.TF_ItemPrice.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[12],_loc5_.Price);
               if(this.FChristmas2_2015.TreeLevel >= _loc5_.Level)
               {
                  _loc6_.MC_Lock.visible = false;
                  if(_loc5_.LimitCount <= 0)
                  {
                     TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc6_.BTN_Buy,true);
                  }
               }
               else
               {
                  _loc6_.MC_Lock.visible = true;
                  _loc6_.MC_Lock.TF_Desc.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[4],_loc5_.Level);
                  TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
               }
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdateSale();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(!FIsPlaying && FOnGetBox != null) && Boolean(this.FChristmas2_2015) && this.FChristmas2_2015.GiftList[_loc2_] > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_GET_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage0 * SALE_COUNT;
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FChristmas2_2015))
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_BUY_ITEM,this.FChristmas2_2015.ShopExchangeItems[_loc3_].Price,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnWaterGoldUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnBuyBox != null)
         {
            if(this.FChristmas2_2015.WaterList[1].Time > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_WATER_GOLD);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_WATER_GOLD,this.FChristmas2_2015.WaterList[1].Price);
            }
         }
      }
      
      protected function ProcessorOnWaterCoinUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && !this.FIsCD)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_WATER_COIN);
         }
      }
      
      protected function ProcessorOnTitleUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(!FIsPlaying && FOnGetBox != null && this.FChristmas2_2015.TitleList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2015.ACTIVITY_2_GET_TITLE,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnTitleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowTitleTip != null && Boolean(this.FChristmas2_2015))
         {
            FOnShowTitleTip(this.FChristmas2_2015.TitleList[_loc2_].Identify);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FChristmas2_2015)
         {
            FOnShowHtmlTip(this.FChristmas2_2015.DescListNew[8 + _loc2_]);
         }
      }
      
      protected function ProcessorOnWaterGoldOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FChristmas2_2015)
         {
            FOnShowHtmlTip(this.FChristmas2_2015.DescListNew[13]);
         }
      }
      
      protected function ProcessorOnWaterCoinOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FChristmas2_2015)
         {
            FOnShowHtmlTip(this.FChristmas2_2015.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FSaleItems.length)
            {
               if(this.FSaleItems[_loc1_])
               {
                  this.FSaleItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            _loc2_ = this.FChristmas2_2015.NextTime - STimingCore.GetServerTick();
            this.FTF_CDTime.text = TUtilityString.Format(this.FChristmas2_2015.DescListNew[11],TGameUtil.FomatDayAndTime(_loc2_));
            if(_loc2_ <= 0 && this.FIsCD || _loc2_ > 0 && !this.FIsCD)
            {
               this.FIsCD = _loc2_ <= 0 ? false : true;
               if(!this.FIsCD && CheckEffect != null)
               {
                  CheckEffect(CONST_SHORTCUTS.TYPE_NewActiveList_Christmas2015,true);
               }
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_TYPE_WATER_COIN:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_TYPE_WATER_GOLD:
                     CurFrame = FMC_Scene.MC_Movie1.currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FChristmas2_2015 = SLogicsCore.ChristmasDatas_2015.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2015;
         this.UpdateText();
         this.UpdateTree();
         this.UpdateGift();
         this.UpdateSale();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         if(this.FMovieType == MOVIE_TYPE_WATER_COIN)
         {
            _loc5_ = FMC_Scene.MC_Movie0;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            FMC_Scene.BTN_WaterCoin.visible = false;
         }
         else if(this.FMovieType == MOVIE_TYPE_WATER_GOLD)
         {
            _loc5_ = FMC_Scene.MC_Movie1;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            FMC_Scene.BTN_WaterGold.visible = false;
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_TYPE_WATER_COIN)
         {
            FMC_Scene.MC_Movie0.visible = false;
            FMC_Scene.BTN_WaterCoin.visible = true;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TYPE_WATER_GOLD)
         {
            FMC_Scene.MC_Movie1.visible = false;
            FMC_Scene.BTN_WaterGold.visible = true;
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
   }
}

