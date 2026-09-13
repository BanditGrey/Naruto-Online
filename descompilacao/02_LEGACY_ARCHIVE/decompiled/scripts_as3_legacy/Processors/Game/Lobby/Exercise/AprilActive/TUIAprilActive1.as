package Processors.Game.Lobby.Exercise.AprilActive
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.AprilActive.TAprilActive1;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIAprilActive1 extends TUIBaseWindow
   {
      
      protected static const SWEET_COUNT:int = 5;
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const DAILY_GIFT_COUNT:int = 2;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      public static const MOVIE_OF_AUTO:int = 0;
      
      public static const MOVIE_OF_AUTO_RAIN:int = 2;
      
      public static const MOVIE_OF_PLAY_GAME:int = 3;
      
      protected var FAprilActive1:TAprilActive1;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FOpenIndex:int;
      
      protected var FIsPlayAuto:Boolean;
      
      protected var FIsBoxShow:Boolean;
      
      public function TUIAprilActive1(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FUIPage = new TUIPage(this);
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
         while(_loc2_ < SWEET_COUNT)
         {
            this.FSweetList[_loc2_] = FMC_Scene["MC_Sweet" + _loc2_];
            this.FSweetList[_loc2_].buttonMode = true;
            this.FSweetList[_loc2_].MC_In.MC_Icon.gotoAndStop(_loc2_ + 1);
            this.FSweetList[_loc2_].MC_Out.gotoAndStop(_loc2_ + 1);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene.MC_BoxDesc["MC_Box" + _loc2_];
            this.FBoxList[_loc2_].buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < DAILY_GIFT_COUNT)
         {
            _loc5_ = FMC_Scene["MC_DailyGift" + _loc2_];
            TGameUtil.setButtonMode(_loc5_.BTN_Get,true);
            _loc5_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyGiftUp);
            _loc5_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyGiftOver);
            _loc5_.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Light0.mouseEnabled = false;
         FMC_Scene.MC_Light1.mouseEnabled = false;
         FMC_Scene.MC_Light2.mouseEnabled = false;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         FMC_Scene.MC_BoxDesc.MC_Gift.buttonMode = true;
         FMC_Scene.MC_BoxDesc.MC_Gift.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_BoxDesc.MC_Gift.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_BoxDesc.MC_Gift.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         FMC_Scene.MC_BoxDesc.visible = false;
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -79;
         this.FProcessorFebActiveShop.y = -15;
         FMC_Scene.MC_TreeTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTreeOver);
         FMC_Scene.MC_TreeTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_ScoreA.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_ScoreA.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_ScoreB.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_ScoreB.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_TitleDesc,true);
         FMC_Scene.BTN_TitleDesc.addEventListener(MouseEvent.CLICK,ProcessorOnShowTitleDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_EquipDesc,true);
         FMC_Scene.BTN_EquipDesc.addEventListener(MouseEvent.CLICK,ProcessorOnShowEquipDesc);
         FMC_Scene.BTN_Box.buttonMode = true;
         FMC_Scene.BTN_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowBoxDesc);
         FMC_Scene.MC_BoxDesc.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideBoxDesc);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_BoxDesc.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_BoxDesc.BTN_Right;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_BoxDesc.MC_Gift;
         _loc3_ = this.FAprilActive1.Gift;
         _loc2_.TF_Count.text = "*" + _loc3_.Count.toString();
         _loc2_.TF_Price.text = TUtilityString.Format(this.FAprilActive1.DescListNew[2],this.FAprilActive1.ConsumeScore % _loc3_.Price);
         if(_loc3_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_BoxPic.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_BoxPic.gotoAndStop(1);
         }
      }
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FAprilActive1.ShowItems);
      }
      
      protected function UpdateSweet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc3_ = this.FSweetList[_loc1_];
            if(_loc1_ < this.FAprilActive1.WaterList.length)
            {
               _loc3_.visible = true;
               if(this.FAprilActive1.WaterList[_loc1_] == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.filters = [];
                  _loc3_.MC_In.gotoAndPlay(1);
               }
               else
               {
                  _loc3_.filters = [TGameUtil.GaryColorFilters];
                  _loc3_.MC_In.gotoAndStop(1);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FMC_Scene.TF_Level.text = TUtilityString.Format(this.FAprilActive1.DescListNew[8],this.FAprilActive1.TreeLevel);
         if(this.FAprilActive1.TreeLevel < 3)
         {
            FMC_Scene.MC_Tree.gotoAndStop(1);
         }
         else if(this.FAprilActive1.TreeLevel < 4)
         {
            FMC_Scene.MC_Tree.gotoAndStop(2);
         }
         else if(this.FAprilActive1.TreeLevel < 5)
         {
            FMC_Scene.MC_Tree.gotoAndStop(3);
         }
         else
         {
            FMC_Scene.MC_Tree.gotoAndStop(4);
         }
         FMC_Scene.MC_Bar.TF_Count.text = this.FAprilActive1.CurTree + "/" + this.FAprilActive1.MaxTree;
         _loc3_ = Number(this.FAprilActive1.CurTree / this.FAprilActive1.MaxTree) * this.FBarMaxWidth;
         _loc4_ = Math.min(_loc3_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc4_;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:int = 0;
         this.FUIPage.TotalQuantity = this.FAprilActive1.BoxList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = this.FBoxList[_loc1_];
            _loc2_ = _loc1_ + this.FCurPage * BOX_COUNT;
            if(_loc2_ < this.FAprilActive1.BoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_BoxPic.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FAprilActive1.BoxList[_loc2_];
               _loc4_.TF_Name.text = TUtilityString.Format(this.FAprilActive1.DescListNew[7],_loc2_ + 2,_loc2_ + 2);
               if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.MC_Got.visible = true;
                  _loc4_.MC_Click.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_Click.visible = true;
               }
               else
               {
                  _loc4_.MC_Got.visible = false;
                  _loc4_.MC_Click.visible = false;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateDailyGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < DAILY_GIFT_COUNT)
         {
            _loc3_ = FMC_Scene["MC_DailyGift" + _loc1_];
            _loc2_ = this.FAprilActive1.DailyGift[_loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(this.FAprilActive1.DescListNew[9 + _loc1_],_loc2_.BuyCount % _loc2_.Price);
            _loc3_.TF_Count.text = "*" + _loc2_.Count;
            if(_loc2_.Count > 0)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
            }
            _loc1_++;
         }
         FMC_Scene.TF_Tips.text = TUtilityString.Format(this.FAprilActive1.DescListNew[12],this.FAprilActive1.ConsumeCount);
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FAprilActive1.IsBtnShine)
         {
            FMC_Scene.BTN_Box.gotoAndPlay(1);
         }
         else
         {
            FMC_Scene.BTN_Box.gotoAndStop(1);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FAprilActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FAprilActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FAprilActive1.DescListNew[1];
         FMC_Scene.MC_ScoreA.TF_Count.text = this.FAprilActive1.ScoreA.toString();
         FMC_Scene.MC_ScoreB.TF_Count.text = this.FAprilActive1.RankPoint.toString();
         FMC_Scene.TF_CurLevel.text = TUtilityString.Format(this.FAprilActive1.DescListNew[11],this.FAprilActive1.TreeLevel,this.FAprilActive1.CurLevelMin,this.FAprilActive1.CurLevelMax);
         if(this.FAprilActive1.NextLevel == 0)
         {
            FMC_Scene.TF_NextLevel.text = "";
            FMC_Scene.MC_End.visible = true;
         }
         else
         {
            FMC_Scene.MC_End.visible = false;
            FMC_Scene.TF_NextLevel.text = TUtilityString.Format(this.FAprilActive1.DescListNew[11],this.FAprilActive1.NextLevel,this.FAprilActive1.NextLevelMin,this.FAprilActive1.NextLevelMax);
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_GET_TASK,_loc3_.Identify);
         }
      }
      
      override protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && !FIsPlaying) && Boolean(this.FAprilActive1) && this.FAprilActive1.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_GET_GIFT);
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FAprilActive1))
         {
            _loc3_ = _loc2_ + this.FCurPage * BOX_COUNT;
            if(this.FAprilActive1.BoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_GET_BOX,_loc3_ + 1);
            }
         }
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnBuyBox != null && !FIsPlaying) && Boolean(this.FAprilActive1) && this.FAprilActive1.WaterList[_loc2_] == TBaseActivity.STATUS_CANGET)
         {
            this.FOpenIndex = _loc2_;
            if(this.FAprilActive1.ScoreA > this.FAprilActive1.Price)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_PLAY_GAME,_loc2_ + 1);
            }
            else
            {
               _loc3_ = (this.FAprilActive1.Price - this.FAprilActive1.ScoreA) * this.FAprilActive1.ScorePrice;
               _loc4_ = TUtilityString.Format(this.FAprilActive1.DescListNew[3],this.FAprilActive1.Price,_loc3_,this.FAprilActive1.Price - this.FAprilActive1.ScoreA);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_PLAY_GAME,_loc3_,_loc2_ + 1,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(FOnBuyBox != null && !FIsPlaying && Boolean(this.FAprilActive1))
         {
            _loc4_ = this.FAprilActive1.AutoPrice;
            if(this.FAprilActive1.ScoreA >= _loc4_)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_AUTO_GAME);
            }
            else
            {
               _loc2_ = (_loc4_ - this.FAprilActive1.ScoreA) * this.FAprilActive1.ScorePrice;
               _loc3_ = TUtilityString.Format(this.FAprilActive1.DescListNew[3],_loc4_,_loc2_,_loc4_ - this.FAprilActive1.ScoreA);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_AUTO_GAME,_loc2_,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnDailyGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(12));
         if(Boolean(FOnGetBox != null) && Boolean(this.FAprilActive1) && this.FAprilActive1.DailyGift[_loc2_].Count > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_DAILY_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FAprilActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorAprilActive.ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FAprilActive1) && _loc2_ < this.FAprilActive1.WaterList.length)
         {
            _loc4_ = this.FAprilActive1.CurLevelMin * this.FAprilActive1.RateList[_loc2_] / 10;
            _loc5_ = this.FAprilActive1.CurLevelMax * this.FAprilActive1.RateList[_loc2_] / 10;
            _loc3_ = TUtilityString.Format(this.FAprilActive1.DescListNew[13 + _loc2_],_loc4_,_loc5_);
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = _loc2_ + this.FCurPage * BOX_COUNT;
         if(FOnNewBoxOver != null && Boolean(this.FAprilActive1))
         {
            FOnNewBoxOver(this.FAprilActive1.BoxList[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FAprilActive1))
         {
            FOnNewBoxOver(this.FAprilActive1.Gift.Inventories);
         }
      }
      
      protected function ProcessorOnDailyGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(12));
         if(FOnNewBoxOver != null && Boolean(this.FAprilActive1))
         {
            FOnNewBoxOver(this.FAprilActive1.DailyGift[_loc2_].Inventories);
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
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FAprilActive1) && this.FAprilActive1.DescList.length > 20)
         {
            FOnShowHtmlTip(this.FAprilActive1.DescListNew[20]);
         }
      }
      
      protected function ProcessorOnTreeOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FAprilActive1))
         {
            FOnShowHtmlTip(this.FAprilActive1.DescListNew[21]);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FAprilActive1))
         {
            FOnShowHtmlTip(this.FAprilActive1.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FAprilActive1))
         {
            FOnShowHtmlTip(this.FAprilActive1.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnTip2Over(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FAprilActive1))
         {
            FOnShowHtmlTip(this.FAprilActive1.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FAprilActive1);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnShowBoxDesc(param1:MouseEvent) : void
      {
         this.FIsBoxShow = !this.FIsBoxShow;
         FMC_Scene.MC_BoxDesc.visible = this.FIsBoxShow;
      }
      
      protected function ProcessorOnHideBoxDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_BoxDesc.visible = false;
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = FMC_Scene.MC_Movie0["MC_Movie" + this.FOpenIndex].currentFrame;
                     break;
                  case MOVIE_OF_AUTO:
                     return;
                  case MOVIE_OF_AUTO_RAIN:
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
         this.FAprilActive1 = SLogicsCore.AprilActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TAprilActive1;
         UpdateTaskView();
         this.UpdateGift();
         this.UpdateSweet();
         this.UpdateTree();
         this.UpdateItem();
         this.UpdateBox();
         this.UpdateDailyGift();
         this.UpdateBtn();
         this.UpdateText();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FAprilActive1);
         }
      }
      
      public function PlayAutoMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         _loc4_ = "";
         if(this.FAprilActive1.IndexList.length > 0)
         {
            _loc1_ = this.FAprilActive1.IndexList[0] - 1;
            this.FAprilActive1.WaterList[_loc1_] = this.FAprilActive1.StatusList[0];
            _loc2_ = _loc1_ <= 0 ? 4 : int(_loc1_ - 1);
            if(_loc2_ != 0)
            {
               this.FAprilActive1.WaterList[_loc2_] = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FAprilActive1.AmountList[0] > 0)
            {
               _loc4_ = TUtilityString.Format(this.FAprilActive1.DescListNew[6],this.FAprilActive1.AmountList[0],this.FAprilActive1.Param1List[0],this.FAprilActive1.Param2List[0] / 10);
            }
            if(this.FAprilActive1.Param3List[0] > 0)
            {
               _loc4_ += "\n" + TUtilityString.Format(this.FAprilActive1.DescListNew[18],this.FAprilActive1.Param3List[0]);
            }
            this.UpdateSweet();
            this.FAprilActive1.StatusList.shift();
            this.FAprilActive1.IndexList.shift();
            this.FAprilActive1.AmountList.shift();
            this.FAprilActive1.Param1List.shift();
            this.FAprilActive1.Param2List.shift();
            this.FAprilActive1.Param3List.shift();
            if(this.FAprilActive1.StatusList.length > 0)
            {
               setTimeout(this.PlayAutoMovie,250);
               FOnShowFlowText(_loc4_);
            }
            else
            {
               if(this.FAprilActive1.IsLevelUp == 1)
               {
                  _loc4_ += "\n" + this.FAprilActive1.DescListNew[19];
               }
               FOnShowFlowText(_loc4_);
               this.AutoMovieEnd();
            }
         }
      }
      
      public function AutoMovieEnd() : void
      {
         this.UpdateUI();
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
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            _loc5_ = FMC_Scene.MC_Movie0;
            _loc5_.visible = true;
            _loc5_.gotoAndStop(this.FOpenIndex + 1);
            FTotalFrame = _loc5_["MC_Movie" + this.FOpenIndex].totalFrames;
            _loc5_["MC_Movie" + this.FOpenIndex].gotoAndPlay(1);
            this.UpdateSweet();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_RAIN)
         {
            _loc5_ = FMC_Scene.MC_Movie1;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            this.PlayAutoMovie();
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_PLAY_GAME)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTO_RAIN)
         {
            FMC_Scene.MC_Movie1.visible = false;
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         if(this.FShowItem)
         {
            this.FShowItem.ResetSlot();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

